Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B776CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hw4-0005H8-8w; Mon, 13 Oct 2025 08:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hva-0004uk-EO
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvO-0008Ci-Ca
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVAPHq5CeoKAkjbrrNqZPoiL/G46kzVCOd4OTh1ST/o=;
 b=Ib8PLcjXBwk6MC/X1ZW4AMM9iiv3AyWSZdcMBpcMqIg0RhIMpq53GbaEWrPXsshizI+FGS
 YEQm/mkQVWmAPJ2BRws1WcF4Jk8IZ1h+E+PaQhuFhSdf1wWnDg+utBRSzwctj7F1M4cr7x
 5E8pmLSUGCGB0cKeLxnfB8yf7vqXMRw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-zoWCPJzuOUaep4sK2keV7w-1; Mon,
 13 Oct 2025 08:45:11 -0400
X-MC-Unique: zoWCPJzuOUaep4sK2keV7w-1
X-Mimecast-MFC-AGG-ID: zoWCPJzuOUaep4sK2keV7w_1760359510
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B982219540C3; Mon, 13 Oct 2025 12:45:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44F101800446; Mon, 13 Oct 2025 12:45:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/29] hw/arm/aspeed_ast27x0-ssp: Make AST27x0 SSP inherit from
 AspeedCoprocessor instead of AspeedSoC
Date: Mon, 13 Oct 2025 14:44:14 +0200
Message-ID: <20251013124421.71977-24-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
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

Refactor the AST27x0 SSP implementation to derive from the newly introduced
AspeedCoprocessor base class rather than AspeedSoC. The AspeedSoC class
contains many SoC-level fields and behaviors that are not applicable to
coprocessor subsystems like SSP, leading to unnecessary coupling and code size.

This change moves the Aspeed27x0SSPSoCState structure definition into
aspeed_coprocessor.h and updates related references in
aspeed_ast27x0-ssp.c and aspeed_ast27x0-fc.c to use
AspeedCoprocessorState and AspeedCoprocessorClass.

Key updates include:

- Replace inheritance from AspeedSoC -> AspeedCoprocessor.
- Replace type casts and class access macros (ASPEED_SOC_*) with
ASPEED_COPROCESSOR_*.

This refactor improves modularity, reduces memory footprint, and prepares
for future coprocessor variants to share a lighter-weight common base.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251013054334.955331-11-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_coprocessor.h | 12 ++++++++++++
 include/hw/arm/aspeed_soc.h         | 12 ------------
 hw/arm/aspeed_ast27x0-fc.c          | 10 +++++-----
 hw/arm/aspeed_ast27x0-ssp.c         | 30 +++++++++++++----------------
 hw/arm/meson.build                  |  2 +-
 5 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index 793c7b1f8be9..901b8d8e249d 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -41,4 +41,16 @@ struct AspeedCoprocessorClass {
     int uarts_num;
 };
 
+struct Aspeed27x0SSPSoCState {
+    AspeedCoprocessorState parent;
+    AspeedINTCState intc[2];
+    UnimplementedDeviceState ipc[2];
+    UnimplementedDeviceState scuio;
+
+    ARMv7MState armv7m;
+};
+
+#define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0SSPSoCState, ASPEED27X0SSP_SOC)
+
 #endif /* ASPEED_COPROCESSOR_H */
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 0e07c079f0cf..a34ab986a9da 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -153,18 +153,6 @@ struct Aspeed10x0SoCState {
     ARMv7MState armv7m;
 };
 
-struct Aspeed27x0SSPSoCState {
-    AspeedSoCState parent;
-    AspeedINTCState intc[2];
-    UnimplementedDeviceState ipc[2];
-    UnimplementedDeviceState scuio;
-
-    ARMv7MState armv7m;
-};
-
-#define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
-OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0SSPSoCState, ASPEED27X0SSP_SOC)
-
 struct Aspeed27x0TSPSoCState {
     AspeedSoCState parent;
     AspeedINTCState intc[2];
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index e598f57ca228..4315e8da98d2 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -21,7 +21,7 @@
 #include "hw/loader.h"
 #include "hw/arm/boot.h"
 #include "hw/block/flash.h"
-
+#include "hw/arm/aspeed_coprocessor.h"
 
 #define TYPE_AST2700A1FC MACHINE_TYPE_NAME("ast2700fc")
 OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700A1FC);
@@ -115,8 +115,8 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
 
 static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
 {
-    AspeedSoCState *soc;
-    AspeedSoCClass *sc;
+    AspeedCoprocessorState *soc;
+    AspeedCoprocessorClass *sc;
     Ast2700FCState *s = AST2700A1FC(machine);
     s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
     clock_set_hz(s->ssp_sysclk, 200000000ULL);
@@ -129,8 +129,8 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
     object_property_set_link(OBJECT(&s->ssp), "memory",
                              OBJECT(&s->ssp_memory), &error_abort);
 
-    soc = ASPEED_SOC(&s->ssp);
-    sc = ASPEED_SOC_GET_CLASS(soc);
+    soc = ASPEED_COPROCESSOR(&s->ssp);
+    sc = ASPEED_COPROCESSOR_GET_CLASS(soc);
     aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART4, sc->uarts_base,
                             sc->uarts_num, serial_hd(1));
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index f90d14437291..1ebf06299ebe 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -14,6 +14,7 @@
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
+#include "hw/arm/aspeed_coprocessor.h"
 
 #define AST2700_SSP_RAM_SIZE (32 * MiB)
 
@@ -104,10 +105,11 @@ static struct nvic_intc_irq_info ast2700_ssp_intcmap[] = {
     {136, 0, 9, NULL},
 };
 
-static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedSoCState *s, int dev)
+static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedCoprocessorState *s,
+                                              int dev)
 {
     Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(s);
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
 
     int or_idx;
     int idx;
@@ -129,8 +131,8 @@ static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedSoCState *s, int dev)
 static void aspeed_soc_ast27x0ssp_init(Object *obj)
 {
     Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(obj);
-    AspeedSoCState *s = ASPEED_SOC(obj);
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    AspeedCoprocessorState *s = ASPEED_COPROCESSOR(obj);
+    AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     int i;
 
     object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
@@ -160,8 +162,8 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
 {
     Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(dev_soc);
-    AspeedSoCState *s = ASPEED_SOC(dev_soc);
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
+    AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
     g_autofree char *sram_name = NULL;
     int uart;
@@ -185,8 +187,8 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     sram_name = g_strdup_printf("aspeed.dram.%d",
                                 CPU(a->armv7m.cpu)->cpu_index);
 
-    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size,
-                                errp)) {
+    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name,
+                                AST2700_SSP_RAM_SIZE, errp)) {
         return;
     }
     memory_region_add_subregion(s->memory,
@@ -268,30 +270,24 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass, const void *dat
         NULL
     };
     DeviceClass *dc = DEVICE_CLASS(klass);
-    AspeedSoCClass *sc = ASPEED_SOC_CLASS(dc);
+    AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_CLASS(dc);
 
-    /* Reason: The Aspeed SoC can only be instantiated from a board */
+    /* Reason: The Aspeed Coprocessor can only be instantiated from a board */
     dc->user_creatable = false;
     dc->realize = aspeed_soc_ast27x0ssp_realize;
 
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev = AST2700_A1_SILICON_REV;
-    sc->sram_size = AST2700_SSP_RAM_SIZE;
-    sc->spis_num = 0;
-    sc->ehcis_num = 0;
-    sc->wdts_num = 0;
-    sc->macs_num = 0;
     sc->uarts_num = 13;
     sc->uarts_base = ASPEED_DEV_UART0;
     sc->irqmap = aspeed_soc_ast27x0ssp_irqmap;
     sc->memmap = aspeed_soc_ast27x0ssp_memmap;
-    sc->num_cpus = 1;
 }
 
 static const TypeInfo aspeed_soc_ast27x0ssp_types[] = {
     {
         .name           = TYPE_ASPEED27X0SSP_SOC,
-        .parent         = TYPE_ASPEED_SOC,
+        .parent         = TYPE_ASPEED_COPROCESSOR,
         .instance_size  = sizeof(Aspeed27x0SSPSoCState),
         .instance_init  = aspeed_soc_ast27x0ssp_init,
         .class_init     = aspeed_soc_ast27x0ssp_class_init,
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 56bdb88b1175..b9e02ace7f21 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -45,7 +45,6 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
   'aspeed_ast2600.c',
-  'aspeed_ast27x0-ssp.c',
   'aspeed_ast27x0-tsp.c',
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
@@ -53,6 +52,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
 arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
   'aspeed_ast27x0.c',
   'aspeed_ast27x0-fc.c',
+  'aspeed_ast27x0-ssp.c',
   'aspeed_coprocessor_common.c'))
 arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2.c'))
 arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2-tz.c'))
-- 
2.51.0


