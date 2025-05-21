Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEE1C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhTV-0005UD-D8; Wed, 21 May 2025 07:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTU-0005Ta-HQ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:19:04 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTS-0006Ov-HQ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747826343; x=1779362343;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4frTGND9Al9idiJkchXDq6kWR6Z+xfk40H5WnMQ5KM4=;
 b=kmcuzwFb4qt8PcMPMhXWriGgy2Qg3lwBKNsb7E59OTm4JFeCM7MRw6Q5
 JLDbny9SBpbf5M9/iFi25QIp2ShsEMttnvHouonWz7wsoKK3EUA2KoC/x
 XVV+JlnQc1+nf9kCi9KZrCyiIwBhBX62Pz9D/KVjSjHgm9IGG1cOcTzIF
 sCz8ZDpitSAOUE07dSzF1ysi4lTZIueXhiDAL4ggq+0poBo3bhHScSji/
 vaI9pd8kFqum1gfwipu1MK0UVSQohVl31lPq6CZgqQKHiQNmN75wb9s7G
 TX2khrIQTKJKF8v2Vz9pg+5CSaGEhuuzhhz2w6mBbIQ7ViEfNj+NALtEd g==;
X-CSE-ConnectionGUID: jkPD7c2hTluNjz2n1ZDwNw==
X-CSE-MsgGUID: RkmEzH53T6KFdBmJGRozbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49894911"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49894911"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:19:00 -0700
X-CSE-ConnectionGUID: R1LLdrsPTsuQpHp56j7Emg==
X-CSE-MsgGUID: AatEFAggSbCAVsXwZOYfuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145158321"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:18:55 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv3 05/21] vfio/iommufd: Save vendor specific device info
Date: Wed, 21 May 2025 19:14:35 +0800
Message-Id: <20250521111452.3316354-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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
specific. Save them all in a new defined structure mirroring that vendor
IOMMU's structure, then get_cap() can query those information for
capability.

We can't use the vendor IOMMU's structure directly because they are in
linux/iommufd.h which breaks build on windows.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/host_iommu_device.h | 12 ++++++++++++
 hw/vfio/iommufd.c                  | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index 809cced4ba..908bfe32c7 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -15,6 +15,17 @@
 #include "qom/object.h"
 #include "qapi/error.h"
 
+/* This is mirror of struct iommu_hw_info_vtd */
+typedef struct Vtd_Caps {
+    uint32_t flags;
+    uint64_t cap_reg;
+    uint64_t ecap_reg;
+} Vtd_Caps;
+
+typedef union VendorCaps {
+    Vtd_Caps vtd;
+} VendorCaps;
+
 /**
  * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
  *
@@ -26,6 +37,7 @@
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
     uint64_t hw_caps;
+    VendorCaps vendor_caps;
 } HostIOMMUDeviceCaps;
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index d661737c17..5c740222e5 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -834,6 +834,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     VFIODevice *vdev = opaque;
     HostIOMMUDeviceIOMMUFD *idev;
     HostIOMMUDeviceCaps *caps = &hiod->caps;
+    VendorCaps *vendor_caps = &caps->vendor_caps;
     enum iommu_hw_info_type type;
     union {
         struct iommu_hw_info_vtd vtd;
@@ -852,6 +853,17 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     caps->type = type;
     caps->hw_caps = hw_caps;
 
+    switch (type) {
+    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
+        vendor_caps->vtd.flags = data.vtd.flags;
+        vendor_caps->vtd.cap_reg = data.vtd.cap_reg;
+        vendor_caps->vtd.ecap_reg = data.vtd.ecap_reg;
+        break;
+    case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
+    case IOMMU_HW_INFO_TYPE_NONE:
+        break;
+    }
+
     idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
     idev->iommufd = vdev->iommufd;
     idev->devid = vdev->devid;
-- 
2.34.1


