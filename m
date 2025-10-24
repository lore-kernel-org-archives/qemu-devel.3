Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AD3CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDQN-0005Bj-DA; Fri, 24 Oct 2025 04:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDQL-0005Aj-Fb
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:45:25 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDQJ-0006Vx-EE
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761295523; x=1792831523;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5ziOz2H5Cd5DtOcROfFnKuCe1XQaE8X2XRR9wWLE3Ho=;
 b=LIQRo22tYDL9OLipisu5/4/mSbM1/npxyeDRkOAIMVJDq5cTly2iF2EP
 e/8V+M2qDr1+MOh5gW0yvYj8D9xsrKhrOzhlYlGN8x/WS+Xu+fiv4mUvi
 QRpv59vrPYC9fkn6o7+h/KKLuWn9j+YML7yGI6eRWH5fTKEa5itRB/lUN
 6C5DITfJwVZbrbRW6Pv3eb5Sq+8Wlp47CxrJIwsOhO7/saT6fKm8xpWnr
 F3fzAM59JKwS4aZ9d1XF/HLQkTvHplXFMzx+NdWVGZH6dP7zBW1iMBx2h
 HkYxgfRgE/n9O/2B+cUqFYPtWIZr2maGQx3nSC3yUydpxZAxIgGTI3vVf g==;
X-CSE-ConnectionGUID: i1ebIQNZSXy6SkPQnm80bA==
X-CSE-MsgGUID: h/27Daz9QTO3JCISrVmXfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62504882"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="62504882"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:22 -0700
X-CSE-ConnectionGUID: ZLn/VIGCSx2yZOn6O6bJdg==
X-CSE-MsgGUID: hoI+V3ZdQtmrAsUp+MprMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="183985967"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:18 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 12/23] intel_iommu: Add some macros and inline functions
Date: Fri, 24 Oct 2025 04:43:36 -0400
Message-ID: <20251024084349.102322-13-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024084349.102322-1-zhenzhong.duan@intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add some macros and inline functions that will be used by following
patch.

This patch also make a cleanup to change macro VTD_SM_PASID_ENTRY_DID
and VTD_SM_PASID_ENTRY_FSPM to use extract64() just like what smmu does,
because they are either used in following patches or used indirectly by
new introduced inline functions. But we doesn't aim to change the huge
amount of bit mask style macro definitions in this patch, that should be
in a separate patch.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu_internal.h |  8 +++++--
 hw/i386/intel_iommu.c          | 38 +++++++++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 09edba81e2..df80af839d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -642,10 +642,14 @@ typedef struct VTDPASIDCacheInfo {
 #define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
 
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
-#define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
+#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
 
-#define VTD_SM_PASID_ENTRY_FSPM          3ULL
 #define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
+#define VTD_SM_PASID_ENTRY_SRE_BIT(x)    extract64((x)->val[2], 0, 1)
+/* 00: 4-level paging, 01: 5-level paging, 10-11: Reserved */
+#define VTD_SM_PASID_ENTRY_FSPM(x)       extract64((x)->val[2], 2, 2)
+#define VTD_SM_PASID_ENTRY_WPE_BIT(x)    extract64((x)->val[2], 4, 1)
+#define VTD_SM_PASID_ENTRY_EAFE_BIT(x)   extract64((x)->val[2], 7, 1)
 
 /* First Stage Paging Structure */
 /* Masks for First Stage Paging Entry */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 56abbb991d..871e6aad19 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -52,8 +52,7 @@
 
 /* pe operations */
 #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
-#define VTD_PE_GET_FS_LEVEL(pe) \
-    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FSPM))
+#define VTD_PE_GET_FS_LEVEL(pe) (VTD_SM_PASID_ENTRY_FSPM(pe) + 4)
 #define VTD_PE_GET_SS_LEVEL(pe) \
     (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
 
@@ -837,6 +836,31 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
     }
 }
 
+static inline dma_addr_t vtd_pe_get_fspt_base(VTDPASIDEntry *pe)
+{
+    return pe->val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
+}
+
+/*
+ * First stage IOVA address width: 48 bits for 4-level paging(FSPM=00)
+ *                                 57 bits for 5-level paging(FSPM=01)
+ */
+static inline uint32_t vtd_pe_get_fs_aw(VTDPASIDEntry *pe)
+{
+    return 48 + VTD_SM_PASID_ENTRY_FSPM(pe) * 9;
+}
+
+static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
+{
+    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_PT);
+}
+
+/* check if pgtt is first stage translation */
+static inline bool vtd_pe_pgtt_is_fst(VTDPASIDEntry *pe)
+{
+    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_FST);
+}
+
 static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
 {
     return pdire->val & 1;
@@ -1625,7 +1649,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
 
     if (s->root_scalable) {
         vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
-        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
+        return VTD_SM_PASID_ENTRY_DID(&pe);
     }
 
     return VTD_CONTEXT_ENTRY_DID(ce->hi);
@@ -1707,7 +1731,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
              */
             return false;
         }
-        return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
+        return vtd_pe_pgtt_is_pt(&pe);
     }
 
     return (vtd_ce_get_type(ce) == VTD_CONTEXT_TT_PASS_THROUGH);
@@ -3146,9 +3170,9 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
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
@@ -5267,7 +5291,7 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
         return -EINVAL;
     }
     pgtt = VTD_PE_GET_TYPE(&pe);
-    domain_id = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
+    domain_id = VTD_SM_PASID_ENTRY_DID(&pe);
     ret = 0;
     switch (pgtt) {
     case VTD_SM_PASID_ENTRY_FST:
-- 
2.47.1


