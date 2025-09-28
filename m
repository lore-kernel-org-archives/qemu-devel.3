Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE04CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3o-0003CY-Se; Sun, 28 Sep 2025 15:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3Z-00032b-52
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3S-00048O-S7
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SHVViW008078;
 Sun, 28 Sep 2025 19:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ZzfpCMciRpwKaURik
 4UQBgOVjKPhOEyFnK/J59woDow=; b=ko7Mv6ouFH009Qe9HENk8cYd0kegMq+/n
 PMLevrkBfBxtR6xzNK4QvXtsxibkFc8kahXFMBehussrrW8e/4kQeyqSDia1riUz
 i97ym92rzkiFeT0aFpypDGjlkrbvZMrRcLRyo6OpZI0y/a2bk5SNjwV7TjHMJDds
 Dso148ts5OiGiInjw1+HKPxUbs/Ek853Efee6ejaemGvI5LS4ageXfj1bzz7XWeO
 g+KcAljGEwPOArDTZ6FaY7IZXxdiQi/gqhufChS2U5dFeXD71mBYqOOcp8yeSOy1
 psENgkOdlM4DZtF+2e6oWsQyxLOKdWZO5UO7vas1SP65PO3RMJ0vA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5bqevgc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:27:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SH0MqD003369;
 Sun, 28 Sep 2025 19:27:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmxk033-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:27:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJRBM555705974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:27:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C257120049;
 Sun, 28 Sep 2025 19:27:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE4E420040;
 Sun, 28 Sep 2025 19:27:10 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:27:10 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/27] target/ppc: Move floating-point move instructions to
 decodetree.
Date: Mon, 29 Sep 2025 00:56:25 +0530
Message-ID: <20250928192629.139822-24-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDIxNCBTYWx0ZWRfXyGEhFO39OHQ1
 HUhjkMx96/4xFusFQdpnzIu8YQWiEGzkzVXjT3+uS0clWlH2i9HQSuinyaSHqtLwICwtyRPvFke
 fCTVY/ZrTBgO7ibmFMhogPp2oAPUCpZgKoPxbYSJQnQYG9kOJxosbm/4ROy5SGP2eUc0aPEXiq3
 VrqttVEojRoMG6naeJfcT9EW3uxDbQJT71HbF9NjFk/t6+39KtJCgeNnnK73zzP7Bk3IibgYtQm
 ib2cyiB5Io1c8UCL5uOCX7x63uELr3rCK435UVr+Hk6Ht8ZmTKwtjP8GEBOkCzJy/3BEa5I63Hy
 zBjiPqkBRLwA7Y9dsCLhCS09TKxTxu3TM/88VBruKgfeKTbbeu+t5b45sksSbj3Lmdk33XFUS+i
 2HHc6MaagN6Ex9QAan0IIsL6a7n5/g==
X-Proofpoint-GUID: A2bxKhSWS9nWzvhaV5-3gK_3sVYQfYHc
X-Authority-Analysis: v=2.4 cv=LLZrgZW9 c=1 sm=1 tr=0 ts=68d98c14 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=R2UZqdDKM_ImC5moMnwA:9 a=cvBusfyB2V15izCimMoJ:22
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-ORIG-GUID: A2bxKhSWS9nWzvhaV5-3gK_3sVYQfYHc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260214
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Chinmay Rath <rathc@linux.ibm.com>

Move below instructions to decodetree specification:

	f{mr, neg, abs, nabs}		: X-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250619095840.369351-4-rathc@linux.ibm.com
Message-ID: <20250619095840.369351-4-rathc@linux.ibm.com>
---
 target/ppc/insn32.decode           |  7 +++
 target/ppc/translate/fp-impl.c.inc | 80 ++++++++----------------------
 target/ppc/translate/fp-ops.c.inc  |  4 --
 3 files changed, 28 insertions(+), 63 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index d446ec534d..063d5726cb 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -530,6 +530,13 @@ STFDU           110111 ..... ...... ...............     @D
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
2.43.5


