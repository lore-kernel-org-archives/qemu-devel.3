Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4F6C369AA
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BVo-0002nM-W6; Fri, 11 Apr 2025 06:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u3BVh-0002fE-J8
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:21 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u3BVe-0005Op-F7
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744366878; x=1775902878;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pognV82UVdHK8qT+B92vH8V1D8/ilicX35LTb3dliZA=;
 b=Th5rqfua5bRnQ/FBbJYbgvGX/TOFJfyzempPvvOLGLW9AESL9P3bZXx/
 mQ87WwGsgiIpMGuelX8CUVZIji9EDUw5mwPp+Rl7jj22yFyZa+G6nxI0d
 3L5E1FwHatRahL/FdTW1bGvgu0lR13Q1LA2alDfHEqQJ1XnXoAns1jRLF
 NuELsHc8wWDTbTQ4EbSvWpsjyZKmiFjDeH/sDR+lyVHoJXz1TKWUpNNAk
 dJfJ8caPHmotu2ZrNJVGFz0cH3qTbPyZv1Gg09hf5VGWmNQ5L5GD8vhRJ
 7BmzUV0lu7Vnai5IOUJGQQpcw+HMlTsETsutqNMWvY/6RH7GBaJR90H3i A==;
X-CSE-ConnectionGUID: fwWKyU7jQ/O3SWT2EmUygg==
X-CSE-MsgGUID: oqFqfiSmScGYBklweoJqbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="49566798"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="49566798"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:20:53 -0700
X-CSE-ConnectionGUID: SdcHZi/MQeOse6DGf1o+4A==
X-CSE-MsgGUID: rC2gTDqzRQe+XxHFcn7dmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="133917417"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:20:52 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 3/5] vfio/iommufd: Implement .get_cap() in
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO sub-class
Date: Fri, 11 Apr 2025 18:17:05 +0800
Message-Id: <20250411101707.3460429-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
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

Now we have saved a copy of host iommu capabilities in VFIODevice, implemented
hiod_iommufd_vfio_get_cap() by querying the caps copy in sub-class. This
overrides .get_cap() implementation hiod_iommufd_vfio_get_cap() in
TYPE_HOST_IOMMU_DEVICE_IOMMUFD parent class.

Vendor caps are checked for a specific capability, e.g., for vtd, checking
code will be in hiod_iommufd_get_vtd_cap().

This also fixes an issue that calling vfio_device_get_aw_bits() in
TYPE_HOST_IOMMU_DEVICE_IOMMUFD parent class .get_cap().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/iommufd.h |  4 ++++
 backends/iommufd.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 hw/vfio/iommufd.c        | 16 ++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 0f337585c9..baba5ec1d8 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -85,4 +85,8 @@ typedef struct HostIOMMUDeviceIOMMUFDCaps {
     uint64_t hw_caps;
     VendorCaps vendor_caps;
 } HostIOMMUDeviceIOMMUFDCaps;
+
+int hiod_iommufd_get_common_cap(HostIOMMUDevice *hiod,
+                                HostIOMMUDeviceIOMMUFDCaps *caps,
+                                int cap, Error **errp);
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 9587e4d99b..54fa3174d0 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -355,3 +355,43 @@ static const TypeInfo types[] = {
 };
 
 DEFINE_TYPES(types)
+
+static int hiod_iommufd_get_vtd_cap(HostIOMMUDevice *hiod,
+                                    struct iommu_hw_info_vtd *vtd,
+                                    int cap, Error **errp)
+{
+    /* TODO: Check vtd->cap_reg/ecap_reg for capability */
+    error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
+    return -EINVAL;
+}
+
+static int hiod_iommufd_get_vendor_cap(HostIOMMUDevice *hiod,
+                                       HostIOMMUDeviceIOMMUFDCaps *caps,
+                                       int cap, Error **errp)
+{
+    enum iommu_hw_info_type type = caps->type;
+
+    switch (type) {
+    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
+        return hiod_iommufd_get_vtd_cap(hiod, &caps->vendor_caps.vtd,
+                                        cap, errp);
+    case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
+    case IOMMU_HW_INFO_TYPE_NONE:
+        break;
+    }
+
+    error_setg(errp, "%s: unsupported capability type %x", hiod->name, type);
+    return -EINVAL;
+}
+
+int hiod_iommufd_get_common_cap(HostIOMMUDevice *hiod,
+                                HostIOMMUDeviceIOMMUFDCaps *caps,
+                                int cap, Error **errp)
+{
+    switch (cap) {
+    case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
+        return caps->type;
+    default:
+        return hiod_iommufd_get_vendor_cap(hiod, caps, cap, errp);
+    }
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index e05b472e35..e7ca92f81f 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -833,6 +833,21 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     return true;
 }
 
+static int hiod_iommufd_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
+                                     Error **errp)
+{
+    VFIODevice *vdev = hiod->agent;
+    HostIOMMUDeviceIOMMUFDCaps *caps = &vdev->caps;
+
+    /* VFIO has its own way to get aw_bits which may be different from VDPA */
+    switch (cap) {
+    case HOST_IOMMU_DEVICE_CAP_AW_BITS:
+        return vfio_device_get_aw_bits(hiod->agent);
+    default:
+        return hiod_iommufd_get_common_cap(hiod, caps, cap, errp);
+    }
+}
+
 static GList *
 hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
 {
@@ -857,6 +872,7 @@ static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
 
     hiodc->realize = hiod_iommufd_vfio_realize;
+    hiodc->get_cap = hiod_iommufd_vfio_get_cap;
     hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
     hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
 };
-- 
2.34.1


