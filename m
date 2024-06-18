Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B18C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 08:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJUgL-0004eG-L0; Tue, 18 Jun 2024 04:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sJUgD-0004by-GD; Tue, 18 Jun 2024 04:59:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sJUgB-0006lA-2j; Tue, 18 Jun 2024 04:59:05 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I7rCUt013350;
 Tue, 18 Jun 2024 08:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=h5oz7ePfeEeLt
 YDmywAsNm6GdxzNVvq12natWXVkPf4=; b=au1+ofiH0e3t8wQ8MI43tGbc9zW2F
 I8TV+6BjQu37KeCl2iYs3kBDu7NrSCRZsD0QT9hbRtq6IRzFZ6phNOjtIyTh1D8v
 WgzfZ9PWe5aZP/lxJXucaT4P2xu6C+5RzIr/yeG5TO578E1vOUvhORdZdiw0HjVj
 VfDbXre0yC17iz/+TxGCVCYddStoU2OOcbQBk7HeSk5Pghl0Twe9pyuyoYOs+fvx
 vNoPzAOnBaOOks9LRF41wqN0n6hecfJ+tOadZ24bDnC3kl2yVs/osTxjwImOBbwW
 lL59C3c5lUw5hgO7rApvHhGuPNXu5YvbycPnxS8X2mqs2Y3EDzcO8oFsg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu4jaresv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:58:59 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45I8wc44020384;
 Tue, 18 Jun 2024 08:58:58 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu4jaresn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:58:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45I6p0cv019545; Tue, 18 Jun 2024 08:58:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysnp11kcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:58:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45I8wq0W44695984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2024 08:58:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09D422004B;
 Tue, 18 Jun 2024 08:58:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C0CB020040;
 Tue, 18 Jun 2024 08:58:50 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jun 2024 08:58:50 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v3 4/4] target/ppc: Move VSX fp compare insns to decodetree.
Date: Tue, 18 Jun 2024 14:28:31 +0530
Message-Id: <20240618085831.546883-5-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240618085831.546883-1-rathc@linux.ibm.com>
References: <20240618085831.546883-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hiOykGJ8xjHH6pwXGlx2UHf_VFH14JYb
X-Proofpoint-GUID: E2dNFBbrQSgY-vj4jPxafPunbskQF0eU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=958 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180065
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Moving the following instructions to decodetree specification:

	xvcmp{eq, gt, ge, ne}{s, d}p	: XX3-form

The changes were verified by validating that the tcg-ops generated for those
instructions remain the same which were captured using the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                 | 16 +++++-----
 target/ppc/insn32.decode            | 12 ++++++++
 target/ppc/fpu_helper.c             | 16 +++++-----
 target/ppc/translate/vsx-impl.c.inc | 46 +++++++++++++----------------
 target/ppc/translate/vsx-ops.c.inc  | 18 -----------
 5 files changed, 48 insertions(+), 60 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 510ce76524..3fd849628a 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -473,10 +473,10 @@ DEF_HELPER_5(xvnmadddp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(xvnmsubdp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_4(XVMAXDP, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(XVMINDP, void, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpeqdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpgedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpgtdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpnedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPEQDP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPGEDP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPGTDP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPNEDP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_3(xvcvdpsp, void, env, vsr, vsr)
 DEF_HELPER_3(xvcvdpsxds, void, env, vsr, vsr)
 DEF_HELPER_3(xvcvdpsxws, void, env, vsr, vsr)
@@ -507,10 +507,10 @@ DEF_HELPER_5(xvnmaddsp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(xvnmsubsp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_4(XVMAXSP, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(XVMINSP, void, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpeqsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpgesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpgtsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
-DEF_HELPER_FLAGS_4(xvcmpnesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPEQSP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPGESP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPGTSP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
+DEF_HELPER_FLAGS_4(XVCMPNESP, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_3(xvcvspdp, void, env, vsr, vsr)
 DEF_HELPER_3(xvcvsphp, void, env, vsr, vsr)
 DEF_HELPER_3(xvcvhpsp, void, env, vsr, vsr)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 3d31ef52f8..bcaf03f24c 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -217,6 +217,9 @@
 &XX3            xt xa xb
 @XX3            ...... ..... ..... ..... ........ ...           &XX3 xt=%xx_xt xa=%xx_xa xb=%xx_xb
 
+&XX3_rc         xt xa xb rc:bool
+@XX3_rc         ...... ..... ..... ..... rc:1 ....... ...       &XX3_rc xt=%xx_xt xa=%xx_xa xb=%xx_xb
+
 # 32 bit GER instructions have all mask bits considered 1
 &MMIRR_XX3      xa xb xt pmsk xmsk ymsk
 %xx_at          23:3
@@ -923,6 +926,15 @@ XSCMPEQQP       111111 ..... ..... ..... 0001000100 -   @X
 XSCMPGEQP       111111 ..... ..... ..... 0011000100 -   @X
 XSCMPGTQP       111111 ..... ..... ..... 0011100100 -   @X
 
+XVCMPEQSP       111100 ..... ..... ..... . 1000011 ...   @XX3_rc
+XVCMPGTSP       111100 ..... ..... ..... . 1001011 ...   @XX3_rc
+XVCMPGESP       111100 ..... ..... ..... . 1010011 ...   @XX3_rc
+XVCMPNESP       111100 ..... ..... ..... . 1011011 ...   @XX3_rc
+XVCMPEQDP       111100 ..... ..... ..... . 1100011 ...   @XX3_rc
+XVCMPGTDP       111100 ..... ..... ..... . 1101011 ...   @XX3_rc
+XVCMPGEDP       111100 ..... ..... ..... . 1110011 ...   @XX3_rc
+XVCMPNEDP       111100 ..... ..... ..... . 1111011 ...   @XX3_rc
+
 XSMAXDP         111100 ..... ..... ..... 10100000 ...   @XX3
 XSMINDP         111100 ..... ..... ..... 10101000 ...   @XX3
 
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index a013160644..5a300a3c86 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2624,14 +2624,14 @@ uint32_t helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                     \
     return crf6;                                                          \
 }
 
-VSX_CMP(xvcmpeqdp, 2, float64, VsrD(i), eq, 0, 1)
-VSX_CMP(xvcmpgedp, 2, float64, VsrD(i), le, 1, 1)
-VSX_CMP(xvcmpgtdp, 2, float64, VsrD(i), lt, 1, 1)
-VSX_CMP(xvcmpnedp, 2, float64, VsrD(i), eq, 0, 0)
-VSX_CMP(xvcmpeqsp, 4, float32, VsrW(i), eq, 0, 1)
-VSX_CMP(xvcmpgesp, 4, float32, VsrW(i), le, 1, 1)
-VSX_CMP(xvcmpgtsp, 4, float32, VsrW(i), lt, 1, 1)
-VSX_CMP(xvcmpnesp, 4, float32, VsrW(i), eq, 0, 0)
+VSX_CMP(XVCMPEQDP, 2, float64, VsrD(i), eq, 0, 1)
+VSX_CMP(XVCMPGEDP, 2, float64, VsrD(i), le, 1, 1)
+VSX_CMP(XVCMPGTDP, 2, float64, VsrD(i), lt, 1, 1)
+VSX_CMP(XVCMPNEDP, 2, float64, VsrD(i), eq, 0, 0)
+VSX_CMP(XVCMPEQSP, 4, float32, VsrW(i), eq, 0, 1)
+VSX_CMP(XVCMPGESP, 4, float32, VsrW(i), le, 1, 1)
+VSX_CMP(XVCMPGTSP, 4, float32, VsrW(i), lt, 1, 1)
+VSX_CMP(XVCMPNESP, 4, float32, VsrW(i), eq, 0, 0)
 
 /*
  * VSX_CVT_FP_TO_FP - VSX floating point/floating point conversion
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index e0fb4bad92..26ebf3fedf 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -792,34 +792,28 @@ static bool do_xvcpsgn(DisasContext *ctx, arg_XX3 *a, unsigned vece)
 TRANS(XVCPSGNSP, do_xvcpsgn, MO_32)
 TRANS(XVCPSGNDP, do_xvcpsgn, MO_64)
 
-#define VSX_CMP(name, op1, op2, inval, type)                                  \
-static void gen_##name(DisasContext *ctx)                                     \
-{                                                                             \
-    TCGv_i32 ignored;                                                         \
-    TCGv_ptr xt, xa, xb;                                                      \
-    if (unlikely(!ctx->vsx_enabled)) {                                        \
-        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
-        return;                                                               \
-    }                                                                         \
-    xt = gen_vsr_ptr(xT(ctx->opcode));                                        \
-    xa = gen_vsr_ptr(xA(ctx->opcode));                                        \
-    xb = gen_vsr_ptr(xB(ctx->opcode));                                        \
-    if ((ctx->opcode >> (31 - 21)) & 1) {                                     \
-        gen_helper_##name(cpu_crf[6], tcg_env, xt, xa, xb);                   \
-    } else {                                                                  \
-        ignored = tcg_temp_new_i32();                                         \
-        gen_helper_##name(ignored, tcg_env, xt, xa, xb);                      \
-    }                                                                         \
+static bool do_cmp(DisasContext *ctx, arg_XX3_rc *a,
+            void (*helper)(TCGv_i32, TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr))
+{
+    TCGv_i32 dest;
+    TCGv_ptr xt, xa, xb;
+    REQUIRE_VSX(ctx);
+    xt = gen_vsr_ptr(a->xt);
+    xa = gen_vsr_ptr(a->xa);
+    xb = gen_vsr_ptr(a->xb);
+    dest = a->rc ? cpu_crf[6] : tcg_temp_new_i32();
+    helper(dest, tcg_env, xt, xa, xb);
+    return true;
 }
 
-VSX_CMP(xvcmpeqdp, 0x0C, 0x0C, 0, PPC2_VSX)
-VSX_CMP(xvcmpgedp, 0x0C, 0x0E, 0, PPC2_VSX)
-VSX_CMP(xvcmpgtdp, 0x0C, 0x0D, 0, PPC2_VSX)
-VSX_CMP(xvcmpnedp, 0x0C, 0x0F, 0, PPC2_ISA300)
-VSX_CMP(xvcmpeqsp, 0x0C, 0x08, 0, PPC2_VSX)
-VSX_CMP(xvcmpgesp, 0x0C, 0x0A, 0, PPC2_VSX)
-VSX_CMP(xvcmpgtsp, 0x0C, 0x09, 0, PPC2_VSX)
-VSX_CMP(xvcmpnesp, 0x0C, 0x0B, 0, PPC2_VSX)
+TRANS_FLAGS2(VSX, XVCMPEQSP, do_cmp, gen_helper_XVCMPEQSP);
+TRANS_FLAGS2(VSX, XVCMPGTSP, do_cmp, gen_helper_XVCMPGTSP);
+TRANS_FLAGS2(VSX, XVCMPGESP, do_cmp, gen_helper_XVCMPGESP);
+TRANS_FLAGS2(ISA300, XVCMPNESP, do_cmp, gen_helper_XVCMPNESP);
+TRANS_FLAGS2(VSX, XVCMPEQDP, do_cmp, gen_helper_XVCMPEQDP);
+TRANS_FLAGS2(VSX, XVCMPGTDP, do_cmp, gen_helper_XVCMPGTDP);
+TRANS_FLAGS2(VSX, XVCMPGEDP, do_cmp, gen_helper_XVCMPGEDP);
+TRANS_FLAGS2(ISA300, XVCMPNEDP, do_cmp, gen_helper_XVCMPNEDP);
 
 static bool trans_XSCVQPDP(DisasContext *ctx, arg_X_tb_rc *a)
 {
diff --git a/target/ppc/translate/vsx-ops.c.inc b/target/ppc/translate/vsx-ops.c.inc
index 91cde088bc..e553b5b8fa 100644
--- a/target/ppc/translate/vsx-ops.c.inc
+++ b/target/ppc/translate/vsx-ops.c.inc
@@ -43,16 +43,6 @@ GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 1, PPC_NONE, fl2), \
 GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 2, opc3, 1, PPC_NONE, fl2), \
 GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 3, opc3, 1, PPC_NONE, fl2)
 
-#define GEN_XX3_RC_FORM(name, opc2, opc3, fl2)                          \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x00, opc3 | 0x00, 0, PPC_NONE, fl2), \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x01, opc3 | 0x00, 0, PPC_NONE, fl2), \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x02, opc3 | 0x00, 0, PPC_NONE, fl2), \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x03, opc3 | 0x00, 0, PPC_NONE, fl2), \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x00, opc3 | 0x10, 0, PPC_NONE, fl2), \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x01, opc3 | 0x10, 0, PPC_NONE, fl2), \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x02, opc3 | 0x10, 0, PPC_NONE, fl2), \
-GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0x03, opc3 | 0x10, 0, PPC_NONE, fl2)
-
 #define GEN_XX3FORM_DM(name, opc2, opc3) \
 GEN_HANDLER2_E(name, #name, 0x3C, opc2|0x00, opc3|0x00, 0, PPC_NONE, PPC2_VSX),\
 GEN_HANDLER2_E(name, #name, 0x3C, opc2|0x01, opc3|0x00, 0, PPC_NONE, PPC2_VSX),\
@@ -175,10 +165,6 @@ GEN_XX3FORM_NAME(xvnmadddp, "xvnmaddadp", 0x04, 0x1C, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmadddp, "xvnmaddmdp", 0x04, 0x1D, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmsubdp, "xvnmsubadp", 0x04, 0x1E, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmsubdp, "xvnmsubmdp", 0x04, 0x1F, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpeqdp, 0x0C, 0x0C, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpgtdp, 0x0C, 0x0D, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpgedp, 0x0C, 0x0E, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpnedp, 0x0C, 0x0F, PPC2_ISA300),
 GEN_XX2FORM(xvcvdpsp, 0x12, 0x18, PPC2_VSX),
 GEN_XX2FORM(xvcvdpsxds, 0x10, 0x1D, PPC2_VSX),
 GEN_XX2FORM(xvcvdpsxws, 0x10, 0x0D, PPC2_VSX),
@@ -207,10 +193,6 @@ GEN_XX3FORM_NAME(xvnmaddsp, "xvnmaddasp", 0x04, 0x18, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmaddsp, "xvnmaddmsp", 0x04, 0x19, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmsubsp, "xvnmsubasp", 0x04, 0x1A, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmsubsp, "xvnmsubmsp", 0x04, 0x1B, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpeqsp, 0x0C, 0x08, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpgtsp, 0x0C, 0x09, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpgesp, 0x0C, 0x0A, PPC2_VSX),
-GEN_XX3_RC_FORM(xvcmpnesp, 0x0C, 0x0B, PPC2_ISA300),
 GEN_XX2FORM(xvcvspdp, 0x12, 0x1C, PPC2_VSX),
 GEN_XX2FORM(xvcvspsxds, 0x10, 0x19, PPC2_VSX),
 GEN_XX2FORM(xvcvspsxws, 0x10, 0x09, PPC2_VSX),
-- 
2.39.3


