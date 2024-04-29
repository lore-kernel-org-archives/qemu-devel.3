Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15FAC19F53
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1KuN-0002gu-91; Mon, 29 Apr 2024 02:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Ku9-00029l-Jr
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:29 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Ku7-0007m1-P6
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373664; x=1745909664;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cq8fXTzgJ7kHNocLmUjDKrOPQxesv37fN7VuB6W7Z9c=;
 b=mVkfM8xgBBV+2xfJeCzmSqeQ4BW/0O0jblP+dOjRAmYtS3fs2uBo34Eg
 12/bn6c3Uo/vOuWPD8JQqLS+eRoGqYCT4UbxS8VQxQnenCYHGHfIINdZN
 hiXxgaxfU8Otsup6YSHit6O6+AQsY0f2Y3+d3EiZ8+9UvrbhSgSfJ4hfA
 IgdOJSKcj2fI0YbbSc7JSRtYp2fP0T//NM4YTSvJnwgjdml5+EVNmV41r
 p2SDrIB1hexLxkRK7VkmXt0FADgTFUvbxAUMEHh8/ArdqbY2MFiex7fmp
 Orr+nYdG3y2bvEVIRJB8zjPnaJ5sAZaJMuYrGpQt71maMR2v4S+TQa4Q0 Q==;
X-CSE-ConnectionGUID: RWj+Rx/HS6WyGG4bwBssYA==
X-CSE-MsgGUID: QS5M4h+8QPWy+3RX/XsRkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560754"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560754"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:21 -0700
X-CSE-ConnectionGUID: I7clq2WERByjqdC6sQ2kOg==
X-CSE-MsgGUID: 5BmP7l5RT2qEpMqhqAqZhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63488323"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:17 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 15/19] hw/pci: Introduce
 pci_device_[set|unset]_iommu_device()
Date: Mon, 29 Apr 2024 14:50:42 +0800
Message-Id: <20240429065046.3688701-16-zhenzhong.duan@intel.com>
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

From: Yi Liu <yi.l.liu@intel.com>

pci_device_[set|unset]_iommu_device() call pci_device_get_iommu_bus_devfn()
to get iommu_bus->iommu_ops and call [set|unset]_iommu_device callback to
set/unset HostIOMMUDevice for a given PCI device.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/pci/pci.h | 38 +++++++++++++++++++++++++++++++++++++-
 hw/pci/pci.c         | 27 +++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index eaa3fc99d8..849e391813 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -3,6 +3,7 @@
 
 #include "exec/memory.h"
 #include "sysemu/dma.h"
+#include "sysemu/host_iommu_device.h"
 
 /* PCI includes legacy ISA access.  */
 #include "hw/isa/isa.h"
@@ -383,10 +384,45 @@ typedef struct PCIIOMMUOps {
      *
      * @devfn: device and function number
      */
-   AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
+    AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
+    /**
+     * @set_iommu_device: attach a HostIOMMUDevice to a vIOMMU
+     *
+     * Optional callback, if not implemented in vIOMMU, then vIOMMU can't
+     * retrieve host information from the associated HostIOMMUDevice.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     *
+     * @dev: the data structure representing host IOMMU device.
+     *
+     * @errp: pass an Error out only when return false
+     *
+     * Returns: 0 if HostIOMMUDevice is attached, or else <0 with errp set.
+     */
+    int (*set_iommu_device)(PCIBus *bus, void *opaque, int devfn,
+                            HostIOMMUDevice *dev, Error **errp);
+    /**
+     * @unset_iommu_device: detach a HostIOMMUDevice from a vIOMMU
+     *
+     * Optional callback.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     */
+    void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
 } PCIIOMMUOps;
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
+int pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
+                                Error **errp);
+void pci_device_unset_iommu_device(PCIDevice *dev);
 
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 02a4bb2af6..c3293e9357 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2742,6 +2742,33 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     return &address_space_memory;
 }
 
+int pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
+                                Error **errp)
+{
+    PCIBus *iommu_bus;
+
+    /* set_iommu_device requires device's direct BDF instead of aliased BDF */
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
+    if (iommu_bus && iommu_bus->iommu_ops->set_iommu_device) {
+        return iommu_bus->iommu_ops->set_iommu_device(pci_get_bus(dev),
+                                                      iommu_bus->iommu_opaque,
+                                                      dev->devfn, hiod, errp);
+    }
+    return 0;
+}
+
+void pci_device_unset_iommu_device(PCIDevice *dev)
+{
+    PCIBus *iommu_bus;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
+    if (iommu_bus && iommu_bus->iommu_ops->unset_iommu_device) {
+        return iommu_bus->iommu_ops->unset_iommu_device(pci_get_bus(dev),
+                                                        iommu_bus->iommu_opaque,
+                                                        dev->devfn);
+    }
+}
+
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
 {
     /*
-- 
2.34.1


