Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD56C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 09:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSC36-000051-78; Thu, 19 Jun 2025 05:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uSC34-0008VQ-0h; Thu, 19 Jun 2025 05:59:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uSC31-0007s2-UR; Thu, 19 Jun 2025 05:59:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J4Wuw3030933;
 Thu, 19 Jun 2025 09:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=w3lRTcVHMbDbBI86f
 WK9GVMk2jXQQqD4AMqpkvjqYec=; b=tId1pBXtLQC1xZPfpX8nsEGeSu8iTpTyu
 rUx1vRr0C/tli3yHSc1ruUZ6ripDzKmCso5O2B5iCq9yN4ZvONjPFo3Uxz89H873
 lVAbD67LS6CpaTGbdP87K1ekTU6nwCeJXC8kGhhnYjRguvVezvyf7lxlHkwuyvJa
 xfqCGHUOthasKjchdcE3oKDlIBvoaT3hdzs2xt4N5XY7NQT5fLvotzJxKOLR53Cb
 qj2I8eD9vc4wWdyJe/FE6+0Jy6BW89mIWvEGmAceuBiNDv9vk2xTjhu/Vzb83wY3
 ACg2rPfvmSMOqw+69wFkH3hsHaMXO6ap1KrYcumVU0MI9V82xW5QQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ktvrw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:59:05 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55J9gksO026115;
 Thu, 19 Jun 2025 09:59:04 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ktvrw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:59:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55J8UqYe005544;
 Thu, 19 Jun 2025 09:59:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mwmdevh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:59:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55J9x17u17629602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Jun 2025 09:59:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6D4C20043;
 Thu, 19 Jun 2025 09:59:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DD4220040;
 Thu, 19 Jun 2025 09:59:00 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.in.ibm.com (unknown
 [9.79.200.241]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Jun 2025 09:59:00 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 danielhb413@gmail.com
Cc: richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 4/5] target/ppc: Move remaining floating-point move
 instructions to decodetree.
Date: Thu, 19 Jun 2025 15:28:39 +0530
Message-ID: <20250619095840.369351-5-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619095840.369351-1-rathc@linux.ibm.com>
References: <20250619095840.369351-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _O1VVrYv5YbDWIw7GzQbZiRES1qfo_5h
X-Proofpoint-ORIG-GUID: EBZZNyo5ODdAcZTgoHFqkYLZdyFQo1Tb
X-Authority-Analysis: v=2.4 cv=KaDSsRYD c=1 sm=1 tr=0 ts=6853df69 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=6iusX0EGUSGkvFOFRKcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA4MiBTYWx0ZWRfX/2d2HfJPs4lf
 s7QvR91nekxI76LqqBH1kTu7YYKcQcpH9EEYPbnbwwVCbe4WDp4RpY1d2K8DfYbK/AUjVhThbuA
 AYSUnKIciWARYaLVAEAcblRi8+INSttj1vOAgJyYmRX+9OZUPTtStNuQ+uqL/5ruhVOOxYHGBhP
 uHtkiPCxuFAB+B5o20x8hOzhBkfnj5aSNJiAxCbV5YFtJVVWH0EplNR+yPGBL90VoznoYV3RRcC
 rQvPYkT1qKcvYjosI3JvweVnFzwlFtsFNrs65LTmm0TEpRFcjYU2dfmVKzXEliUtU2VfMxxkhrh
 A2mo1skFyaqIhb/+ElAh8h2Cn0jaJVPvibHhUh1RKXmb/z9Y30DJV/yC2TeibJnNiqRbx/QQASI
 RX65la7jDpN0nd1OVc4cOgj3YTtr/PtpN/CNgHOWXSoicd5WGs503HGyfQA7tCNmW17YnaLo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506190082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

	fcpsgn, fmrg{e, o}w	: X-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode           |  4 ++
 target/ppc/translate/fp-impl.c.inc | 65 +++++++++++++-----------------
 target/ppc/translate/fp-ops.c.inc  |  3 --
 3 files changed, 32 insertions(+), 40 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index abbdb9fd82..84f9fcd519 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -510,6 +510,10 @@ FNEG            111111 ..... ----- ..... 0000101000 .   @X_tb_rc
 FABS            111111 ..... ----- ..... 0100001000 .   @X_tb_rc
 FNABS           111111 ..... ----- ..... 0010001000 .   @X_tb_rc
 
+FCPSGN          111111 ..... ..... ..... 0000001000 .   @X_rc
+FMRGEW          111111 ..... ..... ..... 1111000110 -   @X
+FMRGOW          111111 ..... ..... ..... 1101000110 -   @X
+
 ### Floating-Point Arithmetic Instructions
 
 FADD            111111 ..... ..... ..... ----- 10101 .  @A_tab
diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index 2843f71122..28dda15040 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -321,62 +321,53 @@ TRANS(FNABS, do_move_b, 1ULL << 63, tcg_gen_ori_i64);
 
 /* fcpsgn: PowerPC 2.05 specification */
 /* XXX: beware that fcpsgn never checks for NaNs nor update FPSCR */
-static void gen_fcpsgn(DisasContext *ctx)
+static bool trans_FCPSGN(DisasContext *ctx, arg_FCPSGN *a)
 {
-    TCGv_i64 t0;
-    TCGv_i64 t1;
-    TCGv_i64 t2;
-    if (unlikely(!ctx->fpu_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_FPU);
-        return;
-    }
+    TCGv_i64 t0, t1, t2;
+    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
+    REQUIRE_FPU(ctx);
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     t2 = tcg_temp_new_i64();
-    get_fpr(t0, rA(ctx->opcode));
-    get_fpr(t1, rB(ctx->opcode));
+    get_fpr(t0, a->ra);
+    get_fpr(t1, a->rb);
     tcg_gen_deposit_i64(t2, t0, t1, 0, 63);
-    set_fpr(rD(ctx->opcode), t2);
-    if (unlikely(Rc(ctx->opcode))) {
+    set_fpr(a->rt, t2);
+    if (unlikely(a->rc)) {
         gen_set_cr1_from_fpscr(ctx);
     }
+    return true;
 }
 
-static void gen_fmrgew(DisasContext *ctx)
+static bool trans_FMRGEW(DisasContext *ctx, arg_FMRGEW *a)
 {
-    TCGv_i64 b0;
-    TCGv_i64 t0;
-    TCGv_i64 t1;
-    if (unlikely(!ctx->fpu_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_FPU);
-        return;
-    }
-    b0 = tcg_temp_new_i64();
+    TCGv_i64 t0, t1, t2;
+    REQUIRE_INSNS_FLAGS2(ctx, VSX207);
+    REQUIRE_FPU(ctx);
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
-    get_fpr(t0, rB(ctx->opcode));
-    tcg_gen_shri_i64(b0, t0, 32);
-    get_fpr(t0, rA(ctx->opcode));
-    tcg_gen_deposit_i64(t1, t0, b0, 0, 32);
-    set_fpr(rD(ctx->opcode), t1);
+    t2 = tcg_temp_new_i64();
+    get_fpr(t1, a->rb);
+    tcg_gen_shri_i64(t0, t1, 32);
+    get_fpr(t1, a->ra);
+    tcg_gen_deposit_i64(t2, t1, t0, 0, 32);
+    set_fpr(a->rt, t2);
+    return true;
 }
 
-static void gen_fmrgow(DisasContext *ctx)
+static bool trans_FMRGOW(DisasContext *ctx, arg_FMRGOW *a)
 {
-    TCGv_i64 t0;
-    TCGv_i64 t1;
-    TCGv_i64 t2;
-    if (unlikely(!ctx->fpu_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_FPU);
-        return;
-    }
+    TCGv_i64 t0, t1, t2;
+    REQUIRE_INSNS_FLAGS2(ctx, VSX207);
+    REQUIRE_FPU(ctx);
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     t2 = tcg_temp_new_i64();
-    get_fpr(t0, rB(ctx->opcode));
-    get_fpr(t1, rA(ctx->opcode));
+    get_fpr(t0, a->rb);
+    get_fpr(t1, a->ra);
     tcg_gen_deposit_i64(t2, t0, t1, 32, 32);
-    set_fpr(rD(ctx->opcode), t2);
+    set_fpr(a->rt, t2);
+    return true;
 }
 
 /***                  Floating-Point status & ctrl register                ***/
diff --git a/target/ppc/translate/fp-ops.c.inc b/target/ppc/translate/fp-ops.c.inc
index 5053cb135c..9bc9c3a3c3 100644
--- a/target/ppc/translate/fp-ops.c.inc
+++ b/target/ppc/translate/fp-ops.c.inc
@@ -10,9 +10,6 @@ GEN_STXF(stfiw, st32fiw, 0x17, 0x1E, PPC_FLOAT_STFIWX)
 GEN_HANDLER_E(stfdepx, 0x1F, 0x1F, 0x16, 0x00000001, PPC_NONE, PPC2_BOOKE206),
 GEN_HANDLER_E(stfdpx, 0x1F, 0x17, 0x1C, 0x00200001, PPC_NONE, PPC2_ISA205),
 
-GEN_HANDLER_E(fcpsgn, 0x3F, 0x08, 0x00, 0x00000000, PPC_NONE, PPC2_ISA205),
-GEN_HANDLER_E(fmrgew, 0x3F, 0x06, 0x1E, 0x00000001, PPC_NONE, PPC2_VSX207),
-GEN_HANDLER_E(fmrgow, 0x3F, 0x06, 0x1A, 0x00000001, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER(mcrfs, 0x3F, 0x00, 0x02, 0x0063F801, PPC_FLOAT),
 GEN_HANDLER(mtfsb0, 0x3F, 0x06, 0x02, 0x001FF800, PPC_FLOAT),
 GEN_HANDLER(mtfsb1, 0x3F, 0x06, 0x01, 0x001FF800, PPC_FLOAT),
-- 
2.49.0


