Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4248C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 20:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcA0y-0004Ov-3G; Mon, 19 Feb 2024 15:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rcA0u-0004OU-B6; Mon, 19 Feb 2024 15:13:20 -0500
Received: from zproxy2.enst.fr ([137.194.2.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rcA0q-0005Ga-TX; Mon, 19 Feb 2024 15:13:19 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 233958059B;
 Mon, 19 Feb 2024 21:13:15 +0100 (CET)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id sVY8ESeNKMt3; Mon, 19 Feb 2024 21:13:14 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 2DDD8805B5;
 Mon, 19 Feb 2024 21:13:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr 2DDD8805B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1708373594;
 bh=vAfG+IW74g0J1PuQWK9i4zFhY6trOAY6kEQQ7cQQr5o=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=R1zFW9p/2lj1LZwKfv51xpIpxjdB+41pXYSDKsVA7i/asC/MyVYIjbO7TFNnnvNx3
 5r3WyRsmhQCx2oMDEadmjFfIW+o4SqKYhMesZIHZzBRe7mNNJXOuZv+72LPf5SgR/U
 4SQ5VGhQNmBUNMH3lJ21TEW61BNZT2LCLCaUlT7U=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id RTjWff_fAU4R; Mon, 19 Feb 2024 21:13:14 +0100 (CET)
Received: from AM-Inspiron-3585.. (cust-west-par-46-193-4-103.cust.wifirst.net
 [46.193.4.103])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id 91A2E8059B;
 Mon, 19 Feb 2024 21:13:13 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>
Subject: [PATCH v5 3/8] Add an internal PLL Clock object
Date: Mon, 19 Feb 2024 21:09:03 +0100
Message-Id: <20240219200908.49551-4-arnaud.minier@telecom-paris.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219200908.49551-1-arnaud.minier@telecom-paris.fr>
References: <20240219200908.49551-1-arnaud.minier@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.221;
 envelope-from=arnaud.minier@telecom-paris.fr; helo=zproxy2.enst.fr
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

This object represents the PLLs and their channels. The PLLs allow for a
more fine-grained control of the clocks frequency.

Wasn't sure about how to handle the reset and the migration so used the
same appproach as the BCM2835 CPRMAN.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/misc/stm32l4x5_rcc.c                   | 176 ++++++++++++++++++++++
 hw/misc/trace-events                      |   5 +
 include/hw/misc/stm32l4x5_rcc.h           |  40 +++++
 include/hw/misc/stm32l4x5_rcc_internals.h |  22 +++
 4 files changed, 243 insertions(+)

diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index ed10832f88..f461b9dd8d 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -162,6 +162,157 @@ static void clock_mux_set_source(RccClockMuxState *=
mux, RccClockMuxSource src)
     clock_mux_update(mux);
 }
=20
+static void pll_update(RccPllState *pll)
+{
+    uint64_t vco_freq, old_channel_freq, channel_freq;
+    int i;
+
+    /* The common PLLM factor is handled by the PLL mux */
+    vco_freq =3D muldiv64(clock_get_hz(pll->in), pll->vco_multiplier, 1)=
;
+
+    for (i =3D 0; i < RCC_NUM_CHANNEL_PLL_OUT; i++) {
+        if (!pll->channel_exists[i]) {
+            continue;
+        }
+
+        old_channel_freq =3D clock_get_hz(pll->channels[i]);
+        if (!pll->enabled ||
+            !pll->channel_enabled[i] ||
+            !pll->channel_divider[i]) {
+            channel_freq =3D 0;
+        } else {
+            channel_freq =3D muldiv64(vco_freq,
+                                    1,
+                                    pll->channel_divider[i]);
+        }
+
+        /* No change, early continue to avoid log spam and useless propa=
gation */
+        if (old_channel_freq =3D=3D channel_freq) {
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
+    RccPllState *s =3D opaque;
+    pll_update(s);
+}
+
+static void pll_init(Object *obj)
+{
+    RccPllState *s =3D RCC_PLL(obj);
+    size_t i;
+
+    s->in =3D qdev_init_clock_in(DEVICE(s), "in",
+                               pll_src_update, s, ClockUpdate);
+
+    const char *names[] =3D {
+        "out-p", "out-q", "out-r",
+    };
+
+    for (i =3D 0; i < RCC_NUM_CHANNEL_PLL_OUT; i++) {
+        s->channels[i] =3D qdev_init_clock_out(DEVICE(s), names[i]);
+    }
+}
+
+static void pll_reset_hold(Object *obj)
+{ }
+
+static const VMStateDescription pll_vmstate =3D {
+    .name =3D TYPE_RCC_PLL,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(id, RccPllState),
+        VMSTATE_CLOCK(in, RccPllState),
+        VMSTATE_ARRAY_CLOCK(channels, RccPllState,
+                            RCC_NUM_CHANNEL_PLL_OUT),
+        VMSTATE_BOOL(enabled, RccPllState),
+        VMSTATE_UINT32(vco_multiplier, RccPllState),
+        VMSTATE_BOOL_ARRAY(channel_enabled, RccPllState, RCC_NUM_CHANNEL=
_PLL_OUT),
+        VMSTATE_BOOL_ARRAY(channel_exists, RccPllState, RCC_NUM_CHANNEL_=
PLL_OUT),
+        VMSTATE_UINT32_ARRAY(channel_divider, RccPllState, RCC_NUM_CHANN=
EL_PLL_OUT),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void pll_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+
+    rc->phases.hold =3D pll_reset_hold;
+    dc->vmsd =3D &pll_vmstate;
+}
+
+static void pll_set_vco_multiplier(RccPllState *pll, uint32_t vco_multip=
lier)
+{
+    if (pll->vco_multiplier =3D=3D vco_multiplier) {
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
+    pll->vco_multiplier =3D vco_multiplier;
+    pll_update(pll);
+}
+
+static void pll_set_enable(RccPllState *pll, bool enabled)
+{
+    if (pll->enabled =3D=3D enabled) {
+        return;
+    }
+
+    pll->enabled =3D enabled;
+    pll_update(pll);
+}
+
+static void pll_set_channel_enable(RccPllState *pll,
+                                   PllCommonChannels channel,
+                                   bool enabled)
+{
+    if (pll->channel_enabled[channel] =3D=3D enabled) {
+        return;
+    }
+
+    if (enabled) {
+        trace_stm32l4x5_rcc_pll_channel_enable(pll->id, channel);
+    } else {
+        trace_stm32l4x5_rcc_pll_channel_disable(pll->id, channel);
+    }
+
+    pll->channel_enabled[channel] =3D enabled;
+    pll_update(pll);
+}
+
+static void pll_set_channel_divider(RccPllState *pll,
+                                    PllCommonChannels channel,
+                                    uint32_t divider)
+{
+    if (pll->channel_divider[channel] =3D=3D divider) {
+        return;
+    }
+
+    trace_stm32l4x5_rcc_pll_set_channel_divider(pll->id,
+        channel, pll->channel_divider[channel], divider);
+
+    pll->channel_divider[channel] =3D divider;
+    pll_update(pll);
+}
+
 static void rcc_update_irq(Stm32l4x5RccState *s)
 {
     if (s->cifr & CIFR_IRQ_MASK) {
@@ -465,6 +616,11 @@ static void stm32l4x5_rcc_init(Object *obj)
=20
     qdev_init_clocks(DEVICE(s), stm32l4x5_rcc_clocks);
=20
+    for (i =3D 0; i < RCC_NUM_PLL; i++) {
+        object_initialize_child(obj, "pll[*]",
+                                &s->plls[i], TYPE_RCC_PLL);
+    }
+
     for (i =3D 0; i < RCC_NUM_CLOCK_MUX; i++) {
=20
         object_initialize_child(obj, "clock[*]",
@@ -528,6 +684,16 @@ static void stm32l4x5_rcc_realize(DeviceState *dev, =
Error **errp)
             return;
         }
=20
+    for (i =3D 0; i < RCC_NUM_PLL; i++) {
+        RccPllState *pll =3D &s->plls[i];
+
+        clock_set_source(pll->in, s->clock_muxes[RCC_CLOCK_MUX_PLL_INPUT=
].out);
+
+        if (!qdev_realize(DEVICE(pll), NULL, errp)) {
+            return;
+        }
+    }
+
     for (i =3D 0; i < RCC_NUM_CLOCK_MUX; i++) {
         RccClockMuxState *clock_mux =3D &s->clock_muxes[i];
=20
@@ -548,6 +714,10 @@ static void stm32l4x5_rcc_realize(DeviceState *dev, =
Error **errp)
     clock_mux_set_source(&s->clock_muxes[0], RCC_CLOCK_MUX_SRC_GND);
     clock_mux_set_enable(&s->clock_muxes[0], true);
     clock_mux_set_factor(&s->clock_muxes[0], 1, 1);
+    pll_set_channel_divider(&s->plls[0], 0, 1);
+    pll_set_enable(&s->plls[0], true);
+    pll_set_channel_enable(&s->plls[0], 0, true);
+    pll_set_vco_multiplier(&s->plls[0], 1);
 }
=20
 static Property stm32l4x5_rcc_properties[] =3D {
@@ -585,6 +755,12 @@ static const TypeInfo stm32l4x5_rcc_types[] =3D {
         .instance_size =3D sizeof(RccClockMuxState),
         .instance_init =3D clock_mux_init,
         .class_init =3D clock_mux_class_init,
+    }, {
+        .name =3D TYPE_RCC_PLL,
+        .parent =3D TYPE_DEVICE,
+        .instance_size =3D sizeof(RccPllState),
+        .instance_init =3D pll_init,
+        .class_init =3D pll_class_init,
     }
 };
=20
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index d5e471811c..1b6054d88a 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -182,6 +182,11 @@ stm32l4x5_rcc_mux_disable(uint32_t mux_id) "RCC: Mux=
 %d disabled"
 stm32l4x5_rcc_mux_set_factor(uint32_t mux_id, uint32_t old_multiplier, u=
int32_t new_multiplier, uint32_t old_divider, uint32_t new_divider) "RCC:=
 Mux %d factor changed: multiplier (%u -> %u), divider (%u -> %u)"
 stm32l4x5_rcc_mux_set_src(uint32_t mux_id, uint32_t old_src, uint32_t ne=
w_src) "RCC: Mux %d source changed: from %u to %u"
 stm32l4x5_rcc_mux_update(uint32_t mux_id, uint32_t src, uint64_t src_fre=
q, uint64_t new_freq) "RCC: Mux %d src %d update: src_freq %" PRIu64 " ne=
w_freq %" PRIu64 ""
+stm32l4x5_rcc_pll_set_vco_multiplier(uint32_t pll_id, uint32_t old_multi=
plier, uint32_t new_multiplier) "RCC: PLL %u: vco_multiplier changed (%u =
-> %u)"
+stm32l4x5_rcc_pll_channel_enable(uint32_t pll_id, uint32_t channel_id) "=
RCC: PLL %u, channel %u enabled"
+stm32l4x5_rcc_pll_channel_disable(uint32_t pll_id, uint32_t channel_id) =
"RCC: PLL %u, channel %u disabled"
+stm32l4x5_rcc_pll_set_channel_divider(uint32_t pll_id, uint32_t channel_=
id, uint32_t old_divider, uint32_t new_divider) "RCC: PLL %u, channel %u:=
 divider changed (%u -> %u)"
+stm32l4x5_rcc_pll_update(uint32_t pll_id, uint32_t channel_id, uint64_t =
vco_freq, uint64_t old_freq, uint64_t new_freq) "RCC: PLL %d channel %d u=
pdate: vco_freq %" PRIu64 " old_freq %" PRIu64 " new_freq %" PRIu64 ""
=20
 # tz-mpc.c
 tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC r=
egs read: offset 0x%x data 0x%" PRIx64 " size %u"
diff --git a/include/hw/misc/stm32l4x5_rcc.h b/include/hw/misc/stm32l4x5_=
rcc.h
index 6719be9fbe..0fbfba5c40 100644
--- a/include/hw/misc/stm32l4x5_rcc.h
+++ b/include/hw/misc/stm32l4x5_rcc.h
@@ -26,6 +26,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5RccState, STM32L4X=
5_RCC)
=20
 /* In the Stm32l4x5 clock tree, mux have at most 7 sources */
 #define RCC_NUM_CLOCK_MUX_SRC 7
+
+typedef enum PllCommonChannels {
+    RCC_PLL_COMMON_CHANNEL_P =3D 0,
+    RCC_PLL_COMMON_CHANNEL_Q =3D 1,
+    RCC_PLL_COMMON_CHANNEL_R =3D 2,
+
+    RCC_NUM_CHANNEL_PLL_OUT =3D 3
+} PllCommonChannels;
+
 /* NB: Prescaler are assimilated to mux with one source and one output *=
/
 typedef enum RccClockMux {
     /* Internal muxes that arent't exposed publicly to other peripherals=
 */
@@ -124,6 +133,14 @@ typedef enum RccClockMux {
     RCC_NUM_CLOCK_MUX
 } RccClockMux;
=20
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
=20
@@ -142,6 +159,26 @@ typedef struct RccClockMuxState {
     struct RccClockMuxState *backref[RCC_NUM_CLOCK_MUX_SRC];
 } RccClockMuxState;
=20
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
=20
@@ -187,6 +224,9 @@ struct Stm32l4x5RccState {
     Clock *sai1_extclk;
     Clock *sai2_extclk;
=20
+    /* PLLs */
+    RccPllState plls[RCC_NUM_PLL];
+
     /* Muxes ~=3D outputs */
     RccClockMuxState clock_muxes[RCC_NUM_CLOCK_MUX];
=20
diff --git a/include/hw/misc/stm32l4x5_rcc_internals.h b/include/hw/misc/=
stm32l4x5_rcc_internals.h
index 4aa836848b..a9da5e3be7 100644
--- a/include/hw/misc/stm32l4x5_rcc_internals.h
+++ b/include/hw/misc/stm32l4x5_rcc_internals.h
@@ -22,7 +22,10 @@
 #include "hw/misc/stm32l4x5_rcc.h"
=20
 #define TYPE_RCC_CLOCK_MUX "stm32l4x5-rcc-clock-mux"
+#define TYPE_RCC_PLL "stm32l4x5-rcc-pll"
+
 OBJECT_DECLARE_SIMPLE_TYPE(RccClockMuxState, RCC_CLOCK_MUX)
+OBJECT_DECLARE_SIMPLE_TYPE(RccPllState, RCC_PLL)
=20
 /* Register map */
 REG32(CR, 0x00)
@@ -285,6 +288,25 @@ REG32(CSR, 0x94)
                             R_CSR_FWRSTF_MASK   | \
                             R_CSR_LSIRDY_MASK)
=20
+/* Pll Channels */
+enum PllChannels {
+    RCC_PLL_CHANNEL_PLLSAI3CLK =3D 0,
+    RCC_PLL_CHANNEL_PLL48M1CLK =3D 1,
+    RCC_PLL_CHANNEL_PLLCLK =3D 2,
+};
+
+enum PllSai1Channels {
+    RCC_PLLSAI1_CHANNEL_PLLSAI1CLK =3D 0,
+    RCC_PLLSAI1_CHANNEL_PLL48M2CLK =3D 1,
+    RCC_PLLSAI1_CHANNEL_PLLADC1CLK =3D 2,
+};
+
+enum PllSai2Channels {
+    RCC_PLLSAI2_CHANNEL_PLLSAI2CLK =3D 0,
+    /* No Q channel */
+    RCC_PLLSAI2_CHANNEL_PLLADC2CLK =3D 2,
+};
+
 typedef enum RccClockMuxSource {
     RCC_CLOCK_MUX_SRC_GND =3D 0,
     RCC_CLOCK_MUX_SRC_HSI,
--=20
2.34.1


