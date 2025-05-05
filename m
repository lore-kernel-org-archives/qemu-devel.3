Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EF4C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrn2-0006dn-SP; Mon, 05 May 2025 05:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrmn-00060C-3B
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrmj-0006Bz-4x
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746436007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oswtdtgKHArstMdjH9TboSKo8ZZZq+gR8hY+A+3zQYU=;
 b=YVCE1SmTB6e0uvdeZfrM4J/SzJ+l2woR5lyRtgaUJga7q6i56kGNcI2OUk85EPMWEQmA98
 THXdSfLyaGKukXDl59wL3iLjLpqOHfZ5jmQZ4sWibdJnDqoayNutD4VN0qItdd51ntKxGN
 hbl0a3IB9W5RsbTUsEAXPwRkHgq7vs8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-UysjpmMCP9ePSPPkoWg8-g-1; Mon,
 05 May 2025 05:06:43 -0400
X-MC-Unique: UysjpmMCP9ePSPPkoWg8-g-1
X-Mimecast-MFC-AGG-ID: UysjpmMCP9ePSPPkoWg8-g_1746436003
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97447180087C; Mon,  5 May 2025 09:06:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B65F030001A2; Mon,  5 May 2025 09:06:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/23] hw/arm: ast27x0: Wire up EHCI controllers
Date: Mon,  5 May 2025 11:06:13 +0200
Message-ID: <20250505090635.778785-2-clg@redhat.com>
In-Reply-To: <20250505090635.778785-1-clg@redhat.com>
References: <20250505090635.778785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Troy Lee <troy_lee@aspeedtech.com>

AST27x0 has 4 EHCI controllers, where each CPU and I/O die has 2
instances. This patch use existing TYPE_PLATFORM_EHCI. After wiring up
the EHCI controller, the ast2700a1-evb can find up to 4 USB EHCI
interfaces.

ehci-platform 12061000.usb: EHCI Host Controller
ehci-platform 12061000.usb: new USB bus registered, assigned bus number 2
ehci-platform 12063000.usb: EHCI Host Controller
ehci-platform 12063000.usb: new USB bus registered, assigned bus number 3
ehci-platform 12061000.usb: irq 88, io mem 0x12061000
ehci-platform 12063000.usb: irq 90, io mem 0x12063000
ehci-platform 14121000.usb: EHCI Host Controller
ehci-platform 14123000.usb: EHCI Host Controller
ehci-platform 12061000.usb: USB 2.0 started, EHCI 1.00
ehci-platform 14121000.usb: new USB bus registered, assigned bus number 5
ehci-platform 14123000.usb: new USB bus registered, assigned bus number 6
ehci-platform 14121000.usb: irq 91, io mem 0x14121000
ehci-platform 14123000.usb: irq 92, io mem 0x14123000
ehci-platform 12063000.usb: USB 2.0 started, EHCI 1.00
usb usb2: Manufacturer: Linux 6.6.78-dirty-bafd2830c17c-gbafd2830c17c-dirty ehci_hcd
usb usb3: Manufacturer: Linux 6.6.78-dirty-bafd2830c17c-gbafd2830c17c-dirty ehci_hcd
ehci-platform 14121000.usb: USB 2.0 started, EHCI 1.00
usb usb5: Manufacturer: Linux 6.6.78-dirty-bafd2830c17c-gbafd2830c17c-dirty ehci_hcd
ehci-platform 14123000.usb: USB 2.0 started, EHCI 1.00
usb usb6: Manufacturer: Linux 6.6.78-dirty-bafd2830c17c-gbafd2830c17c-dirty ehci_hcd

Note that, AST27x0A0 only has 2 EHCI controllers due to hw issue.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250317065938.1902272-2-troy_lee@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  4 +++-
 hw/arm/aspeed_ast27x0.c     | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index f069d17d1629..c1e80c8908b3 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -43,7 +43,7 @@
 #include "hw/intc/arm_gicv3.h"
 
 #define ASPEED_SPIS_NUM  3
-#define ASPEED_EHCIS_NUM 2
+#define ASPEED_EHCIS_NUM 4
 #define ASPEED_WDTS_NUM  8
 #define ASPEED_CPUS_NUM  4
 #define ASPEED_MACS_NUM  4
@@ -192,6 +192,8 @@ enum {
     ASPEED_DEV_SPI2,
     ASPEED_DEV_EHCI1,
     ASPEED_DEV_EHCI2,
+    ASPEED_DEV_EHCI3,
+    ASPEED_DEV_EHCI4,
     ASPEED_DEV_VIC,
     ASPEED_DEV_INTC,
     ASPEED_DEV_INTCIO,
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 63a366f7e837..ea4a611b9068 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -25,6 +25,8 @@
 
 static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_SRAM]      =  0x10000000,
+    [ASPEED_DEV_EHCI1]     =  0x12061000,
+    [ASPEED_DEV_EHCI2]     =  0x12063000,
     [ASPEED_DEV_HACE]      =  0x12070000,
     [ASPEED_DEV_EMMC]      =  0x12090000,
     [ASPEED_DEV_INTC]      =  0x12100000,
@@ -47,6 +49,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_ETH2]      =  0x14060000,
     [ASPEED_DEV_ETH3]      =  0x14070000,
     [ASPEED_DEV_SDHCI]     =  0x14080000,
+    [ASPEED_DEV_EHCI3]     =  0x14121000,
+    [ASPEED_DEV_EHCI4]     =  0x14123000,
     [ASPEED_DEV_ADC]       =  0x14C00000,
     [ASPEED_DEV_SCUIO]     =  0x14C02000,
     [ASPEED_DEV_GPIO]      =  0x14C0B000,
@@ -91,6 +95,8 @@ static const int aspeed_soc_ast2700a0_irqmap[] = {
     [ASPEED_DEV_TIMER7]    = 22,
     [ASPEED_DEV_TIMER8]    = 23,
     [ASPEED_DEV_DP]        = 28,
+    [ASPEED_DEV_EHCI1]     = 33,
+    [ASPEED_DEV_EHCI2]     = 37,
     [ASPEED_DEV_LPC]       = 128,
     [ASPEED_DEV_IBT]       = 128,
     [ASPEED_DEV_KCS]       = 128,
@@ -137,6 +143,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_TIMER7]    = 22,
     [ASPEED_DEV_TIMER8]    = 23,
     [ASPEED_DEV_DP]        = 28,
+    [ASPEED_DEV_EHCI1]     = 33,
+    [ASPEED_DEV_EHCI2]     = 37,
     [ASPEED_DEV_LPC]       = 192,
     [ASPEED_DEV_IBT]       = 192,
     [ASPEED_DEV_KCS]       = 192,
@@ -212,6 +220,8 @@ static const int ast2700_gic132_gic196_intcmap[] = {
     [ASPEED_DEV_UART10]    = 16,
     [ASPEED_DEV_UART11]    = 17,
     [ASPEED_DEV_UART12]    = 18,
+    [ASPEED_DEV_EHCI3]     = 28,
+    [ASPEED_DEV_EHCI4]     = 29,
 };
 
 /* GICINT 133 */
@@ -434,6 +444,11 @@ static void aspeed_soc_ast2700_init(Object *obj)
         object_initialize_child(obj, "spi[*]", &s->spi[i], typename);
     }
 
+    for (i = 0; i < sc->ehcis_num; i++) {
+        object_initialize_child(obj, "ehci[*]", &s->ehci[i],
+                                TYPE_PLATFORM_EHCI);
+    }
+
     snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
     object_initialize_child(obj, "sdmc", &s->sdmc, typename);
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
@@ -709,6 +724,17 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                         ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
     }
 
+    /* EHCI */
+    for (i = 0; i < sc->ehcis_num; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
+            return;
+        }
+        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                        sc->memmap[ASPEED_DEV_EHCI1 + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                           aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
+    }
+
     /*
      * SDMC - SDRAM Memory Controller
      * The SDMC controller is unlocked at SPL stage.
@@ -900,6 +926,7 @@ static void aspeed_soc_ast2700a0_class_init(ObjectClass *oc, const void *data)
     sc->silicon_rev  = AST2700_A0_SILICON_REV;
     sc->sram_size    = 0x20000;
     sc->spis_num     = 3;
+    sc->ehcis_num    = 2;
     sc->wdts_num     = 8;
     sc->macs_num     = 1;
     sc->uarts_num    = 13;
@@ -927,6 +954,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
     sc->silicon_rev  = AST2700_A1_SILICON_REV;
     sc->sram_size    = 0x20000;
     sc->spis_num     = 3;
+    sc->ehcis_num    = 4;
     sc->wdts_num     = 8;
     sc->macs_num     = 3;
     sc->uarts_num    = 13;
-- 
2.49.0


