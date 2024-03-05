Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AB3C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVEo-0001V2-LV; Tue, 05 Mar 2024 08:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDv-0000wD-4s
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:56 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDo-0005xd-6k
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:50 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33e1878e357so2773883f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646762; x=1710251562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dpO++rSHH7rGO28AplCu9nZCf5+X/352HOhoAKdjtuM=;
 b=q3HMeF3SLTKlGrMa/3LfvMl6GoJ/IrvE6pyFVlgvMih16sVroOz4R3dF+KCyU9xcBN
 vFHT02P6am0shzyQpDQpDifhLpoB54xikbUX29GfDquD3ZWM0H3EuJrZ3BuomReszrRn
 X1sQnlWfoCPKMoCu7UTCi0MsGTjrLRhK3q1ArYhhSGXqFtuV412esUq4NrRYA7ZUASA0
 OP+QLS8eay+Vc+eMtMQobpx6LdFAoWZDrSkP89iwE/SiaVgA1arFq+CklhuSLBgFf9le
 qzG2YKmN/XaRcX3177a2xMfd+g1jwFLFmcH0iuQXS4e9J2E+PUbBEd/Lr9dJQ/8bf/ZY
 4Z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646762; x=1710251562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dpO++rSHH7rGO28AplCu9nZCf5+X/352HOhoAKdjtuM=;
 b=pY67WKfKVxuf5zli5CawNq23DB5kbKA6pnVrdqbe+T6UM+e5O5eQKU49Z0kueSwpsi
 eiUqcO9CMuNdvXijgez9vyAUx4TfGwsvCls0Yr0MyPZjdfiBdcPvdojhSMa7nA8zR3LM
 HymdnYp1cGiOMAY8jCsM7T2Aja9T1PmGf5wUh/tUP/IwmIV520s/ibgHnHYo9EHrgqPv
 aHAJFCMsQWaupujeBdRbjQBxQiI1XPZq8TdwCGIh63/rL2zSuHx1IUiJz7bPZTfJjIX0
 vfOMBVTHj580e9kXei9CbpKlgJNxWqNKwAYay/fKc29Cn361L3tTspXdVXa7Jc44s77P
 Hfug==
X-Gm-Message-State: AOJu0YyaAApiQLpmepGCTkw8MNIcpgFCx6gS5cFdX6anfc8n/5z8vyi1
 0/q1j3W8QaYV5QPPeTW3cSrx7qITvFv/GZdu6mYs9VcTE+bmvS3LVvWP786kf9mIKFIO6HfI1Qw
 b
X-Google-Smtp-Source: AGHT+IE0GdRVrS1xqqvUPxWignENzOo7m1hTdDz7M+BCJLYMiyB+FSAC/r33mYCUXdjdejUy/nCx9g==
X-Received: by 2002:adf:e74a:0:b0:33d:3665:666f with SMTP id
 c10-20020adfe74a000000b0033d3665666fmr8444550wrn.44.1709646762552; 
 Tue, 05 Mar 2024 05:52:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/20] hw/misc/stm32l4x5_rcc: Add an internal PLL Clock object
Date: Tue,  5 Mar 2024 13:52:24 +0000
Message-Id: <20240305135237.3111642-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

This object represents the PLLs and their channels. The PLLs allow for a
more fine-grained control of the clocks frequency.

The migration handling is based on hw/misc/zynq_sclr.c.
Three phase reset will be handled in a later commit.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240303140643.81957-4-arnaud.minier@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/stm32l4x5_rcc.h           |  40 +++++
 include/hw/misc/stm32l4x5_rcc_internals.h |  22 +++
 hw/misc/stm32l4x5_rcc.c                   | 176 ++++++++++++++++++++++
 hw/misc/trace-events                      |   5 +
 4 files changed, 243 insertions(+)

diff --git a/include/hw/misc/stm32l4x5_rcc.h b/include/hw/misc/stm32l4x5_rcc.h
index 6719be9fbee..0fbfba5c40b 100644
--- a/include/hw/misc/stm32l4x5_rcc.h
+++ b/include/hw/misc/stm32l4x5_rcc.h
@@ -26,6 +26,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5RccState, STM32L4X5_RCC)
 
 /* In the Stm32l4x5 clock tree, mux have at most 7 sources */
 #define RCC_NUM_CLOCK_MUX_SRC 7
+
+typedef enum PllCommonChannels {
+    RCC_PLL_COMMON_CHANNEL_P = 0,
+    RCC_PLL_COMMON_CHANNEL_Q = 1,
+    RCC_PLL_COMMON_CHANNEL_R = 2,
+
+    RCC_NUM_CHANNEL_PLL_OUT = 3
+} PllCommonChannels;
+
 /* NB: Prescaler are assimilated to mux with one source and one output */
 typedef enum RccClockMux {
     /* Internal muxes that arent't exposed publicly to other peripherals */
@@ -124,6 +133,14 @@ typedef enum RccClockMux {
     RCC_NUM_CLOCK_MUX
 } RccClockMux;
 
+typedef enum RccPll {
+    RCC_PLL_PLL,
+    RCC_PLL_PLLSAI1,
+    RCC_PLL_PLLSAI2,
+
+    RCC_NUM_PLL
+} RccPll;
+
 typedef struct RccClockMuxState {
     DeviceState parent_obj;
 
@@ -142,6 +159,26 @@ typedef struct RccClockMuxState {
     struct RccClockMuxState *backref[RCC_NUM_CLOCK_MUX_SRC];
 } RccClockMuxState;
 
+typedef struct RccPllState {
+    DeviceState parent_obj;
+
+    RccPll id;
+    Clock *in;
+    uint32_t vco_multiplier;
+    Clock *channels[RCC_NUM_CHANNEL_PLL_OUT];
+    /* Global pll enabled flag */
+    bool enabled;
+    /* 'enabled' refers to the runtime configuration */
+    bool channel_enabled[RCC_NUM_CHANNEL_PLL_OUT];
+    /*
+     * 'exists' refers to the physical configuration
+     * It should only be set at pll initialization.
+     * e.g. pllsai2 doesn't have a Q output.
+     */
+    bool channel_exists[RCC_NUM_CHANNEL_PLL_OUT];
+    uint32_t channel_divider[RCC_NUM_CHANNEL_PLL_OUT];
+} RccPllState;
+
 struct Stm32l4x5RccState {
     SysBusDevice parent_obj;
 
@@ -187,6 +224,9 @@ struct Stm32l4x5RccState {
     Clock *sai1_extclk;
     Clock *sai2_extclk;
 
+    /* PLLs */
+    RccPllState plls[RCC_NUM_PLL];
+
     /* Muxes ~= outputs */
     RccClockMuxState clock_muxes[RCC_NUM_CLOCK_MUX];
 
diff --git a/include/hw/misc/stm32l4x5_rcc_internals.h b/include/hw/misc/stm32l4x5_rcc_internals.h
index 4aa836848b4..a9da5e3be7d 100644
--- a/include/hw/misc/stm32l4x5_rcc_internals.h
+++ b/include/hw/misc/stm32l4x5_rcc_internals.h
@@ -22,7 +22,10 @@
 #include "hw/misc/stm32l4x5_rcc.h"
 
 #define TYPE_RCC_CLOCK_MUX "stm32l4x5-rcc-clock-mux"
+#define TYPE_RCC_PLL "stm32l4x5-rcc-pll"
+
 OBJECT_DECLARE_SIMPLE_TYPE(RccClockMuxState, RCC_CLOCK_MUX)
+OBJECT_DECLARE_SIMPLE_TYPE(RccPllState, RCC_PLL)
 
 /* Register map */
 REG32(CR, 0x00)
@@ -285,6 +288,25 @@ REG32(CSR, 0x94)
                             R_CSR_FWRSTF_MASK   | \
                             R_CSR_LSIRDY_MASK)
 
+/* Pll Channels */
+enum PllChannels {
+    RCC_PLL_CHANNEL_PLLSAI3CLK = 0,
+    RCC_PLL_CHANNEL_PLL48M1CLK = 1,
+    RCC_PLL_CHANNEL_PLLCLK = 2,
+};
+
+enum PllSai1Channels {
+    RCC_PLLSAI1_CHANNEL_PLLSAI1CLK = 0,
+    RCC_PLLSAI1_CHANNEL_PLL48M2CLK = 1,
+    RCC_PLLSAI1_CHANNEL_PLLADC1CLK = 2,
+};
+
+enum PllSai2Channels {
+    RCC_PLLSAI2_CHANNEL_PLLSAI2CLK = 0,
+    /* No Q channel */
+    RCC_PLLSAI2_CHANNEL_PLLADC2CLK = 2,
+};
+
 typedef enum RccClockMuxSource {
     RCC_CLOCK_MUX_SRC_GND = 0,
     RCC_CLOCK_MUX_SRC_HSI,
diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index ace4083e837..9a9ea6c4702 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -164,6 +164,157 @@ static void clock_mux_set_source(RccClockMuxState *mux, RccClockMuxSource src)
     clock_mux_update(mux);
 }
 
+static void pll_update(RccPllState *pll)
+{
+    uint64_t vco_freq, old_channel_freq, channel_freq;
+    int i;
+
+    /* The common PLLM factor is handled by the PLL mux */
+    vco_freq = muldiv64(clock_get_hz(pll->in), pll->vco_multiplier, 1);
+
+    for (i = 0; i < RCC_NUM_CHANNEL_PLL_OUT; i++) {
+        if (!pll->channel_exists[i]) {
+            continue;
+        }
+
+        old_channel_freq = clock_get_hz(pll->channels[i]);
+        if (!pll->enabled ||
+            !pll->channel_enabled[i] ||
+            !pll->channel_divider[i]) {
+            channel_freq = 0;
+        } else {
+            channel_freq = muldiv64(vco_freq,
+                                    1,
+                                    pll->channel_divider[i]);
+        }
+
+        /* No change, early continue to avoid log spam and useless propagation */
+        if (old_channel_freq == channel_freq) {
+            continue;
+        }
+
+        clock_update_hz(pll->channels[i], channel_freq);
+        trace_stm32l4x5_rcc_pll_update(pll->id, i, vco_freq,
+            old_channel_freq, channel_freq);
+    }
+}
+
+static void pll_src_update(void *opaque, ClockEvent event)
+{
+    RccPllState *s = opaque;
+    pll_update(s);
+}
+
+static void pll_init(Object *obj)
+{
+    RccPllState *s = RCC_PLL(obj);
+    size_t i;
+
+    s->in = qdev_init_clock_in(DEVICE(s), "in",
+                               pll_src_update, s, ClockUpdate);
+
+    const char *names[] = {
+        "out-p", "out-q", "out-r",
+    };
+
+    for (i = 0; i < RCC_NUM_CHANNEL_PLL_OUT; i++) {
+        s->channels[i] = qdev_init_clock_out(DEVICE(s), names[i]);
+    }
+}
+
+static void pll_reset_hold(Object *obj)
+{ }
+
+static const VMStateDescription pll_vmstate = {
+    .name = TYPE_RCC_PLL,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(id, RccPllState),
+        VMSTATE_CLOCK(in, RccPllState),
+        VMSTATE_ARRAY_CLOCK(channels, RccPllState,
+                            RCC_NUM_CHANNEL_PLL_OUT),
+        VMSTATE_BOOL(enabled, RccPllState),
+        VMSTATE_UINT32(vco_multiplier, RccPllState),
+        VMSTATE_BOOL_ARRAY(channel_enabled, RccPllState, RCC_NUM_CHANNEL_PLL_OUT),
+        VMSTATE_BOOL_ARRAY(channel_exists, RccPllState, RCC_NUM_CHANNEL_PLL_OUT),
+        VMSTATE_UINT32_ARRAY(channel_divider, RccPllState, RCC_NUM_CHANNEL_PLL_OUT),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void pll_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = pll_reset_hold;
+    dc->vmsd = &pll_vmstate;
+}
+
+static void pll_set_vco_multiplier(RccPllState *pll, uint32_t vco_multiplier)
+{
+    if (pll->vco_multiplier == vco_multiplier) {
+        return;
+    }
+
+    if (vco_multiplier < 8 || vco_multiplier > 86) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "%s: VCO multiplier is out of bound (%u) for PLL %u\n",
+            __func__, vco_multiplier, pll->id);
+        return;
+    }
+
+    trace_stm32l4x5_rcc_pll_set_vco_multiplier(pll->id,
+        pll->vco_multiplier, vco_multiplier);
+
+    pll->vco_multiplier = vco_multiplier;
+    pll_update(pll);
+}
+
+static void pll_set_enable(RccPllState *pll, bool enabled)
+{
+    if (pll->enabled == enabled) {
+        return;
+    }
+
+    pll->enabled = enabled;
+    pll_update(pll);
+}
+
+static void pll_set_channel_enable(RccPllState *pll,
+                                   PllCommonChannels channel,
+                                   bool enabled)
+{
+    if (pll->channel_enabled[channel] == enabled) {
+        return;
+    }
+
+    if (enabled) {
+        trace_stm32l4x5_rcc_pll_channel_enable(pll->id, channel);
+    } else {
+        trace_stm32l4x5_rcc_pll_channel_disable(pll->id, channel);
+    }
+
+    pll->channel_enabled[channel] = enabled;
+    pll_update(pll);
+}
+
+static void pll_set_channel_divider(RccPllState *pll,
+                                    PllCommonChannels channel,
+                                    uint32_t divider)
+{
+    if (pll->channel_divider[channel] == divider) {
+        return;
+    }
+
+    trace_stm32l4x5_rcc_pll_set_channel_divider(pll->id,
+        channel, pll->channel_divider[channel], divider);
+
+    pll->channel_divider[channel] = divider;
+    pll_update(pll);
+}
+
 static void rcc_update_irq(Stm32l4x5RccState *s)
 {
     if (s->cifr & CIFR_IRQ_MASK) {
@@ -473,6 +624,11 @@ static void stm32l4x5_rcc_init(Object *obj)
 
     qdev_init_clocks(DEVICE(s), stm32l4x5_rcc_clocks);
 
+    for (i = 0; i < RCC_NUM_PLL; i++) {
+        object_initialize_child(obj, "pll[*]",
+                                &s->plls[i], TYPE_RCC_PLL);
+    }
+
     for (i = 0; i < RCC_NUM_CLOCK_MUX; i++) {
 
         object_initialize_child(obj, "clock[*]",
@@ -543,6 +699,16 @@ static void stm32l4x5_rcc_realize(DeviceState *dev, Error **errp)
             return;
         }
 
+    for (i = 0; i < RCC_NUM_PLL; i++) {
+        RccPllState *pll = &s->plls[i];
+
+        clock_set_source(pll->in, s->clock_muxes[RCC_CLOCK_MUX_PLL_INPUT].out);
+
+        if (!qdev_realize(DEVICE(pll), NULL, errp)) {
+            return;
+        }
+    }
+
     for (i = 0; i < RCC_NUM_CLOCK_MUX; i++) {
         RccClockMuxState *clock_mux = &s->clock_muxes[i];
 
@@ -563,6 +729,10 @@ static void stm32l4x5_rcc_realize(DeviceState *dev, Error **errp)
     clock_mux_set_source(&s->clock_muxes[0], RCC_CLOCK_MUX_SRC_GND);
     clock_mux_set_enable(&s->clock_muxes[0], true);
     clock_mux_set_factor(&s->clock_muxes[0], 1, 1);
+    pll_set_channel_divider(&s->plls[0], 0, 1);
+    pll_set_enable(&s->plls[0], true);
+    pll_set_channel_enable(&s->plls[0], 0, true);
+    pll_set_vco_multiplier(&s->plls[0], 1);
 }
 
 static Property stm32l4x5_rcc_properties[] = {
@@ -600,6 +770,12 @@ static const TypeInfo stm32l4x5_rcc_types[] = {
         .instance_size = sizeof(RccClockMuxState),
         .instance_init = clock_mux_init,
         .class_init = clock_mux_class_init,
+    }, {
+        .name = TYPE_RCC_PLL,
+        .parent = TYPE_DEVICE,
+        .instance_size = sizeof(RccPllState),
+        .instance_init = pll_init,
+        .class_init = pll_class_init,
     }
 };
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 4b97641475b..7cab1d5cb50 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -182,6 +182,11 @@ stm32l4x5_rcc_mux_disable(uint32_t mux_id) "RCC: Mux %d disabled"
 stm32l4x5_rcc_mux_set_factor(uint32_t mux_id, uint32_t old_multiplier, uint32_t new_multiplier, uint32_t old_divider, uint32_t new_divider) "RCC: Mux %d factor changed: multiplier (%u -> %u), divider (%u -> %u)"
 stm32l4x5_rcc_mux_set_src(uint32_t mux_id, uint32_t old_src, uint32_t new_src) "RCC: Mux %d source changed: from %u to %u"
 stm32l4x5_rcc_mux_update(uint32_t mux_id, uint32_t src, uint64_t src_freq, uint32_t multiplier, uint32_t divider) "RCC: Mux %d src %d update: src_freq %" PRIu64 " multiplier %" PRIu32 " divider %" PRIu32
+stm32l4x5_rcc_pll_set_vco_multiplier(uint32_t pll_id, uint32_t old_multiplier, uint32_t new_multiplier) "RCC: PLL %u: vco_multiplier changed (%u -> %u)"
+stm32l4x5_rcc_pll_channel_enable(uint32_t pll_id, uint32_t channel_id) "RCC: PLL %u, channel %u enabled"
+stm32l4x5_rcc_pll_channel_disable(uint32_t pll_id, uint32_t channel_id) "RCC: PLL %u, channel %u disabled"
+stm32l4x5_rcc_pll_set_channel_divider(uint32_t pll_id, uint32_t channel_id, uint32_t old_divider, uint32_t new_divider) "RCC: PLL %u, channel %u: divider changed (%u -> %u)"
+stm32l4x5_rcc_pll_update(uint32_t pll_id, uint32_t channel_id, uint64_t vco_freq, uint64_t old_freq, uint64_t new_freq) "RCC: PLL %d channel %d update: vco_freq %" PRIu64 " old_freq %" PRIu64 " new_freq %" PRIu64
 
 # tz-mpc.c
 tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs read: offset 0x%x data 0x%" PRIx64 " size %u"
-- 
2.34.1


