Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DBBC5DF93
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxRps-0006Ta-7S; Fri, 21 Aug 2026 12:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wxRpq-0006SU-CW
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wxRpo-0001XA-Dm
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787328671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dGUzv5WHptor2idlHZr5nwRiEW5XDSx77shBFL6pTfI=;
 b=H54z4KF8UARePuPljyAi4F3Dc/LBriR6GeZaHwVItuIGkBTpjzHWrsYMBSVsPvTymYNG0e
 zu4+5/CpcJa3KIa+FssKAYkNwPo7qBQ1GDRF5fSPojcwtuyxAVEwI7vGEVqMeJ26h2mgdW
 g1aUahAlB6dUytaEHmaPvpqffzag1/k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-pzBuqZobOeGjCKv6aKx5ow-1; Fri,
 21 Aug 2026 12:11:09 -0400
X-MC-Unique: pzBuqZobOeGjCKv6aKx5ow-1
X-Mimecast-MFC-AGG-ID: pzBuqZobOeGjCKv6aKx5ow_1787328668
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3E571954221; Fri, 21 Aug 2026 16:11:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D08A81800346; Fri, 21 Aug 2026 16:11:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 632811800613; Fri, 21 Aug 2026 18:11:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Gerd Hoffman <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>
Subject: [PULL 02/12] igvm: store IgvmCfg pointer in QIgvm
Date: Fri, 21 Aug 2026 18:10:50 +0200
Message-ID: <20260821161103.3489298-3-kraxel@redhat.com>
In-Reply-To: <20260821161103.3489298-1-kraxel@redhat.com>
References: <20260821161103.3489298-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Store a pointer to IgvmCfg instead of only IgvmFile in QIgvm.  Allows to
store additional state in the (persistent) IgvmCfg struct.

Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260817142010.80693-2-anisinha@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/igvm-internal.h |  2 +-
 backends/igvm.c                | 57 ++++++++++++++++++++--------------
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 7eb3792ed8c5..b5720fae0c00 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -43,7 +43,7 @@ typedef struct QIgvmParameterData {
  * file.
  */
 struct QIgvm {
-    IgvmHandle file;
+    IgvmCfg *cfg;
     MachineState *machine_state;
     ConfidentialGuestSupportClass *cgsc;
     uint32_t compatibility_mask;
diff --git a/backends/igvm.c b/backends/igvm.c
index 80e87fe6029a..534032fed812 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -178,7 +178,8 @@ static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType raw_type,
         if (handlers[handler].type != type) {
             continue;
         }
-        header_handle = igvm_get_header(ctx->file, handlers[handler].section,
+        header_handle = igvm_get_header(ctx->cfg->file,
+                                        handlers[handler].section,
                                         ctx->current_header_index);
         if (header_handle < 0) {
             error_setg(
@@ -187,7 +188,7 @@ static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType raw_type,
                 (int)header_handle);
             return -1;
         }
-        header_data = igvm_get_buffer(ctx->file, header_handle);
+        header_data = igvm_get_buffer(ctx->cfg->file, header_handle);
         if (header_data != NULL) {
             header_data += sizeof(IGVM_VHS_VARIABLE_HEADER);
             result = handlers[handler].handler(ctx, header_data, errp);
@@ -198,7 +199,7 @@ static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType raw_type,
                     header_handle, type);
             result = -1;
         }
-        igvm_free_buffer(ctx->file, header_handle);
+        igvm_free_buffer(ctx->cfg->file, header_handle);
         return result;
     }
 
@@ -344,7 +345,8 @@ static int qigvm_process_mem_region(QIgvm *ctx, unsigned start_index,
 
     for (page_index = 0; page_index < page_count; page_index++) {
         data_handle = igvm_get_header_data(
-            ctx->file, IGVM_HEADER_SECTION_DIRECTIVE, page_index + start_index);
+            ctx->cfg->file, IGVM_HEADER_SECTION_DIRECTIVE,
+            page_index + start_index);
         if (data_handle == IGVMAPI_NO_DATA) {
             /* No data indicates a zero page */
             memset(&region[page_index * page_size], 0, page_size);
@@ -357,7 +359,7 @@ static int qigvm_process_mem_region(QIgvm *ctx, unsigned start_index,
             return -1;
         } else {
             zero = false;
-            data_size = igvm_get_buffer_size(ctx->file, data_handle);
+            data_size = igvm_get_buffer_size(ctx->cfg->file, data_handle);
             if (data_size < page_size) {
                 memset(&region[page_index * page_size], 0, page_size);
             } else if (data_size > page_size) {
@@ -367,14 +369,14 @@ static int qigvm_process_mem_region(QIgvm *ctx, unsigned start_index,
                            page_index + start_index);
                 return -1;
             }
-            data = igvm_get_buffer(ctx->file, data_handle);
+            data = igvm_get_buffer(ctx->cfg->file, data_handle);
             if (data == NULL) {
                 error_setg(errp, "IGVM: No buffer for handle %d", data_handle);
-                igvm_free_buffer(ctx->file, data_handle);
+                igvm_free_buffer(ctx->cfg->file, data_handle);
                 return -1;
             }
             memcpy(&region[page_index * page_size], data, data_size);
-            igvm_free_buffer(ctx->file, data_handle);
+            igvm_free_buffer(ctx->cfg->file, data_handle);
         }
     }
 
@@ -411,7 +413,8 @@ static int qigvm_process_mem_page(QIgvm *ctx,
             ctx->region_start = page_data->gpa;
             ctx->region_start_index = ctx->current_header_index;
         } else {
-            if (!qigvm_page_attrs_equal(ctx->file, ctx->current_header_index,
+            if (!qigvm_page_attrs_equal(ctx->cfg->file,
+                                        ctx->current_header_index,
                                         page_data,
                                         &ctx->region_prev_page_data) ||
                 ((ctx->region_prev_page_data.gpa +
@@ -474,7 +477,8 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
         return 0;
     }
 
-    data_handle = igvm_get_header_data(ctx->file, IGVM_HEADER_SECTION_DIRECTIVE,
+    data_handle = igvm_get_header_data(ctx->cfg->file,
+                                       IGVM_HEADER_SECTION_DIRECTIVE,
                                        ctx->current_header_index);
     if (data_handle < 0) {
         error_setg(errp, "Invalid VP context in IGVM file. Error code: %X",
@@ -482,7 +486,7 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
         return -1;
     }
 
-    data = (uint8_t *)igvm_get_buffer(ctx->file, data_handle);
+    data = (uint8_t *)igvm_get_buffer(ctx->cfg->file, data_handle);
     if (data == NULL) {
         error_setg(errp, "IGVM: No buffer for handle %d", data_handle);
         result = -1;
@@ -491,7 +495,8 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
 
     if (ctx->machine_state->cgs) {
         result = ctx->cgsc->set_guest_state(
-            vp_context->gpa, data, igvm_get_buffer_size(ctx->file, data_handle),
+            vp_context->gpa, data,
+            igvm_get_buffer_size(ctx->cfg->file, data_handle),
             CGS_PAGE_TYPE_VMSA, vp_context->vp_index, errp);
     } else if (target_arch() == SYS_EMU_TARGET_X86_64) {
         result = qigvm_x86_set_vp_context(data, vp_context->vp_index, errp);
@@ -504,7 +509,7 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
     }
 
 exit:
-    igvm_free_buffer(ctx->file, data_handle);
+    igvm_free_buffer(ctx->cfg->file, data_handle);
     if (result < 0) {
         return result;
     }
@@ -863,7 +868,8 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
     uint32_t compatibility_mask_sev_snp = 0;
     uint32_t compatibility_mask = 0;
 
-    header_count = igvm_header_count(ctx->file, IGVM_HEADER_SECTION_PLATFORM);
+    header_count = igvm_header_count(ctx->cfg->file,
+                                     IGVM_HEADER_SECTION_PLATFORM);
     if (header_count < 0) {
         error_setg(errp,
                    "Invalid platform header count in IGVM file. Error code: %X",
@@ -874,11 +880,11 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
     for (header_index = 0; header_index < (unsigned)header_count;
          header_index++) {
         IgvmVariableHeaderType typ = igvm_get_header_type(
-            ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
+            ctx->cfg->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
         typ = igvm_vht_type(typ);
         if (typ == IGVM_VHT_SUPPORTED_PLATFORM) {
             header_handle = igvm_get_header(
-                ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
+                ctx->cfg->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
             if (header_handle < 0) {
                 error_setg(errp,
                            "Invalid platform header in IGVM file. "
@@ -887,11 +893,11 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
                 return -1;
             }
             platform =
-                (IGVM_VHS_SUPPORTED_PLATFORM *)(igvm_get_buffer(ctx->file,
+                (IGVM_VHS_SUPPORTED_PLATFORM *)(igvm_get_buffer(ctx->cfg->file,
                                                                 header_handle));
             if (platform == NULL) {
                 error_setg(errp, "IGVM: No buffer for handle %d", header_handle);
-                igvm_free_buffer(ctx->file, header_handle);
+                igvm_free_buffer(ctx->cfg->file, header_handle);
                 return -1;
             }
 
@@ -922,7 +928,7 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
             } else if (platform->platform_type == IGVM_PLATFORM_TYPE_NATIVE) {
                 compatibility_mask = platform->compatibility_mask;
             }
-            igvm_free_buffer(ctx->file, header_handle);
+            igvm_free_buffer(ctx->cfg->file, header_handle);
         }
     }
     /* Choose the strongest supported isolation technology */
@@ -999,7 +1005,7 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
         error_setg(errp, "No IGVM file loaded.");
         return -1;
     }
-    ctx.file = cfg->file;
+    ctx.cfg = cfg;
     trace_igvm_process_file(cfg->file, onlyVpContext);
 
     ctx.machine_state = machine_state;
@@ -1021,7 +1027,8 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
         goto cleanup;
     }
 
-    header_count = igvm_header_count(ctx.file, IGVM_HEADER_SECTION_DIRECTIVE);
+    header_count = igvm_header_count(ctx.cfg->file,
+                                     IGVM_HEADER_SECTION_DIRECTIVE);
     if (header_count <= 0) {
         error_setg(
             errp, "Invalid directive header count in IGVM file. Error code: %X",
@@ -1035,7 +1042,8 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
          ctx.current_header_index < (unsigned)header_count;
          ctx.current_header_index++) {
         IgvmVariableHeaderType raw_type = igvm_get_header_type(
-            ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, ctx.current_header_index);
+            ctx.cfg->file, IGVM_HEADER_SECTION_DIRECTIVE,
+            ctx.current_header_index);
         if (!onlyVpContext || igvm_vht_type(raw_type) == IGVM_VHT_VP_CONTEXT) {
             if (qigvm_handler(&ctx, raw_type, errp) < 0) {
                 goto cleanup_parameters;
@@ -1053,7 +1061,7 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
     }
 
     header_count =
-        igvm_header_count(ctx.file, IGVM_HEADER_SECTION_INITIALIZATION);
+        igvm_header_count(ctx.cfg->file, IGVM_HEADER_SECTION_INITIALIZATION);
     if (header_count < 0) {
         error_setg(
             errp,
@@ -1066,7 +1074,8 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
          ctx.current_header_index < (unsigned)header_count;
          ctx.current_header_index++) {
         IgvmVariableHeaderType type =
-            igvm_get_header_type(ctx.file, IGVM_HEADER_SECTION_INITIALIZATION,
+            igvm_get_header_type(ctx.cfg->file,
+                                 IGVM_HEADER_SECTION_INITIALIZATION,
                                  ctx.current_header_index);
         if (qigvm_handler(&ctx, type, errp) < 0) {
             goto cleanup_parameters;
-- 
2.55.0


