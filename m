Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AA7C83F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFHE-00022A-MM; Tue, 08 Jul 2025 16:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZE81-0000rA-Py; Tue, 08 Jul 2025 15:37:28 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZE7y-000505-AK; Tue, 08 Jul 2025 15:37:20 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bc51d3k7rz6GF79;
 Tue,  8 Jul 2025 23:41:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id A8EC21404C5;
 Tue,  8 Jul 2025 23:42:29 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Jul 2025 17:42:20 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <gustavo.romero@linaro.org>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v7 07/12] hw/pci: Introduce pci_setup_iommu_per_bus() for
 per-bus IOMMU ops retrieval
Date: Tue, 8 Jul 2025 16:40:50 +0100
Message-ID: <20250708154055.101012-8-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, pci_setup_iommu() registers IOMMU ops for a given PCIBus.
However, when retrieving IOMMU ops for a device using
pci_device_get_iommu_bus_devfn(), the function checks the parent_dev
and fetches IOMMU ops from the parent device, even if the current
bus does not have any associated IOMMU ops.

This behavior works for now because QEMU's IOMMU implementations are
globally scoped, and host bridges rely on the bypass_iommu property
to skip IOMMU translation when needed.

However, this model will break with the soon to be introduced
arm-smmuv3 device, which allows users to associate the IOMMU
with a specific PCIe root complex (e.g., the default pcie.0
or a pxb-pcie root complex).

For example, consider the following setup with multiple root
complexes:

-device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0 \
...
-device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
-device pcie-root-port,id=pcie.port1,bus=pcie.1 \
-device virtio-net-pci,bus=pcie.port1

In Qemu, pxb-pcie acts as a special root complex whose parent is
effectively the default root complex(pcie.0). Hence, though pcie.1
has no associated SMMUv3 as per above, pci_device_get_iommu_bus_devfn()
will incorrectly return the IOMMU ops from pcie.0 due to the fallback
via parent_dev.

To fix this, introduce a new helper pci_setup_iommu_per_bus() that
explicitly sets the new iommu_per_bus field in the PCIBus structure.
This helper will be used in a subsequent patch that adds support for
the new arm-smmuv3 device.

Update pci_device_get_iommu_bus_devfn() to use iommu_per_bus when
determining the correct IOMMU ops, ensuring accurate behavior for
per-bus IOMMUs.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/pci/pci.c             | 31 +++++++++++++++++++++++++++++++
 include/hw/pci/pci.h     |  2 ++
 include/hw/pci/pci_bus.h |  1 +
 3 files changed, 34 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c70b5ceeba..85d6a497da 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2909,6 +2909,19 @@ static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
             }
         }
 
+        /*
+         * When multiple PCI Express Root Buses are defined using pxb-pcie,
+         * the IOMMU configuration may be specific to each root bus. However,
+         * pxb-pcie acts as a special root complex whose parent is effectively
+         * the default root complex(pcie.0). Ensure that we retrieve the
+         * correct IOMMU ops(if any) in such cases.
+         */
+        if (pci_bus_is_express(iommu_bus) && pci_bus_is_root(iommu_bus)) {
+            if (!iommu_bus->iommu_per_bus && parent_bus->iommu_per_bus) {
+                break;
+            }
+        }
+
         iommu_bus = parent_bus;
     }
 
@@ -3169,6 +3182,24 @@ void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
     bus->iommu_opaque = opaque;
 }
 
+/*
+ * Similar to pci_setup_iommu(), but sets iommu_per_bus to true,
+ * indicating that the IOMMU is specific to this bus. This is used by
+ * IOMMU implementations that are tied to a specific PCIe root complex.
+ *
+ * In QEMU, pxb-pcie behaves as a special root complex whose parent is
+ * effectively the default root complex (pcie.0). The iommu_per_bus
+ * is checked in pci_device_get_iommu_bus_devfn() to ensure the correct
+ * IOMMU ops are returned, avoiding the use of the parent’s IOMMU when
+ * it's not appropriate.
+ */
+void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
+                             void *opaque)
+{
+    pci_setup_iommu(bus, ops, opaque);
+    bus->iommu_per_bus = true;
+}
+
 static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
 {
     Range *range = opaque;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index df3cc7b875..a3e0870a15 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -764,6 +764,8 @@ int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
  */
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
 
+void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
+
 pcibus_t pci_bar_address(PCIDevice *d,
                          int reg, uint8_t type, pcibus_t size);
 
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index 2261312546..c738446788 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -35,6 +35,7 @@ struct PCIBus {
     enum PCIBusFlags flags;
     const PCIIOMMUOps *iommu_ops;
     void *iommu_opaque;
+    bool iommu_per_bus;
     uint8_t devfn_min;
     uint32_t slot_reserved_mask;
     pci_set_irq_fn set_irq;
-- 
2.47.0


