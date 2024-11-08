Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A233FD5C0C3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 12:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9OX4-000508-6N; Fri, 08 Nov 2024 07:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1t9OWy-0004yD-0t; Fri, 08 Nov 2024 07:56:05 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1t9OWv-0006fg-FK; Fri, 08 Nov 2024 07:56:03 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XlJl32gKPz6J76j;
 Fri,  8 Nov 2024 20:53:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 0A519140133;
 Fri,  8 Nov 2024 20:55:57 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 13:55:50 +0100
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3 Nested
 device
Date: Fri, 8 Nov 2024 12:52:39 +0000
Message-ID: <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
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
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Based on SMMUv3 as a parent device, add a user-creatable
smmuv3-nested device. Subsequent patches will add support to
specify a PCI bus for this device.

Currently only supported for "virt", so hook up the sybus mem & irq
for that  as well.

No FDT support is added for now.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3.c         | 34 ++++++++++++++++++++++++++++++++++
 hw/arm/virt.c           | 31 +++++++++++++++++++++++++++++--
 hw/core/sysbus-fdt.c    |  1 +
 include/hw/arm/smmuv3.h | 15 +++++++++++++++
 include/hw/arm/virt.h   |  6 ++++++
 5 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2101031a8f..0033eb8125 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2201,6 +2201,19 @@ static void smmu_realize(DeviceState *d, Error **errp)
     smmu_init_irq(s, dev);
 }
 
+static void smmu_nested_realize(DeviceState *d, Error **errp)
+{
+    SMMUv3NestedState *s_nested = ARM_SMMUV3_NESTED(d);
+    SMMUv3NestedClass *c = ARM_SMMUV3_NESTED_GET_CLASS(s_nested);
+    Error *local_err = NULL;
+
+    c->parent_realize(d, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
 static const VMStateDescription vmstate_smmuv3_queue = {
     .name = "smmuv3_queue",
     .version_id = 1,
@@ -2299,6 +2312,18 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, smmuv3_properties);
 }
 
+static void smmuv3_nested_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SMMUv3NestedClass *c = ARM_SMMUV3_NESTED_CLASS(klass);
+
+    dc->vmsd = &vmstate_smmuv3;
+    device_class_set_parent_realize(dc, smmu_nested_realize,
+                                    &c->parent_realize);
+    dc->user_creatable = true;
+    dc->hotpluggable = false;
+}
+
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
                                       IOMMUNotifierFlag old,
                                       IOMMUNotifierFlag new,
@@ -2337,6 +2362,14 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
     imrc->notify_flag_changed = smmuv3_notify_flag_changed;
 }
 
+static const TypeInfo smmuv3_nested_type_info = {
+    .name          = TYPE_ARM_SMMUV3_NESTED,
+    .parent        = TYPE_ARM_SMMUV3,
+    .instance_size = sizeof(SMMUv3NestedState),
+    .class_size    = sizeof(SMMUv3NestedClass),
+    .class_init    = smmuv3_nested_class_init,
+};
+
 static const TypeInfo smmuv3_type_info = {
     .name          = TYPE_ARM_SMMUV3,
     .parent        = TYPE_ARM_SMMU,
@@ -2355,6 +2388,7 @@ static const TypeInfo smmuv3_iommu_memory_region_info = {
 static void smmuv3_register_types(void)
 {
     type_register(&smmuv3_type_info);
+    type_register(&smmuv3_nested_type_info);
     type_register(&smmuv3_iommu_memory_region_info);
 }
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 780bcff77c..38075f9ab2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -181,6 +181,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
     [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
+    [VIRT_SMMU_NESTED] =        { 0x0b000000, 0x01000000 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
     [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
@@ -226,6 +227,7 @@ static const int a15irqmap[] = {
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
     [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
+    [VIRT_SMMU_NESTED] = 200,
 };
 
 static void create_randomness(MachineState *ms, const char *node)
@@ -2883,10 +2885,34 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+    MachineClass *mc = MACHINE_GET_CLASS(vms);
 
-    if (vms->platform_bus_dev) {
-        MachineClass *mc = MACHINE_GET_CLASS(vms);
+    /* For smmuv3-nested devices we need to set the mem & irq */
+    if (device_is_dynamic_sysbus(mc, dev) &&
+        object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3_NESTED)) {
+        hwaddr base = vms->memmap[VIRT_SMMU_NESTED].base;
+        int irq =  vms->irqmap[VIRT_SMMU_NESTED];
+
+        if (vms->smmu_nested_count >= MAX_SMMU_NESTED) {
+            error_setg(errp, "smmuv3-nested max count reached!");
+            return;
+        }
+
+        base += (vms->smmu_nested_count * SMMU_IO_LEN);
+        irq += (vms->smmu_nested_count * NUM_SMMU_IRQS);
 
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+        for (int i = 0; i < 4; i++) {
+            sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                               qdev_get_gpio_in(vms->gic, irq + i));
+        }
+        if (vms->iommu != VIRT_IOMMU_SMMUV3_NESTED) {
+            vms->iommu = VIRT_IOMMU_SMMUV3_NESTED;
+        }
+        vms->smmu_nested_count++;
+    }
+
+    if (vms->platform_bus_dev) {
         if (device_is_dynamic_sysbus(mc, dev)) {
             platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
                                      SYS_BUS_DEVICE(dev));
@@ -3067,6 +3093,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3_NESTED);
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index eebcd28f9a..0f0d0b3e58 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -489,6 +489,7 @@ static const BindingEntry bindings[] = {
 #ifdef CONFIG_LINUX
     TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node),
     TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
+    TYPE_BINDING("arm-smmuv3-nested", no_fdt_node),
     VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
 #endif
 #ifdef CONFIG_TPM
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d183a62766..87e628be7a 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -84,6 +84,21 @@ struct SMMUv3Class {
 #define TYPE_ARM_SMMUV3   "arm-smmuv3"
 OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
 
+#define TYPE_ARM_SMMUV3_NESTED   "arm-smmuv3-nested"
+OBJECT_DECLARE_TYPE(SMMUv3NestedState, SMMUv3NestedClass, ARM_SMMUV3_NESTED)
+
+struct SMMUv3NestedState {
+    SMMUv3State smmuv3_state;
+};
+
+struct SMMUv3NestedClass {
+    /*< private >*/
+    SMMUv3Class smmuv3_class;
+    /*< public >*/
+
+    DeviceRealize parent_realize;
+};
+
 #define STAGE1_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S1P)
 #define STAGE2_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S2P)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 46f48fe561..50e47a4ef3 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -50,6 +50,9 @@
 /* MMIO region size for SMMUv3 */
 #define SMMU_IO_LEN 0x20000
 
+/* Max supported nested SMMUv3 */
+#define MAX_SMMU_NESTED 128
+
 enum {
     VIRT_FLASH,
     VIRT_MEM,
@@ -62,6 +65,7 @@ enum {
     VIRT_GIC_ITS,
     VIRT_GIC_REDIST,
     VIRT_SMMU,
+    VIRT_SMMU_NESTED,
     VIRT_UART0,
     VIRT_MMIO,
     VIRT_RTC,
@@ -92,6 +96,7 @@ enum {
 typedef enum VirtIOMMUType {
     VIRT_IOMMU_NONE,
     VIRT_IOMMU_SMMUV3,
+    VIRT_IOMMU_SMMUV3_NESTED,
     VIRT_IOMMU_VIRTIO,
 } VirtIOMMUType;
 
@@ -155,6 +160,7 @@ struct VirtMachineState {
     bool mte;
     bool dtb_randomness;
     bool second_ns_uart_present;
+    int smmu_nested_count;
     OnOffAuto acpi;
     VirtGICType gic_version;
     VirtIOMMUType iommu;
-- 
2.34.1


