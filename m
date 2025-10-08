Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A211FCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 03:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Kl5-0001nq-LV; Tue, 07 Oct 2025 23:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6Kl3-0001n3-8R; Tue, 07 Oct 2025 23:22:29 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6Kl1-0000T8-GQ; Tue, 07 Oct 2025 23:22:29 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 8 Oct
 2025 11:22:09 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 8 Oct 2025 11:22:09 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 04/16] hw/arm/aspeed: Remove AspeedSoCClass dependency from
 aspeed_soc_cpu_type() API
Date: Wed, 8 Oct 2025 11:21:49 +0800
Message-ID: <20251008032207.593353-5-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008032207.593353-1-jamin_lin@aspeedtech.com>
References: <20251008032207.593353-1-jamin_lin@aspeedtech.com>
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

Refactor the aspeed_soc_cpu_type() helper to remove its dependency on
AspeedSoCClass and make CPU type retrieval more generic.

The function now takes valid_cpu_types as a const char * const *
parameter instead of requiring a full AspeedSoCClass instance.
All corresponding call sites in various Aspeed SoC initialization files
(aspeed_ast10x0.c, aspeed_ast2400.c, aspeed_ast2600.c,
aspeed_ast27x0.c, and related variants) are updated accordingly.

This change simplifies the API, eliminates unnecessary type coupling,
and improves code reusability across different SoC families.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h |  3 +--
 hw/arm/aspeed_ast10x0.c     |  3 ++-
 hw/arm/aspeed_ast2400.c     |  2 +-
 hw/arm/aspeed_ast2600.c     |  2 +-
 hw/arm/aspeed_ast27x0-ssp.c |  3 ++-
 hw/arm/aspeed_ast27x0-tsp.c |  3 ++-
 hw/arm/aspeed_ast27x0.c     |  2 +-
 hw/arm/aspeed_soc_common.c  | 10 +++++-----
 8 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index c870bf5586..385b657b50 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -202,8 +202,6 @@ struct AspeedSoCClass {
     bool (*boot_from_emmc)(AspeedSoCState *s);
 };
 
-const char *aspeed_soc_cpu_type(AspeedSoCClass *sc);
-
 enum {
     ASPEED_DEV_VBOOTROM,
     ASPEED_DEV_SPI_BOOT,
@@ -304,6 +302,7 @@ enum {
     ASPEED_DEV_IPC1,
 };
 
+const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
 qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
 bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp);
 void aspeed_soc_uart_set_chr(SerialMM *uart, int dev, int uarts_base,
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index c446e70b24..dab012aa95 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -211,7 +211,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     /* AST1030 CPU Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
-    qdev_prop_set_string(armv7m, "cpu-type", aspeed_soc_cpu_type(sc));
+    qdev_prop_set_string(armv7m, "cpu-type",
+                         aspeed_soc_cpu_type(sc->valid_cpu_types));
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
     object_property_set_link(OBJECT(&a->armv7m), "memory",
                              OBJECT(s->memory), &error_abort);
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index c7b0f21887..53c2a5156d 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -157,7 +157,7 @@ static void aspeed_ast2400_soc_init(Object *obj)
 
     for (i = 0; i < sc->num_cpus; i++) {
         object_initialize_child(obj, "cpu[*]", &a->cpu[i],
-                                aspeed_soc_cpu_type(sc));
+                                aspeed_soc_cpu_type(sc->valid_cpu_types));
     }
 
     snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 03e5df96bb..0299d97929 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -167,7 +167,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
 
     for (i = 0; i < sc->num_cpus; i++) {
         object_initialize_child(obj, "cpu[*]", &a->cpu[i],
-                                aspeed_soc_cpu_type(sc));
+                                aspeed_soc_cpu_type(sc->valid_cpu_types));
     }
 
     snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 80ec5996c1..490e98b924 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -174,7 +174,8 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     /* AST27X0 SSP Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
-    qdev_prop_set_string(armv7m, "cpu-type", aspeed_soc_cpu_type(sc));
+    qdev_prop_set_string(armv7m, "cpu-type",
+                         aspeed_soc_cpu_type(sc->valid_cpu_types));
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
     object_property_set_link(OBJECT(&a->armv7m), "memory",
                              OBJECT(s->memory), &error_abort);
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 4e0efaef07..d83f90ef00 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -174,7 +174,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     /* AST27X0 TSP Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
-    qdev_prop_set_string(armv7m, "cpu-type", aspeed_soc_cpu_type(sc));
+    qdev_prop_set_string(armv7m, "cpu-type",
+                         aspeed_soc_cpu_type(sc->valid_cpu_types));
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
     object_property_set_link(OBJECT(&a->armv7m), "memory",
                              OBJECT(s->memory), &error_abort);
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 853339119f..2f018e9e58 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -436,7 +436,7 @@ static void aspeed_soc_ast2700_init(Object *obj)
 
     for (i = 0; i < sc->num_cpus; i++) {
         object_initialize_child(obj, "cpu[*]", &a->cpu[i],
-                                aspeed_soc_cpu_type(sc));
+                                aspeed_soc_cpu_type(sc->valid_cpu_types));
     }
 
     object_initialize_child(obj, "gic", &a->gic, gicv3_class_name());
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index ddcbba0020..16c7c4bb78 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -22,12 +22,12 @@
 #include "qemu/datadir.h"
 
 
-const char *aspeed_soc_cpu_type(AspeedSoCClass *sc)
+const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types)
 {
-    assert(sc->valid_cpu_types);
-    assert(sc->valid_cpu_types[0]);
-    assert(!sc->valid_cpu_types[1]);
-    return sc->valid_cpu_types[0];
+    assert(valid_cpu_types);
+    assert(valid_cpu_types[0]);
+    assert(!valid_cpu_types[1]);
+    return valid_cpu_types[0];
 }
 
 qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev)
-- 
2.43.0


