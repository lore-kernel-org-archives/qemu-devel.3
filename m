Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C926CC6B10
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3Z-0007RT-FS; Tue, 13 Oct 2026 04:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY33-0006pm-Ug
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:49 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY32-0007a4-3l
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:49 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso21708255e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880786; x=1792485586; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OaiC0A3kyB7u1DNetaci/CV68nbx8shGZnFz0+Agagc=;
 b=SM7FturrB2CnLG8ip++Ru1u8lJc/0KOc3eWiZF/m+rB+qhWsU4wYDpZdO6d3lKDEW2
 I/W7xXz4ZgT9zDaVxNJXdaekyUbvNdxVCJpdSRoQrprrkOM+WpcDOD5rPmiM53V6gMS0
 oshtz5XWuYMhWQ3quLtH54A/SHro4XTasDnx0Tw5tRNtYGYzyQCz22mqZJ5sLvDFtok4
 QEwrOseuxWdFfDfE+aoxVf6SVQCxQfyxjSZzvzOaZYVFxitfsgHD400IiM/aBrVVN9LP
 8g8hLN2ij9y77paGIIdrMMiMPPw0haBBWdwda6RB8AszYSPiCiQPzEkJGx71GVZicIFt
 TqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880786; x=1792485586;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OaiC0A3kyB7u1DNetaci/CV68nbx8shGZnFz0+Agagc=;
 b=mb6IsnDsfai5Qd4w2+Ynr/364jiYutjZqgYgbBXZeoFrnhN+cKt8BGTj9R/jF2rqu0
 dZan2Hqz44+gggpNfFUg/w069Gef7Uifi6PAYZ+5rMxjXLH2YODVwxyaHKhZ0aB/sLGg
 s9FoITd/JeU287ShPah3D9ouoam9y92OR8nWWZFs2qGq+0Ha8NHH4Noqtw766XQsd9PG
 AI5IKijersfsnljiUCYZX/zCAjNZHOpFgduXQ5Iscu6OpdyWO5+TZ09rrGQvWrH2NyQq
 7m+oVlen7n8tqiAOTCNzsmvcsZFWDvJ+oRitxKXMMTKfjBUB/vWevCHXRrG+1iOrPFSU
 vG0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzh0ZP4R7NyfZ8tte8CiC1WqGWP1ovTWabemgW+Ub/Al3HuVh6gRi8uJmpG3pp7mS6I0swHy+T/I/D/@nongnu.org
X-Gm-Message-State: AFq9FYKM1i3pjfevtBgxB98IdfYDNdH8dkXDVKbmLiAUGR6HfGK8v1dD
 ZrR17o/5iRVvn2HqB4umUk26GW7svcqoa1ARJSXphUGHkwGt5gm48J2pe0v798Ep5TlxON58ESp
 DS4KDOgM=
X-Gm-Gg: AYBFou31VT9nRvyvidastMomJQr2WOHm9USi+kWC+QoFiDeUYHAC1PQvuOCBDjG4oB+
 mZm6LKQJBJIC9+xHON4mE+XIRoqpx27lWURsru+4GGQQM1iaCcosG1rlfqZZF5buxDL8hdSgR1a
 tbGgK2xO5GjD1V+KrKSmGvoyExwsnMZGHNZuglys/h/j0dVs0K37EmOzK3mLLkxbJMSJtagGgxs
 javp2EuV1icz4DT5nyi+qe2wQ1LRc15AzOKq1dQCX4I9vSZohw29hrMhG0JGC+Xy3LqBJLeNBZ1
 2D+w+d9hHPhkfcNT4IXKz+F11+ytPbnPqcpWTE62eiR2eqNV8RpE6AOKXM8xZ/bz4g5KL99mjq8
 LRC/rEzYcJfGpM1LD7VIZFUGxcps3eIw1y7bZ6a14qk6dgAvfkpLJB7LoVmloZCR7NHhP6XzTT6
 2xlI/+smcOz3w2LEo9akq2yWUritB8j3v2DxAxBvaiK08t6d4jEZIYTVUgvrKzosz3YED0mgyUH
 td2rvOE4LcPPE4l92q9KlTtKht6KjKNDiOvDtNqROk9aLn2cxg+E9pCmrO4/HTDEnBkR0pIakz7
 O84=
X-Received: by 2002:a05:600c:c167:b0:4a1:a3cc:3c5c with SMTP id
 5b1f17b1804b1-4a1a3cc3c71mr70054675e9.16.1791880786633; 
 Tue, 13 Oct 2026 01:39:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/86] target/arm: GICv5 cpuif: Use arm_cpu_set_irq() to set
 IRQ/FIQ status
Date: Tue, 13 Oct 2026 09:38:14 +0100
Message-ID: <20261013083933.1024405-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently the GICv5 cpu interface directly calls cpu_interrupt() and
cpu_reset_interrupt() to raise and lower IRQ and FIQ.  This is almost
but not exactly what we do for GICv2/GICv3 external GPIO IRQ/FIQ line
changes.  Those are handled by arm_cpu_set_irq(), and as well as
calling cpu_interrupt() or cpu_reset_interrupt() they also update
env->irq_line_state.

For IRQ and FIQ it doesn't matter whether we set and clear the bits
in irq_line_state, because nothing looks at them.  But for VIRQ and
VFIQ it will matter, because VIRQ and VFIQ are the logical OR of the
line state and some bits in HCR_EL2.  We're going to need to call
arm_cpu_set_irq() for VIRQ and VFIQ; for consistency, handle IRQ and
FIQ that way too.

Since arm_cpu_set_irq() is now a function called from other parts of
the CPU code, we make its first argument a properly typed one, with a
wrapper taking void* for when we need to use it as a
qemu_irq_handler.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c             | 14 +++++++++++---
 target/arm/internals.h       | 14 ++++++++++++++
 target/arm/tcg/gicv5-cpuif.c | 35 ++++-------------------------------
 3 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10ac6c98318..014ec6a945e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -808,9 +808,8 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
 
 
 #ifndef CONFIG_USER_ONLY
-static void arm_cpu_set_irq(void *opaque, int irq, int level)
+void arm_cpu_set_irq(ARMCPU *cpu, int irq, int level)
 {
-    ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
     static const int mask[] = {
@@ -862,6 +861,15 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
     }
 }
 
+/*
+ * Wrapper of arm_cpu_set_irq with the right argument types to be a
+ * qemu_irq_handler function for our inbound GPIO lines.
+ */
+static void arm_cpu_gpio_set_irq(void *opaque, int irq, int level)
+{
+    arm_cpu_set_irq(opaque, irq, level);
+}
+
 static bool arm_cpu_internal_is_big_endian(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1265,7 +1273,7 @@ static void arm_cpu_initfn(Object *obj)
          */
         qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, 6);
     } else {
-        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 6);
+        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_gpio_set_irq, 6);
     }
 
     qdev_init_gpio_out(DEVICE(cpu), cpu->gt_timer_outputs,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index c41fa5225c7..9d817961c67 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1886,6 +1886,20 @@ void define_gcs_cpregs(ARMCPU *cpu);
 /* Add the cpreg definitions for OMAP CP15 regs */
 void define_omap_cp_regs(ARMCPU *cpu);
 
+#ifndef CONFIG_USER_ONLY
+/**
+ * arm_cpu_set_irq: Assert or clear an IRQ/FIQ/etc interrupt line
+ * @cpu: CPU to set interrupt on
+ * @irq: one of the ARM_CPU_IRQ/ARM_CPU_FIQ/ARM_CPU_VIRQ/etc values
+ * @level: 0 to deassert, non-zero to assert
+ *
+ * This function is called by the qemu_irq_handler function
+ * when IRQ etc are real inbound GPIO lines; it is also called
+ * directly by the GICv5 CPU interface.
+ */
+void arm_cpu_set_irq(ARMCPU *cpu, int irq, int level);
+#endif
+
 /* Add the cpreg definitions for the GICv5 CPU interface */
 void define_gicv5_cpuif_regs(ARMCPU *cpu);
 
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index a6e6c440849..517c780d1f7 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -173,33 +173,6 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
     return best;
 }
 
-static void cpu_interrupt_update(CPUARMState *env, int irqtype, bool new_state)
-{
-    CPUState *cs = env_cpu(env);
-
-    /*
-     * OPT: calling cpu_interrupt() and cpu_reset_interrupt() has the
-     * correct behaviour, but is not optimal for the case where we're
-     * setting the interrupt line to the same level it already has.
-     *
-     * Clearing an already clear interrupt is free (it's just doing an
-     * atomic AND operation). Signalling an already set interrupt is a
-     * bit less ideal (it might unnecessarily kick the CPU).
-     *
-     * We could potentially use cpu_test_interrupt(), like
-     * arm_cpu_update_{virq,vfiq,vinmi,vserr}, since we always hold
-     * the BQL here; or perhaps there is an abstraction we could
-     * provide in the core code that all these places could call.
-     *
-     * For now, this is simple and definitely correct.
-     */
-    if (new_state) {
-        cpu_interrupt(cs, irqtype);
-    } else {
-        cpu_reset_interrupt(cs, irqtype);
-    }
-}
-
 static void gicv5_update_irq_fiq(CPUARMState *env)
 {
     /*
@@ -243,12 +216,12 @@ static void gicv5_update_irq_fiq(CPUARMState *env)
     /*
      * Unlike a GICv3 or GICv2, there is no external IRQ or FIQ line
      * to the CPU. Instead we directly signal the interrupt via
-     * cpu_interrupt()/cpu_reset_interrupt().
+     * arm_cpu_set_irq().
      */
     trace_gicv5_update_irq_fiq(irq, fiq, superpriority);
-    cpu_interrupt_update(env, CPU_INTERRUPT_HARD, irq);
-    cpu_interrupt_update(env, CPU_INTERRUPT_FIQ, fiq);
-    cpu_interrupt_update(env, CPU_INTERRUPT_NMI, superpriority);
+    arm_cpu_set_irq(env_archcpu(env), ARM_CPU_IRQ, irq);
+    arm_cpu_set_irq(env_archcpu(env), ARM_CPU_FIQ, fiq);
+    arm_cpu_set_irq(env_archcpu(env), ARM_CPU_NMI, superpriority);
 }
 
 static void gic_recalc_ppi_hppi(CPUARMState *env)
-- 
2.43.0


