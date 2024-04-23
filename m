Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D6BC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 06:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz9iJ-0006LF-KT; Tue, 23 Apr 2024 02:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rz9iH-0006KO-IO; Tue, 23 Apr 2024 02:33:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rz9iF-0003Xh-EX; Tue, 23 Apr 2024 02:33:09 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43N4X8o8009760; Tue, 23 Apr 2024 06:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yGHMvl1NXZ9zjIlkbh02PaHRi9hWXbX8mPaIkoKJmYY=;
 b=mXn1Z8aTQYPU27jahl+dY3VkHI1MqCe9JtVWG1wASvEe4g5dTxh9Lfe8X2gV7s8mOivk
 8m+W7mVXxSql+W3TEvvxJJXyGqBW/ScDVRoV149o+ieYo325sCrHLT0Va+YMEtn8GWKf
 YXE1hGeK+/xnvA3Rz048w14+DVmIVb3iRs17VG+CGhEhdCCBWTqkvkt3a7LCfe++gzVw
 aOR/YTSXQVU3LgvwszRFU6lET2Efn1Uy9Uw+2BaJeqtG21sohVRSXkuMLNuk6DH6A7tx
 N64OEfJ3Ts/0DovHM/dNB9Ip73R7xMTSZojKNjeDVc7lZTrUt5zgL9+1q2EBP/uYSLpD 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp620g80w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:33:04 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N6X4cd024947;
 Tue, 23 Apr 2024 06:33:04 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp620g80v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:33:04 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43N5R1UN028319; Tue, 23 Apr 2024 06:33:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr2bky3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:33:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43N6WxtY46465396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Apr 2024 06:33:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FB5D20043;
 Tue, 23 Apr 2024 06:32:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50D2120040;
 Tue, 23 Apr 2024 06:32:58 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Apr 2024 06:32:58 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v2 5/8] target/ppc: Move multiply fixed-point insns (64-bit
 operands) to decodetree.
Date: Tue, 23 Apr 2024 12:02:31 +0530
Message-Id: <20240423063234.76282-6-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240423063234.76282-1-rathc@linux.ibm.com>
References: <20240423063234.76282-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yoM70x5L1nkEQDTNPQbUJKWFuGhc7HZQ
X-Proofpoint-ORIG-GUID: fBKWwLxa4TCzu2VBTl4dEPOcIJvLO_GN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Moving the following instructions to decodetree :

	mul{ld, ldo, hd, hdu}[.]	: XO-form
	madd{hd, hdu, ld}		: VA-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op'
flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/insn32.decode                   |   9 ++
 target/ppc/translate.c                     | 101 ---------------------
 target/ppc/translate/fixedpoint-impl.c.inc |  85 +++++++++++++++++
 3 files changed, 94 insertions(+), 101 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 654f55471b..61c59bbde0 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -375,6 +375,15 @@ MODUW           011111 ..... ..... ..... 0100001011 -   @X
 DARN            011111 ..... --- .. ----- 1011110011 -  @X_tl
 NEG             011111 ..... ..... ----- . 001101000 .  @XO_ta
 
+MULLD           011111 ..... ..... ..... 0 011101001 .  @XO_tab_rc
+MULLDO          011111 ..... ..... ..... 1 011101001 .  @XO_tab_rc
+MULHD           011111 ..... ..... ..... - 001001001 .  @XO_tab_rc
+MULHDU          011111 ..... ..... ..... - 000001001 .  @XO_tab_rc
+
+MADDLD          000100 ..... ..... ..... ..... 110011   @VA
+MADDHD          000100 ..... ..... ..... ..... 110000   @VA
+MADDHDU         000100 ..... ..... ..... ..... 110001   @VA
+
 ## Fixed-Point Logical Instructions
 
 CFUGED          011111 ..... ..... ..... 0011011100 -   @X
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 436fcfc645..8fa125d0ae 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1918,62 +1918,6 @@ GEN_INT_ARITH_MODD(modud, 0x08, 0);
 GEN_INT_ARITH_MODD(modsd, 0x18, 1);
 #endif
 
-#if defined(TARGET_PPC64)
-/* mulhd  mulhd. */
-static void gen_mulhd(DisasContext *ctx)
-{
-    TCGv lo = tcg_temp_new();
-    tcg_gen_muls2_tl(lo, cpu_gpr[rD(ctx->opcode)],
-                     cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-/* mulhdu  mulhdu. */
-static void gen_mulhdu(DisasContext *ctx)
-{
-    TCGv lo = tcg_temp_new();
-    tcg_gen_mulu2_tl(lo, cpu_gpr[rD(ctx->opcode)],
-                     cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-/* mulld  mulld. */
-static void gen_mulld(DisasContext *ctx)
-{
-    tcg_gen_mul_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
-                   cpu_gpr[rB(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-/* mulldo  mulldo. */
-static void gen_mulldo(DisasContext *ctx)
-{
-    TCGv_i64 t0 = tcg_temp_new_i64();
-    TCGv_i64 t1 = tcg_temp_new_i64();
-
-    tcg_gen_muls2_i64(t0, t1, cpu_gpr[rA(ctx->opcode)],
-                      cpu_gpr[rB(ctx->opcode)]);
-    tcg_gen_mov_i64(cpu_gpr[rD(ctx->opcode)], t0);
-
-    tcg_gen_sari_i64(t0, t0, 63);
-    tcg_gen_setcond_i64(TCG_COND_NE, cpu_ov, t0, t1);
-    if (is_isa300(ctx)) {
-        tcg_gen_mov_tl(cpu_ov32, cpu_ov);
-    }
-    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
-
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-#endif
-
 /* Common subf function */
 static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
                                      TCGv arg2, bool add_ca, bool compute_ca,
@@ -5884,36 +5828,6 @@ static void gen_icbt_440(DisasContext *ctx)
      */
 }
 
-#if defined(TARGET_PPC64)
-static void gen_maddld(DisasContext *ctx)
-{
-    TCGv_i64 t1 = tcg_temp_new_i64();
-
-    tcg_gen_mul_i64(t1, cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]);
-    tcg_gen_add_i64(cpu_gpr[rD(ctx->opcode)], t1, cpu_gpr[rC(ctx->opcode)]);
-}
-
-/* maddhd maddhdu */
-static void gen_maddhd_maddhdu(DisasContext *ctx)
-{
-    TCGv_i64 lo = tcg_temp_new_i64();
-    TCGv_i64 hi = tcg_temp_new_i64();
-    TCGv_i64 t1 = tcg_temp_new_i64();
-
-    if (Rc(ctx->opcode)) {
-        tcg_gen_mulu2_i64(lo, hi, cpu_gpr[rA(ctx->opcode)],
-                          cpu_gpr[rB(ctx->opcode)]);
-        tcg_gen_movi_i64(t1, 0);
-    } else {
-        tcg_gen_muls2_i64(lo, hi, cpu_gpr[rA(ctx->opcode)],
-                          cpu_gpr[rB(ctx->opcode)]);
-        tcg_gen_sari_i64(t1, cpu_gpr[rC(ctx->opcode)], 63);
-    }
-    tcg_gen_add2_i64(t1, cpu_gpr[rD(ctx->opcode)], lo, hi,
-                     cpu_gpr[rC(ctx->opcode)], t1);
-}
-#endif /* defined(TARGET_PPC64) */
-
 static void gen_tbegin(DisasContext *ctx)
 {
     if (unlikely(!ctx->tm_enabled)) {
@@ -6277,9 +6191,6 @@ GEN_HANDLER_E(cmpeqb, 0x1F, 0x00, 0x07, 0x00600000, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(cmpb, 0x1F, 0x1C, 0x0F, 0x00000001, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER_E(cmprb, 0x1F, 0x00, 0x06, 0x00400001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(isel, 0x1F, 0x0F, 0xFF, 0x00000001, PPC_ISEL),
-#if defined(TARGET_PPC64)
-GEN_HANDLER(mulld, 0x1F, 0x09, 0x07, 0x00000000, PPC_64B),
-#endif
 GEN_HANDLER2(andi_, "andi.", 0x1C, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER2(andis_, "andis.", 0x1D, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(cntlzw, 0x1F, 0x1A, 0x00, 0x00000000, PPC_INTEGER),
@@ -6483,11 +6394,6 @@ GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, 0x00000001, PPC_ALTIVEC),
 GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
 GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
 GEN_HANDLER(mtvscr, 0x04, 0x2, 0x19, 0x03ff0000, PPC_ALTIVEC),
-#if defined(TARGET_PPC64)
-GEN_HANDLER_E(maddhd_maddhdu, 0x04, 0x18, 0xFF, 0x00000000, PPC_NONE,
-              PPC2_ISA300),
-GEN_HANDLER_E(maddld, 0x04, 0x19, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA300),
-#endif
 
 #if defined(TARGET_PPC64)
 #undef GEN_INT_ARITH_DIVD
@@ -6504,13 +6410,6 @@ GEN_HANDLER_E(divde, 0x1F, 0x09, 0x0D, 0, PPC_NONE, PPC2_DIVE_ISA206),
 GEN_HANDLER_E(divdeo, 0x1F, 0x09, 0x1D, 0, PPC_NONE, PPC2_DIVE_ISA206),
 GEN_HANDLER_E(modsd, 0x1F, 0x09, 0x18, 0x00000001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(modud, 0x1F, 0x09, 0x08, 0x00000001, PPC_NONE, PPC2_ISA300),
-
-#undef GEN_INT_ARITH_MUL_HELPER
-#define GEN_INT_ARITH_MUL_HELPER(name, opc3)                                  \
-GEN_HANDLER(name, 0x1F, 0x09, opc3, 0x00000000, PPC_64B)
-GEN_INT_ARITH_MUL_HELPER(mulhdu, 0x00),
-GEN_INT_ARITH_MUL_HELPER(mulhd, 0x02),
-GEN_INT_ARITH_MUL_HELPER(mulldo, 0x17),
 #endif
 
 #undef GEN_LOGICAL1
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 1be27150d5..d9a5db83b3 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -529,6 +529,91 @@ static bool trans_DARN(DisasContext *ctx, arg_DARN *a)
     return true;
 }
 
+static bool trans_MULLD(DisasContext *ctx, arg_MULLD *a)
+{
+    REQUIRE_64BIT(ctx);
+    tcg_gen_mul_tl(cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb]);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+    }
+    return true;
+}
+
+static bool trans_MULLDO(DisasContext *ctx, arg_MULLD *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    REQUIRE_64BIT(ctx);
+    tcg_gen_muls2_i64(t0, t1, cpu_gpr[a->ra], cpu_gpr[a->rb]);
+    tcg_gen_mov_i64(cpu_gpr[a->rt], t0);
+
+    tcg_gen_sari_i64(t0, t0, 63);
+    tcg_gen_setcond_i64(TCG_COND_NE, cpu_ov, t0, t1);
+    if (is_isa300(ctx)) {
+        tcg_gen_mov_tl(cpu_ov32, cpu_ov);
+    }
+    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
+
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+    }
+    return true;
+}
+
+static bool do_mulhd(DisasContext *ctx, arg_XO_tab_rc *a,
+                     void (*helper)(TCGv, TCGv, TCGv, TCGv))
+{
+    TCGv lo = tcg_temp_new();
+    helper(lo, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb]);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+    }
+    return true;
+}
+
+TRANS64(MULHD, do_mulhd, tcg_gen_muls2_tl);
+TRANS64(MULHDU, do_mulhd, tcg_gen_mulu2_tl);
+
+static bool trans_MADDLD(DisasContext *ctx, arg_MADDLD *a)
+{
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    tcg_gen_mul_i64(t1, cpu_gpr[a->vra], cpu_gpr[a->vrb]);
+    tcg_gen_add_i64(cpu_gpr[a->vrt], t1, cpu_gpr[a->rc]);
+    return true;
+}
+
+static bool trans_MADDHD(DisasContext *ctx, arg_MADDHD *a)
+{
+    TCGv_i64 lo = tcg_temp_new_i64();
+    TCGv_i64 hi = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    tcg_gen_muls2_i64(lo, hi, cpu_gpr[a->vra], cpu_gpr[a->vrb]);
+    tcg_gen_sari_i64(t1, cpu_gpr[a->rc], 63);
+    tcg_gen_add2_i64(t1, cpu_gpr[a->vrt], lo, hi, cpu_gpr[a->rc], t1);
+    return true;
+}
+
+static bool trans_MADDHDU(DisasContext *ctx, arg_MADDHDU *a)
+{
+    TCGv_i64 lo = tcg_temp_new_i64();
+    TCGv_i64 hi = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    tcg_gen_mulu2_i64(lo, hi, cpu_gpr[a->vra], cpu_gpr[a->vrb]);
+    tcg_gen_add2_i64(t1, cpu_gpr[a->vrt], lo, hi, cpu_gpr[a->rc],
+                     tcg_constant_i64(0));
+    return true;
+}
+
 static bool trans_INVALID(DisasContext *ctx, arg_INVALID *a)
 {
     gen_invalid(ctx);
-- 
2.39.3


