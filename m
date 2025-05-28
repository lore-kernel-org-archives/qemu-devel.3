Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0173C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 06:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK9xj-0007oE-VX; Wed, 28 May 2025 02:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uK9xe-0007aS-Bx
 for qemu-devel@nongnu.org; Wed, 28 May 2025 02:08:25 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uK9xc-0000mi-Nz
 for qemu-devel@nongnu.org; Wed, 28 May 2025 02:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748412501; x=1779948501;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b/xb+LfxXKsbO4y4fM+JK1HYKSnaKJczGtpy5ZvOdck=;
 b=Z6AFhGFq95aJ/hoDxIrbVBd9pQncUuKwG6RH7sQrinJt/8eLdcRFrm6/
 rtRlmuN67VZtYA3KLwJy91zx9qkASe94hZqDW/FSrEysOC4x0rvLIWCKS
 Xtqri7vN0Cfw1e7oqW4TWbyxn+gY4MgNC888u9ChpqsEN+H/jh/sQg11K
 a/o0bxUZD1TDrFNhGeh2R1De0yqFN5/3sq5QZ9mqqpH9TFvLdx1+4vzmk
 ckPg+cx4H4Z8aWSr+Lmq8G1Zc0f+SAoWiJZ4EQ6NwAZCHI2yE/9c7Hkx+
 8nc55g4fjNdquf9b+CcSoOkO4F0QYvwQG4/RbNO6WRUeUmm6t4V2RRQ9g w==;
X-CSE-ConnectionGUID: d3MJPIMERMGS+E6tFcCztg==
X-CSE-MsgGUID: 9dlQEeHeSoyRDMSQB6kC+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="60678999"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="60678999"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 23:08:20 -0700
X-CSE-ConnectionGUID: ex3DoGQtQM606pqq5iLtZQ==
X-CSE-MsgGUID: ghRYVRn7RKykVLTC+fjEyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="143165169"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 23:08:16 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 5/6] vfio/iommufd: Save vendor specific device info
Date: Wed, 28 May 2025 14:04:08 +0800
Message-Id: <20250528060409.3710008-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528060409.3710008-1-zhenzhong.duan@intel.com>
References: <20250528060409.3710008-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

Some device information returned by ioctl(IOMMU_GET_HW_INFO) are vendor
specific. Save them as raw data in a union supporting different vendors,
then get_cap() can provide a general interface for querying capability
and hide different vendor data format under it.

Because IOMMU_GET_HW_INFO is only supported in linux, so declare those
capability related structures with CONFIG_LINUX.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/host_iommu_device.h | 11 +++++++++++
 hw/vfio/iommufd.c                  |  8 +++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index 809cced4ba..10fccc10be 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -14,6 +14,13 @@
 
 #include "qom/object.h"
 #include "qapi/error.h"
+#ifdef CONFIG_LINUX
+#include "linux/iommufd.h"
+
+typedef union VendorCaps {
+    struct iommu_hw_info_vtd vtd;
+    struct iommu_hw_info_arm_smmuv3 smmuv3;
+} VendorCaps;
 
 /**
  * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
@@ -26,7 +33,9 @@
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
     uint64_t hw_caps;
+    VendorCaps vendor_caps;
 } HostIOMMUDeviceCaps;
+#endif
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
 OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
@@ -38,7 +47,9 @@ struct HostIOMMUDevice {
     void *agent; /* pointer to agent device, ie. VFIO or VDPA device */
     PCIBus *aliased_bus;
     int aliased_devfn;
+#ifdef CONFIG_LINUX
     HostIOMMUDeviceCaps caps;
+#endif
 };
 
 /**
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index d661737c17..fbf47cab09 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -834,16 +834,14 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     VFIODevice *vdev = opaque;
     HostIOMMUDeviceIOMMUFD *idev;
     HostIOMMUDeviceCaps *caps = &hiod->caps;
+    VendorCaps *vendor_caps = &caps->vendor_caps;
     enum iommu_hw_info_type type;
-    union {
-        struct iommu_hw_info_vtd vtd;
-    } data;
     uint64_t hw_caps;
 
     hiod->agent = opaque;
 
-    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
-                                         &type, &data, sizeof(data),
+    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid, &type,
+                                         vendor_caps, sizeof(*vendor_caps),
                                          &hw_caps, errp)) {
         return false;
     }
-- 
2.34.1


