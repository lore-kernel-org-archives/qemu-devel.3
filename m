Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AA0EA7959
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnpng-0005iI-MN; Wed, 04 Feb 2026 22:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vnpnf-0005dD-3a
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:12:59 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vnpnc-0001wl-KT
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770261176; x=1801797176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WGBJFTz1kTDMEefQhbEORXzou4JeuUNOn7Nt24iQBLc=;
 b=hQvfX0l+sXiuY+Ejw+sXMfIUF1D8qynAVaEEMEdr2NvKr6hkBw8YP6Fq
 qaemREHNr2eqyH6IlYcAowdq0ZbVp9wQ59UbfcXKYVr0A4pOzP5BJ5QRF
 kpio2XE4S/puV/v6OzQo9c5yRKsxqnVcpV+XamrYk4B/JTdqqq6VvBSlK
 jplUJQpThLesZ9qjcr6VEVccYqCSUK5bbRqM2SZNPWar1MxVR0LefommZ
 QNc2h7LzLnB73h0ADrQR50TRN/oa62n9mMUD3u0h5L2pNfGTT3FrpZFjH
 A/fPxvnLmXNWnlpZi9tbiGMl7QAr2xRggSDZIgJ3LdxvqN8txmKm5IeX5 g==;
X-CSE-ConnectionGUID: EbhLkbjyRiWiGxxtxkHvJg==
X-CSE-MsgGUID: itAddQfRTM6wFpu/iMxUCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96910508"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; d="scan'208";a="96910508"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 19:12:55 -0800
X-CSE-ConnectionGUID: ZsbCcKJgStK/3NhE93QDvQ==
X-CSE-MsgGUID: CqxfQRKSQtORQ8Kt22l3Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; d="scan'208";a="209652069"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 19:12:51 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH 10/14] intel_iommu_accel: Support pasid binding/unbinding
 and PIOTLB flushing
Date: Wed,  4 Feb 2026 22:11:28 -0500
Message-ID: <20260205031133.74357-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205031133.74357-1-zhenzhong.duan@intel.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
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

We just switched to use VTDACCELPASIDCacheEntry to cache pasid entry of
a PASID, also need to switch the binding/unbinding and PIOTLB flushing
functions to use the same structure.

The backend implementations of binding/unbinding to nonzero PASID and
PASID_0 are different, so we need to check the pasid to call different
callbacks.

After the switching, we could remove accel related code from
vtd_pasid_cache_[reset/sync]_locked() to make intel_iommu.c cleaner.

The VTDAddressSpace of PASID_0 is still useful as VTD supports a legacy
mode which needs shadow page table instead of nested page table.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.h   |   2 +-
 include/hw/i386/intel_iommu.h |   2 -
 hw/i386/intel_iommu.c         |  17 +----
 hw/i386/intel_iommu_accel.c   | 128 ++++++++++++++++++----------------
 4 files changed, 70 insertions(+), 79 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 914c690c26..1ae46d9250 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -16,6 +16,7 @@ typedef struct VTDACCELPASIDCacheEntry {
     VTDHostIOMMUDevice *vtd_hiod;
     VTDPASIDEntry pe;
     uint32_t pasid;
+    uint32_t fs_hwpt_id;
     QLIST_ENTRY(VTDACCELPASIDCacheEntry) next;
 } VTDACCELPASIDCacheEntry;
 
@@ -23,7 +24,6 @@ typedef struct VTDACCELPASIDCacheEntry {
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp);
 VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
-bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
 void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                                       uint32_t pasid, hwaddr addr,
                                       uint64_t npages, bool ih);
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 5e5779e460..dfcd8ee652 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -154,8 +154,6 @@ struct VTDAddressSpace {
      * with the guest IOMMU pgtables for a device.
      */
     IOVATree *iova_tree;
-
-    uint32_t fs_hwpt_id;
 };
 
 struct VTDIOTLBEntry {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1d0f0bf68b..1626c8f96b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -86,8 +86,6 @@ static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
         VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
         if (pc_entry->valid) {
             pc_entry->valid = false;
-            /* It's fatal to get failure during reset */
-            vtd_propagate_guest_pasid(vtd_as, &error_fatal);
         }
     }
 }
@@ -3105,8 +3103,6 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     VTDPASIDEntry pe;
     IOMMUNotifier *n;
     uint16_t did;
-    const char *err_prefix = "Attaching to HWPT failed: ";
-    Error *local_err = NULL;
 
     if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
         if (!pc_entry->valid) {
@@ -3127,9 +3123,6 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
             vtd_address_space_unmap(vtd_as, n);
         }
         vtd_switch_address_space(vtd_as);
-
-        err_prefix = "Detaching from HWPT failed: ";
-        goto do_bind_unbind;
     }
 
     /*
@@ -3157,20 +3150,12 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     if (!pc_entry->valid) {
         pc_entry->pasid_entry = pe;
         pc_entry->valid = true;
-    } else if (vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
-        err_prefix = "Replacing HWPT attachment failed: ";
-    } else {
+    } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
         return;
     }
 
     vtd_switch_address_space(vtd_as);
     vtd_address_space_sync(vtd_as);
-
-do_bind_unbind:
-    /* TODO: Fault event injection into guest, report error to QEMU for now */
-    if (!vtd_propagate_guest_pasid(vtd_as, &local_err)) {
-        error_reportf_err(local_err, "%s", err_prefix);
-    }
 }
 
 static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 1d7dae87ec..5abc462a45 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -111,21 +111,22 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
 }
 
 static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
-                                    VTDAddressSpace *vtd_as)
+                                    VTDACCELPASIDCacheEntry *vtd_pce)
 {
-    if (!vtd_as->fs_hwpt_id) {
+    if (!vtd_pce->fs_hwpt_id) {
         return;
     }
-    iommufd_backend_free_id(idev->iommufd, vtd_as->fs_hwpt_id);
-    vtd_as->fs_hwpt_id = 0;
+    iommufd_backend_free_id(idev->iommufd, vtd_pce->fs_hwpt_id);
+    vtd_pce->fs_hwpt_id = 0;
 }
 
-static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
-                                      VTDAddressSpace *vtd_as, Error **errp)
+static bool vtd_device_attach_iommufd(VTDACCELPASIDCacheEntry *vtd_pce,
+                                      Error **errp)
 {
+    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
     HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
-    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
-    uint32_t hwpt_id = idev->hwpt_id;
+    VTDPASIDEntry *pe = &vtd_pce->pe;
+    uint32_t hwpt_id = idev->hwpt_id, pasid = vtd_pce->pasid;
     bool ret;
 
     /*
@@ -145,13 +146,18 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
         }
     }
 
-    ret = host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
-    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);
+    if (pasid == PASID_0) {
+        ret = host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
+    } else {
+        ret = host_iommu_device_iommufd_pasid_attach_hwpt(idev, pasid,
+                                                          hwpt_id, errp);
+    }
+    trace_vtd_device_attach_hwpt(idev->devid, pasid, hwpt_id, ret);
     if (ret) {
         /* Destroy old fs_hwpt if it's a replacement */
-        vtd_destroy_old_fs_hwpt(idev, vtd_as);
+        vtd_destroy_old_fs_hwpt(idev, vtd_pce);
         if (vtd_pe_pgtt_is_fst(pe)) {
-            vtd_as->fs_hwpt_id = hwpt_id;
+            vtd_pce->fs_hwpt_id = hwpt_id;
         }
     } else if (vtd_pe_pgtt_is_fst(pe)) {
         iommufd_backend_free_id(idev->iommufd, hwpt_id);
@@ -160,15 +166,19 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     return ret;
 }
 
-static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
-                                      VTDAddressSpace *vtd_as, Error **errp)
+static bool vtd_device_detach_iommufd(VTDACCELPASIDCacheEntry *vtd_pce,
+                                      Error **errp)
 {
+    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
     HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
-    IntelIOMMUState *s = vtd_as->iommu_state;
-    uint32_t pasid = vtd_as->pasid;
+    IntelIOMMUState *s = vtd_hiod->iommu_state;
+    uint32_t pasid = vtd_pce->pasid;
     bool ret;
 
-    if (s->dmar_enabled && s->root_scalable) {
+    if (pasid != PASID_0) {
+        ret = host_iommu_device_iommufd_pasid_detach_hwpt(idev, pasid, errp);
+        trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
+    } else if (s->dmar_enabled && s->root_scalable) {
         ret = host_iommu_device_iommufd_detach_hwpt(idev, errp);
         trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
     } else {
@@ -183,65 +193,40 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     }
 
     if (ret) {
-        vtd_destroy_old_fs_hwpt(idev, vtd_as);
+        vtd_destroy_old_fs_hwpt(idev, vtd_pce);
     }
 
     return ret;
 }
 
-bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
-{
-    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
-    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
-
-    /* Ignore emulated device or legacy VFIO backed device */
-    if (!vtd_as->iommu_state->fsts || !vtd_hiod) {
-        return true;
-    }
-
-    if (pc_entry->valid) {
-        return vtd_device_attach_iommufd(vtd_hiod, vtd_as, errp);
-    }
-
-    return vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
-}
-
 /*
- * This function is a loop function for the s->vtd_address_spaces
- * list with VTDPIOTLBInvInfo as execution filter. It propagates
- * the piotlb invalidation to host.
+ * This function is a loop function for the s->vtd_host_iommu_dev
+ * and vtd_hiod->pasid_cache_list lists with VTDPIOTLBInvInfo as
+ * execution filter. It propagates the piotlb invalidation to host.
  */
-static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
-                                         gpointer user_data)
+static void vtd_flush_host_piotlb(VTDACCELPASIDCacheEntry *vtd_pce,
+                                  VTDPIOTLBInvInfo *piotlb_info)
 {
-    VTDPIOTLBInvInfo *piotlb_info = user_data;
-    VTDAddressSpace *vtd_as = value;
-    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
-    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
+    VTDPASIDEntry *pe = &vtd_pce->pe;
     uint16_t did;
 
-    if (!vtd_hiod) {
-        return;
-    }
-
-    assert(vtd_as->pasid == PCI_NO_PASID);
-
     /* Nothing to do if there is no first stage HWPT attached */
-    if (!pc_entry->valid ||
-        !vtd_pe_pgtt_is_fst(&pc_entry->pasid_entry)) {
+    if (!vtd_pe_pgtt_is_fst(pe)) {
         return;
     }
 
-    did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
+    did = VTD_SM_PASID_ENTRY_DID(pe);
 
-    if (piotlb_info->domain_id == did && piotlb_info->pasid == PASID_0) {
+    if (piotlb_info->domain_id == did && piotlb_info->pasid == vtd_pce->pasid) {
         HostIOMMUDeviceIOMMUFD *idev =
             HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
         uint32_t entry_num = 1; /* Only implement one request for simplicity */
         Error *local_err = NULL;
         struct iommu_hwpt_vtd_s1_invalidate *cache = piotlb_info->inv_data;
 
-        if (!iommufd_backend_invalidate_cache(idev->iommufd, vtd_as->fs_hwpt_id,
+        if (!iommufd_backend_invalidate_cache(idev->iommufd,
+                                              vtd_pce->fs_hwpt_id,
                                               IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
                                               sizeof(*cache), &entry_num, cache,
                                               &local_err)) {
@@ -257,6 +242,8 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
 {
     struct iommu_hwpt_vtd_s1_invalidate cache_info = { 0 };
     VTDPIOTLBInvInfo piotlb_info;
+    VTDHostIOMMUDevice *vtd_hiod;
+    GHashTableIter as_it;
 
     cache_info.addr = addr;
     cache_info.npages = npages;
@@ -267,12 +254,19 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
     piotlb_info.inv_data = &cache_info;
 
     /*
-     * Go through each vtd_as instance in s->vtd_address_spaces, find out
-     * affected host devices which need host piotlb invalidation. Piotlb
-     * invalidation should check pasid cache per architecture point of view.
+     * Go through each vtd_pce in vtd_hiod->pasid_cache_list for each host
+     * device, find out affected host device pasid which need host piotlb
+     * invalidation. Piotlb invalidation should check pasid cache per
+     * architecture point of view.
      */
-    g_hash_table_foreach(s->vtd_address_spaces,
-                         vtd_flush_host_piotlb_locked, &piotlb_info);
+    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
+    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {
+        VTDACCELPASIDCacheEntry *vtd_pce;
+
+        QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
+            vtd_flush_host_piotlb(vtd_pce, &piotlb_info);
+        }
+    }
 }
 
 static void vtd_pasid_cache_invalidate_one(VTDACCELPASIDCacheEntry *vtd_pce,
@@ -280,6 +274,7 @@ static void vtd_pasid_cache_invalidate_one(VTDACCELPASIDCacheEntry *vtd_pce,
 {
     VTDPASIDEntry pe;
     uint16_t did;
+    Error *local_err = NULL;
 
     /*
      * VTD_INV_DESC_PASIDC_G_DSI and VTD_INV_DESC_PASIDC_G_PASID_SI require
@@ -305,6 +300,9 @@ static void vtd_pasid_cache_invalidate_one(VTDACCELPASIDCacheEntry *vtd_pce,
          * to be either all-zero or non-present. Either case means existing
          * pasid cache should be invalidated.
          */
+        if (!vtd_device_detach_iommufd(vtd_pce, &local_err)) {
+            error_reportf_err(local_err, "%s", "Detaching from HWPT failed: ");
+        }
         QLIST_REMOVE(vtd_pce, next);
         g_free(vtd_pce);
     }
@@ -325,11 +323,17 @@ static void vtd_find_add_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
                             VTDPASIDEntry *pe)
 {
     VTDACCELPASIDCacheEntry *vtd_pce;
+    Error *local_err = NULL;
 
     QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
         if (vtd_pce->pasid == pasid) {
             if (vtd_pasid_entry_compare(pe, &vtd_pce->pe)) {
                 vtd_pce->pe = *pe;
+
+                if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
+                    error_reportf_err(local_err, "%s",
+                                      "Replacing HWPT attachment failed: ");
+                }
             }
             return;
         }
@@ -340,6 +344,10 @@ static void vtd_find_add_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
     vtd_pce->pasid = pasid;
     vtd_pce->pe = *pe;
     QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
+
+    if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
+        error_reportf_err(local_err, "%s", "Attaching to HWPT failed: ");
+    }
 }
 
 /*
-- 
2.47.3


