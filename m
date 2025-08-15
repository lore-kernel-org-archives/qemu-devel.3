Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD70CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umqJT-0003b1-1a; Fri, 15 Aug 2025 05:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJN-0003Xj-QN; Fri, 15 Aug 2025 05:01:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJL-0005ZH-FG; Fri, 15 Aug 2025 05:01:21 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45a1b00a65fso8996805e9.0; 
 Fri, 15 Aug 2025 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755248477; x=1755853277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKlbqgXpe7F+soM4Wz0C9HHoN5daOXjlDdILnsR4XFA=;
 b=VjTjQ0mbVHy+umFYgNNtc8r5Ixhnf4sQY4gtK/NQzZcl7KPeO2qIU0dCsAaZl6rGd/
 YrOxaKEpnszp/m3TFuO44DZxQ8wVI9t82Z2TUNS37BTH9fJDq8JMeztBQUlETiwEN6HO
 Vadd8ITMaxIkvqJra/u3jKl2vwLarZjTbDLKEVQrs7qiooPEXXnA/iRZSgPlDfewDQen
 RZeuRbh5P+j3uF7RzeZtyPFj5YQkf2dgJdmWq4Hy1wGhteojwf7f2D1dSU0I+YnK08TE
 0qe3z51/bNnkpg8eK26RQXm/VWsUnPEiZsztZAsUgGV3qN0rIkQzXZ7HdTfUdQRItBjn
 Fj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755248477; x=1755853277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oKlbqgXpe7F+soM4Wz0C9HHoN5daOXjlDdILnsR4XFA=;
 b=llja08utGvPOxj59nX36RvkNgs5iInUaFeUpRCIo6NZmChbtkwRPvImcEHl3D4lF+D
 eKUt+QdOarRgmrRcghTDw0w4w1Mf+0m0AjTR/292cG6XZROxm/abxqi7NBLHDEmMqfw9
 yLjx4Fa3E5AjM/6S02OmlMSBHHd7eoHkT8jqshfVcDA4MOdNBy6Jawyvb5DP3/Rd2Rgi
 ySD5jpj50yiTCI/yZJ/I9OBg8rvWCWix663soeh9GeER6KmjLnVqFla4d2MuexfNmpf2
 Ohlxy3lKhPPJGH+F9iVvqCuNOms7SaRXF4nVW+LdDm0cnRoXJ8q6avwVjXxWS3qmlA3i
 sTZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2pdKPM/nvy0BVtXN/yAT9iKIbWoJ6oGNu0CN/yxmkbhGUksGed8fkuwWKbd97VrQ302hjK8kyjg==@nongnu.org,
 AJvYcCVXjMIbgYsf7gsMqsMr/U9ZH7O1RtuaG6+0HJWr6zxIy5A/xjtbK+pVSS2uENitQaQ8HwtjbYL6d3rQKg==@nongnu.org
X-Gm-Message-State: AOJu0YyUNmuZPtMq0z9U/ffAiEVcB9FZFLJW8W0B5ddK1NmDA9cNtveg
 1ZBXESbaspYRMencizklSPvkHv2CyLOSLeEXq0OkyvrF8VOmdLJ1RV/p/ANfRhs2
X-Gm-Gg: ASbGncsDbC+qdTfGOixfQiPR5I4fXH2MgDa/Ru7bT41R33sOsdzKNxr7ZQ97k+8Rezu
 E5L0KfK20bzKPFPGYGHhhITClg/Xm4U3+p5/J2saHgkzWKgfZou6kI1Da68BXP+LvtNiz4R31Eg
 cewBPIP+MB6/Kuc3VhPhKTaO5hpTwVgA1e2gIMfe0JRqp0VYgozcEsLASBB2rPggz8TvMuY+BXs
 49YBZ6zYyVeQd/oC9bKM4QUQd9vR4RWHm8IfBV/Pm4W1kyY1hp0l7D2DnStN85tn2EJ/sCYSG2x
 PiHrvp6IaHj0NuVno9UkW9ktmJHpDckEupiRHn78O8ALGa3tJRr2TKCf4KElH3D+ZLWyQUhBosK
 JFGQTpQrmXKN19HNeGmwuNIWLL8gemaDyegzKT6ql8C1x9Q==
X-Google-Smtp-Source: AGHT+IFbJdg7qm3VP9FPSMNThAnGf6yonl/zs/sUoCuL/vrRkMHSwFW0dJc7/q5x1EznsI338EUvUg==
X-Received: by 2002:a05:600c:19d2:b0:456:19be:5e8 with SMTP id
 5b1f17b1804b1-45a218595a3mr11648205e9.20.1755248476581; 
 Fri, 15 Aug 2025 02:01:16 -0700 (PDT)
Received: from corvink-nb.beckhoff.com
 ([2001:9e8:dc31:6500:43b3:5eac:8d91:b512])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a22321a54sm10964045e9.18.2025.08.15.02.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 02:01:16 -0700 (PDT)
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
Subject: [PATCH v2 02/14] hw/timer: Make PERIPHCLK period configurable
Date: Fri, 15 Aug 2025 11:01:00 +0200
Message-ID: <20250815090113.141641-3-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815090113.141641-1-corvin.koehne@gmail.com>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x333.google.com
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

The a9 global timer and arm mp timer rely on the PERIPHCLK
as their clock source. The period of PERIPHCLK (denoted as N)
must be a multiple of the core CLK period, with N being equal
to or greater than two. However, the current implementation
does not take the PERIPHCLK period into account, leading to
unexpected behavior in systems where the application assumes
PERIPHCLK is clocked differently.

The property periphclk-period represents the period N, the CLK
is devided by to get the peripheral clock PERIPHCLK. We can now
configure clock properties for the a9 global timer and arm mp
timer. That ensures timers can behave according to the
applications needs.

The PERIPHCLK period can also be set via the command line, for
example for the a9 global timer:
-global driver=arm.cortex-a9-global-timer,
	       property=periphclk-period,value=2

Information can be found in the Zynq 7000 Soc Technical
Reference Manual under Timers.
https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/timer/a9gtimer.c            | 19 ++++++++++++++++++-
 hw/timer/arm_mptimer.c         | 20 +++++++++++++++++++-
 include/hw/timer/a9gtimer.h    |  1 +
 include/hw/timer/arm_mptimer.h |  2 ++
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index a1f5540e75..83aa75889e 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -27,6 +27,7 @@
 #include "hw/timer/a9gtimer.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
@@ -62,9 +63,17 @@ static inline int a9_gtimer_get_current_cpu(A9GTimerState *s)
 
 static inline uint64_t a9_gtimer_get_conv(A9GTimerState *s)
 {
+    /*
+     * Referring to the ARM-Cortex-A9 MPCore TRM
+     * 
+     * The a9 global timer relies on the PERIPHCLK as its clock source.
+     * The PERIPHCLK clock period must be configured as a multiple of the
+     * main clock CLK. The conversion from the qemu clock (1GHz) to a9
+     * gtimer ticks can be calculated like this:
+     */
     uint64_t prescale = extract32(s->control, R_CONTROL_PRESCALER_SHIFT,
                                   R_CONTROL_PRESCALER_LEN) + 1;
-    uint64_t ret = NANOSECONDS_PER_SECOND * prescale * 10;
+    uint64_t ret = NANOSECONDS_PER_SECOND * prescale * s->periphclk_period;
     return (uint32_t) (ret / s->cpu_clk_freq_hz);
 }
 
@@ -312,6 +321,12 @@ static void a9_gtimer_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, a9_gtimer_update_no_sync, s);
 
+    if (s->periphclk_period < 2) {
+        error_report("Invalid periphclk-period (%lu), must be >= 2",
+                     s->periphclk_period);
+        exit(1);
+    }
+
     for (i = 0; i < s->num_cpu; i++) {
         A9GTimerPerCPU *gtb = &s->per_cpu[i];
 
@@ -377,6 +392,8 @@ static const Property a9_gtimer_properties[] = {
     DEFINE_PROP_UINT64("cpu-freq", A9GTimerState, cpu_clk_freq_hz,
                        NANOSECONDS_PER_SECOND),
     DEFINE_PROP_UINT32("num-cpu", A9GTimerState, num_cpu, 0),
+    DEFINE_PROP_UINT64("periphclk-period", A9GTimerState,
+                       periphclk_period, 10),
 };
 
 static void a9_gtimer_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index a748b6ab1a..767413c77a 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -27,6 +27,7 @@
 #include "hw/timer/arm_mptimer.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/core/cpu.h"
 
@@ -61,8 +62,16 @@ static inline void timerblock_update_irq(TimerBlock *tb)
 /* Return conversion factor from mpcore timer ticks to qemu timer ticks.  */
 static inline uint32_t timerblock_scale(TimerBlock *tb, uint32_t control)
 {
+    /*
+     * Referring to the ARM-Cortex-A9 MPCore TRM
+     * 
+     * The arm mp timer relies on the PERIPHCLK as its clock source.
+     * The PERIPHCLK clock period must be configured as a multiple of the
+     * main clock CLK. The conversion from the qemu clock (1GHz) to arm mp
+     * timer ticks can be calculated like this:
+     */
     uint64_t prescale = (((control >> 8) & 0xff) + 1);
-    uint64_t ret = NANOSECONDS_PER_SECOND * prescale * 10;
+    uint64_t ret = NANOSECONDS_PER_SECOND * prescale * tb->periphclk_period;
     return (uint32_t) (ret / tb->freq_hz);
 }
 
@@ -273,6 +282,12 @@ static void arm_mptimer_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < s->num_cpu; i++) {
         TimerBlock *tb = &s->timerblock[i];
         tb->freq_hz = s->clk_freq_hz;
+        if (s->periphclk_period < 2) {
+            error_report("Invalid periphclk-period (%lu), must be >= 2",
+                         s->periphclk_period);
+            exit(1);
+        }
+        tb->periphclk_period = s->periphclk_period;
         tb->timer = ptimer_init(timerblock_tick, tb, PTIMER_POLICY);
         sysbus_init_irq(sbd, &tb->irq);
         memory_region_init_io(&tb->iomem, OBJECT(s), &timerblock_ops, tb,
@@ -288,6 +303,7 @@ static const VMStateDescription vmstate_timerblock = {
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(control, TimerBlock),
         VMSTATE_UINT64(freq_hz, TimerBlock),
+        VMSTATE_UINT64(periphclk_period, TimerBlock),
         VMSTATE_UINT32(status, TimerBlock),
         VMSTATE_PTIMER(timer, TimerBlock),
         VMSTATE_END_OF_LIST()
@@ -309,6 +325,8 @@ static const Property arm_mptimer_properties[] = {
     DEFINE_PROP_UINT64("clk-freq", ARMMPTimerState, clk_freq_hz,
                        NANOSECONDS_PER_SECOND),
     DEFINE_PROP_UINT32("num-cpu", ARMMPTimerState, num_cpu, 0),
+    DEFINE_PROP_UINT64("periphclk-period", ARMMPTimerState,
+                       periphclk_period, 10),
 };
 
 static void arm_mptimer_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/timer/a9gtimer.h b/include/hw/timer/a9gtimer.h
index 8ce507a793..edb51f91e3 100644
--- a/include/hw/timer/a9gtimer.h
+++ b/include/hw/timer/a9gtimer.h
@@ -77,6 +77,7 @@ struct A9GTimerState {
     MemoryRegion iomem;
     /* static props */
     uint64_t cpu_clk_freq_hz;
+    uint64_t periphclk_period;
     uint32_t num_cpu;
 
     QEMUTimer *timer;
diff --git a/include/hw/timer/arm_mptimer.h b/include/hw/timer/arm_mptimer.h
index 8b936cceac..2c4cb5c1c3 100644
--- a/include/hw/timer/arm_mptimer.h
+++ b/include/hw/timer/arm_mptimer.h
@@ -32,6 +32,7 @@ typedef struct {
     uint32_t status;
     struct ptimer_state *timer;
     uint64_t freq_hz;
+    uint64_t periphclk_period;
     qemu_irq irq;
     MemoryRegion iomem;
 } TimerBlock;
@@ -45,6 +46,7 @@ struct ARMMPTimerState {
     /*< public >*/
 
     uint64_t clk_freq_hz;
+    uint64_t periphclk_period;
     uint32_t num_cpu;
     TimerBlock timerblock[ARM_MPTIMER_MAX_CPUS];
     MemoryRegion iomem;
-- 
2.50.1


