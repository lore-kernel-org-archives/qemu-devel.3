Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E33CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umqJQ-0003ZO-5h; Fri, 15 Aug 2025 05:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJM-0003Wm-N2; Fri, 15 Aug 2025 05:01:20 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJK-0005Z4-Gk; Fri, 15 Aug 2025 05:01:20 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b9d41bfa35so1456055f8f.0; 
 Fri, 15 Aug 2025 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755248476; x=1755853276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=btWRctgXmqOAjXkvhCM7gh0k0uVSvkROM7NTsMMO0EE=;
 b=mNj2lg48fGVcmIxpNuyVTaAzkV+lHIQANg/vvkPLMDcmznxbBkjBGfzSY8dDAwVR9J
 ZvZEtCkLD6oWDlwg6JFeOF+aYePLsygMAqQcLbm0LNgVXSqX9BCqxoYtXkp3kkpnHrPY
 yErmtd/PuymLbQKo7jR9Fnzhp36h/rK20JAf2jZHZSB9hClk9Y1SVxvghbwN5YW0kF5O
 fiOUpYLvbD10rfjZ+j7fVuOLPXpDqSaJFFs9M1yxBhW/zaJa/AzhiEPkdQ7C7lYpTcda
 G/Ed/5ejYQD9QF4VpiZwDXS8+ENoPavY+TttHbQnORwqL4+uVLqVUG1s4Zt8E62Hedze
 +MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755248476; x=1755853276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=btWRctgXmqOAjXkvhCM7gh0k0uVSvkROM7NTsMMO0EE=;
 b=sxDogJW376Wolr8t6AZw6Fhl9VY7dIZth2eOMrV65hGu7kayS8nXN1SEV9T1HJWRKB
 oIKPshKJpLUsBCTGP4x8GurayfS0d5Wb8k2tmqUipt677g4Lf3IJb+DMDXFuxsHHJspB
 5JW2/5Xs2x3qIBXtesGmU5EDL/zYNcaRGBkt0rCaV9W4wAvpWJYkA6gKGgGYK7bNa4XO
 fKlFWS54DF1GLRDdMJ4GGP+R5BjxwjAFe/9Fr4hk8Denn4zvN2b3DzNDxo3hqvbdHQWq
 XWYqhZTAmFx8D1+IPzCjbJ39RjGiWlIWSocXvfkteYTwravvNNdk2R4j3Gmi6TCH2/j2
 Vlyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQSGnCHagtPY1S30Azh55jwmlSdrNA9XITRSX5/llil3QkHlUukRq/Me4rWfoDLemmGgVwZmURaA==@nongnu.org,
 AJvYcCWs8yVrNTt+fjgqqoXu9FRFzt9yKeWClADq8mFpttYtTd7jSpd2xNb0UbG7S7B+r4jFQD5dy79diwQ1EQ==@nongnu.org
X-Gm-Message-State: AOJu0YyW+n4uGdT0lhph7SbxICw1ljy6WrQKNvqMw+kCMwg64geOTVGb
 aN2nqMjRHeGNRW7HyelTGYs7eyq0ENtU7OAHbE0Gqjztbqnf+HBwQNT+n855ckML
X-Gm-Gg: ASbGncvpSB75VKmPI7bkP+3BYJJosTnhsTjxEUCBz4nfUHiJdeP0/PmMFJepAMCwq0c
 wl/dWEPVLVssKRsuBSl3I9NaIB5wxT2jTHjFf2Aypm51hFZysGmRN8PKtjmGZZuddIICdTNcQ9s
 ES+YnOs6InFDWfXBbXxFTBrLuht41lbam7SGq7RyhNYAzU9N+mAwdWt9uxqrlmZsl6X4dzVzwhy
 VkUrMWNIBE7UovHHlk25Ke07H+4MUncTEHH1eRfVyh1BkjLWBuLL0sPR8VcYUimAwB6vERacebl
 Vx540bGSygGG9D7vxc0USz8xj5NPoKlgLXNjOHtBCZAjze93Qubo9gjl69UZibws3AJHoxHyKEv
 1ZaGrqD3HY74aXye3xslwUiB9pDIsokJk0CQWrVRTYSJGXQ==
X-Google-Smtp-Source: AGHT+IGDu3SSKg/iY77neNRxrt6vuPfYBWcJ6kzwQHruj6G8iew5kjvxEYgGu+eUC041wiut3IPwCQ==
X-Received: by 2002:a5d:5887:0:b0:3b9:15eb:6464 with SMTP id
 ffacd0b85a97d-3bb66f11537mr978133f8f.15.1755248475653; 
 Fri, 15 Aug 2025 02:01:15 -0700 (PDT)
Received: from corvink-nb.beckhoff.com
 ([2001:9e8:dc31:6500:43b3:5eac:8d91:b512])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a22321a54sm10964045e9.18.2025.08.15.02.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 02:01:15 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v2 01/14] hw/timer: Make frequency configurable
Date: Fri, 15 Aug 2025 11:00:59 +0200
Message-ID: <20250815090113.141641-2-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815090113.141641-1-corvin.koehne@gmail.com>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wr1-x429.google.com
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
consistently with the expected system configuration.

The frequency can also be set via the command line, for example
for the a9 global timer:
-global driver=arm.cortex-a9-global-timer,
	property=cpu-freq,value=1000000000

Information can be found in the Zynq 7000 SoC Technical
Reference Manual under Timers.
https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/timer/a9gtimer.c            |  8 +++++---
 hw/timer/arm_mptimer.c         | 15 +++++++++++----
 include/hw/timer/a9gtimer.h    |  1 +
 include/hw/timer/arm_mptimer.h |  2 ++
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 9835c35483..a1f5540e75 100644
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
+    uint64_t ret = NANOSECONDS_PER_SECOND * prescale * 10;
+    return (uint32_t) (ret / s->cpu_clk_freq_hz);
 }
 
 static A9GTimerUpdate a9_gtimer_get_update(A9GTimerState *s)
@@ -374,6 +374,8 @@ static const VMStateDescription vmstate_a9_gtimer = {
 };
 
 static const Property a9_gtimer_properties[] = {
+    DEFINE_PROP_UINT64("cpu-freq", A9GTimerState, cpu_clk_freq_hz,
+                       NANOSECONDS_PER_SECOND),
     DEFINE_PROP_UINT32("num-cpu", A9GTimerState, num_cpu, 0),
 };
 
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 803dad1e8a..a748b6ab1a 100644
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
+    uint64_t ret = NANOSECONDS_PER_SECOND * prescale * 10;
+    return (uint32_t) (ret / tb->freq_hz);
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
+        tb->freq_hz = s->clk_freq_hz;
         tb->timer = ptimer_init(timerblock_tick, tb, PTIMER_POLICY);
         sysbus_init_irq(sbd, &tb->irq);
         memory_region_init_io(&tb->iomem, OBJECT(s), &timerblock_ops, tb,
@@ -283,6 +287,7 @@ static const VMStateDescription vmstate_timerblock = {
     .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(control, TimerBlock),
+        VMSTATE_UINT64(freq_hz, TimerBlock),
         VMSTATE_UINT32(status, TimerBlock),
         VMSTATE_PTIMER(timer, TimerBlock),
         VMSTATE_END_OF_LIST()
@@ -301,6 +306,8 @@ static const VMStateDescription vmstate_arm_mptimer = {
 };
 
 static const Property arm_mptimer_properties[] = {
+    DEFINE_PROP_UINT64("clk-freq", ARMMPTimerState, clk_freq_hz,
+                       NANOSECONDS_PER_SECOND),
     DEFINE_PROP_UINT32("num-cpu", ARMMPTimerState, num_cpu, 0),
 };
 
diff --git a/include/hw/timer/a9gtimer.h b/include/hw/timer/a9gtimer.h
index 6ae9122e4b..8ce507a793 100644
--- a/include/hw/timer/a9gtimer.h
+++ b/include/hw/timer/a9gtimer.h
@@ -76,6 +76,7 @@ struct A9GTimerState {
 
     MemoryRegion iomem;
     /* static props */
+    uint64_t cpu_clk_freq_hz;
     uint32_t num_cpu;
 
     QEMUTimer *timer;
diff --git a/include/hw/timer/arm_mptimer.h b/include/hw/timer/arm_mptimer.h
index 65a96e2a0d..8b936cceac 100644
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
 
+    uint64_t clk_freq_hz;
     uint32_t num_cpu;
     TimerBlock timerblock[ARM_MPTIMER_MAX_CPUS];
     MemoryRegion iomem;
-- 
2.50.1


