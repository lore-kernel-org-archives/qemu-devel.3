Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AF3C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9fRH-0005F0-2F; Wed, 22 May 2024 02:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQw-00050M-P5
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:45 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQu-0006eK-L0
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716359201; x=1747895201;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2KJSZHksRpJmurDXEl7K+Gmaryd8njXwBKxopxGT9Pw=;
 b=KW/ktIIJgdNUbGfRMj9wVlngw9GKZKabBbRRjRrORg2OV4mQwBEyDzsg
 tQvuPK3yT8vG+FB2ZJTNKYvB+IQBXd5DEJa6auyt2JojA8HDl1uZPM4Sm
 huglk7LD8zbKwkhWUDMuNFfYefzW8DhVtA6kzIdnOKJm8zpm+II5EMo6x
 clLYfn+XJoLfnF/QwXyQERqcNwBy5Cjz4TvmB8KNjGgrTewkZdOuNRQtD
 n8BehfLeKPUn/Y6nynJdZy0Ez1tHI8ljNh9++HWeEEirMF3uLu+mkoKJE
 mDjjpuGpDQZ0N8p7ZhIndSAltFod0u0XSIdrkGrLmRBq6zzDnGNFmdrQc A==;
X-CSE-ConnectionGUID: Aon7b4aDSFimYPvl0owpOw==
X-CSE-MsgGUID: 3cx3ETdMTSK9WO93rCHZ0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="37972573"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="37972573"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:26:40 -0700
X-CSE-ConnectionGUID: CBQ+VyBzQHOM3zQcJpjZzA==
X-CSE-MsgGUID: 7YBgPqafRMyBkN+1Sa/B+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33597823"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:26:35 -0700
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
Subject: [PATCH rfcv2 10/17] intel_iommu: Process PASID-based iotlb
 invalidation
Date: Wed, 22 May 2024 14:23:06 +0800
Message-Id: <20240522062313.453317-11-zhenzhong.duan@intel.com>
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

PASID-based iotlb (piotlb) is used during walking Intel
VT-d stage-1 page table.

This emulates the stage-1 page table iotlb invalidation requested
by a PASID-based IOTLB Invalidate Descriptor (P_IOTLB).

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  3 +++
 hw/i386/intel_iommu.c          | 45 ++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index c0a94af820..8a375d038a 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -453,6 +453,9 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
 #define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & \
                                              VTD_DOMAIN_ID_MASK)
+#define VTD_INV_DESC_PIOTLB_ADDR(val)     ((val) & ~0xfffULL)
+#define VTD_INV_DESC_PIOTLB_AM(val)       ((val) & 0x3fULL)
+#define VTD_INV_DESC_PIOTLB_IH(val)       (((val) >> 6) & 0x1)
 
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0078bad9d4..f6c429ae4c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -304,6 +304,28 @@ static gboolean vtd_hash_remove_by_page(gpointer key, gpointer value,
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
@@ -2866,11 +2888,30 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     }
 }
 
+static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
+                                       uint32_t pasid, hwaddr addr, uint8_t am,
+                                       bool ih)
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
+    uint8_t am;
+    hwaddr addr;
 
     if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0) ||
         (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_RSVD_VAL1)) {
@@ -2887,6 +2928,10 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
         break;
 
     case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
+        am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
+        addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
+        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
+                                   VTD_INV_DESC_PIOTLB_IH(inv_desc->val[1]));
         break;
 
     default:
-- 
2.34.1


