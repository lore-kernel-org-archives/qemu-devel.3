Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DB0C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 07:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRXf-0005xy-Nm; Thu, 01 Feb 2024 02:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRXd-0005x3-S9
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:31:21 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRXV-0001hL-7u
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706772673; x=1738308673;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=id+Z1Tr+dw3DYND8HRmXBEtVfPDghhlU8wnr/4KPBxo=;
 b=Y0plqqLpXo9yJF7h5T5W2kCwCu1FWzia/w7oSjEhzhM8RuJY3g1RieEz
 ES048kHXaxks2DZ4A4KqIVAzb2vJgYc2l01shpqjxfghRwD3KzdGw2JMK
 qNS3tvhNtoLh36JwTy+fpt2ZIavCpxj1/HD3uGgiaeMfjoiENOGv5XpBK
 7BW5wsBU2wnjhPy3aIBmIGYqGwakBkTGtIXp000A7Dux/LtVfxgks3hWE
 PNwJP54LarMLwoLzxsWW8KunwAV4g4maXlVpaQkiqe0vjH3oH/ZZSFkKu
 i+qBAxL8B+fG80MJ4bzyLOfKLgfmrAsgXemdptCE4Ad46lNoMHqE9vf2F A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402676763"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="402676763"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:31:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4443297"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:31:02 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv2 10/18] hw/pci: Introduce
 pci_device_set/unset_iommu_device()
Date: Thu,  1 Feb 2024 15:28:10 +0800
Message-Id: <20240201072818.327930-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201072818.327930-1-zhenzhong.duan@intel.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This adds pci_device_set/unset_iommu_device() to set/unset
HostIOMMUDevice for a given PCIe device. Caller of set
should fail if set operation fails.

Extract out pci_device_get_iommu_bus_devfn() to facilitate
implementation of pci_device_set/unset_iommu_device().

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/pci/pci.h | 38 ++++++++++++++++++++++++++-
 hw/pci/pci.c         | 62 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index fa6313aabc..5b471fd380 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -3,6 +3,7 @@
 
 #include "exec/memory.h"
 #include "sysemu/dma.h"
+#include "sysemu/host_iommu_device.h"
 
 /* PCI includes legacy ISA access.  */
 #include "hw/isa/isa.h"
@@ -384,10 +385,45 @@ typedef struct PCIIOMMUOps {
      *
      * @devfn: device and function number
      */
-   AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
+    AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
+    /**
+     * @set_iommu_device: set iommufd device for a PCI device to vIOMMU
+     *
+     * Optional callback, if not implemented in vIOMMU, then vIOMMU can't
+     * utilize iommufd specific features.
+     *
+     * Return true if iommufd device is accepted, or else return false with
+     * errp set.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     *
+     * @dev: the data structure representing host assigned device.
+     *
+     */
+    int (*set_iommu_device)(PCIBus *bus, void *opaque, int devfn,
+                            HostIOMMUDevice *dev, Error **errp);
+    /**
+     * @unset_iommu_device: unset iommufd device for a PCI device from vIOMMU
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
+int pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *base_dev,
+                                Error **errp);
+void pci_device_unset_iommu_device(PCIDevice *dev);
 
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 76080af580..8078307963 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2672,11 +2672,14 @@ static void pci_device_class_base_init(ObjectClass *klass, void *data)
     }
 }
 
-AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
+static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
+                                           PCIBus **aliased_bus,
+                                           PCIBus **piommu_bus,
+                                           int *aliased_devfn)
 {
     PCIBus *bus = pci_get_bus(dev);
     PCIBus *iommu_bus = bus;
-    uint8_t devfn = dev->devfn;
+    int devfn = dev->devfn;
 
     while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
         PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
@@ -2717,13 +2720,66 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 
         iommu_bus = parent_bus;
     }
-    if (!pci_bus_bypass_iommu(bus) && iommu_bus->iommu_ops) {
+
+    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
+    assert(iommu_bus);
+
+    if (pci_bus_bypass_iommu(bus) || !iommu_bus->iommu_ops) {
+        iommu_bus = NULL;
+    }
+
+    *piommu_bus = iommu_bus;
+
+    if (aliased_bus) {
+        *aliased_bus = bus;
+    }
+
+    if (aliased_devfn) {
+        *aliased_devfn = devfn;
+    }
+}
+
+AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus) {
         return iommu_bus->iommu_ops->get_address_space(bus,
                                  iommu_bus->iommu_opaque, devfn);
     }
     return &address_space_memory;
 }
 
+int pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *base_dev,
+                                Error **errp)
+{
+    PCIBus *iommu_bus;
+
+    pci_device_get_iommu_bus_devfn(dev, NULL, &iommu_bus, NULL);
+    if (iommu_bus && iommu_bus->iommu_ops->set_iommu_device) {
+        return iommu_bus->iommu_ops->set_iommu_device(pci_get_bus(dev),
+                                                      iommu_bus->iommu_opaque,
+                                                      dev->devfn, base_dev,
+                                                      errp);
+    }
+    return 0;
+}
+
+void pci_device_unset_iommu_device(PCIDevice *dev)
+{
+    PCIBus *iommu_bus;
+
+    pci_device_get_iommu_bus_devfn(dev, NULL, &iommu_bus, NULL);
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


