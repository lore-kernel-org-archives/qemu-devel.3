Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B97606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=YxcqEqqG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYCR-00040j-0F; Thu, 29 Oct 2026 18:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYCA-0003wd-24
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:02:08 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC2-0006WJ-HR
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793311299; x=1793916099; i=deller@gmx.de;
 bh=FmptSiXEFYbchF2FQCG3ItB8N7tEQf2Q9Mf5WU4hoKo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=YxcqEqqGLJitdDJG72A8HmJzDyjEgc/sc9iWK+AH4LbEiFtJBhXbYX3pvkABNJd8
 8OSCCQwENGwsQCBQXejG2qFu8sIpSXWWWbUx4caNdtBkWIMOyvqnAB7Tk/IqUU/Ke
 8H0W84LsUx+byt8W2tiLq3pdCVsfZ0QKdMr/e9Uwcs+LrGEzRv9V2mkpzW8BodS4E
 YRka9Ww9VEkg77YepOA12HlljxhSndY/DYFyik/yf/htSxQ/HprNfAdmJ4fOMmYdR
 irlOHncS8PU3eOwHVBUXUg8PMjQU+TkvcOxRhKTu8GH7rMImqmIyS1RmxRG6KkMqv
 BTHvLd9MIfYErVyBvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU0q-1woJtv1cnM-00gsOb; Thu, 29
 Oct 2026 23:01:39 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 02/10] target/hppa: restore lazy FPU context isolation
Date: Thu, 29 Oct 2026 23:01:27 +0100
Message-ID: <20261029220135.412284-3-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029220135.412284-1-deller@gmx.de>
References: <20261029220135.412284-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H0IXYFWALlaaGyZljL6tUE4lyzXvt86Mwy1b7CAD7Aaocq9LRfO
 C/qQq8h1a9hT7lrd4e0Awod7RRXVXnWVmbsArs/hvYxYeU8yw3+l8IsBxQldjuHI2uujJyP
 GHJ2JbNlCTH23dRmUvklSIfcTfINM+FUzGWaEabWURFxGxete3/QGzlVswoTa/+SwMRUnwu
 /Df40fjyrOQxIOgi9XJQQ==
UI-OutboundReport: notjunk:1;M01:P0:18RYTxhVb+A=;zlV0ZeSKgWVJA2NTem5DBHHl/58
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
=2D--
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
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -842,6 +842,8 @@ static void hppa_machine_reset(MachineState *ms, Reset=
Type type)
=20
         cpu_set_pc(cs, firmware_entry);
         cpu[i]->env.psw =3D PSW_Q;
+        /* Firmware uses FP registers before configuring CCR. */
+        cpu[i]->env.cr[CR_SCRCCR] =3D 0xc0;
         cpu[i]->env.gr[5] =3D CPU_HPA + i * 0x1000;
     }
=20
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 9d64322398..83104ae0c7 100644
=2D-- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -91,6 +91,7 @@ static TCGTBCPUState hppa_get_tb_cpu_state(CPUState *cs)
 #ifdef CONFIG_USER_ONLY
     flags |=3D TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
 #else
+    flags |=3D TB_FLAG_FPU_DISABLED * !(env->cr[CR_SCRCCR] & 0xc0);
     if ((env->sr[4] =3D=3D env->sr[5])
         & (env->sr[4] =3D=3D env->sr[6])
         & (env->sr[4] =3D=3D env->sr[7])) {
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 8818d47dcd..c0ba787974 100644
=2D-- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -372,6 +372,7 @@ hwaddr hppa_abs_to_phys_pa2_w1(uint8_t phys_addr_bits,=
 vaddr addr);
 #define TB_FLAG_PRIV_SHIFT  8
 #define TB_FLAG_UNALIGN     0x400
 #define TB_FLAG_SPHASH      0x800
+#define TB_FLAG_FPU_DISABLED 0x1000
 #define CS_BASE_DIFFPAGE    (1 << 12)
 #define CS_BASE_DIFFSPACE   (1 << 13)
=20
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 8369855d78..f6c7e16f0f 100644
=2D-- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -82,6 +82,7 @@ DEF_HELPER_FLAGS_4(fmpynfadd_d, TCG_CALL_NO_RWG, i64, en=
v, i64, i64, i64)
 DEF_HELPER_FLAGS_0(read_interval_timer, TCG_CALL_NO_RWG, tl)
=20
 #ifndef CONFIG_USER_ONLY
+DEF_HELPER_5(fpu_mem, noreturn, env, tl, i32, i32, i32)
 DEF_HELPER_1(halt, noreturn, env)
 DEF_HELPER_1(reset, noreturn, env)
 DEF_HELPER_1(rfi, void, env)
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 2393a15507..a5da0bc851 100644
=2D-- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -427,6 +427,21 @@ raise_exception_with_ior(CPUHPPAState *env, int excp,=
 uintptr_t retaddr,
     cpu_loop_exit(cs);
 }
=20
+G_NORETURN void HELPER(fpu_mem)(CPUHPPAState *env, target_ulong addr,
+                               uint32_t mmu_idx, uint32_t mop, uint32_t t=
ype)
+{
+    hwaddr phys;
+    int prot, excp;
+
+    /* Memory faults take priority over the assist emulation trap. */
+    excp =3D hppa_get_physical_address(env, addr, mmu_idx, type, mop, &ph=
ys, &prot);
+    if (excp < 0) {
+        excp =3D EXCP_ASSIST_EMU;
+    }
+    raise_exception_with_ior(env, excp, GETPC(), addr,
+                             MMU_IDX_MMU_DISABLED(mmu_idx));
+}
+
 void hppa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
                                      MMUAccessType access_type,
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 46c0408846..ab3505f9c9 100644
=2D-- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1711,8 +1711,30 @@ static bool do_floadw(DisasContext *ctx, unsigned r=
t, unsigned rb,
     return nullify_end(ctx);
 }
=20
+static bool gen_fmem_excp(DisasContext *ctx, arg_ldst *a, MemOp mop, int =
type)
+{
+#ifndef CONFIG_USER_ONLY
+    TCGv_i64 addr, ofs;
+
+    nullify_over(ctx);
+    form_gva(ctx, &addr, &ofs, a->b, a->x,
+             a->scale ? mop & MO_SIZE : 0, a->disp, a->sp, a->m,
+             MMU_DISABLED(ctx));
+    gen_helper_fpu_mem(tcg_env, addr, tcg_constant_i32(ctx->mmu_idx),
+                       tcg_constant_i32(mop | ctx->mo_align | mo_endian(c=
tx)),
+                       tcg_constant_i32(type));
+    ctx->base.is_jmp =3D DISAS_NORETURN;
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
@@ -1738,6 +1760,9 @@ static bool do_floadd(DisasContext *ctx, unsigned rt=
, unsigned rb,
=20
 static bool trans_fldd(DisasContext *ctx, arg_ldst *a)
 {
+    if (ctx->tb_flags & TB_FLAG_FPU_DISABLED) {
+        return gen_fmem_excp(ctx, a, MO_UQ, PAGE_READ);
+    }
     return do_floadd(ctx, a->t, a->b, a->x, a->scale ? 3 : 0,
                      a->disp, a->sp, a->m);
 }
@@ -1767,6 +1792,9 @@ static bool do_fstorew(DisasContext *ctx, unsigned r=
t, unsigned rb,
=20
 static bool trans_fstw(DisasContext *ctx, arg_ldst *a)
 {
+    if (ctx->tb_flags & TB_FLAG_FPU_DISABLED) {
+        return gen_fmem_excp(ctx, a, MO_UL, PAGE_WRITE);
+    }
     return do_fstorew(ctx, a->t, a->b, a->x, a->scale ? 2 : 0,
                       a->disp, a->sp, a->m);
 }
@@ -1787,6 +1815,9 @@ static bool do_fstored(DisasContext *ctx, unsigned r=
t, unsigned rb,
=20
 static bool trans_fstd(DisasContext *ctx, arg_ldst *a)
 {
+    if (ctx->tb_flags & TB_FLAG_FPU_DISABLED) {
+        return gen_fmem_excp(ctx, a, MO_UQ, PAGE_WRITE);
+    }
     return do_fstored(ctx, a->t, a->b, a->x, a->scale ? 3 : 0,
                       a->disp, a->sp, a->m);
 }
@@ -2311,8 +2342,9 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl=
 *a)
 #endif
         break;
=20
+    case CR_SCRCCR:
     case CR_EIEM:
-        /* Exit to re-evaluate interrupts in the main loop. */
+        /* Exit to re-evaluate translation flags and interrupts. */
         ctx->base.is_jmp =3D DISAS_IAQ_N_STALE_EXIT;
         /* FALLTHRU */
     default:
@@ -4721,6 +4753,31 @@ static void hppa_tr_insn_start(DisasContextBase *dc=
base, CPUState *cs)
     ctx->insn_start_updated =3D false;
 }
=20
+static bool decode_insn(DisasContext *ctx, uint32_t insn)
+{
+#ifndef CONFIG_USER_ONLY
+    if (ctx->tb_flags & TB_FLAG_FPU_DISABLED) {
+        switch (insn >> 26) {
+        case 0x0b:
+            /* Both floating-point uids trap when the coprocessor is disa=
bled. */
+            insn &=3D ~0x40;
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
 static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs=
)
 {
     DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
@@ -4754,7 +4811,7 @@ static void hppa_tr_translate_insn(DisasContextBase =
*dcbase, CPUState *cs)
             ret =3D DISAS_NEXT;
         } else {
             ctx->insn =3D insn;
-            if (!decode(ctx, insn)) {
+            if (!decode_insn(ctx, insn)) {
                 gen_illegal(ctx);
             }
             ret =3D ctx->base.is_jmp;
diff --git a/tests/functional/hppa/test_seabios.py b/tests/functional/hppa=
/test_seabios.py
index bdb9d534ef..9fd42d70ac 100755
=2D-- a/tests/functional/hppa/test_seabios.py
+++ b/tests/functional/hppa/test_seabios.py
@@ -20,8 +20,10 @@ def boot_seabios(self):
         self.vm.add_args('-no-shutdown')
         self.vm.set_console()
         self.vm.launch()
-        wait_for_console_pattern(self, f'SeaBIOS PA-RISC {bits}-bit Firmw=
are')
-        wait_for_console_pattern(self, f'Emulated machine:     HP {mach} =
({bits}-bit')
+        wait_for_console_pattern(self, f'SeaBIOS PA-RISC {bits}-bit Firmw=
are',
+                                 failure_message=3D'SeaBIOS: Detected tra=
p')
+        wait_for_console_pattern(self, f'Emulated machine:     HP {mach} =
({bits}-bit',
+                                 failure_message=3D'SeaBIOS: Detected tra=
p')
=20
     def test_hppa_32(self):
         self.set_machine('B160L')
diff --git a/tests/qtest/hppa-fpu-test.c b/tests/qtest/hppa-fpu-test.c
new file mode 100644
index 0000000000..af4ff2a162
=2D-- /dev/null
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
+/* Enable interruption-state collection through IPSW before entering CODE=
. */
+static const uint32_t bootstrap[] =3D {
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
+ * r20 counts assists. After the first call, the shared CCR writer is ent=
ered
+ * with FP enabled. Alternating its input must reselect the next translat=
ion.
+ */
+static const uint32_t fp_guest[] =3D {
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
+    0x08142880, /* cmpclr,=3D r20,r0,r0: nullify the next instruction */
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
+static const uint32_t fp_site[] =3D {
+    0x01411840, /* mtctl r1,ccr */
+    0x08000240, /* replaced by the FP instruction under test */
+    0xe840c002, /* bv,n 0(rp) */
+};
+
+/* r20 and r26 are outside the shadow register set restored by rfir. */
+static const uint32_t assist_handler[] =3D {
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
+static const uint32_t unexpected_handler[] =3D {
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
+static const uint32_t lazy_guest[] =3D {
+    0x34011000, /* ldi 0x800,r1 */
+    0x01c11840, /* mtctl r1,iva */
+    0x08000240, /* nop */
+    0x34123000, /* ldi 0x1800,r18: owner A */
+    0x34113200, /* ldi 0x1900,r17 */
+    0x34140000, /* ldi 0,r20 */
+    0x34010180, /* ldi 0xc0,r1 */
+    0x01411840, /* mtctl r1,ccr */
+    0x2e40100c, /* fldd 0(r18),fr12 */
+    0x318c0e0c, /* fadd,d fr12,fr12,fr12: A =3D 2 */
+    0x34173240, /* ldi 0x1920,r23 */
+    0x34133020, /* ldi 0x1810,r19: request B */
+    0xe8400390, /* bl 0x1300,rp */
+    0x08000240, /* nop */
+    0x318c0e0c, /* fadd,d fr12,fr12,fr12: B =3D 32 */
+    0x36f70010, /* ldo 8(r23),r23 */
+    0x34133000, /* ldi 0x1800,r19: request A */
+    0xe8400368, /* bl 0x1300,rp */
+    0x08000240, /* nop */
+    0x318c0e0c, /* fadd,d fr12,fr12,fr12: A =3D 4 */
+    0x36f70010, /* ldo 8(r23),r23 */
+    0x34133020, /* ldi 0x1810,r19: request B */
+    0xe8400340, /* bl 0x1300,rp */
+    0x08000240, /* nop */
+    0x318c0e0c, /* fadd,d fr12,fr12,fr12: B =3D 64 */
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
+static const uint32_t lazy_site[] =3D {
+    0x01401840, /* mtctl r0,ccr */
+    0x2ee0120c, /* fstd fr12,0(r23) */
+    0xe840c002, /* bv,n 0(rp) */
+};
+
+static const uint32_t lazy_handler[] =3D {
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
+    for (size_t i =3D 0; i < count; i++) {
+        qtest_writel(qts, addr + 4 * i, words[i]);
+    }
+}
+
+static uint32_t branch(uint32_t pc, uint32_t target)
+{
+    uint32_t d =3D (target - pc - 8) / 4;
+
+    return 0xe8000002 | ((d & 0x10000) >> 16) | ((d & 0xf800) << 5) |
+           ((d & 0x400) >> 8) | ((d & 0x3ff) << 3);
+}
+
+static QTestState *start_guest(bool retry_assist)
+{
+    QTestState *qts =3D qtest_init("-machine none -cpu pa-7300lc -m 1M "
+                                "-S -accel tcg -no-shutdown "
+                                "-device loader,addr=3D0x1000,cpu-num=3D0=
");
+
+    write_words(qts, BOOT, bootstrap, G_N_ELEMENTS(bootstrap));
+    /* Shutdown may re-enter this TB before the main loop stops the CPU. =
*/
+    qtest_writel(qts, HALT, 0xfffdead0);
+    write_words(qts, UNEXPECTED, unexpected_handler,
+                G_N_ELEMENTS(unexpected_handler));
+    for (unsigned int i =3D 0; i < 32; i++) {
+        uint32_t pc =3D 0x800 + i * 32;
+        uint32_t target =3D retry_assist && i =3D=3D 22 ? ASSIST : UNEXPE=
CTED;
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
+    result =3D qtest_readl(qts, RESULT);
+    g_test_message("completion=3D0x%x, result[1]=3D0x%x, result[2]=3D0x%x=
",
+                   result, qtest_readl(qts, RESULT + 4),
+                   qtest_readl(qts, RESULT + 8));
+    g_assert_cmphex(result, =3D=3D, expected);
+}
+
+typedef struct FPTest {
+    const char *name;
+    uint32_t instruction;
+    bool memory;
+    uint64_t fr13;
+} FPTest;
+
+static const FPTest fp_tests[] =3D {
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
+    const FPTest *test =3D opaque;
+    static const uint32_t counts[] =3D { 0, 0, 1, 1, 2, 2, 3 };
+    QTestState *qts =3D start_guest(true);
+
+    write_words(qts, CODE, fp_guest, G_N_ELEMENTS(fp_guest));
+    write_words(qts, FP_CODE, fp_site, G_N_ELEMENTS(fp_site));
+    write_words(qts, ASSIST, assist_handler, G_N_ELEMENTS(assist_handler)=
);
+    qtest_writel(qts, CODE + 13 * 4, test->instruction);
+    qtest_writel(qts, FP_CODE + 4, test->instruction);
+    qtest_writeq(qts, DATA, 0x4000000000000000ULL); /* double 2 */
+    run_guest(qts, 1);
+    for (size_t i =3D 0; i < G_N_ELEMENTS(counts); i++) {
+        g_assert_cmpuint(qtest_readl(qts, RESULT + 4 + 4 * i), =3D=3D, co=
unts[i]);
+    }
+    for (unsigned int i =3D 0; i < 3; i++) {
+        g_assert_cmphex(qtest_readl(qts, LOG + 16 * i), =3D=3D, test->ins=
truction);
+        g_assert_cmphex(qtest_readl(qts, LOG + 16 * i + 4), =3D=3D, FP_CO=
DE + 4);
+        if (test->memory) {
+            g_assert_cmphex(qtest_readl(qts, LOG + 16 * i + 8), =3D=3D, 0=
);
+            g_assert_cmphex(qtest_readl(qts, LOG + 16 * i + 12), =3D=3D, =
DATA);
+        }
+    }
+    g_assert_cmphex(qtest_readq(qts, DATA + 8), =3D=3D, 0x400000000000000=
0ULL);
+    g_assert_cmphex(qtest_readq(qts, DATA + 16), =3D=3D, test->fr13);
+    qtest_quit(qts);
+}
+
+static void test_lazy(void)
+{
+    static const uint64_t markers[] =3D {
+        0x4030000000000000ULL, /* B =3D 16 */
+        0x4000000000000000ULL, /* A =3D 2 */
+        0x4040000000000000ULL, /* B =3D 32 */
+        0x4010000000000000ULL, /* A =3D 4 */
+    };
+    QTestState *qts =3D start_guest(true);
+
+    write_words(qts, CODE, lazy_guest, G_N_ELEMENTS(lazy_guest));
+    write_words(qts, FP_CODE, lazy_site, G_N_ELEMENTS(lazy_site));
+    write_words(qts, ASSIST, lazy_handler, G_N_ELEMENTS(lazy_handler));
+    qtest_writeq(qts, DATA, 0x3ff0000000000000ULL); /* A =3D 1 */
+    qtest_writeq(qts, DATA + 16, markers[0]);
+    run_guest(qts, 1);
+    g_assert_cmpuint(qtest_readl(qts, RESULT + 4), =3D=3D, 4);
+    for (size_t i =3D 0; i < G_N_ELEMENTS(markers); i++) {
+        g_assert_cmphex(qtest_readq(qts, RESULT + 32 + 8 * i), =3D=3D, ma=
rkers[i]);
+    }
+    g_assert_cmphex(qtest_readq(qts, DATA), =3D=3D, 0x4010000000000000ULL=
);
+    g_assert_cmphex(qtest_readq(qts, DATA + 16), =3D=3D, 0x40500000000000=
00ULL);
+    qtest_quit(qts);
+}
+
+static const uint32_t fault_guest[] =3D {
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
+static const FaultTest fault_tests[] =3D {
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
+    const FaultTest *test =3D opaque;
+    uint32_t addr =3D test->address;
+    QTestState *qts =3D start_guest(false);
+
+    write_words(qts, CODE, fault_guest, G_N_ELEMENTS(fault_guest));
+    qtest_writel(qts, CODE + 8, 0x34100000 | (addr << 1));
+    if (test->dtlb) {
+        qtest_writel(qts, CODE + 20, 0x00020d60); /* ssm 2,r0 */
+    }
+    qtest_writel(qts, CODE + 24, test->instruction);
+    run_guest(qts, 0x100 | test->exception);
+    g_assert_cmphex(qtest_readl(qts, RESULT + 4), =3D=3D, test->instructi=
on);
+    g_assert_cmphex(qtest_readl(qts, RESULT + 8), =3D=3D, CODE + 24);
+    if (test->memory) {
+        g_assert_cmphex(qtest_readl(qts, RESULT + 12), =3D=3D, 0);
+        g_assert_cmphex(qtest_readl(qts, RESULT + 16), =3D=3D, addr);
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
+    for (size_t i =3D 0; i < G_N_ELEMENTS(fp_tests); i++) {
+        g_autofree char *name =3D g_strdup_printf("fpu/%s", fp_tests[i].n=
ame);
+
+        qtest_add_data_func(name, &fp_tests[i], test_fp);
+    }
+    qtest_add_func("fpu/lazy-contexts", test_lazy);
+    for (size_t i =3D 0; i < G_N_ELEMENTS(fault_tests); i++) {
+        g_autofree char *name =3D g_strdup_printf("fpu/%s", fault_tests[i=
].name);
+
+        qtest_add_data_func(name, &fault_tests[i], test_fault);
+    }
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 46d4fc1d2b..6a748e005e 100644
=2D-- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -158,6 +158,8 @@ qtests_alpha =3D ['boot-serial-test'] + \
 qtests_avr =3D [ 'boot-serial-test' ]
=20
 qtests_hppa =3D \
+  (config_all_accel.has_key('CONFIG_TCG') and \
+   config_all_devices.has_key('CONFIG_GENERIC_LOADER') ? ['hppa-fpu-test'=
] : []) + \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
=20
=2D-=20
2.56.0


