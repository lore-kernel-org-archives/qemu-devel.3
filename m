Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDC6C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVEd-0001Da-DR; Tue, 05 Mar 2024 08:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDw-0000wW-4U
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:06 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDo-0005xj-H5
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:51 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412eddd165eso3687465e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646763; x=1710251563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gMBLxtLg8vmsf4UwKbR23mOVuBgWsMOaKSlUcHfsDKo=;
 b=wfEjN5Jsq7J97yO4VXHJcaHlF+nE2afdw7KxaR/TaS3cBksDo7ihLY9z+jbhk+oD3p
 RUK1I6nP30nZKpbzSJEILp7YnssUHibKBrPzNFpv+Z4Bj8TL4eqUkVRDIqJNYzPYG/jZ
 Cadr5buz7R2BA0qki8DeTSjNn8Bd/gKacnCDem7rRIl5iqzv2wAmkeFXJCgt45iwiSns
 W5Ffs0/Kr6IbNmyDgHDb13MaDy+LRCgfNcQlz9gx6mCc2upnMEoCo7QyDV2Yu92RU77W
 dFQsnePt8PMT+T/jr/pRUySZktrCbLKP96ocLwv/mm+6bWXaviO+NLfKug1BEHOEFP8i
 kQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646763; x=1710251563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMBLxtLg8vmsf4UwKbR23mOVuBgWsMOaKSlUcHfsDKo=;
 b=UJYiIPKMgPFg7edrAp5uuShuEBhTrZsU0gSsZLw5il2mKpAMoff5JEEhFozkdPzebc
 Z0AXwgjtxBn+YOCcSrfn8LKZUTiSXsHMFETAfQ7Opo6ekABCfEO4jPTgje+jfVmTwIrl
 ZVxWArYdLDOgNxFtUh0yvrFDWsm+GIyx3vGsruQKwSeHYth7TNJuGCdRakgbPgoh/p/X
 bxJx6j4eqeEdCI5pFZpMhCfVrRg6F0Wu2K6madKP4EVs38OxYteJcK698C0kGAwOmvty
 mFByrJgizYoooMUihLyFLrvpxLb9T5OjiZJcYW2fKnRRK57Oo9Y69sI3XRgmP71S07LZ
 3aLw==
X-Gm-Message-State: AOJu0YztXPnB1bVJRJRd08286hbdf9zos5P/DhNaDG9MDC7XJ11Pg2da
 r0pueIrFYsY4M0QE7qAnIR/mPYVlNxiJZBJsbq/KYu9P+2NF3tNsMMqNsfJXCYaSio5eor5qbvE
 W
X-Google-Smtp-Source: AGHT+IGphrgq89+B7LP9rJ9fXgRQceF6zhJFKABo/evjdsHdhrNFibZdXg6vD8vqrG9dK2TtOJnFEg==
X-Received: by 2002:a5d:60cb:0:b0:33d:d791:1164 with SMTP id
 x11-20020a5d60cb000000b0033dd7911164mr11186432wrt.8.1709646763020; 
 Tue, 05 Mar 2024 05:52:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/20] hw/misc/stm32l4x5_rcc: Initialize PLLs and clock
 multiplexers
Date: Tue,  5 Mar 2024 13:52:25 +0000
Message-Id: <20240305135237.3111642-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Instantiate the whole clock tree and using the Clock multiplexers and
the PLLs defined in the previous commits. This allows to statically
define the clock tree and easily follow the clock signal from one end to
another.

Also handle three-phase reset now that we have defined a known base
state for every object.
(Reset handling based on hw/misc/zynq_sclr.c)

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240303140643.81957-5-arnaud.minier@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/stm32l4x5_rcc_internals.h | 705 ++++++++++++++++++++++
 hw/misc/stm32l4x5_rcc.c                   | 145 ++++-
 2 files changed, 833 insertions(+), 17 deletions(-)

diff --git a/include/hw/misc/stm32l4x5_rcc_internals.h b/include/hw/misc/stm32l4x5_rcc_internals.h
index a9da5e3be7d..ff1c834f694 100644
--- a/include/hw/misc/stm32l4x5_rcc_internals.h
+++ b/include/hw/misc/stm32l4x5_rcc_internals.h
@@ -334,4 +334,709 @@ typedef enum RccClockMuxSource {
     RCC_CLOCK_MUX_SRC_NUMBER,
 } RccClockMuxSource;
 
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
+static const PllInitInfo PLL_INIT_INFO[] = {
+    [RCC_PLL_PLL] = {
+        .name = "pll",
+        .channel_name = {
+            "pllsai3clk",
+            "pll48m1clk",
+            "pllclk"
+        },
+        .channel_exists = {
+            true, true, true
+        },
+        /* From PLLCFGR register documentation */
+        .default_channel_divider = {
+            7, 2, 2
+        }
+    },
+    [RCC_PLL_PLLSAI1] = {
+        .name = "pllsai1",
+        .channel_name = {
+            "pllsai1clk",
+            "pll48m2clk",
+            "plladc1clk"
+        },
+        .channel_exists = {
+            true, true, true
+        },
+        /* From PLLSAI1CFGR register documentation */
+        .default_channel_divider = {
+            7, 2, 2
+        }
+    },
+    [RCC_PLL_PLLSAI2] = {
+        .name = "pllsai2",
+        .channel_name = {
+            "pllsai2clk",
+            NULL,
+            "plladc2clk"
+        },
+        .channel_exists = {
+            true, false, true
+        },
+        /* From PLLSAI2CFGR register documentation */
+        .default_channel_divider = {
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
+    pll->id = id;
+    pll->vco_multiplier = 1;
+    for (i = 0; i < RCC_NUM_CHANNEL_PLL_OUT; i++) {
+        pll->channel_enabled[i] = false;
+        pll->channel_exists[i] = PLL_INIT_INFO[id].channel_exists[i];
+        pll->channel_divider[i] = PLL_INIT_INFO[id].default_channel_divider[i];
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
+    /* If this is true, the clock will not be exposed outside of the device */
+    bool hidden;
+
+    RccClockMuxSource src_mapping[RCC_NUM_CLOCK_MUX_SRC];
+} ClockMuxInitInfo;
+
+#define FILL_DEFAULT_FACTOR \
+    .multiplier = 1, \
+    .divider =  1
+
+#define FILL_DEFAULT_INIT_ENABLED \
+    FILL_DEFAULT_FACTOR, \
+    .enabled = true
+
+#define FILL_DEFAULT_INIT_DISABLED \
+    FILL_DEFAULT_FACTOR, \
+    .enabled = false
+
+
+static const ClockMuxInitInfo CLOCK_MUX_INIT_INFO[] = {
+    [RCC_CLOCK_MUX_SYSCLK] = {
+        .name = "sysclk",
+        /* Same mapping as: CFGR_SW */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_MSI,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_HSE,
+            RCC_CLOCK_MUX_SRC_PLL,
+        },
+        .hidden = true,
+        FILL_DEFAULT_INIT_ENABLED,
+    },
+    [RCC_CLOCK_MUX_PLL_INPUT] = {
+        .name = "pll-input",
+        /* Same mapping as: PLLCFGR_PLLSRC */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_MSI,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_HSE,
+        },
+        .hidden = true,
+        FILL_DEFAULT_INIT_ENABLED,
+    },
+    [RCC_CLOCK_MUX_HCLK] = {
+        .name = "hclk",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        .hidden = true,
+        FILL_DEFAULT_INIT_ENABLED,
+    },
+    [RCC_CLOCK_MUX_PCLK1] = {
+        .name = "pclk1",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_HCLK,
+        },
+        .hidden = true,
+        FILL_DEFAULT_INIT_ENABLED,
+    },
+    [RCC_CLOCK_MUX_PCLK2] = {
+        .name = "pclk2",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_HCLK,
+        },
+        .hidden = true,
+        FILL_DEFAULT_INIT_ENABLED,
+    },
+    [RCC_CLOCK_MUX_HSE_OVER_32] = {
+        .name = "hse-divided-by-32",
+        .multiplier = 1,
+        .divider = 32,
+        .enabled = true,
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_HSE,
+        },
+        .hidden = true,
+    },
+    [RCC_CLOCK_MUX_LCD_AND_RTC_COMMON] = {
+        .name = "lcd-and-rtc-common-mux",
+        /* Same mapping as: BDCR_RTCSEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_GND,
+            RCC_CLOCK_MUX_SRC_LSE,
+            RCC_CLOCK_MUX_SRC_LSI,
+            RCC_CLOCK_MUX_SRC_HSE_OVER_32,
+        },
+        .hidden = true,
+        FILL_DEFAULT_INIT_ENABLED,
+    },
+    /* From now on, muxes with a publicly available output */
+    [RCC_CLOCK_MUX_CORTEX_REFCLK] = {
+        .name = "cortex-refclk",
+        .multiplier = 1,
+        /* REFCLK is always HCLK/8 */
+        .divider = 8,
+        .enabled = true,
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_HCLK,
+        }
+    },
+    [RCC_CLOCK_MUX_USART1] = {
+        .name = "usart1",
+        /* Same mapping as: CCIPR_USART1SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_USART2] = {
+        .name = "usart2",
+        /* Same mapping as: CCIPR_USART2SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_USART3] = {
+        .name = "usart3",
+        /* Same mapping as: CCIPR_USART3SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_UART4] = {
+        .name = "uart4",
+        /* Same mapping as: CCIPR_UART4SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_UART5] = {
+        .name = "uart5",
+        /* Same mapping as: CCIPR_UART5SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_LPUART1] = {
+        .name = "lpuart1",
+        /* Same mapping as: CCIPR_LPUART1SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_I2C1] = {
+        .name = "i2c1",
+        /* Same mapping as: CCIPR_I2C1SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_I2C2] = {
+        .name = "i2c2",
+        /* Same mapping as: CCIPR_I2C2SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_I2C3] = {
+        .name = "i2c3",
+        /* Same mapping as: CCIPR_I2C3SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+            RCC_CLOCK_MUX_SRC_HSI,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_LPTIM1] = {
+        .name = "lptim1",
+        /* Same mapping as: CCIPR_LPTIM1SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_LSI,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_LPTIM2] = {
+        .name = "lptim2",
+        /* Same mapping as: CCIPR_LPTIM2SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_LSI,
+            RCC_CLOCK_MUX_SRC_HSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SWPMI1] = {
+        .name = "swpmi1",
+        /* Same mapping as: CCIPR_SWPMI1SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+            RCC_CLOCK_MUX_SRC_HSI,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_MCO] = {
+        .name = "mco",
+        /* Same mapping as: CFGR_MCOSEL */
+        .src_mapping = {
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
+    [RCC_CLOCK_MUX_LSCO] = {
+        .name = "lsco",
+        /* Same mapping as: BDCR_LSCOSEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_LSI,
+            RCC_CLOCK_MUX_SRC_LSE,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_DFSDM1] = {
+        .name = "dfsdm1",
+        /* Same mapping as: CCIPR_DFSDM1SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_ADC] = {
+        .name = "adc",
+        /* Same mapping as: CCIPR_ADCSEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_GND,
+            RCC_CLOCK_MUX_SRC_PLLADC1,
+            RCC_CLOCK_MUX_SRC_PLLADC2,
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_CLK48] = {
+        .name = "clk48",
+        /* Same mapping as: CCIPR_CLK48SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_GND,
+            RCC_CLOCK_MUX_SRC_PLL48M2,
+            RCC_CLOCK_MUX_SRC_PLL48M1,
+            RCC_CLOCK_MUX_SRC_MSI,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SAI2] = {
+        .name = "sai2",
+        /* Same mapping as: CCIPR_SAI2SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PLLSAI1,
+            RCC_CLOCK_MUX_SRC_PLLSAI2,
+            RCC_CLOCK_MUX_SRC_PLLSAI3,
+            RCC_CLOCK_MUX_SRC_SAI2_EXTCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SAI1] = {
+        .name = "sai1",
+        /* Same mapping as: CCIPR_SAI1SEL */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PLLSAI1,
+            RCC_CLOCK_MUX_SRC_PLLSAI2,
+            RCC_CLOCK_MUX_SRC_PLLSAI3,
+            RCC_CLOCK_MUX_SRC_SAI1_EXTCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    /* From now on, these muxes only have one valid source */
+    [RCC_CLOCK_MUX_TSC] = {
+        .name = "tsc",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_CRC] = {
+        .name = "crc",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_FLASH] = {
+        .name = "flash",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_DMA2] = {
+        .name = "dma2",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_DMA1] = {
+        .name = "dma1",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_RNG] = {
+        .name = "rng",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_AES] = {
+        .name = "aes",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_OTGFS] = {
+        .name = "otgfs",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOA] = {
+        .name = "gpioa",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOB] = {
+        .name = "gpiob",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOC] = {
+        .name = "gpioc",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOD] = {
+        .name = "gpiod",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOE] = {
+        .name = "gpioe",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOF] = {
+        .name = "gpiof",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOG] = {
+        .name = "gpiog",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_GPIOH] = {
+        .name = "gpioh",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_QSPI] = {
+        .name = "qspi",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_FMC] = {
+        .name = "fmc",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_OPAMP] = {
+        .name = "opamp",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_DAC1] = {
+        .name = "dac1",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_PWR] = {
+        .name = "pwr",
+        /*
+         * PWREN is in the APB1ENR1 register,
+         * but PWR uses SYSCLK according to the clock tree.
+         */
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_SYSCLK,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_CAN1] = {
+        .name = "can1",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SPI3] = {
+        .name = "spi3",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SPI2] = {
+        .name = "spi2",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_WWDG] = {
+        .name = "wwdg",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_LCD] = {
+        .name = "lcd",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_LCD_AND_RTC_COMMON,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM7] = {
+        .name = "tim7",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM6] = {
+        .name = "tim6",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM5] = {
+        .name = "tim5",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM4] = {
+        .name = "tim4",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM3] = {
+        .name = "tim3",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM2] = {
+        .name = "tim2",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK1,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM17] = {
+        .name = "tim17",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM16] = {
+        .name = "tim16",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM15] = {
+        .name = "tim15",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM8] = {
+        .name = "tim8",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SPI1] = {
+        .name = "spi1",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_TIM1] = {
+        .name = "tim1",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SDMMC1] = {
+        .name = "sdmmc1",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_FW] = {
+        .name = "fw",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_SYSCFG] = {
+        .name = "syscfg",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_PCLK2,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_RTC] = {
+        .name = "rtc",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_LCD_AND_RTC_COMMON,
+        },
+        FILL_DEFAULT_INIT_DISABLED,
+    },
+    [RCC_CLOCK_MUX_CORTEX_FCLK] = {
+        .name = "cortex-fclk",
+        .src_mapping = {
+            RCC_CLOCK_MUX_SRC_HCLK,
+        },
+        FILL_DEFAULT_INIT_ENABLED,
+    },
+};
+
+static inline void set_clock_mux_init_info(RccClockMuxState *mux,
+                                           RccClockMux id)
+{
+    mux->id = id;
+    mux->multiplier = CLOCK_MUX_INIT_INFO[id].multiplier;
+    mux->divider = CLOCK_MUX_INIT_INFO[id].divider;
+    mux->enabled = CLOCK_MUX_INIT_INFO[id].enabled;
+    /*
+     * Every peripheral has the first source of their source list as
+     * as their default source.
+     */
+    mux->src = 0;
+}
+
 #endif /* HW_STM32L4X5_RCC_INTERNALS_H */
diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index 9a9ea6c4702..083c0ad9ef5 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -36,7 +36,13 @@
 #define LSE_FRQ 32768ULL
 #define LSI_FRQ 32000ULL
 
-static void clock_mux_update(RccClockMuxState *mux)
+/*
+ * Function to simply acknowledge and propagate changes in a clock mux
+ * frequency.
+ * `bypass_source` allows to bypass the period of the current source and just
+ * consider it equal to 0. This is useful during the hold phase of reset.
+ */
+static void clock_mux_update(RccClockMuxState *mux, bool bypass_source)
 {
     uint64_t src_freq;
     Clock *current_source = mux->srcs[mux->src];
@@ -48,7 +54,7 @@ static void clock_mux_update(RccClockMuxState *mux)
      * the clock and the divider of the mux becomes the multiplier of the
      * clock.
      */
-    if (mux->enabled && mux->divider) {
+    if (!bypass_source && mux->enabled && mux->divider) {
         freq_multiplier = mux->divider;
     }
 
@@ -73,7 +79,7 @@ static void clock_mux_src_update(void *opaque, ClockEvent event)
     const uint32_t update_src = backref - s->backref;
     /* Only update if the clock that was updated is the current source */
     if (update_src == s->src) {
-        clock_mux_update(s);
+        clock_mux_update(s, false);
     }
 }
 
@@ -95,8 +101,23 @@ static void clock_mux_init(Object *obj)
     s->out = qdev_init_clock_out(DEVICE(s), "out");
 }
 
+static void clock_mux_reset_enter(Object *obj, ResetType type)
+{
+    RccClockMuxState *s = RCC_CLOCK_MUX(obj);
+    set_clock_mux_init_info(s, s->id);
+}
+
 static void clock_mux_reset_hold(Object *obj)
-{ }
+{
+    RccClockMuxState *s = RCC_CLOCK_MUX(obj);
+    clock_mux_update(s, true);
+}
+
+static void clock_mux_reset_exit(Object *obj)
+{
+    RccClockMuxState *s = RCC_CLOCK_MUX(obj);
+    clock_mux_update(s, false);
+}
 
 static const VMStateDescription clock_mux_vmstate = {
     .name = TYPE_RCC_CLOCK_MUX,
@@ -119,7 +140,9 @@ static void clock_mux_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    rc->phases.enter = clock_mux_reset_enter;
     rc->phases.hold = clock_mux_reset_hold;
+    rc->phases.exit = clock_mux_reset_exit;
     dc->vmsd = &clock_mux_vmstate;
 }
 
@@ -136,7 +159,7 @@ static void clock_mux_set_enable(RccClockMuxState *mux, bool enabled)
     }
 
     mux->enabled = enabled;
-    clock_mux_update(mux);
+    clock_mux_update(mux, false);
 }
 
 static void clock_mux_set_factor(RccClockMuxState *mux,
@@ -150,7 +173,7 @@ static void clock_mux_set_factor(RccClockMuxState *mux,
 
     mux->multiplier = multiplier;
     mux->divider = divider;
-    clock_mux_update(mux);
+    clock_mux_update(mux, false);
 }
 
 static void clock_mux_set_source(RccClockMuxState *mux, RccClockMuxSource src)
@@ -161,10 +184,15 @@ static void clock_mux_set_source(RccClockMuxState *mux, RccClockMuxSource src)
 
     trace_stm32l4x5_rcc_mux_set_src(mux->id, mux->src, src);
     mux->src = src;
-    clock_mux_update(mux);
+    clock_mux_update(mux, false);
 }
 
-static void pll_update(RccPllState *pll)
+/*
+ * Acknowledge and propagate changes in a PLL frequency.
+ * `bypass_source` allows to bypass the period of the current source and just
+ * consider it equal to 0. This is useful during the hold phase of reset.
+ */
+static void pll_update(RccPllState *pll, bool bypass_source)
 {
     uint64_t vco_freq, old_channel_freq, channel_freq;
     int i;
@@ -178,7 +206,8 @@ static void pll_update(RccPllState *pll)
         }
 
         old_channel_freq = clock_get_hz(pll->channels[i]);
-        if (!pll->enabled ||
+        if (bypass_source ||
+            !pll->enabled ||
             !pll->channel_enabled[i] ||
             !pll->channel_divider[i]) {
             channel_freq = 0;
@@ -202,7 +231,7 @@ static void pll_update(RccPllState *pll)
 static void pll_src_update(void *opaque, ClockEvent event)
 {
     RccPllState *s = opaque;
-    pll_update(s);
+    pll_update(s, false);
 }
 
 static void pll_init(Object *obj)
@@ -222,8 +251,23 @@ static void pll_init(Object *obj)
     }
 }
 
+static void pll_reset_enter(Object *obj, ResetType type)
+{
+    RccPllState *s = RCC_PLL(obj);
+    set_pll_init_info(s, s->id);
+}
+
 static void pll_reset_hold(Object *obj)
-{ }
+{
+    RccPllState *s = RCC_PLL(obj);
+    pll_update(s, true);
+}
+
+static void pll_reset_exit(Object *obj)
+{
+    RccPllState *s = RCC_PLL(obj);
+    pll_update(s, false);
+}
 
 static const VMStateDescription pll_vmstate = {
     .name = TYPE_RCC_PLL,
@@ -248,7 +292,9 @@ static void pll_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    rc->phases.enter = pll_reset_enter;
     rc->phases.hold = pll_reset_hold;
+    rc->phases.exit = pll_reset_exit;
     dc->vmsd = &pll_vmstate;
 }
 
@@ -269,7 +315,7 @@ static void pll_set_vco_multiplier(RccPllState *pll, uint32_t vco_multiplier)
         pll->vco_multiplier, vco_multiplier);
 
     pll->vco_multiplier = vco_multiplier;
-    pll_update(pll);
+    pll_update(pll, false);
 }
 
 static void pll_set_enable(RccPllState *pll, bool enabled)
@@ -279,7 +325,7 @@ static void pll_set_enable(RccPllState *pll, bool enabled)
     }
 
     pll->enabled = enabled;
-    pll_update(pll);
+    pll_update(pll, false);
 }
 
 static void pll_set_channel_enable(RccPllState *pll,
@@ -297,7 +343,7 @@ static void pll_set_channel_enable(RccPllState *pll,
     }
 
     pll->channel_enabled[channel] = enabled;
-    pll_update(pll);
+    pll_update(pll, false);
 }
 
 static void pll_set_channel_divider(RccPllState *pll,
@@ -312,7 +358,7 @@ static void pll_set_channel_divider(RccPllState *pll,
         channel, pll->channel_divider[channel], divider);
 
     pll->channel_divider[channel] = divider;
-    pll_update(pll);
+    pll_update(pll, false);
 }
 
 static void rcc_update_irq(Stm32l4x5RccState *s)
@@ -625,21 +671,79 @@ static void stm32l4x5_rcc_init(Object *obj)
     qdev_init_clocks(DEVICE(s), stm32l4x5_rcc_clocks);
 
     for (i = 0; i < RCC_NUM_PLL; i++) {
-        object_initialize_child(obj, "pll[*]",
+        object_initialize_child(obj, PLL_INIT_INFO[i].name,
                                 &s->plls[i], TYPE_RCC_PLL);
+        set_pll_init_info(&s->plls[i], i);
     }
 
     for (i = 0; i < RCC_NUM_CLOCK_MUX; i++) {
+        char *alias;
 
-        object_initialize_child(obj, "clock[*]",
+        object_initialize_child(obj, CLOCK_MUX_INIT_INFO[i].name,
                                 &s->clock_muxes[i],
                                 TYPE_RCC_CLOCK_MUX);
+        set_clock_mux_init_info(&s->clock_muxes[i], i);
 
+        if (!CLOCK_MUX_INIT_INFO[i].hidden) {
+            /* Expose muxes output as RCC outputs */
+            alias = g_strdup_printf("%s-out", CLOCK_MUX_INIT_INFO[i].name);
+            qdev_alias_clock(DEVICE(&s->clock_muxes[i]), "out", DEVICE(obj), alias);
+            g_free(alias);
+        }
     }
 
     s->gnd = clock_new(obj, "gnd");
 }
 
+static void connect_mux_sources(Stm32l4x5RccState *s,
+                                RccClockMuxState *mux,
+                                const RccClockMuxSource *clk_mapping)
+{
+    size_t i;
+
+    Clock * const CLK_SRC_MAPPING[] = {
+        [RCC_CLOCK_MUX_SRC_GND] = s->gnd,
+        [RCC_CLOCK_MUX_SRC_HSI] = s->hsi16_rc,
+        [RCC_CLOCK_MUX_SRC_HSE] = s->hse,
+        [RCC_CLOCK_MUX_SRC_MSI] = s->msi_rc,
+        [RCC_CLOCK_MUX_SRC_LSI] = s->lsi_rc,
+        [RCC_CLOCK_MUX_SRC_LSE] = s->lse_crystal,
+        [RCC_CLOCK_MUX_SRC_SAI1_EXTCLK] = s->sai1_extclk,
+        [RCC_CLOCK_MUX_SRC_SAI2_EXTCLK] = s->sai2_extclk,
+        [RCC_CLOCK_MUX_SRC_PLL] =
+            s->plls[RCC_PLL_PLL].channels[RCC_PLL_CHANNEL_PLLCLK],
+        [RCC_CLOCK_MUX_SRC_PLLSAI1] =
+            s->plls[RCC_PLL_PLLSAI1].channels[RCC_PLLSAI1_CHANNEL_PLLSAI1CLK],
+        [RCC_CLOCK_MUX_SRC_PLLSAI2] =
+            s->plls[RCC_PLL_PLLSAI2].channels[RCC_PLLSAI2_CHANNEL_PLLSAI2CLK],
+        [RCC_CLOCK_MUX_SRC_PLLSAI3] =
+            s->plls[RCC_PLL_PLL].channels[RCC_PLL_CHANNEL_PLLSAI3CLK],
+        [RCC_CLOCK_MUX_SRC_PLL48M1] =
+            s->plls[RCC_PLL_PLL].channels[RCC_PLL_CHANNEL_PLL48M1CLK],
+        [RCC_CLOCK_MUX_SRC_PLL48M2] =
+            s->plls[RCC_PLL_PLLSAI1].channels[RCC_PLLSAI1_CHANNEL_PLL48M2CLK],
+        [RCC_CLOCK_MUX_SRC_PLLADC1] =
+            s->plls[RCC_PLL_PLLSAI1].channels[RCC_PLLSAI1_CHANNEL_PLLADC1CLK],
+        [RCC_CLOCK_MUX_SRC_PLLADC2] =
+            s->plls[RCC_PLL_PLLSAI2] .channels[RCC_PLLSAI2_CHANNEL_PLLADC2CLK],
+        [RCC_CLOCK_MUX_SRC_SYSCLK] = s->clock_muxes[RCC_CLOCK_MUX_SYSCLK].out,
+        [RCC_CLOCK_MUX_SRC_HCLK] = s->clock_muxes[RCC_CLOCK_MUX_HCLK].out,
+        [RCC_CLOCK_MUX_SRC_PCLK1] = s->clock_muxes[RCC_CLOCK_MUX_PCLK1].out,
+        [RCC_CLOCK_MUX_SRC_PCLK2] = s->clock_muxes[RCC_CLOCK_MUX_PCLK2].out,
+        [RCC_CLOCK_MUX_SRC_HSE_OVER_32] = s->clock_muxes[RCC_CLOCK_MUX_HSE_OVER_32].out,
+        [RCC_CLOCK_MUX_SRC_LCD_AND_RTC_COMMON] =
+            s->clock_muxes[RCC_CLOCK_MUX_LCD_AND_RTC_COMMON].out,
+    };
+
+    assert(ARRAY_SIZE(CLK_SRC_MAPPING) == RCC_CLOCK_MUX_SRC_NUMBER);
+
+    for (i = 0; i < RCC_NUM_CLOCK_MUX_SRC; i++) {
+        RccClockMuxSource mapping = clk_mapping[i];
+        clock_set_source(mux->srcs[i], CLK_SRC_MAPPING[mapping]);
+    }
+}
+
+
 static const VMStateDescription vmstate_stm32l4x5_rcc = {
     .name = TYPE_STM32L4X5_RCC,
     .version_id = 1,
@@ -712,11 +816,17 @@ static void stm32l4x5_rcc_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < RCC_NUM_CLOCK_MUX; i++) {
         RccClockMuxState *clock_mux = &s->clock_muxes[i];
 
+        connect_mux_sources(s, clock_mux, CLOCK_MUX_INIT_INFO[i].src_mapping);
+
         if (!qdev_realize(DEVICE(clock_mux), NULL, errp)) {
             return;
         }
     }
 
+    /*
+     * Start clocks after everything is connected
+     * to propagate the frequencies along the tree.
+     */
     clock_update_hz(s->msi_rc, MSI_DEFAULT_FRQ);
     clock_update_hz(s->sai1_extclk, s->sai1_extclk_frequency);
     clock_update_hz(s->sai2_extclk, s->sai2_extclk_frequency);
@@ -750,6 +860,7 @@ static void stm32l4x5_rcc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    assert(ARRAY_SIZE(CLOCK_MUX_INIT_INFO) == RCC_NUM_CLOCK_MUX);
 
     rc->phases.hold = stm32l4x5_rcc_reset_hold;
     device_class_set_props(dc, stm32l4x5_rcc_properties);
-- 
2.34.1


