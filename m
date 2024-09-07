Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06735E6FE50
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 07:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smpuF-0002SO-79; Sat, 07 Sep 2024 03:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1smpuB-0002Rc-I5
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 03:30:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1smpu9-0006ss-19
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 03:30:47 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxneoeAdxmLAkBAA--.3507S3;
 Sat, 07 Sep 2024 15:30:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxHeQdAdxm++MAAA--.6247S2;
 Sat, 07 Sep 2024 15:30:38 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] hw/loongarch: Add acpi SPCR table support
Date: Sat,  7 Sep 2024 15:30:37 +0800
Message-Id: <20240907073037.243353-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHeQdAdxm++MAAA--.6247S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URI_TRY_3LD=1.999 autolearn=no autolearn_force=no
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

Serial port console redirection table can be used for default serial
port selection, like chosen stdout-path selection with FDT method.

With acpi SPCR table added, early debug console can be parsed from
SPCR table with simple kernel parameter earlycon rather than
earlycon=uart,mmio,0x1fe001e0

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/acpi-build.c | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 2638f87434..3912c8d307 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -241,6 +241,44 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
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
@@ -477,6 +515,8 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 
     acpi_add_table(table_offsets, tables_blob);
     build_srat(tables_blob, tables->linker, machine);
+    acpi_add_table(table_offsets, tables_blob);
+    spcr_setup(tables_blob, tables->linker, machine);
 
     if (machine->numa_state->num_nodes) {
         if (machine->numa_state->have_numa_distance) {

base-commit: 7b87a25f49a301d3377f3e71e0b4a62540c6f6e4
-- 
2.39.3


