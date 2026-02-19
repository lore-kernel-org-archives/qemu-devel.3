Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F06AE9A049
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 13:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt3iD-0000xt-W1; Thu, 19 Feb 2026 08:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1vt3iC-0000tN-Hj; Thu, 19 Feb 2026 08:04:56 -0500
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1vt3iA-0006Rc-KP; Thu, 19 Feb 2026 08:04:56 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771506264; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HwOEH2DXBMom4gwSwtIn9/BJK7rm00LbmgnurlzZa7rHxFXtSinrgAqKstGtoo6P6D6TD8AoXZgyrLcGw74Hvny1gzS55uIgt9yPWwoiwlxsfXErglY/1dKi1u9nMg5aKMWusMeIPWvjo8lK4niktZpefZaAGEG/hw/PcWQ1e9o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771506264;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Ejbq1zbds8dsryaHLlzcU5rieiSlMgaFx6MUQwW3R0g=; 
 b=ICV5CC0xDnhcNRMX+5yRMeaCXKih4QRnPNMPfLrPBNjL3msQdPioeSFMKIuiNii/JgrJy/5jPRP09ShlYNlIYJ1hM0g1WdmYxZIMVARgblf8zQM0PNWusU8bcExi5IIVZITi3oC67Edl6RdVJuqWboBU6sVEcBcArgT1sRur6vQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771506264; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Ejbq1zbds8dsryaHLlzcU5rieiSlMgaFx6MUQwW3R0g=;
 b=RKUA+sKXX2P5mHDHUH41QVonC4CKxO78GN96GehHpdGswG5p4e/+hudukMKcAEAF
 aGOChQG24Bdu41T9VD+6acE3Nf4VflvXi3rs1gw3ezdCY4pTeiNS8LilqxlXrU034kf
 4IrIdwG9GE1FDfu/WQT2JwWbUZc1+NzoP08dqL1U=
Received: by mx.zohomail.com with SMTPS id 177150626127362.394612574572875;
 Thu, 19 Feb 2026 05:04:21 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 1/1] acpi/virt: suppress SPCR when UART0 has no serial
 backend
Date: Thu, 19 Feb 2026 21:04:02 +0800
Message-ID: <20260219130403.810220-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.15; envelope-from=me@linux.beauty;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Li Chen <chenl311@chinatelecom.cn>

virt machines always instantiate a PL011/16550 UART at slot 0 and describe
it in ACPI (DSDT and optional SPCR table). When the command line disables
the serial backend (e.g. "-serial none"), SPCR still points at UART0 and
the guest may pick it as the preferred console even though it is not
usable.

Only generate SPCR when UART0 has a chardev backend attached. Keep the
UART device description in DSDT unchanged so the guest-visible UART
topology does not change.

The bios-tables-test qtests use "-serial null" to keep SPCR enabled while
discarding firmware serial output, avoiding TAP stdout corruption.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
---
v6 -> v7:
  Do not gate DSDT UART devices on serial_hd(0); only gate SPCR.
  Drop the serial_exists() helper added by v6.
  Keep bios-tables-test using "-serial null" (comment wording update).

v5 -> v6:
  Fix TAP parsing errors by using "-serial null" in bios-tables-test.

v4 -> v5:
  Also suppress UART device & SPCR when guest has no serial hardware on
  loongarch.
  Rename serial_exist to serial_exists.
  Fix style issues.

 hw/arm/virt-acpi-build.c       | 3 ++-
 hw/loongarch/virt-acpi-build.c | 2 +-
 hw/riscv/virt-acpi-build.c     | 3 ++-
 tests/qtest/bios-tables-test.c | 7 +++++--
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c145678185..1411f98ea1 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -64,6 +64,7 @@
 #include "hw/virtio/virtio-acpi.h"
 #include "target/arm/cpu.h"
 #include "target/arm/multiprocessing.h"
+#include "system/system.h"
 
 #define ARM_SPI_BASE 32
 
@@ -1291,7 +1292,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
     acpi_add_table(table_offsets, tables_blob);
 
-    if (ms->acpi_spcr_enabled) {
+    if (ms->acpi_spcr_enabled && serial_hd(0)) {
         spcr_setup(tables_blob, tables->linker, vms);
     }
 
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 54ac94e17d..dc8bbb9fdc 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -546,7 +546,7 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     build_srat(tables_blob, tables->linker, machine);
     acpi_add_table(table_offsets, tables_blob);
 
-    if (machine->acpi_spcr_enabled)
+    if (machine->acpi_spcr_enabled && serial_hd(0))
         spcr_setup(tables_blob, tables->linker, machine);
 
     if (machine->numa_state->num_nodes) {
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index f1406cb683..29080d1125 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -39,6 +39,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "system/reset.h"
+#include "system/system.h"
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
 #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
@@ -890,7 +891,7 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
 
     acpi_add_table(table_offsets, tables_blob);
 
-    if (ms->acpi_spcr_enabled) {
+    if (ms->acpi_spcr_enabled && serial_hd(0)) {
         spcr_setup(tables_blob, tables->linker, s);
     }
 
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index e489d94331..37f2b72d83 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -825,10 +825,13 @@ static char *test_acpi_create_args(test_data *data, const char *params)
         /*
          * TODO: convert '-drive if=pflash' to new syntax (see e33763be7cd3)
          * when arm/virt boad starts to support it.
+         * NOTE: Explicitly add "-serial null" to keep SPCR enabled while
+         *       discarding firmware serial output (avoid corrupting TAP
+         *       stdout).
          */
         if (data->cd) {
             args = g_strdup_printf("-machine %s%s %s -accel tcg "
-                "-nodefaults -nographic "
+                "-nodefaults -serial null -nographic "
                 "-drive if=pflash,format=raw,file=%s,readonly=on "
                 "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
                 data->machine, data->machine_param ?: "",
@@ -836,7 +839,7 @@ static char *test_acpi_create_args(test_data *data, const char *params)
                 data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : "");
         } else {
             args = g_strdup_printf("-machine %s%s %s -accel tcg "
-                "-nodefaults -nographic "
+                "-nodefaults -serial null -nographic "
                 "-drive if=pflash,format=raw,file=%s,readonly=on "
                 "-drive if=pflash,format=raw,file=%s,snapshot=on %s",
                 data->machine, data->machine_param ?: "",
-- 
2.52.0

