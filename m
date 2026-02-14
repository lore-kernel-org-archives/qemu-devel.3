Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE646EF99FA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 03:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr6Xf-00057P-JF; Fri, 13 Feb 2026 22:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vr6Xe-00057C-Ik; Fri, 13 Feb 2026 22:41:58 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vr6Xc-0008J1-MF; Fri, 13 Feb 2026 22:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771040517; x=1802576517;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0CFY7/ec9WolJ0TC6427evSbm7/oQkZWjLHaiUI4x3g=;
 b=mAsyMQFF/TwWyG7XfchwMY0IAKo/p/8WqV2nJvy+/si3zHS2EMesJeeQ
 EKrXemFNRC8RTKcegXDXoNBYPnB1liaVdiSc0xzWUBfl+zjTXa5ZekSUf
 guJ7O0SwQj7l5VVtAQJ1QMZjukJ7G9jr6cTGGxVh9L5z2/Aaiw1w2Bxyp
 S8F+uIOJFegoyJNFSk4VxSoE3ApDW7BODKidFAabl6OYbVDbgQlrgF3fY
 6XspU4IZMPT4sLYjqrJYg4lS32rnCknv8oe25tlbEPRHDsnw1N/Ubiuth
 XBAWtKkOE1EJ9eXxelKVXIeXHCI9n14iqIce+BjUxDXro4xiMXiOkA65O Q==;
X-CSE-ConnectionGUID: +qVceJa/QBaaG1Yt/mj4lQ==
X-CSE-MsgGUID: YhlYKltXSGeYM5NchmSJnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="83666805"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="83666805"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 19:41:55 -0800
X-CSE-ConnectionGUID: 4VMdouigT7+3Wyc3EC2GCw==
X-CSE-MsgGUID: UBD6mkS/S4KsdQyUgsnuQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="212932941"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 19:41:51 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 qemu-arm@nongnu.org
Subject: [RFCv2 PATCH 02/13] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Date: Fri, 13 Feb 2026 22:41:22 -0500
Message-ID: <20260214034135.220413-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260214034135.220413-1-zhenzhong.duan@intel.com>
References: <20260214034135.220413-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
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

Same for the two wrappers and their call sites.

Suggested-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/iommufd.h    | 16 +++++++++++-----
 backends/iommufd.c          |  9 +++++----
 hw/arm/smmuv3-accel.c       | 12 ++++++++----
 hw/i386/intel_iommu_accel.c |  8 +++++---
 hw/vfio/iommufd.c           | 10 +++++-----
 5 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 80d72469a9..80c8423654 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -124,14 +124,16 @@ struct HostIOMMUDeviceIOMMUFDClass {
      *
      * @idev: host IOMMU device backed by IOMMUFD backend.
      *
+     * @pasid: pasid of host IOMMU device.
+     *
      * @hwpt_id: ID of IOMMUFD hardware page table.
      *
      * @errp: pass an Error out when attachment fails.
      *
      * Returns: true on success, false on failure.
      */
-    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t hwpt_id,
-                        Error **errp);
+    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t pasid,
+                        uint32_t hwpt_id, Error **errp);
     /**
      * @detach_hwpt: detach host IOMMU device from IOMMUFD hardware page table.
      * VFIO and VDPA device can have different implementation.
@@ -140,15 +142,19 @@ struct HostIOMMUDeviceIOMMUFDClass {
      *
      * @idev: host IOMMU device backed by IOMMUFD backend.
      *
+     * @pasid: pasid of host IOMMU device.
+     *
      * @errp: pass an Error out when attachment fails.
      *
      * Returns: true on success, false on failure.
      */
-    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, Error **errp);
+    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t pasid,
+                        Error **errp);
 };
 
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
-                                           uint32_t hwpt_id, Error **errp);
-bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           uint32_t pasid, uint32_t hwpt_id,
                                            Error **errp);
+bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           uint32_t pasid, Error **errp);
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 13822df82f..153edf4f79 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -505,23 +505,24 @@ bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
 }
 
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
-                                           uint32_t hwpt_id, Error **errp)
+                                           uint32_t pasid, uint32_t hwpt_id,
+                                           Error **errp)
 {
     HostIOMMUDeviceIOMMUFDClass *idevc =
         HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
 
     g_assert(idevc->attach_hwpt);
-    return idevc->attach_hwpt(idev, hwpt_id, errp);
+    return idevc->attach_hwpt(idev, pasid, hwpt_id, errp);
 }
 
 bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
-                                           Error **errp)
+                                           uint32_t pasid, Error **errp)
 {
     HostIOMMUDeviceIOMMUFDClass *idevc =
         HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
 
     g_assert(idevc->detach_hwpt);
-    return idevc->detach_hwpt(idev, errp);
+    return idevc->detach_hwpt(idev, pasid, errp);
 }
 
 static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f5cd4df336..6b04344959 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -294,7 +294,8 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
         return false;
     }
 
-    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID, hwpt_id,
+                                               errp)) {
         if (s1_hwpt) {
             iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
             g_free(s1_hwpt);
@@ -436,7 +437,8 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
 
     /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
     hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
-    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID, hwpt_id,
+                                               errp)) {
         goto free_bypass_hwpt;
     }
     accel->viommu = viommu;
@@ -524,7 +526,8 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     idev = accel_dev->idev;
     accel = accel_dev->s_accel;
     /* Re-attach the default s2 hwpt id */
-    if (!host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, NULL)) {
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID,
+                                               idev->hwpt_id, NULL)) {
         error_report("Unable to attach the default HW pagetable: idev devid "
                      "0x%x", idev->devid);
     }
@@ -720,7 +723,8 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 
     hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
     QLIST_FOREACH(accel_dev, &accel->device_list, next) {
-        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev, hwpt_id,
+        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
+                                                   IOMMU_NO_PASID, hwpt_id,
                                                    &local_err)) {
             error_append_hint(&local_err, "Failed to attach GBPA hwpt %u for "
                               "idev devid %u", hwpt_id, accel_dev->idev->devid);
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 67d54849f2..45c08c8f6f 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -121,7 +121,8 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
         }
     }
 
-    ret = host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
+    ret = host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID, hwpt_id,
+                                                errp);
     trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);
     if (ret) {
         /* Destroy old fs_hwpt if it's a replacement */
@@ -145,7 +146,7 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     bool ret;
 
     if (s->dmar_enabled && s->root_scalable) {
-        ret = host_iommu_device_iommufd_detach_hwpt(idev, errp);
+        ret = host_iommu_device_iommufd_detach_hwpt(idev, IOMMU_NO_PASID, errp);
         trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
     } else {
         /*
@@ -153,7 +154,8 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
          * we fallback to the default HWPT which contains shadow page table.
          * So guest DMA could still work.
          */
-        ret = host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
+        ret = host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID,
+                                                    idev->hwpt_id, errp);
         trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
                                            ret);
     }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index b4c5e81b1d..005f97fe25 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -924,21 +924,21 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
 
 static bool
 host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
-                                           uint32_t hwpt_id, Error **errp)
+                                           uint32_t pasid, uint32_t hwpt_id,
+                                           Error **errp)
 {
     VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
 
-    return !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
-                                                hwpt_id, errp);
+    return !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, pasid, hwpt_id, errp);
 }
 
 static bool
 host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
-                                           Error **errp)
+                                           uint32_t pasid, Error **errp)
 {
     VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
 
-    return iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, errp);
+    return iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, pasid, errp);
 }
 
 static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
-- 
2.47.3


