Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E8CCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 13:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOy27-0000ee-Fv; Mon, 18 May 2026 09:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pm_bounces@pm.mtasv.net>)
 id 1wOscJ-0002US-J2
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:42:23 -0400
Received: from mta216a-ord.mtasv.net ([104.245.209.216])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pm_bounces@pm.mtasv.net>)
 id 1wOscD-0003fP-Nr
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:42:23 -0400
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoicWVtdS1kZXZlbEBub25nbnUub3JnIn0=
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806;
 c=relaxed/relaxed; 
 bh=V58Rw6J4JnrVD1BNMhgwIJVvJMRjR0oKGzWR7bG1W2M=;
 h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
 t=1779090134; x=1779694934;
 b=iWA+aXP9oIngGpJ7OGmwE34EvNWFQMXdg1NsF7YWSfzETfSGd6wD/75XgcQRbGmdtZTmDdJI7
 hzJA5R8PnU9BesUx6wMjay3pDaeg0yW2LBqi0abq0K1ldOhTQnAwu6SJIaU4fks5+F6AovYKhuZ
 i+Snh5r40wGrZFAPrPR9JUAiGw84DS11+pugDYkhYGcc0u95V/6l/dzZO0PWMR+hkBjHLPiJMlv
 VmETp1TLqLncV9NeJfsDwJYxxaIoi0V+DBbNKqnuog2XVdSZwoxJbXij9dEHl5Uu0cv+IGtmpkH
 TYgqscIPV5wOC+X39KYaOuI4j0UXp0nvLA/iVs+is2kA==;
Received: from ip-172-26-21-187.us-east-2.compute.internal (172.26.21.187)
 by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.241.65) 
 with ESMTP id 166f7fd5528d11f19be00269fbd216fb for <qemu-devel@nongnu.org>;
 Mon, 18 May 2026 07:42:14 +0000
From: SignKirigami <prcups@krgm.moe>
Date: Mon, 18 May 2026 07:42:14 +0000
Subject: [PATCH] target/loongarch: add LVZ support for TCG
Message-Id: <7f9a2f3f-896b-4415-b535-429b858fb337@mtasv.net>
To: qemu-devel@nongnu.org
Cc: SignKirigami <prcups@krgm.moe>, Bibo Mao <maobibo@loongson.cn>,
 xianglai li <lixianglai@loongson.cn>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.52.0
Feedback-ID: s9655927-_:s9655927:a251693:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 251693_9655927
X-PM-Message-Id: 7f9a2f3f-896b-4415-b535-429b858fb337
X-PM-RCPT: |bTF8MjUxNjkzfDk2NTU5Mjd8cWVtdS1kZXZlbEBub25nbnUub3Jn|
X-PM-Message-Options: v1;
 1.80QQDPSSw3DSHE9QXlqO3g.OXT9Zhoqy9TOFDtVmWaI0jBLDFBzosLGuFv4XSa9dSvyipYQFibtXf77WfAwus-i3julmWIi423AowlpgfFP6_5niNo8Qx12jKigAeyVicbbhbnXRUG0nGf1htEOwltKVRtQPG1ijaL7w-18QkN_QykcBpS1S0vqRZILdHkeukR0LK0fiof2Jz5fdD_rL5Hg
X-virtual-MTA: ord-104-245-209-216
X-PM-MTA-Pool: transactional-2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=104.245.209.216;
 envelope-from=pm_bounces@pm.mtasv.net; helo=mta216a-ord.mtasv.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 18 May 2026 09:29:17 -0400
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

This patch implements Loongson VirtualiZation (LVZ) extension
support for LoongArch's TCG target. With this patch, it is
now possible to start a nested KVM-accelerated virtual machine
on a TCG-emulated virtual machine.

Cc: Bibo Mao <maobibo@loongson.cn>
Cc: xianglai li <lixianglai@loongson.cn>
Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu-csr.h                    |  42 ++
 target/loongarch/cpu-mmu.h                    |  37 +-
 target/loongarch/cpu.c                        | 132 ++++
 target/loongarch/cpu.h                        | 125 +++-
 target/loongarch/cpu_helper.c                 | 119 ++--
 target/loongarch/csr.c                        | 122 ++++
 target/loongarch/csr.h                        |   3 +
 target/loongarch/disas.c                      |  10 +
 target/loongarch/insns.decode                 |  17 +
 target/loongarch/internals.h                  |   8 +-
 target/loongarch/kvm/kvm.c                    |   1 +
 target/loongarch/machine.c                    | 249 ++++---
 target/loongarch/tcg/constant_timer.c         |  62 +-
 target/loongarch/tcg/csr_helper.c             | 127 +++-
 target/loongarch/tcg/helper.h                 |  30 +-
 .../tcg/insn_trans/trans_privileged.c.inc     | 353 +++++++++-
 target/loongarch/tcg/op_helper.c              |  83 ++-
 target/loongarch/tcg/tcg_cpu.c                | 182 +++--
 target/loongarch/tcg/tcg_loongarch.h          |   6 +-
 target/loongarch/tcg/tlb_helper.c             | 629 +++++++++++++-----
 target/loongarch/tcg/translate.c              |   6 +-
 target/loongarch/translate.h                  |   2 +
 22 files changed, 1909 insertions(+), 436 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index d860417af2..4b0bb4d2e5 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -180,11 +180,13 @@ FIELD(CSR_TLBREHI_64, VPPN, 13, 35)
 #define LOONGARCH_CSR_TLBRPRMD       0x8f /* TLB refill mode info */
 FIELD(CSR_TLBRPRMD, PPLV, 0, 2)
 FIELD(CSR_TLBRPRMD, PIE, 2, 1)
+FIELD(CSR_TLBRPRMD, PGM, 3, 1)
 FIELD(CSR_TLBRPRMD, PWE, 4, 1)
=20
 /* Machine Error CSRs */
 #define LOONGARCH_CSR_MERRCTL        0x90 /* ERRCTL */
 FIELD(CSR_MERRCTL, ISMERR, 0, 1)
+FIELD(CSR_MERRCTL, PGM, 5, 1)
 #define LOONGARCH_CSR_MERRINFO1      0x91
 #define LOONGARCH_CSR_MERRINFO2      0x92
 #define LOONGARCH_CSR_MERRENTRY      0x93 /* MError exception base */
@@ -224,4 +226,44 @@ FIELD(CSR_DBG, ECODE, 16, 6)
 #define LOONGARCH_CSR_DERA           0x501 /* Debug era */
 #define LOONGARCH_CSR_DSAVE          0x502 /* Debug save */
=20
+/* LVZ (LoongArch Virtualization) CSRs */
+#define LOONGARCH_CSR_GSTAT          0x50 /* Guest status */
+FIELD(CSR_GSTAT, VM, 0, 1)
+FIELD(CSR_GSTAT, PVM, 1, 1)
+FIELD(CSR_GSTAT, GIDBIT, 4, 6)
+FIELD(CSR_GSTAT, GID, 16, 8)
+
+#define LOONGARCH_CSR_GCFG           0x51 /* Guest config */
+FIELD(CSR_GCFG, MATP, 0, 4)
+FIELD(CSR_GCFG, MATC, 4, 2)
+FIELD(CSR_GCFG, TOPIP, 6, 1)
+FIELD(CSR_GCFG, TOPI, 7, 1)
+FIELD(CSR_GCFG, TOTIP, 8, 1)
+FIELD(CSR_GCFG, TOTI, 9, 1)
+FIELD(CSR_GCFG, TOEP, 10, 1)
+FIELD(CSR_GCFG, TOE, 11, 1)
+FIELD(CSR_GCFG, TOPP, 12, 1)
+FIELD(CSR_GCFG, TOP, 13, 1)
+FIELD(CSR_GCFG, TOHUP, 14, 1)
+FIELD(CSR_GCFG, TOHU, 15, 1)
+FIELD(CSR_GCFG, TOCIP, 16, 4)
+FIELD(CSR_GCFG, TOCI, 20, 2)
+FIELD(CSR_GCFG, GPMP, 23, 1)
+FIELD(CSR_GCFG, GPMNUM, 24, 3)
+
+#define LOONGARCH_CSR_GINTC          0x52 /* Guest interrupt config */
+FIELD(CSR_GINTC, HWIS, 0, 8)
+FIELD(CSR_GINTC, HWIP, 8, 8)
+FIELD(CSR_GINTC, HWIC, 16, 8)
+
+#define LOONGARCH_CSR_GCNTC          0x53 /* Guest counter compensation */
+
+#define LOONGARCH_CSR_GTLBC          0x15 /* Guest TLB control */
+FIELD(CSR_GTLBC, GMTLBSZ, 0, 6)
+FIELD(CSR_GTLBC, USETGID, 12, 1)
+FIELD(CSR_GTLBC, TOTI, 13, 1)
+FIELD(CSR_GTLBC, TGID, 16, 8)
+
+#define LOONGARCH_CSR_TRGP           0x16 /* Trapped guest physical addres=
s */
+
 #endif /* LOONGARCH_CPU_CSR_H */
diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 2d7ebb2d72..31093641ff 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -17,6 +17,14 @@ typedef enum TLBRet {
     TLBRET_RI,
     TLBRET_XI,
     TLBRET_PE,
+    TLBRET_HOST_MATCH,
+    TLBRET_HOST_BADADDR,
+    TLBRET_HOST_NOMATCH,
+    TLBRET_HOST_INVALID,
+    TLBRET_HOST_DIRTY,
+    TLBRET_HOST_RI,
+    TLBRET_HOST_XI,
+    TLBRET_HOST_PE,
 } TLBRet;
=20
 typedef struct MMUContext {
@@ -30,16 +38,17 @@ typedef struct MMUContext {
     uint64_t      pte_buddy[2];
 } MMUContext;
=20
-static inline bool cpu_has_ptw(CPULoongArchState *env)
+static inline bool cpu_has_ptw(CPULoongArchState *env, bool guest)
 {
-    return !!FIELD_EX64(env->CSR_PWCH, CSR_PWCH, HPTW_EN);
+    return !!FIELD_EX64(GET_CSR_IF(guest, PWCH), CSR_PWCH, HPTW_EN);
 }
=20
-static inline bool pte_present(CPULoongArchState *env, uint64_t entry)
+static inline bool pte_present(CPULoongArchState *env, uint64_t entry,
+                               bool guest)
 {
     uint8_t present;
=20
-    if (cpu_has_ptw(env)) {
+    if (cpu_has_ptw(env, guest)) {
         present =3D FIELD_EX64(entry, TLBENTRY, P);
     } else {
         present =3D FIELD_EX64(entry, TLBENTRY, V);
@@ -48,11 +57,11 @@ static inline bool pte_present(CPULoongArchState *env, =
uint64_t entry)
     return !!present;
 }
=20
-static inline bool pte_write(CPULoongArchState *env, uint64_t entry)
+static inline bool pte_write(CPULoongArchState *env, uint64_t entry, bool =
guest)
 {
     uint8_t writable;
=20
-    if (cpu_has_ptw(env)) {
+    if (cpu_has_ptw(env, guest)) {
         writable =3D FIELD_EX64(entry, TLBENTRY, W);
     } else {
         writable =3D FIELD_EX64(entry, TLBENTRY, D);
@@ -89,14 +98,22 @@ static inline bool pte_dirty(uint64_t entry)
=20
 bool check_ps(CPULoongArchState *ent, uint8_t ps);
 TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
-                           MMUAccessType access_type, int mmu_idx);
+                           MMUAccessType access_type, int mmu_idx, bool gu=
est);
 TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
-                            int is_debug);
+                            int is_debug, uintptr_t retaddr);
 TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
-                     int access_type, int mmu_idx, int debug);
+                     int access_type, int mmu_idx, int debug, bool guest,
+                     uintptr_t retaddr);
+hwaddr loongarch_get_host_address(CPULoongArchState *env, hwaddr gpa,
+                                  uintptr_t retaddr);
+TLBRet loongarch_map_host_address(CPULoongArchState *env, MMUContext *cont=
ext,
+                                  MMUAccessType access_type, uintptr_t ret=
addr);
+TLBRet loongarch_map_address(CPULoongArchState *env, MMUContext *context,
+                             MMUAccessType access_type, int mmu_idx,
+                             int is_debug, bool guest, uintptr_t retaddr);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
-                        uint64_t *dir_width, unsigned int level);
+                        uint64_t *dir_width, unsigned int level, bool gues=
t);
 hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 uint64_t loongarch_palen_mask(CPULoongArchState *env);
=20
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
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 096d778928..8d3cae59fa 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -20,6 +20,20 @@
 #include "cpu-csr.h"
 #include "cpu-qom.h"
=20
+#define GET_CSR_IF(guest_mode, csr_name) \
+    ((guest_mode) ? (env->GCSR_##csr_name) : (env->CSR_##csr_name))
+
+#define SET_CSR_IF(guest_mode, csr_name, value) \
+    do {                                        \
+        if (guest_mode) {                       \
+            env->GCSR_##csr_name =3D (value);     \
+        } else {                                \
+            env->CSR_##csr_name =3D (value);      \
+        }                                       \
+    } while (0)
+
+#define CPU_INTERRUPT_GUEST CPU_INTERRUPT_TGT_EXT_0
+
 #define FCSR0_M1    0x1f         /* FCSR1 mask, Enables */
 #define FCSR0_M2    0x1f1f0000   /* FCSR2 mask, Cause and Flags */
 #define FCSR0_M3    0x300        /* FCSR3 mask, Round Mode */
@@ -93,6 +107,10 @@ FIELD(FCSR0, CAUSE, 24, 5)
 #define  EXCCODE_WPEM                EXCODE(19, 1)
 #define  EXCCODE_BTD                 EXCODE(20, 0)
 #define  EXCCODE_BTE                 EXCODE(21, 0)
+#define  EXCCODE_GSPR                EXCODE(22, 0)
+#define  EXCCODE_HVC                 EXCODE(23, 0)
+#define  EXCCODE_GCSC                EXCODE(24, 0)
+#define  EXCCODE_GCHC                EXCODE(25, 0)
 #define  EXCCODE_DBP                 EXCODE(26, 0) /* Reserved subcode use=
d for debug */
=20
 /* cpucfg[0] bits */
@@ -255,6 +273,7 @@ FIELD(TLB_MISC, E, 0, 1)
 FIELD(TLB_MISC, ASID, 1, 10)
 FIELD(TLB_MISC, VPPN, 13, 35)
 FIELD(TLB_MISC, PS, 48, 6)
+FIELD(TLB_MISC, GID, 54, 8)
=20
 /*Msg interrupt registers */
 #define N_MSGIS                4
@@ -389,6 +408,79 @@ typedef struct CPUArchState {
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
+
+    /* LVZ (LoongArch Virtualization) CSRs */
+    uint64_t CSR_GSTAT;
+    uint64_t CSR_GCFG;
+    uint64_t CSR_GINTC;
+    uint64_t CSR_GCNTC;
+    uint64_t CSR_GTLBC;
+    uint64_t CSR_TRGP;
+
+    /* Guest CSR registers (GCSR) */
+    uint64_t GCSR_CRMD;
+    uint64_t GCSR_PRMD;
+    uint64_t GCSR_EUEN;
+    uint64_t GCSR_MISC;
+    uint64_t GCSR_ECFG;
+    uint64_t GCSR_ESTAT;
+    uint64_t GCSR_ERA;
+    uint64_t GCSR_BADV;
+    uint64_t GCSR_BADI;
+    uint64_t GCSR_EENTRY;
+    uint64_t GCSR_TLBIDX;
+    uint64_t GCSR_TLBEHI;
+    uint64_t GCSR_TLBELO0;
+    uint64_t GCSR_TLBELO1;
+    uint64_t GCSR_ASID;
+    uint64_t GCSR_PGDL;
+    uint64_t GCSR_PGDH;
+    uint64_t GCSR_PGD;
+    uint64_t GCSR_PWCL;
+    uint64_t GCSR_PWCH;
+    uint64_t GCSR_STLBPS;
+    uint64_t GCSR_RVACFG;
+    uint64_t GCSR_CPUID;
+    uint64_t GCSR_PRCFG1;
+    uint64_t GCSR_PRCFG2;
+    uint64_t GCSR_PRCFG3;
+    uint64_t GCSR_SAVE[16];
+    uint64_t GCSR_TID;
+    uint64_t GCSR_TCFG;
+    uint64_t GCSR_TVAL;
+    uint64_t GCSR_CNTC;
+    uint64_t GCSR_TICLR;
+    uint64_t GCSR_LLBCTL;
+    uint64_t GCSR_IMPCTL1;
+    uint64_t GCSR_IMPCTL2;
+    uint64_t GCSR_TLBRENTRY;
+    uint64_t GCSR_TLBRBADV;
+    uint64_t GCSR_TLBRERA;
+    uint64_t GCSR_TLBRSAVE;
+    uint64_t GCSR_TLBRELO0;
+    uint64_t GCSR_TLBRELO1;
+    uint64_t GCSR_TLBREHI;
+    uint64_t GCSR_TLBRPRMD;
+    uint64_t GCSR_MERRCTL;
+    uint64_t GCSR_MERRINFO1;
+    uint64_t GCSR_MERRINFO2;
+    uint64_t GCSR_MERRENTRY;
+    uint64_t GCSR_MERRERA;
+    uint64_t GCSR_MERRSAVE;
+    uint64_t GCSR_CTAG;
+    uint64_t GCSR_DMW[4];
+    uint64_t GCSR_DBG;
+    uint64_t GCSR_DERA;
+    uint64_t GCSR_DSAVE;
+    uint64_t GCSR_GSTAT;
+    uint64_t GCSR_GCFG;
+    uint64_t GCSR_GINTC;
+    uint64_t GCSR_GCNTC;
+    uint64_t GCSR_GTLBC;
+    uint64_t GCSR_TRGP;
+
+    bool guest;
+    bool vm_exit;
     /* Msg interrupt registers */
     uint64_t CSR_MSGIS[N_MSGIS];
     uint64_t CSR_MSGIR;
@@ -410,6 +502,7 @@ typedef struct CPUArchState {
 #ifndef CONFIG_USER_ONLY
 #ifdef CONFIG_TCG
     LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
+    LoongArchTLB gtlb[LOONGARCH_TLB_MAX];
 #endif
=20
     AddressSpace *address_space_iocsr;
@@ -434,9 +527,11 @@ struct ArchCPU {
=20
     CPULoongArchState env;
     QEMUTimer timer;
+    QEMUTimer guest_timer;
     uint32_t  phy_id;
     OnOffAuto lbt;
     OnOffAuto pmu;
+    OnOffAuto lvz;
     OnOffAuto ptw;
     OnOffAuto lsx;
     OnOffAuto lasx;
@@ -480,6 +575,24 @@ struct LoongArchCPUClass {
 #define MMU_KERNEL_IDX   MMU_PLV_KERNEL
 #define MMU_USER_IDX     MMU_PLV_USER
 #define MMU_DA_IDX       4
+#define MMU_GUEST_IDX    5
+#define MMU_GUEST_DA_IDX 9
+
+static inline bool is_guest_mmu_idx(int mmu_idx)
+{
+    return mmu_idx >=3D MMU_GUEST_IDX;
+}
+
+static inline int mmu_idx_to_plv(int mmu_idx)
+{
+    if (mmu_idx =3D=3D MMU_DA_IDX || mmu_idx =3D=3D MMU_GUEST_DA_IDX) {
+        return 0;
+    }
+    if (is_guest_mmu_idx(mmu_idx)) {
+        return mmu_idx - MMU_GUEST_IDX;
+    }
+    return mmu_idx;
+}
=20
 static inline bool is_la64(CPULoongArchState *env)
 {
@@ -490,8 +603,9 @@ static inline bool is_va32(CPULoongArchState *env)
 {
     /* VA32 if !LA64 or VA32L[1-3] */
     bool va32 =3D !is_la64(env);
-    uint64_t plv =3D FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
-    if (plv >=3D 1 && (FIELD_EX64(env->CSR_MISC, CSR_MISC, VA32) & (1 << p=
lv))) {
+    uint64_t plv =3D FIELD_EX64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, PL=
V);
+    if (plv >=3D 1 &&
+        (FIELD_EX64(GET_CSR_IF(env->guest, MISC), CSR_MISC, VA32) & BIT(pl=
v))) {
         va32 =3D true;
     }
     return va32;
@@ -515,6 +629,13 @@ static inline void set_pc(CPULoongArchState *env, uint=
64_t value)
 #define HW_FLAGS_CRMD_PG    R_CSR_CRMD_PG_MASK   /* 0x10 */
 #define HW_FLAGS_VA32       0x20
 #define HW_FLAGS_EUEN_ASXE  0x40
+#define HW_FLAGS_GUEST_MODE 0x80
+
+bool has_lvz_capability(CPULoongArchState *env);
+bool will_return_to_guest(CPULoongArchState *env);
+uint8_t get_gid(CPULoongArchState *env);
+uint8_t get_tgid(CPULoongArchState *env);
+void trigger_vm_exit(CPULoongArchState *env);
=20
 #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
=20
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index eb9684a4a1..bad6062ac9 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -17,46 +17,56 @@
 #include "cpu-mmu.h"
 #include "tcg/tcg_loongarch.h"
=20
-void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
-                        uint64_t *dir_width, unsigned int level)
+static void get_dir_base_width_csr(CPULoongArchState *env, uint64_t *dir_b=
ase,
+                                   uint64_t *dir_width, unsigned int level=
,
+                                   bool guest)
 {
+    uint64_t pwcl =3D GET_CSR_IF(guest, PWCL);
+    uint64_t pwch =3D GET_CSR_IF(guest, PWCH);
+
     switch (level) {
     case 1:
-        *dir_base =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_BASE);
-        *dir_width =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_WIDTH);
+        *dir_base =3D FIELD_EX64(pwcl, CSR_PWCL, DIR1_BASE);
+        *dir_width =3D FIELD_EX64(pwcl, CSR_PWCL, DIR1_WIDTH);
         break;
     case 2:
-        *dir_base =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_BASE);
-        *dir_width =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_WIDTH);
+        *dir_base =3D FIELD_EX64(pwcl, CSR_PWCL, DIR2_BASE);
+        *dir_width =3D FIELD_EX64(pwcl, CSR_PWCL, DIR2_WIDTH);
         break;
     case 3:
-        *dir_base =3D FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_BASE);
-        *dir_width =3D FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_WIDTH);
+        *dir_base =3D FIELD_EX64(pwch, CSR_PWCH, DIR3_BASE);
+        *dir_width =3D FIELD_EX64(pwch, CSR_PWCH, DIR3_WIDTH);
         break;
     case 4:
-        *dir_base =3D FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_BASE);
-        *dir_width =3D FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_WIDTH);
+        *dir_base =3D FIELD_EX64(pwch, CSR_PWCH, DIR4_BASE);
+        *dir_width =3D FIELD_EX64(pwch, CSR_PWCH, DIR4_WIDTH);
         break;
     default:
         /* level may be zero for ldpte */
-        *dir_base =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
-        *dir_width =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
+        *dir_base =3D FIELD_EX64(pwcl, CSR_PWCL, PTBASE);
+        *dir_width =3D FIELD_EX64(pwcl, CSR_PWCL, PTWIDTH);
         break;
     }
 }
=20
+void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
+                        uint64_t *dir_width, unsigned int level, bool gues=
t)
+{
+    get_dir_base_width_csr(env, dir_base, dir_width, level, guest);
+}
+
 TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
-                           MMUAccessType access_type, int mmu_idx)
+                           MMUAccessType access_type, int mmu_idx, bool gu=
est)
 {
-    uint64_t plv =3D mmu_idx;
+    uint64_t plv =3D mmu_idx_to_plv(mmu_idx);
     uint64_t tlb_entry, tlb_ppn;
     uint8_t tlb_ps, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
     bool tlb_v, tlb_d;
=20
     tlb_entry =3D context->pte;
     tlb_ps =3D context->ps;
-    tlb_v =3D pte_present(env, tlb_entry);
-    tlb_d =3D pte_write(env, tlb_entry);
+    tlb_v =3D pte_present(env, tlb_entry, guest);
+    tlb_d =3D pte_write(env, tlb_entry, guest);
     tlb_plv =3D FIELD_EX64(tlb_entry, TLBENTRY, PLV);
     if (is_la64(env)) {
         tlb_ppn =3D FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
@@ -98,7 +108,7 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUCo=
ntext *context,
     context->physical =3D (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
                         (context->addr & MAKE_64BIT_MASK(0, tlb_ps));
     context->prot =3D PAGE_READ;
-    context->mmu_index =3D tlb_plv;
+    context->mmu_index =3D mmu_idx;
     if (tlb_d) {
         context->prot |=3D PAGE_WRITE;
     }
@@ -144,7 +154,8 @@ static MemTxResult loongarch_cmpxchg_phys(CPUState *cs,=
 hwaddr phys,
 }
=20
 TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
-                     int access_type, int mmu_idx, int debug)
+                     int access_type, int mmu_idx, int debug, bool guest,
+                     uintptr_t retaddr)
 {
     const MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
     CPUState *cs =3D env_cpu(env);
@@ -160,14 +171,14 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUConte=
xt *context,
=20
     address =3D context->addr;
     if ((address >> 63) & 0x1) {
-        base =3D env->CSR_PGDH;
+        base =3D GET_CSR_IF(guest, PGDH);
     } else {
-        base =3D env->CSR_PGDL;
+        base =3D GET_CSR_IF(guest, PGDL);
     }
     base &=3D palen_mask;
=20
     for (level =3D 4; level >=3D 0; level--) {
-        get_dir_base_width(env, &dir_base, &dir_width, level);
+        get_dir_base_width(env, &dir_base, &dir_width, level, guest);
=20
         if (dir_width =3D=3D 0) {
             continue;
@@ -176,7 +187,10 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContex=
t *context,
         /* get next level page directory */
         index =3D (address >> dir_base) & ((1 << dir_width) - 1);
         phys =3D base | index << 3;
-        base =3D address_space_ldq_le(cs->as, phys, attrs, NULL);
+        base =3D address_space_ldq_le(
+            cs->as,
+            (guest ? loongarch_get_host_address(env, phys, retaddr) : phys=
),
+            attrs, NULL);
         if (level) {
             if (FIELD_EX64(base, TLBENTRY, HUGE)) {
                 /* base is a huge pte */
@@ -205,19 +219,22 @@ restart:
         context->pte_buddy[index] =3D base;
         context->pte_buddy[1 - index] =3D base + BIT_ULL(dir_base);
         base +=3D (BIT_ULL(dir_base) & address);
-    } else if (cpu_has_ptw(env)) {
+    } else if (cpu_has_ptw(env, guest)) {
         uint64_t val;
=20
         index &=3D 1;
         context->pte_buddy[index] =3D base;
-        val =3D address_space_ldq_le(cs->as, phys + 8 * (1 - 2 * index),
-                                   attrs, NULL);
+        val =3D address_space_ldq_le(
+            cs->as,
+            (guest ? loongarch_get_host_address(env, phys, retaddr) : phys=
) +
+                8 * (1 - 2 * index),
+            attrs, NULL);
         context->pte_buddy[1 - index] =3D val;
     }
=20
     context->ps =3D dir_base;
     context->pte =3D base;
-    ret =3D loongarch_check_pte(env, context, access_type, mmu_idx);
+    ret =3D loongarch_check_pte(env, context, access_type, mmu_idx, guest)=
;
     if (debug) {
         return ret;
     }
@@ -228,7 +245,7 @@ restart:
      * Need atomic compchxg operation with pte update, other vCPUs may
      * update pte at the same time.
      */
-    if (ret =3D=3D TLBRET_MATCH && cpu_has_ptw(env)) {
+    if (ret =3D=3D TLBRET_MATCH && cpu_has_ptw(env, guest)) {
         if (access_type =3D=3D MMU_DATA_STORE && pte_dirty(base)) {
             return ret;
         }
@@ -241,10 +258,15 @@ restart:
         if (access_type =3D=3D MMU_DATA_STORE) {
             base =3D pte_mkdirty(base);
         }
-        ret1 =3D loongarch_cmpxchg_phys(cs, phys, pte, base);
+        ret1 =3D loongarch_cmpxchg_phys(
+            cs, (guest ? loongarch_get_host_address(env, phys, retaddr) : =
phys),
+            pte, base);
         /* PTE updated by other CPU, reload PTE entry */
         if (ret1 =3D=3D MEMTX_DECODE_ERROR) {
-            base =3D address_space_ldq_le(cs->as, phys, attrs, NULL);
+            base =3D address_space_ldq_le(
+                cs->as,
+                (guest ? loongarch_get_host_address(env, phys, retaddr) : =
phys),
+                attrs, NULL);
             goto restart;
         }
=20
@@ -270,15 +292,15 @@ restart:
     return ret;
 }
=20
-static TLBRet loongarch_map_address(CPULoongArchState *env,
-                                    MMUContext *context,
-                                    MMUAccessType access_type, int mmu_idx=
,
-                                    int is_debug)
+TLBRet loongarch_map_address(CPULoongArchState *env, MMUContext *context,
+                             MMUAccessType access_type, int mmu_idx,
+                             int is_debug, bool guest, uintptr_t retaddr)
 {
     TLBRet ret;
=20
     if (tcg_enabled()) {
-        ret =3D loongarch_get_addr_from_tlb(env, context, access_type, mmu=
_idx);
+        ret =3D loongarch_get_addr_from_tlb(env, context, access_type, mmu=
_idx,
+                                          guest);
         if (ret !=3D TLBRET_NOMATCH) {
             return ret;
         }
@@ -290,7 +312,8 @@ static TLBRet loongarch_map_address(CPULoongArchState *=
env,
          * legal mapping, even if the mapping is not yet in TLB. return 0 =
if
          * there is a valid map, else none zero.
          */
-        return loongarch_ptw(env, context, access_type, mmu_idx, is_debug)=
;
+        return loongarch_ptw(env, context, access_type, mmu_idx, is_debug,
+                             guest, retaddr);
     }
=20
     return TLBRET_NOMATCH;
@@ -309,14 +332,14 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr=
 va, uint64_t dmw)
=20
 TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
-                            int is_debug)
+                            int is_debug, uintptr_t retaddr)
 {
-    int user_mode =3D mmu_idx =3D=3D MMU_USER_IDX;
-    int kernel_mode =3D mmu_idx =3D=3D MMU_KERNEL_IDX;
+    int user_mode =3D mmu_idx_to_plv(mmu_idx) =3D=3D MMU_USER_IDX;
+    int kernel_mode =3D mmu_idx_to_plv(mmu_idx) =3D=3D MMU_KERNEL_IDX;
     uint32_t plv, base_c, base_v;
     int64_t addr_high;
-    uint8_t da =3D FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
-    uint8_t pg =3D FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
+    uint8_t da =3D FIELD_EX64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, DA);
+    uint8_t pg =3D FIELD_EX64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, PG);
     vaddr address;
=20
     /* Check PG and DA */
@@ -337,12 +360,15 @@ TLBRet get_physical_address(CPULoongArchState *env, M=
MUContext *context,
     /* Check direct map window */
     for (int i =3D 0; i < 4; i++) {
         if (is_la64(env)) {
-            base_c =3D FIELD_EX64(env->CSR_DMW[i], CSR_DMW_64, VSEG);
+            base_c =3D
+                FIELD_EX64(GET_CSR_IF(env->guest, DMW[i]), CSR_DMW_64, VSE=
G);
         } else {
-            base_c =3D FIELD_EX64(env->CSR_DMW[i], CSR_DMW_32, VSEG);
+            base_c =3D
+                FIELD_EX64(GET_CSR_IF(env->guest, DMW[i]), CSR_DMW_32, VSE=
G);
         }
-        if ((plv & env->CSR_DMW[i]) && (base_c =3D=3D base_v)) {
-            context->physical =3D dmw_va2pa(env, address, env->CSR_DMW[i])=
;
+        if ((plv & GET_CSR_IF(env->guest, DMW[i])) && (base_c =3D=3D base_=
v)) {
+            context->physical =3D
+                dmw_va2pa(env, address, GET_CSR_IF(env->guest, DMW[i]));
             context->prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
             context->mmu_index =3D MMU_DA_IDX;
             return TLBRET_MATCH;
@@ -356,7 +382,8 @@ TLBRet get_physical_address(CPULoongArchState *env, MMU=
Context *context,
     }
=20
     /* Mapped address */
-    return loongarch_map_address(env, context, access_type, mmu_idx, is_de=
bug);
+    return loongarch_map_address(env, context, access_type, mmu_idx, is_de=
bug,
+                                 env->guest, retaddr);
 }
=20
 hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
@@ -366,7 +393,7 @@ hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, =
vaddr addr)
=20
     context.addr =3D addr;
     if (get_physical_address(env, &context, MMU_DATA_LOAD,
-                             cpu_mmu_index(cs, false), 1) !=3D TLBRET_MATC=
H) {
+                             cpu_mmu_index(cs, false), 1, 0) !=3D TLBRET_M=
ATCH) {
         return -1;
     }
     return context.physical;
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index fff2312f87..1c4505536d 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -20,8 +20,27 @@
         .flags =3D 0, .readfn =3D NULL, .writefn =3D NULL           \
     }
=20
+#define GCSR_OFF_FUNCS(NAME, FL, RD, WR)                              \
+    [LOONGARCH_CSR_##                                                 \
+        NAME] =3D { .name =3D (stringify(GCSR_##NAME)),                   =
\
+                  .offset =3D offsetof(CPULoongArchState, GCSR_##NAME), \
+                  .flags =3D FL,                                        \
+                  .readfn =3D RD,                                       \
+                  .writefn =3D WR }
+
+#define GCSR_OFF_ARRAY(NAME, N)                                         \
+    [LOONGARCH_CSR_##NAME(N)] =3D { .name =3D (stringify(GCSR_##NAME##N)),=
  \
+                                  .offset =3D offsetof(CPULoongArchState, =
\
+                                                     GCSR_##NAME[N]),   \
+                                  .flags =3D 0,                           =
\
+                                  .readfn =3D NULL,                       =
\
+                                  .writefn =3D NULL }
+
 #define CSR_OFF_FLAGS(NAME, FL)   CSR_OFF_FUNCS(NAME, FL, NULL, NULL)
 #define CSR_OFF(NAME)             CSR_OFF_FLAGS(NAME, 0)
+#define GCSR_OFF_FLAGS(NAME, FL) GCSR_OFF_FUNCS(NAME, FL, NULL, NULL)
+#define GCSR_OFF(NAME) GCSR_OFF_FLAGS(NAME, 0)
+#define GCSR_GSPR(NAME) GCSR_OFF_FUNCS(NAME, CSRFL_GSPR, NULL, NULL)
=20
 static CSRInfo csr_info[] =3D {
     CSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
@@ -35,6 +54,8 @@ static CSRInfo csr_info[] =3D {
     CSR_OFF_FLAGS(BADI, CSRFL_READONLY),
     CSR_OFF(EENTRY),
     CSR_OFF(TLBIDX),
+    CSR_OFF(GTLBC),
+    CSR_OFF(TRGP),
     CSR_OFF(TLBEHI),
     CSR_OFF(TLBELO0),
     CSR_OFF(TLBELO1),
@@ -71,6 +92,10 @@ static CSRInfo csr_info[] =3D {
     CSR_OFF_FLAGS(TVAL, CSRFL_READONLY | CSRFL_IO),
     CSR_OFF(CNTC),
     CSR_OFF_FLAGS(TICLR, CSRFL_IO),
+    CSR_OFF(GSTAT),
+    CSR_OFF(GCFG),
+    CSR_OFF_FLAGS(GINTC, CSRFL_IO),
+    CSR_OFF(GCNTC),
     CSR_OFF(LLBCTL),
     CSR_OFF(IMPCTL1),
     CSR_OFF(IMPCTL2),
@@ -135,6 +160,87 @@ static CSRInfo csr_info[] =3D {
     CSR_OFF(MSGIR),
 };
=20
+static CSRInfo gcsr_info[] =3D {
+    GCSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
+    GCSR_OFF(PRMD),
+    GCSR_OFF_FLAGS(EUEN, CSRFL_EXITTB),
+    GCSR_OFF_FLAGS(MISC, CSRFL_GUEST_READONLY),
+    GCSR_OFF(ECFG),
+    GCSR_OFF_FLAGS(ESTAT, CSRFL_EXITTB),
+    GCSR_OFF(ERA),
+    GCSR_OFF(BADV),
+    GCSR_OFF_FLAGS(BADI, CSRFL_GUEST_READONLY),
+    GCSR_OFF(EENTRY),
+    GCSR_OFF(TLBIDX),
+    GCSR_GSPR(GTLBC),
+    GCSR_GSPR(TRGP),
+    GCSR_OFF(TLBEHI),
+    GCSR_OFF(TLBELO0),
+    GCSR_OFF(TLBELO1),
+    GCSR_OFF_FLAGS(ASID, CSRFL_EXITTB),
+    GCSR_OFF(PGDL),
+    GCSR_OFF(PGDH),
+    GCSR_OFF_FLAGS(PGD, CSRFL_GUEST_READONLY),
+    GCSR_OFF(PWCL),
+    GCSR_OFF(PWCH),
+    GCSR_OFF(STLBPS),
+    GCSR_OFF(RVACFG),
+    GCSR_OFF_FLAGS(CPUID, CSRFL_GUEST_READONLY),
+    GCSR_OFF_FLAGS(PRCFG1, CSRFL_GUEST_READONLY),
+    GCSR_OFF_FLAGS(PRCFG2, CSRFL_GUEST_READONLY),
+    GCSR_OFF_FLAGS(PRCFG3, CSRFL_GUEST_READONLY),
+    GCSR_OFF_ARRAY(SAVE, 0),
+    GCSR_OFF_ARRAY(SAVE, 1),
+    GCSR_OFF_ARRAY(SAVE, 2),
+    GCSR_OFF_ARRAY(SAVE, 3),
+    GCSR_OFF_ARRAY(SAVE, 4),
+    GCSR_OFF_ARRAY(SAVE, 5),
+    GCSR_OFF_ARRAY(SAVE, 6),
+    GCSR_OFF_ARRAY(SAVE, 7),
+    GCSR_OFF_ARRAY(SAVE, 8),
+    GCSR_OFF_ARRAY(SAVE, 9),
+    GCSR_OFF_ARRAY(SAVE, 10),
+    GCSR_OFF_ARRAY(SAVE, 11),
+    GCSR_OFF_ARRAY(SAVE, 12),
+    GCSR_OFF_ARRAY(SAVE, 13),
+    GCSR_OFF_ARRAY(SAVE, 14),
+    GCSR_OFF_ARRAY(SAVE, 15),
+    GCSR_OFF(TID),
+    GCSR_OFF_FLAGS(TCFG, CSRFL_IO),
+    GCSR_OFF_FLAGS(TVAL, CSRFL_GUEST_READONLY | CSRFL_IO),
+    GCSR_OFF(CNTC),
+    GCSR_OFF_FLAGS(TICLR, CSRFL_IO),
+    GCSR_GSPR(GSTAT),
+    GCSR_GSPR(GCFG),
+    GCSR_GSPR(GINTC),
+    GCSR_GSPR(GCNTC),
+    GCSR_OFF(LLBCTL),
+    GCSR_GSPR(IMPCTL1),
+    GCSR_GSPR(IMPCTL2),
+    GCSR_OFF(TLBRENTRY),
+    GCSR_OFF(TLBRBADV),
+    GCSR_OFF(TLBRERA),
+    GCSR_OFF(TLBRSAVE),
+    GCSR_OFF(TLBRELO0),
+    GCSR_OFF(TLBRELO1),
+    GCSR_OFF(TLBREHI),
+    GCSR_OFF(TLBRPRMD),
+    GCSR_GSPR(MERRCTL),
+    GCSR_GSPR(MERRINFO1),
+    GCSR_GSPR(MERRINFO2),
+    GCSR_GSPR(MERRENTRY),
+    GCSR_GSPR(MERRERA),
+    GCSR_GSPR(MERRSAVE),
+    GCSR_GSPR(CTAG),
+    GCSR_OFF_ARRAY(DMW, 0),
+    GCSR_OFF_ARRAY(DMW, 1),
+    GCSR_OFF_ARRAY(DMW, 2),
+    GCSR_OFF_ARRAY(DMW, 3),
+    GCSR_GSPR(DBG),
+    GCSR_GSPR(DERA),
+    GCSR_GSPR(DSAVE),
+};
+
 CSRInfo *get_csr(unsigned int csr_num)
 {
     CSRInfo *csr;
@@ -151,6 +257,22 @@ CSRInfo *get_csr(unsigned int csr_num)
     return csr;
 }
=20
+CSRInfo *get_gcsr(unsigned int csr_num)
+{
+    CSRInfo *csr;
+
+    if (csr_num >=3D ARRAY_SIZE(gcsr_info)) {
+        return NULL;
+    }
+
+    csr =3D &gcsr_info[csr_num];
+    if (csr->offset =3D=3D 0) {
+        return NULL;
+    }
+
+    return csr;
+}
+
 bool set_csr_flag(unsigned int csr_num, int flag)
 {
     CSRInfo *csr;
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index 81a656baae..a0846353de 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -14,6 +14,8 @@ enum {
     CSRFL_EXITTB   =3D (1 << 1),
     CSRFL_IO       =3D (1 << 2),
     CSRFL_UNUSED   =3D (1 << 3),
+    CSRFL_GUEST_READONLY =3D (1 << 4),
+    CSRFL_GSPR     =3D (1 << 5),
 };
=20
 typedef struct {
@@ -25,5 +27,6 @@ typedef struct {
 } CSRInfo;
=20
 CSRInfo *get_csr(unsigned int csr_num);
+CSRInfo *get_gcsr(unsigned int csr_num);
 bool set_csr_flag(unsigned int csr_num, int flag);
 #endif /* TARGET_LOONGARCH_CSR_H */
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 3249ab7ac6..b282da6ea6 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -698,6 +698,16 @@ INSN(tlbfill,      empty)
 INSN(tlbclr,       empty)
 INSN(tlbflush,     empty)
 INSN(invtlb,       i_rr)
+INSN(gcsrrd,       r_csr)
+INSN(gcsrwr,       r_csr)
+INSN(gcsrxchg,     rr_csr)
+INSN(gtlbclr,      empty)
+INSN(gtlbflush,    empty)
+INSN(gtlbsrch,     empty)
+INSN(gtlbrd,       empty)
+INSN(gtlbwr,       empty)
+INSN(gtlbfill,     empty)
+INSN(hvcl,         i)
 INSN(cacop,        cop_r_i)
 INSN(lddir,        rr_i)
 INSN(ldpte,        j_i)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 3089d42044..b19c40b423 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -493,6 +493,23 @@ bgeu            0110 11 ................ ..... .....  =
   @rr_offs16
   csrxchg           0000 0100 .............. ..... .....     @rr_csr
 }
=20
+#
+# LVZ (LoongArch Virtualization) instructions
+#
+{
+  gcsrrd            0000 0101 .............. 00000 .....     @r_csr
+  gcsrwr            0000 0101 .............. 00001 .....     @r_csr
+  gcsrxchg          0000 0101 .............. ..... .....     @rr_csr
+}
+
+gtlbclr          0000 01100100 10000 01000 00000 00001    @empty
+gtlbflush        0000 01100100 10000 01001 00000 00001    @empty
+gtlbsrch         0000 01100100 10000 01010 00000 00001    @empty
+gtlbrd           0000 01100100 10000 01011 00000 00001    @empty
+gtlbwr           0000 01100100 10000 01100 00000 00001    @empty
+gtlbfill         0000 01100100 10000 01101 00000 00001    @empty
+hvcl             0000 0000 0010 1011 1 ...............    @i15
+
 iocsrrd_b        0000 01100100 10000 00000 ..... .....    @rr
 iocsrrd_h        0000 01100100 10000 00001 ..... .....    @rr
 iocsrrd_w        0000 01100100 10000 00010 ..... .....    @rr
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
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 4db53fec26..df7a7c9075 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -197,11 +197,101 @@ static const VMStateDescription vmstate_tlb =3D {
     .version_id =3D 0,
     .minimum_version_id =3D 0,
     .needed =3D tlb_needed,
-    .fields =3D (const VMStateField[]) {
-        VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
-                             0, vmstate_tlb_entry, LoongArchTLB),
-        VMSTATE_END_OF_LIST()
-    }
+    .fields =3D
+        (const VMStateField[]){
+            VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,=
 0,
+                                 vmstate_tlb_entry, LoongArchTLB),
+            VMSTATE_END_OF_LIST() }
+};
+
+static bool lvz_needed(void *opaque)
+{
+    LoongArchCPU *cpu =3D opaque;
+
+    return FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LVZ);
+}
+
+static const VMStateDescription vmstate_lvz =3D {
+    .name =3D "cpu/lvz",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D lvz_needed,
+    .fields =3D
+        (const VMStateField[]){
+            VMSTATE_UINT64(env.CSR_GSTAT, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_GCFG, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_GINTC, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_GCNTC, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_GTLBC, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TRGP, LoongArchCPU),
+
+            VMSTATE_UINT64(env.GCSR_CRMD, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PRMD, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_EUEN, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_MISC, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_ECFG, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_ESTAT, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_ERA, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_BADV, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_BADI, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_EENTRY, LoongArchCPU),
+
+            VMSTATE_UINT64(env.GCSR_TLBIDX, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBEHI, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBELO0, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBELO1, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_ASID, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PGDL, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PGDH, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PGD, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PWCL, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PWCH, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_STLBPS, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_RVACFG, LoongArchCPU),
+
+            VMSTATE_UINT64(env.GCSR_CPUID, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PRCFG1, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PRCFG2, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PRCFG3, LoongArchCPU),
+            VMSTATE_UINT64_ARRAY(env.GCSR_SAVE, LoongArchCPU, 16),
+
+            VMSTATE_UINT64(env.GCSR_TID, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TCFG, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TVAL, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_CNTC, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TICLR, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_LLBCTL, LoongArchCPU),
+
+            VMSTATE_UINT64(env.GCSR_IMPCTL1, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_IMPCTL2, LoongArchCPU),
+
+            VMSTATE_UINT64(env.GCSR_TLBRENTRY, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBRBADV, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBRERA, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBRSAVE, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBRELO0, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBRELO1, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBREHI, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBRPRMD, LoongArchCPU),
+
+            VMSTATE_UINT64(env.GCSR_MERRCTL, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_MERRINFO1, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_MERRINFO2, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_MERRENTRY, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_MERRERA, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_MERRSAVE, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_CTAG, LoongArchCPU),
+
+            VMSTATE_UINT64_ARRAY(env.GCSR_DMW, LoongArchCPU, 4),
+
+            VMSTATE_UINT64(env.GCSR_DBG, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_DERA, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_DSAVE, LoongArchCPU),
+
+            VMSTATE_BOOL(env.guest, LoongArchCPU),
+            VMSTATE_STRUCT_ARRAY(env.gtlb, LoongArchCPU, LOONGARCH_TLB_MAX=
, 0,
+                                 vmstate_tlb_entry, LoongArchTLB),
+            VMSTATE_END_OF_LIST() },
 };
 #endif
=20
@@ -210,83 +300,78 @@ const VMStateDescription vmstate_loongarch_cpu =3D {
     .name =3D "cpu",
     .version_id =3D 4,
     .minimum_version_id =3D 4,
-    .fields =3D (const VMStateField[]) {
-        VMSTATE_UINT64_ARRAY(env.gpr, LoongArchCPU, 32),
-        VMSTATE_UINT64(env.pc, LoongArchCPU),
-
-        /* Remaining CSRs */
-        VMSTATE_UINT64(env.CSR_CRMD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRMD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_EUEN, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MISC, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ECFG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ESTAT, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_BADV, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_BADI, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_EENTRY, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBIDX, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBEHI, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBELO0, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBELO1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ASID, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PGDL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PGDH, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PGD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PWCL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PWCH, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_STLBPS, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_RVACFG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRCFG1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRCFG2, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRCFG3, LoongArchCPU),
-        VMSTATE_UINT64_ARRAY(env.CSR_SAVE, LoongArchCPU, 16),
-        VMSTATE_UINT64(env.CSR_TID, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TCFG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TVAL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_CNTC, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TICLR, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_LLBCTL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_IMPCTL1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_IMPCTL2, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRENTRY, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRBADV, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRSAVE, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRELO0, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRELO1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBREHI, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRPRMD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRCTL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRINFO1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRINFO2, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRENTRY, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRSAVE, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_CTAG, LoongArchCPU),
-        VMSTATE_UINT64_ARRAY(env.CSR_DMW, LoongArchCPU, 4),
-
-        /* Debug CSRs */
-        VMSTATE_UINT64(env.CSR_DBG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_DERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
-
-        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
-        /* PV steal time */
-        VMSTATE_UINT64(env.stealtime.guest_addr, LoongArchCPU),
-
-        VMSTATE_END_OF_LIST()
-    },
-    .subsections =3D (const VMStateDescription * const []) {
-        &vmstate_fpu,
-        &vmstate_lsx,
-        &vmstate_lasx,
+    .fields =3D
+        (const VMStateField[]){
+            VMSTATE_UINT64_ARRAY(env.gpr, LoongArchCPU, 32),
+            VMSTATE_UINT64(env.pc, LoongArchCPU),
+
+            /* Remaining CSRs */
+            VMSTATE_UINT64(env.CSR_CRMD, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PRMD, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_EUEN, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_MISC, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_ECFG, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_ESTAT, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_ERA, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_BADV, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_BADI, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_EENTRY, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBIDX, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBEHI, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBELO0, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBELO1, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_ASID, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PGDL, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PGDH, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PGD, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PWCL, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PWCH, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_STLBPS, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_RVACFG, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PRCFG1, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PRCFG2, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PRCFG3, LoongArchCPU),
+            VMSTATE_UINT64_ARRAY(env.CSR_SAVE, LoongArchCPU, 16),
+            VMSTATE_UINT64(env.CSR_TID, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TCFG, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TVAL, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_CNTC, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TICLR, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_LLBCTL, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_IMPCTL1, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_IMPCTL2, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBRENTRY, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBRBADV, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBRERA, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBRSAVE, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBRELO0, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBRELO1, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBREHI, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBRPRMD, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_MERRCTL, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_MERRINFO1, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_MERRINFO2, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_MERRENTRY, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_MERRERA, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_MERRSAVE, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_CTAG, LoongArchCPU),
+            VMSTATE_UINT64_ARRAY(env.CSR_DMW, LoongArchCPU, 4),
+
+            /* Debug CSRs */
+            VMSTATE_UINT64(env.CSR_DBG, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_DERA, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
+
+            VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
+            /* PV steal time */
+            VMSTATE_UINT64(env.stealtime.guest_addr, LoongArchCPU),
+
+            VMSTATE_END_OF_LIST() },
+    .subsections =3D
+        (const VMStateDescription *const[]) {
+            &vmstate_fpu, &vmstate_lsx, &vmstate_lasx,
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-        &vmstate_tlb,
+            &vmstate_tlb, &vmstate_lvz,
 #endif
-        &vmstate_lbt,
-        &vmstate_msgint,
-        &vmstate_pmu,
-        NULL
-    }
+            &vmstate_lbt, &vmstate_msgint, &vmstate_pmu, NULL }
 };
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
index 8a6c62f116..648328a7ef 100644
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
@@ -124,16 +133,25 @@ DEF_HELPER_1(tlbsrch, void, env)
 DEF_HELPER_1(tlbrd, void, env)
 DEF_HELPER_1(tlbclr, void, env)
 DEF_HELPER_1(tlbflush, void, env)
-DEF_HELPER_1(invtlb_all, void, env)
-DEF_HELPER_2(invtlb_all_g, void, env, i32)
-DEF_HELPER_2(invtlb_all_asid, void, env, tl)
-DEF_HELPER_3(invtlb_page_asid, void, env, tl, tl)
-DEF_HELPER_3(invtlb_page_asid_or_g, void, env, tl, tl)
+DEF_HELPER_4(invtlb_all, void, env, tl, i32, i32)
+DEF_HELPER_4(invtlb_all_g, void, env, tl, i32, i32)
+DEF_HELPER_3(invtlb_all_asid, void, env, tl, i32)
+DEF_HELPER_4(invtlb_page_asid, void, env, tl, tl, i32)
+DEF_HELPER_4(invtlb_page_asid_or_g, void, env, tl, tl, i32)
+
+DEF_HELPER_1(gtlbwr, void, env)
+DEF_HELPER_1(gtlbfill, void, env)
+DEF_HELPER_1(gtlbsrch, void, env)
+DEF_HELPER_1(gtlbrd, void, env)
+DEF_HELPER_1(gtlbclr, void, env)
+DEF_HELPER_1(gtlbflush, void, env)
=20
 DEF_HELPER_4(lddir, tl, env, tl, i32, i32)
 DEF_HELPER_4(ldpte, void, env, tl, tl, i32)
 DEF_HELPER_1(ertn, void, env)
 DEF_HELPER_1(idle, void, env)
+DEF_HELPER_2(hvcl, void, env, i32)
+DEF_HELPER_1(gspr, void, env)
 #endif
=20
 /* LoongArch LSX  */
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/targe=
t/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 2094d182ac..19b02e6a78 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -39,6 +39,16 @@ GEN_FALSE_TRANS(lddir)
 GEN_FALSE_TRANS(ertn)
 GEN_FALSE_TRANS(dbcl)
 GEN_FALSE_TRANS(idle)
+GEN_FALSE_TRANS(gcsrrd)
+GEN_FALSE_TRANS(gcsrwr)
+GEN_FALSE_TRANS(gcsrxchg)
+GEN_FALSE_TRANS(gtlbclr)
+GEN_FALSE_TRANS(gtlbflush)
+GEN_FALSE_TRANS(gtlbsrch)
+GEN_FALSE_TRANS(gtlbrd)
+GEN_FALSE_TRANS(gtlbwr)
+GEN_FALSE_TRANS(gtlbfill)
+GEN_FALSE_TRANS(hvcl)
=20
 #else
=20
@@ -69,8 +79,25 @@ static bool set_csr_trans_func(unsigned int csr_num, Gen=
CSRRead readfn,
     return true;
 }
=20
+static bool set_gcsr_trans_func(unsigned int csr_num, GenCSRRead readfn,
+                                GenCSRWrite writefn)
+{
+    CSRInfo *csr;
+
+    csr =3D get_gcsr(csr_num);
+    if (!csr) {
+        return false;
+    }
+
+    csr->readfn =3D (GenCSRFunc)readfn;
+    csr->writefn =3D (GenCSRFunc)writefn;
+    return true;
+}
+
 #define SET_CSR_FUNC(NAME, read, write)                 \
         set_csr_trans_func(LOONGARCH_CSR_##NAME, read, write)
+#define SET_GCSR_FUNC(NAME, read, write)                \
+        set_gcsr_trans_func(LOONGARCH_CSR_##NAME, read, write)
=20
 void loongarch_csr_translate_init(void)
 {
@@ -85,14 +112,28 @@ void loongarch_csr_translate_init(void)
     SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
     SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr_ticlr);
     SET_CSR_FUNC(MSGIR, gen_helper_csrrd_msgir, NULL);
+    SET_CSR_FUNC(GSTAT, NULL, gen_helper_csrwr_gstat);
+    SET_CSR_FUNC(GTLBC, NULL, gen_helper_csrwr_gtlbc);
+    SET_CSR_FUNC(GINTC, NULL, gen_helper_csrwr_gintc);
+
+    SET_GCSR_FUNC(ESTAT, NULL, gen_helper_gcsrwr_estat);
+    SET_GCSR_FUNC(ASID, NULL, gen_helper_gcsrwr_asid);
+    SET_GCSR_FUNC(PGD, gen_helper_gcsrrd_pgd, NULL);
+    SET_GCSR_FUNC(TCFG, NULL, gen_helper_gcsrwr_tcfg);
+    SET_GCSR_FUNC(TVAL, gen_helper_gcsrrd_tval, NULL);
+    SET_GCSR_FUNC(TICLR, NULL, gen_helper_gcsrwr_ticlr);
 }
 #undef SET_CSR_FUNC
+#undef SET_GCSR_FUNC
=20
 static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr, bool wr=
ite)
 {
     if ((csr->flags & CSRFL_READONLY) && write) {
         return false;
     }
+    if ((csr->flags & CSRFL_GUEST_READONLY) && ctx->guest_mode && write) {
+        return false;
+    }
     if ((csr->flags & CSRFL_IO) && translator_io_start(&ctx->base)) {
         ctx->base.is_jmp =3D DISAS_EXIT_UPDATE;
     } else if ((csr->flags & CSRFL_EXITTB) && write) {
@@ -110,12 +151,17 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd =
*a)
     if (check_plv(ctx)) {
         return false;
     }
-    csr =3D get_csr(a->csr);
+    csr =3D ctx->guest_mode ? get_gcsr(a->csr) : get_csr(a->csr);
     if (csr =3D=3D NULL) {
         /* CSR is undefined: read as 0. */
         dest =3D tcg_constant_tl(0);
     } else {
         check_csr_flags(ctx, csr, false);
+        if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
+            gen_helper_gspr(tcg_env);
+            gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+            return true;
+        }
         dest =3D gpr_dst(ctx, a->rd, EXT_NONE);
         readfn =3D (GenCSRRead)csr->readfn;
         if (readfn) {
@@ -137,12 +183,17 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr =
*a)
     if (check_plv(ctx)) {
         return false;
     }
-    csr =3D get_csr(a->csr);
+    csr =3D ctx->guest_mode ? get_gcsr(a->csr) : get_csr(a->csr);
     if (csr =3D=3D NULL) {
         /* CSR is undefined: write ignored, read old_value as 0. */
         gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
         return true;
     }
+    if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
+        gen_helper_gspr(tcg_env);
+        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
     if (!check_csr_flags(ctx, csr, true)) {
         /* CSR is readonly: trap. */
         return false;
@@ -170,28 +221,35 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrx=
chg *a)
     if (check_plv(ctx)) {
         return false;
     }
-    csr =3D get_csr(a->csr);
+    csr =3D ctx->guest_mode ? get_gcsr(a->csr) : get_csr(a->csr);
     if (csr =3D=3D NULL) {
         /* CSR is undefined: write ignored, read old_value as 0. */
         gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
         return true;
     }
+    if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
+        gen_helper_gspr(tcg_env);
+        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
=20
     if (!check_csr_flags(ctx, csr, true)) {
         /* CSR is readonly: trap. */
         return false;
     }
=20
-    /* So far only readonly csrs have readfn. */
-    assert(csr->readfn =3D=3D NULL);
-
     src1 =3D gpr_src(ctx, a->rd, EXT_NONE);
     mask =3D gpr_src(ctx, a->rj, EXT_NONE);
     oldv =3D tcg_temp_new();
     newv =3D tcg_temp_new();
     temp =3D tcg_temp_new();
=20
-    tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
+    if (csr->readfn) {
+        GenCSRRead readfn =3D (GenCSRRead)csr->readfn;
+        readfn(oldv, tcg_env);
+    } else {
+        tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
+    }
     tcg_gen_and_tl(newv, src1, mask);
     tcg_gen_andc_tl(temp, oldv, mask);
     tcg_gen_or_tl(newv, newv, temp);
@@ -212,6 +270,11 @@ static bool gen_iocsrrd(DisasContext *ctx, arg_rr *a,
     TCGv dest =3D gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 =3D gpr_src(ctx, a->rj, EXT_NONE);
=20
+    if (ctx->guest_mode) {
+        gen_helper_gspr(tcg_env);
+        return true;
+    }
+
     if (check_plv(ctx)) {
         return false;
     }
@@ -225,6 +288,11 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_rr *a,
     TCGv val =3D gpr_src(ctx, a->rd, EXT_NONE);
     TCGv addr =3D gpr_src(ctx, a->rj, EXT_NONE);
=20
+    if (ctx->guest_mode) {
+        gen_helper_gspr(tcg_env);
+        return true;
+    }
+
     if (check_plv(ctx)) {
         return false;
     }
@@ -243,7 +311,7 @@ TRANS64(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsr=
wr_d)
=20
 static void check_mmu_idx(DisasContext *ctx)
 {
-    if (ctx->mem_idx !=3D MMU_DA_IDX) {
+    if (ctx->mem_idx !=3D MMU_DA_IDX && ctx->mem_idx !=3D MMU_GUEST_DA_IDX=
) {
         tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
         ctx->base.is_jmp =3D DISAS_EXIT;
     }
@@ -316,25 +384,61 @@ static bool trans_invtlb(DisasContext *ctx, arg_invtl=
b *a)
         return false;
     }
=20
+    if (!avail_LVZ(ctx) && a->imm > 0x6) {
+        return false;
+    }
+
+    //TODO: futher refinement of op 0x9 and 0x10-0x16
     switch (a->imm) {
-    case 0:
-    case 1:
-        gen_helper_invtlb_all(tcg_env);
+    case 0x0:
+    case 0x1:
+        gen_helper_invtlb_all(tcg_env, rj, tcg_constant_i32(a->imm),
+                              tcg_constant_i32(0));
+        break;
+    case 0x2:
+        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(1),
+                                tcg_constant_i32(0));
+        break;
+    case 0x3:
+        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(0),
+                                tcg_constant_i32(0));
+        break;
+    case 0x4:
+        gen_helper_invtlb_all_asid(tcg_env, rj, tcg_constant_i32(0));
+        break;
+    case 0x5:
+        gen_helper_invtlb_page_asid(tcg_env, rj, rk, tcg_constant_i32(0));
         break;
-    case 2:
-        gen_helper_invtlb_all_g(tcg_env, tcg_constant_i32(1));
+    case 0x6:
+        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk, tcg_constant_i32=
(0));
         break;
-    case 3:
-        gen_helper_invtlb_all_g(tcg_env, tcg_constant_i32(0));
+    case 0x9:
+    case 0x10:
+    case 0x11:
+    case 0x12:
+    case 0x13:
+    case 0x14:
+    case 0x15:
+    case 0x16:
+        gen_helper_invtlb_all(tcg_env, rj, tcg_constant_i32(0),
+                              tcg_constant_i32(0));
         break;
-    case 4:
-        gen_helper_invtlb_all_asid(tcg_env, rj);
+    case 0xa:
+        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(1),
+                                tcg_constant_i32(1));
         break;
-    case 5:
-        gen_helper_invtlb_page_asid(tcg_env, rj, rk);
+    case 0xb:
+        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(0),
+                                tcg_constant_i32(1));
         break;
-    case 6:
-        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk);
+    case 0xc:
+        gen_helper_invtlb_all_asid(tcg_env, rj, tcg_constant_i32(1));
+        break;
+    case 0xd:
+        gen_helper_invtlb_page_asid(tcg_env, rj, rk, tcg_constant_i32(1));
+        break;
+    case 0xe:
+        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk, tcg_constant_i32=
(1));
         break;
     default:
         return false;
@@ -400,6 +504,10 @@ static bool trans_dbcl(DisasContext *ctx, arg_dbcl *a)
     if (check_plv(ctx)) {
         return false;
     }
+    if (ctx->guest_mode) {
+        gen_helper_gspr(tcg_env);
+        return true;
+    }
     generate_exception(ctx, EXCCODE_DBP);
     return true;
 }
@@ -410,9 +518,212 @@ static bool trans_idle(DisasContext *ctx, arg_idle *a=
)
         return false;
     }
=20
+    if (ctx->guest_mode) {
+        gen_helper_gspr(tcg_env);
+        return true;
+    }
+
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
     gen_helper_idle(tcg_env);
     ctx->base.is_jmp =3D DISAS_NORETURN;
     return true;
 }
+
+static bool trans_gcsrrd(DisasContext *ctx, arg_gcsrrd *a)
+{
+    TCGv dest;
+    const CSRInfo *csr;
+    GenCSRRead readfn;
+
+    if (check_plv(ctx)) {
+        return false;
+    }
+    if (!avail_LVZ(ctx) || ctx->guest_mode) {
+        return false;
+    }
+
+    csr =3D get_gcsr(a->csr);
+    if (csr =3D=3D NULL) {
+        dest =3D tcg_constant_tl(0);
+    } else {
+        dest =3D gpr_dst(ctx, a->rd, EXT_NONE);
+        if (csr->flags & CSRFL_GSPR) {
+            tcg_gen_movi_tl(dest, 0);
+        } else {
+            readfn =3D (GenCSRRead)csr->readfn;
+            if (readfn) {
+                readfn(dest, tcg_env);
+            } else {
+                tcg_gen_ld_tl(dest, tcg_env, csr->offset);
+            }
+        }
+    }
+    gen_set_gpr(a->rd, dest, EXT_NONE);
+    return true;
+}
+
+static bool trans_gcsrwr(DisasContext *ctx, arg_gcsrwr *a)
+{
+    TCGv dest, src1;
+    const CSRInfo *csr;
+    GenCSRWrite writefn;
+
+    if (check_plv(ctx)) {
+        return false;
+    }
+    if (!avail_LVZ(ctx) || ctx->guest_mode) {
+        return false;
+    }
+
+    csr =3D get_gcsr(a->csr);
+    if (csr =3D=3D NULL) {
+        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
+    if (!check_csr_flags(ctx, csr, true)) {
+        return false;
+    }
+    if (csr->flags & CSRFL_GSPR) {
+        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
+
+    src1 =3D gpr_src(ctx, a->rd, EXT_NONE);
+    writefn =3D (GenCSRWrite)csr->writefn;
+    if (writefn) {
+        dest =3D gpr_dst(ctx, a->rd, EXT_NONE);
+        writefn(dest, tcg_env, src1);
+    } else {
+        dest =3D tcg_temp_new();
+        tcg_gen_ld_tl(dest, tcg_env, csr->offset);
+        tcg_gen_st_tl(src1, tcg_env, csr->offset);
+    }
+    gen_set_gpr(a->rd, dest, EXT_NONE);
+    return true;
+}
+
+static bool trans_gcsrxchg(DisasContext *ctx, arg_gcsrxchg *a)
+{
+    TCGv src1, mask, oldv, newv, temp;
+    const CSRInfo *csr;
+    GenCSRRead readfn;
+    GenCSRWrite writefn;
+
+    if (check_plv(ctx)) {
+        return false;
+    }
+    if (!avail_LVZ(ctx) || ctx->guest_mode) {
+        return false;
+    }
+
+    csr =3D get_gcsr(a->csr);
+    if (csr =3D=3D NULL) {
+        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
+    if (!check_csr_flags(ctx, csr, true)) {
+        return false;
+    }
+    if (csr->flags & CSRFL_GSPR) {
+        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
+        return true;
+    }
+
+    src1 =3D gpr_src(ctx, a->rd, EXT_NONE);
+    mask =3D gpr_src(ctx, a->rj, EXT_NONE);
+    oldv =3D tcg_temp_new();
+    newv =3D tcg_temp_new();
+    temp =3D tcg_temp_new();
+
+    readfn =3D (GenCSRRead)csr->readfn;
+    if (readfn) {
+        readfn(oldv, tcg_env);
+    } else {
+        tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
+    }
+    tcg_gen_and_tl(newv, src1, mask);
+    tcg_gen_andc_tl(temp, oldv, mask);
+    tcg_gen_or_tl(newv, newv, temp);
+
+    writefn =3D (GenCSRWrite)csr->writefn;
+    if (writefn) {
+        writefn(oldv, tcg_env, newv);
+    } else {
+        tcg_gen_st_tl(newv, tcg_env, csr->offset);
+    }
+    gen_set_gpr(a->rd, oldv, EXT_NONE);
+    return true;
+}
+
+static bool trans_gtlbsrch(DisasContext *ctx, arg_gtlbsrch *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
+        return false;
+    }
+    gen_helper_gtlbsrch(tcg_env);
+    return true;
+}
+
+static bool trans_gtlbrd(DisasContext *ctx, arg_gtlbrd *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
+        return false;
+    }
+    gen_helper_gtlbrd(tcg_env);
+    return true;
+}
+
+static bool trans_gtlbwr(DisasContext *ctx, arg_gtlbwr *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
+        return false;
+    }
+    gen_helper_gtlbwr(tcg_env);
+    check_mmu_idx(ctx);
+    return true;
+}
+
+static bool trans_gtlbfill(DisasContext *ctx, arg_gtlbfill *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
+        return false;
+    }
+    gen_helper_gtlbfill(tcg_env);
+    check_mmu_idx(ctx);
+    return true;
+}
+
+static bool trans_gtlbclr(DisasContext *ctx, arg_gtlbclr *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
+        return false;
+    }
+    gen_helper_gtlbclr(tcg_env);
+    check_mmu_idx(ctx);
+    return true;
+}
+
+static bool trans_gtlbflush(DisasContext *ctx, arg_gtlbflush *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
+        return false;
+    }
+    gen_helper_gtlbflush(tcg_env);
+    check_mmu_idx(ctx);
+    return true;
+}
+
+static bool trans_hvcl(DisasContext *ctx, arg_hvcl *a)
+{
+    if (!avail_LVZ(ctx)) {
+        return false;
+    }
+    if (!ctx->guest_mode) {
+        return false;
+    }
+    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
+    gen_helper_hvcl(tcg_env, tcg_constant_i32(a->imm));
+    ctx->base.is_jmp =3D DISAS_NORETURN;
+    return true;
+}
 #endif
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
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tc=
g_loongarch.h
index 7fb627f2d6..ceba1e4062 100644
--- a/target/loongarch/tcg/tcg_loongarch.h
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -16,8 +16,8 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, =
int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr);
=20
-TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
-                                   MMUContext *context,
-                                   MMUAccessType access_type, int mmu_idx)=
;
+TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env, MMUContext *con=
text,
+                                   MMUAccessType access_type, int mmu_idx,
+                                   bool guest);
=20
 #endif  /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_h=
elper.c
index 892e0eb473..fec0aeeb57 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -34,6 +34,13 @@ static bool tlb_match_asid(bool global, int asid, int tl=
b_asid)
     return !global && tlb_asid =3D=3D asid;
 }
=20
+static inline bool tlb_entry_matches_gid(LoongArchTLB *tlb, uint8_t gid)
+{
+    uint8_t entry_gid =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, GID);
+
+    return entry_gid =3D=3D gid;
+}
+
 bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
 {
     if (tlb_ps >=3D 64) {
@@ -46,14 +53,22 @@ static void raise_mmu_exception(CPULoongArchState *env,=
 vaddr address,
                                 MMUAccessType access_type, TLBRet tlb_erro=
r)
 {
     CPUState *cs =3D env_cpu(env);
+    bool real_guest;
+
+    if (env->guest && tlb_error > TLBRET_HOST_MATCH) {
+        trigger_vm_exit(env);
+    }
+    real_guest =3D !env->vm_exit && env->guest;
=20
     switch (tlb_error) {
     default:
     case TLBRET_BADADDR:
+    case TLBRET_HOST_BADADDR:
         cs->exception_index =3D access_type =3D=3D MMU_INST_FETCH
                               ? EXCCODE_ADEF : EXCCODE_ADEM;
         break;
     case TLBRET_NOMATCH:
+    case TLBRET_HOST_NOMATCH:
         /* No TLB match for a mapped address */
         if (access_type =3D=3D MMU_DATA_LOAD) {
             cs->exception_index =3D EXCCODE_PIL;
@@ -62,9 +77,12 @@ static void raise_mmu_exception(CPULoongArchState *env, =
vaddr address,
         } else if (access_type =3D=3D MMU_INST_FETCH) {
             cs->exception_index =3D EXCCODE_PIF;
         }
-        env->CSR_TLBRERA =3D FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, IST=
LBR, 1);
+        SET_CSR_IF(real_guest, TLBRERA,
+                   FIELD_DP64(GET_CSR_IF(real_guest, TLBRERA), CSR_TLBRERA=
,
+                              ISTLBR, 1));
         break;
     case TLBRET_INVALID:
+    case TLBRET_HOST_INVALID:
         /* TLB match with no valid bit */
         if (access_type =3D=3D MMU_DATA_LOAD) {
             cs->exception_index =3D EXCCODE_PIL;
@@ -75,46 +93,58 @@ static void raise_mmu_exception(CPULoongArchState *env,=
 vaddr address,
         }
         break;
     case TLBRET_DIRTY:
+    case TLBRET_HOST_DIRTY:
         /* TLB match but 'D' bit is cleared */
         cs->exception_index =3D EXCCODE_PME;
         break;
     case TLBRET_XI:
+    case TLBRET_HOST_XI:
         /* Execute-Inhibit Exception */
         cs->exception_index =3D EXCCODE_PNX;
         break;
     case TLBRET_RI:
+    case TLBRET_HOST_RI:
         /* Read-Inhibit Exception */
         cs->exception_index =3D EXCCODE_PNR;
         break;
     case TLBRET_PE:
+    case TLBRET_HOST_PE:
         /* Privileged Exception */
         cs->exception_index =3D EXCCODE_PPI;
         break;
     }
=20
-    if (tlb_error =3D=3D TLBRET_NOMATCH) {
-        env->CSR_TLBRBADV =3D address;
+    if (tlb_error =3D=3D TLBRET_NOMATCH || tlb_error =3D=3D TLBRET_HOST_NO=
MATCH) {
+        SET_CSR_IF(real_guest, TLBRBADV, address);
         if (is_la64(env)) {
-            env->CSR_TLBREHI =3D FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_=
64,
-                                        VPPN, extract64(address, 13, 35));
+            SET_CSR_IF(real_guest, TLBREHI,
+                       FIELD_DP64(GET_CSR_IF(real_guest, TLBREHI),
+                                  CSR_TLBREHI_64, VPPN,
+                                  extract64(address, 13, 35)));
         } else {
-            env->CSR_TLBREHI =3D FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_=
32,
-                                        VPPN, extract64(address, 13, 19));
+            SET_CSR_IF(real_guest, TLBREHI,
+                       FIELD_DP64(GET_CSR_IF(real_guest, TLBREHI),
+                                  CSR_TLBREHI_32, VPPN,
+                                  extract64(address, 13, 19)));
         }
     } else {
         if (!FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
-            env->CSR_BADV =3D address;
+            SET_CSR_IF(real_guest, BADV, address);
         }
-        env->CSR_TLBEHI =3D address & (TARGET_PAGE_MASK << 1);
-   }
+        SET_CSR_IF(real_guest, TLBEHI, address & (TARGET_PAGE_MASK << 1));
+    }
 }
=20
-static void invalidate_tlb_entry(CPULoongArchState *env, int index)
+static void invalidate_tlb_entry(CPULoongArchState *env, int index, bool g=
uest)
 {
     target_ulong addr, mask, pagesize;
     uint8_t tlb_ps;
-    LoongArchTLB *tlb =3D &env->tlb[index];
-    int idxmap =3D BIT(MMU_KERNEL_IDX) | BIT(MMU_USER_IDX);
+    LoongArchTLB *tlb =3D guest ? &env->gtlb[index] : &env->tlb[index];
+    int idxmap =3D
+        guest ? (BIT(MMU_GUEST_IDX) | BIT(MMU_GUEST_IDX + 1) |
+                 BIT(MMU_GUEST_IDX + 2) | BIT(MMU_GUEST_IDX + 3) |
+                 BIT(MMU_GUEST_DA_IDX)) :
+                (BIT(MMU_KERNEL_IDX) | BIT(MMU_USER_IDX) | BIT(MMU_DA_IDX)=
);
     uint64_t tlb_vppn =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
     bool tlb_v;
=20
@@ -124,27 +154,27 @@ static void invalidate_tlb_entry(CPULoongArchState *e=
nv, int index)
     addr =3D (tlb_vppn << R_TLB_MISC_VPPN_SHIFT) & ~mask;
     addr =3D sextract64(addr, 0, TARGET_VIRT_ADDR_SPACE_BITS);
=20
-    tlb_v =3D pte_present(env, tlb->tlb_entry0);
+    tlb_v =3D pte_present(env, tlb->tlb_entry0, guest);
     if (tlb_v) {
         tlb_flush_range_by_mmuidx(env_cpu(env), addr, pagesize,
                                   idxmap, TARGET_LONG_BITS);
     }
=20
-    tlb_v =3D pte_present(env, tlb->tlb_entry1);
+    tlb_v =3D pte_present(env, tlb->tlb_entry1, guest);
     if (tlb_v) {
         tlb_flush_range_by_mmuidx(env_cpu(env), addr + pagesize, pagesize,
                                   idxmap, TARGET_LONG_BITS);
     }
 }
=20
-static void invalidate_tlb(CPULoongArchState *env, int index)
+static void invalidate_tlb(CPULoongArchState *env, int index, bool guest)
 {
     LoongArchTLB *tlb;
     uint16_t csr_asid, tlb_asid, tlb_g;
     uint8_t tlb_e;
=20
-    csr_asid =3D FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
-    tlb =3D &env->tlb[index];
+    csr_asid =3D FIELD_EX64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID);
+    tlb =3D guest ? &env->gtlb[index] : &env->tlb[index];
     tlb_e =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
     if (!tlb_e) {
         return;
@@ -157,33 +187,38 @@ static void invalidate_tlb(CPULoongArchState *env, in=
t index)
     if (tlb_g =3D=3D 0 && tlb_asid !=3D csr_asid) {
         return;
     }
-    invalidate_tlb_entry(env, index);
+    invalidate_tlb_entry(env, index, guest);
 }
=20
 /* Prepare tlb entry information in software PTW mode */
-static void sptw_prepare_context(CPULoongArchState *env, MMUContext *conte=
xt)
+static void sptw_prepare_context(CPULoongArchState *env, MMUContext *conte=
xt,
+                                 bool guest)
 {
     uint64_t lo0, lo1, csr_vppn;
     uint8_t csr_ps;
=20
-    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        csr_ps =3D FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
+    if (FIELD_EX64(GET_CSR_IF(guest, TLBRERA), CSR_TLBRERA, ISTLBR)) {
+        csr_ps =3D FIELD_EX64(GET_CSR_IF(guest, TLBREHI), CSR_TLBREHI, PS)=
;
         if (is_la64(env)) {
-            csr_vppn =3D FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_64, VPPN=
);
+            csr_vppn =3D
+                FIELD_EX64(GET_CSR_IF(guest, TLBREHI), CSR_TLBREHI_64, VPP=
N);
         } else {
-            csr_vppn =3D FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_32, VPPN=
);
+            csr_vppn =3D
+                FIELD_EX64(GET_CSR_IF(guest, TLBREHI), CSR_TLBREHI_32, VPP=
N);
         }
-        lo0 =3D env->CSR_TLBRELO0;
-        lo1 =3D env->CSR_TLBRELO1;
+        lo0 =3D GET_CSR_IF(guest, TLBRELO0);
+        lo1 =3D GET_CSR_IF(guest, TLBRELO1);
     } else {
-        csr_ps =3D FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
+        csr_ps =3D FIELD_EX64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, PS);
         if (is_la64(env)) {
-            csr_vppn =3D FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_64, VPPN);
+            csr_vppn =3D
+                FIELD_EX64(GET_CSR_IF(guest, TLBEHI), CSR_TLBEHI_64, VPPN)=
;
         } else {
-            csr_vppn =3D FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_32, VPPN);
+            csr_vppn =3D
+                FIELD_EX64(GET_CSR_IF(guest, TLBEHI), CSR_TLBEHI_32, VPPN)=
;
         }
-        lo0 =3D env->CSR_TLBELO0;
-        lo1 =3D env->CSR_TLBELO1;
+        lo0 =3D GET_CSR_IF(guest, TLBELO0);
+        lo1 =3D GET_CSR_IF(guest, TLBELO1);
     }
=20
     context->ps =3D csr_ps;
@@ -193,7 +228,7 @@ static void sptw_prepare_context(CPULoongArchState *env=
, MMUContext *context)
 }
=20
 static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
-                           MMUContext *context)
+                           MMUContext *context, bool guest)
 {
     uint64_t lo0, lo1, csr_vppn;
     uint16_t csr_asid;
@@ -208,8 +243,9 @@ static void fill_tlb_entry(CPULoongArchState *env, Loon=
gArchTLB *tlb,
     tlb->tlb_misc =3D FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
     tlb->tlb_misc =3D FIELD_DP64(tlb->tlb_misc, TLB_MISC, VPPN, csr_vppn);
     tlb->tlb_misc =3D FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 1);
-    csr_asid =3D FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
+    csr_asid =3D FIELD_EX64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID);
     tlb->tlb_misc =3D FIELD_DP64(tlb->tlb_misc, TLB_MISC, ASID, csr_asid);
+    tlb->tlb_misc =3D FIELD_DP64(tlb->tlb_misc, TLB_MISC, GID, get_tgid(en=
v));
=20
     tlb->tlb_entry0 =3D lo0;
     tlb->tlb_entry1 =3D lo1;
@@ -233,7 +269,8 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t h=
igh)
  */
 static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
                                              vaddr vaddr, int csr_asid,
-                                             tlb_match func)
+                                             tlb_match func, bool guest,
+                                             uint8_t gid)
 {
     LoongArchTLB *tlb;
     uint16_t tlb_asid, stlb_idx;
@@ -242,14 +279,15 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoong=
ArchState *env,
     int i, compare_shift;
     uint64_t vpn, tlb_vppn;
=20
-    stlb_ps =3D FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+    stlb_ps =3D FIELD_EX64(GET_CSR_IF(guest, STLBPS), CSR_STLBPS, PS);
     vpn =3D (vaddr & TARGET_VIRT_MASK) >> (stlb_ps + 1);
     stlb_idx =3D vpn & 0xff; /* VA[25:15] <=3D=3D> TLBIDX.index for 16KiB =
Page */
     compare_shift =3D stlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
=20
     /* Search STLB */
     for (i =3D 0; i < 8; ++i) {
-        tlb =3D &env->tlb[i * 256 + stlb_idx];
+        tlb =3D guest ? &env->gtlb[i * 256 + stlb_idx] :
+                      &env->tlb[i * 256 + stlb_idx];
         tlb_e =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
         if (tlb_e) {
             tlb_vppn =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
@@ -257,6 +295,7 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongAr=
chState *env,
             tlb_g =3D !!FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
=20
             if (func(tlb_g, csr_asid, tlb_asid) &&
+                tlb_entry_matches_gid(tlb, gid) &&
                 (vpn =3D=3D (tlb_vppn >> compare_shift))) {
                 return tlb;
             }
@@ -265,7 +304,7 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongAr=
chState *env,
=20
     /* Search MTLB */
     for (i =3D LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; ++i) {
-        tlb =3D &env->tlb[i];
+        tlb =3D guest ? &env->gtlb[i] : &env->tlb[i];
         tlb_e =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
         if (tlb_e) {
             tlb_vppn =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
@@ -275,6 +314,7 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongAr=
chState *env,
             compare_shift =3D tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
             vpn =3D (vaddr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
             if (func(tlb_g, csr_asid, tlb_asid) &&
+                tlb_entry_matches_gid(tlb, gid) &&
                 (vpn =3D=3D (tlb_vppn >> compare_shift))) {
                 return tlb;
             }
@@ -284,17 +324,17 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoong=
ArchState *env,
 }
=20
 static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
-                                 int *index)
+                                 int *index, bool guest, uint8_t gid)
 {
     int csr_asid;
     tlb_match func;
     LoongArchTLB *tlb;
=20
     func =3D tlb_match_any;
-    csr_asid =3D FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
-    tlb =3D loongarch_tlb_search_cb(env, vaddr, csr_asid, func);
+    csr_asid =3D FIELD_EX64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID);
+    tlb =3D loongarch_tlb_search_cb(env, vaddr, csr_asid, func, guest, gid=
);
     if (tlb) {
-        *index =3D tlb - env->tlb;
+        *index =3D guest ? (tlb - env->gtlb) : (tlb - env->tlb);
         return true;
     }
=20
@@ -304,66 +344,112 @@ static bool loongarch_tlb_search(CPULoongArchState *=
env, vaddr vaddr,
 void helper_tlbsrch(CPULoongArchState *env)
 {
     int index, match;
+    vaddr search_ehi;
=20
-    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        match =3D loongarch_tlb_search(env, env->CSR_TLBREHI, &index);
+    if (FIELD_EX64(GET_CSR_IF(env->guest, TLBRERA), CSR_TLBRERA, ISTLBR)) =
{
+        search_ehi =3D GET_CSR_IF(env->guest, TLBREHI);
     } else {
-        match =3D loongarch_tlb_search(env, env->CSR_TLBEHI, &index);
+        search_ehi =3D GET_CSR_IF(env->guest, TLBEHI);
     }
=20
+    match =3D loongarch_tlb_search(env, search_ehi, &index, env->guest,
+                                 get_tgid(env));
+
     if (match) {
-        env->CSR_TLBIDX =3D FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX,=
 index);
-        env->CSR_TLBIDX =3D FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 0)=
;
+        SET_CSR_IF(env->guest, TLBIDX,
+                   FIELD_DP64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, =
INDEX,
+                              index));
+        SET_CSR_IF(
+            env->guest, TLBIDX,
+            FIELD_DP64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, NE, 0))=
;
         return;
     }
=20
-    env->CSR_TLBIDX =3D FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
+    SET_CSR_IF(env->guest, TLBIDX,
+               FIELD_DP64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, NE, =
1));
 }
=20
-void helper_tlbrd(CPULoongArchState *env)
+static void read_tlb(CPULoongArchState *env, bool guest)
 {
     LoongArchTLB *tlb;
     int index;
     uint8_t tlb_ps, tlb_e;
=20
-    index =3D FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
-    tlb =3D &env->tlb[index];
+    index =3D FIELD_EX64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, INDEX);
+    tlb =3D guest ? &env->gtlb[index] : &env->tlb[index];
     tlb_ps =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
     tlb_e =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
=20
     if (!tlb_e) {
         /* Invalid TLB entry */
-        env->CSR_TLBIDX =3D FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 1)=
;
-        env->CSR_ASID  =3D FIELD_DP64(env->CSR_ASID, CSR_ASID, ASID, 0);
-        env->CSR_TLBEHI =3D 0;
-        env->CSR_TLBELO0 =3D 0;
-        env->CSR_TLBELO1 =3D 0;
-        env->CSR_TLBIDX =3D FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, PS, 0)=
;
+        SET_CSR_IF(guest, TLBIDX,
+                   FIELD_DP64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, NE, 1=
));
+        SET_CSR_IF(guest, ASID,
+                   FIELD_DP64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID, 0))=
;
+        SET_CSR_IF(guest, TLBEHI, 0);
+        SET_CSR_IF(guest, TLBELO0, 0);
+        SET_CSR_IF(guest, TLBELO1, 0);
+        SET_CSR_IF(guest, TLBIDX,
+                   FIELD_DP64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, PS, 0=
));
     } else {
         /* Valid TLB entry */
-        env->CSR_TLBIDX =3D FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 0)=
;
-        env->CSR_TLBIDX =3D FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX,
-                                     PS, (tlb_ps & 0x3f));
-        env->CSR_TLBEHI =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN) <<
-                                     R_TLB_MISC_VPPN_SHIFT;
-        env->CSR_TLBELO0 =3D tlb->tlb_entry0;
-        env->CSR_TLBELO1 =3D tlb->tlb_entry1;
+        SET_CSR_IF(guest, TLBIDX,
+                   FIELD_DP64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, NE, 0=
));
+        SET_CSR_IF(guest, TLBIDX,
+                   FIELD_DP64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, PS,
+                              tlb_ps & 0x3f));
+        SET_CSR_IF(guest, TLBEHI,
+                   FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN)
+                       << R_TLB_MISC_VPPN_SHIFT);
+        SET_CSR_IF(guest, TLBELO0, tlb->tlb_entry0);
+        SET_CSR_IF(guest, TLBELO1, tlb->tlb_entry1);
+    }
+}
+
+void helper_tlbrd(CPULoongArchState *env)
+{
+    read_tlb(env, env->guest);
+}
+
+void helper_gtlbsrch(CPULoongArchState *env)
+{
+    int index, match;
+    vaddr search_ehi;
+
+    if (FIELD_EX64(env->GCSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
+        search_ehi =3D env->GCSR_TLBREHI;
+    } else {
+        search_ehi =3D env->GCSR_TLBEHI;
+    }
+
+    match =3D loongarch_tlb_search(env, search_ehi, &index, true, get_tgid=
(env));
+    if (match) {
+        env->GCSR_TLBIDX =3D
+            FIELD_DP64(env->GCSR_TLBIDX, CSR_TLBIDX, INDEX, index);
+        env->GCSR_TLBIDX =3D FIELD_DP64(env->GCSR_TLBIDX, CSR_TLBIDX, NE, =
0);
+        return;
     }
+    env->GCSR_TLBIDX =3D FIELD_DP64(env->GCSR_TLBIDX, CSR_TLBIDX, NE, 1);
+}
+
+void helper_gtlbrd(CPULoongArchState *env)
+{
+    read_tlb(env, true);
 }
=20
 static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
-                             int index)
+                             int index, bool guest)
 {
     LoongArchTLB *old, new =3D {};
     bool skip_inv =3D false, tlb_v0, tlb_v1;
=20
-    old =3D env->tlb + index;
-    fill_tlb_entry(env, &new, context);
+    old =3D guest ? env->gtlb + index : env->tlb + index;
+    fill_tlb_entry(env, &new, context, guest);
     /* Check whether ASID/VPPN is the same */
     if (old->tlb_misc =3D=3D new.tlb_misc) {
         /* Check whether both even/odd pages is the same or invalid */
-        tlb_v0 =3D pte_present(env, old->tlb_entry0);
-        tlb_v1 =3D pte_present(env, old->tlb_entry1);
+        tlb_v0 =3D pte_present(env, old->tlb_entry0, guest);
+        tlb_v1 =3D pte_present(env, old->tlb_entry1, guest);
         if ((!tlb_v0 || new.tlb_entry0 =3D=3D old->tlb_entry0) &&
             (!tlb_v1 || new.tlb_entry1 =3D=3D old->tlb_entry1)) {
             skip_inv =3D true;
@@ -372,7 +458,7 @@ static void update_tlb_index(CPULoongArchState *env, MM=
UContext *context,
=20
     /* flush tlb before updating the entry */
     if (!skip_inv) {
-        invalidate_tlb(env, index);
+        invalidate_tlb(env, index, guest);
     }
=20
     *old =3D new;
@@ -380,20 +466,34 @@ static void update_tlb_index(CPULoongArchState *env, =
MMUContext *context,
=20
 void helper_tlbwr(CPULoongArchState *env)
 {
-    int index =3D FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
+    int index =3D FIELD_EX64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, I=
NDEX);
+    MMUContext context;
+
+    if (FIELD_EX64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, NE)) {
+        invalidate_tlb(env, index, env->guest);
+        return;
+    }
+
+    sptw_prepare_context(env, &context, env->guest);
+    update_tlb_index(env, &context, index, env->guest);
+}
+
+void helper_gtlbwr(CPULoongArchState *env)
+{
+    int index =3D FIELD_EX64(env->GCSR_TLBIDX, CSR_TLBIDX, INDEX);
     MMUContext context;
=20
-    if (FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, NE)) {
-        invalidate_tlb(env, index);
+    if (FIELD_EX64(env->GCSR_TLBIDX, CSR_TLBIDX, NE)) {
+        invalidate_tlb(env, index, true);
         return;
     }
=20
-    sptw_prepare_context(env, &context);
-    update_tlb_index(env, &context, index);
+    sptw_prepare_context(env, &context, true);
+    update_tlb_index(env, &context, index, true);
 }
=20
 static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
-                                int pagesize)
+                                int pagesize, bool guest)
 {
     uint64_t address;
     int index, set, i, stlb_idx;
@@ -402,15 +502,16 @@ static int get_tlb_random_index(CPULoongArchState *en=
v, vaddr addr,
     uint8_t tlb_e, tlb_g;
=20
     /* Validity of stlb_ps is checked in helper_csrwr_stlbps() */
-    stlb_ps =3D FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
-    asid =3D FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
+    stlb_ps =3D FIELD_EX64(GET_CSR_IF(guest, STLBPS), CSR_STLBPS, PS);
+    asid =3D FIELD_EX64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID);
     if (pagesize =3D=3D stlb_ps) {
         /* Only write into STLB bits [47:13] */
         address =3D addr & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT)=
;
         set =3D -1;
         stlb_idx =3D (address >> (stlb_ps + 1)) & 0xff; /* [0,255] */
         for (i =3D 0; i < 8; ++i) {
-            tlb =3D &env->tlb[i * 256 + stlb_idx];
+            tlb =3D guest ? &env->gtlb[i * 256 + stlb_idx] :
+                          &env->tlb[i * 256 + stlb_idx];
             tlb_e =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
             if (!tlb_e) {
                 set =3D i;
@@ -419,7 +520,8 @@ static int get_tlb_random_index(CPULoongArchState *env,=
 vaddr addr,
=20
             tlb_asid =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g =3D FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (tlb_g =3D=3D 0 && asid !=3D tlb_asid) {
+            if (tlb_g =3D=3D 0 && asid !=3D tlb_asid &&
+                tlb_entry_matches_gid(tlb, get_tgid(env))) {
                 set =3D i;
             }
         }
@@ -433,7 +535,7 @@ static int get_tlb_random_index(CPULoongArchState *env,=
 vaddr addr,
         /* Only write into MTLB */
         index =3D -1;
         for (i =3D LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; i++) {
-            tlb =3D &env->tlb[i];
+            tlb =3D guest ? &env->gtlb[i] : &env->tlb[i];
             tlb_e =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
=20
             if (!tlb_e) {
@@ -443,7 +545,8 @@ static int get_tlb_random_index(CPULoongArchState *env,=
 vaddr addr,
=20
             tlb_asid =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g =3D FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (tlb_g =3D=3D 0 && asid !=3D tlb_asid) {
+            if (tlb_g =3D=3D 0 && asid !=3D tlb_asid &&
+                tlb_entry_matches_gid(tlb, get_tgid(env))) {
                 index =3D i;
             }
         }
@@ -462,48 +565,70 @@ void helper_tlbfill(CPULoongArchState *env)
     int index, pagesize;
     MMUContext context;
=20
-    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        entryhi =3D env->CSR_TLBREHI;
+    if (FIELD_EX64(GET_CSR_IF(env->guest, TLBRERA), CSR_TLBRERA, ISTLBR)) =
{
+        entryhi =3D GET_CSR_IF(env->guest, TLBREHI);
         /* Validity of pagesize is checked in helper_ldpte() */
-        pagesize =3D FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
+        pagesize =3D FIELD_EX64(GET_CSR_IF(env->guest, TLBREHI), CSR_TLBRE=
HI, PS);
     } else {
-        entryhi =3D env->CSR_TLBEHI;
+        entryhi =3D GET_CSR_IF(env->guest, TLBEHI);
         /* Validity of pagesize is checked in helper_tlbrd() */
-        pagesize =3D FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
+        pagesize =3D FIELD_EX64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX=
, PS);
     }
=20
-    sptw_prepare_context(env, &context);
-    index =3D get_tlb_random_index(env, entryhi, pagesize);
-    invalidate_tlb(env, index);
-    fill_tlb_entry(env, env->tlb + index, &context);
+    sptw_prepare_context(env, &context, env->guest);
+    index =3D get_tlb_random_index(env, entryhi, pagesize, env->guest);
+    invalidate_tlb(env, index, env->guest);
+    fill_tlb_entry(env, env->guest ? env->gtlb + index : env->tlb + index,
+                   &context, env->guest);
 }
=20
-void helper_tlbclr(CPULoongArchState *env)
+void helper_gtlbfill(CPULoongArchState *env)
+{
+    vaddr entryhi;
+    int index, pagesize;
+    MMUContext context;
+
+    if (FIELD_EX64(env->GCSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
+        entryhi =3D env->GCSR_TLBREHI;
+        pagesize =3D FIELD_EX64(env->GCSR_TLBREHI, CSR_TLBREHI, PS);
+    } else {
+        entryhi =3D env->GCSR_TLBEHI;
+        pagesize =3D FIELD_EX64(env->GCSR_TLBIDX, CSR_TLBIDX, PS);
+    }
+
+    sptw_prepare_context(env, &context, true);
+    index =3D get_tlb_random_index(env, entryhi, pagesize, true);
+    invalidate_tlb(env, index, true);
+    fill_tlb_entry(env, env->gtlb + index, &context, true);
+}
+
+static void clear_tlb_by_index(CPULoongArchState *env, bool guest)
 {
     LoongArchTLB *tlb;
     int i, index;
     uint16_t csr_asid, tlb_asid, tlb_g;
=20
-    csr_asid =3D FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
-    index =3D FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
+    csr_asid =3D FIELD_EX64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID);
+    index =3D FIELD_EX64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, INDEX);
=20
     if (index < LOONGARCH_STLB) {
-        /* STLB. One line per operation */
         for (i =3D 0; i < 8; i++) {
-            tlb =3D &env->tlb[i * 256 + (index % 256)];
+            tlb =3D guest ? &env->gtlb[i * 256 + (index % 256)] :
+                          &env->tlb[i * 256 + (index % 256)];
             tlb_asid =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g =3D FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (!tlb_g && tlb_asid =3D=3D csr_asid) {
+            if (!tlb_g && tlb_asid =3D=3D csr_asid &&
+                tlb_entry_matches_gid(tlb, get_tgid(env))) {
                 tlb->tlb_misc =3D FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0=
);
             }
         }
     } else if (index < LOONGARCH_TLB_MAX) {
-        /* All MTLB entries */
         for (i =3D LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; i++) {
-            tlb =3D &env->tlb[i];
+            tlb =3D guest ? &env->gtlb[i] : &env->tlb[i];
             tlb_asid =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g =3D FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (!tlb_g && tlb_asid =3D=3D csr_asid) {
+            if (!tlb_g && tlb_asid =3D=3D csr_asid &&
+                tlb_entry_matches_gid(tlb, get_tgid(env))) {
                 tlb->tlb_misc =3D FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0=
);
             }
         }
@@ -512,62 +637,116 @@ void helper_tlbclr(CPULoongArchState *env)
     tlb_flush(env_cpu(env));
 }
=20
-void helper_tlbflush(CPULoongArchState *env)
+void helper_tlbclr(CPULoongArchState *env)
+{
+    clear_tlb_by_index(env, env->guest);
+}
+
+void helper_gtlbclr(CPULoongArchState *env)
+{
+    clear_tlb_by_index(env, true);
+}
+
+static void flush_tlb_by_index(CPULoongArchState *env, bool guest)
 {
     int i, index;
=20
-    index =3D FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
+    index =3D FIELD_EX64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, INDEX);
=20
     if (index < LOONGARCH_STLB) {
-        /* STLB. One line per operation */
         for (i =3D 0; i < 8; i++) {
             int s_idx =3D i * 256 + (index % 256);
-            env->tlb[s_idx].tlb_misc =3D FIELD_DP64(env->tlb[s_idx].tlb_mi=
sc,
-                                                  TLB_MISC, E, 0);
+            LoongArchTLB *tlb =3D guest ? &env->gtlb[s_idx] : &env->tlb[s_=
idx];
+
+            tlb->tlb_misc =3D FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
         }
     } else if (index < LOONGARCH_TLB_MAX) {
-        /* All MTLB entries */
         for (i =3D LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; i++) {
-            env->tlb[i].tlb_misc =3D FIELD_DP64(env->tlb[i].tlb_misc,
-                                              TLB_MISC, E, 0);
+            LoongArchTLB *tlb =3D guest ? &env->gtlb[i] : &env->tlb[i];
+
+            tlb->tlb_misc =3D FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
         }
     }
=20
     tlb_flush(env_cpu(env));
 }
=20
-void helper_invtlb_all(CPULoongArchState *env)
+void helper_tlbflush(CPULoongArchState *env)
+{
+    flush_tlb_by_index(env, env->guest);
+}
+
+void helper_gtlbflush(CPULoongArchState *env)
+{
+    flush_tlb_by_index(env, true);
+}
+
+void helper_invtlb_all(CPULoongArchState *env, target_ulong info, uint32_t=
 op,
+                       uint32_t to_guest)
 {
+    uint16_t gid =3D to_guest ? (info & 0xff) : get_tgid(env);
+
+    if (to_guest && env->guest) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+
+    to_guest |=3D env->guest;
+
     for (int i =3D 0; i < LOONGARCH_TLB_MAX; i++) {
-        env->tlb[i].tlb_misc =3D FIELD_DP64(env->tlb[i].tlb_misc,
-                                          TLB_MISC, E, 0);
+        LoongArchTLB *tlb =3D &env->tlb[i];
+        LoongArchTLB *gtlb =3D &env->gtlb[i];
+
+        if (!to_guest && (op =3D=3D 0 || tlb_entry_matches_gid(tlb, 0))) {
+            tlb->tlb_misc =3D FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
+        }
+        if ((!to_guest && op =3D=3D 0) ||
+            (to_guest && tlb_entry_matches_gid(gtlb, gid))) {
+            gtlb->tlb_misc =3D FIELD_DP64(gtlb->tlb_misc, TLB_MISC, E, 0);
+        }
     }
     tlb_flush(env_cpu(env));
 }
=20
-void helper_invtlb_all_g(CPULoongArchState *env, uint32_t g)
+void helper_invtlb_all_g(CPULoongArchState *env, target_ulong info, uint32=
_t g,
+                         uint32_t to_guest)
 {
+    uint16_t gid =3D to_guest ? (info & 0xff) : get_tgid(env);
+
+    if (to_guest && env->guest) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+
+    to_guest |=3D env->guest;
+
     for (int i =3D 0; i < LOONGARCH_TLB_MAX; i++) {
-        LoongArchTLB *tlb =3D &env->tlb[i];
+        LoongArchTLB *tlb =3D to_guest ? &env->gtlb[i] : &env->tlb[i];
         uint8_t tlb_g =3D FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
=20
-        if (tlb_g =3D=3D g) {
+        if (tlb_g =3D=3D g && tlb_entry_matches_gid(tlb, gid)) {
             tlb->tlb_misc =3D FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
         }
     }
     tlb_flush(env_cpu(env));
 }
=20
-void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info)
+void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info,
+                            uint32_t to_guest)
 {
     uint16_t asid =3D info & R_CSR_ASID_ASID_MASK;
+    uint16_t gid =3D to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
+
+    if (to_guest && env->guest) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+
+    to_guest |=3D env->guest;
=20
     for (int i =3D 0; i < LOONGARCH_TLB_MAX; i++) {
-        LoongArchTLB *tlb =3D &env->tlb[i];
+        LoongArchTLB *tlb =3D to_guest ? &env->gtlb[i] : &env->tlb[i];
         uint8_t tlb_g =3D FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
         uint16_t tlb_asid =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
=20
-        if (!tlb_g && (tlb_asid =3D=3D asid)) {
+        if (!tlb_g && tlb_asid =3D=3D asid && tlb_entry_matches_gid(tlb, g=
id)) {
             tlb->tlb_misc =3D FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
         }
     }
@@ -575,66 +754,82 @@ void helper_invtlb_all_asid(CPULoongArchState *env, t=
arget_ulong info)
 }
=20
 void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
-                             target_ulong addr)
+                             target_ulong addr, uint32_t to_guest)
 {
-    int asid =3D info & 0x3ff;
+    uint16_t asid =3D info & R_CSR_ASID_ASID_MASK;
+    uint16_t gid =3D to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
     LoongArchTLB *tlb;
-    tlb_match func;
+    int index;
+
+    if (to_guest && env->guest) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+    to_guest |=3D env->guest;
=20
-    func =3D tlb_match_asid;
-    tlb =3D loongarch_tlb_search_cb(env, addr, asid, func);
+    tlb =3D
+        loongarch_tlb_search_cb(env, addr, asid, tlb_match_asid, to_guest,=
 gid);
     if (tlb) {
-        invalidate_tlb(env, tlb - env->tlb);
+        index =3D to_guest ? (tlb - env->gtlb) : (tlb - env->tlb);
+        invalidate_tlb(env, index, to_guest);
     }
 }
=20
-void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
-                                  target_ulong info, target_ulong addr)
+void helper_invtlb_page_asid_or_g(CPULoongArchState *env, target_ulong inf=
o,
+                                  target_ulong addr, uint32_t to_guest)
 {
-    int asid =3D info & 0x3ff;
+    uint16_t asid =3D info & R_CSR_ASID_ASID_MASK;
+    uint16_t gid =3D to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
     LoongArchTLB *tlb;
-    tlb_match func;
+    int index;
=20
-    func =3D tlb_match_any;
-    tlb =3D loongarch_tlb_search_cb(env, addr, asid, func);
+    if (to_guest && env->guest) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+
+    to_guest |=3D env->guest;
+
+    tlb =3D
+        loongarch_tlb_search_cb(env, addr, asid, tlb_match_any, to_guest, =
gid);
     if (tlb) {
-        invalidate_tlb(env, tlb - env->tlb);
+        index =3D to_guest ? (tlb - env->gtlb) : (tlb - env->tlb);
+        invalidate_tlb(env, index, to_guest);
     }
 }
=20
-static void ptw_update_tlb(CPULoongArchState *env, MMUContext *context)
+static void ptw_update_tlb(CPULoongArchState *env, MMUContext *context,
+                           bool guest)
 {
     int index;
=20
     index =3D context->tlb_index;
     if (index < 0) {
-        index =3D get_tlb_random_index(env, context->addr, context->ps);
+        index =3D get_tlb_random_index(env, context->addr, context->ps, gu=
est);
     }
=20
-    update_tlb_index(env, context, index);
+    update_tlb_index(env, context, index, guest);
 }
=20
-bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                            MMUAccessType access_type, int mmu_idx,
-                            bool probe, uintptr_t retaddr)
+TLBRet loongarch_map_host_address(CPULoongArchState *env, MMUContext *cont=
ext,
+                                  MMUAccessType access_type, uintptr_t ret=
addr)
 {
-    CPULoongArchState *env =3D cpu_env(cs);
-    hwaddr physical;
-    int prot;
-    MMUContext context;
     TLBRet ret;
+    ret =3D loongarch_map_address(env, context, access_type, MMU_KERNEL_ID=
X,
+                                false, false, retaddr);
+    return TLBRET_HOST_MATCH + ret;
+}
=20
-    /* Data access */
-    context.addr =3D address;
-    context.tlb_index =3D -1;
-    ret =3D get_physical_address(env, &context, access_type, mmu_idx, 0);
-    if (ret =3D=3D TLBRET_MATCH && context.mmu_index !=3D MMU_DA_IDX
-        && cpu_has_ptw(env)) {
+static void loongarch_try_ptw(CPULoongArchState *env, MMUContext *context,
+                              MMUAccessType access_type, int mmu_index,
+                              TLBRet *status, bool guest, uintptr_t retadd=
r)
+{
+    if ((*status =3D=3D TLBRET_MATCH || *status =3D=3D TLBRET_HOST_MATCH) =
&&
+        context->mmu_index !=3D MMU_DA_IDX &&
+        context->mmu_index !=3D MMU_GUEST_DA_IDX && cpu_has_ptw(env, guest=
)) {
         bool need_update =3D true;
=20
-        if (access_type =3D=3D MMU_DATA_STORE && pte_dirty(context.pte)) {
+        if (access_type =3D=3D MMU_DATA_STORE && pte_dirty(context->pte)) =
{
             need_update =3D false;
-        } else if (access_type !=3D MMU_DATA_STORE && pte_access(context.p=
te)) {
+        } else if (access_type !=3D MMU_DATA_STORE && pte_access(context->=
pte)) {
             need_update =3D false;
=20
             /*
@@ -649,31 +844,77 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr addre=
ss, int size,
=20
         if (need_update) {
             /* Need update bit A/D in PTE entry, take PTW again */
-            ret =3D TLBRET_NOMATCH;
+            *status =3D
+                (env->guest && !guest) ? TLBRET_HOST_NOMATCH : TLBRET_NOMA=
TCH;
         }
     }
=20
-    if (ret !=3D TLBRET_MATCH && cpu_has_ptw(env)) {
+    if (*status !=3D TLBRET_MATCH && *status !=3D TLBRET_HOST_MATCH &&
+        cpu_has_ptw(env, guest)) {
         /* Take HW PTW if TLB missed or bit P is zero */
-        if (ret =3D=3D TLBRET_NOMATCH || ret =3D=3D TLBRET_INVALID) {
-            ret =3D loongarch_ptw(env, &context, access_type, mmu_idx, 0);
-            if (ret =3D=3D TLBRET_MATCH) {
-                ptw_update_tlb(env, &context);
+        if (*status =3D=3D TLBRET_NOMATCH || *status =3D=3D TLBRET_INVALID=
 ||
+            *status =3D=3D TLBRET_HOST_NOMATCH || *status =3D=3D TLBRET_HO=
ST_INVALID) {
+            *status =3D
+                ((env->guest && !guest) ? TLBRET_HOST_MATCH : TLBRET_MATCH=
) +
+                loongarch_ptw(env, context, access_type, mmu_index, 0, gue=
st,
+                              retaddr);
+            if (*status =3D=3D TLBRET_MATCH || *status =3D=3D TLBRET_HOST_=
MATCH) {
+                ptw_update_tlb(env, context, guest);
             }
-        } else if (context.tlb_index >=3D 0) {
-            invalidate_tlb(env, context.tlb_index);
+        } else if (context->tlb_index >=3D 0) {
+            invalidate_tlb(env, context->tlb_index, guest);
         }
     }
+}
+
+bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                            MMUAccessType access_type, int mmu_idx, bool p=
robe,
+                            uintptr_t retaddr)
+{
+    CPULoongArchState *env =3D cpu_env(cs);
+    MMUContext host_context;
+    hwaddr physical;
+    int prot, host_prot;
+    MMUContext context;
+    TLBRet ret;
+
+    /* Data access */
+    context.addr =3D address;
+    context.tlb_index =3D -1;
+    ret =3D get_physical_address(env, &context, access_type, mmu_idx, 0, r=
etaddr);
+    loongarch_try_ptw(env, &context, access_type, mmu_idx, &ret, env->gues=
t,
+                      retaddr);
=20
     if (ret =3D=3D TLBRET_MATCH) {
         physical =3D context.physical;
         prot =3D context.prot;
+        if (env->guest) {
+            host_context.addr =3D physical;
+            host_context.tlb_index =3D -1;
+            ret =3D loongarch_map_host_address(env, &host_context, access_=
type,
+                                             retaddr);
+            loongarch_try_ptw(env, &host_context, access_type, MMU_KERNEL_=
IDX,
+                              &ret, false, retaddr);
+            if (ret !=3D TLBRET_HOST_MATCH) {
+                if (probe) {
+                    return false;
+                }
+                raise_mmu_exception(env, physical, access_type, ret);
+                cpu_loop_exit_restore(cs, retaddr);
+                return false;
+            }
+            physical =3D host_context.physical;
+            host_prot =3D host_context.prot;
+            prot &=3D host_prot;
+        }
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot,
                      mmu_idx, TARGET_PAGE_SIZE);
         qemu_log_mask(CPU_LOG_MMU,
                       "%s address=3D%" VADDR_PRIx " physical " HWADDR_FMT_=
plx
-                      " prot %d\n", __func__, address, physical, prot);
+                      " prot %d guest %d\n",
+                      __func__, address, physical, prot,
+                      is_guest_mmu_idx(mmu_idx));
         return true;
     } else {
         qemu_log_mask(CPU_LOG_MMU,
@@ -702,6 +943,31 @@ static inline uint64_t loongarch_sanitize_hw_pte(CPULo=
ongArchState *env,
     return (pte & ~ppn_mask) | ((pte & ppn_mask) & palen_mask);
 }
=20
+hwaddr loongarch_get_host_address(CPULoongArchState *env, hwaddr gpa,
+                                  uintptr_t retaddr)
+{
+    MMUContext host_context;
+    TLBRet ret;
+
+    if (!env->guest) {
+        return gpa;
+    }
+
+    host_context.addr =3D gpa;
+    host_context.tlb_index =3D -1;
+    ret =3D
+        loongarch_map_host_address(env, &host_context, MMU_DATA_LOAD, reta=
ddr);
+    loongarch_try_ptw(env, &host_context, MMU_DATA_LOAD, MMU_KERNEL_IDX, &=
ret,
+                      false, retaddr);
+
+    if (ret !=3D TLBRET_HOST_MATCH) {
+        raise_mmu_exception(env, gpa, MMU_DATA_LOAD, ret);
+        cpu_loop_exit_restore(env_cpu(env), retaddr);
+    }
+
+    return host_context.physical;
+}
+
 target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
                           uint32_t level, uint32_t mem_idx)
 {
@@ -732,12 +998,15 @@ target_ulong helper_lddir(CPULoongArchState *env, tar=
get_ulong base,
         }
     }
=20
-    badvaddr =3D env->CSR_TLBRBADV;
+    badvaddr =3D GET_CSR_IF(env->guest, TLBRBADV);
     base =3D base & palen_mask;
-    get_dir_base_width(env, &dir_base, &dir_width, level);
+    get_dir_base_width(env, &dir_base, &dir_width, level, env->guest);
     index =3D (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys =3D base | index << 3;
-    val =3D address_space_ldq_le(cs->as, phys, MEMTXATTRS_UNSPECIFIED, NUL=
L);
+    val =3D address_space_ldq_le(
+        cs->as,
+        (env->guest ? loongarch_get_host_address(env, phys, GETPC()) : phy=
s),
+        MEMTXATTRS_UNSPECIFIED, NULL);
=20
     return val & palen_mask;
 }
@@ -749,8 +1018,10 @@ void helper_ldpte(CPULoongArchState *env, target_ulon=
g base, target_ulong odd,
     hwaddr phys, tmp0, ptindex, ptoffset0, ptoffset1;
     uint64_t pte_raw;
     uint64_t badv;
-    uint64_t ptbase =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
-    uint64_t ptwidth =3D FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
+    uint64_t ptbase =3D
+        FIELD_EX64(GET_CSR_IF(env->guest, PWCL), CSR_PWCL, PTBASE);
+    uint64_t ptwidth =3D
+        FIELD_EX64(GET_CSR_IF(env->guest, PWCL), CSR_PWCL, PTWIDTH);
     uint64_t palen_mask =3D loongarch_palen_mask(env);
     uint64_t dir_base, dir_width;
     uint8_t  ps;
@@ -771,7 +1042,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong=
 base, target_ulong odd,
          * Move HGLOBAL bit to GLOBAL bit.
          */
         get_dir_base_width(env, &dir_base, &dir_width,
-                           FIELD_EX64(base, TLBENTRY, LEVEL));
+                           FIELD_EX64(base, TLBENTRY, LEVEL), env->guest);
=20
         base =3D FIELD_DP64(base, TLBENTRY, LEVEL, 0);
         base =3D FIELD_DP64(base, TLBENTRY, HUGE, 0);
@@ -796,7 +1067,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong=
 base, target_ulong odd,
             return;
         }
     } else {
-        badv =3D env->CSR_TLBRBADV;
+        badv =3D GET_CSR_IF(env->guest, TLBRBADV);
=20
         base =3D base & palen_mask;
=20
@@ -805,26 +1076,31 @@ void helper_ldpte(CPULoongArchState *env, target_ulo=
ng base, target_ulong odd,
         ptoffset0 =3D ptindex << 3;
         ptoffset1 =3D (ptindex + 1) << 3;
         phys =3D base | (odd ? ptoffset1 : ptoffset0);
-        pte_raw =3D address_space_ldq_le(cs->as, phys,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
+        pte_raw =3D address_space_ldq_le(
+            cs->as,
+            (env->guest ? loongarch_get_host_address(env, phys, GETPC()) :
+                          phys),
+            MEMTXATTRS_UNSPECIFIED, NULL);
         tmp0 =3D loongarch_sanitize_hw_pte(env, pte_raw);
         ps =3D ptbase;
     }
=20
     if (odd) {
-        env->CSR_TLBRELO1 =3D tmp0;
+        SET_CSR_IF(env->guest, TLBRELO1, tmp0);
     } else {
-        env->CSR_TLBRELO0 =3D tmp0;
+        SET_CSR_IF(env->guest, TLBRELO0, tmp0);
     }
-    env->CSR_TLBREHI =3D FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, PS, ps)=
;
+    SET_CSR_IF(
+        env->guest, TLBREHI,
+        FIELD_DP64(GET_CSR_IF(env->guest, TLBREHI), CSR_TLBREHI, PS, ps));
 }
=20
 static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
                                       MMUContext *context,
                                       MMUAccessType access_type, int index=
,
-                                      int mmu_idx)
+                                      int mmu_idx, bool guest)
 {
-    LoongArchTLB *tlb =3D &env->tlb[index];
+    LoongArchTLB *tlb =3D guest ? &env->gtlb[index] : &env->tlb[index];
     uint8_t tlb_ps, n;
=20
     tlb_ps =3D FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
@@ -832,19 +1108,20 @@ static TLBRet loongarch_map_tlb_entry(CPULoongArchSt=
ate *env,
     context->pte =3D n ? tlb->tlb_entry1 : tlb->tlb_entry0;
     context->ps =3D tlb_ps;
     context->tlb_index =3D index;
-    return loongarch_check_pte(env, context, access_type, mmu_idx);
+    return loongarch_check_pte(env, context, access_type, mmu_idx, guest);
 }
=20
-TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
-                                   MMUContext *context,
-                                   MMUAccessType access_type, int mmu_idx)
+TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env, MMUContext *con=
text,
+                                   MMUAccessType access_type, int mmu_idx,
+                                   bool guest)
 {
     int index, match;
=20
-    match =3D loongarch_tlb_search(env, context->addr, &index);
+    match =3D
+        loongarch_tlb_search(env, context->addr, &index, guest, get_tgid(e=
nv));
     if (match) {
         return loongarch_map_tlb_entry(env, context, access_type, index,
-                                       mmu_idx);
+                                       mmu_idx, guest);
     }
=20
     return TLBRET_NOMATCH;
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/transl=
ate.c
index 124dce6269..15c83ef72d 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -122,12 +122,16 @@ static void loongarch_tr_init_disas_context(DisasCont=
extBase *dcbase,
     CPULoongArchState *env =3D cpu_env(cs);
     DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
=20
+    ctx->guest_mode =3D (ctx->base.tb->flags & HW_FLAGS_GUEST_MODE) !=3D 0=
;
     ctx->page_start =3D ctx->base.pc_first & TARGET_PAGE_MASK;
     ctx->plv =3D ctx->base.tb->flags & HW_FLAGS_PLV_MASK;
     if (ctx->base.tb->flags & HW_FLAGS_CRMD_PG) {
         ctx->mem_idx =3D ctx->plv;
+        if (ctx->guest_mode) {
+            ctx->mem_idx +=3D MMU_GUEST_IDX;
+        }
     } else {
-        ctx->mem_idx =3D MMU_DA_IDX;
+        ctx->mem_idx =3D ctx->guest_mode ? MMU_GUEST_DA_IDX : MMU_DA_IDX;
     }
=20
     /* Bound the number of insns to execute to those left on the page.  */
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 8aa8325dc6..db0650e713 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -26,6 +26,7 @@
 #define avail_FP_DP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
 #define avail_LSPW(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
 #define avail_LAM(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
+#define avail_LVZ(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LVZ))
 #define avail_LAM_BH(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM_BH))
 #define avail_LAMCAS(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAMCAS))
 #define avail_LSX(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
@@ -66,6 +67,7 @@ typedef struct DisasContext {
     TCGv zero;
     bool la64; /* LoongArch64 mode */
     bool va32; /* 32-bit virtual address */
+    bool guest_mode;
     uint32_t cpucfg1;
     uint32_t cpucfg2;
     uint32_t cpucfg3;
--=20
2.52.0

