Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F47606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K/D7ktnk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN34B-0003Ft-My; Sat, 31 Oct 2026 02:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33Y-0002yt-5m
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33U-0002nT-Oo
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=joFQWn5ZXZ8jdgNi14OX734nOLXD6/depIjSvgWOCJ0=;
 b=K/D7ktnkgHyR8NYnbIa/T/zn7YZPM/krHUzPBi/uxq5zJ4shpPckK5hGMlaJ2WBTkoAGDC
 vfvCChNCVy1slGwSXJOuACsbLkVqmiRPKYoY2Qw18ndZTYcva0xQZyLXlcJF4GSsfR2dno
 PWCe/IMAqn/8evULrC9vWf5BtiL9Q/A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-35aVdnZaPfu1xKRpZo_l1Q-1; Sat,
 31 Oct 2026 02:59:04 -0400
X-MC-Unique: 35aVdnZaPfu1xKRpZo_l1Q-1
X-Mimecast-MFC-AGG-ID: 35aVdnZaPfu1xKRpZo_l1Q_1793429943
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93181195607C; Sat, 31 Oct 2026 06:59:03 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D9561800765; Sat, 31 Oct 2026 06:59:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/34] hw/arm/aspeed_ast1040: Add common init function for
 AST1040/AST1080 SoCs
Date: Sat, 31 Oct 2026 07:58:03 +0100
Message-ID: <20261031065823.191966-15-clg@redhat.com>
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

The AST1030 and AST1060 SoCs share common initialization through
aspeed_soc_ast10x0_init(). Similarly, introduce
aspeed_soc_ast10x0_g2_init() to provide common initialization for the
AST1040 and AST1080 SoCs.

Move the shared AST1040 initialization into the new common function so
that it can be reused when adding AST1080 support. The PECI and eSPI
controllers are only available on the AST1040, so their initialization
is kept in aspeed_soc_ast1040_init().

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261015063625.186708-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast1040.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
index 74a1097bd7d1..5d2713e8bb41 100644
--- a/hw/arm/aspeed_ast1040.c
+++ b/hw/arm/aspeed_ast1040.c
@@ -81,19 +81,23 @@ static const int aspeed_soc_ast1040_irqmap[] = {
     [ASPEED_DEV_PECI]      = 164,
 };
 
-static const UnimplementedDeviceConfig aspeed_soc_ast1040_unimp_devs[] = {
-    { "pwm", "aspeed.pwm", 0x740C0000, 0x10000, -1000 },
-    { "espi", "aspeed.espi", 0x74C05000, 0x1000, -1000 },
-    { "udc", "aspeed.udc", 0x74120000, 0x4000, -1000 },
-    { "jtag[0]", "aspeed.jtag0", 0x74C01000, 0x100, -1000 },
-    { "jtag[1]", "aspeed.jtag1", 0x74C09000, 0x100, -1000 },
+static const UnimplementedDeviceConfig aspeed_soc_ast10x0_g2_unimp_devs[] = {
     { "fmc-filter",  "aspeed.fmc-filter", 0x74000400, 0x1000, -1000 },
     { "spi0-filter", "aspeed.spi0-filter", 0x74010400, 0x1000, -1000 },
     { "spi1-filter", "aspeed.spi1-filter", 0x74020400, 0x1000, -1000 },
+    { "pwm", "aspeed.pwm", 0x740C0000, 0x10000, -1000 },
+    { "udc", "aspeed.udc", 0x74120000, 0x4000, -1000 },
+    { "caliptra", "aspeed.caliptra", 0x74200000, 0x100000, -1000 },
+    { "jtag[0]", "aspeed.jtag0", 0x74C01000, 0x100, -1000 },
     { "otp", "aspeed.otp", 0x74C07000, 0x800, -1000 },
-    { "atc", "aspeed.atc", 0x74C35000, 0x100, -1000 },
+    { "jtag[1]", "aspeed.jtag1", 0x74C09000, 0x100, -1000 },
     { "i3c", "aspeed.i3c", 0x74C20000, 0x8000, -1000 },
-    { "caliptra", "aspeed.caliptra", 0x74200000, 0x100000, -1000 },
+    { "atc", "aspeed.atc", 0x74C35000, 0x100, -1000 },
+    { }
+};
+
+static const UnimplementedDeviceConfig aspeed_soc_ast1040_unimp_devs[] = {
+    { "espi", "aspeed.espi", 0x74C05000, 0x1000, -1000 },
     { }
 };
 
@@ -105,7 +109,7 @@ static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCState *s, int dev)
     return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);
 }
 
-static void aspeed_soc_ast1040_init(Object *obj)
+static void aspeed_soc_ast10x0_g2_init(Object *obj)
 {
     Aspeed10x0SoCState *a = ASPEED10X0_SOC(obj);
     AspeedSoCState *s = ASPEED_SOC(obj);
@@ -117,7 +121,7 @@ static void aspeed_soc_ast1040_init(Object *obj)
 
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 
-    /* AST1040 uses the AST2700 SCUIO model */
+    /* AST10x0 G2 uses the AST2700 SCUIO model */
     object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCUIO);
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
 
@@ -129,7 +133,6 @@ static void aspeed_soc_ast1040_init(Object *obj)
     }
 
     object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);
-    object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
     object_initialize_child(obj, "gpio", &s->gpio, "aspeed.gpio-ast2700");
     for (i = 0; i < sc->sgpio_num; i++) {
         object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i],
@@ -150,6 +153,15 @@ static void aspeed_soc_ast1040_init(Object *obj)
     }
 }
 
+static void aspeed_soc_ast1040_init(Object *obj)
+{
+    AspeedSoCState *s = ASPEED_SOC(obj);
+
+    aspeed_soc_ast10x0_g2_init(obj);
+
+    object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
+}
+
 static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
 {
     Aspeed10x0SoCState *a = ASPEED10X0_SOC(dev_soc);
@@ -313,6 +325,8 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
     }
 
     /* Unimplemented devices */
+    create_unimplemented_devices(OBJECT(s), s->memory,
+                                 aspeed_soc_ast10x0_g2_unimp_devs);
     create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);
 }
 
-- 
2.56.0


