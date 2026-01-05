Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04D5C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vckA1-0004xa-5M; Mon, 05 Jan 2026 07:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck9L-0004cM-Gh
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck9J-00087h-1U
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nyCI6Sy88qGcEs2t2mZ8Esp7vOW+H+nEdg2NcqpXI4=;
 b=XYAuGFQ0BQ0/Z+O7q1/bVWdIRXY5rbP+Sfu+WywjGUPEwV8oqvhAGht2k0rhRJyt+G6A7b
 R2yFumTVv12o/0y8B9ODkSi5f2W+ep7CtFqcwUPgOTz2O/Y2n+IOTQ7H4EtSX+VC4ajCDA
 7KtCeWpUk3KHIsw4AcY4M+48fSmpmF4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-NhSc7oMpMCuU-THUww-wgw-1; Mon,
 05 Jan 2026 07:57:22 -0500
X-MC-Unique: NhSc7oMpMCuU-THUww-wgw-1
X-Mimecast-MFC-AGG-ID: NhSc7oMpMCuU-THUww-wgw_1767617841
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC21C1800654; Mon,  5 Jan 2026 12:57:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39F3819560A7; Mon,  5 Jan 2026 12:57:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 31/36] hw/arm/aspeed_ast27x0: Remove ast2700-a0 SOC
Date: Mon,  5 Jan 2026 13:56:08 +0100
Message-ID: <20260105125613.622667-32-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

The ast2700-a1 SOC represented the first revision of the AST2700 and
was intended as an early engineering sample rather than a production
platform. A newer revision, A1, is now supported, and the ast2700-a1
SOC should replace the older A0 version.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250901040808.1454742-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0.c | 84 -----------------------------------------
 1 file changed, 84 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 70be3871bb12..6d6ffe31272c 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -100,56 +100,6 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
 #define AST2700_MAX_IRQ 256
 
 /* Shared Peripheral Interrupt values below are offset by -32 from datasheet */
-static const int aspeed_soc_ast2700a0_irqmap[] = {
-    [ASPEED_DEV_SDMC]      = 0,
-    [ASPEED_DEV_HACE]      = 4,
-    [ASPEED_DEV_XDMA]      = 5,
-    [ASPEED_DEV_UART4]     = 8,
-    [ASPEED_DEV_SCU]       = 12,
-    [ASPEED_DEV_RTC]       = 13,
-    [ASPEED_DEV_EMMC]      = 15,
-    [ASPEED_DEV_TIMER1]    = 16,
-    [ASPEED_DEV_TIMER2]    = 17,
-    [ASPEED_DEV_TIMER3]    = 18,
-    [ASPEED_DEV_TIMER4]    = 19,
-    [ASPEED_DEV_TIMER5]    = 20,
-    [ASPEED_DEV_TIMER6]    = 21,
-    [ASPEED_DEV_TIMER7]    = 22,
-    [ASPEED_DEV_TIMER8]    = 23,
-    [ASPEED_DEV_DP]        = 28,
-    [ASPEED_DEV_EHCI1]     = 33,
-    [ASPEED_DEV_EHCI2]     = 37,
-    [ASPEED_DEV_LPC]       = 128,
-    [ASPEED_DEV_IBT]       = 128,
-    [ASPEED_DEV_KCS]       = 128,
-    [ASPEED_DEV_ADC]       = 130,
-    [ASPEED_DEV_GPIO]      = 130,
-    [ASPEED_DEV_SGPIOM0]   = 130,
-    [ASPEED_DEV_SGPIOM1]   = 130,
-    [ASPEED_DEV_I2C]       = 130,
-    [ASPEED_DEV_FMC]       = 131,
-    [ASPEED_DEV_WDT]       = 131,
-    [ASPEED_DEV_PWM]       = 131,
-    [ASPEED_DEV_I3C]       = 131,
-    [ASPEED_DEV_UART0]     = 132,
-    [ASPEED_DEV_UART1]     = 132,
-    [ASPEED_DEV_UART2]     = 132,
-    [ASPEED_DEV_UART3]     = 132,
-    [ASPEED_DEV_UART5]     = 132,
-    [ASPEED_DEV_UART6]     = 132,
-    [ASPEED_DEV_UART7]     = 132,
-    [ASPEED_DEV_UART8]     = 132,
-    [ASPEED_DEV_UART9]     = 132,
-    [ASPEED_DEV_UART10]    = 132,
-    [ASPEED_DEV_UART11]    = 132,
-    [ASPEED_DEV_UART12]    = 132,
-    [ASPEED_DEV_ETH1]      = 132,
-    [ASPEED_DEV_ETH2]      = 132,
-    [ASPEED_DEV_ETH3]      = 132,
-    [ASPEED_DEV_PECI]      = 133,
-    [ASPEED_DEV_SDHCI]     = 133,
-};
-
 static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_SDMC]      = 0,
     [ASPEED_DEV_HACE]      = 4,
@@ -1069,35 +1019,6 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                                   AST2700_SOC_IOMEM_SIZE);
 }
 
-static void aspeed_soc_ast2700a0_class_init(ObjectClass *oc, const void *data)
-{
-    static const char * const valid_cpu_types[] = {
-        ARM_CPU_TYPE_NAME("cortex-a35"),
-        NULL
-    };
-    DeviceClass *dc = DEVICE_CLASS(oc);
-    AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
-
-    /* Reason: The Aspeed SoC can only be instantiated from a board */
-    dc->user_creatable = false;
-    dc->realize      = aspeed_soc_ast2700_realize;
-
-    sc->valid_cpu_types = valid_cpu_types;
-    sc->silicon_rev  = AST2700_A0_SILICON_REV;
-    sc->sram_size    = 0x20000;
-    sc->pcie_num     = 0;
-    sc->spis_num     = 3;
-    sc->sgpio_num    = 2;
-    sc->ehcis_num    = 2;
-    sc->wdts_num     = 8;
-    sc->macs_num     = 1;
-    sc->uarts_num    = 13;
-    sc->num_cpus     = 4;
-    sc->uarts_base   = ASPEED_DEV_UART0;
-    sc->irqmap       = aspeed_soc_ast2700a0_irqmap;
-    sc->memmap       = aspeed_soc_ast2700_memmap;
-}
-
 static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
@@ -1133,11 +1054,6 @@ static const TypeInfo aspeed_soc_ast27x0_types[] = {
         .parent         = TYPE_ASPEED_SOC,
         .instance_size  = sizeof(Aspeed27x0SoCState),
         .abstract       = true,
-    }, {
-        .name           = "ast2700-a0",
-        .parent         = TYPE_ASPEED27X0_SOC,
-        .instance_init  = aspeed_soc_ast2700_init,
-        .class_init     = aspeed_soc_ast2700a0_class_init,
     },
     {
         .name           = "ast2700-a1",
-- 
2.52.0


