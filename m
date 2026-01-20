Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503AED2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 05:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi49W-0004RF-VX; Tue, 20 Jan 2026 00:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vi49V-0004QE-Dl; Tue, 20 Jan 2026 00:19:41 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vi49T-0004ZS-Tn; Tue, 20 Jan 2026 00:19:41 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 Jan
 2026 13:19:03 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 Jan 2026 13:19:03 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v5 10/22] hw/arm/aspeed: Attach SPI device to AST1700 model
Date: Tue, 20 Jan 2026 13:18:41 +0800
Message-ID: <20260120051859.1920565-11-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
References: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Connect the SPI device to AST1700 model.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_ast1700.h |  3 +++
 hw/arm/aspeed_ast1700.c         | 30 ++++++++++++++++++++++++++++++
 hw/arm/aspeed_ast27x0.c         |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index a981bff3b2..89562eb64f 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -10,6 +10,7 @@
 
 #include "hw/core/sysbus.h"
 #include "hw/misc/aspeed_ltpi.h"
+#include "hw/ssi/aspeed_smc.h"
 #include "hw/char/serial-mm.h"
 
 #define TYPE_ASPEED_AST1700 "aspeed.ast1700"
@@ -20,11 +21,13 @@ struct AspeedAST1700SoCState {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
+    MemoryRegion *dram_mr;
     uint8_t board_idx;
 
     AspeedLTPIState ltpi;
     SerialMM uart;
     MemoryRegion sram;
+    AspeedSMCState spi;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index c82825d71d..49f9b67c91 100644
--- a/hw/arm/aspeed_ast1700.c
+++ b/hw/arm/aspeed_ast1700.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/boards.h"
 #include "qom/object.h"
+#include "qapi/error.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/aspeed_ast1700.h"
 
@@ -16,15 +17,19 @@
 #define AST1700_SOC_SRAM_SIZE        0x00040000
 
 enum {
+    ASPEED_AST1700_DEV_SPI0,
     ASPEED_AST1700_DEV_SRAM,
     ASPEED_AST1700_DEV_UART12,
     ASPEED_AST1700_DEV_LTPI_CTRL,
+    ASPEED_AST1700_DEV_SPI0_MEM,
 };
 
 static const hwaddr aspeed_ast1700_io_memmap[] = {
+    [ASPEED_AST1700_DEV_SPI0]      =  0x00030000,
     [ASPEED_AST1700_DEV_SRAM]      =  0x00BC0000,
     [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
     [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
+    [ASPEED_AST1700_DEV_SPI0_MEM]  =  0x04000000,
 };
 
 static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
@@ -33,6 +38,11 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     char dev_name[32];
 
+    if (!s->dram_mr) {
+        error_setg(errp, TYPE_ASPEED_AST1700 ": 'dram' link not set");
+        return;
+    }
+
     /* Occupy memory space for all controllers in AST1700 */
     memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
                        AST2700_SOC_LTPI_SIZE);
@@ -57,6 +67,20 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_UART12],
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0));
 
+    /* SPI */
+    object_property_set_link(OBJECT(&s->spi), "dram",
+                             OBJECT(s->dram_mr), errp);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi), errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s->iomem,
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SPI0],
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi), 0));
+
+    memory_region_add_subregion(&s->iomem,
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SPI0_MEM],
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi), 1));
+
     /* LTPI controller */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
         return;
@@ -74,6 +98,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
     object_initialize_child(obj, "uart[*]", &s->uart,
                             TYPE_SERIAL_MM);
 
+    /* SPI */
+    object_initialize_child(obj, "ioexp-spi[*]", &s->spi,
+                            "aspeed.spi0-ast2700");
+
     /* LTPI controller */
     object_initialize_child(obj, "ltpi-ctrl",
                             &s->ltpi, TYPE_ASPEED_LTPI);
@@ -83,6 +111,8 @@ static void aspeed_ast1700_instance_init(Object *obj)
 
 static const Property aspeed_ast1700_props[] = {
     DEFINE_PROP_UINT8("board-idx", AspeedAST1700SoCState, board_idx, 0),
+    DEFINE_PROP_LINK("dram", AspeedAST1700SoCState, dram_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
 static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 6933d03fbf..158f44782b 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -1022,6 +1022,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     /* IO Expander */
     for (i = 0; i < sc->ioexp_num; i++) {
         qdev_prop_set_uint8(DEVICE(&s->ioexp[i]), "board-idx", i);
+        object_property_set_link(OBJECT(&s->ioexp[i]), "dram",
+                                 OBJECT(s->dram_mr), &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {
             return;
         }
-- 
2.43.0


