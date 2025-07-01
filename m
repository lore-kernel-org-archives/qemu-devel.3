Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88488C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWepd-000731-3A; Tue, 01 Jul 2025 13:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uWeov-0006TW-Kc
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:31:04 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uWeor-0007Iv-IV
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:31:01 -0400
Received: from localhost.localdomain (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 54D2F211938F;
 Tue,  1 Jul 2025 10:30:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54D2F211938F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751391046;
 bh=LlF/ug667Qtq+1TC8h6j8A9o+o2DhbC1syYUSBOc37c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=duSBAGKAyNTxw3RoZmxCXzaAOamb7dc0cU12IliCC1m6jE3baf+qBa7CnsxbGt2P0
 MzyNImixqtjIOeeoH+VYnMAVh4mtTFvv555qCQpblWQAX0YD5KLR/kDisQ+tygXxlM
 bzx9nrWrLQKIJLZmRukHGXHhWWqA4a0sy/MWHeXI=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 26/27] accel/mshv: Workaround for overlappig mem mappings
Date: Tue,  1 Jul 2025 19:28:33 +0200
Message-Id: <20250701172834.44849-27-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

QEMU maps certain regions into the guest multiple times, as seen in the
trace below. Currently the MSHV kernel driver will reject those
mappings. To workaround this, a record is kept (a static global list of
"slots", inspired by what the HVF accelerator has implemented). An
overlapping region is not registered at the hypervisor, and marked as
mapped=false. If there is an UNMAPPED_GPA exit, we can look for a slot
that is unmapped and would cover the GPA. In this case we map out the
conflicting slot and map in the requested region.

mshv_set_phys_mem       add=1 name=pc.bios
mshv_map_memory      => u_a=7ffff4e00000 gpa=00fffc0000 size=00040000
mshv_set_phys_mem       add=1 name=ioapic
mshv_set_phys_mem       add=1 name=hpet
mshv_set_phys_mem       add=0 name=pc.ram
mshv_unmap_memory       u_a=7fff67e00000 gpa=0000000000 size=80000000
mshv_set_phys_mem       add=1 name=pc.ram
mshv_map_memory         u_a=7fff67e00000 gpa=0000000000 size=000c0000
mshv_set_phys_mem       add=1 name=pc.rom
mshv_map_memory         u_a=7ffff4c00000 gpa=00000c0000 size=00020000
mshv_set_phys_mem       add=1 name=pc.bios
mshv_remap_attempt   => u_a=7ffff4e20000 gpa=00000e0000 size=00020000

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mem.c            | 264 ++++++++++++++++++++++++++++++++----
 accel/mshv/trace-events     |   7 +-
 include/system/mshv.h       |  16 ++-
 target/i386/mshv/mshv-cpu.c |  43 ++++++
 4 files changed, 295 insertions(+), 35 deletions(-)

diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
index 6d7a726898..0ffe379601 100644
--- a/accel/mshv/mem.c
+++ b/accel/mshv/mem.c
@@ -20,44 +20,167 @@
 #include <sys/ioctl.h>
 #include "trace.h"
 
+MshvMemorySlot mem_slots[MSHV_MAX_MEM_SLOTS];
+
+static MshvMemorySlot *find_free_mem_slot(void)
+{
+    for (int i = 0; i < MSHV_MAX_MEM_SLOTS; i++) {
+        if (mem_slots[i].memory_size == 0) {
+            return &mem_slots[i];
+        }
+    }
+
+    return NULL;
+}
+
+/* Find _currently mapped_ memory slot, that is overlapping in userspace */
+static MshvMemorySlot *find_overlap_mem_slot(const MshvMemorySlot *slot)
+{
+    MshvMemorySlot *other;
+    bool overlaps;
+    uint64_t start_1 = slot->userspace_addr, start_2;
+    size_t len_1 = slot->memory_size, len_2;
+
+    for (int i = 0; i < MSHV_MAX_MEM_SLOTS; i++) {
+        other = &mem_slots[i];
+
+        if (other == slot) {
+            continue;
+        }
+
+        start_2 = other->userspace_addr;
+        len_2 = other->memory_size;
+
+        overlaps = ranges_overlap(start_1, len_1, start_2, len_2);
+        if (other->mapped && overlaps) {
+            return other;
+        }
+    }
+
+    return NULL;
+}
+
 static int set_guest_memory(int vm_fd, const mshv_user_mem_region *region)
 {
     int ret;
 
     ret = ioctl(vm_fd, MSHV_SET_GUEST_MEMORY, region);
     if (ret < 0) {
-        error_report("failed to set guest memory");
-        return -errno;
+        error_report("failed to set guest memory: %s", strerror(errno));
+        return -1;
     }
 
     return 0;
 }
 
-static int map_or_unmap(int vm_fd, const MshvMemoryRegion *mr, bool map)
+static int map_or_unmap(int vm_fd, const MshvMemorySlot *slot, bool map)
 {
     struct mshv_user_mem_region region = {0};
 
-    region.guest_pfn = mr->guest_phys_addr >> MSHV_PAGE_SHIFT;
-    region.size = mr->memory_size;
-    region.userspace_addr = mr->userspace_addr;
+    region.guest_pfn = slot->guest_phys_addr >> MSHV_PAGE_SHIFT;
+    region.size = slot->memory_size;
+    region.userspace_addr = slot->userspace_addr;
 
     if (!map) {
         region.flags |= (1 << MSHV_SET_MEM_BIT_UNMAP);
-        trace_mshv_unmap_memory(mr->userspace_addr, mr->guest_phys_addr,
-                                mr->memory_size);
+        trace_mshv_unmap_memory(slot->userspace_addr, slot->guest_phys_addr,
+                                slot->memory_size);
         return set_guest_memory(vm_fd, &region);
     }
 
     region.flags = BIT(MSHV_SET_MEM_BIT_EXECUTABLE);
-    if (!mr->readonly) {
+    if (!slot->readonly) {
         region.flags |= BIT(MSHV_SET_MEM_BIT_WRITABLE);
     }
 
-    trace_mshv_map_memory(mr->userspace_addr, mr->guest_phys_addr,
-                          mr->memory_size);
+    trace_mshv_map_memory(slot->userspace_addr, slot->guest_phys_addr,
+                          slot->memory_size);
     return set_guest_memory(vm_fd, &region);
 }
 
+static MshvMemorySlot *find_mem_slot_by_region(uint64_t gpa, uint64_t size,
+                                               uint64_t userspace_addr)
+{
+    MshvMemorySlot *slot;
+
+    for (int i = 0; i < MSHV_MAX_MEM_SLOTS; i++) {
+        slot = &mem_slots[i];
+
+        if (slot->guest_phys_addr == gpa &&
+            slot->userspace_addr  == userspace_addr &&
+            slot->memory_size     == size) {
+            trace_mshv_found_slot(slot->userspace_addr, slot->guest_phys_addr,
+                                  slot->memory_size);
+            return slot;
+        }
+    }
+
+    return NULL;
+}
+
+static MshvMemorySlot* find_mem_slot_by_gpa(uint64_t gpa)
+{
+    uint64_t gpa_offset;
+    MshvMemorySlot *slot;
+
+    trace_mshv_find_slot_by_gpa(gpa);
+
+    for (int i = 0; i < MSHV_MAX_MEM_SLOTS; i++) {
+        slot = &mem_slots[i];
+
+        gpa_offset = gpa - slot->guest_phys_addr;
+        if (slot->guest_phys_addr <= gpa && gpa_offset < slot->memory_size) {
+            trace_mshv_found_slot(slot->userspace_addr, slot->guest_phys_addr,
+                                  slot->memory_size);
+            return slot;
+        }
+    }
+
+    return NULL;
+}
+
+MshvRemapResult mshv_remap_overlap_region(int vm_fd, uint64_t gpa)
+{
+    MshvMemorySlot *gpa_slot, *overlap_slot;
+    int ret;
+
+    /* return early if no slot is found */
+    gpa_slot = find_mem_slot_by_gpa(gpa);
+    if (gpa_slot == NULL) {
+        return MshvRemapNoMapping;
+    }
+
+    overlap_slot = find_overlap_mem_slot(gpa_slot);
+    if (overlap_slot == NULL) {
+        return MshvRemapNoOverlap;
+    }
+
+    /* unmap overlapping slot */
+    ret = map_or_unmap(vm_fd, overlap_slot, false);
+    if (ret < 0) {
+        error_report("failed to unmap overlap region");
+        abort();
+    }
+    overlap_slot->mapped = false;
+    warn_report("mapped out userspace_addr=0x%016lx gpa=0x%010lx size=0x%lx",
+                overlap_slot->userspace_addr,
+                overlap_slot->guest_phys_addr,
+                overlap_slot->memory_size);
+
+    /* map region for gpa */
+    ret = map_or_unmap(vm_fd, gpa_slot, true);
+    if (ret < 0) {
+        error_report("failed to map new region");
+        abort();
+    }
+    gpa_slot->mapped = true;
+    warn_report("mapped in  userspace_addr=0x%016lx gpa=0x%010lx size=0x%lx",
+                gpa_slot->userspace_addr, gpa_slot->guest_phys_addr,
+                gpa_slot->memory_size);
+
+    return MshvRemapOk;
+}
+
 static int handle_unmapped_mmio_region_read(uint64_t gpa, uint64_t size,
                                             uint8_t *data)
 {
@@ -123,20 +246,106 @@ int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
     return -1;
 }
 
-static int set_memory(const MshvMemoryRegion *mshv_mr, bool add)
+static void clear_slot(MshvMemorySlot *slot)
 {
-    int ret = 0;
+    assert(slot);
+
+    *slot = (MshvMemorySlot) { 0 };
+}
+
+static int tracked_unmap(int vm_fd, uint64_t gpa, uint64_t size,
+                        uint64_t userspace_addr)
+{
+    int ret;
+    MshvMemorySlot *slot;
+
+    slot = find_mem_slot_by_region(gpa, size, userspace_addr);
+    if (!slot) {
+        trace_mshv_skip_unset_mem(userspace_addr, gpa, size);
+        /* no work to do */
+        return 0;
+    }
+
+    if (!slot->mapped) {
+        /* remove slot, no need to unmap */
+        clear_slot(slot);
+        return 0;
+    }
+
+    ret = map_or_unmap(vm_fd, slot, false);
+    if (ret < 0) {
+        error_report("failed to unmap memory region");
+        return ret;
+    }
+    clear_slot(slot);
+
+    return 0;
+}
 
-    if (!mshv_mr) {
-        error_report("Invalid mshv_mr");
+static int tracked_map(int vm_fd, uint64_t gpa, uint64_t size, bool readonly,
+                       uint64_t userspace_addr)
+{
+    MshvMemorySlot *slot, *overlap_slot;
+    int ret;
+
+    slot = find_mem_slot_by_region(gpa, size, userspace_addr);
+    if (slot) {
+        error_report("memory region already mapped at gpa=0x%lx, "
+                     "userspace_addr=0x%lx, size=0x%lx",
+                     slot->guest_phys_addr, slot->userspace_addr,
+                     slot->memory_size);
+        return -1;
+    }
+
+    slot = find_free_mem_slot();
+    if (!slot) {
+        error_report("no free memory slot available");
+        return -1;
+    }
+
+    slot->guest_phys_addr = gpa;
+    slot->userspace_addr = userspace_addr;
+    slot->memory_size = size;
+    slot->readonly = readonly;
+
+    overlap_slot = find_overlap_mem_slot(slot);
+    if (overlap_slot) {
+        trace_mshv_remap_attempt(slot->userspace_addr,
+                                 slot->guest_phys_addr,
+                                 slot->memory_size);
+        warn_report("attempt to map region [0x%lx-0x%lx], while "
+                    "[0x%lx-0x%lx] is already mapped in the guest",
+                    userspace_addr, userspace_addr + size - 1,
+                    overlap_slot->userspace_addr,
+                    overlap_slot->userspace_addr +
+                    overlap_slot->memory_size - 1);
+
+        /* do not register mem slot in hv, but record for later swap-in */
+        slot->mapped = false;
+
+        return 0;
+    }
+
+    ret = map_or_unmap(vm_fd, slot, true);
+    if (ret < 0) {
+        error_report("failed to map memory region");
         return -1;
     }
+    slot->mapped = true;
 
-    trace_mshv_set_memory(add, mshv_mr->guest_phys_addr,
-                          mshv_mr->memory_size,
-                          mshv_mr->userspace_addr, mshv_mr->readonly,
-                          ret);
-    return map_or_unmap(mshv_state->vm, mshv_mr, add);
+    return 0;
+}
+
+static int set_memory(uint64_t gpa, uint64_t size, bool readonly,
+                      uint64_t userspace_addr, bool add)
+{
+    int vm_fd = mshv_state->vm;
+
+    if (add) {
+        return tracked_map(vm_fd, gpa, size, readonly, userspace_addr);
+    }
+
+    return tracked_unmap(vm_fd, gpa, size, userspace_addr);
 }
 
 /*
@@ -172,9 +381,10 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
     bool writable = !area->readonly && !area->rom_device;
     hwaddr start_addr, mr_offset, size;
     void *ram;
-    MshvMemoryRegion mshv_mr = {0};
 
-    trace_mshv_set_phys_mem(add, section->mr->name);
+    size = align_section(section, &start_addr);
+
+    trace_mshv_set_phys_mem(add, section->mr->name, start_addr);
 
     /* If the memory device is a writable non-ram area, we do not
      * want to map it into the guest memory. If it is not a ROM device,
@@ -188,7 +398,6 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
         }
     }
 
-    size = align_section(section, &start_addr);
     if (!size) {
         return;
     }
@@ -198,14 +407,9 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
 
     ram = memory_region_get_ram_ptr(area) + mr_offset;
 
-    mshv_mr.guest_phys_addr = start_addr;
-    mshv_mr.memory_size = size;
-    mshv_mr.readonly = !writable;
-    mshv_mr.userspace_addr = (uint64_t)ram;
-
-    ret = set_memory(&mshv_mr, add);
+    ret = set_memory(start_addr, size, !writable, (uint64_t)ram, add);
     if (ret < 0) {
-        error_report("Failed to set memory region");
+        error_report("failed to set memory region");
         abort();
     }
 }
diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
index bade57e22c..efd9dd7b3c 100644
--- a/accel/mshv/trace-events
+++ b/accel/mshv/trace-events
@@ -20,5 +20,10 @@ mshv_mem_write(uint64_t addr, size_t size) "\tgpa=%lx size=%lu"
 mshv_mem_read(uint64_t addr, size_t size) "\tgpa=%lx size=%lu"
 mshv_map_memory(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=%lx gpa=%010lx size=%08lx"
 mshv_unmap_memory(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=%lx gpa=%010lx size=%08lx"
-mshv_set_phys_mem(bool add, const char *name) "\tadd=%d name=%s"
+mshv_set_phys_mem(bool add, const char *name, uint64_t gpa) "\tadd=%d name=%s gpa=%lx"
+
+mshv_found_slot(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=%lx gpa=%010lx size=%08lx"
+mshv_skip_unset_mem(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=%lx gpa=%010lx size=%08lx"
+mshv_remap_attempt(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=%lx gpa=%010lx size=%08lx"
+mshv_find_slot_by_gpa(uint64_t gpa) "\tgpa=%010lx"
 mshv_handle_mmio(uint64_t gva, uint64_t gpa, uint64_t size, uint8_t access_type) "\tgva=%lx gpa=%010lx size=%lx access_type=%d"
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 27d7e3dff3..124da05885 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -38,6 +38,8 @@ typedef struct hyperv_message hv_message;
 
 #define MSHV_MSR_ENTRIES_COUNT 64
 
+#define MSHV_MAX_MEM_SLOTS 32
+
 #ifdef CONFIG_MSHV_IS_POSSIBLE
 extern bool mshv_allowed;
 #define mshv_enabled() (mshv_allowed)
@@ -102,6 +104,12 @@ typedef enum MshvVmExit {
     MshvVmExitHlt      = 3,
 } MshvVmExit;
 
+typedef enum MshvRemapResult {
+    MshvRemapOk = 0,
+    MshvRemapNoMapping = 1,
+    MshvRemapNoOverlap = 2,
+} MshvRemapResult;
+
 void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
@@ -143,15 +151,15 @@ typedef struct MshvMsrEntries {
 int mshv_configure_msr(int cpu_fd, const MshvMsrEntry *msrs, size_t n_msrs);
 
 /* memory */
-typedef struct MshvMemoryRegion {
+typedef struct MshvMemorySlot {
     uint64_t guest_phys_addr;
     uint64_t memory_size;
     uint64_t userspace_addr;
     bool readonly;
-} MshvMemoryRegion;
+    bool mapped;
+} MshvMemorySlot;
 
-int mshv_add_mem(int vm_fd, const MshvMemoryRegion *mr);
-int mshv_remove_mem(int vm_fd, const MshvMemoryRegion *mr);
+MshvRemapResult mshv_remap_overlap_region(int vm_fd, uint64_t gpa);
 int mshv_guest_mem_read(uint64_t gpa, uint8_t *data, uintptr_t size,
                         bool is_secure_mode, bool instruction_fetch);
 int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 41a3398ec8..083f161274 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1073,6 +1073,43 @@ static int handle_mmio(CPUState *cpu, const struct hyperv_message *msg,
     return 0;
 }
 
+static int handle_unmapped_mem(int vm_fd, CPUState *cpu,
+                               const struct hyperv_message *msg,
+                               MshvVmExit *exit_reason)
+{
+    struct hv_x64_memory_intercept_message info = { 0 };
+    uint64_t gpa;
+    int ret;
+    enum MshvRemapResult remap_result;
+
+    ret = set_memory_info(msg, &info);
+    if (ret < 0) {
+        error_report("failed to convert message to memory info");
+        return -1;
+    }
+
+    gpa = info.guest_physical_address;
+
+    /* attempt to remap the region, in case of overlapping userspace mappings */
+    remap_result = mshv_remap_overlap_region(vm_fd, gpa);
+    *exit_reason = MshvVmExitIgnore;
+
+    switch (remap_result) {
+    case MshvRemapNoMapping:
+        /* if we didn't find a mapping, it is probably mmio */
+        return handle_mmio(cpu, msg, exit_reason);
+    case MshvRemapOk:
+        break;
+    case MshvRemapNoOverlap:
+        /* This should not happen, but we are forgiving it */
+        warn_report("found no overlap for unmapped region");
+        *exit_reason = MshvVmExitSpecial;
+        break;
+    }
+
+    return 0;
+}
+
 static int set_ioport_info(const struct hyperv_message *msg,
                            hv_x64_io_port_intercept_message *info)
 {
@@ -1449,6 +1486,12 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
     case HVMSG_UNRECOVERABLE_EXCEPTION:
         return MshvVmExitShutdown;
     case HVMSG_UNMAPPED_GPA:
+        ret = handle_unmapped_mem(vm_fd, cpu, msg, &exit_reason);
+        if (ret < 0) {
+            error_report("failed to handle unmapped memory");
+            return -1;
+        }
+        return exit_reason;
     case HVMSG_GPA_INTERCEPT:
         ret = handle_mmio(cpu, msg, &exit_reason);
         if (ret < 0) {
-- 
2.34.1


