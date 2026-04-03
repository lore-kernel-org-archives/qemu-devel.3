Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF2DD7308A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 03:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Vdd-0001Af-Mk; Thu, 02 Apr 2026 23:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8Vdc-00019c-Aq
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 23:56:04 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8Vda-0004MM-KT
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 23:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775188562; x=1806724562;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IM87H8/Ait4f6rjlrPdAR7O/TnBajxtINCeU247Vyjw=;
 b=G0qJd9iq0H9/nb2K9GdNMqxE5tBGVZ5MwTxDTRBSqw9DxP8BacG6t9Kw
 Hu3/OVesqnW5Ks9qPmFEMmhKhKs20gXqMnjJyBlXsA7Yn+OuRTEpZZmDN
 7piM7rx/9nECIwwS1XLyaxRZIB4k56/wbFJYr/mL18oecDPSYMP72/+xE
 QeZkeor1u7UwF6E0JJ1/egCthvRsEDAUqJg5fos+6MUrZyCiOIZM5dxib
 SFWMhOCBACDw+1ERUCZdGzyc3ozZYaBgj1yhdmxCYmVg/17SoMBt//AvN
 5C/eiDZViArByQnXwexr1M+UAYJAxd/taOKEU39YMcwWfWk3GZVjOmADA g==;
X-CSE-ConnectionGUID: /nAzXRYpQsKAPD0QgHdEjQ==
X-CSE-MsgGUID: 7yXnGwL+S3e2/uJmsq5x/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76140602"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76140602"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 20:56:01 -0700
X-CSE-ConnectionGUID: SsTIyR/UR76nqOxEaKClhg==
X-CSE-MsgGUID: nMO9Arz+QNi6BU94BvPifw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="223884852"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 20:55:58 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Date: Thu,  2 Apr 2026 23:55:27 -0400
Message-ID: <20260403035541.18355-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403035541.18355-1-zhenzhong.duan@intel.com>
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

When both device and vIOMMU have PASID enabled, then guest may setup
pasid attached translation.

VFIO needs to be aware of potential pasid usage and should attach the
non-pasid part of pasid-capable device to hwpt flagged with
IOMMU_HWPT_ALLOC_PASID.

ARM SMMU doesn't support IOMMU_HWPT_ALLOC_PASID, only VTD need it. So
we can't check the existing vIOMMU flag VIOMMU_FLAG_PASID_SUPPORTED to
determine if set flag IOMMU_HWPT_ALLOC_PASID. Instead, introduce a new
flag VIOMMU_FLAG_WANT_PASID_ATTACH which will only be exposed by VTD.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 include/hw/core/iommu.h       |  1 +
 include/hw/vfio/vfio-device.h |  1 +
 hw/vfio/device.c              | 11 +++++++++++
 hw/vfio/iommufd.c             |  8 +++++++-
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
index bfcd511013..67c575b08c 100644
--- a/include/hw/core/iommu.h
+++ b/include/hw/core/iommu.h
@@ -21,6 +21,7 @@ enum viommu_flags {
     /* vIOMMU needs nesting parent HWPT to create nested HWPT */
     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
     VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
+    VIOMMU_FLAG_WANT_PASID_ATTACH = BIT_ULL(2),
 };
 
 /* Host IOMMU quirks. Extracted from host IOMMU capabilities */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 828a31c006..d6e522f8b8 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -268,6 +268,7 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
 void vfio_device_unprepare(VFIODevice *vbasedev);
 
 bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
+bool vfio_device_get_viommu_flags_want_pasid_attach(VFIODevice *vbasedev);
 bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
                                                 uint32_t type, void *caps,
                                                 uint32_t size);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 973fc35b59..bc1d37e776 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -533,6 +533,17 @@ bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
     return false;
 }
 
+bool vfio_device_get_viommu_flags_want_pasid_attach(VFIODevice *vbasedev)
+{
+    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
+
+    if (vdev) {
+        return !!(pci_device_get_viommu_flags(PCI_DEVICE(vdev)) &
+                  VIOMMU_FLAG_WANT_PASID_ATTACH);
+    }
+    return false;
+}
+
 bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
                                                 uint32_t type, void *caps,
                                                 uint32_t size)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index ecabc33064..ead40b6617 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -363,6 +363,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     VendorCaps caps;
     VFIOIOASHwpt *hwpt;
     uint32_t hwpt_id;
+    uint8_t max_pasid_log2 = 0;
     int ret;
 
     /* Try to find a domain */
@@ -408,7 +409,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      */
     if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
                                          &type, &caps, sizeof(caps), &hw_caps,
-                                         NULL, errp)) {
+                                         &max_pasid_log2, errp)) {
         return false;
     }
 
@@ -430,6 +431,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         }
     }
 
+    if (max_pasid_log2 &&
+        vfio_device_get_viommu_flags_want_pasid_attach(vbasedev)) {
+        flags |= IOMMU_HWPT_ALLOC_PASID;
+    }
+
     if (cpr_is_incoming()) {
         hwpt_id = vbasedev->cpr.hwpt_id;
         goto skip_alloc;
-- 
2.47.3


