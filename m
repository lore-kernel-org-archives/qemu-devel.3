Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8458CD29DF3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaqF-0007pd-DW; Tue, 13 Jan 2026 04:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqD-0007jA-R1
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqB-0003LO-LS
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zkgUI30UqNpEWdfbXel2rGa7YE71POmVLIyhPMvMxgc=;
 b=cErR34Q2PbmGohY1TLsdK6SM8nS3IJ2md4K9EQ+UL5d3Gx5QT+jGgL06twuQ4NsHRLI4mx
 kQRYHj5lpc5YSm3wll1OhZvCNVkvwYJXaXWQsQI0aLejanCf0TFeMAnV9zkKqkivsdVyuD
 ZURvLalSTwlUDbLnzQL+bRoavBIBRr0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-zfJBgum2OS-g29sPBbQw6A-1; Tue,
 13 Jan 2026 04:37:27 -0500
X-MC-Unique: zfJBgum2OS-g29sPBbQw6A-1
X-Mimecast-MFC-AGG-ID: zfJBgum2OS-g29sPBbQw6A_1768297046
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1A471800371; Tue, 13 Jan 2026 09:37:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 931F130001A8; Tue, 13 Jan 2026 09:37:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/41] intel_iommu_accel: Bind/unbind guest page table to host
Date: Tue, 13 Jan 2026 10:36:11 +0100
Message-ID: <20260113093637.1549214-16-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

This captures the guest PASID table entry modifications and propagates
the changes to host to attach a hwpt with type determined per guest IOMMU
PGTT configuration.

When PGTT=PT, attach PASID_0 to a second stage HWPT(GPA->HPA).
When PGTT=FST, attach PASID_0 to nested HWPT with nesting parent HWPT
coming from VFIO.

Co-Authored-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260106061304.314546-14-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i386/intel_iommu_accel.h   |   7 +++
 include/hw/i386/intel_iommu.h |   2 +
 hw/i386/intel_iommu.c         |  22 ++++++-
 hw/i386/intel_iommu_accel.c   | 114 ++++++++++++++++++++++++++++++++++
 hw/i386/trace-events          |   3 +
 5 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 9558148c517bd9c46e95e49c1884152f6c370799..30696765af61b8864b3577984c5d9bcd774d4212 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -16,6 +16,7 @@
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp);
 VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
+bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
                                         VTDHostIOMMUDevice *vtd_hiod,
@@ -30,5 +31,11 @@ static inline VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
 {
     return NULL;
 }
+
+static inline bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as,
+                                             Error **errp)
+{
+    return true;
+}
 #endif
 #endif
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 401322665ac8e1a25330825b9e506d3942249c92..6c61fd39c7bb737afaca47ef7921ee96a9e6e473 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -154,6 +154,8 @@ struct VTDAddressSpace {
      * with the guest IOMMU pgtables for a device.
      */
     IOVATree *iova_tree;
+
+    uint32_t fs_hwpt_id;
 };
 
 struct VTDIOTLBEntry {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9edd625b1a5d246c311efd510df3967749690c29..f9b80e3257b4e382fd0eb9f946f6b6691a3d09ab 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -87,7 +87,11 @@ static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
     g_hash_table_iter_init(&as_it, s->vtd_address_spaces);
     while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_as)) {
         VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
-        pc_entry->valid = false;
+        if (pc_entry->valid) {
+            pc_entry->valid = false;
+            /* It's fatal to get failure during reset */
+            vtd_propagate_guest_pasid(vtd_as, &error_fatal);
+        }
     }
 }
 
@@ -3073,6 +3077,8 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     VTDPASIDEntry pe;
     IOMMUNotifier *n;
     uint16_t did;
+    const char *err_prefix = "Attaching to HWPT failed: ";
+    Error *local_err = NULL;
 
     if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
         if (!pc_entry->valid) {
@@ -3093,7 +3099,9 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
             vtd_address_space_unmap(vtd_as, n);
         }
         vtd_switch_address_space(vtd_as);
-        return;
+
+        err_prefix = "Detaching from HWPT failed: ";
+        goto do_bind_unbind;
     }
 
     /*
@@ -3121,12 +3129,20 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     if (!pc_entry->valid) {
         pc_entry->pasid_entry = pe;
         pc_entry->valid = true;
-    } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
+    } else if (vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
+        err_prefix = "Replacing HWPT attachment failed: ";
+    } else {
         return;
     }
 
     vtd_switch_address_space(vtd_as);
     vtd_address_space_sync(vtd_as);
+
+do_bind_unbind:
+    /* TODO: Fault event injection into guest, report error to QEMU for now */
+    if (!vtd_propagate_guest_pasid(vtd_as, &local_err)) {
+        error_reportf_err(local_err, "%s", err_prefix);
+    }
 }
 
 static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index acc9cad959ef2e00f5b2783ea3975a91493d0521..69f82e8831f5f834126b9aa1550a6da8f2cc94c5 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -13,6 +13,7 @@
 #include "intel_iommu_internal.h"
 #include "intel_iommu_accel.h"
 #include "hw/pci/pci_bus.h"
+#include "trace.h"
 
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp)
@@ -68,3 +69,116 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
     }
     return NULL;
 }
+
+static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                               VTDPASIDEntry *pe, uint32_t *fs_hwpt_id,
+                               Error **errp)
+{
+    struct iommu_hwpt_vtd_s1 vtd = {};
+
+    vtd.flags = (VTD_SM_PASID_ENTRY_SRE(pe) ? IOMMU_VTD_S1_SRE : 0) |
+                (VTD_SM_PASID_ENTRY_WPE(pe) ? IOMMU_VTD_S1_WPE : 0) |
+                (VTD_SM_PASID_ENTRY_EAFE(pe) ? IOMMU_VTD_S1_EAFE : 0);
+    vtd.addr_width = vtd_pe_get_fs_aw(pe);
+    vtd.pgtbl_addr = (uint64_t)vtd_pe_get_fspt_base(pe);
+
+    return iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, idev->hwpt_id,
+                                      0, IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd),
+                                      &vtd, fs_hwpt_id, errp);
+}
+
+static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                    VTDAddressSpace *vtd_as)
+{
+    if (!vtd_as->fs_hwpt_id) {
+        return;
+    }
+    iommufd_backend_free_id(idev->iommufd, vtd_as->fs_hwpt_id);
+    vtd_as->fs_hwpt_id = 0;
+}
+
+static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
+                                      VTDAddressSpace *vtd_as, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
+    uint32_t hwpt_id = idev->hwpt_id;
+    bool ret;
+
+    /*
+     * We can get here only if flts=on, the supported PGTT is FST or PT.
+     * Catch invalid PGTT when processing invalidation request to avoid
+     * attaching to wrong hwpt.
+     */
+    if (!vtd_pe_pgtt_is_fst(pe) && !vtd_pe_pgtt_is_pt(pe)) {
+        error_setg(errp, "Invalid PGTT type %d",
+                   (uint8_t)VTD_SM_PASID_ENTRY_PGTT(pe));
+        return false;
+    }
+
+    if (vtd_pe_pgtt_is_fst(pe)) {
+        if (!vtd_create_fs_hwpt(idev, pe, &hwpt_id, errp)) {
+            return false;
+        }
+    }
+
+    ret = host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
+    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);
+    if (ret) {
+        /* Destroy old fs_hwpt if it's a replacement */
+        vtd_destroy_old_fs_hwpt(idev, vtd_as);
+        if (vtd_pe_pgtt_is_fst(pe)) {
+            vtd_as->fs_hwpt_id = hwpt_id;
+        }
+    } else if (vtd_pe_pgtt_is_fst(pe)) {
+        iommufd_backend_free_id(idev->iommufd, hwpt_id);
+    }
+
+    return ret;
+}
+
+static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
+                                      VTDAddressSpace *vtd_as, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    uint32_t pasid = vtd_as->pasid;
+    bool ret;
+
+    if (s->dmar_enabled && s->root_scalable) {
+        ret = host_iommu_device_iommufd_detach_hwpt(idev, errp);
+        trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
+    } else {
+        /*
+         * If DMAR remapping is disabled or guest switches to legacy mode,
+         * we fallback to the default HWPT which contains shadow page table.
+         * So guest DMA could still work.
+         */
+        ret = host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
+        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
+                                           ret);
+    }
+
+    if (ret) {
+        vtd_destroy_old_fs_hwpt(idev, vtd_as);
+    }
+
+    return ret;
+}
+
+bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
+{
+    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
+
+    /* Ignore emulated device or legacy VFIO backed device */
+    if (!vtd_as->iommu_state->fsts || !vtd_hiod) {
+        return true;
+    }
+
+    if (pc_entry->valid) {
+        return vtd_device_attach_iommufd(vtd_hiod, vtd_as, errp);
+    }
+
+    return vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
+}
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index b704f4f90c3db8ac84fb49d98237b60800b792c7..5a3ee1cf6418ba0713a716266e662ced2e3027f0 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -73,6 +73,9 @@ vtd_warn_invalid_qi_tail(uint16_t tail) "tail 0x%"PRIx16
 vtd_warn_ir_vector(uint16_t sid, int index, int vec, int target) "sid 0x%"PRIx16" index %d vec %d (should be: %d)"
 vtd_warn_ir_trigger(uint16_t sid, int index, int trig, int target) "sid 0x%"PRIx16" index %d trigger %d (should be: %d)"
 vtd_reset_exit(void) ""
+vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
+vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
+vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
 
 # amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
-- 
2.52.0


