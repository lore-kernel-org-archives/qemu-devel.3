Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084C6D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 05:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi4Ae-0007aw-KV; Tue, 20 Jan 2026 00:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vi4AR-0006HM-OG; Tue, 20 Jan 2026 00:20:40 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vi4AQ-0004v7-0m; Tue, 20 Jan 2026 00:20:39 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 Jan
 2026 13:19:07 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 Jan 2026 13:19:07 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v5 19/22] hw/arm/aspeed: Model AST1700 I3C block as
 unimplemented device
Date: Tue, 20 Jan 2026 13:18:50 +0800
Message-ID: <20260120051859.1920565-20-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
References: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via qemu development <qemu-devel@nongnu.org>
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
---
 include/hw/arm/aspeed_ast1700.h |  3 +++
 include/hw/arm/aspeed_soc.h     |  2 ++
 hw/arm/aspeed_ast1700.c         | 15 +++++++++++++++
 hw/arm/aspeed_ast27x0.c         | 18 ++++++++++++++++--
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index c50987fc76..af2445f4cd 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -19,6 +19,7 @@
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/watchdog/wdt_aspeed.h"
 #include "hw/char/serial-mm.h"
+#include "hw/misc/unimp.h"
 
 #define AST1700_SGPIO_NUM            2
 #define AST1700_WDT_NUM              9
@@ -47,6 +48,8 @@ struct AspeedAST1700SoCState {
     AspeedI2CState i2c;
     AspeedPWMState pwm;
     AspeedWDTState wdt[AST1700_WDT_NUM];
+
+    UnimplementedDeviceState i3c;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 4ea2521041..b185b04186 100644
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
index 06c35a3a36..0b6fdee208 100644
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
@@ -181,6 +184,14 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->wdt[i]), 0));
     }
 
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
@@ -230,6 +241,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
                                 &s->wdt[i], "aspeed.wdt-ast2700");
     }
 
+    /* I3C */
+    object_initialize_child(obj, "ioexp-i3c[*]", &s->i3c,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+
     return;
 }
 
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index ca35a11291..bad2028bc9 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -156,7 +156,9 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_PECI]      = 197,
     [ASPEED_DEV_SDHCI]     = 197,
     [ASPEED_DEV_IOEXP0_I2C] = 198,
+    [ASPEED_DEV_IOEXP0_I3C] = 199,
     [ASPEED_DEV_IOEXP1_I2C] = 200,
+    [ASPEED_DEV_IOEXP1_I3C] = 201,
 };
 
 /* GICINT 192 */
@@ -219,12 +221,24 @@ static const int ast2700_gic198_intcmap[] = {
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
 /* GICINT 192 ~ 201 */
 struct gic_intc_irq_info {
     int irq;
@@ -241,9 +255,9 @@ static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
     {196, 1, 4, ast2700_gic196_intcmap},
     {197, 1, 5, ast2700_gic197_intcmap},
     {198, 2, 0, ast2700_gic198_intcmap},
-    {199, 1, 7, NULL},
+    {199, 2, 1, ast2700_gic199_intcmap},
     {200, 3, 0, ast2700_gic200_intcmap},
-    {201, 1, 9, NULL},
+    {201, 3, 1, ast2700_gic201_intcmap},
 };
 
 static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
-- 
2.43.0


