Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2F0C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x64Sq-0000LV-FV; Mon, 14 Sep 2026 07:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x64So-0000Kb-Mg
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:03:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x64Sm-0003bR-1R
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789383783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zf3SZFWYaM811KTqObYNFKPH8Ipvsia+gV3d3fLGcZ0=;
 b=hHzl83xH26ouZsnY7sA2sesbKEFZTOJeUPUc4Aj7eKkZT8NjYpUxd2kBHUjkQAiipDKfvP
 RO8jB+ViGex5DX8dbQNhSru3vEY8e/a2wJrXGyLDh/y8oHHWOy1A7vhaqpQi2O1RFHlDXE
 psiIfi64PvAZwWcGwjq12jzwL4b6lwM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-u6G3IApBPcOl6aBhyLn74A-1; Mon, 14 Sep 2026 07:02:51 -0400
X-MC-Unique: u6G3IApBPcOl6aBhyLn74A-1
X-Mimecast-MFC-AGG-ID: u6G3IApBPcOl6aBhyLn74A_1789383770
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cf4cc2125so12606025e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 04:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789383770; x=1789988570; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Zf3SZFWYaM811KTqObYNFKPH8Ipvsia+gV3d3fLGcZ0=;
 b=pk6Qae21+PzLVhOYKZ/IRvRPh0DH81VlNdqSQ0092+8d+Shv3ApsdJ5dL1BVU2Mf2d
 FTXQTwW0MuxyFOWZTxPnzQ/0EY/B90hdCEuvYhECE2AoLW8BVDXCqOSzFQCp/tz1D/x5
 nJGCkH8dr7f3b8lX/H2b+1dURlVdq38if/NCEjXIR4dmLEsfyV5tP1CVPU+yD7ThrKwX
 snYaktdTcf5L6d5X566kwHDm83xCi2iMOHHXNeZWMUiQAWvn6sK0Qy4NZyV3SbBwY/lg
 R6TXhcgs0Eqzh43pU+HzkOQDGmUbmaY3Kw3Dfjepvuf+c5Xkjom7f9ZzG7QMYnyqA1xU
 FvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789383770; x=1789988570;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Zf3SZFWYaM811KTqObYNFKPH8Ipvsia+gV3d3fLGcZ0=;
 b=lESjs5CN/H37r5csXJrns4aEPSdyeRSZpQHOFMOL7LyMzEyRlOcu+u/SGkbzlA9hLF
 aJfYBmuJCCa279Z7xtY0l2OHIqDk+QnY/VU9V0Ha+1YQK8GpH9IUTjAOtx5d1hxpPQl+
 psYAEx8y1r8mKxFKwHKndiVRCgk0vHhX7eE5pVvM32eobf1GAwJ+xsnfm4P0vVvg/XJh
 qYADozW1owCU3gDHR3pUP5rp9OZyKClUlJKNYaCZWVtwjjR4e2KFi9yY0LqdiG2lkgs2
 MCR7fIMybq3K6Raw87v1Q/DinKwLfuWrEw1R+y3QwBGsrmwPnff3usWn+kivTN3yfQF5
 V20Q==
X-Gm-Message-State: AFuF++mH7gXUBFwCl67HaLOUulMTYX7K6JThMB9HXPgj75S9baDnjTds
 9EWlzbi8EaALW+h+9l+TyMzgFsufHZ0D0uaDWdwgkNo0Twb49gkvXz/I82/PQgbIgmtuQcoFex5
 Qm0/w0XWqgEVLG8tI+yCmQCtJxWxTK/4PeaGoKUjjVjEKJX3P+DRmCeU/
X-Gm-Gg: AYBFou0KEjpZncDX1427ocfls5dTanKCumi7ctn7vJ6ydLvJ5NRrGVh6KS3Gja801vi
 8lpEXGciOmMWZeokvhHDnIqRJqQPrEhIFq+xjtClkHYbgymsCFR/TCZatDAl5cF7/8u3/yO10fz
 tZzLah8Vu5OMpaMPFODiwPC8cBIAr87med7Et/D/Dy29+0Ke50EEOnt7+5+LZ2AEkmL/FMcyCYy
 0RGFNxYg2VzHkuy+2aoGGrVGYjoYAooHMooiMb0UjW4jwJJbIQkojvXisoYN30+MfOt7uAYEtxk
 SrqBc4oYPow9j9ThYj8SyiHXfldxxgkhWDC/TyUgCi8Mgb3w3nYPCx2R1rUT1D2cqZ53obZsBu8
 0a+4FVsUgQ2VlvPrxIXvfRfwSCN6h6LFXL5v+Cf8uxiPVxYXIFhz/bw==
X-Received: by 2002:a05:600c:4e45:b0:49e:6050:9fbe with SMTP id
 5b1f17b1804b1-49e7a68cefdmr51426765e9.15.1789383770421; 
 Mon, 14 Sep 2026 04:02:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4e45:b0:49e:6050:9fbe with SMTP id
 5b1f17b1804b1-49e7a68cefdmr51425375e9.15.1789383769909; 
 Mon, 14 Sep 2026 04:02:49 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7a29826fsm51727605e9.4.2026.09.14.04.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 04:02:49 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 14 Sep 2026 13:02:43 +0200
Subject: [PATCH v4] igvm: validate and honor byte_offset in parameter
 directives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-fix_offset-v4-1-39d74497c6b5@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MTQ7CIBCG4asY1mKA0j9X3sMYA9MZy8JioCGap
 neXdtVGl99MnndiEYPDyM6HiQVMLjo/5KGPBwa9GR7IXZc3U0JVohWKk3vfPVHEkRtVNWClMoa
 AZfAKmL9r7HrLu3dx9OGztpNcrn8zSXLBhbayobpsS6suAbvejCfwT7Z0ktpavbMqWyqt1UBVp
 634scXW1jtbZGuBCJBAtE25s/M8fwHDhnVLHQEAAA==
X-Change-ID: 20260902-fix_offset-a268cb12aafc
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 qemu-stable@nongnu.org, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

None of the directive handlers that place data within a parameter area
validated that param->byte_offset actually falls within the parameter
area's size. A malformed IGVM file with byte_offset > size would
underflow the "size - byte_offset" computation used to determine
remaining space, wrapping to a huge value and defeating the size
check, then write out of bounds through param_entry->data +
byte_offset.

Separately, qigvm_directive_memory_map(), qigvm_directive_madt() and
qigvm_directive_device_tree() ignored param->byte_offset entirely and
always wrote at the start of the parameter area's buffer. This is
harmless when a directive's offset happens to be 0, but breaks for
IGVM files that pack multiple parameters into a single shared
parameter area at different offsets: a later directive would
overwrite the data written by an earlier one, corrupting it.

Add qigvm_get_param_data(), which looks up the parameter area, checks
byte_offset against its size, and returns the offset-adjusted data
pointer directly (NULL on failure), with the remaining space returned
via an output parameter, instead of the raw QIgvmParameterData entry.
This keeps the byte_offset arithmetic and bounds check in one place
instead of repeating it at every call site.

Switch every directive handler that reads or writes parameter data
to use it, adding explicit checks that each fixed-size read/write fits in
the remaining space.

Fixes: c1d466d267 ("backends/igvm: Add IGVM loader and configuration")
Fixes: dea1f68a5c ("igvm: Fill MADT IGVM parameter field on x86_64")
Fixes: 1c4bd8f13c ("igvm: add device tree parameter support")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Several IGVM directives (memory map, vp-count, environment info, MADT,
device tree) _can_ place their data at a byte_offset within a shared
parameter area, letting multiple parameters be packed into one area.

Introduce qigvm_get_param_data(), which looks up a
parameter area and validates that byte_offset falls within it in one
step, and uses it in the vp-count and environment-info handlers, which
already relied on byte_offset.

Also fixes the memory map, MADT and device tree handlers, which
ignored byte_offset entirely and always wrote at the start of the
buffer, potentially corrupting earlier data when several parameters
share an area.
---
Changes in v4:
- Squashed two commits in one.
- Removed one parameter from `qigvm_get_param_data` [Stefano]
- Removed some useless variables [Stefano]
- Rebased to latest upstream
- Link to v3: https://lore.kernel.org/qemu-devel/20260907-fix_offset-v3-0-bcffcefc0985@redhat.com

Changes in v3:
- Renamed the function to `qigvm_get_param_data`. [Stefano]
- `qigvm_get_param_data` now returns the data pointer directly [Stefano]
- Added fixes tags. [Stefano]
- Renamed variables to param_data and param_size [Stefano]
- Link to v2: https://lore.kernel.org/qemu-devel/20260904-fix_offset-v2-0-f5bb4cf6d4b0@redhat.com

Changes in v2:
- Inverted commit order: first I introduce the helper and use it where
  necessary, then in commit 2 I handle the `offset`. [Stefano]
- The helper now returns data and size, that already consider the byte
  offset [Stefano]
- Link to v1: https://lore.kernel.org/qemu-devel/20260902-fix_offset-v1-0-04b18f7595b2@redhat.com
---
 backends/igvm.c                | 89 +++++++++++++++++++++++++++++++-----------
 include/system/igvm-internal.h |  5 +++
 target/i386/igvm.c             | 12 +++---
 3 files changed, 77 insertions(+), 29 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 7b7bdc72b7..9a2bafc0ca 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -101,6 +101,38 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
     return NULL;
 }
 
+/*
+ * Get parameter area data at byte_offset with bounds validation.
+ * On success, returns offset-adjusted data pointer and sets param_size
+ * to remaining space.
+ * Returns NULL on failure.
+ */
+uint8_t *
+qigvm_get_param_data(QIgvm *igvm, const IGVM_VHS_PARAMETER *param,
+                     uint32_t *param_size,
+                     Error **errp)
+{
+    QIgvmParameterData *param_entry;
+
+    assert(param_size);
+
+    param_entry = qigvm_find_param_entry(igvm, param->parameter_area_index,
+                                         errp);
+    if (!param_entry) {
+        return NULL;
+    }
+
+    if (param->byte_offset > param_entry->size) {
+        error_setg(errp,
+                   "IGVM: byte_offset 0x%x exceeds parameter area size 0x%x",
+                   param->byte_offset, param_entry->size);
+        return NULL;
+    }
+
+    *param_size = param_entry->size - param->byte_offset;
+    return param_entry->data + param->byte_offset;
+}
+
 static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
                                      Error **errp);
 static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
@@ -605,7 +637,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
     int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
                              Error **errp) = NULL;
-    QIgvmParameterData *param_entry;
+    uint32_t param_size;
     int max_entry_count;
     int entry = 0;
     IGVM_VHS_MEMORY_MAP_ENTRY *mm_entry;
@@ -626,14 +658,14 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     }
 
     /* Find the parameter area that should hold the memory map */
-    param_entry = qigvm_find_param_entry(ctx,
-                                         param->parameter_area_index, errp);
-    if (param_entry == NULL) {
+    mm_entry =
+        (IGVM_VHS_MEMORY_MAP_ENTRY *)qigvm_get_param_data(ctx, param,
+                                                          &param_size, errp);
+    if (!mm_entry) {
         return -1;
     }
 
-    max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
-    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
+    max_entry_count = param_size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
 
     retval = get_mem_map_entry(entry, &cgmm_entry, errp);
     while (retval == 0) {
@@ -682,17 +714,22 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
                                     Error **errp)
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
-    QIgvmParameterData *param_entry;
+    uint32_t param_size;
     uint32_t *vp_count;
     CPUState *cpu;
 
-    param_entry = qigvm_find_param_entry(ctx,
-                                         param->parameter_area_index, errp);
-    if (param_entry == NULL) {
+    vp_count = (uint32_t *)qigvm_get_param_data(ctx, param, &param_size, errp);
+    if (!vp_count) {
+        return -1;
+    }
+
+    if (sizeof(*vp_count) > param_size) {
+        error_setg(errp,
+                   "IGVM: vp-count parameter exceeds parameter area "
+                   "defined in IGVM file");
         return -1;
     }
 
-    vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
     *vp_count = 0;
     CPU_FOREACH(cpu)
     {
@@ -707,17 +744,23 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
                                             Error **errp)
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
-    QIgvmParameterData *param_entry;
+    uint32_t param_size;
     IgvmEnvironmentInfo *environmental_state;
 
-    param_entry = qigvm_find_param_entry(ctx,
-                                         param->parameter_area_index, errp);
-    if (param_entry == NULL) {
+    environmental_state =
+        (IgvmEnvironmentInfo *)qigvm_get_param_data(ctx, param, &param_size,
+                                                    errp);
+    if (!environmental_state) {
+        return -1;
+    }
+
+    if (sizeof(*environmental_state) > param_size) {
+        error_setg(errp,
+                   "IGVM: environment-info parameter exceeds parameter area "
+                   "defined in IGVM file");
         return -1;
     }
 
-    environmental_state =
-        (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
     environmental_state->memory_is_shared = 1;
 
     return 0;
@@ -814,12 +857,12 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
     g_autofree void *fdt_packed = NULL;
-    QIgvmParameterData *param_entry;
+    uint8_t *param_data;
+    uint32_t param_size;
     uint32_t fdt_size;
 
-    param_entry = qigvm_find_param_entry(ctx,
-                                         param->parameter_area_index, errp);
-    if (param_entry == NULL) {
+    param_data = qigvm_get_param_data(ctx, param, &param_size, errp);
+    if (!param_data) {
         return -1;
     }
 
@@ -837,14 +880,14 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
     }
 
     fdt_size = fdt_totalsize(fdt_packed);
-    if (fdt_size > param_entry->size) {
+    if (fdt_size > param_size) {
         error_setg(errp,
                    "IGVM: device tree size exceeds parameter area"
                    " defined in IGVM file");
         return -1;
     }
 
-    memcpy(param_entry->data, fdt_packed, fdt_size);
+    memcpy(param_data, fdt_packed, fdt_size);
 
     return 0;
 }
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 9e9fa1d9af..0467eff0ce 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -81,4 +81,9 @@ QIgvmParameterData*
 qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
                        Error **errp);
 
+uint8_t *
+qigvm_get_param_data(QIgvm *igvm, const IGVM_VHS_PARAMETER *param,
+                     uint32_t *param_size,
+                     Error **errp);
+
 #endif
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index ad9bf87761..9c2f8d5164 100644
--- a/target/i386/igvm.c
+++ b/target/i386/igvm.c
@@ -187,20 +187,20 @@ void qigvm_x86_bsp_reset(CPUX86State *env)
 int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
-    QIgvmParameterData *param_entry;
+    uint8_t *param_data;
+    uint32_t param_size;
     int result = 0;
 
     /* Find the parameter area that should hold the MADT data */
-    param_entry = qigvm_find_param_entry(ctx,
-                                         param->parameter_area_index, errp);
-    if (param_entry == NULL) {
+    param_data = qigvm_get_param_data(ctx, param, &param_size, errp);
+    if (!param_data) {
         return -1;
     }
 
     GArray *madt = acpi_build_madt_standalone(ctx->machine_state);
 
-    if (madt->len <= param_entry->size) {
-        memcpy(param_entry->data, madt->data, madt->len);
+    if (madt->len <= param_size) {
+        memcpy(param_data, madt->data, madt->len);
     } else {
         error_setg(
             errp,

---
base-commit: 5f664cd37aec17e8145aa117d8da68f507edc8f1
change-id: 20260902-fix_offset-a268cb12aafc

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


