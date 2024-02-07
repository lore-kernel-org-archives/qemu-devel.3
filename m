Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864F7C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXo7r-0002Tj-P1; Wed, 07 Feb 2024 15:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXo7p-0002Rn-Jh; Wed, 07 Feb 2024 15:02:29 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX02.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXo7n-0003Ra-0m; Wed, 07 Feb 2024 15:02:29 -0500
Received: from TWMBX02.aspeed.com (192.168.0.25) by TWMBX02.aspeed.com
 (192.168.0.25) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Feb
 2024 04:02:22 +0800
Received: from twmbx02.aspeed.com (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Feb 2024 04:02:22 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <jamin_lin@aspeedtech.com>
Subject: [PATCH v2 1/2] aspeed: introduce a new UART0 device name
Date: Thu, 8 Feb 2024 04:02:18 +0800
Message-ID: <20240207200220.453244-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240207200220.453244-1-jamin_lin@aspeedtech.com>
References: <20240207200220.453244-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: Fail (TWMBX02.aspeed.com: domain of jamin_lin@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=twmbx02.aspeed.com;
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX02.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Aspeed datasheet refers to the UART controllers
as UART1 - UART13 for the ast10x0, ast2600, ast2500
and ast2400 SoCs and the Aspeed ast2700 introduces an UART0
and the UART controllers as UART0 - UART12.

To keep the naming in the QEMU models
in sync with the datasheet, let's introduce a new  UART0 device name
and do the required adjustements, etc ...

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c             | 13 ++++++++-----
 hw/arm/aspeed_ast10x0.c     |  1 +
 hw/arm/aspeed_ast2400.c     |  2 ++
 hw/arm/aspeed_ast2600.c     |  1 +
 hw/arm/aspeed_soc_common.c  | 14 +++++++++-----
 include/hw/arm/aspeed_soc.h |  2 ++
 6 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 09b1e823ba..06d863958b 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -342,7 +342,7 @@ static void connect_serial_hds_to_uarts(AspeedMachineState *bmc)
     int uart_chosen = bmc->uart_chosen ? bmc->uart_chosen : amc->uart_default;
 
     aspeed_soc_uart_set_chr(s, uart_chosen, serial_hd(0));
-    for (int i = 1, uart = ASPEED_DEV_UART1; i < sc->uarts_num; i++, uart++) {
+    for (int i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
         if (uart == uart_chosen) {
             continue;
         }
@@ -1094,7 +1094,7 @@ static char *aspeed_get_bmc_console(Object *obj, Error **errp)
     AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
     int uart_chosen = bmc->uart_chosen ? bmc->uart_chosen : amc->uart_default;
 
-    return g_strdup_printf("uart%d", uart_chosen - ASPEED_DEV_UART1 + 1);
+    return g_strdup_printf("uart%d", uart_chosen - ASPEED_DEV_UART0);
 }
 
 static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
@@ -1103,6 +1103,8 @@ static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
     AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(amc->soc_name));
     int val;
+    int start = sc->uarts_base - ASPEED_DEV_UART0;
+    int end = start + sc->uarts_num;
 
     if (sscanf(value, "uart%u", &val) != 1) {
         error_setg(errp, "Bad value for \"uart\" property");
@@ -1110,11 +1112,12 @@ static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
     }
 
     /* The number of UART depends on the SoC */
-    if (val < 1 || val > sc->uarts_num) {
-        error_setg(errp, "\"uart\" should be in range [1 - %d]", sc->uarts_num);
+    if (val < start || val >= end) {
+        error_setg(errp, "\"uart\" should be in range [%d - %d]",
+                   start, end - 1);
         return;
     }
-    bmc->uart_chosen = ASPEED_DEV_UART1 + val - 1;
+    bmc->uart_chosen = val + ASPEED_DEV_UART0;
 }
 
 static void aspeed_machine_class_props_init(ObjectClass *oc)
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index c3b5116a6a..2634e0f654 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -436,6 +436,7 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *klass, void *data)
     sc->wdts_num = 4;
     sc->macs_num = 1;
     sc->uarts_num = 13;
+    sc->uarts_base = ASPEED_DEV_UART1;
     sc->irqmap = aspeed_soc_ast1030_irqmap;
     sc->memmap = aspeed_soc_ast1030_memmap;
     sc->num_cpus = 1;
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index 8829561bb6..95da85fee0 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -523,6 +523,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
     sc->wdts_num     = 2;
     sc->macs_num     = 2;
     sc->uarts_num    = 5;
+    sc->uarts_base   = ASPEED_DEV_UART1;
     sc->irqmap       = aspeed_soc_ast2400_irqmap;
     sc->memmap       = aspeed_soc_ast2400_memmap;
     sc->num_cpus     = 1;
@@ -551,6 +552,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
     sc->wdts_num     = 3;
     sc->macs_num     = 2;
     sc->uarts_num    = 5;
+    sc->uarts_base   = ASPEED_DEV_UART1;
     sc->irqmap       = aspeed_soc_ast2500_irqmap;
     sc->memmap       = aspeed_soc_ast2500_memmap;
     sc->num_cpus     = 1;
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 4ee32ea99d..f74561ecdc 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -666,6 +666,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
     sc->wdts_num     = 4;
     sc->macs_num     = 4;
     sc->uarts_num    = 13;
+    sc->uarts_base   = ASPEED_DEV_UART1;
     sc->irqmap       = aspeed_soc_ast2600_irqmap;
     sc->memmap       = aspeed_soc_ast2600_memmap;
     sc->num_cpus     = 2;
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 123a0c432c..54c875c8d5 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -36,7 +36,7 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     SerialMM *smm;
 
-    for (int i = 0, uart = ASPEED_DEV_UART1; i < sc->uarts_num; i++, uart++) {
+    for (int i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
         smm = &s->uart[i];
 
         /* Chardev property is set by the machine. */
@@ -58,10 +58,14 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
 void aspeed_soc_uart_set_chr(AspeedSoCState *s, int dev, Chardev *chr)
 {
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    int i = dev - ASPEED_DEV_UART1;
-
-    g_assert(0 <= i && i < ARRAY_SIZE(s->uart) && i < sc->uarts_num);
-    qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
+    int uart_num = dev - ASPEED_DEV_UART0;
+    int start = sc->uarts_base - ASPEED_DEV_UART0;
+    int end = start + sc->uarts_num;
+    int index = uart_num - start;
+
+    g_assert(uart_num >= start && uart_num < end);
+    g_assert(index < ARRAY_SIZE(s->uart));
+    qdev_prop_set_chr(DEVICE(&s->uart[index]), "chardev", chr);
 }
 
 /*
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 9d0af84a8c..5ab0902da0 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -140,6 +140,7 @@ struct AspeedSoCClass {
     int wdts_num;
     int macs_num;
     int uarts_num;
+    int uarts_base;
     const int *irqmap;
     const hwaddr *memmap;
     uint32_t num_cpus;
@@ -151,6 +152,7 @@ const char *aspeed_soc_cpu_type(AspeedSoCClass *sc);
 enum {
     ASPEED_DEV_SPI_BOOT,
     ASPEED_DEV_IOMEM,
+    ASPEED_DEV_UART0,
     ASPEED_DEV_UART1,
     ASPEED_DEV_UART2,
     ASPEED_DEV_UART3,
-- 
2.25.1


