Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC2EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 19:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seJk0-0004Lf-4X; Wed, 14 Aug 2024 15:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1seJjr-0004KN-BZ
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 15:32:56 -0400
Received: from secure.fsr.com ([64.126.132.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1seJjo-0003I8-Mc
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 15:32:55 -0400
Received: from [192.168.254.26] (syn-098-146-201-045.res.spectrum.com
 [98.146.201.45]) (Authenticated sender: chauser)
 by secure.fsr.com (Postfix) with ESMTPSA id AF094BB8C6;
 Wed, 14 Aug 2024 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pullman.com;
 s=mail1; t=1723663966;
 bh=X5Lg3HEpwGX+11t9r/yK48e7mPC0jLoUArguwjZFR3c=;
 h=Date:Subject:To:From;
 b=HNOGkwOQsMnWRukkyns/kwll8zn3rmAl2rOuicEXC7QA7nyyWY3lHlloUkvBAP89/
 KjwFLJDRQ+6jbXgmySL1omT8a6bc/E5b7+rZuqxNCOprsU76LcqF6eOicOipowSfR/
 zkk39ObvOM5BpnhhWmsHTuaY6sLUg2OXhLhfdKjA=
Message-ID: <54595d87-fc23-45a0-8dde-a7e43359304a@pullman.com>
Date: Wed, 14 Aug 2024 12:32:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] target/sparc: emulate floating point queue when raising fp
 traps
To: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel@nongnu.org, Carl Hauser <carl.hauser@gmail.com>
References: <cde53d38-c378-459f-9e2a-6e9ca287cc3c@pullman.com>
 <db9a23a4-3423-4c55-8c6d-0507f93d3c50@linaro.org>
Content-Language: en-GB
From: Carl Hauser <chauser@pullman.com>
In-Reply-To: <db9a23a4-3423-4c55-8c6d-0507f93d3c50@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=64.126.132.23; envelope-from=chauser@pullman.com;
 helo=secure.fsr.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


 From 9265233081fae546c0459792598a9f1688ddb020 Mon Sep 17 00:00:00 2001
From: Carl Hauser <chauser@pullman.com>
Date: Sat, 10 Aug 2024 15:09:39 -0700
Subject: [PATCH v2] target/sparc: emulate floating point queue when 
raising fp
  traps

Sparc 32-bit machines perform floating point operations in an
asynchronous co-processor. When a FP operation traps for any reason
the entire set of pending operations is dumped to memory as
the "floating point queue" and then processed by kernel trap
handling. SunOS and at least early Solaris 2 releases only
handle traps correctly if they can find the faulting operation
at the head of the floating point queue. Qemu did not previously
implement FP queue handling. This commit adds: additional fields
to the processor state to contain a single-element FP queue;
logic in trap handling to populate the FP queue when a FP
trap occurs; and implementation of the STDFQ instruction that
the kernel uses to extract a FP queue element from the processor
state to memory.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2340
Signed-off-by: Carl Hauser <chauser@pullman.com>
---
Addressed comments about unrelated blank line insertions, and
unneeded #ifdefs. Put lines in insns.c back to original order,
but now with comments and arg specifier for STDFQ.

As for testing unimplemented operations on linux and NetBSD,
my problem is that I can't get gcc to generate quad-precision
code on them at all. Both gcc's generate the same code for long double
that they generate for double. And neither accepts _Float_128 as
a valid type. While I have reasonable confidence that the
implementation of unimplemented operations will work in the
qemu, I don't know if these kernels actually have the necessary
code to emulate the instructions. Of course, if the compilers
have never generated the instructions it's unlikely that there
are any programs out there using them.

  target/sparc/cpu.h          |  8 ++++++++
  target/sparc/fop_helper.c   | 17 ++++++++++++++++-
  target/sparc/helper.h       |  4 ++++
  target/sparc/insns.decode   |  4 ++--
  target/sparc/int32_helper.c | 13 +++++++++++++
  target/sparc/translate.c    | 14 ++++++++++----
  6 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index dfd9512a21..ff48279a55 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -184,6 +184,8 @@ enum {
  #define FSR_FTT_SEQ_ERROR (4ULL << 14)
  #define FSR_FTT_INVAL_FPR (6ULL << 14)

+#define FSR_QNE    (1ULL << 13)
+
  #define FSR_FCC0_SHIFT    10
  #define FSR_FCC1_SHIFT    32
  #define FSR_FCC2_SHIFT    34
@@ -436,6 +438,12 @@ struct CPUArchState {
      /* FPU State Register, in parts */
      uint32_t fsr;                    /* rm, tem, aexc */
      uint32_t fsr_cexc_ftt;           /* cexc, ftt */
+
+    /* single-element FPU fault queue */
+    uint32_t fsr_qne;                /* qne */
+    uint32_t fsr_qi;                 /* faulting fp instruction */
+    target_ulong fsr_qa;             /* address of faulting instruction */
+
      uint32_t fcc[TARGET_FCCREGS];    /* fcc* */

      CPU_DoubleU fpr[TARGET_DPREGS];  /* floating point registers */
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 0b30665b51..0f74ca7908 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -21,6 +21,7 @@
  #include "cpu.h"
  #include "exec/exec-all.h"
  #include "exec/helper-proto.h"
+#include "exec/cpu_ldst.h"
  #include "fpu/softfloat.h"

  static inline float128 f128_in(Int128 i)
@@ -538,7 +539,7 @@ uint32_t helper_flcmpd(float64 src1, float64 src2)

  target_ulong cpu_get_fsr(CPUSPARCState *env)
  {
-    target_ulong fsr = env->fsr | env->fsr_cexc_ftt;
+    target_ulong fsr = env->fsr | env->fsr_cexc_ftt | env->fsr_qne;

      fsr |= env->fcc[0] << FSR_FCC0_SHIFT;
  #ifdef TARGET_SPARC64
@@ -563,6 +564,7 @@ static void set_fsr_nonsplit(CPUSPARCState *env, 
target_ulong fsr)
      int rnd_mode;

      env->fsr = fsr & (FSR_RD_MASK | FSR_TEM_MASK | FSR_AEXC_MASK);
+    env->fsr_qne = fsr & FSR_QNE;

      switch (fsr & FSR_RD_MASK) {
      case FSR_RD_NEAREST:
@@ -608,3 +610,16 @@ void helper_set_fsr_nofcc(CPUSPARCState *env, 
uint32_t fsr)
      env->fsr_cexc_ftt = fsr & (FSR_CEXC_MASK | FSR_FTT_MASK);
      set_fsr_nonsplit(env, fsr);
  }
+
+#ifndef TARGET_SPARC64
+void helper_store_fp_queue(CPUSPARCState *env, uint32_t addr)
+{
+    if (!env->fsr_qne) {
+        env->fsr_cexc_ftt = FSR_FTT_SEQ_ERROR;
+        cpu_raise_exception_ra(env, TT_FP_EXCP, GETPC());
+    }
+    cpu_stl_be_data(env, addr, env->fsr_qa);
+    cpu_stl_be_data(env, addr + 4, env->fsr_qi);
+    env->fsr_qne = 0;
+}
+#endif
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 134e519a37..15ae94d0f3 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -85,6 +85,10 @@ DEF_HELPER_FLAGS_2(fitoq, TCG_CALL_NO_WG, i128, env, s32)

  DEF_HELPER_FLAGS_2(fitos, TCG_CALL_NO_WG, f32, env, s32)

+#ifndef TARGET_SPARC64
+DEF_HELPER_2(store_fp_queue, void, env, i32)
+#endif
+
  #ifdef TARGET_SPARC64
  DEF_HELPER_FLAGS_2(fxtos, TCG_CALL_NO_WG, f32, env, s64)
  DEF_HELPER_FLAGS_2(fxtod, TCG_CALL_NO_WG, f64, env, s64)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index fbcb4f7aef..cc59dcf8d9 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -644,8 +644,8 @@ STF         11 ..... 100100 ..... . ............. 
    @r_r_ri_na
  STFSR       11 00000 100101 ..... . .............          @n_r_ri
  STXFSR      11 00001 100101 ..... . .............          @n_r_ri
  {
-  STQF      11 ..... 100110 ..... . .............          @q_r_ri_na
-  STDFQ     11 ----- 100110 ----- - -------------
+  STQF      11 ..... 100110 ..... . .............          @q_r_ri_na 
## SPARC-V9
+  STDFQ     11 ..... 100110 ..... . .............          @r_r_r_asi 
## SPARC-V7-8
  }
  STDF        11 ..... 100111 ..... . .............          @d_r_ri_na

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 6b7d65b031..f18cd97059 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -22,6 +22,7 @@
  #include "cpu.h"
  #include "trace.h"
  #include "exec/log.h"
+#include "exec/cpu_ldst.h"
  #include "sysemu/runstate.h"


@@ -147,6 +148,18 @@ void sparc_cpu_do_interrupt(CPUState *cs)
      env->psret = 0;
      cwp = cpu_cwp_dec(env, env->cwp - 1);
      cpu_set_cwp(env, cwp);
+    if (intno == TT_FP_EXCP) {
+        env->fsr_qne = FSR_QNE;
+        env->fsr_qa = env->pc;
+        env->fsr_qi = cpu_ldl_code(env, env->fsr_qa);
+         /*
+          * Because of the asynchronous FPU on real Sparc 32 bit
+          * machines, the pc and npc will have already been advanced
+          * by the time that the trap is taken.
+          */
+        env->pc = env->npc;
+        env->npc = env->npc + 4;
+    }
      env->regwptr[9] = env->pc;
      env->regwptr[10] = env->npc;
      env->psrps = env->psrs;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 113639083b..2160ccb5b9 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -41,6 +41,7 @@
  # define gen_helper_rett(E)                     qemu_build_not_reached()
  # define gen_helper_power_down(E)               qemu_build_not_reached()
  # define gen_helper_wrpsr(E, S)                 qemu_build_not_reached()
+# define gen_helper_store_fp_queue(E, A)        qemu_build_not_reached()
  #else
  # define gen_helper_clear_softint(E, S)         qemu_build_not_reached()
  # define gen_helper_done(E)                     qemu_build_not_reached()
@@ -4521,13 +4522,13 @@ static bool do_st_fpr(DisasContext *dc, 
arg_r_r_ri_asi *a, MemOp sz)

  TRANS(STF, ALL, do_st_fpr, a, MO_32)
  TRANS(STDF, ALL, do_st_fpr, a, MO_64)
-TRANS(STQF, ALL, do_st_fpr, a, MO_128)
+TRANS(STQF, 64, do_st_fpr, a, MO_128)

  TRANS(STFA, 64, do_st_fpr, a, MO_32)
  TRANS(STDFA, 64, do_st_fpr, a, MO_64)
  TRANS(STQFA, 64, do_st_fpr, a, MO_128)

-static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
+static bool trans_STDFQ(DisasContext *dc, arg_r_r_ri_asi *a)
  {
      if (!avail_32(dc)) {
          return false;
@@ -4538,10 +4539,15 @@ static bool trans_STDFQ(DisasContext *dc, 
arg_STDFQ *a)
      if (gen_trap_ifnofpu(dc)) {
          return true;
      }
-    gen_op_fpexception_im(dc, FSR_FTT_SEQ_ERROR);
-    return true;
+    TCGv store_addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    if (store_addr == NULL) {
+        return false;
+    }
+    gen_helper_store_fp_queue(tcg_env, store_addr);
+    return advance_pc(dc);
  }

+
  static bool trans_LDFSR(DisasContext *dc, arg_r_r_ri *a)
  {
      TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
-- 
2.34.1




