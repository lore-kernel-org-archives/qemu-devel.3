Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75AF606A323
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=j57D8anU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN4Si-0001lh-BF; Sat, 31 Oct 2026 04:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4SV-0001iw-Ck
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:04 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4SP-0001rf-Tp
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793435334; x=1794040134; i=deller@gmx.de;
 bh=FmptSiXEFYbchF2FQCG3ItB8N7tEQf2Q9Mf5WU4hoKo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=j57D8anU2H2FazBvf5z13P7mbDLI/Ly3aUBoIlbHZ4Sj1DaCLN7G2gbhTwCGpENj
 l0bASetI6HwolbxkDFx6/a29BRUf5SzkA4GYNHwoi/nHjK3PPshPK78Jp5IG3hcZU
 feDVuscEry6aLjuanrw4O2j+WZZ2SfhZ9e+aJEwozv12BA09UANCR796GoTXE7UpC
 1Y0+GUsY9Nf4JKOljPdVCwsdfq1bRaVtWSwxMw0i9n0bG1aGmQopKGf/Aq6Yi2u3h
 /uE98v3ikVJKXm2GKZZmtaeWFq9xMIujvBpM2dFysdnKF0OmYfuva/qRd2LbvlzG6
 IJ2vpTwHxUT3FEYdAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Ux-1wataX2DuV-017FDy; Sat, 31
 Oct 2026 09:28:54 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Fabiano Rosas <farosas@suse.de>,
 "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 02/10] target/hppa: restore lazy FPU context isolation
Date: Sat, 31 Oct 2026 09:28:42 +0100
Message-ID: <20261031082850.439293-3-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031082850.439293-1-deller@gmx.de>
References: <20261031082850.439293-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MG6/R1iF0mlJiepwiKAGJ8vmiqYoiFs9Cy6Lz/fWtDGjHlI5ZvI
 rMd9MZZYjKwzr2y+KAT3PFmf2D81oX5QFhHENy18Jrf0SUrVcSHWbb9q5LTdE1MyTkHSKsb
 30s2gMks8PYPLn3RKKyGop5VpzNj0RCVdOsZXNDEpG1ReLSHTxYmx7ZKeS66UnsFCIOIzeB
 lnZfyWb6/x4nXqZZFWPUg==
UI-OutboundReport: notjunk:1;M01:P0:Kp01wodFiW4=;F3QRx/RvG7JHRSvCNAyb8T8DAst
 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
 Ofakn
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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


