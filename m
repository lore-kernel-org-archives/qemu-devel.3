Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E7EC28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH64-0003cA-R2; Sun, 09 Mar 2025 09:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5f-0001qS-9k
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5d-0003wd-6M
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xt7ivf08xKDsAVyFSCjcqOKAEtgaXnQwO88Iz+jDcXA=;
 b=JX+7zgBgmJ1QTODaj1+WNn9BmUpJIJMPlNl+dV9dZ0sfUxHg7TFNvslRymla/UkQaILT17
 hutNicK4rNYziea+GVjKblYbpQHf43nhDa6RltmaZI3PmXXMOMgY8vPx4heCINear+G/BJ
 95+/W+WdJAgwv6RPgyJIQs5NUwJBa+4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-fjybkcuGMmeowsPeKXOqKQ-1; Sun,
 09 Mar 2025 09:53:09 -0400
X-MC-Unique: fjybkcuGMmeowsPeKXOqKQ-1
X-Mimecast-MFC-AGG-ID: fjybkcuGMmeowsPeKXOqKQ_1741528388
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23F90180AF52; Sun,  9 Mar 2025 13:53:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8781D1956095; Sun,  9 Mar 2025 13:53:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 37/46] hw/arm/aspeed_ast27x0: Define an Array of
 AspeedINTCState with Two Instances
Date: Sun,  9 Mar 2025 14:51:21 +0100
Message-ID: <20250309135130.545764-38-clg@redhat.com>
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

Updated Aspeed27x0SoCState to include an intc[2] array instead of a single
AspeedINTCState instance. Modified aspeed_soc_ast2700_get_irq and
aspeed_soc_ast2700_get_irq_index to correctly reference the corresponding
interrupt controller instance and OR gate index.

Currently, only GIC 192 to 201 are supported, and their source interrupts are
from INTCIO and connected to INTC at input pin 0 and output pins 0 to 9 for
GIC 192-201.

To support both AST2700 A1 and A0, INTC input pins 1 to 9 and output pins
10 to 18 remain to support GIC 128-136, which source interrupts from INTC.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250307035945.3698802-21-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  2 +-
 hw/arm/aspeed_ast27x0.c     | 58 +++++++++++++++++++++++++------------
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 4a8881ca8b57..066d2fcc204b 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -128,7 +128,7 @@ struct Aspeed27x0SoCState {
     AspeedSoCState parent;
 
     ARMCPU cpu[ASPEED_CPUS_NUM];
-    AspeedINTCState intc;
+    AspeedINTCState intc[2];
     GICv3State gic;
     MemoryRegion dram_empty;
 };
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 9e5f4a208453..6cffa5b9a05e 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -178,32 +178,48 @@ static const int ast2700_gic133_gic197_intcmap[] = {
 /* GICINT 192 ~ 201 */
 struct gic_intc_irq_info {
     int irq;
+    int intc_idx;
+    int orgate_idx;
     const int *ptr;
 };
 
 static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
-    {128,  ast2700_gic128_gic192_intcmap},
-    {129,  NULL},
-    {130,  ast2700_gic130_gic194_intcmap},
-    {131,  ast2700_gic131_gic195_intcmap},
-    {132,  ast2700_gic132_gic196_intcmap},
-    {133,  ast2700_gic133_gic197_intcmap},
-    {134,  NULL},
-    {135,  NULL},
-    {136,  NULL},
+    {192, 1, 0, ast2700_gic128_gic192_intcmap},
+    {193, 1, 1, NULL},
+    {194, 1, 2, ast2700_gic130_gic194_intcmap},
+    {195, 1, 3, ast2700_gic131_gic195_intcmap},
+    {196, 1, 4, ast2700_gic132_gic196_intcmap},
+    {197, 1, 5, ast2700_gic133_gic197_intcmap},
+    {198, 1, 6, NULL},
+    {199, 1, 7, NULL},
+    {200, 1, 8, NULL},
+    {201, 1, 9, NULL},
+    {128, 0, 1, ast2700_gic128_gic192_intcmap},
+    {129, 0, 2, NULL},
+    {130, 0, 3, ast2700_gic130_gic194_intcmap},
+    {131, 0, 4, ast2700_gic131_gic195_intcmap},
+    {132, 0, 5, ast2700_gic132_gic196_intcmap},
+    {133, 0, 6, ast2700_gic133_gic197_intcmap},
+    {134, 0, 7, NULL},
+    {135, 0, 8, NULL},
+    {136, 0, 9, NULL},
 };
 
 static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
 {
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(s);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    int or_idx;
+    int idx;
     int i;
 
     for (i = 0; i < ARRAY_SIZE(ast2700_gic_intcmap); i++) {
         if (sc->irqmap[dev] == ast2700_gic_intcmap[i].irq) {
             assert(ast2700_gic_intcmap[i].ptr);
-            return qdev_get_gpio_in(DEVICE(&a->intc.orgates[i]),
-                ast2700_gic_intcmap[i].ptr[dev]);
+            or_idx = ast2700_gic_intcmap[i].orgate_idx;
+            idx = ast2700_gic_intcmap[i].intc_idx;
+            return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),
+                                    ast2700_gic_intcmap[i].ptr[dev]);
         }
     }
 
@@ -215,12 +231,16 @@ static qemu_irq aspeed_soc_ast2700_get_irq_index(AspeedSoCState *s, int dev,
 {
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(s);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    int or_idx;
+    int idx;
     int i;
 
     for (i = 0; i < ARRAY_SIZE(ast2700_gic_intcmap); i++) {
         if (sc->irqmap[dev] == ast2700_gic_intcmap[i].irq) {
             assert(ast2700_gic_intcmap[i].ptr);
-            return qdev_get_gpio_in(DEVICE(&a->intc.orgates[i]),
+            or_idx = ast2700_gic_intcmap[i].orgate_idx;
+            idx = ast2700_gic_intcmap[i].intc_idx;
+            return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),
                                     ast2700_gic_intcmap[i].ptr[dev] + index);
         }
     }
@@ -390,7 +410,7 @@ static void aspeed_soc_ast2700_init(Object *obj)
 
     object_initialize_child(obj, "sli", &s->sli, TYPE_ASPEED_2700_SLI);
     object_initialize_child(obj, "sliio", &s->sliio, TYPE_ASPEED_2700_SLIIO);
-    object_initialize_child(obj, "intc", &a->intc, TYPE_ASPEED_2700_INTC);
+    object_initialize_child(obj, "intc", &a->intc[0], TYPE_ASPEED_2700_INTC);
 
     snprintf(typename, sizeof(typename), "aspeed.adc-%s", socname);
     object_initialize_child(obj, "adc", &s->adc, typename);
@@ -506,7 +526,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    AspeedINTCClass *ic = ASPEED_INTC_GET_CLASS(&a->intc);
+    AspeedINTCClass *ic = ASPEED_INTC_GET_CLASS(&a->intc[0]);
     g_autofree char *sram_name = NULL;
     qemu_irq irq;
 
@@ -537,23 +557,23 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     }
 
     /* INTC */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc), errp)) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
         return;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc), 0,
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[0]), 0,
                     sc->memmap[ASPEED_DEV_INTC]);
 
     /* irq sources -> orgates -> INTC */
     for (i = 0; i < ic->num_inpins; i++) {
-        qdev_connect_gpio_out(DEVICE(&a->intc.orgates[i]), 0,
-                              qdev_get_gpio_in(DEVICE(&a->intc), i));
+        qdev_connect_gpio_out(DEVICE(&a->intc[0].orgates[i]), 0,
+                              qdev_get_gpio_in(DEVICE(&a->intc[0]), i));
     }
 
     /* INTC -> GIC192 - GIC201 */
     /* INTC -> GIC128 - GIC136 */
     for (i = 0; i < ic->num_outpins; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc), i,
+        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[0]), i,
                            qdev_get_gpio_in(DEVICE(&a->gic),
                                             ast2700_gic_intcmap[i].irq));
     }
-- 
2.48.1


