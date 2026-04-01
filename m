Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CEC1076387
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7z0X-00016m-Ez; Wed, 01 Apr 2026 13:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w7z09-0000pl-O6
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:05:11 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w7z07-00084g-AK
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:05:09 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 aaac95d988df8a5b7476f90d482c0863d3bd26acbd0c843086e3698f5097df11 with SMTP id
 69cd503bbf9bc69ede7f1800; Wed, 01 Apr 2026 17:04:59 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1775063098;
 bh=Ft8NudYzcwgnb/NtMZjokqHSpfT16xJAGl989G7s3EU=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
 From:Reply-to:Subject:Date:Message-id:To:Cc:Mime-version:
 Content-type:Content-transfer-encoding:In-reply-to:References;
 b=bu8sEM1QanOabgLcZus8CskaneuZFKkKKJyWZpUpwsBaiPu9KvzsE4SQ6UURokgiy
 MdQouLAGskimFVrMpIDNleuP0qvyLhr28ybrDF9C8XKvkup8nM0j85bAf64fWEV2eU
 eF/ou5PlQjraGvy3zhDTONXb7uDdIDEAJl0iX5cyfL2T8gdYG9CvKpFB6nDpnHogdW
 sX1AggpTucEpprgQK1CDXUNNs6jrbypvN0OMj6AaaoidBScYgH351wNIwIAwENkWca
 v9EFnRYzJUeemCoB9C6xAawqVs+y8G9w0jdb7uxdk3iFZnnUbKZIeAtk7kqyXo28kG
 0KXwWEQihgtpA==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: "Yodel Eldar" <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [RFC PATCH 3/4] alpha: Replace helper_set_alarm with Typhoon Cchip
 MMIO register
Date: Wed,  1 Apr 2026 12:04:53 -0500
Message-ID: <20260401170454.32045-4-yodel.eldar@yodel.dev>
In-Reply-To: <20260401170454.32045-1-yodel.eldar@yodel.dev>
References: <20260401170454.32045-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

This commit creates a QEMU-specific (non-standard) MMIO register
in Typhoon's Cchip to replace helper_set_alarm() and to move
the QEMUTimer pointer, alarm_timer, out of the Alpha CPU and into
the chipset code.

Currently, PALcode writes to the QEMU-specific, synthetic
Processor Register (index 251) and triggers the invocation of
helper_set_alarm() as a side effect in QEMU, thereby setting
the timer alarm expiration value.

This works, because the AlphaCPU contains the QEMUTimer and
CPUAlphaState stores the alarm expiration value; however, the timer
alarm callback resides in and is specific to the Typhoon chipset,
thus the CPU and the chipset are entangled.

By designating the currently unused offset (0x7c0) of Cchip as the
location of the timer alarm expiration, we can disentangle and
better encapsulate both.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---

Notes:
    The patch to the palcode-clipper binary that follows this
    one is necessary for this patch to work; I've left the
    diff to the source in the notes of it for reproduction.
    
    Philippe:
    Thanks, again, for the suggestion of decoupling the CPU from
    the Typhoon using IRQ lines. In my response, I guessed that
    getting the CPU index would be trickier than moving the timer
    into TyphoonState; perhaps you'll find it amusing (as I do)
    that it appears I had that backwards (due to the PALcode
    peculiarity)!
    
    The remaining CPU interrupts will be refactored in v2 of that
    series.

 hw/alpha/dp264.c          |  4 ++++
 hw/alpha/typhoon.c        | 38 ++++++++++++++++++++++++++++++++------
 target/alpha/cpu.c        | 17 +++++++++++++++++
 target/alpha/cpu.h        |  6 ------
 target/alpha/helper.h     |  1 -
 target/alpha/sys_helper.c | 12 ------------
 target/alpha/translate.c  | 11 -----------
 7 files changed, 53 insertions(+), 36 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index ce2f8765cd..8e63b48a02 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -71,6 +71,10 @@ static void clipper_init(MachineState *machine)
     memset(cpus, 0, sizeof(cpus));
     for (i = 0; i < smp_cpus; ++i) {
         cpus[i] = ALPHA_CPU(cpu_create(machine->cpu_type));
+
+        qdev_connect_gpio_out_named(DEVICE(typhoon_obj), "cpu-irq", i,
+                                    qdev_get_gpio_in_named(DEVICE(cpus[i]),
+                                                           "timer-irq", 0));
     }
 
     /*
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 5dadfa7691..a40f690ed1 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -26,6 +26,9 @@ typedef struct TyphoonCchip {
     uint64_t dim[4];
     uint32_t iic[4];
     AlphaCPU *cpu[4];
+    qemu_irq cpu_irq[4];
+    QEMUTimer *alarm_timer[4];
+    uint64_t alarm_expire[4];
 } TyphoonCchip;
 
 typedef struct TyphoonWindow {
@@ -187,6 +190,14 @@ static MemTxResult cchip_read(void *opaque, hwaddr addr,
         /* PWR: Power Management Control.   */
         break;
     
+    case 0x07c0: {
+        /* ALRM: QEMU-specific Timer Alarm Register */
+        uint64_t cpu_index = attrs.requester_id & 3;
+
+        ret = s->cchip.alarm_expire[cpu_index];
+
+        break;
+    }
     case 0x0c00: /* CMONCTLA */
     case 0x0c40: /* CMONCTLB */
     case 0x0c80: /* CMONCNT01 */
@@ -352,7 +363,7 @@ static MemTxResult cchip_write(void *opaque, hwaddr addr,
 
                     /* ITI can only be cleared by the write.  */
                     if ((newval & (1 << (i + 4))) == 0) {
-                        cpu_reset_interrupt(cs, CPU_INTERRUPT_TIMER);
+                        qemu_set_irq(s->cchip.cpu_irq[i], 0);
                     }
                 }
             }
@@ -439,6 +450,19 @@ static MemTxResult cchip_write(void *opaque, hwaddr addr,
         /* PWR: Power Management Control.   */
         break;
     
+    case 0x07c0: {
+        /* ALRM: QEMU-specific Timer Alarm Register */
+        uint64_t cpu_index = attrs.requester_id & 3;
+        QEMUTimer *alarm_timer = s->cchip.alarm_timer[cpu_index];
+
+        if (val) {
+            s->cchip.alarm_expire[cpu_index] = val;
+            timer_mod(alarm_timer, val);
+        } else {
+            timer_del(alarm_timer);
+        }
+        break;
+    }
     case 0x0c00: /* CMONCTLA */
     case 0x0c40: /* CMONCTLB */
     case 0x0c80: /* CMONCNT01 */
@@ -801,7 +825,7 @@ static void typhoon_set_timer_irq(void *opaque, int irq, int level)
                 /* Set the ITI bit for this cpu.  */
                 s->cchip.misc |= 1 << (i + 4);
                 /* And signal the interrupt.  */
-                cpu_interrupt(CPU(cpu), CPU_INTERRUPT_TIMER);
+                qemu_set_irq(s->cchip.cpu_irq[i], 1);
             }
         }
     }
@@ -814,7 +838,7 @@ static void typhoon_alarm_timer(void *opaque)
 
     /* Set the ITI bit for this cpu.  */
     s->cchip.misc |= 1 << (cpu + 4);
-    cpu_interrupt(CPU(s->cchip.cpu[cpu]), CPU_INTERRUPT_TIMER);
+    qemu_set_irq(s->cchip.cpu_irq[cpu], 1);
 }
 
 static void typhoon_pcihost_instance_init(Object *obj)
@@ -823,6 +847,8 @@ static void typhoon_pcihost_instance_init(Object *obj)
 
     s->cchip.misc = 0x800000000ull; /* Revision: Typhoon.  */
     s->pchip.win[3].wba = 2;        /* Window 3 SG always enabled. */
+
+    qdev_init_gpio_out_named(DEVICE(s), s->cchip.cpu_irq, "cpu-irq", 4);
 }
 
 PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
@@ -843,9 +869,9 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
         AlphaCPU *cpu = cpus[i];
         s->cchip.cpu[i] = cpu;
         if (cpu != NULL) {
-            cpu->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                                 typhoon_alarm_timer,
-                                                 (void *)((uintptr_t)s + i));
+            s->cchip.alarm_timer[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                                   typhoon_alarm_timer,
+                                                   (void *)((uintptr_t)s + i));
         }
     }
 
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index ff053043a3..7f908a98c0 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -27,6 +27,7 @@
 #include "exec/target_page.h"
 #include "accel/tcg/cpu-ops.h"
 #include "fpu/softfloat.h"
+#include "hw/core/cpu.h"
 
 
 static void alpha_cpu_set_pc(CPUState *cs, vaddr value)
@@ -203,10 +204,26 @@ static void ev67_cpu_initfn(Object *obj)
     cpu_env(CPU(obj))->amask |= AMASK_CIX | AMASK_PREFETCH;
 }
 
+#ifndef CONFIG_USER_ONLY
+static void alpha_cpu_irq_handler(void *opaque, int irq, int level)
+{
+    CPUState *cs = CPU(opaque);
+
+    if (level) {
+        cpu_interrupt(cs, CPU_INTERRUPT_TIMER);
+    } else {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_TIMER);
+    }
+}
+#endif
+
 static void alpha_cpu_initfn(Object *obj)
 {
     CPUAlphaState *env = cpu_env(CPU(obj));
 
+#ifndef CONFIG_USER_ONLY
+    qdev_init_gpio_in_named(DEVICE(obj), alpha_cpu_irq_handler, "timer-irq", 1);
+#endif
     /* TODO all this should be done in reset, not init */
 
     env->lock_addr = -1;
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 45944e46b5..1ae1c40ce9 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -241,9 +241,6 @@ typedef struct CPUArchState {
     uint64_t scratch[24];
 #endif
 
-    /* This alarm doesn't exist in real hardware; we wish it did.  */
-    uint64_t alarm_expire;
-
     int error_code;
 
     uint32_t features;
@@ -261,9 +258,6 @@ struct ArchCPU {
     CPUState parent_obj;
 
     CPUAlphaState env;
-
-    /* This alarm doesn't exist in real hardware; we wish it did.  */
-    QEMUTimer *alarm_timer;
 };
 
 /**
diff --git a/target/alpha/helper.h b/target/alpha/helper.h
index 954a5c8294..c76b20eb8d 100644
--- a/target/alpha/helper.h
+++ b/target/alpha/helper.h
@@ -96,5 +96,4 @@ DEF_HELPER_1(whami, i64, env)
 
 DEF_HELPER_FLAGS_0(get_vmtime, TCG_CALL_NO_RWG, i64)
 DEF_HELPER_FLAGS_0(get_walltime, TCG_CALL_NO_RWG, i64)
-DEF_HELPER_FLAGS_2(set_alarm, TCG_CALL_NO_RWG, void, env, i64)
 #endif
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 0e0a619975..73f26a81d1 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -56,18 +56,6 @@ uint64_t helper_get_walltime(void)
     return qemu_clock_get_ns(rtc_clock);
 }
 
-void helper_set_alarm(CPUAlphaState *env, uint64_t expire)
-{
-    AlphaCPU *cpu = env_archcpu(env);
-
-    if (expire) {
-        env->alarm_expire = expire;
-        timer_mod(cpu->alarm_timer, expire);
-    } else {
-        timer_del(cpu->alarm_timer);
-    }
-}
-
 uint64_t HELPER(whami)(CPUAlphaState *env)
 {
     return env_cpu(env)->cpu_index;
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 4d22d7d5a4..cfe84f28bf 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1196,9 +1196,6 @@ static int cpu_pr_data(int pr)
 
     case 40 ... 63:
         return offsetof(CPUAlphaState, scratch[pr - 40]);
-
-    case 251:
-        return offsetof(CPUAlphaState, alarm_expire);
     }
     return 0;
 }
@@ -1280,14 +1277,6 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv_i64 vb, int regno)
         gen_helper_halt(vb);
         return DISAS_PC_STALE;
 
-    case 251:
-        /* ALARM */
-        if (translator_io_start(&ctx->base)) {
-            ret = DISAS_PC_STALE;
-        }
-        gen_helper_set_alarm(tcg_env, vb);
-        break;
-
     case 7:
         /* PALBR */
         tcg_gen_st_i64(vb, tcg_env, offsetof(CPUAlphaState, palbr));
-- 
2.53.0


