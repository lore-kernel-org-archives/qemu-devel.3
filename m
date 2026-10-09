Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76CFCA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0wS-0004te-43; Thu, 08 Oct 2026 23:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vY-0004dm-TK
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:44 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vW-0005m1-4D
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:43 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id 34CF2E001;
 Fri, 09 Oct 2026 08:35:39 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 08/23] target/loongarch: add LVZ guest timer
Date: Fri,  9 Oct 2026 11:05:04 +0800
Message-ID: <519eadd31f0af84ce49794e1922527d7c8d99104.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791514848.git.prcups@krgm.moe>
References: <cover.1791514848.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a separate guest timer and IRQ_VTIMER.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.c | 8 +++++++-
 target/loongarch/cpu.h | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 5cef63a778..8e759a2987 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -770,7 +770,7 @@ static void loongarch_cpu_init(Object *obj)
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
 #ifdef CONFIG_TCG
     CPULoongArchState *env = &cpu->env;
-    CPUTimerState *timer;
+    CPUTimerState *timer, *guest_timer;
 #endif
 
     qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, N_IRQS);
@@ -778,8 +778,14 @@ static void loongarch_cpu_init(Object *obj)
     timer = env_timer(env);
     timer->irq = IRQ_TIMER;
     timer->cs  = CPU(obj);
+    guest_timer = env_guest_timer(env);
+    guest_timer->irq = IRQ_VTIMER;
+    guest_timer->cs = CPU(obj);
+
     timer_init_ns(&timer->timer, QEMU_CLOCK_VIRTUAL,
                   &cpu_loongarch_timer_cb, timer);
+    timer_init_ns(&guest_timer->timer, QEMU_CLOCK_VIRTUAL,
+                  &cpu_loongarch_timer_cb, guest_timer);
 #endif
 #endif
 }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 8939dbc748..ba28d80272 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -245,6 +245,7 @@ extern const char * const fregnames[32];
 #define IRQ_IPI     12
 #define INT_DMSI    14
 #define N_VIRQS     (N_IRQS * 2)
+#define IRQ_VTIMER  (N_IRQS + IRQ_TIMER)
 
 #define MAX_PERF_EVENTS        16
 #define LOONGARCH_STLB         2048 /* 2048 STLB */
@@ -577,6 +578,11 @@ static inline CPUTimerState *env_timer(CPULoongArchState *env)
     return &env->sys_states[0].timer_state;
 }
 
+static inline CPUTimerState *env_guest_timer(CPULoongArchState *env)
+{
+    return &env->sys_states[1].timer_state;
+}
+
 static inline bool is_la64(CPULoongArchState *env)
 {
     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
-- 
2.55.0


