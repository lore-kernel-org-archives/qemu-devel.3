Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76868C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hFc-0001M0-8B; Mon, 07 Apr 2025 03:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hFN-0001JS-Nd
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:50:25 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hFK-0005Qw-AB
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744012219; x=1775548219;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o+a/Hw3O4JaruEHuRPJRaztD3Sx+cvobAeN0HQKIJvQ=;
 b=Tu5tLdILCKhctHYbdkNv+LzRwoPIvUHEw941SC+5x9oekKYnvvY8Q9id
 D8bB33iyD3xy8Ei7hhHCrt3VF4aL0kMeyyPPxbIkM5XTsyFVVgmIgn6k5
 SY2tqn55vGXB8KSV0DVt4idpYK7oCGymO914MH+J3xItBvnnv/YbkTj10
 2G1l/o9u6fLstb4CdBLVvfGNufic14TqEh6s0vKpmFNbXa5SIzmc2dEhU
 FMEYG2Vq7lHnVP1f0c+dle1S9Dfll9tyPO8OD/c49eq2v41thE2fnQTji
 b8FX4+JLdPyttCOgXUkAiv11J03F+1H/hslJLncjZ5XZfwdcXbjNe/TUO Q==;
X-CSE-ConnectionGUID: JJDlwF9dRAGoVvVLAp2w3w==
X-CSE-MsgGUID: +HCoiyEmTSey6Ga/LjFbig==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="67857562"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="67857562"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:50:18 -0700
X-CSE-ConnectionGUID: ZqAUSgJjSNmFp9U52hhdEg==
X-CSE-MsgGUID: qT3igI5+Ro6ZU3k+HwPskw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="128405652"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:50:14 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v4 08/13] ram-block-attribute: Introduce a callback to notify
 shared/private state changes
Date: Mon,  7 Apr 2025 15:49:28 +0800
Message-ID: <20250407074939.18657-9-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250407074939.18657-1-chenyi.qiang@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=chenyi.qiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
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

A new state_change() callback is introduced in PrivateSharedManageClass
to efficiently notify all registered PrivateSharedListeners, including
VFIO listeners, about memory conversion events in guest_memfd. The VFIO
listener can dynamically DMA map/unmap shared pages based on conversion
types:
- For conversions from shared to private, the VFIO system ensures the
  discarding of shared mapping from the IOMMU.
- For conversions from private to shared, it triggers the population of
  the shared mapping into the IOMMU.

Additionally, special conversion requests are handled as followed:
- If a conversion request is made for a page already in the desired
  state, the helper simply returns success.
- For requests involving a range partially in the desired state, only
  the necessary segments are converted, ensuring efficient compliance
  with the request. In this case, fallback to "1 block at a time"
  handling so that the range passed to the notify_to_private/shared() is
  always in the desired state.
- If a conversion request is declined by other systems, such as a
  failure from VFIO during notify_to_shared(), the helper rolls back the
  request to maintain consistency. As for notify_to_private() handling,
  failure in VFIO is unexpected, so no error check is performed.

Note that the bitmap status is updated before callbacks, allowing
listeners to handle memory based on the latest status.

Opportunistically, introduce a helper to trigger the state_change()
callback of the class.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v4:
    - Add the state_change() callback in PrivateSharedManagerClass
      instead of the RamBlockAttribute.

Changes in v3:
    - Move the bitmap update before notifier callbacks.
    - Call the notifier callbacks directly in notify_discard/populate()
      with the expectation that the request memory range is in the
      desired attribute.
    - For the case that only partial range in the desire status, handle
      the range with block_size granularity for ease of rollback
      (https://lore.kernel.org/qemu-devel/812768d7-a02d-4b29-95f3-fb7a125cf54e@redhat.com/)

Changes in v2:
    - Do the alignment changes due to the rename to MemoryAttributeManager
    - Move the state_change() helper definition in this patch.
---
 include/exec/memory.h        |   7 ++
 system/memory.c              |  10 ++
 system/ram-block-attribute.c | 191 +++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 08f25e5e84..a61896251c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -780,6 +780,9 @@ struct PrivateSharedListener {
 struct PrivateSharedManagerClass {
     /* private */
     GenericStateManagerClass parent_class;
+
+    int (*state_change)(PrivateSharedManager *mgr, uint64_t offset, uint64_t size,
+                        bool to_private);
 };
 
 static inline void private_shared_listener_init(PrivateSharedListener *psl,
@@ -789,6 +792,10 @@ static inline void private_shared_listener_init(PrivateSharedListener *psl,
     state_change_listener_init(&psl->scl, populate_fn, discard_fn);
 }
 
+int private_shared_manager_state_change(PrivateSharedManager *mgr,
+                                        uint64_t offset, uint64_t size,
+                                        bool to_private);
+
 /**
  * memory_get_xlat_addr: Extract addresses from a TLB entry
  *
diff --git a/system/memory.c b/system/memory.c
index e6e944d9c0..2f6eaf6314 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2206,6 +2206,16 @@ void generic_state_manager_unregister_listener(GenericStateManager *gsm,
     gsmc->unregister_listener(gsm, scl);
 }
 
+int private_shared_manager_state_change(PrivateSharedManager *mgr,
+                                        uint64_t offset, uint64_t size,
+                                        bool to_private)
+{
+    PrivateSharedManagerClass *psmc = PRIVATE_SHARED_MANAGER_GET_CLASS(mgr);
+
+    g_assert(psmc->state_change);
+    return psmc->state_change(mgr, offset, size, to_private);
+}
+
 /* Called with rcu_read_lock held.  */
 bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                           ram_addr_t *ram_addr, bool *read_only,
diff --git a/system/ram-block-attribute.c b/system/ram-block-attribute.c
index 283c03b354..06ed134cda 100644
--- a/system/ram-block-attribute.c
+++ b/system/ram-block-attribute.c
@@ -233,6 +233,195 @@ static int ram_block_attribute_psm_replay_on_private(const GenericStateManager *
                                                         ram_block_attribute_psm_replay_cb);
 }
 
+static bool ram_block_attribute_is_valid_range(RamBlockAttribute *attr,
+                                               uint64_t offset, uint64_t size)
+{
+    MemoryRegion *mr = attr->mr;
+
+    g_assert(mr);
+
+    uint64_t region_size = memory_region_size(mr);
+    int block_size = ram_block_attribute_get_block_size(attr);
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
+static void ram_block_attribute_notify_to_private(RamBlockAttribute *attr,
+                                                  uint64_t offset, uint64_t size)
+{
+    PrivateSharedListener *psl;
+
+    QLIST_FOREACH(psl, &attr->psl_list, next) {
+        StateChangeListener *scl = &psl->scl;
+        MemoryRegionSection tmp = *scl->section;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            continue;
+        }
+        scl->notify_to_state_clear(scl, &tmp);
+    }
+}
+
+static int ram_block_attribute_notify_to_shared(RamBlockAttribute *attr,
+                                                uint64_t offset, uint64_t size)
+{
+    PrivateSharedListener *psl, *psl2;
+    int ret = 0;
+
+    QLIST_FOREACH(psl, &attr->psl_list, next) {
+        StateChangeListener *scl = &psl->scl;
+        MemoryRegionSection tmp = *scl->section;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            continue;
+        }
+        ret = scl->notify_to_state_set(scl, &tmp);
+        if (ret) {
+            break;
+        }
+    }
+
+    if (ret) {
+        /* Notify all already-notified listeners. */
+        QLIST_FOREACH(psl2, &attr->psl_list, next) {
+            StateChangeListener *scl2 = &psl2->scl;
+            MemoryRegionSection tmp = *scl2->section;
+
+            if (psl == psl2) {
+                break;
+            }
+            if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+                continue;
+            }
+            scl2->notify_to_state_clear(scl2, &tmp);
+        }
+    }
+    return ret;
+}
+
+static bool ram_block_attribute_is_range_shared(RamBlockAttribute *attr,
+                                                uint64_t offset, uint64_t size)
+{
+    const int block_size = ram_block_attribute_get_block_size(attr);
+    const unsigned long first_bit = offset / block_size;
+    const unsigned long last_bit = first_bit + (size / block_size) - 1;
+    unsigned long found_bit;
+
+    /* We fake a shorter bitmap to avoid searching too far. */
+    found_bit = find_next_zero_bit(attr->shared_bitmap, last_bit + 1, first_bit);
+    return found_bit > last_bit;
+}
+
+static bool ram_block_attribute_is_range_private(RamBlockAttribute *attr,
+                                                uint64_t offset, uint64_t size)
+{
+    const int block_size = ram_block_attribute_get_block_size(attr);
+    const unsigned long first_bit = offset / block_size;
+    const unsigned long last_bit = first_bit + (size / block_size) - 1;
+    unsigned long found_bit;
+
+    /* We fake a shorter bitmap to avoid searching too far. */
+    found_bit = find_next_bit(attr->shared_bitmap, last_bit + 1, first_bit);
+    return found_bit > last_bit;
+}
+
+static int ram_block_attribute_psm_state_change(PrivateSharedManager *mgr, uint64_t offset,
+                                                uint64_t size, bool to_private)
+{
+    RamBlockAttribute *attr = RAM_BLOCK_ATTRIBUTE(mgr);
+    const int block_size = ram_block_attribute_get_block_size(attr);
+    const unsigned long first_bit = offset / block_size;
+    const unsigned long nbits = size / block_size;
+    const uint64_t end = offset + size;
+    unsigned long bit;
+    uint64_t cur;
+    int ret = 0;
+
+    if (!ram_block_attribute_is_valid_range(attr, offset, size)) {
+        error_report("%s, invalid range: offset 0x%lx, size 0x%lx",
+                     __func__, offset, size);
+        return -1;
+    }
+
+    if (to_private) {
+        if (ram_block_attribute_is_range_private(attr, offset, size)) {
+            /* Already private */
+        } else if (!ram_block_attribute_is_range_shared(attr, offset, size)) {
+            /* Unexpected mixture: process individual blocks */
+            for (cur = offset; cur < end; cur += block_size) {
+                bit = cur / block_size;
+                if (!test_bit(bit, attr->shared_bitmap)) {
+                    continue;
+                }
+                clear_bit(bit, attr->shared_bitmap);
+                ram_block_attribute_notify_to_private(attr, cur, block_size);
+            }
+        } else {
+            /* Completely shared */
+            bitmap_clear(attr->shared_bitmap, first_bit, nbits);
+            ram_block_attribute_notify_to_private(attr, offset, size);
+        }
+    } else {
+        if (ram_block_attribute_is_range_shared(attr, offset, size)) {
+            /* Already shared */
+        } else if (!ram_block_attribute_is_range_private(attr, offset, size)) {
+            /* Unexpected mixture: process individual blocks */
+            unsigned long *modified_bitmap = bitmap_new(nbits);
+
+            for (cur = offset; cur < end; cur += block_size) {
+                bit = cur / block_size;
+                if (test_bit(bit, attr->shared_bitmap)) {
+                    continue;
+                }
+                set_bit(bit, attr->shared_bitmap);
+                ret = ram_block_attribute_notify_to_shared(attr, cur, block_size);
+                if (!ret) {
+                    set_bit(bit - first_bit, modified_bitmap);
+                    continue;
+                }
+                clear_bit(bit, attr->shared_bitmap);
+                break;
+            }
+
+            if (ret) {
+                /*
+                 * Very unexpected: something went wrong. Revert to the old
+                 * state, marking only the blocks as private that we converted
+                 * to shared.
+                 */
+                for (cur = offset; cur < end; cur += block_size) {
+                    bit = cur / block_size;
+                    if (!test_bit(bit - first_bit, modified_bitmap)) {
+                        continue;
+                    }
+                    assert(test_bit(bit, attr->shared_bitmap));
+                    clear_bit(bit, attr->shared_bitmap);
+                    ram_block_attribute_notify_to_private(attr, cur, block_size);
+                }
+            }
+            g_free(modified_bitmap);
+        } else {
+            /* Complete private */
+            bitmap_set(attr->shared_bitmap, first_bit, nbits);
+            ret = ram_block_attribute_notify_to_shared(attr, offset, size);
+            if (ret) {
+                bitmap_clear(attr->shared_bitmap, first_bit, nbits);
+            }
+        }
+    }
+
+    return ret;
+}
+
 int ram_block_attribute_realize(RamBlockAttribute *attr, MemoryRegion *mr)
 {
     uint64_t shared_bitmap_size;
@@ -272,6 +461,7 @@ static void ram_block_attribute_finalize(Object *obj)
 static void ram_block_attribute_class_init(ObjectClass *oc, void *data)
 {
     GenericStateManagerClass *gsmc = GENERIC_STATE_MANAGER_CLASS(oc);
+    PrivateSharedManagerClass *psmc = PRIVATE_SHARED_MANAGER_CLASS(oc);
 
     gsmc->get_min_granularity = ram_block_attribute_psm_get_min_granularity;
     gsmc->register_listener = ram_block_attribute_psm_register_listener;
@@ -279,4 +469,5 @@ static void ram_block_attribute_class_init(ObjectClass *oc, void *data)
     gsmc->is_state_set = ram_block_attribute_psm_is_shared;
     gsmc->replay_on_state_set = ram_block_attribute_psm_replay_on_shared;
     gsmc->replay_on_state_clear = ram_block_attribute_psm_replay_on_private;
+    psmc->state_change = ram_block_attribute_psm_state_change;
 }
-- 
2.43.5


