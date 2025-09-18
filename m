Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC71FCAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 08:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAU1-000124-LA; Thu, 18 Sep 2025 04:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzATi-0000oB-NP
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:00 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzATe-0004j2-7p
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758185934; x=1789721934;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RSUOvermyX2pxpbuQCt08BT7UyyKZv3uKbqgB/W3tz0=;
 b=hz6yck21IEtkUjP5zX+F3+/uIey7dwYcMd8j+fWXOaEV19dE9sPT9Gp2
 J6OGWku1u5I+G+W4vxXXvFe+hbOw41ef4q5xKKFduoCnuYb1RxXoCjrVg
 ByLuVCmnIpv/X0G93UMHBB6Oqow/z+M+Id7e3WEBpBh38X+W/Qx1cxRGm
 sAxc2r7+W1ufcyv3qrw20jXIX15hA7eVfpw0TVkeSBIU2FUK1Eay+7a96
 4Z9Uqo3LheWzBUIvQX3tRqOGplmyQPNYHDLK7EIo1eydi78vmZRpHkCvi
 346v8S7ngelS8lmnMs7sv/NspaMxbmB7Tlw50lln2Aas37hGBtuHvaHAw Q==;
X-CSE-ConnectionGUID: ilhgy0VZRv6GnmAp2c01oQ==
X-CSE-MsgGUID: mVI6ZF+iTyKaOVzm3CmL3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="78109429"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="78109429"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:58:53 -0700
X-CSE-ConnectionGUID: 84t6334oRWuKZQntlKQM/A==
X-CSE-MsgGUID: kjeVKNHoTteAStUj9tuLhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175930332"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:58:49 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 05/22] hw/pci: Introduce pci_device_get_viommu_flags()
Date: Thu, 18 Sep 2025 04:57:44 -0400
Message-ID: <20250918085803.796942-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250918085803.796942-1-zhenzhong.duan@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
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

Introduce a new PCIIOMMUOps optional callback, get_viommu_flags() which
allows to retrieve flags exposed by a vIOMMU. The first planned vIOMMU
device flag is VIOMMU_FLAG_WANT_NESTING_PARENT that advertises the
support of HW nested stage translation scheme and wants other sub-system
like VFIO's cooperation to create nesting parent HWPT.

pci_device_get_viommu_flags() is a wrapper that can be called on a PCI
device potentially protected by a vIOMMU.

get_viommu_flags() is designed to return 64bit bitmap of purely vIOMMU
flags which are only determined by user's configuration, no host
capabilities involved. Reasons are:

1. host may has heterogeneous IOMMUs, each with different capabilities
2. this is migration friendly, return value is consistent between source
   and target.
3. host IOMMU capabilities are passed to vIOMMU through set_iommu_device()
   interface which have to be after attach_device(), when get_viommu_flags()
   is called in attach_device(), there is no way for vIOMMU to get host
   IOMMU capabilities yet, so only pure vIOMMU flags can be returned.
   See below sequence:

     vfio_device_attach():
         iommufd_cdev_attach():
             pci_device_get_viommu_flags() for HW nesting cap
             create a nesting parent HWPT
             attach device to the HWPT
             vfio_device_hiod_create_and_realize() creating hiod
     ...
     pci_device_set_iommu_device(hiod)

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 MAINTAINERS          |  1 +
 include/hw/iommu.h   | 19 +++++++++++++++++++
 include/hw/pci/pci.h | 27 +++++++++++++++++++++++++++
 hw/pci/pci.c         | 11 +++++++++++
 4 files changed, 58 insertions(+)
 create mode 100644 include/hw/iommu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f8cd513d8b..71457e4cde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2307,6 +2307,7 @@ F: include/system/iommufd.h
 F: backends/host_iommu_device.c
 F: include/system/host_iommu_device.h
 F: include/qemu/chardev_open.h
+F: include/hw/iommu.h
 F: util/chardev_open.c
 F: docs/devel/vfio-iommufd.rst
 
diff --git a/include/hw/iommu.h b/include/hw/iommu.h
new file mode 100644
index 0000000000..65d652950a
--- /dev/null
+++ b/include/hw/iommu.h
@@ -0,0 +1,19 @@
+/*
+ * General vIOMMU flags
+ *
+ * Copyright (C) 2025 Intel Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_IOMMU_H
+#define HW_IOMMU_H
+
+#include "qemu/bitops.h"
+
+enum {
+    /* Nesting parent HWPT will be reused by vIOMMU to create nested HWPT */
+     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
+};
+
+#endif /* HW_IOMMU_H */
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index bde9dca8e2..c54f2b53ae 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -462,6 +462,23 @@ typedef struct PCIIOMMUOps {
      * @devfn: device and function number of the PCI device.
      */
     void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
+    /**
+     * @get_viommu_flags: get vIOMMU flags
+     *
+     * Optional callback, if not implemented, then vIOMMU doesn't support
+     * exposing flags to other sub-system, e.g., VFIO. Each flag can be
+     * an expectation or request to other sub-system or just a pure vIOMMU
+     * capability. vIOMMU can choose which flags to expose.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * Returns: 64bit bitmap with each bit represents a flag that vIOMMU
+     * wants to expose. See VIOMMU_FLAG_* in include/hw/iommu.h for all
+     * possible flags currently used. These flags are theoretical which
+     * are only determined by vIOMMU device properties and independent on
+     * the actual host capabilities they may depend on.
+     */
+    uint64_t (*get_viommu_flags)(void *opaque);
     /**
      * @get_iotlb_info: get properties required to initialize a device IOTLB.
      *
@@ -644,6 +661,16 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
 
+/**
+ * pci_device_get_viommu_flags: get vIOMMU flags.
+ *
+ * Returns a 64bit bitmap with each bit represents a vIOMMU exposed
+ * flags, 0 if vIOMMU doesn't support that.
+ *
+ * @dev: PCI device pointer.
+ */
+uint64_t pci_device_get_viommu_flags(PCIDevice *dev);
+
 /**
  * pci_iommu_get_iotlb_info: get properties required to initialize a
  * device IOTLB.
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4d4b9dda4d..1315ef13ea 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -3012,6 +3012,17 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
     }
 }
 
+uint64_t pci_device_get_viommu_flags(PCIDevice *dev)
+{
+    PCIBus *iommu_bus;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
+    if (iommu_bus && iommu_bus->iommu_ops->get_viommu_flags) {
+        return iommu_bus->iommu_ops->get_viommu_flags(iommu_bus->iommu_opaque);
+    }
+    return 0;
+}
+
 int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
                          bool exec_req, hwaddr addr, bool lpig,
                          uint16_t prgi, bool is_read, bool is_write)
-- 
2.47.1


