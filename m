Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188A2C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 06:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMhZ7-00036T-Nl; Wed, 04 Jun 2025 02:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMhZ5-00036B-R4
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 02:25:31 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMhZ2-0001ba-SM
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 02:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749018329; x=1780554329;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o0AmsQcPj4xV+MPQDwAQCn0gZWrRYxVnEnQFUs8pNyc=;
 b=JyADO+rl03nx6Azhld870oQZV53tEWr1iGAEUmRE8Hgb824uCPzWCCFZ
 FYGO6wWFk5XElJ4tsd2lkgs2JaEDMF6FwYhtY9Bv9ir3tln0Y0DlV74Wu
 Z5L4eWopg9brKoRRsVYIlEFCivZlPiVpe6DWb0D2dIzSogTsybinGO0VS
 RKdxxjZuSBykoefYzx+r/m4Lu8Ge5Xjc67Usyu6JxmR+dYzyWWOoK1qeV
 7We0h/W4taSk4+z8Q943jDcDUuTFeGZrJqBfG7cweV33cEWetGk1ZkAVM
 dQ1d3CwE3q1fIw8oaK5JAdFYJz/dC6KrSN+LdiT3LRsJ4hzPo4G5puDj6 g==;
X-CSE-ConnectionGUID: 0XMyZIOYTy+mX6zLdt0twg==
X-CSE-MsgGUID: uzP8r2twRCCXKVRYz9qosA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="73614563"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="73614563"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 23:25:26 -0700
X-CSE-ConnectionGUID: FR2ty/p+Qt++YivWo2nQJg==
X-CSE-MsgGUID: VBwo8NO8QXaOurfCwqMrYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="145693593"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 23:25:19 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 4/4] vfio/iommufd: Save vendor specific device info
Date: Wed,  4 Jun 2025 14:21:15 +0800
Message-Id: <20250604062115.4004200-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604062115.4004200-1-zhenzhong.duan@intel.com>
References: <20250604062115.4004200-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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
then vendor IOMMU can query the raw data with its fixed format for
capability directly.

Because IOMMU_GET_HW_INFO is only supported in linux, so declare those
capability related structures with CONFIG_LINUX.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 include/system/host_iommu_device.h | 15 +++++++++++++++
 hw/vfio/iommufd.c                  |  8 +++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index 809cced4ba..ab849a4a82 100644
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
@@ -22,11 +29,17 @@
  *
  * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
  *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
+ *
+ * @vendor_caps: host platform IOMMU vendor specific capabilities (e.g. on
+ *               IOMMUFD this represents a user-space buffer filled by kernel
+ *               with host IOMMU @type specific hardware information data)
  */
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
     uint64_t hw_caps;
+    VendorCaps vendor_caps;
 } HostIOMMUDeviceCaps;
+#endif
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
 OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
@@ -38,7 +51,9 @@ struct HostIOMMUDevice {
     void *agent; /* pointer to agent device, ie. VFIO or VDPA device */
     PCIBus *aliased_bus;
     int aliased_devfn;
+#ifdef CONFIG_LINUX
     HostIOMMUDeviceCaps caps;
+#endif
 };
 
 /**
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 3910b4b2b9..d3efef71af 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -839,16 +839,14 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
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


