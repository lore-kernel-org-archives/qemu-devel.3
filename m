Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA36EC44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmDC-0004W9-75; Thu, 09 Jul 2026 06:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1whmDA-0004VI-N4
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1whmD8-0001Xt-Lk
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783593749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sTmzTu2GwNp8kx7ZebrgoU+qGZvdlx+WqTNJKCvwnSY=;
 b=CwxgUAEJaMdotSvhlEe2ZxQMp6V2bGlTEonFrScOnlgHxunev97MsyyGd/69dAHt8tYTXC
 81Nygtqqb7GaWgIAcubrw0dxc7FcNBQ4OEj0xS1isVCKsoCz/S5EsPpvybHO1pOaqUkzh0
 Z/OPwA8uux51hDdVeeg9eJGMNI3YzX8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-Oq-2Le-PMLeC5-WiS2HwvA-1; Thu,
 09 Jul 2026 06:42:28 -0400
X-MC-Unique: Oq-2Le-PMLeC5-WiS2HwvA-1
X-Mimecast-MFC-AGG-ID: Oq-2Le-PMLeC5-WiS2HwvA_1783593747
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F8BD195607D; Thu,  9 Jul 2026 10:42:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.140])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16FD2195419E; Thu,  9 Jul 2026 10:42:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 622ED180101D; Thu, 09 Jul 2026 12:42:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: mcascell@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 peter.maydell@linaro.org
Subject: [PATCH v3 4/5] hw/uefi: account variable policy entries against
 storage size
Date: Thu,  9 Jul 2026 12:42:19 +0200
Message-ID: <20260709104223.143594-5-kraxel@redhat.com>
In-Reply-To: <20260709104223.143594-1-kraxel@redhat.com>
References: <20260709104223.143594-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

uefi-vars already tracks (and limits) the memory footprint of UEFI
variables.  Do that for variable policies too.

Fixes: CVE-2026-61405
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3890
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-policy.c | 5 +++++
 hw/uefi/var-service-vars.c   | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/hw/uefi/var-service-policy.c b/hw/uefi/var-service-policy.c
index 0880bfe074a6..46c4ff2dacae 100644
--- a/hw/uefi/var-service-policy.c
+++ b/hw/uefi/var-service-policy.c
@@ -283,7 +283,12 @@ static uint32_t uefi_vars_mm_check_policy_register(uefi_vars_state *uv,
         return uefi_vars_mm_policy_error(mhdr, mchk, EFI_ALREADY_STARTED);
     }
 
+    if (uv->used_storage + pe->size > uv->max_storage) {
+        return uefi_vars_mm_policy_error(mhdr, mchk, EFI_OUT_OF_RESOURCES);
+    }
+
     uefi_vars_add_policy(uv, pe);
+    uv->used_storage += pe->size;
 
     mchk->result = EFI_SUCCESS;
     return sizeof(*mchk);
diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index 2c83130ebf63..fd07782f1e0d 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -201,11 +201,15 @@ void uefi_vars_clear_all(uefi_vars_state *uv)
 void uefi_vars_update_storage(uefi_vars_state *uv)
 {
     uefi_variable *var;
+    uefi_var_policy *pol;
 
     uv->used_storage = 0;
     QTAILQ_FOREACH(var, &uv->variables, next) {
         uv->used_storage += variable_size(var);
     }
+    QTAILQ_FOREACH(pol, &uv->var_policies, next) {
+        uv->used_storage += pol->entry->size;
+    }
 }
 
 static gboolean check_access(uefi_vars_state *uv, uefi_variable *var)
-- 
2.55.0


