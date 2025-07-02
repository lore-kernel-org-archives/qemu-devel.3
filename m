Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09905C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2eK-0000mD-9a; Wed, 02 Jul 2025 14:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2eE-0000Rf-SW
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2e6-0002dy-Tz
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4539cd7990cso1356265e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482643; x=1752087443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=coUKaKf6dZIxfVeFUFnOi2/CaQ9UIB137B6rtgj9MwA=;
 b=cmDCdRaR3/x2kRvruGd86hOJwBDqEl2tH5zyErOFahp9y3EGgP5tUokTV2YI6Ta3w2
 ygX9iXkxY8cM+uH6iHGEu1LRu1AE9Io+MOEs8IeJriGVXDEHKKYkEqG2APmp1LdrLWtC
 jbSj+Z4PmPwgHdgCRxHZeojRA7pS9xfBlzkBNOLrjGXq3RwMSzjQMJolMVzqI+zqRKqj
 D6tfu7EnWyjsdVtFssxJfqY+j3P741hNUZNfY3e+/uaLKn028qIo9WeJdoxcw2Quo36F
 GaXD2ssz8pRCdvaoDIxr2LAz2UWbynazW505u7ezw+kCS10m7Pk+MAgRwCQJuWGzvia/
 34QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482643; x=1752087443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=coUKaKf6dZIxfVeFUFnOi2/CaQ9UIB137B6rtgj9MwA=;
 b=OUr0bdoMd/olrpx/vG4pjEoAxM1M3roarREtox4GPcL/DnfplZv+0Lvi201ShYITwo
 5Oh5C6fKzcglRcn0GnQPygrLloo4HhXXr8AqW+eRHesFbLyxTeqppRTnhf8/1mFCL2dD
 tc8fAkkOKUrlZs1T8bTa/EwwzmiTWtV5KBi8+/BpxrFRzU3EYw7AJ1JwO/zeyliwqfuf
 iECS1uWZZq0txWgm6uYmMvRl6ERfuBwTtL+c/yozliUU/DbBqy+n2SnIWT8qJjZUqaAZ
 KRXS58MTFnjJGLIAMdIfgliI1Drc8iYwKqeD7ViXO3acxHqx2rauWku50dGROBurpd9K
 p/3A==
X-Gm-Message-State: AOJu0Yx6gsdHnocvtvQGzNZJmqsWKAGg/bqnyzw7s9r4HtwkIHaIIMl1
 cSSY8+PVxvlLlfgnMTbZy1oGcY4Zee0EGwky9xmB4vqHz5XWDy9iPJvj67FEAL9UIGWAyDWfBOT
 Co5vU
X-Gm-Gg: ASbGncvlFBNditsGuFMMTjxYgHKl8/FTBqwOfJR+yryVky65MLCy8zkqxLOTBz0Pr+1
 xZhr0QlEfpxkH6XUGLMgnrYvVdjvgkEc6Ig+BQqndBVIXyZ2Q/Z8ihVGHEafhHl3mYNflgkfTnI
 7LUAWembNWFVBLDzV1HhHW/s22aIZgWwjtSAnv9nP7NtvN1DryVl7wFNPoULPSW42nQhFsCkBLj
 nZHmQ5boU5wKGTpZ7u2MXs186NWxVPukwKSutjBix+Z7PGNtYeRN8aN+NxW1huXyHFLSGFxg4bN
 0I04N0tMBJKLz1X9jne0NQdeytHwNYFg3ZqJ85LanDR8L2Y7GVjpcbWfUzvyaWPvbL1oz4mO2kN
 IxybIe87BmoodiXGHnsOovOJgsHsaiDNi/vCK
X-Google-Smtp-Source: AGHT+IHIKX5OmA/KwNdN2EdkVK0D88nimPTw3HFPaO6C1JBTH8vp4OsjITVu1EX9pdcs/gBimxxWRg==
X-Received: by 2002:a05:600c:c058:b0:43c:f3e1:a729 with SMTP id
 5b1f17b1804b1-454ab350a0cmr56905e9.12.1751482642837; 
 Wed, 02 Jul 2025 11:57:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997b492sm5775395e9.13.2025.07.02.11.57.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:57:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v4 31/65] accel/hvf: Move generic method declarations to
 hvf-all.c
Date: Wed,  2 Jul 2025 20:52:53 +0200
Message-ID: <20250702185332.43650-32-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
 accel/hvf/hvf-accel-ops.c | 278 +-------------------------------------
 accel/hvf/hvf-all.c       | 272 +++++++++++++++++++++++++++++++++++++
 2 files changed, 277 insertions(+), 273 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index be044b9ceaa..319c30f703c 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -48,19 +48,16 @@
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
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
-#include "system/runstate.h"
-#include "qemu/guest-random.h"
-#include "trace.h"
+#include "hw/core/cpu.h"
 
 HVFState *hvf_state;
 
@@ -80,132 +77,6 @@ hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
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
@@ -243,157 +114,16 @@ static void hvf_cpu_synchronize_pre_loadvm(CPUState *cpu)
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
-static int hvf_accel_init(AccelState *as, MachineState *ms)
-{
-    int x;
-    hv_return_t ret;
-    HVFState *s = HVF_STATE(as);
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
-    if (ret == HV_DENIED) {
-        error_report("Could not access HVF. Is the executable signed"
-                     " with com.apple.security.hypervisor entitlement?");
-        exit(1);
-    }
-    assert_hvf_ok(ret);
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
-static inline int hvf_gdbstub_sstep_flags(AccelState *as)
-{
-    return SSTEP_ENABLE | SSTEP_NOIRQ;
-}
-
 static void do_hvf_get_vcpu_exec_time(CPUState *cpu, run_on_cpu_data arg)
 {
     int r = hv_vcpu_get_exec_time(cpu->accel->fd, arg.host_ptr);
     assert_hvf_ok(r);
 }
 
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
@@ -662,8 +392,10 @@ static const TypeInfo hvf_accel_ops_type = {
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
index 481d7dece57..f498e32a23f 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -10,8 +10,24 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
+#include "hw/core/cpu.h"
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
@@ -40,3 +56,259 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 
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
+static int hvf_accel_init(AccelState *as, MachineState *ms)
+{
+    int x;
+    hv_return_t ret;
+    HVFState *s = HVF_STATE(as);
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
+    if (ret == HV_DENIED) {
+        error_report("Could not access HVF. Is the executable signed"
+                     " with com.apple.security.hypervisor entitlement?");
+        exit(1);
+    }
+    assert_hvf_ok(ret);
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
+static inline int hvf_gdbstub_sstep_flags(AccelState *as)
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


