Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CFAC48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 20:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcA24-0005Cw-15; Mon, 19 Feb 2024 15:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rcA21-0005C8-0i; Mon, 19 Feb 2024 15:14:29 -0500
Received: from zproxy1.enst.fr ([137.194.2.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rcA1w-0005cq-RY; Mon, 19 Feb 2024 15:14:28 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 4BE87C059F;
 Mon, 19 Feb 2024 21:14:22 +0100 (CET)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id GgB5YceL3coz; Mon, 19 Feb 2024 21:14:21 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 5B7E2C0597;
 Mon, 19 Feb 2024 21:14:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr 5B7E2C0597
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1708373661;
 bh=Yqjs/on0dwAwenAhg4q9HmjNDZFQcBpYG2V6tDI5TqQ=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=rfDptJhMhzxB83Xmr9iK5fifqWVtV85UNg7yU1MIfZZdW8bUINikU+r1JKW1ve7hX
 fErOkmz7LH1fcA/wriTTbVZOZ9G7KUF0vy+jPxSq2t2KEBYU0xVTwwYIqu9hwqKQPh
 +vgfX3rkrgzTgfXoOFlE+XTlWHPDQRIC3sowiSeQ=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id lLwZiNpWZhQ5; Mon, 19 Feb 2024 21:14:21 +0100 (CET)
Received: from AM-Inspiron-3585.. (cust-west-par-46-193-4-103.cust.wifirst.net
 [46.193.4.103])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id A0C03C05B3;
 Mon, 19 Feb 2024 21:14:20 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>
Subject: [PATCH v5 4/8] Add initialization information for PLLs and clock
 multiplexers
Date: Mon, 19 Feb 2024 21:09:04 +0100
Message-Id: <20240219200908.49551-5-arnaud.minier@telecom-paris.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219200908.49551-1-arnaud.minier@telecom-paris.fr>
References: <20240219200908.49551-1-arnaud.minier@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.220;
 envelope-from=arnaud.minier@telecom-paris.fr; helo=zproxy1.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Instanciate the whole clock tree and using the Clock multiplexers and
the PLLs defined in the previous commits. This allows to statically
define the clock tree and easily follow the clock signal from one end to
another.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/misc/stm32l4x5_rcc.c                   |  81 ++-
 include/hw/misc/stm32l4x5_rcc_internals.h | 705 ++++++++++++++++++++++
 2 files changed, 782 insertions(+), 4 deletions(-)

diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index f461b9dd8d..4ffb8a209a 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -93,7 +93,11 @@ static void clock_mux_init(Object *obj)
 }
=20
 static void clock_mux_reset_hold(Object *obj)
-{ }
+{
+    RccClockMuxState *s =3D RCC_CLOCK_MUX(obj);
+    set_clock_mux_init_info(s, s->id);
+    clock_mux_update(s);
+}
=20
 static const VMStateDescription clock_mux_vmstate =3D {
     .name =3D TYPE_RCC_CLOCK_MUX,
@@ -221,7 +225,11 @@ static void pll_init(Object *obj)
 }
=20
 static void pll_reset_hold(Object *obj)
-{ }
+{
+    RccPllState *s =3D RCC_PLL(obj);
+    set_pll_init_info(s, s->id);
+    pll_update(s);
+}
=20
 static const VMStateDescription pll_vmstate =3D {
     .name =3D TYPE_RCC_PLL,
@@ -617,21 +625,79 @@ static void stm32l4x5_rcc_init(Object *obj)
     qdev_init_clocks(DEVICE(s), stm32l4x5_rcc_clocks);
=20
     for (i =3D 0; i < RCC_NUM_PLL; i++) {
-        object_initialize_child(obj, "pll[*]",
+        object_initialize_child(obj, PLL_INIT_INFO[i].name,
                                 &s->plls[i], TYPE_RCC_PLL);
+        set_pll_init_info(&s->plls[i], i);
     }
=20
     for (i =3D 0; i < RCC_NUM_CLOCK_MUX; i++) {
+        char *alias;
=20
-        object_initialize_child(obj, "clock[*]",
+        object_initialize_child(obj, CLOCK_MUX_INIT_INFO[i].name,
                                 &s->clock_muxes[i],
                                 TYPE_RCC_CLOCK_MUX);
+        set_clock_mux_init_info(&s->clock_muxes[i], i);
=20
+        if (!CLOCK_MUX_INIT_INFO[i].hidden) {
+            /* Expose muxes output as RCC outputs */
+            alias =3D g_strdup_printf("%s-out", CLOCK_MUX_INIT_INFO[i].n=
ame);
+            qdev_alias_clock(DEVICE(&s->clock_muxes[i]), "out", DEVICE(o=
bj), alias);
+            g_free(alias);
+        }
     }
=20
     s->gnd =3D clock_new(obj, "gnd");
 }
=20
+static void connect_mux_sources(Stm32l4x5RccState *s,
+                                RccClockMuxState *mux,
+                                const RccClockMuxSource *clk_mapping)
+{
+    size_t i;
+
+    Clock * const CLK_SRC_MAPPING[] =3D {
+        [RCC_CLOCK_MUX_SRC_GND] =3D s->gnd,
+        [RCC_CLOCK_MUX_SRC_HSI] =3D s->hsi16_rc,
+        [RCC_CLOCK_MUX_SRC_HSE] =3D s->hse,
+        [RCC_CLOCK_MUX_SRC_MSI] =3D s->msi_rc,
+        [RCC_CLOCK_MUX_SRC_LSI] =3D s->lsi_rc,
+        [RCC_CLOCK_MUX_SRC_LSE] =3D s->lse_crystal,
+        [RCC_CLOCK_MUX_SRC_SAI1_EXTCLK] =3D s->sai1_extclk,
+        [RCC_CLOCK_MUX_SRC_SAI2_EXTCLK] =3D s->sai2_extclk,
+        [RCC_CLOCK_MUX_SRC_PLL] =3D
+            s->plls[RCC_PLL_PLL].channels[RCC_PLL_CHANNEL_PLLCLK],
+        [RCC_CLOCK_MUX_SRC_PLLSAI1] =3D
+            s->plls[RCC_PLL_PLLSAI1].channels[RCC_PLLSAI1_CHANNEL_PLLSAI=
1CLK],
+        [RCC_CLOCK_MUX_SRC_PLLSAI2] =3D
+            s->plls[RCC_PLL_PLLSAI2].channels[RCC_PLLSAI2_CHANNEL_PLLSAI=
2CLK],
+        [RCC_CLOCK_MUX_SRC_PLLSAI3] =3D
+            s->plls[RCC_PLL_PLL].channels[RCC_PLL_CHANNEL_PLLSAI3CLK],
+        [RCC_CLOCK_MUX_SRC_PLL48M1] =3D
+            s->plls[RCC_PLL_PLL].channels[RCC_PLL_CHANNEL_PLL48M1CLK],
+        [RCC_CLOCK_MUX_SRC_PLL48M2] =3D
+            s->plls[RCC_PLL_PLLSAI1].channels[RCC_PLLSAI1_CHANNEL_PLL48M=
2CLK],
+        [RCC_CLOCK_MUX_SRC_PLLADC1] =3D
+            s->plls[RCC_PLL_PLLSAI1].channels[RCC_PLLSAI1_CHANNEL_PLLADC=
1CLK],
+        [RCC_CLOCK_MUX_SRC_PLLADC2] =3D
+            s->plls[RCC_PLL_PLLSAI2] .channels[RCC_PLLSAI2_CHANNEL_PLLAD=
C2CLK],
+        [RCC_CLOCK_MUX_SRC_SYSCLK] =3D s->clock_muxes[RCC_CLOCK_MUX_SYSC=
LK].out,
+        [RCC_CLOCK_MUX_SRC_HCLK] =3D s->clock_muxes[RCC_CLOCK_MUX_HCLK].=
out,
+        [RCC_CLOCK_MUX_SRC_PCLK1] =3D s->clock_muxes[RCC_CLOCK_MUX_PCLK1=
].out,
+        [RCC_CLOCK_MUX_SRC_PCLK2] =3D s->clock_muxes[RCC_CLOCK_MUX_PCLK2=
].out,
+        [RCC_CLOCK_MUX_SRC_HSE_OVER_32] =3D s->clock_muxes[RCC_CLOCK_MUX=
_HSE_OVER_32].out,
+        [RCC_CLOCK_MUX_SRC_LCD_AND_RTC_COMMON] =3D
+            s->clock_muxes[RCC_CLOCK_MUX_LCD_AND_RTC_COMMON].out,
+    };
+
+    assert(ARRAY_SIZE(CLK_SRC_MAPPING) =3D=3D RCC_CLOCK_MUX_SRC_NUMBER);
+
+    for (i =3D 0; i < RCC_NUM_CLOCK_MUX_SRC; i++) {
+        RccClockMuxSource mapping =3D clk_mapping[i];
+        clock_set_source(mux->srcs[i], CLK_SRC_MAPPING[mapping]);
+    }
+}
+
+
 static const VMStateDescription vmstate_stm32l4x5_rcc =3D {
     .name =3D TYPE_STM32L4X5_RCC,
     .version_id =3D 1,
@@ -697,11 +763,17 @@ static void stm32l4x5_rcc_realize(DeviceState *dev,=
 Error **errp)
     for (i =3D 0; i < RCC_NUM_CLOCK_MUX; i++) {
         RccClockMuxState *clock_mux =3D &s->clock_muxes[i];
=20
+        connect_mux_sources(s, clock_mux, CLOCK_MUX_INIT_INFO[i].src_map=
ping);
+
         if (!qdev_realize(DEVICE(clock_mux), NULL, errp)) {
             return;
         }
     }
=20
+    /*
+     * Start clocks after everything is connected
+     * to propagate the frequencies along the tree.
+     */
     clock_update_hz(s->msi_rc, MSI_DEFAULT_FRQ);
     clock_update_hz(s->sai1_extclk, s->sai1_extclk_frequency);
     clock_update_hz(s->sai2_extclk, s->sai2_extclk_frequency);
@@ -735,6 +807,7 @@ static void stm32l4x5_rcc_class_init(ObjectClass *kla=
ss, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     ResettableClass *rc =3D RESETTABLE_CLASS(klass);
=20
+    assert(ARRAY_SIZE(CLOCK_MUX_INIT_INFO) =3D=3D RCC_NUM_CLOCK_MUX);
=20
     rc->phases.hold =3D stm32l4x5_rcc_reset_hold;
     device_class_set_props(dc, stm32l4x5_rcc_properties);
diff --git a/include/hw/misc/stm32l4x5_rcc_internals.h b/include/hw/misc/=
stm32l4x5_rcc_internals.h
index a9da5e3be7..ff1c834f69 100644
--- a/include/hw/misc/stm32l4x5_rcc_internals.h
+++ b/include/hw/misc/stm32l4x5_rcc_internals.h
@@ -334,4 +334,709 @@ typedef enum RccClockMuxSource {
     RCC_CLOCK_MUX_SRC_NUMBER,
 } RccClockMuxSource;
=20
+/* PLL init info */
+typedef struct PllInitInfo {
+    const char *name;
+
+    const char *channel_name[RCC_NUM_CHANNEL_PLL_OUT];
+    bool channel_exists[RCC_NUM_CHANNEL_PLL_OUT];
+    uint32_t default_channel_divider[RCC_NUM_CHANNEL_PLL_OUT];
+
+    RccClockMuxSource src_mapping[RCC_NUM_CLOCK_MUX_SRC];
+} PllInitInfo;
+
+static const PllInitInfo PLL_INIT_INFO[] =3D {
+    [RCC_PLL_PLL] =3D {
+        .name =3D "pll",
+        .channel_name =3D {
+            "pllsai3clk",
+            "pll48m1clk",
+            "pllclk"
+        },
+        .channel_exists =3D {
+            true, true, true
+        },
+        /* From PLLCFGR register documentation */
+        .default_channel_divider =3D {
+            7, 2, 2
+        }
+    },
+    [RCC_PLL_PLLSAI1] =3D {
+        .name =3D "pllsai1",
+        .channel_name =3D {
+            "pllsai1clk",
+            "pll48m2clk",
+            "plladc1clk"
+        },
+        .channel_exists =3D {
+            true, true, true
+        },
+        /* From PLLSAI1CFGR register documentation */
+        .default_channel_divider =3D {
+            7, 2, 2
+        }
+    },
+    [RCC_PLL_PLLSAI2] =3D {
+        .name =3D "pllsai2",
+        .channel_name =3D {
+            "pllsai2clk",
+            NULL,
+            "plladc2clk"
+        },
+        .channel_exists =3D {
+            true, false, true
+        },
+        /* From PLLSAI2CFGR register documentation */
+        .default_channel_divider =3D {
+            7, 0, 2
+        }
+    }
+};
+
+static inline void set_pll_init_info(RccPllState *pll,
+                                     RccPll id)
+{
+    int i;
+
+    pll->id =3D id;
+    pll->vco_multiplier =3D 1;
+    for (i =3D 0; i < RCC_NUM_CHANNEL_PLL_OUT; i++) {
+        pll->channel_enabled[i] =3D false;
+        pll->channel_exists[i] =3D PLL_INIT_INFO[id].channel_exists[i];
+        pll->channel_divider[i] =3D PLL_INIT_INFO[id].default_channel_di=
vider[i];
+    }
+}
+
+/* Clock mux init info */
+typedef struct ClockMuxInitInfo {
+    const char *name;
+
+    uint32_t multiplier;
+    uint32_t divider;
+    bool enabled;
+    /* If this is true, the clock will not be exposed outside of the dev=
ice */
+    bool hidden;
+
+    RccClockMuxSource src_mapping[RCC_NUM_CLOCK_MUX_SRC];
+} ClockMuxInitInfo;
+
+#define FILL_DEFAULT_FACTOR \
+    .multiplier =3D 1, \
+    .divider =3D  1
+
+#define FILL_DEFAULT_INIT_ENABLED \
+    FILL_DEFAULT_FACTOR, \
+    .enabled =3D true
+
+#define FILL_DEFAULT_INIT_DISABLED \
+    FILL_DEFAULT_FACTOR, \
+    .enabled =3D false
+
+
+static const ClockMuxInitInfo CLOCK_MUX_INIT_INFO[] =3D {
+    [RCC_CLOCK_MUX_SYSCLK] =3D {
+        .name =3D "sysclk",
+        /* Same mapping as: CFGR_SW */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_MSI,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_HSE,
+            RCC_CLOCK_MUX_SRC_PLL,
+        },
+        .hidden =3D true,
+        FILL_DEFAULT_INIT_ENABLED,
+    },
+    [RCC_CLOCK_MUX_PLL_INPUT] =3D {
+        .name =3D "pll-input",
+        /* Same mapping as: PLLCFGR_PLLSRC */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_MSI,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_HSE,
+        },
+        .hidden =3D true,
+        FILL_DEFAULT_INIT_ENABLED,
+    },
+    [RCC_CLOCK_MUX_HCLK] =3D {
+        .name =3D "hclk",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        .hidden =3D true,
+        FILL_DEFAULT_INIT_ENABLED,
+    },
+    [RCC_CLOCK_MUX_PCLK1] =3D {
+        .name =3D "pclk1",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_HCLK,
+        },
+        .hidden =3D true,
+        FILL_DEFAULT_INIT_ENABLED,
+    },
+    [RCC_CLOCK_MUX_PCLK2] =3D {
+        .name =3D "pclk2",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_HCLK,
+        },
+        .hidden =3D true,
+        FILL_DEFAULT_INIT_ENABLED,
+    },
+    [RCC_CLOCK_MUX_HSE_OVER_32] =3D {
+        .name =3D "hse-divided-by-32",
+        .multiplier =3D 1,
+        .divider =3D 32,
+        .enabled =3D true,
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_HSE,
+        },
+        .hidden =3D true,
+    },
+    [RCC_CLOCK_MUX_LCD_AND_RTC_COMMON] =3D {
+        .name =3D "lcd-and-rtc-common-mux",
+        /* Same mapping as: BDCR_RTCSEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_GND,
+            RCC_CLOCK_MUX_SRC_LSE,
+            RCC_CLOCK_MUX_SRC_LSI,
+            RCC_CLOCK_MUX_SRC_HSE_OVER_32,
+        },
+        .hidden =3D true,
+        FILL_DEFAULT_INIT_ENABLED,
+    },
+    /* From now on, muxes with a publicly available output */
+    [RCC_CLOCK_MUX_CORTEX_REFCLK] =3D {
+        .name =3D "cortex-refclk",
+        .multiplier =3D 1,
+        /* REFCLK is always HCLK/8 */
+        .divider =3D 8,
+        .enabled =3D true,
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_HCLK,
+        }
+    },
+    [RCC_CLOCK_MUX_USART1] =3D {
+        .name =3D "usart1",
+        /* Same mapping as: CCIPR_USART1SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_USART2] =3D {
+        .name =3D "usart2",
+        /* Same mapping as: CCIPR_USART2SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_USART3] =3D {
+        .name =3D "usart3",
+        /* Same mapping as: CCIPR_USART3SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_UART4] =3D {
+        .name =3D "uart4",
+        /* Same mapping as: CCIPR_UART4SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_UART5] =3D {
+        .name =3D "uart5",
+        /* Same mapping as: CCIPR_UART5SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_LPUART1] =3D {
+        .name =3D "lpuart1",
+        /* Same mapping as: CCIPR_LPUART1SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_I2C1] =3D {
+        .name =3D "i2c1",
+        /* Same mapping as: CCIPR_I2C1SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_I2C2] =3D {
+        .name =3D "i2c2",
+        /* Same mapping as: CCIPR_I2C2SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_I2C3] =3D {
+        .name =3D "i2c3",
+        /* Same mapping as: CCIPR_I2C3SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_LPTIM1] =3D {
+        .name =3D "lptim1",
+        /* Same mapping as: CCIPR_LPTIM1SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_LSI,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_LPTIM2] =3D {
+        .name =3D "lptim2",
+        /* Same mapping as: CCIPR_LPTIM2SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_LSI,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SWPMI1] =3D {
+        .name =3D "swpmi1",
+        /* Same mapping as: CCIPR_SWPMI1SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_HSI,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_MCO] =3D {
+        .name =3D "mco",
+        /* Same mapping as: CFGR_MCOSEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_MSI,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_HSE,
+            RCC_CLOCK_MUX_SRC_PLL,
+            RCC_CLOCK_MUX_SRC_LSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_LSCO] =3D {
+        .name =3D "lsco",
+        /* Same mapping as: BDCR_LSCOSEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_LSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_DFSDM1] =3D {
+        .name =3D "dfsdm1",
+        /* Same mapping as: CCIPR_DFSDM1SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_ADC] =3D {
+        .name =3D "adc",
+        /* Same mapping as: CCIPR_ADCSEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_GND,
+            RCC_CLOCK_MUX_SRC_PLLADC1,
+            RCC_CLOCK_MUX_SRC_PLLADC2,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_CLK48] =3D {
+        .name =3D "clk48",
+        /* Same mapping as: CCIPR_CLK48SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_GND,
+            RCC_CLOCK_MUX_SRC_PLL48M2,
+            RCC_CLOCK_MUX_SRC_PLL48M1,
+            RCC_CLOCK_MUX_SRC_MSI,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SAI2] =3D {
+        .name =3D "sai2",
+        /* Same mapping as: CCIPR_SAI2SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PLLSAI1,
+            RCC_CLOCK_MUX_SRC_PLLSAI2,
+            RCC_CLOCK_MUX_SRC_PLLSAI3,
+            RCC_CLOCK_MUX_SRC_SAI2_EXTCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SAI1] =3D {
+        .name =3D "sai1",
+        /* Same mapping as: CCIPR_SAI1SEL */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PLLSAI1,
+            RCC_CLOCK_MUX_SRC_PLLSAI2,
+            RCC_CLOCK_MUX_SRC_PLLSAI3,
+            RCC_CLOCK_MUX_SRC_SAI1_EXTCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    /* From now on, these muxes only have one valid source */
+    [RCC_CLOCK_MUX_TSC] =3D {
+        .name =3D "tsc",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_CRC] =3D {
+        .name =3D "crc",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_FLASH] =3D {
+        .name =3D "flash",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_DMA2] =3D {
+        .name =3D "dma2",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_DMA1] =3D {
+        .name =3D "dma1",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_RNG] =3D {
+        .name =3D "rng",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_AES] =3D {
+        .name =3D "aes",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_OTGFS] =3D {
+        .name =3D "otgfs",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOA] =3D {
+        .name =3D "gpioa",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOB] =3D {
+        .name =3D "gpiob",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOC] =3D {
+        .name =3D "gpioc",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOD] =3D {
+        .name =3D "gpiod",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOE] =3D {
+        .name =3D "gpioe",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOF] =3D {
+        .name =3D "gpiof",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOG] =3D {
+        .name =3D "gpiog",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOH] =3D {
+        .name =3D "gpioh",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_QSPI] =3D {
+        .name =3D "qspi",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_FMC] =3D {
+        .name =3D "fmc",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_OPAMP] =3D {
+        .name =3D "opamp",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_DAC1] =3D {
+        .name =3D "dac1",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_PWR] =3D {
+        .name =3D "pwr",
+        /*
+         * PWREN is in the APB1ENR1 register,
+         * but PWR uses SYSCLK according to the clock tree.
+         */
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_CAN1] =3D {
+        .name =3D "can1",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SPI3] =3D {
+        .name =3D "spi3",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SPI2] =3D {
+        .name =3D "spi2",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_WWDG] =3D {
+        .name =3D "wwdg",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_LCD] =3D {
+        .name =3D "lcd",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_LCD_AND_RTC_COMMON,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM7] =3D {
+        .name =3D "tim7",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM6] =3D {
+        .name =3D "tim6",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM5] =3D {
+        .name =3D "tim5",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM4] =3D {
+        .name =3D "tim4",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM3] =3D {
+        .name =3D "tim3",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM2] =3D {
+        .name =3D "tim2",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM17] =3D {
+        .name =3D "tim17",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM16] =3D {
+        .name =3D "tim16",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM15] =3D {
+        .name =3D "tim15",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM8] =3D {
+        .name =3D "tim8",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SPI1] =3D {
+        .name =3D "spi1",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM1] =3D {
+        .name =3D "tim1",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SDMMC1] =3D {
+        .name =3D "sdmmc1",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_FW] =3D {
+        .name =3D "fw",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SYSCFG] =3D {
+        .name =3D "syscfg",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_RTC] =3D {
+        .name =3D "rtc",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_LCD_AND_RTC_COMMON,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_CORTEX_FCLK] =3D {
+        .name =3D "cortex-fclk",
+        .src_mapping =3D {
+            RCC_CLOCK_MUX_SRC_HCLK,
+        },
+        FILL_DEFAULT_INIT_ENABLED,
+    },
+};
+
+static inline void set_clock_mux_init_info(RccClockMuxState *mux,
+                                           RccClockMux id)
+{
+    mux->id =3D id;
+    mux->multiplier =3D CLOCK_MUX_INIT_INFO[id].multiplier;
+    mux->divider =3D CLOCK_MUX_INIT_INFO[id].divider;
+    mux->enabled =3D CLOCK_MUX_INIT_INFO[id].enabled;
+    /*
+     * Every peripheral has the first source of their source list as
+     * as their default source.
+     */
+    mux->src =3D 0;
+}
+
 #endif /* HW_STM32L4X5_RCC_INTERNALS_H */
--=20
2.34.1


