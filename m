Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08A0CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xeM-0001xm-I4; Wed, 15 Oct 2025 05:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xe6-0001pi-Ps
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:12 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xdl-0007Bk-MM
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:09 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b41870fef44so491070366b.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760519862; x=1761124662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dD9uX6PaBNvNuAFjXV9Q7DahJDHptOizy7QDhFL8Gts=;
 b=hMdCQWsNKd4NetYe7OEnS64akGFKWuBwmAo0rHa1o1HYeMjQy9u7AdmV9IdlvY7qdM
 m5uPQQQjmchXSF6a9reTaHLjrqosVupVj/xbP8/C7mG3AVOwsUlvdqOT+vHGabY1XotF
 /ZjF4e3eLY+hFa2Cvw6ZpJlBqzNZBn5uuRVx6uWHLcN/4YioLubCrXSOzKxUmBGznvhW
 uajAzqDHzAAcaygPjwuhr0PHD3DUyNyQLAiE9AJHjER2uYr8tKmsiHRKa5WL+X8yX8Ha
 xcOpfMEdeWooeW9kakOcvla0UqcZMX8X6YlzYGkS7t9IcouX6bw4v2rCBFyRlA1ZclOt
 CTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519862; x=1761124662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dD9uX6PaBNvNuAFjXV9Q7DahJDHptOizy7QDhFL8Gts=;
 b=gyiSUJhnSIHnobDg2Zn9PY4Fr9FIf77tBy5u6A/mrFjJqW5LEEitWHvEJyeZXLhjiq
 YPoPCCwN/xocWCFK4N2WG5iJWxaFwM+3c+sGXlnt8H6YWXAh8piL7rC2HdeQqi2He57Y
 MB3Lmd3IqcMPPstN53txbLkO3SrFkzWaScsBmODR0/61uW8WSeSzZDBNHTUbdvTo2IPr
 0bkxZTmh++tD8//1Y7VzMoUM23sA3XI9fCFGDB3HZ0zTligpSqiv2Q9esrG7I9HzvDEr
 ggeFCkgN0mB7pUUFLB5P8ZLaY4MOGy3yyzBRHs0qgP1pHb1m7gTxJdjvt5pIF//UFD64
 lR2w==
X-Gm-Message-State: AOJu0Yyj2k7kDOM6m+MCXRm9UqMpG6prnAIDXpgzjMYF38u024aP47Kh
 8OYY1CzlYBYFkIRauQOEdEyH9IGOCQIfA3OSLbsYbHrKtXrk+ahVDlFhfZ+2RuYxcs0=
X-Gm-Gg: ASbGncubyi2P3UWbx82D1OszqjBVRe1wfDigYQTksf7tESQ93Derg5wTpmCGl+lNFtk
 5pNhBDiaPu6aGqx9YI3L5KPtN/v5C7J4CY7L12LF7vKws65bt1Yq9Z33BkzaxiVdUbzVj2dLmel
 0wWhPdWXzxKwFryi1Yv2+GUvVDEa4q/5GwxQ1y5wuT7vnqz0rswXoHUKUXQEkhoQHuwaVfs2aTy
 GZxIQcUT4HirFtHcWg8Z6gkIfuJ7dgtrVTMSqlJwwv64fib2w5Lw9BQSB69bEwfUkp1DxuaG2GX
 vZH9lnW4DFX+SnIh7wV6PNTwsAUTVm5u6/UDPuvn7RAQKYEKuGv+MQ33zY3nr/D5wUKaXANp0rh
 C2RCSJJyQzadcZPvsKYA3xUEhlrSH0pkg6GJ7X9iVKYJ1fcQHhZF09uasoj3WS+0s0ix4L3kR
X-Google-Smtp-Source: AGHT+IFn+Jxc4SgpAXY72JjpWx+qqMtm+cS8pd7JnLXg7lsD9pjCYZCnrynqxVjYC2WqHyUIITBJIA==
X-Received: by 2002:a17:907:7f0b:b0:b46:31be:e8fe with SMTP id
 a640c23a62f3a-b50aa48c4f0mr3042696566b.11.1760519861994; 
 Wed, 15 Oct 2025 02:17:41 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cb9e7a23dsm182069966b.23.2025.10.15.02.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 02:17:41 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v3 01/14] hw/timer: Make frequency configurable
Date: Wed, 15 Oct 2025 11:17:16 +0200
Message-ID: <20251015091729.33761-2-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015091729.33761-1-corvin.koehne@gmail.com>
References: <20251015091729.33761-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

The a9 global timer and arm mp timers rely on the PERIPHCLK as
their clock source. The current implementation does not take
that into account. That causes problems for applications assuming
other frequencies than 1 GHz.

We can now configure frequencies for the a9 global timer and
arm mp timer. By allowing these values to be set according to
the application's needs, we ensure that the timers behave
consistently with the expected system configuration. The SoC
configures the device correctly.

Information can be found in the Zynq 7000 SoC Technical
Reference Manual under Timers.
https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/timer/a9gtimer.c            |  9 ++++++---
 hw/timer/arm_mptimer.c         | 15 +++++++++++----
 include/hw/timer/a9gtimer.h    |  1 +
 include/hw/timer/arm_mptimer.h |  2 ++
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 690140f5a6..ad9abcb4bb 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -63,9 +63,9 @@ static inline int a9_gtimer_get_current_cpu(A9GTimerState *s)
 static inline uint64_t a9_gtimer_get_conv(A9GTimerState *s)
 {
     uint64_t prescale = extract32(s->control, R_CONTROL_PRESCALER_SHIFT,
-                                  R_CONTROL_PRESCALER_LEN);
-
-    return (prescale + 1) * 10;
+                                  R_CONTROL_PRESCALER_LEN) + 1;
+    uint64_t scaled_prescaler = prescale * 10;
+    return muldiv64(scaled_prescaler, NANOSECONDS_PER_SECOND, s->freq_hz);
 }
 
 static A9GTimerUpdate a9_gtimer_get_update(A9GTimerState *s)
@@ -374,6 +374,9 @@ static const VMStateDescription vmstate_a9_gtimer = {
 };
 
 static const Property a9_gtimer_properties[] = {
+    /* Default clock-frequency is 1GHz (NANOSECONDS_PER_SECOND) */
+    DEFINE_PROP_UINT64("clock-frequency", A9GTimerState, freq_hz,
+                       NANOSECONDS_PER_SECOND),
     DEFINE_PROP_UINT32("num-cpu", A9GTimerState, num_cpu, 0),
 };
 
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 7cc5915e9e..342ca1276a 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -59,9 +59,11 @@ static inline void timerblock_update_irq(TimerBlock *tb)
 }
 
 /* Return conversion factor from mpcore timer ticks to qemu timer ticks.  */
-static inline uint32_t timerblock_scale(uint32_t control)
+static inline uint32_t timerblock_scale(TimerBlock *tb, uint32_t control)
 {
-    return (((control >> 8) & 0xff) + 1) * 10;
+    uint64_t prescale = (((control >> 8) & 0xff) + 1);
+    uint64_t scaled_prescaler = prescale * 10;
+    return muldiv64(scaled_prescaler, NANOSECONDS_PER_SECOND, tb->freq_hz);
 }
 
 /* Must be called within a ptimer transaction block */
@@ -155,7 +157,7 @@ static void timerblock_write(void *opaque, hwaddr addr,
             ptimer_stop(tb->timer);
         }
         if ((control & 0xff00) != (value & 0xff00)) {
-            ptimer_set_period(tb->timer, timerblock_scale(value));
+            ptimer_set_period(tb->timer, timerblock_scale(tb, value));
         }
         if (value & 1) {
             uint64_t count = ptimer_get_count(tb->timer);
@@ -222,7 +224,8 @@ static void timerblock_reset(TimerBlock *tb)
         ptimer_transaction_begin(tb->timer);
         ptimer_stop(tb->timer);
         ptimer_set_limit(tb->timer, 0, 1);
-        ptimer_set_period(tb->timer, timerblock_scale(0));
+        ptimer_set_period(tb->timer,
+            timerblock_scale(tb, tb->control));
         ptimer_transaction_commit(tb->timer);
     }
 }
@@ -269,6 +272,7 @@ static void arm_mptimer_realize(DeviceState *dev, Error **errp)
      */
     for (i = 0; i < s->num_cpu; i++) {
         TimerBlock *tb = &s->timerblock[i];
+        tb->freq_hz = s->freq_hz;
         tb->timer = ptimer_init(timerblock_tick, tb, PTIMER_POLICY);
         sysbus_init_irq(sbd, &tb->irq);
         memory_region_init_io(&tb->iomem, OBJECT(s), &timerblock_ops, tb,
@@ -301,6 +305,9 @@ static const VMStateDescription vmstate_arm_mptimer = {
 };
 
 static const Property arm_mptimer_properties[] = {
+    /* Default clock-frequency is 1GHz (NANOSECONDS_PER_SECOND) */
+    DEFINE_PROP_UINT64("clock-frequency", ARMMPTimerState, freq_hz,
+                       NANOSECONDS_PER_SECOND),
     DEFINE_PROP_UINT32("num-cpu", ARMMPTimerState, num_cpu, 0),
 };
 
diff --git a/include/hw/timer/a9gtimer.h b/include/hw/timer/a9gtimer.h
index 6ae9122e4b..3b63d14927 100644
--- a/include/hw/timer/a9gtimer.h
+++ b/include/hw/timer/a9gtimer.h
@@ -76,6 +76,7 @@ struct A9GTimerState {
 
     MemoryRegion iomem;
     /* static props */
+    uint64_t freq_hz;
     uint32_t num_cpu;
 
     QEMUTimer *timer;
diff --git a/include/hw/timer/arm_mptimer.h b/include/hw/timer/arm_mptimer.h
index 65a96e2a0d..da43a3d351 100644
--- a/include/hw/timer/arm_mptimer.h
+++ b/include/hw/timer/arm_mptimer.h
@@ -31,6 +31,7 @@ typedef struct {
     uint32_t control;
     uint32_t status;
     struct ptimer_state *timer;
+    uint64_t freq_hz;
     qemu_irq irq;
     MemoryRegion iomem;
 } TimerBlock;
@@ -43,6 +44,7 @@ struct ARMMPTimerState {
     SysBusDevice parent_obj;
     /*< public >*/
 
+    uint64_t freq_hz;
     uint32_t num_cpu;
     TimerBlock timerblock[ARM_MPTIMER_MAX_CPUS];
     MemoryRegion iomem;
-- 
2.47.3


