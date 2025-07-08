Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33787C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFFC-00023S-La; Tue, 08 Jul 2025 16:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDrW-0008Hg-PB
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:20:23 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDrQ-00086x-KZ
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752002413; x=1783538413;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2RiIr4+eavDZWdSlMVoyWZlpg5A1dJBD7bC9x9Ek84g=;
 b=mUdYXdEH74m9pr4As/QK19QztLVqNjqLSEAQ32MMAN6d45xEBqZ8r3U6
 b3fScNsIkLDaN49WOG91cuIAHh+x+4p4pVx8HDZ61/2wnOug+gCgyP4P6
 XCQlhDz4N6OT7z0jhwQeKIJkV8lCMA8kVko1PH3CgZYejOJSFc3+sBd4r
 wgPm1maKHlmP6ZZ6ktiUQ6jXOIBdcrfUFsEBhZj76yZBvgJNdZMIGwOJg
 5dCsS/iA8qC911lgJPMVXr2qD15oBnzKSyBEsjjYGwx7uupUw5ZsXa9sb
 8PGYDoJkGe7GnZfAIf7bdpWQOrspd2tCMrqYtrqtGam8tHFxBfA10R64w A==;
X-CSE-ConnectionGUID: s3qhotHNRyGUwudavqt10g==
X-CSE-MsgGUID: WGBnYywYSFOUJFYQIUJPHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57973910"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="57973910"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:06:21 -0700
X-CSE-ConnectionGUID: vODf6lIERFep+cdj9Cjllw==
X-CSE-MsgGUID: 0c6MqHjBQFyehb393xa7Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="192647930"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:06:17 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Date: Tue,  8 Jul 2025 07:05:43 -0400
Message-ID: <20250708110601.633308-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708110601.633308-1-zhenzhong.duan@intel.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

pci_device_get_viommu_cap() call pci_device_get_iommu_bus_devfn()
to get iommu_bus->iommu_ops and call get_viommu_cap() callback to
get a bitmap with each bit represents a vIOMMU exposed capability.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 MAINTAINERS          |  1 +
 hw/pci/pci.c         | 11 +++++++++++
 include/hw/iommu.h   | 16 ++++++++++++++++
 include/hw/pci/pci.h | 23 +++++++++++++++++++++++
 4 files changed, 51 insertions(+)
 create mode 100644 include/hw/iommu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1842c3dd83..d9fc977b81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2302,6 +2302,7 @@ F: include/system/iommufd.h
 F: backends/host_iommu_device.c
 F: include/system/host_iommu_device.h
 F: include/qemu/chardev_open.h
+F: include/hw/iommu.h
 F: util/chardev_open.c
 F: docs/devel/vfio-iommufd.rst
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c70b5ceeba..df1fb615a8 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2992,6 +2992,17 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
     }
 }
 
+uint64_t pci_device_get_viommu_cap(PCIDevice *dev)
+{
+    PCIBus *iommu_bus;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
+    if (iommu_bus && iommu_bus->iommu_ops->get_viommu_cap) {
+        return iommu_bus->iommu_ops->get_viommu_cap(iommu_bus->iommu_opaque);
+    }
+    return 0;
+}
+
 int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
                          bool exec_req, hwaddr addr, bool lpig,
                          uint16_t prgi, bool is_read, bool is_write)
diff --git a/include/hw/iommu.h b/include/hw/iommu.h
new file mode 100644
index 0000000000..e80aaf4431
--- /dev/null
+++ b/include/hw/iommu.h
@@ -0,0 +1,16 @@
+/*
+ * General vIOMMU capabilities, flags, etc
+ *
+ * Copyright (C) 2025 Intel Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_IOMMU_H
+#define HW_IOMMU_H
+
+enum {
+    VIOMMU_CAP_STAGE1 = BIT_ULL(0),  /* stage1 page table supported */
+};
+
+#endif /* HW_IOMMU_H */
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index df3cc7b875..a11ab14bdc 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -453,6 +453,19 @@ typedef struct PCIIOMMUOps {
      * @devfn: device and function number of the PCI device.
      */
     void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
+    /**
+     * @get_viommu_cap: get vIOMMU capabilities
+     *
+     * Optional callback, if not implemented, then vIOMMU doesn't
+     * support exposing capabilities to other subsystem, e.g., VFIO.
+     * vIOMMU can choose which capabilities to expose.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * Returns: 64bit bitmap with each bit represents a capability emulated
+     * by VIOMMU_CAP_* in include/hw/iommu.h
+     */
+    uint64_t (*get_viommu_cap)(void *opaque);
     /**
      * @get_iotlb_info: get properties required to initialize a device IOTLB.
      *
@@ -633,6 +646,16 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
 
+/**
+ * pci_device_get_viommu_cap: get vIOMMU capabilities.
+ *
+ * Returns a 64bit bitmap with each bit represents a vIOMMU exposed
+ * capability, 0 if vIOMMU doesn't support esposing capabilities.
+ *
+ * @dev: PCI device pointer.
+ */
+uint64_t pci_device_get_viommu_cap(PCIDevice *dev);
+
 /**
  * pci_iommu_get_iotlb_info: get properties required to initialize a
  * device IOTLB.
-- 
2.47.1


