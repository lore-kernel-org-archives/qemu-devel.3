Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470ECCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wILbQ-0005OO-6N; Thu, 30 Apr 2026 03:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wILam-00058N-1y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:13:51 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wILaj-0008IJ-7M
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777533225; x=1809069225;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WFgpWH3Lzh77PiPSeGLuAnB2U0goGkEoiXkGm0T8WVA=;
 b=BGT14pJbO64VMWBVmjTgYCn1iRdk4QqqwGQ4ZG1SppS7gSw1PuF070mN
 lpZv9KtVFIY3NaUhr6AP6u1qc/MUMoNK7Muu23tx+kYhRJg+CS5pNKkqE
 H6kCnfQ6KOxh2ADXzZcwgjw/+xQVE/Btl4aV6ISzLMVaF7/RskwOBjaWf
 bahZMchwWPf7xEgfgNkt71VZS6EOji4JGAWcTXiXApN0Xp6aF11uqZXqf
 tQ++vDRugL64jJy7f8pRrkdkWd2BvtP+OmI9d9lAHMXj2jO68fcUdNud1
 LIMpKeU9p1LlCOHmaAE3oA4/4vqLhbD3jmiBcXo5aZbkFEcoX3InrWRo0 A==;
X-CSE-ConnectionGUID: kkOlo/ENSmSD8GpoNT9nuA==
X-CSE-MsgGUID: E90wHr1BQM+4ymKG0dk8ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="81051585"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="81051585"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:13:43 -0700
X-CSE-ConnectionGUID: 24iJRBIeSrmod/zhjjX2Gw==
X-CSE-MsgGUID: eAyCTGDJQy+h5OZ3Sb+jMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="234771472"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:13:40 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 03/15] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Date: Thu, 30 Apr 2026 03:12:59 -0400
Message-ID: <20260430071315.354333-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430071315.354333-1-zhenzhong.duan@intel.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
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

When both device and vIOMMU have PASID enabled, then guest may setup
pasid attached translation.

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
index 77739d4214..20d6d79062 100644
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
index 3ffd69a579..b954b44d31 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -544,6 +544,17 @@ bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
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


