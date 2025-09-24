Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFA2CAC5B5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 05:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1IUq-00042v-0l; Wed, 24 Sep 2025 01:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1IUh-0003gZ-3c; Wed, 24 Sep 2025 01:56:52 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1IUc-0000It-48; Wed, 24 Sep 2025 01:56:45 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 24 Sep
 2025 13:56:04 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 24 Sep 2025 13:56:04 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v2 5/7] hw/arm/aspeed_ast27x0-fc: Replace error_abort with
 local errp
Date: Wed, 24 Sep 2025 13:55:59 +0800
Message-ID: <20250924055602.294857-6-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924055602.294857-1-jamin_lin@aspeedtech.com>
References: <20250924055602.294857-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch introduces a local Error **errp = NULL and
replaces error_abort with errp in these paths.

This makes error handling more consistent with QEMU guidelines and avoids
using error_abort in cases where failure should not be treated as a
programming error.

Discussion:
object_property_set_link() can return false only when it fails, and it
sets an error when it fails. Since passing &error_abort causes an abort,
the function never returns false, and the return statement is effectively
dead code. If failure is considered a programming error, using
&error_abort is correct. However, if failure is not a programming error,
passing &error_abort is wrong, and errp should be used instead. This
patch follows the latter approach by replacing error_abort with errp.
https://patchwork.kernel.org/project/qemu-devel/patch/20250717034054.1903991-3-jamin_lin@aspeedtech.com/#26540626

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0-fc.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 7087be4288..b15cb94c39 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -61,6 +61,7 @@ static void ast2700fc_ca35_init(MachineState *machine)
     Ast2700FCState *s = AST2700A1FC(machine);
     AspeedSoCState *soc;
     AspeedSoCClass *sc;
+    Error **errp = NULL;
 
     object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a1");
     soc = ASPEED_SOC(&s->ca35);
@@ -71,20 +72,20 @@ static void ast2700fc_ca35_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), 0, &s->ca35_memory);
 
     if (!memory_region_init_ram(&s->ca35_dram, OBJECT(&s->ca35), "ca35-dram",
-                                AST2700FC_BMC_RAM_SIZE, &error_abort)) {
+                                AST2700FC_BMC_RAM_SIZE, errp)) {
         return;
     }
     if (!object_property_set_link(OBJECT(&s->ca35), "memory",
                                   OBJECT(&s->ca35_memory),
-                                  &error_abort)) {
+                                  errp)) {
         return;
     };
     if (!object_property_set_link(OBJECT(&s->ca35), "dram",
-                                  OBJECT(&s->ca35_dram), &error_abort)) {
+                                  OBJECT(&s->ca35_dram), errp)) {
         return;
     }
     if (!object_property_set_int(OBJECT(&s->ca35), "ram-size",
-                                 AST2700FC_BMC_RAM_SIZE, &error_abort)) {
+                                 AST2700FC_BMC_RAM_SIZE, errp)) {
         return;
     }
 
@@ -95,15 +96,15 @@ static void ast2700fc_ca35_init(MachineState *machine)
         }
     }
     if (!object_property_set_int(OBJECT(&s->ca35), "hw-strap1",
-                                 AST2700FC_HW_STRAP1, &error_abort)) {
+                                 AST2700FC_HW_STRAP1, errp)) {
         return;
     }
     if (!object_property_set_int(OBJECT(&s->ca35), "hw-strap2",
-                                 AST2700FC_HW_STRAP2, &error_abort)) {
+                                 AST2700FC_HW_STRAP2, errp)) {
         return;
     }
     aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
-    if (!qdev_realize(DEVICE(&s->ca35), NULL, &error_abort)) {
+    if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {
         return;
     }
 
@@ -125,6 +126,8 @@ static void ast2700fc_ssp_init(MachineState *machine)
 {
     AspeedSoCState *soc;
     Ast2700FCState *s = AST2700A1FC(machine);
+    Error **errp = NULL;
+
     s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
     clock_set_hz(s->ssp_sysclk, 200000000ULL);
 
@@ -134,13 +137,13 @@ static void ast2700fc_ssp_init(MachineState *machine)
 
     qdev_connect_clock_in(DEVICE(&s->ssp), "sysclk", s->ssp_sysclk);
     if (!object_property_set_link(OBJECT(&s->ssp), "memory",
-                                  OBJECT(&s->ssp_memory), &error_abort)) {
+                                  OBJECT(&s->ssp_memory), errp)) {
         return;
     }
 
     soc = ASPEED_SOC(&s->ssp);
     aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(1));
-    if (!qdev_realize(DEVICE(&s->ssp), NULL, &error_abort)) {
+    if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
         return;
     }
 }
@@ -149,6 +152,8 @@ static void ast2700fc_tsp_init(MachineState *machine)
 {
     AspeedSoCState *soc;
     Ast2700FCState *s = AST2700A1FC(machine);
+    Error **errp = NULL;
+
     s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
     clock_set_hz(s->tsp_sysclk, 200000000ULL);
 
@@ -158,13 +163,13 @@ static void ast2700fc_tsp_init(MachineState *machine)
 
     qdev_connect_clock_in(DEVICE(&s->tsp), "sysclk", s->tsp_sysclk);
     if (!object_property_set_link(OBJECT(&s->tsp), "memory",
-                                  OBJECT(&s->tsp_memory), &error_abort)) {
+                                  OBJECT(&s->tsp_memory), errp)) {
         return;
     }
 
     soc = ASPEED_SOC(&s->tsp);
     aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART7, serial_hd(2));
-    if (!qdev_realize(DEVICE(&s->tsp), NULL, &error_abort)) {
+    if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
         return;
     }
 }
-- 
2.43.0


