Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9643AC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpl7-0005l5-Eh; Fri, 28 Aug 2026 02:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpl5-0005kt-VE
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpl3-0000tG-Qk
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S231ur679595
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=EYj2NlrLumJYw1m0f
 geVX3Haa++2aqls7AbU0G61zd4=; b=OYFHwmjN9E75jb6Zw3ay6mYTqBXRIz0Ki
 s785qo/2xoAmsFTo2sZ6zBB+BQusigwrtPIdQu0QouYIAXZdud3Tc9kU58lO33ur
 zREG1WGGKryEgk+cnAcxqm9kukCsg6ZEg7vQ7H6H0wXnggLWWwDTxf/W0Re4Y1t6
 nHhZlLeEirsYtuv1u+wxc2xEcLhPVQROwNIDl81ykwCOdW0SOdVxF2/ISCQGg7Wx
 zcKU6jdS35PHvYn3cuMVQ+0dYGUHc9t6VDntF/dcuxQNCZgUsR1lRKvoBs1134XP
 xhX9EyVAom/3e2kQdl4Hb0sApAdszD4W6lg9BoT8wp8INM9mF6CKw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxt0m0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5ueYZ006077
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qmv9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S682wJ48562686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:08:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E434620040;
 Fri, 28 Aug 2026 06:08:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 222B020043;
 Fri, 28 Aug 2026 06:08:00 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:07:59 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Sathvika Vasireddy <sv@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 14/41] target/ppc: Move fixed-point Shift insns to decodetree
Date: Fri, 28 Aug 2026 11:36:49 +0530
Message-ID: <20260828060716.91672-15-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX9H0yqzcTINCa
 8We4s+GtQwyb/L64DrgLR7O9QEl3kv5s70bNC+JZpwMPmyECmMfmBSSLw15NWpSFF3G4ZW+08LS
 ELQ/RzIxr4XVgxH1jPlJgAzpanqSez8=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a9125c8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=70_TU0wQgaf75xgqATAA:9
X-Proofpoint-ORIG-GUID: KvTH82xaT6cJ5YJoV3uaZd-DpeNJ1VVH
X-Proofpoint-GUID: KvTH82xaT6cJ5YJoV3uaZd-DpeNJ1VVH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfXwUB1H0VSguTu
 j6N1EjYpqr7YQDjeLPOl7Eh+7UnfbpxJKn6o8VYzvZeCC4px54mImx2inQjH+A75/9+izMdCeM5
 4ZgYoe9KcqXY6VuLzWBJFwnczFxsCLRx7bPdMIBXui2nbxcFQQRyBxefCT5/aDrzzLX36A0L7mb
 /sQXUZeejHX5bpqcdokf2UXlvae1mDZt+EVe5DqOToXWkCivnlToGAi0PlPjYyJ1tAIXH6QqDNK
 U/CjUG9/FoaBG1GyRQDxbMhgPg+TkAt04sUPOfjKDmCt+BOpSh1L1lpc6Rc0HWKWBgN9BCErNZx
 dpbFrPIhJiFHDqtggdWdZ4n4enClqxj7h834vwCH7+FByoijT5EPukAZw2E1iRo9/iaSAShJ6YI
 tV3wYTRnyze/OzjlHqsy3AXXAG+h2PrYfFLqIBLv0ZpA9KIJ/y1nFpv8XM+kHXOdNcBkBEQ6dX3
 Lm3lQFPuV3/XIQnoABQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-11-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/helper.h                        |  2 +-
 target/ppc/insn32.decode                   | 12 ++-
 target/ppc/int_helper.c                    |  2 +-
 target/ppc/translate.c                     | 96 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 72 ++++++++++++++++
 5 files changed, 82 insertions(+), 102 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index d4a9334ce8..e7bf43bf4b 100644
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
index f928cd6602..12fb4974e4 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -119,7 +119,7 @@
 
 # XS-form with fractured shift amount
 %xs_sh           1:1 11:5
-&XS              rs ra sh rc
+&XS              rs ra sh rc:bool
 @XS              ...... rs:5 ra:5 ..... ......... . rc:1        &XS sh=%xs_sh
 
 %x_frtp         22:4 !function=times_2
@@ -512,6 +512,13 @@ SRW             011111 ..... ..... ..... 1000011000 .   @X_rc
 SRAW            011111 ..... ..... ..... 1100011000 .   @X_rc
 SRAWI           011111 ..... ..... ..... 1100111000 .   @X_rc
 
+SLD             011111 ..... ..... ..... 0000011011 .   @X_rc
+SRD             011111 ..... ..... ..... 1000011011 .   @X_rc
+SRAD            011111 ..... ..... ..... 1100011010 .   @X_rc
+SRADI           011111 ..... ..... ..... 110011101 . .  @XS
+
+EXTSWSLI        011111 ..... ..... ..... 110111101 . .  @XS
+
 ## BCD Assist
 
 ADDG6S          011111 ..... ..... ..... - 001001010 -  @X
@@ -1379,9 +1386,6 @@ DST             011111 ----- ..... ..... 0101010110 -   @X_ea
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
index 7e7ef4e32d..45418b4de5 100644
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
@@ -5671,13 +5582,6 @@ GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
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
2.52.0


