Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF18CCFA19
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 08:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGvgt-0003QW-Jq; Thu, 06 Nov 2025 03:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vGvgq-0003Hz-JY; Thu, 06 Nov 2025 03:49:56 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vGvgp-0005Sg-3z; Thu, 06 Nov 2025 03:49:56 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 6 Nov
 2025 16:49:28 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 6 Nov 2025 16:49:28 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "Kevin
 Wolf" <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 07/12] hw/arm/aspeed_ast10x0: Pass SoC name to common init
 for AST10x0 family reuse
Date: Thu, 6 Nov 2025 16:49:16 +0800
Message-ID: <20251106084925.1253704-8-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
References: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
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

Refactor the AST10x0 common initialization to accept a socname
parameter.

The AST1030 model can be reused by AST1060 since they share most of the
same controllers. This approach allows AST1060 to leverage the existing
AST1030 initialization flow while keeping separate SoC-specific init
functions for components that differ.

This prepares the framework for AST1060 support, allowing it to reuse
AST1030 device models and initialization flow without code duplication.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast10x0.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 5bbe16af24..c85c21b149 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -107,19 +107,14 @@ static qemu_irq aspeed_soc_ast1030_get_irq(AspeedSoCState *s, int dev)
     return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);
 }
 
-static void aspeed_soc_ast10x0_init(Object *obj)
+static void aspeed_soc_ast10x0_init(Object *obj, const char *socname)
 {
     Aspeed10x0SoCState *a = ASPEED10X0_SOC(obj);
     AspeedSoCState *s = ASPEED_SOC(obj);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    char socname[8];
     char typename[64];
     int i;
 
-    if (sscanf(object_get_typename(obj), "%7s", socname) != 1) {
-        g_assert_not_reached();
-    }
-
     object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
 
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
@@ -184,8 +179,13 @@ static void aspeed_soc_ast10x0_init(Object *obj)
 static void aspeed_soc_ast1030_init(Object *obj)
 {
     AspeedSoCState *s = ASPEED_SOC(obj);
+    char socname[8];
+
+    if (sscanf(object_get_typename(obj), "%7s", socname) != 1) {
+        g_assert_not_reached();
+    }
 
-    aspeed_soc_ast10x0_init(obj);
+    aspeed_soc_ast10x0_init(obj, socname);
     object_initialize_child(obj, "lpc", &s->lpc, TYPE_ASPEED_LPC);
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
 }
-- 
2.43.0


