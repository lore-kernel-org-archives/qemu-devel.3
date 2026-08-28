Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81941C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpla-0007Mm-8O; Fri, 28 Aug 2026 02:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplX-00075H-SU
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplV-0000xY-M5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:39 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S22qxS679486
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ifgh0arjL5W4HNIJr
 qc60pLNiYWVjZU/gDnaUQka28I=; b=ExdNFtLle/XMclVkYO1Pdi6WsIuC2pn+H
 1XGhM4x3L3Ad6qc55ZmgXzRIRLIxCoCWwCa8yUIOL44FhOPjWBMPDkGdQqv/k9VW
 wc8Bn+uh9Ltvd3AiQLbLKBzP2Tu8d05fZJ62kE9L4vdhONG+9O6wChkfPB34DxSz
 yKKu41k/P5wrR6G+hXN1naDRqdlUFCZSQ43V06+Y4/+M36KrQ8ZvxEZcZ8wDhr/B
 0+SvTzxLW93M5AOQcmBxpSWy4P2bOHna+XN5X7DnOPovBv/MPDGRPs50Ov0NwHaz
 F7/l2YUKOKngd2n1/2XqrSrx2shu6WONImdVQ54RKJQon1vJEHMTQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxt0pg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uNut003691
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhmk1q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S68Vvh43057548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:08:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB90C20043;
 Fri, 28 Aug 2026 06:08:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B24F720040;
 Fri, 28 Aug 2026 06:08:29 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:08:29 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 25/41] target/ppc: Move Condition Register logical instructions
 to decodetree.
Date: Fri, 28 Aug 2026 11:37:00 +0530
Message-ID: <20260828060716.91672-26-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX3uN2YgXF3C4n
 FLgUENy9vU8JkpQAleie0VxaMBPF0DC+VLbo4JIUG4LHF4KPqedJCqzn86HkvAN8XMmqTnFa+Gj
 KsvtfCIbCutpM1/KjKYgNkj2N9YQwb8=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a9125e4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=hG2spAfxjb5FyaO2x7EA:9
X-Proofpoint-ORIG-GUID: mtKxW_ZufugaBfP766rq0Al8j4_i7bk2
X-Proofpoint-GUID: mtKxW_ZufugaBfP766rq0Al8j4_i7bk2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX7Ra1LQ8PegGX
 CbH9yHmBQc6t0jI7FiG9IS20oCOl4wcPpHmfP9rfCJ3dt4B2I2/4BIJy9rWzEDQL9Djn7piX+hW
 9ahtCupINjSltO0sso9v9wFJLjmYy7kLrsAnfZvIl2LDs3sZDzwDAfkbahMPfJNBBfZLNKKF9wp
 Cwo2SmdmrRimvvRGA9qaGUvpEFuJFHmyvE0yX7YWuZfoxynMbWRFFlpICWdYNcXmv2qvujWQwil
 2WGVjBx0KRW8y1LextnoH9MDXTA2E7YX+01OMpFGOym7ux9+SlJxulU72/7ZB/p8HEUVV4VoqRr
 tjBpQ5PSoxbTeb/4JlHa7zHPT8LPFvPboIIp5Oo0IOwY+E1kuHFO219VXIZMlYilGi1A1+6+4V7
 EKLNK0JNiKUrBNfIf8HlGXdMWcDsooT/OvXOSEwDMjMeyX0x+iWBzaTMvLNJ8eaGUr89UWJom8G
 y5dz2kXAhVBSTtK3V/A==
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

Move below instructions to decodetree specification :

        cr{and, or, xor, nand, nor, eqv, andc, orc}  : XL-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-22-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/insn32.decode                   | 11 ++++
 target/ppc/translate.c                     | 59 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 45 +++++++++++++++++
 3 files changed, 56 insertions(+), 59 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 137432ed96..5e5490b169 100644
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
index 59e8ecb262..c5361d8db5 100644
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
@@ -5109,18 +5062,6 @@ GEN_STEPX(stw, DEF_MEMOP(MO_UL), 0x1F, 0x04)
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
index 11d919a21a..d0b3bda97f 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -539,6 +539,51 @@ static bool trans_MFCR(DisasContext *ctx, arg_MFCR *a)
     return true;
 }
 
+static bool cr_logic_common(DisasContext *ctx, arg_X *a,
+                            void (*tcg_op)(TCGv_i32, TCGv_i32, TCGv_i32))
+{
+    uint8_t bitmask;
+    int sh;
+    TCGv_i32 t0, t1;
+    sh = (a->rt & 0x03) - (a->ra & 0x03);
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
+
+    if (sh > 0) {
+        tcg_gen_shri_i32(t0, cpu_crf[a->ra >> 2], sh);
+    } else if (sh < 0) {
+        tcg_gen_shli_i32(t0, cpu_crf[a->ra >> 2], -sh);
+    } else {
+        tcg_gen_mov_i32(t0, cpu_crf[a->ra >> 2]);
+    }
+
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
2.52.0


