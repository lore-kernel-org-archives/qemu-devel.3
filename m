Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FE1E7718F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 06:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR3ju-0003C4-4z; Fri, 27 Dec 2024 01:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tR3jl-0003AI-Tv
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 01:22:18 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tR3jj-0000Kw-LF
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 01:22:17 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxSOGVR25npNlaAA--.47250S3;
 Fri, 27 Dec 2024 14:22:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx_8eQR25nZ54KAA--.56394S5;
 Fri, 27 Dec 2024 14:22:13 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL v2 3/6] hw/loongarch/virt: Create fdt table on machine creation
 done notification
Date: Fri, 27 Dec 2024 14:22:05 +0800
Message-Id: <20241227062208.1232281-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241227062208.1232281-1-maobibo@loongson.cn>
References: <20241227062208.1232281-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_8eQR25nZ54KAA--.56394S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The same with ACPI table, fdt table is created on machine done
notification. Some objects like CPU objects can be created with cold-plug
method with command such as -smp x, -device la464-loongarch-cpu, so all
objects finish to create when machine is done.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 103 ++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 46 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 3a905cf71d..266f291509 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -615,12 +615,67 @@ static void virt_build_smbios(LoongArchVirtMachineState *lvms)
     }
 }
 
+static void virt_fdt_setup(LoongArchVirtMachineState *lvms)
+{
+    MachineState *machine = MACHINE(lvms);
+    uint32_t cpuintc_phandle, eiointc_phandle, pch_pic_phandle, pch_msi_phandle;
+    int i;
+
+    create_fdt(lvms);
+    fdt_add_cpu_nodes(lvms);
+    fdt_add_memory_nodes(machine);
+    fdt_add_fw_cfg_node(lvms);
+    fdt_add_flash_node(lvms);
+
+    /* Add cpu interrupt-controller */
+    fdt_add_cpuic_node(lvms, &cpuintc_phandle);
+    /* Add Extend I/O Interrupt Controller node */
+    fdt_add_eiointc_node(lvms, &cpuintc_phandle, &eiointc_phandle);
+    /* Add PCH PIC node */
+    fdt_add_pch_pic_node(lvms, &eiointc_phandle, &pch_pic_phandle);
+    /* Add PCH MSI node */
+    fdt_add_pch_msi_node(lvms, &eiointc_phandle, &pch_msi_phandle);
+    /* Add pcie node */
+    fdt_add_pcie_node(lvms, &pch_pic_phandle, &pch_msi_phandle);
+
+    /*
+     * Create uart fdt node in reverse order so that they appear
+     * in the finished device tree lowest address first
+     */
+    for (i = VIRT_UART_COUNT; i-- > 0;) {
+        hwaddr base = VIRT_UART_BASE + i * VIRT_UART_SIZE;
+        int irq = VIRT_UART_IRQ + i - VIRT_GSI_BASE;
+        fdt_add_uart_node(lvms, &pch_pic_phandle, base, irq, i == 0);
+    }
+
+    fdt_add_rtc_node(lvms, &pch_pic_phandle);
+    fdt_add_ged_reset(lvms);
+    platform_bus_add_all_fdt_nodes(machine->fdt, "/platic",
+                                   VIRT_PLATFORM_BUS_BASEADDRESS,
+                                   VIRT_PLATFORM_BUS_SIZE,
+                                   VIRT_PLATFORM_BUS_IRQ);
+
+    /*
+     * Since lowmem region starts from 0 and Linux kernel legacy start address
+     * at 2 MiB, FDT base address is located at 1 MiB to avoid NULL pointer
+     * access. FDT size limit with 1 MiB.
+     * Put the FDT into the memory map as a ROM image: this will ensure
+     * the FDT is copied again upon reset, even if addr points into RAM.
+     */
+    qemu_fdt_dumpdtb(machine->fdt, lvms->fdt_size);
+    rom_add_blob_fixed_as("fdt", machine->fdt, lvms->fdt_size, FDT_BASE,
+                          &address_space_memory);
+    qemu_register_reset_nosnapshotload(qemu_fdt_randomize_seeds,
+            rom_ptr_for_as(&address_space_memory, FDT_BASE, lvms->fdt_size));
+}
+
 static void virt_done(Notifier *notifier, void *data)
 {
     LoongArchVirtMachineState *lvms = container_of(notifier,
                                       LoongArchVirtMachineState, machine_done);
     virt_build_smbios(lvms);
     loongarch_acpi_setup(lvms);
+    virt_fdt_setup(lvms);
 }
 
 static void virt_powerdown_req(Notifier *notifier, void *opaque)
@@ -699,9 +754,7 @@ static DeviceState *create_platform_bus(DeviceState *pch_pic)
 }
 
 static void virt_devices_init(DeviceState *pch_pic,
-                                   LoongArchVirtMachineState *lvms,
-                                   uint32_t *pch_pic_phandle,
-                                   uint32_t *pch_msi_phandle)
+                                   LoongArchVirtMachineState *lvms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(lvms);
     DeviceState *gpex_dev;
@@ -747,9 +800,6 @@ static void virt_devices_init(DeviceState *pch_pic,
         gpex_set_irq_num(GPEX_HOST(gpex_dev), i, 16 + i);
     }
 
-    /* Add pcie node */
-    fdt_add_pcie_node(lvms, pch_pic_phandle, pch_msi_phandle);
-
     /*
      * Create uart fdt node in reverse order so that they appear
      * in the finished device tree lowest address first
@@ -760,7 +810,6 @@ static void virt_devices_init(DeviceState *pch_pic,
         serial_mm_init(get_system_memory(), base, 0,
                        qdev_get_gpio_in(pch_pic, irq),
                        115200, serial_hd(i), DEVICE_LITTLE_ENDIAN);
-        fdt_add_uart_node(lvms, pch_pic_phandle, base, irq, i == 0);
     }
 
     /* Network init */
@@ -774,8 +823,6 @@ static void virt_devices_init(DeviceState *pch_pic,
     sysbus_create_simple("ls7a_rtc", VIRT_RTC_REG_BASE,
                          qdev_get_gpio_in(pch_pic,
                          VIRT_RTC_IRQ - VIRT_GSI_BASE));
-    fdt_add_rtc_node(lvms, pch_pic_phandle);
-    fdt_add_ged_reset(lvms);
 
     /* acpi ged */
     lvms->acpi_ged = create_acpi_ged(pch_pic, lvms);
@@ -793,7 +840,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     CPULoongArchState *env;
     CPUState *cpu_state;
     int cpu, pin, i, start, num;
-    uint32_t cpuintc_phandle, eiointc_phandle, pch_pic_phandle, pch_msi_phandle;
 
     /*
      * Extended IRQ model.
@@ -850,9 +896,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     memory_region_add_subregion(&lvms->system_iocsr, MAIL_SEND_ADDR,
                    sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
 
-    /* Add cpu interrupt-controller */
-    fdt_add_cpuic_node(lvms, &cpuintc_phandle);
-
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
         cpu_state = qemu_get_cpu(cpu);
         cpudev = DEVICE(cpu_state);
@@ -891,9 +934,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
         }
     }
 
-    /* Add Extend I/O Interrupt Controller node */
-    fdt_add_eiointc_node(lvms, &cpuintc_phandle, &eiointc_phandle);
-
     pch_pic = qdev_new(TYPE_LOONGARCH_PIC);
     num = VIRT_PCH_PIC_IRQ_NUM;
     qdev_prop_set_uint32(pch_pic, "pch_pic_irq_num", num);
@@ -913,9 +953,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
         qdev_connect_gpio_out(DEVICE(d), i, qdev_get_gpio_in(extioi, i));
     }
 
-    /* Add PCH PIC node */
-    fdt_add_pch_pic_node(lvms, &eiointc_phandle, &pch_pic_phandle);
-
     pch_msi = qdev_new(TYPE_LOONGARCH_PCH_MSI);
     start   =  num;
     num = EXTIOI_IRQS - start;
@@ -930,10 +967,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
                               qdev_get_gpio_in(extioi, i + start));
     }
 
-    /* Add PCH MSI node */
-    fdt_add_pch_msi_node(lvms, &eiointc_phandle, &pch_msi_phandle);
-
-    virt_devices_init(pch_pic, lvms, &pch_pic_phandle, &pch_msi_phandle);
+    virt_devices_init(pch_pic, lvms);
 }
 
 static void virt_firmware_init(LoongArchVirtMachineState *lvms)
@@ -1151,8 +1185,6 @@ static void virt_init(MachineState *machine)
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
     }
 
-    create_fdt(lvms);
-
     /* Create IOCSR space */
     memory_region_init_io(&lvms->system_iocsr, OBJECT(machine), NULL,
                           machine, "iocsr", UINT64_MAX);
@@ -1171,8 +1203,6 @@ static void virt_init(MachineState *machine)
         lacpu = LOONGARCH_CPU(cpu);
         lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
     }
-    fdt_add_cpu_nodes(lvms);
-    fdt_add_memory_nodes(machine);
     fw_cfg_add_memory(machine);
 
     /* Node0 memory */
@@ -1224,34 +1254,15 @@ static void virt_init(MachineState *machine)
                         memmap_table,
                         sizeof(struct memmap_entry) * (memmap_entries));
     }
-    fdt_add_fw_cfg_node(lvms);
-    fdt_add_flash_node(lvms);
 
     /* Initialize the IO interrupt subsystem */
     virt_irq_init(lvms);
-    platform_bus_add_all_fdt_nodes(machine->fdt, "/platic",
-                                   VIRT_PLATFORM_BUS_BASEADDRESS,
-                                   VIRT_PLATFORM_BUS_SIZE,
-                                   VIRT_PLATFORM_BUS_IRQ);
     lvms->machine_done.notify = virt_done;
     qemu_add_machine_init_done_notifier(&lvms->machine_done);
      /* connect powerdown request */
     lvms->powerdown_notifier.notify = virt_powerdown_req;
     qemu_register_powerdown_notifier(&lvms->powerdown_notifier);
 
-    /*
-     * Since lowmem region starts from 0 and Linux kernel legacy start address
-     * at 2 MiB, FDT base address is located at 1 MiB to avoid NULL pointer
-     * access. FDT size limit with 1 MiB.
-     * Put the FDT into the memory map as a ROM image: this will ensure
-     * the FDT is copied again upon reset, even if addr points into RAM.
-     */
-    qemu_fdt_dumpdtb(machine->fdt, lvms->fdt_size);
-    rom_add_blob_fixed_as("fdt", machine->fdt, lvms->fdt_size, FDT_BASE,
-                          &address_space_memory);
-    qemu_register_reset_nosnapshotload(qemu_fdt_randomize_seeds,
-            rom_ptr_for_as(&address_space_memory, FDT_BASE, lvms->fdt_size));
-
     lvms->bootinfo.ram_size = ram_size;
     loongarch_load_kernel(machine, &lvms->bootinfo);
 }
-- 
2.43.5


