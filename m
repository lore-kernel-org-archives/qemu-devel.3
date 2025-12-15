Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A635D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 06:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2Rc-0000EO-E4; Mon, 15 Dec 2025 01:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV2RO-0008Ue-5D
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 01:52:21 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV2RK-0000u9-Gm
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 01:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765781535; x=1797317535;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q3ZfVnvLRRI30A+V2H4/C3KAT4Hd80xvS2oaSTaFW54=;
 b=T4RIsexATCJ1K7s723gcT7hSQrrWG2j9rLczQUdwldv+PsfvgHjqRUxD
 S0FACOCDhYERyBgrsPxaKB+OleJawXRxxPQa7lmb/D5PBlghF9jDDbPa7
 VDDAa2EF+zlknZWfCqWvZlpc5FhizB6Und6kXbMnsvadrzcrwfBerR1x0
 jQDV2gU2Lwg81ORA6cxlJ4P/ySyVh/aLzbovoYVoZe46kEwaR73Mj9owO
 CcjOXGsLcQUpoo95mIqTXyMLkKQl1HEoIJB5VC6Gas3sLwgsIGtGgovDP
 f8HuqrPsnDDifaFiOtK7XlRbYwewcSPsSVnaFl9VT72qwgDni6YaFmppf g==;
X-CSE-ConnectionGUID: laiwtPHTSm+KgeVoZ9Rfag==
X-CSE-MsgGUID: 6HCZu8c6STSrASQzaVKphQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="71305038"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="71305038"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 22:52:14 -0800
X-CSE-ConnectionGUID: 2dm1dxN7QO2Ci1mK4SW7LQ==
X-CSE-MsgGUID: WXETWwMURl29Via+BeFcdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197408838"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 22:52:10 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v9 14/19] intel_iommu_accel: Propagate PASID-based iotlb
 invalidation to host
Date: Mon, 15 Dec 2025 01:50:38 -0500
Message-ID: <20251215065046.86991-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251215065046.86991-1-zhenzhong.duan@intel.com>
References: <20251215065046.86991-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
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
configured as first stage page table on host side for a specific pasid, and
host owns GPA->HPA translation. As guest owns first stage translation table,
piotlb invalidation should be propagated to host since host IOMMU will cache
first level page table related mappings during DMA address translation.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/i386/intel_iommu_accel.h    | 10 +++++
 hw/i386/intel_iommu_internal.h |  6 +++
 hw/i386/intel_iommu.c          | 11 ++++--
 hw/i386/intel_iommu_accel.c    | 69 ++++++++++++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 82821ec0ef..3b0ecc7e22 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -17,6 +17,9 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp);
 VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
 bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
+void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
+                                      uint32_t pasid, hwaddr addr,
+                                      uint64_t npages, bool ih);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
                                         VTDHostIOMMUDevice *vtd_hiod,
@@ -37,5 +40,12 @@ static inline bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as,
 {
     return true;
 }
+
+static inline void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
+                                                    uint16_t domain_id,
+                                                    uint32_t pasid, hwaddr addr,
+                                                    uint64_t npages, bool ih)
+{
+}
 #endif
 #endif
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index e987322e93..a2ca79f925 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -622,6 +622,12 @@ typedef struct VTDPASIDCacheInfo {
     uint32_t pasid;
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
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index fd58fbdac7..e27f055d03 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2967,6 +2967,8 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
                                 &info);
+    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, 0, (uint64_t)-1,
+                                     false);
     vtd_iommu_unlock(s);
 
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
@@ -2986,7 +2988,8 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
 }
 
 static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
-                                       uint32_t pasid, hwaddr addr, uint8_t am)
+                                       uint32_t pasid, hwaddr addr, uint8_t am,
+                                       bool ih)
 {
     VTDIOTLBPageInvInfo info;
 
@@ -2998,6 +3001,7 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb,
                                 vtd_hash_remove_by_page_piotlb, &info);
+    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, addr, 1 << am, ih);
     vtd_iommu_unlock(s);
 
     vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, pasid);
@@ -3029,7 +3033,8 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
     case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
         am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
         addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
-        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am);
+        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
+                                   VTD_INV_DESC_PIOTLB_IH(inv_desc));
         break;
 
     default:
@@ -5176,7 +5181,7 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
     ret = 0;
     switch (pgtt) {
     case VTD_SM_PASID_ENTRY_FST:
-        vtd_piotlb_page_invalidate(s, domain_id, vtd_as->pasid, addr, 0);
+        vtd_piotlb_page_invalidate(s, domain_id, vtd_as->pasid, addr, 0, false);
         break;
     /* Room for other pgtt values */
     default:
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 748a6c7e1c..2996e4b640 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -182,3 +182,72 @@ bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
 
     return vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
 }
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
+    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
+    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    uint16_t did;
+
+    if (!vtd_hiod) {
+        return;
+    }
+
+    assert(vtd_as->pasid == PCI_NO_PASID);
+
+    /* Nothing to do if there is no first stage HWPT attached */
+    if (!pc_entry->valid ||
+        !vtd_pe_pgtt_is_fst(&pc_entry->pasid_entry)) {
+        return;
+    }
+
+    did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
+
+    if (piotlb_info->domain_id == did && piotlb_info->pasid == PASID_0) {
+        HostIOMMUDeviceIOMMUFD *idev =
+            HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+        uint32_t entry_num = 1; /* Only implement one request for simplicity */
+        Error *local_err = NULL;
+        struct iommu_hwpt_vtd_s1_invalidate *cache = piotlb_info->inv_data;
+
+        if (!iommufd_backend_invalidate_cache(idev->iommufd, vtd_as->fs_hwpt_id,
+                                              IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
+                                              sizeof(*cache), &entry_num, cache,
+                                              &local_err)) {
+            /* Something wrong in kernel, but trying to continue */
+            error_report_err(local_err);
+        }
+    }
+}
+
+void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
+                                      uint32_t pasid, hwaddr addr,
+                                      uint64_t npages, bool ih)
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
+     * affected host devices which need host piotlb invalidation. Piotlb
+     * invalidation should check pasid cache per architecture point of view.
+     */
+    g_hash_table_foreach(s->vtd_address_spaces,
+                         vtd_flush_host_piotlb_locked, &piotlb_info);
+}
-- 
2.47.1


