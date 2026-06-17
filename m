Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63845CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnDC-0006lg-Ri; Wed, 17 Jun 2026 06:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wZnDB-0006lF-Jf
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wZnD9-0000Wb-Qn
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781690970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WDHK55odBvgL5WNEiMm6wKtzzsfWxmYvXH0NGMhmUvw=;
 b=PAhmdzjxJNIEYB4OXUI63VfnPMa3Civbs+gTWa9AYBRTFlh8prQHRj9V7DpLlqE5UaKfRR
 M3LOMr2sw939YN8GxXf/YICAQ2pegKiXdP9nTO6C/ukvH7kIgIx9OQeskUT5HILpgq4Q5U
 wtFHTVJAtWLGRBVDwSpqEQUyMGqbD0A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-PhPWYVRcMsWCYkIiSS-TFA-1; Wed,
 17 Jun 2026 06:09:28 -0400
X-MC-Unique: PhPWYVRcMsWCYkIiSS-TFA-1
X-Mimecast-MFC-AGG-ID: PhPWYVRcMsWCYkIiSS-TFA_1781690966
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52910195E90A
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:09:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.13])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B45283189; Wed, 17 Jun 2026 10:09:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0DDB21801A85; Wed, 17 Jun 2026 12:09:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 3/3] igvm: fix handling of optional variable header types
Date: Wed, 17 Jun 2026 12:09:22 +0200
Message-ID: <20260617100922.1302000-4-kraxel@redhat.com>
In-Reply-To: <20260617100922.1302000-1-kraxel@redhat.com>
References: <20260617100922.1302000-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Luigi Leonardi <leonardi@redhat.com>

The IGVM spec defines bit 31 of the variable header type as an
optional flag: if set, a loader that does not recognize the header
type may safely skip it. If clear, the loader must reject the file.

Currently, the optional bit is not stripped before comparing header
types, so headers with the bit set fail to match any known type
and are rejected.

Mask bit 31 before comparing header types throughout the IGVM
loader, and skip with a warning any unrecognized header that has
the optional bit set.

Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Message-ID: <20260609-igvm_optional-v2-2-b1f1f08dc40e@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 3ccbafe9b90c..3f4b97a5d417 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -26,6 +26,25 @@
 #include <igvm/igvm.h>
 #include <igvm/igvm_defs.h>
 
+#ifndef IGVM_VHT_OPTIONAL_BIT
+#define IGVM_VHT_OPTIONAL_BIT (1U << 31)
+#endif
+
+/*
+ * Bit 31 of the variable header type indicates that the header is
+ * optional and can be safely ignored by a loader that does not
+ * support it. If the bit is clear, the file cannot be loaded.
+ * https://docs.rs/igvm_defs/0.4.0/igvm_defs/struct.IgvmVariableHeaderType.html
+ */
+static IgvmVariableHeaderType igvm_vht_type(IgvmVariableHeaderType type)
+{
+    return type & ~IGVM_VHT_OPTIONAL_BIT;
+}
+
+static bool igvm_vht_optional(IgvmVariableHeaderType type)
+{
+    return !!(type & IGVM_VHT_OPTIONAL_BIT);
+}
 
 /*
  * Some directives are specific to particular confidential computing platforms.
@@ -132,12 +151,14 @@ static struct QIGVMHandler handlers[] = {
       qigvm_directive_madt },
 };
 
-static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType type, Error **errp)
+static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType raw_type,
+                         Error **errp)
 {
     size_t handler;
     IgvmHandle header_handle;
     const uint8_t *header_data;
     int result;
+    IgvmVariableHeaderType type = igvm_vht_type(raw_type);
 
     for (handler = 0; handler < G_N_ELEMENTS(handlers); handler++) {
         if (handlers[handler].type != type) {
@@ -166,6 +187,13 @@ static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType type, Error **errp)
         igvm_free_buffer(ctx->file, header_handle);
         return result;
     }
+
+    if (igvm_vht_optional(raw_type)) {
+        warn_report("IGVM: Skipping unsupported optional header type 0x%"
+                    PRIX32, type);
+        return 0;
+    }
+
     error_setg(errp,
                "IGVM: Unknown header type encountered when processing file: "
                "(type 0x%X)",
@@ -787,6 +815,7 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
          header_index++) {
         IgvmVariableHeaderType typ = igvm_get_header_type(
             ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
+        typ = igvm_vht_type(typ);
         if (typ == IGVM_VHT_SUPPORTED_PLATFORM) {
             header_handle = igvm_get_header(
                 ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
@@ -945,10 +974,10 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
     for (ctx.current_header_index = 0;
          ctx.current_header_index < (unsigned)header_count;
          ctx.current_header_index++) {
-        IgvmVariableHeaderType type = igvm_get_header_type(
+        IgvmVariableHeaderType raw_type = igvm_get_header_type(
             ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, ctx.current_header_index);
-        if (!onlyVpContext || (type == IGVM_VHT_VP_CONTEXT)) {
-            if (qigvm_handler(&ctx, type, errp) < 0) {
+        if (!onlyVpContext || igvm_vht_type(raw_type) == IGVM_VHT_VP_CONTEXT) {
+            if (qigvm_handler(&ctx, raw_type, errp) < 0) {
                 goto cleanup_parameters;
             }
         }
-- 
2.54.0


