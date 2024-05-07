Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866F4C25B76
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H4S-0002v7-7V; Tue, 07 May 2024 05:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2y-0000Tg-S2
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:45 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2x-0000Bi-5T
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715073819; x=1746609819;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VOrfu7fZiy+3eHvD+lVlGibrcIGk/lLlGO5XtB2n6eA=;
 b=bnBC4jiT+WCytJmg+KkCLYjKyaAfJNwlp2GfJ2IQy1OTaK/4c6JEtEna
 pxB0jfy8hOqtRwsLwkCdBUmMSIS6/TwgLXoCAy/Fm7rZPFu76jRwXGMgG
 t6k7F7i7U/mDygu2Qhf3xkFaVFHgsfcb/tRdh+WNstbTbflYDvedaRTSA
 HhaR3Nc6Q+uvoKBCec5QZlKqG97SEEZ88S8q3RKwEDr5zBk9MMDwXx9BL
 /SOg3oJdvf0nvTi9IY9+KpUbSw0ZdcAOQXJ5soOaZnWoim8QO/YCTju9A
 uMzeXXBKF2oqIWNv7EpmQdncZ3zGP0GMIbZOzo6ERrxLB5qBwDSveEKuR Q==;
X-CSE-ConnectionGUID: Tku1E4eyTEe0VBMUKDmI3w==
X-CSE-MsgGUID: AjIxXvjaTPeB2tz8/XXu6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10785246"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10785246"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:37 -0700
X-CSE-ConnectionGUID: 507bDKBvTPypAFXmxBzeZw==
X-CSE-MsgGUID: LVFxHRtGQ82g56wfn5vm7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28553372"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:34 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v4 09/19] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Date: Tue,  7 May 2024 17:20:33 +0800
Message-Id: <20240507092043.1172717-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

It calls iommufd_backend_get_device_info() to get host IOMMU
related information and translate it into HostIOMMUDeviceCaps
for query with .get_cap().

Introduce macro VTD_MGAW_FROM_CAP to get MGAW which equals to
(aw_bits - 1).

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h |  1 +
 hw/vfio/iommufd.c             | 37 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 7fa0a695c8..7d694b0813 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -47,6 +47,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU_DEVICE)
 #define VTD_HOST_AW_48BIT           48
 #define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
 #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
+#define VTD_MGAW_FROM_CAP(cap)      ((cap >> 16) & 0x3fULL)
 
 #define DMAR_REPORT_F_INTR          (1)
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index e4a507d55c..9d2e95e20e 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,6 +25,7 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
+#include "hw/i386/intel_iommu_internal.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
@@ -619,6 +620,41 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
     vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
 };
 
+static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
+                                      Error **errp)
+{
+    VFIODevice *vdev = opaque;
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+    enum iommu_hw_info_type type;
+    union {
+        struct iommu_hw_info_vtd vtd;
+    } data;
+
+    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
+                                         &type, &data, sizeof(data), errp)) {
+        return false;
+    }
+
+    caps->type = type;
+
+    switch (type) {
+    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
+        caps->aw_bits = VTD_MGAW_FROM_CAP(data.vtd.cap_reg) + 1;
+        break;
+    case IOMMU_HW_INFO_TYPE_NONE:
+        break;
+    }
+
+    return true;
+}
+
+static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
+{
+    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
+
+    hiodc->realize = hiod_iommufd_vfio_realize;
+};
+
 static const TypeInfo types[] = {
     {
         .name = TYPE_VFIO_IOMMU_IOMMUFD,
@@ -627,6 +663,7 @@ static const TypeInfo types[] = {
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
         .parent = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
+        .class_init = hiod_iommufd_vfio_class_init,
     }
 };
 
-- 
2.34.1


