Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E36FC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyCh-000058-N9; Mon, 17 Aug 2026 10:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyCd-0008Vw-Qz
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyCb-0002c4-QY
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786976437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fI9JZRfoTYevOhwLW01o4u8d5VRWRzVxD6hY9gyUnU=;
 b=hLj43nu1Ryebz5IwRQeqzCLTyYXMOgJ3QI3P5GRgs6UdmH8mdnHSKmnw9ba9RdhpXtpUo8
 DSf/XzGcg+zVnxltxR0cDrNgdbwCHbMZKlUixCiWSq6h3I4XdwpnPcznEXKvKUgSIjfTAn
 cNYyFFOx2QdarTiSjtRG1TMWb5zi684=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-MGQWK9g1Pn2O2ji86V6QOw-1; Mon, 17 Aug 2026 10:20:35 -0400
X-MC-Unique: MGQWK9g1Pn2O2ji86V6QOw-1
X-Mimecast-MFC-AGG-ID: MGQWK9g1Pn2O2ji86V6QOw_1786976435
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ce8a76df2dso79178065ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786976434; x=1787581234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0fI9JZRfoTYevOhwLW01o4u8d5VRWRzVxD6hY9gyUnU=;
 b=oXp+jwxx3qBaenfh5iSZNvcpPQjdyEooMkKYp4BGb0wnrW//Z7XVXma1PXx7g60QD3
 2QqjjHc122kn/N+ZP8ZiB7uTV+rxPvSlw3+OzWsstVNmHNDbfmzArkn6zA8J8RQ8Cox0
 E4QLoO2hFspMZJJFEeG6PvPk/6/X1C8RFrMj3mhfBxe1JX1Q61vkpZ/vyoLssfMH+5wb
 L/nwrkKXG79Kxp6Jrd8O9sqngcYJlWqUKUUd0S+qrRA0jYdCQWK1oa2g+BtXqouCkvLv
 nNynZQEfxhhZBmzIta7zfWf44CVX7q7nn+hL9TuDlgFolBw0X2OhLMXhJUFQKmmCIyq1
 A8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976434; x=1787581234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0fI9JZRfoTYevOhwLW01o4u8d5VRWRzVxD6hY9gyUnU=;
 b=Cwph9lfk4ZdX159cyUfkwdMKbqcmJbIFSVuid1ItCwBiKmeYUoWR1x9zfCp+FfBH7B
 aNtSD03FAmucb6zdqb+7R/AfW6jO/j5Ag29A1+tmOi6O6RSqwor5OctX0kRRCW3v38Yp
 8rJ66GOGrElk/O2gWBVV8MkKgjjvcK+JFki/C3sfk5jAp+XglcyM6gC8X9TKq8m5r/4E
 fOWSY3jHLwwYz88uYfq3zbEYQ+VRmGFLg5duwLpltZH7tzLEyTJ+p4+1y2S5j5CziUA2
 QcFXzCQpTgyHQdxu7wD0iBsFqma5QLCFF+A+elPFyHpdqNV882BTKXExKvD6r6ry987G
 F0Zg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpL5Eu315NeCHkI5deeeALGo5HN1iUuFnnmxcpCmmUijr4PMtiBELBYB4+/1keABnx1nj+w69z428Rp@nongnu.org
X-Gm-Message-State: AOJu0Yx1LhknpJmseqdfiQ0hFKOQxR/1YmWMFHBC9KAD+iqp6DCnf61v
 zjQeBZZKwdWzU1WhkqjQUDfliQLAcDifCtioZW0WVdijj3u6e7Y3Tw8/QBG8De8f9P1va+slGYm
 hTWrs5UWNGPMt2DOP8nB2DGzhro++bmAAVonkM/h8ckj1hyWuRI9typMV
X-Gm-Gg: AR+sD121TQDwebkA+zBX4az9Z1GDGvvzFBxG2r4QsJtHE9/eqs/la6zyMSlB1+4bp0l
 p1qTsBYx9hmMim+SHrFQfue8+UjW0K4/8FdI2kWcFy6Qvy2iN88MOi2Aw4u6cA/xhkUc+Rg0k9W
 9jxSNI/Lv1MMFwS1DxstApndn37bx4S12qxzUAFr2ppywa7vLUI77c48Q6Upv7/UeSFAXIMxjcq
 YsARwxYIw83jvoySGFAlVpaEwR4NZY7GbqtJ59BreTdfhB199cGtRWHZZJtDvpINEezc/z9JoiG
 BWO41PFcliash9Y+TVujQMGZ7cwhNoCw5CsYlNxjCfgwysIu2IXiIrxTaZiNd0C9J99E1b1SdQy
 RCPQ3qVwxXj4zEolfLIyUnd9C/Xyu7Gr8Tw==
X-Received: by 2002:a17:902:f691:b0:2ca:481:de45 with SMTP id
 d9443c01a7336-2d5c4f3b815mr6704595ad.6.1786976434425; 
 Mon, 17 Aug 2026 07:20:34 -0700 (PDT)
X-Received: by 2002:a17:902:f691:b0:2ca:481:de45 with SMTP id
 d9443c01a7336-2d5c4f3b815mr6704045ad.6.1786976433809; 
 Mon, 17 Aug 2026 07:20:33 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d5c1efd10fsm3705105ad.81.2026.08.17.07.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:20:32 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: ani@anisinha.ca, agraf@csgraf.de, graf@amazon.com, qemu-devel@nongnu.org
Subject: [PATCH v6 01/11] igvm: store IgvmCfg pointer in QIgvm
Date: Mon, 17 Aug 2026 19:49:56 +0530
Message-ID: <20260817142010.80693-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260817142010.80693-1-anisinha@redhat.com>
References: <20260817142010.80693-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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


