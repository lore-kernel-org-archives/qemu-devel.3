Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4B0CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcGZ4-00070W-A1; Wed, 24 Jun 2026 01:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGZ2-000704-Cw
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGZ0-00062U-6g
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782280457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1uvo9RPO6TNl4nAj04B5KNyUa4/1mdy4K3DUeLED7o=;
 b=IDUjDTzhbhA0REFcF9leUYRgarwOHxkwZgtKsjmZDm3YxRZ/FIIt6GSl2OL4ZUP8ZsC3Dp
 YG0q1GixtCPy7OVUJGfu+jG32dz5bso+ndxpzdFW9pTCvC5B1ewzMCDM9l77kwI+n625pd
 RSKajQGbaB/b70t5nFAsD/pT8GW7NTk=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-CuefhXN0P4-tQZl2zGArhA-1; Wed, 24 Jun 2026 01:54:15 -0400
X-MC-Unique: CuefhXN0P4-tQZl2zGArhA-1
X-Mimecast-MFC-AGG-ID: CuefhXN0P4-tQZl2zGArhA_1782280454
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c108c19d4so807735eec.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 22:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782280454; x=1782885254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1uvo9RPO6TNl4nAj04B5KNyUa4/1mdy4K3DUeLED7o=;
 b=JzpFAY9/giy3pOUjLXtDHjlzwGwcs0kpF6IxSK28S/UsNokHv4D/w+19E5R1kq88TT
 pkDAA+qGV6ER+PWM5OqfIe/EGU1D/RrKhP7tw/ihL2PTSuuyzG01wMgmvSspUJPBVB0h
 soJn7CbQlKDIa11LAItExpNGVFizJx6gKyz8ox5J78pjCtx8bN7VgTGFpKTVPeNI3quW
 aXb1f7AdAu1e3T2LTDUMc7A23WwMr859KuXnpYb2AFaqk42+QhZI3+dV0JY610HX5Kq1
 mqQjkduQFgZz0kdzeXCFf2J3+G/SGV/AzWnEuxPgV866czINa1XP0baWCdYOmoewxoaI
 fr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782280454; x=1782885254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L1uvo9RPO6TNl4nAj04B5KNyUa4/1mdy4K3DUeLED7o=;
 b=ryq9zC3pCHG+kG6SEI+9FERbpDQsGYJS9ra/pzsEEGyM0T8SkG0hrWxmzqEmlvcsSx
 E6AV892qHCaodVtuBE7Qj/+GS6LRxvNF4ykfLJO7h6410eBUx4SbtoPwTUEW6H5glZrP
 AmjQjkoXNUQOZn8PQCrXXmWrR5W0mxV2l90HtY2OtTQpAWJmFYfiVwgqtYXeZ3c66jDK
 neDqc77Q9hJKS0v62ZRUa7gpUg4AJ7fmzITmMQt4sbLO/M49+HamrO9PmOYdT5+m5rJ6
 6nO67ns0lmPHvhA/UA5q4/npJAueiZSwB4pGUNxMFzXLouiXvKXEyF9TBLvbUOrVGIdv
 OmLw==
X-Gm-Message-State: AOJu0YzQDmbIK4yMxOEsq3LNPCG99RABjwBSMhEZ/SA5NbbwnZ/GQtay
 ZCK93VqM1idmU2G/hMU79xjLz5ouK2LL16qPZRNfYCIdcL36DSdcjDwg4otoQ1h77zCZJ/OS6b2
 k3LC1q5ZyQX7xYP1rLZcLI37b30kCMzbeezl8cTIDxdmC9GfxIv8TFg+V
X-Gm-Gg: AfdE7cmIiuJD7kpCqtOPqUIZTm8UC0cfQ09ejRpj6BaeE2d97Qih4DeQBuEhSc+DjAQ
 SKig7gl4nmOj2W81Tqcq0mjr6HjtqRd1YmwY2x3ht0/dgGCGEEAdbO+qSsJrGpOcojE/CPPfyYH
 45Rla+Vn4BhK2+JN+52V/zQ/2VQsDKQ5qekm54Yc+4I9FftGt8vyhst6ExPdas+Bfbjkj8xnfDv
 xaUVhHcELLfnQ0QIPKUcvPx+khBMqtwwtVCnB2tactLp+NHwHhITGXCO0mBQkJTTQRIkc5IFJ2g
 A5BtugyGx0f72zlhIHhiA9QhPeBkVBJ/j6/H11P5KeHkooGMovNz+bi3dzm7PM08zxWWulW0HEG
 ECFz/SLSAWpZYuI4tA9N73BUHJgcYtS4tFujGb1lGYaB7
X-Received: by 2002:a05:7300:f60b:b0:303:f2dc:8ab4 with SMTP id
 5a478bee46e88-30c6918496emr2477483eec.2.1782280454279; 
 Tue, 23 Jun 2026 22:54:14 -0700 (PDT)
X-Received: by 2002:a05:7300:f60b:b0:303:f2dc:8ab4 with SMTP id
 5a478bee46e88-30c6918496emr2477459eec.2.1782280453608; 
 Tue, 23 Jun 2026 22:54:13 -0700 (PDT)
Received: from rhel9-box.lan ([110.227.100.91])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d6edsm21075803eec.14.2026.06.23.22.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 22:54:13 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v1 1/8] igvm: store IgvmCfg pointer in QIgvm
Date: Wed, 24 Jun 2026 11:23:23 +0530
Message-ID: <20260624055339.46862-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260624055339.46862-1-anisinha@redhat.com>
References: <20260624055339.46862-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c                | 57 ++++++++++++++++++++--------------
 include/system/igvm-internal.h |  2 +-
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 3f4b97a5d4..2995e82cee 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -164,7 +164,8 @@ static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType raw_type,
         if (handlers[handler].type != type) {
             continue;
         }
-        header_handle = igvm_get_header(ctx->file, handlers[handler].section,
+        header_handle = igvm_get_header(ctx->cfg->file,
+                                        handlers[handler].section,
                                         ctx->current_header_index);
         if (header_handle < 0) {
             error_setg(
@@ -173,7 +174,7 @@ static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType raw_type,
                 (int)header_handle);
             return -1;
         }
-        header_data = igvm_get_buffer(ctx->file, header_handle);
+        header_data = igvm_get_buffer(ctx->cfg->file, header_handle);
         if (header_data != NULL) {
             header_data += sizeof(IGVM_VHS_VARIABLE_HEADER);
             result = handlers[handler].handler(ctx, header_data, errp);
@@ -184,7 +185,7 @@ static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType raw_type,
                     header_handle, type);
             result = -1;
         }
-        igvm_free_buffer(ctx->file, header_handle);
+        igvm_free_buffer(ctx->cfg->file, header_handle);
         return result;
     }
 
@@ -330,7 +331,8 @@ static int qigvm_process_mem_region(QIgvm *ctx, unsigned start_index,
 
     for (page_index = 0; page_index < page_count; page_index++) {
         data_handle = igvm_get_header_data(
-            ctx->file, IGVM_HEADER_SECTION_DIRECTIVE, page_index + start_index);
+            ctx->cfg->file, IGVM_HEADER_SECTION_DIRECTIVE,
+            page_index + start_index);
         if (data_handle == IGVMAPI_NO_DATA) {
             /* No data indicates a zero page */
             memset(&region[page_index * page_size], 0, page_size);
@@ -343,7 +345,7 @@ static int qigvm_process_mem_region(QIgvm *ctx, unsigned start_index,
             return -1;
         } else {
             zero = false;
-            data_size = igvm_get_buffer_size(ctx->file, data_handle);
+            data_size = igvm_get_buffer_size(ctx->cfg->file, data_handle);
             if (data_size < page_size) {
                 memset(&region[page_index * page_size], 0, page_size);
             } else if (data_size > page_size) {
@@ -353,14 +355,14 @@ static int qigvm_process_mem_region(QIgvm *ctx, unsigned start_index,
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
 
@@ -397,7 +399,8 @@ static int qigvm_process_mem_page(QIgvm *ctx,
             ctx->region_start = page_data->gpa;
             ctx->region_start_index = ctx->current_header_index;
         } else {
-            if (!qigvm_page_attrs_equal(ctx->file, ctx->current_header_index,
+            if (!qigvm_page_attrs_equal(ctx->cfg->file,
+                                        ctx->current_header_index,
                                         page_data,
                                         &ctx->region_prev_page_data) ||
                 ((ctx->region_prev_page_data.gpa +
@@ -460,7 +463,8 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
         return 0;
     }
 
-    data_handle = igvm_get_header_data(ctx->file, IGVM_HEADER_SECTION_DIRECTIVE,
+    data_handle = igvm_get_header_data(ctx->cfg->file,
+                                       IGVM_HEADER_SECTION_DIRECTIVE,
                                        ctx->current_header_index);
     if (data_handle < 0) {
         error_setg(errp, "Invalid VP context in IGVM file. Error code: %X",
@@ -468,7 +472,7 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
         return -1;
     }
 
-    data = (uint8_t *)igvm_get_buffer(ctx->file, data_handle);
+    data = (uint8_t *)igvm_get_buffer(ctx->cfg->file, data_handle);
     if (data == NULL) {
         error_setg(errp, "IGVM: No buffer for handle %d", data_handle);
         result = -1;
@@ -477,7 +481,8 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
 
     if (ctx->machine_state->cgs) {
         result = ctx->cgsc->set_guest_state(
-            vp_context->gpa, data, igvm_get_buffer_size(ctx->file, data_handle),
+            vp_context->gpa, data,
+            igvm_get_buffer_size(ctx->cfg->file, data_handle),
             CGS_PAGE_TYPE_VMSA, vp_context->vp_index, errp);
     } else if (target_arch() == SYS_EMU_TARGET_X86_64) {
         result = qigvm_x86_set_vp_context(data, vp_context->vp_index, errp);
@@ -490,7 +495,7 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
     }
 
 exit:
-    igvm_free_buffer(ctx->file, data_handle);
+    igvm_free_buffer(ctx->cfg->file, data_handle);
     if (result < 0) {
         return result;
     }
@@ -803,7 +808,8 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
     uint32_t compatibility_mask_sev_snp = 0;
     uint32_t compatibility_mask = 0;
 
-    header_count = igvm_header_count(ctx->file, IGVM_HEADER_SECTION_PLATFORM);
+    header_count = igvm_header_count(ctx->cfg->file,
+                                     IGVM_HEADER_SECTION_PLATFORM);
     if (header_count < 0) {
         error_setg(errp,
                    "Invalid platform header count in IGVM file. Error code: %X",
@@ -814,11 +820,11 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
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
@@ -827,11 +833,11 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
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
 
@@ -862,7 +868,7 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
             } else if (platform->platform_type == IGVM_PLATFORM_TYPE_NATIVE) {
                 compatibility_mask = platform->compatibility_mask;
             }
-            igvm_free_buffer(ctx->file, header_handle);
+            igvm_free_buffer(ctx->cfg->file, header_handle);
         }
     }
     /* Choose the strongest supported isolation technology */
@@ -939,7 +945,7 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
         error_setg(errp, "No IGVM file loaded.");
         return -1;
     }
-    ctx.file = cfg->file;
+    ctx.cfg = cfg;
     trace_igvm_process_file(cfg->file, onlyVpContext);
 
     ctx.machine_state = machine_state;
@@ -961,7 +967,8 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
         goto cleanup;
     }
 
-    header_count = igvm_header_count(ctx.file, IGVM_HEADER_SECTION_DIRECTIVE);
+    header_count = igvm_header_count(ctx.cfg->file,
+                                     IGVM_HEADER_SECTION_DIRECTIVE);
     if (header_count <= 0) {
         error_setg(
             errp, "Invalid directive header count in IGVM file. Error code: %X",
@@ -975,7 +982,8 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
          ctx.current_header_index < (unsigned)header_count;
          ctx.current_header_index++) {
         IgvmVariableHeaderType raw_type = igvm_get_header_type(
-            ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, ctx.current_header_index);
+            ctx.cfg->file, IGVM_HEADER_SECTION_DIRECTIVE,
+            ctx.current_header_index);
         if (!onlyVpContext || igvm_vht_type(raw_type) == IGVM_VHT_VP_CONTEXT) {
             if (qigvm_handler(&ctx, raw_type, errp) < 0) {
                 goto cleanup_parameters;
@@ -993,7 +1001,7 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
     }
 
     header_count =
-        igvm_header_count(ctx.file, IGVM_HEADER_SECTION_INITIALIZATION);
+        igvm_header_count(ctx.cfg->file, IGVM_HEADER_SECTION_INITIALIZATION);
     if (header_count < 0) {
         error_setg(
             errp,
@@ -1006,7 +1014,8 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
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
index 7f131c4d03..b55b35328a 100644
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


