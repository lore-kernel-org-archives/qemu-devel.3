Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA124C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMlX-0001t4-QZ; Mon, 14 Jul 2025 13:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLcv-0005Yt-5X; Mon, 14 Jul 2025 12:02:05 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLct-0008PQ-0Q; Mon, 14 Jul 2025 12:02:00 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgn9G1MDrz6L5d4;
 Tue, 15 Jul 2025 00:00:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 1C1BB1402FB;
 Tue, 15 Jul 2025 00:01:55 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 18:01:46 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: [RFC PATCH v3 11/15] hw/pci/pci: Introduce optional
 get_msi_address_space() callback.
Date: Mon, 14 Jul 2025 16:59:37 +0100
Message-ID: <20250714155941.22176-12-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On ARM, when a device is behind an IOMMU, its MSI doorbell address is
subject to translation by the IOMMU. This behavior affects vfio-pci
passthrough devices assigned to guests using an accelerated SMMUv3.

In this setup, we configure the host SMMUv3 in nested mode, where
VFIO sets up the Stage-2 (S2) mappings for guest RAM, while the guest
controls Stage-1 (S1). To allow VFIO to correctly configure S2 mappings,
we currently return the system address space via the get_address_space()
callback for vfio-pci devices.

However, QEMU/KVM also uses this same callback path when resolving the
address space for MSI doorbells:

kvm_irqchip_add_msi_route()
  kvm_arch_fixup_msi_route()
    pci_device_iommu_address_space()

This leads to problems when MSI doorbells need to be translated.

To fix this, introduce an optional get_msi_address_space() callback.
In the SMMUv3 accelerated case, this callback returns the IOMMU address
space if the guest has set up S1 translations for the vfio-pci device.
Otherwise, it returns the system address space.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3-accel.c | 25 +++++++++++++++++++++++++
 hw/pci/pci.c          | 19 +++++++++++++++++++
 include/hw/pci/pci.h  | 16 ++++++++++++++++
 target/arm/kvm.c      |  2 +-
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f1584dd775..04c665ccf5 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -346,6 +346,30 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     }
 }
 
+static AddressSpace *smmuv3_accel_find_msi_as(PCIBus *bus, void *opaque,
+                                                  int devfn)
+{
+    SMMUState *bs = opaque;
+    SMMUPciBus *sbus;
+    SMMUv3AccelDevice *accel_dev;
+    SMMUDevice *sdev;
+
+    sbus = smmu_get_sbus(bs, bus);
+    accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
+    sdev = &accel_dev->sdev;
+
+    /*
+     * If the assigned vfio-pci dev has S1 translation enabled by
+     * Guest, return IOMMU address space for MSI translation.
+     * Otherwise, return system address space.
+     */
+    if (accel_dev->s1_hwpt) {
+        return &sdev->as;
+    } else {
+        return &accel_dev->as_sysmem;
+    }
+}
+
 static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
 {
 
@@ -407,6 +431,7 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_viommu_cap = smmuv3_accel_get_viommu_cap,
     .set_iommu_device = smmuv3_accel_set_iommu_device,
     .unset_iommu_device = smmuv3_accel_unset_iommu_device,
+    .get_msi_address_space = smmuv3_accel_find_msi_as,
 };
 
 void smmuv3_accel_init(SMMUv3State *s)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 13de0e2809..404aeb643d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2957,6 +2957,25 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     return &address_space_memory;
 }
 
+AddressSpace *pci_device_iommu_msi_address_space(PCIDevice *dev)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
+    if (iommu_bus) {
+        if (iommu_bus->iommu_ops->get_msi_address_space) {
+            return iommu_bus->iommu_ops->get_msi_address_space(bus,
+                                 iommu_bus->iommu_opaque, devfn);
+        } else {
+            return iommu_bus->iommu_ops->get_address_space(bus,
+                                 iommu_bus->iommu_opaque, devfn);
+        }
+    }
+    return &address_space_memory;
+}
+
 int pci_iommu_init_iotlb_notifier(PCIDevice *dev, IOMMUNotifier *n,
                                   IOMMUNotify fn, void *opaque)
 {
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d1d43e9fb9..55138c406e 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -639,12 +639,28 @@ typedef struct PCIIOMMUOps {
                             uint32_t pasid, bool priv_req, bool exec_req,
                             hwaddr addr, bool lpig, uint16_t prgi, bool is_read,
                             bool is_write);
+    /**
+     * @get_msi_address_space: get the address space for MSI doorbell address
+     * for devices
+     *
+     * Optional callback which returns a pointer to an #AddressSpace. This
+     * is required if MSI doorbell also gets translated through IOMMU(eg: ARM)
+     *
+     * @bus: the #PCIBus being accessed.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number
+     */
+    AddressSpace * (*get_msi_address_space)(PCIBus *bus, void *opaque,
+                                            int devfn);
 } PCIIOMMUOps;
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
+AddressSpace *pci_device_iommu_msi_address_space(PCIDevice *dev);
 
 /**
  * pci_device_get_viommu_cap: get vIOMMU capabilities.
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 6672344855..c78d0d59bb 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1535,7 +1535,7 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level)
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
-    AddressSpace *as = pci_device_iommu_address_space(dev);
+    AddressSpace *as = pci_device_iommu_msi_address_space(dev);
     hwaddr xlat, len, doorbell_gpa;
     MemoryRegionSection mrs;
     MemoryRegion *mr;
-- 
2.34.1


