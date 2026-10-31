Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D9606A31F
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LKGvp6FE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN35F-0004y0-R7; Sat, 31 Oct 2026 03:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33l-00037X-Pr
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33d-0002qi-Jq
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2O+t8Z/54/Eg0SWZHShl4uHKNaO3du96WH081hnunjM=;
 b=LKGvp6FEj2XwfrP0Sl1kx0PhUQzb3nOugixAf52Xpr6k8u1cUaB5t4xL0x6u+NZ/FVcgji
 KfGlZVgd7zI/ehFCLvN2AvW/ZRIfg+M9qWpspGs7fLhG6CE3GLV6gsrgluaN5NxYp1HbdA
 tIHcDxi+qZg0+gKUv8cJ9ah79TxKVfk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-MkeBSXMnMVi00v4GxqQqmw-1; Sat,
 31 Oct 2026 02:59:10 -0400
X-MC-Unique: MkeBSXMnMVi00v4GxqQqmw-1
X-Mimecast-MFC-AGG-ID: MkeBSXMnMVi00v4GxqQqmw_1793429949
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72DBA1956072; Sat, 31 Oct 2026 06:59:09 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEE201800677; Sat, 31 Oct 2026 06:59:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/34] hw/arm/aspeed_ast1040: Add AST1080 SoC support
Date: Sat, 31 Oct 2026 07:58:06 +0100
Message-ID: <20261031065823.191966-18-clg@redhat.com>
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add initial support for the Aspeed AST1080 SoC. The AST1080 reuses most
of the AST1040 peripheral device models, as the two SoCs share nearly
the same controllers including WDT, SCU, GPIO, SGPIO, ADC, I2C, FMC,
and SPI.

The common initialization and realization functions,
aspeed_soc_ast10x0_g2_init() and aspeed_soc_ast10x0_g2_realize(),
introduced in the previous patches are reused, so AST1080 can
instantiate the existing AST1040 device models without defining
duplicate device types.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261015063625.186708-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast1040.c | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
index 28abbe70104d..c641f84fbe8c 100644
--- a/hw/arm/aspeed_ast1040.c
+++ b/hw/arm/aspeed_ast1040.c
@@ -162,6 +162,11 @@ static void aspeed_soc_ast1040_init(Object *obj)
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
 }
 
+static void aspeed_soc_ast1080_init(Object *obj)
+{
+    aspeed_soc_ast10x0_g2_init(obj);
+}
+
 static bool aspeed_soc_ast10x0_g2_realize(Aspeed10x0SoCState *a, Error **errp)
 {
     AspeedSoCState *s = ASPEED_SOC(a);
@@ -342,6 +347,15 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_PECI));
 }
 
+static void aspeed_soc_ast1080_realize(DeviceState *dev_soc, Error **errp)
+{
+    Aspeed10x0SoCState *a = ASPEED10X0_SOC(dev_soc);
+
+    if (!aspeed_soc_ast10x0_g2_realize(a, errp)) {
+        return;
+    }
+}
+
 static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *data)
 {
     static const char * const valid_cpu_types[] = {
@@ -370,12 +384,45 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *data)
     sc->num_cpus        = 1;
 }
 
+static void aspeed_soc_ast1080_class_init(ObjectClass *klass, const void *data)
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
+    dc->realize = aspeed_soc_ast1080_realize;
+
+    sc->valid_cpu_types = valid_cpu_types;
+    sc->silicon_rev     = AST1080_A0_SILICON_REV;
+    sc->sram_size[0]    = 128 * KiB;
+    sc->sram_size[1]    = 16 * MiB; /* Hyper RAM */
+    sc->uarts_num       = 13;
+    sc->sgpio_num       = 1;
+    sc->wdts_num        = 8;
+    sc->spis_num        = 2;
+    sc->uarts_base      = ASPEED_DEV_UART0;
+    sc->irqmap          = aspeed_soc_ast1040_irqmap;
+    sc->memmap          = aspeed_soc_ast1040_memmap;
+    sc->num_cpus        = 1;
+}
+
 static const TypeInfo aspeed_soc_ast1040_types[] = {
     {
         .name           = "ast1040-a0",
         .parent         = TYPE_ASPEED10X0_SOC,
         .instance_init  = aspeed_soc_ast1040_init,
         .class_init     = aspeed_soc_ast1040_class_init,
+    },
+    {
+        .name           = "ast1080-a0",
+        .parent         = TYPE_ASPEED10X0_SOC,
+        .instance_init  = aspeed_soc_ast1080_init,
+        .class_init     = aspeed_soc_ast1080_class_init,
     }
 };
 
-- 
2.56.0


