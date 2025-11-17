Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16BACEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvhw-0004jh-7R; Mon, 17 Nov 2025 04:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKvhj-0004Zi-LJ
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:39:27 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKvhh-0006HR-KB
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763372362; x=1794908362;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+yjj9ijeq21N7Fjj9Xc9Wnu9iUgFPcdd+uWXenF86w0=;
 b=nQfDHSMKGZNvupqWOiMvgNKmX5+Yv7Sj3QR9hguCCnQ+ZYHHlN3C2A/H
 O+2MJSNEgg62aWaraqXIk7kjS7l/aCWTne0Bw33pmESWBsZnBPcuq+8PR
 87a6lrX0kdXdaJjIRsy9ccYOnbq/0DiNahy70pFP7fzmcVTzhIeWuA5Zb
 godtwis2bP0p689pO0R72OpR/BxI+3GgjhbHUzWwrWZZOAtpoCaVvfGAA
 Q+lVsVX7Rj13ffv6xh/69JJDJelWc20Llwmqy9DyQI7UQSO8YEncknNSA
 DxG4cgJQPGOvsgqhmLD0qhHuqtgoKpk99wFEvSePwzF9zyobV+Ev3UeYv w==;
X-CSE-ConnectionGUID: 3sXn0AX0R52sHeVBsJsDDw==
X-CSE-MsgGUID: D0/5d45rRgOKbjyKs59d/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="76045998"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="76045998"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:39:20 -0800
X-CSE-ConnectionGUID: ueZxDyulTFmh3dkJzCIBzA==
X-CSE-MsgGUID: +m14IqeyRwSVFWkxadI5cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="190070937"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:39:16 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v8 12/23] intel_iommu: Add some macros and inline functions
Date: Mon, 17 Nov 2025 04:37:15 -0500
Message-ID: <20251117093729.1121324-13-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add some macros and inline functions that will be used by following patch.

This patch also make a cleanup to change below macros to use extract64()
just like what smmu does, because they are either used in following patches
or used indirectly by new introduced inline functions.

  VTD_INV_DESC_PIOTLB_IH
  VTD_SM_PASID_ENTRY_PGTT
  VTD_SM_PASID_ENTRY_DID
  VTD_SM_PASID_ENTRY_FSPM
  VTD_SM_PASID_ENTRY_FSPTPTR

But we doesn't aim to change the huge amount of bit mask style macro
definitions in this patch, that should be in a separate patch.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu_internal.h | 50 ++++++++++++++++++++++++++++------
 hw/i386/intel_iommu.c          | 27 +++++++++---------
 2 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index d8dad18304..e987322e93 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -516,7 +516,7 @@ typedef union VTDPRDesc VTDPRDesc;
 #define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & VTD_DOMAIN_ID_MASK)
 #define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
 #define VTD_INV_DESC_PIOTLB_AM(val)       ((val) & 0x3fULL)
-#define VTD_INV_DESC_PIOTLB_IH(val)       (((val) >> 6) & 0x1)
+#define VTD_INV_DESC_PIOTLB_IH(x)         extract64((x)->val[1], 6, 1)
 #define VTD_INV_DESC_PIOTLB_ADDR(val)     ((val) & ~0xfffULL)
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
@@ -636,17 +636,20 @@ typedef struct VTDPASIDCacheInfo {
 
 /* PASID Granular Translation Type Mask */
 #define VTD_PASID_ENTRY_P              1ULL
-#define VTD_SM_PASID_ENTRY_PGTT        (7ULL << 6)
-#define VTD_SM_PASID_ENTRY_FST         (1ULL << 6)
-#define VTD_SM_PASID_ENTRY_SST         (2ULL << 6)
-#define VTD_SM_PASID_ENTRY_NESTED      (3ULL << 6)
-#define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
+#define VTD_SM_PASID_ENTRY_PGTT(x)     extract64((x)->val[0], 6, 3)
+#define VTD_SM_PASID_ENTRY_FST         1
+#define VTD_SM_PASID_ENTRY_SST         2
+#define VTD_SM_PASID_ENTRY_NESTED      3
+#define VTD_SM_PASID_ENTRY_PT          4
 
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
-#define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
+#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
 
-#define VTD_SM_PASID_ENTRY_FSPM          3ULL
-#define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
+#define VTD_SM_PASID_ENTRY_SRE(x)      extract64((x)->val[2], 0, 1)
+#define VTD_SM_PASID_ENTRY_FSPM(x)     extract64((x)->val[2], 2, 2)
+#define VTD_SM_PASID_ENTRY_WPE(x)      extract64((x)->val[2], 4, 1)
+#define VTD_SM_PASID_ENTRY_EAFE(x)     extract64((x)->val[2], 7, 1)
+#define VTD_SM_PASID_ENTRY_FSPTPFN(x)  extract64((x)->val[2], 12, 52)
 
 /* First Stage Paging Structure */
 /* Masks for First Stage Paging Entry */
@@ -696,4 +699,33 @@ struct vtd_as_key {
     uint8_t devfn;
     uint32_t pasid;
 };
+
+static inline dma_addr_t vtd_pe_get_fspt_base(VTDPASIDEntry *pe)
+{
+    return VTD_SM_PASID_ENTRY_FSPTPFN(pe) << VTD_PAGE_SHIFT;
+}
+
+/*
+ * First stage IOVA address width: 48 bits for 4-level paging(FSPM=00)
+ *                                 57 bits for 5-level paging(FSPM=01)
+ */
+static inline uint32_t vtd_pe_get_fs_aw(VTDPASIDEntry *pe)
+{
+    /*
+     * Paging mode for first-stage translation (VTD spec Figure 9-6)
+     * 00: 4-level paging, 01: 5-level paging
+     */
+    return VTD_HOST_AW_48BIT + VTD_SM_PASID_ENTRY_FSPM(pe) * 9;
+}
+
+static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
+{
+    return (VTD_SM_PASID_ENTRY_PGTT(pe) == VTD_SM_PASID_ENTRY_PT);
+}
+
+/* check if PGTT is first stage translation */
+static inline bool vtd_pe_pgtt_is_fst(VTDPASIDEntry *pe)
+{
+    return (VTD_SM_PASID_ENTRY_PGTT(pe) == VTD_SM_PASID_ENTRY_FST);
+}
 #endif
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 29e0281af8..513b2c85d4 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -49,10 +49,11 @@
 #define VTD_CE_GET_PRE(ce) \
     ((ce)->val[0] & VTD_SM_CONTEXT_ENTRY_PRE)
 
-/* pe operations */
-#define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
-#define VTD_PE_GET_FS_LEVEL(pe) \
-    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FSPM))
+/*
+ * Paging mode for first-stage translation (VTD spec Figure 9-6)
+ * 00: 4-level paging, 01: 5-level paging
+ */
+#define VTD_PE_GET_FS_LEVEL(pe) (VTD_SM_PASID_ENTRY_FSPM(pe) + 4)
 #define VTD_PE_GET_SS_LEVEL(pe) \
     (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
 
@@ -808,7 +809,7 @@ static inline bool vtd_is_fs_level_supported(IntelIOMMUState *s, uint32_t level)
 /* Return true if check passed, otherwise false */
 static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
 {
-    switch (VTD_PE_GET_TYPE(pe)) {
+    switch (VTD_SM_PASID_ENTRY_PGTT(pe)) {
     case VTD_SM_PASID_ENTRY_FST:
         return !!(s->ecap & VTD_ECAP_FSTS);
     case VTD_SM_PASID_ENTRY_SST:
@@ -883,7 +884,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
         return -VTD_FR_PASID_TABLE_ENTRY_INV;
     }
 
-    pgtt = VTD_PE_GET_TYPE(pe);
+    pgtt = VTD_SM_PASID_ENTRY_PGTT(pe);
     if (pgtt == VTD_SM_PASID_ENTRY_SST &&
         !vtd_is_ss_level_supported(s, VTD_PE_GET_SS_LEVEL(pe))) {
             return -VTD_FR_PASID_TABLE_ENTRY_INV;
@@ -1117,7 +1118,7 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
     if (s->root_scalable) {
         vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         if (s->fsts) {
-            return pe.val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
+            return vtd_pe_get_fspt_base(&pe);
         } else {
             return pe.val[0] & VTD_SM_PASID_ENTRY_SSPTPTR;
         }
@@ -1606,7 +1607,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
 
     if (s->root_scalable) {
         vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
-        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
+        return VTD_SM_PASID_ENTRY_DID(&pe);
     }
 
     return VTD_CONTEXT_ENTRY_DID(ce->hi);
@@ -1688,7 +1689,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
              */
             return false;
         }
-        return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
+        return vtd_pe_pgtt_is_pt(&pe);
     }
 
     return (vtd_ce_get_type(ce) == VTD_CONTEXT_TT_PASS_THROUGH);
@@ -3109,9 +3110,9 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
         /* Fall through */
     case VTD_INV_DESC_PASIDC_G_DSI:
         if (pc_entry->valid) {
-            did = VTD_SM_PASID_ENTRY_DID(pc_entry->pasid_entry.val[1]);
+            did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
         } else {
-            did = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
+            did = VTD_SM_PASID_ENTRY_DID(&pe);
         }
         if (pc_info->did != did) {
             return;
@@ -5196,8 +5197,8 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
     if (ret) {
         return -EINVAL;
     }
-    pgtt = VTD_PE_GET_TYPE(&pe);
-    domain_id = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
+    pgtt = VTD_SM_PASID_ENTRY_PGTT(&pe);
+    domain_id = VTD_SM_PASID_ENTRY_DID(&pe);
     ret = 0;
     switch (pgtt) {
     case VTD_SM_PASID_ENTRY_FST:
-- 
2.47.1


