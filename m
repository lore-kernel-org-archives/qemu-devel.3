Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B42ECEACE9
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfw0-00086e-Pw; Tue, 01 Oct 2024 12:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfum-0005is-SQ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:59 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfug-0006B2-VU
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cb806623eso45073375e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800789; x=1728405589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A7o6ch0a5RszGTX9E3fyH7auH9LSgrWJbfp969FkUVQ=;
 b=WVUq6xiHSJfyvlWI6T2DVbs8en54rrdL4NOjM3OFpMZpLTOSTyhyduHmDiBukp1P/m
 MSsywsZkgcDvnoQiRjHEtgNkAntT66d2ajdcoxugpYn9LURx2orshcKeNRRPRMbSZ9if
 RfuTd9RLZH1m+E3Fb7INtdw8IPct2Wy6FEw8zVVjQKMBN6kNxFOiK1GcFyjdZCeOfJpb
 NWbbB9ifVrKuxe78q3f7Lk4xcCC0uhHTFACvThBACbBVOPz2ucadpFVsq2qDkyOA4ybj
 rqnl09vK1ryBDovDnKjQcH4S2pSFumVHZcreLLKZMu0R0HXEUDVti0uJJUeZvETWHxU4
 oEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800789; x=1728405589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A7o6ch0a5RszGTX9E3fyH7auH9LSgrWJbfp969FkUVQ=;
 b=qDU29/6I1K/UZsacHm9SXNBumzvpnDmjzYD00glaz2QtwqSnaz0d+plqia6USfBHTE
 oar2DN6Z6iGMUvszh5x1Rd755GEmD61eLWQTm79V0N3ZD8IaonbZ0hb687KFYocp77g4
 4C9uU9JtLHx/YR7O6mjntHid5h+sf74yIN/ukIfXOXwrkQrjb+0WBQezofms1a2oaLER
 AEhytykIk/KTJrUhna887MIaYY9TqS+d8cVpG4SZhMPm8Tc3u8sLEkJEbO/1yoniO7NU
 vK9RGLS2I3A+o6ubd1K9KNjcA+MV1Oxk4+ggIp5k5WRWsvBDNagAT3OB9G30SRVc1SOu
 i2Rw==
X-Gm-Message-State: AOJu0YzQvqDMzrPwd9EtJkr12h7a5uayWcS5nmsgSXMHxqoGy5hh9pCN
 pDa37NiitZZRPqdfF9wgJkm4qrtDq6NW9vNegw6eez5+stmJRy4ZUenpRPzQlgxu5WxHaW2baX5
 C
X-Google-Smtp-Source: AGHT+IHf3nzX4mjRQ+NFqLf4axuZXt47x0l8QnECzv0M/u5QgxegB8mzSBxyCLLb44tLmcD4sPU99g==
X-Received: by 2002:a05:600c:3b99:b0:42c:c401:6d67 with SMTP id
 5b1f17b1804b1-42f777b0b5dmr870215e9.6.1727800789357; 
 Tue, 01 Oct 2024 09:39:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/54] hw: Remove omap2 specific defines and enums
Date: Tue,  1 Oct 2024 17:39:18 +0100
Message-Id: <20241001163918.1275441-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove some defines and enums that are OMAP2 specific and
no longer used anywhere.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-54-peter.maydell@linaro.org
---
 include/hw/arm/omap.h | 207 ------------------------------------------
 1 file changed, 207 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 3f9860070b9..cf5f0219a2f 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -26,7 +26,6 @@
 #include "qom/object.h"
 
 # define OMAP_EMIFS_BASE	0x00000000
-# define OMAP2_Q0_BASE		0x00000000
 # define OMAP_CS0_BASE		0x00000000
 # define OMAP_CS1_BASE		0x04000000
 # define OMAP_CS2_BASE		0x08000000
@@ -34,20 +33,12 @@
 # define OMAP_EMIFF_BASE	0x10000000
 # define OMAP_IMIF_BASE		0x20000000
 # define OMAP_LOCALBUS_BASE	0x30000000
-# define OMAP2_Q1_BASE		0x40000000
-# define OMAP2_L4_BASE		0x48000000
-# define OMAP2_SRAM_BASE	0x40200000
-# define OMAP2_L3_BASE		0x68000000
-# define OMAP2_Q2_BASE		0x80000000
-# define OMAP2_Q3_BASE		0xc0000000
 # define OMAP_MPUI_BASE		0xe1000000
 
 # define OMAP730_SRAM_SIZE	0x00032000
 # define OMAP15XX_SRAM_SIZE	0x00030000
 # define OMAP16XX_SRAM_SIZE	0x00004000
 # define OMAP1611_SRAM_SIZE	0x0003e800
-# define OMAP242X_SRAM_SIZE	0x000a0000
-# define OMAP243X_SRAM_SIZE	0x00010000
 # define OMAP_CS0_SIZE		0x04000000
 # define OMAP_CS1_SIZE		0x04000000
 # define OMAP_CS2_SIZE		0x04000000
@@ -335,87 +326,6 @@ void omap_gpio_set_clk(Omap1GpioState *gpio, omap_clk clk);
 # define OMAP_INT_730_DMA_CH15		62
 # define OMAP_INT_730_NAND		63
 
-/*
- * OMAP-24xx common IRQ numbers
- */
-# define OMAP_INT_24XX_STI		4
-# define OMAP_INT_24XX_SYS_NIRQ		7
-# define OMAP_INT_24XX_L3_IRQ		10
-# define OMAP_INT_24XX_PRCM_MPU_IRQ	11
-# define OMAP_INT_24XX_SDMA_IRQ0	12
-# define OMAP_INT_24XX_SDMA_IRQ1	13
-# define OMAP_INT_24XX_SDMA_IRQ2	14
-# define OMAP_INT_24XX_SDMA_IRQ3	15
-# define OMAP_INT_243X_MCBSP2_IRQ	16
-# define OMAP_INT_243X_MCBSP3_IRQ	17
-# define OMAP_INT_243X_MCBSP4_IRQ	18
-# define OMAP_INT_243X_MCBSP5_IRQ	19
-# define OMAP_INT_24XX_GPMC_IRQ		20
-# define OMAP_INT_24XX_GUFFAW_IRQ	21
-# define OMAP_INT_24XX_IVA_IRQ		22
-# define OMAP_INT_24XX_EAC_IRQ		23
-# define OMAP_INT_24XX_CAM_IRQ		24
-# define OMAP_INT_24XX_DSS_IRQ		25
-# define OMAP_INT_24XX_MAIL_U0_MPU	26
-# define OMAP_INT_24XX_DSP_UMA		27
-# define OMAP_INT_24XX_DSP_MMU		28
-# define OMAP_INT_24XX_GPIO_BANK1	29
-# define OMAP_INT_24XX_GPIO_BANK2	30
-# define OMAP_INT_24XX_GPIO_BANK3	31
-# define OMAP_INT_24XX_GPIO_BANK4	32
-# define OMAP_INT_243X_GPIO_BANK5	33
-# define OMAP_INT_24XX_MAIL_U3_MPU	34
-# define OMAP_INT_24XX_WDT3		35
-# define OMAP_INT_24XX_WDT4		36
-# define OMAP_INT_24XX_GPTIMER1		37
-# define OMAP_INT_24XX_GPTIMER2		38
-# define OMAP_INT_24XX_GPTIMER3		39
-# define OMAP_INT_24XX_GPTIMER4		40
-# define OMAP_INT_24XX_GPTIMER5		41
-# define OMAP_INT_24XX_GPTIMER6		42
-# define OMAP_INT_24XX_GPTIMER7		43
-# define OMAP_INT_24XX_GPTIMER8		44
-# define OMAP_INT_24XX_GPTIMER9		45
-# define OMAP_INT_24XX_GPTIMER10	46
-# define OMAP_INT_24XX_GPTIMER11	47
-# define OMAP_INT_24XX_GPTIMER12	48
-# define OMAP_INT_24XX_PKA_IRQ		50
-# define OMAP_INT_24XX_SHA1MD5_IRQ	51
-# define OMAP_INT_24XX_RNG_IRQ		52
-# define OMAP_INT_24XX_MG_IRQ		53
-# define OMAP_INT_24XX_I2C1_IRQ		56
-# define OMAP_INT_24XX_I2C2_IRQ		57
-# define OMAP_INT_24XX_MCBSP1_IRQ_TX	59
-# define OMAP_INT_24XX_MCBSP1_IRQ_RX	60
-# define OMAP_INT_24XX_MCBSP2_IRQ_TX	62
-# define OMAP_INT_24XX_MCBSP2_IRQ_RX	63
-# define OMAP_INT_243X_MCBSP1_IRQ	64
-# define OMAP_INT_24XX_MCSPI1_IRQ	65
-# define OMAP_INT_24XX_MCSPI2_IRQ	66
-# define OMAP_INT_24XX_SSI1_IRQ0	67
-# define OMAP_INT_24XX_SSI1_IRQ1	68
-# define OMAP_INT_24XX_SSI2_IRQ0	69
-# define OMAP_INT_24XX_SSI2_IRQ1	70
-# define OMAP_INT_24XX_SSI_GDD_IRQ	71
-# define OMAP_INT_24XX_UART1_IRQ	72
-# define OMAP_INT_24XX_UART2_IRQ	73
-# define OMAP_INT_24XX_UART3_IRQ	74
-# define OMAP_INT_24XX_USB_IRQ_GEN	75
-# define OMAP_INT_24XX_USB_IRQ_NISO	76
-# define OMAP_INT_24XX_USB_IRQ_ISO	77
-# define OMAP_INT_24XX_USB_IRQ_HGEN	78
-# define OMAP_INT_24XX_USB_IRQ_HSOF	79
-# define OMAP_INT_24XX_USB_IRQ_OTG	80
-# define OMAP_INT_24XX_VLYNQ_IRQ	81
-# define OMAP_INT_24XX_MMC_IRQ		83
-# define OMAP_INT_24XX_MS_IRQ		84
-# define OMAP_INT_24XX_FAC_IRQ		85
-# define OMAP_INT_24XX_MCSPI3_IRQ	91
-# define OMAP_INT_243X_HS_USB_MC	92
-# define OMAP_INT_243X_HS_USB_DMA	93
-# define OMAP_INT_243X_CARKIT		94
-# define OMAP_INT_34XX_GPTIMER12	95
-
 /* omap_dma.c */
 enum omap_dma_model {
     omap_dma_3_0,
@@ -568,74 +478,6 @@ struct omap_dma_lcd_channel_s {
 # define OMAP_DMA_MMC2_RX		55
 # define OMAP_DMA_CRYPTO_DES_OUT	56
 
-/*
- * DMA request numbers for the OMAP2
- */
-# define OMAP24XX_DMA_NO_DEVICE		0
-# define OMAP24XX_DMA_XTI_DMA		1	/* Not in OMAP2420 */
-# define OMAP24XX_DMA_EXT_DMAREQ0	2
-# define OMAP24XX_DMA_EXT_DMAREQ1	3
-# define OMAP24XX_DMA_GPMC		4
-# define OMAP24XX_DMA_GFX		5	/* Not in OMAP2420 */
-# define OMAP24XX_DMA_DSS		6
-# define OMAP24XX_DMA_VLYNQ_TX		7	/* Not in OMAP2420 */
-# define OMAP24XX_DMA_CWT		8	/* Not in OMAP2420 */
-# define OMAP24XX_DMA_AES_TX		9	/* Not in OMAP2420 */
-# define OMAP24XX_DMA_AES_RX		10	/* Not in OMAP2420 */
-# define OMAP24XX_DMA_DES_TX		11	/* Not in OMAP2420 */
-# define OMAP24XX_DMA_DES_RX		12	/* Not in OMAP2420 */
-# define OMAP24XX_DMA_SHA1MD5_RX	13	/* Not in OMAP2420 */
-# define OMAP24XX_DMA_EXT_DMAREQ2	14
-# define OMAP24XX_DMA_EXT_DMAREQ3	15
-# define OMAP24XX_DMA_EXT_DMAREQ4	16
-# define OMAP24XX_DMA_EAC_AC_RD		17
-# define OMAP24XX_DMA_EAC_AC_WR		18
-# define OMAP24XX_DMA_EAC_MD_UL_RD	19
-# define OMAP24XX_DMA_EAC_MD_UL_WR	20
-# define OMAP24XX_DMA_EAC_MD_DL_RD	21
-# define OMAP24XX_DMA_EAC_MD_DL_WR	22
-# define OMAP24XX_DMA_EAC_BT_UL_RD	23
-# define OMAP24XX_DMA_EAC_BT_UL_WR	24
-# define OMAP24XX_DMA_EAC_BT_DL_RD	25
-# define OMAP24XX_DMA_EAC_BT_DL_WR	26
-# define OMAP24XX_DMA_I2C1_TX		27
-# define OMAP24XX_DMA_I2C1_RX		28
-# define OMAP24XX_DMA_I2C2_TX		29
-# define OMAP24XX_DMA_I2C2_RX		30
-# define OMAP24XX_DMA_MCBSP1_TX		31
-# define OMAP24XX_DMA_MCBSP1_RX		32
-# define OMAP24XX_DMA_MCBSP2_TX		33
-# define OMAP24XX_DMA_MCBSP2_RX		34
-# define OMAP24XX_DMA_SPI1_TX0		35
-# define OMAP24XX_DMA_SPI1_RX0		36
-# define OMAP24XX_DMA_SPI1_TX1		37
-# define OMAP24XX_DMA_SPI1_RX1		38
-# define OMAP24XX_DMA_SPI1_TX2		39
-# define OMAP24XX_DMA_SPI1_RX2		40
-# define OMAP24XX_DMA_SPI1_TX3		41
-# define OMAP24XX_DMA_SPI1_RX3		42
-# define OMAP24XX_DMA_SPI2_TX0		43
-# define OMAP24XX_DMA_SPI2_RX0		44
-# define OMAP24XX_DMA_SPI2_TX1		45
-# define OMAP24XX_DMA_SPI2_RX1		46
-
-# define OMAP24XX_DMA_UART1_TX		49
-# define OMAP24XX_DMA_UART1_RX		50
-# define OMAP24XX_DMA_UART2_TX		51
-# define OMAP24XX_DMA_UART2_RX		52
-# define OMAP24XX_DMA_UART3_TX		53
-# define OMAP24XX_DMA_UART3_RX		54
-# define OMAP24XX_DMA_USB_W2FC_TX0	55
-# define OMAP24XX_DMA_USB_W2FC_RX0	56
-# define OMAP24XX_DMA_USB_W2FC_TX1	57
-# define OMAP24XX_DMA_USB_W2FC_RX1	58
-# define OMAP24XX_DMA_USB_W2FC_TX2	59
-# define OMAP24XX_DMA_USB_W2FC_RX2	60
-# define OMAP24XX_DMA_MMC1_TX		61
-# define OMAP24XX_DMA_MMC1_RX		62
-# define OMAP24XX_DMA_MS		63	/* Not in OMAP2420 */
-# define OMAP24XX_DMA_EXT_DMAREQ5	64
-
 struct omap_uart_s;
 struct omap_uart_s *omap_uart_init(hwaddr base,
                 qemu_irq irq, omap_clk fclk, omap_clk iclk,
@@ -709,24 +551,11 @@ I2CBus *omap_i2c_bus(DeviceState *omap_i2c);
 # define cpu_is_omap1510(cpu)		(cpu->mpu_model == omap1510)
 # define cpu_is_omap1610(cpu)		(cpu->mpu_model == omap1610)
 # define cpu_is_omap1710(cpu)		(cpu->mpu_model == omap1710)
-# define cpu_is_omap2410(cpu)		(cpu->mpu_model == omap2410)
-# define cpu_is_omap2420(cpu)		(cpu->mpu_model == omap2420)
-# define cpu_is_omap2430(cpu)		(cpu->mpu_model == omap2430)
-# define cpu_is_omap3430(cpu)		(cpu->mpu_model == omap3430)
-# define cpu_is_omap3630(cpu)           (cpu->mpu_model == omap3630)
 
 # define cpu_is_omap15xx(cpu)		\
         (cpu_is_omap310(cpu) || cpu_is_omap1510(cpu))
 # define cpu_is_omap16xx(cpu)		\
         (cpu_is_omap1610(cpu) || cpu_is_omap1710(cpu))
-# define cpu_is_omap24xx(cpu)		\
-        (cpu_is_omap2410(cpu) || cpu_is_omap2420(cpu) || cpu_is_omap2430(cpu))
-
-# define cpu_class_omap1(cpu)		\
-        (cpu_is_omap15xx(cpu) || cpu_is_omap16xx(cpu))
-# define cpu_class_omap2(cpu)		cpu_is_omap24xx(cpu)
-# define cpu_class_omap3(cpu) \
-        (cpu_is_omap3430(cpu) || cpu_is_omap3630(cpu))
 
 struct omap_mpu_state_s {
     enum omap_mpu_model {
@@ -734,13 +563,6 @@ struct omap_mpu_state_s {
         omap1510,
         omap1610,
         omap1710,
-        omap2410,
-        omap2420,
-        omap2422,
-        omap2423,
-        omap2430,
-        omap3430,
-        omap3630,
     } mpu_model;
 
     ARMCPU *cpu;
@@ -876,35 +698,6 @@ void omap_mpu_wakeup(void *opaque, int irq, int req);
                                        HWADDR_PRIx "\n", \
                       __func__, paddr)
 
-/* OMAP-specific Linux bootloader tags for the ATAG_BOARD area
- * (Board-specific tags are not here)
- */
-#define OMAP_TAG_CLOCK		0x4f01
-#define OMAP_TAG_MMC		0x4f02
-#define OMAP_TAG_SERIAL_CONSOLE	0x4f03
-#define OMAP_TAG_USB		0x4f04
-#define OMAP_TAG_LCD		0x4f05
-#define OMAP_TAG_GPIO_SWITCH	0x4f06
-#define OMAP_TAG_UART		0x4f07
-#define OMAP_TAG_FBMEM		0x4f08
-#define OMAP_TAG_STI_CONSOLE	0x4f09
-#define OMAP_TAG_CAMERA_SENSOR	0x4f0a
-#define OMAP_TAG_PARTITION	0x4f0b
-#define OMAP_TAG_TEA5761	0x4f10
-#define OMAP_TAG_TMP105		0x4f11
-#define OMAP_TAG_BOOT_REASON	0x4f80
-#define OMAP_TAG_FLASH_PART_STR	0x4f81
-#define OMAP_TAG_VERSION_STR	0x4f82
-
-enum {
-    OMAP_GPIOSW_TYPE_COVER	= 0 << 4,
-    OMAP_GPIOSW_TYPE_CONNECTION	= 1 << 4,
-    OMAP_GPIOSW_TYPE_ACTIVITY	= 2 << 4,
-};
-
-#define OMAP_GPIOSW_INVERTED	0x0001
-#define OMAP_GPIOSW_OUTPUT	0x0002
-
 # define OMAP_MPUI_REG_MASK		0x000007ff
 
 #endif
-- 
2.34.1


