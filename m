Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66CFCA5FA1
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmRh-00069q-Br; Sun, 27 Sep 2026 06:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRH-0005xF-Th; Sun, 27 Sep 2026 06:49:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRF-000110-Qy; Sun, 27 Sep 2026 06:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506130; bh=AsGG4zrN1D4UK3Kz30kRFhte+WrE92dWm9BD9W6Ta+w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bRGvNWQGjsrnDNLXwglti4n06IB+7oaDlplK7lRMm3LHhOexbXlyKfgZIKdn8zxB1
 OpBmhc5VytJzRtH8K8eVUDXGGB5lRCcVjLjC6iTLo4RmufspN9tXrnzx/P7iXBa/Sm
 lf55jDVDXemZRBBOZQOAO1sqX73dkCPhA6c5fiP5jymZrGMbMMsMqk/e4aiE6S4GFx
 vhLR97/R6LpsNjpvTNrg2+8/OXWHegbrGg9v6Fu+UbBA7DdEXGKRixEI1w8xpkQgEL
 4Q0XKvkh9rlhT4c0tOe7dHrywN7aYzMiHXY1SjyWaoqaVJ6IRXqC59X0Qmt9tkV4Ri
 scOHXE8EQLVJQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6F3EC1D8B5B;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6C1B2432162;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4CBE15E76E; Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Luigi Leonardi <leonardi@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 60/92] igvm: validate and honor byte_offset in
 parameter directives
Date: Sun, 27 Sep 2026 13:47:36 +0300
Message-ID: <20260927104821.196183-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Parameter directive handlers either ignore param->byte_offset,
overwriting each other when several parameters share one area, or use
it without validating it, letting a malformed IGVM file corrupt QEMU's
memory.

Add qigvm_get_param_data(), which validates byte_offset against the
parameter area size and returns the offset-adjusted pointer together
with the space left after it. Convert all parameter directive handlers
to use it and to check their writes against that remaining space, so
that no parameter can be written past the end of its area.

Fixes: c1d466d267 ("backends/igvm: Add IGVM loader and configuration")
Fixes: dea1f68a5c ("igvm: Fill MADT IGVM parameter field on x86_64")
Fixes: 1c4bd8f13c ("igvm: add device tree parameter support")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20260916-fix_offset-v5-1-11cf8ef37854@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit d9275e776e95ca04bd47bdf519cf1b1d9101b0ce)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/backends/igvm.c b/backends/igvm.c
index 80e87fe6029..9c610578587 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -100,6 +100,38 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
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
@@ -595,7 +627,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
     int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
                              Error **errp) = NULL;
-    QIgvmParameterData *param_entry;
+    uint32_t param_size;
     int max_entry_count;
     int entry = 0;
     IGVM_VHS_MEMORY_MAP_ENTRY *mm_entry;
@@ -616,14 +648,14 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
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
@@ -672,17 +704,22 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
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
@@ -697,17 +734,23 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
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
@@ -804,12 +847,12 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
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
 
@@ -827,14 +870,14 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
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
index 7eb3792ed8c..1330ea3f6e0 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -75,4 +75,9 @@ QIgvmParameterData*
 qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
                        Error **errp);
 
+uint8_t *
+qigvm_get_param_data(QIgvm *igvm, const IGVM_VHS_PARAMETER *param,
+                     uint32_t *param_size,
+                     Error **errp);
+
 #endif
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index ad9bf87761f..9c2f8d51649 100644
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
-- 
2.47.3


