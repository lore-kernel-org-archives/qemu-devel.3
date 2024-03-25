Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24373CD11BF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokSB-0002aw-NU; Mon, 25 Mar 2024 09:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokRz-0002Vz-NV
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:33:22 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokRx-0007Km-L9
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:33:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41488d7d0f6so6462125e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 06:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711373596; x=1711978396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LcyveRM01RBdsZUoJvcc1ljUZ85bZnawQAlgxiQ5g44=;
 b=zkogC/o//J9sp5kP/kJTjQ2jmafcdvhVYR1MNHl62FlTroHQPVQ63gPg84/xcOYbbp
 ssLl+eqthPU1mPOFkyEOUD6/f3/HqFF67ZjSKpZngROJdrasTAbFYZ4Gdy29f5Psh79p
 uH0StaOGhedVqdjlaaqAj+8dbDL++fdUJsxvok90ybdxVkfKjBHMUxcJV2+d4iKhy9p/
 LaLaduKDlW73l4TznKtmW4waqe+BIc5I2a8ekZYrwC9Y8idyXCjOHL3ArgGkeG1tzjMK
 YkRxgNfcGdqah3kGe93q+XBS8nGFCc0E5y+33+n1+9hZKKJWJjTvUCWe5MumaVzq4037
 JaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711373596; x=1711978396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LcyveRM01RBdsZUoJvcc1ljUZ85bZnawQAlgxiQ5g44=;
 b=ebZRhdAm4deIBqWso9f7XR+UkzyxNp3JdbrMoZLNQyT5uPyDq+1d4d1JA4+AiBwTHN
 93Hpi860gMfKHgf3oVYto2CUWVpcLYpOPGBrOcUBEOPjOtPBjrNvCvevZ8IA/3Q0OIRg
 +Vs4zjNd/tZEmIu4oO/eCzuSOPWDGfSP7yc34B54p1rzggdzaaOWeCaYCQV9feUam4ap
 UvmSs4ppykIUV3WHlPVi0jFiFLSHLTjga0yfdsR9nIUZR9hanZ7LCKNdHWQWFdwDGDSA
 WnOT43uWwS5zN6SodfcqZBlrn5T8nrjF5fWGTdreTykLRR8eixGDOqOkj77sPF1UAmma
 HMbA==
X-Gm-Message-State: AOJu0Yz8aokOoUcRMBX+WN7hSaPBFJ24qRi0MLSy0avoUbgl5v0GQ2tz
 qn1sLkDIdcIuXVt3Qd0dkXalYbRntIgpLre8go8X4PqHAnT79p+G1WIy0WhvkWc+YnZdPBaPqKW
 z8mc=
X-Google-Smtp-Source: AGHT+IE6y/+NX5ez0RRhTaA2VoxilKzUHty2NIeFfLScFZglQCH3mXK8q4s4o6XF4+cFJ61/qrDy5w==
X-Received: by 2002:a5d:53d1:0:b0:33e:1e2b:3f76 with SMTP id
 a17-20020a5d53d1000000b0033e1e2b3f76mr4724078wrw.61.1711373595764; 
 Mon, 25 Mar 2024 06:33:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 cl1-20020a5d5f01000000b00341b9737fc5sm8551423wrb.96.2024.03.25.06.33.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Mar 2024 06:33:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH-for-9.0? v2 2/8] hw/clock: Pass optional &bool argument to
 clock_set()
Date: Mon, 25 Mar 2024 14:32:52 +0100
Message-ID: <20240325133259.57235-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325133259.57235-1-philmd@linaro.org>
References: <20240325133259.57235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently clock_set() returns whether the clock has
been changed or not. In order to combine this information
with other clock calls, pass an optional boolean and do
not return anything.  The single caller ignores the return
value, have it use NULL.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/clock.h       | 22 ++++++++++++++++------
 hw/core/clock.c          |  8 +++++---
 hw/misc/bcm2835_cprman.c |  2 +-
 hw/misc/zynq_slcr.c      |  4 ++--
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index bb12117f67..474bbc07fe 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -180,21 +180,28 @@ static inline bool clock_has_source(const Clock *clk)
  * clock_set:
  * @clk: the clock to initialize.
  * @value: the clock's value, 0 means unclocked
+ * @changed: set to true if the clock is changed, ignored if set to NULL.
  *
  * Set the local cached period value of @clk to @value.
- *
- * @return: true if the clock is changed.
  */
-bool clock_set(Clock *clk, uint64_t value);
+void clock_set(Clock *clk, uint64_t period, bool *changed);
 
 static inline bool clock_set_hz(Clock *clk, unsigned hz)
 {
-    return clock_set(clk, CLOCK_PERIOD_FROM_HZ(hz));
+    bool changed = false;
+
+    clock_set(clk, CLOCK_PERIOD_FROM_HZ(hz), &changed);
+
+    return changed;
 }
 
 static inline bool clock_set_ns(Clock *clk, unsigned ns)
 {
-    return clock_set(clk, CLOCK_PERIOD_FROM_NS(ns));
+    bool changed = false;
+
+    clock_set(clk, CLOCK_PERIOD_FROM_NS(ns), &changed);
+
+    return changed;
 }
 
 /**
@@ -220,7 +227,10 @@ void clock_propagate(Clock *clk);
  */
 static inline void clock_update(Clock *clk, uint64_t value)
 {
-    if (clock_set(clk, value)) {
+    bool changed = false;
+
+    clock_set(clk, value, &changed);
+    if (changed) {
         clock_propagate(clk);
     }
 }
diff --git a/hw/core/clock.c b/hw/core/clock.c
index c73f0c2f98..e0f257b141 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -52,16 +52,18 @@ void clock_clear_callback(Clock *clk)
     clock_set_callback(clk, NULL, NULL, 0);
 }
 
-bool clock_set(Clock *clk, uint64_t period)
+void clock_set(Clock *clk, uint64_t period, bool *changed)
 {
     if (clk->period == period) {
-        return false;
+        return;
     }
     trace_clock_set(CLOCK_PATH(clk), CLOCK_PERIOD_TO_HZ(clk->period),
                     CLOCK_PERIOD_TO_HZ(period));
     clk->period = period;
 
-    return true;
+    if (changed) {
+        *changed = true;
+    }
 }
 
 static uint64_t clock_get_child_period(Clock *clk)
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 91c8f7bd17..f16f7978ae 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -680,7 +680,7 @@ static void cprman_init(Object *obj)
     s->xosc = clock_new(obj, "xosc");
     s->gnd = clock_new(obj, "gnd");
 
-    clock_set(s->gnd, 0);
+    clock_set(s->gnd, 0, NULL);
 
     memory_region_init_io(&s->iomem, obj, &cprman_ops,
                           s, "bcm2835-cprman", 0x2000);
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index d2ac2e77f2..e637798507 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -279,9 +279,9 @@ static void zynq_slcr_compute_clocks_internal(ZynqSLCRState *s, uint64_t ps_clk)
 
     /* compute uartX reference clocks */
     clock_set(s->uart0_ref_clk,
-              ZYNQ_COMPUTE_CLK(s, uart_mux, R_UART_CLK_CTRL, CLKACT0));
+              ZYNQ_COMPUTE_CLK(s, uart_mux, R_UART_CLK_CTRL, CLKACT0), NULL);
     clock_set(s->uart1_ref_clk,
-              ZYNQ_COMPUTE_CLK(s, uart_mux, R_UART_CLK_CTRL, CLKACT1));
+              ZYNQ_COMPUTE_CLK(s, uart_mux, R_UART_CLK_CTRL, CLKACT1), NULL);
 }
 
 /**
-- 
2.41.0


