Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A9ACAC592
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 01:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyh1u-0006Ej-AR; Tue, 16 Sep 2025 21:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh1q-0006D9-U3; Tue, 16 Sep 2025 21:32:16 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh1o-0006vf-NC; Tue, 16 Sep 2025 21:32:14 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 17 Sep
 2025 09:31:44 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 17 Sep 2025 09:31:44 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v1 4/6] hw/arm/aspeed: Model AST1700 IO expander UART on
 AST27x0
Date: Wed, 17 Sep 2025 09:31:39 +0800
Message-ID: <20250917013143.1600377-5-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917013143.1600377-1-kane_chen@aspeedtech.com>
References: <20250917013143.1600377-1-kane_chen@aspeedtech.com>
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

AST1700 IO expander boards carry a serial-mm UART. Model this device in
the AST1700 child and expose it via the AST1700 MMIO map (UART12 at
offset 0x00C33B00) on AST27x0 machines.

Addressing:
- slot 0 (IO0): 0x30000000 + 0x00C33B00 = 0x30C33B00
- slot 1 (IO1): 0x50000000 + 0x00C33B00 = 0x50C33B00

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 2e180c8cc5..d63a331c0a 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -89,6 +89,19 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_SDRAM]     =  0x400000000,
 };
 
+static const hwaddr aspeed_soc_ast1700_memmap[] = {
+    [ASPEED_DEV_PWM]       =  0x000C0000,
+    [ASPEED_DEV_SRAM]      =  0x00BC0000,
+    [ASPEED_DEV_ADC]       =  0x00C00000,
+    [ASPEED_DEV_SCU]       =  0x00C02000,
+    [ASPEED_DEV_GPIO]      =  0x00C0B000,
+    [ASPEED_DEV_I2C]       =  0x00C0F000,
+    [ASPEED_DEV_I3C]       =  0x00C20000,
+    [ASPEED_DEV_UART12]    =  0x00C33B00,
+    [ASPEED_DEV_WDT]       =  0x00C37000,
+    [ASPEED_DEV_SPI_BOOT]  =  0x04000000,
+};
+
 #define AST2700_MAX_IRQ 256
 
 /* Shared Peripheral Interrupt values below are offset by -32 from datasheet */
@@ -538,6 +551,8 @@ static void aspeed_soc_ast2700_init(Object *obj)
 
 static void aspeed_ast2700_ast1700_init(AspeedSoCState *s, int i)
 {
+    object_initialize_child(OBJECT(s), "uart[*]", &s->ioexp[i].uart,
+                            TYPE_SERIAL_MM);
     object_initialize_child(OBJECT(s), "ltpi-ctrl[*]",
                             &s->ltpi_ctrl[i], TYPE_ASPEED_LTPI);
 }
@@ -626,13 +641,27 @@ static void aspeed_soc_ast2700_ast1700_realize(Aspeed27x0SoCState *a,
                                                AspeedSoCClass *sc,
                                                int index, Error **errp)
 {
+    SerialMM *smm;
+    hwaddr uart_base = sc->memmap[ASPEED_DEV_LTPI_IO0 + index] +
+                       aspeed_soc_ast1700_memmap[ASPEED_DEV_UART12];
     AspeedLTPIState *ltpi_ctrl = ASPEED_LTPI(&s->ltpi_ctrl[index]);
     hwaddr ltpi_base = sc->memmap[ASPEED_DEV_LTPI_CTRL1 + index];
+    smm = &s->ioexp[index].uart;
+
+    /* Chardev property is set by the machine. */
+    qdev_prop_set_uint8(DEVICE(smm), "regshift", 2);
+    qdev_prop_set_uint32(DEVICE(smm), "baudbase", 38400);
+    qdev_set_legacy_instance_id(DEVICE(smm), uart_base, 2);
+    qdev_prop_set_uint8(DEVICE(smm), "endianness", DEVICE_LITTLE_ENDIAN);
+    if (!sysbus_realize(SYS_BUS_DEVICE(smm), errp)) {
+        return;
+    }
 
     if (!sysbus_realize(SYS_BUS_DEVICE(ltpi_ctrl), errp)) {
         return;
     }
     aspeed_mmio_map(s, SYS_BUS_DEVICE(ltpi_ctrl), 0, ltpi_base);
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(smm), 0, uart_base);
 }
 
 static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
-- 
2.43.0


