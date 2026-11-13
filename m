Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C10606B353
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmvY-0002uY-04; Fri, 13 Nov 2026 03:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvR-0002r7-It
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:25 -0500
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvQ-0007QN-0G
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:25 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 14DF082B;
 Fri, 13 Nov 2026 14:16:21 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 08/26] target/loongarch: add LVZ guest timer
Date: Fri, 13 Nov 2026 16:45:23 +0800
Message-ID: <868343e68bee1b4fb7cfa7c82cce76cab4bf4806.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a separate guest timer and IRQ_VTIMER. To use cpu_has_ptw(), timer init should
be after loongarch_la464_initfn() when CPUCFG is set.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.c | 16 ++++++++++++++--
 target/loongarch/cpu.h |  6 ++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 20209c1bfc..3a351e43cc 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -738,10 +738,14 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
     CPULoongArchState *env = cpu_env(cs);
 
 #ifdef CONFIG_TCG
-    CPUTimerState *timer;
+    CPUTimerState *timer, *guest_timer;
 #endif
 
-    env->irq_nr = N_IRQS;
+    if (cpu_has_lvz(env)) {
+        env->irq_nr = N_VIRQS;
+    } else {
+        env->irq_nr = N_IRQS;
+    }
     qdev_init_gpio_in(dev, loongarch_cpu_set_irq, env->irq_nr);
 #ifdef CONFIG_TCG
     timer = env_timer(env);
@@ -749,6 +753,14 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
     timer->cs  = cs;
     timer_init_ns(&timer->timer, QEMU_CLOCK_VIRTUAL,
                   &cpu_loongarch_timer_cb, timer);
+
+    if (cpu_has_lvz(env)) {
+        guest_timer = env_guest_timer(env);
+        guest_timer->irq = IRQ_VTIMER;
+        guest_timer->cs = cs;
+        timer_init_ns(&guest_timer->timer, QEMU_CLOCK_VIRTUAL,
+            &cpu_loongarch_timer_cb, guest_timer);
+    }
 #endif
 
     cpu_common_realize(cs, &local_err);
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 22f2b0aa47..c1a59882f7 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -245,6 +245,7 @@ extern const char * const fregnames[32];
 #define IRQ_IPI     12
 #define INT_DMSI    14
 #define N_VIRQS     (N_IRQS * 2)
+#define IRQ_VTIMER  (N_IRQS + IRQ_TIMER)
 
 #define MAX_PERF_EVENTS        16
 #define LOONGARCH_STLB         2048 /* 2048 STLB */
@@ -582,6 +583,11 @@ static inline CPUTimerState *env_timer(CPULoongArchState *env)
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
2.56.0


