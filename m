Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECC2C021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwLJ-000363-Od; Mon, 17 Feb 2025 03:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tjwLI-00035i-Gq
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:04 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tjwLG-00015l-CP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739780342; x=1771316342;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fgikP9pCs5jC0lyoad1drlNUfTByGFH9gXJjN5Ul2t0=;
 b=BsOIwMnfLhRmMLXcoAZPvTqa/1RJiZNGAHNKOZJL9oLK60EXBtoAtjJN
 M3lC8R7H+or3gL8oPVhKW3yFA73E1ismJkRrQEFCXgcbHY6Cc582vvPrr
 LmUu/WTVHZGYjt3M3F8DsiUx/ldASRqLH5rrHAmJ5mLnjtcAYQQjOlEWt
 +zgUG83Rqv/SqewJ4AubWeY3JGgjI5ICVQ7+wgZGFob0vm5+NpFo4Pl+G
 xIzzu8DIN6nK2ykEIvohPKIjrMMm9v1irlP7MoafjteAT4e7Bw6x6PQAw
 ysPVmv2oM7hm90UTOpNf5lhOz6I6lCyJXxXN4jzsUk3K3Pck7i02KOou0 w==;
X-CSE-ConnectionGUID: 9WR2EyTeQHeHv9pzZWyBUQ==
X-CSE-MsgGUID: EFwQk2I0TqWFzzaYCMD7BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="50668994"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; d="scan'208";a="50668994"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 00:19:01 -0800
X-CSE-ConnectionGUID: 4++vfEfLQc+TGqj/kWLFbw==
X-CSE-MsgGUID: nF3NBRcjRM+gJeJNBwQ0gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118690233"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 00:18:58 -0800
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v2 4/6] memory-attribute-manager: Introduce a callback to
 notify the shared/private state change
Date: Mon, 17 Feb 2025 16:18:23 +0800
Message-ID: <20250217081833.21568-5-chenyi.qiang@intel.com>
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

Introduce a new state_change() callback in MemoryAttributeManagerClass to
efficiently notify all registered RamDiscardListeners, including VFIO
listeners about the memory conversion events in guest_memfd. The
existing VFIO listener can dynamically DMA map/unmap the shared pages
based on conversion types:
- For conversions from shared to private, the VFIO system ensures the
  discarding of shared mapping from the IOMMU.
- For conversions from private to shared, it triggers the population of
  the shared mapping into the IOMMU.

Additionally, there could be some special conversion requests:
- When a conversion request is made for a page already in the desired
  state, the helper simply returns success.
- For requests involving a range partially in the desired state, only
  the necessary segments are converted, ensuring the entire range
  complies with the request efficiently.
- In scenarios where a conversion request is declined by other systems,
  such as a failure from VFIO during notify_populate(), the helper will
  roll back the request, maintaining consistency.

Opportunistically introduce a helper to trigger the state_change()
callback of the class.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v2:
    - Do the alignment changes due to the rename to MemoryAttributeManager
    - Move the state_change() helper definition in this patch.
---
 include/system/memory-attribute-manager.h |  20 +++
 system/memory-attribute-manager.c         | 148 ++++++++++++++++++++++
 2 files changed, 168 insertions(+)

diff --git a/include/system/memory-attribute-manager.h b/include/system/memory-attribute-manager.h
index 72adc0028e..c3dab4e47b 100644
--- a/include/system/memory-attribute-manager.h
+++ b/include/system/memory-attribute-manager.h
@@ -34,8 +34,28 @@ struct MemoryAttributeManager {
 
 struct MemoryAttributeManagerClass {
     ObjectClass parent_class;
+
+    int (*state_change)(MemoryAttributeManager *mgr, uint64_t offset, uint64_t size,
+                        bool shared_to_private);
 };
 
+static inline int memory_attribute_manager_state_change(MemoryAttributeManager *mgr, uint64_t offset,
+                                                        uint64_t size, bool shared_to_private)
+{
+    MemoryAttributeManagerClass *klass;
+
+    if (mgr == NULL) {
+        return 0;
+    }
+
+    klass = MEMORY_ATTRIBUTE_MANAGER_GET_CLASS(mgr);
+    if (klass->state_change) {
+        return klass->state_change(mgr, offset, size, shared_to_private);
+    }
+
+    return 0;
+}
+
 int memory_attribute_manager_realize(MemoryAttributeManager *mgr, MemoryRegion *mr);
 void memory_attribute_manager_unrealize(MemoryAttributeManager *mgr);
 
diff --git a/system/memory-attribute-manager.c b/system/memory-attribute-manager.c
index ed97e43dd0..17c70cf677 100644
--- a/system/memory-attribute-manager.c
+++ b/system/memory-attribute-manager.c
@@ -241,6 +241,151 @@ static void memory_attribute_rdm_replay_discarded(const RamDiscardManager *rdm,
                                                 memory_attribute_rdm_replay_discarded_cb);
 }
 
+static bool memory_attribute_is_valid_range(MemoryAttributeManager *mgr,
+                                            uint64_t offset, uint64_t size)
+{
+    MemoryRegion *mr = mgr->mr;
+
+    g_assert(mr);
+
+    uint64_t region_size = memory_region_size(mr);
+    int block_size = memory_attribute_manager_get_block_size(mgr);
+
+    if (!QEMU_IS_ALIGNED(offset, block_size)) {
+        return false;
+    }
+    if (offset + size < offset || !size) {
+        return false;
+    }
+    if (offset >= region_size || offset + size > region_size) {
+        return false;
+    }
+    return true;
+}
+
+static void memory_attribute_notify_discard(MemoryAttributeManager *mgr,
+                                            uint64_t offset, uint64_t size)
+{
+    RamDiscardListener *rdl;
+
+    QLIST_FOREACH(rdl, &mgr->rdl_list, next) {
+        MemoryRegionSection tmp = *rdl->section;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            continue;
+        }
+
+        memory_attribute_for_each_populated_section(mgr, &tmp, rdl,
+                                                    memory_attribute_notify_discard_cb);
+    }
+}
+
+static int memory_attribute_notify_populate(MemoryAttributeManager *mgr,
+                                            uint64_t offset, uint64_t size)
+{
+    RamDiscardListener *rdl, *rdl2;
+    int ret = 0;
+
+    QLIST_FOREACH(rdl, &mgr->rdl_list, next) {
+        MemoryRegionSection tmp = *rdl->section;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            continue;
+        }
+
+        ret = memory_attribute_for_each_discarded_section(mgr, &tmp, rdl,
+                                                          memory_attribute_notify_populate_cb);
+        if (ret) {
+            break;
+        }
+    }
+
+    if (ret) {
+        /* Notify all already-notified listeners. */
+        QLIST_FOREACH(rdl2, &mgr->rdl_list, next) {
+            MemoryRegionSection tmp = *rdl2->section;
+
+            if (rdl2 == rdl) {
+                break;
+            }
+            if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+                continue;
+            }
+
+            memory_attribute_for_each_discarded_section(mgr, &tmp, rdl2,
+                                                        memory_attribute_notify_discard_cb);
+        }
+    }
+    return ret;
+}
+
+static bool memory_attribute_is_range_populated(MemoryAttributeManager *mgr,
+                                                uint64_t offset, uint64_t size)
+{
+    int block_size = memory_attribute_manager_get_block_size(mgr);
+    const unsigned long first_bit = offset / block_size;
+    const unsigned long last_bit = first_bit + (size / block_size) - 1;
+    unsigned long found_bit;
+
+    /* We fake a shorter bitmap to avoid searching too far. */
+    found_bit = find_next_zero_bit(mgr->shared_bitmap, last_bit + 1, first_bit);
+    return found_bit > last_bit;
+}
+
+static bool memory_attribute_is_range_discarded(MemoryAttributeManager *mgr,
+                                                uint64_t offset, uint64_t size)
+{
+    int block_size = memory_attribute_manager_get_block_size(mgr);
+    const unsigned long first_bit = offset / block_size;
+    const unsigned long last_bit = first_bit + (size / block_size) - 1;
+    unsigned long found_bit;
+
+    /* We fake a shorter bitmap to avoid searching too far. */
+    found_bit = find_next_bit(mgr->shared_bitmap, last_bit + 1, first_bit);
+    return found_bit > last_bit;
+}
+
+static int memory_attribute_state_change(MemoryAttributeManager *mgr, uint64_t offset,
+                                         uint64_t size, bool shared_to_private)
+{
+    int block_size = memory_attribute_manager_get_block_size(mgr);
+    int ret = 0;
+
+    if (!memory_attribute_is_valid_range(mgr, offset, size)) {
+        error_report("%s, invalid range: offset 0x%lx, size 0x%lx",
+                     __func__, offset, size);
+        return -1;
+    }
+
+    if ((shared_to_private && memory_attribute_is_range_discarded(mgr, offset, size)) ||
+        (!shared_to_private && memory_attribute_is_range_populated(mgr, offset, size))) {
+        return 0;
+    }
+
+    if (shared_to_private) {
+        memory_attribute_notify_discard(mgr, offset, size);
+    } else {
+        ret = memory_attribute_notify_populate(mgr, offset, size);
+    }
+
+    if (!ret) {
+        unsigned long first_bit = offset / block_size;
+        unsigned long nbits = size / block_size;
+
+        g_assert((first_bit + nbits) <= mgr->bitmap_size);
+
+        if (shared_to_private) {
+            bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
+        } else {
+            bitmap_set(mgr->shared_bitmap, first_bit, nbits);
+        }
+
+        return 0;
+    }
+
+    return ret;
+}
+
 int memory_attribute_manager_realize(MemoryAttributeManager *mgr, MemoryRegion *mr)
 {
     uint64_t bitmap_size;
@@ -281,8 +426,11 @@ static void memory_attribute_manager_finalize(Object *obj)
 
 static void memory_attribute_manager_class_init(ObjectClass *oc, void *data)
 {
+    MemoryAttributeManagerClass *mamc = MEMORY_ATTRIBUTE_MANAGER_CLASS(oc);
     RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(oc);
 
+    mamc->state_change = memory_attribute_state_change;
+
     rdmc->get_min_granularity = memory_attribute_rdm_get_min_granularity;
     rdmc->register_listener = memory_attribute_rdm_register_listener;
     rdmc->unregister_listener = memory_attribute_rdm_unregister_listener;
-- 
2.43.5


