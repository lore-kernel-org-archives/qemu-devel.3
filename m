Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06977C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5vb-0003LL-Sx; Wed, 26 Aug 2026 01:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5va-0003Gd-Ts; Wed, 26 Aug 2026 01:11:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5vY-0005Sb-U4; Wed, 26 Aug 2026 01:11:58 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3Vram2880860; Wed, 26 Aug 2026 05:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=i6nCekAfVpByryG0l
 yx718XLJ3FfUZMRZn8wja29Dcs=; b=dl2stoqyG7XWgDqtliC7kAHSJna0GqhtL
 JXTu8lnjLM7MgssEwYC0IDdDnD53WYcL1rkUyqxebXB7KPAz5DKxe1hRRSLuyDpF
 QZ4TTnEDJZJG311e2jIvLuIW3RyF6MEivG6svSbrWhKHA+ozy9YQa4XWlQkcOsjp
 oJTAq1zsihMo05juf+fQkaUNU5cGSAZfBlfMpD+ySb0qJ1d0bWujI4AswRlaH3NK
 rlhbKNKXjsimVQe3v5TWp/Yc4hbAuLzZyHPzGpPKdx0chUF1Dg+QPkPAujWjsR8E
 oaXS+0TdoZMPRECPsz41ekY+8L/kNLJufD4qEOgOoVpNoBkGv9g+A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxcbj4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:11:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q5BKBV009879;
 Wed, 26 Aug 2026 05:11:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy7xu2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:11:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5Bo9B39911910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:11:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6565120043;
 Wed, 26 Aug 2026 05:11:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1662520040;
 Wed, 26 Aug 2026 05:11:45 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:11:44 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 21/37] target/ppc: Move Condition Register logical
 instructions to decodetree.
Date: Wed, 26 Aug 2026 10:38:47 +0530
Message-ID: <20260826050923.74756-22-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX9P25EkFB0W4R
 oF3MvYgZIFBzFTbYzACpDeXHidTxUsOEzp7vj6Jn/9FO9/bVugIakMAxzeoG0w2gV8ne6nNiWAi
 3wSvTCEggZE5uHmkNDSwODbMBWks5IM=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8e759b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=hG2spAfxjb5FyaO2x7EA:9
X-Proofpoint-ORIG-GUID: TNS3u-JVzyHxPrVjCZ1_z5_bLb7lWyzR
X-Proofpoint-GUID: ROays8zP8r1mZ2AXS4vp4s9S3sE60O0-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfXySH7zViPV7vH
 2xP7/xWOES2mQYU/W8Aptawwqp6e9BZmFz7yRqJdlLJi9NqNOW2H0B1osK63uf3iFG66S9CDudn
 MJ9ChVi4Bi7QNh9jDKubDDMbxf38FVpIpcoaEe6/r/aKbAhH46HTdk2gs2mVRA4qcyFhddbV46/
 sAs7cJOQxugTQt0AfpXwvJOSMNALYI8wk2B+R5zOFZ6bcBXlFhirX1eGP62BwnaEdb2FAy/y2pL
 +T4vpU9D6n/8cqhyh5bQsL0YRKlJ/28fmUmu4hZNOoUOxXk5Lzfj6WQ71rr/jDrzT2df1RWW2HH
 4R5vzl/EugK2N/rtHaub9CXQuYa1OhJXCwu68A8t8QiTmvjjs81+hXZf2M940P+nC6wVcqFDt9E
 uOjUE9ApFN8Aim6jOwgoDYfi36vVajPtIuNS4hDPS8W7hvxZrYOfYqCXEmP5BwBj+SSDq7ltRaQ
 tIFJ6Byp11PJIR9d0xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260040
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
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
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


