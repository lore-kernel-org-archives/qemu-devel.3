Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA90CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXyz-0001Fp-OR; Wed, 22 Oct 2025 08:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXyv-0001AA-H0
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXys-0008NI-Tm
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761136218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h+iSTY7ypTD5IhBhaGjoBU8rgZcYEQnS7JehcOzg5B0=;
 b=Rmcv1h+yayySDj3Zj0rv3X/fdaX/amplI8ZOysgcWHH0/9qtH+6kXqba4S39uDYyzJTR+6
 rT7gmryf+XkoFt0DrFvT/YnyE7/aXtS9UOzV8x3244VbeEb3zNQQ+JUvsKT6Dj+7S2DZL6
 sdsy6QrEBdFiQvhzEnkmZtL6ciWhUXc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-GOkRwBQZNYCdp5xdUN5D0g-1; Wed,
 22 Oct 2025 08:30:14 -0400
X-MC-Unique: GOkRwBQZNYCdp5xdUN5D0g-1
X-Mimecast-MFC-AGG-ID: GOkRwBQZNYCdp5xdUN5D0g_1761136213
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3AFB1956095; Wed, 22 Oct 2025 12:30:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19F8B180057E; Wed, 22 Oct 2025 12:30:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/16] hw/arm/ast27x0: Share single SCU instance across PSP, SSP,
 and TSP
Date: Wed, 22 Oct 2025 14:29:42 +0200
Message-ID: <20251022122953.877335-6-clg@redhat.com>
In-Reply-To: <20251022122953.877335-1-clg@redhat.com>
References: <20251022122953.877335-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

AST2700 has a single SCU hardware block, memory-mapped at
0x12C02000–0x12C03FFF from the perspective of the main CA35 processor (PSP).
The SSP and TSP coprocessors access this same SCU block at different
addresses: 0x72C02000–0x72C03FFF.

Previously, each subsystem (PSP, SSP, and TSP) instantiated its own SCU
device, resulting in three independent SCU instances in the QEMU model.
In real hardware, however, only a single SCU exists and is shared among
all processors.

This commit reworks the SCU model to correctly reflect the hardware
behavior by allowing SSP and TSP to reference the PSP’s SCU instance.
The following changes are introduced:

- Add a scu property to AspeedCoprocessorState for linking the
  coprocessor to the PSP’s SCU instance.
- Replace per-coprocessor SCU instantiation with a shared SCU link.
- Add "MemoryRegion scu_alias" to model address remapping for SSP and TSP.
- Create SCU alias regions in both SSP and TSP coprocessors and map
  them at 0x72C02000 to mirror the PSP’s SCU registers.
- Ensure the SCU device in PSP is realized before SSP/TSP alias setup.

With this change, PSP, SSP, and TSP now share a consistent SCU state,
matching the single-SCU hardware design of AST2700.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251015062210.3128710-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_coprocessor.h |  4 ++--
 hw/arm/aspeed_ast27x0-fc.c          |  4 ++++
 hw/arm/aspeed_ast27x0-ssp.c         | 13 +++++--------
 hw/arm/aspeed_ast27x0-tsp.c         | 13 +++++--------
 hw/arm/aspeed_coprocessor_common.c  |  2 ++
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index d9a5f517d7c7..c1f2c549c323 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -19,9 +19,10 @@ struct AspeedCoprocessorState {
     MemoryRegion sdram;
     MemoryRegion *sram;
     MemoryRegion sram_alias;
+    MemoryRegion scu_alias;
     Clock *sysclk;
 
-    AspeedSCUState scu;
+    AspeedSCUState *scu;
     AspeedSCUState scuio;
     AspeedTimerCtrlState timerctrl;
     SerialMM uart[ASPEED_UARTS_NUM];
@@ -36,7 +37,6 @@ struct AspeedCoprocessorClass {
 
     /** valid_cpu_types: NULL terminated array of a single CPU type. */
     const char * const *valid_cpu_types;
-    uint32_t silicon_rev;
     const hwaddr *memmap;
     const int *irqmap;
     int uarts_base;
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index dfac7d1e17b8..ba43a4620760 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -138,6 +138,8 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
                             sc->uarts_num, serial_hd(1));
     object_property_set_link(OBJECT(&s->ssp), "sram",
                              OBJECT(&psp->sram), &error_abort);
+    object_property_set_link(OBJECT(&s->ssp), "scu",
+                             OBJECT(&psp->scu), &error_abort);
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
         return false;
     }
@@ -170,6 +172,8 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
                             sc->uarts_num, serial_hd(2));
     object_property_set_link(OBJECT(&s->tsp), "sram",
                              OBJECT(&psp->sram), &error_abort);
+    object_property_set_link(OBJECT(&s->tsp), "scu",
+                             OBJECT(&psp->scu), &error_abort);
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
         return false;
     }
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 66c4ef6d1b74..577a3379c6c0 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -137,9 +137,7 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)
     int i;
 
     object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
-    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
-    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
 
     for (i = 0; i < sc->uarts_num; i++) {
         object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
@@ -203,11 +201,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
                                 &s->sram_alias);
 
     /* SCU */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
-        return;
-    }
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
-                    sc->memmap[ASPEED_DEV_SCU]);
+    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",
+                             &s->scu->iomem, 0,
+                             memory_region_size(&s->scu->iomem));
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
+                                &s->scu_alias);
 
     /* INTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
@@ -285,7 +283,6 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
     dc->realize = aspeed_soc_ast27x0ssp_realize;
 
     sc->valid_cpu_types = valid_cpu_types;
-    sc->silicon_rev = AST2700_A1_SILICON_REV;
     sc->uarts_num = 13;
     sc->uarts_base = ASPEED_DEV_UART0;
     sc->irqmap = aspeed_soc_ast27x0ssp_irqmap;
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 56b68adf541b..a7c141678fc2 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -137,9 +137,7 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)
     int i;
 
     object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
-    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
-    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
 
     for (i = 0; i < sc->uarts_num; i++) {
         object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
@@ -203,11 +201,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
                                 &s->sram_alias);
 
     /* SCU */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
-        return;
-    }
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
-                    sc->memmap[ASPEED_DEV_SCU]);
+    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",
+                             &s->scu->iomem, 0,
+                             memory_region_size(&s->scu->iomem));
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
+                                &s->scu_alias);
 
     /* INTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
@@ -285,7 +283,6 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,
     dc->realize = aspeed_soc_ast27x0tsp_realize;
 
     sc->valid_cpu_types = valid_cpu_types;
-    sc->silicon_rev = AST2700_A1_SILICON_REV;
     sc->uarts_num = 13;
     sc->uarts_base = ASPEED_DEV_UART0;
     sc->irqmap = aspeed_soc_ast27x0tsp_irqmap;
diff --git a/hw/arm/aspeed_coprocessor_common.c b/hw/arm/aspeed_coprocessor_common.c
index 8322ad5eb544..14e26bbe234e 100644
--- a/hw/arm/aspeed_coprocessor_common.c
+++ b/hw/arm/aspeed_coprocessor_common.c
@@ -27,6 +27,8 @@ static const Property aspeed_coprocessor_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_LINK("sram", AspeedCoprocessorState, sram, TYPE_MEMORY_REGION,
                      MemoryRegion *),
+    DEFINE_PROP_LINK("scu", AspeedCoprocessorState, scu, TYPE_ASPEED_SCU,
+                     AspeedSCUState *),
 };
 
 static void aspeed_coprocessor_class_init(ObjectClass *oc, const void *data)
-- 
2.51.0


