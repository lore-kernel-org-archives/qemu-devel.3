Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DFAD41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 06:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2Qp-00081U-NY; Mon, 15 Dec 2025 01:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV2Qi-000810-Mb
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 01:51:38 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV2Qg-0000u9-4h
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 01:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765781495; x=1797317495;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IDqjTPmEfiskGsVfVAVPXLUUK/9gq3KKukts76FWljY=;
 b=UyDdEWZzDy/UOPECCLbHvbl0feXrqdIa1M3wx5YKAmUKPP+QYadQkE13
 KzL7CdjTN2nHvbnedbRlhV2IaUWOLDBG7iHvfIxFyK1NvyiZ0Fayw7CHT
 T6Lw1MJWazAvJnsB/Hz3KebWuSkxOAWaPs251pMlPw0pRGI1cdk8OrayW
 6+gJIMEk3ffrdjq4thRi6wpXlw77BIghCRhGPqMvprvfLWb3Bc+kyvYNh
 KyJ/XREIILe99VJ0X8mrLjd5hcQ8QqqkpZDWexhm1UBfjGgwO1t+y2NR7
 NavQSQsHk7TbSqpiQcvmEGJBazMVwNKWw4JUJFu6yn/+rwqGIlDT4vKiH A==;
X-CSE-ConnectionGUID: ftAU2tNhQW+hMA4r5USqPA==
X-CSE-MsgGUID: Z5UucovCTy2QcFfm9AEksQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="71304975"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="71304975"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 22:51:34 -0800
X-CSE-ConnectionGUID: F1TfjK+WQdOrv2TsKGoaXQ==
X-CSE-MsgGUID: U6yL3LuzSH6H7yDcIa5trQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197408753"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 22:51:29 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v9 05/19] hw/pci: Introduce pci_device_get_viommu_flags()
Date: Mon, 15 Dec 2025 01:50:29 -0500
Message-ID: <20251215065046.86991-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251215065046.86991-1-zhenzhong.duan@intel.com>
References: <20251215065046.86991-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
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

Note that this op will be invoked at the attach_device() stage, at which
point host IOMMU capabilities are not yet forwarded to the vIOMMU through
the set_iommu_device() callback that will be after the attach_device().

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
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS          |  1 +
 include/hw/iommu.h   | 25 +++++++++++++++++++++++++
 include/hw/pci/pci.h | 22 ++++++++++++++++++++++
 hw/pci/pci.c         | 11 +++++++++++
 4 files changed, 59 insertions(+)
 create mode 100644 include/hw/iommu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d007584b47..5529353759 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2346,6 +2346,7 @@ F: include/system/iommufd.h
 F: backends/host_iommu_device.c
 F: include/system/host_iommu_device.h
 F: include/qemu/chardev_open.h
+F: include/hw/iommu.h
 F: util/chardev_open.c
 F: docs/devel/vfio-iommufd.rst
 
diff --git a/include/hw/iommu.h b/include/hw/iommu.h
new file mode 100644
index 0000000000..9b8bb94fc2
--- /dev/null
+++ b/include/hw/iommu.h
@@ -0,0 +1,25 @@
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
+/*
+ * Theoretical vIOMMU flags. Only determined by the vIOMMU device properties and
+ * independent on the actual host IOMMU capabilities they may depend on. Each
+ * flag can be an expectation or request to other sub-system or just a pure
+ * vIOMMU capability. vIOMMU can choose which flags to expose.
+ */
+enum viommu_flags {
+    /* vIOMMU needs nesting parent HWPT to create nested HWPT */
+    VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
+};
+
+#endif /* HW_IOMMU_H */
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index bde9dca8e2..a3ca54859c 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -462,6 +462,18 @@ typedef struct PCIIOMMUOps {
      * @devfn: device and function number of the PCI device.
      */
     void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
+    /**
+     * @get_viommu_flags: get vIOMMU flags
+     *
+     * Optional callback, if not implemented, then vIOMMU doesn't support
+     * exposing flags to other sub-system, e.g., VFIO.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * Returns: bitmap with each bit representing a vIOMMU flag defined in
+     * enum viommu_flags.
+     */
+    uint64_t (*get_viommu_flags)(void *opaque);
     /**
      * @get_iotlb_info: get properties required to initialize a device IOTLB.
      *
@@ -644,6 +656,16 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
 
+/**
+ * pci_device_get_viommu_flags: get vIOMMU flags.
+ *
+ * Returns: bitmap with each bit representing a vIOMMU flag defined in
+ * enum viommu_flags. Or 0 if vIOMMU doesn't report any.
+ *
+ * @dev: PCI device pointer.
+ */
+uint64_t pci_device_get_viommu_flags(PCIDevice *dev);
+
 /**
  * pci_iommu_get_iotlb_info: get properties required to initialize a
  * device IOTLB.
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 3eb57b96ea..8b62044a8e 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -3021,6 +3021,17 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
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


