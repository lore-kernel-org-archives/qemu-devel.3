Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF896E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 07:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLznp-0007Xk-UZ; Fri, 13 Dec 2024 02:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tLzno-0007XB-2R
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 02:09:32 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tLznf-00071K-N5
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 02:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734073764; x=1765609764;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f3SH0dN9l5XpHOQkWq7GcuZYymqFqU3Q2bWZ4IWC33c=;
 b=c6OnPVrx8m0xZ1RTNJPRsJOSgxlrwx5eXQ8AXs9KwbBV4uDyM7Up6xUG
 TS8FxfgwGlEnuwBXAL57MpZij0oKCEWMqK39nFaKQNoTLfCZPAFiW0bsH
 U8W7BMBNqaFopcHKOhvX9Ap7qkmD34aKi0SQAAf3RPlnXeSxlibI8/NNO
 9MdhZy+8OgDbW4B151ku4REqGxiarn8XjKfF5sPuPny7kBH2ZiXOhs0Bd
 /blvFYTq2gKRVjUw/fz/gMVD5W/mm8/qvHA6POudqLBfrIC69qfB5Omhm
 5uSEs4QpvEqxEDJjGqGDo7vqIOVCupDts78MzxOXIwInD4/MavdoxzxAj g==;
X-CSE-ConnectionGUID: mbH6/IYxSumUHWSORdn65Q==
X-CSE-MsgGUID: 2wKFu47bRE+4qyoF7zz/6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="51937075"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="51937075"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 23:09:23 -0800
X-CSE-ConnectionGUID: IixbyfNwTPSBxOVNMAoO2Q==
X-CSE-MsgGUID: TT8enhCkR7aiPygj5iCDvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="96365549"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 23:09:19 -0800
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Date: Fri, 13 Dec 2024 15:08:44 +0800
Message-ID: <20241213070852.106092-3-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213070852.106092-1-chenyi.qiang@intel.com>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

As the commit 852f0048f3 ("RAMBlock: make guest_memfd require
uncoordinated discard") highlighted, some subsystems like VFIO might
disable ram block discard. However, guest_memfd relies on the discard
operation to perform page conversion between private and shared memory.
This can lead to stale IOMMU mapping issue when assigning a hardware
device to a confidential VM via shared memory (unprotected memory
pages). Blocking shared page discard can solve this problem, but it
could cause guests to consume twice the memory with VFIO, which is not
acceptable in some cases. An alternative solution is to convey other
systems like VFIO to refresh its outdated IOMMU mappings.

RamDiscardManager is an existing concept (used by virtio-mem) to adjust
VFIO mappings in relation to VM page assignment. Effectively page
conversion is similar to hot-removing a page in one mode and adding it
back in the other, so the similar work that needs to happen in response
to virtio-mem changes needs to happen for page conversion events.
Introduce the RamDiscardManager to guest_memfd to achieve it.

However, guest_memfd is not an object so it cannot directly implement
the RamDiscardManager interface.

One solution is to implement the interface in HostMemoryBackend. Any
guest_memfd-backed host memory backend can register itself in the target
MemoryRegion. However, this solution doesn't cover the scenario where a
guest_memfd MemoryRegion doesn't belong to the HostMemoryBackend, e.g.
the virtual BIOS MemoryRegion.

Thus, choose the second option, i.e. define an object type named
guest_memfd_manager with RamDiscardManager interface. Upon creation of
guest_memfd, a new guest_memfd_manager object can be instantiated and
registered to the managed guest_memfd MemoryRegion to handle the page
conversion events.

In the context of guest_memfd, the discarded state signifies that the
page is private, while the populated state indicated that the page is
shared. The state of the memory is tracked at the granularity of the
host page size (i.e. block_size), as the minimum conversion size can be
one page per request.

In addition, VFIO expects the DMA mapping for a specific iova to be
mapped and unmapped with the same granularity. However, the confidential
VMs may do partial conversion, e.g. conversion happens on a small region
within a large region. To prevent such invalid cases and before any
potential optimization comes out, all operations are performed with 4K
granularity.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 include/sysemu/guest-memfd-manager.h |  46 +++++
 system/guest-memfd-manager.c         | 250 +++++++++++++++++++++++++++
 system/meson.build                   |   1 +
 3 files changed, 297 insertions(+)
 create mode 100644 include/sysemu/guest-memfd-manager.h
 create mode 100644 system/guest-memfd-manager.c

diff --git a/include/sysemu/guest-memfd-manager.h b/include/sysemu/guest-memfd-manager.h
new file mode 100644
index 0000000000..ba4a99b614
--- /dev/null
+++ b/include/sysemu/guest-memfd-manager.h
@@ -0,0 +1,46 @@
+/*
+ * QEMU guest memfd manager
+ *
+ * Copyright Intel
+ *
+ * Author:
+ *      Chenyi Qiang <chenyi.qiang@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory
+ *
+ */
+
+#ifndef SYSEMU_GUEST_MEMFD_MANAGER_H
+#define SYSEMU_GUEST_MEMFD_MANAGER_H
+
+#include "sysemu/hostmem.h"
+
+#define TYPE_GUEST_MEMFD_MANAGER "guest-memfd-manager"
+
+OBJECT_DECLARE_TYPE(GuestMemfdManager, GuestMemfdManagerClass, GUEST_MEMFD_MANAGER)
+
+struct GuestMemfdManager {
+    Object parent;
+
+    /* Managed memory region. */
+    MemoryRegion *mr;
+
+    /*
+     * 1-setting of the bit represents the memory is populated (shared).
+     */
+    int32_t bitmap_size;
+    unsigned long *bitmap;
+
+    /* block size and alignment */
+    uint64_t block_size;
+
+    /* listeners to notify on populate/discard activity. */
+    QLIST_HEAD(, RamDiscardListener) rdl_list;
+};
+
+struct GuestMemfdManagerClass {
+    ObjectClass parent_class;
+};
+
+#endif
diff --git a/system/guest-memfd-manager.c b/system/guest-memfd-manager.c
new file mode 100644
index 0000000000..d7e105fead
--- /dev/null
+++ b/system/guest-memfd-manager.c
@@ -0,0 +1,250 @@
+/*
+ * QEMU guest memfd manager
+ *
+ * Copyright Intel
+ *
+ * Author:
+ *      Chenyi Qiang <chenyi.qiang@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "sysemu/guest-memfd-manager.h"
+
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(GuestMemfdManager,
+                                          guest_memfd_manager,
+                                          GUEST_MEMFD_MANAGER,
+                                          OBJECT,
+                                          { TYPE_RAM_DISCARD_MANAGER },
+                                          { })
+
+static bool guest_memfd_rdm_is_populated(const RamDiscardManager *rdm,
+                                         const MemoryRegionSection *section)
+{
+    const GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(rdm);
+    uint64_t first_bit = section->offset_within_region / gmm->block_size;
+    uint64_t last_bit = first_bit + int128_get64(section->size) / gmm->block_size - 1;
+    unsigned long first_discard_bit;
+
+    first_discard_bit = find_next_zero_bit(gmm->bitmap, last_bit + 1, first_bit);
+    return first_discard_bit > last_bit;
+}
+
+typedef int (*guest_memfd_section_cb)(MemoryRegionSection *s, void *arg);
+
+static int guest_memfd_notify_populate_cb(MemoryRegionSection *section, void *arg)
+{
+    RamDiscardListener *rdl = arg;
+
+    return rdl->notify_populate(rdl, section);
+}
+
+static int guest_memfd_notify_discard_cb(MemoryRegionSection *section, void *arg)
+{
+    RamDiscardListener *rdl = arg;
+
+    rdl->notify_discard(rdl, section);
+
+    return 0;
+}
+
+static int guest_memfd_for_each_populated_section(const GuestMemfdManager *gmm,
+                                                  MemoryRegionSection *section,
+                                                  void *arg,
+                                                  guest_memfd_section_cb cb)
+{
+    unsigned long first_one_bit, last_one_bit;
+    uint64_t offset, size;
+    int ret = 0;
+
+    first_one_bit = section->offset_within_region / gmm->block_size;
+    first_one_bit = find_next_bit(gmm->bitmap, gmm->bitmap_size, first_one_bit);
+
+    while (first_one_bit < gmm->bitmap_size) {
+        MemoryRegionSection tmp = *section;
+
+        offset = first_one_bit * gmm->block_size;
+        last_one_bit = find_next_zero_bit(gmm->bitmap, gmm->bitmap_size,
+                                          first_one_bit + 1) - 1;
+        size = (last_one_bit - first_one_bit + 1) * gmm->block_size;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            break;
+        }
+
+        ret = cb(&tmp, arg);
+        if (ret) {
+            break;
+        }
+
+        first_one_bit = find_next_bit(gmm->bitmap, gmm->bitmap_size,
+                                      last_one_bit + 2);
+    }
+
+    return ret;
+}
+
+static int guest_memfd_for_each_discarded_section(const GuestMemfdManager *gmm,
+                                                  MemoryRegionSection *section,
+                                                  void *arg,
+                                                  guest_memfd_section_cb cb)
+{
+    unsigned long first_zero_bit, last_zero_bit;
+    uint64_t offset, size;
+    int ret = 0;
+
+    first_zero_bit = section->offset_within_region / gmm->block_size;
+    first_zero_bit = find_next_zero_bit(gmm->bitmap, gmm->bitmap_size,
+                                        first_zero_bit);
+
+    while (first_zero_bit < gmm->bitmap_size) {
+        MemoryRegionSection tmp = *section;
+
+        offset = first_zero_bit * gmm->block_size;
+        last_zero_bit = find_next_bit(gmm->bitmap, gmm->bitmap_size,
+                                      first_zero_bit + 1) - 1;
+        size = (last_zero_bit - first_zero_bit + 1) * gmm->block_size;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            break;
+        }
+
+        ret = cb(&tmp, arg);
+        if (ret) {
+            break;
+        }
+
+        first_zero_bit = find_next_zero_bit(gmm->bitmap, gmm->bitmap_size,
+                                            last_zero_bit + 2);
+    }
+
+    return ret;
+}
+
+static uint64_t guest_memfd_rdm_get_min_granularity(const RamDiscardManager *rdm,
+                                                    const MemoryRegion *mr)
+{
+    GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(rdm);
+
+    g_assert(mr == gmm->mr);
+    return gmm->block_size;
+}
+
+static void guest_memfd_rdm_register_listener(RamDiscardManager *rdm,
+                                              RamDiscardListener *rdl,
+                                              MemoryRegionSection *section)
+{
+    GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(rdm);
+    int ret;
+
+    g_assert(section->mr == gmm->mr);
+    rdl->section = memory_region_section_new_copy(section);
+
+    QLIST_INSERT_HEAD(&gmm->rdl_list, rdl, next);
+
+    ret = guest_memfd_for_each_populated_section(gmm, section, rdl,
+                                                 guest_memfd_notify_populate_cb);
+    if (ret) {
+        error_report("%s: Failed to register RAM discard listener: %s", __func__,
+                     strerror(-ret));
+    }
+}
+
+static void guest_memfd_rdm_unregister_listener(RamDiscardManager *rdm,
+                                                RamDiscardListener *rdl)
+{
+    GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(rdm);
+    int ret;
+
+    g_assert(rdl->section);
+    g_assert(rdl->section->mr == gmm->mr);
+
+    ret = guest_memfd_for_each_populated_section(gmm, rdl->section, rdl,
+                                                 guest_memfd_notify_discard_cb);
+    if (ret) {
+        error_report("%s: Failed to unregister RAM discard listener: %s", __func__,
+                     strerror(-ret));
+    }
+
+    memory_region_section_free_copy(rdl->section);
+    rdl->section = NULL;
+    QLIST_REMOVE(rdl, next);
+
+}
+
+typedef struct GuestMemfdReplayData {
+    void *fn;
+    void *opaque;
+} GuestMemfdReplayData;
+
+static int guest_memfd_rdm_replay_populated_cb(MemoryRegionSection *section, void *arg)
+{
+    struct GuestMemfdReplayData *data = arg;
+    ReplayRamPopulate replay_fn = data->fn;
+
+    return replay_fn(section, data->opaque);
+}
+
+static int guest_memfd_rdm_replay_populated(const RamDiscardManager *rdm,
+                                            MemoryRegionSection *section,
+                                            ReplayRamPopulate replay_fn,
+                                            void *opaque)
+{
+    GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(rdm);
+    struct GuestMemfdReplayData data = { .fn = replay_fn, .opaque = opaque };
+
+    g_assert(section->mr == gmm->mr);
+    return guest_memfd_for_each_populated_section(gmm, section, &data,
+                                                  guest_memfd_rdm_replay_populated_cb);
+}
+
+static int guest_memfd_rdm_replay_discarded_cb(MemoryRegionSection *section, void *arg)
+{
+    struct GuestMemfdReplayData *data = arg;
+    ReplayRamDiscard replay_fn = data->fn;
+
+    replay_fn(section, data->opaque);
+
+    return 0;
+}
+
+static void guest_memfd_rdm_replay_discarded(const RamDiscardManager *rdm,
+                                             MemoryRegionSection *section,
+                                             ReplayRamDiscard replay_fn,
+                                             void *opaque)
+{
+    GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(rdm);
+    struct GuestMemfdReplayData data = { .fn = replay_fn, .opaque = opaque };
+
+    g_assert(section->mr == gmm->mr);
+    guest_memfd_for_each_discarded_section(gmm, section, &data,
+                                           guest_memfd_rdm_replay_discarded_cb);
+}
+
+static void guest_memfd_manager_init(Object *obj)
+{
+    GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(obj);
+
+    QLIST_INIT(&gmm->rdl_list);
+}
+
+static void guest_memfd_manager_finalize(Object *obj)
+{
+    g_free(GUEST_MEMFD_MANAGER(obj)->bitmap);
+}
+
+static void guest_memfd_manager_class_init(ObjectClass *oc, void *data)
+{
+    RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(oc);
+
+    rdmc->get_min_granularity = guest_memfd_rdm_get_min_granularity;
+    rdmc->register_listener = guest_memfd_rdm_register_listener;
+    rdmc->unregister_listener = guest_memfd_rdm_unregister_listener;
+    rdmc->is_populated = guest_memfd_rdm_is_populated;
+    rdmc->replay_populated = guest_memfd_rdm_replay_populated;
+    rdmc->replay_discarded = guest_memfd_rdm_replay_discarded;
+}
diff --git a/system/meson.build b/system/meson.build
index 4952f4b2c7..ed4e1137bd 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -15,6 +15,7 @@ system_ss.add(files(
   'dirtylimit.c',
   'dma-helpers.c',
   'globals.c',
+  'guest-memfd-manager.c',
   'memory_mapping.c',
   'qdev-monitor.c',
   'qtest.c',
-- 
2.43.5


