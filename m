Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF78C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 20:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcA3c-0006Hn-OB; Mon, 19 Feb 2024 15:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rcA3D-00065Z-Ge; Mon, 19 Feb 2024 15:15:48 -0500
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rcA35-0006Ld-Lp; Mon, 19 Feb 2024 15:15:40 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 26800205EA;
 Mon, 19 Feb 2024 21:15:32 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id lxQuZH7M8uuA; Mon, 19 Feb 2024 21:15:30 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 67BCD205F9;
 Mon, 19 Feb 2024 21:15:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 67BCD205F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1708373730;
 bh=eBYIgw11sKXz2be0RD6ORx9pSyG9o10aswCk6Dkff2w=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=Tt7qpK7oWGRjCtL8E1CFXzIWX2pLnjKgdIJl4+gb+bCCT804a42iVFB1wiCkLwE0+
 3UiGiLxPPM6bAwN5HTl2XZeeOnRECsr5E/ewar7PrMFhFw/jTByvsMR5hYG/yYVBpb
 6cAJ/T6ftL1voO8fnJifsq4ehy3ZTyRPXvsaBKjo=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id VD6gYsIcq46Q; Mon, 19 Feb 2024 21:15:30 +0100 (CET)
Received: from AM-Inspiron-3585.. (cust-west-par-46-193-4-103.cust.wifirst.net
 [46.193.4.103])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id 7995B205EA;
 Mon, 19 Feb 2024 21:15:29 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>
Subject: [PATCH v5 5/8] RCC: Handle Register Updates
Date: Mon, 19 Feb 2024 21:09:05 +0100
Message-Id: <20240219200908.49551-6-arnaud.minier@telecom-paris.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219200908.49551-1-arnaud.minier@telecom-paris.fr>
References: <20240219200908.49551-1-arnaud.minier@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::df;
 envelope-from=arnaud.minier@telecom-paris.fr; helo=zproxy4.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Update the RCC state and propagate frequency changes when writing to the
RCC registers. Currently, ICSCR, CIER, the reset registers and the stop
mode registers are not implemented.

Some fields  have not been implemented due to uncertainty about
how to handle them (Like the clock security system or bypassing
mecanisms).

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/misc/stm32l4x5_rcc.c | 536 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 524 insertions(+), 12 deletions(-)

diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index 4ffb8a209a..a3b192e61b 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -36,6 +36,19 @@
 #define LSE_FRQ 32768ULL
 #define LSI_FRQ 32000ULL
=20
+/*
+ * Extract the bits of the field designated by `_bit_field_name` from th=
e
+ * register `_register_name`, stored in the field `_struct_field_name` o=
f the
+ * Stm32l4x5RccState struct named `_struct`.
+ *
+ * Usually, `_struct_field_name` is the lowercase version of `_register_=
name`.
+ */
+#define REGISTER_EXTRACT(_struct_name, _struct_field_name, \
+                         _register_name, _bit_field_name) \
+        extract32(_struct_name->_struct_field_name, \
+                  R_##_register_name##_##_bit_field_name##_SHIFT, \
+                  R_##_register_name##_##_bit_field_name##_LENGTH)
+
 static void clock_mux_update(RccClockMuxState *mux)
 {
     uint64_t src_freq, old_freq, freq;
@@ -323,6 +336,9 @@ static void pll_set_channel_divider(RccPllState *pll,
=20
 static void rcc_update_irq(Stm32l4x5RccState *s)
 {
+    /*
+     * TODO: Handle LSECSSF and CSSF flags when the CSS is implemented.
+     */
     if (s->cifr & CIFR_IRQ_MASK) {
         qemu_irq_raise(s->irq);
     } else {
@@ -330,6 +346,472 @@ static void rcc_update_irq(Stm32l4x5RccState *s)
     }
 }
=20
+static void rcc_update_cr_register(Stm32l4x5RccState *s)
+{
+    int val;
+
+    /* PLLSAI2ON and update PLLSAI2RDY */
+    val =3D extract32(s->cr, R_CR_PLLSAI2ON_SHIFT, R_CR_PLLSAI2ON_LENGTH=
);
+    pll_set_enable(&s->plls[RCC_PLL_PLLSAI2], val);
+    s->cr =3D (s->cr & ~R_CR_PLLSAI2RDY_MASK) |
+            (val << R_CR_PLLSAI2RDY_SHIFT);
+    if (s->cier & R_CIER_PLLSAI2RDYIE_MASK) {
+        s->cifr |=3D R_CIFR_PLLSAI2RDYF_MASK;
+    }
+
+    /* PLLSAI1ON and update PLLSAI1RDY */
+    val =3D extract32(s->cr, R_CR_PLLSAI1ON_SHIFT, R_CR_PLLSAI1ON_LENGTH=
);
+    pll_set_enable(&s->plls[RCC_PLL_PLLSAI1], val);
+    s->cr =3D (s->cr & ~R_CR_PLLSAI1RDY_MASK) |
+            (val << R_CR_PLLSAI1RDY_SHIFT);
+    if (s->cier & R_CIER_PLLSAI1RDYIE_MASK) {
+        s->cifr |=3D R_CIFR_PLLSAI1RDYF_MASK;
+    }
+
+    /* PLLON and update PLLRDY */
+    val =3D extract32(s->cr, R_CR_PLLON_SHIFT, R_CR_PLLON_LENGTH);
+    pll_set_enable(&s->plls[RCC_PLL_PLL], val);
+    s->cr =3D (s->cr & ~R_CR_PLLRDY_MASK) |
+            (val << R_CR_PLLRDY_SHIFT);
+    if (s->cier & R_CIER_PLLRDYIE_MASK) {
+        s->cifr |=3D R_CIFR_PLLRDYF_MASK;
+    }
+
+    /* CSSON: TODO */
+    /* HSEBYP: TODO */
+
+    /* HSEON and update HSERDY */
+    val =3D extract32(s->cr, R_CR_HSEON_SHIFT, R_CR_HSEON_LENGTH);
+    s->cr =3D (s->cr & ~R_CR_HSERDY_MASK) |
+            (val << R_CR_HSERDY_SHIFT);
+    if (val) {
+        clock_update_hz(s->hse, s->hse_frequency);
+        if (s->cier & R_CIER_HSERDYIE_MASK) {
+            s->cifr |=3D R_CIFR_HSERDYF_MASK;
+        }
+    } else {
+        clock_update_hz(s->hse, 0);
+    }
+
+    /* HSIAFS: TODO*/
+    /* HSIKERON: TODO*/
+
+    /* HSION and update HSIRDY*/
+    val =3D extract32(s->cr, R_CR_HSION_SHIFT, R_CR_HSION_LENGTH);
+    s->cr =3D (s->cr & ~R_CR_HSIRDY_MASK) |
+            (val << R_CR_HSIRDY_SHIFT);
+    if (val) {
+        clock_update_hz(s->hsi16_rc, HSI_FRQ);
+        if (s->cier & R_CIER_HSIRDYIE_MASK) {
+            s->cifr |=3D R_CIFR_HSIRDYF_MASK;
+        }
+    } else {
+        clock_update_hz(s->hsi16_rc, 0);
+    }
+
+    static const uint32_t msirange[] =3D {
+        100000, 200000, 400000, 800000, 1000000, 2000000,
+        4000000, 8000000, 16000000, 24000000, 32000000, 48000000
+    };
+    /* MSIRANGE and MSIRGSEL */
+    val =3D extract32(s->cr, R_CR_MSIRGSEL_SHIFT, R_CR_MSIRGSEL_LENGTH);
+    if (val) {
+        /* MSIRGSEL is set, use the MSIRANGE field */
+        val =3D extract32(s->cr, R_CR_MSIRANGE_SHIFT, R_CR_MSIRANGE_LENG=
TH);
+    } else {
+        /* MSIRGSEL is not set, use the MSISRANGE field */
+        val =3D extract32(s->csr, R_CSR_MSISRANGE_SHIFT, R_CSR_MSISRANGE=
_LENGTH);
+    }
+
+    if (val < ARRAY_SIZE(msirange)) {
+        clock_update_hz(s->msi_rc, msirange[val]);
+    } else {
+        clock_update_hz(s->msi_rc, MSI_DEFAULT_FRQ);
+        /* TODO: there is a write protection if the value is out of boun=
d,
+           implement that instead of setting the default */
+    }
+
+    /* MSIPLLEN */
+
+    /* MSION and update MSIRDY */
+    val =3D extract32(s->cr, R_CR_MSION_SHIFT, R_CR_MSION_LENGTH);
+    s->cr =3D (s->cr & ~R_CR_MSIRDY_MASK) |
+            (val << R_CR_MSIRDY_SHIFT);
+    if (s->cier & R_CIER_MSIRDYIE_MASK) {
+        s->cifr |=3D R_CIFR_MSIRDYF_MASK;
+    }
+    rcc_update_irq(s);
+}
+
+static void rcc_update_cfgr_register(Stm32l4x5RccState *s)
+{
+    uint32_t val;
+    /* MCOPRE */
+    val =3D extract32(s->cfgr, R_CFGR_MCOPRE_SHIFT, R_CFGR_MCOPRE_LENGTH=
);
+    assert(val <=3D 0b100);
+    clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_MCO],
+                         1, 1 << val);
+
+    /* MCOSEL */
+    val =3D extract32(s->cfgr, R_CFGR_MCOSEL_SHIFT, R_CFGR_MCOSEL_LENGTH=
);
+    assert(val <=3D 0b111);
+    if (val =3D=3D 0) {
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
+    val =3D extract32(s->cfgr, R_CFGR_PPRE2_SHIFT, R_CFGR_PPRE2_LENGTH);
+    if (val < 0b100) {
+        clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_PCLK2],
+                             1, 1);
+    } else {
+        clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_PCLK2],
+                             1, 1 << (val - 0b11));
+    }
+
+    /* PPRE1 */
+    val =3D extract32(s->cfgr, R_CFGR_PPRE1_SHIFT, R_CFGR_PPRE1_LENGTH);
+    if (val < 0b100) {
+        clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_PCLK1],
+                             1, 1);
+    } else {
+        clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_PCLK1],
+                             1, 1 << (val - 0b11));
+    }
+
+    /* HPRE */
+    val =3D extract32(s->cfgr, R_CFGR_HPRE_SHIFT, R_CFGR_HPRE_LENGTH);
+    if (val < 0b1000) {
+        clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_HCLK],
+                             1, 1);
+    } else {
+        clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_HCLK],
+                             1, 1 << (val - 0b111));
+    }
+
+    /* Update SWS */
+    val =3D extract32(s->cfgr, R_CFGR_SW_SHIFT, R_CFGR_SW_LENGTH);
+    clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_SYSCLK],
+                         val);
+    s->cfgr &=3D ~R_CFGR_SWS_MASK;
+    s->cfgr |=3D val << R_CFGR_SWS_SHIFT;
+}
+
+static void rcc_update_ahb1enr(Stm32l4x5RccState *s)
+{
+    #define AHB1ENR_SET_ENABLE(_peripheral_name) \
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_##_peripheral=
_name], \
+            REGISTER_EXTRACT(s, ahb1enr, AHB1ENR, _peripheral_name##EN))
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
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_##_peripheral=
_name], \
+            REGISTER_EXTRACT(s, ahb2enr, AHB2ENR, _peripheral_name##EN))
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
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_##_peripheral=
_name], \
+            REGISTER_EXTRACT(s, ahb3enr, AHB3ENR, _peripheral_name##EN))
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
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_##_peripheral=
_name], \
+            REGISTER_EXTRACT(s, apb1enr1, APB1ENR1, _peripheral_name##EN=
))
+    #define APB1ENR2_SET_ENABLE(_peripheral_name) \
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_##_peripheral=
_name], \
+            REGISTER_EXTRACT(s, apb1enr2, APB1ENR2, _peripheral_name##EN=
))
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
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_##_peripheral=
_name], \
+            REGISTER_EXTRACT(s, apb2enr, APB2ENR, _peripheral_name##EN))
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
+        reg =3D s->pllcfgr;
+        break;
+    case RCC_PLL_PLLSAI1:
+        reg =3D s->pllsai1cfgr;
+        break;
+    case RCC_PLL_PLLSAI2:
+        reg =3D s->pllsai2cfgr;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid PLL ID: %u\n", __func__, pll_id);
+        return;
+    }
+
+    /* PLLPDIV */
+    val =3D extract32(reg, R_PLLCFGR_PLLPDIV_SHIFT, R_PLLCFGR_PLLPDIV_LE=
NGTH);
+    /* 1 is a reserved value */
+    if (val =3D=3D 0) {
+        /* Get PLLP value */
+        val =3D extract32(reg, R_PLLCFGR_PLLP_SHIFT, R_PLLCFGR_PLLP_LENG=
TH);
+        pll_set_channel_divider(&s->plls[pll_id], RCC_PLL_COMMON_CHANNEL=
_P,
+            (val ? 17 : 7));
+    } else if (val > 1) {
+        pll_set_channel_divider(&s->plls[pll_id], RCC_PLL_COMMON_CHANNEL=
_P,
+            val);
+    }
+
+
+    /* PLLR */
+    val =3D extract32(reg, R_PLLCFGR_PLLR_SHIFT, R_PLLCFGR_PLLR_LENGTH);
+    pll_set_channel_divider(&s->plls[pll_id], RCC_PLL_COMMON_CHANNEL_R,
+        2 * (val + 1));
+
+    /* PLLREN */
+    val =3D extract32(reg, R_PLLCFGR_PLLREN_SHIFT, R_PLLCFGR_PLLREN_LENG=
TH);
+    pll_set_channel_enable(&s->plls[pll_id], RCC_PLL_COMMON_CHANNEL_R, v=
al);
+
+    /* PLLQ */
+    val =3D extract32(reg, R_PLLCFGR_PLLQ_SHIFT, R_PLLCFGR_PLLQ_LENGTH);
+    pll_set_channel_divider(&s->plls[pll_id], RCC_PLL_COMMON_CHANNEL_Q,
+        2 * (val + 1));
+
+    /* PLLQEN */
+    val =3D extract32(reg, R_PLLCFGR_PLLQEN_SHIFT, R_PLLCFGR_PLLQEN_LENG=
TH);
+    pll_set_channel_enable(&s->plls[pll_id], RCC_PLL_COMMON_CHANNEL_Q, v=
al);
+
+    /* PLLPEN */
+    val =3D extract32(reg, R_PLLCFGR_PLLPEN_SHIFT, R_PLLCFGR_PLLPEN_LENG=
TH);
+    pll_set_channel_enable(&s->plls[pll_id], RCC_PLL_COMMON_CHANNEL_P, v=
al);
+
+    /* PLLN */
+    val =3D extract32(reg, R_PLLCFGR_PLLN_SHIFT, R_PLLCFGR_PLLN_LENGTH);
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
+    val =3D extract32(s->pllcfgr, R_PLLCFGR_PLLM_SHIFT, R_PLLCFGR_PLLM_L=
ENGTH);
+    clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_PLL_INPUT], 1, (v=
al + 1));
+
+    /* PLLSRC */
+    val =3D extract32(s->pllcfgr, R_PLLCFGR_PLLSRC_SHIFT, R_PLLCFGR_PLLS=
RC_LENGTH);
+    if (val =3D=3D 0) {
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_PLL_INPUT], f=
alse);
+    } else {
+        clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_PLL_INPUT], v=
al - 1);
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_PLL_INPUT], t=
rue);
+    }
+}
+
+static void rcc_update_ccipr(Stm32l4x5RccState *s)
+{
+    #define CCIPR_SET_SOURCE(_peripheral_name) \
+        clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_##_peripheral=
_name], \
+            REGISTER_EXTRACT(s, ccipr, CCIPR, _peripheral_name##SEL))
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
+    val =3D extract32(s->bdcr, R_BDCR_LSCOSEL_SHIFT, R_BDCR_LSCOSEL_LENG=
TH);
+    clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_LSCO], val);
+
+    val =3D extract32(s->bdcr, R_BDCR_LSCOEN_SHIFT, R_BDCR_LSCOEN_LENGTH=
);
+    clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_LSCO], val);
+
+    /* BDRST */
+    /*
+     * The documentation is not clear if the RTCEN flag disables the RTC=
 and
+     * the LCD common mux or if it only affects the RTC.
+     * As the LCDEN flag exists, we assume here that it only affects the=
 RTC.
+     */
+    val =3D extract32(s->bdcr, R_BDCR_RTCEN_SHIFT, R_BDCR_RTCEN_SHIFT);
+    clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_RTC], val);
+    /* LCD and RTC share the same clock */
+    val =3D extract32(s->bdcr, R_BDCR_RTCSEL_SHIFT, R_BDCR_RTCSEL_LENGTH=
);
+    clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_LCD_AND_RTC_COMMO=
N], val);
+
+    /* LSECSSON */
+    /* LSEDRV[1:0] */
+    /* LSEBYP */
+
+    /* LSEON: Update LSERDY at the same time */
+    val =3D extract32(s->bdcr, R_BDCR_LSEON_SHIFT, R_BDCR_LSEON_LENGTH);
+    if (val) {
+        clock_update_hz(s->lse_crystal, LSE_FRQ);
+        s->bdcr |=3D R_BDCR_LSERDY_MASK;
+        if (s->cier & R_CIER_LSERDYIE_MASK) {
+            s->cifr |=3D R_CIFR_LSERDYF_MASK;
+        }
+    } else {
+        clock_update_hz(s->lse_crystal, 0);
+        s->bdcr &=3D ~R_BDCR_LSERDY_MASK;
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
+    val =3D extract32(s->csr, R_CSR_LSION_SHIFT, R_CSR_LSION_LENGTH);
+    if (val) {
+        clock_update_hz(s->lsi_rc, LSI_FRQ);
+        s->csr |=3D R_CSR_LSIRDY_MASK;
+        if (s->cier & R_CIER_LSIRDYIE_MASK) {
+            s->cifr |=3D R_CIFR_LSIRDYF_MASK;
+        }
+    } else {
+        /*
+         * TODO: Handle when the LSI is set independently of LSION.
+         * E.g. when the LSI is set by the RTC.
+         * See the reference manual for more details.
+         */
+        clock_update_hz(s->lsi_rc, 0);
+        s->csr &=3D ~R_CSR_LSIRDY_MASK;
+    }
+
+    rcc_update_irq(s);
+}
+
 static void stm32l4x5_rcc_reset_hold(Object *obj)
 {
     Stm32l4x5RccState *s =3D STM32L4X5_RCC(obj);
@@ -489,24 +971,33 @@ static void stm32l4x5_rcc_write(void *opaque, hwadd=
r addr,
     case A_CR:
         s->cr =3D (s->cr & CR_READ_SET_MASK) |
                 (value & (CR_READ_SET_MASK | ~CR_READ_ONLY_MASK));
+        rcc_update_cr_register(s);
         break;
     case A_ICSCR:
         s->icscr =3D value & ~ICSCR_READ_ONLY_MASK;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for ICSCR\n", __func__=
);
         break;
     case A_CFGR:
         s->cfgr =3D value & ~CFGR_READ_ONLY_MASK;
+        rcc_update_cfgr_register(s);
         break;
     case A_PLLCFGR:
         s->pllcfgr =3D value;
+        rcc_update_pllcfgr(s);
         break;
     case A_PLLSAI1CFGR:
         s->pllsai1cfgr =3D value;
+        rcc_update_pllsaixcfgr(s, RCC_PLL_PLLSAI1);
         break;
     case A_PLLSAI2CFGR:
         s->pllsai2cfgr =3D value;
+        rcc_update_pllsaixcfgr(s, RCC_PLL_PLLSAI2);
         break;
     case A_CIER:
         s->cier =3D value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for CIER\n", __func__)=
;
         break;
     case A_CIFR:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -521,67 +1012,100 @@ static void stm32l4x5_rcc_write(void *opaque, hwa=
ddr addr,
     /* Reset behaviors are not implemented */
     case A_AHB1RSTR:
         s->ahb1rstr =3D value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for AHB1RSTR\n", __fun=
c__);
         break;
     case A_AHB2RSTR:
         s->ahb2rstr =3D value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for AHB2RSTR\n", __fun=
c__);
         break;
     case A_AHB3RSTR:
         s->ahb3rstr =3D value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for AHB3RSTR\n", __fun=
c__);
         break;
     case A_APB1RSTR1:
         s->apb1rstr1 =3D value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for APB1RSTR1\n", __fu=
nc__);
         break;
     case A_APB1RSTR2:
         s->apb1rstr2 =3D value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for APB1RSTR2\n", __fu=
nc__);
         break;
     case A_APB2RSTR:
         s->apb2rstr =3D value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for APB2RSTR\n", __fun=
c__);
         break;
     case A_AHB1ENR:
         s->ahb1enr =3D value;
+        rcc_update_ahb1enr(s);
         break;
     case A_AHB2ENR:
         s->ahb2enr =3D value;
+        rcc_update_ahb2enr(s);
         break;
     case A_AHB3ENR:
         s->ahb3enr =3D value;
+        rcc_update_ahb3enr(s);
         break;
     case A_APB1ENR1:
         s->apb1enr1 =3D value;
+        rcc_update_apb1enr(s);
         break;
     case A_APB1ENR2:
         s->apb1enr2 =3D value;
+        rcc_update_apb1enr(s);
         break;
     case A_APB2ENR:
         s->apb2enr =3D (s->apb2enr & APB2ENR_READ_SET_MASK) | value;
+        rcc_update_apb2enr(s);
         break;
     /* Behaviors for Sleep and Stop modes are not implemented */
     case A_AHB1SMENR:
         s->ahb1smenr =3D value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for AHB1SMENR\n", __fu=
nc__);
         break;
     case A_AHB2SMENR:
         s->ahb2smenr =3D value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for AHB2SMENR\n", __fu=
nc__);
         break;
     case A_AHB3SMENR:
         s->ahb3smenr =3D value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for AHB3SMENR\n", __fu=
nc__);
         break;
     case A_APB1SMENR1:
         s->apb1smenr1 =3D value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for APB1SMENR1\n", __f=
unc__);
         break;
     case A_APB1SMENR2:
         s->apb1smenr2 =3D value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for APB1SMENR2\n", __f=
unc__);
         break;
     case A_APB2SMENR:
         s->apb2smenr =3D value;
+        qemu_log_mask(LOG_UNIMP,
+                "%s: Side-effects not implemented for APB2SMENR\n", __fu=
nc__);
         break;
     case A_CCIPR:
         s->ccipr =3D value;
+        rcc_update_ccipr(s);
         break;
     case A_BDCR:
         s->bdcr =3D value & ~BDCR_READ_ONLY_MASK;
+        rcc_update_bdcr(s);
         break;
     case A_CSR:
         s->csr =3D value & ~CSR_READ_ONLY_MASK;
+        rcc_update_csr(s);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -778,18 +1302,6 @@ static void stm32l4x5_rcc_realize(DeviceState *dev,=
 Error **errp)
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
=20
 static Property stm32l4x5_rcc_properties[] =3D {
--=20
2.34.1


