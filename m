Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE2BC79F8C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vckAz-0006GM-9e; Mon, 05 Jan 2026 07:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck99-0004KS-5c
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck96-00085K-Ra
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2eN4X3uyfV9cJriJXGMysA4V49qLGAdRFXwkwfMgEWE=;
 b=ZAeN44N8p9wnHBqH2u1ZeLADO98C9OOWcahd5YG/NjyDbdNaKd+pYJufiaNRKaKyZINdc5
 P5yKqMIJ/Hc33vyV45gaT9J8aaqAiJuTtn4VscjsOBATqdzCWRzEmsaVWkjbsa0JFYYiei
 WE2FjEt68kCbcpTIUJNxg3m9EvreAX0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-WwKwJ853MMCFq-PbYxOElg-1; Mon,
 05 Jan 2026 07:57:12 -0500
X-MC-Unique: WwKwJ853MMCFq-PbYxOElg-1
X-Mimecast-MFC-AGG-ID: WwKwJ853MMCFq-PbYxOElg_1767617831
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40554195609F; Mon,  5 Jan 2026 12:57:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E884B1953984; Mon,  5 Jan 2026 12:57:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Yubin Zou <yubinz@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/36] hw/arm/aspeed_soc: Update Aspeed SoC to support two
 SGPIO controllers
Date: Mon,  5 Jan 2026 13:56:03 +0100
Message-ID: <20260105125613.622667-27-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

From: Yubin Zou <yubinz@google.com>

This commit updates the Aspeed SoC model to support two SGPIO
controllers, reflecting the hardware capabilities of the AST2700

The memory map and interrupt map are updated to include entries for
two SGPIO controllers (SGPIOM0 and SGPIOM1). This change is a
prerequisite for the full implementation of the SGPIO device model.

Signed-off-by: Yubin Zou <yubinz@google.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251219-aspeed-sgpio-v5-4-fd5593178144@google.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  8 ++++++--
 hw/arm/aspeed_ast10x0.c     |  6 +++---
 hw/arm/aspeed_ast27x0.c     | 10 ++++++++++
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 4b8e599f1a53..18ff961a3850 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -32,6 +32,7 @@
 #include "hw/net/ftgmac100.h"
 #include "target/arm/cpu.h"
 #include "hw/gpio/aspeed_gpio.h"
+#include "hw/gpio/aspeed_sgpio.h"
 #include "hw/sd/aspeed_sdhci.h"
 #include "hw/usb/hcd-ehci.h"
 #include "qom/object.h"
@@ -46,6 +47,7 @@
 #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
 
 #define ASPEED_SPIS_NUM  3
+#define ASPEED_SGPIO_NUM 2
 #define ASPEED_EHCIS_NUM 4
 #define ASPEED_WDTS_NUM  8
 #define ASPEED_CPUS_NUM  4
@@ -89,6 +91,7 @@ struct AspeedSoCState {
     AspeedMiiState mii[ASPEED_MACS_NUM];
     AspeedGPIOState gpio;
     AspeedGPIOState gpio_1_8v;
+    AspeedSGPIOState sgpiom[ASPEED_SGPIO_NUM];
     AspeedSDHCIState sdhci;
     AspeedSDHCIState emmc;
     AspeedLPCState lpc;
@@ -106,7 +109,6 @@ struct AspeedSoCState {
     UnimplementedDeviceState pwm;
     UnimplementedDeviceState espi;
     UnimplementedDeviceState udc;
-    UnimplementedDeviceState sgpiom;
     UnimplementedDeviceState ltpi;
     UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
     AspeedAPB2OPBState fsi[2];
@@ -166,6 +168,7 @@ struct AspeedSoCClass {
     uint64_t secsram_size;
     int pcie_num;
     int spis_num;
+    int sgpio_num;
     int ehcis_num;
     int wdts_num;
     int macs_num;
@@ -221,6 +224,8 @@ enum {
     ASPEED_DEV_SDHCI,
     ASPEED_DEV_GPIO,
     ASPEED_DEV_GPIO_1_8V,
+    ASPEED_DEV_SGPIOM0,
+    ASPEED_DEV_SGPIOM1,
     ASPEED_DEV_RTC,
     ASPEED_DEV_TIMER1,
     ASPEED_DEV_TIMER2,
@@ -263,7 +268,6 @@ enum {
     ASPEED_DEV_I3C,
     ASPEED_DEV_ESPI,
     ASPEED_DEV_UDC,
-    ASPEED_DEV_SGPIOM,
     ASPEED_DEV_JTAG0,
     ASPEED_DEV_JTAG1,
     ASPEED_DEV_FSI1,
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 44e1d59ddb3c..41a4e82c1f87 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -36,7 +36,7 @@ static const hwaddr aspeed_soc_ast1030_memmap[] = {
     [ASPEED_DEV_ESPI]      = 0x7E6EE000,
     [ASPEED_DEV_SBC]       = 0x7E6F2000,
     [ASPEED_DEV_GPIO]      = 0x7E780000,
-    [ASPEED_DEV_SGPIOM]    = 0x7E780500,
+    [ASPEED_DEV_SGPIOM0]   = 0x7E780500,
     [ASPEED_DEV_TIMER1]    = 0x7E782000,
     [ASPEED_DEV_UART1]     = 0x7E783000,
     [ASPEED_DEV_UART2]     = 0x7E78D000,
@@ -94,7 +94,7 @@ static const int aspeed_soc_ast1030_irqmap[] = {
     [ASPEED_DEV_I2C]       = 110, /* 110 ~ 123 */
     [ASPEED_DEV_KCS]       = 138, /* 138 -> 142 */
     [ASPEED_DEV_UDC]       = 9,
-    [ASPEED_DEV_SGPIOM]    = 51,
+    [ASPEED_DEV_SGPIOM0]   = 51,
     [ASPEED_DEV_JTAG0]     = 27,
     [ASPEED_DEV_JTAG1]     = 53,
 };
@@ -406,7 +406,7 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
                                   sc->memmap[ASPEED_DEV_UDC], 0x1000);
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom),
                                   "aspeed.sgpiom",
-                                  sc->memmap[ASPEED_DEV_SGPIOM], 0x100);
+                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x100);
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),
                                   "aspeed.jtag",
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 95f155fcf1ad..9f471c399491 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -69,6 +69,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_ADC]       =  0x14C00000,
     [ASPEED_DEV_SCUIO]     =  0x14C02000,
     [ASPEED_DEV_GPIO]      =  0x14C0B000,
+    [ASPEED_DEV_SGPIOM0]   =  0x14C0C000,
+    [ASPEED_DEV_SGPIOM1]   =  0x14C0D000,
     [ASPEED_DEV_I2C]       =  0x14C0F000,
     [ASPEED_DEV_INTCIO]    =  0x14C18000,
     [ASPEED_DEV_PCIE_PHY2] =  0x14C1C000,
@@ -122,6 +124,8 @@ static const int aspeed_soc_ast2700a0_irqmap[] = {
     [ASPEED_DEV_KCS]       = 128,
     [ASPEED_DEV_ADC]       = 130,
     [ASPEED_DEV_GPIO]      = 130,
+    [ASPEED_DEV_SGPIOM0]   = 130,
+    [ASPEED_DEV_SGPIOM1]   = 130,
     [ASPEED_DEV_I2C]       = 130,
     [ASPEED_DEV_FMC]       = 131,
     [ASPEED_DEV_WDT]       = 131,
@@ -173,6 +177,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_I2C]       = 194,
     [ASPEED_DEV_ADC]       = 194,
     [ASPEED_DEV_GPIO]      = 194,
+    [ASPEED_DEV_SGPIOM0]   = 194,
+    [ASPEED_DEV_SGPIOM1]   = 194,
     [ASPEED_DEV_FMC]       = 195,
     [ASPEED_DEV_WDT]       = 195,
     [ASPEED_DEV_PWM]       = 195,
@@ -214,6 +220,8 @@ static const int ast2700_gic130_gic194_intcmap[] = {
     [ASPEED_DEV_I2C]        = 0,
     [ASPEED_DEV_ADC]        = 16,
     [ASPEED_DEV_GPIO]       = 18,
+    [ASPEED_DEV_SGPIOM0]    = 21,
+    [ASPEED_DEV_SGPIOM1]    = 24,
 };
 
 /* GICINT 131 */
@@ -1063,6 +1071,7 @@ static void aspeed_soc_ast2700a0_class_init(ObjectClass *oc, const void *data)
     sc->sram_size    = 0x20000;
     sc->pcie_num     = 0;
     sc->spis_num     = 3;
+    sc->sgpio_num    = 2;
     sc->ehcis_num    = 2;
     sc->wdts_num     = 8;
     sc->macs_num     = 1;
@@ -1091,6 +1100,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
     sc->sram_size    = 0x20000;
     sc->pcie_num     = 3;
     sc->spis_num     = 3;
+    sc->sgpio_num    = 2;
     sc->ehcis_num    = 4;
     sc->wdts_num     = 8;
     sc->macs_num     = 3;
-- 
2.52.0


