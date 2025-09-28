Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA41CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3U-0002zE-5y; Sun, 28 Sep 2025 15:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3S-0002xM-3p
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3I-00048o-PE
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SHxl12028246;
 Sun, 28 Sep 2025 19:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=UfIZ0k0Dc8XPk6O8w
 GUyEt/o4zFT9Ab7fZAYudydsTw=; b=LHM8LZvnpnsn2lcVj4HaK9MwUzDlO4CE2
 yAHTgiUQ6qrvFucx3ynrsBDZYhW7s84D/IzWQIlAs3xPPJU8AWZpBx8fjacXPiUN
 kSESmTq2ogp8NoTS3uUchLDM4CPTQ83MKMOeUCBMkW9P+BNOQedJJiJw/PX8miw4
 RRgLwfLclIpbbRh7mjgdO9PSOFIVsk8YVcurffjFNRSaQp6sSuKd89v1uA0qLhT9
 xFpRvPYZzAFsiNVRDVsv/B3Btr3SIgB5pdTIRswblVr/6O/opWTZTE2sHs1lx/kO
 iSzeTwYwWxhNo8MwumcxN8WycOIQo75FTqq4FIcnFiyFlwv4zgDJw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh6qcs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:27:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SH6FeR020061;
 Sun, 28 Sep 2025 19:27:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8ru1e2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:27:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJRDcT50528706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:27:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3122D2004B;
 Sun, 28 Sep 2025 19:27:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D5CD20040;
 Sun, 28 Sep 2025 19:27:12 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:27:11 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 24/27] target/ppc: Move remaining floating-point move
 instructions to decodetree.
Date: Mon, 29 Sep 2025 00:56:26 +0530
Message-ID: <20250928192629.139822-25-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68d98c15 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=zPOmP9BgHNOD40qC0pcA:9 a=cvBusfyB2V15izCimMoJ:22
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX+5vJFmbyW0fN
 JJ2Eul2Ur/jIQTo+vuF06Fc7HzCyqi7mOPcBa1XKG4qy9SBoXZ6R7S/P8wtWxUDZeEjLimc0I7v
 bvmiLoJdpUj4ygHDqAkJEaDIKWhJsiBlMnAifQKoC00zGeuojbWz8ZWe9DcTmRz1LZBnVVrmQat
 sk7PyuqPoKThkhcsjyNEkquOnQ3V+PP/KpvQFHgoGYt6Rn83lMVaK4zUI/QTXw9ckdEBuB1C87S
 KGkQSxA7wp+Qp5ifa352CK6MHgd0H5UcIstBU2koxnRKXL45Pl79hmpd4n6DmqjvhUqpkXF9OjR
 ZBvCq6mG7nqSaJQLpkEb6Ht1IR6xCM4Db2WO90ugHDxUrsAXlf9x7e7EJgbR7G/oQBGqZbsS83B
 wQ6OjF9CoWiD10KPTIXwAfVCthAHvg==
X-Proofpoint-GUID: vdu05Ur2Ok_LNwywXOiuZCHkcZxbYJZj
X-Proofpoint-ORIG-GUID: vdu05Ur2Ok_LNwywXOiuZCHkcZxbYJZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010
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

	fcpsgn, fmrg{e, o}w	: X-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250619095840.369351-5-rathc@linux.ibm.com
Message-ID: <20250619095840.369351-5-rathc@linux.ibm.com>
---
 target/ppc/insn32.decode           |  4 ++
 target/ppc/translate/fp-impl.c.inc | 65 +++++++++++++-----------------
 target/ppc/translate/fp-ops.c.inc  |  3 --
 3 files changed, 32 insertions(+), 40 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 063d5726cb..0e9c68f2fb 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -537,6 +537,10 @@ FNEG            111111 ..... ----- ..... 0000101000 .   @X_tb_rc
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
2.43.5


