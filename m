Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02A2CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hvy-0005EU-24; Mon, 13 Oct 2025 08:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvM-0004g8-Tc
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvE-00080m-6e
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UEdbp2eXeKKamlc+9pxois55NeQtijMnAB2hMYnvI08=;
 b=ci0ikWKDawtde/78HCMp3R8I3iJxo7NxrTD+GnZh5jQgdmSyFwUtVhkLw8vH6nPvRI0rv+
 xE5oVkbnq3FXz+RhPepX1lhRLJ6lZHmsmDNsfZIHl1KTPYucwq656TcB1MqtV3YmDrJfCU
 0y/hUv//jWx+V6TnREhtdNYhwVFZlXg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-Z4Bl88HUNj2ZG0HBgRW6qA-1; Mon,
 13 Oct 2025 08:44:59 -0400
X-MC-Unique: Z4Bl88HUNj2ZG0HBgRW6qA-1
X-Mimecast-MFC-AGG-ID: Z4Bl88HUNj2ZG0HBgRW6qA_1760359499
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC54E1956096; Mon, 13 Oct 2025 12:44:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68E8C1800446; Mon, 13 Oct 2025 12:44:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/29] hw/arm/aspeed: Remove AspeedSoCClass dependency from
 aspeed_soc_cpu_type() API
Date: Mon, 13 Oct 2025 14:44:08 +0200
Message-ID: <20251013124421.71977-18-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251013054334.955331-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
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
index c870bf55865e..385b657b5096 100644
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
index c446e70b24a9..dab012aa953d 100644
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
index c7b0f21887b5..53c2a5156dd5 100644
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
index 03e5df96bb4f..0299d9792918 100644
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
index 80ec5996c1d1..490e98b924df 100644
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
index 4e0efaef07c0..d83f90ef00ce 100644
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
index 853339119ff6..2f018e9e588a 100644
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
index ddcbba0020ee..16c7c4bb78d4 100644
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
2.51.0


