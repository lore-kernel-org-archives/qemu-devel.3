Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BBDC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokSF-0002ds-Na; Mon, 25 Mar 2024 09:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokSB-0002bD-PD
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:33:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokS9-0007N8-Nf
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:33:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4148bc73069so3322555e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711373608; x=1711978408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+iChHJV7sNlvRqqjFzQcgZJQ2tuinOgYhEDNJOHyzoE=;
 b=yzSINfOc5KigA7rYWbldxZDNz7WrJpMf5CZewBVIHHxRHaalkbXomJ9mfGCqgKg1vx
 neZhXNlqD2GXVKP/VAgq0LF6/Ol5FjTxYyDVggoKdUW3Fy0p8W75V/jwheF//PgfatV3
 LPI+B460xUzVhU+aT+9wuPoYl9xpSeYTn4N5oza9WtdOFTqmkmhfHfksAfb+DSq0lyYb
 95Z091PmLAISGzXkNLi21mypvVSqJu6SxOv5dJDfBcBRI5feW59zYOlNmXhO0U/pb2Bp
 veINHTiuuYgqNXdbhy4tBopMsjY7nBMT7Ce8kMQc0Q03GuvUJRfWHFRj5powlyZMSgd0
 vHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711373608; x=1711978408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+iChHJV7sNlvRqqjFzQcgZJQ2tuinOgYhEDNJOHyzoE=;
 b=APbbw7uObe/cWLvWvjS6jxmrLYov1rSUJXVjJO6fEHzybJEHAg+EiBobskkOOpw2VR
 9qJp61SEF674s35sg9KepNWVofcCScnwxWSCoHsGMIGzUyVQKklgmbPILuYr3/YvXPfV
 zGBK06vxqZ1tNQTY+iB+v0ApR7A5HKHOSHP/jWQNzYjr+0aKwtrJHJv4VDqvo3bDHcpC
 nCsTie1ixk2T7WMfBv6k5gWNoEnVfqYErsnKhgPixHJ0vJi65Xy+DZN/CXEIhssaPZS8
 tkfPUs3upB1DfQGD9IrVz/opY4Q2uQAmlgsHqboF/2G4/csuRAQwIqQtFftXcAAaqZH2
 WuAA==
X-Gm-Message-State: AOJu0YxWLAWQfs/AQ4Ws8mHj9Qa2+GHTFGIcnhLyJRwExgvYJ949KZ2B
 W4M3bZIpB73C5NS+xVEfYibCgNWHHB3Yb/Zv8nCMMB9JZawWSD+V58DpfNJmzand6x2GnUc8ZlB
 HjWk=
X-Google-Smtp-Source: AGHT+IEV/yh479xjpGEm/dixwALkBj+9rU8pOrz0EphvfaixtwC++Jn2XXpqh2asCeljeudbYuo71w==
X-Received: by 2002:a05:600c:5128:b0:414:8a28:6c8e with SMTP id
 o40-20020a05600c512800b004148a286c8emr1941571wms.26.1711373607847; 
 Mon, 25 Mar 2024 06:33:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 l40-20020a05600c1d2800b0041480a1b8f7sm7972127wms.4.2024.03.25.06.33.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Mar 2024 06:33:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Felipe Balbi <balbi@kernel.org>, Alexandre Iooss <erdnaxe@crans.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-9.0? v2 4/8] hw/clock: Pass optional &bool argument to
 clock_set_hz()
Date: Mon, 25 Mar 2024 14:32:54 +0100
Message-ID: <20240325133259.57235-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325133259.57235-1-philmd@linaro.org>
References: <20240325133259.57235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Pass optional &bool argument to clock_set_ns().
Since all callers ignore the return value, have
them use NULL.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/clock.h         | 8 ++------
 hw/arm/aspeed.c            | 2 +-
 hw/arm/fby35.c             | 2 +-
 hw/arm/mps2-tz.c           | 4 ++--
 hw/arm/mps2.c              | 4 ++--
 hw/arm/mps3r.c             | 2 +-
 hw/arm/msf2-som.c          | 2 +-
 hw/arm/musca.c             | 4 ++--
 hw/arm/netduino2.c         | 2 +-
 hw/arm/netduinoplus2.c     | 2 +-
 hw/arm/nrf51_soc.c         | 2 +-
 hw/arm/olimex-stm32-h405.c | 2 +-
 hw/arm/stm32vldiscovery.c  | 2 +-
 hw/arm/xilinx_zynq.c       | 2 +-
 hw/char/cadence_uart.c     | 4 ++--
 15 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index 94ed5ba6e6..f0ac410fc8 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -186,13 +186,9 @@ static inline bool clock_has_source(const Clock *clk)
  */
 void clock_set(Clock *clk, uint64_t period, bool *changed);
 
-static inline bool clock_set_hz(Clock *clk, unsigned hz)
+static inline void clock_set_hz(Clock *clk, unsigned hz, bool *changed)
 {
-    bool changed = false;
-
-    clock_set(clk, CLOCK_PERIOD_FROM_HZ(hz), &changed);
-
-    return changed;
+    clock_set(clk, CLOCK_PERIOD_FROM_HZ(hz), changed);
 }
 
 static inline void clock_set_ns(Clock *clk, unsigned ns, bool *changed)
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 8854581ca8..7e4ed71e9f 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1521,7 +1521,7 @@ static void aspeed_minibmc_machine_init(MachineState *machine)
     Clock *sysclk;
 
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
-    clock_set_hz(sysclk, SYSCLK_FRQ);
+    clock_set_hz(sysclk, SYSCLK_FRQ, NULL);
 
     bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index c9964bd283..dd4abdd768 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -119,7 +119,7 @@ static void fby35_bic_init(Fby35State *s)
     AspeedSoCState *soc;
 
     s->bic_sysclk = clock_new(OBJECT(s), "SYSCLK");
-    clock_set_hz(s->bic_sysclk, 200000000ULL);
+    clock_set_hz(s->bic_sysclk, 200000000ULL, NULL);
 
     object_initialize_child(OBJECT(s), "bic", &s->bic, "ast1030-a1");
     soc = ASPEED_SOC(&s->bic);
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index a2d18afd79..015db74ab8 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -818,9 +818,9 @@ static void mps2tz_common_init(MachineState *machine)
 
     /* These clocks don't need migration because they are fixed-frequency */
     mms->sysclk = clock_new(OBJECT(machine), "SYSCLK");
-    clock_set_hz(mms->sysclk, mmc->sysclk_frq);
+    clock_set_hz(mms->sysclk, mmc->sysclk_frq, NULL);
     mms->s32kclk = clock_new(OBJECT(machine), "S32KCLK");
-    clock_set_hz(mms->s32kclk, S32KCLK_FRQ);
+    clock_set_hz(mms->s32kclk, S32KCLK_FRQ, NULL);
 
     object_initialize_child(OBJECT(machine), TYPE_IOTKIT, &mms->iotkit,
                             mmc->armsse_type);
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 50919ee46d..7176305239 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -151,10 +151,10 @@ static void mps2_common_init(MachineState *machine)
 
     /* This clock doesn't need migration because it is fixed-frequency */
     mms->sysclk = clock_new(OBJECT(machine), "SYSCLK");
-    clock_set_hz(mms->sysclk, SYSCLK_FRQ);
+    clock_set_hz(mms->sysclk, SYSCLK_FRQ, NULL);
 
     mms->refclk = clock_new(OBJECT(machine), "REFCLK");
-    clock_set_hz(mms->refclk, REFCLK_FRQ);
+    clock_set_hz(mms->refclk, REFCLK_FRQ, NULL);
 
     /* The FPGA images have an odd combination of different RAMs,
      * because in hardware they are different implementations and
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 4d55a6564c..84f1f9d3a2 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -360,7 +360,7 @@ static void mps3r_common_init(MachineState *machine)
     QList *oscclk;
 
     mms->clk = clock_new(OBJECT(machine), "CLK");
-    clock_set_hz(mms->clk, CLK_FRQ);
+    clock_set_hz(mms->clk, CLK_FRQ, NULL);
 
     for (const RAMInfo *ri = mmc->raminfo; ri->name; ri++) {
         MemoryRegion *mr = mr_for_raminfo(mms, ri);
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 5c415abe85..420c0ae332 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -71,7 +71,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
      */
     /* This clock doesn't need migration because it is fixed-frequency */
     m3clk = clock_new(OBJECT(machine), "m3clk");
-    clock_set_hz(m3clk, 142 * 1000000);
+    clock_set_hz(m3clk, 142 * 1000000, NULL);
     qdev_connect_clock_in(dev, "m3clk", m3clk);
     qdev_prop_set_uint32(dev, "apb0div", 2);
     qdev_prop_set_uint32(dev, "apb1div", 2);
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index e2c9d49af5..6fdcb76dfa 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -366,9 +366,9 @@ static void musca_init(MachineState *machine)
     assert(mmc->num_mpcs <= MUSCA_MPC_MAX);
 
     mms->sysclk = clock_new(OBJECT(machine), "SYSCLK");
-    clock_set_hz(mms->sysclk, SYSCLK_FRQ);
+    clock_set_hz(mms->sysclk, SYSCLK_FRQ, NULL);
     mms->s32kclk = clock_new(OBJECT(machine), "S32KCLK");
-    clock_set_hz(mms->s32kclk, S32KCLK_FRQ);
+    clock_set_hz(mms->s32kclk, S32KCLK_FRQ, NULL);
 
     object_initialize_child(OBJECT(machine), "sse-200", &mms->sse,
                             TYPE_SSE200);
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 8b1a9a2437..49a3ee2c47 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -41,7 +41,7 @@ static void netduino2_init(MachineState *machine)
 
     /* This clock doesn't need migration because it is fixed-frequency */
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
-    clock_set_hz(sysclk, SYSCLK_FRQ);
+    clock_set_hz(sysclk, SYSCLK_FRQ, NULL);
 
     dev = qdev_new(TYPE_STM32F205_SOC);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index bccd100354..30d9c0410d 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -41,7 +41,7 @@ static void netduinoplus2_init(MachineState *machine)
 
     /* This clock doesn't need migration because it is fixed-frequency */
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
-    clock_set_hz(sysclk, SYSCLK_FRQ);
+    clock_set_hz(sysclk, SYSCLK_FRQ, NULL);
 
     dev = qdev_new(TYPE_STM32F405_SOC);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index ac53441630..9aebb98934 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -75,7 +75,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
     /* This clock doesn't need migration because it is fixed-frequency */
-    clock_set_hz(s->sysclk, HCLK_FRQ);
+    clock_set_hz(s->sysclk, HCLK_FRQ, NULL);
     qdev_connect_clock_in(DEVICE(&s->cpu), "cpuclk", s->sysclk);
     /*
      * This SoC has no systick device, so don't connect refclk.
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 4ad7b043be..394875608a 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -44,7 +44,7 @@ static void olimex_stm32_h405_init(MachineState *machine)
 
     /* This clock doesn't need migration because it is fixed-frequency */
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
-    clock_set_hz(sysclk, SYSCLK_FRQ);
+    clock_set_hz(sysclk, SYSCLK_FRQ, NULL);
 
     dev = qdev_new(TYPE_STM32F405_SOC);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index cc41935160..4be626e878 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -44,7 +44,7 @@ static void stm32vldiscovery_init(MachineState *machine)
 
     /* This clock doesn't need migration because it is fixed-frequency */
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
-    clock_set_hz(sysclk, SYSCLK_FRQ);
+    clock_set_hz(sysclk, SYSCLK_FRQ, NULL);
 
     dev = qdev_new(TYPE_STM32F100_SOC);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index fc3abcbe88..1fd13caa58 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -228,7 +228,7 @@ static void zynq_init(MachineState *machine)
     object_property_add_child(OBJECT(zynq_machine), "ps_clk",
                               OBJECT(zynq_machine->ps_clk));
     object_unref(OBJECT(zynq_machine->ps_clk));
-    clock_set_hz(zynq_machine->ps_clk, PS_CLK_FREQUENCY);
+    clock_set_hz(zynq_machine->ps_clk, PS_CLK_FREQUENCY, NULL);
 
     /* Create slcr, keep a pointer to connect clocks */
     slcr = qdev_new("xilinx-zynq_slcr");
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index db31d7cc85..4619209af4 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -566,7 +566,7 @@ static void cadence_uart_init(Object *obj)
     s->refclk = qdev_init_clock_in(DEVICE(obj), "refclk",
                                    cadence_uart_refclk_update, s, ClockUpdate);
     /* initialize the frequency in case the clock remains unconnected */
-    clock_set_hz(s->refclk, UART_DEFAULT_REF_CLK);
+    clock_set_hz(s->refclk, UART_DEFAULT_REF_CLK, NULL);
 
     s->char_tx_time = (NANOSECONDS_PER_SECOND / 9600) * 10;
 }
@@ -576,7 +576,7 @@ static int cadence_uart_pre_load(void *opaque)
     CadenceUARTState *s = opaque;
 
     /* the frequency will be overridden if the refclk field is present */
-    clock_set_hz(s->refclk, UART_DEFAULT_REF_CLK);
+    clock_set_hz(s->refclk, UART_DEFAULT_REF_CLK, NULL);
     return 0;
 }
 
-- 
2.41.0


