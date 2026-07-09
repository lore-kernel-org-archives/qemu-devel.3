Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07BCC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmDB-0004W8-W4; Thu, 09 Jul 2026 06:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1whmDA-0004VK-RC
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1whmD9-0001Y0-5P
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783593750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UGWHelquemiDD5NLCvYR1AkBolWYwsAixwbTYXmasbU=;
 b=IYSp2WsdkAMl6bxzTa6cPgGWHBunsvqzZOBhq9NjrrRXuoA4hcS87ztaiynUn9iHCHIpqJ
 Cb0Heg6WZ2FrI3Z6IoTVpFYWOCLUDHY4fiki6jBi61wnRPlpd8yN7SFdpjkhPsT9mrni3M
 PoYIt4g+2w8oEMvNNS15rTRxMRSdz0Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-R0OpMHJQMgm6kcaZ1oingQ-1; Thu,
 09 Jul 2026 06:42:27 -0400
X-MC-Unique: R0OpMHJQMgm6kcaZ1oingQ-1
X-Mimecast-MFC-AGG-ID: R0OpMHJQMgm6kcaZ1oingQ_1783593746
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7495819560BB; Thu,  9 Jul 2026 10:42:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.140])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 028181955D71; Thu,  9 Jul 2026 10:42:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 426371801013; Thu, 09 Jul 2026 12:42:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: mcascell@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 peter.maydell@linaro.org
Subject: [PATCH v3 2/5] hw/uefi: remove debug function
Date: Thu,  9 Jul 2026 12:42:17 +0200
Message-ID: <20260709104223.143594-3-kraxel@redhat.com>
In-Reply-To: <20260709104223.143594-1-kraxel@redhat.com>
References: <20260709104223.143594-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This was never meant to be present in production builds.  It's a code
path not hit on a normal boot (OVMF wouldn't try variable updates which
are not allowed), so this went unnoticed.

Remove the function.  If needed for debugging the git log is your
friend.

Fixes: CVE-2026-58582
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3615
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-policy.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/hw/uefi/var-service-policy.c b/hw/uefi/var-service-policy.c
index 989bf87ddb86..0880bfe074a6 100644
--- a/hw/uefi/var-service-policy.c
+++ b/hw/uefi/var-service-policy.c
@@ -37,37 +37,6 @@ const VMStateDescription vmstate_uefi_var_policy = {
     },
 };
 
-static void print_policy_entry(variable_policy_entry *pe)
-{
-    uint16_t *name = (void *)pe + pe->offset_to_name;
-
-    fprintf(stderr, "%s:\n", __func__);
-
-    fprintf(stderr, "    name ´");
-    while (*name) {
-        fprintf(stderr, "%c", *name);
-        name++;
-    }
-    fprintf(stderr, "', version=%d.%d, size=%d\n",
-            pe->version >> 16, pe->version & 0xffff, pe->size);
-
-    if (pe->min_size) {
-        fprintf(stderr, "    size min=%d\n", pe->min_size);
-    }
-    if (pe->max_size != UINT32_MAX) {
-        fprintf(stderr, "    size max=%u\n", pe->max_size);
-    }
-    if (pe->attributes_must_have) {
-        fprintf(stderr, "    attr must=0x%x\n", pe->attributes_must_have);
-    }
-    if (pe->attributes_cant_have) {
-        fprintf(stderr, "    attr cant=0x%x\n", pe->attributes_cant_have);
-    }
-    if (pe->lock_policy_type) {
-        fprintf(stderr, "    lock policy type %d\n", pe->lock_policy_type);
-    }
-}
-
 static gboolean wildcard_str_equal(uefi_var_policy *pol,
                                    uefi_variable *var)
 {
@@ -173,7 +142,6 @@ efi_status uefi_vars_policy_check(uefi_vars_state *uv,
     pe = pol->entry;
 
     uefi_trace_variable(__func__, var->guid, var->name, var->name_size);
-    print_policy_entry(pe);
 
     if ((var->attributes & pe->attributes_must_have) != pe->attributes_must_have) {
         trace_uefi_vars_policy_deny("must-have-attr");
-- 
2.55.0


