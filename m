Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF83C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 09:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKwCq-00083t-Ia; Fri, 30 May 2025 05:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uKwCn-00083H-Pl
 for qemu-devel@nongnu.org; Fri, 30 May 2025 05:39:14 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uKwCm-0006E7-1x
 for qemu-devel@nongnu.org; Fri, 30 May 2025 05:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748597952; x=1780133952;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=I+1Tmy4s6r2K7hGPZ7z3W7e3Gy3Luj1bV6KKdzf1un8=;
 b=QFkeKhUji6Nk/kS2sPQeS/mi6M+D/9CtWT/mhjGxGDIrInZCTa31ajlS
 fjFB4Y5exarD55CLHb/My75zNxqvWyCZ6F3+xQWLTVVeyaaQBbLRecid2
 4bZCmpXZ9Pvh4i80tiYIbdKMCYDcUQirz1awmfer00Gbx855EA6uBi8Ie
 RonjKebN3CeiMbtpURz3xWs0rp/C3cAlrSdSm+mB1OhGlXcR7h/zpY0bD
 OtLv76bzkgiAU4+VLT8dizJRYX9/XLZEyZeTM898JBYxUI4EUJCKCBAYr
 yVjmfu3OTKWXMA40Ovx3roh0s58TVrrG3SQ2vQIIgxCOKCJpk25xuNAQC Q==;
X-CSE-ConnectionGUID: rc8h/FowRj66M9Dq4u+bEA==
X-CSE-MsgGUID: N0rBFxwKQaefnUt1vzk0ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="60942056"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; d="scan'208";a="60942056"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 02:39:11 -0700
X-CSE-ConnectionGUID: DLehRV9ETs+nuFMOFybJ5Q==
X-CSE-MsgGUID: Ka5sLRyuQoePsq3aZlAvwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; d="scan'208";a="143788737"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 02:39:07 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 2/4] vfio/iommufd: Add properties and handlers to
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD
Date: Fri, 30 May 2025 17:35:10 +0800
Message-Id: <20250530093512.3959484-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

Enhance HostIOMMUDeviceIOMMUFD object with 3 new members, specific
to the iommufd BE + 2 new class functions.

IOMMUFD BE includes IOMMUFD handle, devid and hwpt_id. IOMMUFD handle
and devid are used to allocate/free ioas and hwpt. hwpt_id is used to
re-attach IOMMUFD backed device to its default VFIO sub-system created
hwpt, i.e., when vIOMMU is disabled by guest. These properties are
initialized in hiod::realize() after attachment.

2 new class functions are [at|de]tach_hwpt(). They are used to
attach/detach hwpt. VFIO and VDPA can have different implementions,
so implementation will be in sub-class instead of HostIOMMUDeviceIOMMUFD,
e.g., in HostIOMMUDeviceIOMMUFDVFIO.

Add two wrappers host_iommu_device_iommufd_[at|de]tach_hwpt to wrap the
two functions.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/system/iommufd.h | 50 ++++++++++++++++++++++++++++++++++++++++
 backends/iommufd.c       | 22 ++++++++++++++++++
 hw/vfio/iommufd.c        |  6 +++++
 3 files changed, 78 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 83ab8e1e4c..283861b924 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -67,4 +67,54 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
                                       Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
+OBJECT_DECLARE_TYPE(HostIOMMUDeviceIOMMUFD, HostIOMMUDeviceIOMMUFDClass,
+                    HOST_IOMMU_DEVICE_IOMMUFD)
+
+/* Overload of the host IOMMU device for the iommufd backend */
+struct HostIOMMUDeviceIOMMUFD {
+    HostIOMMUDevice parent_obj;
+
+    IOMMUFDBackend *iommufd;
+    uint32_t devid;
+    uint32_t hwpt_id;
+};
+
+struct HostIOMMUDeviceIOMMUFDClass {
+    HostIOMMUDeviceClass parent_class;
+
+    /**
+     * @attach_hwpt: attach host IOMMU device to IOMMUFD hardware page table.
+     * VFIO and VDPA device can have different implementation.
+     *
+     * Mandatory callback.
+     *
+     * @idev: host IOMMU device backed by IOMMUFD backend.
+     *
+     * @hwpt_id: ID of IOMMUFD hardware page table.
+     *
+     * @errp: pass an Error out when attachment fails.
+     *
+     * Returns: true on success, false on failure.
+     */
+    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t hwpt_id,
+                        Error **errp);
+    /**
+     * @detach_hwpt: detach host IOMMU device from IOMMUFD hardware page table.
+     * VFIO and VDPA device can have different implementation.
+     *
+     * Mandatory callback.
+     *
+     * @idev: host IOMMU device backed by IOMMUFD backend.
+     *
+     * @errp: pass an Error out when attachment fails.
+     *
+     * Returns: true on success, false on failure.
+     */
+    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, Error **errp);
+};
+
+bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           uint32_t hwpt_id, Error **errp);
+bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           Error **errp);
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 8bcdb60fe7..c2c47abf7e 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -347,6 +347,26 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
     return !ret;
 }
 
+bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           uint32_t hwpt_id, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFDClass *idevc =
+        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
+
+    g_assert(idevc->attach_hwpt);
+    return idevc->attach_hwpt(idev, hwpt_id, errp);
+}
+
+bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           Error **errp)
+{
+    HostIOMMUDeviceIOMMUFDClass *idevc =
+        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
+
+    g_assert(idevc->detach_hwpt);
+    return idevc->detach_hwpt(idev, errp);
+}
+
 static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
 {
     HostIOMMUDeviceCaps *caps = &hiod->caps;
@@ -385,6 +405,8 @@ static const TypeInfo types[] = {
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
         .parent = TYPE_HOST_IOMMU_DEVICE,
+        .instance_size = sizeof(HostIOMMUDeviceIOMMUFD),
+        .class_size = sizeof(HostIOMMUDeviceIOMMUFDClass),
         .class_init = hiod_iommufd_class_init,
         .abstract = true,
     }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index af1c7ab10a..5fde2b633a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -814,6 +814,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
                                       Error **errp)
 {
     VFIODevice *vdev = opaque;
+    HostIOMMUDeviceIOMMUFD *idev;
     HostIOMMUDeviceCaps *caps = &hiod->caps;
     enum iommu_hw_info_type type;
     union {
@@ -833,6 +834,11 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     caps->type = type;
     caps->hw_caps = hw_caps;
 
+    idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
+    idev->iommufd = vdev->iommufd;
+    idev->devid = vdev->devid;
+    idev->hwpt_id = vdev->hwpt->hwpt_id;
+
     return true;
 }
 
-- 
2.34.1


