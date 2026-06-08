Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F353CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSsI-0002em-TL; Mon, 08 Jun 2026 01:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrs-0001wx-Rk
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrr-0000ls-7a
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SSUvNO9W+5Js9bcLGiZp5dMbvbLWfDEK7WlzONfr4Fs=;
 b=W3xmX/wsIcDsT+4lbQbGELruAu1MJWKVC3LF4wmOEQrtHvb42YkTfHArSQUWA8yV249mvN
 9zD91oZPUhyiaMOOYaVqy2qYlbwQj/dlimkLcnvOdQFzaqu4CREMAWgP64LEJBtn9rom72
 EEunMj0XXdXlXxwmabWTmmGO3qVtX7A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-0IVpvVGcPdq2Uq1WsNUY9Q-1; Mon,
 08 Jun 2026 01:49:39 -0400
X-MC-Unique: 0IVpvVGcPdq2Uq1WsNUY9Q-1
X-Mimecast-MFC-AGG-ID: 0IVpvVGcPdq2Uq1WsNUY9Q_1780897778
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90A861800473; Mon,  8 Jun 2026 05:49:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BB401624; Mon,  8 Jun 2026 05:49:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 34/37] hw/arm/aspeed_ast1040: Reuse AST2700 watchdog models
Date: Mon,  8 Jun 2026 07:48:23 +0200
Message-ID: <20260608054826.346488-35-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Instantiate and realize the watchdog models for the AST1040 SoC.

The AST1040 watchdog controller is compatible with the AST2700 watchdog
controller, so reuse the existing AST2700 watchdog model.

Configure the AST1040 SoC with 8 watchdog instances and map them to
their corresponding MMIO regions. The first watchdog controller (WDT0) is
located at 0x74c37000, with subsequent watchdogs placed according to the
controller register space size.

Each watchdog is linked to the SCU device before realization to provide the
required reset and system control interactions.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260603040027.938816-11-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast1040.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
index 6d1cb9b102d5..57ffc0807ab7 100644
--- a/hw/arm/aspeed_ast1040.c
+++ b/hw/arm/aspeed_ast1040.c
@@ -119,6 +119,11 @@ static void aspeed_soc_ast1040_init(Object *obj)
     }
     object_initialize_child(obj, "i2c", &s->i2c, TYPE_ASPEED_1040_I2C);
 
+    for (i = 0; i < sc->wdts_num; i++) {
+        object_initialize_child(obj, "wdt[*]", &s->wdt[i],
+                                "aspeed.wdt-ast2700");
+    }
+
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE);
@@ -249,6 +254,19 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);
     }
 
+    /* Watch dog */
+    for (i = 0; i < sc->wdts_num; i++) {
+        AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
+        hwaddr wdt_offset = sc->memmap[ASPEED_DEV_WDT] + i * awc->iosize;
+
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu),
+                                 &error_abort);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
+            return;
+        }
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
+    }
+
     /* Unimplemented peripherals */
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
                                   "aspeed.pwm",
@@ -290,6 +308,7 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *data)
     sc->sram_size[1]    = 16 * MiB; /* Hyper RAM */
     sc->uarts_num       = 13;
     sc->sgpio_num       = 2;
+    sc->wdts_num        = 8;
     sc->uarts_base      = ASPEED_DEV_UART0;
     sc->irqmap          = aspeed_soc_ast1040_irqmap;
     sc->memmap          = aspeed_soc_ast1040_memmap;
-- 
2.54.0


