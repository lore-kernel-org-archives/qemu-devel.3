Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818D8CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 05:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8BMK-00088R-IW; Mon, 13 Oct 2025 01:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8BMH-00085Y-RJ; Mon, 13 Oct 2025 01:44:33 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8BMG-0002Gm-1m; Mon, 13 Oct 2025 01:44:33 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 13 Oct
 2025 13:43:39 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 13 Oct 2025 13:43:39 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v3 13/16] hw/arm/aspeed_ast27x0-tsp: Change to use
 Aspeed27x0CoprocessorState
Date: Mon, 13 Oct 2025 13:43:25 +0800
Message-ID: <20251013054334.955331-14-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013054334.955331-1-jamin_lin@aspeedtech.com>
References: <20251013054334.955331-1-jamin_lin@aspeedtech.com>
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

Refactor the AST27x0 TSP implementation to use the unified
Aspeed27x0CoprocessorState, matching the prior SSP change and removing the
duplicated Aspeed27x0TSPSoCState.

Key updates:
- Delete Aspeed27x0TSPSoCState and reuse Aspeed27x0CoprocessorState.

Update Ast2700FCState to declare tsp as Aspeed27x0CoprocessorState.
This aligns TSP with SSP on a single coprocessor state type, reducing code
duplication and simplifying maintenance.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_coprocessor.h | 12 ++----------
 hw/arm/aspeed_ast27x0-fc.c          |  2 +-
 hw/arm/aspeed_ast27x0-tsp.c         |  8 ++++----
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index d799726635..110e776c62 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -53,16 +53,8 @@ struct Aspeed27x0CoprocessorState {
 #define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
 OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0CoprocessorState, ASPEED27X0SSP_SOC)
 
-struct Aspeed27x0TSPSoCState {
-    AspeedCoprocessorState parent;
-    AspeedINTCState intc[2];
-    UnimplementedDeviceState ipc[2];
-    UnimplementedDeviceState scuio;
-
-    ARMv7MState armv7m;
-};
-
 #define TYPE_ASPEED27X0TSP_SOC "aspeed27x0tsp-soc"
-OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0TSPSoCState, ASPEED27X0TSP_SOC)
+DECLARE_OBJ_CHECKERS(Aspeed27x0CoprocessorState, AspeedCoprocessorClass,
+                     ASPEED27X0TSP_SOC, TYPE_ASPEED27X0TSP_SOC)
 
 #endif /* ASPEED_COPROCESSOR_H */
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index cd09a2dcf0..c2fa8df33c 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -43,7 +43,7 @@ struct Ast2700FCState {
 
     Aspeed27x0SoCState ca35;
     Aspeed27x0CoprocessorState ssp;
-    Aspeed27x0TSPSoCState tsp;
+    Aspeed27x0CoprocessorState tsp;
 
     bool mmio_exec;
 };
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index b77c5291a6..e18c624361 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -108,7 +108,7 @@ static struct nvic_intc_irq_info ast2700_tsp_intcmap[] = {
 static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedCoprocessorState *s,
                                               int dev)
 {
-    Aspeed27x0TSPSoCState *a = ASPEED27X0TSP_SOC(s);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0TSP_SOC(s);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
 
     int or_idx;
@@ -130,7 +130,7 @@ static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedCoprocessorState *s,
 
 static void aspeed_soc_ast27x0tsp_init(Object *obj)
 {
-    Aspeed27x0TSPSoCState *a = ASPEED27X0TSP_SOC(obj);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0TSP_SOC(obj);
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(obj);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     int i;
@@ -161,7 +161,7 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)
 
 static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
 {
-    Aspeed27x0TSPSoCState *a = ASPEED27X0TSP_SOC(dev_soc);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0TSP_SOC(dev_soc);
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
@@ -288,7 +288,7 @@ static const TypeInfo aspeed_soc_ast27x0tsp_types[] = {
     {
         .name           = TYPE_ASPEED27X0TSP_SOC,
         .parent         = TYPE_ASPEED_COPROCESSOR,
-        .instance_size  = sizeof(Aspeed27x0TSPSoCState),
+        .instance_size  = sizeof(Aspeed27x0CoprocessorState),
         .instance_init  = aspeed_soc_ast27x0tsp_init,
         .class_init     = aspeed_soc_ast27x0tsp_class_init,
     },
-- 
2.43.0


