Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0882FCAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAUc-00032W-SN; Thu, 18 Sep 2025 04:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAUa-0002pp-Gh
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:52 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAUX-0004kl-4g
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758185989; x=1789721989;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Kk93UegMJO9MsHInGh48oCIawxlVHG3/YVcWpauVbGI=;
 b=GaYNoCitnD/99tBzJLQ+IjKxsYa3vzkc+AbkbQqk6blRAY78mfYJKJFP
 UZ2OxOBkFamn+tsAgm9dSLjHriM3zz82IBIEVCgAzYUvPXRtt3Jz0EzcK
 TBqCVVNrzxuWON/UQNuExSc/12NLYjqH0oacWP67XuG8DNuhhveg5OJp8
 OmHi7wLuXy1leBg2k6Oa3Ytrvfv4DlAmLE/bq7hHykxbRtYGdRC7fCujN
 INQKN8PfbyecWurgBQqdJcOk5MXUiEGQ7xsdmdCyS/WxgR8hmR6PnZaOc
 DrnOH4TXiMW8z0emBzCvJU4+lUDZLvisAhS2veriAPnt6IzWTYToV9FNK Q==;
X-CSE-ConnectionGUID: KHJh6CnjQLuYZEh/RX96AA==
X-CSE-MsgGUID: 3vbR6DySRoCOG6rXHDN/qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="78109557"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="78109557"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:38 -0700
X-CSE-ConnectionGUID: J+NUDOBfTx+6Bk3rr9NThQ==
X-CSE-MsgGUID: mXQwCackTx6EL1J4mRcnWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175930474"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:31 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 16/22] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
Date: Thu, 18 Sep 2025 04:57:55 -0400
Message-ID: <20250918085803.796942-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250918085803.796942-1-zhenzhong.duan@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
---
 hw/i386/intel_iommu_internal.h |  6 +++
 hw/i386/intel_iommu.c          | 85 +++++++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 3d5ee5ed52..d7c1ff4382 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -569,6 +569,12 @@ typedef struct VTDPASIDCacheInfo {
     bool reset;
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
index bfe229d0dc..92548f9573 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2514,11 +2514,88 @@ static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
 
     return ret;
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
+    if (piotlb_info->domain_id == did && piotlb_info->pasid == RID_PASID) {
+        HostIOMMUDeviceIOMMUFD *idev =
+            HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+        uint32_t entry_num = 1; /* Only implement one request for simplicity */
+        Error *local_err = NULL;
+        struct iommu_hwpt_vtd_s1_invalidate *cache = piotlb_info->inv_data;
+
+        if (!iommufd_backend_invalidate_cache(idev->iommufd, vtd_as->fs_hwpt,
+                                              IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
+                                              sizeof(*cache), &entry_num, cache,
+                                              &local_err)) {
+            /* Something wrong in kernel, but trying to continue */
+            error_report_err(local_err);
+        }
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
 static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
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
 
 /* Do a context-cache device-selective invalidation.
@@ -3159,6 +3236,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
                                 &info);
+    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, 0, (uint64_t)-1, 0);
     vtd_iommu_unlock(s);
 
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
@@ -3178,7 +3256,8 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
 }
 
 static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
-                                       uint32_t pasid, hwaddr addr, uint8_t am)
+                                       uint32_t pasid, hwaddr addr, uint8_t am,
+                                       bool ih)
 {
     VTDIOTLBPageInvInfo info;
 
@@ -3190,6 +3269,7 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb,
                                 vtd_hash_remove_by_page_piotlb, &info);
+    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, addr, 1 << am, ih);
     vtd_iommu_unlock(s);
 
     vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, pasid);
@@ -3221,7 +3301,8 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
     case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
         am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
         addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
-        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am);
+        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
+                                   VTD_INV_DESC_PIOTLB_IH(inv_desc->val[1]));
         break;
 
     default:
-- 
2.47.1


