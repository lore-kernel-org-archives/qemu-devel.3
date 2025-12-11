Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D62D41C14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 10:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTdnY-0005a6-1o; Thu, 11 Dec 2025 05:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1vTdnW-0005ZY-UO; Thu, 11 Dec 2025 05:21:22 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1vTdnU-00055B-Ck; Thu, 11 Dec 2025 05:21:22 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1765448437; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZE9sPVAWXVGWu/LKi5ajTaoLknyfwf/HKS2rDEvvA/7mK2cUqkWxtvc8qXkjKviHz7krbiQMDs2Mmqt2sIVo7Q0DH+wI1JDUY0UroKUBKwxn6LYw4b72NqiRTr8U2YGwTrM3JCAaC6DFnOdn421L6PXIghNog7bvI6S7huTRMpI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1765448437;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=zvbCSxFQ5GtZrejK5aYSTISAwkVH5RejnhMuIVCy2F0=; 
 b=GoVBLEjxz1lVpXIXNUCOhNJkF9yd2hcCILoOyR/TystJTosLO7qaxbnm+tX+1dCaMbxuys6NJNh5HOwnlYIucsrGfogm/bEkPSdJT0Ew2M/0sqdVA/+K/6MbJ+Mx/qmKvU1R5msXXsels+Np17T1F/6T93fFySYkIIfSMQfGHi4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765448437; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=zvbCSxFQ5GtZrejK5aYSTISAwkVH5RejnhMuIVCy2F0=;
 b=IhWGfCVuV3zNxpJHAJpO77jGMX+raRXN6DPXjBiPOLDlUDavPNeXM+D0Xoezb7B9
 hmvQ+MyefT+r74nj12I5UYYKlLwdRmOdBcu5GOnbOSRjClG1F1alwJEO+3GWEx9MJsp
 GWi6X0lxVwmJ+4gM1T+zJ8hBsb6ChiivE4t9EkYY=
Received: by mx.zohomail.com with SMTPS id 1765448433768511.7457602478198;
 Thu, 11 Dec 2025 02:20:33 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Peter Maydell" <peter.maydell@linaro.org>,
 "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Igor Mammedov" <imammedo@redhat.com>, "Ani Sinha" <anisinha@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Yanan Wang" <wangyanan55@huawei.com>, "Zhao Liu" <zhao1.liu@intel.com>,
 "Song Gao" <gaosong@loongson.cn>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>, "qemu-arm" <qemu-arm@nongnu.org>,
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>
Subject: [PATCH v6] acpi/virt: suppress UART device & SPCR when guest has no
 serial hardware
Date: Thu, 11 Dec 2025 18:20:25 +0800
Message-ID: <20251211102025.873506-1-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112; envelope-from=me@linux.beauty;
 helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Li Chen <chenl311@chinatelecom.cn>

virt machines always instantiate a PL011/16550 UART at slot 0 and describe
it in ACPI (DSDT and optional SPCR table). When the command line disables
the serial backend (e.g. "-serial none"), the guest still sees the UART as
a preferred console even though it is not usable.

Teach the virt ACPI code to omit the UART device and SPCR when there is no
serial backend attached. This matches the hardware that the guest can
actually use and avoids confusing firmware or OS code that relies on SPCR.

The bios-tables-test qtests rely on an ACPI UART node and SPCR entry for
UEFI-based virt machines. To keep those tests working we create a UART
with a "null" chardev backend instead. This preserves the ACPI tables
while discarding the firmware's serial output so it does not corrupt the
TAP stdout stream.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
---
v4->v5:
- Also suppress UART device & SPCR when guest has no serial hardware on loongarch
- rename serial_exist to serial_exists
- fix style issue
v5->v6: 
- Fix: tap parsingg error caused by changing serial to none; now set to null.

 hw/arm/virt-acpi-build.c       | 15 +++++++++------
 hw/loongarch/virt-acpi-build.c |  8 +++++---
 hw/riscv/virt-acpi-build.c     |  8 ++++++--
 include/system/system.h        |  2 ++
 system/vl.c                    |  5 +++++
 tests/qtest/bios-tables-test.c |  6 ++++--
 6 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 200e2a1da7..16d3b63030 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -64,6 +64,7 @@
 #include "hw/virtio/virtio-acpi.h"
 #include "target/arm/cpu.h"
 #include "target/arm/multiprocessing.h"
+#include "system/system.h"
 
 #define ARM_SPI_BASE 32
 
@@ -1031,11 +1032,13 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
      */
     scope = aml_scope("\\_SB");
     acpi_dsdt_add_cpus(scope, vms);
-    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0],
-                       (irqmap[VIRT_UART0] + ARM_SPI_BASE), 0);
-    if (vms->second_ns_uart_present) {
-        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1],
-                           (irqmap[VIRT_UART1] + ARM_SPI_BASE), 1);
+    if (serial_exists()) {
+        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0],
+                           (irqmap[VIRT_UART0] + ARM_SPI_BASE), 0);
+        if (vms->second_ns_uart_present) {
+            acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1],
+                               (irqmap[VIRT_UART1] + ARM_SPI_BASE), 1);
+        }
     }
     if (vmc->acpi_expose_flash) {
         acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
@@ -1184,7 +1187,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
     acpi_add_table(table_offsets, tables_blob);
 
-    if (ms->acpi_spcr_enabled) {
+    if (ms->acpi_spcr_enabled && serial_exists()) {
         spcr_setup(tables_blob, tables->linker, vms);
     }
 
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 3694c9827f..6eab907087 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -484,8 +484,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 
     acpi_table_begin(&table, table_data);
     dsdt = init_aml_allocator();
-    for (i = 0; i < VIRT_UART_COUNT; i++) {
-        build_uart_device_aml(dsdt, i);
+    if (serial_exists()) {
+        for (i = 0; i < VIRT_UART_COUNT; i++) {
+            build_uart_device_aml(dsdt, i);
+        }
     }
     build_pci_device_aml(dsdt, lvms);
     build_la_ged_aml(dsdt, machine);
@@ -557,7 +559,7 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     build_srat(tables_blob, tables->linker, machine);
     acpi_add_table(table_offsets, tables_blob);
 
-    if (machine->acpi_spcr_enabled)
+    if (machine->acpi_spcr_enabled && serial_exists())
         spcr_setup(tables_blob, tables->linker, machine);
 
     if (machine->numa_state->num_nodes) {
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index f1406cb683..e895bc4ddb 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -39,6 +39,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "system/reset.h"
+#include "system/system.h"
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
 #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
@@ -474,7 +475,10 @@ static void build_dsdt(GArray *table_data,
                                  memmap[VIRT_APLIC_S].size, "RSCV0002");
     }
 
-    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
+    if (serial_exists()) {
+        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
+    }
+
     if (virt_is_iommu_sys_enabled(s)) {
         acpi_dsdt_add_iommu_sys(scope, &memmap[VIRT_IOMMU_SYS], IOMMU_SYS_IRQ);
     }
@@ -890,7 +894,7 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
 
     acpi_add_table(table_offsets, tables_blob);
 
-    if (ms->acpi_spcr_enabled) {
+    if (ms->acpi_spcr_enabled && serial_exists()) {
         spcr_setup(tables_blob, tables->linker, s);
     }
 
diff --git a/include/system/system.h b/include/system/system.h
index 03a2d0e900..4a03f17e91 100644
--- a/include/system/system.h
+++ b/include/system/system.h
@@ -74,6 +74,8 @@ extern unsigned int nb_prom_envs;
 /* Return the Chardev for serial port i, or NULL if none */
 Chardev *serial_hd(int i);
 
+bool serial_exists(void);
+
 /* parallel ports */
 
 #define MAX_PARALLEL_PORTS 3
diff --git a/system/vl.c b/system/vl.c
index 5091fe52d9..3a2988cb47 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1487,6 +1487,11 @@ Chardev *serial_hd(int i)
     return NULL;
 }
 
+bool serial_exists(void)
+{
+    return serial_hd(0) ? true : false;
+}
+
 static bool parallel_parse(const char *devname, Error **errp)
 {
     static int index = 0;
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 6b892ef23e..6b0e4be752 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -824,10 +824,12 @@ static char *test_acpi_create_args(test_data *data, const char *params)
         /*
          * TODO: convert '-drive if=pflash' to new syntax (see e33763be7cd3)
          * when arm/virt boad starts to support it.
+         * NOTE: Explicitly add "-serial null" to enable uart in DSDT
+         *       without mixing guest output into TAP stdout.
          */
         if (data->cd) {
             args = g_strdup_printf("-machine %s%s %s -accel tcg "
-                "-nodefaults -nographic "
+                "-nodefaults -serial null -nographic "
                 "-drive if=pflash,format=raw,file=%s,readonly=on "
                 "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
                 data->machine, data->machine_param ?: "",
@@ -835,7 +837,7 @@ static char *test_acpi_create_args(test_data *data, const char *params)
                 data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : "");
         } else {
             args = g_strdup_printf("-machine %s%s %s -accel tcg "
-                "-nodefaults -nographic "
+                "-nodefaults -serial null -nographic "
                 "-drive if=pflash,format=raw,file=%s,readonly=on "
                 "-drive if=pflash,format=raw,file=%s,snapshot=on %s",
                 data->machine, data->machine_param ?: "",
-- 
2.51.0


