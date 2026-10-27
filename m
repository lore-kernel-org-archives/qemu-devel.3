Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFBD606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhKn0Ocq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLp5g-0002x1-IA; Tue, 27 Oct 2026 17:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLp5e-0002wF-P1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 17:52:18 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLp5b-00006r-Bl
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 17:52:18 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 46834600C8;
 Tue, 27 Oct 2026 21:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AFB1F01825;
 Tue, 27 Oct 2026 21:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793137934;
 bh=QaVRcb8yXZ4o8Ma7MN3IF8FH4J0vdEYFJdp2P80b7Q0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BhKn0Ocqu5n0uaqJd402RGt5bhj/8Jd+sKBMgO7Fc6y3KpQ415l4neJg0DfjA3nIf
 ZKvhJJKBYRbsJl8UdV2foY1EsItAK1+b+vled1wczcjl3/Yxkqcmqhj+/QBYJz4qPA
 HFbCdVNHdf3sRh7tpTNJaxueCrC8YJ4Y0J2CroAzLFJRzwvx1bp5qcw8FXeg1BseMY
 al0iBfbOzgaSgNn52gg9DMkYuNXYiYwQzNU2RbSsQXnYuJWkMl4zL19C4zxyeGig6C
 P24m7ubt6p16xOOvpthaaUEzwBI99XC/OjpnRZcQTRwsSHGt1vHzlhwvZVmPeL7KCk
 VIXdugCnABC4w==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Keith Monahan <keith@techtravels.org>,
 "Kirill A . Korinsky" <kirill@korins.ky>, Helge Deller <deller@gmx.de>
Subject: [PATCH 1/8] target/hppa: restore lazy FPU context isolation
Date: Tue, 27 Oct 2026 22:52:02 +0100
Message-ID: <20261027215209.21150-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027215209.21150-1-deller@kernel.org>
References: <20261027215209.21150-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Kirill A. Korinsky" <kirill@korins.ky>

Raise assist emulation trap 22 when CCR disables FP execution;
this restores lazy FPU context isolation, stabilizes OpenBSD/hppa, and
fixes unexplained SSH "incorrect signature" failures.

I keep FP enabled on firmware entry because SeaBIOS uses FP registers
before configuring CCR.

The regression test is based on lazy.elf and eager.elf, compiled from
firmware.ld and fpu-state.s with OpenBSD/hppa 8.0's patched GCC 4.2.1
and BFD 2.17.

Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4715
Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c                     |   2 +
 target/hppa/cpu.c                     |   1 +
 target/hppa/cpu.h                     |   1 +
 target/hppa/helper.h                  |   1 +
 target/hppa/mem_helper.c              |  15 ++
 target/hppa/translate.c               |  61 ++++-
 tests/functional/hppa/test_seabios.py |   6 +-
 tests/qtest/hppa-fpu-test.c           | 371 ++++++++++++++++++++++++++
 tests/qtest/meson.build               |   2 +
 9 files changed, 456 insertions(+), 4 deletions(-)
 create mode 100644 tests/qtest/hppa-fpu-test.c

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 0b0a8047ed..96d57b9b0f 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -842,6 +842,8 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
 
         cpu_set_pc(cs, firmware_entry);
         cpu[i]->env.psw = PSW_Q;
+        /* Firmware uses FP registers before configuring CCR. */
+        cpu[i]->env.cr[CR_SCRCCR] = 0xc0;
         cpu[i]->env.gr[5] = CPU_HPA + i * 0x1000;
     }
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 9d64322398..83104ae0c7 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -91,6 +91,7 @@ static TCGTBCPUState hppa_get_tb_cpu_state(CPUState *cs)
 #ifdef CONFIG_USER_ONLY
     flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
 #else
+    flags |= TB_FLAG_FPU_DISABLED * !(env->cr[CR_SCRCCR] & 0xc0);
     if ((env->sr[4] == env->sr[5])
         & (env->sr[4] == env->sr[6])
         & (env->sr[4] == env->sr[7])) {
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 8818d47dcd..c0ba787974 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -372,6 +372,7 @@ hwaddr hppa_abs_to_phys_pa2_w1(uint8_t phys_addr_bits, vaddr addr);
 #define TB_FLAG_PRIV_SHIFT  8
 #define TB_FLAG_UNALIGN     0x400
 #define TB_FLAG_SPHASH      0x800
+#define TB_FLAG_FPU_DISABLED 0x1000
 #define CS_BASE_DIFFPAGE    (1 << 12)
 #define CS_BASE_DIFFSPACE   (1 << 13)
 
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 8d7fa1ae34..449818f9dd 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -82,6 +82,7 @@ DEF_HELPER_FLAGS_4(fmpynfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_0(read_interval_timer, TCG_CALL_NO_RWG, tl)
 
 #ifndef CONFIG_USER_ONLY
+DEF_HELPER_5(fpu_mem, noreturn, env, tl, i32, i32, i32)
 DEF_HELPER_1(hppa_halt, noreturn, env)
 DEF_HELPER_1(hppa_reset, noreturn, env)
 DEF_HELPER_1(rfi, void, env)
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 2393a15507..a5da0bc851 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -427,6 +427,21 @@ raise_exception_with_ior(CPUHPPAState *env, int excp, uintptr_t retaddr,
     cpu_loop_exit(cs);
 }
 
+G_NORETURN void HELPER(fpu_mem)(CPUHPPAState *env, target_ulong addr,
+                               uint32_t mmu_idx, uint32_t mop, uint32_t type)
+{
+    hwaddr phys;
+    int prot, excp;
+
+    /* Memory faults take priority over the assist emulation trap. */
+    excp = hppa_get_physical_address(env, addr, mmu_idx, type, mop, &phys, &prot);
+    if (excp < 0) {
+        excp = EXCP_ASSIST_EMU;
+    }
+    raise_exception_with_ior(env, excp, GETPC(), addr,
+                             MMU_IDX_MMU_DISABLED(mmu_idx));
+}
+
 void hppa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
                                      MMUAccessType access_type,
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index befdb58e9a..6a4072a630 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1711,8 +1711,30 @@ static bool do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
     return nullify_end(ctx);
 }
 
+static bool gen_fmem_excp(DisasContext *ctx, arg_ldst *a, MemOp mop, int type)
+{
+#ifndef CONFIG_USER_ONLY
+    TCGv_i64 addr, ofs;
+
+    nullify_over(ctx);
+    form_gva(ctx, &addr, &ofs, a->b, a->x,
+             a->scale ? mop & MO_SIZE : 0, a->disp, a->sp, a->m,
+             MMU_DISABLED(ctx));
+    gen_helper_fpu_mem(tcg_env, addr, tcg_constant_i32(ctx->mmu_idx),
+                       tcg_constant_i32(mop | ctx->mo_align | mo_endian(ctx)),
+                       tcg_constant_i32(type));
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return nullify_end(ctx);
+#else
+    g_assert_not_reached();
+#endif
+}
+
 static bool trans_fldw(DisasContext *ctx, arg_ldst *a)
 {
+    if (ctx->tb_flags & TB_FLAG_FPU_DISABLED) {
+        return gen_fmem_excp(ctx, a, MO_UL, PAGE_READ);
+    }
     return do_floadw(ctx, a->t, a->b, a->x, a->scale ? 2 : 0,
                      a->disp, a->sp, a->m);
 }
@@ -1738,6 +1760,9 @@ static bool do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
 
 static bool trans_fldd(DisasContext *ctx, arg_ldst *a)
 {
+    if (ctx->tb_flags & TB_FLAG_FPU_DISABLED) {
+        return gen_fmem_excp(ctx, a, MO_UQ, PAGE_READ);
+    }
     return do_floadd(ctx, a->t, a->b, a->x, a->scale ? 3 : 0,
                      a->disp, a->sp, a->m);
 }
@@ -1767,6 +1792,9 @@ static bool do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
 
 static bool trans_fstw(DisasContext *ctx, arg_ldst *a)
 {
+    if (ctx->tb_flags & TB_FLAG_FPU_DISABLED) {
+        return gen_fmem_excp(ctx, a, MO_UL, PAGE_WRITE);
+    }
     return do_fstorew(ctx, a->t, a->b, a->x, a->scale ? 2 : 0,
                       a->disp, a->sp, a->m);
 }
@@ -1787,6 +1815,9 @@ static bool do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
 
 static bool trans_fstd(DisasContext *ctx, arg_ldst *a)
 {
+    if (ctx->tb_flags & TB_FLAG_FPU_DISABLED) {
+        return gen_fmem_excp(ctx, a, MO_UQ, PAGE_WRITE);
+    }
     return do_fstored(ctx, a->t, a->b, a->x, a->scale ? 3 : 0,
                       a->disp, a->sp, a->m);
 }
@@ -2311,8 +2342,9 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
 #endif
         break;
 
+    case CR_SCRCCR:
     case CR_EIEM:
-        /* Exit to re-evaluate interrupts in the main loop. */
+        /* Exit to re-evaluate translation flags and interrupts. */
         ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
         /* FALLTHRU */
     default:
@@ -4721,6 +4753,31 @@ static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
     ctx->insn_start_updated = false;
 }
 
+static bool decode_insn(DisasContext *ctx, uint32_t insn)
+{
+#ifndef CONFIG_USER_ONLY
+    if (ctx->tb_flags & TB_FLAG_FPU_DISABLED) {
+        switch (insn >> 26) {
+        case 0x0b:
+            /* Both floating-point uids trap when the coprocessor is disabled. */
+            insn &= ~0x40;
+            break;
+        case 0x0c:
+            if (extract32(insn, 7, 2)) {
+                break;
+            }
+            /* fall through */
+        case 0x06:
+        case 0x0e:
+        case 0x26:
+        case 0x2e:
+            return gen_excp_iir(ctx, EXCP_ASSIST_EMU);
+        }
+    }
+#endif
+    return decode(ctx, insn);
+}
+
 static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
@@ -4754,7 +4811,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
             ret = DISAS_NEXT;
         } else {
             ctx->insn = insn;
-            if (!decode(ctx, insn)) {
+            if (!decode_insn(ctx, insn)) {
                 gen_illegal(ctx);
             }
             ret = ctx->base.is_jmp;
diff --git a/tests/functional/hppa/test_seabios.py b/tests/functional/hppa/test_seabios.py
index bdb9d534ef..9fd42d70ac 100755
--- a/tests/functional/hppa/test_seabios.py
+++ b/tests/functional/hppa/test_seabios.py
@@ -20,8 +20,10 @@ def boot_seabios(self):
         self.vm.add_args('-no-shutdown')
         self.vm.set_console()
         self.vm.launch()
-        wait_for_console_pattern(self, f'SeaBIOS PA-RISC {bits}-bit Firmware')
-        wait_for_console_pattern(self, f'Emulated machine:     HP {mach} ({bits}-bit')
+        wait_for_console_pattern(self, f'SeaBIOS PA-RISC {bits}-bit Firmware',
+                                 failure_message='SeaBIOS: Detected trap')
+        wait_for_console_pattern(self, f'Emulated machine:     HP {mach} ({bits}-bit',
+                                 failure_message='SeaBIOS: Detected trap')
 
     def test_hppa_32(self):
         self.set_machine('B160L')
diff --git a/tests/qtest/hppa-fpu-test.c b/tests/qtest/hppa-fpu-test.c
new file mode 100644
index 0000000000..af4ff2a162
--- /dev/null
+++ b/tests/qtest/hppa-fpu-test.c
@@ -0,0 +1,371 @@
+/*
+ * HPPA CCR floating-point enable and lazy context switching tests.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define BOOT 0x1000
+#define CODE 0x1100
+#define FP_CODE 0x1300
+#define ASSIST 0x1400
+#define UNEXPECTED 0x1500
+#define HALT 0x1600
+#define DATA 0x1800
+#define RESULT 0x1900
+#define LOG 0x1a00
+
+/* Enable interruption-state collection through IPSW before entering CODE. */
+static const uint32_t bootstrap[] = {
+    0x34010010, /* ldi 8,r1 */
+    0x02c11840, /* mtctl r1,ipsw */
+    0x02201840, /* mtctl r0,iiasq */
+    0x02201840, /* mtctl r0,iiasq */
+    0x34012200, /* ldi 0x1100,r1 */
+    0x02411840, /* mtctl r1,iiaoq */
+    0x34012208, /* ldi 0x1104,r1 */
+    0x02411840, /* mtctl r1,iiaoq */
+    0x00000c00, /* rfi */
+};
+
+/*
+ * r20 counts assists. After the first call, the shared CCR writer is entered
+ * with FP enabled. Alternating its input must reselect the next translation.
+ */
+static const uint32_t fp_guest[] = {
+    0x34011000, /* ldi 0x800,r1 */
+    0x01c11840, /* mtctl r1,iva */
+    0x08000240, /* nop */
+    0x34103000, /* ldi 0x1800,r16 */
+    0x34113200, /* ldi 0x1900,r17 */
+    0x341a3400, /* ldi 0x1a00,r26 */
+    0x34140000, /* ldi 0,r20 */
+    0x34010180, /* ldi 0xc0,r1 */
+    0x01411840, /* mtctl r1,ccr */
+    0x2e00100c, /* fldd 0(r16),fr12 */
+    0x34010000, /* ldi 0,r1 */
+    0x01411840, /* mtctl r1,ccr */
+    0x08142880, /* cmpclr,= r20,r0,r0: nullify the next instruction */
+    0x08000240, /* replaced by the FP instruction under test */
+    0x6a340008, /* stw r20,4(r17) */
+    0x34010180, /* ldi 0xc0,r1 */
+    0xe8400370, /* bl 0x1300,rp */
+    0x08000240, /* nop */
+    0x6a340010, /* stw r20,8(r17) */
+    0x34010000, /* ldi 0,r1 */
+    0xe8400350, /* bl 0x1300,rp */
+    0x08000240, /* nop */
+    0x6a340018, /* stw r20,12(r17) */
+    0x34010180, /* ldi 0xc0,r1 */
+    0xe8400330, /* bl 0x1300,rp */
+    0x08000240, /* nop */
+    0x6a340020, /* stw r20,16(r17) */
+    0x34010000, /* ldi 0,r1 */
+    0xe8400310, /* bl 0x1300,rp */
+    0x08000240, /* nop */
+    0x6a340028, /* stw r20,20(r17) */
+    0x34010180, /* ldi 0xc0,r1 */
+    0xe84002f0, /* bl 0x1300,rp */
+    0x08000240, /* nop */
+    0x6a340030, /* stw r20,24(r17) */
+    0x34010000, /* ldi 0,r1 */
+    0xe84002d0, /* bl 0x1300,rp */
+    0x08000240, /* nop */
+    0x6a340038, /* stw r20,28(r17) */
+    0x34010180, /* ldi 0xc0,r1 */
+    0x01411840, /* mtctl r1,ccr */
+    0x2e10120c, /* fstd fr12,8(r16) */
+    0x36100010, /* ldo 8(r16),r16 */
+    0x2e10120d, /* fstd fr13,8(r16) */
+    0x34010002, /* ldi 1,r1 */
+    0x6a210000, /* stw r1,0(r17): completion */
+    0xe8000882, /* b,n 0x1600 */
+};
+
+static const uint32_t fp_site[] = {
+    0x01411840, /* mtctl r1,ccr */
+    0x08000240, /* replaced by the FP instruction under test */
+    0xe840c002, /* bv,n 0(rp) */
+};
+
+/* r20 and r26 are outside the shadow register set restored by rfir. */
+static const uint32_t assist_handler[] = {
+    0x026008a1, /* mfctl iir,r1 */
+    0x6b410000, /* stw r1,0(r26) */
+    0x024008a1, /* mfctl iiaoq,r1 */
+    0x6b410008, /* stw r1,4(r26) */
+    0x028008a1, /* mfctl isr,r1 */
+    0x6b410010, /* stw r1,8(r26) */
+    0x02a008a1, /* mfctl ior,r1 */
+    0x6b410018, /* stw r1,12(r26) */
+    0x375a0020, /* ldo 16(r26),r26 */
+    0x36940002, /* ldo 1(r20),r20 */
+    0x34010180, /* ldi 0xc0,r1 */
+    0x01411840, /* mtctl r1,ccr */
+    0x00000ca0, /* rfir: retry the faulting instruction */
+};
+
+static const uint32_t unexpected_handler[] = {
+    0x026008a1, /* mfctl iir,r1 */
+    0x6a210008, /* stw r1,4(r17) */
+    0x024008a1, /* mfctl iiaoq,r1 */
+    0x6a210010, /* stw r1,8(r17) */
+    0x028008a1, /* mfctl isr,r1 */
+    0x6a210018, /* stw r1,12(r17) */
+    0x02a008a1, /* mfctl ior,r1 */
+    0x6a210020, /* stw r1,16(r17) */
+    0x6a380000, /* stw r24,0(r17): 0x100 | exception number */
+    0xe80001aa, /* b,n 0x1600 */
+};
+
+/* r18 owns the live FP state; r19 requests the next logical context. */
+static const uint32_t lazy_guest[] = {
+    0x34011000, /* ldi 0x800,r1 */
+    0x01c11840, /* mtctl r1,iva */
+    0x08000240, /* nop */
+    0x34123000, /* ldi 0x1800,r18: owner A */
+    0x34113200, /* ldi 0x1900,r17 */
+    0x34140000, /* ldi 0,r20 */
+    0x34010180, /* ldi 0xc0,r1 */
+    0x01411840, /* mtctl r1,ccr */
+    0x2e40100c, /* fldd 0(r18),fr12 */
+    0x318c0e0c, /* fadd,d fr12,fr12,fr12: A = 2 */
+    0x34173240, /* ldi 0x1920,r23 */
+    0x34133020, /* ldi 0x1810,r19: request B */
+    0xe8400390, /* bl 0x1300,rp */
+    0x08000240, /* nop */
+    0x318c0e0c, /* fadd,d fr12,fr12,fr12: B = 32 */
+    0x36f70010, /* ldo 8(r23),r23 */
+    0x34133000, /* ldi 0x1800,r19: request A */
+    0xe8400368, /* bl 0x1300,rp */
+    0x08000240, /* nop */
+    0x318c0e0c, /* fadd,d fr12,fr12,fr12: A = 4 */
+    0x36f70010, /* ldo 8(r23),r23 */
+    0x34133020, /* ldi 0x1810,r19: request B */
+    0xe8400340, /* bl 0x1300,rp */
+    0x08000240, /* nop */
+    0x318c0e0c, /* fadd,d fr12,fr12,fr12: B = 64 */
+    0x36f70010, /* ldo 8(r23),r23 */
+    0x34133000, /* ldi 0x1800,r19: request A */
+    0xe8400318, /* bl 0x1300,rp */
+    0x08000240, /* nop */
+    0x6a340008, /* stw r20,4(r17) */
+    0x34010002, /* ldi 1,r1 */
+    0x6a210000, /* stw r1,0(r17) */
+    0xe80008f2, /* b,n 0x1600 */
+};
+
+static const uint32_t lazy_site[] = {
+    0x01401840, /* mtctl r0,ccr */
+    0x2ee0120c, /* fstd fr12,0(r23) */
+    0xe840c002, /* bv,n 0(rp) */
+};
+
+static const uint32_t lazy_handler[] = {
+    0x34010180, /* ldi 0xc0,r1 */
+    0x01411840, /* mtctl r1,ccr */
+    0x2e40120c, /* fstd fr12,0(r18): save owner */
+    0x2e60100c, /* fldd 0(r19),fr12: restore requested context */
+    0x08130252, /* copy r19,r18 */
+    0x36940002, /* ldo 1(r20),r20 */
+    0x00000ca0, /* rfir */
+};
+
+static void write_words(QTestState *qts, uint32_t addr,
+                        const uint32_t *words, size_t count)
+{
+    for (size_t i = 0; i < count; i++) {
+        qtest_writel(qts, addr + 4 * i, words[i]);
+    }
+}
+
+static uint32_t branch(uint32_t pc, uint32_t target)
+{
+    uint32_t d = (target - pc - 8) / 4;
+
+    return 0xe8000002 | ((d & 0x10000) >> 16) | ((d & 0xf800) << 5) |
+           ((d & 0x400) >> 8) | ((d & 0x3ff) << 3);
+}
+
+static QTestState *start_guest(bool retry_assist)
+{
+    QTestState *qts = qtest_init("-machine none -cpu pa-7300lc -m 1M "
+                                "-S -accel tcg -no-shutdown "
+                                "-device loader,addr=0x1000,cpu-num=0");
+
+    write_words(qts, BOOT, bootstrap, G_N_ELEMENTS(bootstrap));
+    /* Shutdown may re-enter this TB before the main loop stops the CPU. */
+    qtest_writel(qts, HALT, 0xfffdead0);
+    write_words(qts, UNEXPECTED, unexpected_handler,
+                G_N_ELEMENTS(unexpected_handler));
+    for (unsigned int i = 0; i < 32; i++) {
+        uint32_t pc = 0x800 + i * 32;
+        uint32_t target = retry_assist && i == 22 ? ASSIST : UNEXPECTED;
+
+        qtest_writel(qts, pc, 0x34180000 | ((0x100 | i) << 1));
+        qtest_writel(qts, pc + 4, branch(pc + 4, target));
+    }
+    return qts;
+}
+
+static void run_guest(QTestState *qts, uint32_t expected)
+{
+    uint32_t result;
+
+    qtest_qmp_assert_success(qts, "{'execute':'cont'}");
+    qtest_qmp_eventwait(qts, "SHUTDOWN");
+    result = qtest_readl(qts, RESULT);
+    g_test_message("completion=0x%x, result[1]=0x%x, result[2]=0x%x",
+                   result, qtest_readl(qts, RESULT + 4),
+                   qtest_readl(qts, RESULT + 8));
+    g_assert_cmphex(result, ==, expected);
+}
+
+typedef struct FPTest {
+    const char *name;
+    uint32_t instruction;
+    bool memory;
+    uint64_t fr13;
+} FPTest;
+
+static const FPTest fp_tests[] = {
+    { "fldw", 0x2600100c, true },
+    { "fstw", 0x2600120c, true },
+    { "fldd", 0x2e00100c, true },
+    { "fstd", 0x2e00120c, true },
+    { "fid", 0x30000000 },
+    { "fadd-double", 0x318c0e0d, false, 0x4010000000000000ULL },
+    { "fadd-double-extended", 0x398c0e0d, false, 0x4010000000000000ULL },
+    { "fmpyadd-single", 0x188541e6 }, /* fr20L,fr21L,fr22L,fr23L,fr24L */
+    { "fmpysub-double", 0x988541c6 }, /* fr4,fr5,fr6,fr7,fr8 */
+};
+
+static void test_fp(const void *opaque)
+{
+    const FPTest *test = opaque;
+    static const uint32_t counts[] = { 0, 0, 1, 1, 2, 2, 3 };
+    QTestState *qts = start_guest(true);
+
+    write_words(qts, CODE, fp_guest, G_N_ELEMENTS(fp_guest));
+    write_words(qts, FP_CODE, fp_site, G_N_ELEMENTS(fp_site));
+    write_words(qts, ASSIST, assist_handler, G_N_ELEMENTS(assist_handler));
+    qtest_writel(qts, CODE + 13 * 4, test->instruction);
+    qtest_writel(qts, FP_CODE + 4, test->instruction);
+    qtest_writeq(qts, DATA, 0x4000000000000000ULL); /* double 2 */
+    run_guest(qts, 1);
+    for (size_t i = 0; i < G_N_ELEMENTS(counts); i++) {
+        g_assert_cmpuint(qtest_readl(qts, RESULT + 4 + 4 * i), ==, counts[i]);
+    }
+    for (unsigned int i = 0; i < 3; i++) {
+        g_assert_cmphex(qtest_readl(qts, LOG + 16 * i), ==, test->instruction);
+        g_assert_cmphex(qtest_readl(qts, LOG + 16 * i + 4), ==, FP_CODE + 4);
+        if (test->memory) {
+            g_assert_cmphex(qtest_readl(qts, LOG + 16 * i + 8), ==, 0);
+            g_assert_cmphex(qtest_readl(qts, LOG + 16 * i + 12), ==, DATA);
+        }
+    }
+    g_assert_cmphex(qtest_readq(qts, DATA + 8), ==, 0x4000000000000000ULL);
+    g_assert_cmphex(qtest_readq(qts, DATA + 16), ==, test->fr13);
+    qtest_quit(qts);
+}
+
+static void test_lazy(void)
+{
+    static const uint64_t markers[] = {
+        0x4030000000000000ULL, /* B = 16 */
+        0x4000000000000000ULL, /* A = 2 */
+        0x4040000000000000ULL, /* B = 32 */
+        0x4010000000000000ULL, /* A = 4 */
+    };
+    QTestState *qts = start_guest(true);
+
+    write_words(qts, CODE, lazy_guest, G_N_ELEMENTS(lazy_guest));
+    write_words(qts, FP_CODE, lazy_site, G_N_ELEMENTS(lazy_site));
+    write_words(qts, ASSIST, lazy_handler, G_N_ELEMENTS(lazy_handler));
+    qtest_writeq(qts, DATA, 0x3ff0000000000000ULL); /* A = 1 */
+    qtest_writeq(qts, DATA + 16, markers[0]);
+    run_guest(qts, 1);
+    g_assert_cmpuint(qtest_readl(qts, RESULT + 4), ==, 4);
+    for (size_t i = 0; i < G_N_ELEMENTS(markers); i++) {
+        g_assert_cmphex(qtest_readq(qts, RESULT + 32 + 8 * i), ==, markers[i]);
+    }
+    g_assert_cmphex(qtest_readq(qts, DATA), ==, 0x4010000000000000ULL);
+    g_assert_cmphex(qtest_readq(qts, DATA + 16), ==, 0x4050000000000000ULL);
+    qtest_quit(qts);
+}
+
+static const uint32_t fault_guest[] = {
+    0x34011000, /* ldi 0x800,r1 */
+    0x01c11840, /* mtctl r1,iva */
+    0x34103000, /* ldi 0x1800,r16: replaced for unaligned cases */
+    0x34113200, /* ldi 0x1900,r17 */
+    0x01401840, /* mtctl r0,ccr */
+    0x08000240, /* replaced by ssm 2,r0 for data translation */
+    0x08000240, /* replaced by the FP instruction under test */
+    0x34010002, /* ldi 1,r1 */
+    0x6a210000, /* stw r1,0(r17): unexpectedly completed */
+    0xe80009aa, /* b,n 0x1600 */
+};
+
+typedef struct FaultTest {
+    const char *name;
+    uint32_t instruction;
+    unsigned int exception;
+    uint32_t address;
+    bool dtlb;
+    bool memory;
+} FaultTest;
+
+static const FaultTest fault_tests[] = {
+    { "unaligned-load", 0x2e00100c, 28, DATA + 2, false, true },
+    { "unaligned-store", 0x2e00120c, 28, DATA + 2, false, true },
+    { "dtlb-load", 0x2e00100c, 15, DATA, true, true },
+    { "dtlb-store", 0x2e00120c, 15, DATA, true, true },
+    { "disabled-uid1-arithmetic", 0x30000040, 22, DATA, false, false },
+    { "disabled-uid1-memory", 0x2e00104c, 22, DATA, false, true },
+};
+
+static void test_fault(const void *opaque)
+{
+    const FaultTest *test = opaque;
+    uint32_t addr = test->address;
+    QTestState *qts = start_guest(false);
+
+    write_words(qts, CODE, fault_guest, G_N_ELEMENTS(fault_guest));
+    qtest_writel(qts, CODE + 8, 0x34100000 | (addr << 1));
+    if (test->dtlb) {
+        qtest_writel(qts, CODE + 20, 0x00020d60); /* ssm 2,r0 */
+    }
+    qtest_writel(qts, CODE + 24, test->instruction);
+    run_guest(qts, 0x100 | test->exception);
+    g_assert_cmphex(qtest_readl(qts, RESULT + 4), ==, test->instruction);
+    g_assert_cmphex(qtest_readl(qts, RESULT + 8), ==, CODE + 24);
+    if (test->memory) {
+        g_assert_cmphex(qtest_readl(qts, RESULT + 12), ==, 0);
+        g_assert_cmphex(qtest_readl(qts, RESULT + 16), ==, addr);
+    }
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    if (!qtest_has_accel("tcg")) {
+        g_test_skip("TCG accelerator required");
+        return 0;
+    }
+    for (size_t i = 0; i < G_N_ELEMENTS(fp_tests); i++) {
+        g_autofree char *name = g_strdup_printf("fpu/%s", fp_tests[i].name);
+
+        qtest_add_data_func(name, &fp_tests[i], test_fp);
+    }
+    qtest_add_func("fpu/lazy-contexts", test_lazy);
+    for (size_t i = 0; i < G_N_ELEMENTS(fault_tests); i++) {
+        g_autofree char *name = g_strdup_printf("fpu/%s", fault_tests[i].name);
+
+        qtest_add_data_func(name, &fault_tests[i], test_fault);
+    }
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 46685d6d46..9d422886d8 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -158,6 +158,8 @@ qtests_alpha = ['boot-serial-test'] + \
 qtests_avr = [ 'boot-serial-test' ]
 
 qtests_hppa = \
+  (config_all_accel.has_key('CONFIG_TCG') and \
+   config_all_devices.has_key('CONFIG_GENERIC_LOADER') ? ['hppa-fpu-test'] : []) + \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
 
-- 
2.54.0


