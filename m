Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72576CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 05:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS77y-0006HO-4j; Wed, 27 May 2026 01:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS77O-0006Cl-VG
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:47:52 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS77M-0000aI-UT
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779860869; x=1811396869;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HYyStD+myHi5nql+iy2uYJ1QvXXIHi0P+IXf9H4bMAc=;
 b=UybJ2WhkEcJlKfR+1co4pGLz2RrZGiLZxpRF1Vhd5VI6Vk9y+3bIzcbS
 a0V6Pqbs7jk+hZz95aUwwwOJXOXxKXiqFaUtZYEP+rVS+zGcTyI4xmBPy
 hgwmc++2cbDc5+iU3ScUsn8rBLu9lqjf2hJB9NxE86uxDjsfmuVl1ehES
 g2/VsgvJsiNOSD+CgOY6hXw2cpp8LPp6rc1u/UZEko05k9M/Fxl8PMInP
 2OmYeqeRZ70QBikN6eUEbKQ9Y08de9L/IytBxpnpcduI8uWIQTDSIgzbG
 ulJ3XK/EEYr7IGeSuACzIj6vc8cmgVH+SCFUcJ5EXnxkYzoF2aqqixEWz w==;
X-CSE-ConnectionGUID: 3gnEDpVKRauj5uMapW9ncg==
X-CSE-MsgGUID: qHWQp9evQya5LJFzg5Rxbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="90988090"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="90988090"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:47:46 -0700
X-CSE-ConnectionGUID: D0xEKKFwS4G4M0rTUQE2sw==
X-CSE-MsgGUID: kptPDHDdSFyZ8orosOjsmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="241086685"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:47:42 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 03/17] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Date: Wed, 27 May 2026 01:46:41 -0400
Message-ID: <20260527054658.1021096-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
References: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
pasid usages such as SVM.

VFIO needs to be aware of potential pasid usage and should attach the
non-pasid part of pasid-capable device to hwpt flagged with
IOMMU_HWPT_ALLOC_PASID.

ARM SMMU doesn't support IOMMU_HWPT_ALLOC_PASID, only VTD need it. So
we can't check the existing vIOMMU flag VIOMMU_FLAG_PASID_SUPPORTED to
determine if set flag IOMMU_HWPT_ALLOC_PASID. Instead, introduce a new
flag VIOMMU_FLAG_WANT_PASID_ATTACH which will only be exposed by VTD.

Opportunistically add documentation for VIOMMU_FLAG_PASID_SUPPORTED
and explain the difference with VIOMMU_FLAG_WANT_PASID_ATTACH.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 include/hw/core/iommu.h       | 11 +++++++++++
 include/hw/vfio/vfio-device.h |  1 +
 hw/vfio/device.c              | 11 +++++++++++
 hw/vfio/iommufd.c             |  8 +++++++-
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
index 7fb5c81c9f..fd513d6472 100644
--- a/include/hw/core/iommu.h
+++ b/include/hw/core/iommu.h
@@ -20,9 +20,20 @@
 enum viommu_flags {
     /* vIOMMU needs nesting parent HWPT to create nested HWPT */
     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
+    /*
+     * vIOMMU supports PASID capability, VFIO checks this flag and synthesize
+     * a PASID capability.
+     */
     VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
     /* vIOMMU needs dirty tracking on the nesting parent HWPT for nested use */
     VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING = BIT_ULL(2),
+    /*
+     * vIOMMU requests other sub-system like VFIO to create a HWPT that can be
+     * used with PASID attachment. VIOMMU_FLAG_PASID_SUPPORTED can't be used
+     * for this purpose as PASID attachment is needed by VTD IOMMU but not ARM
+     * SMMU.
+     */
+    VIOMMU_FLAG_WANT_PASID_ATTACH = BIT_ULL(3),
 };
 
 /* Host IOMMU quirks. Extracted from host IOMMU capabilities */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 380a55d6e5..8472420d3f 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -282,6 +282,7 @@ void vfio_device_unprepare(VFIODevice *vbasedev);
 
 bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
 bool vfio_device_get_viommu_flags_want_nesting_dirty(VFIODevice *vbasedev);
+bool vfio_device_get_viommu_flags_want_pasid_attach(VFIODevice *vbasedev);
 bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
                                                 uint32_t type, void *caps,
                                                 uint32_t size);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index ccf14743e9..1a7f8088aa 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -543,6 +543,17 @@ bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
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
index 78e7b6a045..0718f029ca 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -364,6 +364,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     VendorCaps caps;
     VFIOIOASHwpt *hwpt;
     uint32_t hwpt_id;
+    uint8_t max_pasid_log2 = 0;
     int ret;
 
     /* Try to find a domain */
@@ -409,7 +410,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      */
     if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
                                          &type, &caps, sizeof(caps), &hw_caps,
-                                         NULL, errp)) {
+                                         &max_pasid_log2, errp)) {
         return false;
     }
 
@@ -437,6 +438,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
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


