Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6F0C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW63-0006CK-45; Fri, 20 Jun 2025 03:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW61-00067Z-0g
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:33 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5y-0008OF-Vp
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404211; x=1781940211;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nnvG2xtnaKIFcWQTmrzVrU+8r3z7FiJUhlrx+0+GXLc=;
 b=FZomA7fCFyn+hlTbzTZJ8bh/PSCQCgFV4mL9PAhBd69pOofuJgjq5VFG
 KdhQ0LyvruRxzyxtsnQRU5w9Sd6TIYYl5w7ysch7dQabKJ/STEYN2KlDD
 t/pF+MQ4ZYg8yOocKmRhbixXMLWXThsE9UUOEUXkQnx4Dl7LWJQfaCIHg
 JgxKswiFAfbcyZXHD84Yw3Fn6jH+KTzrgGNAtGhV9URJ3YpJ3RxX9A+ZZ
 Vn0DuIr2arUpnjamG8+WgLlxAQNRpesMkzuqFvF4jqDVmfonZ7XKvR47K
 F6+nLfdKcO0I6xjxX6z9YceHi1jGOxNTzJ3jTdff7E/cgEmSC5Hiji7DR Q==;
X-CSE-ConnectionGUID: pPusw6J7TR6yKoJ7ZjZtjQ==
X-CSE-MsgGUID: vY0cCvcnSVibTAxUI9CvSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532513"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532513"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:23:29 -0700
X-CSE-ConnectionGUID: n6HAxrRLQzOGyBjWIYbVtg==
X-CSE-MsgGUID: n5B5d+pKT7SGSvsDlqWw4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863267"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:23:25 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 16/19] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
Date: Fri, 20 Jun 2025 15:18:10 +0800
Message-Id: <20250620071813.55571-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620071813.55571-1-zhenzhong.duan@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

Intel VT-d 3.0 supports nested translation in PASID granular. Guest SVA support
could be implemented by configuring nested translation on specific PASID. This
is also known as dual stage DMA translation.

Under such configuration, guest owns the GVA->GPA translation which is
configured as stage-1 page table in host side for a specific pasid, and host
owns GPA->HPA translation. As guest owns stage-1 translation table, piotlb
invalidation should be propagated to host since host IOMMU will cache first
level page table related mappings during DMA address translation.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |   6 ++
 hw/i386/intel_iommu.c          | 113 ++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index b3e4aa23f1..07bfb97499 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -589,6 +589,12 @@ typedef struct VTDPASIDCacheInfo {
     bool error_happened;
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
index 621b07aa02..d1fa395274 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2639,12 +2639,105 @@ static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as,
 
     return ret;
 }
+
+/*
+ * Caller of this function should hold iommu_lock.
+ */
+static void vtd_invalidate_piotlb(VTDAddressSpace *vtd_as,
+                                  struct iommu_hwpt_vtd_s1_invalidate *cache)
+{
+    VTDHostIOMMUDevice *vtd_hiod;
+    HostIOMMUDeviceIOMMUFD *idev;
+    int devfn = vtd_as->devfn;
+    struct vtd_as_key key = {
+        .bus = vtd_as->bus,
+        .devfn = devfn,
+    };
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    uint32_t entry_num = 1; /* Only implement one request for simplicity */
+    Error *err;
+
+    vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
+    if (!vtd_hiod || !vtd_hiod->hiod) {
+        return;
+    }
+    idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+
+    if (!iommufd_backend_invalidate_cache(idev->iommufd, vtd_hiod->s1_hwpt,
+                                          IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
+                                          sizeof(*cache), &entry_num, cache,
+                                          &err)) {
+        error_report_err(err);
+    }
+}
+
+/*
+ * This function is a loop function for the s->vtd_address_spaces
+ * list with VTDPIOTLBInvInfo as execution filter. It propagates
+ * the piotlb invalidation to host. Caller of this function
+ * should hold iommu_lock.
+ */
+static void vtd_flush_pasid_iotlb(gpointer key, gpointer value,
+                                  gpointer user_data)
+{
+    VTDPIOTLBInvInfo *piotlb_info = user_data;
+    VTDAddressSpace *vtd_as = value;
+    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    uint32_t pasid;
+    uint16_t did;
+
+    /* Replay only fill pasid entry cache for passthrough device */
+    if (!pc_entry->cache_filled ||
+        !vtd_pe_pgtt_is_flt(&pc_entry->pasid_entry)) {
+        return;
+    }
+
+    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
+        return;
+    }
+
+    did = vtd_pe_get_did(&pc_entry->pasid_entry);
+
+    if (piotlb_info->domain_id == did && piotlb_info->pasid == pasid) {
+        vtd_invalidate_piotlb(vtd_as, piotlb_info->inv_data);
+    }
+}
+
+static void vtd_flush_pasid_iotlb_all(IntelIOMMUState *s,
+                                      uint16_t domain_id, uint32_t pasid,
+                                      hwaddr addr, uint64_t npages, bool ih)
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
+     * Here loops all the vtd_as instances in s->vtd_address_spaces
+     * to find out the affected devices since piotlb invalidation
+     * should check pasid cache per architecture point of view.
+     */
+    g_hash_table_foreach(s->vtd_address_spaces,
+                         vtd_flush_pasid_iotlb, &piotlb_info);
+}
 #else
 static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as,
                                 VTDPASIDEntry *pe, VTDPASIDOp op)
 {
     return 0;
 }
+
+static void vtd_flush_pasid_iotlb_all(IntelIOMMUState *s,
+                                      uint16_t domain_id, uint32_t pasid,
+                                      hwaddr addr, uint64_t npages, bool ih)
+{
+}
 #endif
 
 /* Do a context-cache device-selective invalidation.
@@ -3300,6 +3393,13 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     info.pasid = pasid;
 
     vtd_iommu_lock(s);
+    /*
+     * Here loops all the vtd_as instances in s->vtd_as
+     * to find out the affected devices since piotlb invalidation
+     * should check pasid cache per architecture point of view.
+     */
+    vtd_flush_pasid_iotlb_all(s, domain_id, pasid, 0, (uint64_t)-1, 0);
+
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
                                 &info);
     vtd_iommu_unlock(s);
@@ -3323,7 +3423,8 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
 }
 
 static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
-                                       uint32_t pasid, hwaddr addr, uint8_t am)
+                                       uint32_t pasid, hwaddr addr, uint8_t am,
+                                       bool ih)
 {
     VTDIOTLBPageInvInfo info;
 
@@ -3333,6 +3434,13 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     info.mask = ~((1 << am) - 1);
 
     vtd_iommu_lock(s);
+    /*
+     * Here loops all the vtd_as instances in s->vtd_as
+     * to find out the affected devices since piotlb invalidation
+     * should check pasid cache per architecture point of view.
+     */
+    vtd_flush_pasid_iotlb_all(s, domain_id, pasid, addr, 1 << am, ih);
+
     g_hash_table_foreach_remove(s->iotlb,
                                 vtd_hash_remove_by_page_piotlb, &info);
     vtd_iommu_unlock(s);
@@ -3366,7 +3474,8 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
     case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
         am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
         addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
-        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am);
+        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
+                                   VTD_INV_DESC_PIOTLB_IH(inv_desc->val[1]));
         break;
 
     default:
-- 
2.34.1


