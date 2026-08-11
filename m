Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AC7C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNJ-0008Vs-VY; Tue, 11 Aug 2026 12:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNC-0008CO-PD
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpN8-0000cu-VR
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Vh2YnUBKuwGAMUCfrAfj//pXx3hpZqPJ2DDc5+7iGI=;
 b=Sp/Tvb2/AZS/4XdLAMYkOFFXSvNzZqk4YU575OjlRdkzevKRWj4j5F7T0JO2zlPbPtCSBa
 HE4Y7fPX2kBSfcRgVDOtYcnMpIVnAhrI0qcKVVSqkSuNSEjPkL6cu5acFR2nts8v6JNOQ0
 dCfkRVLvdhhW9RDxDcXMwlqG6OtwoMs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-m2QxV5cBMgqPKxJxl9gFRQ-1; Tue,
 11 Aug 2026 12:30:34 -0400
X-MC-Unique: m2QxV5cBMgqPKxJxl9gFRQ-1
X-Mimecast-MFC-AGG-ID: m2QxV5cBMgqPKxJxl9gFRQ_1786465833
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA7E71800471; Tue, 11 Aug 2026 16:30:33 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C150A195DF91; Tue, 11 Aug 2026 16:30:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/83] hw/arm/ast27x0: Share single SCUIO instance across PSP,
 SSP, and TSP
Date: Tue, 11 Aug 2026 18:28:38 +0200
Message-ID: <20260811162938.1403216-24-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AST2700 has a single SCUIO hardware block, memory-mapped at
0x14C02000–0x14C03FFF from the perspective of the main CA35 processor (PSP).
The SSP and TSP coprocessors access this same SCUIO block at different
addresses: 0x74C02000–0x74C03FFF.

Previously, each subsystem (PSP, SSP, and TSP) instantiated its own SCUIO
device, resulting in three independent SCUIO instances in the QEMU model.
In real hardware, however, only a single SCUIO exists and is shared among
all processors.

This commit reworks the SCUIO model to correctly reflect the hardware
behavior by allowing SSP and TSP to reference the PSP’s SCUIO instance.
The following changes are introduced:

- Add a scuio property to Aspeed27x0CoprocessorState for linking the
  coprocessor to the PSP’s SCUIO instance.
- Replace per-coprocessor SCUIO instantiation with a shared SCUIO link.
- Add "MemoryRegion scuio_alias" to model address remapping for SSP and TSP.
- Create SCUIO alias regions in both SSP and TSP coprocessors and map
  them at 0x74C02000 to mirror the PSP’s SCUIO registers.
- Ensure the SCUIO device in PSP is realized before SSP/TSP alias setup.

With this change, PSP, SSP, and TSP now share a consistent SCUIO state,
matching the single-SCUIO hardware design of AST2700.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260717084559.3477061-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_coprocessor.h |  4 ++--
 hw/arm/aspeed_ast27x0-fc.c          |  4 ++++
 hw/arm/aspeed_ast27x0-ssp.c         | 20 +++++++++++++++-----
 hw/arm/aspeed_ast27x0-tsp.c         | 20 +++++++++++++++-----
 4 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index adfc3c451239..b77ea06e7f68 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -22,7 +22,6 @@ struct AspeedCoprocessorState {
     MemoryRegion uart_alias;
     Clock *sysclk;
 
-    AspeedSCUState scuio;
     AspeedTimerCtrlState timerctrl;
     SerialMM *uart;
     int uart_dev;
@@ -45,14 +44,15 @@ struct Aspeed27x0CoprocessorState {
     AspeedCoprocessorState parent;
     AspeedINTCState intc[2];
     UnimplementedDeviceState ipc[2];
-    UnimplementedDeviceState scuio;
     UnimplementedDeviceState pric[2];
     UnimplementedDeviceState otp;
 
     ARMv7MState armv7m;
 
     MemoryRegion scu_alias;
+    MemoryRegion scuio_alias;
     Aspeed2700SCUState *scu;
+    AspeedSCUState *scuio;
 };
 
 #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 58d0b4d7cd59..d14a42ebca3f 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -157,6 +157,8 @@ static bool ast2700fc_ssp_init(Ast2700FCState *s, AspeedSoCState *psp,
                              OBJECT(&psp->sram), &error_abort);
     object_property_set_link(OBJECT(&s->ssp), "scu",
                              OBJECT(&s->ca35.scu), &error_abort);
+    object_property_set_link(OBJECT(&s->ssp), "scuio",
+                             OBJECT(&psp->scuio), &error_abort);
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
         return false;
     }
@@ -187,6 +189,8 @@ static bool ast2700fc_tsp_init(Ast2700FCState *s, AspeedSoCState *psp,
                              OBJECT(&psp->sram), &error_abort);
     object_property_set_link(OBJECT(&s->tsp), "scu",
                              OBJECT(&s->ca35.scu), &error_abort);
+    object_property_set_link(OBJECT(&s->tsp), "scuio",
+                             OBJECT(&psp->scuio), &error_abort);
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
         return false;
     }
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 28bb59c8c56a..fa492f179732 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -142,8 +142,6 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)
                             TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "ipc1", &a->ipc[1],
                             TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "scuio", &a->scuio,
-                            TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "pric0", &a->pric[0],
                             TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "pric1", &a->pric[1],
@@ -173,6 +171,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+    if (!a->scuio) {
+        error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR
+                   ": 'scuio' link is not set");
+        return;
+    }
+
     /* AST27X0 SSP Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
@@ -207,6 +211,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
                                 &a->scu_alias);
 
+    /* SCUIO */
+    memory_region_init_alias(&a->scuio_alias, OBJECT(a), "scuio.alias",
+                             &a->scuio->iomem, 0,
+                             memory_region_size(&a->scuio->iomem));
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],
+                                &a->scuio_alias);
+
     /* INTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
         return;
@@ -267,9 +278,6 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),
                                   "aspeed.ipc1",
                                   sc->memmap[ASPEED_DEV_IPC1], 0x1000);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),
-                                  "aspeed.scuio",
-                                  sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),
                                   "aspeed.pric0",
                                   sc->memmap[ASPEED_DEV_PRIC0], 0x1000);
@@ -284,6 +292,8 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
 static const Property aspeed_27x0_coprocessor_properties[] = {
     DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),
+    DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,
+                     TYPE_ASPEED_SCU, AspeedSCUState *),
 };
 
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index f5c4a021616b..3a98bd232c0b 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -142,8 +142,6 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)
                             TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "ipc1", &a->ipc[1],
                             TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "scuio", &a->scuio,
-                            TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "pric0", &a->pric[0],
                             TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "pric1", &a->pric[1],
@@ -173,6 +171,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+    if (!a->scuio) {
+        error_setg(errp, TYPE_ASPEED27X0TSP_COPROCESSOR
+                   ": 'scuio' link is not set");
+        return;
+    }
+
     /* AST27X0 TSP Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
@@ -207,6 +211,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
                                 &a->scu_alias);
 
+    /* SCUIO */
+    memory_region_init_alias(&a->scuio_alias, OBJECT(a), "scuio.alias",
+                             &a->scuio->iomem, 0,
+                             memory_region_size(&a->scuio->iomem));
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],
+                                &a->scuio_alias);
+
     /* INTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
         return;
@@ -267,9 +278,6 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),
                                   "aspeed.ipc1",
                                   sc->memmap[ASPEED_DEV_IPC1], 0x1000);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),
-                                  "aspeed.scuio",
-                                  sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),
                                   "aspeed.pric0",
                                   sc->memmap[ASPEED_DEV_PRIC0], 0x1000);
@@ -284,6 +292,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
 static const Property aspeed_27x0_coprocessor_properties[] = {
     DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),
+    DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,
+                     TYPE_ASPEED_SCU, AspeedSCUState *),
 };
 
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,
-- 
2.55.0


