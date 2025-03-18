Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DF3C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWgv-00062t-AY; Tue, 18 Mar 2025 09:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWgq-0005mN-0H; Tue, 18 Mar 2025 09:09:04 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWgm-00037E-Uz; Tue, 18 Mar 2025 09:09:03 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so513033066b.3; 
 Tue, 18 Mar 2025 06:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303339; x=1742908139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCS//sQC/Pd3mJsOjU1j+UGkPkKFk8gzbUC/mzKDYOc=;
 b=kgHvL0MYi4zAf/Dk0++e8t+MubG60EzFUHfEGen7OrfenXx6hrvk8z0hEPNeqJOGR6
 MZCQOvkVvOIXtWDQ6B6mY1xRGLslIpu+hiDXrC/sAYdmNrnKEer7KfSHWB49/E/4Ea1L
 W9/4eqWMFwo3HtmqDaUnH8MeTXT1DgISEZlpBt85EX2XEkLE0MBuCx+D1OnS3U4NP1Wc
 nnurCUtPNK4JMT469VZ+bs24cE4eleVoz0AEk7xeTaoZ7i6dedpSTwCUoDweWwmLBgMg
 4e9Tbi/FZsc3twwix4kGW88G5xlG++l2iUIkjCfP+KP7rTUse2XEe5oH8okIiCqSNEDw
 tsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303339; x=1742908139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCS//sQC/Pd3mJsOjU1j+UGkPkKFk8gzbUC/mzKDYOc=;
 b=p0r1W+pUB6oAHGiJD+KuZCwRCAOiAmzxjwcu0Uqvpyqq3lN8/soyC5wO06zjUAIRko
 QLH3PyCMBm3ihRQ9t14uobWW0WaZItOQhf5U7WVSjZ0O7zKiHuPlpW2XXIF4G2dIzYJg
 Up99bpITXYNzWDkl2AyvRXGhME1gh30OaeeDK+ju4vUS4n88V5OP73wZ/U5Ao1oqCVPb
 23wxzilmH7SDM4EuuVfP2q9p1r3zcIRxCMQ3Hd9QPx9BUV2ZpN1vsnrBE2EPCxOUxBho
 xt+fhoZcQ/FodBhJC95E4eXHA40otW1XUpqf/xvwsh9GWDgWnHi1umDxMQOgtdp2Hw4K
 R66Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtUCJYtjNE5+0XJdB3z1CLrqOCp31NExDvQkIZiQTh44SCNhcMtlovCA7XrMBKbEftqYhVEJXpYA==@nongnu.org
X-Gm-Message-State: AOJu0YzDO3s5z0hB8UklA2yBR1AUbBHM3+QvGbVSsIvvBOesHoPKfsY8
 ozkBfGMtE6Szck3tGiUB+oLgVkFdPLXTFXintTkVuZrAaNFnRMyTZU+YJg8S
X-Gm-Gg: ASbGncuc2cCdWsOjxxhX1crc93L/Ho5N5LRsfaQMSNGsDAbNPdaOnWQoRAq7qdQ+4Js
 AJ3iz6tRaYd2oCrEkFZpBlea73nL6wqnPEbwCdWWREjV5VerOxpFniqxtK/YU90NvEPuoGFYGSv
 FRCrO9p1WxRFZ8T4aQcBCUuIbqZsnlYmDz4MCYsj+8XcfMNAwnpP31ujyzrlKRskbfmzHhvgE+d
 3TNgUL9oZaxWBl9Ly2EGMLCZJK3DjSUaLTTHYK4AaoLT8KgFxpbGFLbwcetlRn/nHOtT6nE0sJA
 MF+dkF+IHE9+p63Cxb+Sqx0qUJS375hCRnC5NeoqqqQ7DUR0rj/87Uls0U89PIcuoAGhU0XzuBr
 qog==
X-Google-Smtp-Source: AGHT+IGthgh2JCMge8aKmPYzXb+hQCwzKN1UHgrNMMhr8esvu9jlzrLtxc/TLtb9yAmLVo8MDZIXLg==
X-Received: by 2002:a17:906:6a27:b0:ac2:7be7:95c5 with SMTP id
 a640c23a62f3a-ac3303225c3mr1741297866b.33.1742303327933; 
 Tue, 18 Mar 2025 06:08:47 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:08:46 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>, YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH 01/21] hw/timer: Make frequency configurable
Date: Tue, 18 Mar 2025 14:07:52 +0100
Message-ID: <20250318130817.119636-2-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318130817.119636-1-corvin.koehne@gmail.com>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x630.google.com
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
2.49.0


