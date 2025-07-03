Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDE3C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNpV-0006vv-VH; Thu, 03 Jul 2025 13:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpC-0006H3-G5
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:20 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNp9-0008Tm-Oy
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:18 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so39333f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564053; x=1752168853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeBsFGHXLsHGotNyus5vOaCkT/NMYUV/oKT335Y1mlE=;
 b=WUU8WDqCuyDe6tWYezIii5rp9k3SgnN0gDrp33vVe+U5P5RY8nkzUUjeKEb7I/+HYm
 NuvRjFWgbQJe88gNyhrg6LhNijHwopJNXvh+j2Oavix7C6vW0SW7fxAXoxMkKzujNqyU
 xSQrfrcuVp+Jba3rVz4PkxJ/B2xnjE7lqeUW/mJqvhYXIuZhRfw5eUoH+dUTEB0J515+
 ORljNP9tfHwTG5UBLX2BA18Cfw1a5ZnWEDt3Hwg49LpE4b7hsnXsGsJsZBEFPEpVtE0r
 ekcCBhRiHyNFUAahpsbfGUkCJdukianK+39vVXM3mbmY2iwuv8luLCsc0xsrGX0UM4Za
 ZAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564053; x=1752168853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KeBsFGHXLsHGotNyus5vOaCkT/NMYUV/oKT335Y1mlE=;
 b=adMQpTrRIMVVwVtm3uP1hTOr5NXScROdb+OXeagZs/YvkTqGHxMbRmZDd0/MxcTgkz
 1E2T4d1CGOiTGeRhVWhfm0Ob7Gn5MMEYgSUZLK0oVSHFHN4NqSD1pyaoR87qWr4xfixh
 WToI83XFAdDL50Jw6T4Vgz7efjJIbdeBl3VvY2Xw8FMxEcueXPxGd9ZwZZwFEBz5xzeN
 wahUbarYUxz3fZ4XIx6YWSblyihJnpjKX2CNd5TTo4gCckBIo0S3Fc83GnA5+wY9OKJU
 w8E6Sco7lcToSHw/Q1wNLomKd8KP3apTPlS7piPSdkbP8X1jjhhbXFPw7oiHaaKHIGri
 jX/A==
X-Gm-Message-State: AOJu0YxtZIGchfMApV5rSm70ysW3axGa9MF/ikYgiC/18bAj21+RplQG
 yh2ih/oiPD0uxFieW9sqCXtDfPIuUcclUdGtnf1fZ+U8qHNvXxgWgSlnePM0oIZ8SA0VVL+T0Ix
 WBT1A7oQ=
X-Gm-Gg: ASbGncu6wlsb+7mzgXSq3LPC+X3WzoawsAsQE7QBuaxvz5S7Vny3OObuCvETs6Q8zQc
 mtyujI8q1Mm4xPEDjh7nX+lW9yez8kqU16c207ol9Tj0hgL+6PNHhY45xIM/lASTgk4gjz5/c9p
 V+hBx65hdwBeWnNZW3/UAELGgBaWLMS3pa65ziDgiZV442nQBKh48qkPbsMF16ULo7j/EFY8ZYK
 T6qAg4U0wIVzkXuPThTpkFbevXNJxavSCJNvyornFZk8inLAIjlF7HC3mOKSWgFyv9I8dnqWUBD
 Qq3P+VwQdFBwezD5tBTHmy7zZ5xt1MDLuog6u1OliRMW8Cs0jf8AQwN8EFamliJsyL9Ey+S8/8H
 u2ebKWiRNPHf0raX2JtglYnCJ1vg981v32E9Y
X-Google-Smtp-Source: AGHT+IFE7cdiXsgzzl9P+XQ68AH0An71MoAYAUIF7Nz7q8bNviRLxvd3HIRsIH44uKNhQ3XxG4/CGA==
X-Received: by 2002:a05:6000:26c2:b0:3a4:f6c4:355a with SMTP id
 ffacd0b85a97d-3b201d8e2fdmr6773317f8f.57.1751564052761; 
 Thu, 03 Jul 2025 10:34:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcebf7sm33289065e9.21.2025.07.03.10.34.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:34:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v6 16/39] accel/hvf: Move generic method declarations to
 hvf-all.c
Date: Thu,  3 Jul 2025 19:32:22 +0200
Message-ID: <20250703173248.44995-17-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

hvf-all.c aims to contain the generic accel methods (TYPE_ACCEL),
while hvf-accel-ops.c the per-vcpu methods (TYPE_ACCEL_OPS).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 274 +-------------------------------------
 accel/hvf/hvf-all.c       | 268 +++++++++++++++++++++++++++++++++++++
 2 files changed, 272 insertions(+), 270 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 646cd240238..6b1a256deb5 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -48,20 +48,16 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/error-report.h"
+#include "qemu/guest-random.h"
 #include "qemu/main-loop.h"
 #include "qemu/queue.h"
-#include "system/address-spaces.h"
 #include "gdbstub/enums.h"
-#include "hw/boards.h"
+#include "exec/cpu-common.h"
 #include "hw/core/cpu.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
-#include "system/runstate.h"
-#include "qemu/guest-random.h"
-#include "trace.h"
 
 HVFState *hvf_state;
 
@@ -81,132 +77,6 @@ hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
     return NULL;
 }
 
-struct mac_slot {
-    int present;
-    uint64_t size;
-    uint64_t gpa_start;
-    uint64_t gva;
-};
-
-struct mac_slot mac_slots[32];
-
-static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
-{
-    struct mac_slot *macslot;
-    hv_return_t ret;
-
-    macslot = &mac_slots[slot->slot_id];
-
-    if (macslot->present) {
-        if (macslot->size != slot->size) {
-            macslot->present = 0;
-            trace_hvf_vm_unmap(macslot->gpa_start, macslot->size);
-            ret = hv_vm_unmap(macslot->gpa_start, macslot->size);
-            assert_hvf_ok(ret);
-        }
-    }
-
-    if (!slot->size) {
-        return 0;
-    }
-
-    macslot->present = 1;
-    macslot->gpa_start = slot->start;
-    macslot->size = slot->size;
-    trace_hvf_vm_map(slot->start, slot->size, slot->mem, flags,
-                     flags & HV_MEMORY_READ ?  'R' : '-',
-                     flags & HV_MEMORY_WRITE ? 'W' : '-',
-                     flags & HV_MEMORY_EXEC ?  'E' : '-');
-    ret = hv_vm_map(slot->mem, slot->start, slot->size, flags);
-    assert_hvf_ok(ret);
-    return 0;
-}
-
-static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
-{
-    hvf_slot *mem;
-    MemoryRegion *area = section->mr;
-    bool writable = !area->readonly && !area->rom_device;
-    hv_memory_flags_t flags;
-    uint64_t page_size = qemu_real_host_page_size();
-
-    if (!memory_region_is_ram(area)) {
-        if (writable) {
-            return;
-        } else if (!memory_region_is_romd(area)) {
-            /*
-             * If the memory device is not in romd_mode, then we actually want
-             * to remove the hvf memory slot so all accesses will trap.
-             */
-             add = false;
-        }
-    }
-
-    if (!QEMU_IS_ALIGNED(int128_get64(section->size), page_size) ||
-        !QEMU_IS_ALIGNED(section->offset_within_address_space, page_size)) {
-        /* Not page aligned, so we can not map as RAM */
-        add = false;
-    }
-
-    mem = hvf_find_overlap_slot(
-            section->offset_within_address_space,
-            int128_get64(section->size));
-
-    if (mem && add) {
-        if (mem->size == int128_get64(section->size) &&
-            mem->start == section->offset_within_address_space &&
-            mem->mem == (memory_region_get_ram_ptr(area) +
-            section->offset_within_region)) {
-            return; /* Same region was attempted to register, go away. */
-        }
-    }
-
-    /* Region needs to be reset. set the size to 0 and remap it. */
-    if (mem) {
-        mem->size = 0;
-        if (do_hvf_set_memory(mem, 0)) {
-            error_report("Failed to reset overlapping slot");
-            abort();
-        }
-    }
-
-    if (!add) {
-        return;
-    }
-
-    if (area->readonly ||
-        (!memory_region_is_ram(area) && memory_region_is_romd(area))) {
-        flags = HV_MEMORY_READ | HV_MEMORY_EXEC;
-    } else {
-        flags = HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC;
-    }
-
-    /* Now make a new slot. */
-    int x;
-
-    for (x = 0; x < hvf_state->num_slots; ++x) {
-        mem = &hvf_state->slots[x];
-        if (!mem->size) {
-            break;
-        }
-    }
-
-    if (x == hvf_state->num_slots) {
-        error_report("No free slots");
-        abort();
-    }
-
-    mem->size = int128_get64(section->size);
-    mem->mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
-    mem->start = section->offset_within_address_space;
-    mem->region = area;
-
-    if (do_hvf_set_memory(mem, flags)) {
-        error_report("Error registering new memory slot");
-        abort();
-    }
-}
-
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->accel->dirty) {
@@ -244,148 +114,10 @@ static void hvf_cpu_synchronize_pre_loadvm(CPUState *cpu)
     run_on_cpu(cpu, do_hvf_cpu_synchronize_set_dirty, RUN_ON_CPU_NULL);
 }
 
-static void hvf_set_dirty_tracking(MemoryRegionSection *section, bool on)
-{
-    hvf_slot *slot;
-
-    slot = hvf_find_overlap_slot(
-            section->offset_within_address_space,
-            int128_get64(section->size));
-
-    /* protect region against writes; begin tracking it */
-    if (on) {
-        slot->flags |= HVF_SLOT_LOG;
-        hv_vm_protect((uintptr_t)slot->start, (size_t)slot->size,
-                      HV_MEMORY_READ | HV_MEMORY_EXEC);
-    /* stop tracking region*/
-    } else {
-        slot->flags &= ~HVF_SLOT_LOG;
-        hv_vm_protect((uintptr_t)slot->start, (size_t)slot->size,
-                      HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
-    }
-}
-
-static void hvf_log_start(MemoryListener *listener,
-                          MemoryRegionSection *section, int old, int new)
-{
-    if (old != 0) {
-        return;
-    }
-
-    hvf_set_dirty_tracking(section, 1);
-}
-
-static void hvf_log_stop(MemoryListener *listener,
-                         MemoryRegionSection *section, int old, int new)
-{
-    if (new != 0) {
-        return;
-    }
-
-    hvf_set_dirty_tracking(section, 0);
-}
-
-static void hvf_log_sync(MemoryListener *listener,
-                         MemoryRegionSection *section)
-{
-    /*
-     * sync of dirty pages is handled elsewhere; just make sure we keep
-     * tracking the region.
-     */
-    hvf_set_dirty_tracking(section, 1);
-}
-
-static void hvf_region_add(MemoryListener *listener,
-                           MemoryRegionSection *section)
-{
-    hvf_set_phys_mem(section, true);
-}
-
-static void hvf_region_del(MemoryListener *listener,
-                           MemoryRegionSection *section)
-{
-    hvf_set_phys_mem(section, false);
-}
-
-static MemoryListener hvf_memory_listener = {
-    .name = "hvf",
-    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
-    .region_add = hvf_region_add,
-    .region_del = hvf_region_del,
-    .log_start = hvf_log_start,
-    .log_stop = hvf_log_stop,
-    .log_sync = hvf_log_sync,
-};
-
 static void dummy_signal(int sig)
 {
 }
 
-bool hvf_allowed;
-
-static int hvf_accel_init(MachineState *ms)
-{
-    int x;
-    hv_return_t ret;
-    HVFState *s;
-    int pa_range = 36;
-    MachineClass *mc = MACHINE_GET_CLASS(ms);
-
-    if (mc->hvf_get_physical_address_range) {
-        pa_range = mc->hvf_get_physical_address_range(ms);
-        if (pa_range < 0) {
-            return -EINVAL;
-        }
-    }
-
-    ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
-    assert_hvf_ok(ret);
-
-    s = g_new0(HVFState, 1);
-
-    s->num_slots = ARRAY_SIZE(s->slots);
-    for (x = 0; x < s->num_slots; ++x) {
-        s->slots[x].size = 0;
-        s->slots[x].slot_id = x;
-    }
-
-    QTAILQ_INIT(&s->hvf_sw_breakpoints);
-
-    hvf_state = s;
-    memory_listener_register(&hvf_memory_listener, &address_space_memory);
-
-    return hvf_arch_init();
-}
-
-static inline int hvf_gdbstub_sstep_flags(void)
-{
-    return SSTEP_ENABLE | SSTEP_NOIRQ;
-}
-
-static void hvf_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelClass *ac = ACCEL_CLASS(oc);
-    ac->name = "HVF";
-    ac->init_machine = hvf_accel_init;
-    ac->allowed = &hvf_allowed;
-    ac->supports_guest_debug = hvf_arch_supports_guest_debug;
-    ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
-}
-
-static const TypeInfo hvf_accel_type = {
-    .name = TYPE_HVF_ACCEL,
-    .parent = TYPE_ACCEL,
-    .instance_size = sizeof(HVFState),
-    .class_init = hvf_accel_class_init,
-};
-
-static void hvf_type_init(void)
-{
-    type_register_static(&hvf_accel_type);
-}
-
-type_init(hvf_type_init);
-
 static void hvf_vcpu_destroy(CPUState *cpu)
 {
     hv_return_t ret = hv_vcpu_destroy(cpu->accel->fd);
@@ -639,8 +371,10 @@ static const TypeInfo hvf_accel_ops_type = {
     .class_init = hvf_accel_ops_class_init,
     .abstract = true,
 };
+
 static void hvf_accel_ops_register_types(void)
 {
     type_register_static(&hvf_accel_ops_type);
 }
+
 type_init(hvf_accel_ops_register_types);
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 1c72c43ddb4..897a02eebe2 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -10,9 +10,24 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
 #include "hw/core/cpu.h"
+#include "hw/boards.h"
+#include "trace.h"
+
+bool hvf_allowed;
+
+struct mac_slot {
+    int present;
+    uint64_t size;
+    uint64_t gpa_start;
+    uint64_t gva;
+};
+
+struct mac_slot mac_slots[32];
 
 const char *hvf_return_string(hv_return_t ret)
 {
@@ -41,3 +56,256 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 
     abort();
 }
+
+static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
+{
+    struct mac_slot *macslot;
+    hv_return_t ret;
+
+    macslot = &mac_slots[slot->slot_id];
+
+    if (macslot->present) {
+        if (macslot->size != slot->size) {
+            macslot->present = 0;
+            trace_hvf_vm_unmap(macslot->gpa_start, macslot->size);
+            ret = hv_vm_unmap(macslot->gpa_start, macslot->size);
+            assert_hvf_ok(ret);
+        }
+    }
+
+    if (!slot->size) {
+        return 0;
+    }
+
+    macslot->present = 1;
+    macslot->gpa_start = slot->start;
+    macslot->size = slot->size;
+    trace_hvf_vm_map(slot->start, slot->size, slot->mem, flags,
+                     flags & HV_MEMORY_READ ?  'R' : '-',
+                     flags & HV_MEMORY_WRITE ? 'W' : '-',
+                     flags & HV_MEMORY_EXEC ?  'E' : '-');
+    ret = hv_vm_map(slot->mem, slot->start, slot->size, flags);
+    assert_hvf_ok(ret);
+    return 0;
+}
+
+static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
+{
+    hvf_slot *mem;
+    MemoryRegion *area = section->mr;
+    bool writable = !area->readonly && !area->rom_device;
+    hv_memory_flags_t flags;
+    uint64_t page_size = qemu_real_host_page_size();
+
+    if (!memory_region_is_ram(area)) {
+        if (writable) {
+            return;
+        } else if (!memory_region_is_romd(area)) {
+            /*
+             * If the memory device is not in romd_mode, then we actually want
+             * to remove the hvf memory slot so all accesses will trap.
+             */
+             add = false;
+        }
+    }
+
+    if (!QEMU_IS_ALIGNED(int128_get64(section->size), page_size) ||
+        !QEMU_IS_ALIGNED(section->offset_within_address_space, page_size)) {
+        /* Not page aligned, so we can not map as RAM */
+        add = false;
+    }
+
+    mem = hvf_find_overlap_slot(
+            section->offset_within_address_space,
+            int128_get64(section->size));
+
+    if (mem && add) {
+        if (mem->size == int128_get64(section->size) &&
+            mem->start == section->offset_within_address_space &&
+            mem->mem == (memory_region_get_ram_ptr(area) +
+            section->offset_within_region)) {
+            return; /* Same region was attempted to register, go away. */
+        }
+    }
+
+    /* Region needs to be reset. set the size to 0 and remap it. */
+    if (mem) {
+        mem->size = 0;
+        if (do_hvf_set_memory(mem, 0)) {
+            error_report("Failed to reset overlapping slot");
+            abort();
+        }
+    }
+
+    if (!add) {
+        return;
+    }
+
+    if (area->readonly ||
+        (!memory_region_is_ram(area) && memory_region_is_romd(area))) {
+        flags = HV_MEMORY_READ | HV_MEMORY_EXEC;
+    } else {
+        flags = HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC;
+    }
+
+    /* Now make a new slot. */
+    int x;
+
+    for (x = 0; x < hvf_state->num_slots; ++x) {
+        mem = &hvf_state->slots[x];
+        if (!mem->size) {
+            break;
+        }
+    }
+
+    if (x == hvf_state->num_slots) {
+        error_report("No free slots");
+        abort();
+    }
+
+    mem->size = int128_get64(section->size);
+    mem->mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
+    mem->start = section->offset_within_address_space;
+    mem->region = area;
+
+    if (do_hvf_set_memory(mem, flags)) {
+        error_report("Error registering new memory slot");
+        abort();
+    }
+}
+
+static void hvf_set_dirty_tracking(MemoryRegionSection *section, bool on)
+{
+    hvf_slot *slot;
+
+    slot = hvf_find_overlap_slot(
+            section->offset_within_address_space,
+            int128_get64(section->size));
+
+    /* protect region against writes; begin tracking it */
+    if (on) {
+        slot->flags |= HVF_SLOT_LOG;
+        hv_vm_protect((uintptr_t)slot->start, (size_t)slot->size,
+                      HV_MEMORY_READ | HV_MEMORY_EXEC);
+    /* stop tracking region*/
+    } else {
+        slot->flags &= ~HVF_SLOT_LOG;
+        hv_vm_protect((uintptr_t)slot->start, (size_t)slot->size,
+                      HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
+    }
+}
+
+static void hvf_log_start(MemoryListener *listener,
+                          MemoryRegionSection *section, int old, int new)
+{
+    if (old != 0) {
+        return;
+    }
+
+    hvf_set_dirty_tracking(section, 1);
+}
+
+static void hvf_log_stop(MemoryListener *listener,
+                         MemoryRegionSection *section, int old, int new)
+{
+    if (new != 0) {
+        return;
+    }
+
+    hvf_set_dirty_tracking(section, 0);
+}
+
+static void hvf_log_sync(MemoryListener *listener,
+                         MemoryRegionSection *section)
+{
+    /*
+     * sync of dirty pages is handled elsewhere; just make sure we keep
+     * tracking the region.
+     */
+    hvf_set_dirty_tracking(section, 1);
+}
+
+static void hvf_region_add(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    hvf_set_phys_mem(section, true);
+}
+
+static void hvf_region_del(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    hvf_set_phys_mem(section, false);
+}
+
+static MemoryListener hvf_memory_listener = {
+    .name = "hvf",
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
+    .region_add = hvf_region_add,
+    .region_del = hvf_region_del,
+    .log_start = hvf_log_start,
+    .log_stop = hvf_log_stop,
+    .log_sync = hvf_log_sync,
+};
+
+static int hvf_accel_init(MachineState *ms)
+{
+    int x;
+    hv_return_t ret;
+    HVFState *s;
+    int pa_range = 36;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
+    if (mc->hvf_get_physical_address_range) {
+        pa_range = mc->hvf_get_physical_address_range(ms);
+        if (pa_range < 0) {
+            return -EINVAL;
+        }
+    }
+
+    ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
+    assert_hvf_ok(ret);
+
+    s = g_new0(HVFState, 1);
+
+    s->num_slots = ARRAY_SIZE(s->slots);
+    for (x = 0; x < s->num_slots; ++x) {
+        s->slots[x].size = 0;
+        s->slots[x].slot_id = x;
+    }
+
+    QTAILQ_INIT(&s->hvf_sw_breakpoints);
+
+    hvf_state = s;
+    memory_listener_register(&hvf_memory_listener, &address_space_memory);
+
+    return hvf_arch_init();
+}
+
+static int hvf_gdbstub_sstep_flags(void)
+{
+    return SSTEP_ENABLE | SSTEP_NOIRQ;
+}
+
+static void hvf_accel_class_init(ObjectClass *oc, const void *data)
+{
+    AccelClass *ac = ACCEL_CLASS(oc);
+    ac->name = "HVF";
+    ac->init_machine = hvf_accel_init;
+    ac->allowed = &hvf_allowed;
+    ac->supports_guest_debug = hvf_arch_supports_guest_debug;
+    ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
+}
+
+static const TypeInfo hvf_accel_type = {
+    .name = TYPE_HVF_ACCEL,
+    .parent = TYPE_ACCEL,
+    .instance_size = sizeof(HVFState),
+    .class_init = hvf_accel_class_init,
+};
+
+static void hvf_type_init(void)
+{
+    type_register_static(&hvf_accel_type);
+}
+
+type_init(hvf_type_init);
-- 
2.49.0


