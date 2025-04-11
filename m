Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9502C369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BVq-0002qv-IK; Fri, 11 Apr 2025 06:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u3BVe-0002bX-0e
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:18 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u3BVT-0005O8-Nx
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744366867; x=1775902867;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HDSjhWoNRiRif3N3R0QiTa26vrCzPQDa4qlgutcJNyQ=;
 b=Q51r4nunu81ybHsElx2jIXb98WCN7EIMUyG2Pzxb34btKYXuYJDtHGJI
 ArYQhgQ1NbaSmO3a0pvjsvKbpr/h+yLxYiDIEdt1MXV3BBDzyZCxGRtNe
 9MderpwozUuabmgbPj6s9V9MzYWB9+HSfXuM2uD8uq0TUPdsq2M8VGZGr
 f954SZkTi/McFHkSWytp6YlHtNwUN3vwJpr/i7KvAmKYoqPc1ypX/bJtE
 jar8DAwucEWuYwI1pOxPsfFiaXiggQSh/oDI7nmv5aVPC0ZlIs3NJ90dz
 AH+vFdqAfJQ5QTyJgtV9P2hw2xxeglaHohtI7j1k3tf7HQ3OmYlWvDIIr w==;
X-CSE-ConnectionGUID: zyO75PytTuqzTPKOy1+L9g==
X-CSE-MsgGUID: BtSLvZ8BSaOsoR37dok+gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="49566779"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="49566779"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:20:48 -0700
X-CSE-ConnectionGUID: rLx+R/RrSjyBmrwGrbDKDg==
X-CSE-MsgGUID: b+/cmEqZSj6QjggpoAxlEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="133917410"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:20:47 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
Date: Fri, 11 Apr 2025 18:17:03 +0800
Message-Id: <20250411101707.3460429-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
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

The saved caps copy can be used to check dirty tracking capability.

The capabilities is gotten through IOMMUFD interface, so define a
new structure HostIOMMUDeviceIOMMUFDCaps which contains vendor
caps raw data in "include/system/iommufd.h".

This is a prepare work for moving .realize() after .attach_device().

Suggested-by: Cédric Le Goater <clg@redhat.com>
Suggested-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-device.h |  1 +
 include/system/iommufd.h      | 22 ++++++++++++++++++++++
 hw/vfio/iommufd.c             | 10 +++++++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 66797b4c92..09a7af891a 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -77,6 +77,7 @@ typedef struct VFIODevice {
     bool dirty_tracking; /* Protected by BQL */
     bool iommu_dirty_tracking;
     HostIOMMUDevice *hiod;
+    HostIOMMUDeviceIOMMUFDCaps caps;
     int devid;
     IOMMUFDBackend *iommufd;
     VFIOIOASHwpt *hwpt;
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index cbab75bfbf..0f337585c9 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -18,6 +18,9 @@
 #include "exec/hwaddr.h"
 #include "exec/cpu-common.h"
 #include "system/host_iommu_device.h"
+#ifdef CONFIG_LINUX
+#include <linux/iommufd.h>
+#endif
 
 #define TYPE_IOMMUFD_BACKEND "iommufd"
 OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass, IOMMUFD_BACKEND)
@@ -63,4 +66,23 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
                                       Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
+
+typedef union VendorCaps {
+    struct iommu_hw_info_vtd vtd;
+    struct iommu_hw_info_arm_smmuv3 smmuv3;
+} VendorCaps;
+
+/**
+ * struct HostIOMMUDeviceIOMMUFDCaps - Define host IOMMU device capabilities.
+ *
+ * @type: host platform IOMMU type.
+ *
+ * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
+ *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
+ */
+typedef struct HostIOMMUDeviceIOMMUFDCaps {
+    uint32_t type;
+    uint64_t hw_caps;
+    VendorCaps vendor_caps;
+} HostIOMMUDeviceIOMMUFDCaps;
 #endif
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 48db105422..530cde6740 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -324,7 +324,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      * vfio_migration_realize() may decide to use VF dirty tracking
      * instead.
      */
-    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
+    if (vbasedev->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
         flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
     }
 
@@ -475,6 +475,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     int ret, devfd;
     uint32_t ioas_id;
     Error *err = NULL;
+    HostIOMMUDeviceIOMMUFDCaps *caps = &vbasedev->caps;
     const VFIOIOMMUClass *iommufd_vioc =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
 
@@ -505,6 +506,13 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_alloc_ioas;
     }
 
+    if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
+                                         &caps->type, &caps->vendor_caps,
+                                         sizeof(VendorCaps), &caps->hw_caps,
+                                         errp)) {
+        goto err_alloc_ioas;
+    }
+
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
-- 
2.34.1


