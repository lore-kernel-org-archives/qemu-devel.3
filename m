Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C2CC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpi0N-0000rz-9F; Wed, 05 Mar 2025 01:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tpi0K-0000rg-Vt
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:13:16 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tpi0I-0004IF-Rk
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:13:16 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxWOFu68dn19+KAA--.40844S3;
 Wed, 05 Mar 2025 14:13:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBx3MRi68dnfRQ3AA--.5679S15;
 Wed, 05 Mar 2025 14:13:01 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 13/15] hw/loongarch/virt: Update the ACPI table for hotplug cpu
Date: Wed,  5 Mar 2025 14:12:48 +0800
Message-Id: <20250305061250.1908444-14-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250305061250.1908444-1-maobibo@loongson.cn>
References: <20250305061250.1908444-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3MRi68dnfRQ3AA--.5679S15
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

On LoongArch virt machine, ACPI GED hardware is used for CPU hotplug
handler, here CPU hotplug support feature is added based on GED handler,
also CPU scan and reject method is added about CPU device in DSDT table.

Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/Kconfig           |  1 +
 hw/loongarch/virt-acpi-build.c | 35 +++++++++++++++++++++++++++++++---
 hw/loongarch/virt.c            | 10 ++++++++++
 include/hw/loongarch/virt.h    |  1 +
 4 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index fe1c6feac1..bb2838b7b5 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -17,6 +17,7 @@ config LOONGARCH_VIRT
     select LOONGARCH_EXTIOI
     select LS7A_RTC
     select SMBIOS
+    select ACPI_CPU_HOTPLUG
     select ACPI_PCI
     select ACPI_HW_REDUCED
     select FW_CFG_DMA
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 9ca88d63ae..fced6c445a 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -47,6 +47,22 @@
 #define ACPI_BUILD_DPRINTF(fmt, ...)
 #endif
 
+static void virt_madt_cpu_entry(int uid,
+                                const CPUArchIdList *apic_ids,
+                                GArray *entry, bool force_enabled)
+{
+    uint32_t flags, apic_id = apic_ids->cpus[uid].arch_id;
+
+    flags = apic_ids->cpus[uid].cpu || force_enabled ? 1 /* Enabled */ : 0;
+
+    /* Rev 1.0b, Table 5-13 Processor Local APIC Structure */
+    build_append_int_noprefix(entry, 0, 1);       /* Type */
+    build_append_int_noprefix(entry, 8, 1);       /* Length */
+    build_append_int_noprefix(entry, uid, 1);     /* ACPI Processor ID */
+    build_append_int_noprefix(entry, apic_id, 1); /* APIC ID */
+    build_append_int_noprefix(entry, flags, 4); /* Flags */
+}
+
 /* build FADT */
 static void init_common_fadt_data(AcpiFadtData *data)
 {
@@ -112,7 +128,7 @@ build_madt(GArray *table_data, BIOSLinker *linker,
     MachineState *ms = MACHINE(lvms);
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
-    int i, arch_id;
+    int i, arch_id, flags;
     AcpiTable table = { .sig = "APIC", .rev = 1, .oem_id = lvms->oem_id,
                         .oem_table_id = lvms->oem_table_id };
 
@@ -125,13 +141,13 @@ build_madt(GArray *table_data, BIOSLinker *linker,
     for (i = 0; i < arch_ids->len; i++) {
         /* Processor Core Interrupt Controller Structure */
         arch_id = arch_ids->cpus[i].arch_id;
-
+        flags   = arch_ids->cpus[i].cpu ? 1 : 0;
         build_append_int_noprefix(table_data, 17, 1);    /* Type */
         build_append_int_noprefix(table_data, 15, 1);    /* Length */
         build_append_int_noprefix(table_data, 1, 1);     /* Version */
         build_append_int_noprefix(table_data, i, 4);     /* ACPI Processor ID */
         build_append_int_noprefix(table_data, arch_id, 4); /* Core ID */
-        build_append_int_noprefix(table_data, 1, 4);     /* Flags */
+        build_append_int_noprefix(table_data, flags, 4); /* Flags */
     }
 
     /* Extend I/O Interrupt Controller Structure */
@@ -338,6 +354,7 @@ build_la_ged_aml(Aml *dsdt, MachineState *machine)
 {
     uint32_t event;
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
+    CPUHotplugFeatures opts;
 
     build_ged_aml(dsdt, "\\_SB."GED_DEVICE,
                   HOTPLUG_HANDLER(lvms->acpi_ged),
@@ -350,6 +367,18 @@ build_la_ged_aml(Aml *dsdt, MachineState *machine)
                                  AML_SYSTEM_MEMORY,
                                  VIRT_GED_MEM_ADDR);
     }
+
+    if (event & ACPI_GED_CPU_HOTPLUG_EVT) {
+        opts.acpi_1_compatible = false;
+        opts.has_legacy_cphp = false;
+        opts.fw_unplugs_cpu = false;
+        opts.smi_path = NULL;
+
+        build_cpus_aml(dsdt, machine, opts, virt_madt_cpu_entry,
+                       VIRT_GED_CPUHP_ADDR, "\\_SB",
+                       AML_GED_EVT_CPU_SCAN_METHOD, AML_SYSTEM_MEMORY);
+    }
+
     acpi_dsdt_add_power_button(dsdt);
 }
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 7788efbe44..8aba145566 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -187,11 +187,17 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic,
 {
     DeviceState *dev;
     MachineState *ms = MACHINE(lvms);
+    MachineClass *mc = MACHINE_GET_CLASS(lvms);
     uint32_t event = ACPI_GED_PWR_DOWN_EVT;
 
     if (ms->ram_slots) {
         event |= ACPI_GED_MEM_HOTPLUG_EVT;
     }
+
+    if (mc->has_hotpluggable_cpus) {
+        event |= ACPI_GED_CPU_HOTPLUG_EVT;
+    }
+
     dev = qdev_new(TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -203,6 +209,10 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic,
     /* ged regs used for reset and power down */
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, VIRT_GED_REG_ADDR);
 
+    if (mc->has_hotpluggable_cpus) {
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 3, VIRT_GED_CPUHP_ADDR);
+    }
+
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(pch_pic, VIRT_SCI_IRQ - VIRT_GSI_BASE));
     return dev;
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 2e7cdfaef0..2b7d19953f 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -30,6 +30,7 @@
 #define VIRT_GED_EVT_ADDR       0x100e0000
 #define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN)
 #define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN)
+#define VIRT_GED_CPUHP_ADDR     (VIRT_GED_REG_ADDR + ACPI_GED_REG_COUNT)
 
 #define COMMAND_LINE_SIZE       512
 
-- 
2.43.5


