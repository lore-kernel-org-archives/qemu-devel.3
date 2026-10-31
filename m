Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BD6606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f9qjxklV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN33K-0002ed-Aj; Sat, 31 Oct 2026 02:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33H-0002dG-6I
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33F-0002kL-Dl
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fKuhhw/v+Abwi53MKx3yJFEEnBFvrzCXO8mARsc5rl4=;
 b=f9qjxklVrLP2yGs7q0DDDG0Uot0k28cjpONR1zWkSiYv6o2qiZRpiQkoJPElQWqemYroqS
 5yJYvJgXMm3BORrReU8hs4Bj5HVTUEGEv2P9O2oy1RaGRMc4G6ZAAHAREDF9oU7C6NsjSr
 +QAfoWVkoejab/UKrq/CgZIP/H2sy1w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-i_UQJlqsOq25J0qLe8HaAA-1; Sat,
 31 Oct 2026 02:58:48 -0400
X-MC-Unique: i_UQJlqsOq25J0qLe8HaAA-1
X-Mimecast-MFC-AGG-ID: i_UQJlqsOq25J0qLe8HaAA_1793429928
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1A141956089; Sat, 31 Oct 2026 06:58:47 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C77F1800765; Sat, 31 Oct 2026 06:58:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/34] hw/arm/aspeed_ast1040: Add FMC and SPI controllers
Date: Sat, 31 Oct 2026 07:57:55 +0100
Message-ID: <20261031065823.191966-7-clg@redhat.com>
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
References: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add the FMC, SPI0 and SPI1 controllers to the AST1040 SoC. Map their
register and flash memory regions, connect their interrupts, and link
the DMA DRAM region to internal Hyper RAM.

The AST1040 supports two SPI controllers, SPI0 and SPI1.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261028023154.48395-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast1040.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
index 0b078f10c403..6e3b6900e0fb 100644
--- a/hw/arm/aspeed_ast1040.c
+++ b/hw/arm/aspeed_ast1040.c
@@ -103,7 +103,9 @@ static void aspeed_soc_ast1040_init(Object *obj)
     Aspeed10x0SoCState *a = ASPEED10X0_SOC(obj);
     AspeedSoCState *s = ASPEED_SOC(obj);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    char typename[64];
     int i;
+
     object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
 
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
@@ -132,6 +134,13 @@ static void aspeed_soc_ast1040_init(Object *obj)
         object_initialize_child(obj, "wdt[*]", &s->wdt[i],
                                 "aspeed.wdt-ast2700");
     }
+
+    object_initialize_child(obj, "fmc", &s->fmc, "aspeed.fmc-ast1040");
+
+    for (i = 0; i < sc->spis_num; i++) {
+        snprintf(typename, sizeof(typename), "aspeed.spi%d-ast1040", i);
+        object_initialize_child(obj, "spi[*]", &s->spi[i], typename);
+    }
 }
 
 static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
@@ -268,6 +277,34 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
     }
 
+    /* FMC, The number of CS is set at the board level */
+    object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(&s->sram[1]),
+            &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 0,
+                    sc->memmap[ASPEED_DEV_FMC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
+                    ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_FMC));
+
+    /* SPI */
+    for (i = 0; i < sc->spis_num; i++) {
+        object_property_set_link(OBJECT(&s->spi[i]), "dram",
+                                 OBJECT(&s->sram[1]), &error_abort);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
+            return;
+        }
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 0,
+                        sc->memmap[ASPEED_DEV_SPI0 + i]);
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,
+                        ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                           aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_SPI0 + i));
+    }
+
     /* Unimplemented devices */
     create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);
 }
@@ -292,6 +329,7 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *data)
     sc->uarts_num       = 13;
     sc->sgpio_num       = 2;
     sc->wdts_num        = 8;
+    sc->spis_num        = 2;
     sc->uarts_base      = ASPEED_DEV_UART0;
     sc->irqmap          = aspeed_soc_ast1040_irqmap;
     sc->memmap          = aspeed_soc_ast1040_memmap;
-- 
2.56.0


