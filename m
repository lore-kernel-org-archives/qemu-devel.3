Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84795C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rHJ-0004mg-EN; Wed, 16 Sep 2026 11:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x6rHC-0004lr-To
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:10:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x6rH6-0004Gc-Ra
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789571415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PIT3TyieWx42Sg74YtgUs+uuEvQmhcL3DRQI3EBPTcA=;
 b=TvDG9FfYscjhQmEVy8tsiKuRge9/gN9i7yih0YHJFyte/010hGSMADAapsqn/jVUGBVCKV
 +ckizGbTEXbK7RjqwqGDjricpQtYHUSRivUUxP63I0JnbvxW9rN+i/orZdzZeGCK85KCCU
 6ywEngqqOHMVZ6+97MdYezv6D42CeJM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-wU81QP8lOyqPTKdPCEmz0g-1; Wed, 16 Sep 2026 11:10:13 -0400
X-MC-Unique: wU81QP8lOyqPTKdPCEmz0g-1
X-Mimecast-MFC-AGG-ID: wU81QP8lOyqPTKdPCEmz0g_1789571412
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cf4cc2125so25134085e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789571412; x=1790176212; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PIT3TyieWx42Sg74YtgUs+uuEvQmhcL3DRQI3EBPTcA=;
 b=VZ8vDp5k84Z3IWc9uMkkRfGw9pTFUaBOf2iJxce6JNS+Zo0E0vfoAXetDKCzg74cRF
 zzdLCIIh53u9AEEYNFRiii3VK/i2cSP6XrHgCvJCMwmni/BYweduylHZutng1OlhEfXc
 VtSg95qhE97GB+Waw6lXv28bvJ8YeUtKnl531B98kvxvxL14fQaEcQ1BSHNfflmE6zI7
 co6u4pyY1EGeOHq7XjERUzSMijdAhapyVz92XL43O3Y59ImT4k2EMDqTq7IJO7QdYjFm
 hSaDKri6WHS+gNiW7T7QN4+2dgRGIA3xJC6RppCABG3FNzVNTPHXNGs8JnVuYvqF7YVW
 cllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789571412; x=1790176212;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PIT3TyieWx42Sg74YtgUs+uuEvQmhcL3DRQI3EBPTcA=;
 b=QL8glLOC0q2nOc+CVot0IiwEIMZ/zJJwD4NSWrYAH7LUsJtnooWNENNzvC+d/mzNWf
 fRpiTJurpEErv8+RTsUnCqxuchwdMLs1sxPbB6yxXlITg/iZXtsAPoOravMoNpb2YsEM
 5xprL2Ny00gR/JawG0K15r+2pKl778oAO8vn7E3vpO0x7UkT26kwo54RV4Z1HMAmpLLo
 k8VolPlMbJjaIxp39esfBpT/N2m0A/2AnqoBfhe8r+vkNAAqUtXZN0fRqaZqpnUE8aQk
 UjMC0OZ9JMyvlpOSBtBit/YIvgUQIzhMmvyrfVkE3GsWZqHsr3flRmJflKmWC5bck/zq
 0IbA==
X-Gm-Message-State: AFuF++m+LvnBr1D1tkDoApRTsKGQhMY0qfxdqWJ7bMQt7vylwXyIbUy/
 2AwLGCP4v0ie07M/pFU6jHdzd2xn0CSJfE5RIfXgikf/6LzOi5TniJtvLs9Lp8ToYJrp3uacZ74
 Bfy0sWKZLNmKujzqCnjqiUv3/O8dYGFKu4LT2dAxNSbv3ix/CHz4RmbjSRf6o6oCBo3oxsGS663
 J5PW9ueev49QOIzRpDuO+h3pGervgNsB20uHVA/RzrUcQ=
X-Gm-Gg: AYBFou0FpwlIqtUDJwu50h/TxRoShZ7f9avEr5YFE+TON7gZ7KcoLCZpNm4t5/FzEjI
 tt4IaqQOZh4PoKYhE4oGFTFnqGvm240nSK96dXoBDXDi0UAI9V9qcfbmKAvs2Wo82EykfDCFMSS
 PaNMZFu+MURju/CKpH3J85fB8QtZy2s+526ErPTkCSzKdOl2druuXobNhoXZATMbXGiJljamrW9
 VJgxueD1SFbJmzf3Gxm1XF2qA5aTYdSCpM/JCcqX4gthcEJNN7QJndWv/F8wCHxCFvRngEBJU/R
 v8RcldIlqJRnYTwTGglK0BObLVppFw/msX6qYzuoyD1lSPUu9AgU553mWdWw445p5UdmnDFkDOc
 Pfa4P4RrKyVlgIwtElREETzTiza6ijkREpgiXNhoR5Tg/yOzP76+uweSug3+2JeZ48/Ox
X-Received: by 2002:a05:600c:474a:b0:49c:ee20:e787 with SMTP id
 5b1f17b1804b1-49eac464371mr52820425e9.1.1789571411636; 
 Wed, 16 Sep 2026 08:10:11 -0700 (PDT)
X-Received: by 2002:a05:600c:474a:b0:49c:ee20:e787 with SMTP id
 5b1f17b1804b1-49eac464371mr52819575e9.1.1789571411107; 
 Wed, 16 Sep 2026 08:10:11 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd112455sm40865e9.12.2026.09.16.08.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:10:10 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 16 Sep 2026 17:10:05 +0200
Subject: [PATCH v5 1/2] igvm: validate and honor byte_offset in parameter
 directives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-fix_offset-v5-1-11cf8ef37854@redhat.com>
References: <20260916-fix_offset-v5-0-11cf8ef37854@redhat.com>
In-Reply-To: <20260916-fix_offset-v5-0-11cf8ef37854@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

-- 
2.55.0


