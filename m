Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731D8CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIlcb-0008Dl-SJ; Tue, 11 Nov 2025 05:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcH-0007Vc-J8
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:28:49 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcB-0000Fa-16
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:28:46 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b7321b03aecso89215766b.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 02:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762856919; x=1763461719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zu0Rm6kaYJRSMkds5jE0Qr5Ypoby5zFJAM6oroUc1k=;
 b=OqBcmjvmU8xp0wthNlysJeDhXQXIULa6Aqt7adSKaEeVTPedwQvOyr4t1EAVt4m6Ye
 CZpWQ/OU8SMXj9XO7VJWyYI/OrLuXKCTBnQeBNwV56E8jIGJR3cFfHZ6uURNa+VLIags
 ADZNnYiib2uqBAIeZESI5dkMAVc3S+0dGu/ZPXiFxzW9X3mNpD4MLohWqOPrR/n08HIl
 lnbZiUm7VO2o7t7pEbYfNB29uF8naT/BOwmii+6zezXR7pTTHeOWuWydp/dyIQt2Fpcp
 MJqVTjzCzGV6GqXSAg1zfXrXZ1iVj4g8qwvCnw43j1zem1RTTUoIcH8jzoaPJQ1C1/E4
 0Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762856919; x=1763461719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4zu0Rm6kaYJRSMkds5jE0Qr5Ypoby5zFJAM6oroUc1k=;
 b=TEAEjcNZG1U+L6HvpyKQFNp5PHFhnwlbzew8bJzQek7Dk6CtRIoUIAs7kAcDnqfhlw
 4EdB4m6q6KMRf8aOXF90iG+beo5p5wH9h/7A17GZ1NKSK+vbY4iwGd+6gbj1an4cE0KC
 JEgy687Yimistk8cjLWPDQfu8U85i/VOBP/ru42NbjioH+4hlpcNGDZEz74gsem+na9b
 w3xjQfrtqHbHrPdEY9B3foe+IoynA7bsnS/cKF8xHJ5JenGDmSwOI405g6LEep7LJL4Y
 1h8cvzBmMDboAMTLUD6SjjEdY7sDn2kaHqSeOtC+my9W7eJMYBcJGxxrbdhTaAQmsZob
 4EBw==
X-Gm-Message-State: AOJu0Yw3Ow1gbvv0vB7DZE0ScKWfJ+X0I8EIJiJ/63yTa8hkIiCHeCkM
 r7AZo9zgEacnJ2L2oLph4LTKQ8lpiyGB6cBmB6J1ELMyxRYgBblQfWmGhCg9P2EJ
X-Gm-Gg: ASbGncthyjtzKf22IFygUR3XM9XI8MTA1m6ip/yg18kWxfEJMIGbL1zS/Nq3z0JBk4/
 Fp3rgtNRSNx9RHDdgnLU3Zg3sr7yUXPJE6Juw/sgY/7Rgo/Hsv1hrLPMbvgBUMs4g00zs8O+jQD
 mBVawEmpHDgGaqWkxz8L0ubtfVdtntT/ps59W8nygdDil0L9mmfJ+SMwVRNDZMHbq+IZ/2EbqFq
 5LjUp8IDxbxSXD1hvumM4l6MBv/b4WBdhZMLoRtHw/4h9S6Jhst0SHEB5nrqw/mB4ByN6fzrM8O
 VzBauzmubQ9n/ZkGfW2i4Kqbw0znUcZgkFEMf7yYnoWoHU93dMtlayIN73L3BGk/TomjGvi1Hdo
 Zm5ALL7O93ye4CM6fGWrXoZvWL9TVdnXqf3h7poef2oUsAmzo3Z06c8tA+vJunpR3rdTbuaddbt
 6wrHsQVjSboET4TjxvqVY7FA==
X-Google-Smtp-Source: AGHT+IGKJxSK2MsTiZQr6YSNqN+N8dUmQNNXUM73L+gy87N6msmi8tJWFcz6kE6LzJQ4C7TvWayVSQ==
X-Received: by 2002:a17:907:3c91:b0:b3c:193:820e with SMTP id
 a640c23a62f3a-b72e02ca102mr1162872066b.13.1762856918877; 
 Tue, 11 Nov 2025 02:28:38 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc12:ce00:ae91:a1ff:fe8b:15a7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bdbd1ecfsm1290619366b.10.2025.11.11.02.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 02:28:38 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v4 01/15] hw/timer: Make frequency configurable
Date: Tue, 11 Nov 2025 11:28:22 +0100
Message-ID: <20251111102836.212535-2-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111102836.212535-1-corvin.koehne@gmail.com>
References: <20251111102836.212535-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
index 9835c35483..090d14c683 100644
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
index 803dad1e8a..cae07090f9 100644
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


