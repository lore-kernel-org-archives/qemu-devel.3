Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C693CD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 13:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOy2Q-0000iU-69; Mon, 18 May 2026 09:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pm_bounces@pm.mtasv.net>)
 id 1wOxks-0004uZ-RX
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:11:34 -0400
Received: from mta213a-ord.mtasv.net ([104.245.209.213])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pm_bounces@pm.mtasv.net>)
 id 1wOxkp-0007PM-1h
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:11:34 -0400
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoicWVtdS1kZXZlbEBub25nbnUub3JnIn0=
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806;
 c=relaxed/relaxed; 
 bh=s3PnWB5Zgv6PDjHeNwQy+fBwfJgq/W5Wd9fMrIE4vsU=;
 h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
 t=1779109890; x=1779714690;
 b=nagy8QkZpDJU+G08Jf4E+imrmC1QzH0ex7reZefopCCaI25Muqs0yVxegKWj5qu7KiINxVgSb
 P//9VHto8OiR9ch7IKtcyySM6VV1iMtNh9DtKF5NnUORUCBawd5yzCxB/nKuw2EepN59Rifufla
 04PD6vvkk97khi42H9juWV1lalWQTCH6j8hITBvd6ZUIaFkbf/tNEtiw4ezcUs+Jpvq5ZEUayQ7
 QJYW7N4n21xSwS3taqBm11+az/ZMgtAmSjvQMqOhPlXTH/pik74WYWGTipYTW/tnEen89GhgEkJ
 UHZ9aasVrAPmi3czFtK/isJdkpY7jBhwMYo+dtxqnb7A==;
Received: from ip-172-26-21-70.us-east-2.compute.internal (172.26.21.70)
 by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.242.151) 
 with ESMTP id 15b92ecc52bb11f1bb3b0292cb89fe79 for <qemu-devel@nongnu.org>;
 Mon, 18 May 2026 13:11:30 +0000
From: SignKirigami <prcups@krgm.moe>
Date: Mon, 18 May 2026 13:11:30 +0000
Subject: [PATCH 2/4] target/loongarch: add LVZ guest runtime support
Message-Id: <bdf77670-7681-47af-8c1d-f4e436ee5626@mtasv.net>
To: qemu-devel@nongnu.org
Cc: SignKirigami <prcups@krgm.moe>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260518130918.76338-1-prcups@krgm.moe>
References: <20260518130918.76338-1-prcups@krgm.moe>
Feedback-ID: s9655927-_:s9655927:a251693:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 251693_9655927
X-PM-Message-Id: bdf77670-7681-47af-8c1d-f4e436ee5626
X-PM-RCPT: |bTF8MjUxNjkzfDk2NTU5Mjd8cWVtdS1kZXZlbEBub25nbnUub3Jn|
X-PM-Message-Options: v1;
 1.4-_kldOh9z87mbA8SYEh2A.IMmhbowRlidiAm4zinKBohXds6m_El71khRovnJvgZ7WSAsarrNkcOL3k0zX1rbqYCF5-x_0ahILKOBLy8iRIFRuGn95vyhJy_xMTOumr4e7pkz1AC2rZlYCLhB6z_D69QTspNbylNnnVvbK7ezoZLLERt_Jx7lGJuajb5N1xmqJu4et9Zx-VMz89VhjAYPV
X-virtual-MTA: ord-104-245-209-213
X-PM-MTA-Pool: transactional-2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=104.245.209.213;
 envelope-from=pm_bounces@pm.mtasv.net; helo=mta213a-ord.mtasv.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 18 May 2026 09:29:19 -0400
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
Reply-To: prcups@krgm.moe
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.c                | 132 +++++++++++++++++++
 target/loongarch/internals.h          |   8 +-
 target/loongarch/kvm/kvm.c            |   1 +
 target/loongarch/tcg/constant_timer.c |  62 ++++++++-
 target/loongarch/tcg/csr_helper.c     | 127 +++++++++++++++++-
 target/loongarch/tcg/helper.h         |  13 +-
 target/loongarch/tcg/op_helper.c      |  83 +++++++++---
 target/loongarch/tcg/tcg_cpu.c        | 182 +++++++++++++++++---------
 8 files changed, 518 insertions(+), 90 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 8f277f7696..2477d84625 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -67,6 +67,11 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int le=
vel)
         return;
     }
=20
+    if (FIELD_EX64(env->CSR_GINTC, CSR_GINTC, HWIP) & BIT(irq)) {
+        loongarch_cpu_set_irq_guest(opaque, irq, level);
+        return;
+    }
+
     if (kvm_enabled()) {
         kvm_loongarch_set_interrupt(cpu, irq, level);
     } else if (tcg_enabled()) {
@@ -79,6 +84,26 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int le=
vel)
     }
 }
=20
+void loongarch_cpu_set_irq_guest(void *opaque, int irq, int level)
+{
+    LoongArchCPU *cpu =3D opaque;
+    CPULoongArchState *env =3D &cpu->env;
+    CPUState *cs =3D CPU(cpu);
+
+    if (irq < 0 || irq >=3D N_IRQS) {
+        return;
+    }
+
+    env->GCSR_ESTAT =3D deposit64(env->GCSR_ESTAT, irq, 1, level !=3D 0);
+    if (env->guest) {
+        if (FIELD_EX64(env->GCSR_ESTAT, CSR_ESTAT, IS)) {
+            cpu_interrupt(cs, CPU_INTERRUPT_GUEST);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_GUEST);
+        }
+    }
+}
+
 /* Check if there is pending and not masked out interrupt */
 bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
 {
@@ -90,6 +115,30 @@ bool cpu_loongarch_hw_interrupts_pending(CPULoongArchSt=
ate *env)
=20
     return (pending & status) !=3D 0;
 }
+
+static inline bool
+cpu_loongarch_hw_interrupts_enabled_guest(CPULoongArchState *env)
+{
+    return FIELD_EX64(env->GCSR_CRMD, CSR_CRMD, IE);
+}
+
+static inline bool
+cpu_loongarch_hw_interrupts_pending_guest(CPULoongArchState *env)
+{
+    uint32_t pending;
+    uint32_t status;
+
+    pending =3D FIELD_EX64(env->GCSR_ESTAT, CSR_ESTAT, IS);
+    status =3D FIELD_EX64(env->GCSR_ECFG, CSR_ECFG, LIE);
+
+    return (pending & status) !=3D 0;
+}
+
+bool loongarch_guest_has_interrupt(CPULoongArchState *env)
+{
+    return env->guest && cpu_loongarch_hw_interrupts_enabled_guest(env) &&
+           cpu_loongarch_hw_interrupts_pending_guest(env);
+}
 #endif
=20
 #ifndef CONFIG_USER_ONLY
@@ -102,10 +151,54 @@ bool loongarch_cpu_has_work(CPUState *cs)
         has_work =3D true;
     }
=20
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_GUEST) &&
+        loongarch_guest_has_interrupt(cpu_env(cs))) {
+        has_work =3D true;
+    }
+
     return has_work;
 }
 #endif /* !CONFIG_USER_ONLY */
=20
+uint8_t get_tgid(CPULoongArchState *env)
+{
+    if (env->guest) {
+        return get_gid(env);
+    }
+
+    if (FIELD_EX64(env->CSR_GTLBC, CSR_GTLBC, USETGID)) {
+        return FIELD_EX64(env->CSR_GTLBC, CSR_GTLBC, TGID);
+    } else if (will_return_to_guest(env)) {
+        return get_gid(env);
+    }
+    return 0;
+}
+
+bool will_return_to_guest(CPULoongArchState *env)
+{
+    if (!has_lvz_capability(env) || env->guest) {
+        return false;
+    }
+    return FIELD_EX64(env->CSR_GSTAT, CSR_GSTAT, PVM);
+}
+
+bool has_lvz_capability(CPULoongArchState *env)
+{
+    return FIELD_EX32(env->cpucfg[2], CPUCFG2, LVZ);
+}
+
+uint8_t get_gid(CPULoongArchState *env)
+{
+    return FIELD_EX64(env->CSR_GSTAT, CSR_GSTAT, GID);
+}
+
+void trigger_vm_exit(CPULoongArchState *env)
+{
+    cpu_loongarch_set_guest_timer(env_archcpu(env), false);
+    env->CSR_GSTAT =3D FIELD_DP64(env->CSR_GSTAT, CSR_GSTAT, PVM, 1);
+    env->vm_exit =3D true;
+}
+
 static void loongarch_la464_init_csr(DeviceState *dev)
 {
 #ifndef CONFIG_USER_ONLY
@@ -248,12 +341,33 @@ static void loongarch_set_ptw(Object *obj, bool value=
, Error **errp)
     cpu->env.cpucfg[2] =3D FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, HPTW, v=
alue);
 }
=20
+static bool loongarch_get_lvz(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->lvz !=3D ON_OFF_AUTO_OFF;
+}
+
+static void loongarch_set_lvz(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu =3D LOONGARCH_CPU(obj);
+
+    cpu->lvz =3D value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+
+    if (kvm_enabled()) {
+        return;
+    }
+
+    cpu->env.cpucfg[2] =3D FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LVZ, va=
lue);
+    cpu->env.cpucfg[2] =3D
+        FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LVZ_VER, value ? 1 : 0);
+}
+
 static void loongarch_cpu_post_init(Object *obj)
 {
     LoongArchCPU *cpu =3D LOONGARCH_CPU(obj);
=20
     cpu->lbt =3D ON_OFF_AUTO_OFF;
     cpu->pmu =3D ON_OFF_AUTO_OFF;
+    cpu->lvz =3D ON_OFF_AUTO_AUTO;
     cpu->lsx =3D ON_OFF_AUTO_AUTO;
     cpu->lasx =3D ON_OFF_AUTO_AUTO;
     object_property_add_bool(obj, "lsx", loongarch_get_lsx,
@@ -264,6 +378,8 @@ static void loongarch_cpu_post_init(Object *obj)
                              loongarch_set_msgint);
     object_property_add_bool(obj, "ptw", loongarch_get_ptw,
                              loongarch_set_ptw);
+    object_property_add_bool(obj, "lvz", loongarch_get_lvz,
+                             loongarch_set_lvz);
     /* lbt is enabled only in kvm mode, not supported in tcg mode */
=20
     if (kvm_enabled()) {
@@ -317,6 +433,8 @@ static void loongarch_la464_initfn(Object *obj)
     data =3D FIELD_DP32(data, CPUCFG2, FP_VER, 1);
     data =3D FIELD_DP32(data, CPUCFG2, LSX, 1),
     data =3D FIELD_DP32(data, CPUCFG2, LASX, 1),
+    data =3D FIELD_DP32(data, CPUCFG2, LVZ, 1);
+    data =3D FIELD_DP32(data, CPUCFG2, LVZ_VER, 1);
     data =3D FIELD_DP32(data, CPUCFG2, LLFTP, 1);
     data =3D FIELD_DP32(data, CPUCFG2, LLFTP_VER, 1);
     data =3D FIELD_DP32(data, CPUCFG2, LSPW, 1);
@@ -395,6 +513,7 @@ static void loongarch_la464_initfn(Object *obj)
     env->CSR_PRCFG3 =3D FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS,=
 8);
=20
     cpu->msgint =3D ON_OFF_AUTO_OFF;
+    cpu->lvz =3D ON_OFF_AUTO_AUTO;
     cpu->ptw =3D ON_OFF_AUTO_OFF;
     loongarch_cpu_post_init(obj);
 }
@@ -432,6 +551,7 @@ static void loongarch_la132_initfn(Object *obj)
     data =3D FIELD_DP32(data, CPUCFG1, CRC, 1);
     env->cpucfg[1] =3D data;
     cpu->msgint =3D ON_OFF_AUTO_OFF;
+    cpu->lvz =3D ON_OFF_AUTO_OFF;
     cpu->ptw =3D ON_OFF_AUTO_OFF;
 }
=20
@@ -637,6 +757,7 @@ static void loongarch_cpu_reset_hold(Object *obj, Reset=
Type type)
     env->CSR_RVACFG =3D FIELD_DP64(env->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
     env->CSR_CPUID =3D cs->cpu_index;
     env->CSR_TCFG =3D FIELD_DP64(env->CSR_TCFG, CSR_TCFG, EN, 0);
+    env->GCSR_TCFG =3D FIELD_DP64(env->GCSR_TCFG, CSR_TCFG, EN, 0);
     env->CSR_LLBCTL =3D FIELD_DP64(env->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
     env->CSR_TLBRERA =3D FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR,=
 0);
     env->CSR_MERRCTL =3D FIELD_DP64(env->CSR_MERRCTL, CSR_MERRCTL, ISMERR,=
 0);
@@ -671,6 +792,15 @@ static void loongarch_cpu_reset_hold(Object *obj, Rese=
tType type)
     env->pc =3D 0x1c000000;
 #ifdef CONFIG_TCG
     memset(env->tlb, 0, sizeof(env->tlb));
+    env->guest =3D false;
+    env->vm_exit =3D false;
+    env->CSR_GSTAT =3D FIELD_DP64(0, CSR_GSTAT, GIDBIT, 8);
+    env->CSR_GCFG =3D 0;
+    env->CSR_GINTC =3D 0;
+    env->CSR_GCNTC =3D 0;
+    env->CSR_GTLBC =3D 0;
+    env->CSR_TRGP =3D 0;
+    env->GCSR_ASID =3D FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
 #endif
     if (kvm_enabled()) {
         kvm_arch_reset_vcpu(cs);
@@ -731,6 +861,8 @@ static void loongarch_cpu_init(Object *obj)
 #ifdef CONFIG_TCG
     timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
                   &loongarch_constant_timer_cb, cpu);
+    timer_init_ns(&cpu->guest_timer, QEMU_CLOCK_VIRTUAL,
+                  &loongarch_constant_timer_cb_guest, cpu);
 #endif
 #endif
 }
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index e01dbed40f..8a06ab9868 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -32,14 +32,18 @@ void restore_fp_status(CPULoongArchState *env);
 extern const VMStateDescription vmstate_loongarch_cpu;
=20
 void loongarch_cpu_set_irq(void *opaque, int irq, int level);
+void loongarch_cpu_set_irq_guest(void *opaque, int irq, int level);
=20
 void loongarch_constant_timer_cb(void *opaque);
+void loongarch_constant_timer_cb_guest(void *opaque);
 uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
-uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
+uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu, bool gu=
est);
+void cpu_loongarch_set_guest_timer(LoongArchCPU *cpu, bool on);
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
-                                               uint64_t value);
+                                               uint64_t value, bool guest)=
;
 bool loongarch_cpu_has_work(CPUState *cs);
 bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
+bool loongarch_guest_has_interrupt(CPULoongArchState *env);
 #endif /* !CONFIG_USER_ONLY */
=20
 uint64_t read_fcc(CPULoongArchState *env);
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 9d844c4905..114f115e90 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -28,6 +28,7 @@
 #include "cpu-csr.h"
 #include "kvm_loongarch.h"
 #include "trace.h"
+#include "exec/target_long.h"
=20
 static bool cap_has_mp_state;
 static unsigned int brk_insn;
diff --git a/target/loongarch/tcg/constant_timer.c b/target/loongarch/tcg/c=
onstant_timer.c
index 1851f53fd6..97892e3ff9 100644
--- a/target/loongarch/tcg/constant_timer.c
+++ b/target/loongarch/tcg/constant_timer.c
@@ -20,29 +20,62 @@ uint64_t cpu_loongarch_get_constant_timer_counter(Loong=
ArchCPU *cpu)
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / TIMER_PERIOD;
 }
=20
-uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu)
+uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu, bool gu=
est)
 {
     uint64_t now, expire;
+    CPULoongArchState *env =3D &cpu->env;
+
+    if (guest && !env->guest) {
+        return env->GCSR_TVAL;
+    }
=20
     now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    expire =3D timer_expire_time_ns(&cpu->timer);
+    expire =3D timer_expire_time_ns(guest ? &cpu->guest_timer : &cpu->time=
r);
=20
     return (expire - now) / TIMER_PERIOD;
 }
=20
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
-                                               uint64_t value)
+                                               uint64_t value, bool guest)
 {
     CPULoongArchState *env =3D &cpu->env;
     uint64_t now, next;
+    QEMUTimer *timer =3D guest ? &cpu->guest_timer : &cpu->timer;
+
+    SET_CSR_IF(guest, TCFG, value);
+
+    if (guest && !env->guest) {
+        return;
+    }
=20
-    env->CSR_TCFG =3D value;
     if (value & CONSTANT_TIMER_ENABLE) {
         now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         next =3D now + (value & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
-        timer_mod(&cpu->timer, next);
+        timer_mod(timer, next);
     } else {
-        timer_del(&cpu->timer);
+        timer_del(timer);
+    }
+}
+
+void cpu_loongarch_set_guest_timer(LoongArchCPU *cpu, bool on)
+{
+    CPULoongArchState *env =3D &cpu->env;
+    uint64_t now, next, ticks;
+
+    if (!(env->GCSR_TCFG & CONSTANT_TIMER_ENABLE)) {
+        return;
+    }
+
+    if (on) {
+        now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        ticks =3D env->GCSR_TVAL ? env->GCSR_TVAL :
+                                 (env->GCSR_TCFG & CONSTANT_TIMER_TICK_MAS=
K);
+        next =3D now + ticks * TIMER_PERIOD;
+        env->GCSR_TVAL =3D 0;
+        timer_mod(&cpu->guest_timer, next);
+    } else {
+        env->GCSR_TVAL =3D cpu_loongarch_get_constant_timer_ticks(cpu, tru=
e);
+        timer_del(&cpu->guest_timer);
     }
 }
=20
@@ -62,3 +95,20 @@ void loongarch_constant_timer_cb(void *opaque)
=20
     loongarch_cpu_set_irq(opaque, IRQ_TIMER, 1);
 }
+
+void loongarch_constant_timer_cb_guest(void *opaque)
+{
+    LoongArchCPU *cpu =3D opaque;
+    CPULoongArchState *env =3D &cpu->env;
+    uint64_t now, next;
+
+    if (FIELD_EX64(env->GCSR_TCFG, CSR_TCFG, PERIODIC)) {
+        now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        next =3D now + (env->GCSR_TCFG & CONSTANT_TIMER_TICK_MASK) * TIMER=
_PERIOD;
+        timer_mod(&cpu->guest_timer, next);
+    } else {
+        env->GCSR_TCFG =3D FIELD_DP64(env->GCSR_TCFG, CSR_TCFG, EN, 0);
+    }
+
+    loongarch_cpu_set_irq_guest(opaque, IRQ_TIMER, 1);
+}
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_h=
elper.c
index cd35ca93c7..a680c6cbfe 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -58,6 +58,25 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
     return v;
 }
=20
+target_ulong helper_gcsrrd_pgd(CPULoongArchState *env)
+{
+    int64_t v;
+
+    if (env->GCSR_TLBRERA & 0x1) {
+        v =3D env->GCSR_TLBRBADV;
+    } else {
+        v =3D env->GCSR_BADV;
+    }
+
+    if ((v >> 63) & 0x1) {
+        v =3D env->GCSR_PGDH;
+    } else {
+        v =3D env->GCSR_PGDL;
+    }
+
+    return v;
+}
+
 target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
 {
     LoongArchCPU *lac =3D env_archcpu(env);
@@ -71,7 +90,14 @@ target_ulong helper_csrrd_tval(CPULoongArchState *env)
 {
     LoongArchCPU *cpu =3D env_archcpu(env);
=20
-    return cpu_loongarch_get_constant_timer_ticks(cpu);
+    return cpu_loongarch_get_constant_timer_ticks(cpu, false);
+}
+
+target_ulong helper_gcsrrd_tval(CPULoongArchState *env)
+{
+    LoongArchCPU *cpu =3D env_archcpu(env);
+
+    return cpu_loongarch_get_constant_timer_ticks(cpu, true);
 }
=20
 target_ulong helper_csrrd_msgir(CPULoongArchState *env)
@@ -105,6 +131,27 @@ target_ulong helper_csrwr_estat(CPULoongArchState *env=
, target_ulong val)
     return old_v;
 }
=20
+target_ulong helper_gcsrwr_estat(CPULoongArchState *env, target_ulong val)
+{
+    int64_t old_v =3D env->GCSR_ESTAT;
+
+    env->GCSR_ESTAT =3D deposit64(env->GCSR_ESTAT, 0, 2, val);
+    if (!env->guest) {
+        env->GCSR_ESTAT =3D
+            deposit64(env->GCSR_ESTAT, 2, 11, extract64(val, 2, 11));
+        if (extract64(val, 2, 8) &
+            FIELD_EX64(env->CSR_GINTC, CSR_GINTC, HWIC)) {
+            env->CSR_ESTAT =3D deposit64(env->CSR_ESTAT, 2, 8,
+                                       extract64(env->CSR_ESTAT, 2, 8) &
+                                           ~extract64(val, 2, 8));
+        }
+        env->GCSR_ESTAT =3D
+            deposit64(env->GCSR_ESTAT, 16, 15, extract64(val, 16, 15));
+    }
+
+    return old_v;
+}
+
 target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
 {
     int64_t old_v =3D env->CSR_ASID;
@@ -117,12 +164,33 @@ target_ulong helper_csrwr_asid(CPULoongArchState *env=
, target_ulong val)
     return old_v;
 }
=20
+target_ulong helper_gcsrwr_asid(CPULoongArchState *env, target_ulong val)
+{
+    int64_t old_v =3D env->GCSR_ASID;
+
+    env->GCSR_ASID =3D deposit64(env->GCSR_ASID, 0, 10, val);
+    if (old_v !=3D env->GCSR_ASID) {
+        tlb_flush(env_cpu(env));
+    }
+    return old_v;
+}
+
 target_ulong helper_csrwr_tcfg(CPULoongArchState *env, target_ulong val)
 {
     LoongArchCPU *cpu =3D env_archcpu(env);
     int64_t old_v =3D env->CSR_TCFG;
=20
-    cpu_loongarch_store_constant_timer_config(cpu, val);
+    cpu_loongarch_store_constant_timer_config(cpu, val, false);
+
+    return old_v;
+}
+
+target_ulong helper_gcsrwr_tcfg(CPULoongArchState *env, target_ulong val)
+{
+    LoongArchCPU *cpu =3D env_archcpu(env);
+    int64_t old_v =3D env->GCSR_TCFG;
+
+    cpu_loongarch_store_constant_timer_config(cpu, val, true);
=20
     return old_v;
 }
@@ -140,6 +208,61 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env=
, target_ulong val)
     return old_v;
 }
=20
+target_ulong helper_gcsrwr_ticlr(CPULoongArchState *env, target_ulong val)
+{
+    LoongArchCPU *cpu =3D env_archcpu(env);
+    int64_t old_v =3D 0;
+
+    if (val & 0x1) {
+        bql_lock();
+        loongarch_cpu_set_irq_guest(cpu, IRQ_TIMER, 0);
+        bql_unlock();
+    }
+    return old_v;
+}
+
+target_ulong helper_csrwr_gstat(CPULoongArchState *env, target_ulong val)
+{
+    int64_t old_v =3D env->CSR_GSTAT;
+    uint8_t old_gid =3D FIELD_EX64(env->CSR_GSTAT, CSR_GSTAT, GID);
+
+    env->CSR_GSTAT =3D FIELD_DP64(env->CSR_GSTAT, CSR_GSTAT, PVM,
+                                FIELD_EX64(val, CSR_GSTAT, PVM));
+    env->CSR_GSTAT =3D FIELD_DP64(env->CSR_GSTAT, CSR_GSTAT, GID,
+                                FIELD_EX64(val, CSR_GSTAT, GID));
+
+    if (old_gid !=3D FIELD_EX64(env->CSR_GSTAT, CSR_GSTAT, GID)) {
+        tlb_flush(env_cpu(env));
+    }
+
+    return old_v;
+}
+
+target_ulong helper_csrwr_gtlbc(CPULoongArchState *env, target_ulong val)
+{
+    int64_t old_v =3D env->CSR_GTLBC;
+    uint8_t old_use_tgid =3D FIELD_EX64(old_v, CSR_GTLBC, USETGID);
+    uint8_t old_tgid =3D FIELD_EX64(old_v, CSR_GTLBC, TGID);
+
+    env->CSR_GTLBC =3D val;
+    if (old_use_tgid !=3D FIELD_EX64(env->CSR_GTLBC, CSR_GTLBC, USETGID) |=
|
+        old_tgid !=3D FIELD_EX64(env->CSR_GTLBC, CSR_GTLBC, TGID)) {
+        tlb_flush(env_cpu(env));
+    }
+
+    return old_v;
+}
+
+target_ulong helper_csrwr_gintc(CPULoongArchState *env, target_ulong val)
+{
+    int64_t old_v =3D env->CSR_GINTC;
+
+    env->CSR_GINTC =3D val & 0xffff00;
+    env->GCSR_ESTAT =3D deposit64(env->GCSR_ESTAT, 2, 8, extract64(val, 0,=
 8));
+
+    return old_v;
+}
+
 target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
 {
     uint8_t shift, ptbase;
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 8a6c62f116..69f6cb352a 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -14,7 +14,7 @@ DEF_HELPER_FLAGS_3(asrtgt_d, TCG_CALL_NO_WG, void, env, t=
l, tl)
=20
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
-DEF_HELPER_FLAGS_2(cpucfg, TCG_CALL_NO_RWG_SE, tl, env, tl)
+DEF_HELPER_FLAGS_2(cpucfg, TCG_CALL_NO_WG_SE, tl, env, tl)
=20
 /* Floating-point helper */
 DEF_HELPER_FLAGS_3(fadd_s, TCG_CALL_NO_WG, i64, env, i64, i64)
@@ -98,14 +98,23 @@ DEF_HELPER_1(rdtime_d, i64, env)
 #ifndef CONFIG_USER_ONLY
 /* CSRs helper */
 DEF_HELPER_1(csrrd_pgd, i64, env)
+DEF_HELPER_1(gcsrrd_pgd, i64, env)
 DEF_HELPER_1(csrrd_cpuid, i64, env)
 DEF_HELPER_1(csrrd_tval, i64, env)
+DEF_HELPER_1(gcsrrd_tval, i64, env)
 DEF_HELPER_1(csrrd_msgir, i64, env)
 DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
 DEF_HELPER_2(csrwr_estat, i64, env, tl)
+DEF_HELPER_2(gcsrwr_estat, i64, env, tl)
 DEF_HELPER_2(csrwr_asid, i64, env, tl)
+DEF_HELPER_2(gcsrwr_asid, i64, env, tl)
 DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
+DEF_HELPER_2(gcsrwr_tcfg, i64, env, tl)
 DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
+DEF_HELPER_2(gcsrwr_ticlr, i64, env, tl)
+DEF_HELPER_2(csrwr_gstat, i64, env, tl)
+DEF_HELPER_2(csrwr_gtlbc, i64, env, tl)
+DEF_HELPER_2(csrwr_gintc, i64, env, tl)
 DEF_HELPER_2(csrwr_pwcl, i64, env, tl)
 DEF_HELPER_2(csrwr_pwch, i64, env, tl)
 DEF_HELPER_2(iocsrrd_b, i64, env, tl)
@@ -134,6 +143,8 @@ DEF_HELPER_4(lddir, tl, env, tl, i32, i32)
 DEF_HELPER_4(ldpte, void, env, tl, tl, i32)
 DEF_HELPER_1(ertn, void, env)
 DEF_HELPER_1(idle, void, env)
+DEF_HELPER_2(hvcl, void, env, i32)
+DEF_HELPER_1(gspr, void, env)
 #endif
=20
 /* LoongArch LSX  */
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_hel=
per.c
index 16ac0d43bc..28043697d8 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -15,6 +15,7 @@
 #include "qemu/crc32c.h"
 #include <zlib.h> /* for crc32 */
 #include "cpu-csr.h"
+#include "qemu/main-loop.h"
=20
 /* Exceptions helpers */
 void helper_raise_exception(CPULoongArchState *env, uint32_t exception)
@@ -81,6 +82,10 @@ target_ulong helper_crc32c(target_ulong val, target_ulon=
g m, uint64_t sz)
=20
 target_ulong helper_cpucfg(CPULoongArchState *env, target_ulong rj)
 {
+    if (env->guest) {
+        trigger_vm_exit(env);
+        do_raise_exception(env, EXCCODE_GSPR, GETPC());
+    }
     return rj >=3D ARRAY_SIZE(env->cpucfg) ? 0 : env->cpucfg[rj];
 }
=20
@@ -92,8 +97,9 @@ uint64_t helper_rdtime_d(CPULoongArchState *env)
     uint64_t plv;
     LoongArchCPU *cpu =3D env_archcpu(env);
=20
-    plv =3D FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
-    if (extract64(env->CSR_MISC, R_CSR_MISC_DRDTL_SHIFT + plv, 1)) {
+    plv =3D FIELD_EX64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, PLV);
+    if (extract64(GET_CSR_IF(env->guest, MISC), R_CSR_MISC_DRDTL_SHIFT + p=
lv,
+                  1)) {
         do_raise_exception(env, EXCCODE_IPE, GETPC());
     }
=20
@@ -105,28 +111,50 @@ uint64_t helper_rdtime_d(CPULoongArchState *env)
 void helper_ertn(CPULoongArchState *env)
 {
     uint64_t csr_pplv, csr_pie;
-    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        csr_pplv =3D FIELD_EX64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV);
-        csr_pie =3D FIELD_EX64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PIE);
-
-        env->CSR_TLBRERA =3D FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, IST=
LBR, 0);
-        env->CSR_CRMD =3D FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DA, 0);
-        env->CSR_CRMD =3D FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 1);
-        set_pc(env, env->CSR_TLBRERA);
-        qemu_log_mask(CPU_LOG_INT, "%s: TLBRERA " TARGET_FMT_lx "\n",
-                      __func__, env->CSR_TLBRERA);
+
+    if (FIELD_EX64(GET_CSR_IF(env->guest, TLBRERA), CSR_TLBRERA, ISTLBR)) =
{
+        csr_pplv =3D
+            FIELD_EX64(GET_CSR_IF(env->guest, TLBRPRMD), CSR_TLBRPRMD, PPL=
V);
+        csr_pie =3D
+            FIELD_EX64(GET_CSR_IF(env->guest, TLBRPRMD), CSR_TLBRPRMD, PIE=
);
+
+        SET_CSR_IF(env->guest, TLBRERA,
+                   FIELD_DP64(GET_CSR_IF(env->guest, TLBRERA), CSR_TLBRERA=
,
+                              ISTLBR, 0));
+        SET_CSR_IF(env->guest, CRMD,
+                   FIELD_DP64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, DA, =
0));
+        SET_CSR_IF(env->guest, CRMD,
+                   FIELD_DP64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, PG, =
1));
+        set_pc(env, GET_CSR_IF(env->guest, TLBRERA));
+        qemu_log_mask(CPU_LOG_INT, "%s: TLBRERA " TARGET_FMT_lx "\n", __fu=
nc__,
+                      GET_CSR_IF(env->guest, TLBRERA));
     } else {
-        csr_pplv =3D FIELD_EX64(env->CSR_PRMD, CSR_PRMD, PPLV);
-        csr_pie =3D FIELD_EX64(env->CSR_PRMD, CSR_PRMD, PIE);
+        csr_pplv =3D FIELD_EX64(GET_CSR_IF(env->guest, PRMD), CSR_PRMD, PP=
LV);
+        csr_pie =3D FIELD_EX64(GET_CSR_IF(env->guest, PRMD), CSR_PRMD, PIE=
);
=20
-        set_pc(env, env->CSR_ERA);
-        qemu_log_mask(CPU_LOG_INT, "%s: ERA " TARGET_FMT_lx "\n",
-                      __func__, env->CSR_ERA);
+        set_pc(env, GET_CSR_IF(env->guest, ERA));
+        qemu_log_mask(CPU_LOG_INT, "%s: ERA " TARGET_FMT_lx "\n", __func__=
,
+                      GET_CSR_IF(env->guest, ERA));
     }
-    env->CSR_CRMD =3D FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PLV, csr_pplv);
-    env->CSR_CRMD =3D FIELD_DP64(env->CSR_CRMD, CSR_CRMD, IE, csr_pie);
+    SET_CSR_IF(
+        env->guest, CRMD,
+        FIELD_DP64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, PLV, csr_pplv))=
;
+    SET_CSR_IF(env->guest, CRMD,
+               FIELD_DP64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, IE, csr_=
pie));
=20
     env->lladdr =3D 1;
+    if (will_return_to_guest(env)) {
+        env->guest =3D true;
+        env->CSR_GSTAT =3D FIELD_DP64(env->CSR_GSTAT, CSR_GSTAT, VM, 1);
+        cpu_loongarch_set_guest_timer(env_archcpu(env), true);
+        bql_lock();
+        if (loongarch_guest_has_interrupt(env)) {
+            cpu_interrupt(env_cpu(env), CPU_INTERRUPT_GUEST);
+        } else {
+            cpu_reset_interrupt(env_cpu(env), CPU_INTERRUPT_GUEST);
+        }
+        bql_unlock();
+    }
 }
=20
 void helper_idle(CPULoongArchState *env)
@@ -136,4 +164,21 @@ void helper_idle(CPULoongArchState *env)
     cs->halted =3D 1;
     do_raise_exception(env, EXCP_HLT, 0);
 }
+
+void helper_hvcl(CPULoongArchState *env, uint32_t code)
+{
+    if (!env->guest) {
+        do_raise_exception(env, EXCCODE_INE, GETPC());
+        return;
+    }
+
+    trigger_vm_exit(env);
+    do_raise_exception(env, EXCCODE_HVC, GETPC());
+}
+
+void helper_gspr(CPULoongArchState *env)
+{
+    trigger_vm_exit(env);
+    do_raise_exception(env, EXCCODE_GSPR, GETPC());
+}
 #endif
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.=
c
index 31d3db6e8e..7bc4911524 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -43,6 +43,10 @@ static const struct TypeExcp excp_names[] =3D {
     {EXCCODE_BCE, "Bound Check Exception"},
     {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
     {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
+    {EXCCODE_GSPR, "Guest Sensitive and Privileged Resources"},
+    {EXCCODE_HVC, "Hypervisor call"},
+    {EXCCODE_GCSC, "Guest CSR visited by Software"},
+    {EXCCODE_GCHC, "Guest CSR visited by Hardware"},
     {EXCP_HLT, "EXCP_HLT"},
 };
=20
@@ -79,9 +83,12 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     CPULoongArchState *env =3D cpu_env(cs);
     bool update_badinstr =3D 1;
     int cause =3D -1;
-    bool tlbfill =3D FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
-    uint32_t vec_size =3D FIELD_EX64(env->CSR_ECFG, CSR_ECFG, VS);
+    bool real_guest =3D !env->vm_exit && env->guest;
+    bool tlbfill =3D
+        FIELD_EX64(GET_CSR_IF(real_guest, TLBRERA), CSR_TLBRERA, ISTLBR);
+    uint32_t vec_size =3D FIELD_EX64(GET_CSR_IF(real_guest, ECFG), CSR_ECF=
G, VS);
     uint64_t last_pc =3D env->pc;
+    uint32_t badinstr;
=20
     if (cs->exception_index !=3D EXCCODE_INT) {
         qemu_log_mask(CPU_LOG_INT,
@@ -115,7 +122,11 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
         update_badinstr =3D 0;
         break;
     case EXCCODE_BCE:
-        env->CSR_BADV =3D env->pc;
+    case EXCCODE_GSPR:
+    case EXCCODE_GCHC:
+    case EXCCODE_GCSC:
+    case EXCCODE_HVC:
+        SET_CSR_IF(real_guest, BADV, env->pc);
         QEMU_FALLTHROUGH;
     case EXCCODE_SYS:
     case EXCCODE_BRK:
@@ -142,35 +153,51 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     if (update_badinstr) {
         MemOpIdx oi =3D make_memop_idx(MO_LEUL, cpu_mmu_index(cs, true));
=20
-        env->CSR_BADI =3D cpu_ldl_code_mmu(env, env->pc, oi, 0);
+        badinstr =3D cpu_ldl_code_mmu(env, env->pc, oi, 0);
+        SET_CSR_IF(real_guest, BADI, badinstr);
     }
=20
     /* Save PLV and IE */
     if (tlbfill) {
-        env->CSR_TLBRPRMD =3D FIELD_DP64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, =
PPLV,
-                                       FIELD_EX64(env->CSR_CRMD,
-                                       CSR_CRMD, PLV));
-        env->CSR_TLBRPRMD =3D FIELD_DP64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, =
PIE,
-                                       FIELD_EX64(env->CSR_CRMD, CSR_CRMD,=
 IE));
+        SET_CSR_IF(real_guest, TLBRPRMD,
+                   FIELD_DP64(GET_CSR_IF(real_guest, TLBRPRMD), CSR_TLBRPR=
MD,
+                              PPLV,
+                              FIELD_EX64(GET_CSR_IF(real_guest, CRMD), CSR=
_CRMD,
+                                         PLV)));
+        SET_CSR_IF(
+            real_guest, TLBRPRMD,
+            FIELD_DP64(GET_CSR_IF(real_guest, TLBRPRMD), CSR_TLBRPRMD, PIE=
,
+                       FIELD_EX64(GET_CSR_IF(real_guest, CRMD), CSR_CRMD, =
IE)));
         /* set the DA mode */
-        env->CSR_CRMD =3D FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DA, 1);
-        env->CSR_CRMD =3D FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 0);
-        env->CSR_TLBRERA =3D FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA,
-                                      PC, (env->pc >> 2));
+        SET_CSR_IF(real_guest, CRMD,
+                   FIELD_DP64(GET_CSR_IF(real_guest, CRMD), CSR_CRMD, DA, =
1));
+        SET_CSR_IF(real_guest, CRMD,
+                   FIELD_DP64(GET_CSR_IF(real_guest, CRMD), CSR_CRMD, PG, =
0));
+        SET_CSR_IF(real_guest, TLBRERA,
+                   FIELD_DP64(GET_CSR_IF(real_guest, TLBRERA), CSR_TLBRERA=
, PC,
+                              (env->pc >> 2)));
     } else {
-        env->CSR_ESTAT =3D FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, ECODE,
-                                    EXCODE_MCODE(cause));
-        env->CSR_ESTAT =3D FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, ESUBCODE,
-                                    EXCODE_SUBCODE(cause));
-        env->CSR_PRMD =3D FIELD_DP64(env->CSR_PRMD, CSR_PRMD, PPLV,
-                                   FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV=
));
-        env->CSR_PRMD =3D FIELD_DP64(env->CSR_PRMD, CSR_PRMD, PIE,
-                                   FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE)=
);
-        env->CSR_ERA =3D env->pc;
+        SET_CSR_IF(real_guest, ESTAT,
+                   FIELD_DP64(GET_CSR_IF(real_guest, ESTAT), CSR_ESTAT, EC=
ODE,
+                              EXCODE_MCODE(cause)));
+        SET_CSR_IF(real_guest, ESTAT,
+                   FIELD_DP64(GET_CSR_IF(real_guest, ESTAT), CSR_ESTAT,
+                              ESUBCODE, EXCODE_SUBCODE(cause)));
+        SET_CSR_IF(real_guest, PRMD,
+                   FIELD_DP64(GET_CSR_IF(real_guest, PRMD), CSR_PRMD, PPLV=
,
+                              FIELD_EX64(GET_CSR_IF(real_guest, CRMD), CSR=
_CRMD,
+                                         PLV)));
+        SET_CSR_IF(
+            real_guest, PRMD,
+            FIELD_DP64(GET_CSR_IF(real_guest, PRMD), CSR_PRMD, PIE,
+                       FIELD_EX64(GET_CSR_IF(real_guest, CRMD), CSR_CRMD, =
IE)));
+        SET_CSR_IF(real_guest, ERA, env->pc);
     }
=20
-    env->CSR_CRMD =3D FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PLV, 0);
-    env->CSR_CRMD =3D FIELD_DP64(env->CSR_CRMD, CSR_CRMD, IE, 0);
+    SET_CSR_IF(real_guest, CRMD,
+               FIELD_DP64(GET_CSR_IF(real_guest, CRMD), CSR_CRMD, PLV, 0))=
;
+    SET_CSR_IF(real_guest, CRMD,
+               FIELD_DP64(GET_CSR_IF(real_guest, CRMD), CSR_CRMD, IE, 0));
=20
     if (vec_size) {
         vec_size =3D (1 << vec_size) * 4;
@@ -179,43 +206,54 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     if  (cs->exception_index =3D=3D EXCCODE_INT) {
         /* Interrupt */
         uint32_t vector =3D 0;
-        uint32_t pending =3D FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS);
-        pending &=3D FIELD_EX64(env->CSR_ECFG, CSR_ECFG, LIE);
+        uint32_t pending =3D
+            FIELD_EX64(GET_CSR_IF(real_guest, ESTAT), CSR_ESTAT, IS);
+        pending &=3D FIELD_EX64(GET_CSR_IF(real_guest, ECFG), CSR_ECFG, LI=
E);
=20
         /* Find the highest-priority interrupt. */
         vector =3D 31 - clz32(pending);
-        set_pc(env, env->CSR_EENTRY + \
-               (EXCCODE_EXTERNAL_INT + vector) * vec_size);
-        qemu_log_mask(CPU_LOG_INT,
-                      "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
-                      " cause %d\n" "    A " TARGET_FMT_lx " D "
-                      TARGET_FMT_lx " vector =3D %d ExC " TARGET_FMT_lx "E=
xS"
-                      TARGET_FMT_lx "\n",
-                      __func__, env->pc, env->CSR_ERA,
-                      cause, env->CSR_BADV, env->CSR_DERA, vector,
-                      env->CSR_ECFG, env->CSR_ESTAT);
+        set_pc(env, GET_CSR_IF(real_guest, EENTRY) +
+                        (EXCCODE_EXTERNAL_INT + vector) * vec_size);
+        qemu_log_mask(
+            CPU_LOG_INT,
+            "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx " cause %d\n"
+            "    A " TARGET_FMT_lx " D " TARGET_FMT_lx
+            " vector =3D %d ExC " TARGET_FMT_lx "ExS" TARGET_FMT_lx "\n",
+            __func__, env->pc, GET_CSR_IF(real_guest, ERA), cause,
+            GET_CSR_IF(real_guest, BADV), GET_CSR_IF(real_guest, DERA), ve=
ctor,
+            GET_CSR_IF(real_guest, ECFG), GET_CSR_IF(real_guest, ESTAT));
         qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
     } else {
         if (tlbfill) {
-            set_pc(env, env->CSR_TLBRENTRY);
+            set_pc(env, GET_CSR_IF(real_guest, TLBRENTRY));
         } else {
-            set_pc(env, env->CSR_EENTRY + EXCODE_MCODE(cause) * vec_size);
+            set_pc(env, GET_CSR_IF(real_guest, EENTRY) +
+                            EXCODE_MCODE(cause) * vec_size);
         }
-        qemu_log_mask(CPU_LOG_INT,
-                      "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
-                      " cause %d%s\n, ESTAT " TARGET_FMT_lx
-                      " EXCFG " TARGET_FMT_lx " BADVA " TARGET_FMT_lx
-                      "BADI " TARGET_FMT_lx " SYS_NUM " TARGET_FMT_lu
-                      " cpu %d asid " TARGET_FMT_lx "\n", __func__, env->p=
c,
-                      tlbfill ? env->CSR_TLBRERA : env->CSR_ERA,
-                      cause, tlbfill ? "(refill)" : "", env->CSR_ESTAT,
-                      env->CSR_ECFG,
-                      tlbfill ? env->CSR_TLBRBADV : env->CSR_BADV,
-                      env->CSR_BADI, env->gpr[11], cs->cpu_index,
-                      env->CSR_ASID);
+        qemu_log_mask(
+            CPU_LOG_INT,
+            "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
+            " cause %d%s\n, ESTAT " TARGET_FMT_lx " EXCFG " TARGET_FMT_lx
+            " BADVA " TARGET_FMT_lx "BADI " TARGET_FMT_lx
+            " SYS_NUM " TARGET_FMT_lu " cpu %d asid " TARGET_FMT_lx "\n",
+            __func__, env->pc,
+            tlbfill ? GET_CSR_IF(real_guest, TLBRERA) :
+                      GET_CSR_IF(real_guest, ERA),
+            cause, tlbfill ? "(refill)" : "", GET_CSR_IF(real_guest, ESTAT=
),
+            GET_CSR_IF(real_guest, ECFG),
+            tlbfill ? GET_CSR_IF(real_guest, TLBRBADV) :
+                      GET_CSR_IF(real_guest, BADV),
+            GET_CSR_IF(real_guest, BADI), env->gpr[11], cs->cpu_index,
+            GET_CSR_IF(real_guest, ASID));
         qemu_plugin_vcpu_exception_cb(cs, last_pc);
     }
     cs->exception_index =3D -1;
+    if (env->vm_exit) {
+        env->CSR_GSTAT =3D FIELD_DP64(env->CSR_GSTAT, CSR_GSTAT, VM, 0);
+        env->guest =3D false;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_GUEST);
+    }
+    env->vm_exit =3D false;
 }
=20
 static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physa=
ddr,
@@ -247,16 +285,25 @@ static inline bool cpu_loongarch_hw_interrupts_enable=
d(CPULoongArchState *env)
=20
 static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_reque=
st)
 {
-    if (interrupt_request & CPU_INTERRUPT_HARD) {
-        CPULoongArchState *env =3D cpu_env(cs);
+    CPULoongArchState *env =3D cpu_env(cs);
+    bool has_interrupt =3D false;
=20
+    if (interrupt_request & CPU_INTERRUPT_HARD) {
         if (cpu_loongarch_hw_interrupts_enabled(env) &&
             cpu_loongarch_hw_interrupts_pending(env)) {
-            /* Raise it */
-            cs->exception_index =3D EXCCODE_INT;
-            loongarch_cpu_do_interrupt(cs);
-            return true;
+            if (env->guest) {
+                trigger_vm_exit(env);
+            }
+            has_interrupt =3D true;
         }
+    } else if (interrupt_request & CPU_INTERRUPT_GUEST) {
+        has_interrupt =3D loongarch_guest_has_interrupt(env);
+    }
+
+    if (has_interrupt) {
+        cs->exception_index =3D EXCCODE_INT;
+        loongarch_cpu_do_interrupt(cs);
+        return true;
     }
     return false;
 }
@@ -273,10 +320,18 @@ static TCGTBCPUState loongarch_get_tb_cpu_state(CPUSt=
ate *cs)
     CPULoongArchState *env =3D cpu_env(cs);
     uint32_t flags;
=20
-    flags =3D env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
-    flags |=3D FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FP=
E;
-    flags |=3D FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SX=
E;
-    flags |=3D FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_A=
SXE;
+    if (env->guest) {
+        flags =3D env->GCSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MA=
SK);
+        flags |=3D HW_FLAGS_GUEST_MODE;
+    } else {
+        flags =3D env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MAS=
K);
+    }
+    flags |=3D FIELD_EX64(GET_CSR_IF(env->guest, EUEN), CSR_EUEN, FPE) *
+             HW_FLAGS_EUEN_FPE;
+    flags |=3D FIELD_EX64(GET_CSR_IF(env->guest, EUEN), CSR_EUEN, SXE) *
+             HW_FLAGS_EUEN_SXE;
+    flags |=3D FIELD_EX64(GET_CSR_IF(env->guest, EUEN), CSR_EUEN, ASXE) *
+             HW_FLAGS_EUEN_ASXE;
     flags |=3D is_va32(env) * HW_FLAGS_VA32;
=20
     return (TCGTBCPUState){ .pc =3D env->pc, .flags =3D flags };
@@ -300,6 +355,13 @@ static int loongarch_cpu_mmu_index(CPUState *cs, bool =
ifetch)
 {
     CPULoongArchState *env =3D cpu_env(cs);
=20
+    if (env->guest) {
+        if (FIELD_EX64(env->GCSR_CRMD, CSR_CRMD, PG)) {
+            return MMU_GUEST_IDX + FIELD_EX64(env->GCSR_CRMD, CSR_CRMD, PL=
V);
+        }
+        return MMU_GUEST_DA_IDX;
+    }
+
     if (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG)) {
         return FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
     }
--=20
2.52.0

