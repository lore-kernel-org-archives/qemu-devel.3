Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DF3CD343F
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 04:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLZ0M-0001LF-2f; Sat, 09 May 2026 00:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLZ07-0001HW-NO
 for qemu-devel@nongnu.org; Sat, 09 May 2026 00:09:17 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLZ05-0000KM-4u
 for qemu-devel@nongnu.org; Sat, 09 May 2026 00:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778299753; x=1809835753;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y7DgEP09S5eQsPL2KFXuc3RWzCtmohiRUmbsNMV+Dlg=;
 b=lAjPSVdyWPMY74CMe2yOQpe4IIhiZ6kXH7+S4CW8gFff9hExzwqegl4r
 ajoitNdJf2RR8YCcK/ovKgcVANe0MeB88voZAeN3iGgd1ikocgMumWhUv
 m0wTcxzfTChEIyyr0KexcDNnHCKlZtHlTqwDrPFu8+Zwziegdy6l9CFYa
 tBjYg8GaXgaZWvwrNtxvNwXfWuMaKrS6n0iKMKwGg0s9Ql9nMMUSgzDtf
 kLPYxJM7Bczn6AuvcnGrYa8AlJEI3WqOybBOhtwQ7nt9wwzIoGQBjT1QI
 otBLpzygZ/bKiZAyyIxprWF0iUGxXnkofc2Co5e6pplupJgrs/y/0FW90 Q==;
X-CSE-ConnectionGUID: aPremcImQv+DCqmE6TGqIQ==
X-CSE-MsgGUID: Ut8zBX8JTgiOxYtzE1KeEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90654457"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="90654457"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 21:09:06 -0700
X-CSE-ConnectionGUID: KkkPcpMBQWegyX2AExiA0g==
X-CSE-MsgGUID: WpW3Q5D+SL2msG2CecDX5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="235966532"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 21:09:02 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 07/15] intel_iommu: Use IOMMU_NO_PASID and delete PASID_0
Date: Sat,  9 May 2026 00:08:00 -0400
Message-ID: <20260509040819.1044702-8-zhenzhong.duan@intel.com>
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

In previous patch we introduced a global macro IOMMU_NO_PASID(0) for
the RID attachment, this makes the local macro PASID_0 redundant.
Delete it and use IOMMU_NO_PASID instead.

No functional changes intended.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 -
 hw/i386/intel_iommu.c          | 22 +++++++++++-----------
 hw/i386/intel_iommu_accel.c    |  2 +-
 3 files changed, 12 insertions(+), 13 deletions(-)

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
index 36af13cee3..5e5dcdc274 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -941,7 +941,7 @@ int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
     dma_addr_t pasid_dir_base;
 
     if (pasid == PCI_NO_PASID) {
-        pasid = PASID_0;
+        pasid = IOMMU_NO_PASID;
     }
     pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
     return vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
@@ -958,7 +958,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (pasid == PCI_NO_PASID) {
-        pasid = PASID_0;
+        pasid = IOMMU_NO_PASID;
     }
     pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
 
@@ -1501,9 +1501,9 @@ static int vtd_ce_pasid_0_check(IntelIOMMUState *s, VTDContextEntry *ce)
 
     /*
      * Make sure in Scalable Mode, a present context entry
-     * has valid pasid entry setting at PASID_0.
+     * has valid pasid entry setting at IOMMU_NO_PASID.
      */
-    return vtd_ce_get_pasid_entry(s, ce, &pe, PASID_0);
+    return vtd_ce_get_pasid_entry(s, ce, &pe, IOMMU_NO_PASID);
 }
 
 /* Map a device to its corresponding domain (context-entry) */
@@ -1564,7 +1564,7 @@ int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         }
     } else {
         /*
-         * Check if the programming of pasid setting of PASID_0
+         * Check if the programming of pasid setting of IOMMU_NO_PASID
          * is valid, and thus avoids to check pasid entry fetching
          * result in future helper function calling.
          */
@@ -2122,7 +2122,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     vtd_iommu_lock(s);
 
     if (pasid == PCI_NO_PASID && s->root_scalable) {
-        pasid = PASID_0;
+        pasid = IOMMU_NO_PASID;
     }
 
     /* Try to fetch pte from IOTLB */
@@ -2487,7 +2487,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
 }
 
 /*
- * There is no pasid field in iotlb invalidation descriptor, so PCI_NO_PASID
+ * There is no pasid field in iotlb invalidation descriptor, so IOMMU_NO_PASID
  * is passed as parameter. Piotlb invalidation supports pasid, pasid in its
  * descriptor is passed which should not be PCI_NO_PASID.
  */
@@ -2508,10 +2508,10 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
              * In legacy mode, vtd_as->pasid == pasid is always true.
              * In scalable mode, for vtd address space backing a PCI
              * device without pasid, needs to compare pasid with
-             * PASID_0 of this device.
+             * IOMMU_NO_PASID of this device.
              */
             if (!(vtd_as->pasid == pasid ||
-                  (vtd_as->pasid == PCI_NO_PASID && pasid == PASID_0))) {
+                  (vtd_as->pasid == PCI_NO_PASID && pasid == IOMMU_NO_PASID))) {
                 continue;
             }
 
@@ -2563,7 +2563,7 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &info);
     vtd_iommu_unlock(s);
-    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, PCI_NO_PASID);
+    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, IOMMU_NO_PASID);
 }
 
 /* Flush IOTLB
@@ -3022,7 +3022,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
         if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                       vtd_as->devfn, &ce) &&
             domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
-            if ((vtd_as->pasid != PCI_NO_PASID || pasid != PASID_0) &&
+            if ((vtd_as->pasid != PCI_NO_PASID || pasid != IOMMU_NO_PASID) &&
                 vtd_as->pasid != pasid) {
                 continue;
             }
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


