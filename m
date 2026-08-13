Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644D8C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 03:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuMIM-0003ZW-GN; Wed, 12 Aug 2026 23:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wuMIK-0003Yv-Nf
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 23:39:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wuMIH-0004Sy-8z
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 23:39:52 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8BxhvCDPH1qy8gAAA--.2515S3;
 Thu, 13 Aug 2026 11:39:47 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJBx6c2EPH1qVO8CAA--.4092S3;
 Thu, 13 Aug 2026 11:39:48 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 5/5] target/loongarch: Set timer tick value even if disabled
Date: Thu, 13 Aug 2026 11:40:52 +0800
Message-ID: <20260813034052.79094-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813034052.79094-1-maobibo@loongson.cn>
References: <20260813034052.79094-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx6c2EPH1qVO8CAA--.4092S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF17CF1xAry3Kw1kXw1fAFc_yoW8tw1kpr
 4I9r9rKr1FyrWkuFyrJan8XFn8Wr17W3WI9ayxAF4xCwn8XwnrW348W3s7KFW3AFy5urWa
 vF95X3WqgF4xC3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UMpBfUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

If constant timer is enabled, its tick value is remained value from
the next expired time. However if timer is not enabled, its value
should be CONSTANT_TIMER_TICK_MASK or zero.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Xianglai Li <lixianglai@loongson.cn>
---
 target/loongarch/tcg/constant_timer.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/tcg/constant_timer.c b/target/loongarch/tcg/constant_timer.c
index f56e76d482..b91ad1de69 100644
--- a/target/loongarch/tcg/constant_timer.c
+++ b/target/loongarch/tcg/constant_timer.c
@@ -22,12 +22,18 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu)
 
 uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu)
 {
+    CPULoongArchState *env = &cpu->env;
+    CPUSysState *sys = env_sys(env);
     uint64_t now, expire;
 
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    expire = timer_expire_time_ns(&cpu->timer);
+    if ((sys->CSR_TCFG & CONSTANT_TIMER_ENABLE) &&
+        (sys->CSR_TVAL < sys->CSR_TCFG)) {
+        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        expire = timer_expire_time_ns(&cpu->timer);
+        sys->CSR_TVAL = (expire - now) / TIMER_PERIOD;
+    }
 
-    return (expire - now) / TIMER_PERIOD;
+    return sys->CSR_TVAL;
 }
 
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
@@ -42,8 +48,10 @@ void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         next = now + (value & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
         timer_mod(&cpu->timer, next);
+        sys->CSR_TVAL = sys->CSR_TCFG & CONSTANT_TIMER_TICK_MASK;
     } else {
         timer_del(&cpu->timer);
+        sys->CSR_TVAL = 0;
     }
 }
 
@@ -58,8 +66,9 @@ void loongarch_constant_timer_cb(void *opaque)
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         next = now + (sys->CSR_TCFG & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
         timer_mod(&cpu->timer, next);
+        sys->CSR_TVAL = sys->CSR_TCFG & CONSTANT_TIMER_TICK_MASK;
     } else {
-        sys->CSR_TCFG = FIELD_DP64(sys->CSR_TCFG, CSR_TCFG, EN, 0);
+        sys->CSR_TVAL = CONSTANT_TIMER_TICK_MASK;
     }
 
     loongarch_cpu_set_irq(opaque, IRQ_TIMER, 1);
-- 
2.54.0


