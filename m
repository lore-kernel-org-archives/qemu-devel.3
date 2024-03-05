Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD406C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVEO-00014P-J0; Tue, 05 Mar 2024 08:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDu-0000w7-U4
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:51 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDn-0005xW-GH
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:50 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33dd2f0a0c4so3289958f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646762; x=1710251562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vTSqwIO9P4ISrMhGaC6cCKlCKl6nQ7JcgEadIqESrFU=;
 b=ON0OOAKpxB0n1OzgQCPrefU+lzr6hTDcyEo2YAvJOUf6XUhBqzme20JkRlwBBHyE22
 XYVZ8b7fDZvm2twIUfZc63yMMFUJ3Yr1XqQge/AuETvYKEsKPHl3AKlupwqblhsiV6aN
 Kbs8V2NlbtaaoSpg2x8jL5TeFtkM2zZdzMCuvUA/ravxU1gifzSE/TY+4AQEBgITl8u0
 AsZZDLa7NAaVcI3ZNWgkNF+ENDI4EYOBv/K7fEw9C7NqhRaJhDv5G4q/MzGDikqoAje0
 6N+KMj909B0AvcufHGmc9aYYG9Fm7i+BvuHEIRI9hozcl3zhRqKkE3phAAmjZJGCM70T
 DUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646762; x=1710251562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vTSqwIO9P4ISrMhGaC6cCKlCKl6nQ7JcgEadIqESrFU=;
 b=l3RxmpDSiuqg4nbOp4ns5BeIVI+35A5Vdd5YKwcNknjREJ0Gz36IraGv05OwiJPnYr
 4OUlxIhE9uWsgHLwAbbPS5CfF599f4nWFbiYZI5zGDH7nNXl+uPmHAoFS48nnV9ezFV/
 RN11QSgIpra8VoTrDoLdeEmZ1wOjogFsmFvdO/k5VK28JLj/w43d6QfEO73BaLDofB9W
 +Ai4Cv6l9IE2oZ8ULC/ODTcCS0TLvbXiX+DLzy/1Uo2hOGCTmN28Hsv8uSc1i45j/H3B
 chDdzBzEgBtWMnwuCkBVW9TR5N+MRRp/z3DOEUlGcR+9xx5H6BC9v4dhzcPfqnkcBF4M
 0R1A==
X-Gm-Message-State: AOJu0YzDqRMFmHB+nDKmAFzPyEEYswMf/zrJUfqSifEmi7lpyyC/h1Lg
 2jynVdO3KKyCK3CeJ6thzJF5Ex86Rzl4kze5d0tmyH1G2Tg0QhG1y05s341YhqcEyE0rLXuyCEF
 6
X-Google-Smtp-Source: AGHT+IGQ6CyPIkO4GZURHS1FgdOYp6oBenfPXkTB7YqYqtiyNIaoz8pWVXqbSmtsOIGfBfOkzJ2Szw==
X-Received: by 2002:a5d:624e:0:b0:33d:87ed:626 with SMTP id
 m14-20020a5d624e000000b0033d87ed0626mr7750596wrv.58.1709646762006; 
 Tue, 05 Mar 2024 05:52:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/20] hw/misc/stm32l4x5_rcc: Add an internal clock multiplexer
 object
Date: Tue,  5 Mar 2024 13:52:23 +0000
Message-Id: <20240305135237.3111642-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

This object is used to represent every multiplexer in the clock tree as
well as every clock output, every presecaler, frequency multiplier, etc.
This allows to use a generic approach for every component of the clock tree
(except the PLLs).

The migration handling is based on hw/misc/zynq_sclr.c.
Three phase reset will be handled in a later commit.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20240303140643.81957-3-arnaud.minier@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/stm32l4x5_rcc.h           | 119 ++++++++++++++++
 include/hw/misc/stm32l4x5_rcc_internals.h |  29 ++++
 hw/misc/stm32l4x5_rcc.c                   | 160 ++++++++++++++++++++++
 hw/misc/trace-events                      |   5 +
 4 files changed, 313 insertions(+)

diff --git a/include/hw/misc/stm32l4x5_rcc.h b/include/hw/misc/stm32l4x5_rcc.h
index 5157e966352..6719be9fbee 100644
--- a/include/hw/misc/stm32l4x5_rcc.h
+++ b/include/hw/misc/stm32l4x5_rcc.h
@@ -26,6 +26,122 @@ OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5RccState, STM32L4X5_RCC)
 
 /* In the Stm32l4x5 clock tree, mux have at most 7 sources */
 #define RCC_NUM_CLOCK_MUX_SRC 7
+/* NB: Prescaler are assimilated to mux with one source and one output */
+typedef enum RccClockMux {
+    /* Internal muxes that arent't exposed publicly to other peripherals */
+    RCC_CLOCK_MUX_SYSCLK,
+    RCC_CLOCK_MUX_PLL_INPUT,
+    RCC_CLOCK_MUX_HCLK,
+    RCC_CLOCK_MUX_PCLK1,
+    RCC_CLOCK_MUX_PCLK2,
+    RCC_CLOCK_MUX_HSE_OVER_32,
+    RCC_CLOCK_MUX_LCD_AND_RTC_COMMON,
+
+    /* Muxes with a publicly available output */
+    RCC_CLOCK_MUX_CORTEX_REFCLK,
+    RCC_CLOCK_MUX_USART1,
+    RCC_CLOCK_MUX_USART2,
+    RCC_CLOCK_MUX_USART3,
+    RCC_CLOCK_MUX_UART4,
+    RCC_CLOCK_MUX_UART5,
+    RCC_CLOCK_MUX_LPUART1,
+    RCC_CLOCK_MUX_I2C1,
+    RCC_CLOCK_MUX_I2C2,
+    RCC_CLOCK_MUX_I2C3,
+    RCC_CLOCK_MUX_LPTIM1,
+    RCC_CLOCK_MUX_LPTIM2,
+    RCC_CLOCK_MUX_SWPMI1,
+    RCC_CLOCK_MUX_MCO,
+    RCC_CLOCK_MUX_LSCO,
+    RCC_CLOCK_MUX_DFSDM1,
+    RCC_CLOCK_MUX_ADC,
+    RCC_CLOCK_MUX_CLK48,
+    RCC_CLOCK_MUX_SAI1,
+    RCC_CLOCK_MUX_SAI2,
+
+    /*
+     * Mux that have only one input and one output assigned to as peripheral.
+     * They could be direct lines but it is simpler
+     * to use the same logic for all outputs.
+     */
+    /* - AHB1 */
+    RCC_CLOCK_MUX_TSC,
+    RCC_CLOCK_MUX_CRC,
+    RCC_CLOCK_MUX_FLASH,
+    RCC_CLOCK_MUX_DMA2,
+    RCC_CLOCK_MUX_DMA1,
+
+    /* - AHB2 */
+    RCC_CLOCK_MUX_RNG,
+    RCC_CLOCK_MUX_AES,
+    RCC_CLOCK_MUX_OTGFS,
+    RCC_CLOCK_MUX_GPIOA,
+    RCC_CLOCK_MUX_GPIOB,
+    RCC_CLOCK_MUX_GPIOC,
+    RCC_CLOCK_MUX_GPIOD,
+    RCC_CLOCK_MUX_GPIOE,
+    RCC_CLOCK_MUX_GPIOF,
+    RCC_CLOCK_MUX_GPIOG,
+    RCC_CLOCK_MUX_GPIOH,
+
+    /* - AHB3 */
+    RCC_CLOCK_MUX_QSPI,
+    RCC_CLOCK_MUX_FMC,
+
+    /* - APB1 */
+    RCC_CLOCK_MUX_OPAMP,
+    RCC_CLOCK_MUX_DAC1,
+    RCC_CLOCK_MUX_PWR,
+    RCC_CLOCK_MUX_CAN1,
+    RCC_CLOCK_MUX_SPI3,
+    RCC_CLOCK_MUX_SPI2,
+    RCC_CLOCK_MUX_WWDG,
+    RCC_CLOCK_MUX_LCD,
+    RCC_CLOCK_MUX_TIM7,
+    RCC_CLOCK_MUX_TIM6,
+    RCC_CLOCK_MUX_TIM5,
+    RCC_CLOCK_MUX_TIM4,
+    RCC_CLOCK_MUX_TIM3,
+    RCC_CLOCK_MUX_TIM2,
+
+    /* - APB2 */
+    RCC_CLOCK_MUX_TIM17,
+    RCC_CLOCK_MUX_TIM16,
+    RCC_CLOCK_MUX_TIM15,
+    RCC_CLOCK_MUX_TIM8,
+    RCC_CLOCK_MUX_SPI1,
+    RCC_CLOCK_MUX_TIM1,
+    RCC_CLOCK_MUX_SDMMC1,
+    RCC_CLOCK_MUX_FW,
+    RCC_CLOCK_MUX_SYSCFG,
+
+    /* - BDCR */
+    RCC_CLOCK_MUX_RTC,
+
+    /* - OTHER */
+    RCC_CLOCK_MUX_CORTEX_FCLK,
+
+    RCC_NUM_CLOCK_MUX
+} RccClockMux;
+
+typedef struct RccClockMuxState {
+    DeviceState parent_obj;
+
+    RccClockMux id;
+    Clock *srcs[RCC_NUM_CLOCK_MUX_SRC];
+    Clock *out;
+    bool enabled;
+    uint32_t src;
+    uint32_t multiplier;
+    uint32_t divider;
+
+    /*
+     * Used by clock srcs update callback to retrieve both the clock and the
+     * source number.
+     */
+    struct RccClockMuxState *backref[RCC_NUM_CLOCK_MUX_SRC];
+} RccClockMuxState;
+
 struct Stm32l4x5RccState {
     SysBusDevice parent_obj;
 
@@ -71,6 +187,9 @@ struct Stm32l4x5RccState {
     Clock *sai1_extclk;
     Clock *sai2_extclk;
 
+    /* Muxes ~= outputs */
+    RccClockMuxState clock_muxes[RCC_NUM_CLOCK_MUX];
+
     qemu_irq irq;
     uint64_t hse_frequency;
     uint64_t sai1_extclk_frequency;
diff --git a/include/hw/misc/stm32l4x5_rcc_internals.h b/include/hw/misc/stm32l4x5_rcc_internals.h
index 331ea30db57..4aa836848b4 100644
--- a/include/hw/misc/stm32l4x5_rcc_internals.h
+++ b/include/hw/misc/stm32l4x5_rcc_internals.h
@@ -21,6 +21,8 @@
 #include "hw/registerfields.h"
 #include "hw/misc/stm32l4x5_rcc.h"
 
+#define TYPE_RCC_CLOCK_MUX "stm32l4x5-rcc-clock-mux"
+OBJECT_DECLARE_SIMPLE_TYPE(RccClockMuxState, RCC_CLOCK_MUX)
 
 /* Register map */
 REG32(CR, 0x00)
@@ -283,4 +285,31 @@ REG32(CSR, 0x94)
                             R_CSR_FWRSTF_MASK   | \
                             R_CSR_LSIRDY_MASK)
 
+typedef enum RccClockMuxSource {
+    RCC_CLOCK_MUX_SRC_GND = 0,
+    RCC_CLOCK_MUX_SRC_HSI,
+    RCC_CLOCK_MUX_SRC_HSE,
+    RCC_CLOCK_MUX_SRC_MSI,
+    RCC_CLOCK_MUX_SRC_LSI,
+    RCC_CLOCK_MUX_SRC_LSE,
+    RCC_CLOCK_MUX_SRC_SAI1_EXTCLK,
+    RCC_CLOCK_MUX_SRC_SAI2_EXTCLK,
+    RCC_CLOCK_MUX_SRC_PLL,
+    RCC_CLOCK_MUX_SRC_PLLSAI1,
+    RCC_CLOCK_MUX_SRC_PLLSAI2,
+    RCC_CLOCK_MUX_SRC_PLLSAI3,
+    RCC_CLOCK_MUX_SRC_PLL48M1,
+    RCC_CLOCK_MUX_SRC_PLL48M2,
+    RCC_CLOCK_MUX_SRC_PLLADC1,
+    RCC_CLOCK_MUX_SRC_PLLADC2,
+    RCC_CLOCK_MUX_SRC_SYSCLK,
+    RCC_CLOCK_MUX_SRC_HCLK,
+    RCC_CLOCK_MUX_SRC_PCLK1,
+    RCC_CLOCK_MUX_SRC_PCLK2,
+    RCC_CLOCK_MUX_SRC_HSE_OVER_32,
+    RCC_CLOCK_MUX_SRC_LCD_AND_RTC_COMMON,
+
+    RCC_CLOCK_MUX_SRC_NUMBER,
+} RccClockMuxSource;
+
 #endif /* HW_STM32L4X5_RCC_INTERNALS_H */
diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index 269e50b85a0..ace4083e837 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -36,6 +36,134 @@
 #define LSE_FRQ 32768ULL
 #define LSI_FRQ 32000ULL
 
+static void clock_mux_update(RccClockMuxState *mux)
+{
+    uint64_t src_freq;
+    Clock *current_source = mux->srcs[mux->src];
+    uint32_t freq_multiplier = 0;
+    /*
+     * To avoid rounding errors, we use the clock period instead of the
+     * frequency.
+     * This means that the multiplier of the mux becomes the divider of
+     * the clock and the divider of the mux becomes the multiplier of the
+     * clock.
+     */
+    if (mux->enabled && mux->divider) {
+        freq_multiplier = mux->divider;
+    }
+
+    clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier);
+    clock_update(mux->out, clock_get(current_source));
+
+    src_freq = clock_get_hz(current_source);
+    /* TODO: can we simply detect if the config changed so that we reduce log spam ? */
+    trace_stm32l4x5_rcc_mux_update(mux->id, mux->src, src_freq,
+                                   mux->multiplier, mux->divider);
+}
+
+static void clock_mux_src_update(void *opaque, ClockEvent event)
+{
+    RccClockMuxState **backref = opaque;
+    RccClockMuxState *s = *backref;
+    /*
+     * The backref value is equal to:
+     * s->backref + (sizeof(RccClockMuxState *) * update_src).
+     * By subtracting we can get back the index of the updated clock.
+     */
+    const uint32_t update_src = backref - s->backref;
+    /* Only update if the clock that was updated is the current source */
+    if (update_src == s->src) {
+        clock_mux_update(s);
+    }
+}
+
+static void clock_mux_init(Object *obj)
+{
+    RccClockMuxState *s = RCC_CLOCK_MUX(obj);
+    size_t i;
+
+    for (i = 0; i < RCC_NUM_CLOCK_MUX_SRC; i++) {
+        char *name = g_strdup_printf("srcs[%zu]", i);
+        s->backref[i] = s;
+        s->srcs[i] = qdev_init_clock_in(DEVICE(s), name,
+                                        clock_mux_src_update,
+                                        &s->backref[i],
+                                        ClockUpdate);
+        g_free(name);
+    }
+
+    s->out = qdev_init_clock_out(DEVICE(s), "out");
+}
+
+static void clock_mux_reset_hold(Object *obj)
+{ }
+
+static const VMStateDescription clock_mux_vmstate = {
+    .name = TYPE_RCC_CLOCK_MUX,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(id, RccClockMuxState),
+        VMSTATE_ARRAY_CLOCK(srcs, RccClockMuxState,
+                            RCC_NUM_CLOCK_MUX_SRC),
+        VMSTATE_BOOL(enabled, RccClockMuxState),
+        VMSTATE_UINT32(src, RccClockMuxState),
+        VMSTATE_UINT32(multiplier, RccClockMuxState),
+        VMSTATE_UINT32(divider, RccClockMuxState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void clock_mux_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = clock_mux_reset_hold;
+    dc->vmsd = &clock_mux_vmstate;
+}
+
+static void clock_mux_set_enable(RccClockMuxState *mux, bool enabled)
+{
+    if (mux->enabled == enabled) {
+        return;
+    }
+
+    if (enabled) {
+        trace_stm32l4x5_rcc_mux_enable(mux->id);
+    } else {
+        trace_stm32l4x5_rcc_mux_disable(mux->id);
+    }
+
+    mux->enabled = enabled;
+    clock_mux_update(mux);
+}
+
+static void clock_mux_set_factor(RccClockMuxState *mux,
+                                 uint32_t multiplier, uint32_t divider)
+{
+    if (mux->multiplier == multiplier && mux->divider == divider) {
+        return;
+    }
+    trace_stm32l4x5_rcc_mux_set_factor(mux->id,
+        mux->multiplier, multiplier, mux->divider, divider);
+
+    mux->multiplier = multiplier;
+    mux->divider = divider;
+    clock_mux_update(mux);
+}
+
+static void clock_mux_set_source(RccClockMuxState *mux, RccClockMuxSource src)
+{
+    if (mux->src == src) {
+        return;
+    }
+
+    trace_stm32l4x5_rcc_mux_set_src(mux->id, mux->src, src);
+    mux->src = src;
+    clock_mux_update(mux);
+}
+
 static void rcc_update_irq(Stm32l4x5RccState *s)
 {
     if (s->cifr & CIFR_IRQ_MASK) {
@@ -335,6 +463,7 @@ static const ClockPortInitArray stm32l4x5_rcc_clocks = {
 static void stm32l4x5_rcc_init(Object *obj)
 {
     Stm32l4x5RccState *s = STM32L4X5_RCC(obj);
+    size_t i;
 
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
 
@@ -344,6 +473,14 @@ static void stm32l4x5_rcc_init(Object *obj)
 
     qdev_init_clocks(DEVICE(s), stm32l4x5_rcc_clocks);
 
+    for (i = 0; i < RCC_NUM_CLOCK_MUX; i++) {
+
+        object_initialize_child(obj, "clock[*]",
+                                &s->clock_muxes[i],
+                                TYPE_RCC_CLOCK_MUX);
+
+    }
+
     s->gnd = clock_new(obj, "gnd");
 }
 
@@ -396,6 +533,7 @@ static const VMStateDescription vmstate_stm32l4x5_rcc = {
 static void stm32l4x5_rcc_realize(DeviceState *dev, Error **errp)
 {
     Stm32l4x5RccState *s = STM32L4X5_RCC(dev);
+    size_t i;
 
     if (s->hse_frequency <  4000000ULL ||
         s->hse_frequency > 48000000ULL) {
@@ -405,10 +543,26 @@ static void stm32l4x5_rcc_realize(DeviceState *dev, Error **errp)
             return;
         }
 
+    for (i = 0; i < RCC_NUM_CLOCK_MUX; i++) {
+        RccClockMuxState *clock_mux = &s->clock_muxes[i];
+
+        if (!qdev_realize(DEVICE(clock_mux), NULL, errp)) {
+            return;
+        }
+    }
+
     clock_update_hz(s->msi_rc, MSI_DEFAULT_FRQ);
     clock_update_hz(s->sai1_extclk, s->sai1_extclk_frequency);
     clock_update_hz(s->sai2_extclk, s->sai2_extclk_frequency);
     clock_update(s->gnd, 0);
+
+    /*
+     * Dummy values to make compilation pass.
+     * Removed in later commits.
+     */
+    clock_mux_set_source(&s->clock_muxes[0], RCC_CLOCK_MUX_SRC_GND);
+    clock_mux_set_enable(&s->clock_muxes[0], true);
+    clock_mux_set_factor(&s->clock_muxes[0], 1, 1);
 }
 
 static Property stm32l4x5_rcc_properties[] = {
@@ -440,6 +594,12 @@ static const TypeInfo stm32l4x5_rcc_types[] = {
         .instance_size  = sizeof(Stm32l4x5RccState),
         .instance_init  = stm32l4x5_rcc_init,
         .class_init     = stm32l4x5_rcc_class_init,
+    }, {
+        .name = TYPE_RCC_CLOCK_MUX,
+        .parent = TYPE_DEVICE,
+        .instance_size = sizeof(RccClockMuxState),
+        .instance_init = clock_mux_init,
+        .class_init = clock_mux_class_init,
     }
 };
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 38169ccbc10..4b97641475b 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -177,6 +177,11 @@ stm32l4x5_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64
 # stm32l4x5_rcc.c
 stm32l4x5_rcc_read(uint64_t addr, uint32_t data) "RCC: Read <0x%" PRIx64 "> -> 0x%" PRIx32
 stm32l4x5_rcc_write(uint64_t addr, uint32_t data) "RCC: Write <0x%" PRIx64 "> <- 0x%" PRIx32
+stm32l4x5_rcc_mux_enable(uint32_t mux_id) "RCC: Mux %d enabled"
+stm32l4x5_rcc_mux_disable(uint32_t mux_id) "RCC: Mux %d disabled"
+stm32l4x5_rcc_mux_set_factor(uint32_t mux_id, uint32_t old_multiplier, uint32_t new_multiplier, uint32_t old_divider, uint32_t new_divider) "RCC: Mux %d factor changed: multiplier (%u -> %u), divider (%u -> %u)"
+stm32l4x5_rcc_mux_set_src(uint32_t mux_id, uint32_t old_src, uint32_t new_src) "RCC: Mux %d source changed: from %u to %u"
+stm32l4x5_rcc_mux_update(uint32_t mux_id, uint32_t src, uint64_t src_freq, uint32_t multiplier, uint32_t divider) "RCC: Mux %d src %d update: src_freq %" PRIu64 " multiplier %" PRIu32 " divider %" PRIu32
 
 # tz-mpc.c
 tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs read: offset 0x%x data 0x%" PRIx64 " size %u"
-- 
2.34.1


