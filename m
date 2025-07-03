Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3FDC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFbx-0006iu-IF; Thu, 03 Jul 2025 04:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uXFbv-0006hr-LD; Thu, 03 Jul 2025 04:48:03 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uXFbt-00045e-AT; Thu, 03 Jul 2025 04:48:03 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXr4L3XqDz6L5HN;
 Thu,  3 Jul 2025 16:47:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 0A1CB1402F0;
 Thu,  3 Jul 2025 16:47:59 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Jul 2025 10:47:49 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <gustavo.romero@linaro.org>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v6 04/12] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Date: Thu, 3 Jul 2025 09:46:35 +0100
Message-ID: <20250703084643.85740-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
References: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

With the soon to be introduced user-creatable SMMUv3 devices for
virt, it is possible to have multiple SMMUv3 devices associated
with different PCIe root complexes.

Update IORT nodes accordingly.

An example IORT Id mappings for a Qemu virt machine with two
PCIe Root Complexes each assocaited with a SMMUv3 will
be something like below,

  -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
  -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
  ...

  +--------------------+           +--------------------+
  |   Root Complex 0   |           |   Root Complex 1   |
  |                    |           |                    |
  |  Requestor IDs     |           |  Requestor IDs     |
  |  0x0000 - 0x00FF   |           |  0x0100 - 0x01FF   |
  +---------+----------+           +---------+----------+
            |                               |
            |                               |
            |       Stream ID Mapping       |
            v                               v
  +--------------------+          +--------------------+
  |    SMMUv3 Node 0   |          |    SMMUv3 Node 1   |
  |                    |          |                    |
  | Stream IDs 0x0000- |          | Stream IDs 0x0100- |
  | 0x00FF mapped from |          | 0x01FF mapped from |
  | RC0 Requestor IDs  |          | RC1 Requestor IDs  |
  +--------------------+          +--------------------+
            |                                |
            |                                |
            +----------------+---------------+
                             |
                             |Device ID Mapping
                             v
              +----------------------------+
              |       ITS Node 0           |
              |                            |
              | Device IDs:                |
              | 0x0000 - 0x00FF (from RC0) |
              | 0x0100 - 0x01FF (from RC1) |
              | 0x0200 - 0xFFFF (No SMMU)  |
              +----------------------------+

Tested-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/virt-acpi-build.c | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index cb11b316a2..d2a3914d91 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -43,6 +43,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/hmat.h"
+#include "hw/arm/smmuv3.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
@@ -299,6 +300,67 @@ static int populate_smmuv3_legacy_dev(GArray *sdev_blob)
     return sdev.rc_smmu_idmaps->len;
 }
 
+static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
+{
+    AcpiIortSMMUv3Dev *sdev_a = (AcpiIortSMMUv3Dev *)a;
+    AcpiIortSMMUv3Dev *sdev_b = (AcpiIortSMMUv3Dev *)b;
+    AcpiIortIdMapping *map_a = &g_array_index(sdev_a->rc_smmu_idmaps,
+                                              AcpiIortIdMapping, 0);
+    AcpiIortIdMapping *map_b = &g_array_index(sdev_b->rc_smmu_idmaps,
+                                              AcpiIortIdMapping, 0);
+    return map_a->input_base - map_b->input_base;
+}
+
+static int iort_smmuv3_devices(Object *obj, void *opaque)
+{
+    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
+    GArray *sdev_blob = opaque;
+    AcpiIortIdMapping idmap;
+    PlatformBusDevice *pbus;
+    AcpiIortSMMUv3Dev sdev;
+    int min_bus, max_bus;
+    SysBusDevice *sbdev;
+    PCIBus *bus;
+
+    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
+        return 0;
+    }
+
+    bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
+    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+    sbdev = SYS_BUS_DEVICE(obj);
+    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
+    sdev.irq = platform_bus_get_irqn(pbus, sbdev, 0);
+    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
+    sdev.irq += ARM_SPI_BASE;
+
+    pci_bus_range(bus, &min_bus, &max_bus);
+    sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    idmap.input_base = min_bus << 8,
+    idmap.id_count = (max_bus - min_bus + 1) << 8,
+    g_array_append_val(sdev.rc_smmu_idmaps, idmap);
+    g_array_append_val(sdev_blob, sdev);
+    return 0;
+}
+
+/*
+ * Populate the struct AcpiIortSMMUv3Dev for all SMMUv3 devices and
+ * return the total number of idmaps.
+ */
+static int populate_smmuv3_dev(GArray *sdev_blob)
+{
+    object_child_foreach_recursive(object_get_root(),
+                                   iort_smmuv3_devices, sdev_blob);
+    /* Sort the smmuv3 devices(if any) by smmu idmap input_base */
+    g_array_sort(sdev_blob, smmuv3_dev_idmap_compare);
+    /*
+     * Since each SMMUv3 dev is assocaited with specific host bridge,
+     * total number of idmaps equals to total number of smmuv3 devices.
+     */
+    return sdev_blob->len;
+}
+
 /* Compute ID ranges (RIDs) from RC that are directed to the ITS Group node */
 static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
 {
@@ -362,6 +424,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     if (vms->legacy_smmuv3_present) {
         rc_smmu_idmaps_len = populate_smmuv3_legacy_dev(smmuv3_devs);
+    } else {
+        rc_smmu_idmaps_len = populate_smmuv3_dev(smmuv3_devs);
     }
 
     num_smmus = smmuv3_devs->len;
-- 
2.34.1


