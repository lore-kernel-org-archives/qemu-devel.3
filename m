Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00110C982D1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7CFE-0000bj-QO; Thu, 17 Sep 2026 09:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x7CF2-0000bI-9U
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x7CEx-0003Vv-JR
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789652005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rC0MvOwoBF73sE6fWWaPxdO0f1psZR9mBvPUchKomSM=;
 b=e0IipeQNdIdDN3G3s1B+ak7hPjnxlhBx3z7DO9uxYSqygj15wSW08RvGEEZdYwuDGjaDRB
 XVr5rLCDqN//B+G6+byIY49IkPb1Jgb+qfqbqkSYVw1w0NTj7wuJljJmEIoDVeVJlCe9d5
 VgBrAtiy3o2uU0VO4TEaMiltXJkFv3w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-vV1dLViVM1W1n7BLKwkXgQ-1; Thu,
 17 Sep 2026 09:33:23 -0400
X-MC-Unique: vV1dLViVM1W1n7BLKwkXgQ-1
X-Mimecast-MFC-AGG-ID: vV1dLViVM1W1n7BLKwkXgQ_1789652002
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C2011955BED; Thu, 17 Sep 2026 13:33:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.37])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDA54180035F; Thu, 17 Sep 2026 13:33:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 167E9180063D; Thu, 17 Sep 2026 15:33:19 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 2/5] igvm: validate and honor byte_offset in parameter
 directives
Date: Thu, 17 Sep 2026 15:33:15 +0200
Message-ID: <20260917133318.2004317-3-kraxel@redhat.com>
In-Reply-To: <20260917133318.2004317-1-kraxel@redhat.com>
References: <20260917133318.2004317-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
---
 include/system/igvm-internal.h |  5 ++
 backends/igvm.c                | 93 +++++++++++++++++++++++++---------
 target/i386/igvm.c             | 12 ++---
 3 files changed, 79 insertions(+), 31 deletions(-)

diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 9e9fa1d9afdb..0467eff0ceab 100644
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
diff --git a/backends/igvm.c b/backends/igvm.c
index 7b7bdc72b75b..9a2bafc0cad0 100644
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
-        return -1;
-    }
-
     environmental_state =
-        (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
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
+        return -1;
+    }
+
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
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index ad9bf87761fb..9c2f8d516492 100644
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
2.55.0


