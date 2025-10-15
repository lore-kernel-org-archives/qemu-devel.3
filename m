Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76F8CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xeI-0001tA-Jn; Wed, 15 Oct 2025 05:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xe2-0001n6-30
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:08 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xdi-0007Bv-BI
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:00 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b00a9989633so157952366b.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760519863; x=1761124663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8m7VawR/OxqHvIOhqF6CI4yFuFJqXm6ZRHJgBXFIs2k=;
 b=MbFB7jtQd2DQmSoDjZoRHdKW5qxDLXcH8E7kyTGP+oye5RHf3f4hpRftMPhB2v/rt2
 RdceKreOISdnFtqD2g+xrJnNI3ey2qZs1K1g1O3kwN5c2lIfGpslUHeVJcmmTUi3mSRj
 DIsS1jQktQdW5Qs0lK7nYypkJTXd9eDKrSK2rpqZf91Tm3jU5cPTr8bNOUZ2NMj/3Tqy
 rAhMGFl2gk56TCGoC5APFkzCtTYeL8BiSmGe8gwLmXv3kKX4eZk8LQCYORn8Q+V5eHvI
 qhyuUDnSI8SqO+pUWFasdSBhVQuNACKDBbcb0w4JdMIBtIYAMGpM9FEzdTdAnOPHT314
 iGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519863; x=1761124663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8m7VawR/OxqHvIOhqF6CI4yFuFJqXm6ZRHJgBXFIs2k=;
 b=IsUd/hwu2OZGMyUMcmhtJspx+b91VWOLSTW9E6xlzHWAU17WdNU3VAFyjfX2pn52Jz
 9rFh9j7vEJrwDF1Rm3iRwTrjp5plW28dlt3clYK6BRuMfhzHPzrgeDt6Mz0sAZ2tDA0j
 mUwNNYeGoNPtRref8W4r4kPSpOURNQ4k9w0QFG13+nGogyajV1Ec8SE7Ao9LbnWQJ+6J
 jWoQ7sq35vfNT4YPcqTm0dTDk9J57kONJzT6eyjlblDyOaSRt7yW8a49qXVH/uJjZwnb
 rJf57zQcrDu/nEN9kjarUQK3MiEIWo3WRK5WVCkK2/x/nKd5aGbotYIa7JtTR4uunqY6
 A4fg==
X-Gm-Message-State: AOJu0YzHRWL+SQkD3YsIw72IXfdaUueAseF5c5CN31AQ449FLU3CUpwq
 J3yj/llNwOhdnQw7p66p8E7tydeFyqQNc0Xi5Ci65rToMKjRZMOwdlWkL9szWnRa3O4=
X-Gm-Gg: ASbGncvczPHHhh/asLzJKrfHy5JfnXXfp+/a6RXl2nDMBUxwUoBq//EuNNMaTzbFmqy
 ZHd0DtGQWYerNpoFKTTeyd6i+gGiJX9pzdokik1ODDY35lHIdx56yhxNhMWV7LovBu4Q05d2Rvx
 dzTxsjvkHU1gCuEu8BcozzCBTRcr7rosTAk7ntjvIh937IoLq6GmCQwPbs18uS/muupObvVIm6V
 Y4++3tLnBNcBfZd3gnn4Pb2OOaTo8lAigQv7+xPqDaucf+gkbGULNwqJY9PodVon5MXwJSTsoc6
 6QnJCWynhRk7RMfIV6ekibZGPtDAt9FV7DjxONQVrLU8fflu+BUl5VP68jDyTm1heqoSDnTYhQi
 vM+JCEzchjIx9ty63727kgxy1BAkhEghrZhwaZ61w9TbA0FOH9nHUqxIRUU/2ujokFC7l+2YO
X-Google-Smtp-Source: AGHT+IFJvQJYBuyhdCLuAI9rl/toqlfqnx92EsYwa0SXLO6F4eUuNOuaNQVmAV+lzCoh286Ms7d17g==
X-Received: by 2002:a17:907:8694:b0:b40:7305:b93d with SMTP id
 a640c23a62f3a-b50bcbe2701mr3405313066b.2.1760519863120; 
 Wed, 15 Oct 2025 02:17:43 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cb9e7a23dsm182069966b.23.2025.10.15.02.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 02:17:42 -0700 (PDT)
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
Subject: [PATCH v3 02/14] hw/timer: Make PERIPHCLK divider configurable
Date: Wed, 15 Oct 2025 11:17:17 +0200
Message-ID: <20251015091729.33761-3-corvin.koehne@gmail.com>
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
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The A9 global timer and ARM MP timer use PERIPHCLK as
their clock source. The frequency of PERIPHCLK is derived
by dividing the main clock (CLK) by a configurable
divider (must be at least 2). Previously, the PERIPHCLK
divider was not configurable, which could lead to
unexspected behavior if the application exspected a
different PERIPHCLK rate.

The property periphclk-divider specifies by which value
the main clock is divided to generate PERIPHCLK. This
allows flexible configuration of the timer clocks to
match application requirements.

Information can be found in the Zynq 7000 Soc Technical
Reference Manual under Timers.
https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/timer/a9gtimer.c            | 19 ++++++++++++++++++-
 hw/timer/arm_mptimer.c         | 19 ++++++++++++++++++-
 include/hw/timer/a9gtimer.h    |  1 +
 include/hw/timer/arm_mptimer.h |  2 ++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index ad9abcb4bb..8b4c6d7e6a 100644
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
-    uint64_t scaled_prescaler = prescale * 10;
+    uint64_t scaled_prescaler = prescale * s->periphclk_divider;
     return muldiv64(scaled_prescaler, NANOSECONDS_PER_SECOND, s->freq_hz);
 }
 
@@ -312,6 +321,12 @@ static void a9_gtimer_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, a9_gtimer_update_no_sync, s);
 
+    if (s->periphclk_divider < 2) {
+        error_setg(errp, "Invalid periphclk-divider (%lu), must be >= 2",
+                   s->periphclk_divider);
+        return;
+    }
+
     for (i = 0; i < s->num_cpu; i++) {
         A9GTimerPerCPU *gtb = &s->per_cpu[i];
 
@@ -378,6 +393,8 @@ static const Property a9_gtimer_properties[] = {
     DEFINE_PROP_UINT64("clock-frequency", A9GTimerState, freq_hz,
                        NANOSECONDS_PER_SECOND),
     DEFINE_PROP_UINT32("num-cpu", A9GTimerState, num_cpu, 0),
+    DEFINE_PROP_UINT64("periphclk-divider", A9GTimerState,
+                       periphclk_divider, 10),
 };
 
 static void a9_gtimer_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 342ca1276a..cf434ca2f4 100644
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
-    uint64_t scaled_prescaler = prescale * 10;
+    uint64_t scaled_prescaler = prescale * tb->periphclk_divider;
     return muldiv64(scaled_prescaler, NANOSECONDS_PER_SECOND, tb->freq_hz);
 }
 
@@ -273,6 +282,12 @@ static void arm_mptimer_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < s->num_cpu; i++) {
         TimerBlock *tb = &s->timerblock[i];
         tb->freq_hz = s->freq_hz;
+        if (s->periphclk_divider < 2) {
+            error_setg(errp, "Invalid periphclk-divider (%lu), must be >= 2",
+                       s->periphclk_divider);
+            return;
+        }
+        tb->periphclk_divider = s->periphclk_divider;
         tb->timer = ptimer_init(timerblock_tick, tb, PTIMER_POLICY);
         sysbus_init_irq(sbd, &tb->irq);
         memory_region_init_io(&tb->iomem, OBJECT(s), &timerblock_ops, tb,
@@ -309,6 +324,8 @@ static const Property arm_mptimer_properties[] = {
     DEFINE_PROP_UINT64("clock-frequency", ARMMPTimerState, freq_hz,
                        NANOSECONDS_PER_SECOND),
     DEFINE_PROP_UINT32("num-cpu", ARMMPTimerState, num_cpu, 0),
+    DEFINE_PROP_UINT64("periphclk-divider", ARMMPTimerState,
+                       periphclk_divider, 10),
 };
 
 static void arm_mptimer_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/timer/a9gtimer.h b/include/hw/timer/a9gtimer.h
index 3b63d14927..ff9baf1c77 100644
--- a/include/hw/timer/a9gtimer.h
+++ b/include/hw/timer/a9gtimer.h
@@ -77,6 +77,7 @@ struct A9GTimerState {
     MemoryRegion iomem;
     /* static props */
     uint64_t freq_hz;
+    uint64_t periphclk_divider;
     uint32_t num_cpu;
 
     QEMUTimer *timer;
diff --git a/include/hw/timer/arm_mptimer.h b/include/hw/timer/arm_mptimer.h
index da43a3d351..061934e4b5 100644
--- a/include/hw/timer/arm_mptimer.h
+++ b/include/hw/timer/arm_mptimer.h
@@ -32,6 +32,7 @@ typedef struct {
     uint32_t status;
     struct ptimer_state *timer;
     uint64_t freq_hz;
+    uint64_t periphclk_divider;
     qemu_irq irq;
     MemoryRegion iomem;
 } TimerBlock;
@@ -45,6 +46,7 @@ struct ARMMPTimerState {
     /*< public >*/
 
     uint64_t freq_hz;
+    uint64_t periphclk_divider;
     uint32_t num_cpu;
     TimerBlock timerblock[ARM_MPTIMER_MAX_CPUS];
     MemoryRegion iomem;
-- 
2.47.3


