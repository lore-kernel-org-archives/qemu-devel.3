Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FA4CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSsD-00029U-GM; Mon, 08 Jun 2026 01:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrd-0001hU-SN
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrc-0000cf-27
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZfVBhAkKSFXr5nO8islHlQFJb52F9RvRM2gwOrdIIQ4=;
 b=ECdlhCcM7a7n+Xy5HdeqTOFM0RUrU4rszj7aBuS4SMgmU6Vd4rkNNFNuBdtzbqocje0I8t
 JKFxPBZUu45JloYq/zGWh5M7PVmzJ/FwHnQZoJZjHCbr1SmflWecnG+yjaCZXatDBVq22Q
 yvjpgSw1rIetAxfxDxEmGDNuzoD8wNo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-1TB_7Lz6Nr2TEF_LQlnUnA-1; Mon,
 08 Jun 2026 01:49:27 -0400
X-MC-Unique: 1TB_7Lz6Nr2TEF_LQlnUnA-1
X-Mimecast-MFC-AGG-ID: 1TB_7Lz6Nr2TEF_LQlnUnA_1780897766
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B88791800473; Mon,  8 Jun 2026 05:49:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4612D1686; Mon,  8 Jun 2026 05:49:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/37] hw/arm/aspeed_ast1040: Introduce PECI support
Date: Mon,  8 Jun 2026 07:48:17 +0200
Message-ID: <20260608054826.346488-29-clg@redhat.com>
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

Introduce PECI support for the AST1040 SoC model.

This change adds the PECI MMIO region and IRQ mapping,
initializes the PECI device instance, and realizes the
controller during SoC initialization.

The PECI controller is mapped at 0x74C1F000 and connected
to IRQ 164.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260603040027.938816-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast1040.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
index b736e690e5e2..9ae0a0e7a4a1 100644
--- a/hw/arm/aspeed_ast1040.c
+++ b/hw/arm/aspeed_ast1040.c
@@ -31,6 +31,7 @@ static const hwaddr aspeed_soc_ast1040_memmap[] = {
     [ASPEED_DEV_SGPIOM0]   = 0x74C0C000,
     [ASPEED_DEV_SGPIOM1]   = 0x74C0D000,
     [ASPEED_DEV_I2C]       = 0x74C0F000,
+    [ASPEED_DEV_PECI]      = 0x74C1F000,
     [ASPEED_DEV_I3C]       = 0x74C20000,
     [ASPEED_DEV_UART0]     = 0x74C33000,
     [ASPEED_DEV_UART1]     = 0x74C33100,
@@ -76,6 +77,7 @@ static const int aspeed_soc_ast1040_irqmap[] = {
     [ASPEED_DEV_UART11]    = 146,
     [ASPEED_DEV_UART12]    = 147,
     [ASPEED_DEV_JTAG0]     = 162,
+    [ASPEED_DEV_PECI]      = 164,
 };
 
 static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCState *s, int dev)
@@ -108,6 +110,7 @@ static void aspeed_soc_ast1040_init(Object *obj)
     }
 
     object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);
+    object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
 
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVICE);
@@ -199,6 +202,15 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_ADC));
 
+    /* PECI */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
+                    sc->memmap[ASPEED_DEV_PECI]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_PECI));
+
     /* Unimplemented peripherals */
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
                                   "aspeed.pwm",
-- 
2.54.0


