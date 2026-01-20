Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9EBD2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 09:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi83n-0003ZT-Rj; Tue, 20 Jan 2026 04:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vi83l-0003Uf-AV; Tue, 20 Jan 2026 04:30:01 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vi83j-0005eG-Rp; Tue, 20 Jan 2026 04:30:01 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 Jan
 2026 17:29:40 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 Jan 2026 17:29:40 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 05/11] hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap
Date: Tue, 20 Jan 2026 17:29:30 +0800
Message-ID: <20260120092939.2708302-6-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120092939.2708302-1-jamin_lin@aspeedtech.com>
References: <20260120092939.2708302-1-jamin_lin@aspeedtech.com>
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

This commit adds a MemoryRegion alias to support PSP access to
TSP SDRAM through shared memory remapping, as defined by the default SCU
configuration.

The TSP coprocessor exposes one DRAM alias:
  - remap maps PSP DRAM at 0x42e000000 (32MB) to TSP SDRAM offset 0x0

This region corresponds to the default SCU register value, which controls
the mapping between PSP and coprocessor memory windows.

Set TSP CPUID 5. SCU VMState version remains at 3, as it was already bumped in a
previous commit.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/misc/aspeed_scu.h |  1 +
 hw/arm/aspeed_ast27x0-fc.c   |  2 ++
 hw/arm/aspeed_ast27x0-tsp.c  |  3 +++
 hw/arm/aspeed_ast27x0.c      |  2 ++
 hw/misc/aspeed_scu.c         | 15 +++++++++++++++
 5 files changed, 23 insertions(+)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 6f7f7d2766..1e18dcd4a5 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -43,6 +43,7 @@ struct AspeedSCUState {
     MemoryRegion dram_remap_alias[3];
     MemoryRegion *dram;
     int ssp_cpuid;
+    int tsp_cpuid;
 };
 
 #define AST2400_A0_SILICON_REV   0x02000303U
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index b788e6ca2a..e03f6870e7 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -103,6 +103,8 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
                             sc->uarts_num, serial_hd(2));
     object_property_set_int(OBJECT(&s->ca35), "ssp-cpuid", 4,
                             &error_abort);
+    object_property_set_int(OBJECT(&s->ca35), "tsp-cpuid", 5,
+                            &error_abort);
     if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {
         return false;
     }
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 46691080d1..5d2977b45c 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -198,6 +198,9 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
                                 &s->scu_alias);
 
+    /* SDRAM remap alias used by PSP to access TSP SDRAM */
+    memory_region_add_subregion(&s->sdram, 0, &s->scu->dram_remap_alias[2]);
+
     /* INTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
         return;
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index ae8b22fc1c..6e4b456b8c 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -391,6 +391,8 @@ static void aspeed_soc_ast2700_init(Object *obj)
                               "hw-prot-key");
     object_property_add_alias(obj, "ssp-cpuid", OBJECT(&s->scu),
                               "ssp-cpuid");
+    object_property_add_alias(obj, "tsp-cpuid", OBJECT(&s->scu),
+                              "tsp-cpuid");
 
     object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUIO);
     qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 4b74e5adcb..ec373147ab 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -629,6 +629,7 @@ static const Property aspeed_scu_properties[] = {
     DEFINE_PROP_UINT32("hw-strap2", AspeedSCUState, hw_strap2, 0),
     DEFINE_PROP_UINT32("hw-prot-key", AspeedSCUState, hw_prot_key, 0),
     DEFINE_PROP_INT32("ssp-cpuid", AspeedSCUState, ssp_cpuid, -1),
+    DEFINE_PROP_INT32("tsp-cpuid", AspeedSCUState, tsp_cpuid, -1),
     DEFINE_PROP_LINK("dram", AspeedSCUState, dram, TYPE_MEMORY_REGION,
                      MemoryRegion *),
 };
@@ -903,6 +904,20 @@ static void aspeed_2700_scu_dram_remap_alias_init(AspeedSCUState *s)
                                  "ssp.dram.remap2", s->dram,
                                  0x2c000000, 32 * MiB);
     }
+
+    if (s->tsp_cpuid > 0) {
+        /*
+         * The TSP coprocessor uses one memory alias (remap) to access a shared
+         * region in the PSP DRAM:
+         *
+         * - remap maps PSP DRAM at 0x42e000000 (size: 32MB) to TSP SDRAM
+         *   offset 0x0
+         *
+         */
+        memory_region_init_alias(&s->dram_remap_alias[2], OBJECT(s),
+                                 "tsp.dram.remap", s->dram,
+                                 0x2e000000, 32 * MiB);
+    }
 }
 
 static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,
-- 
2.43.0


