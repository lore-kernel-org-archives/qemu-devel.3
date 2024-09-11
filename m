Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987B6EE01FF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDjc-0004Ev-SR; Tue, 10 Sep 2024 23:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1soDja-0004DG-Bj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:09:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1soDjX-0007Xp-KB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:09:34 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx9+jkCeFmh1MEAA--.9020S3;
 Wed, 11 Sep 2024 11:09:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxXuTiCeFmf3cDAA--.19910S3;
 Wed, 11 Sep 2024 11:09:23 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] acpi: ged: Add macro for acpi sleep control register
Date: Wed, 11 Sep 2024 11:09:21 +0800
Message-Id: <20240911030922.877259-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240911030922.877259-1-maobibo@loongson.cn>
References: <20240911030922.877259-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXuTiCeFmf3cDAA--.19910S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

Macro definition is added for acpi sleep control register, so that
ged emulation driver can use this, also it can be used in FDT table if
ged is exposed with FDT table.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/acpi/generic_event_device.c         | 6 +++---
 hw/i386/acpi-microvm.c                 | 2 +-
 hw/loongarch/acpi-build.c              | 2 +-
 include/hw/acpi/generic_event_device.h | 9 +++++++--
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 15b4c3ebbf..94992e6119 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -201,9 +201,9 @@ static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
 
     switch (addr) {
     case ACPI_GED_REG_SLEEP_CTL:
-        slp_typ = (data >> 2) & 0x07;
-        slp_en  = (data >> 5) & 0x01;
-        if (slp_en && slp_typ == 5) {
+        slp_typ = (data & ACPI_GED_SLP_TYPx_MASK) >> ACPI_GED_SLP_TYPx_POS;
+        slp_en  = !!(data & ACPI_GED_SLP_EN);
+        if (slp_en && slp_typ == ACPI_GED_SLP_TYPx_S5) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         }
         return;
diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index 279da6b4aa..1e424076d2 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -131,7 +131,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
     /* ACPI 5.0: Table 7-209 System State Package */
     scope = aml_scope("\\");
     pkg = aml_package(4);
-    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S5));
+    aml_append(pkg, aml_int(ACPI_GED_SLP_TYPx_S5));
     aml_append(pkg, aml_int(0)); /* ignored */
     aml_append(pkg, aml_int(0)); /* reserved */
     aml_append(pkg, aml_int(0)); /* reserved */
diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 2638f87434..974519a347 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -418,7 +418,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     /* System State Package */
     scope = aml_scope("\\");
     pkg = aml_package(4);
-    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S5));
+    aml_append(pkg, aml_int(ACPI_GED_SLP_TYPx_S5));
     aml_append(pkg, aml_int(0)); /* ignored */
     aml_append(pkg, aml_int(0)); /* reserved */
     aml_append(pkg, aml_int(0)); /* reserved */
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index 40af3550b5..41741e94ea 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -81,8 +81,13 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 /* ACPI_GED_REG_RESET value for reset*/
 #define ACPI_GED_RESET_VALUE       0x42
 
-/* ACPI_GED_REG_SLEEP_CTL.SLP_TYP value for S5 (aka poweroff) */
-#define ACPI_GED_SLP_TYP_S5        0x05
+/* [ACPI 5.0+ FADT] Sleep Control Register */
+/* 3-bit field defines the type of hardware sleep state */
+#define ACPI_GED_SLP_TYPx_POS      0x2
+#define ACPI_GED_SLP_TYPx_MASK     (0x07 << ACPI_GED_SLP_TYPx_POS)
+#define ACPI_GED_SLP_TYPx_S5       0x05  /* System \_S5 State (Soft Off) */
+/* Write-only, Set this bit causes system to enter SLP_TYPx sleeping state */
+#define ACPI_GED_SLP_EN            0x20
 
 #define GED_DEVICE      "GED"
 #define AML_GED_EVT_REG "EREG"
-- 
2.39.3


