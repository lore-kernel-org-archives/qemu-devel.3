Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7E2CCFA04
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 04:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGUgN-0007bf-3t; Tue, 04 Nov 2025 22:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUgK-0007bG-OS; Tue, 04 Nov 2025 22:59:36 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUgJ-0008AS-C9; Tue, 04 Nov 2025 22:59:36 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 5 Nov
 2025 11:59:03 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 5 Nov 2025 11:59:03 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v2 10/17] hw/arm/aspeed: Attach ADC device to AST1700 model
Date: Wed, 5 Nov 2025 11:58:48 +0800
Message-ID: <20251105035859.3709907-11-kane_chen@aspeedtech.com>
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

Connect the ADC device to AST1700 model.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/misc/aspeed_ast1700.h |  1 +
 hw/arm/aspeed_ast27x0.c          |  4 ++++
 hw/misc/aspeed_ast1700.c         | 15 +++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/hw/misc/aspeed_ast1700.h b/include/hw/misc/aspeed_ast1700.h
index e55deea67a..dc9aa08c24 100644
--- a/include/hw/misc/aspeed_ast1700.h
+++ b/include/hw/misc/aspeed_ast1700.h
@@ -34,6 +34,7 @@ struct AspeedAST1700SoCState {
     SerialMM uart;
     MemoryRegion sram;
     AspeedSMCState spi;
+    AspeedADCState adc;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 7151feb35d..75bb18b9c1 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -1092,6 +1092,10 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
             sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[2 + i]), j,
                                irq);
         }
+
+        /* ADC */
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].adc), 0,
+                           aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_ADC));
     }
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c
index ba44e484e8..d06603a048 100644
--- a/hw/misc/aspeed_ast1700.c
+++ b/hw/misc/aspeed_ast1700.c
@@ -22,6 +22,7 @@
 enum {
     ASPEED_AST1700_DEV_SPI0,
     ASPEED_AST1700_DEV_SRAM,
+    ASPEED_AST1700_DEV_ADC,
     ASPEED_AST1700_DEV_UART12,
     ASPEED_AST1700_DEV_LTPI_CTRL,
     ASPEED_AST1700_DEV_SPI0_MEM,
@@ -30,6 +31,7 @@ enum {
 static const hwaddr aspeed_ast1700_io_memmap[] = {
     [ASPEED_AST1700_DEV_SPI0]      =  0x00030000,
     [ASPEED_AST1700_DEV_SRAM]      =  0x00BC0000,
+    [ASPEED_AST1700_DEV_ADC]       =  0x00C00000,
     [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
     [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
     [ASPEED_AST1700_DEV_SPI0_MEM]  =  0x04000000,
@@ -94,6 +96,14 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
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
@@ -121,6 +131,11 @@ static void aspeed_ast1700_instance_init(Object *obj)
     snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", 0, socname);
     object_initialize_child(obj, "ioexp-spi[*]", &s->spi,
                             typename);
+
+    /* ADC */
+    snprintf(typename, sizeof(typename), "aspeed.adc-%s", socname);
+    object_initialize_child(obj, "ioexp-adc[*]", &s->adc,
+                            typename);
     /* LTPI controller */
     object_initialize_child(obj, "ltpi-ctrl",
                             &s->ltpi, TYPE_ASPEED_LTPI);
-- 
2.43.0


