Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9231BC369B9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bOy-0003bi-G8; Tue, 15 Apr 2025 04:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1u4bOw-0003WX-HU; Tue, 15 Apr 2025 04:12:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1u4bOt-0001py-57; Tue, 15 Apr 2025 04:12:14 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcGxR5jh7z6LD3q;
 Tue, 15 Apr 2025 16:08:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 07E801402C3;
 Tue, 15 Apr 2025 16:12:09 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Apr 2025 10:12:01 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH 2/5] hw/arm/virt-acpi-build: Update IORT for multiple smmuv3
 devices
Date: Tue, 15 Apr 2025 09:11:01 +0100
Message-ID: <20250415081104.71708-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com>
References: <20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

With the soon to be introduced user-creatable SMMUv3 devices for
virt, it is possible to have multiple SMMUv3 devices associated
with different PCIe root complexes.

Update IORT nodes accordingly.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/virt-acpi-build.c | 119 +++++++++++++++++++++++++++++++++++----
 include/hw/arm/virt.h    |   1 +
 2 files changed, 108 insertions(+), 12 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3ac8f8e178..d1e083ee31 100644
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
@@ -266,6 +267,60 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
     return idmap_a->input_base - idmap_b->input_base;
 }
 
+struct SMMUv3Device {
+    int irq;
+    hwaddr base;
+    AcpiIortIdMapping smmu_idmap;
+};
+typedef struct SMMUv3Device SMMUv3Device;
+
+static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
+{
+    SMMUv3Device *sdev_a = (SMMUv3Device *)a;
+    SMMUv3Device *sdev_b = (SMMUv3Device *)b;
+
+    return sdev_a->smmu_idmap.input_base - sdev_b->smmu_idmap.input_base;
+}
+
+static int get_smmuv3_device(Object *obj, void *opaque)
+{
+    GArray *sdev_blob = opaque;
+    int min_bus, max_bus;
+    VirtMachineState *vms;
+    PlatformBusDevice *pbus;
+    SysBusDevice *sbdev;
+    SMMUv3Device sdev;
+    hwaddr base;
+    int irq;
+    PCIBus *bus;
+
+    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3_DEV)) {
+        return 0;
+    }
+
+    bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
+    if (!bus || pci_bus_bypass_iommu(bus)) {
+        return 0;
+    }
+
+    vms = VIRT_MACHINE(qdev_get_machine());
+    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+    sbdev = SYS_BUS_DEVICE(obj);
+    base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    irq = platform_bus_get_irqn(pbus, sbdev, 0);
+
+    base += vms->memmap[VIRT_PLATFORM_BUS].base;
+    irq += vms->irqmap[VIRT_PLATFORM_BUS];
+
+    pci_bus_range(bus, &min_bus, &max_bus);
+    sdev.smmu_idmap.input_base = min_bus << 8;
+    sdev.smmu_idmap.id_count = (max_bus - min_bus + 1) << 8;
+    sdev.base = base;
+    sdev.irq = irq + ARM_SPI_BASE;
+    g_array_append_val(sdev_blob, sdev);
+    return 0;
+}
+
 /*
  * Input Output Remapping Table (IORT)
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
@@ -275,25 +330,42 @@ static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     int i, nb_nodes, rc_mapping_count;
-    size_t node_size, smmu_offset = 0;
+    size_t node_size, *smmu_offset = NULL;
     AcpiIortIdMapping *idmap;
+    int num_smmus = 0;
     uint32_t id = 0;
     GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
     GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    GArray *smmuv3_devices = g_array_new(false, true, sizeof(SMMUv3Device));
 
     AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
     /* Table 2 The IORT */
     acpi_table_begin(&table, table_data);
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        AcpiIortIdMapping next_range = {0};
-
+    nb_nodes = 2; /* RC, ITS */
+    if (vms->iommu == VIRT_IOMMU_SMMUV3_DEV) {
+        object_child_foreach_recursive(object_get_root(),
+                                       get_smmuv3_device, smmuv3_devices);
+         /* Sort the smmuv3-devices by smmu idmap input_base */
+        g_array_sort(smmuv3_devices, smmuv3_dev_idmap_compare);
+        /*  Fill smmu idmap from sorted smmuv3 devices array */
+        for (i = 0; i < smmuv3_devices->len; i++) {
+            SMMUv3Device *s = &g_array_index(smmuv3_devices, SMMUv3Device, i);
+            g_array_append_val(smmu_idmaps, s->smmu_idmap);
+        }
+        num_smmus = smmuv3_devices->len;
+    } else if (vms->iommu == VIRT_IOMMU_SMMUV3) {
         object_child_foreach_recursive(object_get_root(),
                                        iort_host_bridges, smmu_idmaps);
 
         /* Sort the smmu idmap by input_base */
         g_array_sort(smmu_idmaps, iort_idmap_compare);
+        num_smmus = 1;
+    }
+
+    if (num_smmus) {
+        AcpiIortIdMapping next_range = {0};
 
         /*
          * Split the whole RIDs by mapping from RC to SMMU,
@@ -316,10 +388,10 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             g_array_append_val(its_idmaps, next_range);
         }
 
-        nb_nodes = 3; /* RC, ITS, SMMUv3 */
+        smmu_offset = g_new0(size_t, num_smmus);
+        nb_nodes += num_smmus;
         rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
     } else {
-        nb_nodes = 2; /* RC, ITS */
         rc_mapping_count = 1;
     }
     /* Number of IORT Nodes */
@@ -341,10 +413,20 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     /* GIC ITS Identifier Array */
     build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+    for (i = 0; i < num_smmus; i++) {
+        hwaddr base;
+        int irq;
+
+        if (vms->iommu == VIRT_IOMMU_SMMUV3_DEV) {
+            SMMUv3Device *s = &g_array_index(smmuv3_devices, SMMUv3Device, i);
+            base = s->base;
+            irq = s->irq;
+        } else {
+            base = vms->memmap[VIRT_SMMU].base;
+            irq = vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+        }
 
-        smmu_offset = table_data->len - table.table_offset;
+        smmu_offset[i] = table_data->len - table.table_offset;
         /* Table 9 SMMUv3 Format */
         build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
         node_size =  SMMU_V3_ENTRY_SIZE + ID_MAPPING_ENTRY_SIZE;
@@ -355,7 +437,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Reference to ID Array */
         build_append_int_noprefix(table_data, SMMU_V3_ENTRY_SIZE, 4);
         /* Base address */
-        build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
+        build_append_int_noprefix(table_data, base, 8);
         /* Flags */
         build_append_int_noprefix(table_data, 1 /* COHACC Override */, 4);
         build_append_int_noprefix(table_data, 0, 4); /* Reserved */
@@ -404,15 +486,26 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0, 3); /* Reserved */
 
     /* Output Reference */
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
+    if (num_smmus) {
         AcpiIortIdMapping *range;
 
         /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
         for (i = 0; i < smmu_idmaps->len; i++) {
+            size_t offset;
+            if (vms->iommu == VIRT_IOMMU_SMMUV3_DEV) {
+                offset = smmu_offset[i];
+            } else {
+                /*
+                 * For legacy VIRT_IOMMU_SMMUV3 case, one machine wide
+                 * smmuv3 may have multiple smmu_idmaps.
+                 */
+                offset = smmu_offset[0];
+            }
+
             range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
             /* output IORT node is the smmuv3 node */
             build_iort_id_mapping(table_data, range->input_base,
-                                  range->id_count, smmu_offset);
+                                  range->id_count, offset);
         }
 
         /* bypassed RIDs connect to ITS group node directly: RC -> ITS */
@@ -430,6 +523,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_table_end(linker, &table);
     g_array_free(smmu_idmaps, true);
     g_array_free(its_idmaps, true);
+    g_free(smmu_offset);
+    g_array_free(smmuv3_devices, true);
 }
 
 /*
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c8e94e6aed..12395c7594 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -92,6 +92,7 @@ enum {
 typedef enum VirtIOMMUType {
     VIRT_IOMMU_NONE,
     VIRT_IOMMU_SMMUV3,
+    VIRT_IOMMU_SMMUV3_DEV,
     VIRT_IOMMU_VIRTIO,
 } VirtIOMMUType;
 
-- 
2.34.1


