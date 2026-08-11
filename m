Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01083C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNR-0000Ox-UY; Tue, 11 Aug 2026 12:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpN2-0007yQ-Vf
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMz-0000Zl-Q2
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9E55Ye2fkqHrKpeIFrpfy4+viF+fVXAqvwT0EPojipc=;
 b=E8WBvCLcTJcZV/kLsZ7QPYxo2f+9mm3D1s6BVd7eswUfWB3G8IUAIXg9DfqFpKPh+FxnaB
 Q1s37eTwgtpGtXzXNvfeCrWDFsgsrVzv/unbm+bI1RijWBBHjDFYAQucZsQsvnGw0FC0PL
 A2ca4k2DulCdlHZLRtLYWh5CrJyaiS4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-p2QYrI34OZy6enBqcBoFwg-1; Tue,
 11 Aug 2026 12:30:25 -0400
X-MC-Unique: p2QYrI34OZy6enBqcBoFwg-1
X-Mimecast-MFC-AGG-ID: p2QYrI34OZy6enBqcBoFwg_1786465824
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2FA6180035C; Tue, 11 Aug 2026 16:30:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C80C0195DF96; Tue, 11 Aug 2026 16:30:22 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/83] hw/arm/aspeed: Use Aspeed2700SCUState for AST2700 users
Date: Tue, 11 Aug 2026 18:28:34 +0200
Message-ID: <20260811162938.1403216-20-clg@redhat.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now that Aspeed2700SCUState has been introduced, update the AST1700 and
AST27x0 SoCs to instantiate the AST2700-specific SCU subclass instead of
the generic AspeedSCUState.

Also update the AST27x0 FC board to link the SSP/TSP coprocessors to the
AST2700 SCU instance.

This prepares the AST2700 platform for subsequent patches that move
AST2700-specific SCU functionality into the subclass.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260717084559.3477061-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_ast1700.h |  2 +-
 include/hw/arm/aspeed_soc.h     |  1 +
 hw/arm/aspeed_ast27x0-fc.c      |  4 ++--
 hw/arm/aspeed_ast27x0.c         | 16 ++++++++--------
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index f7bd4e8650ba..39c5977cf109 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -41,7 +41,7 @@ struct AspeedAST1700SoCState {
     MemoryRegion sram;
     AspeedSMCState spi;
     AspeedADCState adc;
-    AspeedSCUState scu;
+    Aspeed2700SCUState scu;
     AspeedGPIOState gpio;
     AspeedSGPIOState sgpiom[AST1700_SGPIO_NUM];
     AspeedI2CState i2c;
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 41dc04e2930f..cd68c7f1caa2 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -151,6 +151,7 @@ struct Aspeed27x0SoCState {
     AspeedINTCState intcioexp[ASPEED_IOEXP_NUM];
     GICv3State gic;
     MemoryRegion dram_empty;
+    Aspeed2700SCUState scu;
 };
 
 #define TYPE_ASPEED27X0_SOC "aspeed27x0-soc"
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 7d9fade68dab..8d49bb95d67b 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -158,7 +158,7 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
     object_property_set_link(OBJECT(&s->ssp), "sram",
                              OBJECT(&psp->sram), &error_abort);
     object_property_set_link(OBJECT(&s->ssp), "scu",
-                             OBJECT(&psp->scu), &error_abort);
+                             OBJECT(&s->ca35.scu), &error_abort);
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
         return false;
     }
@@ -190,7 +190,7 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
     object_property_set_link(OBJECT(&s->tsp), "sram",
                              OBJECT(&psp->sram), &error_abort);
     object_property_set_link(OBJECT(&s->tsp), "scu",
-                             OBJECT(&psp->scu), &error_abort);
+                             OBJECT(&s->ca35.scu), &error_abort);
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
         return false;
     }
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 7c062580f2b1..6365dbd638b5 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -435,12 +435,12 @@ static void aspeed_soc_ast2700_init(Object *obj)
 
     object_initialize_child(obj, "gic", &a->gic, gicv3_class_name());
 
-    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);
-    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
+    object_initialize_child(obj, "scu", &a->scu, TYPE_ASPEED_2700_SCU);
+    qdev_prop_set_uint32(DEVICE(&a->scu), "silicon-rev",
                          sc->silicon_rev);
-    object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
+    object_property_add_alias(obj, "hw-strap1", OBJECT(&a->scu),
                               "hw-strap1");
-    object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
+    object_property_add_alias(obj, "hw-prot-key", OBJECT(&a->scu),
                               "hw-prot-key");
 
     object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUIO);
@@ -808,10 +808,10 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                                 sc->memmap[ASPEED_DEV_VBOOTROM], &s->vbootrom);
 
     /* SCU */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->scu), errp)) {
         return;
     }
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->scu), 0,
                     sc->memmap[ASPEED_DEV_SCU]);
 
     /* SCU1 */
@@ -934,7 +934,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
         hwaddr wdt_offset = sc->memmap[ASPEED_DEV_WDT] + i * awc->iosize;
 
-        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu),
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&a->scu),
                                  &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
             return;
@@ -1037,7 +1037,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_EMMC));
 
     /* Timer */
-    object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
+    object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&a->scu),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
         return;
-- 
2.55.0


