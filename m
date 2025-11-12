Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1813CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 03:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ1Br-0000es-6R; Tue, 11 Nov 2025 22:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vJ1Bo-0000cr-WD; Tue, 11 Nov 2025 22:06:33 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vJ1Bn-0003zx-Bi; Tue, 11 Nov 2025 22:06:32 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 12 Nov
 2025 11:05:56 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 12 Nov 2025 11:05:55 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "Kevin
 Wolf" <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v2 08/12] hw/arm/aspeed_ast10x0: Add AST1060 SoC support
Date: Wed, 12 Nov 2025 11:05:45 +0800
Message-ID: <20251112030553.291734-9-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112030553.291734-1-jamin_lin@aspeedtech.com>
References: <20251112030553.291734-1-jamin_lin@aspeedtech.com>
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

Add initial support for the Aspeed AST1060 SoC. The AST1060 reuses most
of the AST1030 peripheral device models, as the two SoCs share nearly
the same controllers including WDT, SCU, TIMER, HACE, ADC, I2C, FMC,
and SPI.

A new common initialization and realization framework (ast10x0_init
and ast10x0_realize) is leveraged so AST1060 can instantiate the
existing AST1030 models without redefining duplicate device types.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast10x0.c | 59 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 1521000af0..bcfe83bdb7 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -185,6 +185,23 @@ static void aspeed_soc_ast1030_init(Object *obj)
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
 }
 
+static void aspeed_soc_ast1060_init(Object *obj)
+{
+    /*
+     * The AST1060 SoC reuses the AST1030 device models. Since all peripheral
+     * models (e.g. WDT, SCU, TIMER, HACE, ADC, I2C, FMC, SPI) defined for
+     * AST1030 are compatible with AST1060, we simply reuse the existing
+     * AST1030 models for AST1060.
+     *
+     * To simplify the implementation, AST1060 sets its socname to that of
+     * AST1030, avoiding the need to create a full set of new
+     * TYPE_ASPEED_1060_XXX device definitions. This allows the same
+     * TYPE_ASPEED_1030_WDT and other models to be instantiated for both
+     * SoCs.
+     */
+    aspeed_soc_ast10x0_init(obj, "ast1030");
+}
+
 static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
 {
     AspeedSoCState *s = ASPEED_SOC(a);
@@ -451,6 +468,15 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
                                 sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_4));
 }
 
+static void aspeed_soc_ast1060_realize(DeviceState *dev_soc, Error **errp)
+{
+    Aspeed10x0SoCState *a = ASPEED10X0_SOC(dev_soc);
+
+    if (!aspeed_soc_ast10x0_realize(a, errp)) {
+        return;
+    }
+}
+
 static void aspeed_soc_ast1030_class_init(ObjectClass *klass, const void *data)
 {
     static const char * const valid_cpu_types[] = {
@@ -479,6 +505,32 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *klass, const void *data)
     sc->num_cpus = 1;
 }
 
+static void aspeed_soc_ast1060_class_init(ObjectClass *klass, const void *data)
+{
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO cortex-m4f */
+        NULL
+    };
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSoCClass *sc = ASPEED_SOC_CLASS(dc);
+
+    /* Reason: The Aspeed SoC can only be instantiated from a board */
+    dc->user_creatable = false;
+    dc->realize = aspeed_soc_ast1060_realize;
+
+    sc->valid_cpu_types = valid_cpu_types;
+    sc->silicon_rev = AST1060_A2_SILICON_REV;
+    sc->sram_size = 0xc0000;
+    sc->secsram_size = 0x40000; /* 256 * KiB */
+    sc->spis_num = 2;
+    sc->wdts_num = 4;
+    sc->uarts_num = 1;
+    sc->uarts_base = ASPEED_DEV_UART5;
+    sc->irqmap = aspeed_soc_ast1030_irqmap;
+    sc->memmap = aspeed_soc_ast1030_memmap;
+    sc->num_cpus = 1;
+}
+
 static const TypeInfo aspeed_soc_ast10x0_types[] = {
     {
         .name           = TYPE_ASPEED10X0_SOC,
@@ -490,7 +542,12 @@ static const TypeInfo aspeed_soc_ast10x0_types[] = {
         .parent         = TYPE_ASPEED10X0_SOC,
         .instance_init  = aspeed_soc_ast1030_init,
         .class_init     = aspeed_soc_ast1030_class_init,
-    },
+    }, {
+        .name           = "ast1060-a2",
+        .parent         = TYPE_ASPEED10X0_SOC,
+        .instance_init  = aspeed_soc_ast1060_init,
+        .class_init     = aspeed_soc_ast1060_class_init,
+    }
 };
 
 DEFINE_TYPES(aspeed_soc_ast10x0_types)
-- 
2.43.0


