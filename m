Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC47D7308A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 03:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Vdq-0001FB-VV; Thu, 02 Apr 2026 23:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8Vdq-0001Ew-4S
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 23:56:18 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8Vdo-0004N9-Es
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 23:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775188576; x=1806724576;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iQaCmLmcKbdNrlzqxau5uvh3eGSoDbU2Iuqgw7ziD1M=;
 b=nBaQUD6UyH4yhBVgrkxnVxSZRUeTIBDSSKMWmdoBSBRRYay28bjodkGw
 8Y8z+Q+S9f7i0zoESsW8uPTkeGK4sxpN8CXI3NSYRreZg/6G9TViH2Zcp
 bICviZawERHXpu1HYsZNIJbY77G/QKhAEQy2yfhjaADt0GcXyLjIBZh/l
 3go3PevfCq3UpyhWEsczI634ucHT+ongCWmLya1bdFVjD+JIiKOwrylMD
 0hInipMTKKdpeOLAUL5uIv8WuOvxOjoBvASqgemVxErU2nI3jtEesXR5+
 ZdjOQGPDPPFrthzDr+T0gj7XMPx/+5SjvFxmrEcH3tnPW8YAdAEa2zRdl w==;
X-CSE-ConnectionGUID: r/9A47wSTQyqd50gkcmyyg==
X-CSE-MsgGUID: 32EXtFCgR22Ln9blBmh7WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76140638"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76140638"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 20:56:15 -0700
X-CSE-ConnectionGUID: 6AriUrPARGeJH4hE35nvww==
X-CSE-MsgGUID: exCLPoykTNmf0W7GENFdJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="223884888"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 20:56:12 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 07/14] intel_iommu: Use IOMMU_NO_PASID and delete PASID_0
Date: Thu,  2 Apr 2026 23:55:31 -0400
Message-ID: <20260403035541.18355-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403035541.18355-1-zhenzhong.duan@intel.com>
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
 hw/i386/intel_iommu.c          | 18 +++++++++---------
 hw/i386/intel_iommu_accel.c    |  2 +-
 3 files changed, 10 insertions(+), 11 deletions(-)

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
index aa67c89e73..3b8d3a96d2 100644
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


