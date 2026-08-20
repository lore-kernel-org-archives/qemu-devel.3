Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8A2C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3PW-0006gU-51; Thu, 20 Aug 2026 10:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3PS-0006MZ-3L; Thu, 20 Aug 2026 10:06:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3PQ-0006iJ-4k; Thu, 20 Aug 2026 10:06:21 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8cIgj504073; Thu, 20 Aug 2026 14:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=shdGJuop2JWCG5U7d
 56w0FKLTkpS5L8Z5Zf0cMuu51A=; b=FLT19mbP6pND120jjx5JEmiPpbR3Mxvwk
 x0Rl0Vt0dpl5BHIxXs27HccYJIHHXf+ekZg2WyMnSjbchVnkdh8cO0SpUII+Cb+y
 jWXHud9gpUrwm7IziJJqn6KS7KV11ArmWx8KRtxtCDAGkI/dDzvQ9Mubt3bkRIFC
 2inIWjGZiI1OhvQZCJ0DqhTrDQ1hT4kcvZpgTRpdGTl8SQ0TOLw/cBKnkSvUOz1c
 G61AZbwkrXNBkzCdrxmBMSqcSWn6qCv228Z6HU7uGFxRyITh83GL5OxXOSdWE8e4
 0J1yABXRJw3MZAKIaTyG5PlSXBjR3AdUDeWTuJhhRlAS3zlG1f05g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4am6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:06:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuIhA014849;
 Thu, 20 Aug 2026 14:06:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngpqmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:06:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KE697444171608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:06:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A47B22004B;
 Thu, 20 Aug 2026 14:06:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24E2920040;
 Thu, 20 Aug 2026 14:05:58 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:05:57 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 21/29] target/ppc: Move Condition Register logical
 instructions to decodetree.
Date: Thu, 20 Aug 2026 19:30:50 +0530
Message-ID: <20260820140114.327023-22-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820140114.327023-1-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a8709d9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=hG2spAfxjb5FyaO2x7EA:9
X-Proofpoint-ORIG-GUID: Yx6JNzmSf6EOH6Nj-WZTyn9UW7R0gsjF
X-Proofpoint-GUID: sS8C_zgKhpRt5F_rBZBTHNQwqvmnnxRE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfXx4FOgWkaXgqG
 bU8qI9ZQSTs38UCTNQfOrEsZq6p0y58PKZUcP9WerG1izPhPuK7misXw5UBLwVpoMv7b4J4J8kT
 JGhgvlugRmJpikmhPD7khJIcm1sXsAw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX6ONHHfwJfIww
 mr9E6ZM7mqKRoZxoYOolzT8Ei6FFJmalZYlGYj9BUX6h+Q7AcO6/HXy310C4wYklnpPynVxlM1b
 RzQ6OVix/Pqt56rWEzLbS2sZ+12aUiAzhmqq1dHLEaXt4I7WpMqSG/CEr7Ka1XA2I38OFWYLWMR
 Z+Wr/f3b7lVDh85ENOjILOgsszeJmyHXjnrBIye1gVZMkZQBqu9OE6ql0lcJKtlfzCJFi0fgdaX
 ambScNwle5Wpv+6+u0cGfoKzQ6iSM0rqs3FVbRiUQ4IUGddIhiWs7FTrDLF/dPuK9NAdp6vYEOf
 GhF3Q9P4pC81JTg/XyMclSKdYwWD9NhvsbU+YdGSbAn/ZxdDAVxRBDh40rGXIRgOFU8PiiXgp+B
 /l3F7bM3NC/nWF/m/+5GPL2OZsiEMHQv6rd//TVrYM+rGJ1irtUeWFD5MzIcrYimm/XbahlAJLt
 rBmoRcL0gfnFji9Uu1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200105
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

Move below instructions to decodetree specification :

        cr{and, or, xor, nand, nor, eqv, andc, orc}  : XL-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode                   | 11 ++++
 target/ppc/translate.c                     | 59 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 45 +++++++++++++++++
 3 files changed, 56 insertions(+), 59 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index dc708b5442..a3973e042d 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -516,6 +516,17 @@ CFUGED          011111 ..... ..... ..... 0011011100 -   @X
 PDEPD           011111 ..... ..... ..... 0010011100 -   @X
 PEXTD           011111 ..... ..... ..... 0010111100 -   @X
 
+## Condition Register Instructions
+
+CRAND           010011 ..... ..... ..... 0100000001 -  @X
+CROR            010011 ..... ..... ..... 0111000001 -  @X
+CRNAND          010011 ..... ..... ..... 0011100001 -  @X
+CRXOR           010011 ..... ..... ..... 0011000001 -  @X
+CRNOR           010011 ..... ..... ..... 0000100001 -  @X
+CREQV           010011 ..... ..... ..... 0100100001 -  @X
+CRANDC          010011 ..... ..... ..... 0010000001 -  @X
+CRORC           010011 ..... ..... ..... 0110100001 -  @X
+
 # Fixed-Point Hash Instructions
 
 HASHST          011111 ..... ..... ..... 1011010010 .   @X_DW
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index d01981de73..5b08d9b282 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2920,53 +2920,6 @@ static inline void gen_setlr(DisasContext *ctx, target_ulong nip)
     tcg_gen_movi_tl(cpu_lr, nip);
 }
 
-/***                      Condition register logical                       ***/
-#define GEN_CRLOGIC(name, tcg_op, opc)                                        \
-static void glue(gen_, name)(DisasContext *ctx)                               \
-{                                                                             \
-    uint8_t bitmask;                                                          \
-    int sh;                                                                   \
-    TCGv_i32 t0, t1;                                                          \
-    sh = (crbD(ctx->opcode) & 0x03) - (crbA(ctx->opcode) & 0x03);             \
-    t0 = tcg_temp_new_i32();                                                  \
-    if (sh > 0)                                                               \
-        tcg_gen_shri_i32(t0, cpu_crf[crbA(ctx->opcode) >> 2], sh);            \
-    else if (sh < 0)                                                          \
-        tcg_gen_shli_i32(t0, cpu_crf[crbA(ctx->opcode) >> 2], -sh);           \
-    else                                                                      \
-        tcg_gen_mov_i32(t0, cpu_crf[crbA(ctx->opcode) >> 2]);                 \
-    t1 = tcg_temp_new_i32();                                                  \
-    sh = (crbD(ctx->opcode) & 0x03) - (crbB(ctx->opcode) & 0x03);             \
-    if (sh > 0)                                                               \
-        tcg_gen_shri_i32(t1, cpu_crf[crbB(ctx->opcode) >> 2], sh);            \
-    else if (sh < 0)                                                          \
-        tcg_gen_shli_i32(t1, cpu_crf[crbB(ctx->opcode) >> 2], -sh);           \
-    else                                                                      \
-        tcg_gen_mov_i32(t1, cpu_crf[crbB(ctx->opcode) >> 2]);                 \
-    tcg_op(t0, t0, t1);                                                       \
-    bitmask = 0x08 >> (crbD(ctx->opcode) & 0x03);                             \
-    tcg_gen_andi_i32(t0, t0, bitmask);                                        \
-    tcg_gen_andi_i32(t1, cpu_crf[crbD(ctx->opcode) >> 2], ~bitmask);          \
-    tcg_gen_or_i32(cpu_crf[crbD(ctx->opcode) >> 2], t0, t1);                  \
-}
-
-/* crand */
-GEN_CRLOGIC(crand, tcg_gen_and_i32, 0x08);
-/* crandc */
-GEN_CRLOGIC(crandc, tcg_gen_andc_i32, 0x04);
-/* creqv */
-GEN_CRLOGIC(creqv, tcg_gen_eqv_i32, 0x09);
-/* crnand */
-GEN_CRLOGIC(crnand, tcg_gen_nand_i32, 0x07);
-/* crnor */
-GEN_CRLOGIC(crnor, tcg_gen_nor_i32, 0x01);
-/* cror */
-GEN_CRLOGIC(cror, tcg_gen_or_i32, 0x0E);
-/* crorc */
-GEN_CRLOGIC(crorc, tcg_gen_orc_i32, 0x0D);
-/* crxor */
-GEN_CRLOGIC(crxor, tcg_gen_xor_i32, 0x06);
-
 /***                           System linkage                              ***/
 
 /* rfi (supervisor only) */
@@ -5120,18 +5073,6 @@ GEN_STEPX(stw, DEF_MEMOP(MO_UL), 0x1F, 0x04)
 GEN_STEPX(std, DEF_MEMOP(MO_UQ), 0x1D, 0x04)
 #endif
 
-#undef GEN_CRLOGIC
-#define GEN_CRLOGIC(name, tcg_op, opc)                                        \
-GEN_HANDLER(name, 0x13, 0x01, opc, 0x00000001, PPC_INTEGER)
-GEN_CRLOGIC(crand, tcg_gen_and_i32, 0x08),
-GEN_CRLOGIC(crandc, tcg_gen_andc_i32, 0x04),
-GEN_CRLOGIC(creqv, tcg_gen_eqv_i32, 0x09),
-GEN_CRLOGIC(crnand, tcg_gen_nand_i32, 0x07),
-GEN_CRLOGIC(crnor, tcg_gen_nor_i32, 0x01),
-GEN_CRLOGIC(cror, tcg_gen_or_i32, 0x0E),
-GEN_CRLOGIC(crorc, tcg_gen_orc_i32, 0x0D),
-GEN_CRLOGIC(crxor, tcg_gen_xor_i32, 0x06),
-
 #undef GEN_MAC_HANDLER
 #define GEN_MAC_HANDLER(name, opc2, opc3)                                     \
 GEN_HANDLER(name, 0x04, opc2, opc3, 0x00000000, PPC_405_MAC)
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index d768a0454d..26b308e435 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -540,6 +540,51 @@ static bool trans_MFCR(DisasContext *ctx, arg_MFCR *a)
     return true;
 }
 
+static bool cr_logic_common(DisasContext *ctx, arg_X *a,
+                            void (*tcg_op)(TCGv_i32, TCGv_i32, TCGv_i32))
+{
+
+    uint8_t bitmask;
+    int sh;
+    TCGv_i32 t0, t1;
+    sh = (a->rt & 0x03) - (a->ra & 0x03);
+    t0 = tcg_temp_new_i32();
+    if (sh > 0) {
+        tcg_gen_shri_i32(t0, cpu_crf[a->ra >> 2], sh);
+    } else if (sh < 0) {
+        tcg_gen_shli_i32(t0, cpu_crf[a->ra >> 2], -sh);
+    } else {
+        tcg_gen_mov_i32(t0, cpu_crf[a->ra >> 2]);
+    }
+
+    t1 = tcg_temp_new_i32();
+    sh = (a->rt & 0x03) - (a->rb & 0x03);
+    if (sh > 0) {
+        tcg_gen_shri_i32(t1, cpu_crf[a->rb >> 2], sh);
+    } else if (sh < 0) {
+        tcg_gen_shli_i32(t1, cpu_crf[a->rb >> 2], -sh);
+    } else {
+        tcg_gen_mov_i32(t1, cpu_crf[a->rb >> 2]);
+    }
+    tcg_op(t0, t0, t1);
+
+    bitmask = 0x08 >> (a->rt & 0x03);
+    tcg_gen_andi_i32(t0, t0, bitmask);
+    tcg_gen_andi_i32(t1, cpu_crf[a->rt >> 2], ~bitmask);
+    tcg_gen_or_i32(cpu_crf[a->rt >> 2], t0, t1);
+
+    return true;
+}
+
+TRANS(CRAND, cr_logic_common, tcg_gen_and_i32);
+TRANS(CROR, cr_logic_common, tcg_gen_or_i32);
+TRANS(CRXOR, cr_logic_common, tcg_gen_xor_i32);
+TRANS(CRNAND, cr_logic_common, tcg_gen_nand_i32);
+TRANS(CRNOR, cr_logic_common, tcg_gen_nor_i32);
+TRANS(CRANDC, cr_logic_common, tcg_gen_andc_i32);
+TRANS(CREQV, cr_logic_common, tcg_gen_eqv_i32);
+TRANS(CRORC, cr_logic_common, tcg_gen_orc_i32);
+
 static bool do_add_D(DisasContext *ctx, arg_D *a, bool add_ca, bool compute_ca,
                      bool compute_ov, bool compute_rc0)
 {
-- 
2.55.0


