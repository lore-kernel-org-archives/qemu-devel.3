Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633F9C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 11:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc0M7-00045K-AB; Wed, 16 Jul 2025 07:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uc0DK-0003fQ-6o; Wed, 16 Jul 2025 07:22:18 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uc0DI-0001Dy-17; Wed, 16 Jul 2025 07:22:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1752664825; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DHvnyi8O3qAqL1gY3vQYXwq/KBOXnOKpUrnLo7VwyGSQ++gI3ZqjwYCdBEUz7RPBnKRSc8f/YtQ6Npsc6yN9/UiojJ2D1cTd8QDdJSV+hshPAOfQIg5bgqVGxSDnL+TyAuBJPEo2PFf/ijIUrQPLpSVfuoHaSW7Y4h1jlRjeOKQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1752664825;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=/QpS4sUrmm/ishoPatrTc/F0h2NQwScMA4kFCFRLbBE=; 
 b=DxlPGuLGyJ2figQoKAZKpsXXK/pMCUsWG1oIdIEyyYErQmmYf3t2lUZwH5yvufRk8T09SCaJpd2ivpjMb2U8odcDmYj629O3Y5xEqoWXKhvZ7iPSjG+kG2egXO04ZC5c4w7piazQoIJcA4vIRLhsNqivGf4FpLFfBXoUYJJT7d0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752664825; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=/QpS4sUrmm/ishoPatrTc/F0h2NQwScMA4kFCFRLbBE=;
 b=OE1MAE4R+/mpBXbNfvW32vWj1AvnAZiWC5oJR06+4KaNI+QpjN+4LQutANXCo77a
 9yLVZ6rnTAkA7sYWS6KvUD+LFYmYqwFztTPK8dTc3YlBUWfq8joMrj0SelijK+Y82Da
 WcgXnXLR5ifJy/fchdGvNY5y0GgWc1jviD3hpa8w=
Received: by mx.zohomail.com with SMTPS id 1752664824422729.9651341987811;
 Wed, 16 Jul 2025 04:20:24 -0700 (PDT)
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
Subject: [PATCH v5 4/4] acpi/virt: suppress UART device & SPCR when guest has
 no serial hardware
Date: Wed, 16 Jul 2025 19:19:56 +0800
Message-ID: <20250716111959.404917-5-me@linux.beauty>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716111959.404917-1-me@linux.beauty>
References: <20250716111959.404917-1-me@linux.beauty>
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

From: Li Chen <chenl311@chinatelecom.cn>

The virt machines always instantiate a PL011/16550 at UART0 and
describe it in ACPI (DSDT device node plus optional SPCR table).  When
the command line contains “-serial none” there is no backend attached to
that UART, yet the guest still discovers it via ACPI and may try to use
it as a console, causing unexpected results.

And also explicitly add "-serial stdio" in bios-tables-test.c to allow
serial device creation, otherwise DSDT assert would get failure because
"-nodefaults" will not create uart device by default:

```
stderr:
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-BMOL72], Expected [aml:tests/data/acpi/aarch64/virt/DSDT].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-RNOL72.dsl, aml:/tmp/aml-BMOL72], Expected [asl:/tmp/asl-ZVQL72.dsl, aml:tests/data/acpi/aarch64/virt/DS
DT].
```

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
---

Notes:
    Changes since v4: 1. Also suppress UART device & SPCR when guest has no serial hardware on loongarch
                      2. rename serial_exist to serial_exists
                      3. fix style issue
    Changes since v3: 1. Add Reviewed-by from Sunil V L <sunilvl@ventanamicro.com>
                      2. Explicitly add "-serial stdio" to pass DSDT assert

 hw/arm/virt-acpi-build.c       | 15 +++++++++------
 hw/loongarch/virt-acpi-build.c |  8 +++++---
 hw/riscv/virt-acpi-build.c     |  8 ++++++--
 include/system/system.h        |  2 ++
 system/vl.c                    |  5 +++++
 tests/qtest/bios-tables-test.c |  5 +++--
 6 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 782b17b966..8761e814ec 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -61,6 +61,7 @@
 #include "hw/acpi/viot.h"
 #include "hw/virtio/virtio-acpi.h"
 #include "target/arm/multiprocessing.h"
+#include "system/system.h"
 
 #define ARM_SPI_BASE 32
 
@@ -908,11 +909,13 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
@@ -1024,7 +1027,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
     acpi_add_table(table_offsets, tables_blob);
 
-    if (ms->acpi_spcr_enabled) {
+    if (ms->acpi_spcr_enabled && serial_exists()) {
         spcr_setup(tables_blob, tables->linker, vms);
     }
 
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 8c2228a772..d356578968 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -485,8 +485,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 
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
@@ -558,7 +560,7 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     build_srat(tables_blob, tables->linker, machine);
     acpi_add_table(table_offsets, tables_blob);
 
-    if (machine->acpi_spcr_enabled)
+    if (machine->acpi_spcr_enabled && serial_exists())
         spcr_setup(tables_blob, tables->linker, machine);
 
     if (machine->numa_state->num_nodes) {
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index ee1416d264..5132aa7b55 100644
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
@@ -895,7 +899,7 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
 
     acpi_add_table(table_offsets, tables_blob);
 
-    if (ms->acpi_spcr_enabled) {
+    if (ms->acpi_spcr_enabled && serial_exists()) {
         spcr_setup(tables_blob, tables->linker, s);
     }
 
diff --git a/include/system/system.h b/include/system/system.h
index a7effe7dfd..022222c81a 100644
--- a/include/system/system.h
+++ b/include/system/system.h
@@ -75,6 +75,8 @@ extern unsigned int nb_prom_envs;
 /* Return the Chardev for serial port i, or NULL if none */
 Chardev *serial_hd(int i);
 
+bool serial_exists(void);
+
 /* parallel ports */
 
 #define MAX_PARALLEL_PORTS 3
diff --git a/system/vl.c b/system/vl.c
index 3b7057e6c6..2ec18d4a59 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1482,6 +1482,11 @@ Chardev *serial_hd(int i)
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
index 04a9d8a4da..802ad5ccfd 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -824,10 +824,11 @@ static char *test_acpi_create_args(test_data *data, const char *params)
         /*
          * TODO: convert '-drive if=pflash' to new syntax (see e33763be7cd3)
          * when arm/virt boad starts to support it.
+         * NOTE: Explicitly add "-serial stdio" to enable uart in DSDT.
          */
         if (data->cd) {
             args = g_strdup_printf("-machine %s%s %s -accel tcg "
-                "-nodefaults -nographic "
+                "-nodefaults -serial stdio -nographic "
                 "-drive if=pflash,format=raw,file=%s,readonly=on "
                 "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
                 data->machine, data->machine_param ?: "",
@@ -835,7 +836,7 @@ static char *test_acpi_create_args(test_data *data, const char *params)
                 data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : "");
         } else {
             args = g_strdup_printf("-machine %s%s %s -accel tcg "
-                "-nodefaults -nographic "
+                "-nodefaults -serial stdio -nographic "
                 "-drive if=pflash,format=raw,file=%s,readonly=on "
                 "-drive if=pflash,format=raw,file=%s,snapshot=on %s",
                 data->machine, data->machine_param ?: "",
-- 
2.50.0


