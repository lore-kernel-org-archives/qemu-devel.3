Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C4AD2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 05:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi4AW-0006SO-VP; Tue, 20 Jan 2026 00:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vi4AC-0005fe-Qx; Tue, 20 Jan 2026 00:20:24 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vi4AB-0004v7-6K; Tue, 20 Jan 2026 00:20:24 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 Jan
 2026 13:19:05 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 Jan 2026 13:19:05 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v5 14/22] hw/arm/aspeed: Introduce 'bus-label' property for
 AST1700 SoC
Date: Tue, 20 Jan 2026 13:18:45 +0800
Message-ID: <20260120051859.1920565-15-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
References: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

The AST2700 SoC can be integrated with multiple AST1700 IO expanders.
Without unique identifiers, the I2C bus object names for the primary
BMC SoC and multiple expander chips may collide in the QOM
(QEMU Object Model) tree.

To resolve this, introduce a bus-label property to the AST1700 SoC.
This allows the parent SoC (AST2700) to assign a unique prefix
(e.g., "ioexp0", "ioexp1") to each AST1700 instance. These labels
ensure that the bus naming hierarchy remains distinct and traceable
across different expanders.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_ast1700.h | 1 +
 hw/arm/aspeed_ast1700.c         | 1 +
 hw/arm/aspeed_ast27x0.c         | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index 63cfcb4c24..d364203175 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -27,6 +27,7 @@ struct AspeedAST1700SoCState {
     MemoryRegion *dram_mr;
     uint8_t board_idx;
     uint32_t silicon_rev;
+    char *bus_label;
 
     AspeedLTPIState ltpi;
     SerialMM uart;
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index c7eaf583e2..0f2d2c381d 100644
--- a/hw/arm/aspeed_ast1700.c
+++ b/hw/arm/aspeed_ast1700.c
@@ -156,6 +156,7 @@ static void aspeed_ast1700_instance_init(Object *obj)
 static const Property aspeed_ast1700_props[] = {
     DEFINE_PROP_UINT8("board-idx", AspeedAST1700SoCState, board_idx, 0),
     DEFINE_PROP_UINT32("silicon-rev", AspeedAST1700SoCState, silicon_rev, 0),
+    DEFINE_PROP_STRING("bus-label", AspeedAST1700SoCState, bus_label),
     DEFINE_PROP_LINK("dram", AspeedAST1700SoCState, dram_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 58977e2fa3..b4b5afe6d3 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -503,11 +503,14 @@ static void aspeed_soc_ast2700_init(Object *obj)
     }
 
     for (i = 0; i < sc->ioexp_num; i++) {
+        g_autofree char *bus_label = g_strdup_printf("ioexp%d", i);
         /* AST1700 IOEXP */
         object_initialize_child(obj, "ioexp[*]", &s->ioexp[i],
                                 TYPE_ASPEED_AST1700);
         qdev_prop_set_uint32(DEVICE(&s->ioexp[i]), "silicon-rev",
                              sc->silicon_rev);
+        qdev_prop_set_string(DEVICE(&s->ioexp[i]), "bus-label",
+                             bus_label);
     }
 
     object_initialize_child(obj, "dpmcu", &s->dpmcu,
-- 
2.43.0


