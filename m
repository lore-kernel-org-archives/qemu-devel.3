Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8318C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAncW-0008O7-Hb; Fri, 02 May 2025 06:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uAncT-0008Mn-As; Fri, 02 May 2025 06:27:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uAncQ-00024R-SQ; Fri, 02 May 2025 06:27:49 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZpnB53V1zz6L4xL;
 Fri,  2 May 2025 18:25:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id AEFFA1400D9;
 Fri,  2 May 2025 18:27:44 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 May 2025 12:27:37 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v2 2/6] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Date: Fri, 2 May 2025 11:27:03 +0100
Message-ID: <20250502102707.110516-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
 hw/arm/virt-acpi-build.c | 162 +++++++++++++++++++++++++++++++--------
 hw/arm/virt.c            |   1 +
 include/hw/arm/virt.h    |   1 +
 3 files changed, 131 insertions(+), 33 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3ac8f8e178..3ce70f8fa9 100644
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
@@ -266,6 +267,75 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
     return idmap_a->input_base - idmap_b->input_base;
 }
 
+struct SMMUv3Device {
+    int irq;
+    hwaddr base;
+    GArray *smmu_idmaps;
+    size_t offset;
+};
+typedef struct SMMUv3Device SMMUv3Device;
+
+static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
+{
+    SMMUv3Device *sdev_a = (SMMUv3Device *)a;
+    SMMUv3Device *sdev_b = (SMMUv3Device *)b;
+    AcpiIortIdMapping *map_a = &g_array_index(sdev_a->smmu_idmaps,
+                                              AcpiIortIdMapping, 0);
+    AcpiIortIdMapping *map_b = &g_array_index(sdev_b->smmu_idmaps,
+                                              AcpiIortIdMapping, 0);
+    return map_a->input_base - map_b->input_base;
+}
+
+static void
+get_smmuv3_legacy_dev(VirtMachineState *vms, GArray * smmuv3_devices)
+{
+    SMMUv3Device sdev;
+
+    sdev.smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    object_child_foreach_recursive(object_get_root(),
+                                   iort_host_bridges, sdev.smmu_idmaps);
+    sdev.base = vms->memmap[VIRT_SMMU].base;
+    sdev.irq = vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+    g_array_append_val(smmuv3_devices, sdev);
+}
+
+static int get_smmuv3_devices(Object *obj, void *opaque)
+{
+    PCIBus *bus;
+    SMMUv3Device sdev;
+    SysBusDevice *sbdev;
+    int min_bus, max_bus;
+    AcpiIortIdMapping idmap;
+    PlatformBusDevice *pbus;
+    GArray *sdev_blob = opaque;
+    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
+
+    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
+        return 0;
+    }
+
+    bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
+    if (!bus || pci_bus_bypass_iommu(bus)) {
+        return 0;
+    }
+
+    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+    sbdev = SYS_BUS_DEVICE(obj);
+    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
+    sdev.irq = platform_bus_get_irqn(pbus, sbdev, 0);
+    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
+    sdev.irq += ARM_SPI_BASE;
+
+    pci_bus_range(bus, &min_bus, &max_bus);
+    sdev.smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    idmap.input_base = min_bus << 8,
+    idmap.id_count = (max_bus - min_bus + 1) << 8,
+    g_array_append_val(sdev.smmu_idmaps, idmap);
+    g_array_append_val(sdev_blob, sdev);
+    return 0;
+}
+
 /*
  * Input Output Remapping Table (IORT)
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
@@ -274,11 +344,11 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
 static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
-    int i, nb_nodes, rc_mapping_count;
-    size_t node_size, smmu_offset = 0;
-    AcpiIortIdMapping *idmap;
+    int i, j, nb_nodes, rc_mapping_count;
+    size_t node_size;
+    int num_smmus = 0;
     uint32_t id = 0;
-    GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    GArray *smmuv3_devices = g_array_new(false, true, sizeof(SMMUv3Device));
     GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
 
     AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
@@ -286,28 +356,46 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     /* Table 2 The IORT */
     acpi_table_begin(&table, table_data);
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        AcpiIortIdMapping next_range = {0};
-
+    nb_nodes = 2; /* RC, ITS */
+    if (vms->legacy_smmuv3_present) {
+        get_smmuv3_legacy_dev(vms, smmuv3_devices);
+        /*
+         * There will be only one legacy SMMUv3 as it is a machine wide one.
+         * And since it covers all the PCIe RCs in the machine, may have
+         * multiple SMMUv3 idmaps. Sort it by input_base.
+         */
+        SMMUv3Device *s = &g_array_index(smmuv3_devices, SMMUv3Device, 0);
+        g_array_sort(s->smmu_idmaps, iort_idmap_compare);
+    } else {
         object_child_foreach_recursive(object_get_root(),
-                                       iort_host_bridges, smmu_idmaps);
-
-        /* Sort the smmu idmap by input_base */
-        g_array_sort(smmu_idmaps, iort_idmap_compare);
+                                       get_smmuv3_devices, smmuv3_devices);
+        /* Sort the smmuv3 devices(if any) by smmu idmap input_base */
+        g_array_sort(smmuv3_devices, smmuv3_dev_idmap_compare);
+    }
 
+    num_smmus = smmuv3_devices->len;
+    if (num_smmus) {
+        AcpiIortIdMapping next_range = {0};
+        int smmu_map_cnt = 0;
         /*
          * Split the whole RIDs by mapping from RC to SMMU,
          * build the ID mapping from RC to ITS directly.
          */
-        for (i = 0; i < smmu_idmaps->len; i++) {
-            idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
-
-            if (next_range.input_base < idmap->input_base) {
-                next_range.id_count = idmap->input_base - next_range.input_base;
-                g_array_append_val(its_idmaps, next_range);
+        for (i = 0; i < num_smmus; i++) {
+            AcpiIortIdMapping *idmap;
+            SMMUv3Device *s = &g_array_index(smmuv3_devices, SMMUv3Device, i);
+
+            for (j = 0; j < s->smmu_idmaps->len; j++) {
+                idmap = &g_array_index(s->smmu_idmaps, AcpiIortIdMapping, j);
+
+                if (next_range.input_base < idmap->input_base) {
+                    next_range.id_count = idmap->input_base -
+                                          next_range.input_base;
+                    g_array_append_val(its_idmaps, next_range);
+                }
+                next_range.input_base = idmap->input_base + idmap->id_count;
+                smmu_map_cnt++;
             }
-
-            next_range.input_base = idmap->input_base + idmap->id_count;
         }
 
         /* Append the last RC -> ITS ID mapping */
@@ -316,10 +404,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             g_array_append_val(its_idmaps, next_range);
         }
 
-        nb_nodes = 3; /* RC, ITS, SMMUv3 */
-        rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
+        nb_nodes += num_smmus;
+        rc_mapping_count = smmu_map_cnt + its_idmaps->len;
     } else {
-        nb_nodes = 2; /* RC, ITS */
         rc_mapping_count = 1;
     }
     /* Number of IORT Nodes */
@@ -341,10 +428,11 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     /* GIC ITS Identifier Array */
     build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+    for (i = 0; i < num_smmus; i++) {
+        SMMUv3Device *s = &g_array_index(smmuv3_devices, SMMUv3Device, i);
+        int irq = s->irq;
 
-        smmu_offset = table_data->len - table.table_offset;
+        s->offset = table_data->len - table.table_offset;
         /* Table 9 SMMUv3 Format */
         build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
         node_size =  SMMU_V3_ENTRY_SIZE + ID_MAPPING_ENTRY_SIZE;
@@ -355,7 +443,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Reference to ID Array */
         build_append_int_noprefix(table_data, SMMU_V3_ENTRY_SIZE, 4);
         /* Base address */
-        build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
+        build_append_int_noprefix(table_data, s->base, 8);
         /* Flags */
         build_append_int_noprefix(table_data, 1 /* COHACC Override */, 4);
         build_append_int_noprefix(table_data, 0, 4); /* Reserved */
@@ -404,15 +492,19 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0, 3); /* Reserved */
 
     /* Output Reference */
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
+    if (num_smmus) {
         AcpiIortIdMapping *range;
 
         /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
-        for (i = 0; i < smmu_idmaps->len; i++) {
-            range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
-            /* output IORT node is the smmuv3 node */
-            build_iort_id_mapping(table_data, range->input_base,
-                                  range->id_count, smmu_offset);
+        for (i = 0; i < num_smmus; i++) {
+            SMMUv3Device *s = &g_array_index(smmuv3_devices, SMMUv3Device, i);
+
+            for (j = 0; j < s->smmu_idmaps->len; j++) {
+                range = &g_array_index(s->smmu_idmaps, AcpiIortIdMapping, j);
+                /* output IORT node is the smmuv3 node */
+                build_iort_id_mapping(table_data, range->input_base,
+                                      range->id_count, s->offset);
+            }
         }
 
         /* bypassed RIDs connect to ITS group node directly: RC -> ITS */
@@ -428,8 +520,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     acpi_table_end(linker, &table);
-    g_array_free(smmu_idmaps, true);
     g_array_free(its_idmaps, true);
+    for (i = 0; i < num_smmus; i++) {
+        SMMUv3Device *s = &g_array_index(smmuv3_devices, SMMUv3Device, i);
+        g_array_free(s->smmu_idmaps, true);
+    }
+    g_array_free(smmuv3_devices, true);
 }
 
 /*
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3bae4e374f..dd355f4454 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1620,6 +1620,7 @@ static void create_pcie(VirtMachineState *vms)
             create_smmu(vms, vms->bus);
             qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
                                    0x0, vms->iommu_phandle, 0x0, 0x10000);
+            vms->legacy_smmuv3_present = true;
             break;
         default:
             g_assert_not_reached();
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c8e94e6aed..2e2867c906 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -180,6 +180,7 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    bool legacy_smmuv3_present;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.34.1


