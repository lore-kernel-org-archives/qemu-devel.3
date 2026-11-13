Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FEA606A88C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmvX-0002uJ-El; Fri, 13 Nov 2026 03:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvP-0002ol-3u
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:23 -0500
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvN-0007QZ-Gw
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:22 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 1FCE3780F;
 Fri, 13 Nov 2026 14:16:18 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 06/26] target/loongarch: move timer initialization to
 loongarh_cpu_realizefn()
Date: Fri, 13 Nov 2026 16:45:21 +0800
Message-ID: <00538728e2c970e2038ddf2e54d91870e210f387.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
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

After guest_timer initialization is added, irq_nr needs to be determined
using cpu_has_lvz(), which relys on CPUCFG LVZ bit. So move it for
preparation.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index d8f3af4f31..fc432cfda0 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -721,6 +721,21 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUState *cs = CPU(dev);
     LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
+    CPULoongArchState *env = cpu_env(cs);
+
+#ifdef CONFIG_TCG
+    CPUTimerState *timer;
+#endif
+
+    env->irq_nr = N_IRQS;
+    qdev_init_gpio_in(dev, loongarch_cpu_set_irq, env->irq_nr);
+#ifdef CONFIG_TCG
+    timer = env_timer(env);
+    timer->irq = IRQ_TIMER;
+    timer->cs  = cs;
+    timer_init_ns(&timer->timer, QEMU_CLOCK_VIRTUAL,
+                  &cpu_loongarch_timer_cb, timer);
+#endif
 
     cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
@@ -748,27 +763,6 @@ static void loongarch_cpu_unrealizefn(DeviceState *dev)
     lacc->parent_unrealize(dev);
 }
 
-static void loongarch_cpu_init(Object *obj)
-{
-#ifndef CONFIG_USER_ONLY
-    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-    CPULoongArchState *env = &cpu->env;
-#ifdef CONFIG_TCG
-    CPUTimerState *timer;
-#endif
-
-    env->irq_nr = N_IRQS;
-    qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, env->irq_nr);
-#ifdef CONFIG_TCG
-    timer = env_timer(env);
-    timer->irq = IRQ_TIMER;
-    timer->cs  = CPU(obj);
-    timer_init_ns(&timer->timer, QEMU_CLOCK_VIRTUAL,
-                  &cpu_loongarch_timer_cb, timer);
-#endif
-#endif
-}
-
 static ObjectClass *loongarch_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -1002,7 +996,6 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .parent = TYPE_CPU,
         .instance_size = sizeof(LoongArchCPU),
         .instance_align = __alignof(LoongArchCPU),
-        .instance_init = loongarch_cpu_init,
 
         .abstract = true,
         .class_size = sizeof(LoongArchCPUClass),
-- 
2.56.0


