Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33EBC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfDeM-0005P0-CR; Thu, 02 Jul 2026 05:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wfDeJ-0005OD-Gh
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wfDeH-0005uO-SG
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782984237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3V3CXvvH2NXUkWs8mV7EVNFrfm22A/C0O13gkRy4+7w=;
 b=WVlO6sqci7dU1CpY48uugt5BKDlYRuJtzFP9f+gbuECtP4/kfUiQueMTfRhkvDlrUt5ugb
 huJkrcrSOgz2UDP2Qzz6GZWxN91ueUW+8zn9491rlWpltKl9ipbGMzX9sMoQwD3+kPl+6q
 DqHaexONVWjUVE2SfbN+hBSsOF28x4M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-c4d_ORKlPBe34E2xW-PvAw-1; Thu,
 02 Jul 2026 05:23:53 -0400
X-MC-Unique: c4d_ORKlPBe34E2xW-PvAw-1
X-Mimecast-MFC-AGG-ID: c4d_ORKlPBe34E2xW-PvAw_1782984233
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD0C7195395C; Thu,  2 Jul 2026 09:23:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.8])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5EAFD36F05; Thu,  2 Jul 2026 09:23:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B25F71800DE4; Thu, 02 Jul 2026 11:23:49 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	peter.maydell@linaro.org
Subject: [PATCH v2 2/2] hw/uefi: disable debug function
Date: Thu,  2 Jul 2026 11:23:47 +0200
Message-ID: <20260702092349.4183512-3-kraxel@redhat.com>
In-Reply-To: <20260702092349.4183512-1-kraxel@redhat.com>
References: <20260702092349.4183512-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

This was never meant to be active in production builds.  It's a code
path not hit on a normal boot (OVMF wouldn't try variable updates which
are not allowed), so this went unnoticed.

Wrap the call into "if (VARIABLE_POLICY_DEBUG)" so it is never used
unless the #define is changed to true.

Also fix the name printing to not overrun the entry size.

Fixes: CVE-2026-58582
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3615
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-policy.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/uefi/var-service-policy.c b/hw/uefi/var-service-policy.c
index 989bf87ddb86..b56fc62f7092 100644
--- a/hw/uefi/var-service-policy.c
+++ b/hw/uefi/var-service-policy.c
@@ -16,6 +16,8 @@
 
 #include "trace.h"
 
+#define VARIABLE_POLICY_DEBUG 0
+
 static void calc_policy(uefi_var_policy *pol);
 
 static int uefi_var_policy_post_load(void *opaque, int version_id)
@@ -40,11 +42,12 @@ const VMStateDescription vmstate_uefi_var_policy = {
 static void print_policy_entry(variable_policy_entry *pe)
 {
     uint16_t *name = (void *)pe + pe->offset_to_name;
+    uint16_t *end = (void *)pe + pe->size;
 
     fprintf(stderr, "%s:\n", __func__);
 
     fprintf(stderr, "    name ´");
-    while (*name) {
+    while (*name && name < end) {
         fprintf(stderr, "%c", *name);
         name++;
     }
@@ -173,7 +176,9 @@ efi_status uefi_vars_policy_check(uefi_vars_state *uv,
     pe = pol->entry;
 
     uefi_trace_variable(__func__, var->guid, var->name, var->name_size);
-    print_policy_entry(pe);
+    if (VARIABLE_POLICY_DEBUG) {
+        print_policy_entry(pe);
+    }
 
     if ((var->attributes & pe->attributes_must_have) != pe->attributes_must_have) {
         trace_uefi_vars_policy_deny("must-have-attr");
-- 
2.55.0


