Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B9ACD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjUl-0004Mg-DX; Wed, 20 May 2026 12:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjUh-0003xq-46; Wed, 20 May 2026 12:10:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjUe-000370-W5; Wed, 20 May 2026 12:10:02 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K4nRr32386827; Wed, 20 May 2026 16:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NcJx1c2+94suNm1Ft
 +J4YagjB0scwhW0wz30b9mK9AU=; b=dYkytajqxaiyinfDPyCQ703HdSK8C5V7E
 M4Ni9iU2KPzfm8eOaRp1E3oAwWzODDkDcGgvhQiX1hgdyvM45Ak3yfEQmwZVLLmq
 GT4ogNmcWs1WOeeNEBDpqsiIU6Bn8zjVV4ayXLLPmcW4+CGIneoO+yKp8wfQzN/v
 ZVBWd5Ots9UKyAv/61fyj6HpxRANqzAu1Ucc+fdChGpVS/17N9oYol0+aoKNQFZL
 aAKJ+YfcBJGPnpcJdUm1ZRhNQtJiMeJU8deJMMoOikj0ss69d8+RAAzWJgw/U67+
 Rhp7fie2UygBCGOlSsp0tRzUAyvyd4RKXk23Q2hzgy8cPHGdEl4Dw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8hwcs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:09:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KG974B024343;
 Wed, 20 May 2026 16:09:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq8amy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:09:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KG9swW26673548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 16:09:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F81120043;
 Wed, 20 May 2026 16:09:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2211420040;
 Wed, 20 May 2026 16:09:49 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.31.153]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 16:09:48 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 21/28] target/ppc: Move Condition Register logical
 instructions to decodetree.
Date: Wed, 20 May 2026 21:37:21 +0530
Message-ID: <20260520160728.2283628-22-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfX5yrEINEi3fmW
 5lC2SP4IU+N6D0i96khrSSEZZKRQXckHDswA9OpJGfjcqVWlpuWLF/XhcRELUHxI+216UdQLZ9S
 6+aSk8f7+sCLLAMAqLAy4hG+JbWqz2z1iHddmk2vra0oy3KnyS3PZkFZrHZbZRoYrZ8G8oOAZn5
 wLqviuXCe2BiC0QlFhl+vrYbpLKalEq0HqtQkozkjfGHNHVqj0tAgqiN/sGypEwYnUu+uR5Hj3y
 qxhtQYpcPEEYD6apDsab4rjWjwndoTDRZHge14DH/v+tiH40vwSXmjd42Pl59hmHIGihgNdtqdq
 WXWz6HOP+PT41JrblB/wNlmylHUvfFdo+PTcnHJX2JYWDp8fXMwd8joBJ+l0rE/q9NkOrIgv5pn
 rlH5YhafQV6r7GmbpPeFgH5VXD4pYbmYL9KwEFOBOaMG8AA/AuVZL4aY4vKKHd7pP05SZkjVYUQ
 m19RX3boSsOSeCJgO7w==
X-Proofpoint-GUID: kywvsF4mliCWebFig0y41bkUKpuk3bVN
X-Proofpoint-ORIG-GUID: clUy0s4ax8X1RzINVJhrqYNeae436Ilb
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0ddcd7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=hG2spAfxjb5FyaO2x7EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
index 928ae1f48b..f3a1f7970e 100644
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
index d5369549ee..85bdb7deab 100644
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
@@ -5144,18 +5097,6 @@ GEN_STEPX(stw, DEF_MEMOP(MO_UL), 0x1F, 0x04)
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
2.53.0


