Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5F5C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfQt-0006ks-Cp; Wed, 19 Feb 2025 03:27:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQc-00063c-Cw
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:37 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQZ-0004g2-N4
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953652; x=1771489652;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tBh6tA0va6cynvyYuShl6iuhaQZExg1BzepN1L8cTG4=;
 b=F/hlCVrEjRhgkDbcxgFeaI8P4yiyEo6D32ioqpCO0p6WzRWu3HN9nOGp
 9mmcu/KvZnZfqYWeN2Y1K9VvXcK2Hvr1jYgqbYHY48iHcQR/pP0g7uLOg
 M7Rg0TmxFIaaGeMhAZaUNCR1nUrqBWfkMEejkovLAqtsOdGwkfPOhAiOd
 CA+CdBy6IRkUBCaR3rH/rV2Vy70rfwOm/6genUmPBoB+UPTh890liEbqE
 rdAZXhKbgaug7/+h36gXpvrh95rbBJc5H1ZIvQ9a8yD4Rj4LS/Cdckg2+
 946eBhUkWXDmUfIw1I3hwcZr4+pq+QUIvi3etMr9u6tjae03Frc9Sc9G6 A==;
X-CSE-ConnectionGUID: dhMSwklvQHioGrZWgtCYIg==
X-CSE-MsgGUID: OGkpPujSSkS79jXeapN2bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544300"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544300"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:27:30 -0800
X-CSE-ConnectionGUID: p6mYlznwThua97D5YVrlgw==
X-CSE-MsgGUID: htWFNE/ZSqWZS2MwoRJ6CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119851408"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:27:24 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv2 17/20] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
Date: Wed, 19 Feb 2025 16:22:25 +0800
Message-Id: <20250219082228.3303163-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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
 hw/i386/intel_iommu.c          | 116 ++++++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 8f7be7f123..630394a8c3 100644
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
index e7376ba6a7..8f7fb473f5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2938,12 +2938,108 @@ static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as,
 
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
+    VTDHwpt *hwpt = &vtd_as->hwpt;
+    int devfn = vtd_as->devfn;
+    struct vtd_as_key key = {
+        .bus = vtd_as->bus,
+        .devfn = devfn,
+    };
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    uint32_t entry_num = 1; /* Only implement one request for simplicity */
+
+    if (!hwpt) {
+        return;
+    }
+
+    vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
+    if (!vtd_hiod || !vtd_hiod->hiod) {
+        return;
+    }
+    idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+
+    if (iommufd_backend_invalidate_cache(idev->iommufd, hwpt->hwpt_id,
+                                         IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
+                                         sizeof(*cache), &entry_num, cache)) {
+        error_report("Cache flush failed, entry_num %d", entry_num);
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
+    if (vtd_as_to_iommu_pasid(vtd_as, &pasid)) {
+        return;
+    }
+
+    did = vtd_pe_get_domain_id(&pc_entry->pasid_entry);
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
@@ -3597,6 +3693,13 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
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
@@ -3619,7 +3722,8 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
 }
 
 static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
-                                       uint32_t pasid, hwaddr addr, uint8_t am)
+                                       uint32_t pasid, hwaddr addr, uint8_t am,
+                                       bool ih)
 {
     VTDIOTLBPageInvInfo info;
 
@@ -3629,6 +3733,13 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
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
@@ -3662,7 +3773,8 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
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


