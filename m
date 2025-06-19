Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC6FC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 09:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSC34-0008Vs-PS; Thu, 19 Jun 2025 05:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uSC31-0008Te-HN; Thu, 19 Jun 2025 05:59:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uSC2y-0007rX-NI; Thu, 19 Jun 2025 05:59:06 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J7SZF4024164;
 Thu, 19 Jun 2025 09:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=l8JsP2aaG0Qhr3SUv
 EFUVsvpLhpXkR6ZqE47GM3QNK8=; b=NBLJKtOw0YTqVaDKWREkmDEyYP7/+e9u7
 LRvnZIZZJ9C3YiRk6izmtT3878dxBrHgd+nR7RrDqmCIf1bO1V5ouFJab31Lpxd/
 LHLTm0PRfPjCahM+ryRKqXIUO90L8mswfmGyAC4WO2bKURb7CCxW10nIM0xgPWFE
 3V1lYdhislNDIaNKteZQA9NsIw/4XrAfYCWun8lMUpAOPy73YJ2z9PKOUva/CnwZ
 Hq7BdnpPiu9lda1845m1XMfTCVwcvW1PaToW95h1KuX7V2WnKbf9PXzhjLV6vao2
 MYLy7l5ez1Ml3vbGAnThRodPBq7v4LSPUOCkkDir52pqG0Oa/HElQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygnm9jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:59:03 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55J9vuLC008771;
 Thu, 19 Jun 2025 09:59:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygnm9jv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:59:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55J86hDd000762;
 Thu, 19 Jun 2025 09:59:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdpdhc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:59:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55J9x0gl45809920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Jun 2025 09:59:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B55B2004B;
 Thu, 19 Jun 2025 09:59:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 631CD20040;
 Thu, 19 Jun 2025 09:58:58 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.in.ibm.com (unknown
 [9.79.200.241]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Jun 2025 09:58:58 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 danielhb413@gmail.com
Cc: richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 3/5] target/ppc: Move floating-point move instructions to
 decodetree.
Date: Thu, 19 Jun 2025 15:28:38 +0530
Message-ID: <20250619095840.369351-4-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619095840.369351-1-rathc@linux.ibm.com>
References: <20250619095840.369351-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA4MiBTYWx0ZWRfX/kERBKd3XqWn
 GfMpkju5SdDTz/pZwwbx0msNcklfTyJ+SLjGRj6BxW+BRmHf9sLN+AWPc2K8U8Xpj0pPP+xDutQ
 LNwg7aLE81LyqyQ57W24/3/WGz62CknGLtBlAvYQGOscN6udQ+YUOFwDrpvJ5V/r1aSeev8Dish
 7rHutoq9ikEhHfWo0WMNqDs9s38cCbE5GZ8txSgsCjI1MWB1meCralL7zHUciQHxzQ+1TGNuKnC
 zLihNyTT6eHIIEilfgWLHFuVfeiLReDFarxMMeGm3FCTsm2UUsFuXNCcL3ipXhWwTXZLM2XrPxa
 Crewo+6YoVc5bUHdAn0p8Rih9udPy24zab0+xDtAMKqjr5+8ufRWwVZkdp5qtUk1pvn9lA37tf1
 cc6vJQ/dmYrQRFDulaVG7Sv22j6w9n3x9LSQ688USgMTPeMCpRYi5dZs9tOz2phZnpHNyCYh
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=6853df67 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=R2UZqdDKM_ImC5moMnwA:9
X-Proofpoint-ORIG-GUID: YiJ0p0cc9FsXngcGBnKBqWkl8R6WnX19
X-Proofpoint-GUID: O9DmGNEVHs4s3iTA1La10N3TRARlr7GY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506190082
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move below instructions to decodetree specification:

	f{mr, neg, abs, nabs}		: X-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode           |  7 +++
 target/ppc/translate/fp-impl.c.inc | 80 ++++++++----------------------
 target/ppc/translate/fp-ops.c.inc  |  4 --
 3 files changed, 28 insertions(+), 63 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 0ffd814471..abbdb9fd82 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -503,6 +503,13 @@ STFDU           110111 ..... ...... ...............     @D
 STFDX           011111 ..... ...... .... 1011010111 -   @X
 STFDUX          011111 ..... ...... .... 1011110111 -   @X
 
+### Floating-Point Move Instructions
+
+FMR             111111 ..... ----- ..... 0001001000 .   @X_tb_rc
+FNEG            111111 ..... ----- ..... 0000101000 .   @X_tb_rc
+FABS            111111 ..... ----- ..... 0100001000 .   @X_tb_rc
+FNABS           111111 ..... ----- ..... 0010001000 .   @X_tb_rc
+
 ### Floating-Point Arithmetic Instructions
 
 FADD            111111 ..... ..... ..... ----- 10101 .  @A_tab
diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index 4e18d350c0..2843f71122 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -280,82 +280,44 @@ TRANS(FCMPU, do_helper_cmp, gen_helper_FCMPU);
 TRANS(FCMPO, do_helper_cmp, gen_helper_FCMPO);
 
 /***                         Floating-point move                           ***/
-/* fabs */
-/* XXX: beware that fabs never checks for NaNs nor update FPSCR */
-static void gen_fabs(DisasContext *ctx)
-{
-    TCGv_i64 t0;
-    TCGv_i64 t1;
-    if (unlikely(!ctx->fpu_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_FPU);
-        return;
-    }
-    t0 = tcg_temp_new_i64();
-    t1 = tcg_temp_new_i64();
-    get_fpr(t0, rB(ctx->opcode));
-    tcg_gen_andi_i64(t1, t0, ~(1ULL << 63));
-    set_fpr(rD(ctx->opcode), t1);
-    if (unlikely(Rc(ctx->opcode))) {
-        gen_set_cr1_from_fpscr(ctx);
-    }
-}
 
 /* fmr  - fmr. */
 /* XXX: beware that fmr never checks for NaNs nor update FPSCR */
-static void gen_fmr(DisasContext *ctx)
+static bool trans_FMR(DisasContext *ctx, arg_FMR *a)
 {
     TCGv_i64 t0;
-    if (unlikely(!ctx->fpu_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_FPU);
-        return;
-    }
+    REQUIRE_INSNS_FLAGS(ctx, FLOAT);
+    REQUIRE_FPU(ctx);
     t0 = tcg_temp_new_i64();
-    get_fpr(t0, rB(ctx->opcode));
-    set_fpr(rD(ctx->opcode), t0);
-    if (unlikely(Rc(ctx->opcode))) {
+    get_fpr(t0, a->rb);
+    set_fpr(a->rt, t0);
+    if (unlikely(a->rc)) {
         gen_set_cr1_from_fpscr(ctx);
     }
+    return true;
 }
 
-/* fnabs */
-/* XXX: beware that fnabs never checks for NaNs nor update FPSCR */
-static void gen_fnabs(DisasContext *ctx)
+/* XXX: beware that f{neg, abs, nabs} never checks for NaNs nor update FPSCR */
+static bool do_move_b(DisasContext *ctx, arg_X_tb_rc *a, int64_t val,
+                      void (*tcg_op)(TCGv_i64, TCGv_i64, int64_t))
 {
-    TCGv_i64 t0;
-    TCGv_i64 t1;
-    if (unlikely(!ctx->fpu_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_FPU);
-        return;
-    }
+    TCGv_i64 t0, t1;
+    REQUIRE_INSNS_FLAGS(ctx, FLOAT);
+    REQUIRE_FPU(ctx);
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
-    get_fpr(t0, rB(ctx->opcode));
-    tcg_gen_ori_i64(t1, t0, 1ULL << 63);
-    set_fpr(rD(ctx->opcode), t1);
-    if (unlikely(Rc(ctx->opcode))) {
+    get_fpr(t0, a->rb);
+    tcg_op(t1, t0, val);
+    set_fpr(a->rt, t1);
+    if (unlikely(a->rc)) {
         gen_set_cr1_from_fpscr(ctx);
     }
+    return true;
 }
 
-/* fneg */
-/* XXX: beware that fneg never checks for NaNs nor update FPSCR */
-static void gen_fneg(DisasContext *ctx)
-{
-    TCGv_i64 t0;
-    TCGv_i64 t1;
-    if (unlikely(!ctx->fpu_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_FPU);
-        return;
-    }
-    t0 = tcg_temp_new_i64();
-    t1 = tcg_temp_new_i64();
-    get_fpr(t0, rB(ctx->opcode));
-    tcg_gen_xori_i64(t1, t0, 1ULL << 63);
-    set_fpr(rD(ctx->opcode), t1);
-    if (unlikely(Rc(ctx->opcode))) {
-        gen_set_cr1_from_fpscr(ctx);
-    }
-}
+TRANS(FNEG, do_move_b, 1ULL << 63, tcg_gen_xori_i64);
+TRANS(FABS, do_move_b, ~(1ULL << 63), tcg_gen_andi_i64);
+TRANS(FNABS, do_move_b, 1ULL << 63, tcg_gen_ori_i64);
 
 /* fcpsgn: PowerPC 2.05 specification */
 /* XXX: beware that fcpsgn never checks for NaNs nor update FPSCR */
diff --git a/target/ppc/translate/fp-ops.c.inc b/target/ppc/translate/fp-ops.c.inc
index 502453da35..5053cb135c 100644
--- a/target/ppc/translate/fp-ops.c.inc
+++ b/target/ppc/translate/fp-ops.c.inc
@@ -10,10 +10,6 @@ GEN_STXF(stfiw, st32fiw, 0x17, 0x1E, PPC_FLOAT_STFIWX)
 GEN_HANDLER_E(stfdepx, 0x1F, 0x1F, 0x16, 0x00000001, PPC_NONE, PPC2_BOOKE206),
 GEN_HANDLER_E(stfdpx, 0x1F, 0x17, 0x1C, 0x00200001, PPC_NONE, PPC2_ISA205),
 
-GEN_HANDLER(fabs, 0x3F, 0x08, 0x08, 0x001F0000, PPC_FLOAT),
-GEN_HANDLER(fmr, 0x3F, 0x08, 0x02, 0x001F0000, PPC_FLOAT),
-GEN_HANDLER(fnabs, 0x3F, 0x08, 0x04, 0x001F0000, PPC_FLOAT),
-GEN_HANDLER(fneg, 0x3F, 0x08, 0x01, 0x001F0000, PPC_FLOAT),
 GEN_HANDLER_E(fcpsgn, 0x3F, 0x08, 0x00, 0x00000000, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER_E(fmrgew, 0x3F, 0x06, 0x1E, 0x00000001, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER_E(fmrgow, 0x3F, 0x06, 0x1A, 0x00000001, PPC_NONE, PPC2_VSX207),
-- 
2.49.0


