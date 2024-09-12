Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E932DEE57F8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 13:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sojZx-0003ut-2g; Thu, 12 Sep 2024 09:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sojZj-0003AA-QP
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:09:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sojZg-0004qA-Pj
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:09:31 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxC+oE6OJm7uQFAA--.13752S3;
 Thu, 12 Sep 2024 21:09:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front2 (Coremail) with SMTP id qciowMDxl8Xr5+JmR8MFAA--.9219S7;
 Thu, 12 Sep 2024 21:09:22 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 5/7] hw/loongarch: virt: support up to 4 serial ports
Date: Thu, 12 Sep 2024 20:51:30 +0800
Message-Id: <20240912125132.268802-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240912125132.268802-1-gaosong@loongson.cn>
References: <20240912125132.268802-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowMDxl8Xr5+JmR8MFAA--.9219S7
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

In order to support additional channels of communication using
`-serial`, add several serial ports, up to the standard 4 generally
supported by the 8250 driver.

Fixed: https://lore.kernel.org/all/20240907143439.2792924-1-Jason@zx2c4.com/

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Tested-by: Bibo Mao <maobibo@loongson.cn>
[gaosong: ACPI uart need't reverse order]
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240907143439.2792924-1-Jason@zx2c4.com>
---
 hw/loongarch/acpi-build.c  | 23 +++++++++++++++--------
 hw/loongarch/virt.c        | 27 +++++++++++++++++----------
 include/hw/pci-host/ls7a.h |  9 +++++----
 3 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 2638f87434..04107c84ba 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -31,6 +31,7 @@
 
 #include "hw/acpi/generic_event_device.h"
 #include "hw/pci-host/gpex.h"
+#include "sysemu/sysemu.h"
 #include "sysemu/tpm.h"
 #include "hw/platform-bus.h"
 #include "hw/acpi/aml-build.h"
@@ -252,23 +253,27 @@ struct AcpiBuildState {
     MemoryRegion *linker_mr;
 } AcpiBuildState;
 
-static void build_uart_device_aml(Aml *table)
+static void build_uart_device_aml(Aml *table, int index)
 {
     Aml *dev;
     Aml *crs;
     Aml *pkg0, *pkg1, *pkg2;
-    uint32_t uart_irq = VIRT_UART_IRQ;
-
-    Aml *scope = aml_scope("_SB");
-    dev = aml_device("COMA");
+    Aml *scope;
+    uint32_t uart_irq;
+    uint64_t base;
+
+    uart_irq = VIRT_UART_IRQ + index;
+    base = VIRT_UART_BASE + index * VIRT_UART_SIZE;
+    scope = aml_scope("_SB");
+    dev = aml_device("COM%d", index);
     aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
-    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+    aml_append(dev, aml_name_decl("_UID", aml_int(index)));
     aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
     crs = aml_resource_template();
     aml_append(crs,
         aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
                          AML_NON_CACHEABLE, AML_READ_WRITE,
-                         0, VIRT_UART_BASE, VIRT_UART_BASE + VIRT_UART_SIZE - 1,
+                         0, base, base + VIRT_UART_SIZE - 1,
                          0, VIRT_UART_SIZE));
     aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
                                   AML_SHARED, &uart_irq, 1));
@@ -401,6 +406,7 @@ static void acpi_dsdt_add_tpm(Aml *scope, LoongArchVirtMachineState *vms)
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 {
+    int i;
     Aml *dsdt, *scope, *pkg;
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
     AcpiTable table = { .sig = "DSDT", .rev = 1, .oem_id = lvms->oem_id,
@@ -408,7 +414,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 
     acpi_table_begin(&table, table_data);
     dsdt = init_aml_allocator();
-    build_uart_device_aml(dsdt);
+    for (i = 0; i < VIRT_UART_COUNT; i++)
+        build_uart_device_aml(dsdt, i);
     build_pci_device_aml(dsdt, lvms);
     build_la_ged_aml(dsdt, machine);
     build_flash_aml(dsdt, lvms);
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 29040422aa..76dd29a391 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -280,10 +280,10 @@ static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
 }
 
 static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
-                              uint32_t *pch_pic_phandle)
+                              uint32_t *pch_pic_phandle, hwaddr base,
+                              int irq, bool chosen)
 {
     char *nodename;
-    hwaddr base = VIRT_UART_BASE;
     hwaddr size = VIRT_UART_SIZE;
     MachineState *ms = MACHINE(lvms);
 
@@ -292,9 +292,9 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
     qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "ns16550a");
     qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0x0, base, 0x0, size);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "clock-frequency", 100000000);
-    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
-    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                           VIRT_UART_IRQ - VIRT_GSI_BASE, 0x4);
+    if (chosen)
+        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0x4);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
                           *pch_pic_phandle);
     g_free(nodename);
@@ -706,11 +706,18 @@ static void virt_devices_init(DeviceState *pch_pic,
     /* Add pcie node */
     fdt_add_pcie_node(lvms, pch_pic_phandle, pch_msi_phandle);
 
-    serial_mm_init(get_system_memory(), VIRT_UART_BASE, 0,
-                   qdev_get_gpio_in(pch_pic,
-                                    VIRT_UART_IRQ - VIRT_GSI_BASE),
-                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
-    fdt_add_uart_node(lvms, pch_pic_phandle);
+    /*
+     * Create uart fdt node in reverse order so that they appear
+     * in the finished device tree lowest address first
+     */
+    for (i = VIRT_UART_COUNT; i --> 0;) {
+        hwaddr base = VIRT_UART_BASE + i * VIRT_UART_SIZE;
+        int irq = VIRT_UART_IRQ + i - VIRT_GSI_BASE;
+        serial_mm_init(get_system_memory(), base, 0,
+                       qdev_get_gpio_in(pch_pic, irq),
+                       115200, serial_hd(i), DEVICE_LITTLE_ENDIAN);
+        fdt_add_uart_node(lvms, pch_pic_phandle, base, irq, i == 0);
+    }
 
     /* Network init */
     pci_init_nic_devices(pci_bus, mc->default_nic);
diff --git a/include/hw/pci-host/ls7a.h b/include/hw/pci-host/ls7a.h
index cd7c9ec7bc..79d4ea8501 100644
--- a/include/hw/pci-host/ls7a.h
+++ b/include/hw/pci-host/ls7a.h
@@ -36,17 +36,18 @@
 #define VIRT_PCH_PIC_IRQ_NUM     32
 #define VIRT_GSI_BASE            64
 #define VIRT_DEVICE_IRQS         16
+#define VIRT_UART_COUNT          4
 #define VIRT_UART_IRQ            (VIRT_GSI_BASE + 2)
 #define VIRT_UART_BASE           0x1fe001e0
-#define VIRT_UART_SIZE           0X100
-#define VIRT_RTC_IRQ             (VIRT_GSI_BASE + 3)
+#define VIRT_UART_SIZE           0x100
+#define VIRT_RTC_IRQ             (VIRT_GSI_BASE + 6)
 #define VIRT_MISC_REG_BASE       (VIRT_PCH_REG_BASE + 0x00080000)
 #define VIRT_RTC_REG_BASE        (VIRT_MISC_REG_BASE + 0x00050100)
 #define VIRT_RTC_LEN             0x100
-#define VIRT_SCI_IRQ             (VIRT_GSI_BASE + 4)
+#define VIRT_SCI_IRQ             (VIRT_GSI_BASE + 7)
 
 #define VIRT_PLATFORM_BUS_BASEADDRESS   0x16000000
 #define VIRT_PLATFORM_BUS_SIZE          0x2000000
 #define VIRT_PLATFORM_BUS_NUM_IRQS      2
-#define VIRT_PLATFORM_BUS_IRQ           (VIRT_GSI_BASE + 5)
+#define VIRT_PLATFORM_BUS_IRQ           (VIRT_GSI_BASE + 8)
 #endif
-- 
2.34.1


