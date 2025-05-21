Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F0FC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhV2-0007iq-Hy; Wed, 21 May 2025 07:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhUc-0006oC-Oq
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:20:18 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhUX-0006s0-Mg
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747826409; x=1779362409;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yf2rtAHIjTAjyOB9iFxD9ZSf30ZHHb0aAOHee99yrSg=;
 b=aCBABWMsNs1IeeN60n7TTDDYvmoFDDNihl9zVuRvOaodDeRRBdKnKSUL
 1bvY1cHEWvXkEt9QkfJbYhXKrGfO6NnBPh8MNL4qpeS9O/R4uCNgyuv/g
 N3AIYzXOzIT3ze1+fE/2FLBbrLMrt6eeqWHxZS8ygNfSGm0LDPYUtynCJ
 l48YoeI9uNpqrUXm2lfFrknBKZGhVu2C8g+tzvh7f/IDaTQ/FgHXfXJSI
 dKO2fSwP5kmtMjyez8kWvE75Y9QZza5J0omaSSbBk/dZGoDzkpTzvZrhq
 cpyeKPp0QOecaQCAg6xDEgL1yROSZBoTrk/K/4xRzM1KtCxIj5I2KgbeZ A==;
X-CSE-ConnectionGUID: yvOrMII1Q8ahoI0geCcc2Q==
X-CSE-MsgGUID: dZs7/UXwRfOWrNoTCjvt9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49895155"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49895155"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:20:07 -0700
X-CSE-ConnectionGUID: bIrvWRhbSICpjhLKmg53zQ==
X-CSE-MsgGUID: nrWvXHGySz2SNLOnrNquaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145158460"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:20:02 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv3 18/21] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
Date: Wed, 21 May 2025 19:14:48 +0800
Message-Id: <20250521111452.3316354-19-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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
 hw/i386/intel_iommu.c          | 118 ++++++++++++++++++++++++++++++++-
 2 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 198726b48f..e4552ff9bd 100644
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
index d686d0ee1a..bb21060d7e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2932,12 +2932,110 @@ static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as,
 
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
+    Error *err;
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
+    if (!iommufd_backend_invalidate_cache(idev->iommufd, hwpt->hwpt_id,
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
@@ -3591,6 +3689,13 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
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
@@ -3613,7 +3718,8 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
 }
 
 static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
-                                       uint32_t pasid, hwaddr addr, uint8_t am)
+                                       uint32_t pasid, hwaddr addr, uint8_t am,
+                                       bool ih)
 {
     VTDIOTLBPageInvInfo info;
 
@@ -3623,6 +3729,13 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
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
@@ -3656,7 +3769,8 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
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


