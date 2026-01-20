Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCCCD2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 09:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi83d-0003MM-HK; Tue, 20 Jan 2026 04:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vi83b-0003Ja-Ve; Tue, 20 Jan 2026 04:29:52 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vi83a-0005eG-Fs; Tue, 20 Jan 2026 04:29:51 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 Jan
 2026 17:29:39 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 Jan 2026 17:29:39 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 01/11] hw/arm/ast27x0: Move DRAM and SDMC initialization
 earlier to support memory aliasing
Date: Tue, 20 Jan 2026 17:29:26 +0800
Message-ID: <20260120092939.2708302-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120092939.2708302-1-jamin_lin@aspeedtech.com>
References: <20260120092939.2708302-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

To support DRAM aliasing for coprocessors (SSP/TSP), this commit moves the
initialization of the SDMC (SDRAM controller) and DRAM models earlier in
the device realization order.

In the upcoming changes, the PSP will expose a portion of its DRAM as shared
memory by creating a memory region alias at a specific offset. This alias is
mapped into the coprocessor's SDRAM address space, allowing both PSP and the
coprocessor (SSP/TSP) to access the same physical memory through their respective
views — PSP via its DRAM, and the coprocessor via its SDRAM.

The remapping is configured through SCU registers and enables shared memory
communication between PSP and the coprocessors.

Therefore, the DRAM and SDMC devices must be realized before:
  - the SCU, which configures the alias offset and size
  - the coprocessors, which access the alias through their SDRAM window

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index d17f446661..74a004adca 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -702,6 +702,26 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), i));
     }
 
+    /*
+     * SDMC - SDRAM Memory Controller
+     * The SDMC controller is unlocked at SPL stage.
+     * At present, only supports to emulate booting
+     * start from u-boot stage. Set SDMC controller
+     * unlocked by default. It is a temporarily solution.
+     */
+    object_property_set_bool(OBJECT(&s->sdmc), "unlocked", true,
+                                 &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdmc), 0,
+                    sc->memmap[ASPEED_DEV_SDMC]);
+
+    /* RAM */
+    if (!aspeed_soc_ast2700_dram_init(dev, errp)) {
+        return;
+    }
+
     /* SRAM */
     name = g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index);
     if (!memory_region_init_ram(&s->sram, OBJECT(s), name, sc->sram_size,
@@ -792,26 +812,6 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                                                       ASPEED_DEV_EHCI1 + i));
     }
 
-    /*
-     * SDMC - SDRAM Memory Controller
-     * The SDMC controller is unlocked at SPL stage.
-     * At present, only supports to emulate booting
-     * start from u-boot stage. Set SDMC controller
-     * unlocked by default. It is a temporarily solution.
-     */
-    object_property_set_bool(OBJECT(&s->sdmc), "unlocked", true,
-                                 &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
-        return;
-    }
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdmc), 0,
-                    sc->memmap[ASPEED_DEV_SDMC]);
-
-    /* RAM */
-    if (!aspeed_soc_ast2700_dram_init(dev, errp)) {
-        return;
-    }
-
     /* Net */
     for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), "aspeed", true,
-- 
2.43.0


