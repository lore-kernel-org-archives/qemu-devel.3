Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844C7FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wILbY-0005ck-7h; Thu, 30 Apr 2026 03:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wILai-00056o-R3; Thu, 30 Apr 2026 03:13:46 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wILaf-0008G4-2P; Thu, 30 Apr 2026 03:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777533221; x=1809069221;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GYtv3/y1PAiYkNdPRh1yU0HKiNPcdFTz7LmXJapcAb8=;
 b=nLTywqprvCwptADEubvX2Rvg9LYkaGeEI6Kz3dAbFXIEy8wlAeV5LTJ6
 2vZPqHX8bWWiRZtV/vCT3h0rwXtR5WfXYqbALvNmUxD9kzj1gCldgGU1g
 wmb27t/y9RlsJ70jU5ykfdEd12DjRSB8KjAu+EcFGDWVfJP9RMHZ/mYOW
 e5d27Gv0m7Pqax1hBgJIhc9uuRpw6Jq5ZQsBNvx0nzlUoLcjSj0MMhSI7
 GjfR/VCXGa5frvV2pb/Sqg/Vw4bhjRiawGshqvSlD/0Eafbh44SwK5pP/
 OxDJ3bSlqBbuOG7v+T3781+7xcW6USfp+IabS5SEUHTESL41UYtkoHRjI w==;
X-CSE-ConnectionGUID: zBDeOgClSE66AumqwhQjMw==
X-CSE-MsgGUID: NaMbZiXjR2+8o/HQq4cr5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="81051578"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="81051578"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:13:39 -0700
X-CSE-ConnectionGUID: lkPAgVpgStGtfNir11SX0Q==
X-CSE-MsgGUID: 3b5JeeReQMa0bOjKspMG7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="234771432"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:13:36 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 qemu-arm@nongnu.org
Subject: [PATCH v4 02/15] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Date: Thu, 30 Apr 2026 03:12:58 -0400
Message-ID: <20260430071315.354333-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430071315.354333-1-zhenzhong.duan@intel.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 include/system/iommufd.h    | 16 +++++++++++-----
 backends/iommufd.c          |  9 +++++----
 hw/arm/smmuv3-accel.c       | 12 ++++++++----
 hw/i386/intel_iommu_accel.c | 19 ++++++++++---------
 hw/vfio/iommufd.c           | 10 +++++-----
 5 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 2925d116ac..da98e79439 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -138,14 +138,16 @@ struct HostIOMMUDeviceIOMMUFDClass {
      *
      * @hiodi: host IOMMU device backed by IOMMUFD backend.
      *
+     * @pasid: target pasid of the device to be attached.
+     *
      * @hwpt_id: ID of IOMMUFD hardware page table.
      *
      * @errp: pass an Error out when attachment fails.
      *
      * Returns: true on success, false on failure.
      */
-    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *hiodi, uint32_t hwpt_id,
-                        Error **errp);
+    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *hiodi, uint32_t pasid,
+                        uint32_t hwpt_id, Error **errp);
     /**
      * @detach_hwpt: detach host IOMMU device from IOMMUFD hardware page table.
      * VFIO and VDPA device can have different implementation.
@@ -154,15 +156,19 @@ struct HostIOMMUDeviceIOMMUFDClass {
      *
      * @hiodi: host IOMMU device backed by IOMMUFD backend.
      *
+     * @pasid: target pasid of the device to be detached.
+     *
      * @errp: pass an Error out when attachment fails.
      *
      * Returns: true on success, false on failure.
      */
-    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *hiodi, Error **errp);
+    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *hiodi, uint32_t pasid,
+                        Error **errp);
 };
 
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
-                                           uint32_t hwpt_id, Error **errp);
-bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
+                                           uint32_t pasid, uint32_t hwpt_id,
                                            Error **errp);
+bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
+                                           uint32_t pasid, Error **errp);
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 410b044370..cfde6f2b2c 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -539,23 +539,24 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
 }
 
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
-                                           uint32_t hwpt_id, Error **errp)
+                                           uint32_t pasid, uint32_t hwpt_id,
+                                           Error **errp)
 {
     HostIOMMUDeviceIOMMUFDClass *hiodic =
         HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(hiodi);
 
     g_assert(hiodic->attach_hwpt);
-    return hiodic->attach_hwpt(hiodi, hwpt_id, errp);
+    return hiodic->attach_hwpt(hiodi, pasid, hwpt_id, errp);
 }
 
 bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
-                                           Error **errp)
+                                           uint32_t pasid, Error **errp)
 {
     HostIOMMUDeviceIOMMUFDClass *hiodic =
         HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(hiodi);
 
     g_assert(hiodic->detach_hwpt);
-    return hiodic->detach_hwpt(hiodi, errp);
+    return hiodic->detach_hwpt(hiodi, pasid, errp);
 }
 
 static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 862be814a0..2947e2e5dc 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -300,7 +300,8 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
         return false;
     }
 
-    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, hwpt_id, errp)) {
+    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, IOMMU_NO_PASID, hwpt_id,
+                                               errp)) {
         if (s1_hwpt) {
             iommufd_backend_free_id(hiodi->iommufd, s1_hwpt->hwpt_id);
             g_free(s1_hwpt);
@@ -575,7 +576,8 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
 
     /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
     hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
-    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, hwpt_id, errp)) {
+    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, IOMMU_NO_PASID, hwpt_id,
+                                               errp)) {
         goto free_veventq;
     }
     return true;
@@ -665,7 +667,8 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     hiodi = accel_dev->hiodi;
     accel = accel_dev->s_accel;
     /* Re-attach the default s2 hwpt id */
-    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, hiodi->hwpt_id, NULL)) {
+    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, IOMMU_NO_PASID,
+                                               hiodi->hwpt_id, NULL)) {
         error_report("Unable to attach the default HW pagetable: hiodi devid "
                      "0x%x", hiodi->devid);
     }
@@ -879,7 +882,8 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 
     hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
     QLIST_FOREACH(accel_dev, &accel->device_list, next) {
-        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->hiodi, hwpt_id,
+        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->hiodi,
+                                                   IOMMU_NO_PASID, hwpt_id,
                                                    &local_err)) {
             error_append_hint(&local_err, "Failed to attach GBPA hwpt %u for "
                               "hiodi devid %u", hwpt_id,
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index ed3793602b..3217a2afac 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -121,8 +121,9 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
         }
     }
 
-    ret = host_iommu_device_iommufd_attach_hwpt(hiodi, hwpt_id, errp);
-    trace_vtd_device_attach_hwpt(hiodi->devid, vtd_as->pasid, hwpt_id, ret);
+    ret = host_iommu_device_iommufd_attach_hwpt(hiodi, IOMMU_NO_PASID, hwpt_id,
+                                                errp);
+    trace_vtd_device_attach_hwpt(hiodi->devid, IOMMU_NO_PASID, hwpt_id, ret);
     if (ret) {
         /* Destroy old fs_hwpt if it's a replacement */
         vtd_destroy_old_fs_hwpt(hiodi, vtd_as);
@@ -141,22 +142,22 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
 {
     HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
     IntelIOMMUState *s = vtd_as->iommu_state;
-    uint32_t pasid = vtd_as->pasid;
     bool ret;
 
     if (s->dmar_enabled && s->root_scalable) {
-        ret = host_iommu_device_iommufd_detach_hwpt(hiodi, errp);
-        trace_vtd_device_detach_hwpt(hiodi->devid, pasid, ret);
+        ret = host_iommu_device_iommufd_detach_hwpt(hiodi, IOMMU_NO_PASID,
+                                                    errp);
+        trace_vtd_device_detach_hwpt(hiodi->devid, IOMMU_NO_PASID, ret);
     } else {
         /*
          * If DMAR remapping is disabled or guest switches to legacy mode,
          * we fallback to the default HWPT which contains shadow page table.
          * So guest DMA could still work.
          */
-        ret = host_iommu_device_iommufd_attach_hwpt(hiodi, hiodi->hwpt_id,
-                                                    errp);
-        trace_vtd_device_reattach_def_hwpt(hiodi->devid, pasid, hiodi->hwpt_id,
-                                           ret);
+        ret = host_iommu_device_iommufd_attach_hwpt(hiodi, IOMMU_NO_PASID,
+                                                    hiodi->hwpt_id, errp);
+        trace_vtd_device_reattach_def_hwpt(hiodi->devid, IOMMU_NO_PASID,
+                                           hiodi->hwpt_id, ret);
     }
 
     if (ret) {
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index f86f6f0d7b..78e7b6a045 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -934,21 +934,21 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
 
 static bool
 host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
-                                           uint32_t hwpt_id, Error **errp)
+                                           uint32_t pasid, uint32_t hwpt_id,
+                                           Error **errp)
 {
     VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
 
-    return !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
-                                                hwpt_id, errp);
+    return !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, pasid, hwpt_id, errp);
 }
 
 static bool
 host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
-                                           Error **errp)
+                                           uint32_t pasid, Error **errp)
 {
     VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
 
-    return iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, errp);
+    return iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, pasid, errp);
 }
 
 static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
-- 
2.47.3


