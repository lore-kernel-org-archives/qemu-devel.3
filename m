Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E925CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSsJ-0002gh-7g; Mon, 08 Jun 2026 01:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrj-0001r3-D9
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrf-0000hB-Oi
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eDZtwZRXZZCr66ELqoFMvh5WzweIfksK+cS5qV8a/lY=;
 b=EgZiQb7Xc37pTvRsf5qCGFpdQXCdUXSOtPMtZDTi3PNW/fx6FvCy+j+wdy6AFMrdauxl7Z
 FZitaLyKkf6URW0YmYYSp3MHhfh7dbh1j2TEQjudlZw17izvqUQOkoOHXcK9KMF27V/aKp
 jUrWjRMwdn1Tp84P9pRTKX7abGbfoKk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-tEG4Y8XUNHGlmxHjRLN5Bg-1; Mon,
 08 Jun 2026 01:49:31 -0400
X-MC-Unique: tEG4Y8XUNHGlmxHjRLN5Bg-1
X-Mimecast-MFC-AGG-ID: tEG4Y8XUNHGlmxHjRLN5Bg_1780897770
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CE361800599; Mon,  8 Jun 2026 05:49:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 28D961624; Mon,  8 Jun 2026 05:49:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 30/37] hw/arm/aspeed_ast1040: Add SGPIO controller support
Date: Mon,  8 Jun 2026 07:48:19 +0200
Message-ID: <20260608054826.346488-31-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The AST1040 SGPIO controller is compatible with the AST2700
SGPIO controller implementation.

AST1040 contains two SGPIO controllers, so reuse the existing
"aspeed.sgpio-ast2700" device model instead of keeping them as
unimplemented devices.

MMIO mapping:
- SGPIOM0 : 0x74C0C000
- SGPIOM1 : 0x74C0D000

IRQ mapping:
- SGPIOM0 : IRQ 85
- SGPIOM1 : IRQ 88

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260603040027.938816-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast1040.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
index c6b22186ce72..77211ce1f362 100644
--- a/hw/arm/aspeed_ast1040.c
+++ b/hw/arm/aspeed_ast1040.c
@@ -56,6 +56,7 @@ static const int aspeed_soc_ast1040_irqmap[] = {
     [ASPEED_DEV_ADC]       = 80,
     [ASPEED_DEV_GPIO]      = 82,
     [ASPEED_DEV_SGPIOM0]   = 85,
+    [ASPEED_DEV_SGPIOM1]   = 88,
     [ASPEED_DEV_TIMER1]    = 92,
     [ASPEED_DEV_I3C]       = 96, /* 96 ~ 103 */
     [ASPEED_DEV_WDT]       = 112,
@@ -112,14 +113,14 @@ static void aspeed_soc_ast1040_init(Object *obj)
     object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
     object_initialize_child(obj, "gpio", &s->gpio, "aspeed.gpio-ast2700");
+    for (i = 0; i < sc->sgpio_num; i++) {
+        object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i],
+                                "aspeed.sgpio-ast2700");
+    }
 
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "sgpiom[0]", &s->sgpiom[0],
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "sgpiom[1]", &s->sgpiom[1],
-                            TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "jtag[0]", &s->jtag[0],
                             TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "jtag[1]", &s->jtag[1],
@@ -221,6 +222,17 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_GPIO));
 
+    /* SGPIO */
+    for (i = 0; i < sc->sgpio_num; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {
+            return;
+        }
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
+                        sc->memmap[ASPEED_DEV_SGPIOM0 + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_SGPIOM0 + i));
+    }
+
     /* Unimplemented peripherals */
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
                                   "aspeed.pwm",
@@ -234,14 +246,6 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
                                   "aspeed.udc",
                                   sc->memmap[ASPEED_DEV_UDC], 0x4000);
 
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[0]),
-                                  "aspeed.sgpiom0",
-                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x1000);
-
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[1]),
-                                  "aspeed.sgpiom1",
-                                  sc->memmap[ASPEED_DEV_SGPIOM1], 0x1000);
-
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),
                                   "aspeed.jtag0",
                                   sc->memmap[ASPEED_DEV_JTAG0], 0x100);
@@ -269,6 +273,7 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *data)
     sc->sram_size[0]    = 128 * KiB;
     sc->sram_size[1]    = 16 * MiB; /* Hyper RAM */
     sc->uarts_num       = 13;
+    sc->sgpio_num       = 2;
     sc->uarts_base      = ASPEED_DEV_UART0;
     sc->irqmap          = aspeed_soc_ast1040_irqmap;
     sc->memmap          = aspeed_soc_ast1040_memmap;
-- 
2.54.0


