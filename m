Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA12C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H3w-0001UN-K9; Tue, 07 May 2024 05:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H3O-0000tD-Aa
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:24:08 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H3M-0000Bi-BE
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715073844; x=1746609844;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BFBVh7a4OwNLjSOvfXm70UiH99H7v0NnXTDPTvjkZ+c=;
 b=I/fUB7oO5LiMirMP2Q+L7sIE0alzE9TshMo5TLRf3yU1wK+J40crQShz
 8lSpHxmvG9UG/U9LBq8JHlwjSCpk0/FV3k8V5WWB81JEpW+GzetY/IyVt
 Er7oV9WjzGkQdG+wTHmtL2Qln12q5p1fcQryqNySCFt5iD9b2O6Y/qUvT
 ItTNIisL0e82Q0XxsCnlx23oyR27CAXkwL2GXgNHYyFEhBU5qvzdYnF41
 QDi1jU4tmCeMXj95MPP7IJgcpdywhYFZdAdstqEoOxa0N7q0MNw7BsItL
 uH+hhAqj7S0zymcGuNN83WqxizFuLO7aeATpts/NR0K+NEUM2FVN1paca A==;
X-CSE-ConnectionGUID: ZVpZrt52Q/yYKP/Q2FVr0g==
X-CSE-MsgGUID: R+ZbMXUoRn+JrpvqkpsF/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10785310"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10785310"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:24:03 -0700
X-CSE-ConnectionGUID: kta5yrVWS8WK+hdeOgPCUg==
X-CSE-MsgGUID: N+ZC2MJlQTWia1o+MVcXow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28553492"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:59 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v4 15/19] hw/pci: Introduce
 pci_device_[set|unset]_iommu_device()
Date: Tue,  7 May 2024 17:20:39 +0800
Message-Id: <20240507092043.1172717-16-zhenzhong.duan@intel.com>
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
index eaa3fc99d8..33ad56408e 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -362,6 +362,7 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range);
 
 void pci_device_deassert_intx(PCIDevice *dev);
 
+typedef struct HostIOMMUDevice HostIOMMUDevice;
 
 /**
  * struct PCIIOMMUOps: callbacks structure for specific IOMMU handlers
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
+     * Returns: true if HostIOMMUDevice is attached or else false with errp set.
+     */
+    bool (*set_iommu_device)(PCIBus *bus, void *opaque, int devfn,
+                             HostIOMMUDevice *dev, Error **errp);
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
+bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
+                                 Error **errp);
+void pci_device_unset_iommu_device(PCIDevice *dev);
 
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 02a4bb2af6..963e589790 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2742,6 +2742,33 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     return &address_space_memory;
 }
 
+bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
+                                 Error **errp)
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


