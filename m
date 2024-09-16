Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FFBC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 19:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqGwl-00036m-0L; Mon, 16 Sep 2024 14:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqGwE-0001Oy-Vg
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 14:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqGwB-0003MN-QP
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 14:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726513141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J69EhvPmH7a9b/ssskl31M0xPvcGDgAyThJiJBY7Dw8=;
 b=hYw0iD+uudTc11fk0Ca3/H5Rv61KPjuxAvThOorITnkU7UhpTACEpKeOnqZ6PWLdLsbIJa
 K+eAAVpRY5i9Rn/Em8ULx63XstDvra9MLhMtcaWFZv85XbiLJdIBoLLxFLkmtfJd5YE5vl
 pJU8ouHtZogaQptqweEKyhxEoy9ZOuE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-82-7BpgiMhebPCcZTDXIww-1; Mon,
 16 Sep 2024 14:57:36 -0400
X-MC-Unique: 82-7BpgiMhebPCcZTDXIww-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9E07195608C; Mon, 16 Sep 2024 18:57:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.44])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42AE8195605A; Mon, 16 Sep 2024 18:57:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/12] aspeed/soc: Support I2C for AST2700
Date: Mon, 16 Sep 2024 20:57:06 +0200
Message-ID: <20240916185708.574546-11-clg@redhat.com>
In-Reply-To: <20240916185708.574546-1-clg@redhat.com>
References: <20240916185708.574546-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add I2C model for AST2700 I2C support.
The I2C controller registers base address is start at
0x14C0_F000 and its address space is 0x2000.

The AST2700 I2C controller has one source INTC per bus.
I2C buses interrupt are connected to GICINT130_INTC
from bit 0 to bit 15.
I2C bus 0 is connected to GICINT130_INTC at bit 0.
I2C bus 15 is connected to GICINT130_INTC at bit 15.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index a5eb78524f6a..761ee116579c 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -61,6 +61,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_GIC_DIST]      =  0x12200000,
     [ASPEED_GIC_REDIST]    =  0x12280000,
     [ASPEED_DEV_ADC]       =  0x14C00000,
+    [ASPEED_DEV_I2C]       =  0x14C0F000,
 };
 
 #define AST2700_MAX_IRQ 288
@@ -369,6 +370,9 @@ static void aspeed_soc_ast2700_init(Object *obj)
 
     snprintf(typename, sizeof(typename), "aspeed.adc-%s", socname);
     object_initialize_child(obj, "adc", &s->adc, typename);
+
+    snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
+    object_initialize_child(obj, "i2c", &s->i2c, typename);
 }
 
 /*
@@ -452,6 +456,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     AspeedINTCClass *ic = ASPEED_INTC_GET_CLASS(&a->intc);
     g_autofree char *sram_name = NULL;
+    qemu_irq irq;
 
     /* Default boot region (SPI memory or ROMs) */
     memory_region_init(&s->spi_boot_container, OBJECT(s),
@@ -634,6 +639,25 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
 
+    /* I2C */
+    object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(s->dram_mr),
+                             &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_DEV_I2C]);
+    for (i = 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
+        /*
+         * The AST2700 I2C controller has one source INTC per bus.
+         * I2C buses interrupt are connected to GICINT130_INTC
+         * from bit 0 to bit 15.
+         * I2C bus 0 is connected to GICINT130_INTC at bit 0.
+         * I2C bus 15 is connected to GICINT130_INTC at bit 15.
+         */
+        irq = aspeed_soc_ast2700_get_irq_index(s, ASPEED_DEV_I2C, i);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);
+    }
+
     create_unimplemented_device("ast2700.dpmcu", 0x11000000, 0x40000);
     create_unimplemented_device("ast2700.iomem0", 0x12000000, 0x01000000);
     create_unimplemented_device("ast2700.iomem1", 0x14000000, 0x01000000);
-- 
2.46.0


