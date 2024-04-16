Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73205C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 06:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwcUv-0004c1-MI; Tue, 16 Apr 2024 02:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rwcUt-0004UV-EU; Tue, 16 Apr 2024 02:40:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rwcUr-0006ju-H8; Tue, 16 Apr 2024 02:40:51 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43G6ToNj026405; Tue, 16 Apr 2024 06:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=u/bdAiVA+8bV4Oc0Rewr4IlSyjl4nGbh0yO6G29gaD4=;
 b=M5eVCvTYH0sAclIaGGudPiEyrXGqk8VAZIsvn+Jx1tZew5z1c96VUW8FxDHPTuEWEEcM
 hbNTGYJ+1pGFvKpN/ESC+taQJU2HBV1wDTgSlHdd5h73RCtjbZHthHWE++cgycy7K4m+
 5U5O2i57LEfFt4J4hXfRLJ9M549yptbCz56A1Bed7bjILXbhzh+8MZRKM8rFQQ5iBFaY
 PNOIgfTAiVO7+qcfo7+mYrPVxKe/pMdYXdBva5z2xc5CPs3nZ3MNUvqK3UAtloX6l57R
 0QAIvUwJ2+oiV/bJotFWGIFMsc1Pq5SSPCA4AUg1msiLlEl1jZMB9TVsX8Ua4H1qx6gT lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhm3f80p7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 06:40:47 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43G6eloD010896;
 Tue, 16 Apr 2024 06:40:47 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhm3f80p6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 06:40:46 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43G3b1Pk021365; Tue, 16 Apr 2024 06:40:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg6kkc5kn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 06:40:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43G6efDD12779820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2024 06:40:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C5DD2004B;
 Tue, 16 Apr 2024 06:40:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E99320071;
 Tue, 16 Apr 2024 06:40:40 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2024 06:40:39 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 4/8] target/ppc: Move neg, darn, mod{sw, uw} to decodetree.
Date: Tue, 16 Apr 2024 12:09:23 +0530
Message-Id: <20240416063927.99428-5-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240416063927.99428-1-rathc@linux.ibm.com>
References: <20240416063927.99428-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oYH3IBh5qbIueWmux9SvTh5ioh-BN9Mg
X-Proofpoint-GUID: d-_kdyivd5rzW3_kQ4yvwF11KnghV38V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_03,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=739 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160038
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

	neg[o][.]       	: XO-form
	mod{sw, uw}, darn	: X-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/helper.h                        |  4 +-
 target/ppc/insn32.decode                   |  8 ++++
 target/ppc/int_helper.c                    |  4 +-
 target/ppc/translate.c                     | 56 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 44 +++++++++++++++++
 5 files changed, 56 insertions(+), 60 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 1fc8b7c5fd..09d0b0074b 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -71,8 +71,8 @@ DEF_HELPER_FLAGS_2(cmpeqb, TCG_CALL_NO_RWG_SE, i32, tl, tl)
 DEF_HELPER_FLAGS_1(popcntw, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(bpermd, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_3(srad, tl, env, tl, tl)
-DEF_HELPER_FLAGS_0(darn32, TCG_CALL_NO_RWG, tl)
-DEF_HELPER_FLAGS_0(darn64, TCG_CALL_NO_RWG, tl)
+DEF_HELPER_FLAGS_0(DARN32, TCG_CALL_NO_RWG, tl)
+DEF_HELPER_FLAGS_0(DARN64, TCG_CALL_NO_RWG, tl)
 #endif
 
 DEF_HELPER_FLAGS_1(cntlsw32, TCG_CALL_NO_RWG_SE, i32, i32)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index bfccebd9a7..654f55471b 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -187,6 +187,9 @@
 &X_a            ra
 @X_a            ...... ra:3 .. ..... ..... .......... .         &X_a
 
+&X_tl           rt l
+@X_tl           ...... rt:5 ... l:2 ..... .......... .          &X_tl
+
 &XO             rt ra rb oe:bool rc:bool
 @XO             ...... rt:5 ra:5 rb:5 oe:1 ......... rc:1       &XO
 
@@ -367,6 +370,11 @@ DIVWU           011111 ..... ..... ..... . 111001011 .  @XO
 DIVWE           011111 ..... ..... ..... . 110101011 .  @XO
 DIVWEU          011111 ..... ..... ..... . 110001011 .  @XO
 
+MODSW           011111 ..... ..... ..... 1100001011 -   @X
+MODUW           011111 ..... ..... ..... 0100001011 -   @X
+DARN            011111 ..... --- .. ----- 1011110011 -  @X_tl
+NEG             011111 ..... ..... ----- . 001101000 .  @XO_ta
+
 ## Fixed-Point Logical Instructions
 
 CFUGED          011111 ..... ..... ..... 0011011100 -   @X
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index dc1f72ff38..bc25d5b062 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -171,7 +171,7 @@ uint32_t helper_cmpeqb(target_ulong ra, target_ulong rb)
 /*
  * Return a random number.
  */
-uint64_t helper_darn32(void)
+uint64_t helper_DARN32(void)
 {
     Error *err = NULL;
     uint32_t ret;
@@ -186,7 +186,7 @@ uint64_t helper_darn32(void)
     return ret;
 }
 
-uint64_t helper_darn64(void)
+uint64_t helper_DARN64(void)
 {
     Error *err = NULL;
     uint64_t ret;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 0a1d1d63b3..436fcfc645 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1878,17 +1878,6 @@ static inline void gen_op_arith_modw(DisasContext *ctx, TCGv ret, TCGv arg1,
     }
 }
 
-#define GEN_INT_ARITH_MODW(name, opc3, sign)                                \
-static void glue(gen_, name)(DisasContext *ctx)                             \
-{                                                                           \
-    gen_op_arith_modw(ctx, cpu_gpr[rD(ctx->opcode)],                        \
-                      cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],   \
-                      sign);                                                \
-}
-
-GEN_INT_ARITH_MODW(moduw, 0x08, 0);
-GEN_INT_ARITH_MODW(modsw, 0x18, 1);
-
 #if defined(TARGET_PPC64)
 static inline void gen_op_arith_modd(DisasContext *ctx, TCGv ret, TCGv arg1,
                                      TCGv arg2, int sign)
@@ -2055,27 +2044,6 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
     }
 }
 
-/* neg neg. nego nego. */
-static inline void gen_op_arith_neg(DisasContext *ctx, bool compute_ov)
-{
-    TCGv zero = tcg_constant_tl(0);
-    gen_op_arith_subf(ctx, cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
-                      zero, 0, 0, compute_ov, Rc(ctx->opcode));
-}
-
-static void gen_neg(DisasContext *ctx)
-{
-    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode))) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-static void gen_nego(DisasContext *ctx)
-{
-    gen_op_arith_neg(ctx, 1);
-}
-
 /***                            Integer logical                            ***/
 #define GEN_LOGICAL2(name, tcg_op, opc, type)                                 \
 static void glue(gen_, name)(DisasContext *ctx)                               \
@@ -2401,24 +2369,6 @@ static void gen_cnttzd(DisasContext *ctx)
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
     }
 }
-
-/* darn */
-static void gen_darn(DisasContext *ctx)
-{
-    int l = L(ctx->opcode);
-
-    if (l > 2) {
-        tcg_gen_movi_i64(cpu_gpr[rD(ctx->opcode)], -1);
-    } else {
-        translator_io_start(&ctx->base);
-        if (l == 0) {
-            gen_helper_darn32(cpu_gpr[rD(ctx->opcode)]);
-        } else {
-            /* Return 64-bit random for both CRN and RRN */
-            gen_helper_darn64(cpu_gpr[rD(ctx->opcode)]);
-        }
-    }
-}
 #endif
 
 /***                             Integer rotate                            ***/
@@ -6330,8 +6280,6 @@ GEN_HANDLER(isel, 0x1F, 0x0F, 0xFF, 0x00000001, PPC_ISEL),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(mulld, 0x1F, 0x09, 0x07, 0x00000000, PPC_64B),
 #endif
-GEN_HANDLER(neg, 0x1F, 0x08, 0x03, 0x0000F800, PPC_INTEGER),
-GEN_HANDLER(nego, 0x1F, 0x08, 0x13, 0x0000F800, PPC_INTEGER),
 GEN_HANDLER2(andi_, "andi.", 0x1C, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER2(andis_, "andis.", 0x1D, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(cntlzw, 0x1F, 0x1A, 0x00, 0x00000000, PPC_INTEGER),
@@ -6352,7 +6300,6 @@ GEN_HANDLER_E(prtyw, 0x1F, 0x1A, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER(popcntd, 0x1F, 0x1A, 0x0F, 0x0000F801, PPC_POPCNTWD),
 GEN_HANDLER(cntlzd, 0x1F, 0x1A, 0x01, 0x00000000, PPC_64B),
 GEN_HANDLER_E(cnttzd, 0x1F, 0x1A, 0x11, 0x00000000, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(darn, 0x1F, 0x13, 0x17, 0x001CF801, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(prtyd, 0x1F, 0x1A, 0x05, 0x0000F801, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER_E(bpermd, 0x1F, 0x1C, 0x07, 0x00000001, PPC_NONE, PPC2_PERM_ISA206),
 #endif
@@ -6542,9 +6489,6 @@ GEN_HANDLER_E(maddhd_maddhdu, 0x04, 0x18, 0xFF, 0x00000000, PPC_NONE,
 GEN_HANDLER_E(maddld, 0x04, 0x19, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA300),
 #endif
 
-GEN_HANDLER_E(modsw, 0x1F, 0x0B, 0x18, 0x00000001, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(moduw, 0x1F, 0x0B, 0x08, 0x00000001, PPC_NONE, PPC2_ISA300),
-
 #if defined(TARGET_PPC64)
 #undef GEN_INT_ARITH_DIVD
 #define GEN_INT_ARITH_DIVD(name, opc3, sign, compute_ov)                      \
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 3f787bbeaa..2dfd6bea57 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -490,6 +490,50 @@ TRANS(DIVWU, do_divw, 0);
 TRANS(DIVWE, do_divwe, gen_helper_DIVWE);
 TRANS(DIVWEU, do_divwe, gen_helper_DIVWEU);
 
+static bool do_modw(DisasContext *ctx, arg_X *a, bool sign)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    gen_op_arith_modw(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
+                      sign);
+    return true;
+}
+
+TRANS(MODUW, do_modw, false);
+TRANS(MODSW, do_modw, true);
+
+static bool trans_NEG(DisasContext *ctx, arg_NEG *a)
+{
+    if (a->oe) {
+        TCGv zero = tcg_constant_tl(0);
+        gen_op_arith_subf(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], zero,
+                          false, false, true, a->rc);
+    } else {
+        tcg_gen_neg_tl(cpu_gpr[a->rt], cpu_gpr[a->ra]);
+        if (unlikely(a->rc)) {
+            gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+        }
+    }
+    return true;
+}
+
+static bool trans_DARN(DisasContext *ctx, arg_DARN *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    if (a->l > 2) {
+        tcg_gen_movi_i64(cpu_gpr[a->rt], -1);
+    } else {
+        translator_io_start(&ctx->base);
+        if (a->l == 0) {
+            gen_helper_DARN32(cpu_gpr[a->rt]);
+        } else {
+            /* Return 64-bit random for both CRN and RRN */
+            gen_helper_DARN64(cpu_gpr[a->rt]);
+        }
+    }
+    return true;
+}
+
 static bool trans_INVALID(DisasContext *ctx, arg_INVALID *a)
 {
     gen_invalid(ctx);
-- 
2.39.3


