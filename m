Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CD5C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLDi-0002kC-B6; Tue, 20 May 2025 07:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uHLDF-00024a-BO
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:32:49 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uHLDB-0001Ov-I3
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:32:49 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (unknown [172.201.77.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id CC581206832E;
 Tue, 20 May 2025 04:32:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC581206832E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747740754;
 bh=tGF+088azxs8Bh2UpgWFjEFNm5ei9K9/YPHSHdXlluM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=srFA1cubJBM0DM4oeH23rQRUVvAr7P9j109LfC+R3etSThvBc9540FlFWImAWGMzd
 QNDoCDfp8wZIKjo7tzSn/s7Zl9TTbJcVLzKmY35oggeAJeDFSXvVjg0MczaxSrgtDk
 3rdQlPn/ljm7mM0tMxXTi4yYtzQ9nLNI9oe671r8=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: magnuskulke@microsoft.com,
	qemu-devel@nongnu.org,
	liuwe@microsoft.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 25/25] accel/mshv: Add memory remapping workaround
Date: Tue, 20 May 2025 13:30:18 +0200
Message-Id: <20250520113018.49569-26-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Qemu maps regions of userland multiple times into the guest. The MSHV
kernel driver detects those overlapping regions and rejects those
mappings.

A logic is introduced to track all mappings and replace a region on the
fly if an unmapped gpa is encountered. If there is a region in the list
that would qualify and is currently unmapped, the current region is
unmapped and the requested region is mapped in.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mem.c            | 229 +++++++++++++++++++++++++++++++++++-
 accel/mshv/mshv-all.c       |   2 +
 include/system/mshv.h       |  13 ++
 target/i386/mshv/mshv-cpu.c |  23 +++-
 4 files changed, 265 insertions(+), 2 deletions(-)

diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
index ee627e7bd6..53e43873dc 100644
--- a/accel/mshv/mem.c
+++ b/accel/mshv/mem.c
@@ -12,7 +12,9 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/lockable.h"
 #include "qemu/error-report.h"
+#include "qemu/rcu.h"
 #include "hw/hyperv/linux-mshv.h"
 #include "system/address-spaces.h"
 #include "system/mshv.h"
@@ -20,12 +22,101 @@
 #include <sys/ioctl.h>
 #include "trace.h"
 
+static GList *mem_entries;
+
+/* We need this, because call_rcu1 won't operate on empty lists (NULL) */
+typedef struct {
+    struct rcu_head rcu;
+    GList *list;
+} FreeMemEntriesJob;
+
+static inline void free_mem_entries(struct rcu_head *rh)
+{
+    FreeMemEntriesJob *job = container_of(rh, FreeMemEntriesJob, rcu);
+    g_list_free(job->list);
+    g_free(job);
+}
+
+static void add_mem_entry(MshvMemoryEntry *entry)
+{
+    GList *old = qatomic_rcu_read(&mem_entries);
+    GList *new = g_list_copy(old);
+    new = g_list_prepend(new, entry);
+
+    qatomic_rcu_set(&mem_entries, new);
+
+    /* defer freeing of an obsolete snapshot */
+    FreeMemEntriesJob *job = g_new(FreeMemEntriesJob, 1);
+    job->list = old;
+    call_rcu1(&job->rcu, free_mem_entries);
+}
+
+static void remove_mem_entry(MshvMemoryEntry *entry)
+{
+    GList *old = qatomic_rcu_read(&mem_entries);
+    GList *new = g_list_copy(old);
+    new = g_list_remove(new, entry);
+
+    qatomic_rcu_set(&mem_entries, new);
+
+    /* Defer freeing of an obsolete snapshot */
+    FreeMemEntriesJob *job = g_new(FreeMemEntriesJob, 1);
+    job->list = old;
+    call_rcu1((struct rcu_head *)old, free_mem_entries);
+}
+
+/* Find _currently mapped_ memory entry, that is overlapping in userspace */
+static MshvMemoryEntry *find_overlap_mem_entry(const MshvMemoryEntry *entry_1)
+{
+    uint64_t start_1 = entry_1->mr.userspace_addr, start_2;
+    size_t len_1 = entry_1->mr.memory_size, len_2;
+
+    WITH_RCU_READ_LOCK_GUARD() {
+        GList *entries = qatomic_rcu_read(&mem_entries);
+        bool overlaps;
+        MshvMemoryEntry *entry_2;
+
+        for (GList *l = entries; l != NULL; l = l->next) {
+            entry_2 = l->data;
+            assert(entry_2);
+
+            if (entry_2 == entry_1) {
+                continue;
+            }
+
+            start_2 = entry_2->mr.userspace_addr;
+            len_2 = entry_2->mr.memory_size;
+
+            overlaps = ranges_overlap(start_1, len_1, start_2, len_2);
+            if (entry_2 != entry_1 && entry_2->mapped && overlaps) {
+                return entry_2;
+            }
+        }
+    }
+
+    return NULL;
+}
+
+void mshv_init_mem_manager(void)
+{
+    mem_entries = NULL;
+}
+
 static int set_guest_memory(int vm_fd, const mshv_user_mem_region *region)
 {
     int ret;
+    MshvMemoryEntry *overlap_entry, entry = { .mr = { 0 }, .mapped = false };
 
     ret = ioctl(vm_fd, MSHV_SET_GUEST_MEMORY, region);
     if (ret < 0) {
+        entry.mr.userspace_addr = region->userspace_addr;
+        entry.mr.memory_size = region->size;
+
+        overlap_entry = find_overlap_mem_entry(&entry);
+        if (overlap_entry != NULL) {
+            return -MSHV_USERSPACE_ADDR_REMAP_ERROR;
+        }
+
         error_report("failed to set guest memory");
         return -errno;
     }
@@ -54,6 +145,142 @@ static int map_or_unmap(int vm_fd, const MshvMemoryRegion *mr, bool add)
     return set_guest_memory(vm_fd, &region);
 }
 
+static MshvMemoryEntry *find_mem_entry_by_region(const MshvMemoryRegion *mr)
+{
+    WITH_RCU_READ_LOCK_GUARD() {
+        GList *entries = qatomic_rcu_read(&mem_entries);
+        MshvMemoryEntry *entry;
+
+        for (GList *l = entries; l != NULL; l = l->next) {
+            entry = l->data;
+            assert(entry);
+            if (memcmp(mr, &entry->mr, sizeof(MshvMemoryRegion)) == 0) {
+                return entry;
+            }
+        }
+    }
+
+    return NULL;
+}
+
+static inline int tracked_map_or_unmap(int vm_fd, const MshvMemoryRegion *mr, bool add)
+{
+    MshvMemoryEntry *entry;
+    int ret;
+
+    entry = find_mem_entry_by_region(mr);
+
+    if (!entry) {
+        /* delete */
+        if (!add) {
+            error_report("mem entry selected for removal does not exist");
+            return -1;
+        }
+
+        /* add */
+        ret = map_or_unmap(vm_fd, mr, true);
+        entry = g_new0(MshvMemoryEntry, 1);
+        entry->mr = *mr;
+        /* set depending on success */
+        entry->mapped = (ret == 0);
+        add_mem_entry(entry);
+
+        if (ret == -MSHV_USERSPACE_ADDR_REMAP_ERROR) {
+            warn_report(
+                "ignoring failed remapping userspace_addr=0x%016lx "
+                "gpa=0x%08lx size=0x%lx", mr->userspace_addr,
+                mr->guest_phys_addr, mr->memory_size);
+            ret = 0;
+        }
+
+        return ret;
+    }
+
+    /* entry exists */
+
+    /* delete */
+    if (!add) {
+        ret = 0;
+        if (entry->mapped) {
+            ret = map_or_unmap(vm_fd, mr, false);
+        }
+        remove_mem_entry(entry);
+        g_free(entry);
+        return ret;
+    }
+
+    /* add */
+    ret = map_or_unmap(vm_fd, mr, true);
+
+    /* set depending on success */
+    entry->mapped = (ret == 0);
+    return ret;
+}
+
+static MshvMemoryEntry* find_mem_entry_by_gpa(uint64_t gpa)
+{
+    WITH_RCU_READ_LOCK_GUARD() {
+        GList *entries = qatomic_rcu_read(&mem_entries);
+        MshvMemoryEntry *entry;
+        uint64_t gpa_offset;
+
+        for (GList *l = entries; l != NULL; l = l->next) {
+            entry = l->data;
+            assert(entry);
+            gpa_offset = gpa - entry->mr.guest_phys_addr;
+            if (entry->mr.guest_phys_addr <= gpa
+                && gpa_offset < entry->mr.memory_size) {
+                return entry;
+            }
+        }
+    }
+
+    return NULL;
+}
+
+MshvRemapResult mshv_remap_overlapped_region(int vm_fd, uint64_t gpa)
+{
+    MshvMemoryEntry *gpa_entry, *overlap_entry;
+    int ret;
+
+    /* return early if no entry is found */
+    gpa_entry = find_mem_entry_by_gpa(gpa);
+    if (gpa_entry == NULL) {
+        return MshvRemapNoMapping;
+    }
+
+    overlap_entry = find_overlap_mem_entry(gpa_entry);
+    if (overlap_entry == NULL) {
+        return MshvRemapNoOverlap;
+    }
+
+    /* unmap overlapping region */
+    ret = map_or_unmap(vm_fd, &overlap_entry->mr, false);
+    if (ret < 0) {
+        error_report("failed to unmap overlap region");
+        abort();
+    }
+    overlap_entry->mapped = false;
+    warn_report("mapped out userspace_addr=0x%016lx gpa=0x%010lx size=0x%lx",
+                overlap_entry->mr.userspace_addr,
+                overlap_entry->mr.guest_phys_addr,
+                overlap_entry->mr.memory_size);
+
+    /* map region for gpa */
+    ret = map_or_unmap(vm_fd, &gpa_entry->mr, true);
+    if (ret < 0) {
+        error_report("failed to map new region");
+        abort();
+    }
+    gpa_entry->mapped = true;
+    warn_report("mapped in  userspace_addr=0x%016lx gpa=0x%010lx size=0x%lx",
+                gpa_entry->mr.userspace_addr,
+                gpa_entry->mr.guest_phys_addr,
+                gpa_entry->mr.memory_size);
+
+    return MshvRemapOk;
+}
+
 static inline MemTxAttrs get_mem_attrs(bool is_secure_mode)
 {
     MemTxAttrs memattr = {0};
@@ -139,7 +366,7 @@ static int set_memory(const MshvMemoryRegion *mshv_mr, bool add)
                           mshv_mr->memory_size,
                           mshv_mr->userspace_addr, mshv_mr->readonly,
                           ret);
-    return map_or_unmap(mshv_state->vm, mshv_mr, add);
+    return tracked_map_or_unmap(mshv_state->vm, mshv_mr, add);
 }
 
 /*
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 97212c54f1..bf30c968ce 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -439,6 +439,8 @@ static int mshv_init(MachineState *ms)
 
     mshv_init_msicontrol();
 
+    mshv_init_mem_manager();
+
     do {
         int vm_fd = create_vm(mshv_fd);
         s->vm = vm_fd;
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 622b3db540..c4072b980f 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -147,6 +147,12 @@ typedef enum MshvVmExit {
     MshvVmExitSpecial  = 2,
 } MshvVmExit;
 
+typedef enum MshvRemapResult {
+    MshvRemapOk = 0,
+    MshvRemapNoMapping = 1,
+    MshvRemapNoOverlap = 2,
+} MshvRemapResult;
+
 void mshv_init_cpu_logic(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
@@ -199,8 +205,15 @@ typedef struct MshvMemoryRegion {
     bool readonly;
 } MshvMemoryRegion;
 
+typedef struct MshvMemoryEntry {
+    MshvMemoryRegion mr;
+    bool mapped;
+} MshvMemoryEntry;
+
+void mshv_init_mem_manager(void);
 int mshv_add_mem(int vm_fd, const MshvMemoryRegion *mr);
 int mshv_remove_mem(int vm_fd, const MshvMemoryRegion *mr);
+MshvRemapResult mshv_remap_overlapped_region(int vm_fd, uint64_t gpa);
 int mshv_guest_mem_read(uint64_t gpa, uint8_t *data, uintptr_t size,
                         bool is_secure_mode, bool instruction_fetch);
 int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 27c6cd6138..4c74081968 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1159,7 +1159,9 @@ static int handle_unmapped_mem(int vm_fd, CPUState *cpu,
                                MshvVmExit *exit_reason)
 {
     struct hv_x64_memory_intercept_message info = { 0 };
+    uint64_t gpa;
     int ret;
+    enum MshvRemapResult remap_result;
 
     ret = set_memory_info(msg, &info);
     if (ret < 0) {
@@ -1167,7 +1169,26 @@ static int handle_unmapped_mem(int vm_fd, CPUState *cpu,
         return -1;
     }
 
-    return handle_mmio(cpu, msg, exit_reason);
+    gpa = info.guest_physical_address;
+
+    /* attempt to remap the region, in case of overlapping userspase mappings */
+    remap_result = mshv_remap_overlapped_region(vm_fd, gpa);
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
 }
 
 static int set_ioport_info(const struct hyperv_message *msg,
-- 
2.34.1


