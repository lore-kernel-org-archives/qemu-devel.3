Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85335EE57F8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 13:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sojZv-0003lh-Vw; Thu, 12 Sep 2024 09:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sojZj-00039Q-KW
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:09:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sojZg-0004qO-RG
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:09:31 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxB+kG6OJm9uQFAA--.12642S3;
 Thu, 12 Sep 2024 21:09:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front2 (Coremail) with SMTP id qciowMDxl8Xr5+JmR8MFAA--.9219S9;
 Thu, 12 Sep 2024 21:09:24 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 7/7] hw/loongarch: Add acpi SPCR table support
Date: Thu, 12 Sep 2024 20:51:32 +0800
Message-Id: <20240912125132.268802-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240912125132.268802-1-gaosong@loongson.cn>
References: <20240912125132.268802-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowMDxl8Xr5+JmR8MFAA--.9219S9
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

From: Bibo Mao <maobibo@loongson.cn>

Serial port console redirection table can be used for default serial
port selection, like chosen stdout-path selection with FDT method.

With acpi SPCR table added, early debug console can be parsed from
SPCR table with simple kernel parameter earlycon rather than
earlycon=uart,mmio,0x1fe001e0

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240907073037.243353-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/acpi-build.c | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 04107c84ba..50709bda0f 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -242,6 +242,44 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     acpi_table_end(linker, &table);
 }
 
+/*
+ * Serial Port Console Redirection Table (SPCR)
+ * https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
+ */
+static void
+spcr_setup(GArray *table_data, BIOSLinker *linker, MachineState *machine)
+{
+    LoongArchVirtMachineState *lvms;
+    AcpiSpcrData serial = {
+        .interface_type = 0,       /* 16550 compatible */
+        .base_addr.id = AML_AS_SYSTEM_MEMORY,
+        .base_addr.width = 32,
+        .base_addr.offset = 0,
+        .base_addr.size = 1,
+        .base_addr.addr = VIRT_UART_BASE,
+        .interrupt_type = 0,       /* Interrupt not supported */
+        .pc_interrupt = 0,
+        .interrupt = VIRT_UART_IRQ,
+        .baud_rate = 7,            /* 115200 */
+        .parity = 0,
+        .stop_bits = 1,
+        .flow_control = 0,
+        .terminal_type = 3,        /* ANSI */
+        .language = 0,             /* Language */
+        .pci_device_id = 0xffff,   /* not a PCI device*/
+        .pci_vendor_id = 0xffff,   /* not a PCI device*/
+        .pci_bus = 0,
+        .pci_device = 0,
+        .pci_function = 0,
+        .pci_flags = 0,
+        .pci_segment = 0,
+    };
+
+    lvms = LOONGARCH_VIRT_MACHINE(machine);
+    build_spcr(table_data, linker, &serial, 2, lvms->oem_id,
+               lvms->oem_table_id);
+}
+
 typedef
 struct AcpiBuildState {
     /* Copy of table in RAM (for patching). */
@@ -484,6 +522,8 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 
     acpi_add_table(table_offsets, tables_blob);
     build_srat(tables_blob, tables->linker, machine);
+    acpi_add_table(table_offsets, tables_blob);
+    spcr_setup(tables_blob, tables->linker, machine);
 
     if (machine->numa_state->num_nodes) {
         if (machine->numa_state->have_numa_distance) {
-- 
2.34.1


