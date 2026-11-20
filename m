Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B21606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univ-grenoble-alpes.fr header.i=@univ-grenoble-alpes.fr header.a=rsa-sha256 header.s=2020 header.b=oQ5yURNO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUNiY-0007QW-CK; Fri, 20 Nov 2026 07:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xUNiW-0007PA-7b; Fri, 20 Nov 2026 07:27:48 -0500
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xUNiT-0001sr-Pn; Fri, 20 Nov 2026 07:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1795177663;
 bh=JVtaRwl/JnoGFEJiYpnWZOcM95itPku7oGfUkJR9Tco=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oQ5yURNOTFlsB9f5lv5kYCD3myvuP5REtByckjSp/wEFDzASFW/x8SQdBpVCRhCZw
 aEOVc4RiaxKj5xIkD+C3kR7Z0bg43sJYGp/KEZ24Ac/9pf/sIjdCsiVdfWkIMu0KDB
 0Wff2SZ3Jhh0AwcZLb/39MPIKcQOj2iSwsY0ir4OciqVN3aN1zI5abuEqiV2gA0ry1
 qydMn+SHLV4AUDkbdhU+8cSs7LcMad2v0BBzDCMrc2Ttgv14YPhEPXQbPEEx7E3hs4
 2Wl41Hy4CSH2/JJfw42In/xx0rv2d4BLFUJ+eALAQUXkEiR4wfqf382a7amT+PTPof
 h6okIKbKifCow==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 85A69402A8;
 Fri, 20 Nov 2026 13:27:43 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id 81B22FF853;
 Fri, 20 Nov 2026 13:27:43 +0100 (CET)
Received: from naga.tima.u-ga.fr (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 5444414009A;
 Fri, 20 Nov 2026 13:27:43 +0100 (CET)
From: frederic.petrot@univ-grenoble-alpes.fr
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, peter.maydell@linaro.org,
 daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v5 2/4] target/riscv: fix riscv_cpu_do_interrupt sanitize
 error for x-rv128
Date: Fri, 20 Nov 2026 13:27:39 +0100
Message-ID: <20261120122741.33727-3-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120122741.33727-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20261120122741.33727-1-frederic.petrot@univ-grenoble-alpes.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

UndefinedBehaviorSanitizer reports an undefined behavior when setting
the Interrupt flag (msb) in the [ms]cause registers due to an out of
bounds shift.

To prevent this, we introduce fields to hold the interrupt flag in
all "versions" of the cause register and build the expected
values on the fly by oring it with the proper cause.
Handling of vscause assumes it has the same xlen than cause.

Fixes: 58597bfeab45 ("target/riscv: Correct mcause/scause bit width for RV32 in RV64 QEMU")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 target/riscv/cpu.c            |  1 +
 target/riscv/cpu.h            |  4 ++
 target/riscv/tcg/cpu_helper.c | 20 +++++++--
 target/riscv/tcg/csr.c        | 79 +++++++++++++++++++++++++++++++----
 4 files changed, 93 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 15c27f4ce4..3e2f739c4e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1021,6 +1021,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->mstatus = set_field(env->mstatus, MSTATUS_SBE, cpu->cfg.big_endian);
     env->mstatus = set_field(env->mstatus, MSTATUS_UBE, cpu->cfg.big_endian);
     env->mcause = 0;
+    env->mcause_int = 0;
     env->miclaim = MIP_SGEIP;
     env->pc = env->resetvec;
     env->bins = 0;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 49a1186bdb..e7fe1102c3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -354,10 +354,12 @@ struct CPUArchState {
     uint64_t stvec;
     uint64_t sepc;
     uint64_t scause;
+    uint64_t scause_int;
 
     uint64_t mtvec;
     uint64_t mepc;
     uint64_t mcause;
+    uint64_t mcause_int;
     uint64_t mtval;  /* since: priv-1.10.0 */
 
     uint64_t mctrctl;
@@ -417,6 +419,7 @@ struct CPUArchState {
     uint64_t vsscratch;
     uint64_t vsepc;
     uint64_t vscause;
+    uint64_t vscause_int;
     uint64_t vstval;
     uint64_t vsatp;
 
@@ -431,6 +434,7 @@ struct CPUArchState {
     uint64_t sscratch_hs;
     uint64_t sepc_hs;
     uint64_t scause_hs;
+    uint64_t scause_int_hs;
     uint64_t stval_hs;
     uint64_t satp_hs;
     uint64_t mstatus_hs;
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 58e98e975c..a3ba7e9c42 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -585,7 +585,9 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
         env->sepc = env->sepc_hs;
 
         env->vscause = env->scause;
+        env->vscause_int = env->scause_int;
         env->scause = env->scause_hs;
+        env->scause_int = env->scause_int_hs;
 
         env->vstval = env->stval;
         env->stval = env->stval_hs;
@@ -608,7 +610,9 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
         env->sepc = env->vsepc;
 
         env->scause_hs = env->scause;
+        env->scause_int_hs = env->scause_int;
         env->scause = env->vscause;
+        env->scause_int = env->vscause_int;
 
         env->stval_hs = env->stval;
         env->stval = env->vstval;
@@ -2375,7 +2379,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         }
         env->mstatus = s;
         sxlen = 16 << riscv_cpu_sxl(env);
-        env->scause = cause | ((target_ulong)async << (sxlen - 1));
+        env->scause = cause;
+        if (riscv_cpu_sxl(env) != MXL_RV128) {
+            env->scause_int = (target_ulong)async << (sxlen - 1);
+        } else {
+            env->scause_int = (target_ulong)async << 63;
+        }
         env->sepc = env->pc;
         env->stval = tval;
         env->htval = htval;
@@ -2447,9 +2456,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             s = set_field(s, MSTATUS_MDT, 1);
         }
         env->mstatus = s;
-        env->mcause = cause | ((target_ulong)async << (mxlen - 1));
+        env->mcause = cause;
+        if (riscv_cpu_mxl(env) != MXL_RV128) {
+            env->mcause_int = (target_ulong)async << (mxlen - 1);
+        } else {
+            env->mcause_int = (target_ulong)async << 63;
+        }
         if (smode_double_trap) {
-            env->mtval2 = env->mcause;
+            env->mtval2 = env->mcause_int | env->mcause;
             env->mcause = RISCV_EXCP_DOUBLE_TRAP;
         } else {
             env->mtval2 = mtval2;
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index c3ef16cf1a..9549f5e6c5 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3234,14 +3234,37 @@ static RISCVException write_mepc(CPURISCVState *env, int csrno,
 static RISCVException read_mcause(CPURISCVState *env, int csrno,
                                   target_ulong *val)
 {
-    *val = env->mcause;
+    *val = env->mcause_int | env->mcause;
     return RISCV_EXCP_NONE;
 }
 
+static uint64_t cause_int_mask(RISCVMXL xl)
+{
+    g_assert(xl != MXL_RV128);
+    return 1ULL << ((16 << xl) - 1);
+}
+
 static RISCVException write_mcause(CPURISCVState *env, int csrno,
                                    target_ulong val, uintptr_t ra)
 {
-    env->mcause = val;
+    env->mcause = val & (cause_int_mask(riscv_cpu_xlen(env)) - 1);
+    env->mcause_int = val & cause_int_mask(riscv_cpu_xlen(env));
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mcause_i128(CPURISCVState *env, int csrno,
+                                       Int128 *val)
+{
+    *val = int128_make128(env->mcause, env->mcause_int);
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mcause_i128(CPURISCVState *env, int csrno,
+                                        Int128 val)
+{
+    env->mcause = int128_getlo(val);
+    env->mcause_int = int128_gethi(val);
     return RISCV_EXCP_NONE;
 }
 
@@ -4494,14 +4517,31 @@ static RISCVException write_sepc(CPURISCVState *env, int csrno,
 static RISCVException read_scause(CPURISCVState *env, int csrno,
                                   target_ulong *val)
 {
-    *val = env->scause;
+    *val = env->scause_int | env->scause;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_scause(CPURISCVState *env, int csrno,
                                    target_ulong val, uintptr_t ra)
 {
-    env->scause = val;
+    env->scause = val & (cause_int_mask(riscv_cpu_sxl(env)) - 1);
+    env->scause_int = val & cause_int_mask(riscv_cpu_sxl(env));
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_scause_i128(CPURISCVState *env, int csrno,
+                                       Int128 *val)
+{
+    *val = int128_make128(env->scause, env->scause_int);
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_scause_i128(CPURISCVState *env, int csrno,
+                                        Int128 val)
+{
+    env->scause = int128_getlo(val);
+    env->scause_int = int128_gethi(val);
     return RISCV_EXCP_NONE;
 }
 
@@ -5532,14 +5572,16 @@ static RISCVException write_vsepc(CPURISCVState *env, int csrno,
 static RISCVException read_vscause(CPURISCVState *env, int csrno,
                                    target_ulong *val)
 {
-    *val = env->vscause;
+    *val = env->vscause_int | env->vscause;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_vscause(CPURISCVState *env, int csrno,
                                     target_ulong val, uintptr_t ra)
 {
-    env->vscause = val;
+    /* Assumes vxlen == sxlen */
+    env->vscause = val & (cause_int_mask(riscv_cpu_sxl(env)) - 1);
+    env->vscause_int = val & cause_int_mask(riscv_cpu_sxl(env));
     return RISCV_EXCP_NONE;
 }
 
@@ -5632,6 +5674,24 @@ static RISCVException write_pmpcfg(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_pmpcfg_i128(CPURISCVState *env, int csrno,
+                                       Int128 *val)
+{
+    uint32_t reg_index = csrno - CSR_PMPCFG0;
+
+    *val = pmpcfg_csr_read_i128(env, reg_index);
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_pmpcfg_i128(CPURISCVState *env, int csrno,
+                                        Int128 val)
+{
+    uint32_t reg_index = csrno - CSR_PMPCFG0;
+
+    pmpcfg_csr_write_i128(env, reg_index, val);
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_pmpaddr(CPURISCVState *env, int csrno,
                                    target_ulong *val)
 {
@@ -6227,7 +6287,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MSCRATCH] = { "mscratch", any,  read_mscratch, write_mscratch,
                        NULL, read_mscratch_i128, write_mscratch_i128   },
     [CSR_MEPC]     = { "mepc",     any,  read_mepc,     write_mepc     },
-    [CSR_MCAUSE]   = { "mcause",   any,  read_mcause,   write_mcause   },
+    [CSR_MCAUSE]   = { "mcause",   any,  read_mcause,   write_mcause,
+                        NULL, read_mcause_i128, write_mcause_i128      },
     [CSR_MTVAL]    = { "mtval",    any,  read_mtval,    write_mtval    },
     [CSR_MIP]      = { "mip",      any,  NULL,    NULL, rmw_mip        },
 
@@ -6362,7 +6423,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SSCRATCH] = { "sscratch", smode, read_sscratch, write_sscratch,
                        NULL, read_sscratch_i128, write_sscratch_i128    },
     [CSR_SEPC]     = { "sepc",     smode, read_sepc,     write_sepc     },
-    [CSR_SCAUSE]   = { "scause",   smode, read_scause,   write_scause   },
+    [CSR_SCAUSE]   = { "scause",   smode, read_scause,   write_scause,
+                       NULL, read_scause_i128, write_scause_i128        },
+
     [CSR_STVAL]    = { "stval",    smode, read_stval,    write_stval    },
     [CSR_SIP]      = { "sip",      smode, NULL,    NULL, rmw_sip        },
     [CSR_STIMECMP] = { "stimecmp", sstc, read_stimecmp, write_stimecmp,
-- 
2.43.0


