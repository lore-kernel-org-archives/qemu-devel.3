Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2A7C83F10
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFDb-000309-BB; Tue, 08 Jul 2025 16:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDsL-0000eT-0y
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:12 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDsA-0008BN-JT
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752002459; x=1783538459;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ShIehTFb3p9MKkiVPnCmMIig5SMIJy5XRedD7Veywv8=;
 b=GI9hGU2QcO14NUcXxeHFu9RODDgSEZWMBSqV0VLeBjDTYPBQoTpOxSuT
 3SFuxAH3KpVV2zM416/w11gRWG67G9jsqiEzhNO4kctklnFXD8gIAw600
 lQNj83yepP6Y1nExzxrxfyT71Mno6jNu/8bkiWHgWLjwMU1peWvrcsDij
 WuJW5qOKOzcZnLWsbKnWXE8gk7bJLFJPuZ2afVnlp6YzYfmQ77gpm25OL
 GEs2tqL76/0d4Z2shsU1bNUekOc+/WcPrsFsxxAz/ihI+pkepC5Pcaz4g
 gHJoHGNxgAdIAubhLsnXHoWCFAfwaetTFWlzzv1oprsO/HuyLG/w/C/I7 g==;
X-CSE-ConnectionGUID: k4lxSEq/RK+3cWvcD0QC/A==
X-CSE-MsgGUID: xqQVJcRQTp6AEw4ignma4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57974075"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="57974075"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:07:21 -0700
X-CSE-ConnectionGUID: Ma1qJf7ySBGUD/B47JIUbg==
X-CSE-MsgGUID: TsCjrEuBRrKPn78hXtH+vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="192648014"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:07:17 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 16/20] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
Date: Tue,  8 Jul 2025 07:05:57 -0400
Message-ID: <20250708110601.633308-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708110601.633308-1-zhenzhong.duan@intel.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
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

From: Yi Liu <yi.l.liu@intel.com>

This traps the guest PASID-based iotlb invalidation request and propagate it
to host.

Intel VT-d 3.0 supports nested translation in PASID granularity. Guest SVA
support could be implemented by configuring nested translation on specific
pasid. This is also known as dual stage DMA translation.

Under such configuration, guest owns the GVA->GPA translation which is
configured as stage-1 page table on host side for a specific pasid, and host
owns GPA->HPA translation. As guest owns stage-1 translation table, piotlb
invalidation should be propagated to host since host IOMMU will cache first
level page table related mappings during DMA address translation.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c          | 95 +++++++++++++++++++++++++++++++++-
 hw/i386/intel_iommu_internal.h |  6 +++
 2 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 887830a855..d8b4296fe4 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2606,12 +2606,99 @@ static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, VTDPASIDOp op,
 
     return ret;
 }
+
+static void
+vtd_invalidate_piotlb_locked(VTDAddressSpace *vtd_as,
+                             struct iommu_hwpt_vtd_s1_invalidate *cache)
+{
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(s, vtd_as);
+    HostIOMMUDeviceIOMMUFD *idev;
+    uint32_t entry_num = 1; /* Only implement one request for simplicity */
+    Error *local_err = NULL;
+
+    if (!vtd_hiod || !vtd_as->s1_hwpt) {
+        return;
+    }
+    idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+
+    if (!iommufd_backend_invalidate_cache(idev->iommufd, vtd_as->s1_hwpt,
+                                          IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
+                                          sizeof(*cache), &entry_num, cache,
+                                          &local_err)) {
+        /* Something wrong in kernel, but trying to continue */
+        error_report_err(local_err);
+    }
+}
+
+/*
+ * This function is a loop function for the s->vtd_address_spaces
+ * list with VTDPIOTLBInvInfo as execution filter. It propagates
+ * the piotlb invalidation to host.
+ */
+static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
+                                         gpointer user_data)
+{
+    VTDPIOTLBInvInfo *piotlb_info = user_data;
+    VTDAddressSpace *vtd_as = value;
+    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    uint32_t pasid;
+    uint16_t did;
+
+    /* Replay only fills pasid entry cache for passthrough device */
+    if (!pc_entry->valid ||
+        !vtd_pe_pgtt_is_flt(&pc_entry->pasid_entry)) {
+        return;
+    }
+
+    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
+        return;
+    }
+
+    did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
+
+    if (piotlb_info->domain_id == did && piotlb_info->pasid == pasid) {
+        vtd_invalidate_piotlb_locked(vtd_as, piotlb_info->inv_data);
+    }
+}
+
+static void
+vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
+                                 uint16_t domain_id, uint32_t pasid,
+                                 hwaddr addr, uint64_t npages, bool ih)
+{
+    struct iommu_hwpt_vtd_s1_invalidate cache_info = { 0 };
+    VTDPIOTLBInvInfo piotlb_info;
+
+    cache_info.addr = addr;
+    cache_info.npages = npages;
+    cache_info.flags = ih ? IOMMU_VTD_INV_FLAGS_LEAF : 0;
+
+    piotlb_info.domain_id = domain_id;
+    piotlb_info.pasid = pasid;
+    piotlb_info.inv_data = &cache_info;
+
+    /*
+     * Go through each vtd_as instance in s->vtd_address_spaces, find out
+     * the affected host device which need host piotlb invalidation. Piotlb
+     * invalidation should check pasid cache per architecture point of view.
+     */
+    g_hash_table_foreach(s->vtd_address_spaces,
+                         vtd_flush_host_piotlb_locked, &piotlb_info);
+}
 #else
 static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, VTDPASIDOp op,
                                 Error **errp)
 {
     return 0;
 }
+
+static void
+vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
+                                 uint16_t domain_id, uint32_t pasid,
+                                 hwaddr addr, uint64_t npages, bool ih)
+{
+}
 #endif
 
 static int vtd_bind_guest_pasid_report_err(VTDAddressSpace *vtd_as,
@@ -3286,6 +3373,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
                                 &info);
+    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, 0, (uint64_t)-1, 0);
     vtd_iommu_unlock(s);
 
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
@@ -3307,7 +3395,8 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
 }
 
 static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
-                                       uint32_t pasid, hwaddr addr, uint8_t am)
+                                       uint32_t pasid, hwaddr addr, uint8_t am,
+                                       bool ih)
 {
     VTDIOTLBPageInvInfo info;
 
@@ -3319,6 +3408,7 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb,
                                 vtd_hash_remove_by_page_piotlb, &info);
+    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, addr, 1 << am, ih);
     vtd_iommu_unlock(s);
 
     vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, pasid);
@@ -3350,7 +3440,8 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
     case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
         am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
         addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
-        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am);
+        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
+                                   VTD_INV_DESC_PIOTLB_IH(inv_desc->val[1]));
         break;
 
     default:
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 9af073d843..f4982b19a2 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -595,6 +595,12 @@ typedef struct VTDPASIDCacheInfo {
     uint16_t devfn;
 } VTDPASIDCacheInfo;
 
+typedef struct VTDPIOTLBInvInfo {
+    uint16_t domain_id;
+    uint32_t pasid;
+    struct iommu_hwpt_vtd_s1_invalidate *inv_data;
+} VTDPIOTLBInvInfo;
+
 /* PASID Table Related Definitions */
 #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
 #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
-- 
2.47.1


