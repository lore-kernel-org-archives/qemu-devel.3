Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA2EC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVEt-0001dd-Us; Tue, 05 Mar 2024 08:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDw-0000wb-QH
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:06 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDo-0005xn-T7
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:52 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33d118a181fso3650373f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646763; x=1710251563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JNI+Qpco22VWGAbmNYNkaRO2Lu4QWjoV4nttCF019Tw=;
 b=FWDFtzvPdK8F2XMbz5X8EQPfHNA18peyhQrifWh1FNCz7yUnze41Kwu6sM9KVAEWT4
 5fmzObsBX/+pVPbzZRzJR8WY16Fy0prXdFhRm7n9IE4JKwr/AldFqX0qIrkgLtOusP3n
 caHoF/rjK0pH8qg6Nv6eC09dkKDh7q5xoi8W9EUzOW515404K6Csi5zm3AOtCAd+ok8g
 sGKiHtzBnjJip6K7FjsLvZi02cG87q5TqrW46HDwLlcRBrfhVRTjSmpOG1bWUj2TdECi
 76UdrvX5rc0PufxRI2HsJ6qhK4d69nCi8qoKPJ5rUcskXFxOW/4Vaom7tOUAZM/x+3Y9
 EW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646763; x=1710251563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JNI+Qpco22VWGAbmNYNkaRO2Lu4QWjoV4nttCF019Tw=;
 b=lUtu9y0STLLkHXlfp9CxLXDtwTcwUHTie0yhdjpXCXz9til1suG426ARhaizalQFge
 mACVKL7efvkox8oObgyGHjklntCPb6ltPdzpEXGzzkZrV/JJ/1e4SunP1dS79m2m7AS6
 BLWnM9VsmgkiHy+DfiCNEyCHubWpT7DO/SYY/VXVq8DWksd5hEW1TC5iccARf46weH4R
 Fb9X5/S3hxjsuFwdOzicDd44hSqNmB5YX7GMqsnc6ug+4+NLh3aglyIH5jurAW87TCK4
 kyNy3j+nTP2Hi4nY7mJzwafwbco3YhncXDeDHGW7TFUrb5A3F4qD+V0iFovbBk7+3cR3
 OFmA==
X-Gm-Message-State: AOJu0Yy3UpmkmVneD2thY/TbwXEtKoXIQb2X80auSyu+hkO9qqwlki8k
 fy+lbLFYoJ4Vftsu5qndR0B5H5umakK4IIimQHbzZ3akfsSpeO3sqhTaElg6ebvQiDaeBq8MqWF
 r
X-Google-Smtp-Source: AGHT+IFX9fzPerwWVI1nba94s/HZaX2JI3CF1eoPMWG3ZOiCqNik3STSzl3XdanxoXZBTAJW3ioKAQ==
X-Received: by 2002:a05:6000:3c5:b0:33e:4590:8bd8 with SMTP id
 b5-20020a05600003c500b0033e45908bd8mr4370759wrg.60.1709646763442; 
 Tue, 05 Mar 2024 05:52:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/20] hw/misc/stm32l4x5_rcc: Handle Register Updates
Date: Tue,  5 Mar 2024 13:52:26 +0000
Message-Id: <20240305135237.3111642-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Arnaud Minier <arnaud.minier@telecom-paris.fr>

Update the RCC state and propagate frequency changes when writing to the
RCC registers. Currently, ICSCR, CIER, the reset registers and the stop
mode registers are not implemented.

Some fields  have not been implemented due to uncertainty about
how to handle them (Like the clock security system or bypassing
mecanisms).

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240303140643.81957-6-arnaud.minier@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/stm32l4x5_rcc.c | 524 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 512 insertions(+), 12 deletions(-)

diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index 083c0ad9ef5..2109f809e2b 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -28,6 +28,7 @@
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "hw/registerfields.h"
 #include "trace.h"
 
 #define HSE_DEFAULT_FRQ 48000000ULL
@@ -363,6 +364,9 @@ static void pll_set_channel_divider(RccPllState *pll,
 
 static void rcc_update_irq(Stm32l4x5RccState *s)
 {
+    /*
+     * TODO: Handle LSECSSF and CSSF flags when the CSS is implemented.
+     */
     if (s->cifr & CIFR_IRQ_MASK) {
         qemu_irq_raise(s->irq);
     } else {
@@ -370,6 +374,472 @@ static void rcc_update_irq(Stm32l4x5RccState *s)
     }
 }
 
+static void rcc_update_cr_register(Stm32l4x5RccState *s)
+{
+    int val;
+
+    /* PLLSAI2ON and update PLLSAI2RDY */
+    val = FIELD_EX32(s->cr, CR, PLLSAI2ON);
+    pll_set_enable(&s->plls[RCC_PLL_PLLSAI2], val);
+    s->cr = (s->cr & ~R_CR_PLLSAI2RDY_MASK) |
+            (val << R_CR_PLLSAI2RDY_SHIFT);
+    if (s->cier & R_CIER_PLLSAI2RDYIE_MASK) {
+        s->cifr |= R_CIFR_PLLSAI2RDYF_MASK;
+    }
+
+    /* PLLSAI1ON and update PLLSAI1RDY */
+    val = FIELD_EX32(s->cr, CR, PLLSAI1ON);
+    pll_set_enable(&s->plls[RCC_PLL_PLLSAI1], val);
+    s->cr = (s->cr & ~R_CR_PLLSAI1RDY_MASK) |
+            (val << R_CR_PLLSAI1RDY_SHIFT);
+    if (s->cier & R_CIER_PLLSAI1RDYIE_MASK) {
+        s->cifr |= R_CIFR_PLLSAI1RDYF_MASK;
+    }
+
+    /* PLLON and update PLLRDY */
+    val = FIELD_EX32(s->cr, CR, PLLON);
+    pll_set_enable(&s->plls[RCC_PLL_PLL], val);
+    s->cr = (s->cr & ~R_CR_PLLRDY_MASK) |
+            (val << R_CR_PLLRDY_SHIFT);
+    if (s->cier & R_CIER_PLLRDYIE_MASK) {
+        s->cifr |= R_CIFR_PLLRDYF_MASK;
+    }
+
+    /* CSSON: TODO */
+    /* HSEBYP: TODO */
+
+    /* HSEON and update HSERDY */
+    val = FIELD_EX32(s->cr, CR, HSEON);
+    s->cr = (s->cr & ~R_CR_HSERDY_MASK) |
+            (val << R_CR_HSERDY_SHIFT);
+    if (val) {
+        clock_update_hz(s->hse, s->hse_frequency);
+        if (s->cier & R_CIER_HSERDYIE_MASK) {
+            s->cifr |= R_CIFR_HSERDYF_MASK;
+        }
+    } else {
+        clock_update(s->hse, 0);
+    }
+
+    /* HSIAFS: TODO*/
+    /* HSIKERON: TODO*/
+
+    /* HSION and update HSIRDY*/
+    val = FIELD_EX32(s->cr, CR, HSION);
+    s->cr = (s->cr & ~R_CR_HSIRDY_MASK) |
+            (val << R_CR_HSIRDY_SHIFT);
+    if (val) {
+        clock_update_hz(s->hsi16_rc, HSI_FRQ);
+        if (s->cier & R_CIER_HSIRDYIE_MASK) {
+            s->cifr |= R_CIFR_HSIRDYF_MASK;
+        }
+    } else {
+        clock_update(s->hsi16_rc, 0);
+    }
+
+    static const uint32_t msirange[] = {
+        100000, 200000, 400000, 800000, 1000000, 2000000,
+        4000000, 8000000, 16000000, 24000000, 32000000, 48000000
+    };
+    /* MSIRANGE and MSIRGSEL */
+    val = FIELD_EX32(s->cr, CR, MSIRGSEL);
+    if (val) {
+        /* MSIRGSEL is set, use the MSIRANGE field */
+        val = FIELD_EX32(s->cr, CR, MSIRANGE);
+    } else {
+        /* MSIRGSEL is not set, use the MSISRANGE field */
+        val = FIELD_EX32(s->csr, CSR, MSISRANGE);
+    }
+
+    if (val < ARRAY_SIZE(msirange)) {
+        clock_update_hz(s->msi_rc, msirange[val]);
+    } else {
+        clock_update_hz(s->msi_rc, MSI_DEFAULT_FRQ);
+        /* TODO: there is a write protection if the value is out of bound,
+           implement that instead of setting the default */
+    }
+
+    /* MSIPLLEN */
+
+    /* MSION and update MSIRDY */
+    val = FIELD_EX32(s->cr, CR, MSION);
+    s->cr = (s->cr & ~R_CR_MSIRDY_MASK) |
+            (val << R_CR_MSIRDY_SHIFT);
+    if (s->cier & R_CIER_MSIRDYIE_MASK) {
+        s->cifr |= R_CIFR_MSIRDYF_MASK;
+    }
+    rcc_update_irq(s);
+}
+
+static void rcc_update_cfgr_register(Stm32l4x5RccState *s)
+{
+    uint32_t val;
+    /* MCOPRE */
+    val = FIELD_EX32(s->cfgr, CFGR, MCOPRE);
+    assert(val <= 0b100);
+    clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_MCO],
+                         1, 1 << val);
+
+    /* MCOSEL */
+    val = FIELD_EX32(s->cfgr, CFGR, MCOSEL);
+    assert(val <= 0b111);
+    if (val == 0) {
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_MCO], false);
+    } else {
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_MCO], true);
+        clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_MCO],
+                             val - 1);
+    }
+
+    /* STOPWUCK */
+    /* TODO */
+
+    /* PPRE2 */
+    val = FIELD_EX32(s->cfgr, CFGR, PPRE2);
+    if (val < 0b100) {
+        clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_PCLK2],
+                             1, 1);
+    } else {
+        clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_PCLK2],
+                             1, 1 << (val - 0b11));
+    }
+
+    /* PPRE1 */
+    val = FIELD_EX32(s->cfgr, CFGR, PPRE1);
+    if (val < 0b100) {
+        clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_PCLK1],
+                             1, 1);
+    } else {
+        clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_PCLK1],
+                             1, 1 << (val - 0b11));
+    }
+
+    /* HPRE */
+    val = FIELD_EX32(s->cfgr, CFGR, HPRE);
+    if (val < 0b1000) {
+        clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_HCLK],
+                             1, 1);
+    } else {
+        clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_HCLK],
+                             1, 1 << (val - 0b111));
+    }
+
+    /* Update SWS */
+    val = FIELD_EX32(s->cfgr, CFGR, SW);
+    clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_SYSCLK],
+                         val);
+    s->cfgr &= ~R_CFGR_SWS_MASK;
+    s->cfgr |= val << R_CFGR_SWS_SHIFT;
+}
+
+static void rcc_update_ahb1enr(Stm32l4x5RccState *s)
+{
+    #define AHB1ENR_SET_ENABLE(_peripheral_name) \
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_##_peripheral_name], \
+            FIELD_EX32(s->ahb1enr, AHB1ENR, _peripheral_name##EN))
+
+    /* DMA2DEN: reserved for STM32L475xx */
+    AHB1ENR_SET_ENABLE(TSC);
+    AHB1ENR_SET_ENABLE(CRC);
+    AHB1ENR_SET_ENABLE(FLASH);
+    AHB1ENR_SET_ENABLE(DMA2);
+    AHB1ENR_SET_ENABLE(DMA1);
+
+    #undef AHB1ENR_SET_ENABLE
+}
+
+static void rcc_update_ahb2enr(Stm32l4x5RccState *s)
+{
+    #define AHB2ENR_SET_ENABLE(_peripheral_name) \
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_##_peripheral_name], \
+            FIELD_EX32(s->ahb2enr, AHB2ENR, _peripheral_name##EN))
+
+    AHB2ENR_SET_ENABLE(RNG);
+    /* HASHEN: reserved for STM32L475xx */
+    AHB2ENR_SET_ENABLE(AES);
+    /* DCMIEN: reserved for STM32L475xx */
+    AHB2ENR_SET_ENABLE(ADC);
+    AHB2ENR_SET_ENABLE(OTGFS);
+    /* GPIOIEN: reserved for STM32L475xx */
+    AHB2ENR_SET_ENABLE(GPIOA);
+    AHB2ENR_SET_ENABLE(GPIOB);
+    AHB2ENR_SET_ENABLE(GPIOC);
+    AHB2ENR_SET_ENABLE(GPIOD);
+    AHB2ENR_SET_ENABLE(GPIOE);
+    AHB2ENR_SET_ENABLE(GPIOF);
+    AHB2ENR_SET_ENABLE(GPIOG);
+    AHB2ENR_SET_ENABLE(GPIOH);
+
+    #undef AHB2ENR_SET_ENABLE
+}
+
+static void rcc_update_ahb3enr(Stm32l4x5RccState *s)
+{
+    #define AHB3ENR_SET_ENABLE(_peripheral_name) \
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_##_peripheral_name], \
+            FIELD_EX32(s->ahb3enr, AHB3ENR, _peripheral_name##EN))
+
+    AHB3ENR_SET_ENABLE(QSPI);
+    AHB3ENR_SET_ENABLE(FMC);
+
+    #undef AHB3ENR_SET_ENABLE
+}
+
+static void rcc_update_apb1enr(Stm32l4x5RccState *s)
+{
+    #define APB1ENR1_SET_ENABLE(_peripheral_name) \
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_##_peripheral_name], \
+            FIELD_EX32(s->apb1enr1, APB1ENR1, _peripheral_name##EN))
+    #define APB1ENR2_SET_ENABLE(_peripheral_name) \
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_##_peripheral_name], \
+            FIELD_EX32(s->apb1enr2, APB1ENR2, _peripheral_name##EN))
+
+    /* APB1ENR1 */
+    APB1ENR1_SET_ENABLE(LPTIM1);
+    APB1ENR1_SET_ENABLE(OPAMP);
+    APB1ENR1_SET_ENABLE(DAC1);
+    APB1ENR1_SET_ENABLE(PWR);
+    /* CAN2: reserved for STM32L4x5 */
+    APB1ENR1_SET_ENABLE(CAN1);
+    /* CRSEN: reserved for STM32L4x5 */
+    APB1ENR1_SET_ENABLE(I2C3);
+    APB1ENR1_SET_ENABLE(I2C2);
+    APB1ENR1_SET_ENABLE(I2C1);
+    APB1ENR1_SET_ENABLE(UART5);
+    APB1ENR1_SET_ENABLE(UART4);
+    APB1ENR1_SET_ENABLE(USART3);
+    APB1ENR1_SET_ENABLE(USART2);
+    APB1ENR1_SET_ENABLE(SPI3);
+    APB1ENR1_SET_ENABLE(SPI2);
+    APB1ENR1_SET_ENABLE(WWDG);
+    /* RTCAPB: reserved for STM32L4x5 */
+    APB1ENR1_SET_ENABLE(LCD);
+    APB1ENR1_SET_ENABLE(TIM7);
+    APB1ENR1_SET_ENABLE(TIM6);
+    APB1ENR1_SET_ENABLE(TIM5);
+    APB1ENR1_SET_ENABLE(TIM4);
+    APB1ENR1_SET_ENABLE(TIM3);
+    APB1ENR1_SET_ENABLE(TIM2);
+
+    /* APB1ENR2 */
+    APB1ENR2_SET_ENABLE(LPTIM2);
+    APB1ENR2_SET_ENABLE(SWPMI1);
+    /* I2C4EN: reserved for STM32L4x5 */
+    APB1ENR2_SET_ENABLE(LPUART1);
+
+    #undef APB1ENR1_SET_ENABLE
+    #undef APB1ENR2_SET_ENABLE
+}
+
+static void rcc_update_apb2enr(Stm32l4x5RccState *s)
+{
+    #define APB2ENR_SET_ENABLE(_peripheral_name) \
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_##_peripheral_name], \
+            FIELD_EX32(s->apb2enr, APB2ENR, _peripheral_name##EN))
+
+    APB2ENR_SET_ENABLE(DFSDM1);
+    APB2ENR_SET_ENABLE(SAI2);
+    APB2ENR_SET_ENABLE(SAI1);
+    APB2ENR_SET_ENABLE(TIM17);
+    APB2ENR_SET_ENABLE(TIM16);
+    APB2ENR_SET_ENABLE(TIM15);
+    APB2ENR_SET_ENABLE(USART1);
+    APB2ENR_SET_ENABLE(TIM8);
+    APB2ENR_SET_ENABLE(SPI1);
+    APB2ENR_SET_ENABLE(TIM1);
+    APB2ENR_SET_ENABLE(SDMMC1);
+    APB2ENR_SET_ENABLE(FW);
+    APB2ENR_SET_ENABLE(SYSCFG);
+
+    #undef APB2ENR_SET_ENABLE
+}
+
+/*
+ * The 3 PLLs share the same register layout
+ * so we can use the same function for all of them
+ * Note: no frequency bounds checking is done here.
+ */
+static void rcc_update_pllsaixcfgr(Stm32l4x5RccState *s, RccPll pll_id)
+{
+    uint32_t reg, val;
+    switch (pll_id) {
+    case RCC_PLL_PLL:
+        reg = s->pllcfgr;
+        break;
+    case RCC_PLL_PLLSAI1:
+        reg = s->pllsai1cfgr;
+        break;
+    case RCC_PLL_PLLSAI2:
+        reg = s->pllsai2cfgr;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid PLL ID: %u\n", __func__, pll_id);
+        return;
+    }
+
+    /* PLLPDIV */
+    val = FIELD_EX32(reg, PLLCFGR, PLLPDIV);
+    /* 1 is a reserved value */
+    if (val == 0) {
+        /* Get PLLP value */
+        val = FIELD_EX32(reg, PLLCFGR, PLLP);
+        pll_set_channel_divider(&s->plls[pll_id], RCC_PLL_COMMON_CHANNEL_P,
+            (val ? 17 : 7));
+    } else if (val > 1) {
+        pll_set_channel_divider(&s->plls[pll_id], RCC_PLL_COMMON_CHANNEL_P,
+            val);
+    }
+
+
+    /* PLLR */
+    val = FIELD_EX32(reg, PLLCFGR, PLLR);
+    pll_set_channel_divider(&s->plls[pll_id], RCC_PLL_COMMON_CHANNEL_R,
+        2 * (val + 1));
+
+    /* PLLREN */
+    val = FIELD_EX32(reg, PLLCFGR, PLLREN);
+    pll_set_channel_enable(&s->plls[pll_id], RCC_PLL_COMMON_CHANNEL_R, val);
+
+    /* PLLQ */
+    val = FIELD_EX32(reg, PLLCFGR, PLLQ);
+    pll_set_channel_divider(&s->plls[pll_id], RCC_PLL_COMMON_CHANNEL_Q,
+        2 * (val + 1));
+
+    /* PLLQEN */
+    val = FIELD_EX32(reg, PLLCFGR, PLLQEN);
+    pll_set_channel_enable(&s->plls[pll_id], RCC_PLL_COMMON_CHANNEL_Q, val);
+
+    /* PLLPEN */
+    val = FIELD_EX32(reg, PLLCFGR, PLLPEN);
+    pll_set_channel_enable(&s->plls[pll_id], RCC_PLL_COMMON_CHANNEL_P, val);
+
+    /* PLLN */
+    val = FIELD_EX32(reg, PLLCFGR, PLLN);
+    pll_set_vco_multiplier(&s->plls[pll_id], val);
+}
+
+static void rcc_update_pllcfgr(Stm32l4x5RccState *s)
+{
+    int val;
+
+    /* Use common layout */
+    rcc_update_pllsaixcfgr(s, RCC_PLL_PLL);
+
+    /* Fetch specific fields for pllcfgr */
+
+    /* PLLM */
+    val = FIELD_EX32(s->pllcfgr, PLLCFGR, PLLM);
+    clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_PLL_INPUT], 1, (val + 1));
+
+    /* PLLSRC */
+    val = FIELD_EX32(s->pllcfgr, PLLCFGR, PLLSRC);
+    if (val == 0) {
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_PLL_INPUT], false);
+    } else {
+        clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_PLL_INPUT], val - 1);
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_PLL_INPUT], true);
+    }
+}
+
+static void rcc_update_ccipr(Stm32l4x5RccState *s)
+{
+    #define CCIPR_SET_SOURCE(_peripheral_name) \
+        clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_##_peripheral_name], \
+            FIELD_EX32(s->ccipr, CCIPR, _peripheral_name##SEL))
+
+    CCIPR_SET_SOURCE(DFSDM1);
+    CCIPR_SET_SOURCE(SWPMI1);
+    CCIPR_SET_SOURCE(ADC);
+    CCIPR_SET_SOURCE(CLK48);
+    CCIPR_SET_SOURCE(SAI2);
+    CCIPR_SET_SOURCE(SAI1);
+    CCIPR_SET_SOURCE(LPTIM2);
+    CCIPR_SET_SOURCE(LPTIM1);
+    CCIPR_SET_SOURCE(I2C3);
+    CCIPR_SET_SOURCE(I2C2);
+    CCIPR_SET_SOURCE(I2C1);
+    CCIPR_SET_SOURCE(LPUART1);
+    CCIPR_SET_SOURCE(UART5);
+    CCIPR_SET_SOURCE(UART4);
+    CCIPR_SET_SOURCE(USART3);
+    CCIPR_SET_SOURCE(USART2);
+    CCIPR_SET_SOURCE(USART1);
+
+    #undef CCIPR_SET_SOURCE
+}
+
+static void rcc_update_bdcr(Stm32l4x5RccState *s)
+{
+    int val;
+
+    /* LSCOSEL */
+    val = FIELD_EX32(s->bdcr, BDCR, LSCOSEL);
+    clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_LSCO], val);
+
+    val = FIELD_EX32(s->bdcr, BDCR, LSCOEN);
+    clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_LSCO], val);
+
+    /* BDRST */
+    /*
+     * The documentation is not clear if the RTCEN flag disables the RTC and
+     * the LCD common mux or if it only affects the RTC.
+     * As the LCDEN flag exists, we assume here that it only affects the RTC.
+     */
+    val = FIELD_EX32(s->bdcr, BDCR, RTCEN);
+    clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_RTC], val);
+    /* LCD and RTC share the same clock */
+    val = FIELD_EX32(s->bdcr, BDCR, RTCSEL);
+    clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_LCD_AND_RTC_COMMON], val);
+
+    /* LSECSSON */
+    /* LSEDRV[1:0] */
+    /* LSEBYP */
+
+    /* LSEON: Update LSERDY at the same time */
+    val = FIELD_EX32(s->bdcr, BDCR, LSEON);
+    if (val) {
+        clock_update_hz(s->lse_crystal, LSE_FRQ);
+        s->bdcr |= R_BDCR_LSERDY_MASK;
+        if (s->cier & R_CIER_LSERDYIE_MASK) {
+            s->cifr |= R_CIFR_LSERDYF_MASK;
+        }
+    } else {
+        clock_update(s->lse_crystal, 0);
+        s->bdcr &= ~R_BDCR_LSERDY_MASK;
+    }
+
+    rcc_update_irq(s);
+}
+
+static void rcc_update_csr(Stm32l4x5RccState *s)
+{
+    int val;
+
+    /* Reset flags: Not implemented */
+    /* MSISRANGE: Not implemented after reset */
+
+    /* LSION: Update LSIRDY at the same time */
+    val = FIELD_EX32(s->csr, CSR, LSION);
+    if (val) {
+        clock_update_hz(s->lsi_rc, LSI_FRQ);
+        s->csr |= R_CSR_LSIRDY_MASK;
+        if (s->cier & R_CIER_LSIRDYIE_MASK) {
+            s->cifr |= R_CIFR_LSIRDYF_MASK;
+        }
+    } else {
+        /*
+         * TODO: Handle when the LSI is set independently of LSION.
+         * E.g. when the LSI is set by the RTC.
+         * See the reference manual for more details.
+         */
+        clock_update(s->lsi_rc, 0);
+        s->csr &= ~R_CSR_LSIRDY_MASK;
+    }
+
+    rcc_update_irq(s);
+}
+
 static void stm32l4x5_rcc_reset_hold(Object *obj)
 {
     Stm32l4x5RccState *s = STM32L4X5_RCC(obj);
@@ -529,24 +999,33 @@ static void stm32l4x5_rcc_write(void *opaque, hwaddr addr,
     case A_CR:
         s->cr = (s->cr & CR_READ_SET_MASK) |
                 (value & (CR_READ_SET_MASK | ~CR_READ_ONLY_MASK));
+        rcc_update_cr_register(s);
         break;
     case A_ICSCR:
         s->icscr = value & ~ICSCR_READ_ONLY_MASK;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for ICSCR\n", __func__);
         break;
     case A_CFGR:
         s->cfgr = value & ~CFGR_READ_ONLY_MASK;
+        rcc_update_cfgr_register(s);
         break;
     case A_PLLCFGR:
         s->pllcfgr = value;
+        rcc_update_pllcfgr(s);
         break;
     case A_PLLSAI1CFGR:
         s->pllsai1cfgr = value;
+        rcc_update_pllsaixcfgr(s, RCC_PLL_PLLSAI1);
         break;
     case A_PLLSAI2CFGR:
         s->pllsai2cfgr = value;
+        rcc_update_pllsaixcfgr(s, RCC_PLL_PLLSAI2);
         break;
     case A_CIER:
         s->cier = value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for CIER\n", __func__);
         break;
     case A_CIFR:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -561,67 +1040,100 @@ static void stm32l4x5_rcc_write(void *opaque, hwaddr addr,
     /* Reset behaviors are not implemented */
     case A_AHB1RSTR:
         s->ahb1rstr = value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for AHB1RSTR\n", __func__);
         break;
     case A_AHB2RSTR:
         s->ahb2rstr = value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for AHB2RSTR\n", __func__);
         break;
     case A_AHB3RSTR:
         s->ahb3rstr = value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for AHB3RSTR\n", __func__);
         break;
     case A_APB1RSTR1:
         s->apb1rstr1 = value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for APB1RSTR1\n", __func__);
         break;
     case A_APB1RSTR2:
         s->apb1rstr2 = value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for APB1RSTR2\n", __func__);
         break;
     case A_APB2RSTR:
         s->apb2rstr = value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for APB2RSTR\n", __func__);
         break;
     case A_AHB1ENR:
         s->ahb1enr = value;
+        rcc_update_ahb1enr(s);
         break;
     case A_AHB2ENR:
         s->ahb2enr = value;
+        rcc_update_ahb2enr(s);
         break;
     case A_AHB3ENR:
         s->ahb3enr = value;
+        rcc_update_ahb3enr(s);
         break;
     case A_APB1ENR1:
         s->apb1enr1 = value;
+        rcc_update_apb1enr(s);
         break;
     case A_APB1ENR2:
         s->apb1enr2 = value;
+        rcc_update_apb1enr(s);
         break;
     case A_APB2ENR:
         s->apb2enr = (s->apb2enr & APB2ENR_READ_SET_MASK) | value;
+        rcc_update_apb2enr(s);
         break;
     /* Behaviors for Sleep and Stop modes are not implemented */
     case A_AHB1SMENR:
         s->ahb1smenr = value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for AHB1SMENR\n", __func__);
         break;
     case A_AHB2SMENR:
         s->ahb2smenr = value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for AHB2SMENR\n", __func__);
         break;
     case A_AHB3SMENR:
         s->ahb3smenr = value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for AHB3SMENR\n", __func__);
         break;
     case A_APB1SMENR1:
         s->apb1smenr1 = value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for APB1SMENR1\n", __func__);
         break;
     case A_APB1SMENR2:
         s->apb1smenr2 = value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for APB1SMENR2\n", __func__);
         break;
     case A_APB2SMENR:
         s->apb2smenr = value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for APB2SMENR\n", __func__);
         break;
     case A_CCIPR:
         s->ccipr = value;
+        rcc_update_ccipr(s);
         break;
     case A_BDCR:
         s->bdcr = value & ~BDCR_READ_ONLY_MASK;
+        rcc_update_bdcr(s);
         break;
     case A_CSR:
         s->csr = value & ~CSR_READ_ONLY_MASK;
+        rcc_update_csr(s);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -831,18 +1343,6 @@ static void stm32l4x5_rcc_realize(DeviceState *dev, Error **errp)
     clock_update_hz(s->sai1_extclk, s->sai1_extclk_frequency);
     clock_update_hz(s->sai2_extclk, s->sai2_extclk_frequency);
     clock_update(s->gnd, 0);
-
-    /*
-     * Dummy values to make compilation pass.
-     * Removed in later commits.
-     */
-    clock_mux_set_source(&s->clock_muxes[0], RCC_CLOCK_MUX_SRC_GND);
-    clock_mux_set_enable(&s->clock_muxes[0], true);
-    clock_mux_set_factor(&s->clock_muxes[0], 1, 1);
-    pll_set_channel_divider(&s->plls[0], 0, 1);
-    pll_set_enable(&s->plls[0], true);
-    pll_set_channel_enable(&s->plls[0], 0, true);
-    pll_set_vco_multiplier(&s->plls[0], 1);
 }
 
 static Property stm32l4x5_rcc_properties[] = {
-- 
2.34.1


