Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF67C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x697d-0004EN-L0; Mon, 14 Sep 2026 12:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x696k-0003Gi-5d
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:00:47 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x696i-0004eq-7f
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:00:37 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso13177485e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789401634; x=1790006434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6E734XzpINz7DVCD4hyOh+TtFltl3kWyJgieC8778LU=;
 b=KlZ5qU2KhHLC64DgRGE7qplcHWXoQRQuzhtOYh9eQ3O68bqg3FAI54xQApG6X1WAau
 7x7HvPnnWmrIJqU8zbJ7tt1R/EZrHrg7y+4c6gqczZoTuI/SXA3G8bZaDEiFj9tGMb/6
 9nJbyrLv+TW4CPGbUhC7dKwdgJ3MD6aEsSEJJorrwSI4HIJoEEyiRQAbXvvhp4gtvdoT
 uiG2VEOEyT755rh+vKIOptPMyuWRUJimdYQU1WilH49iqVnR0znPr7gZD/1npJk2NfQp
 EUvf3wn3lX+/Uh4qR290SekubiH3+yUrylGHAM87SwmazQU6rab25VZvQyQzmS7LnWva
 YnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401634; x=1790006434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6E734XzpINz7DVCD4hyOh+TtFltl3kWyJgieC8778LU=;
 b=n6nhghvkmLplSYwpnbzJo6kYgUuz60cor+vjL9rZjHr3jwd+ABUXp6d/egyHDS6WdM
 PosN5h/Hp2EvRay8tTL9sdNVOBQ90FSi7rJUaeE2XN8QdgMWviGG+rdR3PpOODrJRyes
 u5/I3UQkXdULEBDx8EisoG2KUnzxFKhaLTCCD6zg0pQDlkIvs1/KM91+upta0uVmfM2/
 se9ewaFJi+usS+kF0Z0w0yE2c0eWPmYWUWAh16VsVYGOd6zRqheThyYE3BQ0V3syj21R
 pJSpNlG5TEIdvz/zgdbjb42vFo+wWXtu2vVqXYIhRn6o0kOdbUjWIQ/Fv7r5TWOcnurw
 Jsfw==
X-Forwarded-Encrypted: i=1;
 AKwUvByLGx7ZrerDse0+7xpA+HgH+zIzFl9+D3mja76f3AmEV/UVrcntJK7U0IW28GtzgTkvEhqZL0nTka8f@nongnu.org
X-Gm-Message-State: AFuF++nwUDEPyv4xFYui1CcEvHmTCQGR06TyKs+mzvqdUNyq7Jh4LMJ5
 pI9jG9LHGKeOSwKPLAMzM2X1Giw9MKF1xkDns3bhYxTY4PjJyOyNUzsq7Ir4VI+pUerHEMXo2hT
 7D8gGMJg=
X-Gm-Gg: AYBFou2EkM2smiRqVtJ949Js+FBV3dWcumhrCbKV4aLUChV+gBDS13rInKsib2v5L6B
 VoZ4wlVR7j1w1A19FcroTc20yS6BqH5BvcocnWxv/xqYltgEya0Fqo9gQ64OX7l04oKVD6Lny67
 RwDKO3pLXVN+p9p44zFtg+zSFtqHl/gwmhyePjkBrykiZA3fu9LfXMlRl03MbutWdA5o3u4BUBu
 mXRYvjRMZFyC1sm2OCT9vEWKB1sVzqLX+EpSKsDljgqW/xPDOvGUXJQQLCXn0MN3bMsdmJ7fZht
 e3vFm2q+Zy3iD3rNulw64Y2aKqHC/nHEzPnplxNSxYr8Xt1/kS7ozs7KwA5qMtJ8R+LFMB6jd6U
 dpiQDFXtFYsLbrhprBo4gEHENGmvVY6Y+iz/JYR2xC1idzGaypT9E3nYA1FWclq4VJ/MkKMn5ms
 x0ss/FRU3e2+T5KfbMOlvKheSGTynLv5HtUClXJRK8Y+77TKv3Z0wL+47hSaIcoqkw6xU2ngH8t
 xYd9XaWcE4uGKuER5tEfzQgFCAQ+FTF1KCKCVsRGzi1vyLaRWqjvd8OlXuON75/YoezK5CEsRPf
 WtlE
X-Received: by 2002:a05:600c:474e:b0:49d:39:90ba with SMTP id
 5b1f17b1804b1-49e7a638725mr42904245e9.3.1789401630887; 
 Mon, 14 Sep 2026 09:00:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm30797695f8f.27.2026.09.14.09.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:00:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 6/9] target/arm: GICv5 cpuif: Use arm_cpu_set_irq() to set
 IRQ/FIQ status
Date: Mon, 14 Sep 2026 17:00:17 +0100
Message-ID: <20260914160020.327787-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914160020.327787-1-peter.maydell@linaro.org>
References: <20260914160020.327787-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c             | 14 +++++++++++---
 target/arm/internals.h       | 14 ++++++++++++++
 target/arm/tcg/gicv5-cpuif.c | 35 ++++-------------------------------
 3 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 77aa78f00e2..2b1b87b0ed4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -806,9 +806,8 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
 
 
 #ifndef CONFIG_USER_ONLY
-static void arm_cpu_set_irq(void *opaque, int irq, int level)
+void arm_cpu_set_irq(ARMCPU *cpu, int irq, int level)
 {
-    ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
     static const int mask[] = {
@@ -860,6 +859,15 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
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
@@ -1263,7 +1271,7 @@ static void arm_cpu_initfn(Object *obj)
          */
         qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, 6);
     } else {
-        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 6);
+        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_gpio_set_irq, 6);
     }
 
     qdev_init_gpio_out(DEVICE(cpu), cpu->gt_timer_outputs,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1775835ad50..c623e875136 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1883,6 +1883,20 @@ void define_gcs_cpregs(ARMCPU *cpu);
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


