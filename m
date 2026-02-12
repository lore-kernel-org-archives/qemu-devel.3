Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F44EE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvs-00078U-C4; Thu, 12 Feb 2026 09:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvf-0006k2-0o
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvc-0006JF-2I
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0uYZne8yLPOlYUa8J2qxfeDZ6ErnSQon2oFjnwLMmA=;
 b=OkLUvkLr0TaB4COYNvgJsQWXJPveLP5X3FFdvIuM0aRxFRqdNEQ5RI1e/I4sxwo09fi4bQ
 PG9PBEYRx5z8tPYGphmfyVGenJ/z1hRvZRs7h28SWQIc0UCQpVjn+Mb2WW254WoeRyrHx2
 KD9DDTLe0mFMbVCVVyRAanXM+yXNBmo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-g2X3IRtkPbC1-V7yYmDaXw-1; Thu, 12 Feb 2026 09:44:22 -0500
X-MC-Unique: g2X3IRtkPbC1-V7yYmDaXw-1
X-Mimecast-MFC-AGG-ID: g2X3IRtkPbC1-V7yYmDaXw_1770907461
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-480711d09f1so43118195e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907459; x=1771512259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D0uYZne8yLPOlYUa8J2qxfeDZ6ErnSQon2oFjnwLMmA=;
 b=hxzyw8YJZbONbNVmPOCMBtpfAYboPmOmO09eX0ehJbQxIGxJRVB90sZyjjE5fY2fIz
 24hVP9WJkP5EHJPj+0hT1sMiIYCWEadBSnhJ4rI5L0W0N+WLU0SdT0fFqYVgjII4zVhl
 DZp83r/U+iQduMXXftWXMxLMt7j93qrMc+yq81z9uOuJkl2yptTaK7/MeXP5T0DYpIv4
 5FnR5dttlR/Jt6v+AupTa/Igsw2xOjwqe7D3njEmL0fxn40J2asenIUZwe9L2awLZcdY
 8o5nM6OqCQmTep5hC6cBpPwsF1wAWno7fJtIVK09dJkNGsr2mO5ZbnlluYuD1u8UEx24
 FNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907459; x=1771512259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D0uYZne8yLPOlYUa8J2qxfeDZ6ErnSQon2oFjnwLMmA=;
 b=RHL6r5AqWDiDmpD8OLO+r+zw0KeMLRbfq2ZkBnPZEhJosPLzPuYmfTvC3jf6p3r7uJ
 /NZEEnHWA+00trdvV/ImY98w6fRdELHCGqzdFkOA5KGS0glafvOnNbE+Jf66hbDo/kwR
 DiMlh+7dsMBZJVabnIuuHYOblZmUmhHKlBAB07N6kPKcqSYz5EzEpKedJAqeAUr4cdmF
 YgpYeq1dG57WwIp+lyA4rx/Zb/dP18tyD7cv564At43+Pp7Iyc/mFIvKoU+gmycbdLCx
 SYbW3aYqK98d4evgunNI6JZcenJANNA2rYvN8G2RuS/ucid6kIXgeifofj+hD5nShU9A
 OUlw==
X-Gm-Message-State: AOJu0Yzzep0SG4xeVaVJBLHyD95GoC5Qpjs9boqmKNnPdjFwNE9JNvCz
 K1ow0TvT5gal/5vMgPRcAN+ZYI0nOhcbGGHKbwuRwG5ej1Pu+Bmyzd/KrXDNeQ7hxKOVkZIGxQ9
 vaMmZm+fNQjENGYMZXNpQbXz8QgBhA7ksp6tOhWmZSg/i6Php+6NC0GAR6FcCcKKWntlSP4JJ0e
 gQYDSkWREMjZGG6/QoXUS3eg0vlCe3KQg97m2O6Zrk
X-Gm-Gg: AZuq6aKtLY3tYtXb1Y0qVeJ0LUU07YKQi53CG9zt2aeDd1GIJU4G02iTmEeYTEAXben
 1iHLj2a542nBg5hcKIF4jGraB0n6fJljgmrothz756DuoZON7YJU5FOMGtxL3HRHs/LqZ+Onbsa
 SGmEgfagD8rbj4kOgsxAZHK6J5GdgsqU5TPZYWDqL9lRt40cbK5EBe7sJrqqy4Hag6KoY6ahDuh
 84JuNlqAdLBZ7cMpmiZI4r0KBlF+3JpV63iHOgGn8X8st/kHPCY97hqXgBmHq2/UoV4PCxTFWyu
 uFALSZJ8sMfqhC0fvZ23uhd8jO2FoxBWcj4XG0S4miq8r422k8vwo3ZR5KuLyTklriJmrcZScoN
 thWEljNNvG+1khxML9P7xxZ4vJb5CKm+g1J++FC0q6jOwUWszYUuE4q6vUe4xDHUIiloQOjSbUd
 ivZmk0H67oKTsRIn9KzTZt1KxvyPQnNpqfOMh8EVro6Xpx3bRKui0=
X-Received: by 2002:a05:600c:3e1b:b0:47a:935f:61a0 with SMTP id
 5b1f17b1804b1-48367086001mr35416645e9.0.1770907459205; 
 Thu, 12 Feb 2026 06:44:19 -0800 (PST)
X-Received: by 2002:a05:600c:3e1b:b0:47a:935f:61a0 with SMTP id
 5b1f17b1804b1-48367086001mr35416075e9.0.1770907458601; 
 Thu, 12 Feb 2026 06:44:18 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836aa0847asm48393415e9.3.2026.02.12.06.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:44:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Wei Liu (Microsoft)" <wei.liu@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 40/41] accel/mshv: Remove remap overlapping mappings code
Date: Thu, 12 Feb 2026 15:42:42 +0100
Message-ID: <20260212144244.22579-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

This change removes userland code that worked around a restriction
in the mshv driver in the 6.18 kernel: regions from userland
couldn't be mapped to multiple regions in the kernel. We maintained a
shadow mapping table in qemu and used a heuristic to swap in a requested
region in case of UNMAPPED_GPA exits.

However, this heuristic wasn't reliable in all cases, since HyperV
behaviour is not 100% reliable across versions. HyperV itself doesn't
prohibit to map regions at multiple places into the guest, so the
restriction has been removed in the mshv driver.

Hence we can remove the remapping code. Effectively this will mandate a
6.19 kernel, if the workload attempt to map e.g. BIOS to multiple
reagions. I still think it's the right call to remove this logic:

- The workaround only seems to work reliably with a certain revision
  of HyperV as a nested hypervisor.
- We expect Direct Virtualization (L1VH) to be the main platform for
  the mshv accelerator, which also requires a 6.19 kernel

This reverts commit efc4093358511a58846a409b965213aa1bb9f31a.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Acked-by: Wei Liu (Microsoft) <wei.liu@kernel.org>
Tested-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260113153708.448968-1-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |  22 +-
 accel/mshv/mem.c            | 406 +++---------------------------------
 accel/mshv/mshv-all.c       |   2 -
 target/i386/mshv/mshv-cpu.c |  43 ----
 accel/mshv/trace-events     |   5 -
 5 files changed, 30 insertions(+), 448 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 490563c1ab2..ad4d001c3cd 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -16,8 +16,6 @@
 
 #define MSHV_MSR_ENTRIES_COUNT 64
 
-#define MSHV_MAX_MEM_SLOTS 32
-
 typedef struct hyperv_message hv_message;
 
 typedef struct MshvHvCallArgs {
@@ -42,12 +40,6 @@ typedef struct MshvAddressSpace {
     AddressSpace *as;
 } MshvAddressSpace;
 
-typedef struct MshvMemorySlotManager {
-    size_t n_slots;
-    GList *slots;
-    QemuMutex mutex;
-} MshvMemorySlotManager;
-
 struct MshvState {
     AccelState parent_obj;
     int vm;
@@ -56,7 +48,6 @@ struct MshvState {
     int nr_as;
     MshvAddressSpace *as;
     int fd;
-    MshvMemorySlotManager msm;
 };
 
 typedef struct MshvMsiControl {
@@ -87,12 +78,6 @@ typedef enum MshvVmExit {
     MshvVmExitSpecial  = 2,
 } MshvVmExit;
 
-typedef enum MshvRemapResult {
-    MshvRemapOk = 0,
-    MshvRemapNoMapping = 1,
-    MshvRemapNoOverlap = 2,
-} MshvRemapResult;
-
 void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
@@ -116,22 +101,19 @@ int mshv_hvcall(int fd, const struct mshv_root_hvcall *args);
 #endif
 
 /* memory */
-typedef struct MshvMemorySlot {
+typedef struct MshvMemoryRegion {
     uint64_t guest_phys_addr;
     uint64_t memory_size;
     uint64_t userspace_addr;
     bool readonly;
-    bool mapped;
-} MshvMemorySlot;
+} MshvMemoryRegion;
 
-MshvRemapResult mshv_remap_overlap_region(int vm_fd, uint64_t gpa);
 int mshv_guest_mem_read(uint64_t gpa, uint8_t *data, uintptr_t size,
                         bool is_secure_mode, bool instruction_fetch);
 int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
                          bool is_secure_mode);
 void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
                        bool add);
-void mshv_init_memory_slot_manager(MshvState *mshv_state);
 
 /* msr */
 typedef struct MshvMsrEntry {
diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
index 0e2164af3ee..e55c38d4db9 100644
--- a/accel/mshv/mem.c
+++ b/accel/mshv/mem.c
@@ -11,9 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/lockable.h"
 #include "qemu/error-report.h"
-#include "qemu/rcu.h"
 #include "linux/mshv.h"
 #include "system/address-spaces.h"
 #include "system/mshv.h"
@@ -22,137 +20,6 @@
 #include <sys/ioctl.h>
 #include "trace.h"
 
-typedef struct SlotsRCUReclaim {
-    struct rcu_head rcu;
-    GList *old_head;
-    MshvMemorySlot *removed_slot;
-} SlotsRCUReclaim;
-
-static void rcu_reclaim_slotlist(struct rcu_head *rcu)
-{
-    SlotsRCUReclaim *r = container_of(rcu, SlotsRCUReclaim, rcu);
-    g_list_free(r->old_head);
-    g_free(r->removed_slot);
-    g_free(r);
-}
-
-static void publish_slots(GList *new_head, GList *old_head,
-                          MshvMemorySlot *removed_slot)
-{
-    MshvMemorySlotManager *manager = &mshv_state->msm;
-
-    assert(manager);
-    qatomic_store_release(&manager->slots, new_head);
-
-    SlotsRCUReclaim *r = g_new(SlotsRCUReclaim, 1);
-    r->old_head = old_head;
-    r->removed_slot = removed_slot;
-
-    call_rcu1(&r->rcu, rcu_reclaim_slotlist);
-}
-
-/* Needs to be called with mshv_state->msm.mutex held */
-static int remove_slot(MshvMemorySlot *slot)
-{
-    GList *old_head, *new_head;
-    MshvMemorySlotManager *manager = &mshv_state->msm;
-
-    assert(manager);
-    old_head = qatomic_load_acquire(&manager->slots);
-
-    if (!g_list_find(old_head, slot)) {
-        error_report("slot requested for removal not found");
-        return -1;
-    }
-
-    new_head = g_list_copy(old_head);
-    new_head = g_list_remove(new_head, slot);
-    manager->n_slots--;
-
-    publish_slots(new_head, old_head, slot);
-
-    return 0;
-}
-
-/* Needs to be called with mshv_state->msm.mutex held */
-static MshvMemorySlot *append_slot(uint64_t gpa, uint64_t userspace_addr,
-                                   uint64_t size, bool readonly)
-{
-    GList *old_head, *new_head;
-    MshvMemorySlot *slot;
-    MshvMemorySlotManager *manager = &mshv_state->msm;
-
-    assert(manager);
-
-    old_head = qatomic_load_acquire(&manager->slots);
-
-    if (manager->n_slots >= MSHV_MAX_MEM_SLOTS) {
-        error_report("no free memory slots available");
-        return NULL;
-    }
-
-    slot = g_new0(MshvMemorySlot, 1);
-    slot->guest_phys_addr = gpa;
-    slot->userspace_addr = userspace_addr;
-    slot->memory_size = size;
-    slot->readonly = readonly;
-
-    new_head = g_list_copy(old_head);
-    new_head = g_list_append(new_head, slot);
-    manager->n_slots++;
-
-    publish_slots(new_head, old_head, NULL);
-
-    return slot;
-}
-
-static int slot_overlaps(const MshvMemorySlot *slot1,
-                         const MshvMemorySlot *slot2)
-{
-    uint64_t start_1 = slot1->userspace_addr,
-             start_2 = slot2->userspace_addr;
-    size_t len_1 = slot1->memory_size,
-           len_2 = slot2->memory_size;
-
-    if (slot1 == slot2) {
-        return -1;
-    }
-
-    return ranges_overlap(start_1, len_1, start_2, len_2) ?  0 : -1;
-}
-
-static bool is_mapped(MshvMemorySlot *slot)
-{
-    /* Subsequent reads of mapped field see a fully-initialized slot */
-    return qatomic_load_acquire(&slot->mapped);
-}
-
-/*
- * Find slot that is:
- * - overlapping in userspace
- * - currently mapped in the guest
- *
- * Needs to be called with mshv_state->msm.mutex or RCU read lock held.
- */
-static MshvMemorySlot *find_overlap_mem_slot(GList *head, MshvMemorySlot *slot)
-{
-    GList *found;
-    MshvMemorySlot *overlap_slot;
-
-    found = g_list_find_custom(head, slot, (GCompareFunc) slot_overlaps);
-
-    if (!found) {
-        return NULL;
-    }
-
-    overlap_slot = found->data;
-    if (!overlap_slot || !is_mapped(overlap_slot)) {
-        return NULL;
-    }
-
-    return overlap_slot;
-}
-
 static int set_guest_memory(int vm_fd,
                             const struct mshv_user_mem_region *region)
 {
@@ -160,169 +27,38 @@ static int set_guest_memory(int vm_fd,
 
     ret = ioctl(vm_fd, MSHV_SET_GUEST_MEMORY, region);
     if (ret < 0) {
-        error_report("failed to set guest memory: %s", strerror(errno));
-        return -1;
+        error_report("failed to set guest memory");
+        return -errno;
     }
 
     return 0;
 }
 
-static int map_or_unmap(int vm_fd, const MshvMemorySlot *slot, bool map)
+static int map_or_unmap(int vm_fd, const MshvMemoryRegion *mr, bool map)
 {
     struct mshv_user_mem_region region = {0};
 
-    region.guest_pfn = slot->guest_phys_addr >> MSHV_PAGE_SHIFT;
-    region.size = slot->memory_size;
-    region.userspace_addr = slot->userspace_addr;
+    region.guest_pfn = mr->guest_phys_addr >> MSHV_PAGE_SHIFT;
+    region.size = mr->memory_size;
+    region.userspace_addr = mr->userspace_addr;
 
     if (!map) {
         region.flags |= (1 << MSHV_SET_MEM_BIT_UNMAP);
-        trace_mshv_unmap_memory(slot->userspace_addr, slot->guest_phys_addr,
-                                slot->memory_size);
+        trace_mshv_unmap_memory(mr->userspace_addr, mr->guest_phys_addr,
+                                mr->memory_size);
         return set_guest_memory(vm_fd, &region);
     }
 
     region.flags = BIT(MSHV_SET_MEM_BIT_EXECUTABLE);
-    if (!slot->readonly) {
+    if (!mr->readonly) {
         region.flags |= BIT(MSHV_SET_MEM_BIT_WRITABLE);
     }
 
-    trace_mshv_map_memory(slot->userspace_addr, slot->guest_phys_addr,
-                          slot->memory_size);
+    trace_mshv_map_memory(mr->userspace_addr, mr->guest_phys_addr,
+                          mr->memory_size);
     return set_guest_memory(vm_fd, &region);
 }
 
-static int slot_matches_region(const MshvMemorySlot *slot1,
-                               const MshvMemorySlot *slot2)
-{
-    return (slot1->guest_phys_addr == slot2->guest_phys_addr &&
-            slot1->userspace_addr  == slot2->userspace_addr &&
-            slot1->memory_size     == slot2->memory_size) ? 0 : -1;
-}
-
-/* Needs to be called with mshv_state->msm.mutex held */
-static MshvMemorySlot *find_mem_slot_by_region(uint64_t gpa, uint64_t size,
-                                               uint64_t userspace_addr)
-{
-    MshvMemorySlot ref_slot = {
-        .guest_phys_addr = gpa,
-        .userspace_addr  = userspace_addr,
-        .memory_size     = size,
-    };
-    GList *found;
-    MshvMemorySlotManager *manager = &mshv_state->msm;
-
-    assert(manager);
-    found = g_list_find_custom(manager->slots, &ref_slot,
-                               (GCompareFunc) slot_matches_region);
-
-    return found ? found->data : NULL;
-}
-
-static int slot_covers_gpa(const MshvMemorySlot *slot, uint64_t *gpa_p)
-{
-    uint64_t gpa_offset, gpa = *gpa_p;
-
-    gpa_offset = gpa - slot->guest_phys_addr;
-    return (slot->guest_phys_addr <= gpa && gpa_offset < slot->memory_size)
-        ? 0 : -1;
-}
-
-/* Needs to be called with mshv_state->msm.mutex or RCU read lock held */
-static MshvMemorySlot *find_mem_slot_by_gpa(GList *head, uint64_t gpa)
-{
-    GList *found;
-    MshvMemorySlot *slot;
-
-    trace_mshv_find_slot_by_gpa(gpa);
-
-    found = g_list_find_custom(head, &gpa, (GCompareFunc) slot_covers_gpa);
-    if (found) {
-        slot = found->data;
-        trace_mshv_found_slot(slot->userspace_addr, slot->guest_phys_addr,
-                              slot->memory_size);
-        return slot;
-    }
-
-    return NULL;
-}
-
-/* Needs to be called with mshv_state->msm.mutex held */
-static void set_mapped(MshvMemorySlot *slot, bool mapped)
-{
-    /* prior writes to mapped field becomes visible before readers see slot */
-    qatomic_store_release(&slot->mapped, mapped);
-}
-
-MshvRemapResult mshv_remap_overlap_region(int vm_fd, uint64_t gpa)
-{
-    MshvMemorySlot *gpa_slot, *overlap_slot;
-    GList *head;
-    int ret;
-    MshvMemorySlotManager *manager = &mshv_state->msm;
-
-    /* fast path, called often by unmapped_gpa vm exit */
-    WITH_RCU_READ_LOCK_GUARD() {
-        assert(manager);
-        head = qatomic_load_acquire(&manager->slots);
-        /* return early if no slot is found */
-        gpa_slot = find_mem_slot_by_gpa(head, gpa);
-        if (gpa_slot == NULL) {
-            return MshvRemapNoMapping;
-        }
-
-        /* return early if no overlapping slot is found */
-        overlap_slot = find_overlap_mem_slot(head, gpa_slot);
-        if (overlap_slot == NULL) {
-            return MshvRemapNoOverlap;
-        }
-    }
-
-    /*
-     * We'll modify the mapping list, so we need to upgrade to mutex and
-     * recheck.
-     */
-    assert(manager);
-    QEMU_LOCK_GUARD(&manager->mutex);
-
-    /* return early if no slot is found */
-    gpa_slot = find_mem_slot_by_gpa(manager->slots, gpa);
-    if (gpa_slot == NULL) {
-        return MshvRemapNoMapping;
-    }
-
-    /* return early if no overlapping slot is found */
-    overlap_slot = find_overlap_mem_slot(manager->slots, gpa_slot);
-    if (overlap_slot == NULL) {
-        return MshvRemapNoOverlap;
-    }
-
-    /* unmap overlapping slot */
-    ret = map_or_unmap(vm_fd, overlap_slot, false);
-    if (ret < 0) {
-        error_report("failed to unmap overlap region");
-        abort();
-    }
-    set_mapped(overlap_slot, false);
-    warn_report("mapped out userspace_addr=0x%016lx gpa=0x%010lx size=0x%lx",
-                overlap_slot->userspace_addr,
-                overlap_slot->guest_phys_addr,
-                overlap_slot->memory_size);
-
-    /* map region for gpa */
-    ret = map_or_unmap(vm_fd, gpa_slot, true);
-    if (ret < 0) {
-        error_report("failed to map new region");
-        abort();
-    }
-    set_mapped(gpa_slot, true);
-    warn_report("mapped in  userspace_addr=0x%016lx gpa=0x%010lx size=0x%lx",
-                gpa_slot->userspace_addr, gpa_slot->guest_phys_addr,
-                gpa_slot->memory_size);
-
-    return MshvRemapOk;
-}
-
 static int handle_unmapped_mmio_region_read(uint64_t gpa, uint64_t size,
                                             uint8_t *data)
 {
@@ -388,97 +124,20 @@ int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
     return -1;
 }
 
-static int tracked_unmap(int vm_fd, uint64_t gpa, uint64_t size,
-                        uint64_t userspace_addr)
+static int set_memory(const MshvMemoryRegion *mshv_mr, bool add)
 {
-    int ret;
-    MshvMemorySlot *slot;
-    MshvMemorySlotManager *manager = &mshv_state->msm;
+    int ret = 0;
 
-    assert(manager);
-
-    QEMU_LOCK_GUARD(&manager->mutex);
-
-    slot = find_mem_slot_by_region(gpa, size, userspace_addr);
-    if (!slot) {
-        trace_mshv_skip_unset_mem(userspace_addr, gpa, size);
-        /* no work to do */
-        return 0;
-    }
-
-    if (!is_mapped(slot)) {
-        /* remove slot, no need to unmap */
-        return remove_slot(slot);
-    }
-
-    ret = map_or_unmap(vm_fd, slot, false);
-    if (ret < 0) {
-        error_report("failed to unmap memory region");
-        return ret;
-    }
-    return remove_slot(slot);
-}
-
-static int tracked_map(int vm_fd, uint64_t gpa, uint64_t size, bool readonly,
-                       uint64_t userspace_addr)
-{
-    MshvMemorySlot *slot, *overlap_slot;
-    int ret;
-    MshvMemorySlotManager *manager = &mshv_state->msm;
-
-    assert(manager);
-
-    QEMU_LOCK_GUARD(&manager->mutex);
-
-    slot = find_mem_slot_by_region(gpa, size, userspace_addr);
-    if (slot) {
-        error_report("memory region already mapped at gpa=0x%lx, "
-                     "userspace_addr=0x%lx, size=0x%lx",
-                     slot->guest_phys_addr, slot->userspace_addr,
-                     slot->memory_size);
+    if (!mshv_mr) {
+        error_report("Invalid mshv_mr");
         return -1;
     }
 
-    slot = append_slot(gpa, userspace_addr, size, readonly);
-
-    overlap_slot = find_overlap_mem_slot(manager->slots, slot);
-    if (overlap_slot) {
-        trace_mshv_remap_attempt(slot->userspace_addr,
-                                 slot->guest_phys_addr,
-                                 slot->memory_size);
-        warn_report("attempt to map region [0x%lx-0x%lx], while "
-                    "[0x%lx-0x%lx] is already mapped in the guest",
-                    userspace_addr, userspace_addr + size - 1,
-                    overlap_slot->userspace_addr,
-                    overlap_slot->userspace_addr +
-                    overlap_slot->memory_size - 1);
-
-        /* do not register mem slot in hv, but record for later swap-in */
-        set_mapped(slot, false);
-
-        return 0;
-    }
-
-    ret = map_or_unmap(vm_fd, slot, true);
-    if (ret < 0) {
-        error_report("failed to map memory region");
-        return -1;
-    }
-    set_mapped(slot, true);
-
-    return 0;
-}
-
-static int set_memory(uint64_t gpa, uint64_t size, bool readonly,
-                      uint64_t userspace_addr, bool add)
-{
-    int vm_fd = mshv_state->vm;
-
-    if (add) {
-        return tracked_map(vm_fd, gpa, size, readonly, userspace_addr);
-    }
-
-    return tracked_unmap(vm_fd, gpa, size, userspace_addr);
+    trace_mshv_set_memory(add, mshv_mr->guest_phys_addr,
+                          mshv_mr->memory_size,
+                          mshv_mr->userspace_addr, mshv_mr->readonly,
+                          ret);
+    return map_or_unmap(mshv_state->vm, mshv_mr, add);
 }
 
 /*
@@ -514,9 +173,7 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
     bool writable = !area->readonly && !area->rom_device;
     hwaddr start_addr, mr_offset, size;
     void *ram;
-
-    size = align_section(section, &start_addr);
-    trace_mshv_set_phys_mem(add, section->mr->name, start_addr);
+    MshvMemoryRegion mshv_mr = {0};
 
     size = align_section(section, &start_addr);
     trace_mshv_set_phys_mem(add, section->mr->name, start_addr);
@@ -543,21 +200,14 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
 
     ram = memory_region_get_ram_ptr(area) + mr_offset;
 
-    ret = set_memory(start_addr, size, !writable, (uint64_t)ram, add);
+    mshv_mr.guest_phys_addr = start_addr;
+    mshv_mr.memory_size = size;
+    mshv_mr.readonly = !writable;
+    mshv_mr.userspace_addr = (uint64_t)ram;
+
+    ret = set_memory(&mshv_mr, add);
     if (ret < 0) {
-        error_report("failed to set memory region");
+        error_report("Failed to set memory region");
         abort();
     }
 }
-
-void mshv_init_memory_slot_manager(MshvState *mshv_state)
-{
-    MshvMemorySlotManager *manager;
-
-    assert(mshv_state);
-    manager = &mshv_state->msm;
-
-    manager->n_slots = 0;
-    manager->slots = NULL;
-    qemu_mutex_init(&manager->mutex);
-}
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index bed0fa298e6..ddc4c18cba4 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -437,8 +437,6 @@ static int mshv_init(AccelState *as, MachineState *ms)
 
     mshv_init_msicontrol();
 
-    mshv_init_memory_slot_manager(s);
-
     ret = create_vm(mshv_fd, &vm_fd);
     if (ret < 0) {
         close(mshv_fd);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 586383b8820..f5c388eb87c 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1167,43 +1167,6 @@ static int handle_mmio(CPUState *cpu, const struct hyperv_message *msg,
     return 0;
 }
 
-static int handle_unmapped_mem(int vm_fd, CPUState *cpu,
-                               const struct hyperv_message *msg,
-                               MshvVmExit *exit_reason)
-{
-    struct hv_x64_memory_intercept_message info = { 0 };
-    uint64_t gpa;
-    int ret;
-    enum MshvRemapResult remap_result;
-
-    ret = set_memory_info(msg, &info);
-    if (ret < 0) {
-        error_report("failed to convert message to memory info");
-        return -1;
-    }
-
-    gpa = info.guest_physical_address;
-
-    /* attempt to remap the region, in case of overlapping userspace mappings */
-    remap_result = mshv_remap_overlap_region(vm_fd, gpa);
-    *exit_reason = MshvVmExitIgnore;
-
-    switch (remap_result) {
-    case MshvRemapNoMapping:
-        /* if we didn't find a mapping, it is probably mmio */
-        return handle_mmio(cpu, msg, exit_reason);
-    case MshvRemapOk:
-        break;
-    case MshvRemapNoOverlap:
-        /* This should not happen, but we are forgiving it */
-        warn_report("found no overlap for unmapped region");
-        *exit_reason = MshvVmExitSpecial;
-        break;
-    }
-
-    return 0;
-}
-
 static int set_ioport_info(const struct hyperv_message *msg,
                            hv_x64_io_port_intercept_message *info)
 {
@@ -1545,12 +1508,6 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
     case HVMSG_UNRECOVERABLE_EXCEPTION:
         return MshvVmExitShutdown;
     case HVMSG_UNMAPPED_GPA:
-        ret = handle_unmapped_mem(vm_fd, cpu, msg, &exit_reason);
-        if (ret < 0) {
-            error_report("failed to handle unmapped memory");
-            return -1;
-        }
-        return exit_reason;
     case HVMSG_GPA_INTERCEPT:
         ret = handle_mmio(cpu, msg, &exit_reason);
         if (ret < 0) {
diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
index 36f0d59b385..a4dffeb24a3 100644
--- a/accel/mshv/trace-events
+++ b/accel/mshv/trace-events
@@ -26,8 +26,3 @@ mshv_map_memory(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=0x%
 mshv_unmap_memory(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=0x%" PRIx64 " gpa=0x%010" PRIx64 " size=0x%08" PRIx64
 mshv_set_phys_mem(bool add, const char *name, uint64_t gpa) "\tadd=%d name=%s gpa=0x%010" PRIx64
 mshv_handle_mmio(uint64_t gva, uint64_t gpa, uint64_t size, uint8_t access_type) "\tgva=0x%" PRIx64 " gpa=0x%010" PRIx64 " size=0x%" PRIx64 " access_type=%d"
-
-mshv_found_slot(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=0x%" PRIx64 " gpa=0x%010" PRIx64 " size=0x%08" PRIx64
-mshv_skip_unset_mem(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=0x%" PRIx64 " gpa=0x%010" PRIx64 " size=0x%08" PRIx64
-mshv_remap_attempt(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=0x%" PRIx64 " gpa=0x%010" PRIx64 " size=0x%08" PRIx64
-mshv_find_slot_by_gpa(uint64_t gpa) "\tgpa=0x%010" PRIx64
-- 
2.52.0


