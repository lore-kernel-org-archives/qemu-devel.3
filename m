Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F60EF99F6
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 03:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr6Xi-00058G-5j; Fri, 13 Feb 2026 22:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vr6Xg-000581-US
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 22:42:00 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vr6Xf-0008J1-D6
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 22:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771040519; x=1802576519;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PZiKPHz95BBgPb151LL+6wUcQZZQYeja5VAOu/lm/xE=;
 b=Q/2KH6KedOJNqHqeL+A3P+2qYDl1kD31vUhndRxAWj419mgNL62cLMXu
 HHAiXT1+4up4Ls8Bv4uCozJtx0EgQaJVtT1vpgQdtZIVGfv2OGDwP5pJ4
 iCkdc84PvKUjtbgUuWO3Lrq/fySnN/OVG5oi14xCbwa7OEFfLvUw5tkPz
 w+EbqbY39ZkNzgaoyBWYwsGuJXUhPyOjVDto0QI1jYld9+YukMuDK2Wst
 7Oirc8pz7R6pakMYXKDCD5KrG7iTA8OSyTfwpOsMNgXUvENPVNcp/uxB+
 5yuh94VfF9bl1La8zK5kYVmOV2F2Nwvq+AVqyPAtn0zG29sGFeBev/qQ8 A==;
X-CSE-ConnectionGUID: K7Yh8dHxTRe3H503KlhtUA==
X-CSE-MsgGUID: MiQFb6TGRr2Onua7MnG+dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="83666812"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="83666812"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 19:41:59 -0800
X-CSE-ConnectionGUID: 1mmkvfy0QxGbzWuXnom65A==
X-CSE-MsgGUID: Hdbcwh/ySymgabw7UlbsMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="212932951"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 19:41:55 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFCv2 PATCH 03/13] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Date: Fri, 13 Feb 2026 22:41:23 -0500
Message-ID: <20260214034135.220413-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260214034135.220413-1-zhenzhong.duan@intel.com>
References: <20260214034135.220413-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
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

When both host device and vIOMMU have PASID enabled, then guest may
setup pasid attached translation.

We need to create the nesting parent hwpt with IOMMU_HWPT_ALLOC_PASID
flag because according to uAPI, any domain attached to the non-PASID
part of the device must also be flagged, otherwise attaching a PASID
will blocked.

Introduce a vfio_device_get_viommu_flags_pasid_supported() helper to
facilitate this implementation.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-device.h |  1 +
 hw/vfio/device.c              | 11 +++++++++++
 hw/vfio/iommufd.c             |  8 +++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 35a5ec6d92..983eb0ecce 100644
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
index 005f97fe25..c408f9151b 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -360,6 +360,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     VendorCaps caps;
     VFIOIOASHwpt *hwpt;
     uint32_t hwpt_id;
+    uint8_t max_pasid_log2 = 0;
     int ret;
 
     /* Try to find a domain */
@@ -405,7 +406,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      */
     if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
                                          &type, &caps, sizeof(caps), &hw_caps,
-                                         NULL, errp)) {
+                                         &max_pasid_log2, errp)) {
         return false;
     }
 
@@ -427,6 +428,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
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


