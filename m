Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9ABC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 06:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz9iN-0006Q9-Qg; Tue, 23 Apr 2024 02:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rz9iL-0006Mv-9A; Tue, 23 Apr 2024 02:33:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rz9iJ-0003YH-3c; Tue, 23 Apr 2024 02:33:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43N6VCKD017656; Tue, 23 Apr 2024 06:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VrIktk/ljSNau8NiJ1DhcywbPzNhH+kE6Zfhk1x1nfc=;
 b=srY8PWcJ0goxQ/nvUfn8UAjx5P2Z1H7vpBmwVycgDIfkrnK2Mws8+DzUgsCZvmZ9dIDX
 TeRvdc3sFu/gF/ZabboUykvMKygH4yhHWvkZ5T6d+k6e+Cki7lXWvSlfQCxfY7DRAR2K
 7ekAPkbIhJjmu0XSGhygna8bcKT74YMQGdIHF+SgpP3IX4YRexQuzgl1WAKVeze8iYIo
 FDLm1A0OWnjBvyg8tcrPjC9C8/CfS9j5/Z2Ji1lmf0tbscRxPyx2tToVCl8hd923jE3u
 Oet9fuvyNfzuK9rsBSR8GlM/6e8MTBazFt2Hy4JT17y5NaLQZhN3ZvLbJU6HuRA8xGm6 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp72r02hb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:33:08 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N6X7nV021176;
 Tue, 23 Apr 2024 06:33:07 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp72r02h9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:33:07 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43N584AB005352; Tue, 23 Apr 2024 06:33:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3catb5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:33:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43N6X3i247841726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Apr 2024 06:33:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E01D72005A;
 Tue, 23 Apr 2024 06:33:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F51A20063;
 Tue, 23 Apr 2024 06:33:01 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Apr 2024 06:33:01 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v2 6/8] target/ppc: Move div/mod fixed-point insns (64 bits
 operands) to decodetree.
Date: Tue, 23 Apr 2024 12:02:32 +0530
Message-Id: <20240423063234.76282-7-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240423063234.76282-1-rathc@linux.ibm.com>
References: <20240423063234.76282-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: inU78Lgzlpl_sFgV5txnVsE2XG9Hv-nT
X-Proofpoint-GUID: Qy7cdNEu8Qz5TTRwsCmqqqrtdG0W23VP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 mlxscore=0 phishscore=0 priorityscore=1501
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

Moving the below instructions to decodetree specification :

	divd[u, e, eu][o][.]	: XO-form
	mod{sd, ud}		: X-form

With this patch, all the fixed-point arithmetic instructions have been
moved to decodetree.
The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured using the '-d in_asm,op' flag.
Also, remaned do_divwe method in fixedpoint-impl.c.inc to do_dive because it is
now used to divide doubleword operands as well, and not just words.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                        |  4 +-
 target/ppc/insn32.decode                   |  8 +++
 target/ppc/int_helper.c                    |  4 +-
 target/ppc/translate.c                     | 65 ++--------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 29 +++++++++-
 5 files changed, 42 insertions(+), 68 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 09d0b0074b..e862bdceaf 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -52,8 +52,8 @@ DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
 
 #if defined(TARGET_PPC64)
-DEF_HELPER_4(divdeu, i64, env, i64, i64, i32)
-DEF_HELPER_4(divde, i64, env, i64, i64, i32)
+DEF_HELPER_4(DIVDEU, i64, env, i64, i64, i32)
+DEF_HELPER_4(DIVDE, i64, env, i64, i64, i32)
 #endif
 DEF_HELPER_4(DIVWEU, tl, env, tl, tl, i32)
 DEF_HELPER_4(DIVWE, tl, env, tl, tl, i32)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 61c59bbde0..509961023b 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -384,6 +384,14 @@ MADDLD          000100 ..... ..... ..... ..... 110011   @VA
 MADDHD          000100 ..... ..... ..... ..... 110000   @VA
 MADDHDU         000100 ..... ..... ..... ..... 110001   @VA
 
+DIVD            011111 ..... ..... ..... . 111101001 .  @XO
+DIVDU           011111 ..... ..... ..... . 111001001 .  @XO
+DIVDE           011111 ..... ..... ..... . 110101001 .  @XO
+DIVDEU          011111 ..... ..... ..... . 110001001 .  @XO
+
+MODSD           011111 ..... ..... ..... 1100001001 -   @X
+MODUD           011111 ..... ..... ..... 0100001001 -   @X
+
 ## Fixed-Point Logical Instructions
 
 CFUGED          011111 ..... ..... ..... 0011011100 -   @X
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index bc25d5b062..585c2b65d3 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -101,7 +101,7 @@ target_ulong helper_DIVWE(CPUPPCState *env, target_ulong ra, target_ulong rb,
 
 #if defined(TARGET_PPC64)
 
-uint64_t helper_divdeu(CPUPPCState *env, uint64_t ra, uint64_t rb, uint32_t oe)
+uint64_t helper_DIVDEU(CPUPPCState *env, uint64_t ra, uint64_t rb, uint32_t oe)
 {
     uint64_t rt = 0;
     int overflow = 0;
@@ -120,7 +120,7 @@ uint64_t helper_divdeu(CPUPPCState *env, uint64_t ra, uint64_t rb, uint32_t oe)
     return rt;
 }
 
-uint64_t helper_divde(CPUPPCState *env, uint64_t rau, uint64_t rbu, uint32_t oe)
+uint64_t helper_DIVDE(CPUPPCState *env, uint64_t rau, uint64_t rbu, uint32_t oe)
 {
     uint64_t rt = 0;
     int64_t ra = (int64_t)rau;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 8fa125d0ae..8900da85e5 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1778,21 +1778,11 @@ static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret,
         gen_set_Rc0(ctx, ret);
     }
 }
-/* div[wd]eu[o][.] */
-#define GEN_DIVE(name, hlpr, compute_ov)                                      \
-static void gen_##name(DisasContext *ctx)                                     \
-{                                                                             \
-    TCGv_i32 t0 = tcg_constant_i32(compute_ov);                               \
-    gen_helper_##hlpr(cpu_gpr[rD(ctx->opcode)], tcg_env,                      \
-                     cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)], t0); \
-    if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);                           \
-    }                                                                         \
-}
 
 #if defined(TARGET_PPC64)
-static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret, TCGv arg1,
-                                     TCGv arg2, int sign, int compute_ov)
+static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret,
+                                     TCGv arg1, TCGv arg2, bool sign,
+                                     bool compute_ov, bool compute_rc0)
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_i64 t1 = tcg_temp_new_i64();
@@ -1824,29 +1814,10 @@ static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret, TCGv arg1,
         tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
     }
 
-    if (unlikely(Rc(ctx->opcode) != 0)) {
+    if (unlikely(compute_rc0)) {
         gen_set_Rc0(ctx, ret);
     }
 }
-
-#define GEN_INT_ARITH_DIVD(name, opc3, sign, compute_ov)                      \
-static void glue(gen_, name)(DisasContext *ctx)                               \
-{                                                                             \
-    gen_op_arith_divd(ctx, cpu_gpr[rD(ctx->opcode)],                          \
-                      cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],     \
-                      sign, compute_ov);                                      \
-}
-/* divdu  divdu.  divduo  divduo.   */
-GEN_INT_ARITH_DIVD(divdu, 0x0E, 0, 0);
-GEN_INT_ARITH_DIVD(divduo, 0x1E, 0, 1);
-/* divd  divd.  divdo  divdo.   */
-GEN_INT_ARITH_DIVD(divd, 0x0F, 1, 0);
-GEN_INT_ARITH_DIVD(divdo, 0x1F, 1, 1);
-
-GEN_DIVE(divdeu, divdeu, 0);
-GEN_DIVE(divdeuo, divdeu, 1);
-GEN_DIVE(divde, divde, 0);
-GEN_DIVE(divdeo, divde, 1);
 #endif
 
 static inline void gen_op_arith_modw(DisasContext *ctx, TCGv ret, TCGv arg1,
@@ -1905,17 +1876,6 @@ static inline void gen_op_arith_modd(DisasContext *ctx, TCGv ret, TCGv arg1,
         tcg_gen_remu_i64(ret, t0, t1);
     }
 }
-
-#define GEN_INT_ARITH_MODD(name, opc3, sign)                            \
-static void glue(gen_, name)(DisasContext *ctx)                           \
-{                                                                         \
-  gen_op_arith_modd(ctx, cpu_gpr[rD(ctx->opcode)],                        \
-                    cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],   \
-                    sign);                                                \
-}
-
-GEN_INT_ARITH_MODD(modud, 0x08, 0);
-GEN_INT_ARITH_MODD(modsd, 0x18, 1);
 #endif
 
 /* Common subf function */
@@ -6395,23 +6355,6 @@ GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
 GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
 GEN_HANDLER(mtvscr, 0x04, 0x2, 0x19, 0x03ff0000, PPC_ALTIVEC),
 
-#if defined(TARGET_PPC64)
-#undef GEN_INT_ARITH_DIVD
-#define GEN_INT_ARITH_DIVD(name, opc3, sign, compute_ov)                      \
-GEN_HANDLER(name, 0x1F, 0x09, opc3, 0x00000000, PPC_64B)
-GEN_INT_ARITH_DIVD(divdu, 0x0E, 0, 0),
-GEN_INT_ARITH_DIVD(divduo, 0x1E, 0, 1),
-GEN_INT_ARITH_DIVD(divd, 0x0F, 1, 0),
-GEN_INT_ARITH_DIVD(divdo, 0x1F, 1, 1),
-
-GEN_HANDLER_E(divdeu, 0x1F, 0x09, 0x0C, 0, PPC_NONE, PPC2_DIVE_ISA206),
-GEN_HANDLER_E(divdeuo, 0x1F, 0x09, 0x1C, 0, PPC_NONE, PPC2_DIVE_ISA206),
-GEN_HANDLER_E(divde, 0x1F, 0x09, 0x0D, 0, PPC_NONE, PPC2_DIVE_ISA206),
-GEN_HANDLER_E(divdeo, 0x1F, 0x09, 0x1D, 0, PPC_NONE, PPC2_DIVE_ISA206),
-GEN_HANDLER_E(modsd, 0x1F, 0x09, 0x18, 0x00000001, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(modud, 0x1F, 0x09, 0x08, 0x00000001, PPC_NONE, PPC2_ISA300),
-#endif
-
 #undef GEN_LOGICAL1
 #undef GEN_LOGICAL2
 #define GEN_LOGICAL2(name, tcg_op, opc, type)                                 \
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index d9a5db83b3..f5dbf188bd 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -468,7 +468,7 @@ static bool do_divw(DisasContext *ctx, arg_XO *a, int sign)
     return true;
 }
 
-static bool do_divwe(DisasContext *ctx, arg_XO *a,
+static bool do_dive(DisasContext *ctx, arg_XO *a,
                      void (*helper)(TCGv, TCGv_ptr, TCGv, TCGv, TCGv_i32))
 {
     REQUIRE_INSNS_FLAGS2(ctx, DIVE_ISA206);
@@ -482,8 +482,8 @@ static bool do_divwe(DisasContext *ctx, arg_XO *a,
 
 TRANS(DIVW, do_divw, 1);
 TRANS(DIVWU, do_divw, 0);
-TRANS(DIVWE, do_divwe, gen_helper_DIVWE);
-TRANS(DIVWEU, do_divwe, gen_helper_DIVWEU);
+TRANS(DIVWE, do_dive, gen_helper_DIVWE);
+TRANS(DIVWEU, do_dive, gen_helper_DIVWEU);
 
 static bool do_modw(DisasContext *ctx, arg_X *a, bool sign)
 {
@@ -614,6 +614,29 @@ static bool trans_MADDHDU(DisasContext *ctx, arg_MADDHDU *a)
     return true;
 }
 
+static bool do_divd(DisasContext *ctx, arg_XO *a, bool sign)
+{
+    gen_op_arith_divd(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
+                      sign, a->oe, a->rc);
+    return true;
+}
+
+static bool do_modd(DisasContext *ctx, arg_X *a, bool sign)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    gen_op_arith_modd(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
+                      sign);
+    return true;
+}
+
+TRANS64(DIVD, do_divd, true);
+TRANS64(DIVDU, do_divd, false);
+TRANS64(DIVDE, do_dive, gen_helper_DIVDE);
+TRANS64(DIVDEU, do_dive, gen_helper_DIVDEU);
+
+TRANS64(MODSD, do_modd, true);
+TRANS64(MODUD, do_modd, false);
+
 static bool trans_INVALID(DisasContext *ctx, arg_INVALID *a)
 {
     gen_invalid(ctx);
-- 
2.39.3


