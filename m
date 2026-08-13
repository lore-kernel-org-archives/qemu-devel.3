Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913C1C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSm3-0005vK-1N; Thu, 13 Aug 2026 06:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSm1-0005uj-Ng
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSlz-00008L-LK
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786617295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fI9JZRfoTYevOhwLW01o4u8d5VRWRzVxD6hY9gyUnU=;
 b=LtAyN4UO5hPtjVQFv1MqtZmMw1EPRDJcPdU78JmZhY7ZEj7EUMtiYU0SV7jhGGLeL+njYi
 lvA12+44Sy8ZVWGdr5WaKU7WvRuQbkSAIV1syIYqS8qITkL94Fd9b5KgiR1VOCz7hP8qFi
 6FrSqqdqATJ0PYA5U6AKl0GFd4xoaWY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-B2_YEzwNOSmvG7M6Zkkqbg-1; Thu, 13 Aug 2026 06:34:51 -0400
X-MC-Unique: B2_YEzwNOSmvG7M6Zkkqbg-1
X-Mimecast-MFC-AGG-ID: B2_YEzwNOSmvG7M6Zkkqbg_1786617290
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e25e4b41cso691301a91.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 03:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786617290; x=1787222090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0fI9JZRfoTYevOhwLW01o4u8d5VRWRzVxD6hY9gyUnU=;
 b=JCwSmxTYUo5rppd9vmQn2TJq+lYh2DA3Pda+VKKgfTL8sSsSgL7VMDeE0sY+qWoJGk
 2mF4d0baiopBdP+QRrNge1S4drD7MzdTGcktiL2ss73GRh5BS9UhOQqVcqHwmldOD660
 Lv1rHCKAONkmtVp9GKAh0nmDW/RTvhwtHQMVGq2pAjVX57UJdZ2laTAAEGTVjGIReUqX
 1L5t0Zd+X/mOR5cJCSF7jCzZxJObD1IcvJr91SRmNAYal3abDDhFR5I8KzWjjMwkmbn5
 6O9jCeX+sxOTMRMZVc3x1NgHvgtb35tl/C+KOChApeKTfL/FiN1sFChYcn4H6XnDqSZP
 RGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617290; x=1787222090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0fI9JZRfoTYevOhwLW01o4u8d5VRWRzVxD6hY9gyUnU=;
 b=Kw1eCJz9ICGLnRRt+LP2xnC7W4zcsHtD6rTqcxTImY5jN9jZdHO8QOsSlR3o/tUxQJ
 zCWtcv9cmhik838i6z3inLoERm0ReP8wT2j1uO3ZEjy6ehi7zaiPI+k13bW2SIwfUDbq
 g3ruInJ18KhMHic5mqvOyIrcIbptdQzcBGF9ji2Jnuz70Av3TOzNQFL/P3dzv63ZTUS4
 lK1fcmJYggKPo08JMUpKVr2CpDrpqD6Bz8YrXrTpZVSXcLLm9bsDY+ywymm5ameaeK7F
 ebjD9d/6TlD5L3GfSqlQI5H+j6a5IDVT1eJQU2LHqgauXY43buLBqVvDm+Hdbgv1MH4I
 xuow==
X-Forwarded-Encrypted: i=1;
 AHgh+RqftRdtsf10FZnIXfGyrlzAOM9F0Z+2wBS+VLgDfcnugfcMKAy7CQW5dXRPd8GcoaEGF3zVXiCqANEL@nongnu.org
X-Gm-Message-State: AOJu0YztWQtwJMTQVShiPc6I77T37XoJKrz0qjxJgcAXt1e4CKzvj+lH
 zS6+gy6OmilFBmXaCWr03qCsMd3YCSpT5yNuDvEstaEkt2v2AHc+7SCsXuzmfqX0oN9lyLVY7Hm
 AA2JUpP85+rBvJjBq1Zc4FvUtzVFzjoJAJQwIF9FMxFU8NVdwDW1I/Lv/
X-Gm-Gg: AR+sD11P94Ey5gWpsHECRD9H31O4egfVOJm8kCsjxzDw5XpKalQGSUugWpx8I8Lf591
 ZHbrQtpImZV3XdK7okDWgZBKHZpCosAd0VEzb+YpxSqg7cYLnWuk0+9Pp/VGVhLA6s3VUxjz02L
 5Dnqt3eeajQ3KDMJIinDKB6nMXqlH3qTRYDRjEnUlH1StP1AjW056WIc3JwDPItcBD4ssaUt2uQ
 SzaMp5NJXYZtxWn7OlGq7Zm1E3l8cffYc2LqWNhrtVNbbyIYQpZ0bjLWeQJS1jQw4yAFT+XYmmB
 PwAGVaRMYwkYYrjDqhWz3zi5U6bDf00x6AmXupsN37w0zdaLF/LsKXiji+HLQYG/LBS2n0Fq2Fv
 rW3dxfmDEWrjLQXGs79uzEBVbrzS3a4Oegg==
X-Received: by 2002:a17:90b:57c6:b0:390:b41a:b92a with SMTP id
 98e67ed59e1d1-3931dfe3decmr5655192a91.4.1786617290025; 
 Thu, 13 Aug 2026 03:34:50 -0700 (PDT)
X-Received: by 2002:a17:90b:57c6:b0:390:b41a:b92a with SMTP id
 98e67ed59e1d1-3931dfe3decmr5655154a91.4.1786617289469; 
 Thu, 13 Aug 2026 03:34:49 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3931ced0781sm2918093a91.11.2026.08.13.03.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:34:49 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: ani@anisinha.ca, agraf@csgraf.de, graf@amazon.com, qemu-devel@nongnu.org
Subject: [PATCH v5 01/11] igvm: store IgvmCfg pointer in QIgvm
Date: Thu, 13 Aug 2026 16:04:03 +0530
Message-ID: <20260813103425.24474-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260813103425.24474-1-anisinha@redhat.com>
References: <20260813103425.24474-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Gerd Hoffmann <kraxel@redhat.com>

Store a pointer to IgvmCfg instead of only IgvmFile in QIgvm.  Allows to
store additional state in the (persistent) IgvmCfg struct.

Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c                | 57 ++++++++++++++++++++--------------
 include/system/igvm-internal.h |  2 +-
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 80e87fe602..534032fed8 100644
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
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 7eb3792ed8..b5720fae0c 100644
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
-- 
2.42.0


