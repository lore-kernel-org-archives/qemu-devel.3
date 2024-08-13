Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A517C531DC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 01:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se2QJ-0005Mb-Ie; Tue, 13 Aug 2024 21:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1se0qe-00089k-Ex
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:22:41 -0400
Received: from secure.fsr.com ([64.126.132.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1se0qb-0006Gj-Q4
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:22:40 -0400
Received: from [192.168.254.26] (syn-098-146-201-045.res.spectrum.com
 [98.146.201.45]) (Authenticated sender: chauser)
 by secure.fsr.com (Postfix) with ESMTPSA id 8638231235;
 Tue, 13 Aug 2024 16:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pullman.com;
 s=mail1; t=1723591347;
 bh=Dta+Erz9bAeLggwvPwiI8zBw7dOr+Uq3yES+tUEhWZo=;
 h=Date:To:From:Subject;
 b=eU0x7Fah/53lT1AIgmWrARR3jjErFUP5Y7/RgGRq6fW7anldwGuoSOHC7H3z7ruYT
 YjbLpohU3GuU/IvB4GPxyNNEYuUahB2qMsWcuoQPhx4u8T/by2XuExsxgvFzPa1G/M
 U66APCQ4edIliLoyZtrPMzOit84CcnDJVyWf5/WE=
Message-ID: <cde53d38-c378-459f-9e2a-6e9ca287cc3c@pullman.com>
Date: Tue, 13 Aug 2024 16:22:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel@nongnu.org, Carl Hauser <carl.hauser@gmail.com>
From: Carl Hauser <chauser@pullman.com>
Subject: [PATCH] target/sparc: emulate floating point queue when raising fp
 traps
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
X-Mailman-Approved-At: Tue, 13 Aug 2024 21:03:31 -0400
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

 From 310902d2ccd88ccb8de971d0d7ede0dbc93939f4 Mon Sep 17 00:00:00 2001
From: Carl Hauser <chauser@pullman.com>
Date: Sat, 10 Aug 2024 15:09:39 -0700
Subject: [PATCH] target/sparc: emulate floating point queue when raising 
fp traps

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
IEEE trap changes have been tested with Solaris 2.5.6,
linux kernel 2.6.18 (debian 4), and NetBSD 10.

For IEEE traps the behaviors change as follows:

Solaris -- occurence of a FP trap no longer hangs the user program.
The trap is reported as occurring at the instruction after the
instruction that caused the fault. This probably is the case for SunOS
4.1.4 as well.

For linux -- occurence of a FP did not
previously hang the user program. However the trap was previously
reported as occurring AT the instruction that caused the fault and
now is reported at the next instruction.

For NetBSD -- previously, trap did not hang but was reported as
occurring on the FP instruction. The trap is now reported as
occurring at the instruction after the instruction that caused the fault.

For unimplemented FP operation traps:
For Solaris 2.5.6 -- occurence of a FP trap no longer hangs the user 
program.
The instruction is emulated by kernel and control returns to the user 
program.

I am unable to test the linux and NetBSD behavior because I've been
unable to get gcc to actually generate quad precision instructions on those
systems.

My main concern as a newbie patch submitter is that I may have broken
something for SPARC64. I couldn't figure out the correct changes
for insns.decode, but reordering the two lines allowed the patch
to work for 32-bit sparc, but it may have broken sparc64, which I
have no way to test.

  target/sparc/cpu.h          |  8 ++++++++
  target/sparc/fop_helper.c   | 17 ++++++++++++++++-
  target/sparc/helper.h       |  4 ++++
  target/sparc/insns.decode   |  5 +++--
  target/sparc/int32_helper.c | 15 +++++++++++++++
  target/sparc/translate.c    | 20 +++++++++++++++++---
  6 files changed, 63 insertions(+), 6 deletions(-)

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
index fbcb4f7aef..e0ad090340 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -644,8 +644,9 @@ STF         11 ..... 100100 ..... . ............. 
       @r_r_ri_na
  STFSR       11 00000 100101 ..... . .............          @n_r_ri
  STXFSR      11 00001 100101 ..... . .............          @n_r_ri
  {
-  STQF      11 ..... 100110 ..... . .............          @q_r_ri_na
-  STDFQ     11 ----- 100110 ----- - -------------
+
+  STDFQ     11 ..... 100110 ..... . .............          @r_r_r_asi 
## SPARC-V7-8
+  STQF      11 ..... 100110 ..... . .............          @q_r_ri_na 
## SPARC-V9
  }
  STDF        11 ..... 100111 ..... . .............          @d_r_ri_na

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 6b7d65b031..e2c5fbe301 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -22,6 +22,7 @@
  #include "cpu.h"
  #include "trace.h"
  #include "exec/log.h"
+#include "exec/cpu_ldst.h"
  #include "sysemu/runstate.h"


@@ -147,6 +148,20 @@ void sparc_cpu_do_interrupt(CPUState *cs)
      env->psret = 0;
      cwp = cpu_cwp_dec(env, env->cwp - 1);
      cpu_set_cwp(env, cwp);
+#ifndef TARGET_SPARC64
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
+#endif
      env->regwptr[9] = env->pc;
      env->regwptr[10] = env->npc;
      env->psrps = env->psrs;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 113639083b..18cb1383b4 100644
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
@@ -1458,8 +1459,10 @@ static void gen_op_fpexception_im(DisasContext 
*dc, int ftt)
       * or when raising FSR_FTT_IEEE_EXCP, i.e. check_ieee_exception.
       * Thus we can simply store FTT into this field.
       */
+
      tcg_gen_st_i32(tcg_constant_i32(ftt), tcg_env,
                     offsetof(CPUSPARCState, fsr_cexc_ftt));
+
      gen_exception(dc, TT_FP_EXCP);
  }

@@ -4527,8 +4530,10 @@ TRANS(STFA, 64, do_st_fpr, a, MO_32)
  TRANS(STDFA, 64, do_st_fpr, a, MO_64)
  TRANS(STQFA, 64, do_st_fpr, a, MO_128)

-static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
+static bool trans_STDFQ(DisasContext *dc, arg_r_r_ri_asi *a)
  {
+
+#ifndef TARGET_SPARC64
      if (!avail_32(dc)) {
          return false;
      }
@@ -4538,10 +4543,19 @@ static bool trans_STDFQ(DisasContext *dc, 
arg_STDFQ *a)
      if (gen_trap_ifnofpu(dc)) {
          return true;
      }
-    gen_op_fpexception_im(dc, FSR_FTT_SEQ_ERROR);
-    return true;
+
+    TCGv store_addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    if (store_addr == NULL) {
+        return false;
+    }
+    gen_helper_store_fp_queue(tcg_env, store_addr);
+    return advance_pc(dc);
+#else
+    g_assert_not_reached();
+#endif
  }

+
  static bool trans_LDFSR(DisasContext *dc, arg_r_r_ri *a)
  {
      TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
-- 
2.34.1


