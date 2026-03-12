Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3697103E302
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 02:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0VxT-00076l-Jj; Wed, 11 Mar 2026 22:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1w0VxR-00076c-RO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 22:39:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1w0VxO-0002DB-LO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 22:39:29 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxL6pSJ7JpKTEaAA--.17611S3;
 Thu, 12 Mar 2026 10:39:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJBx78JQJ7JppYhTAA--.28822S2;
 Thu, 12 Mar 2026 10:39:13 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org,
	lixianglai@loongson.cn
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH V2] hw/loongarch: add rtc acpi table
Date: Thu, 12 Mar 2026 10:13:50 +0800
Message-Id: <20260312021350.1052791-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx78JQJ7JppYhTAA--.28822S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the acpi table to the loongson rtc hardware so that the virtual machine
kernel can use the loongson RTC-related drivers.

Delete the interrupt information in the rtc fdt table.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Song Gao <gaosong@loongson.cn> 
Cc: Bibo Mao <maobibo@loongson.cn> 
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com> 

change:
V1->V2:
1.Add a comment to explain why the acpi table no longer provides interrupt numbers
2.Delete the interrupt number from the rtc fdt table

 hw/loongarch/virt-acpi-build.c | 25 +++++++++++++++++++++++++
 hw/loongarch/virt-fdt-build.c  | 16 ++++++++--------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 3e34bedcd6..42820001d7 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -460,6 +460,30 @@ static void acpi_dsdt_add_tpm(Aml *scope, LoongArchVirtMachineState *vms)
 }
 #endif
 
+static void acpi_dsdt_add_rtc(Aml *scope)
+{
+    Aml *dev = aml_device("RTC");
+
+    aml_append(dev, aml_name_decl("_HID", aml_string("LOON0001")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+
+    Aml *crs = aml_resource_template();
+    aml_append(crs,
+        aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                         AML_NON_CACHEABLE, AML_READ_WRITE,
+                         0, VIRT_RTC_REG_BASE,
+                         VIRT_RTC_REG_BASE + VIRT_RTC_LEN - 1,
+                         0, VIRT_RTC_LEN));
+    /*
+     * The virtual machine model does not support suspend and wake-up,
+     * and rtc is no longer the wake-up source. Therefore, the current
+     * rtc table no longer provides the rtc alarm interrupt number to
+     * avoid the software initializing alarm.
+     */
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+}
+
 /* build DSDT */
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
@@ -475,6 +499,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     for (i = 0; i < VIRT_UART_COUNT; i++) {
         build_uart_device_aml(dsdt, i);
     }
+    acpi_dsdt_add_rtc(dsdt);
     build_pci_device_aml(dsdt, lvms);
     build_la_ged_aml(dsdt, machine);
     build_flash_aml(dsdt, lvms);
diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index 6c06b36fca..42f014a7bd 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -458,8 +458,7 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
     g_free(nodename);
 }
 
-static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
-                             uint32_t *pch_pic_phandle)
+static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms)
 {
     char *nodename;
     hwaddr base = VIRT_RTC_REG_BASE;
@@ -470,12 +469,13 @@ static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
     qemu_fdt_add_subnode(ms->fdt, nodename);
     qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
                             "loongson,ls7a-rtc");
+    /*
+     * The virtual machine model does not support suspend and wake-up,
+     * and rtc is no longer the wake-up source. Therefore, the current
+     * rtc table no longer provides the rtc alarm interrupt number to
+     * avoid the software initializing alarm.
+     */
     qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
-    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                           VIRT_RTC_IRQ - VIRT_GSI_BASE ,
-                           FDT_IRQ_TYPE_LEVEL_HIGH);
-    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
-                          *pch_pic_phandle);
     g_free(nodename);
 }
 
@@ -550,7 +550,7 @@ void virt_fdt_setup(LoongArchVirtMachineState *lvms)
         fdt_add_uart_node(lvms, &pch_pic_phandle, base, irq, i == 0);
     }
 
-    fdt_add_rtc_node(lvms, &pch_pic_phandle);
+    fdt_add_rtc_node(lvms);
     fdt_add_ged_reset(lvms);
     platform_bus_add_all_fdt_nodes(machine->fdt, "/platic",
                                    VIRT_PLATFORM_BUS_BASEADDRESS,
-- 
2.39.1


