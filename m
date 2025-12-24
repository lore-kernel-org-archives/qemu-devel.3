Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B00E748FC
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 01:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYDuC-0001Yt-Tr; Tue, 23 Dec 2025 20:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vYDu4-0001MM-5L; Tue, 23 Dec 2025 20:43:04 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vYDu2-00058k-Id; Tue, 23 Dec 2025 20:43:03 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 24 Dec
 2025 09:42:07 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 24 Dec 2025 09:42:07 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <nabihestefan@google.com>, Kane-Chen-AS
 <kane_chen@aspeedtech.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>
Subject: [PATCH v4 09/19] hw/arm/aspeed: Attach SRAM device to AST1700 model
Date: Wed, 24 Dec 2025 09:41:48 +0800
Message-ID: <20251224014203.756264-10-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251224014203.756264-1-kane_chen@aspeedtech.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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

Map the SRAM device to AST1700 model

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_ast1700.h |  2 ++
 hw/arm/aspeed_ast1700.c         | 18 ++++++++++++++++++
 hw/arm/aspeed_ast27x0.c         |  1 +
 3 files changed, 21 insertions(+)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index a0d6b3ae44..23588f7a81 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -20,9 +20,11 @@ struct AspeedAST1700SoCState {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
+    uint8_t board_idx;
 
     AspeedLTPIState ltpi;
     SerialMM uart;
+    MemoryRegion sram;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index f444582795..cb07d94054 100644
--- a/hw/arm/aspeed_ast1700.c
+++ b/hw/arm/aspeed_ast1700.c
@@ -14,13 +14,16 @@
 #include "hw/arm/aspeed_ast1700.h"
 
 #define AST2700_SOC_LTPI_SIZE        0x01000000
+#define AST1700_SOC_SRAM_SIZE        0x00040000
 
 enum {
+    ASPEED_AST1700_DEV_SRAM,
     ASPEED_AST1700_DEV_UART12,
     ASPEED_AST1700_DEV_LTPI_CTRL,
 };
 
 static const hwaddr aspeed_ast1700_io_memmap[] = {
+    [ASPEED_AST1700_DEV_SRAM]      =  0x00BC0000,
     [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
     [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
 };
@@ -29,12 +32,21 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
 {
     AspeedAST1700SoCState *s = ASPEED_AST1700(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    char dev_name[32];
 
     /* Occupy memory space for all controllers in AST1700 */
     memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
                        AST2700_SOC_LTPI_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
 
+    /* SRAM */
+    snprintf(dev_name, sizeof(dev_name), "aspeed.ioexp-sram.%d", s->board_idx);
+    memory_region_init_ram(&s->sram, OBJECT(s), dev_name,
+                           AST1700_SOC_SRAM_SIZE, errp);
+    memory_region_add_subregion(&s->iomem,
+                            aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SRAM],
+                            &s->sram);
+
     /* UART */
     qdev_prop_set_uint8(DEVICE(&s->uart), "regshift", 2);
     qdev_prop_set_uint32(DEVICE(&s->uart), "baudbase", 38400);
@@ -69,11 +81,17 @@ static void aspeed_ast1700_instance_init(Object *obj)
 
     return;
 }
+
+static const Property aspeed_ast1700_props[] = {
+    DEFINE_PROP_UINT8("board-idx", AspeedAST1700SoCState, board_idx, 0),
+};
+
 static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = aspeed_ast1700_realize;
+    device_class_set_props(dc, aspeed_ast1700_props);
 }
 
 static const TypeInfo aspeed_ast1700_info = {
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 678d4eb6d9..f2418e0e45 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -1096,6 +1096,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
 
     /* IO Expander */
     for (i = 0; i < sc->ioexp_num; i++) {
+        qdev_prop_set_uint8(DEVICE(&s->ioexp[i]), "board-idx", i);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {
             return;
         }
-- 
2.43.0


