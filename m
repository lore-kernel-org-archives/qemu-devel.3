Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAEDFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wILbW-0005XF-0j; Thu, 30 Apr 2026 03:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wILb3-0005Ad-Rx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:14:14 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wILb1-0008QN-Au
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777533243; x=1809069243;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QgQEKzeierZ7H50tnMUbHnRlrfJCILNdeLaWJtSesh0=;
 b=T/NlAFpLpWvNLHbDtT8nwQfovbNc8apLZ0OfQUq0xtbo8B9yWAhR8d0N
 /X4uLXylBmBlF4AfguuwvB7ZBRo/2rdlbjGg70ingsSuzAFCTvD6Nf3Bl
 uDWX0anYu84FxwrHSIMeOgCjZTVKqSj9anE05nsVlC5rzG3qZsiIprEWP
 kACvGsywD2B0A17CeeUSAeigVXMNQG8tQnTvXSkRYd1MoS0VtoAJBZVdb
 T8WTRjyCq8EdEnU+TE/j6WLD3Nv3530zRyMN98LEnvAjBvgmL2p/LEs1z
 krdd5O4ItihAT6hPJO5PacJJJSQmuNhNusXrC3TOTsaFrvtHQn6mP6Mv/ w==;
X-CSE-ConnectionGUID: 7kOLKJYBR2G+Erwz2JetEg==
X-CSE-MsgGUID: fWdTL0DsTiW6dI+Im/4Vfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="81051629"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="81051629"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:14:01 -0700
X-CSE-ConnectionGUID: 0dC+3/8hRyGaBClBp/nIzw==
X-CSE-MsgGUID: JzGx2nQcQNyLR1bGp8GE4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="234771533"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:13:59 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 08/15] intel_iommu: Use IOMMU_NO_PASID and delete PASID_0
Date: Thu, 30 Apr 2026 03:13:04 -0400
Message-ID: <20260430071315.354333-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430071315.354333-1-zhenzhong.duan@intel.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
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

In previous patch we introduced a global macro IOMMU_NO_PASID(0) for
Requests-without-PASID, this makes the local macro PASID_0 redundant.
Delete it and use IOMMU_NO_PASID instead.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 -
 hw/i386/intel_iommu.c          | 21 +++++++++++----------
 hw/i386/intel_iommu_accel.c    |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index c7e107fe87..0141316f83 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -615,7 +615,6 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_CTX_ENTRY_LEGACY_SIZE     16
 #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
 
-#define PASID_0                             0
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 74642d8123..4d1b262d56 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -100,7 +100,8 @@ static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
  *
  * Requests-without-PASID:
  *   - PCI subsystem: Uses PCI_NO_PASID (-1) to indicate no PASID present
- *   - VT-d IOMMU:    Uses PASID_0 (0) to index the PASID table for translation
+ *   - VT-d IOMMU:    Uses IOMMU_NO_PASID (0) to index the PASID table for
+ *                    translation
  *
  * Requests-with-PASID:
  *   - Both subsystems use identical PASID values (1-0xFFFFF)
@@ -114,7 +115,7 @@ static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
  */
 static uint32_t vtd_pasid_to_pci_pasid(uint32_t pasid)
 {
-    if (pasid == PASID_0) {
+    if (pasid == IOMMU_NO_PASID) {
         pasid = PCI_NO_PASID;
     }
     return pasid;
@@ -969,7 +970,7 @@ int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
     dma_addr_t pasid_dir_base;
 
     if (pasid == PCI_NO_PASID) {
-        pasid = PASID_0;
+        pasid = IOMMU_NO_PASID;
     }
     pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
     return vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
@@ -986,7 +987,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (pasid == PCI_NO_PASID) {
-        pasid = PASID_0;
+        pasid = IOMMU_NO_PASID;
     }
     pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
 
@@ -1529,9 +1530,9 @@ static int vtd_ce_pasid_0_check(IntelIOMMUState *s, VTDContextEntry *ce)
 
     /*
      * Make sure in Scalable Mode, a present context entry
-     * has valid pasid entry setting at PASID_0.
+     * has valid pasid entry setting at IOMMU_NO_PASID.
      */
-    return vtd_ce_get_pasid_entry(s, ce, &pe, PASID_0);
+    return vtd_ce_get_pasid_entry(s, ce, &pe, IOMMU_NO_PASID);
 }
 
 /* Map a device to its corresponding domain (context-entry) */
@@ -1592,7 +1593,7 @@ int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         }
     } else {
         /*
-         * Check if the programming of pasid setting of PASID_0
+         * Check if the programming of pasid setting of IOMMU_NO_PASID
          * is valid, and thus avoids to check pasid entry fetching
          * result in future helper function calling.
          */
@@ -2150,7 +2151,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     vtd_iommu_lock(s);
 
     if (pasid == PCI_NO_PASID && s->root_scalable) {
-        pasid = PASID_0;
+        pasid = IOMMU_NO_PASID;
     }
 
     /* Try to fetch pte from IOTLB */
@@ -2515,7 +2516,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
 }
 
 /*
- * There is no pasid field in iotlb invalidation descriptor, so PASID_0
+ * There is no pasid field in iotlb invalidation descriptor, so IOMMU_NO_PASID
  * is passed as parameter. Piotlb invalidation supports pasid, pasid in its
  * descriptor is passed. In both cases, pasid is converted to PCI pasid
  * before checking with vtd_as->pasid.
@@ -2586,7 +2587,7 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &info);
     vtd_iommu_unlock(s);
-    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, PASID_0);
+    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, IOMMU_NO_PASID);
 }
 
 /* Flush IOTLB
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index bd1236c070..8940d240a1 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -217,7 +217,7 @@ static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
 
     did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
 
-    if (piotlb_info->domain_id == did && piotlb_info->pasid == PASID_0) {
+    if (piotlb_info->domain_id == did && piotlb_info->pasid == IOMMU_NO_PASID) {
         HostIOMMUDeviceIOMMUFD *hiodi =
             HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
         uint32_t entry_num = 1; /* Only implement one request for simplicity */
-- 
2.47.3


