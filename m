Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766BAD3B7DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 07:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSVxg-0008AS-JA; Mon, 08 Dec 2025 02:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVw1-00074D-9A; Mon, 08 Dec 2025 02:45:32 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVvy-0000As-FO; Mon, 08 Dec 2025 02:45:27 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Dec
 2025 15:44:41 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Dec 2025 15:44:41 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v3 11/18] hw/arm/aspeed: Attach ADC device to AST1700 model
Date: Mon, 8 Dec 2025 15:44:23 +0800
Message-ID: <20251208074436.1871180-12-kane_chen@aspeedtech.com>
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

Connect the ADC device to AST1700 model.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_ast1700.h |  2 ++
 hw/arm/aspeed_ast1700.c         | 14 ++++++++++++++
 hw/arm/aspeed_ast27x0.c         |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index 5b120dd11a..0c1216c4ba 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -9,6 +9,7 @@
 #define ASPEED_AST1700_H
 
 #include "hw/sysbus.h"
+#include "hw/adc/aspeed_adc.h"
 #include "hw/misc/aspeed_ltpi.h"
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/char/serial-mm.h"
@@ -27,6 +28,7 @@ struct AspeedAST1700SoCState {
     SerialMM uart;
     MemoryRegion sram;
     AspeedSMCState spi;
+    AspeedADCState adc;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index 62808f7c60..967264aec9 100644
--- a/hw/arm/aspeed_ast1700.c
+++ b/hw/arm/aspeed_ast1700.c
@@ -19,6 +19,7 @@
 enum {
     ASPEED_AST1700_DEV_SPI0,
     ASPEED_AST1700_DEV_SRAM,
+    ASPEED_AST1700_DEV_ADC,
     ASPEED_AST1700_DEV_UART12,
     ASPEED_AST1700_DEV_LTPI_CTRL,
     ASPEED_AST1700_DEV_SPI0_MEM,
@@ -27,6 +28,7 @@ enum {
 static const hwaddr aspeed_ast1700_io_memmap[] = {
     [ASPEED_AST1700_DEV_SPI0]      =  0x00030000,
     [ASPEED_AST1700_DEV_SRAM]      =  0x00BC0000,
+    [ASPEED_AST1700_DEV_ADC]       =  0x00C00000,
     [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
     [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
     [ASPEED_AST1700_DEV_SPI0_MEM]  =  0x04000000,
@@ -76,6 +78,14 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SPI0_MEM],
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi), 1));
 
+    /* ADC */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s->iomem,
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_ADC],
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->adc), 0));
+
     /* LTPI controller */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
         return;
@@ -97,6 +107,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
     object_initialize_child(obj, "ioexp-spi[*]", &s->spi,
                             "aspeed.spi0-ast2700");
 
+    /* ADC */
+    object_initialize_child(obj, "ioexp-adc[*]", &s->adc,
+                            "aspeed.adc-ast2700");
+
     /* LTPI controller */
     object_initialize_child(obj, "ltpi-ctrl",
                             &s->ltpi, TYPE_ASPEED_LTPI);
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 66c877a6a4..726b31031b 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -1117,6 +1117,11 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
             sysbus_connect_irq(SYS_BUS_DEVICE(&a->intcioexp[i]), j,
                                irq);
         }
+
+        /* ADC */
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].adc), 0,
+                           aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_ADC));
+
     }
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
-- 
2.43.0


