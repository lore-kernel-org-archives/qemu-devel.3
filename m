Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9D2C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9fQv-0004xo-D6; Wed, 22 May 2024 02:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQY-0004gi-GB
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:23 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQV-0006eK-M1
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716359176; x=1747895176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uPUVQFGDFxFSLvmCcNQ6Dut0feFHx5NOEumo20sJpRw=;
 b=geR+YSrtMlZoaVU+zdnc03/4q1PrifD7SBIdeiXPJ6hYOyOVwhX6r5aA
 0a+kSXkrUXscAO7FWqMf3bgQ2ZB4HRuBQq7MpHXlLm0HbU+vwjtz+ovMf
 gdH4kYfzOB4qCfSYxaYFTST4Y9UuAOC7f9RthhzQ1JZbO27G/6nzvMDkh
 7nR2Mn7fg7arTnyAORjLKJmlPYsSHPl/dIFRfn34ooi4slG1LmrUprPgy
 gLnzguMJAun85/RBLSKNLhXKIQxuqBufC4le/yQ/eAdhArAXakmFzi9ZM
 XaEgfd1ZNpL0V5FK1Yax97E0eBty0vhxFSUQzb/yighHQDm6qeryfLnqQ g==;
X-CSE-ConnectionGUID: fh5bGqBIRrK66zNSQ7pvEw==
X-CSE-MsgGUID: 2S/TTeMkQ2iFCaPK/GQqXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="37972490"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="37972490"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:26:15 -0700
X-CSE-ConnectionGUID: /2IrnlxoSW+ZZGmOi1W3Ug==
X-CSE-MsgGUID: BmmNIJUeQlCKl48ONHnT+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33597713"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:26:10 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv2 05/17] intel_iommu: Rename slpte to pte
Date: Wed, 22 May 2024 14:23:01 +0800
Message-Id: <20240522062313.453317-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522062313.453317-1-zhenzhong.duan@intel.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Yi Liu <yi.l.liu@intel.com>

Because we will support both FST(a.k.a, FLT) and SST(a.k.a, SLT) translation,
rename slpte to pte to make it generic.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  3 ++-
 include/hw/i386/intel_iommu.h  |  2 +-
 hw/i386/intel_iommu.c          | 39 +++++++++++++++++-----------------
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index b0d9b1f986..0e240d6d54 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -553,10 +553,11 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SL_RW_MASK              3ULL
 #define VTD_SL_R                    1ULL
 #define VTD_SL_W                    (1ULL << 1)
-#define VTD_SL_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MASK(aw))
 #define VTD_SL_IGN_COM              0xbff0000000000000ULL
 #define VTD_SL_TM                   (1ULL << 62)
 
+/* Common for both First Level and Second Level */
+#define VTD_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MASK(aw))
 
 typedef struct VTDHostIOMMUDevice {
     IntelIOMMUState *iommu_state;
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 9ba9c45015..011f374883 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -153,7 +153,7 @@ struct VTDIOTLBEntry {
     uint64_t gfn;
     uint16_t domain_id;
     uint32_t pasid;
-    uint64_t slpte;
+    uint64_t pte;
     uint64_t mask;
     uint8_t access_flags;
 };
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ed95b5ba2e..544e8f0e40 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -360,7 +360,7 @@ out:
 
 /* Must be with IOMMU lock held */
 static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
-                             uint16_t domain_id, hwaddr addr, uint64_t slpte,
+                             uint16_t domain_id, hwaddr addr, uint64_t pte,
                              uint8_t access_flags, uint32_t level,
                              uint32_t pasid)
 {
@@ -368,7 +368,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
     struct vtd_iotlb_key *key = g_malloc(sizeof(*key));
     uint64_t gfn = vtd_get_iotlb_gfn(addr, level);
 
-    trace_vtd_iotlb_page_update(source_id, addr, slpte, domain_id);
+    trace_vtd_iotlb_page_update(source_id, addr, pte, domain_id);
     if (g_hash_table_size(s->iotlb) >= VTD_IOTLB_MAX_SIZE) {
         trace_vtd_iotlb_reset("iotlb exceeds size limit");
         vtd_reset_iotlb_locked(s);
@@ -376,7 +376,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
 
     entry->gfn = gfn;
     entry->domain_id = domain_id;
-    entry->slpte = slpte;
+    entry->pte = pte;
     entry->access_flags = access_flags;
     entry->mask = vtd_slpt_level_page_mask(level);
     entry->pasid = pasid;
@@ -693,9 +693,9 @@ static inline dma_addr_t vtd_ce_get_slpt_base(VTDContextEntry *ce)
     return ce->lo & VTD_CONTEXT_ENTRY_SLPTPTR;
 }
 
-static inline uint64_t vtd_get_slpte_addr(uint64_t slpte, uint8_t aw)
+static inline uint64_t vtd_get_pte_addr(uint64_t slpte, uint8_t aw)
 {
-    return slpte & VTD_SL_PT_BASE_ADDR_MASK(aw);
+    return slpte & VTD_PT_BASE_ADDR_MASK(aw);
 }
 
 /* Whether the pte indicates the address of the page frame */
@@ -1152,11 +1152,11 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
             *slpte_level = level;
             break;
         }
-        addr = vtd_get_slpte_addr(slpte, aw_bits);
+        addr = vtd_get_pte_addr(slpte, aw_bits);
         level--;
     }
 
-    xlat = vtd_get_slpte_addr(*slptep, aw_bits);
+    xlat = vtd_get_pte_addr(*slptep, aw_bits);
     size = ~vtd_slpt_level_page_mask(level) + 1;
 
     /*
@@ -1343,7 +1343,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
              * This is a valid PDE (or even bigger than PDE).  We need
              * to walk one further level.
              */
-            ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte, info->aw),
+            ret = vtd_page_walk_level(vtd_get_pte_addr(slpte, info->aw),
                                       iova, MIN(iova_next, end), level - 1,
                                       read_cur, write_cur, info);
         } else {
@@ -1360,7 +1360,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
             event.entry.perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
             event.entry.addr_mask = ~subpage_mask;
             /* NOTE: this is only meaningful if entry_valid == true */
-            event.entry.translated_addr = vtd_get_slpte_addr(slpte, info->aw);
+            event.entry.translated_addr = vtd_get_pte_addr(slpte, info->aw);
             event.type = event.entry.perm ? IOMMU_NOTIFIER_MAP :
                                             IOMMU_NOTIFIER_UNMAP;
             ret = vtd_page_walk_one(&event, info);
@@ -1883,7 +1883,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     VTDContextEntry ce;
     uint8_t bus_num = pci_bus_num(bus);
     VTDContextCacheEntry *cc_entry;
-    uint64_t slpte, page_mask;
+    uint64_t pte, page_mask;
     uint32_t level, pasid = vtd_as->pasid;
     uint16_t source_id = PCI_BUILD_BDF(bus_num, devfn);
     int ret_fr;
@@ -1904,13 +1904,13 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
 
     cc_entry = &vtd_as->context_cache_entry;
 
-    /* Try to fetch slpte form IOTLB, we don't need RID2PASID logic */
+    /* Try to fetch pte form IOTLB, we don't need RID2PASID logic */
     if (!rid2pasid) {
         iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
         if (iotlb_entry) {
-            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->slpte,
+            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
                                      iotlb_entry->domain_id);
-            slpte = iotlb_entry->slpte;
+            pte = iotlb_entry->pte;
             access_flags = iotlb_entry->access_flags;
             page_mask = iotlb_entry->mask;
             goto out;
@@ -1982,21 +1982,22 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         return true;
     }
 
-    /* Try to fetch slpte form IOTLB for RID2PASID slow path */
+    /* Try to fetch pte form IOTLB for RID2PASID slow path */
     if (rid2pasid) {
         iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
         if (iotlb_entry) {
-            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->slpte,
+            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
                                      iotlb_entry->domain_id);
-            slpte = iotlb_entry->slpte;
+            pte = iotlb_entry->pte;
             access_flags = iotlb_entry->access_flags;
             page_mask = iotlb_entry->mask;
             goto out;
         }
     }
 
-    ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &slpte, &level,
+    ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
                                &reads, &writes, s->aw_bits, pasid);
+
     if (ret_fr) {
         vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
                          addr, is_write, pasid != PCI_NO_PASID, pasid);
@@ -2006,11 +2007,11 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     page_mask = vtd_slpt_level_page_mask(level);
     access_flags = IOMMU_ACCESS_FLAG(reads, writes);
     vtd_update_iotlb(s, source_id, vtd_get_domain_id(s, &ce, pasid),
-                     addr, slpte, access_flags, level, pasid);
+                     addr, pte, access_flags, level, pasid);
 out:
     vtd_iommu_unlock(s);
     entry->iova = addr & page_mask;
-    entry->translated_addr = vtd_get_slpte_addr(slpte, s->aw_bits) & page_mask;
+    entry->translated_addr = vtd_get_pte_addr(pte, s->aw_bits) & page_mask;
     entry->addr_mask = ~page_mask;
     entry->perm = access_flags;
     return true;
-- 
2.34.1


