Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225DF106F30E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5gky-0002l9-MQ; Thu, 26 Mar 2026 05:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5gkx-0002kz-2S
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:11:59 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5gkv-0003w6-EJ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774516318; x=1806052318;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H4fMV8E43avYhxzlOLd5HgNHl22XbOt9leSYBYHFmB0=;
 b=P2xj/nffOC3UwhKNB3j9R11WD/WoJIOm2JGSkVdd0PBycBD9Ied5pQG9
 pUBl3FdmqPTgiYNSaCYiM/dIPHv6e0mPiW35JJQ9BjeTeoBo38zrm4H3N
 5bjYMHwTmM7ykiggXRFaSu74BNfYPj1vA0SuPGz3m0l9XZvSVcXX7eTHz
 v9qjBFmrOxtuZKHhRD/GbTZW4I+Ybw2//o01JriD/TlZAoeUijy4Hlrm+
 +dLhwtMBxpbrwQCQIWs8jgACcFGFfGsi5dlS1EEJW7YbESa3UZsc/KzN3
 rOwxO0ev5LT3INU3ewpzwZZonQgDu07uOfhYByaV61HhM3UZPGLQBtl+N w==;
X-CSE-ConnectionGUID: H3O0dnliSXmkkuzltOZ/ng==
X-CSE-MsgGUID: awY9vQwrS0OGn3wc941LOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75531325"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="75531325"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:11:56 -0700
X-CSE-ConnectionGUID: pS9eLGJWSJy1ugBTEOKcng==
X-CSE-MsgGUID: JsGt6oZWQ3iKFdExqgCVSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="248368564"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:11:52 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Date: Thu, 26 Mar 2026 05:11:17 -0400
Message-ID: <20260326091130.321483-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326091130.321483-1-zhenzhong.duan@intel.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

We need to create the nesting parent hwpt with IOMMU_HWPT_ALLOC_PASID
flag because according to uAPI, any domain attached to the non-PASID
part of the device must also be flagged, otherwise attaching a PASID
will blocked.

Introduce a vfio_device_get_viommu_flags_pasid_supported() helper to
facilitate this implementation.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 include/hw/vfio/vfio-device.h |  1 +
 hw/vfio/device.c              | 11 +++++++++++
 hw/vfio/iommufd.c             |  8 +++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 828a31c006..dd0355eb3d 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -268,6 +268,7 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
 void vfio_device_unprepare(VFIODevice *vbasedev);
 
 bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
+bool vfio_device_get_viommu_flags_pasid_supported(VFIODevice *vbasedev);
 bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
                                                 uint32_t type, void *caps,
                                                 uint32_t size);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 973fc35b59..b15ca6ef0a 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -533,6 +533,17 @@ bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
     return false;
 }
 
+bool vfio_device_get_viommu_flags_pasid_supported(VFIODevice *vbasedev)
+{
+    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
+
+    if (vdev) {
+        return !!(pci_device_get_viommu_flags(PCI_DEVICE(vdev)) &
+                  VIOMMU_FLAG_PASID_SUPPORTED);
+    }
+    return false;
+}
+
 bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
                                                 uint32_t type, void *caps,
                                                 uint32_t size)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index e822039858..dce4e4ce72 100644
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
+        vfio_device_get_viommu_flags_pasid_supported(vbasedev)) {
+        flags |= IOMMU_HWPT_ALLOC_PASID;
+    }
+
     if (cpr_is_incoming()) {
         hwpt_id = vbasedev->cpr.hwpt_id;
         goto skip_alloc;
-- 
2.47.3


