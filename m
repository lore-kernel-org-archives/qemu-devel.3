Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8936085099
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VLNfVbvk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOBEf-0000yp-7U; Tue, 03 Nov 2026 04:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xOBEc-0000yb-QD
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 04:55:18 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xOBEa-0004K8-Ce
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 04:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793699716; x=1825235716;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=x39JTdyv4F07kClYlzgbjDeJfENien04cz3ebIkRkWA=;
 b=VLNfVbvk6Qy8Jp7LYtMJUIudFgcypJWbOb5zO9TmiNqUvoGRwdIBPWek
 NOuB/mcA59kj9yj9BsvzDMLKNlAIczYIS/QVzPJsZJZIQ8++05S4tOVDA
 /e56JZoiSpLkSXOuqCRMfMGOAapgbKD6uL+dAOB5DVFMYZdR/j6f9yS6k
 i1fSZbPaM6UOL+MoDjNsNsEqHlXXh9jtomv+wg2+qXVjpHQcAgz1RJ9cn
 CQE+FjrS2eO5cfQTyzzfCjPm86lEPVTDKflya9D2duZPVUKKtMokMC1yO
 D7ZRaaGbbno8H9UVHpa5KxGmXcBuXnxwyLA4ZAHQImR7aE4Jf0m7RkDGY w==;
X-CSE-ConnectionGUID: bvRta9QOR06AUfFoMoHJCQ==
X-CSE-MsgGUID: BltNjXHFQb+nNSV396uhQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2429986"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2429986"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 01:55:12 -0800
X-CSE-ConnectionGUID: k3IAS8RlQRKMY7mbAydBTw==
X-CSE-MsgGUID: 1Ksd3Oz3TVWopPKhoj1GQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6283765"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 01:55:10 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: clement.mathieu--drif@bull.com, mst@redhat.com, jasowangio@gmail.com,
 yi.l.liu@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] intel_iommu: Keep PASID cache consistent with PT fast path
Date: Tue,  3 Nov 2026 17:54:44 +0800
Message-ID: <20261103095444.1218225-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With caching mode disabled, a guest can install a scalable-mode
pass-through PASID entry without issuing a PASID-cache invalidation. The
first DMA enables the PT fast path, but leaves QEMU's PASID cache invalid.

When the guest tears down that entry to switch back to a DMA domain, the
invalidation handler sees both a non-present guest entry and an invalid
cached entry and returns without re-enabling the IOMMU memory region.
Subsequent DMA therefore continues to bypass translation.

The issue can be reproduced with an emulated device in scalable mode
with caching-mode=off:

1. Unbind the guest device driver and change the group's type to
   identity through /sys/kernel/iommu_groups/<group>/type.
2. Rebind the driver and issue a DMA write.
3. Unbind the driver, change the group's type back to DMA-FQ, and
   rebind the driver.
4. Issue another DMA write using an IOVA mapped to a different GPA.

The second write incorrectly bypasses translation instead of reaching
the mapped GPA.

Save the PASID entry when enabling the scalable-mode PT fast path so
teardown invalidation can restore the IOMMU address space. Return after
handling a non-present entry, and refresh the cached entry when a present
entry changes.

Opportunistically clarify the invalidation modes in the fast-path comment.

Fixes: c9cf33075a4c ("intel_iommu: Fix DMA failure when guest switches IOMMU domain")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b7da5d086d..ec8d056735 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1649,7 +1649,7 @@ static int vtd_address_space_sync(VTDAddressSpace *vtd_as)
  * or second stage translation, it depends on PGTT setting.
  */
 static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
-                               uint32_t pasid)
+                               uint32_t pasid, VTDPASIDEntry *pasid_entry)
 {
     VTDPASIDEntry pe;
     int ret;
@@ -1663,6 +1663,11 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
              */
             return false;
         }
+
+        if (pasid_entry) {
+            *pasid_entry = pe;
+        }
+
         return vtd_pe_pgtt_is_pt(&pe);
     }
 
@@ -1689,7 +1694,7 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
         return false;
     }
 
-    return vtd_dev_pt_enabled(s, &ce, as->pasid);
+    return vtd_dev_pt_enabled(s, &ce, as->pasid, NULL);
 }
 
 /* Return whether the device is using IOMMU translation. */
@@ -1887,7 +1892,8 @@ VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
     return vtd_get_as_by_sid_and_pasid(s, sid, IOMMU_NO_PASID);
 }
 
-static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_id)
+static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_id,
+                                    VTDPASIDEntry *pe)
 {
     VTDAddressSpace *vtd_as;
     bool success = false;
@@ -1898,8 +1904,15 @@ static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_id)
     }
 
     if (vtd_switch_address_space(vtd_as) == false) {
+        VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+
         /* We switched off IOMMU region successfully. */
         success = true;
+
+        if (s->root_scalable) {
+            pc_entry->pasid_entry = *pe;
+            pc_entry->valid = true;
+        }
     }
 
 out:
@@ -2091,6 +2104,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
 {
     IntelIOMMUState *s = vtd_as->iommu_state;
     VTDContextEntry ce;
+    VTDPASIDEntry pe;
     uint8_t bus_num = pci_bus_num(bus);
     VTDContextCacheEntry *cc_entry;
     uint64_t pte, page_mask;
@@ -2167,7 +2181,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
      * We don't need to translate for pass-through context entries.
      * Also, let's ignore IOTLB caching as well for PT devices.
      */
-    if (vtd_dev_pt_enabled(s, &ce, pasid)) {
+    if (vtd_dev_pt_enabled(s, &ce, pasid, &pe)) {
         entry->iova = addr & VTD_PAGE_MASK_4K;
         entry->translated_addr = entry->iova;
         entry->addr_mask = ~VTD_PAGE_MASK_4K;
@@ -2180,10 +2194,11 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
          * the device. Let's enable the fast path for passthrough.
          *
          * When passthrough is disabled again for the device, we can
-         * capture it via the context entry invalidation, then the
-         * IOMMU region can be swapped back.
+         * capture it via context-cache invalidation in legacy mode or
+         * PASID-cache invalidation in scalable mode, then the IOMMU
+         * region can be swapped back.
          */
-        vtd_pt_enable_fast_path(s, source_id);
+        vtd_pt_enable_fast_path(s, source_id, &pe);
         vtd_iommu_unlock(s);
         return true;
     }
@@ -3133,6 +3148,7 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
             vtd_address_space_unmap(vtd_as, n);
         }
         vtd_switch_address_space(vtd_as);
+        return;
     }
 
     /*
@@ -3158,11 +3174,11 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     }
 
     if (!pc_entry->valid) {
-        pc_entry->pasid_entry = pe;
         pc_entry->valid = true;
     } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
         return;
     }
+    pc_entry->pasid_entry = pe;
 
     vtd_switch_address_space(vtd_as);
     vtd_address_space_sync(vtd_as);
-- 
2.52.0


