Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02B5C79F8B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 12:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck8n-0003xL-Fp; Mon, 05 Jan 2026 07:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8T-0003p7-Qq
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8R-0007wi-RP
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VubRcQ92hC2orf+/hvxD67znU0vMNup3DnROyTxFHaw=;
 b=Bo0RGI3bcOkZED5xZ/CzUggbDshS4P/sqx6QdG9IaF7jegzDNBimd2wxga3x6plZpRhPop
 BUylsj08yWAeiv6OmJuXJ0wpBp0lBQrhgai20TujniXq4kHKIDasMV3JDzMN5U0qR08yEd
 N+LJZ0Wj8U/N2WVI5v+yJR474Inl5kc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-vnGpVYs9Mc6jKB3AwawyLQ-1; Mon,
 05 Jan 2026 07:56:32 -0500
X-MC-Unique: vnGpVYs9Mc6jKB3AwawyLQ-1
X-Mimecast-MFC-AGG-ID: vnGpVYs9Mc6jKB3AwawyLQ_1767617791
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 828B61955F3F; Mon,  5 Jan 2026 12:56:31 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 103AB19560A7; Mon,  5 Jan 2026 12:56:29 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/36] hw/arm/aspeed_ast10x0: Add AST1060 SoC support
Date: Mon,  5 Jan 2026 13:55:44 +0100
Message-ID: <20260105125613.622667-8-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add initial support for the Aspeed AST1060 SoC. The AST1060 reuses most
of the AST1030 peripheral device models, as the two SoCs share nearly
the same controllers including WDT, SCU, TIMER, HACE, ADC, I2C, FMC,
and SPI.

A new common initialization and realization framework (ast10x0_init
and ast10x0_realize) is leveraged so AST1060 can instantiate the
existing AST1030 models without redefining duplicate device types.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251112030553.291734-9-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast10x0.c | 59 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 4ed6649e5546..44e1d59ddb3c 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -185,6 +185,23 @@ static void aspeed_soc_ast1030_init(Object *obj)
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
 }
 
+static void aspeed_soc_ast1060_init(Object *obj)
+{
+    /*
+     * The AST1060 SoC reuses the AST1030 device models. Since all peripheral
+     * models (e.g. WDT, SCU, TIMER, HACE, ADC, I2C, FMC, SPI) defined for
+     * AST1030 are compatible with AST1060, we simply reuse the existing
+     * AST1030 models for AST1060.
+     *
+     * To simplify the implementation, AST1060 sets its socname to that of
+     * AST1030, avoiding the need to create a full set of new
+     * TYPE_ASPEED_1060_XXX device definitions. This allows the same
+     * TYPE_ASPEED_1030_WDT and other models to be instantiated for both
+     * SoCs.
+     */
+    aspeed_soc_ast10x0_init(obj, "ast1030");
+}
+
 static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
 {
     AspeedSoCState *s = ASPEED_SOC(a);
@@ -451,6 +468,15 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
                                 sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_4));
 }
 
+static void aspeed_soc_ast1060_realize(DeviceState *dev_soc, Error **errp)
+{
+    Aspeed10x0SoCState *a = ASPEED10X0_SOC(dev_soc);
+
+    if (!aspeed_soc_ast10x0_realize(a, errp)) {
+        return;
+    }
+}
+
 static void aspeed_soc_ast1030_class_init(ObjectClass *klass, const void *data)
 {
     static const char * const valid_cpu_types[] = {
@@ -479,6 +505,32 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *klass, const void *data)
     sc->num_cpus = 1;
 }
 
+static void aspeed_soc_ast1060_class_init(ObjectClass *klass, const void *data)
+{
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO cortex-m4f */
+        NULL
+    };
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSoCClass *sc = ASPEED_SOC_CLASS(dc);
+
+    /* Reason: The Aspeed SoC can only be instantiated from a board */
+    dc->user_creatable = false;
+    dc->realize = aspeed_soc_ast1060_realize;
+
+    sc->valid_cpu_types = valid_cpu_types;
+    sc->silicon_rev = AST1060_A2_SILICON_REV;
+    sc->sram_size = 0xc0000;
+    sc->secsram_size = 0x40000; /* 256 * KiB */
+    sc->spis_num = 2;
+    sc->wdts_num = 4;
+    sc->uarts_num = 1;
+    sc->uarts_base = ASPEED_DEV_UART5;
+    sc->irqmap = aspeed_soc_ast1030_irqmap;
+    sc->memmap = aspeed_soc_ast1030_memmap;
+    sc->num_cpus = 1;
+}
+
 static const TypeInfo aspeed_soc_ast10x0_types[] = {
     {
         .name           = TYPE_ASPEED10X0_SOC,
@@ -490,7 +542,12 @@ static const TypeInfo aspeed_soc_ast10x0_types[] = {
         .parent         = TYPE_ASPEED10X0_SOC,
         .instance_init  = aspeed_soc_ast1030_init,
         .class_init     = aspeed_soc_ast1030_class_init,
-    },
+    }, {
+        .name           = "ast1060-a2",
+        .parent         = TYPE_ASPEED10X0_SOC,
+        .instance_init  = aspeed_soc_ast1060_init,
+        .class_init     = aspeed_soc_ast1060_class_init,
+    }
 };
 
 DEFINE_TYPES(aspeed_soc_ast10x0_types)
-- 
2.52.0


