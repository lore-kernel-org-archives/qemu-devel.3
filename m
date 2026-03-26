Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2506F106F30E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5glQ-0002pH-0L; Thu, 26 Mar 2026 05:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5glP-0002p7-4p
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:12:27 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5glM-0003yp-Gb
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774516345; x=1806052345;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IGzGznuODX+ECvA9aRO2+ucrUdFqIbMBnbYf+sV0zFc=;
 b=ItWQ3nWqiXEW/xuxZy/+MsBdq8Kq652JEtlDS5LBw4xryFtOcagd2KeO
 0l8e7hhXGtwbwm3Hn5Qr90wB9cSVnXmlRUCzys2qf65yX7h5PcBEDHPcZ
 Nz1FGNNspG8LWXbe6RAwxXiplQCnWBRj6mrF11/c+w/V63tbRJ2W6gHwu
 dVneOAKEkAvdXgT1k90y+k86DumrDqLFhUI339O7m/iik58InUijA2I5C
 mlY/MbFR60Z0AppoS45X1b74iK6hiHwv+KFzDzGE6CycjQYXSuIukZPxV
 IKfTKHTWhvOyWl/TWPK475d2VvqLfDYGCsenfFfmmIdD5tnBPQclf2paL w==;
X-CSE-ConnectionGUID: LrhrZEixQMi10O7dzAt/7g==
X-CSE-MsgGUID: qYGfUikFQImxA5R8MxOvIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75531388"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="75531388"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:12:24 -0700
X-CSE-ConnectionGUID: ZBib/HuLTbm+3MOdVPvP9A==
X-CSE-MsgGUID: 1+gbr28nR7mTAyiKDTmyWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="248368606"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:12:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 11/14] intel_iommu_accel: Support pasid binding/unbinding
 and PIOTLB flushing
Date: Thu, 26 Mar 2026 05:11:25 -0400
Message-ID: <20260326091130.321483-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326091130.321483-1-zhenzhong.duan@intel.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17;
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

We just switched to use VTDAccelPASIDCacheEntry to cache pasid entry of
passthrough device, also need to switch the binding/unbinding and PIOTLB
flushing functions to use the same structure.

After the switching, we could remove accel related code from
vtd_pasid_cache_[reset/sync]_locked() to make intel_iommu.c cleaner.

The VTDAddressSpace of PASID_0 is still useful as VTD supports a legacy
mode which needs shadow page table instead of nested page table.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.h   |   2 +-
 include/hw/i386/intel_iommu.h |   2 -
 hw/i386/intel_iommu.c         |  17 +----
 hw/i386/intel_iommu_accel.c   | 125 +++++++++++++++++-----------------
 4 files changed, 64 insertions(+), 82 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 1fb7ca0af6..c72856a8ff 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -16,6 +16,7 @@ typedef struct VTDAccelPASIDCacheEntry {
     VTDHostIOMMUDevice *vtd_hiod;
     VTDPASIDEntry pasid_entry;
     uint32_t pasid;
+    uint32_t fs_hwpt_id;
     QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
 } VTDAccelPASIDCacheEntry;
 
@@ -23,7 +24,6 @@ typedef struct VTDAccelPASIDCacheEntry {
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp);
 VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
-bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
 void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                                       uint32_t pasid, hwaddr addr,
                                       uint64_t npages, bool ih);
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 95c76015e4..1842ba5840 100644
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
index b022f3cb9e..f53642a611 100644
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
@@ -3126,8 +3124,6 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     VTDPASIDEntry pe;
     IOMMUNotifier *n;
     uint16_t did;
-    const char *err_prefix = "Attaching to HWPT failed: ";
-    Error *local_err = NULL;
 
     if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
         if (!pc_entry->valid) {
@@ -3148,9 +3144,6 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
             vtd_address_space_unmap(vtd_as, n);
         }
         vtd_switch_address_space(vtd_as);
-
-        err_prefix = "Detaching from HWPT failed: ";
-        goto do_bind_unbind;
     }
 
     /*
@@ -3178,20 +3171,12 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
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
index e9e67eb1a0..26543489fb 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -111,23 +111,24 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
 }
 
 static void vtd_destroy_old_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
-                                    VTDAddressSpace *vtd_as)
+                                    VTDAccelPASIDCacheEntry *vtd_pce)
 {
     HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
 
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
+static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
+                                      Error **errp)
 {
+    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
     HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
-    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
-    uint32_t hwpt_id = idev->hwpt_id;
+    VTDPASIDEntry *pe = &vtd_pce->pasid_entry;
+    uint32_t hwpt_id = idev->hwpt_id, pasid = vtd_pce->pasid;
     bool ret;
 
     /*
@@ -147,14 +148,13 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
         }
     }
 
-    ret = host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID, hwpt_id,
-                                                errp);
-    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);
+    ret = host_iommu_device_iommufd_attach_hwpt(idev, pasid, hwpt_id, errp);
+    trace_vtd_device_attach_hwpt(idev->devid, pasid, hwpt_id, ret);
     if (ret) {
         /* Destroy old fs_hwpt if it's a replacement */
-        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
+        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_pce);
         if (vtd_pe_pgtt_is_fst(pe)) {
-            vtd_as->fs_hwpt_id = hwpt_id;
+            vtd_pce->fs_hwpt_id = hwpt_id;
         }
     } else if (vtd_pe_pgtt_is_fst(pe)) {
         iommufd_backend_free_id(idev->iommufd, hwpt_id);
@@ -163,16 +163,17 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     return ret;
 }
 
-static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
-                                      VTDAddressSpace *vtd_as, Error **errp)
+static bool vtd_device_detach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
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
-        ret = host_iommu_device_iommufd_detach_hwpt(idev, IOMMU_NO_PASID, errp);
+    if (pasid != IOMMU_NO_PASID || (s->dmar_enabled && s->root_scalable)) {
+        ret = host_iommu_device_iommufd_detach_hwpt(idev, pasid, errp);
         trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
     } else {
         /*
@@ -180,72 +181,47 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
          * we fallback to the default HWPT which contains shadow page table.
          * So guest DMA could still work.
          */
-        ret = host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID,
+        ret = host_iommu_device_iommufd_attach_hwpt(idev, pasid,
                                                     idev->hwpt_id, errp);
         trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
                                            ret);
     }
 
     if (ret) {
-        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
+        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_pce);
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
+static void vtd_flush_host_piotlb(VTDAccelPASIDCacheEntry *vtd_pce,
+                                  VTDPIOTLBInvInfo *piotlb_info)
 {
-    VTDPIOTLBInvInfo *piotlb_info = user_data;
-    VTDAddressSpace *vtd_as = value;
-    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
-    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
+    VTDPASIDEntry *pe = &vtd_pce->pasid_entry;
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
@@ -261,6 +237,8 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
 {
     struct iommu_hwpt_vtd_s1_invalidate cache_info = { 0 };
     VTDPIOTLBInvInfo piotlb_info;
+    VTDHostIOMMUDevice *vtd_hiod;
+    GHashTableIter as_it;
 
     cache_info.addr = addr;
     cache_info.npages = npages;
@@ -271,12 +249,19 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
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
+        VTDAccelPASIDCacheEntry *vtd_pce;
+
+        QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
+            vtd_flush_host_piotlb(vtd_pce, &piotlb_info);
+        }
+    }
 }
 
 static void vtd_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
@@ -284,6 +269,7 @@ static void vtd_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
 {
     VTDPASIDEntry pe;
     uint16_t did;
+    Error *local_err = NULL;
 
     /*
      * VTD_INV_DESC_PASIDC_G_DSI and VTD_INV_DESC_PASIDC_G_PASID_SI require
@@ -309,6 +295,9 @@ static void vtd_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
          * to be either all-zero or non-present. Either case means existing
          * pasid cache should be invalidated.
          */
+        if (!vtd_device_detach_iommufd(vtd_pce, &local_err)) {
+            error_reportf_err(local_err, "%s", "Detaching from HWPT failed: ");
+        }
         QLIST_REMOVE(vtd_pce, next);
         g_free(vtd_pce);
 
@@ -333,11 +322,17 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
                               VTDPASIDEntry *pe)
 {
     VTDAccelPASIDCacheEntry *vtd_pce;
+    Error *local_err = NULL;
 
     QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
         if (vtd_pce->pasid == pasid) {
             if (vtd_pasid_entry_compare(pe, &vtd_pce->pasid_entry)) {
                 vtd_pce->pasid_entry = *pe;
+
+                if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
+                    error_reportf_err(local_err, "%s",
+                                      "Replacing HWPT attachment failed: ");
+                }
             }
             return;
         }
@@ -348,6 +343,10 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
     vtd_pce->pasid = pasid;
     vtd_pce->pasid_entry = *pe;
     QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
+
+    if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
+        error_reportf_err(local_err, "%s", "Attaching to HWPT failed: ");
+    }
 }
 
 /*
-- 
2.47.3


