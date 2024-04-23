Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E2EC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 06:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz9iE-0006H8-4G; Tue, 23 Apr 2024 02:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rz9iC-0006G4-D6; Tue, 23 Apr 2024 02:33:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rz9iA-0003X5-IT; Tue, 23 Apr 2024 02:33:04 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43N5kFcT006287; Tue, 23 Apr 2024 06:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=z86ON6eM7uMi/n2fgGU4DJgFCy6enaT4968TRNM+DE4=;
 b=EZUNKI97/9aYFm8iUwWq+jy70zrUmzZwGKYVJJ1TQqjly8kBiOHNt83lbSC7YaScJ7uX
 ZLLvS9N1zkVSoZRXXEc1eFQFUsYR0pqU85v7DqQT2a32VeU45/LH2Tgof7A6Q2KTQq57
 2AdMq4IfLHtGbQ3VaLd9kObkmhRqEEi5ljF5kMF83DxqA3ZuFyS7zWS4DF04ldrIq1Oe
 kLws6KaSoalt9El483QlJfzsFuzVJRU0kAhl3TWjMEH+dwh95b6q91dm+zcEC23qQf9Z
 SuTnbdKba0ibUx9NxwTULhShMATFu4lAh+ZpNhQTrP/lNksU8L9qXs/1CVCSleIXvP15 Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp620g80m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:32:59 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N6WwtZ024145;
 Tue, 23 Apr 2024 06:32:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp620g80k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:32:58 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43N4qShg015430; Tue, 23 Apr 2024 06:32:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshm3w3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:32:57 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43N6WrvU49938812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Apr 2024 06:32:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84B7C20043;
 Tue, 23 Apr 2024 06:32:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44C5E2004B;
 Tue, 23 Apr 2024 06:32:52 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Apr 2024 06:32:52 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v2 3/8] target/ppc: Move divw[u, e,
 eu] instructions to decodetree.
Date: Tue, 23 Apr 2024 12:02:29 +0530
Message-Id: <20240423063234.76282-4-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240423063234.76282-1-rathc@linux.ibm.com>
References: <20240423063234.76282-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GJbjCS2rJWsGfo0gBDJ3SxWNIohsAIpS
X-Proofpoint-ORIG-GUID: EmKFIOHQB-lwh53Bt3ed7Ejmpp5nyXQk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 mlxlogscore=698
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

Moving the following instructions to decodetree specification :
	 divw[u, e, eu][o][.] 	: XO-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                        |  4 +--
 target/ppc/insn32.decode                   |  5 ++++
 target/ppc/int_helper.c                    |  4 +--
 target/ppc/translate.c                     | 31 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 24 +++++++++++++++++
 5 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 86f97ee1e7..1fc8b7c5fd 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -55,8 +55,8 @@ DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
 DEF_HELPER_4(divdeu, i64, env, i64, i64, i32)
 DEF_HELPER_4(divde, i64, env, i64, i64, i32)
 #endif
-DEF_HELPER_4(divweu, tl, env, tl, tl, i32)
-DEF_HELPER_4(divwe, tl, env, tl, tl, i32)
+DEF_HELPER_4(DIVWEU, tl, env, tl, tl, i32)
+DEF_HELPER_4(DIVWE, tl, env, tl, tl, i32)
 
 DEF_HELPER_FLAGS_1(popcntb, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(cmpb, TCG_CALL_NO_RWG_SE, tl, tl, tl)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 0184680db8..bfccebd9a7 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -362,6 +362,11 @@ MULLWO          011111 ..... ..... ..... 1 011101011 .  @XO_tab_rc
 MULHW           011111 ..... ..... ..... - 001001011 .  @XO_tab_rc
 MULHWU          011111 ..... ..... ..... - 000001011 .  @XO_tab_rc
 
+DIVW            011111 ..... ..... ..... . 111101011 .  @XO
+DIVWU           011111 ..... ..... ..... . 111001011 .  @XO
+DIVWE           011111 ..... ..... ..... . 110101011 .  @XO
+DIVWEU          011111 ..... ..... ..... . 110001011 .  @XO
+
 ## Fixed-Point Logical Instructions
 
 CFUGED          011111 ..... ..... ..... 0011011100 -   @X
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 0a5c3e78a4..dc1f72ff38 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -44,7 +44,7 @@ static inline void helper_update_ov_legacy(CPUPPCState *env, int ov)
     }
 }
 
-target_ulong helper_divweu(CPUPPCState *env, target_ulong ra, target_ulong rb,
+target_ulong helper_DIVWEU(CPUPPCState *env, target_ulong ra, target_ulong rb,
                            uint32_t oe)
 {
     uint64_t rt = 0;
@@ -71,7 +71,7 @@ target_ulong helper_divweu(CPUPPCState *env, target_ulong ra, target_ulong rb,
     return (target_ulong)rt;
 }
 
-target_ulong helper_divwe(CPUPPCState *env, target_ulong ra, target_ulong rb,
+target_ulong helper_DIVWE(CPUPPCState *env, target_ulong ra, target_ulong rb,
                           uint32_t oe)
 {
     int64_t rt = 0;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index be7d807e3c..0a1d1d63b3 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1778,21 +1778,6 @@ static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret,
         gen_set_Rc0(ctx, ret);
     }
 }
-/* Div functions */
-#define GEN_INT_ARITH_DIVW(name, opc3, sign, compute_ov)                      \
-static void glue(gen_, name)(DisasContext *ctx)                               \
-{                                                                             \
-    gen_op_arith_divw(ctx, cpu_gpr[rD(ctx->opcode)],                          \
-                     cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],      \
-                     sign, compute_ov, Rc(ctx->opcode));                      \
-}
-/* divwu  divwu.  divwuo  divwuo.   */
-GEN_INT_ARITH_DIVW(divwu, 0x0E, 0, 0);
-GEN_INT_ARITH_DIVW(divwuo, 0x1E, 0, 1);
-/* divw  divw.  divwo  divwo.   */
-GEN_INT_ARITH_DIVW(divw, 0x0F, 1, 0);
-GEN_INT_ARITH_DIVW(divwo, 0x1F, 1, 1);
-
 /* div[wd]eu[o][.] */
 #define GEN_DIVE(name, hlpr, compute_ov)                                      \
 static void gen_##name(DisasContext *ctx)                                     \
@@ -1805,11 +1790,6 @@ static void gen_##name(DisasContext *ctx)                                     \
     }                                                                         \
 }
 
-GEN_DIVE(divweu, divweu, 0);
-GEN_DIVE(divweuo, divweu, 1);
-GEN_DIVE(divwe, divwe, 0);
-GEN_DIVE(divweo, divwe, 1);
-
 #if defined(TARGET_PPC64)
 static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret, TCGv arg1,
                                      TCGv arg2, int sign, int compute_ov)
@@ -6562,17 +6542,6 @@ GEN_HANDLER_E(maddhd_maddhdu, 0x04, 0x18, 0xFF, 0x00000000, PPC_NONE,
 GEN_HANDLER_E(maddld, 0x04, 0x19, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA300),
 #endif
 
-#undef GEN_INT_ARITH_DIVW
-#define GEN_INT_ARITH_DIVW(name, opc3, sign, compute_ov)                      \
-GEN_HANDLER(name, 0x1F, 0x0B, opc3, 0x00000000, PPC_INTEGER)
-GEN_INT_ARITH_DIVW(divwu, 0x0E, 0, 0),
-GEN_INT_ARITH_DIVW(divwuo, 0x1E, 0, 1),
-GEN_INT_ARITH_DIVW(divw, 0x0F, 1, 0),
-GEN_INT_ARITH_DIVW(divwo, 0x1F, 1, 1),
-GEN_HANDLER_E(divwe, 0x1F, 0x0B, 0x0D, 0, PPC_NONE, PPC2_DIVE_ISA206),
-GEN_HANDLER_E(divweo, 0x1F, 0x0B, 0x1D, 0, PPC_NONE, PPC2_DIVE_ISA206),
-GEN_HANDLER_E(divweu, 0x1F, 0x0B, 0x0C, 0, PPC_NONE, PPC2_DIVE_ISA206),
-GEN_HANDLER_E(divweuo, 0x1F, 0x0B, 0x1C, 0, PPC_NONE, PPC2_DIVE_ISA206),
 GEN_HANDLER_E(modsw, 0x1F, 0x0B, 0x18, 0x00000001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(moduw, 0x1F, 0x0B, 0x08, 0x00000001, PPC_NONE, PPC2_ISA300),
 
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 1a2ad58929..3265c77aa6 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -461,6 +461,30 @@ static bool do_mulhw(DisasContext *ctx, arg_XO_tab_rc *a,
 TRANS(MULHW, do_mulhw, tcg_gen_muls2_i32)
 TRANS(MULHWU, do_mulhw, tcg_gen_mulu2_i32)
 
+static bool do_divw(DisasContext *ctx, arg_XO *a, int sign)
+{
+    gen_op_arith_divw(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
+                      sign, a->oe, a->rc);
+    return true;
+}
+
+static bool do_divwe(DisasContext *ctx, arg_XO *a,
+                     void (*helper)(TCGv, TCGv_ptr, TCGv, TCGv, TCGv_i32))
+{
+    REQUIRE_INSNS_FLAGS2(ctx, DIVE_ISA206);
+    helper(cpu_gpr[a->rt], tcg_env, cpu_gpr[a->ra], cpu_gpr[a->rb],
+           tcg_constant_i32(a->oe));
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+    }
+    return true;
+}
+
+TRANS(DIVW, do_divw, 1);
+TRANS(DIVWU, do_divw, 0);
+TRANS(DIVWE, do_divwe, gen_helper_DIVWE);
+TRANS(DIVWEU, do_divwe, gen_helper_DIVWEU);
+
 static bool trans_INVALID(DisasContext *ctx, arg_INVALID *a)
 {
     gen_invalid(ctx);
-- 
2.39.3


