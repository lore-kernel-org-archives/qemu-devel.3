Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF95ACAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 05:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1eCl-0000rx-2j; Thu, 25 Sep 2025 01:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1eCi-0000r4-ON; Thu, 25 Sep 2025 01:07:40 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1eCf-00072D-6g; Thu, 25 Sep 2025 01:07:40 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 25 Sep
 2025 13:05:37 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 25 Sep 2025 13:05:37 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v3 6/8] hw/arm/aspeed_ast27x0-fc: Make sub-init functions
 return bool with errp
Date: Thu, 25 Sep 2025 13:05:32 +0800
Message-ID: <20250925050535.2657256-7-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925050535.2657256-1-jamin_lin@aspeedtech.com>
References: <20250925050535.2657256-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Refactor ast2700fc_ca35_init(), ast2700fc_ssp_init(), and ast2700fc_tsp_init()
to take an Error **errp parameter and return a bool.
Each function now reports failure through the error object and returns false.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0-fc.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index ebf3784df5..2e16a0340a 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -56,7 +56,7 @@ struct Ast2700FCState {
 #define AST2700FC_FMC_MODEL "w25q01jvq"
 #define AST2700FC_SPI_MODEL "w25q512jv"
 
-static void ast2700fc_ca35_init(MachineState *machine)
+static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
 {
     Ast2700FCState *s = AST2700A1FC(machine);
     AspeedSoCState *soc;
@@ -71,8 +71,8 @@ static void ast2700fc_ca35_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), 0, &s->ca35_memory);
 
     if (!memory_region_init_ram(&s->ca35_dram, OBJECT(&s->ca35), "ca35-dram",
-                                AST2700FC_BMC_RAM_SIZE, &error_abort)) {
-        return;
+                                AST2700FC_BMC_RAM_SIZE, errp)) {
+        return false;
     }
     object_property_set_link(OBJECT(&s->ca35), "memory",
                              OBJECT(&s->ca35_memory), &error_abort);
@@ -92,8 +92,8 @@ static void ast2700fc_ca35_init(MachineState *machine)
     object_property_set_int(OBJECT(&s->ca35), "hw-strap2",
                             AST2700FC_HW_STRAP2, &error_abort);
     aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
-    if (!qdev_realize(DEVICE(&s->ca35), NULL, &error_abort)) {
-        return;
+    if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {
+        return false;
     }
 
     /*
@@ -108,9 +108,11 @@ static void ast2700fc_ca35_init(MachineState *machine)
     ast2700fc_board_info.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
 
     arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
+
+    return true;
 }
 
-static void ast2700fc_ssp_init(MachineState *machine)
+static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
 {
     AspeedSoCState *soc;
     Ast2700FCState *s = AST2700A1FC(machine);
@@ -127,12 +129,14 @@ static void ast2700fc_ssp_init(MachineState *machine)
 
     soc = ASPEED_SOC(&s->ssp);
     aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(1));
-    if (!qdev_realize(DEVICE(&s->ssp), NULL, &error_abort)) {
-        return;
+    if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
+        return false;
     }
+
+    return true;
 }
 
-static void ast2700fc_tsp_init(MachineState *machine)
+static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
 {
     AspeedSoCState *soc;
     Ast2700FCState *s = AST2700A1FC(machine);
@@ -149,16 +153,18 @@ static void ast2700fc_tsp_init(MachineState *machine)
 
     soc = ASPEED_SOC(&s->tsp);
     aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART7, serial_hd(2));
-    if (!qdev_realize(DEVICE(&s->tsp), NULL, &error_abort)) {
-        return;
+    if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
+        return false;
     }
+
+    return true;
 }
 
 static void ast2700fc_init(MachineState *machine)
 {
-    ast2700fc_ca35_init(machine);
-    ast2700fc_ssp_init(machine);
-    ast2700fc_tsp_init(machine);
+    ast2700fc_ca35_init(machine, &error_abort);
+    ast2700fc_ssp_init(machine, &error_abort);
+    ast2700fc_tsp_init(machine, &error_abort);
 }
 
 static void ast2700fc_class_init(ObjectClass *oc, const void *data)
-- 
2.43.0


