Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4466606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b0ItJBi1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRPy3-0004Ez-Bk; Thu, 12 Nov 2026 03:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xRPxw-0004BU-1o
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 03:15:31 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xRPxs-0000Il-48
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 03:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794471324; x=1826007324;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kpCvyj78fixhRKyYwxCpHSzphQ0fJQ+Eb1uySvbXxIA=;
 b=b0ItJBi1SA/60eMl8l/e1SaX0vY+J57kCjg31on7EHuY+3gnACGZK5I1
 Mu45sVg6M/jO3ONCdTpB3vMry8Pmwb4JNCwmcLv64tKVGIf4WvUSqtXOP
 5xX6NsLbTGVWWbXzjy/9BI1xlDqdtCjJqF2TBbBTGCcfCCd6YLr7pa+V1
 oa0980KtRwomHTvnMaX84qBhT69C20r60oH+ogT8kP0sNfPRyDoMVpcVn
 ZJXGU/BQopNGyeziWtBqo+rXK6GGegFo1ysp21ZgR/sF6rV3UyYXxP1Cw
 7GUTC1/Q6bqOh0l5QuqUfgGQBWuhPClfis5WWZ8jfF10enI53u5fkN5Ib A==;
X-CSE-ConnectionGUID: pCoJLL5rSvO8P0ZrbPj2sw==
X-CSE-MsgGUID: GiRTmE4MTWGpGSfcToiDrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3114187"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3114187"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 00:15:20 -0800
X-CSE-ConnectionGUID: ImbtJty3TiCdVShnnmzjXQ==
X-CSE-MsgGUID: LEE2lRdaT3+hOA/sC9heQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; d="scan'208";a="10326641"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 00:15:17 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: clement.mathieu--drif@bull.com, mst@redhat.com, jasowangio@gmail.com,
 yi.l.liu@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3] intel_iommu: Keep PASID cache consistent with PT fast path
Date: Thu, 12 Nov 2026 16:15:09 +0800
Message-ID: <20261112081509.442872-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
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
entry changes, pass vtd_as to vtd_try_enable_pt_fast_path() instead of
pick it from PASID 0.

Opportunistically clarify the invalidation modes in the fast-path comment
and merge trace event vtd_translate_pt and vtd_pt_enable_fast_path into
vtd_fast_path_translate_pt.

Fixes: c9cf33075a4c ("intel_iommu: Fix DMA failure when guest switches IOMMU domain")
Reported-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
---
v3:
- introduce a new helper vtd_try_enable_pt_fast_path (Clement)
v2:
- move "VTDPASIDCacheEntry *pc_entry" in the branch it is used (Clement)

 hw/i386/intel_iommu.c | 62 ++++++++++++++++++++++++-------------------
 hw/i386/trace-events  |  3 +--
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b7da5d086d..a5ff89a11a 100644
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
@@ -1701,8 +1706,8 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
     assert(as);
 
     s = as->iommu_state;
-    use_iommu = s->dmar_enabled && !vtd_as_pt_enabled(as);
     pt = s->dmar_enabled && vtd_as_pt_enabled(as);
+    use_iommu = s->dmar_enabled && !pt;
 
     /*
      * When guest enables scalable mode and sets up first stage page table,
@@ -1887,23 +1892,34 @@ VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
     return vtd_get_as_by_sid_and_pasid(s, sid, IOMMU_NO_PASID);
 }
 
-static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_id)
+static bool vtd_try_enable_pt_fast_path(IntelIOMMUState *s,
+                                        VTDAddressSpace *vtd_as,
+                                        VTDContextEntry *ce, uint32_t pasid)
 {
-    VTDAddressSpace *vtd_as;
-    bool success = false;
+    VTDPASIDEntry pe;
 
-    vtd_as = vtd_get_as_by_sid(s, source_id);
-    if (!vtd_as) {
-        goto out;
+    if (!vtd_dev_pt_enabled(s, ce, pasid, &pe)) {
+        return false;
     }
 
-    if (vtd_switch_address_space(vtd_as) == false) {
-        /* We switched off IOMMU region successfully. */
-        success = true;
+    /*
+     * When this happens, it means firstly caching-mode is not
+     * enabled, and this is the first passthrough translation for
+     * the device. Let's enable the fast path for passthrough.
+     *
+     * When passthrough is disabled again for the device, we can
+     * capture it via context-cache invalidation in legacy mode or
+     * PASID-cache invalidation in scalable mode, then the IOMMU
+     * region can be swapped back.
+     */
+    if (!vtd_switch_address_space(vtd_as) && s->root_scalable) {
+        VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+
+        pc_entry->pasid_entry = pe;
+        pc_entry->valid = true;
     }
 
-out:
-    trace_vtd_pt_enable_fast_path(source_id, success);
+    return true;
 }
 
 /*
@@ -2167,23 +2183,12 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
      * We don't need to translate for pass-through context entries.
      * Also, let's ignore IOTLB caching as well for PT devices.
      */
-    if (vtd_dev_pt_enabled(s, &ce, pasid)) {
+    if (vtd_try_enable_pt_fast_path(s, vtd_as, &ce, pasid)) {
         entry->iova = addr & VTD_PAGE_MASK_4K;
         entry->translated_addr = entry->iova;
         entry->addr_mask = ~VTD_PAGE_MASK_4K;
         entry->perm = IOMMU_RW;
-        trace_vtd_translate_pt(source_id, entry->iova);
-
-        /*
-         * When this happens, it means firstly caching-mode is not
-         * enabled, and this is the first passthrough translation for
-         * the device. Let's enable the fast path for passthrough.
-         *
-         * When passthrough is disabled again for the device, we can
-         * capture it via the context entry invalidation, then the
-         * IOMMU region can be swapped back.
-         */
-        vtd_pt_enable_fast_path(s, source_id);
+        trace_vtd_fast_path_translate_pt(source_id, entry->iova);
         vtd_iommu_unlock(s);
         return true;
     }
@@ -3133,6 +3138,7 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
             vtd_address_space_unmap(vtd_as, n);
         }
         vtd_switch_address_space(vtd_as);
+        return;
     }
 
     /*
@@ -3158,11 +3164,11 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
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
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 7bf4cddd38..3337a7e19c 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -47,8 +47,7 @@ vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"P
 vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
 vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
 vtd_as_unmap_whole(uint8_t bus, uint8_t slot, uint8_t fn, uint64_t iova, uint64_t size) "Device %02x:%02x.%x start 0x%"PRIx64" size 0x%"PRIx64
-vtd_translate_pt(uint16_t sid, uint64_t addr) "source id 0x%"PRIx16", iova 0x%"PRIx64
-vtd_pt_enable_fast_path(uint16_t sid, bool success) "sid 0x%"PRIx16" %d"
+vtd_fast_path_translate_pt(uint16_t sid, uint64_t addr) "source id 0x%"PRIx16", iova 0x%"PRIx64
 vtd_irq_generate(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64
 vtd_reg_read(uint64_t addr, uint64_t size) "addr 0x%"PRIx64" size 0x%"PRIx64
 vtd_reg_write(uint64_t addr, uint64_t size, uint64_t val) "addr 0x%"PRIx64" size 0x%"PRIx64" value 0x%"PRIx64
-- 
2.52.0


