Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049C1CCFA18
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 04:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGUg7-0007Vd-7m; Tue, 04 Nov 2025 22:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUg4-0007UV-Hl; Tue, 04 Nov 2025 22:59:20 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUg2-0006sZ-Sk; Tue, 04 Nov 2025 22:59:20 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 5 Nov
 2025 11:59:01 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 5 Nov 2025 11:59:01 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v2 04/17] hw/arm/aspeed: Integrate AST1700 device into AST27X0
Date: Wed, 5 Nov 2025 11:58:42 +0800
Message-ID: <20251105035859.3709907-5-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
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

Connect the AST1700 device as a child of the AST27X0 model to reflect
its role in DC-SCM 2.0 LTPI-based architectures. This patch wires
the AST1700 device into the platform without introducing functional
peripherals.

This forms the base for LTPI expander emulation in QEMU using
AST27X0 as the host controller.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h      |  9 +++++++--
 include/hw/misc/aspeed_ast1700.h |  1 +
 hw/arm/aspeed_ast27x0.c          | 30 ++++++++++++++++++++++--------
 hw/misc/aspeed_ast1700.c         |  6 ++++++
 4 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index bae60d85ea..00cd8df038 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -43,6 +43,7 @@
 #include "hw/char/serial-mm.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/misc/aspeed_ltpi.h"
+#include "hw/misc/aspeed_ast1700.h"
 
 #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
 
@@ -109,10 +110,10 @@ struct AspeedSoCState {
     UnimplementedDeviceState espi;
     UnimplementedDeviceState udc;
     UnimplementedDeviceState sgpiom;
-    UnimplementedDeviceState ltpi;
     UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
     AspeedAPB2OPBState fsi[2];
     AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];
+    AspeedAST1700SoCState ioexp[ASPEED_IOEXP_NUM];
 };
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
@@ -174,6 +175,7 @@ struct AspeedSoCClass {
     int macs_num;
     int uarts_num;
     int uarts_base;
+    int ioexp_num;
     const int *irqmap;
     const hwaddr *memmap;
     uint32_t num_cpus;
@@ -186,7 +188,8 @@ enum {
     ASPEED_DEV_IOMEM,
     ASPEED_DEV_IOMEM0,
     ASPEED_DEV_IOMEM1,
-    ASPEED_DEV_LTPI,
+    ASPEED_DEV_LTPI_IO0,
+    ASPEED_DEV_LTPI_IO1,
     ASPEED_DEV_UART0,
     ASPEED_DEV_UART1,
     ASPEED_DEV_UART2,
@@ -280,6 +283,8 @@ enum {
     ASPEED_DEV_IPC1,
     ASPEED_DEV_LTPI_CTRL1,
     ASPEED_DEV_LTPI_CTRL2,
+    ASPEED_DEV_IOEXP0_INTCIO,
+    ASPEED_DEV_IOEXP1_INTCIO,
 };
 
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
diff --git a/include/hw/misc/aspeed_ast1700.h b/include/hw/misc/aspeed_ast1700.h
index b7c666eef2..624ef61eda 100644
--- a/include/hw/misc/aspeed_ast1700.h
+++ b/include/hw/misc/aspeed_ast1700.h
@@ -20,6 +20,7 @@
 #include "hw/misc/unimp.h"
 
 #define TYPE_ASPEED_AST1700 "aspeed.ast1700"
+#define TYPE_ASPEED_AST1700_AST2700 "aspeed.ast1700-ast2700"
 
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedAST1700SoCState, ASPEED_AST1700)
 
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index c0d8639bde..054864467d 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -26,7 +26,6 @@
 #define AST2700_SOC_IO_SIZE          0x00FE0000
 #define AST2700_SOC_IOMEM_SIZE       0x01000000
 #define AST2700_SOC_DPMCU_SIZE       0x00040000
-#define AST2700_SOC_LTPI_SIZE        0x01000000
 
 static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_VBOOTROM]  =  0x00000000,
@@ -89,11 +88,14 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_LTPI_CTRL1] =  0x14C34000,
     [ASPEED_DEV_LTPI_CTRL2] =  0x14C35000,
     [ASPEED_DEV_WDT]       =  0x14C37000,
+    [ASPEED_DEV_LTPI_IO0]  =  0x30000000,
+    [ASPEED_DEV_IOEXP0_INTCIO] = 0x30C18000,
+    [ASPEED_DEV_LTPI_IO1]  =  0x50000000,
+    [ASPEED_DEV_IOEXP1_INTCIO] = 0x50C18000,
     [ASPEED_DEV_PCIE_MMIO0] = 0x60000000,
     [ASPEED_DEV_PCIE_MMIO1] = 0x80000000,
     [ASPEED_DEV_PCIE_MMIO2] = 0xA0000000,
     [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
-    [ASPEED_DEV_LTPI]      =  0x300000000,
     [ASPEED_DEV_SDRAM]     =  0x400000000,
 };
 
@@ -549,10 +551,15 @@ static void aspeed_soc_ast2700_init(Object *obj)
         object_initialize_child(obj, "ltpi-ctrl[*]",
                                 &s->ltpi_ctrl[i], TYPE_ASPEED_LTPI);
     }
+
+    for (i = 0; i < sc->ioexp_num; i++) {
+        /* AST1700 IOEXP */
+        object_initialize_child(obj, "ioexp[*]", &s->ioexp[i],
+                                TYPE_ASPEED_AST1700_AST2700);
+    }
+
     object_initialize_child(obj, "dpmcu", &s->dpmcu,
                             TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "ltpi", &s->ltpi,
-                            TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "iomem", &s->iomem,
                             TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "iomem0", &s->iomem0,
@@ -1039,14 +1046,20 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         }
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(ltpi_ctrl), 0, ltpi_base);
     }
+
+    /* IO Expander */
+    for (i = 0; i < sc->ioexp_num; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioexp[i]), 0,
+                        sc->memmap[ASPEED_DEV_LTPI_IO0 + i]);
+    }
+
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
                                   "aspeed.dpmcu",
                                   sc->memmap[ASPEED_DEV_DPMCU],
                                   AST2700_SOC_DPMCU_SIZE);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->ltpi),
-                                  "aspeed.ltpi",
-                                  sc->memmap[ASPEED_DEV_LTPI],
-                                  AST2700_SOC_LTPI_SIZE);
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
                                   "aspeed.io",
                                   sc->memmap[ASPEED_DEV_IOMEM],
@@ -1112,6 +1125,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
     sc->macs_num     = 3;
     sc->uarts_num    = 13;
     sc->num_cpus     = 4;
+    sc->ioexp_num    = 2;
     sc->uarts_base   = ASPEED_DEV_UART0;
     sc->irqmap       = aspeed_soc_ast2700a1_irqmap;
     sc->memmap       = aspeed_soc_ast2700_memmap;
diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c
index bb05e392f4..3125bec795 100644
--- a/hw/misc/aspeed_ast1700.c
+++ b/hw/misc/aspeed_ast1700.c
@@ -48,10 +48,16 @@ static const TypeInfo aspeed_ast1700_info = {
     .instance_init = aspeed_ast1700_instance_init,
 };
 
+static const TypeInfo aspeed_ast1700_ast2700_info = {
+    .name = TYPE_ASPEED_AST1700_AST2700,
+    .parent = TYPE_ASPEED_AST1700,
+};
+
 
 static void aspeed_ast1700_register_types(void)
 {
     type_register_static(&aspeed_ast1700_info);
+    type_register_static(&aspeed_ast1700_ast2700_info);
 }
 
 type_init(aspeed_ast1700_register_types);
-- 
2.43.0


