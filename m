Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DCDD3ABEF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 07:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSVxj-0008Rp-Oh; Mon, 08 Dec 2025 02:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVw3-00074Q-8M; Mon, 08 Dec 2025 02:45:32 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVw1-0000As-Pp; Mon, 08 Dec 2025 02:45:31 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Dec
 2025 15:44:42 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Dec 2025 15:44:42 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v3 12/18] hw/arm/aspeed: Attach SCU device to AST1700 model
Date: Mon, 8 Dec 2025 15:44:24 +0800
Message-ID: <20251208074436.1871180-13-kane_chen@aspeedtech.com>
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

Connect the SCU device to AST1700 model.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_ast1700.h |  3 +++
 hw/arm/aspeed_ast1700.c         | 17 +++++++++++++++++
 hw/arm/aspeed_ast27x0.c         |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index 0c1216c4ba..12c57145c6 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -9,6 +9,7 @@
 #define ASPEED_AST1700_H
 
 #include "hw/sysbus.h"
+#include "hw/misc/aspeed_scu.h"
 #include "hw/adc/aspeed_adc.h"
 #include "hw/misc/aspeed_ltpi.h"
 #include "hw/ssi/aspeed_smc.h"
@@ -23,12 +24,14 @@ struct AspeedAST1700SoCState {
 
     MemoryRegion iomem;
     uint8_t board_idx;
+    uint32_t silicon_rev;
 
     AspeedLTPIState ltpi;
     SerialMM uart;
     MemoryRegion sram;
     AspeedSMCState spi;
     AspeedADCState adc;
+    AspeedSCUState scu;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index 967264aec9..b9a77765ce 100644
--- a/hw/arm/aspeed_ast1700.c
+++ b/hw/arm/aspeed_ast1700.c
@@ -20,6 +20,7 @@ enum {
     ASPEED_AST1700_DEV_SPI0,
     ASPEED_AST1700_DEV_SRAM,
     ASPEED_AST1700_DEV_ADC,
+    ASPEED_AST1700_DEV_SCU,
     ASPEED_AST1700_DEV_UART12,
     ASPEED_AST1700_DEV_LTPI_CTRL,
     ASPEED_AST1700_DEV_SPI0_MEM,
@@ -29,6 +30,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] = {
     [ASPEED_AST1700_DEV_SPI0]      =  0x00030000,
     [ASPEED_AST1700_DEV_SRAM]      =  0x00BC0000,
     [ASPEED_AST1700_DEV_ADC]       =  0x00C00000,
+    [ASPEED_AST1700_DEV_SCU]       =  0x00C02000,
     [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
     [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
     [ASPEED_AST1700_DEV_SPI0_MEM]  =  0x04000000,
@@ -86,6 +88,16 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_ADC],
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->adc), 0));
 
+    /* SCU */
+    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
+                         s->silicon_rev);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s->iomem,
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SCU],
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->scu), 0));
+
     /* LTPI controller */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
         return;
@@ -111,6 +123,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
     object_initialize_child(obj, "ioexp-adc[*]", &s->adc,
                             "aspeed.adc-ast2700");
 
+    /* SCU */
+    object_initialize_child(obj, "ioexp-scu[*]", &s->scu,
+                            TYPE_ASPEED_2700_SCU);
+
     /* LTPI controller */
     object_initialize_child(obj, "ltpi-ctrl",
                             &s->ltpi, TYPE_ASPEED_LTPI);
@@ -119,6 +135,7 @@ static void aspeed_ast1700_instance_init(Object *obj)
 
 static const Property aspeed_ast1700_props[] = {
     DEFINE_PROP_UINT8("board-idx", AspeedAST1700SoCState, board_idx, 0),
+    DEFINE_PROP_UINT32("silicon-rev", AspeedAST1700SoCState, silicon_rev, 0),
 };
 
 static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 726b31031b..817c78209a 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -573,6 +573,8 @@ static void aspeed_soc_ast2700_init(Object *obj)
         /* AST1700 IOEXP */
         object_initialize_child(obj, "ioexp[*]", &s->ioexp[i],
                                 TYPE_ASPEED_AST1700);
+        qdev_prop_set_uint32(DEVICE(&s->ioexp[i]), "silicon-rev",
+                             sc->silicon_rev);
     }
 
     object_initialize_child(obj, "dpmcu", &s->dpmcu,
-- 
2.43.0


