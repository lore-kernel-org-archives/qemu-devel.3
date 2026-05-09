Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7911CD37AF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 04:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLZ0D-0001I2-23; Sat, 09 May 2026 00:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLYzw-0001Fw-Tm
 for qemu-devel@nongnu.org; Sat, 09 May 2026 00:09:05 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLYzu-0000KM-WD
 for qemu-devel@nongnu.org; Sat, 09 May 2026 00:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778299743; x=1809835743;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TvSjztnNB8o7LST8yO8oBOj9nwcS6N/crPDRICx1jqI=;
 b=D+DOC5MeDwSGkuV/PwPAsVMu1ZhQd7OKXrYD1gW3bMOSc3Ep/usEZxo0
 liW3K2RFdphN5b1BlLKR9VeQw7Ot+2C+hRs+lyj4G2fbyhBeJSBLesiyI
 Fm/SJsTPluiNOJpEiGy/zsTmcPvGSlkxIEDF+Dtx+CkXNn1CixH39rda3
 /uf5aeMJaFKXcjfAF5ZI2hWuBvGh5k8xzPUy0AGkJ1dXSWG28nCssPWBW
 wcNY7WlzGAsJpiC86BtrmFzHkwKLcf+r6s/gca/XF6jc/hOj552mcWI5T
 fKZSTuNOt1yIclv55wp6QHYA8OkfqJ1i9A/M6dGQSlaVmIXQ7gwJjJuYn Q==;
X-CSE-ConnectionGUID: ptOOE2NgQ/6vsBhS3UeKbg==
X-CSE-MsgGUID: Q6ZrvKM8QP2XLLX038wnRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90654450"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="90654450"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 21:09:02 -0700
X-CSE-ConnectionGUID: +3y6JvcQSGGBToYScaK21w==
X-CSE-MsgGUID: CA0Ki/yuTDSIsf/IS+I4GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="235966517"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 21:08:58 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Subject: [PATCH v5 06/15] intel_iommu: Export some functions
Date: Sat,  9 May 2026 00:07:59 -0400
Message-ID: <20260509040819.1044702-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_internal.h | 31 +++++++++++++++++++++++++
 hw/i386/intel_iommu.c          | 42 ++++++++--------------------------
 2 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index db4f186a3e..c7e107fe87 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -620,6 +620,12 @@ typedef struct VTDRootEntry VTDRootEntry;
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
@@ -746,4 +752,29 @@ static inline bool vtd_pe_pgtt_is_fst(VTDPASIDEntry *pe)
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
index cf275b496e..36af13cee3 100644
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
 
@@ -1526,8 +1507,8 @@ static int vtd_ce_pasid_0_check(IntelIOMMUState *s, VTDContextEntry *ce)
 }
 
 /* Map a device to its corresponding domain (context-entry) */
-static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
-                                    uint8_t devfn, VTDContextEntry *ce)
+int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
+                             uint8_t devfn, VTDContextEntry *ce)
 {
     VTDRootEntry re;
     int ret_fr;
@@ -1909,7 +1890,7 @@ static VTDAddressSpace *vtd_get_as_by_sid_and_pasid(IntelIOMMUState *s,
                              vtd_find_as_by_sid_and_pasid, &key);
 }
 
-static VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
+VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
 {
     return vtd_get_as_by_sid_and_pasid(s, sid, PCI_NO_PASID);
 }
@@ -3133,11 +3114,6 @@ static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
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


