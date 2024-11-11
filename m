Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20893D2E9C3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 08:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAPww-0004y7-7J; Mon, 11 Nov 2024 03:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPwo-0004w5-4K
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:38:58 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPwm-0003UY-Cc
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731314336; x=1762850336;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6FABnwmc8/sgxd2GYOU2jxuHbQlFg+zNaxsIsYIqwt8=;
 b=D3lc86vXXi6AZ3quRSJdLr85D7CenFWkHXuHgkZTh9JKZemaD66dv9TB
 wDSMeUrXx71IrBXCuRKfpdfux/m3jYrAOQm6piMRFtbYbVFIlNK08QjJt
 Vc/Ds3pUD3axdGebv6TOrKzjiAxFhmZgOGTNY3VgALgPPQrCuHhKytwkl
 gpIAXh0Q2h6yfE1D/MYLu2D7VVfC+JEwgDz+q0Rmax9brcB0uht+CLTwD
 RDlmZGt2CFRq4SzpLaJnt27X41r2kBU+dZVM9fVcmZT/QTILXa3yZg+L7
 Jk39YdIFPcrczlkjsk023z76pLy0TVVk0j63megGmJy5eecKZRvklUFy3 g==;
X-CSE-ConnectionGUID: 0W0WslEpToy1NJRRSQdjyg==
X-CSE-MsgGUID: dPIZaiXeQM6lgay9OPHDpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="31334474"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="31334474"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:38:55 -0800
X-CSE-ConnectionGUID: eR9ZofvRRsWz+qwQkb7Ojg==
X-CSE-MsgGUID: fcGj9vD/SwqhMofUVi0AbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="87608329"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:38:51 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v5 11/20] intel_iommu: Process PASID-based iotlb invalidation
Date: Mon, 11 Nov 2024 16:34:48 +0800
Message-Id: <20241111083457.2090664-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
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

PASID-based iotlb (piotlb) is used during walking Intel
VT-d stage-1 page table.

This emulates the stage-1 page table iotlb invalidation requested
by a PASID-based IOTLB Invalidate Descriptor (P_IOTLB).

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu_internal.h |  3 +++
 hw/i386/intel_iommu.c          | 43 ++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 22dd3faf0c..5e4e563e62 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -471,6 +471,9 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
 #define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & VTD_DOMAIN_ID_MASK)
 #define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_PIOTLB_AM(val)       ((val) & 0x3fULL)
+#define VTD_INV_DESC_PIOTLB_IH(val)       (((val) >> 6) & 0x1)
+#define VTD_INV_DESC_PIOTLB_ADDR(val)     ((val) & ~0xfffULL)
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4b0fb1f83d..71ef5d741a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -322,6 +322,28 @@ static gboolean vtd_hash_remove_by_page(gpointer key, gpointer value,
     return (entry->gfn & info->mask) == gfn || entry->gfn == gfn_tlb;
 }
 
+static gboolean vtd_hash_remove_by_page_piotlb(gpointer key, gpointer value,
+                                               gpointer user_data)
+{
+    VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
+    VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
+    uint64_t gfn = (info->addr >> VTD_PAGE_SHIFT_4K) & info->mask;
+    uint64_t gfn_tlb = (info->addr & entry->mask) >> VTD_PAGE_SHIFT_4K;
+
+    /*
+     * According to spec, PASID-based-IOTLB Invalidation in page granularity
+     * doesn't invalidate IOTLB entries caching second-stage (PGTT=010b)
+     * or pass-through (PGTT=100b) mappings. Nested isn't supported yet,
+     * so only need to check first-stage (PGTT=001b) mappings.
+     */
+    if (entry->pgtt != VTD_SM_PASID_ENTRY_FLT) {
+        return false;
+    }
+
+    return entry->domain_id == info->domain_id && entry->pasid == info->pasid &&
+           ((entry->gfn & info->mask) == gfn || entry->gfn == gfn_tlb);
+}
+
 /* Reset all the gen of VTDAddressSpace to zero and set the gen of
  * IntelIOMMUState to 1.  Must be called with IOMMU lock held.
  */
@@ -2937,11 +2959,29 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     }
 }
 
+static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
+                                       uint32_t pasid, hwaddr addr, uint8_t am)
+{
+    VTDIOTLBPageInvInfo info;
+
+    info.domain_id = domain_id;
+    info.pasid = pasid;
+    info.addr = addr;
+    info.mask = ~((1 << am) - 1);
+
+    vtd_iommu_lock(s);
+    g_hash_table_foreach_remove(s->iotlb,
+                                vtd_hash_remove_by_page_piotlb, &info);
+    vtd_iommu_unlock(s);
+}
+
 static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
                                     VTDInvDesc *inv_desc)
 {
     uint16_t domain_id;
     uint32_t pasid;
+    hwaddr addr;
+    uint8_t am;
     uint64_t mask[4] = {VTD_INV_DESC_PIOTLB_RSVD_VAL0,
                         VTD_INV_DESC_PIOTLB_RSVD_VAL1,
                         VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
@@ -2959,6 +2999,9 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
         break;
 
     case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
+        am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
+        addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
+        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am);
         break;
 
     default:
-- 
2.34.1


