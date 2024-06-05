Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D939AC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEm5v-0001q3-RC; Wed, 05 Jun 2024 04:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5u-0001nQ-IY
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:34:06 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5s-00062T-IV
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717576445; x=1749112445;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cLXto5lTTRuKedPlHNOcB9nwrNNwqPGVin048o0aHD4=;
 b=F7tILgun+Q4rn/OP4wCRD2YD5TNjhCxNvRDvaZNpyKKnwqvHvpUAVg31
 WvK6x58n/EMIEkJzijLD4CBVwDOf+scKH5GFeEuUqqLcVURs4DnEO1B+W
 acBdg6WLE8ieVEZs3ZpSJKd1i5WIVZ9HeOO5t8E9iAcfmeJdgGsMH4Wkc
 OjBSv2r7ydAdu/1C9dIxXFOQm8/BCVFMyGgdsOKwTL4CKWv3kfFjmj5oS
 8PfHFgd9PM475UPt/D37YlAZBKEm/NVzQBHOTUwCz71lFumIug29tVHlv
 YxEG4qO6RSk9gPmqSkux1ptvOwa9+hdz+y591ESTCMypgkj61Sc7LVCcK A==;
X-CSE-ConnectionGUID: wAVRzlRCQgOWsCu94a6kdQ==
X-CSE-MsgGUID: iAW8wq2gT3Kk2VqPr0Ujig==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25575399"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="25575399"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:34:04 -0700
X-CSE-ConnectionGUID: h3StnYd3SLm7lhP8509VtQ==
X-CSE-MsgGUID: ETRSgtTiQ3OhryMnpk63zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="37954847"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:34:00 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v7 12/17] hw/pci: Introduce helper function
 pci_device_get_iommu_bus_devfn()
Date: Wed,  5 Jun 2024 16:30:38 +0800
Message-Id: <20240605083043.317831-13-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605083043.317831-1-zhenzhong.duan@intel.com>
References: <20240605083043.317831-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Extract out pci_device_get_iommu_bus_devfn() from
pci_device_iommu_address_space() to facilitate
implementation of pci_device_[set|unset]_iommu_device()
in following patch.

No functional change intended.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/pci/pci.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 324c1302d2..02a4bb2af6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2648,11 +2648,27 @@ static void pci_device_class_base_init(ObjectClass *klass, void *data)
     }
 }
 
-AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
+/*
+ * Get IOMMU root bus, aliased bus and devfn of a PCI device
+ *
+ * IOMMU root bus is needed by all call sites to call into iommu_ops.
+ * For call sites which don't need aliased BDF, passing NULL to
+ * aliased_[bus|devfn] is allowed.
+ *
+ * @piommu_bus: return root #PCIBus backed by an IOMMU for the PCI device.
+ *
+ * @aliased_bus: return aliased #PCIBus of the PCI device, optional.
+ *
+ * @aliased_devfn: return aliased devfn of the PCI device, optional.
+ */
+static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
+                                           PCIBus **piommu_bus,
+                                           PCIBus **aliased_bus,
+                                           int *aliased_devfn)
 {
     PCIBus *bus = pci_get_bus(dev);
     PCIBus *iommu_bus = bus;
-    uint8_t devfn = dev->devfn;
+    int devfn = dev->devfn;
 
     while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
         PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
@@ -2693,7 +2709,33 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 
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
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
+    if (iommu_bus) {
         return iommu_bus->iommu_ops->get_address_space(bus,
                                  iommu_bus->iommu_opaque, devfn);
     }
-- 
2.34.1


