Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D22D3B7DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 07:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSVxr-0000UK-Lo; Mon, 08 Dec 2025 02:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVwp-0007a8-2o; Mon, 08 Dec 2025 02:46:28 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVwm-0000Ml-FN; Mon, 08 Dec 2025 02:46:17 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Dec
 2025 15:44:44 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Dec 2025 15:44:44 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v3 18/18] hw/arm/aspeed: Model AST1700 I3C block as
 unimplemented device
Date: Mon, 8 Dec 2025 15:44:30 +0800
Message-ID: <20251208074436.1871180-19-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

AST1700 exposes more I3C buses than the current dummy I3C model
provides. When Linux probes the I3C devices on AST1700 this mismatch
can trigger a kernel panic. Model the I3C block as an unimplemented
device to make the missing functionality explicit and avoid unexpected
side effects.

This wires up the I3C interrupt lines for the IO expanders and adds the
corresponding device entries for the AST1700 model.

No functional I3C emulation is provided yet; this only prevents crashes and
documents the missing piece.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_ast1700.h |  3 +++
 include/hw/arm/aspeed_soc.h     |  2 ++
 hw/arm/aspeed_ast1700.c         | 17 +++++++++++++++++
 hw/arm/aspeed_ast27x0.c         | 18 ++++++++++++++++--
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index 490f2a3b05..874b4d63fe 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -19,6 +19,7 @@
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/watchdog/wdt_aspeed.h"
 #include "hw/char/serial-mm.h"
+#include "hw/misc/unimp.h"
 
 #define AST1700_SGPIO_NUM            2
 #define AST1700_WDT_NUM              9
@@ -45,6 +46,8 @@ struct AspeedAST1700SoCState {
     AspeedI2CState i2c;
     AspeedPWMState pwm;
     AspeedWDTState wdt[AST1700_WDT_NUM];
+
+    UnimplementedDeviceState i3c;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 602ce3924d..4207887d0f 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -294,6 +294,8 @@ enum {
     ASPEED_DEV_IOEXP1_I2C,
     ASPEED_DEV_IOEXP0_INTCIO,
     ASPEED_DEV_IOEXP1_INTCIO,
+    ASPEED_DEV_IOEXP0_I3C,
+    ASPEED_DEV_IOEXP1_I3C,
 };
 
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index e027ae02ad..67ff278241 100644
--- a/hw/arm/aspeed_ast1700.c
+++ b/hw/arm/aspeed_ast1700.c
@@ -15,6 +15,7 @@
 
 #define AST2700_SOC_LTPI_SIZE        0x01000000
 #define AST1700_SOC_SRAM_SIZE        0x00040000
+#define AST1700_SOC_I3C_SIZE         0x00010000
 
 enum {
     ASPEED_AST1700_DEV_SPI0,
@@ -26,6 +27,7 @@ enum {
     ASPEED_AST1700_DEV_SGPIOM0,
     ASPEED_AST1700_DEV_SGPIOM1,
     ASPEED_AST1700_DEV_I2C,
+    ASPEED_AST1700_DEV_I3C,
     ASPEED_AST1700_DEV_UART12,
     ASPEED_AST1700_DEV_LTPI_CTRL,
     ASPEED_AST1700_DEV_WDT,
@@ -42,6 +44,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] = {
     [ASPEED_AST1700_DEV_SGPIOM0]   =  0x00C0C000,
     [ASPEED_AST1700_DEV_SGPIOM1]   =  0x00C0D000,
     [ASPEED_AST1700_DEV_I2C]       =  0x00C0F000,
+    [ASPEED_AST1700_DEV_I3C]       =  0x00C20000,
     [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
     [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
     [ASPEED_AST1700_DEV_WDT]       =  0x00C37000,
@@ -171,6 +174,15 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
                         wdt_offset,
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->wdt[i]), 0));
     }
+
+    /* I3C */
+    qdev_prop_set_string(DEVICE(&s->i3c), "name", "ioexp-i3c");
+    qdev_prop_set_uint64(DEVICE(&s->i3c), "size", AST1700_SOC_I3C_SIZE);
+    sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp);
+    memory_region_add_subregion_overlap(&s->iomem,
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_I3C],
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i3c), 0),
+                        -1000);
 }
 
 static void aspeed_ast1700_instance_init(Object *obj)
@@ -219,6 +231,11 @@ static void aspeed_ast1700_instance_init(Object *obj)
         object_initialize_child(obj, "ioexp-wdt[*]",
                                 &s->wdt[i], "aspeed.wdt-ast2700");
     }
+
+    /* I3C */
+    object_initialize_child(obj, "ioexp-i3c[*]", &s->i3c,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+
     return;
 }
 
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 7433d365a3..5604a5b8e4 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -206,7 +206,9 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_PECI]      = 197,
     [ASPEED_DEV_SDHCI]     = 197,
     [ASPEED_DEV_IOEXP0_I2C] = 198,
+    [ASPEED_DEV_IOEXP0_I3C] = 199,
     [ASPEED_DEV_IOEXP1_I2C] = 200,
+    [ASPEED_DEV_IOEXP1_I3C] = 201,
 };
 
 /* GICINT 128 */
@@ -275,12 +277,24 @@ static const int ast2700_gic198_intcmap[] = {
     [ASPEED_DEV_IOEXP0_I2C]       = 0, /* 0 - 15 */
 };
 
+/* Primary AST1700 Interrupts */
+/* A1: GINTC 199 */
+static const int ast2700_gic199_intcmap[] = {
+    [ASPEED_DEV_IOEXP0_I3C]       = 0, /* 0 - 15 */
+};
+
 /* Secondary AST1700 Interrupts */
 /* A1: GINTC 200 */
 static const int ast2700_gic200_intcmap[] = {
     [ASPEED_DEV_IOEXP1_I2C]       = 0, /* 0 - 15 */
 };
 
+/* Secondary AST1700 Interrupts */
+/* A1: GINTC 201 */
+static const int ast2700_gic201_intcmap[] = {
+    [ASPEED_DEV_IOEXP1_I3C]       = 0, /* 0 - 15 */
+};
+
 /* GICINT 128 ~ 136 */
 /* GICINT 192 ~ 201 */
 struct gic_intc_irq_info {
@@ -298,9 +312,9 @@ static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
     {196, 1, 4, ast2700_gic132_gic196_intcmap},
     {197, 1, 5, ast2700_gic133_gic197_intcmap},
     {198, 2, 0, ast2700_gic198_intcmap},
-    {199, 1, 7, NULL},
+    {199, 2, 1, ast2700_gic199_intcmap},
     {200, 3, 0, ast2700_gic200_intcmap},
-    {201, 1, 9, NULL},
+    {201, 3, 1, ast2700_gic201_intcmap},
     {128, 0, 1, ast2700_gic128_gic192_intcmap},
     {129, 0, 2, NULL},
     {130, 0, 3, ast2700_gic130_gic194_intcmap},
-- 
2.43.0


