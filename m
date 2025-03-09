Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D637EC28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH5q-0002il-Q0; Sun, 09 Mar 2025 09:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5h-0001zn-Aq
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5b-0003w8-9W
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63jKPfrJ2QNjFYHlTPjmt0JRQvPdat4i8OcOgzRGW8E=;
 b=Mxj5F9p3JQK961GcdRM/HqR6ClUK8HHBw9o3nshc6aaqSU1zlu1P0n145rZQJcgSH1Nqm2
 C3i7nHp+qF14WYNat5fFi0Q3f80zTxkGdlFTx2ptEX5pbFMzD6eT3e3c5MWtDVElKDinJD
 eU2OqPtTT0mYYvF4dGLuwhVUUKQVNQo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-el5kCD35O62kTLTtS5YPHg-1; Sun,
 09 Mar 2025 09:53:07 -0400
X-MC-Unique: el5kCD35O62kTLTtS5YPHg-1
X-Mimecast-MFC-AGG-ID: el5kCD35O62kTLTtS5YPHg_1741528386
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FB1F195608A; Sun,  9 Mar 2025 13:53:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 514911956094; Sun,  9 Mar 2025 13:53:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 36/46] hw/arm/aspeed_ast27x0.c Support AST2700 A1 GIC Interrupt
 Mapping
Date: Sun,  9 Mar 2025 14:51:20 +0100
Message-ID: <20250309135130.545764-37-clg@redhat.com>
In-Reply-To: <20250309135130.545764-1-clg@redhat.com>
References: <20250309135130.545764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently, these IRQ tables support from GIC 128 - 136 for AST2700 A0.
These IRQ tables can be reused for AST2700 A1 from GIC 192 - 197.
Updates the interrupt mapping to include support for AST2700 A1 by extending
the existing mappings to the new GIC range.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250307035945.3698802-20-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0.c | 77 ++++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 27 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 3cb95210a06f..9e5f4a208453 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -120,21 +120,27 @@ static const int aspeed_soc_ast2700a0_irqmap[] = {
 };
 
 /* GICINT 128 */
-static const int aspeed_soc_ast2700_gic128_intcmap[] = {
+/* GICINT 192 */
+static const int ast2700_gic128_gic192_intcmap[] = {
     [ASPEED_DEV_LPC]       = 0,
     [ASPEED_DEV_IBT]       = 2,
     [ASPEED_DEV_KCS]       = 4,
 };
 
+/* GICINT 129 */
+/* GICINT 193 */
+
 /* GICINT 130 */
-static const int aspeed_soc_ast2700_gic130_intcmap[] = {
+/* GICINT 194 */
+static const int ast2700_gic130_gic194_intcmap[] = {
     [ASPEED_DEV_I2C]        = 0,
     [ASPEED_DEV_ADC]        = 16,
     [ASPEED_DEV_GPIO]       = 18,
 };
 
 /* GICINT 131 */
-static const int aspeed_soc_ast2700_gic131_intcmap[] = {
+/* GICINT 195 */
+static const int ast2700_gic131_gic195_intcmap[] = {
     [ASPEED_DEV_I3C]       = 0,
     [ASPEED_DEV_WDT]       = 16,
     [ASPEED_DEV_FMC]       = 25,
@@ -142,7 +148,8 @@ static const int aspeed_soc_ast2700_gic131_intcmap[] = {
 };
 
 /* GICINT 132 */
-static const int aspeed_soc_ast2700_gic132_intcmap[] = {
+/* GICINT 196 */
+static const int ast2700_gic132_gic196_intcmap[] = {
     [ASPEED_DEV_ETH1]      = 0,
     [ASPEED_DEV_ETH2]      = 1,
     [ASPEED_DEV_ETH3]      = 2,
@@ -161,24 +168,26 @@ static const int aspeed_soc_ast2700_gic132_intcmap[] = {
 };
 
 /* GICINT 133 */
-static const int aspeed_soc_ast2700_gic133_intcmap[] = {
+/* GICINT 197 */
+static const int ast2700_gic133_gic197_intcmap[] = {
     [ASPEED_DEV_SDHCI]     = 1,
     [ASPEED_DEV_PECI]      = 4,
 };
 
 /* GICINT 128 ~ 136 */
+/* GICINT 192 ~ 201 */
 struct gic_intc_irq_info {
     int irq;
     const int *ptr;
 };
 
-static const struct gic_intc_irq_info aspeed_soc_ast2700_gic_intcmap[] = {
-    {128,  aspeed_soc_ast2700_gic128_intcmap},
+static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
+    {128,  ast2700_gic128_gic192_intcmap},
     {129,  NULL},
-    {130,  aspeed_soc_ast2700_gic130_intcmap},
-    {131,  aspeed_soc_ast2700_gic131_intcmap},
-    {132,  aspeed_soc_ast2700_gic132_intcmap},
-    {133,  aspeed_soc_ast2700_gic133_intcmap},
+    {130,  ast2700_gic130_gic194_intcmap},
+    {131,  ast2700_gic131_gic195_intcmap},
+    {132,  ast2700_gic132_gic196_intcmap},
+    {133,  ast2700_gic133_gic197_intcmap},
     {134,  NULL},
     {135,  NULL},
     {136,  NULL},
@@ -190,11 +199,11 @@ static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(aspeed_soc_ast2700_gic_intcmap); i++) {
-        if (sc->irqmap[dev] == aspeed_soc_ast2700_gic_intcmap[i].irq) {
-            assert(aspeed_soc_ast2700_gic_intcmap[i].ptr);
+    for (i = 0; i < ARRAY_SIZE(ast2700_gic_intcmap); i++) {
+        if (sc->irqmap[dev] == ast2700_gic_intcmap[i].irq) {
+            assert(ast2700_gic_intcmap[i].ptr);
             return qdev_get_gpio_in(DEVICE(&a->intc.orgates[i]),
-                aspeed_soc_ast2700_gic_intcmap[i].ptr[dev]);
+                ast2700_gic_intcmap[i].ptr[dev]);
         }
     }
 
@@ -208,16 +217,17 @@ static qemu_irq aspeed_soc_ast2700_get_irq_index(AspeedSoCState *s, int dev,
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(aspeed_soc_ast2700_gic_intcmap); i++) {
-        if (sc->irqmap[dev] == aspeed_soc_ast2700_gic_intcmap[i].irq) {
-            assert(aspeed_soc_ast2700_gic_intcmap[i].ptr);
+    for (i = 0; i < ARRAY_SIZE(ast2700_gic_intcmap); i++) {
+        if (sc->irqmap[dev] == ast2700_gic_intcmap[i].irq) {
+            assert(ast2700_gic_intcmap[i].ptr);
             return qdev_get_gpio_in(DEVICE(&a->intc.orgates[i]),
-                aspeed_soc_ast2700_gic_intcmap[i].ptr[dev] + index);
+                                    ast2700_gic_intcmap[i].ptr[dev] + index);
         }
     }
 
     /*
-     * Invalid orgate index, device irq should be 128 to 136.
+     * Invalid OR gate index, device IRQ should be between 128 to 136
+     * and 192 to 201.
      */
     g_assert_not_reached();
 }
@@ -534,17 +544,18 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc), 0,
                     sc->memmap[ASPEED_DEV_INTC]);
 
-    /* source orgates -> INTC */
+    /* irq sources -> orgates -> INTC */
     for (i = 0; i < ic->num_inpins; i++) {
         qdev_connect_gpio_out(DEVICE(&a->intc.orgates[i]), 0,
-                                qdev_get_gpio_in(DEVICE(&a->intc), i));
+                              qdev_get_gpio_in(DEVICE(&a->intc), i));
     }
 
+    /* INTC -> GIC192 - GIC201 */
     /* INTC -> GIC128 - GIC136 */
     for (i = 0; i < ic->num_outpins; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc), i,
                            qdev_get_gpio_in(DEVICE(&a->gic),
-                                aspeed_soc_ast2700_gic_intcmap[i].irq));
+                                            ast2700_gic_intcmap[i].irq));
     }
 
     /* SRAM */
@@ -695,10 +706,22 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
         /*
          * The AST2700 I2C controller has one source INTC per bus.
-         * I2C buses interrupt are connected to GICINT130_INTC
-         * from bit 0 to bit 15.
-         * I2C bus 0 is connected to GICINT130_INTC at bit 0.
-         * I2C bus 15 is connected to GICINT130_INTC at bit 15.
+         *
+         * For AST2700 A0:
+         * I2C bus interrupts are connected to the OR gate from bit 0 to bit
+         * 15, and the OR gate output pin is connected to the input pin of
+         * GICINT130 of INTC (CPU Die). Then, the output pin is connected to
+         * the GIC.
+         *
+         * For AST2700 A1:
+         * I2C bus interrupts are connected to the OR gate from bit 0 to bit
+         * 15, and the OR gate output pin is connected to the input pin of
+         * GICINT194 of INTCIO (IO Die). Then, the output pin is connected
+         * to the INTC (CPU Die) input pin, and its output pin is connected
+         * to the GIC.
+         *
+         * I2C bus 0 is connected to the OR gate at bit 0.
+         * I2C bus 15 is connected to the OR gate at bit 15.
          */
         irq = aspeed_soc_ast2700_get_irq_index(s, ASPEED_DEV_I2C, i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);
-- 
2.48.1


