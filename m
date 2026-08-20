Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3708C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3Ne-00028s-17; Thu, 20 Aug 2026 10:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3Nb-0001vR-Oj; Thu, 20 Aug 2026 10:04:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3NZ-000655-CO; Thu, 20 Aug 2026 10:04:27 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8s5VQ2794686; Thu, 20 Aug 2026 14:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=+vZRm0aKGT8TY8Ze/
 byF0bqk3eik6aF5engcrXk1Y6E=; b=Fv7NsBR52v1A8+uw2bzu05ZEbOHfyUm08
 RL9DTr2sxklRONr4XHUCJvDQV/9E9TRSJwTtZu6lzX+a1VPjVDWIpKi8NG2zJyP/
 XHpujbgB2W7ZcUxKpKt6QL3HY9tn0MczIG9Ni4mYdLJFQ3my5XWo7vFzEu/+wfIh
 2s4brJyAh6BpA7YTqWEarpLzvooCQKiY+nHVVFT2Say+mnuvWJ2tg9nQKvzMGO+p
 8BDSPMo22yU+BbZEwBsr7uT7lpk9wxc6bHjL+e3weaeUHCS1AKwuf2kKJtdEMUtM
 ktcrUGcgBRjPsh8pM85uAIwfWOdd+BKokWPXf0ex35TkSaN3lcsSQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0as59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:04:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuIft014612;
 Thu, 20 Aug 2026 14:04:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ypn70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:04:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KE4EXt28836512
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:04:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 808AB2004D;
 Thu, 20 Aug 2026 14:04:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28DD820043;
 Thu, 20 Aug 2026 14:04:03 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:04:02 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 10/29] target/ppc: Move fixed-point Shift insns to decodetree
Date: Thu, 20 Aug 2026 19:30:39 +0530
Message-ID: <20260820140114.327023-11-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820140114.327023-1-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: VmT60ySz_yT4MNNWLs--asrPlMbbQLJT
X-Proofpoint-GUID: eO4y8xWy31iMxVLCta0FeoQdAlO5ezdU
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a870966 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=70_TU0wQgaf75xgqATAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX70/k54ZKCRjM
 A7WbgLNIEWiMman3S5esEzbOKuWOV7ASa0D+eEVdKf2Hnr1KGcuje4ssLSMZUv21tox+4dTv7ZL
 sv1pgDmDUvTDp4ynq1uIFVUSf3U2gIE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX0FcmP28xJfmc
 pu88brRmU9kK3hk3O4SnWsxJU6zeLNrfSwhAY32OmDsk3jD3mq1dwyJGO1W9uFaAYxELK2+GNVn
 cpIqHHbQjrUM5U+8sTh1W8g+mQSzGNzmANfk+9UFYHE2wRPG038pmRfk6tySZOvARUGUdmvWz0y
 bpMtEtojkRuPkfG1rmX0aphnccmxTmdrkPadYtwmFlVcc+64WRM4+TKc+mNyub6qPunVG5JQuvT
 v7OAmiAwNGNu0MHAFttvy2fIDF+XPuiTreVRgcH0/nSItAuamyJ2Us0MhOcuenuMSyF/BH+cXV/
 ATpKpUZTx2iS5/d8BKe/mFQ2PeMZqXOxVFk8DlkmKOP5WT3yDBB2PqPoyfYhvBn4dXdfk5pXX9e
 jJkYDbJyEbmwU+pDodwyU+FmgbSmMPuv9ED50a+QFGmLqWpraWQPCsImIvlKeAF9VQKOu0Gl0IL
 H1MAZhO5nXDwIhmrOig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Amit Machhiwal <amachhiw@linux.ibm.com>

Move the below instructions to decodetree specification:

  s{r,l}d, and srad[i]					: X-form

The changes were verified by validating that the TCG ops generated by
these instructions remain the same after these changes. The TCG
micro-ops were captured with the '-d op,in_asm' QEMU flag.

Move all shift insntructions to one place in insn32.decode

Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/helper.h                        |  2 +-
 target/ppc/insn32.decode                   | 11 ++-
 target/ppc/int_helper.c                    |  2 +-
 target/ppc/translate.c                     | 96 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 72 ++++++++++++++++
 5 files changed, 81 insertions(+), 102 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3aff559504..cd2a0948a3 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -74,7 +74,7 @@ DEF_HELPER_FLAGS_1(CBCDTD, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(CMPEQB, TCG_CALL_NO_RWG_SE, i32, tl, tl)
 DEF_HELPER_FLAGS_1(POPCNTW, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(BPERMD, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_3(srad, tl, env, tl, tl)
+DEF_HELPER_3(SRAD, tl, env, tl, tl)
 DEF_HELPER_FLAGS_0(DARN32, TCG_CALL_NO_RWG, tl)
 DEF_HELPER_FLAGS_0(DARN64, TCG_CALL_NO_RWG, tl)
 #endif
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 7d792d2318..d34094d717 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -119,7 +119,7 @@
 
 # XS-form with fractured shift amount
 %xs_sh           1:1 11:5
-&XS              rs ra sh rc
+&XS              rs ra sh rc:bool
 @XS              ...... rs:5 ra:5 ..... ......... . rc:1        &XS sh=%xs_sh
 
 %x_frtp         22:4 !function=times_2
@@ -512,6 +512,12 @@ SRAW            011111 ..... ..... ..... 1100011000 .   @X_rc
 SRAWI           011111 ..... ..... ..... 1100111000 .   @X_rc
 SRW             011111 ..... ..... ..... 1000011000 .   @X_rc
 
+SLD             011111 ..... ..... ..... 0000011011 .   @X_rc
+SRD             011111 ..... ..... ..... 1000011011 .   @X_rc
+SRAD            011111 ..... ..... ..... 1100011010 .   @X_rc
+SRADI           011111 ..... ..... ..... 110011101 . .  @XS
+
+EXTSWSLI        011111 ..... ..... ..... 110111101 . .  @XS
 
 ## BCD Assist
 
@@ -1382,9 +1388,6 @@ DST             011111 ----- ..... ..... 0101010110 -   @X_ea
 DSTST           011111 ----- ..... ..... 0101110110 -   @X_ea
 DSS             011111 ----- ..... ..... 1100110110 -   @X_ea
 
-##Extend Sign Word and Shift Left Immediate XS-form
-EXTSWSLI         011111 ..... ..... ..... 110111101 . .         @XS
-
 ## Load and Reserve Instructions
 LBARX           011111 ..... ..... ..... 0000110100 .   @X_rc
 LHARX           011111 ..... ..... ..... 0001110100 .   @X_rc
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index b161f930ec..8e8076a92c 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -261,7 +261,7 @@ target_ulong helper_SRAW(CPUPPCState *env, target_ulong value,
 }
 
 #if defined(TARGET_PPC64)
-target_ulong helper_srad(CPUPPCState *env, target_ulong value,
+target_ulong helper_SRAD(CPUPPCState *env, target_ulong value,
                          target_ulong shift)
 {
     int64_t ret;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 55b515cec7..09a461dd63 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2313,95 +2313,6 @@ static void gen_rldimi(DisasContext *ctx, int mbn, int shn)
 GEN_PPC64_R4(rldimi, 0x1E, 0x06);
 #endif
 
-/***                             Integer shift                             ***/
-
-
-#if defined(TARGET_PPC64)
-/* sld & sld. */
-static void gen_sld(DisasContext *ctx)
-{
-    TCGv t0, t1;
-
-    t0 = tcg_temp_new();
-    /* AND rS with a mask that is 0 when rB >= 0x40 */
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x39);
-    tcg_gen_sari_tl(t0, t0, 0x3f);
-    tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
-    t1 = tcg_temp_new();
-    tcg_gen_andi_tl(t1, cpu_gpr[rB(ctx->opcode)], 0x3f);
-    tcg_gen_shl_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
-    }
-}
-
-/* srad & srad. */
-static void gen_srad(DisasContext *ctx)
-{
-    gen_helper_srad(cpu_gpr[rA(ctx->opcode)], tcg_env,
-                    cpu_gpr[rS(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
-    }
-}
-/* sradi & sradi. */
-static inline void gen_sradi(DisasContext *ctx, int n)
-{
-    int sh = SH(ctx->opcode) + (n << 5);
-    TCGv dst = cpu_gpr[rA(ctx->opcode)];
-    TCGv src = cpu_gpr[rS(ctx->opcode)];
-    if (sh == 0) {
-        tcg_gen_mov_tl(dst, src);
-        tcg_gen_movi_tl(cpu_ca, 0);
-        if (is_isa300(ctx)) {
-            tcg_gen_movi_tl(cpu_ca32, 0);
-        }
-    } else {
-        TCGv t0;
-        tcg_gen_andi_tl(cpu_ca, src, (1ULL << sh) - 1);
-        t0 = tcg_temp_new();
-        tcg_gen_sari_tl(t0, src, TARGET_LONG_BITS - 1);
-        tcg_gen_and_tl(cpu_ca, cpu_ca, t0);
-        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
-        if (is_isa300(ctx)) {
-            tcg_gen_mov_tl(cpu_ca32, cpu_ca);
-        }
-        tcg_gen_sari_tl(dst, src, sh);
-    }
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, dst);
-    }
-}
-
-static void gen_sradi0(DisasContext *ctx)
-{
-    gen_sradi(ctx, 0);
-}
-
-static void gen_sradi1(DisasContext *ctx)
-{
-    gen_sradi(ctx, 1);
-}
-
-/* srd & srd. */
-static void gen_srd(DisasContext *ctx)
-{
-    TCGv t0, t1;
-
-    t0 = tcg_temp_new();
-    /* AND rS with a mask that is 0 when rB >= 0x40 */
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x39);
-    tcg_gen_sari_tl(t0, t0, 0x3f);
-    tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
-    t1 = tcg_temp_new();
-    tcg_gen_andi_tl(t1, cpu_gpr[rB(ctx->opcode)], 0x3f);
-    tcg_gen_shr_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
-    }
-}
-#endif
-
 /***                           Addressing modes                            ***/
 /* Register indirect with immediate index : EA = (rA|0) + SIMM */
 static inline void gen_addr_imm_index(DisasContext *ctx, TCGv EA,
@@ -5684,13 +5595,6 @@ GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(rlwimi, 0x14, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(rlwinm, 0x15, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-#if defined(TARGET_PPC64)
-GEN_HANDLER(sld, 0x1F, 0x1B, 0x00, 0x00000000, PPC_64B),
-GEN_HANDLER(srad, 0x1F, 0x1A, 0x18, 0x00000000, PPC_64B),
-GEN_HANDLER2(sradi0, "sradi", 0x1F, 0x1A, 0x19, 0x00000000, PPC_64B),
-GEN_HANDLER2(sradi1, "sradi", 0x1F, 0x1B, 0x19, 0x00000000, PPC_64B),
-GEN_HANDLER(srd, 0x1F, 0x1B, 0x10, 0x00000000, PPC_64B),
-#endif
 /* handles lfdp, lxsd, lxssp */
 GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
 /* handles stfdp, stxsd, stxssp */
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 234404e459..9f669894a3 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -486,6 +486,76 @@ static bool do_add_const_XO(DisasContext *ctx, arg_XO_ta *a, TCGv const_val,
     return true;
 }
 
+static bool do_shift_X_rc(DisasContext *ctx, arg_X_rc *a,
+                                void(*op)(TCGv, TCGv, TCGv))
+{
+    REQUIRE_64BIT(ctx);
+#if defined(TARGET_PPC64)
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+
+    /* AND rt with a mask that is 0 when rb >= 0x40 */
+    tcg_gen_shli_tl(t0, cpu_gpr[a->rb], 0x39);
+    tcg_gen_sari_tl(t0, t0, 0x3f);
+    tcg_gen_andc_tl(t0, cpu_gpr[a->rt], t0);
+    tcg_gen_andi_tl(t1, cpu_gpr[a->rb], 0x3f);
+    op(cpu_gpr[a->ra], t0, t1);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+    }
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_SRAD(DisasContext *ctx, arg_SRAD *a)
+{
+    REQUIRE_64BIT(ctx);
+#if defined(TARGET_PPC64)
+    gen_helper_SRAD(cpu_gpr[a->ra], tcg_env, cpu_gpr[a->rt], cpu_gpr[a->rb]);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+    }
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_SRADI(DisasContext *ctx, arg_SRADI *a)
+{
+    REQUIRE_64BIT(ctx);
+#if defined(TARGET_PPC64)
+    int sh = a->sh;
+    TCGv dst = cpu_gpr[a->ra];
+    TCGv src = cpu_gpr[a->rs];
+    if (sh == 0) {
+        tcg_gen_mov_tl(dst, src);
+        tcg_gen_movi_tl(cpu_ca, 0);
+        if (is_isa300(ctx)) {
+            tcg_gen_movi_tl(cpu_ca32, 0);
+        }
+    } else {
+        TCGv t0 = tcg_temp_new();
+        tcg_gen_andi_tl(cpu_ca, src, (1ULL << sh) - 1);
+        tcg_gen_sari_tl(t0, src, TARGET_LONG_BITS - 1);
+        tcg_gen_and_tl(cpu_ca, cpu_ca, t0);
+        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
+        if (is_isa300(ctx)) {
+            tcg_gen_mov_tl(cpu_ca32, cpu_ca);
+        }
+        tcg_gen_sari_tl(dst, src, sh);
+    }
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, dst);
+    }
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
 TRANS(ADD, do_add_XO, false, false);
 TRANS(ADDC, do_add_XO, false, true);
 TRANS(ADDE, do_add_XO, true, true);
@@ -493,6 +563,8 @@ TRANS(ADDME, do_add_const_XO, tcg_constant_tl(-1LL), true, true);
 TRANS(ADDZE, do_add_const_XO, tcg_constant_tl(0), true, true);
 TRANS(ADDIC, do_add_D, false, true, false, false);
 TRANS(ADDIC_, do_add_D, false, true, false, true);
+TRANS(SLD, do_shift_X_rc, tcg_gen_shl_tl);
+TRANS(SRD, do_shift_X_rc, tcg_gen_shr_tl);
 
 static bool trans_SUBFIC(DisasContext *ctx, arg_D *a)
 {
-- 
2.55.0


