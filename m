Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2595C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmXSZ-0007gG-1y; Wed, 22 Jul 2026 09:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wmXSV-0007f0-L8
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wmXSU-0006t6-4X
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784728681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GjAKuZGD/e3TUI8K9fZukuAlvtrrLMVlz77kvZ/XcBE=;
 b=GPl1opKXd1LHSLTIvk8pamOcCvdFdDJDGkrBTRLt3ui+uyIk6mlMd/sDGmxEe0LvDhyQ6k
 UMmng7GPxdArEjpRvZeCFs5eQo2Q01PHdLJ5fzX2BuQIgqieDnFMXG8dFXHaUeqhZ7fzKS
 4PRAYYNd8ntRlnBoiZ3KEAamoQcFpeI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-eAfiO2UcN5Sj6ebwlcc3AQ-1; Wed,
 22 Jul 2026 09:57:57 -0400
X-MC-Unique: eAfiO2UcN5Sj6ebwlcc3AQ-1
X-Mimecast-MFC-AGG-ID: eAfiO2UcN5Sj6ebwlcc3AQ_1784728676
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84E4A1954111
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 13:57:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.49.247])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 417983004082; Wed, 22 Jul 2026 13:57:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9A2071826B12; Wed, 22 Jul 2026 15:57:52 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 4/6] hw/uefi: account variable policy entries against storage
 size
Date: Wed, 22 Jul 2026 15:57:48 +0200
Message-ID: <20260722135752.1264244-5-kraxel@redhat.com>
In-Reply-To: <20260722135752.1264244-1-kraxel@redhat.com>
References: <20260722135752.1264244-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=kraxel@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Acked-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260720143244.821889-5-kraxel@redhat.com>
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


