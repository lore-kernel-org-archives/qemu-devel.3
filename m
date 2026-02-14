Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CEDEF99FA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 03:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr6Xu-0005At-Dm; Fri, 13 Feb 2026 22:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vr6Xs-0005AP-DP
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 22:42:12 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vr6Xq-0008J1-MB
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 22:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771040531; x=1802576531;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VHorsJz4aqaEhjxNJ20oCh3okyulXgR95PzP5Z+GvaA=;
 b=kEUIu04AqH9w2kzpPe5h6lD84s5UcoukeHINzLqINFUsrjouCXlnSV67
 lYk1PDYAV4+qlJn/a+wpgiR4wiSyoWAwQ+3giCKPOaLivbzdt9iHQjGqR
 tWakBYh4+Wm4xS5nwea8/n/zKh5eTzti0pIKzxjDPjWla/KyhXa1GPUN+
 QMDQc0tq8asz+aenAJJ+1b4WNFyZWR+wuUb+lVSavEJ4d1oguSy/BfMtr
 Fmrv9061ia/qnB9B0bjW/NBTVU1eYIvUB8tNY1JErvvXbtaJ0mYkRPlmT
 0/8cGTeAPTESVENZSwRkYOe5skPfdlXfG2i7fuhSoR2md/DXkbl9IGC9i A==;
X-CSE-ConnectionGUID: FGZjIH8gRYGWR+clWF2ciQ==
X-CSE-MsgGUID: Rs59cnNaQUu19DONosrgwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="83666833"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="83666833"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 19:42:10 -0800
X-CSE-ConnectionGUID: VEfS5l9OSVSldpdxLvMZ+g==
X-CSE-MsgGUID: EXtFf3zPTF27TdNbal9PQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="212933050"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 19:42:06 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFCv2 PATCH 06/13] intel_iommu: Export some functions
Date: Fri, 13 Feb 2026 22:41:26 -0500
Message-ID: <20260214034135.220413-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260214034135.220413-1-zhenzhong.duan@intel.com>
References: <20260214034135.220413-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Export some functions for accel code usages. Inline functions and MACROs
are moved to internal header files. Then accel code in following patches
could access them.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu_internal.h | 31 +++++++++++++++++++++++++
 hw/i386/intel_iommu.c          | 42 ++++++++--------------------------
 2 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 04a9392e8a..8b020fb3a4 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -619,6 +619,12 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
 
+/* context entry operations */
+#define VTD_CE_GET_PASID_DIR_TABLE(ce) \
+    ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
+#define VTD_CE_GET_PRE(ce) \
+    ((ce)->val[0] & VTD_SM_CONTEXT_ENTRY_PRE)
+
 typedef struct VTDPASIDCacheInfo {
     uint8_t type;
     uint16_t did;
@@ -745,4 +751,29 @@ static inline bool vtd_pe_pgtt_is_fst(VTDPASIDEntry *pe)
 {
     return (VTD_SM_PASID_ENTRY_PGTT(pe) == VTD_SM_PASID_ENTRY_FST);
 }
+
+static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
+{
+    return pdire->val & 1;
+}
+
+static inline bool vtd_pe_present(VTDPASIDEntry *pe)
+{
+    return pe->val[0] & VTD_PASID_ENTRY_P;
+}
+
+static inline int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
+{
+    return memcmp(p1, p2, sizeof(*p1));
+}
+
+int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base, uint32_t pasid,
+                                  VTDPASIDDirEntry *pdire);
+int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s, uint32_t pasid,
+                                   dma_addr_t addr, VTDPASIDEntry *pe);
+int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
+                             uint8_t devfn, VTDContextEntry *ce);
+int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
+                           VTDPASIDEntry *pe, uint32_t pasid);
+VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid);
 #endif
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e27a7c725f..d257dd95f6 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -42,12 +42,6 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 
-/* context entry operations */
-#define VTD_CE_GET_PASID_DIR_TABLE(ce) \
-    ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
-#define VTD_CE_GET_PRE(ce) \
-    ((ce)->val[0] & VTD_SM_CONTEXT_ENTRY_PRE)
-
 /*
  * Paging mode for first-stage translation (VTD spec Figure 9-6)
  * 00: 4-level paging, 01: 5-level paging
@@ -831,18 +825,12 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
     }
 }
 
-static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
-{
-    return pdire->val & 1;
-}
-
 /**
  * Caller of this function should check present bit if wants
  * to use pdir entry for further usage except for fpd bit check.
  */
-static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
-                                         uint32_t pasid,
-                                         VTDPASIDDirEntry *pdire)
+int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base, uint32_t pasid,
+                                  VTDPASIDDirEntry *pdire)
 {
     uint32_t index;
     dma_addr_t addr, entry_size;
@@ -860,15 +848,8 @@ static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
     return 0;
 }
 
-static inline bool vtd_pe_present(VTDPASIDEntry *pe)
-{
-    return pe->val[0] & VTD_PASID_ENTRY_P;
-}
-
-static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
-                                          uint32_t pasid,
-                                          dma_addr_t addr,
-                                          VTDPASIDEntry *pe)
+int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s, uint32_t pasid,
+                                   dma_addr_t addr, VTDPASIDEntry *pe)
 {
     uint8_t pgtt;
     uint32_t index;
@@ -954,8 +935,8 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
     return 0;
 }
 
-static int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
-                                  VTDPASIDEntry *pe, uint32_t pasid)
+int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
+                           VTDPASIDEntry *pe, uint32_t pasid)
 {
     dma_addr_t pasid_dir_base;
 
@@ -1531,8 +1512,8 @@ static int vtd_ce_pasid_0_check(IntelIOMMUState *s, VTDContextEntry *ce)
 }
 
 /* Map a device to its corresponding domain (context-entry) */
-static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
-                                    uint8_t devfn, VTDContextEntry *ce)
+int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
+                             uint8_t devfn, VTDContextEntry *ce)
 {
     VTDRootEntry re;
     int ret_fr;
@@ -1894,7 +1875,7 @@ static VTDAddressSpace *vtd_get_as_by_sid_and_pasid(IntelIOMMUState *s,
                              vtd_find_as_by_sid_and_pasid, &key);
 }
 
-static VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
+VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
 {
     return vtd_get_as_by_sid_and_pasid(s, sid, PCI_NO_PASID);
 }
@@ -3116,11 +3097,6 @@ static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
     return vtd_ce_get_pasid_entry(s, &ce, pe, vtd_as->pasid);
 }
 
-static int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
-{
-    return memcmp(p1, p2, sizeof(*p1));
-}
-
 /* Update or invalidate pasid cache based on the pasid entry in guest memory. */
 static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
                                         gpointer user_data)
-- 
2.47.3


