Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A6CC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Ktm-0001tN-Iv; Mon, 29 Apr 2024 02:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Ktk-0001pe-EB
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:00 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Kti-0007m1-LL
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373639; x=1745909639;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6ltkk9ZSzHtUFy8gqqP1beuuPHxf/CT+sJYprNmHrog=;
 b=R/ZiP9yCPLTraTHcM/GdP/l3naQHemUvneIGYUFA+Nb4eO7YXsJM1ZR/
 nEo1i4XoQmDqxxFu1fD9bpAyyw2Y4SSs7rrJ2kvx0SzyzzlEPBEFpafVu
 I60K7Zb7lFE3lt/+GSOl2J9IfVjtqPo44dscOsyVzhaXVjgfoC2SuB7uG
 uAXf3X0wugaZDEthwXvWoFNTfd+zLM6Niz31AH4kfrCgt9VnDwRFs8w5U
 GjyVEEVev57+Q0wObbhmVLZbZ2SSW7pLI7AciClhfaag28GNiblxpJ2np
 5c9ePLPzclq7GvR15IwliPSpLDOzhcICAuDmtQr+q1kIHtcR9HRBfhaxm Q==;
X-CSE-ConnectionGUID: li8DX8KhRxeliTIdfWTQoQ==
X-CSE-MsgGUID: 31ocWLbfQtmDTMQjeaD4hQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560709"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560709"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:57 -0700
X-CSE-ConnectionGUID: FikWmnyQT9eKeEmX22dPsQ==
X-CSE-MsgGUID: WmKU2X18R0uqTLY1kvmU0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63488089"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:54 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 09/19] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Date: Mon, 29 Apr 2024 14:50:36 +0800
Message-Id: <20240429065046.3688701-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
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
for query with .check_cap().

Introduce macro VTD_MGAW_FROM_CAP to get MGAW which equals to
(aw_bits - 1).

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h |  1 +
 hw/vfio/iommufd.c             | 44 +++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

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
index 997f4ac43e..6bc2dc68f6 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,6 +25,7 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
+#include "hw/i386/intel_iommu_internal.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
@@ -634,6 +635,48 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
     vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
 };
 
+static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
+                                      Error **errp)
+{
+    VFIODevice *vdev = opaque;
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+    enum iommu_hw_info_type type;
+    union {
+        struct iommu_hw_info_vtd vtd;
+    } data;
+    int ret;
+
+    HOST_IOMMU_DEVICE_IOMMUFD_VFIO(hiod)->vdev = vdev;
+    idev->iommufd = vdev->iommufd;
+    idev->devid = vdev->devid;
+
+    ret = iommufd_backend_get_device_info(idev->iommufd, idev->devid,
+                                          &type, &data, sizeof(data), errp);
+    if (ret) {
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
@@ -643,6 +686,7 @@ static const TypeInfo types[] = {
         .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
         .parent = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
         .instance_size = sizeof(HostIOMMUDeviceIOMMUFDVFIO),
+        .class_init = hiod_iommufd_vfio_class_init,
     }
 };
 
-- 
2.34.1


