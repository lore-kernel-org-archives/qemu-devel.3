Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F4606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL24L-0000xB-Jz; Sun, 25 Oct 2026 13:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL23m-0000j2-KD; Sun, 25 Oct 2026 13:31:12 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL23k-0007IB-38; Sun, 25 Oct 2026 13:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=j3TyNMZ+FhVgZXveP5/NoYhCpKoL34F2hog7VU2itRY=; b=sG8+vDw8X3E/8kwbKlNSf7O03U
 //l8hBKvd82vvkR6IZ+IWT2yzpHp/RBWlZ05T6xH1DTOV6VSzoCcWvjCbpLbThLk3EczhlFcvf/g7
 kSOT9uPgCMig0rI7SD3ZwJsED9cmjSfLPWu1Z9R1uEBhECBT2TwcbwnxrDlCGk0r8AMd4wna3DHxp
 w/5SF/NHbPbCNxwXGOQLE92vxf0qF0qtHDDpXbioVhUM3fQtnZrOyI0kA506lrmxfwrSP3Antkl0j
 qYRvHm/hthIDeuzceTvgb3Pe3WDgCBsASv5/PTI1cIDIJ+tUFaBEBzBSYQtjoNpz0VHed1+P1iNvF
 NRkQPJHg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-0006kb-1A; Sun, 25 Oct 2026 17:56:07 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-000OzG-1u; Sun, 25 Oct 2026 17:56:07 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:22 +0100
Subject: [PATCH v2 06/31] target/rx: add DPFPU arithmetic instructions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-6-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=13328;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=vLMbC4PdMzmegJKQfm9hB0POYJK4eI93AwogTOJ8C/A=;
 b=0EfVuxwwmMd87eP2njcwbo1lg1xAcBq6hFEfNIAI0CziXEK/9DXBl9MrsUIIsomnhnaHZhgSe
 0AoVsrGwm0vBMDxLgbNalsVFBK29KNpZ/NbNtLZhasb7iZlL4yyAlL9
X-Developer-Key: i=contact@sayyadumar.com; a=ed25519;
 pk=CsAjTLRCB7+pnzmj8902JER4gL8CTzNQFxlMZTl4wDk=
X-Virus-Scanned: Clear (ClamAV 1.4.6/28164/Sun Oct 25 07:24:12 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add DADD, DSUB, DMUL, DDIV and DCMP. The DPFPU has its own status
word, so double-precision arithmetic runs on a separate float_status:
dp_begin() applies DPSW's rounding mode and update_dpsw() records the
outcome in the DC*/DF* bits. DCMP records its result in DCMR.RES
rather than touching the PSW.

The DPFPU exists on the RX64M/RX71M (RXv2) and RX72M (RXv3); the only
RXv2 model currently in QEMU, the RX65N, has no FPU at all, so these
instructions are gated on RX_ISA_V3 for now.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/disas.c      |  34 +++++++++++
 target/rx/helper.h     |   6 ++
 target/rx/insns.decode |  15 +++++
 target/rx/op_helper.c  | 155 +++++++++++++++++++++++++++++++++++++++++++++++++
 target/rx/translate.c  |  78 +++++++++++++++++++++++++
 5 files changed, 288 insertions(+)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 34cfe6f0ec..98882044be 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -133,6 +133,9 @@ static const char cond[][4] = {
     "eq", "ne", "c", "nc", "gtu", "leu", "pz", "n",
     "ge", "lt", "gt", "le", "o", "no", "ra", "f"
 };
+static const char dcmp_cond[8][3] = {
+    "", "un", "eq", "", "lt", "", "le", ""
+};
 static const char psw[] = {
     'c', 'z', 's', 'o', 0, 0, 0, 0,
     'i', 'u', 0, 0, 0, 0, 0, 0,
@@ -1209,6 +1212,37 @@ static bool trans_UTOF(DisasContext *ctx, arg_UTOF *a)
     return true;
 }
 
+/* RXv2 DPFPU disassembly */
+static bool trans_DADD(DisasContext *ctx, arg_DADD *a)
+{
+    prt("dadd\tdr%d, dr%d, dr%d", a->drs1, a->drs2, a->drd);
+    return true;
+}
+
+static bool trans_DSUB(DisasContext *ctx, arg_DSUB *a)
+{
+    prt("dsub\tdr%d, dr%d, dr%d", a->drs1, a->drs2, a->drd);
+    return true;
+}
+
+static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
+{
+    prt("dmul\tdr%d, dr%d, dr%d", a->drs1, a->drs2, a->drd);
+    return true;
+}
+
+static bool trans_DDIV(DisasContext *ctx, arg_DDIV *a)
+{
+    prt("ddiv\tdr%d, dr%d, dr%d", a->drs1, a->drs2, a->drd);
+    return true;
+}
+
+static bool trans_DCMP(DisasContext *ctx, arg_DCMP *a)
+{
+    prt("dcmp%s\tdr%d, dr%d", dcmp_cond[a->cd & 7], a->drs1, a->drs2);
+    return true;
+}
+
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
         char dsp[8];                                            \
diff --git a/target/rx/helper.h b/target/rx/helper.h
index 63cfe48e6b..e39f4b65ae 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -13,6 +13,12 @@ DEF_HELPER_2(ftou, i32, env, f32)
 DEF_HELPER_2(round, i32, env, f32)
 DEF_HELPER_2(itof, f32, env, i32)
 DEF_HELPER_2(utof, f32, env, i32)
+/* RXv3 double-precision FPU (DPFPU) helpers */
+DEF_HELPER_3(dadd, f64, env, f64, f64)
+DEF_HELPER_3(dsub, f64, env, f64, f64)
+DEF_HELPER_3(dmul, f64, env, f64, f64)
+DEF_HELPER_3(ddiv, f64, env, f64, f64)
+DEF_HELPER_4(dcmp, void, env, i32, f64, f64)
 DEF_HELPER_2(set_fpsw, void, env, i32)
 DEF_HELPER_2(racw, void, env, i32)
 DEF_HELPER_2(set_psw_rte, void, env, i32)
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index e9ace9624c..e22536a9e0 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -29,6 +29,9 @@
 &mi		rs ld mi imm
 &mr		rs ld mi rs2
 &mcnd		ld sz rd cd
+# RXv3 DPFPU argument types
+&drrr		drd drs1 drs2
+&dcmpd		drs1 drs2 cd
 ########
 %b1_bdsp	24:3 !function=bdsp_s
 
@@ -628,3 +631,15 @@ XOR_ir		1111 1101 0111 ..00 1101 ....		@b3_rd_li
 XOR_mr		1111 1100 0011 01.. .... ....		@b3_rd_ld_ub
 # XOR dsp[rs], rd
 XOR_mr		0000 0110 ..10 00.. 0000 1101 .... ....	@b4_rd_ldmi
+
+########
+# RXv2 DPFPU instructions
+# All 4-byte register-to-register ops use prefix 0x76 0x90
+#
+# Binary ops: 0111 0110 1001 0000 drs2:4 op:4 drd:4 drs1:4
+# Result: DRdrd = DRdrs1 op DRdrs2
+DADD		0111 0110 1001 0000 drs2:4 0000 drd:4 drs1:4	&drrr
+DSUB		0111 0110 1001 0000 drs2:4 0001 drd:4 drs1:4	&drrr
+DMUL		0111 0110 1001 0000 drs2:4 0010 drd:4 drs1:4	&drrr
+DDIV		0111 0110 1001 0000 drs2:4 0101 drd:4 drs1:4	&drrr
+DCMP		0111 0110 1001 0000 drs2:4 1000 cd:4  drs1:4	&dcmpd
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 114cc235f3..61277b7581 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
@@ -152,6 +153,160 @@ FLOATOP(rx_fsub, float32_sub)
 FLOATOP(rx_fmul, float32_mul)
 FLOATOP(rx_fdiv, float32_div)
 
+/*
+ * RXv3 double-precision FPU helpers.
+ *
+ * The DPFPU has its own status word: "The single-precision floating-point
+ * status word (FPSW) is neither referred to nor updated in double-precision
+ * floating-point arithmetic operations." DPSW carries its own rounding mode
+ * (DRM) and denormal handling (DDN), so double precision runs on a separate
+ * softfloat state rather than sharing fp_status. The PSW is not touched
+ * either; DCMP records its answer in DCMR and MVFDR moves it to PSW.Z.
+ */
+#define SET_DPSW(b)                                                     \
+    do {                                                                \
+        dpsw = FIELD_DP32(dpsw, DPSW, DC ## b, 1);                      \
+        if (!FIELD_EX32(dpsw, DPSW, DE ## b)) {                         \
+            dpsw = FIELD_DP32(dpsw, DPSW, DF ## b, 1);                  \
+        }                                                               \
+    } while (0)
+
+/* Apply DPSW's rounding mode and clear the sticky softfloat flags. */
+static void dp_begin(CPURXState *env)
+{
+    static const int roundmode[] = {
+        float_round_nearest_even,
+        float_round_to_zero,
+        float_round_up,
+        float_round_down,
+    };
+    uint32_t dpsw = env->dcr[RX_DCR_DPSW];
+
+    set_float_rounding_mode(roundmode[FIELD_EX32(dpsw, DPSW, DRM)],
+                            &env->dp_status);
+    set_float_exception_flags(0, &env->dp_status);
+}
+
+/*
+ * Record the outcome of a DP arithmetic instruction in DPSW. Every such
+ * instruction except DABS and DNEG recomputes the DC* cause bits, so they
+ * are cleared first; the DF* flags accumulate and are only set while the
+ * matching DE* enable is clear.
+ */
+static void update_dpsw(CPURXState *env)
+{
+    uint32_t decnt = env->dcr[RX_DCR_DECNT];
+    uint32_t dpsw = env->dcr[RX_DCR_DPSW];
+    int xcpt = get_float_exception_flags(&env->dp_status);
+    int cause, enable;
+
+    /* DPSW and DEPC stop updating while exception info is preserved. */
+    if (FIELD_EX32(decnt, DECNT, EHM) && FIELD_EX32(decnt, DECNT, EHS)) {
+        return;
+    }
+
+    dpsw = FIELD_DP32(dpsw, DPSW, CAUSE, 0);
+
+    if (xcpt & float_flag_invalid) {
+        SET_DPSW(V);
+    }
+    if (xcpt & float_flag_divbyzero) {
+        SET_DPSW(Z);
+    }
+    if (xcpt & float_flag_overflow) {
+        SET_DPSW(O);
+    }
+    if (xcpt & float_flag_underflow) {
+        SET_DPSW(U);
+    }
+    if (xcpt & float_flag_inexact) {
+        SET_DPSW(X);
+    }
+    /*
+     * A denormal the DPFPU cannot handle is an unimplemented processing
+     * exception, which is reported only while DDN says denormals are to be
+     * treated as denormals.
+     */
+    if ((xcpt & (float_flag_input_denormal_flushed
+                 | float_flag_output_denormal_flushed))
+        && !FIELD_EX32(dpsw, DPSW, DDN)) {
+        dpsw = FIELD_DP32(dpsw, DPSW, DCE, 1);
+    }
+
+    dpsw = FIELD_DP32(dpsw, DPSW, DFS,
+                      FIELD_EX32(dpsw, DPSW, FLAGS) != 0);
+    env->dcr[RX_DCR_DPSW] = dpsw;
+
+    /*
+     * An enabled DP exception is delivered as an interrupt request to the
+     * interrupt controller rather than as a CPU exception, and suppresses
+     * the write to the destination register. Neither is modelled: the cause
+     * and flag bits above are correct, but the interrupt is not raised and
+     * the destination is written regardless.
+     */
+    cause = FIELD_EX32(dpsw, DPSW, CAUSE);
+    enable = FIELD_EX32(dpsw, DPSW, ENABLE);
+    if (cause & enable) {
+        qemu_log_mask(LOG_UNIMP,
+                      "rx: enabled DPFPU exception (DPSW=0x%08x) does not "
+                      "raise an interrupt\n", dpsw);
+    }
+}
+
+#define FLOATOP64(op, func)                                             \
+    float64 helper_##op(CPURXState *env, float64 t0, float64 t1)        \
+    {                                                                   \
+        float64 ret;                                                    \
+        dp_begin(env);                                                  \
+        ret = func(t0, t1, &env->dp_status);                            \
+        update_dpsw(env);                                               \
+        return ret;                                                     \
+    }
+
+FLOATOP64(dadd, float64_add)
+FLOATOP64(dsub, float64_sub)
+FLOATOP64(dmul, float64_mul)
+FLOATOP64(ddiv, float64_div)
+
+/*
+ * dcmp<cm> src, src2 -- compare src2 against src as directed by cm and
+ * record the answer in DCMR.RES.
+ *
+ * Mind the operand order: the manual defines every relation as src2 REL
+ * src, so LT is true when the *second* operand is the smaller one. src is
+ * the first encoded register (drs1) and src2 the second (drs2).
+ *
+ * The PSW is left alone -- C, Z, S and O are all listed as unchanged --
+ * which is why MVFDR exists to move DCMR.RES into PSW.Z.
+ *
+ * The condition field is a mask of the relations that make RES true, which
+ * is why LE (6) is LT (4) | EQ (2); it agrees with the manual on all four
+ * documented conditions. UN is defined as isNaN(src) || isNaN(src2), which
+ * is exactly what an unordered comparison reports. The comparison is quiet
+ * because testing for unordered is one of the conditions on offer.
+ */
+void helper_dcmp(CPURXState *env, uint32_t cm, float64 src, float64 src2)
+{
+    int st;
+    bool res = false;
+
+    dp_begin(env);
+    st = float64_compare_quiet(src2, src, &env->dp_status);
+
+    if ((cm & RX_DCMP_UN) && st == float_relation_unordered) {
+        res = true;
+    }
+    if ((cm & RX_DCMP_EQ) && st == float_relation_equal) {
+        res = true;
+    }
+    if ((cm & RX_DCMP_LT) && st == float_relation_less) {
+        res = true;
+    }
+    env->dcr[RX_DCR_DCMR] = deposit32(env->dcr[RX_DCR_DCMR],
+                                      RX_DCMR_RES_BIT, 1, res);
+    update_dpsw(env);
+}
+
 void helper_rx_fcmp(CPURXState *env, float32 t0, float32 t1)
 {
     int st;
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 43fd88b15d..2eb0b7b39e 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -1949,6 +1949,84 @@ static bool trans_UTOF(DisasContext *ctx, arg_UTOF * a)
     return true;
 }
 
+/*
+ * RXv3 DPFPU register access. DR0-DR15 are dedicated 64-bit registers,
+ * architecturally distinct from the general purpose registers; DRHn and
+ * DRLn name the high and low 32-bit halves of DRn.
+ */
+static TCGv_i64 dr_read(int n)
+{
+    return cpu_dregs[n];
+}
+
+static void dr_write(int n, TCGv_i64 val)
+{
+    tcg_gen_mov_i64(cpu_dregs[n], val);
+}
+
+/* dadd DRdrs1, DRdrd, DRdrs2  (DRdrd = DRdrs1 + DRdrs2) */
+static bool trans_DADD(DisasContext *ctx, arg_DADD *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s1 = dr_read(a->drs1);
+    TCGv_i64 s2 = dr_read(a->drs2);
+    TCGv_i64 d  = tcg_temp_new_i64();
+    gen_helper_dadd(d, tcg_env, s1, s2);
+    dr_write(a->drd, d);
+    return true;
+}
+
+static bool trans_DSUB(DisasContext *ctx, arg_DSUB *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s1 = dr_read(a->drs1);
+    TCGv_i64 s2 = dr_read(a->drs2);
+    TCGv_i64 d  = tcg_temp_new_i64();
+    gen_helper_dsub(d, tcg_env, s1, s2);
+    dr_write(a->drd, d);
+    return true;
+}
+
+static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s1 = dr_read(a->drs1);
+    TCGv_i64 s2 = dr_read(a->drs2);
+    TCGv_i64 d  = tcg_temp_new_i64();
+    gen_helper_dmul(d, tcg_env, s1, s2);
+    dr_write(a->drd, d);
+    return true;
+}
+
+static bool trans_DDIV(DisasContext *ctx, arg_DDIV *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s1 = dr_read(a->drs1);
+    TCGv_i64 s2 = dr_read(a->drs2);
+    TCGv_i64 d  = tcg_temp_new_i64();
+    gen_helper_ddiv(d, tcg_env, s1, s2);
+    dr_write(a->drd, d);
+    return true;
+}
+
+static bool trans_DCMP(DisasContext *ctx, arg_DCMP *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    gen_helper_dcmp(tcg_env, tcg_constant_i32(a->cd),
+                    cpu_dregs[a->drs1], cpu_dregs[a->drs2]);
+    return true;
+}
+
 static void rx_bsetm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
     TCGv_i32 val;

-- 
2.53.0


