Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA1AC48295
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 14:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWzrV-0006hj-RM; Mon, 05 Feb 2024 09:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rWzrS-0006fs-Mw
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:22:14 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rWzrQ-0003Me-F3
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:22:14 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT7lb2S0lz6JB87;
 Mon,  5 Feb 2024 22:18:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 885831404F5;
 Mon,  5 Feb 2024 22:22:09 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:22:09 +0000
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, <linuxarm@huawei.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Peter Maydell
 <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 05/11] arm/virt: Wire up GPIO error source for ACPI / GHES
Date: Mon, 5 Feb 2024 14:19:34 +0000
Message-ID: <20240205141940.31111-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
References: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Includes creation of a GED - Generic Event Device

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/boards.h      |  1 +
 hw/arm/virt-acpi-build.c | 29 +++++++++++++++++++++++++----
 hw/arm/virt.c            | 12 +++++++++++-
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index bcfde8a84d..a9badd9fd2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -301,6 +301,7 @@ struct MachineClass {
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
     ram_addr_t (*fixup_ram_size)(ram_addr_t size);
+    void (*set_error)(void);
 };
 
 /**
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index cdc0bca729..297fa5f8b2 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -64,6 +64,7 @@
 
 #define ARM_SPI_BASE 32
 
+#define ACPI_GENERIC_EVENT_DEVICE "GEDD"
 #define ACPI_BUILD_TABLE_SIZE             0x20000
 
 static void acpi_dsdt_add_cpus(Aml *scope, VirtMachineState *vms)
@@ -242,9 +243,14 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
 
     Aml *aei = aml_resource_template();
     /* Pin 3 for power button */
-    const uint32_t pin_list[1] = {3};
+    uint32_t pin = 3;
     aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
-                                 AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
+                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
+                                 "GPO0", NULL, 0));
+    pin = 6;
+    /* Pin 8 for generic error */
+    aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
+                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
                                  "GPO0", NULL, 0));
     aml_append(dev, aml_name_decl("_AEI", aei));
 
@@ -253,6 +259,11 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
     aml_append(method, aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
                                   aml_int(0x80)));
     aml_append(dev, method);
+    method = aml_method("_E06", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_notify(aml_name(ACPI_GENERIC_EVENT_DEVICE),
+                                  aml_int(0x80)));
+    aml_append(dev, method);
+
     aml_append(scope, dev);
 }
 
@@ -885,6 +896,15 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
     build_fadt(table_data, linker, &fadt, vms->oem_id, vms->oem_table_id);
 }
 
+static void acpi_dsdt_add_generic_event_device(Aml *scope)
+{
+    Aml *dev = aml_device(ACPI_GENERIC_EVENT_DEVICE);
+    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
+    aml_append(scope, dev);
+}
+
 /* DSDT */
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
@@ -926,9 +946,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                       irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY,
                       memmap[VIRT_ACPI_GED].base);
     } else {
-        acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
-                           (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
     }
+    acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
+                       (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
 
     if (vms->acpi_dev) {
         uint32_t event = object_property_get_uint(OBJECT(vms->acpi_dev),
@@ -942,6 +962,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     acpi_dsdt_add_power_button(scope);
+    acpi_dsdt_add_generic_event_device(scope);
 #ifdef CONFIG_TPM
     acpi_dsdt_add_tpm(scope, vms);
 #endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c1c8a514d7..c87dc5acce 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -914,6 +914,13 @@ static void create_rtc(const VirtMachineState *vms)
 }
 
 static DeviceState *gpio_key_dev;
+
+static DeviceState *gpio_error_dev;
+static void virt_set_error(void)
+{
+    qemu_set_irq(qdev_get_gpio_in(gpio_error_dev, 0), 1);
+}
+
 static void virt_powerdown_req(Notifier *n, void *opaque)
 {
     VirtMachineState *s = container_of(n, VirtMachineState, powerdown_notifier);
@@ -931,6 +938,8 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
 {
     gpio_key_dev = sysbus_create_simple("gpio-key", -1,
                                         qdev_get_gpio_in(pl061_dev, 3));
+    gpio_error_dev = sysbus_create_simple("gpio-key", -1,
+                                          qdev_get_gpio_in(pl061_dev, 6));
 
     qemu_fdt_add_subnode(fdt, "/gpio-keys");
     qemu_fdt_setprop_string(fdt, "/gpio-keys", "compatible", "gpio-keys");
@@ -2606,8 +2615,8 @@ static void machvirt_init(MachineState *machine)
     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
     } else {
-        create_gpio_devices(vms, VIRT_GPIO, sysmem);
     }
+    create_gpio_devices(vms, VIRT_GPIO, sysmem);
 
     if (vms->secure && !vmc->no_secure_gpio) {
         create_gpio_devices(vms, VIRT_SECURE_GPIO, secure_sysmem);
@@ -3337,6 +3346,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "mach-virt.ram";
     mc->default_nic = "virtio-net-pci";
 
+    mc->set_error = virt_set_error;
     object_class_property_add(oc, "acpi", "OnOffAuto",
         virt_get_acpi, virt_set_acpi,
         NULL, NULL);
-- 
2.39.2


