Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE20C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNR-0000Nz-Bn; Tue, 11 Aug 2026 12:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpN9-00087X-6G
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpN7-0000am-0l
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SaqdHhOfR0pntcuwei9xlL2SDBuhrGg1yc0/Ud+mKbs=;
 b=L/1rMPuaQqsPR1Ts+1+iF0ZJIW5r0ey+I53JaUvBBpMF+ysqyXPekQjDPoCUezJdF7aH4O
 uGYXChJq/GsH7Gz/ZUiTznFBx1RryQN2TobK1d53GTmVbgc5GI3MNB0Xu5PwdrZbxqhkl/
 jOoM/l8ouozZmIaKH84utzHuDunReN8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-fHjQVbqHM0CyHKIzeez8pQ-1; Tue,
 11 Aug 2026 12:30:28 -0400
X-MC-Unique: fHjQVbqHM0CyHKIzeez8pQ-1
X-Mimecast-MFC-AGG-ID: fHjQVbqHM0CyHKIzeez8pQ_1786465827
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 051571956058; Tue, 11 Aug 2026 16:30:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F626195DF91; Tue, 11 Aug 2026 16:30:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/83] hw/arm/aspeed_ast27x0: Move SCU link into AST27x0
 coprocessors
Date: Tue, 11 Aug 2026 18:28:35 +0200
Message-ID: <20260811162938.1403216-21-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The SCU link is only needed by the AST27x0 SSP/TSP coprocessors for their
AST2700-specific SCU alias window.

Move the link property from the common AspeedCoprocessorState into
Aspeed27x0CoprocessorState, so the generic coprocessor model no longer
contains an AST2700-specific dependency.

Also validate that the SCU link has been provided during device realize
before accessing it.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260717084559.3477061-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_coprocessor.h |  5 +++--
 hw/arm/aspeed_ast27x0-ssp.c         | 20 ++++++++++++++++----
 hw/arm/aspeed_ast27x0-tsp.c         | 20 ++++++++++++++++----
 hw/arm/aspeed_coprocessor_common.c  |  2 --
 4 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index ac58a5f424ff..adfc3c451239 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -20,10 +20,8 @@ struct AspeedCoprocessorState {
     MemoryRegion *sram;
     MemoryRegion sram_alias;
     MemoryRegion uart_alias;
-    MemoryRegion scu_alias;
     Clock *sysclk;
 
-    AspeedSCUState *scu;
     AspeedSCUState scuio;
     AspeedTimerCtrlState timerctrl;
     SerialMM *uart;
@@ -52,6 +50,9 @@ struct Aspeed27x0CoprocessorState {
     UnimplementedDeviceState otp;
 
     ARMv7MState armv7m;
+
+    MemoryRegion scu_alias;
+    Aspeed2700SCUState *scu;
 };
 
 #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 68a8ab26f7ac..28bb59c8c56a 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -167,6 +167,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+    if (!a->scu) {
+        error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR
+                   ": 'scu' link is not set");
+        return;
+    }
+
     /* AST27X0 SSP Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
@@ -195,11 +201,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
                                 &s->sram_alias);
 
     /* SCU */
-    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",
-                             &s->scu->iomem, 0,
-                             memory_region_size(&s->scu->iomem));
+    memory_region_init_alias(&a->scu_alias, OBJECT(a), "scu.alias",
+                             &a->scu->parent_obj.iomem, 0,
+                             memory_region_size(&a->scu->parent_obj.iomem));
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
-                                &s->scu_alias);
+                                &a->scu_alias);
 
     /* INTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
@@ -275,6 +281,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
                                   sc->memmap[ASPEED_DEV_OTP], 0x800);
 }
 
+static const Property aspeed_27x0_coprocessor_properties[] = {
+    DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,
+                     TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),
+};
+
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
                                              const void *data)
 {
@@ -288,6 +299,7 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
     /* Reason: The Aspeed Coprocessor can only be instantiated from a board */
     dc->user_creatable = false;
     dc->realize = aspeed_soc_ast27x0ssp_realize;
+    device_class_set_props(dc, aspeed_27x0_coprocessor_properties);
 
     sc->valid_cpu_types = valid_cpu_types;
     sc->irqmap = aspeed_soc_ast27x0ssp_irqmap;
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index b8a4f7c91d60..f5c4a021616b 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -167,6 +167,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+    if (!a->scu) {
+        error_setg(errp, TYPE_ASPEED27X0TSP_COPROCESSOR
+                   ": 'scu' link is not set");
+        return;
+    }
+
     /* AST27X0 TSP Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
@@ -195,11 +201,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
                                 &s->sram_alias);
 
     /* SCU */
-    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",
-                             &s->scu->iomem, 0,
-                             memory_region_size(&s->scu->iomem));
+    memory_region_init_alias(&a->scu_alias, OBJECT(a), "scu.alias",
+                             &a->scu->parent_obj.iomem, 0,
+                             memory_region_size(&a->scu->parent_obj.iomem));
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
-                                &s->scu_alias);
+                                &a->scu_alias);
 
     /* INTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
@@ -275,6 +281,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
                                   sc->memmap[ASPEED_DEV_OTP], 0x800);
 }
 
+static const Property aspeed_27x0_coprocessor_properties[] = {
+    DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,
+                     TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),
+};
+
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,
                                              const void *data)
 {
@@ -288,6 +299,7 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,
     /* Reason: The Aspeed Coprocessor can only be instantiated from a board */
     dc->user_creatable = false;
     dc->realize = aspeed_soc_ast27x0tsp_realize;
+    device_class_set_props(dc, aspeed_27x0_coprocessor_properties);
 
     sc->valid_cpu_types = valid_cpu_types;
     sc->irqmap = aspeed_soc_ast27x0tsp_irqmap;
diff --git a/hw/arm/aspeed_coprocessor_common.c b/hw/arm/aspeed_coprocessor_common.c
index a0a4c73d08d3..43026d2a555a 100644
--- a/hw/arm/aspeed_coprocessor_common.c
+++ b/hw/arm/aspeed_coprocessor_common.c
@@ -27,8 +27,6 @@ static const Property aspeed_coprocessor_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_LINK("sram", AspeedCoprocessorState, sram, TYPE_MEMORY_REGION,
                      MemoryRegion *),
-    DEFINE_PROP_LINK("scu", AspeedCoprocessorState, scu, TYPE_ASPEED_SCU,
-                     AspeedSCUState *),
     DEFINE_PROP_LINK("uart", AspeedCoprocessorState, uart, TYPE_SERIAL_MM,
                      SerialMM *),
     DEFINE_PROP_INT32("uart-dev", AspeedCoprocessorState, uart_dev, 0),
-- 
2.55.0


