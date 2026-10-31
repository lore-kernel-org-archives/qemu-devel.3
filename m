Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B943606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gNqg0cnh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN35J-0005Ml-Dr; Sat, 31 Oct 2026 03:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33k-00037d-Vp
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33e-0002qz-8S
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z/p2aV8JLJIWOtuKLRWOx3ihTzVk9+xiCB8jKQyJpoQ=;
 b=gNqg0cnhLDOud/6/20JFf3txiPXuJII0a2YbGsZHkdX46RiCutDxNGjfInLh2vvFH0sERG
 7pIoTXIrP5ad3BLd6npZmzb+JB6uNQA9718oM6W6x332Z20h7ppgfBx/j0MMwgm+dZ4UfD
 OCbFguXtVlCSusOF6hIdFMQnYMPYWwA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-0fV0YHykNuq_y8Gooaa2QQ-1; Sat,
 31 Oct 2026 02:59:06 -0400
X-MC-Unique: 0fV0YHykNuq_y8Gooaa2QQ-1
X-Mimecast-MFC-AGG-ID: 0fV0YHykNuq_y8Gooaa2QQ_1793429945
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8715E1956049; Sat, 31 Oct 2026 06:59:05 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BF5B1800765; Sat, 31 Oct 2026 06:59:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/34] hw/arm/aspeed_ast1040: Add common realize function for
 AST1040/AST1080 SoCs
Date: Sat, 31 Oct 2026 07:58:04 +0100
Message-ID: <20261031065823.191966-16-clg@redhat.com>
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
References: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jamin Lin <jamin_lin@aspeedtech.com>

AST1040 and AST1080 are the next-generation SoCs of AST1030 and AST1060,
respectively.

The AST1030 and AST1060 SoCs share common realization through
aspeed_soc_ast10x0_realize(). Similarly, introduce
aspeed_soc_ast10x0_g2_realize() to provide common realization for the
AST1040 and AST1080 SoCs.

Move the shared AST1040 realization into the new common function so that
it can be reused when adding AST1080 support. The PECI and eSPI
controllers are only available on the AST1040, so their realization is
kept in aspeed_soc_ast1040_realize().

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261015063625.186708-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast1040.c | 62 ++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
index 5d2713e8bb41..28abbe70104d 100644
--- a/hw/arm/aspeed_ast1040.c
+++ b/hw/arm/aspeed_ast1040.c
@@ -162,10 +162,9 @@ static void aspeed_soc_ast1040_init(Object *obj)
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
 }
 
-static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
+static bool aspeed_soc_ast10x0_g2_realize(Aspeed10x0SoCState *a, Error **errp)
 {
-    Aspeed10x0SoCState *a = ASPEED10X0_SOC(dev_soc);
-    AspeedSoCState *s = ASPEED_SOC(dev_soc);
+    AspeedSoCState *s = ASPEED_SOC(a);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     g_autofree char *hyperram_name = NULL;
     g_autofree char *sram_name = NULL;
@@ -176,10 +175,10 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
 
     if (!clock_has_source(s->sysclk)) {
         error_setg(errp, "sysclk clock must be wired up by the board code");
-        return;
+        return false;
     }
 
-    /* AST1040 CPU Core */
+    /* AST10x0 G2 CPU Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
     qdev_prop_set_string(armv7m, "cpu-type",
@@ -196,7 +195,7 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
                            sc->sram_size[0], &err);
     if (err) {
         error_propagate(errp, err);
-        return;
+        return false;
     }
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM0],
                                 &s->sram[0]);
@@ -208,14 +207,14 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
                            sc->sram_size[1], &err);
     if (err) {
         error_propagate(errp, err);
-        return;
+        return false;
     }
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],
                                 &s->sram[1]);
 
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
                     sc->memmap[ASPEED_DEV_SCU]);
@@ -224,7 +223,7 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
         if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
                                      sc->memmap[uart], errp)) {
-            return;
+            return false;
         }
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
                            aspeed_soc_ast1040_get_irq(s, uart));
@@ -232,25 +231,16 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
 
     /* ADC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
                     sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_ADC));
 
-    /* PECI */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
-        return;
-    }
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
-                    sc->memmap[ASPEED_DEV_PECI]);
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
-                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_PECI));
-
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
@@ -260,7 +250,7 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
     /* SGPIO */
     for (i = 0; i < sc->sgpio_num; i++) {
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {
-            return;
+            return false;
         }
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
                         sc->memmap[ASPEED_DEV_SGPIOM0 + i]);
@@ -272,7 +262,7 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
     object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(&s->sram[1]),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,
                     sc->memmap[ASPEED_DEV_I2C]);
@@ -291,7 +281,7 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
         object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu),
                                  &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
-            return;
+            return false;
         }
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
     }
@@ -300,7 +290,7 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
     object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(&s->sram[1]),
             &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 0,
                     sc->memmap[ASPEED_DEV_FMC]);
@@ -314,7 +304,7 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
         object_property_set_link(OBJECT(&s->spi[i]), "dram",
                                  OBJECT(&s->sram[1]), &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
-            return;
+            return false;
         }
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 0,
                         sc->memmap[ASPEED_DEV_SPI0 + i]);
@@ -328,6 +318,28 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_devices(OBJECT(s), s->memory,
                                  aspeed_soc_ast10x0_g2_unimp_devs);
     create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);
+
+    return true;
+}
+
+static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
+{
+    Aspeed10x0SoCState *a = ASPEED10X0_SOC(dev_soc);
+    AspeedSoCState *s = ASPEED_SOC(a);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+
+    if (!aspeed_soc_ast10x0_g2_realize(a, errp)) {
+        return;
+    }
+
+    /* PECI */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
+                    sc->memmap[ASPEED_DEV_PECI]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_PECI));
 }
 
 static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *data)
-- 
2.56.0


