Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70691CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKU2-0006uz-DH; Thu, 15 Oct 2026 08:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTl-0006U5-Sf
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTh-0005fN-0P
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YFIBgtDCaNxYpIAuZmZT+o2i8lKi8DgRaHj9/8zUWsY=;
 b=AXsJaHI/plkdRk/uvaRXzRFGbGEmGpi+rBgp+5MXJPLBcbVMxAvvy0Nzy+RKamKE5oVLRd
 bCIlPJaszDTijCVMtEhAWAPxAG/A5aKaoDUshP1RHhPbj4fW8QHIM7DmEReSkC4kZhS+6H
 +e0Cf7YzabfKa7YptqIXt99eDGoA9rg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-NNSOfFDjP2eg45-Fih47LQ-1; Thu,
 15 Oct 2026 12:22:28 +0000
X-MC-Unique: NNSOfFDjP2eg45-Fih47LQ-1
X-Mimecast-MFC-AGG-ID: NNSOfFDjP2eg45-Fih47LQ_1792066947
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE2351955E95; Thu, 15 Oct 2026 12:22:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 026637D8; Thu, 15 Oct 2026 12:22:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/21] hw/arm/aspeed_ast27x0: Use a table for unimplemented
 devices for SSP/TSP
Date: Thu, 15 Oct 2026 14:21:46 +0200
Message-ID: <20261015122151.889017-17-clg@redhat.com>
In-Reply-To: <20261015122151.889017-1-clg@redhat.com>
References: <20261015122151.889017-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Before this change, each unimplemented device needed its own field in
the coprocessor state. This made the code hard to maintain.

Add an unimp_devs table in AspeedCoprocessorClass to describe the
unimplemented devices, and use create_unimplemented_devices() to create
and map them. This makes the code easier to maintain and read. Convert
AST2700 SSP and TSP to use them.

This also fixes a type mismatch. SSP and TSP used the "timerctrl"
field (AspeedTimerCtrlState) to create an unimplemented device. It is
not used for that anymore.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261012064445.2571633-9-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_coprocessor.h |  1 +
 hw/arm/aspeed_ast27x0-ssp.c         | 44 +++++++++--------------------
 hw/arm/aspeed_ast27x0-tsp.c         | 44 +++++++++--------------------
 3 files changed, 27 insertions(+), 62 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index acb8b0645777..39209d2579f7 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -37,6 +37,7 @@ struct AspeedCoprocessorClass {
     /** valid_cpu_types: NULL terminated array of a single CPU type. */
     const char * const *valid_cpu_types;
     const hwaddr *memmap;
+    const UnimplementedDeviceConfig *unimp_devs;
     const int *irqmap;
 };
 
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index e03653086c88..0238dc36725f 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -101,6 +101,16 @@ static struct nvic_intc_irq_info ast2700_ssp_intcmap[] = {
     {169, 1, 9, NULL},
 };
 
+static const UnimplementedDeviceConfig aspeed_soc_ast27x0ssp_unimp_devs[] = {
+    { "timerctrl", "aspeed.timerctrl", 0x72C10000, 0x200, -1000 },
+    { "ipc0", "aspeed.ipc0", 0x72C1C000, 0x1000, -1000 },
+    { "ipc1", "aspeed.ipc1", 0x74C39000, 0x1000, -1000 },
+    { "pric0", "aspeed.pric0", 0x72140000, 0x1000, -1000 },
+    { "pric1", "aspeed.pric1", 0x74100000, 0x1000, -1000 },
+    { "otp", "aspeed.otp", 0x74C07000, 0x800, -1000 },
+    { }
+};
+
 static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedCoprocessorState *s,
                                               int dev)
 {
@@ -136,19 +146,6 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)
                             TYPE_ASPEED_2700SSP_INTC);
     object_initialize_child(obj, "intc1", &a->intc[1],
                             TYPE_ASPEED_2700SSP_INTCIO);
-
-    object_initialize_child(obj, "timerctrl", &s->timerctrl,
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "ipc0", &a->ipc[0],
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "ipc1", &a->ipc[1],
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "pric0", &a->pric[0],
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "pric1", &a->pric[1],
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "otp", &a->otp,
-                            TYPE_UNIMPLEMENTED_DEVICE);
 }
 
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
@@ -283,24 +280,8 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],
                                 &a->fmc_alias);
 
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
-                                  "aspeed.timerctrl",
-                                  sc->memmap[ASPEED_DEV_TIMER1], 0x200);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[0]),
-                                  "aspeed.ipc0",
-                                  sc->memmap[ASPEED_DEV_IPC0], 0x1000);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),
-                                  "aspeed.ipc1",
-                                  sc->memmap[ASPEED_DEV_IPC1], 0x1000);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),
-                                  "aspeed.pric0",
-                                  sc->memmap[ASPEED_DEV_PRIC0], 0x1000);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),
-                                  "aspeed.pric1",
-                                  sc->memmap[ASPEED_DEV_PRIC1], 0x1000);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),
-                                  "aspeed.otp",
-                                  sc->memmap[ASPEED_DEV_OTP], 0x800);
+    /* Unimplemented devices */
+    create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);
 }
 
 static const Property aspeed_27x0_coprocessor_properties[] = {
@@ -330,6 +311,7 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
     sc->valid_cpu_types = valid_cpu_types;
     sc->irqmap = aspeed_soc_ast27x0ssp_irqmap;
     sc->memmap = aspeed_soc_ast27x0ssp_memmap;
+    sc->unimp_devs = aspeed_soc_ast27x0ssp_unimp_devs;
 }
 
 static const TypeInfo aspeed_soc_ast27x0ssp_types[] = {
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 39ba062a20f7..7f057ff1357d 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -101,6 +101,16 @@ static struct nvic_intc_irq_info ast2700_tsp_intcmap[] = {
     {169, 1, 9, NULL},
 };
 
+static const UnimplementedDeviceConfig aspeed_soc_ast27x0tsp_unimp_devs[] = {
+    { "timerctrl", "aspeed.timerctrl", 0x72C10000, 0x200, -1000 },
+    { "ipc0", "aspeed.ipc0", 0x72C1C000, 0x1000, -1000 },
+    { "ipc1", "aspeed.ipc1", 0x74C39000, 0x1000, -1000 },
+    { "pric0", "aspeed.pric0", 0x72140000, 0x1000, -1000 },
+    { "pric1", "aspeed.pric1", 0x74100000, 0x1000, -1000 },
+    { "otp", "aspeed.otp", 0x74C07000, 0x800, -1000 },
+    { }
+};
+
 static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedCoprocessorState *s,
                                               int dev)
 {
@@ -136,19 +146,6 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)
                             TYPE_ASPEED_2700TSP_INTC);
     object_initialize_child(obj, "intc1", &a->intc[1],
                             TYPE_ASPEED_2700TSP_INTCIO);
-
-    object_initialize_child(obj, "timerctrl", &s->timerctrl,
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "ipc0", &a->ipc[0],
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "ipc1", &a->ipc[1],
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "pric0", &a->pric[0],
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "pric1", &a->pric[1],
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "otp", &a->otp,
-                            TYPE_UNIMPLEMENTED_DEVICE);
 }
 
 static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
@@ -283,24 +280,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],
                                 &a->fmc_alias);
 
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
-                                  "aspeed.timerctrl",
-                                  sc->memmap[ASPEED_DEV_TIMER1], 0x200);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[0]),
-                                  "aspeed.ipc0",
-                                  sc->memmap[ASPEED_DEV_IPC0], 0x1000);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),
-                                  "aspeed.ipc1",
-                                  sc->memmap[ASPEED_DEV_IPC1], 0x1000);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),
-                                  "aspeed.pric0",
-                                  sc->memmap[ASPEED_DEV_PRIC0], 0x1000);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),
-                                  "aspeed.pric1",
-                                  sc->memmap[ASPEED_DEV_PRIC1], 0x1000);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),
-                                  "aspeed.otp",
-                                  sc->memmap[ASPEED_DEV_OTP], 0x800);
+    /* Unimplemented devices */
+    create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);
 }
 
 static const Property aspeed_27x0_coprocessor_properties[] = {
@@ -330,6 +311,7 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,
     sc->valid_cpu_types = valid_cpu_types;
     sc->irqmap = aspeed_soc_ast27x0tsp_irqmap;
     sc->memmap = aspeed_soc_ast27x0tsp_memmap;
+    sc->unimp_devs = aspeed_soc_ast27x0tsp_unimp_devs;
 }
 
 static const TypeInfo aspeed_soc_ast27x0tsp_types[] = {
-- 
2.56.0


