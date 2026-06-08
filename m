Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E966CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSsK-0002kI-5o; Mon, 08 Jun 2026 01:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrx-0001zM-4b
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSru-0000nR-Ew
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dzPcXMjJVMFZRcH4S5AUyUHbZ/WOYXon1snH6e5CcnY=;
 b=CK/577BkmTVtEOIh9dWWlqSkMep/Vw25EXLVSkQapP5kP9Ai/Yd1DgrWoF1iShtfpsoxSz
 P0bxoAY4vhLGNjpVsWQK28VRWdW85SUdafHq0G43cILjAHXkI7/cQXXS/oQlwcUrQ0B+rk
 UEIesBKF1e8Yc7Y6SWsGH0MjzFygS04=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-tMxI7h_6NDamWSY6B7aFuw-1; Mon,
 08 Jun 2026 01:49:35 -0400
X-MC-Unique: tMxI7h_6NDamWSY6B7aFuw-1
X-Mimecast-MFC-AGG-ID: tMxI7h_6NDamWSY6B7aFuw_1780897774
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 976F71956089; Mon,  8 Jun 2026 05:49:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D1AD765; Mon,  8 Jun 2026 05:49:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 32/37] hw/arm/aspeed_ast1040: Introduce I2C support
Date: Mon,  8 Jun 2026 07:48:21 +0200
Message-ID: <20260608054826.346488-33-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

Introduce I2C controller support for the AST1040 SoC model.

The I2C model type is selected from the SoC type name, allowing the AST1040
SoC to use the corresponding aspeed.i2c-ast1040 model.

The I2C controller is mapped at 0x74C0F000 and uses IRQs
64 - 77, with one IRQ assigned per I2C bus.

The controller DRAM link is connected to SRAM1 (HyperRAM)
for DMA support.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260603040027.938816-9-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast1040.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
index 77211ce1f362..6d1cb9b102d5 100644
--- a/hw/arm/aspeed_ast1040.c
+++ b/hw/arm/aspeed_ast1040.c
@@ -117,6 +117,7 @@ static void aspeed_soc_ast1040_init(Object *obj)
         object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i],
                                 "aspeed.sgpio-ast2700");
     }
+    object_initialize_child(obj, "i2c", &s->i2c, TYPE_ASPEED_1040_I2C);
 
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVICE);
@@ -233,6 +234,21 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_SGPIOM0 + i));
     }
 
+    /* I2C */
+    object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(&s->sram[1]),
+                             &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,
+                    sc->memmap[ASPEED_DEV_I2C]);
+    for (i = 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
+        qemu_irq irq = qdev_get_gpio_in(DEVICE(&a->armv7m),
+                                        sc->irqmap[ASPEED_DEV_I2C] + i);
+        /* The AST1040 I2C controller has one IRQ per bus. */
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);
+    }
+
     /* Unimplemented peripherals */
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
                                   "aspeed.pwm",
-- 
2.54.0


