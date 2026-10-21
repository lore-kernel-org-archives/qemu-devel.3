Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F54B606A32D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=foZZudLG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZFc-0007ZU-H5; Wed, 21 Oct 2026 12:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFG-0007TZ-J7
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFB-0006Uq-V9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792600369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oi199wsf8nTgvRE+hN//iXiFJETYhH2ljQFRicUL4uc=;
 b=foZZudLGENB//PT6EqhTtSOgA6U3HbO47CZ4UnlAZf/cT6u/CPnyoCKlbEV4Dzv33Jbbxx
 AZKVTDl2a0L73xMlVazMINCTBXoxm+U+SAmZHwRmMhDGG9m1I/bMbNpnVQq71Q0lLCmrvf
 +wlM/jiO2fh8ToaATffx5swwFD9a4y4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-6p3gm9sYPdqHSWpBhsvuEw-1; Wed,
 21 Oct 2026 16:32:45 +0000
X-MC-Unique: 6p3gm9sYPdqHSWpBhsvuEw-1
X-Mimecast-MFC-AGG-ID: 6p3gm9sYPdqHSWpBhsvuEw_1792600364
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4646195608E; Wed, 21 Oct 2026 16:32:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B2F8362; Wed, 21 Oct 2026 16:32:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EEBD91827594; Wed, 21 Oct 2026 18:32:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 06/10] backends/igvm: supply an empty device tree when the
 machine has none
Date: Wed, 21 Oct 2026 18:32:34 +0200
Message-ID: <20261021163239.1131460-7-kraxel@redhat.com>
In-Reply-To: <20261021163239.1131460-1-kraxel@redhat.com>
References: <20261021163239.1131460-1-kraxel@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Luigi Leonardi <leonardi@redhat.com>

Commit 1c4bd8f13c ("igvm: add device tree parameter support") added
handling for the IGVM device tree parameter directive. The handler
fails when the machine has not built a device tree of its own, so an
IGVM file carrying that directive cannot be booted on such a machine,
for example q35.

An empty tree satisfies the IGVM file's request, so build and supply
one instead of rejecting the whole file.

While at it, rename fdt_packed to fdt, which better reflects the
content of the variable, as it does not always hold a packed fdt.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Message-ID: <20260923-relax_dt-v1-1-ff40f2a06acd@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index ef45794744bc..5a1416fe8eac 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -29,6 +29,9 @@
 
 #ifdef CONFIG_FDT
 #include <libfdt.h>
+
+/* Enough for the header, the memory reservation block and an empty root node */
+#define EMPTY_FDT_SIZE 256
 #endif
 
 #ifndef IGVM_VHT_OPTIONAL_BIT
@@ -871,7 +874,7 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
                                        Error **errp)
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
-    g_autofree void *fdt_packed = NULL;
+    g_autofree void *fdt = NULL;
     uint8_t *param_data;
     uint32_t param_size;
     uint32_t fdt_size;
@@ -881,20 +884,27 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
         return -1;
     }
 
-    if (ctx->machine_state->fdt == NULL) {
-        error_setg(errp, "IGVM: device tree not available");
-        return -1;
+    if (ctx->machine_state->fdt) {
+        fdt = g_memdup2(ctx->machine_state->fdt,
+                        fdt_totalsize(ctx->machine_state->fdt));
+    } else {
+        /*
+         * The machine doesn't build a device tree of its own.
+         * Supply an empty tree rather than rejecting the IGVM file.
+         */
+        fdt = g_malloc0(EMPTY_FDT_SIZE);
+        if (fdt_create_empty_tree(fdt, EMPTY_FDT_SIZE)) {
+            error_setg(errp, "IGVM: failed to create an empty device tree");
+            return -1;
+        }
     }
 
-    fdt_size = fdt_totalsize(ctx->machine_state->fdt);
-    fdt_packed = g_memdup2(ctx->machine_state->fdt, fdt_size);
-
-    if (fdt_pack(fdt_packed)) {
+    if (fdt_pack(fdt)) {
         error_setg(errp, "IGVM: failed to pack device tree");
         return -1;
     }
 
-    fdt_size = fdt_totalsize(fdt_packed);
+    fdt_size = fdt_totalsize(fdt);
     if (fdt_size > param_size) {
         error_setg(errp,
                    "IGVM: device tree size exceeds parameter area"
@@ -902,7 +912,7 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
         return -1;
     }
 
-    memcpy(param_data, fdt_packed, fdt_size);
+    memcpy(param_data, fdt, fdt_size);
 
     return 0;
 }
-- 
2.56.0


