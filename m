Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED7A106F30F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5gkw-0002kj-72; Thu, 26 Mar 2026 05:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5gku-0002k7-3Y; Thu, 26 Mar 2026 05:11:56 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5gks-0003vM-7M; Thu, 26 Mar 2026 05:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774516315; x=1806052315;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=foksISldHtV0VQ/dVtjMN2IGqwNby9lo/p4TbgaTPyM=;
 b=S/4yt/wk+JJtZWGPA/0fcqFS6sTfDvzKLb3GDxO4s5xvoQX2QJedv/XJ
 hEN2O8Theiqsb7u9tv+U7NoDb0JmBNUSe4VmnQa4Mek7bnmxUDPi6tXyi
 JshUADtzWpgBcNkbnUCNBObxjP838jMlxM4E/bEHJgvd6HhJAiC/0xOZC
 H/ufcT7ED/QgKcBF+70pVLuD12KS1nRGtkX3JUXA5bQBQMfHNHwxlQui+
 zUo0xAcYVV0JrIHTpFa1X4QnQ4nPGC6T0DIhCOqp9lId2GPxHAUzg1ZC9
 g2nm2CNytSz0lAEvo4u2o8jPtEBIJEfQVtdYunI5ONXqQSVXFEpEuasNA A==;
X-CSE-ConnectionGUID: ZOom+LKaTpG03n+xihiHfQ==
X-CSE-MsgGUID: bM1kcCCdRdGz0fiG9oMjHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75531314"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="75531314"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:11:53 -0700
X-CSE-ConnectionGUID: EfT0KxC9ReK3U9pUUCrPiw==
X-CSE-MsgGUID: aXCffF3fRUiRYl1ChgUDOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="248368557"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:11:49 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 qemu-arm@nongnu.org
Subject: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Date: Thu, 26 Mar 2026 05:11:16 -0400
Message-ID: <20260326091130.321483-3-zhenzhong.duan@intel.com>
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

Same for the two wrappers and their call sites.

Suggested-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 include/system/iommufd.h    | 16 +++++++++++-----
 backends/iommufd.c          |  9 +++++----
 hw/arm/smmuv3-accel.c       | 12 ++++++++----
 hw/i386/intel_iommu_accel.c |  8 +++++---
 hw/vfio/iommufd.c           | 10 +++++-----
 5 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 7062944fe6..45a9e87cb0 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -138,14 +138,16 @@ struct HostIOMMUDeviceIOMMUFDClass {
      *
      * @idev: host IOMMU device backed by IOMMUFD backend.
      *
+     * @pasid: target pasid of attach.
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
@@ -154,15 +156,19 @@ struct HostIOMMUDeviceIOMMUFDClass {
      *
      * @idev: host IOMMU device backed by IOMMUFD backend.
      *
+     * @pasid: target pasid of detach.
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
index e1fee16acf..ab612e4874 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -539,23 +539,24 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
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
index 65c2f44880..0af6b3296d 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -300,7 +300,8 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
         return false;
     }
 
-    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID, hwpt_id,
+                                               errp)) {
         if (s1_hwpt) {
             iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
             g_free(s1_hwpt);
@@ -575,7 +576,8 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
 
     /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
     hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
-    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID, hwpt_id,
+                                               errp)) {
         goto free_veventq;
     }
     return true;
@@ -665,7 +667,8 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     idev = accel_dev->idev;
     accel = accel_dev->s_accel;
     /* Re-attach the default s2 hwpt id */
-    if (!host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, NULL)) {
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID,
+                                               idev->hwpt_id, NULL)) {
         error_report("Unable to attach the default HW pagetable: idev devid "
                      "0x%x", idev->devid);
     }
@@ -879,7 +882,8 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 
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
index 93f1e61a8c..e822039858 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -927,21 +927,21 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
 
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


