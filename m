Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDC0E95377
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBt-000225-EV; Wed, 04 Feb 2026 05:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBk-0001jx-Uk
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBi-00047t-ME
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvXSaU2PnAYagmnR84k/5v2USDAte/uH+f3lq1Gh+ek=;
 b=aOQ7rPr35/35ZuW5ImOlg8J43s6fszvCxNIMk++X0Qva9vXIlnZwL60px25I/qaugd7Bw9
 l6vDLNrsnYJHnfW6zawQwZQzdsPUBBrA9d+wzn642THgwQVlUP7MT4GQyjwoBS4hnBprXp
 b422Zn6whIJEwXpA4w2yL8kyUnmB3uw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-PZdsQoP5P3iQvIME8R8MRQ-1; Wed,
 04 Feb 2026 05:32:42 -0500
X-MC-Unique: PZdsQoP5P3iQvIME8R8MRQ-1
X-Mimecast-MFC-AGG-ID: PZdsQoP5P3iQvIME8R8MRQ_1770201161
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 974711800D8E; Wed,  4 Feb 2026 10:32:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 262C818003F6; Wed,  4 Feb 2026 10:32:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 29/45] hw/arm/aspeed: Integrate interrupt controller for AST1700
Date: Wed,  4 Feb 2026 11:31:20 +0100
Message-ID: <20260204103136.1795455-30-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Kane Chen <kane_chen@aspeedtech.com>

Connect the AST1700 interrupt lines to the GIC in AST27X0, enabling
the propagation of AST1700-originated interrupts to the host SoC.

This patch does not implement interrupt sources in AST1700 itself,
only the wiring into AST27X0.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260204082113.3955407-7-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h   |  6 +++-
 include/hw/intc/aspeed_intc.h |  2 ++
 hw/arm/aspeed_ast27x0.c       | 37 +++++++++++++++++++++
 hw/intc/aspeed_intc.c         | 60 +++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index f19bab3457ea..b051d0eb3a0a 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -58,6 +58,7 @@
 #define ASPEED_UARTS_NUM 13
 #define ASPEED_JTAG_NUM  2
 #define ASPEED_PCIE_NUM  3
+#define ASPEED_INTC_NUM  2
 #define ASPEED_IOEXP_NUM 2
 
 struct AspeedSoCState {
@@ -146,7 +147,8 @@ struct Aspeed27x0SoCState {
     AspeedSoCState parent;
 
     ARMCPU cpu[ASPEED_CPUS_NUM];
-    AspeedINTCState intc[2];
+    AspeedINTCState intc[ASPEED_INTC_NUM];
+    AspeedINTCState intcioexp[ASPEED_IOEXP_NUM];
     GICv3State gic;
     MemoryRegion dram_empty;
 };
@@ -288,6 +290,8 @@ enum {
     ASPEED_DEV_LTPI_CTRL2,
     ASPEED_DEV_LTPI_IO0,
     ASPEED_DEV_LTPI_IO1,
+    ASPEED_DEV_IOEXP0_INTCIO,
+    ASPEED_DEV_IOEXP1_INTCIO,
 };
 
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 5d10268fff32..b25ef4a464e5 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -15,6 +15,8 @@
 #define TYPE_ASPEED_INTC "aspeed.intc"
 #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
 #define TYPE_ASPEED_2700_INTCIO TYPE_ASPEED_INTC "io-ast2700"
+#define TYPE_ASPEED_2700_INTCIOEXP1 TYPE_ASPEED_INTC "-ast2700-ioexp1"
+#define TYPE_ASPEED_2700_INTCIOEXP2 TYPE_ASPEED_INTC "-ast2700-ioexp2"
 #define TYPE_ASPEED_2700SSP_INTC TYPE_ASPEED_INTC "-ast2700ssp"
 #define TYPE_ASPEED_2700SSP_INTCIO TYPE_ASPEED_INTC "io-ast2700ssp"
 #define TYPE_ASPEED_2700TSP_INTC TYPE_ASPEED_INTC "-ast2700tsp"
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index a05112e2b040..d9866c2c3b23 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -91,7 +91,9 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_LTPI_CTRL2] =  0x14C35000,
     [ASPEED_DEV_WDT]       =  0x14C37000,
     [ASPEED_DEV_LTPI_IO0]  =  0x30000000,
+    [ASPEED_DEV_IOEXP0_INTCIO] = 0x30C18000,
     [ASPEED_DEV_LTPI_IO1]  =  0x50000000,
+    [ASPEED_DEV_IOEXP1_INTCIO] = 0x50C18000,
     [ASPEED_DEV_PCIE_MMIO0] = 0x60000000,
     [ASPEED_DEV_PCIE_MMIO1] = 0x80000000,
     [ASPEED_DEV_PCIE_MMIO2] = 0xA0000000,
@@ -446,6 +448,10 @@ static void aspeed_soc_ast2700_init(Object *obj)
     object_initialize_child(obj, "intc", &a->intc[0], TYPE_ASPEED_2700_INTC);
     object_initialize_child(obj, "intcio", &a->intc[1],
                             TYPE_ASPEED_2700_INTCIO);
+    object_initialize_child(obj, "intc-ioexp0", &a->intcioexp[0],
+                            TYPE_ASPEED_2700_INTCIOEXP1);
+    object_initialize_child(obj, "intc-ioexp1", &a->intcioexp[1],
+                            TYPE_ASPEED_2700_INTCIOEXP2);
 
     snprintf(typename, sizeof(typename), "aspeed.adc-%s", socname);
     object_initialize_child(obj, "adc", &s->adc, typename);
@@ -690,6 +696,22 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[1]), 0,
                     sc->memmap[ASPEED_DEV_INTCIO]);
 
+    /* INTCIOEXP0 */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intcioexp[0]), errp)) {
+        return;
+    }
+
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intcioexp[0]), 0,
+                    sc->memmap[ASPEED_DEV_IOEXP0_INTCIO]);
+
+    /* INTCIOEXP1 */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intcioexp[1]), errp)) {
+        return;
+    }
+
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intcioexp[1]), 0,
+                    sc->memmap[ASPEED_DEV_IOEXP1_INTCIO]);
+
     /* irq sources -> orgates -> INTC */
     for (i = 0; i < ic->num_inpins; i++) {
         qdev_connect_gpio_out(DEVICE(&a->intc[0].orgates[i]), 0,
@@ -1006,6 +1028,21 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioexp[i]), 0,
                         sc->memmap[ASPEED_DEV_LTPI_IO0 + i]);
+
+        icio = ASPEED_INTC_GET_CLASS(&a->intcioexp[i]);
+        /* INTC_IOEXP internal: orgate[i] -> input[i] */
+        for (int j = 0; j < icio->num_inpins; j++) {
+            irq = qdev_get_gpio_in(DEVICE(&a->intcioexp[i]), j);
+            qdev_connect_gpio_out(DEVICE(&a->intcioexp[i].orgates[j]), 0,
+                                  irq);
+        }
+
+        /* INTC_IOEXP output[i] -> INTC0.orgate[0].input[i] */
+        for (int j = 0; j < icio->num_outpins; j++) {
+            irq = qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), j);
+            sysbus_connect_irq(SYS_BUS_DEVICE(&a->intcioexp[i]), j,
+                               irq);
+        }
     }
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 77fae3920584..52f2f946d59e 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -793,6 +793,64 @@ static const TypeInfo aspeed_2700_intc_info = {
     .class_init = aspeed_2700_intc_class_init,
 };
 
+static AspeedINTCIRQ aspeed_2700_intcioexp2_irqs[ASPEED_INTC_MAX_INPINS] = {
+    {0, 8, 1, R_GICINT192_EN, R_GICINT192_STATUS},
+    {1, 9, 1, R_GICINT193_EN, R_GICINT193_STATUS},
+};
+
+static void aspeed_2700_intcioexp2_class_init(ObjectClass *klass,
+                                              const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
+
+    dc->desc = "ASPEED 2700 IOEXP2 INTC Controller";
+    aic->num_lines = 32;
+    aic->num_inpins = 2;
+    aic->num_outpins = 10;
+    aic->mem_size = 0x400;
+    aic->nr_regs = 0x58 >> 2;
+    aic->reg_offset = 0x100;
+    aic->reg_ops = &aspeed_intcio_ops;
+    aic->irq_table = aspeed_2700_intcioexp2_irqs;
+    aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intcioexp2_irqs);
+}
+
+static const TypeInfo aspeed_2700_intcioexp2_info = {
+    .name = TYPE_ASPEED_2700_INTCIOEXP2,
+    .parent = TYPE_ASPEED_INTC,
+    .class_init = aspeed_2700_intcioexp2_class_init,
+};
+
+static AspeedINTCIRQ aspeed_2700_intcioexp1_irqs[ASPEED_INTC_MAX_INPINS] = {
+    {0, 6, 1, R_GICINT192_EN, R_GICINT192_STATUS},
+    {1, 7, 1, R_GICINT193_EN, R_GICINT193_STATUS},
+};
+
+static void aspeed_2700_intcioexp1_class_init(ObjectClass *klass,
+                                              const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
+
+    dc->desc = "ASPEED 2700 IOEXP1 INTC Controller";
+    aic->num_lines = 32;
+    aic->num_inpins = 2;
+    aic->num_outpins = 10;
+    aic->mem_size = 0x400;
+    aic->nr_regs = 0x58 >> 2;
+    aic->reg_offset = 0x100;
+    aic->reg_ops = &aspeed_intcio_ops;
+    aic->irq_table = aspeed_2700_intcioexp1_irqs;
+    aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intcioexp1_irqs);
+}
+
+static const TypeInfo aspeed_2700_intcioexp1_info = {
+    .name = TYPE_ASPEED_2700_INTCIOEXP1,
+    .parent = TYPE_ASPEED_INTC,
+    .class_init = aspeed_2700_intcioexp1_class_init,
+};
+
 static AspeedINTCIRQ aspeed_2700_intcio_irqs[ASPEED_INTC_MAX_INPINS] = {
     {0, 0, 1, R_GICINT192_EN, R_GICINT192_STATUS},
     {1, 1, 1, R_GICINT193_EN, R_GICINT193_STATUS},
@@ -950,6 +1008,8 @@ static void aspeed_intc_register_types(void)
     type_register_static(&aspeed_intc_info);
     type_register_static(&aspeed_2700_intc_info);
     type_register_static(&aspeed_2700_intcio_info);
+    type_register_static(&aspeed_2700_intcioexp1_info);
+    type_register_static(&aspeed_2700_intcioexp2_info);
     type_register_static(&aspeed_2700ssp_intc_info);
     type_register_static(&aspeed_2700ssp_intcio_info);
     type_register_static(&aspeed_2700tsp_intc_info);
-- 
2.52.0


