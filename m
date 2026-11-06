Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8413F606A32C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=univ-grenoble-alpes.fr header.i=@univ-grenoble-alpes.fr header.a=rsa-sha256 header.s=2020 header.b=WY/5WYl8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPMf0-0007V6-BH; Fri, 06 Nov 2026 11:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xPMeZ-0007EL-P3; Fri, 06 Nov 2026 11:18:59 -0500
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xPMeW-0004Dq-NQ; Fri, 06 Nov 2026 11:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1793981932;
 bh=SE3m8IlGg5jkVt+rBzd5npOuos8UeaRGV3wS+Ry2TMQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WY/5WYl8I/X8Q4oau4ASGxausJP9/SYNYXO+1soJXPHJDJqpqW3vi/rswTrM2+how
 LwgHpG3a8YhLu5ulSdhsAa9PQvZPpJnPfbaOG2/jgkwSbRZ08ShxfgBV/z0CxPRl2E
 SahnECZUx9XrTOpFXrsVC8+grICfIKgG1BMWr2FnYcJup7pSgHAAS+b69z60wRAyWs
 JBNdAtVZW2vkvwAfIrWSjfEitZwpb32e6jXqN2Dn1XyDc3CHalWjGuFZBFPzgDEib5
 l+GJwDKxGdg4hGBjI8Xd43Ux5oXKf/Cf+WaRrbY42FAv0A533a5/BUCpkC8ocxwKj+
 O9j0yIz2WYcGg==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id F3AE34029B;
 Fri,  6 Nov 2026 17:18:51 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id EF589FF855;
 Fri,  6 Nov 2026 17:18:51 +0100 (CET)
Received: from naga.tima.u-ga.fr (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id B5E8E40056;
 Fri, 06 Nov 2026 17:18:51 +0100 (CET)
From: frederic.petrot@univ-grenoble-alpes.fr
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v3 2/4] target/riscv: fix riscv_cpu_do_interrupt sanitize
 error for x-rv128
Date: Fri,  6 Nov 2026 17:18:41 +0100
Message-ID: <20261106161843.2075117-3-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106161843.2075117-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20261106161843.2075117-1-frederic.petrot@univ-grenoble-alpes.fr>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 target/riscv/cpu.c            |  1 +
 target/riscv/cpu.h            |  4 ++
 target/riscv/tcg/cpu_helper.c | 20 +++++++--
 target/riscv/tcg/csr.c        | 79 +++++++++++++++++++++++++++++++----
 4 files changed, 93 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 362e561809..d473c94e21 100644
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


