Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39C5C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlp7p-0003fV-Ng; Mon, 20 Jul 2026 10:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wlp3H-0001sW-FA
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wlp3F-0002dh-Rc
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784557980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sTmzTu2GwNp8kx7ZebrgoU+qGZvdlx+WqTNJKCvwnSY=;
 b=I7jgxbjs803tW/eI99eLswr7IwCv0Ux2pGZUmDg4e2A3vv68+Zd3qwjrAvVlnZ773FWPDh
 8FPh82ZH2lu6I4SE1A1M/2XTQi2d01LZvBiTIW2pf5APZHKladn1mf3kMhiDblrLFaRLfs
 AgUYb/DZafWRvi13XaAjDjxPVt5tXpw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-RKRn7v48Ozaxl3JQbL13tg-1; Mon,
 20 Jul 2026 10:32:58 -0400
X-MC-Unique: RKRn7v48Ozaxl3JQbL13tg-1
X-Mimecast-MFC-AGG-ID: RKRn7v48Ozaxl3JQbL13tg_1784557978
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A76F1808997; Mon, 20 Jul 2026 14:32:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F29B818001E7; Mon, 20 Jul 2026 14:32:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A1FE218009D6; Mon, 20 Jul 2026 16:32:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mcascell@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 4/6] hw/uefi: account variable policy entries against
 storage size
Date: Mon, 20 Jul 2026 16:32:40 +0200
Message-ID: <20260720143244.821889-5-kraxel@redhat.com>
In-Reply-To: <20260720143244.821889-1-kraxel@redhat.com>
References: <20260720143244.821889-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=kraxel@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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


