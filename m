Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B85C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKDz-0004kw-0E; Tue, 20 May 2025 06:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uHKDv-0004hE-TS
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:29:28 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uHKDs-0004hJ-Il
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747736965; x=1779272965;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xjsSyyH/vKZhnfoKeplftZcDafjUAYrMzMyTUKLznE8=;
 b=lWmdQWxvxS+TbNqdDd11iSL0EkipB1RW9Yv7PAGFEbET1cgDaR1YL1uW
 vdOqWowkihjlmj1o0fhbyT78CUMbrfYHMgcOGDEuiL6cMQn0jhHV1Sc3O
 w8NV4q9gEWA8lgJpE7CXq2AF+NlIQHX0AstB2OnFV6BRZTTBVDXtfKPjD
 Rlg8f2U2S+yjhyZifJAet0lRzyxoAkHHFacbJJb2tcvpFem0DisFh1A7L
 89Qf3KtMULRye6iQIQjd3H2O8VmYDpfRmeKtlpMGvNUFRTPA+glOVNm2l
 fqg+Tp2Sofr3Zfu3MA9axJ20Mt7xfHN5DacnWLx0A9SwvE+wkyIOCLOdu A==;
X-CSE-ConnectionGUID: pCEouSRHTJ6sup4l4SPq4Q==
X-CSE-MsgGUID: qj+XW3upRUqc/LoZTa8C7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49566661"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="49566661"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 03:29:23 -0700
X-CSE-ConnectionGUID: Lph/xiMcRAauSxFu6majOw==
X-CSE-MsgGUID: gmuyuwicRxWHnua84DPXKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="144905255"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 03:29:19 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Gao Chao <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v5 05/10] ram-block-attribute: Introduce a helper to notify
 shared/private state changes
Date: Tue, 20 May 2025 18:28:45 +0800
Message-ID: <20250520102856.132417-6-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250520102856.132417-1-chenyi.qiang@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
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

A new state_change() helper is introduced for RamBlockAttribute
to efficiently notify all registered RamDiscardListeners, including
VFIO listeners, about memory conversion events in guest_memfd. The VFIO
listener can dynamically DMA map/unmap shared pages based on conversion
types:
- For conversions from shared to private, the VFIO system ensures the
  discarding of shared mapping from the IOMMU.
- For conversions from private to shared, it triggers the population of
  the shared mapping into the IOMMU.

Currently, memory conversion failures cause QEMU to quit instead of
resuming the guest or retrying the operation. It would be a future work
to add more error handling or rollback mechanisms once conversion
failures are allowed. For example, in-place conversion of guest_memfd
could retry the unmap operation during the conversion from shared to
private. However, for now, keep the complex error handling out of the
picture as it is not required:

- If a conversion request is made for a page already in the desired
  state, the helper simply returns success.
- For requests involving a range partially in the desired state, there
  is no such scenario in practice at present. Simply return error.
- If a conversion request is declined by other systems, such as a
  failure from VFIO during notify_to_populated(), the failure is
  returned directly. As for notify_to_discard(), VFIO cannot fail
  unmap/unpin, so no error is returned.

Note that the bitmap status is updated before callbacks, allowing
listeners to handle memory based on the latest status.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Change in v5:
    - Move the state_change() back to a helper instead of a callback of
      the class since there's no child for the RamBlockAttributeClass.
    - Remove the error handling and move them to an individual patch for
      simple management.

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
 include/system/ramblock.h    |   2 +
 system/ram-block-attribute.c | 134 +++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 09255e8495..270dffb2f3 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -108,6 +108,8 @@ struct RamBlockAttribute {
     QLIST_HEAD(, RamDiscardListener) rdl_list;
 };
 
+int ram_block_attribute_state_change(RamBlockAttribute *attr, uint64_t offset,
+                                     uint64_t size, bool to_private);
 RamBlockAttribute *ram_block_attribute_create(MemoryRegion *mr);
 void ram_block_attribute_destroy(RamBlockAttribute *attr);
 
diff --git a/system/ram-block-attribute.c b/system/ram-block-attribute.c
index 8d4a24738c..f12dd4b881 100644
--- a/system/ram-block-attribute.c
+++ b/system/ram-block-attribute.c
@@ -253,6 +253,140 @@ ram_block_attribute_rdm_replay_discard(const RamDiscardManager *rdm,
                                             ram_block_attribute_rdm_replay_cb);
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
+static void ram_block_attribute_notify_to_discard(RamBlockAttribute *attr,
+                                                  uint64_t offset,
+                                                  uint64_t size)
+{
+    RamDiscardListener *rdl;
+
+    QLIST_FOREACH(rdl, &attr->rdl_list, next) {
+        MemoryRegionSection tmp = *rdl->section;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            continue;
+        }
+        rdl->notify_discard(rdl, &tmp);
+    }
+}
+
+static int
+ram_block_attribute_notify_to_populated(RamBlockAttribute *attr,
+                                        uint64_t offset, uint64_t size)
+{
+    RamDiscardListener *rdl;
+    int ret = 0;
+
+    QLIST_FOREACH(rdl, &attr->rdl_list, next) {
+        MemoryRegionSection tmp = *rdl->section;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            continue;
+        }
+        ret = rdl->notify_populate(rdl, &tmp);
+        if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
+static bool ram_block_attribute_is_range_populated(RamBlockAttribute *attr,
+                                                   uint64_t offset,
+                                                   uint64_t size)
+{
+    const int block_size = ram_block_attribute_get_block_size(attr);
+    const unsigned long first_bit = offset / block_size;
+    const unsigned long last_bit = first_bit + (size / block_size) - 1;
+    unsigned long found_bit;
+
+    /* We fake a shorter bitmap to avoid searching too far. */
+    found_bit = find_next_zero_bit(attr->bitmap, last_bit + 1,
+                                   first_bit);
+    return found_bit > last_bit;
+}
+
+static bool
+ram_block_attribute_is_range_discard(RamBlockAttribute *attr,
+                                     uint64_t offset, uint64_t size)
+{
+    const int block_size = ram_block_attribute_get_block_size(attr);
+    const unsigned long first_bit = offset / block_size;
+    const unsigned long last_bit = first_bit + (size / block_size) - 1;
+    unsigned long found_bit;
+
+    /* We fake a shorter bitmap to avoid searching too far. */
+    found_bit = find_next_bit(attr->bitmap, last_bit + 1, first_bit);
+    return found_bit > last_bit;
+}
+
+int ram_block_attribute_state_change(RamBlockAttribute *attr, uint64_t offset,
+                                     uint64_t size, bool to_private)
+{
+    const int block_size = ram_block_attribute_get_block_size(attr);
+    const unsigned long first_bit = offset / block_size;
+    const unsigned long nbits = size / block_size;
+    int ret = 0;
+
+    if (!ram_block_attribute_is_valid_range(attr, offset, size)) {
+        error_report("%s, invalid range: offset 0x%lx, size 0x%lx",
+                     __func__, offset, size);
+        return -1;
+    }
+
+    /* Already discard/populated */
+    if ((ram_block_attribute_is_range_discard(attr, offset, size) &&
+         to_private) ||
+        (ram_block_attribute_is_range_populated(attr, offset, size) &&
+         !to_private)) {
+        return 0;
+    }
+
+    /* Unexpected mixture */
+    if ((!ram_block_attribute_is_range_populated(attr, offset, size) &&
+         to_private) ||
+        (!ram_block_attribute_is_range_discard(attr, offset, size) &&
+         !to_private)) {
+        error_report("%s, the range is not all in the desired state: "
+                     "(offset 0x%lx, size 0x%lx), %s",
+                     __func__, offset, size,
+                     to_private ? "private" : "shared");
+        return -1;
+    }
+
+    if (to_private) {
+        bitmap_clear(attr->bitmap, first_bit, nbits);
+        ram_block_attribute_notify_to_discard(attr, offset, size);
+    } else {
+        bitmap_set(attr->bitmap, first_bit, nbits);
+        ret = ram_block_attribute_notify_to_populated(attr, offset, size);
+    }
+
+    return ret;
+}
+
 RamBlockAttribute *ram_block_attribute_create(MemoryRegion *mr)
 {
     uint64_t bitmap_size;
-- 
2.43.5


