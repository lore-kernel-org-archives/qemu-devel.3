Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671BD606A320
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kjn3dyOc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN33H-0002dE-7H; Sat, 31 Oct 2026 02:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33G-0002cb-Cp
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33D-0002k3-TW
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMBA93sxNAD9cUUyKM5JcU12jFFj27Ymjpc4Mk7i7KA=;
 b=Kjn3dyOcvKhk0qzGQNSK9V09RMMwl2mC0Yh4n5W1tdKfacgFL2whxwCOP2AGn+7fd3Tn/F
 xL8NZqsO5pB5VPbmTwOtzxrVGGSx0VtaPCt6wUJOQR+NGKyOVq43xjmxObj1gNfPfG7GIR
 N4S69sSvjK1t8gDFsrkJhMNb17e65aE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-KkzqeDvgOBWPIYGectaSJw-1; Sat,
 31 Oct 2026 02:58:47 -0400
X-MC-Unique: KkzqeDvgOBWPIYGectaSJw-1
X-Mimecast-MFC-AGG-ID: KkzqeDvgOBWPIYGectaSJw_1793429926
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FBE61956072; Sat, 31 Oct 2026 06:58:46 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E4AC1800677; Sat, 31 Oct 2026 06:58:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/34] hw/ssi/aspeed_smc: Add AST1040 FMC and SPI controllers
Date: Sat, 31 Oct 2026 07:57:54 +0100
Message-ID: <20261031065823.191966-6-clg@redhat.com>
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
References: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jamin Lin <jamin_lin@aspeedtech.com>

The AST1040 FMC and SPI controllers are compatible with the AST2700
controllers, but use different flash window. Therefore, the AST2700
controller types cannot be reused directly for AST1040.

Add dedicated AST1040 FMC, SPI0 and SPI1 controller types with the
appropriate parameter settings.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261028023154.48395-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/ssi/aspeed_smc.c | 119 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index c0c3666dbca3..ec9ad0f747e1 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -2072,6 +2072,110 @@ static void aspeed_2700_spi2_class_init(ObjectClass *klass, const void *data)
     asc->reg_ops           = &aspeed_2700_smc_flash_ops;
 }
 
+static const uint32_t aspeed_1040_resets[ASPEED_SMC_R_MAX] = {
+    [R_CONF] = (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0 |
+                CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1 |
+                CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE2 |
+                CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE3),
+};
+
+static void aspeed_1040_fmc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
+
+    dc->desc               = "Aspeed 1040 FMC Controller";
+    asc->r_conf            = R_CONF;
+    asc->r_ce_ctrl         = R_CE_CTRL;
+    asc->r_ctrl0           = R_CTRL0;
+    asc->r_timings         = R_TIMINGS;
+    asc->nregs_timings     = 2;
+    asc->conf_enable_w0    = CONF_ENABLE_W0;
+    asc->cs_num_max        = 2;
+    asc->segments          = aspeed_2700_spi0_segments;
+    asc->segment_addr_mask = 0xffffffff;
+    asc->resets            = aspeed_1040_resets;
+    asc->flash_window_base = 0x80000000;
+    asc->flash_window_size = 512 * MiB;
+    asc->features          = ASPEED_SMC_FEATURE_DMA |
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
+    asc->dma_flash_mask    = 0x1FFFFFFC;
+    asc->dma_dram_mask     = 0x00FFFFFC;
+    asc->dma_start_length  = 1;
+    asc->nregs             = ASPEED_SMC_R_MAX;
+    asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
+    asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
+    asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_2700_smc_flash_ops;
+}
+
+static const AspeedSegments aspeed_1040_spi0_segments[] = {
+    { 0x0, 128 * MiB },
+    { 128 * MiB, 128 * MiB },
+    { 256 * MiB, 128 * MiB },
+    { 384 * MiB, 128 * MiB },
+};
+
+static void aspeed_1040_spi0_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
+
+    dc->desc               = "Aspeed 1040 SPI0 Controller";
+    asc->r_conf            = R_CONF;
+    asc->r_ce_ctrl         = R_CE_CTRL;
+    asc->r_ctrl0           = R_CTRL0;
+    asc->r_timings         = R_TIMINGS;
+    asc->nregs_timings     = 4;
+    asc->conf_enable_w0    = CONF_ENABLE_W0;
+    asc->cs_num_max        = 4;
+    asc->segments          = aspeed_1040_spi0_segments;
+    asc->segment_addr_mask = 0xffffffff;
+    asc->resets            = aspeed_1040_resets;
+    asc->flash_window_base = 0xA0000000;
+    asc->flash_window_size = 512 * MiB;
+    asc->features          = ASPEED_SMC_FEATURE_DMA |
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
+    asc->dma_flash_mask    = 0x1FFFFFFC;
+    asc->dma_dram_mask     = 0x00FFFFFC;
+    asc->dma_start_length  = 1;
+    asc->nregs             = ASPEED_SMC_R_MAX;
+    asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
+    asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
+    asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_2700_smc_flash_ops;
+}
+
+static void aspeed_1040_spi1_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
+
+    dc->desc               = "Aspeed 1040 SPI1 Controller";
+    asc->r_conf            = R_CONF;
+    asc->r_ce_ctrl         = R_CE_CTRL;
+    asc->r_ctrl0           = R_CTRL0;
+    asc->r_timings         = R_TIMINGS;
+    asc->nregs_timings     = 2;
+    asc->conf_enable_w0    = CONF_ENABLE_W0;
+    asc->cs_num_max        = 2;
+    asc->segments          = aspeed_2700_spi0_segments;
+    asc->segment_addr_mask = 0xffffffff;
+    asc->resets            = aspeed_1040_resets;
+    asc->flash_window_base = 0xC0000000;
+    asc->flash_window_size = 512 * MiB;
+    asc->features          = ASPEED_SMC_FEATURE_DMA |
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
+    asc->dma_flash_mask    = 0x1FFFFFFC;
+    asc->dma_dram_mask     = 0x00FFFFFC;
+    asc->dma_start_length  = 1;
+    asc->nregs             = ASPEED_SMC_R_MAX;
+    asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
+    asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
+    asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_2700_smc_flash_ops;
+}
+
 static const TypeInfo aspeed_smc_types[] = {
     {
         .name           = TYPE_ASPEED_SMC_FLASH,
@@ -2103,6 +2207,21 @@ static const TypeInfo aspeed_smc_types[] = {
         .parent     = TYPE_ASPEED_SMC,
         .class_init = aspeed_1030_spi2_class_init,
     },
+    {
+        .name       = "aspeed.fmc-ast1040",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_1040_fmc_class_init,
+    },
+    {
+        .name       = "aspeed.spi0-ast1040",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_1040_spi0_class_init,
+    },
+    {
+        .name       = "aspeed.spi1-ast1040",
+        .parent     = TYPE_ASPEED_SMC,
+        .class_init = aspeed_1040_spi1_class_init,
+    },
     {
         .name       = "aspeed.smc-ast2400",
         .parent     = TYPE_ASPEED_SMC,
-- 
2.56.0


