Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33984C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1KuP-0002tn-Iw; Mon, 29 Apr 2024 02:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Ku4-000295-8V
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:25 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Ku1-0007m1-1Q
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373657; x=1745909657;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lOqDt9v6x0LF0QRt0dafkaMf+eapZI59zjmfrdfGr4k=;
 b=I/9IEMbU7WOpfJjSsLbufldqCOmOuW1UzlAAEuv56wuujJL35dFA0Xor
 KPDNOKJOaV4XtntyDme4kwMf89cChk82DCBDbxomLO4dW2mtGsTEvyF8W
 DRe5Hr7SDQSNwW/MqeZpUx9uMxLPN8vakJXW0rM//HpcYi/Y49jw716bx
 rvciUQVxirGzbjBPR/9aoJzWmkJYe3wVK7yzrMcbp6a1/+oCYHdpFz730
 J9Hw2VGM2xbp5YnYuJFrZfLi42tnbG6PrFnn9DvP3SZifi89NlqFNzmuE
 YolxItrOBKJJXd5YjedFhtwsKB8hfStkaUVpZVOegHPgke+SyXr3Avb8Q A==;
X-CSE-ConnectionGUID: fauOdEP5QmaXNisJotLAvQ==
X-CSE-MsgGUID: Tr1cX8VSSgGMivdNX466dA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560746"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560746"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:16 -0700
X-CSE-ConnectionGUID: ubrSFQkRR96aA4Ho9AL+VA==
X-CSE-MsgGUID: OvsJrTqHTomzQbC80gdBkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63488298"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:13 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 14/19] hw/pci: Introduce helper function
 pci_device_get_iommu_bus_devfn()
Date: Mon, 29 Apr 2024 14:50:41 +0800
Message-Id: <20240429065046.3688701-15-zhenzhong.duan@intel.com>
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

Extract out pci_device_get_iommu_bus_devfn() from
pci_device_iommu_address_space() to facilitate
implementation of pci_device_[set|unset]_iommu_device()
in following patch.

No functional change intended.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
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


