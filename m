Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657D2CD343F
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 04:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLZ0P-0001MM-0e; Sat, 09 May 2026 00:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLZ0N-0001M8-CR
 for qemu-devel@nongnu.org; Sat, 09 May 2026 00:09:31 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLZ0K-0000Q3-Sg
 for qemu-devel@nongnu.org; Sat, 09 May 2026 00:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778299769; x=1809835769;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3kxhNNjS+GruRojlo+OOPJDsXiXYsd7toq3yLF+OKqY=;
 b=RvtRbFGRgtAxfDgP6RWN2FbbyPu5WZk9DQa5xS9al69PMJ3iPHqJj4E5
 WNkzKfvDxTRFhKGZx2ewjhwAH3/ya8FXiiBvA7UM8pmAR+uSHvbHd/Zs8
 XqC0Cm4E6U6QLr5kDXm2vpNdGQBfoS9hJiY4KvNY5TpTIn8CaFDzzTEd9
 Mp1BNKE53DLRaxHeKHIFrt/a7WCyRsQ2sEm1x3uITyyb31UiMQcKlSkGi
 dqGU5FLC4y0PXfZvztz6IhWJRdbo1APcVb4ypt+ISb9q6NnI6j5J1QJy4
 UJC/LOrJL6+uyhb2r7EMFE45dt6GUIRDVgdr64m83+UOjvStwiZJKOBAA Q==;
X-CSE-ConnectionGUID: zdyAOxi9T1O504exin9YSg==
X-CSE-MsgGUID: a8ScWZkgQtOVAC/xrJ3P6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90654498"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="90654498"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 21:09:28 -0700
X-CSE-ConnectionGUID: W6Zzpy1+RTSWji+rnLZBQQ==
X-CSE-MsgGUID: zuFhjcu0TVKQE9+UgrQLYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="235966578"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 21:09:24 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 13/15] intel_iommu_accel: Switch to VTDAccelPASIDCacheEntry
 for PASID bind/unbind and PIOTLB invalidation
Date: Sat,  9 May 2026 00:08:06 -0400
Message-ID: <20260509040819.1044702-14-zhenzhong.duan@intel.com>
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

This patch switches from VTDAddressSpace to VTDAccelPASIDCacheEntry for
handling PASID bind/unbind operations and PIOTLB invalidations in
passthrough scenarios. VTDAccelPASIDCacheEntry was introduced to cache
PASID entries for passthrough devices and is now ready to propagate
PASID bind/unbind operations and PIOTLB invalidations to the host.

Unlike the previous approach, VTDAccelPASIDCacheEntry supports both
IOMMU_NO_PASID (rid_pasid) and other valid PASIDs, so this switch drops
IOMMU_NO_PASID limitations that existed in the prior PASID bind/unbind
and PIOTLB invalidation path. For IOMMU_NO_PASID of passthrough devices,
VTDAddressSpace continues to handle shadow page modifications to the
host, but no longer manages PASID bind/unbind operations or PIOTLB
invalidations for passthrough scenarios.

Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_accel.h   |   2 +-
 include/hw/i386/intel_iommu.h |   2 -
 hw/i386/intel_iommu.c         |  17 +----
 hw/i386/intel_iommu_accel.c   | 131 +++++++++++++++++-----------------
 4 files changed, 68 insertions(+), 84 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index a2226b28b6..4a9003c92d 100644
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
index ac1b5f4d79..6067069e02 100644
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
index b1c1cd719a..4ddf66262c 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -111,24 +111,25 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
                                       fs_hwpt_id, errp);
 }
 
-static void vtd_destroy_old_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
-                                    VTDAddressSpace *vtd_as)
+static void vtd_destroy_old_fs_hwpt(VTDAccelPASIDCacheEntry *vtd_pce)
 {
-    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    HostIOMMUDeviceIOMMUFD *hiodi =
+        HOST_IOMMU_DEVICE_IOMMUFD(vtd_pce->vtd_hiod->hiod);
 
-    if (!vtd_as->fs_hwpt_id) {
+    if (!vtd_pce->fs_hwpt_id) {
         return;
     }
-    iommufd_backend_free_id(hiodi->iommufd, vtd_as->fs_hwpt_id);
-    vtd_as->fs_hwpt_id = 0;
+    iommufd_backend_free_id(hiodi->iommufd, vtd_pce->fs_hwpt_id);
+    vtd_pce->fs_hwpt_id = 0;
 }
 
-static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
-                                      VTDAddressSpace *vtd_as, Error **errp)
+static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
+                                      Error **errp)
 {
+    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
     HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
-    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
-    uint32_t hwpt_id = hiodi->hwpt_id;
+    VTDPASIDEntry *pe = &vtd_pce->pasid_entry;
+    uint32_t hwpt_id = hiodi->hwpt_id, pasid = vtd_pce->pasid;
     bool ret;
 
     /*
@@ -148,14 +149,13 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
         }
     }
 
-    ret = host_iommu_device_iommufd_attach_hwpt(hiodi, IOMMU_NO_PASID, hwpt_id,
-                                                errp);
-    trace_vtd_device_attach_hwpt(hiodi->devid, IOMMU_NO_PASID, hwpt_id, ret);
+    ret = host_iommu_device_iommufd_attach_hwpt(hiodi, pasid, hwpt_id, errp);
+    trace_vtd_device_attach_hwpt(hiodi->devid, pasid, hwpt_id, ret);
     if (ret) {
         /* Destroy old fs_hwpt if it's a replacement */
-        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
+        vtd_destroy_old_fs_hwpt(vtd_pce);
         if (vtd_pe_pgtt_is_fst(pe)) {
-            vtd_as->fs_hwpt_id = hwpt_id;
+            vtd_pce->fs_hwpt_id = hwpt_id;
         }
     } else if (vtd_pe_pgtt_is_fst(pe)) {
         iommufd_backend_free_id(hiodi->iommufd, hwpt_id);
@@ -164,17 +164,19 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     return ret;
 }
 
-static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
-                                      VTDAddressSpace *vtd_as, Error **errp)
+static bool vtd_device_detach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
+                                      Error **errp)
 {
+    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
     HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
-    IntelIOMMUState *s = vtd_as->iommu_state;
+
+    IntelIOMMUState *s = vtd_hiod->iommu_state;
+    uint32_t pasid = vtd_pce->pasid;
     bool ret;
 
-    if (s->dmar_enabled && s->root_scalable) {
-        ret = host_iommu_device_iommufd_detach_hwpt(hiodi, IOMMU_NO_PASID,
-                                                    errp);
-        trace_vtd_device_detach_hwpt(hiodi->devid, IOMMU_NO_PASID, ret);
+    if (pasid != IOMMU_NO_PASID || (s->dmar_enabled && s->root_scalable)) {
+        ret = host_iommu_device_iommufd_detach_hwpt(hiodi, pasid, errp);
+        trace_vtd_device_detach_hwpt(hiodi->devid, pasid, ret);
     } else {
         /*
          * If DMAR remapping is disabled or guest switches to legacy mode,
@@ -188,58 +190,32 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     }
 
     if (ret) {
-        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
+        vtd_destroy_old_fs_hwpt(vtd_pce);
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
+static void vtd_flush_host_piotlb_locked(VTDAccelPASIDCacheEntry *vtd_pce,
+                                         VTDPIOTLBInvInfo *piotlb_info)
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
-    assert(vtd_as->pasid == IOMMU_NO_PASID);
-
     /* Nothing to do if there is no first stage HWPT attached */
-    if (!pc_entry->valid ||
-        !vtd_pe_pgtt_is_fst(&pc_entry->pasid_entry)) {
+    if (!vtd_pe_pgtt_is_fst(pe)) {
         return;
     }
 
-    did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
+    did = VTD_SM_PASID_ENTRY_DID(pe);
 
-    if (piotlb_info->domain_id == did && piotlb_info->pasid == IOMMU_NO_PASID) {
+    if (piotlb_info->domain_id == did && piotlb_info->pasid == vtd_pce->pasid) {
         HostIOMMUDeviceIOMMUFD *hiodi =
             HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
         uint32_t entry_num = 1; /* Only implement one request for simplicity */
@@ -247,7 +223,7 @@ static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
         struct iommu_hwpt_vtd_s1_invalidate *cache = piotlb_info->inv_data;
 
         if (!iommufd_backend_invalidate_cache(hiodi->iommufd,
-                                              vtd_as->fs_hwpt_id,
+                                              vtd_pce->fs_hwpt_id,
                                               IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
                                               sizeof(*cache), &entry_num, cache,
                                               &local_err)) {
@@ -263,6 +239,8 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
 {
     struct iommu_hwpt_vtd_s1_invalidate cache_info = { 0 };
     VTDPIOTLBInvInfo piotlb_info;
+    VTDHostIOMMUDevice *vtd_hiod;
+    GHashTableIter hiod_it;
 
     cache_info.addr = addr;
     cache_info.npages = npages;
@@ -273,23 +251,36 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
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
+    g_hash_table_iter_init(&hiod_it, s->vtd_host_iommu_dev);
+    while (g_hash_table_iter_next(&hiod_it, NULL, (void **)&vtd_hiod)) {
+        VTDAccelPASIDCacheEntry *vtd_pce;
+
+        QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
+            vtd_flush_host_piotlb_locked(vtd_pce, &piotlb_info);
+        }
+    }
 }
 
 static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
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
@@ -300,11 +291,21 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
     vtd_pce->pasid = pasid;
     vtd_pce->pasid_entry = *pe;
     QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
+
+    if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
+        error_reportf_err(local_err, "%s", "Attaching to HWPT failed: ");
+    }
 }
 
 static void vtd_accel_delete_pc(VTDAccelPASIDCacheEntry *vtd_pce,
                                 VTDPASIDCacheInfo *pc_info)
 {
+    Error *local_err = NULL;
+
+    if (!vtd_device_detach_iommufd(vtd_pce, &local_err)) {
+        error_reportf_err(local_err, "%s", "Detaching from HWPT failed: ");
+    }
+
     QLIST_REMOVE(vtd_pce, next);
     g_free(vtd_pce);
 
-- 
2.47.3


