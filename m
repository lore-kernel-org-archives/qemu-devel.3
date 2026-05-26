Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F36DCD5BC9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 02:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRhr0-0002lX-DE; Mon, 25 May 2026 22:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRhqy-0002ky-Iq
 for qemu-devel@nongnu.org; Mon, 25 May 2026 22:49:12 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRhqw-0004AY-AA
 for qemu-devel@nongnu.org; Mon, 25 May 2026 22:49:12 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-304545f5206so4802514eec.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 19:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779763748; x=1780368548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PPBJDCY+ArxL4xLA9Bd1nlIF3CCQEZENICaMrFhcXeU=;
 b=qTr3ED9xjdatJtEYmstTOfLXiWIxSo6UxWEMq5NVAa0/HlCN8v3NH2F+giPohXHLjp
 FXAPfQQUrD7y0YoBQVgp54AvKmKk1N6NdOENatDz6HGJkXuRVPihuYtOQSW+IIXGDPOK
 HigtWYbg1Gc52DxHv3+/Or3wY8ZEpeqUZvPBGVCgxtBh2qxwdGprIALALDq7ddl5+OHc
 FNq0c1qaxB2ApROcYNWGDMGVoIBk8sTuDNcOU98jedtWqMKvJ6wNNoZlcHy0TnzIF9Qf
 maWdOXn0rYG8RW11AtGcOe2icZvzqibK40Prx+gywLFiQAkIB47kyvVj5fOFHy96+/d+
 HyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779763748; x=1780368548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPBJDCY+ArxL4xLA9Bd1nlIF3CCQEZENICaMrFhcXeU=;
 b=DZ9OodkI7Z/h7kx92d5imYYh2yjq58IMYoqLDyoWQcqPPVHlACC27833uaVg/muSta
 l95wk5L+qLFcFivqTyFjGPK7ks3fiMpeTLDBqJ4XSHw9mDt7LXoLiRFDOTUZdBi8obJn
 X9HGVfGgAz3qlRi3Y0RB+YihZskZIlN4nh5DEnbiev/gnKKOIgBiEI2RBL+USmyREpgH
 3PLOjyUvdxbOn9lD9BKF1OM2jYLKGV19LTQSzk3X2VG1ldjWgZQpIkKY8lEAjpDtVQ0R
 GXA9yLppSuNjBvk77VX/zkJXR3BuBpISMRpkvcc4L8M/33kPqET0Fw4EZeNUOH3Ye3Kq
 Ji8A==
X-Gm-Message-State: AOJu0YwvCeM6Q0w5HPjIIpFma52ke5PQZ4FLzK4NTiaNQkixjkn0a0GK
 LeObnpn5nz7CaOvsZ+bdy5nMaWbwF6HRhTdG7YN8Ih3FQnomsJDrljKN1BiyknGmLoOzqw==
X-Gm-Gg: Acq92OEWFu9eCSjuFb9DAaahxJnabgYS4N+mFpg3L+5a3cu07NIvyweQ2ncTUjjjwyR
 aneeyrEzDoA/iYpQ94b4nKDlKPnQkd8ms6pTHRH3JO9MOgKxDD1ud6ILp5FOEb6IAzKCssP4XCo
 EM0tegoEct89SI8OCaZJls22GOJv6NfulPEnnnVYijBDcmJl8yCpj3URIuEbQJmge/8qbGIQGja
 IDOnnnVkziyQ9hk/I9UbwnBKQFDZPZ51stz7pTnxncssQaqn8tWtJAWWPJ+sYLdGNE3yHAYBrOr
 SMBhaM11DSv7z4vLfZBkwa8XvMQEkoLBBUI4zMN3hLHphPQzcRSAZzhTni3TGdIDeuVJ/kRGpd3
 EgctF5K/L5pcLokdMTI2xG02t1wIngsI00K3xTlkZoqMDAR5g1aFZ3cER+MMQ9S3hwmbjgoA1e4
 5dnyrmifM/UR/fxEjhqqxtgymHJYbLJ7hnAcAS0V5mQU81dsiqhQptDw6Y9pk20HOYbj1opyLPU
 HJ5ikfIK8Q=
X-Received: by 2002:a05:7300:8607:b0:2ed:935:aa33 with SMTP id
 5a478bee46e88-30448fd64b5mr9029033eec.5.1779763747854; 
 Mon, 25 May 2026 19:49:07 -0700 (PDT)
Received: from openkylin.. (ec2-3-101-81-203.us-west-1.compute.amazonaws.com.
 [3.101.81.203]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045245fbeesm9501357eec.30.2026.05.25.19.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 19:49:07 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, daniel.barboza@oss.qualcomm.com
Subject: [PATCH] target/riscv: Fix no-TCG build
Date: Tue, 26 May 2026 10:48:51 +0800
Message-ID: <20260526024851.2014325-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Building riscv64-softmmu with --disable-tcg currently fails because
RISC-V still builds or references TCG-only sources and helpers in the
no-TCG configuration.

Move TCG-only helper and translator sources under CONFIG_TCG, guard the
remaining TCG-only code in common files, and move common CSR helpers out
of TCG-only helper files.

misa writes still rely on the TCG extension validation path. Since
x-misa-w is a TCG-only experimental property, reject it during CPU
realize when TCG is not available.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3483

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
Testing:
- riscv64-softmmu --enable-kvm --disable-tcg --enable-debug builds
  successfully.
- riscv64-softmmu --enable-debug builds successfully.
- qemu-system-riscv64 -M virt,accel=qtest -cpu rv64,x-misa-w=true \
      -S -nographic reports "x-misa-w requires TCG".

 target/riscv/cpu.c        |  9 +++++++
 target/riscv/cpu_helper.c | 53 +++++++++++++++++++++++++++++++++++++++
 target/riscv/csr.c        | 18 +++++++++++--
 target/riscv/fpu_helper.c | 27 --------------------
 target/riscv/meson.build  |  9 ++++---
 target/riscv/op_helper.c  | 15 -----------
 6 files changed, 84 insertions(+), 47 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 862834b480..3f4563fce2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -36,7 +36,9 @@
 #include "system/tcg.h"
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
+#ifdef CONFIG_TCG
 #include "tcg/tcg.h"
+#endif
 
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
@@ -956,6 +958,13 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+#ifndef CONFIG_TCG
+    if (cpu->cfg.misa_w) {
+        error_setg(errp, "x-misa-w requires TCG");
+        return;
+    }
+#endif
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 17305e1bb7..e53a5d567d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
+#include "fpu/softfloat.h"
 #include "internals.h"
 #include "pmu.h"
 #include "exec/cputlb.h"
@@ -28,8 +29,10 @@
 #include "exec/target_page.h"
 #include "system/memory.h"
 #include "instmap.h"
+#ifdef CONFIG_TCG
 #include "tcg/tcg-op.h"
 #include "accel/tcg/cpu-ops.h"
+#endif
 #include "trace.h"
 #include "semihosting/common-semi.h"
 #include "exec/icount.h"
@@ -38,6 +41,52 @@
 #include "pmp.h"
 #include "qemu/plugin.h"
 
+/* Exceptions processing helpers */
+G_NORETURN void riscv_raise_exception(CPURISCVState *env,
+                                      RISCVException exception,
+                                      uintptr_t pc)
+{
+    CPUState *cs = env_cpu(env);
+
+    trace_riscv_exception(exception,
+                          riscv_cpu_get_trap_name(exception, false),
+                          env->pc);
+
+    cs->exception_index = exception;
+#ifdef CONFIG_TCG
+    cpu_loop_exit_restore(cs, pc);
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
+{
+    int soft = get_float_exception_flags(&env->fp_status);
+    target_ulong hard = 0;
+
+    hard |= (soft & float_flag_inexact) ? FPEXC_NX : 0;
+    hard |= (soft & float_flag_underflow) ? FPEXC_UF : 0;
+    hard |= (soft & float_flag_overflow) ? FPEXC_OF : 0;
+    hard |= (soft & float_flag_divbyzero) ? FPEXC_DZ : 0;
+    hard |= (soft & float_flag_invalid) ? FPEXC_NV : 0;
+
+    return hard;
+}
+
+void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
+{
+    int soft = 0;
+
+    soft |= (hard & FPEXC_NX) ? float_flag_inexact : 0;
+    soft |= (hard & FPEXC_UF) ? float_flag_underflow : 0;
+    soft |= (hard & FPEXC_OF) ? float_flag_overflow : 0;
+    soft |= (hard & FPEXC_DZ) ? float_flag_divbyzero : 0;
+    soft |= (hard & FPEXC_NV) ? float_flag_invalid : 0;
+
+    set_float_exception_flags(soft, &env->fp_status);
+}
+
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
@@ -1667,6 +1716,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     return TRANSLATE_SUCCESS;
 }
 
+#ifdef CONFIG_TCG
 static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
                                 MMUAccessType access_type, bool pmp_violation,
                                 bool first_stage, bool two_stage,
@@ -1709,6 +1759,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
     env->two_stage_lookup = two_stage;
     env->two_stage_indirect_lookup = two_stage_indirect;
 }
+#endif
 
 hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
@@ -1733,6 +1784,7 @@ hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
     return phys_addr;
 }
 
+#ifdef CONFIG_TCG
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
                                      MMUAccessType access_type,
@@ -1957,6 +2009,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
     return true;
 }
+#endif
 
 static target_ulong riscv_transformed_insn(CPURISCVState *env,
                                            target_ulong insn,
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5514e0f455..04fa320ff8 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2135,21 +2135,31 @@ static RISCVException read_misa(CPURISCVState *env, int csrno,
 
 static target_ulong get_next_pc(CPURISCVState *env, uintptr_t ra)
 {
+    /* Outside of a running cpu, env contains the next pc. */
+    if (ra == 0) {
+        return env->pc;
+    }
+
+#ifdef CONFIG_TCG
     uint64_t data[INSN_START_WORDS];
 
-    /* Outside of a running cpu, env contains the next pc. */
-    if (ra == 0 || !cpu_unwind_state_data(env_cpu(env), ra, data)) {
+    if (!cpu_unwind_state_data(env_cpu(env), ra, data)) {
         return env->pc;
     }
 
     /* Within unwind data, [0] is pc and [1] is the opcode. */
     return data[0] + insn_len(data[1]);
+#else
+    qemu_build_not_reached();
+#endif
 }
 
 static RISCVException write_misa(CPURISCVState *env, int csrno,
                                  target_ulong val, uintptr_t ra)
 {
+#ifdef CONFIG_TCG
     RISCVCPU *cpu = env_archcpu(env);
+#endif
     uint32_t orig_misa_ext = env->misa_ext;
     Error *local_err = NULL;
 
@@ -2178,7 +2188,11 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
     }
 
     env->misa_ext = val;
+#ifdef CONFIG_TCG
     riscv_cpu_validate_set_extensions(cpu, &local_err);
+#else
+    qemu_build_not_reached();
+#endif
     if (local_err != NULL) {
         /* Rollback on validation error */
         qemu_log_mask(LOG_GUEST_ERROR, "Unable to write MISA ext value "
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index af40561b31..eec6328281 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -23,33 +23,6 @@
 #include "fpu/softfloat.h"
 #include "internals.h"
 
-target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
-{
-    int soft = get_float_exception_flags(&env->fp_status);
-    target_ulong hard = 0;
-
-    hard |= (soft & float_flag_inexact) ? FPEXC_NX : 0;
-    hard |= (soft & float_flag_underflow) ? FPEXC_UF : 0;
-    hard |= (soft & float_flag_overflow) ? FPEXC_OF : 0;
-    hard |= (soft & float_flag_divbyzero) ? FPEXC_DZ : 0;
-    hard |= (soft & float_flag_invalid) ? FPEXC_NV : 0;
-
-    return hard;
-}
-
-void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
-{
-    int soft = 0;
-
-    soft |= (hard & FPEXC_NX) ? float_flag_inexact : 0;
-    soft |= (hard & FPEXC_UF) ? float_flag_underflow : 0;
-    soft |= (hard & FPEXC_OF) ? float_flag_overflow : 0;
-    soft |= (hard & FPEXC_DZ) ? float_flag_divbyzero : 0;
-    soft |= (hard & FPEXC_NV) ? float_flag_invalid : 0;
-
-    set_float_exception_flags(soft, &env->fp_status);
-}
-
 void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
 {
     int softrm;
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 79f36abd63..c2b2f61ad9 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -9,7 +9,7 @@ gen = [
 ]
 
 riscv_ss = ss.source_set()
-riscv_ss.add(gen)
+riscv_ss.add(when: 'CONFIG_TCG', if_true: gen)
 
 riscv_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		     if_true: files('common-semi-target.c'))
@@ -18,11 +18,14 @@ riscv_ss.add(files(
   'cpu.c',
   'cpu_helper.c',
   'csr.c',
-  'fpu_helper.c',
   'gdbstub.c',
+  'vector_internals.c',
+))
+
+riscv_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'fpu_helper.c',
   'op_helper.c',
   'vector_helper.c',
-  'vector_internals.c',
   'bitmanip_helper.c',
   'translate.c',
   'm128_helper.c',
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 81873014cb..d17a8bbf10 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -28,21 +28,6 @@
 #include "exec/tlb-flags.h"
 #include "trace.h"
 
-/* Exceptions processing helpers */
-G_NORETURN void riscv_raise_exception(CPURISCVState *env,
-                                      RISCVException exception,
-                                      uintptr_t pc)
-{
-    CPUState *cs = env_cpu(env);
-
-    trace_riscv_exception(exception,
-                          riscv_cpu_get_trap_name(exception, false),
-                          env->pc);
-
-    cs->exception_index = exception;
-    cpu_loop_exit_restore(cs, pc);
-}
-
 void helper_raise_exception(CPURISCVState *env, uint32_t exception)
 {
     riscv_raise_exception(env, exception, 0);
-- 
2.43.0


