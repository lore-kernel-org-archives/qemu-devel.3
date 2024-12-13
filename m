Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523EDE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBA1-0003g3-QH; Fri, 13 Dec 2024 14:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7n-00080m-RJ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:58 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7i-0007ff-W2
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:54 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5f32fab5de9so239842eaf.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117288; x=1734722088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xPd8v41eeOyrQJCDfbB2uHm4CbCifH9Wt1doq061h1k=;
 b=h7rn5YdK6uE1n5nj0invX66fNw1UgOLUGPgD5XgMDmNLN/RClYy/DoWmRcrUur02WM
 7vJBgOJMhuDfMKFwFCo6F3qvlSqzuZ1EScSRV1bw9vQJLcbH0Kre7Gq+D0Si9XgOTNr1
 A0YSOV0VxWbKYvNZwmJ4v99eouVZNXbUe9TvKHzxG7kasVNVM8huSUyQ/wy7SWLiowOE
 tGnRv4fS6rGkK13CF8EkcevcWfkaUsN532ttEF9jQAQQhUpZDlgRGhrT82OgCerGBrvI
 3rpUL4NlstCxBFQa2U5Zzku4CgoHe+vKNj02eKuM0+phY5Jt/+GVhG2p92uwynn9XvgF
 yvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117288; x=1734722088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xPd8v41eeOyrQJCDfbB2uHm4CbCifH9Wt1doq061h1k=;
 b=BosSnl4RNws9A0HywOmOGux+gjwbcu6hZo+ElgFkjCITG6afDtqomnYy7tWFKr0Zqc
 dxlrbmhWMzM57wycUAlTBRAbzTRPyRO8KMBKApBH/3/jRSr91/xgbskhV8aHl1VXDfdd
 mNhdBhIaDt/ZkVpnbTdyFb/Wmkj81XJ68MSp+7smWlTACblKEiUTRDK04Jdc4WvPBrG1
 6pBjUR1AZ14UizCTRp07NOk/iYln0MRGoY55xl58ZdH6f0n2egsBHriM70jJJq5roB1k
 wmRufnvh3zg4ICL2XdGsNwC7+dm7Qn8+yAK15EKt+ZAg+2AmAuOqxl03R7oi7TzQwYVo
 xzOw==
X-Gm-Message-State: AOJu0YwRnVN0k2ms7dAaHYqa0jtjqReN3dJ0btIFXGSq3Kl+B6Vgjgzi
 ZcAGQmVC0/xq22pq9yQdNQZgSNYS5+CaF7yKY6sSZRoNgwvpco1g1wD+RplRUS/6yVy55YA9mgN
 /VS6MVfo6
X-Gm-Gg: ASbGncs/HH1RNd6VICZKHY6APZLwh6FqF1aRkGTM71J/DoJ3zOLfQ2PG/TGNLPj7P4Y
 MytOdAomnOdIi6braU69A6J8MTEYuiJxGKNkRDvBghdi1LhC3EOul8scCXCUY6wzHKgI5ouvk6w
 tq05HyVRsluUtCDYfGEviNXOh3D5UgA5SiEos71vJnPoaG44MjT6Cq8R7rrLKjM3koZVHT/t1y3
 5zINEMUfzF3k7inL75I8lT4Iv6gqynuKfleKq738H4wI8OOejYcSfG7CrNPT5qp
X-Google-Smtp-Source: AGHT+IHK4henUoHCX20TGQ7y/2wzNbbn5NldL0W9ORA9M7fAcn3uS/jfg6n2FqNYFoNZJI2qxr9P8A==
X-Received: by 2002:a05:6808:158e:b0:3eb:53f2:17c3 with SMTP id
 5614622812f47-3eba691e54bmr2492728b6e.26.1734117287684; 
 Fri, 13 Dec 2024 11:14:47 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-arm@nongnu.org (open list:ARM cores),
 qemu-riscv@nongnu.org (open list:OpenTitan)
Subject: [PATCH 60/71] hw/timer: Constify all Property
Date: Fri, 13 Dec 2024 13:07:34 -0600
Message-ID: <20241213190750.2513964-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/timer/a9gtimer.c          | 2 +-
 hw/timer/allwinner-a10-pit.c | 2 +-
 hw/timer/arm_mptimer.c       | 2 +-
 hw/timer/arm_timer.c         | 2 +-
 hw/timer/aspeed_timer.c      | 2 +-
 hw/timer/avr_timer16.c       | 2 +-
 hw/timer/grlib_gptimer.c     | 2 +-
 hw/timer/hpet.c              | 2 +-
 hw/timer/i8254_common.c      | 2 +-
 hw/timer/ibex_timer.c        | 2 +-
 hw/timer/mss-timer.c         | 2 +-
 hw/timer/nrf51_timer.c       | 2 +-
 hw/timer/pxa2xx_timer.c      | 2 +-
 hw/timer/renesas_cmt.c       | 2 +-
 hw/timer/renesas_tmr.c       | 2 +-
 hw/timer/sifive_pwm.c        | 2 +-
 hw/timer/slavio_timer.c      | 2 +-
 hw/timer/sse-timer.c         | 2 +-
 hw/timer/stm32f2xx_timer.c   | 2 +-
 hw/timer/xilinx_timer.c      | 2 +-
 20 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 8091ec18c7..c0a91bab0c 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -373,7 +373,7 @@ static const VMStateDescription vmstate_a9_gtimer = {
     }
 };
 
-static Property a9_gtimer_properties[] = {
+static const Property a9_gtimer_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", A9GTimerState, num_cpu, 0),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index d488e9782b..2904ccfb42 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -188,7 +188,7 @@ static const MemoryRegionOps a10_pit_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static Property a10_pit_properties[] = {
+static const Property a10_pit_properties[] = {
     DEFINE_PROP_UINT32("clk0-freq", AwA10PITState, clk_freq[0], 0),
     DEFINE_PROP_UINT32("clk1-freq", AwA10PITState, clk_freq[1], 0),
     DEFINE_PROP_UINT32("clk2-freq", AwA10PITState, clk_freq[2], 0),
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index defa30b46d..6244a7a84f 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -300,7 +300,7 @@ static const VMStateDescription vmstate_arm_mptimer = {
     }
 };
 
-static Property arm_mptimer_properties[] = {
+static const Property arm_mptimer_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", ARMMPTimerState, num_cpu, 0),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 0940e03f1d..dfa034296c 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -387,7 +387,7 @@ static const TypeInfo icp_pit_info = {
     .instance_init = icp_pit_init,
 };
 
-static Property sp804_properties[] = {
+static const Property sp804_properties[] = {
     DEFINE_PROP_UINT32("freq0", SP804State, freq0, 1000000),
     DEFINE_PROP_UINT32("freq1", SP804State, freq1, 1000000),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 149f7cc5a6..4c16b5016e 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -674,7 +674,7 @@ static const VMStateDescription vmstate_aspeed_timer_state = {
     }
 };
 
-static Property aspeed_timer_properties[] = {
+static const Property aspeed_timer_properties[] = {
     DEFINE_PROP_LINK("scu", AspeedTimerCtrlState, scu, TYPE_ASPEED_SCU,
                      AspeedSCUState *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
index 421920054f..2e3ce83c43 100644
--- a/hw/timer/avr_timer16.c
+++ b/hw/timer/avr_timer16.c
@@ -542,7 +542,7 @@ static const MemoryRegionOps avr_timer16_ifr_ops = {
     .impl = {.max_access_size = 1}
 };
 
-static Property avr_timer16_properties[] = {
+static const Property avr_timer16_properties[] = {
     DEFINE_PROP_UINT8("id", struct AVRTimer16State, id, 0),
     DEFINE_PROP_UINT64("cpu-frequency-hz", struct AVRTimer16State,
                        cpu_freq_hz, 0),
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 6ef08f25fd..a7428ed938 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -403,7 +403,7 @@ static void grlib_gptimer_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &unit->iomem);
 }
 
-static Property grlib_gptimer_properties[] = {
+static const Property grlib_gptimer_properties[] = {
     DEFINE_PROP_UINT32("frequency", GPTimerUnit, freq_hz,   40000000),
     DEFINE_PROP_UINT32("irq-line",  GPTimerUnit, irq_line,  8),
     DEFINE_PROP_UINT32("nr-timers", GPTimerUnit, nr_timers, 2),
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 5399f1b2a3..46886c379e 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -745,7 +745,7 @@ static void hpet_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out(dev, &s->pit_enabled, 1);
 }
 
-static Property hpet_device_properties[] = {
+static const Property hpet_device_properties[] = {
     DEFINE_PROP_UINT8("timers", HPETState, num_timers, HPET_MIN_TIMERS),
     DEFINE_PROP_BIT("msi", HPETState, flags, HPET_MSI_SUPPORT, false),
     DEFINE_PROP_UINT32(HPET_INTCAP, HPETState, intcap, 0),
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index 28fdabc321..953c1e11eb 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -238,7 +238,7 @@ static const VMStateDescription vmstate_pit_common = {
     }
 };
 
-static Property pit_common_properties[] = {
+static const Property pit_common_properties[] = {
     DEFINE_PROP_UINT32("iobase", PITCommonState, iobase,  -1),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
index 2bdcff532d..fba4466a89 100644
--- a/hw/timer/ibex_timer.c
+++ b/hw/timer/ibex_timer.c
@@ -263,7 +263,7 @@ static const VMStateDescription vmstate_ibex_timer = {
     }
 };
 
-static Property ibex_timer_properties[] = {
+static const Property ibex_timer_properties[] = {
     DEFINE_PROP_UINT32("timebase-freq", IbexTimerState, timebase_freq, 10000),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index b66aed56ea..e5c5cd6a84 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -279,7 +279,7 @@ static const VMStateDescription vmstate_mss_timer = {
     }
 };
 
-static Property mss_timer_properties[] = {
+static const Property mss_timer_properties[] = {
     /* Libero GUI shows 100Mhz as default for clocks */
     DEFINE_PROP_UINT32("clock-frequency", MSSTimerState, freq_hz,
                       100 * 1000000),
diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index 35b0e62d5b..48fccec1bf 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -379,7 +379,7 @@ static const VMStateDescription vmstate_nrf51_timer = {
     }
 };
 
-static Property nrf51_timer_properties[] = {
+static const Property nrf51_timer_properties[] = {
     DEFINE_PROP_UINT8("id", NRF51TimerState, id, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 3234bbb1f4..345145bfa8 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -549,7 +549,7 @@ static const VMStateDescription vmstate_pxa2xx_timer_regs = {
     }
 };
 
-static Property pxa25x_timer_dev_properties[] = {
+static const Property pxa25x_timer_dev_properties[] = {
     DEFINE_PROP_UINT32("freq", PXA2xxTimerInfo, freq, PXA25X_FREQ),
     DEFINE_PROP_BIT("tm4", PXA2xxTimerInfo, flags,
                     PXA2XX_TIMER_HAVE_TM4, false),
diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
index cd59b08c87..6d451fa86b 100644
--- a/hw/timer/renesas_cmt.c
+++ b/hw/timer/renesas_cmt.c
@@ -253,7 +253,7 @@ static const VMStateDescription vmstate_rcmt = {
     }
 };
 
-static Property rcmt_properties[] = {
+static const Property rcmt_properties[] = {
     DEFINE_PROP_UINT64("input-freq", RCMTState, input_freq, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index a93e075fcd..890f803cf8 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -463,7 +463,7 @@ static const VMStateDescription vmstate_rtmr = {
     }
 };
 
-static Property rtmr_properties[] = {
+static const Property rtmr_properties[] = {
     DEFINE_PROP_UINT64("input-freq", RTMRState, input_freq, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/timer/sifive_pwm.c b/hw/timer/sifive_pwm.c
index 4602fc1a61..042c89c67a 100644
--- a/hw/timer/sifive_pwm.c
+++ b/hw/timer/sifive_pwm.c
@@ -404,7 +404,7 @@ static const VMStateDescription vmstate_sifive_pwm = {
     }
 };
 
-static Property sifive_pwm_properties[] = {
+static const Property sifive_pwm_properties[] = {
     /* 0.5Ghz per spec after FSBL */
     DEFINE_PROP_UINT64("clock-frequency", struct SiFivePwmState,
                        freq_hz, 500000000ULL),
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 12cb3bac97..32991f4436 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -420,7 +420,7 @@ static void slavio_timer_init(Object *obj)
     }
 }
 
-static Property slavio_timer_properties[] = {
+static const Property slavio_timer_properties[] = {
     DEFINE_PROP_UINT32("num_cpus",  SLAVIO_TIMERState, num_cpus,  0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/timer/sse-timer.c b/hw/timer/sse-timer.c
index 115b0138c8..6b7a67941c 100644
--- a/hw/timer/sse-timer.c
+++ b/hw/timer/sse-timer.c
@@ -440,7 +440,7 @@ static const VMStateDescription sse_timer_vmstate = {
     }
 };
 
-static Property sse_timer_properties[] = {
+static const Property sse_timer_properties[] = {
     DEFINE_PROP_LINK("counter", SSETimer, counter, TYPE_SSE_COUNTER, SSECounter *),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 16b47887a5..d9d745cd76 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -298,7 +298,7 @@ static const VMStateDescription vmstate_stm32f2xx_timer = {
     }
 };
 
-static Property stm32f2xx_timer_properties[] = {
+static const Property stm32f2xx_timer_properties[] = {
     DEFINE_PROP_UINT64("clock-frequency", struct STM32F2XXTimerState,
                        freq_hz, 1000000000),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 32a9df69e0..7fe3e83baa 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -242,7 +242,7 @@ static void xilinx_timer_init(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &t->irq);
 }
 
-static Property xilinx_timer_properties[] = {
+static const Property xilinx_timer_properties[] = {
     DEFINE_PROP_UINT32("clock-frequency", XpsTimerState, freq_hz, 62 * 1000000),
     DEFINE_PROP_UINT8("one-timer-only", XpsTimerState, one_timer_only, 0),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.43.0


