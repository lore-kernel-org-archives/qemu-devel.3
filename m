Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F6ED1F9A0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5kI-0001ER-Hr; Thu, 04 Dec 2025 04:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5jz-00018A-VD
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:13 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5jv-0003N7-Jc
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:10 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-64180bd67b7so922417a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 01:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764840905; x=1765445705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dD9uX6PaBNvNuAFjXV9Q7DahJDHptOizy7QDhFL8Gts=;
 b=Xaj+3bi2z29SWcHuBTqFEQKqLOo/QxCneReO0J7OGZNvlBuqggpvhOmre3qm3Bjfzs
 0xyvmkMW29FEsom/hBKNUet9I6uhklVdiIMofCmy+ueEVlyGuoAGphNgNQqNQ9Nqdq01
 CPMi64lj7EvqkIt68kPD5iq5ZzSV3nvkn6GSIz1bYyPya8V0eM9y6O75vknao/QRxxPf
 YerpzgAG9ff/FMGs5feOUP7wVlp3RhWN+BhwIdVuq8sMdq8cI4XZ6KquokkeVkbmim4e
 ZoqhBmyhmG71TzE52yOCANzUbHJXp1YODDBn0FBo6hFVK+2YpxfCLUAjJ3m2YVe/Y/Rr
 h64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764840905; x=1765445705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dD9uX6PaBNvNuAFjXV9Q7DahJDHptOizy7QDhFL8Gts=;
 b=Evh0uXrNcQI7V7sALLxbPMSrVGWR7f7bgQv8hb+2DaYzBQB6ML+7xxAxHxBPIbLzqg
 T4M1xt7k2nreecJ6G47D4XIxjZDGR5/fi/tezNBcdVVX76qGCrWahxq6nYui3siAXQlM
 tt0taFOmYXZhYam5fzIGZI+9QhulLJQmTwxzU93uWwrdku1P15f4X4Al0GB0wyRXDv6X
 DgIuCPUGwhpEf4iPVVPVP4S2F9iiMQuM2jsTY/3yAzegPwzvNkc2QpyazvNojKxNe9V7
 o3hH8OdtCB+KAw6d/QUSP5MmfqQVEg3o5yHJg9HwI0gz9r+xfQmKQX++WyMZzBUF+Db9
 Q3+w==
X-Gm-Message-State: AOJu0Yydj9JJ5NISWVkjb1YMUVkBCMcque/UKhs1mkyc/BLz1EbQoq1p
 mAvUWYNI/hmhrEGZR+qolQh3v0r8R4fL1Min3Nei4hbAKwFExvV3EE8uXRji01/0
X-Gm-Gg: ASbGnctSl1beYwyPI+0OoxrURvwKvSTSjL3zJs2a+0LLaiItV3HXFCgPZRwdonDPBU1
 6zJTojXJg84x8vlfGlgk7ZK3Tqyn3MWp18rJpNQBWY9GLa4xZjoz39phnxQ6GoeZW1DZr6Fuu+a
 Yd8U1OplORO9GgYBMCaKNqIeJkwp8fXyP4pzr39Xy/BqubLzJGZQmupNd086Az9mgWGtq9JoqJp
 bFuYPXR2m6EOniSw+cePQ/1mYsQBzhGHnLY4D0GXZZ26J16Y6g1Yiggv64ZSLsOHPaXTASC7whc
 BqS3UACoSAz+59x5w8MxQIUO4l2WbUdw8EjCAtKVO5DBzCiDs9fv39ztM3jQ3t9MhTNI8zOjR9Z
 mNifGBemLUhOyUwQUwzCEk2iKAyWJpEQC6zK+IunuRpvrnAJASJhbyyjAuMZL4U8nL13+iij/20
 nVN2e/FfVoufKk0NMN+CrhYmuqsccMm6A=
X-Google-Smtp-Source: AGHT+IE6d/SHN2OcrtrFj1TBqwCEjZQSDjJXv7k71DKG6n9hi6fDLIvewnwQZsYMCA7/FWlifx46kQ==
X-Received: by 2002:a05:6402:2807:b0:647:5c27:5440 with SMTP id
 4fb4d7f45d1cf-6479c49c55cmr4840711a12.24.1764840904695; 
 Thu, 04 Dec 2025 01:35:04 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2edf72asm856573a12.11.2025.12.04.01.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 01:35:04 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v5 01/15] hw/timer: Make frequency configurable
Date: Thu,  4 Dec 2025 10:34:48 +0100
Message-ID: <20251204093502.50582-2-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204093502.50582-1-corvin.koehne@gmail.com>
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x531.google.com
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


