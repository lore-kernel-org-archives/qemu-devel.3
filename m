Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59742C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 09:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uggWT-0004jE-QZ; Tue, 29 Jul 2025 05:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggWI-0004cR-Sq
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:21:16 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggWE-0002ac-Sg
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753780871; x=1785316871;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YrMUOAbaPySq5rNWcT8o3Mzs/Ye4hYTT3J/w1kcD3tw=;
 b=L7EORSwX1y+eSfoTXPZwYRis0Y5UvI8u8kUE/PJKNmQkEs7OlRdeFimD
 mdnynNnYCkOPAMFDIvAhI1JGH36ZmOzrk7yhSpiCJO7R6kZrb4mSnwTAg
 HqujUhPU1J2MSjU6cEBM9uI9gw0Ab1p3Rh/boPNTfw/Yo3//ek5ss+qmD
 E2s/AoPFtqBfhdm+gJaA3F0XAiPEP2O/n6EtLkLB0UJZXRhzBC9bpJulI
 gtMW6UD66lLhSpWHRHq8uriAgMv1W1eBzHV3UvvbX5qTOyzYVbQa3W0KX
 6meEOdFojdCTsfYxFE7Ka/xp+a9YPdXAOJCcHMlV18mJRfN5M7N/Vhzma Q==;
X-CSE-ConnectionGUID: qbkNNuBMTse86/b7FG1k2A==
X-CSE-MsgGUID: DPY+cr7iTEiB2cDYPAA+PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55981846"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="55981846"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:21:09 -0700
X-CSE-ConnectionGUID: 3XaEHYvUQWerjmacVzTxeA==
X-CSE-MsgGUID: fpq1/bVATa6KA/zvxQjzlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="162691098"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:21:03 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Date: Tue, 29 Jul 2025 05:20:24 -0400
Message-ID: <20250729092043.785836-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250729092043.785836-1-zhenzhong.duan@intel.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
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

Introduce a new PCIIOMMUOps optional callback, get_viommu_cap() which
allows to retrieve capabilities exposed by a vIOMMU. The first planned
capability is VIOMMU_CAP_HW_NESTED that advertises the support of HW
nested stage translation scheme. pci_device_get_viommu_cap is a wrapper
that can be called on a PCI device potentially protected by a vIOMMU.

get_viommu_cap() is designed to return 64bit bitmap of purely emulated
capabilities which are only derermined by user's configuration, no host
capabilities involved. Reasons are:

1. there can be more than one host IOMMUs with different capabilities
2. there can also be more than one vIOMMUs with different user
   configuration, e.g., arm smmuv3.
3. This is migration friendly, return value is consistent between source
   and target.
4. It's too late for VFIO to call get_viommu_cap() after set_iommu_device()
   because we need get_viommu_cap() to determine if creating nested parent
   hwpt or not at attaching stage, meanwhile hiod realize needs iommufd,
   devid and hwpt_id which are ready after attach_device().
   See below sequence:

     attach_device()
       get_viommu_cap()
       create hwpt
     ...
     create hiod
     set_iommu_device(hiod)

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 MAINTAINERS          |  1 +
 include/hw/iommu.h   | 17 +++++++++++++++++
 include/hw/pci/pci.h | 25 +++++++++++++++++++++++++
 hw/pci/pci.c         | 11 +++++++++++
 4 files changed, 54 insertions(+)
 create mode 100644 include/hw/iommu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 37879ab64e..840cb1e604 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2304,6 +2304,7 @@ F: include/system/iommufd.h
 F: backends/host_iommu_device.c
 F: include/system/host_iommu_device.h
 F: include/qemu/chardev_open.h
+F: include/hw/iommu.h
 F: util/chardev_open.c
 F: docs/devel/vfio-iommufd.rst
 
diff --git a/include/hw/iommu.h b/include/hw/iommu.h
new file mode 100644
index 0000000000..021db50db5
--- /dev/null
+++ b/include/hw/iommu.h
@@ -0,0 +1,17 @@
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
+    /* hardware nested stage-1 page table support */
+    VIOMMU_CAP_HW_NESTED = BIT_ULL(0),
+};
+
+#endif /* HW_IOMMU_H */
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 6b7d3ac8a3..d89aefc030 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -462,6 +462,21 @@ typedef struct PCIIOMMUOps {
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
+     * Returns: 64bit bitmap with each bit represents a capability emulated by
+     * VIOMMU_CAP_* in include/hw/iommu.h, these capabilities are theoretical
+     * which are only determined by user's configuration and independent on the
+     * actual host capabilities they may depend on.
+     */
+    uint64_t (*get_viommu_cap)(void *opaque);
     /**
      * @get_iotlb_info: get properties required to initialize a device IOTLB.
      *
@@ -642,6 +657,16 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
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
-- 
2.47.1


