Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F781C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNe-0000xC-Lf; Tue, 11 Aug 2026 12:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNP-0000IE-4c
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNN-0000ge-A6
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUqu1rILv8G/Wk8qQbfrEaPHubvKy3vTc+2h6bDozyo=;
 b=jOuzu+O08NFtKNoD+f5gJv0NN1Fqb+tq8Hrs1/3GyIsZGzxLOpHRQoEOwOz+WYtf5UE2SJ
 tQQi0eS4m76muM//fBYkqVcgXplzi3DeXsLo76ck1gWRoVKspjoGUGfbQK7D9U3/p7mz7H
 qJmw/MWkuq5T/BXSsApYjT8gfV8853s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-RNTMf6cMMzyiUabmgLHBtA-1; Tue,
 11 Aug 2026 12:30:37 -0400
X-MC-Unique: RNTMf6cMMzyiUabmgLHBtA-1
X-Mimecast-MFC-AGG-ID: RNTMf6cMMzyiUabmgLHBtA_1786465836
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D75C5195604F; Tue, 11 Aug 2026 16:30:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EE97195DF91; Tue, 11 Aug 2026 16:30:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/83] hw/arm/ast27x0: Share FMC controller with SSP and TSP
Date: Tue, 11 Aug 2026 18:28:39 +0200
Message-ID: <20260811162938.1403216-25-clg@redhat.com>
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

AST2700 provides a single FMC controller shared by the main CA35 processor
(PSP) and the SSP/TSP coprocessors.

>From the PSP perspective, the FMC controller is memory-mapped at
0x14000000–0x140000FF. The SSP and TSP access the same controller through
a different address window at 0x74000000–0x740000FF.

This change allows the SSP and TSP SoC models to reference the existing
PSP FMC instance instead of creating independent controllers. An MMIO
alias is added in the SSP and TSP address spaces to map their FMC access
window to the shared FMC device.

This ensures consistent FMC state across PSP, SSP, and TSP and matches
the AST2700 hardware design.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260717084559.3477061-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_coprocessor.h |  7 +++++++
 hw/arm/aspeed_ast27x0-fc.c          |  4 ++++
 hw/arm/aspeed_ast27x0-ssp.c         | 16 ++++++++++++++++
 hw/arm/aspeed_ast27x0-tsp.c         | 16 ++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index b77ea06e7f68..acb8b0645777 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -49,10 +49,17 @@ struct Aspeed27x0CoprocessorState {
 
     ARMv7MState armv7m;
 
+    /*
+     * SCU, SCUIO and FMC are not owned by this coprocessor: they are
+     * shared with the main PSP SoC, and only aliased into this
+     * coprocessor's own address space here.
+     */
     MemoryRegion scu_alias;
     MemoryRegion scuio_alias;
+    MemoryRegion fmc_alias;
     Aspeed2700SCUState *scu;
     AspeedSCUState *scuio;
+    AspeedSMCState *fmc;
 };
 
 #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index d14a42ebca3f..058cea42edca 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -159,6 +159,8 @@ static bool ast2700fc_ssp_init(Ast2700FCState *s, AspeedSoCState *psp,
                              OBJECT(&s->ca35.scu), &error_abort);
     object_property_set_link(OBJECT(&s->ssp), "scuio",
                              OBJECT(&psp->scuio), &error_abort);
+    object_property_set_link(OBJECT(&s->ssp), "fmc",
+                             OBJECT(&psp->fmc), &error_abort);
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
         return false;
     }
@@ -191,6 +193,8 @@ static bool ast2700fc_tsp_init(Ast2700FCState *s, AspeedSoCState *psp,
                              OBJECT(&s->ca35.scu), &error_abort);
     object_property_set_link(OBJECT(&s->tsp), "scuio",
                              OBJECT(&psp->scuio), &error_abort);
+    object_property_set_link(OBJECT(&s->tsp), "fmc",
+                             OBJECT(&psp->fmc), &error_abort);
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
         return false;
     }
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index fa492f179732..e03653086c88 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -27,6 +27,7 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
     [ASPEED_DEV_TIMER1]    =  0x72C10000,
     [ASPEED_DEV_UART4]     =  0x72C1A000,
     [ASPEED_DEV_IPC0]      =  0x72C1C000,
+    [ASPEED_DEV_FMC]       =  0x74000000,
     [ASPEED_DEV_PRIC1]     =  0x74100000,
     [ASPEED_DEV_SCUIO]     =  0x74C02000,
     [ASPEED_DEV_OTP]       =  0x74C07000,
@@ -177,6 +178,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+    if (!a->fmc) {
+        error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR
+                   ": 'fmc' link is not set");
+        return;
+    }
+
     /* AST27X0 SSP Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
@@ -269,6 +276,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,
                        aspeed_soc_ast27x0ssp_get_irq(s, s->uart_dev));
 
+    /* FMC */
+    memory_region_init_alias(&a->fmc_alias, OBJECT(a), "fmc.alias",
+                             &a->fmc->mmio, 0,
+                             memory_region_size(&a->fmc->mmio));
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],
+                                &a->fmc_alias);
+
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
                                   "aspeed.timerctrl",
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);
@@ -294,6 +308,8 @@ static const Property aspeed_27x0_coprocessor_properties[] = {
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),
     DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,
                      TYPE_ASPEED_SCU, AspeedSCUState *),
+    DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_SMC,
+                     AspeedSMCState *),
 };
 
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 3a98bd232c0b..39ba062a20f7 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -27,6 +27,7 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
     [ASPEED_DEV_TIMER1]    =  0x72C10000,
     [ASPEED_DEV_UART4]     =  0x72C1A000,
     [ASPEED_DEV_IPC0]      =  0x72C1C000,
+    [ASPEED_DEV_FMC]       =  0x74000000,
     [ASPEED_DEV_PRIC1]     =  0x74100000,
     [ASPEED_DEV_SCUIO]     =  0x74C02000,
     [ASPEED_DEV_OTP]       =  0x74C07000,
@@ -177,6 +178,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+    if (!a->fmc) {
+        error_setg(errp, TYPE_ASPEED27X0TSP_COPROCESSOR
+                   ": 'fmc' link is not set");
+        return;
+    }
+
     /* AST27X0 TSP Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
@@ -269,6 +276,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,
                        aspeed_soc_ast27x0tsp_get_irq(s, s->uart_dev));
 
+    /* FMC */
+    memory_region_init_alias(&a->fmc_alias, OBJECT(a), "fmc.alias",
+                             &a->fmc->mmio, 0,
+                             memory_region_size(&a->fmc->mmio));
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],
+                                &a->fmc_alias);
+
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
                                   "aspeed.timerctrl",
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);
@@ -294,6 +308,8 @@ static const Property aspeed_27x0_coprocessor_properties[] = {
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),
     DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,
                      TYPE_ASPEED_SCU, AspeedSCUState *),
+    DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_SMC,
+                     AspeedSMCState *),
 };
 
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,
-- 
2.55.0


