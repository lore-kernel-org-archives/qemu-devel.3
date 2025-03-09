Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F5EC28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH6T-0004ov-5I; Sun, 09 Mar 2025 09:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5k-0002B8-PO
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5h-0003xj-Tr
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lY/mgkz7UKbtun2cufg6h3yp/eLSgCuByf8NHRBx48M=;
 b=DJEXSXqOjABfR6hG4/4tPHdnXQ0QoVGQJVsFwpufjQP5kk2gUPKZh+Mou7KNVqkXhPXStA
 aLmrjFUXB7FhftqftT7vFBxepdDjGDmUXAZLm9yzINYXgl1wwjXkQsgjiNQ8oauoBC6WRo
 8T4fqT5rzsffyKQXDoPI6+dt33505Dk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-HoPlnY55N2mTQ43_Vz7RuA-1; Sun,
 09 Mar 2025 09:53:13 -0400
X-MC-Unique: HoPlnY55N2mTQ43_Vz7RuA-1
X-Mimecast-MFC-AGG-ID: HoPlnY55N2mTQ43_Vz7RuA_1741528393
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0084B195608B; Sun,  9 Mar 2025 13:53:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4ED171956094; Sun,  9 Mar 2025 13:53:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 39/46] hw/arm/aspeed_ast27x0: Add SoC Support for AST2700 A1
Date: Sun,  9 Mar 2025 14:51:23 +0100
Message-ID: <20250309135130.545764-40-clg@redhat.com>
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The memory map for AST2700 A1 remains compatible with AST2700 A0. However, the
IRQ mapping has been updated for AST2700 A1, with GIC interrupts now ranging
from 192 to 201. Add a new IRQ map table for AST2700 A1.
Add "aspeed_soc_ast2700a1_class_init" to initialize the AST2700 A1 SoC.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250307035945.3698802-23-jamin_lin@aspeedtech.com
[ clg: Removed sc->name ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0.c | 79 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 8ed57d23ef1c..682ab9bf8a38 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -120,6 +120,52 @@ static const int aspeed_soc_ast2700a0_irqmap[] = {
     [ASPEED_DEV_SDHCI]     = 133,
 };
 
+static const int aspeed_soc_ast2700a1_irqmap[] = {
+    [ASPEED_DEV_SDMC]      = 0,
+    [ASPEED_DEV_HACE]      = 4,
+    [ASPEED_DEV_XDMA]      = 5,
+    [ASPEED_DEV_UART4]     = 8,
+    [ASPEED_DEV_SCU]       = 12,
+    [ASPEED_DEV_RTC]       = 13,
+    [ASPEED_DEV_EMMC]      = 15,
+    [ASPEED_DEV_TIMER1]    = 16,
+    [ASPEED_DEV_TIMER2]    = 17,
+    [ASPEED_DEV_TIMER3]    = 18,
+    [ASPEED_DEV_TIMER4]    = 19,
+    [ASPEED_DEV_TIMER5]    = 20,
+    [ASPEED_DEV_TIMER6]    = 21,
+    [ASPEED_DEV_TIMER7]    = 22,
+    [ASPEED_DEV_TIMER8]    = 23,
+    [ASPEED_DEV_DP]        = 28,
+    [ASPEED_DEV_LPC]       = 192,
+    [ASPEED_DEV_IBT]       = 192,
+    [ASPEED_DEV_KCS]       = 192,
+    [ASPEED_DEV_I2C]       = 194,
+    [ASPEED_DEV_ADC]       = 194,
+    [ASPEED_DEV_GPIO]      = 194,
+    [ASPEED_DEV_FMC]       = 195,
+    [ASPEED_DEV_WDT]       = 195,
+    [ASPEED_DEV_PWM]       = 195,
+    [ASPEED_DEV_I3C]       = 195,
+    [ASPEED_DEV_UART0]     = 196,
+    [ASPEED_DEV_UART1]     = 196,
+    [ASPEED_DEV_UART2]     = 196,
+    [ASPEED_DEV_UART3]     = 196,
+    [ASPEED_DEV_UART5]     = 196,
+    [ASPEED_DEV_UART6]     = 196,
+    [ASPEED_DEV_UART7]     = 196,
+    [ASPEED_DEV_UART8]     = 196,
+    [ASPEED_DEV_UART9]     = 196,
+    [ASPEED_DEV_UART10]    = 196,
+    [ASPEED_DEV_UART11]    = 196,
+    [ASPEED_DEV_UART12]    = 196,
+    [ASPEED_DEV_ETH1]      = 196,
+    [ASPEED_DEV_ETH2]      = 196,
+    [ASPEED_DEV_ETH3]      = 196,
+    [ASPEED_DEV_PECI]      = 197,
+    [ASPEED_DEV_SDHCI]     = 197,
+};
+
 /* GICINT 128 */
 /* GICINT 192 */
 static const int ast2700_gic128_gic192_intcmap[] = {
@@ -864,6 +910,33 @@ static void aspeed_soc_ast2700a0_class_init(ObjectClass *oc, void *data)
     sc->get_irq      = aspeed_soc_ast2700_get_irq;
 }
 
+static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, void *data)
+{
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a35"),
+        NULL
+    };
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
+
+    /* Reason: The Aspeed SoC can only be instantiated from a board */
+    dc->user_creatable = false;
+    dc->realize      = aspeed_soc_ast2700_realize;
+
+    sc->valid_cpu_types = valid_cpu_types;
+    sc->silicon_rev  = AST2700_A1_SILICON_REV;
+    sc->sram_size    = 0x20000;
+    sc->spis_num     = 3;
+    sc->wdts_num     = 8;
+    sc->macs_num     = 3;
+    sc->uarts_num    = 13;
+    sc->num_cpus     = 4;
+    sc->uarts_base   = ASPEED_DEV_UART0;
+    sc->irqmap       = aspeed_soc_ast2700a1_irqmap;
+    sc->memmap       = aspeed_soc_ast2700_memmap;
+    sc->get_irq      = aspeed_soc_ast2700_get_irq;
+}
+
 static const TypeInfo aspeed_soc_ast27x0_types[] = {
     {
         .name           = TYPE_ASPEED27X0_SOC,
@@ -876,6 +949,12 @@ static const TypeInfo aspeed_soc_ast27x0_types[] = {
         .instance_init  = aspeed_soc_ast2700_init,
         .class_init     = aspeed_soc_ast2700a0_class_init,
     },
+    {
+        .name           = "ast2700-a1",
+        .parent         = TYPE_ASPEED27X0_SOC,
+        .instance_init  = aspeed_soc_ast2700_init,
+        .class_init     = aspeed_soc_ast2700a1_class_init,
+    },
 };
 
 DEFINE_TYPES(aspeed_soc_ast27x0_types)
-- 
2.48.1


