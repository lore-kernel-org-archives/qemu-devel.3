Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A377CDC19C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 13:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd6sl-0004eR-16; Tue, 06 Jan 2026 08:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>)
 id 1vd6si-0004YA-D5; Tue, 06 Jan 2026 08:13:52 -0500
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>)
 id 1vd6sd-0005kR-Dn; Tue, 06 Jan 2026 08:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1k
 3I1kaf73evLsvV553tPJTFI3ze8pdf7uUpBFlGrro=; b=ATuq181AzH5HGB65B/
 WUwHRwGiazOW+DVnN4R4Sm1x4ghVMu6XM39crTNiamwiLZLaCuTJdzeTvCQIWVdR
 qsI6SBleJfCas51xTGmnG4yBZ8SvsCBNQh4filwCCh+bUv+nEJnfCgO3I5iCvezg
 JW2iu0zbUFZ6krWprmnA7qcPo=
Received: from alano.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wDnT4lVCl1p0+SgFA--.17566S4; 
 Tue, 06 Jan 2026 21:13:18 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: cminyard@mvista.com, peter.maydell@linaro.org, philmd@linaro.org,
 ani@anisinha.ca, pbonzini@redhat.com, shannon.zhaosl@gmail.com,
 Alano Song <AlanoSong@163.com>
Subject: [PATCH 2/2] hw/arm/virt: Add DesignWare I2C controller
Date: Tue,  6 Jan 2026 21:12:53 +0800
Message-ID: <20260106131253.16192-3-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106131253.16192-1-AlanoSong@163.com>
References: <20260106131253.16192-1-AlanoSong@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnT4lVCl1p0+SgFA--.17566S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF4rJFyfGr4fAw18uFyrtFb_yoW7Zw1fpF
 WqyFZ0grW5AF13X39IgF4fWF15Jw1kK3WY9ws7CrWxCF1qgw1UJrWUta45Gry5urWDJ3WY
 gFZIqFy8Kr1vq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piY9aDUUUUU=
X-Originating-IP: [240e:36a:147b:2000:594:6424:e3:c901]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC9Q9PY2ldCm+oZAAA3L
Received-SPF: pass client-ip=220.197.31.3; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Alano Song <AlanoSong@163.com>

Add DesignWare I2C controller onto virt board,
and also an at24c eeprom for r/w operation.

Add these two devices into arm virt acpi table.

Confirmed with i2c-tools under v6.18 linux driver.

Signed-off-by: Alano Song <AlanoSong@163.com>
---
 hw/arm/Kconfig           |  1 +
 hw/arm/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
 hw/arm/virt.c            | 38 +++++++++++++++++++++++++++++++++++++-
 include/hw/arm/virt.h    |  1 +
 4 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 97d747e206..f23c063474 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -36,6 +36,7 @@ config ARM_VIRT
     select VIRTIO_MEM_SUPPORTED
     select ACPI_CXL
     select ACPI_HMAT
+    select DW_I2C
 
 config CUBIEBOARD
     bool
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 03b4342574..3d06356169 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -100,6 +100,34 @@ static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
     aml_append(scope, dev);
 }
 
+static void acpi_dsdt_add_i2c(Aml *scope, const MemMapEntry *i2c_memmap,
+                               uint32_t i2c_irq)
+{
+    Aml *i2c_dev, *eprm_dev, *crs;
+
+    i2c_dev = aml_device("I2C0");
+    aml_append(i2c_dev, aml_name_decl("_HID", aml_string("INT3433")));
+    aml_append(i2c_dev, aml_name_decl("_UID", aml_int(0)));
+
+    crs = aml_resource_template();
+    aml_append(crs, aml_memory32_fixed(i2c_memmap->base,
+                                       i2c_memmap->size, AML_READ_WRITE));
+    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+                                  AML_EXCLUSIVE, &i2c_irq, 1));
+    aml_append(i2c_dev, aml_name_decl("_CRS", crs));
+
+    eprm_dev = aml_device("EPRM");
+    aml_append(eprm_dev, aml_name_decl("_HID", aml_string("INT3499")));
+    aml_append(eprm_dev, aml_name_decl("_UID", aml_int(0)));
+
+    crs = aml_resource_template();
+    aml_append(crs, aml_i2c_serial_bus_device(0x50, "^"));
+    aml_append(eprm_dev, aml_name_decl("_CRS", crs));
+
+    aml_append(i2c_dev, eprm_dev);
+    aml_append(scope, i2c_dev);
+}
+
 static void acpi_dsdt_add_flash(Aml *scope, const MemMapEntry *flash_memmap)
 {
     Aml *dev, *crs;
@@ -1037,6 +1065,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1],
                            (irqmap[VIRT_UART1] + ARM_SPI_BASE), 1);
     }
+
+    acpi_dsdt_add_i2c(scope, &memmap[VIRT_I2C],
+                      irqmap[VIRT_I2C] + ARM_SPI_BASE);
+
     if (vmc->acpi_expose_flash) {
         acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index fd0e28f030..8fd37126d1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -38,6 +38,8 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
 #include "hw/arm/virt.h"
+#include "hw/i2c/dw_i2c.h"
+#include "hw/nvram/eeprom_at24c.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/display/ramfb.h"
@@ -193,7 +195,8 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
     [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
     [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
-    [VIRT_ACPI_PCIHP] =         { 0x090c0000, ACPI_PCIHP_SIZE },
+    [VIRT_I2C] =                { 0x090c0000, 0x00001000 },
+    [VIRT_ACPI_PCIHP] =         { 0x090d0000, ACPI_PCIHP_SIZE },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -245,6 +248,7 @@ static const int a15irqmap[] = {
     [VIRT_GPIO] = 7,
     [VIRT_UART1] = 8,
     [VIRT_ACPI_GED] = 9,
+    [VIRT_I2C] = 10,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
     [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
@@ -1016,6 +1020,36 @@ static void create_uart(const VirtMachineState *vms, int uart,
     g_free(nodename);
 }
 
+static void create_i2c(const VirtMachineState *vms, int i2c)
+{
+    char *nodename = NULL;
+    hwaddr base = vms->memmap[i2c].base;
+    hwaddr size = vms->memmap[i2c].size;
+    int irq = vms->irqmap[i2c];
+    MachineState *ms = MACHINE(vms);
+    DeviceState *dev = sysbus_create_simple(TYPE_DW_I2C, base,
+                                            qdev_get_gpio_in(vms->gic, irq));
+    DWI2CState *s = DW_I2C(dev);
+
+    nodename = g_strdup_printf("/dw-i2c@%" PRIx64, base);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
+                            "snps,designware-i2c");
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
+                                 2, base, 2, size);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
+                           GIC_FDT_IRQ_TYPE_SPI, irq,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+
+    if (s && s->bus) {
+        at24c_eeprom_init(s->bus, 0x50, 256);
+    } else {
+        fprintf(stderr, "Warning: DW I2C created but bus not available\n");
+    }
+
+    g_free(nodename);
+}
+
 static void create_rtc(const VirtMachineState *vms)
 {
     char *nodename;
@@ -2493,6 +2527,8 @@ static void machvirt_init(MachineState *machine)
         create_uart(vms, VIRT_UART1, secure_sysmem, serial_hd(1), true);
     }
 
+    create_i2c(vms, VIRT_I2C);
+
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem, secure_tag_sysmem);
     }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 8694aaa4e2..911beea7fd 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -75,6 +75,7 @@ enum {
     VIRT_PLATFORM_BUS,
     VIRT_GPIO,
     VIRT_UART1,
+    VIRT_I2C,
     VIRT_SECURE_MEM,
     VIRT_SECURE_GPIO,
     VIRT_PCDIMM_ACPI,
-- 
2.43.0


