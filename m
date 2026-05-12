Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7231CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMtoW-0002Xh-CH; Tue, 12 May 2026 16:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMtoF-0002Nv-JS
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMtoA-0002P6-QA
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so37565275e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778618063; x=1779222863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9aaDQ12UBCrB15ahgAwdguXL2xkiRYB5Sw8BTXsTekM=;
 b=DiQnqx4QhK0I2/heXoQfhEAlGPmg+XVGm/thpMiEQ5u6iBQ0nkhXmTpBpicKMcHfaQ
 dLA6EmUBF122OWkgti8XLhqxu9yYpWmJA3ayrPcKu5EkYRb8kPrPUuka/+7yOla4wO2+
 wcKYFCaB+jBcCFZ/H/vRknRO4FHblKQ+GDD8UwMycQl+EQHKnqQhFeQct8jD+WJCQRZo
 6TBI4Jukt7uAHLGPVqXFrbHhfy6HvokowPyTU3aIy07ozXf5cQcB8fA8i+nL0vQ5dETw
 az2u6FPDG/4oIj0vuYWWb4NvnDDw3MbANzDf+XmCGlx8VKXsOGu+brZ6sHSqGwmTTBX7
 3ZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778618063; x=1779222863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9aaDQ12UBCrB15ahgAwdguXL2xkiRYB5Sw8BTXsTekM=;
 b=byjOgwcGqGpOsmBj67gvBotZU0XPK0kQdDQEJRfiFjAgtmBO8AYj0qfkW2IgXOko7a
 TxO/hTNzfbVydjWbeZUh4yWiKBAAbS7aoJ6UGLdIsKDk4Q02YDzAEJwzbddAbdvKDmFT
 HaraWPXY+vm6BWSt6JykFtYVIWll+SeBdPrJqC0SfUAaCtHOZETlMFC4yrvLb2XeTyQ6
 G8NN0d0+fvck3LrgCR+W8dcxGQlR4IC0BKRYSCaGDVH4XcLiS7x7lh9zgi8yOyE2HX4w
 6LVy5GtNw/Ccz2hNCB4PrAav+69tA6plW2jcJWWJcP6kd7zM0KgcMAeJ3BfvTwbBpB2C
 3B2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qMg0EG95Bu7s4+o0LsVkx0IKh4d1+hNOHbHZ0R89xeXtZwkHV027TBHQoBAQuA6omoV2NfjtTLN15@nongnu.org
X-Gm-Message-State: AOJu0YzlEZ8mu/uXmezUaVGjk7NlygwcgZA486XnP0gj7HKkc0vKyjZN
 so86akqdkwxf2Le/80mqhXsjcUNVRnG3bZPWZzUPNZulsenYPxnSSvnKgg1EI5Owqng=
X-Gm-Gg: Acq92OHBY7TQq+ZjFrMAxxX3Ed85WrpJqzC9uAPZUSAweYGH/ahPETpWCBYGcyzVh+r
 GpRfDu1QKcS+voh2uD6n1DGmk1dRoTUUr4UVK7bDHeT3h/YhWgg/9L65Xb9RduE0LqoVAJeR9QO
 Pm0jS/+bkz1Hh7qjp3ukYWJ2VsNNIKyJQ3q4kPT0VYM+r1CPUNSLc2MdPKHHWUmRMBbUXfJsWns
 cuMBWU40QMqtuoOqHvrpIdUMyB+PBp2kC0SEmIGZ9ZByldvL1pLGXy6aBUNf9k4DI06TBjZqEtz
 CkZWW1KP+UXnjjppq68POYAW7X6fmpznukb7AADSrFFEEmJmsDNcmp16sWMl5sa8U2u9aYVkWC5
 FF+g13mJBxFdMXFO+Lqad4UXZWZdYV/b7yd/rLdahAAtmmVxPnXAPHvsdu14UdnyBEhAxnxYkRk
 tvZFj6/LETKba5uygERX3MZLo8lqwGKxKyvlJZz4jkqM5WjD09n6tcwiCbt0CAcABii6wBwgaF0
 ++TYRmE1E7YztOO1GBMuyfpwaXT4QA=
X-Received: by 2002:a05:600c:3107:b0:48e:635a:18d2 with SMTP id
 5b1f17b1804b1-48fc9a08e2dmr4891255e9.2.1778618062648; 
 Tue, 12 May 2026 13:34:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d69d0bsm16350635e9.13.2026.05.12.13.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 13:34:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/12] hw/arm/omap: Delete unused #defines
Date: Tue, 12 May 2026 21:34:07 +0100
Message-ID: <20260512203414.3633237-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512203414.3633237-1-peter.maydell@linaro.org>
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Delete some #defines which we no longer use because they are
for OMAP SoCs which we dropped support for.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h | 185 ------------------------------------------
 1 file changed, 185 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 96a52d280c..14d6e9d214 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -35,10 +35,7 @@
 #define OMAP_LOCALBUS_BASE 0x30000000
 #define OMAP_MPUI_BASE     0xe1000000
 
-#define OMAP730_SRAM_SIZE  0x00032000
 #define OMAP15XX_SRAM_SIZE 0x00030000
-#define OMAP16XX_SRAM_SIZE 0x00004000
-#define OMAP1611_SRAM_SIZE 0x0003e800
 #define OMAP_CS0_SIZE      0x04000000
 #define OMAP_CS1_SIZE      0x04000000
 #define OMAP_CS2_SIZE      0x04000000
@@ -130,16 +127,6 @@ void omap_gpio_set_clk(Omap1GpioState *gpio, omap_clk clk);
  * Common OMAP-15xx IRQ numbers for level 1 interrupt handler
  */
 #define OMAP_INT_15XX_IH2_IRQ      0
-#define OMAP_INT_15XX_LB_MMU       17
-#define OMAP_INT_15XX_LOCAL_BUS    29
-
-/*
- * OMAP-1510 specific IRQ numbers for level 1 interrupt handler
- */
-#define OMAP_INT_1510_SPI_TX       4
-#define OMAP_INT_1510_SPI_RX       5
-#define OMAP_INT_1510_DSP_MAILBOX1 10
-#define OMAP_INT_1510_DSP_MAILBOX2 11
 
 /*
  * OMAP-310 specific IRQ numbers for level 1 interrupt handler
@@ -149,42 +136,6 @@ void omap_gpio_set_clk(Omap1GpioState *gpio, omap_clk clk);
 #define OMAP_INT_310_HSB_MAILBOX1  12
 #define OMAP_INT_310_HSAB_MMU      18
 
-/*
- * OMAP-1610 specific IRQ numbers for level 1 interrupt handler
- */
-#define OMAP_INT_1610_IH2_IRQ      0
-#define OMAP_INT_1610_IH2_FIQ      2
-#define OMAP_INT_1610_McBSP2_TX    4
-#define OMAP_INT_1610_McBSP2_RX    5
-#define OMAP_INT_1610_DSP_MAILBOX1 10
-#define OMAP_INT_1610_DSP_MAILBOX2 11
-#define OMAP_INT_1610_LCD_LINE     12
-#define OMAP_INT_1610_GPTIMER1     17
-#define OMAP_INT_1610_GPTIMER2     18
-#define OMAP_INT_1610_SSR_FIFO_0   29
-
-/*
- * OMAP-730 specific IRQ numbers for level 1 interrupt handler
- */
-#define OMAP_INT_730_IH2_FIQ       0
-#define OMAP_INT_730_IH2_IRQ       1
-#define OMAP_INT_730_USB_NON_ISO   2
-#define OMAP_INT_730_USB_ISO       3
-#define OMAP_INT_730_ICR           4
-#define OMAP_INT_730_EAC           5
-#define OMAP_INT_730_GPIO_BANK1    6
-#define OMAP_INT_730_GPIO_BANK2    7
-#define OMAP_INT_730_GPIO_BANK3    8
-#define OMAP_INT_730_McBSP2TX      10
-#define OMAP_INT_730_McBSP2RX      11
-#define OMAP_INT_730_McBSP2RX_OVF  12
-#define OMAP_INT_730_LCD_LINE      14
-#define OMAP_INT_730_GSM_PROTECT   15
-#define OMAP_INT_730_TIMER3        16
-#define OMAP_INT_730_GPIO_BANK5    17
-#define OMAP_INT_730_GPIO_BANK6    18
-#define OMAP_INT_730_SPGIO_WR      29
-
 /*
  * Common IRQ numbers for level 2 interrupt handler
  */
@@ -209,15 +160,6 @@ void omap_gpio_set_clk(Omap1GpioState *gpio, omap_clk clk);
 #define OMAP_INT_RTC_ALARM     26
 #define OMAP_INT_DSP_MMU       28
 
-/*
- * OMAP-1510 specific IRQ numbers for level 2 interrupt handler
- */
-#define OMAP_INT_1510_BT_MCSI1TX   16
-#define OMAP_INT_1510_BT_MCSI1RX   17
-#define OMAP_INT_1510_SoSSI_MATCH  19
-#define OMAP_INT_1510_MEM_STICK    27
-#define OMAP_INT_1510_COM_SPI_RO   31
-
 /*
  * OMAP-310 specific IRQ numbers for level 2 interrupt handler
  */
@@ -229,103 +171,6 @@ void omap_gpio_set_clk(Omap1GpioState *gpio, omap_clk clk);
 #define OMAP_INT_310_USB_W2FC_NON_ISO  30
 #define OMAP_INT_310_McBSP2RX_OF       31
 
-/*
- * OMAP-1610 specific IRQ numbers for level 2 interrupt handler
- */
-#define OMAP_INT_1610_FAC          0
-#define OMAP_INT_1610_USB_HHC_2    7
-#define OMAP_INT_1610_USB_OTG      8
-#define OMAP_INT_1610_SoSSI        9
-#define OMAP_INT_1610_BT_MCSI1TX   16
-#define OMAP_INT_1610_BT_MCSI1RX   17
-#define OMAP_INT_1610_SoSSI_MATCH  19
-#define OMAP_INT_1610_MEM_STICK    27
-#define OMAP_INT_1610_McBSP2RX_OF  31
-#define OMAP_INT_1610_STI          32
-#define OMAP_INT_1610_STI_WAKEUP   33
-#define OMAP_INT_1610_GPTIMER3     34
-#define OMAP_INT_1610_GPTIMER4     35
-#define OMAP_INT_1610_GPTIMER5     36
-#define OMAP_INT_1610_GPTIMER6     37
-#define OMAP_INT_1610_GPTIMER7     38
-#define OMAP_INT_1610_GPTIMER8     39
-#define OMAP_INT_1610_GPIO_BANK2   40
-#define OMAP_INT_1610_GPIO_BANK3   41
-#define OMAP_INT_1610_MMC2         42
-#define OMAP_INT_1610_CF           43
-#define OMAP_INT_1610_WAKE_UP_REQ  46
-#define OMAP_INT_1610_GPIO_BANK4   48
-#define OMAP_INT_1610_SPI          49
-#define OMAP_INT_1610_DMA_CH6      53
-#define OMAP_INT_1610_DMA_CH7      54
-#define OMAP_INT_1610_DMA_CH8      55
-#define OMAP_INT_1610_DMA_CH9      56
-#define OMAP_INT_1610_DMA_CH10     57
-#define OMAP_INT_1610_DMA_CH11     58
-#define OMAP_INT_1610_DMA_CH12     59
-#define OMAP_INT_1610_DMA_CH13     60
-#define OMAP_INT_1610_DMA_CH14     61
-#define OMAP_INT_1610_DMA_CH15     62
-#define OMAP_INT_1610_NAND         63
-
-/*
- * OMAP-730 specific IRQ numbers for level 2 interrupt handler
- */
-#define OMAP_INT_730_HW_ERRORS         0
-#define OMAP_INT_730_NFIQ_PWR_FAIL     1
-#define OMAP_INT_730_CFCD              2
-#define OMAP_INT_730_CFIREQ            3
-#define OMAP_INT_730_I2C               4
-#define OMAP_INT_730_PCC               5
-#define OMAP_INT_730_MPU_EXT_NIRQ      6
-#define OMAP_INT_730_SPI_100K_1        7
-#define OMAP_INT_730_SYREN_SPI         8
-#define OMAP_INT_730_VLYNQ             9
-#define OMAP_INT_730_GPIO_BANK4        10
-#define OMAP_INT_730_McBSP1TX          11
-#define OMAP_INT_730_McBSP1RX          12
-#define OMAP_INT_730_McBSP1RX_OF       13
-#define OMAP_INT_730_UART_MODEM_IRDA_2 14
-#define OMAP_INT_730_UART_MODEM_1      15
-#define OMAP_INT_730_MCSI              16
-#define OMAP_INT_730_uWireTX           17
-#define OMAP_INT_730_uWireRX           18
-#define OMAP_INT_730_SMC_CD            19
-#define OMAP_INT_730_SMC_IREQ          20
-#define OMAP_INT_730_HDQ_1WIRE         21
-#define OMAP_INT_730_TIMER32K          22
-#define OMAP_INT_730_MMC_SDIO          23
-#define OMAP_INT_730_UPLD              24
-#define OMAP_INT_730_USB_HHC_1         27
-#define OMAP_INT_730_USB_HHC_2         28
-#define OMAP_INT_730_USB_GENI          29
-#define OMAP_INT_730_USB_OTG           30
-#define OMAP_INT_730_CAMERA_IF         31
-#define OMAP_INT_730_RNG               32
-#define OMAP_INT_730_DUAL_MODE_TIMER   33
-#define OMAP_INT_730_DBB_RF_EN         34
-#define OMAP_INT_730_MPUIO_KEYPAD      35
-#define OMAP_INT_730_SHA1_MD5          36
-#define OMAP_INT_730_SPI_100K_2        37
-#define OMAP_INT_730_RNG_IDLE          38
-#define OMAP_INT_730_MPUIO             39
-#define OMAP_INT_730_LLPC_LCD_CTRL_OFF 40
-#define OMAP_INT_730_LLPC_OE_FALLING   41
-#define OMAP_INT_730_LLPC_OE_RISING    42
-#define OMAP_INT_730_LLPC_VSYNC        43
-#define OMAP_INT_730_WAKE_UP_REQ       46
-#define OMAP_INT_730_DMA_CH6           53
-#define OMAP_INT_730_DMA_CH7           54
-#define OMAP_INT_730_DMA_CH8           55
-#define OMAP_INT_730_DMA_CH9           56
-#define OMAP_INT_730_DMA_CH10          57
-#define OMAP_INT_730_DMA_CH11          58
-#define OMAP_INT_730_DMA_CH12          59
-#define OMAP_INT_730_DMA_CH13          60
-#define OMAP_INT_730_DMA_CH14          61
-#define OMAP_INT_730_DMA_CH15          62
-#define OMAP_INT_730_NAND              63
-
 /* omap_dma.c */
 enum omap_dma_model {
     omap_dma_3_0,
@@ -437,9 +282,6 @@ struct omap_dma_lcd_channel_s {
 #define OMAP_DMA_CAMERA_IF_RX      20
 #define OMAP_DMA_MMC_TX            21
 #define OMAP_DMA_MMC_RX            22
-#define OMAP_DMA_NAND              23  /* Not in OMAP310 */
-#define OMAP_DMA_IRQ_LCD_LINE      24  /* Not in OMAP310 */
-#define OMAP_DMA_MEMORY_STICK      25  /* Not in OMAP310 */
 #define OMAP_DMA_USB_W2FC_RX0      26
 #define OMAP_DMA_USB_W2FC_RX1      27
 #define OMAP_DMA_USB_W2FC_RX2      28
@@ -447,33 +289,6 @@ struct omap_dma_lcd_channel_s {
 #define OMAP_DMA_USB_W2FC_TX1      30
 #define OMAP_DMA_USB_W2FC_TX2      31
 
-/* These are only for 1610 */
-#define OMAP_DMA_CRYPTO_DES_IN         32
-#define OMAP_DMA_SPI_TX                33
-#define OMAP_DMA_SPI_RX                34
-#define OMAP_DMA_CRYPTO_HASH           35
-#define OMAP_DMA_CCP_ATTN              36
-#define OMAP_DMA_CCP_FIFO_NOT_EMPTY    37
-#define OMAP_DMA_CMT_APE_TX_CHAN_0     38
-#define OMAP_DMA_CMT_APE_RV_CHAN_0     39
-#define OMAP_DMA_CMT_APE_TX_CHAN_1     40
-#define OMAP_DMA_CMT_APE_RV_CHAN_1     41
-#define OMAP_DMA_CMT_APE_TX_CHAN_2     42
-#define OMAP_DMA_CMT_APE_RV_CHAN_2     43
-#define OMAP_DMA_CMT_APE_TX_CHAN_3     44
-#define OMAP_DMA_CMT_APE_RV_CHAN_3     45
-#define OMAP_DMA_CMT_APE_TX_CHAN_4     46
-#define OMAP_DMA_CMT_APE_RV_CHAN_4     47
-#define OMAP_DMA_CMT_APE_TX_CHAN_5     48
-#define OMAP_DMA_CMT_APE_RV_CHAN_5     49
-#define OMAP_DMA_CMT_APE_TX_CHAN_6     50
-#define OMAP_DMA_CMT_APE_RV_CHAN_6     51
-#define OMAP_DMA_CMT_APE_TX_CHAN_7     52
-#define OMAP_DMA_CMT_APE_RV_CHAN_7     53
-#define OMAP_DMA_MMC2_TX               54
-#define OMAP_DMA_MMC2_RX               55
-#define OMAP_DMA_CRYPTO_DES_OUT        56
-
 struct omap_uart_s;
 struct omap_uart_s *omap_uart_init(hwaddr base,
                 qemu_irq irq, omap_clk fclk, omap_clk iclk,
-- 
2.43.0


