Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96134C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwLI-00035X-Kx; Mon, 17 Feb 2025 03:19:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tjwLG-00030b-3Z
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:02 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tjwLD-00015F-B1
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739780339; x=1771316339;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s6pqC5vUpmDBSKOPqcIdeYtY5SKjjfh0VkIpfTUsAwE=;
 b=EeJcIjVqEbywJbCh/uHPHXsLP99fJSzinTEHQeRaKK+P14bBCUH6Z6sW
 s+ghCFOTYeTyIHXKFCv2opXhdeUIjreUUM9364XeYoZrcmOkqtzwR3BpT
 W3wMBiwaIeAyyAxwfPiv3iWho76X3RGywOCdyLlI6U1nWBM/sl9NbgvfK
 Uz9SV/bkMOOeC7+s2EhztYqzbGkPTkTdKxBte8VynxJqwG5gxJkfsM3mH
 N7SzG3J+7FK/T8JDIrjZ/q992LMWO2b/I1JJdLxnxNEzG5Ag/hws3vcg6
 +S4QV8BVJJVWv4hiuq0RNw/YpLoGR16Zw3o5CmYu+3H30wSiueMftU9id g==;
X-CSE-ConnectionGUID: LgnNeVv6QCu0f26OoBn5gQ==
X-CSE-MsgGUID: IpsRTTCRQAea7sQo263g2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="50668985"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; d="scan'208";a="50668985"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 00:18:58 -0800
X-CSE-ConnectionGUID: d/k2H8RBTby5fb9aR2w1yA==
X-CSE-MsgGUID: +c31eibPQwKxlZJH4fjoJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118690199"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 00:18:55 -0800
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v2 3/6] memory-attribute-manager: Introduce
 MemoryAttributeManager to manage RAMBLock with guest_memfd
Date: Mon, 17 Feb 2025 16:18:22 +0800
Message-ID: <20250217081833.21568-4-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250217081833.21568-1-chenyi.qiang@intel.com>
References: <20250217081833.21568-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
uncoordinated discard") highlighted, some subsystems like VFIO may
disable ram block discard. However, guest_memfd relies on the discard
operation to perform page conversion between private and shared memory.
This can lead to stale IOMMU mapping issue when assigning a hardware
device to a confidential VM via shared memory. To address this, it is
crucial to ensure systems like VFIO refresh its IOMMU mappings.

RamDiscardManager is an existing concept (used by virtio-mem) to adjust
VFIO mappings in relation to VM page assignment. Effectively page
conversion is similar to hot-removing a page in one mode and adding it
back in the other. Therefore, similar actions are required for page
conversion events. Introduce the RamDiscardManager to guest_memfd to
facilitate this process.

Since guest_memfd is not an object, it cannot directly implement the
RamDiscardManager interface. One potential attempt is to implement it in
HostMemoryBackend. This is not appropriate because guest_memfd is per
RAMBlock. Some RAMBlocks have a memory backend but others do not. In
particular, the ones like virtual BIOS calling
memory_region_init_ram_guest_memfd() do not.

To manage the RAMBlocks with guest_memfd, define a new object named
MemoryAttributeManager to implement the RamDiscardManager interface. The
object stores guest_memfd information such as shared_bitmap, and handles
page conversion notification. Using the name of MemoryAttributeManager is
aimed to make it more generic. The term "Memory" emcompasses not only RAM
but also private MMIO in TEE I/O, which might rely on this
object/interface to handle page conversion events in the future. The
term "Attribute" allows for the management of various attributes beyond
shared and private. For instance, it could support scenarios where
discard vs. populated and shared vs. private states co-exists, such as
supporting virtio-mem or something similar in the future.

In the current context, MemoryAttributeManager signifies discarded state
as private and populated state as shared. Memory state is tracked at the
host page size granularity, as the minimum memory conversion size can be one
page per request. Additionally, VFIO expects the DMA mapping for a
specific iova to be mapped and unmapped with the same granularity.
Confidential VMs may perform  partial conversions, e.g. conversion
happens on a small region within a large region. To prevent such invalid
cases and until cut_mapping operation support is introduced, all
operations are performed with 4K granularity.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v2:
    - Rename the object name to MemoryAttributeManager
    - Rename the bitmap to shared_bitmap to make it more clear.
    - Remove block_size field and get it from a helper. In future, we
      can get the page_size from RAMBlock if necessary.
    - Remove the unncessary "struct" before GuestMemfdReplayData
    - Remove the unncessary g_free() for the bitmap
    - Add some error report when the callback failure for
      populated/discarded section.
    - Move the realize()/unrealize() definition to this patch.
---
 include/system/memory-attribute-manager.h |  42 ++++
 system/memory-attribute-manager.c         | 292 ++++++++++++++++++++++
 system/meson.build                        |   1 +
 3 files changed, 335 insertions(+)
 create mode 100644 include/system/memory-attribute-manager.h
 create mode 100644 system/memory-attribute-manager.c

diff --git a/include/system/memory-attribute-manager.h b/include/system/memory-attribute-manager.h
new file mode 100644
index 0000000000..72adc0028e
--- /dev/null
+++ b/include/system/memory-attribute-manager.h
@@ -0,0 +1,42 @@
+/*
+ * QEMU memory attribute manager
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
+#ifndef SYSTEM_MEMORY_ATTRIBUTE_MANAGER_H
+#define SYSTEM_MEMORY_ATTRIBUTE_MANAGER_H
+
+#include "system/hostmem.h"
+
+#define TYPE_MEMORY_ATTRIBUTE_MANAGER "memory-attribute-manager"
+
+OBJECT_DECLARE_TYPE(MemoryAttributeManager, MemoryAttributeManagerClass, MEMORY_ATTRIBUTE_MANAGER)
+
+struct MemoryAttributeManager {
+    Object parent;
+
+    MemoryRegion *mr;
+
+    /* 1-setting of the bit represents the memory is populated (shared) */
+    int32_t bitmap_size;
+    unsigned long *shared_bitmap;
+
+    QLIST_HEAD(, RamDiscardListener) rdl_list;
+};
+
+struct MemoryAttributeManagerClass {
+    ObjectClass parent_class;
+};
+
+int memory_attribute_manager_realize(MemoryAttributeManager *mgr, MemoryRegion *mr);
+void memory_attribute_manager_unrealize(MemoryAttributeManager *mgr);
+
+#endif
diff --git a/system/memory-attribute-manager.c b/system/memory-attribute-manager.c
new file mode 100644
index 0000000000..ed97e43dd0
--- /dev/null
+++ b/system/memory-attribute-manager.c
@@ -0,0 +1,292 @@
+/*
+ * QEMU memory attribute manager
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
+#include "system/memory-attribute-manager.h"
+
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(MemoryAttributeManager,
+                                   memory_attribute_manager,
+                                   MEMORY_ATTRIBUTE_MANAGER,
+                                   OBJECT,
+                                   { TYPE_RAM_DISCARD_MANAGER },
+                                   { })
+
+static int memory_attribute_manager_get_block_size(const MemoryAttributeManager *mgr)
+{
+    /*
+     * Because page conversion could be manipulated in the size of at least 4K or 4K aligned,
+     * Use the host page size as the granularity to track the memory attribute.
+     * TODO: if necessary, switch to get the page_size from RAMBlock.
+     * i.e. mgr->mr->ram_block->page_size.
+     */
+    return qemu_real_host_page_size();
+}
+
+
+static bool memory_attribute_rdm_is_populated(const RamDiscardManager *rdm,
+                                              const MemoryRegionSection *section)
+{
+    const MemoryAttributeManager *mgr = MEMORY_ATTRIBUTE_MANAGER(rdm);
+    int block_size = memory_attribute_manager_get_block_size(mgr);
+    uint64_t first_bit = section->offset_within_region / block_size;
+    uint64_t last_bit = first_bit + int128_get64(section->size) / block_size - 1;
+    unsigned long first_discard_bit;
+
+    first_discard_bit = find_next_zero_bit(mgr->shared_bitmap, last_bit + 1, first_bit);
+    return first_discard_bit > last_bit;
+}
+
+typedef int (*memory_attribute_section_cb)(MemoryRegionSection *s, void *arg);
+
+static int memory_attribute_notify_populate_cb(MemoryRegionSection *section, void *arg)
+{
+    RamDiscardListener *rdl = arg;
+
+    return rdl->notify_populate(rdl, section);
+}
+
+static int memory_attribute_notify_discard_cb(MemoryRegionSection *section, void *arg)
+{
+    RamDiscardListener *rdl = arg;
+
+    rdl->notify_discard(rdl, section);
+
+    return 0;
+}
+
+static int memory_attribute_for_each_populated_section(const MemoryAttributeManager *mgr,
+                                                       MemoryRegionSection *section,
+                                                       void *arg,
+                                                       memory_attribute_section_cb cb)
+{
+    unsigned long first_one_bit, last_one_bit;
+    uint64_t offset, size;
+    int block_size = memory_attribute_manager_get_block_size(mgr);
+    int ret = 0;
+
+    first_one_bit = section->offset_within_region / block_size;
+    first_one_bit = find_next_bit(mgr->shared_bitmap, mgr->bitmap_size, first_one_bit);
+
+    while (first_one_bit < mgr->bitmap_size) {
+        MemoryRegionSection tmp = *section;
+
+        offset = first_one_bit * block_size;
+        last_one_bit = find_next_zero_bit(mgr->shared_bitmap, mgr->bitmap_size,
+                                          first_one_bit + 1) - 1;
+        size = (last_one_bit - first_one_bit + 1) * block_size;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            break;
+        }
+
+        ret = cb(&tmp, arg);
+        if (ret) {
+            error_report("%s: Failed to notify RAM discard listener: %s", __func__,
+                         strerror(-ret));
+            break;
+        }
+
+        first_one_bit = find_next_bit(mgr->shared_bitmap, mgr->bitmap_size,
+                                      last_one_bit + 2);
+    }
+
+    return ret;
+}
+
+static int memory_attribute_for_each_discarded_section(const MemoryAttributeManager *mgr,
+                                                       MemoryRegionSection *section,
+                                                       void *arg,
+                                                       memory_attribute_section_cb cb)
+{
+    unsigned long first_zero_bit, last_zero_bit;
+    uint64_t offset, size;
+    int block_size = memory_attribute_manager_get_block_size(mgr);
+    int ret = 0;
+
+    first_zero_bit = section->offset_within_region / block_size;
+    first_zero_bit = find_next_zero_bit(mgr->shared_bitmap, mgr->bitmap_size,
+                                        first_zero_bit);
+
+    while (first_zero_bit < mgr->bitmap_size) {
+        MemoryRegionSection tmp = *section;
+
+        offset = first_zero_bit * block_size;
+        last_zero_bit = find_next_bit(mgr->shared_bitmap, mgr->bitmap_size,
+                                      first_zero_bit + 1) - 1;
+        size = (last_zero_bit - first_zero_bit + 1) * block_size;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            break;
+        }
+
+        ret = cb(&tmp, arg);
+        if (ret) {
+            error_report("%s: Failed to notify RAM discard listener: %s", __func__,
+                         strerror(-ret));
+            break;
+        }
+
+        first_zero_bit = find_next_zero_bit(mgr->shared_bitmap, mgr->bitmap_size,
+                                            last_zero_bit + 2);
+    }
+
+    return ret;
+}
+
+static uint64_t memory_attribute_rdm_get_min_granularity(const RamDiscardManager *rdm,
+                                                         const MemoryRegion *mr)
+{
+    MemoryAttributeManager *mgr = MEMORY_ATTRIBUTE_MANAGER(rdm);
+
+    g_assert(mr == mgr->mr);
+    return memory_attribute_manager_get_block_size(mgr);
+}
+
+static void memory_attribute_rdm_register_listener(RamDiscardManager *rdm,
+                                                   RamDiscardListener *rdl,
+                                                   MemoryRegionSection *section)
+{
+    MemoryAttributeManager *mgr = MEMORY_ATTRIBUTE_MANAGER(rdm);
+    int ret;
+
+    g_assert(section->mr == mgr->mr);
+    rdl->section = memory_region_section_new_copy(section);
+
+    QLIST_INSERT_HEAD(&mgr->rdl_list, rdl, next);
+
+    ret = memory_attribute_for_each_populated_section(mgr, section, rdl,
+                                                      memory_attribute_notify_populate_cb);
+    if (ret) {
+        error_report("%s: Failed to register RAM discard listener: %s", __func__,
+                     strerror(-ret));
+    }
+}
+
+static void memory_attribute_rdm_unregister_listener(RamDiscardManager *rdm,
+                                                     RamDiscardListener *rdl)
+{
+    MemoryAttributeManager *mgr = MEMORY_ATTRIBUTE_MANAGER(rdm);
+    int ret;
+
+    g_assert(rdl->section);
+    g_assert(rdl->section->mr == mgr->mr);
+
+    ret = memory_attribute_for_each_populated_section(mgr, rdl->section, rdl,
+                                                      memory_attribute_notify_discard_cb);
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
+typedef struct MemoryAttributeReplayData {
+    void *fn;
+    void *opaque;
+} MemoryAttributeReplayData;
+
+static int memory_attribute_rdm_replay_populated_cb(MemoryRegionSection *section, void *arg)
+{
+    MemoryAttributeReplayData *data = arg;
+
+    return ((ReplayRamPopulate)data->fn)(section, data->opaque);
+}
+
+static int memory_attribute_rdm_replay_populated(const RamDiscardManager *rdm,
+                                                 MemoryRegionSection *section,
+                                                 ReplayRamPopulate replay_fn,
+                                                 void *opaque)
+{
+    MemoryAttributeManager *mgr = MEMORY_ATTRIBUTE_MANAGER(rdm);
+    MemoryAttributeReplayData data = { .fn = replay_fn, .opaque = opaque };
+
+    g_assert(section->mr == mgr->mr);
+    return memory_attribute_for_each_populated_section(mgr, section, &data,
+                                                       memory_attribute_rdm_replay_populated_cb);
+}
+
+static int memory_attribute_rdm_replay_discarded_cb(MemoryRegionSection *section, void *arg)
+{
+    MemoryAttributeReplayData *data = arg;
+
+    ((ReplayRamDiscard)data->fn)(section, data->opaque);
+    return 0;
+}
+
+static void memory_attribute_rdm_replay_discarded(const RamDiscardManager *rdm,
+                                                  MemoryRegionSection *section,
+                                                  ReplayRamDiscard replay_fn,
+                                                  void *opaque)
+{
+    MemoryAttributeManager *mgr = MEMORY_ATTRIBUTE_MANAGER(rdm);
+    MemoryAttributeReplayData data = { .fn = replay_fn, .opaque = opaque };
+
+    g_assert(section->mr == mgr->mr);
+    memory_attribute_for_each_discarded_section(mgr, section, &data,
+                                                memory_attribute_rdm_replay_discarded_cb);
+}
+
+int memory_attribute_manager_realize(MemoryAttributeManager *mgr, MemoryRegion *mr)
+{
+    uint64_t bitmap_size;
+    int block_size = memory_attribute_manager_get_block_size(mgr);
+    int ret;
+
+    bitmap_size = ROUND_UP(mr->size, block_size) / block_size;
+
+    mgr->mr = mr;
+    mgr->bitmap_size = bitmap_size;
+    mgr->shared_bitmap = bitmap_new(bitmap_size);
+
+    ret = memory_region_set_ram_discard_manager(mgr->mr, RAM_DISCARD_MANAGER(mgr));
+    if (ret) {
+        g_free(mgr->shared_bitmap);
+    }
+
+    return ret;
+}
+
+void memory_attribute_manager_unrealize(MemoryAttributeManager *mgr)
+{
+    memory_region_set_ram_discard_manager(mgr->mr, NULL);
+
+    g_free(mgr->shared_bitmap);
+}
+
+static void memory_attribute_manager_init(Object *obj)
+{
+    MemoryAttributeManager *mgr = MEMORY_ATTRIBUTE_MANAGER(obj);
+
+    QLIST_INIT(&mgr->rdl_list);
+}
+
+static void memory_attribute_manager_finalize(Object *obj)
+{
+}
+
+static void memory_attribute_manager_class_init(ObjectClass *oc, void *data)
+{
+    RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(oc);
+
+    rdmc->get_min_granularity = memory_attribute_rdm_get_min_granularity;
+    rdmc->register_listener = memory_attribute_rdm_register_listener;
+    rdmc->unregister_listener = memory_attribute_rdm_unregister_listener;
+    rdmc->is_populated = memory_attribute_rdm_is_populated;
+    rdmc->replay_populated = memory_attribute_rdm_replay_populated;
+    rdmc->replay_discarded = memory_attribute_rdm_replay_discarded;
+}
diff --git a/system/meson.build b/system/meson.build
index 4952f4b2c7..ab07ff1442 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -15,6 +15,7 @@ system_ss.add(files(
   'dirtylimit.c',
   'dma-helpers.c',
   'globals.c',
+  'memory-attribute-manager.c',
   'memory_mapping.c',
   'qdev-monitor.c',
   'qtest.c',
-- 
2.43.5


