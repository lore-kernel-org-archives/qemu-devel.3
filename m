Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA48C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 06:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz9i8-0006F1-Q6; Tue, 23 Apr 2024 02:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rz9i7-0006Dh-07; Tue, 23 Apr 2024 02:32:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rz9i5-0003Vn-0R; Tue, 23 Apr 2024 02:32:58 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43N4u7ul017716; Tue, 23 Apr 2024 06:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PAhj3wejXb2bJdls/fr305+VuagSkeCfn1tLr5ilIh0=;
 b=kQmNDqFQEvTgQXwN1vTEHCVCHYt+GEHa27B+nGJhgjMuAAOmJHIn+I5XdNl5Ks+wlgzt
 rOZ2L+qC2QPLg4R3i8aKjJZ98QoY1Mgau0aqyolExjDnjou3+QcCpP4qZv0C+7g2yN7w
 lwM5OfrP5CTY8muFhCmJz4AdAAVxfkugGKBdI0IoBmEhY6SOnAWvKyWBMDhOXNY5FsfJ
 rqXDWzsxW/MEeP4IGQQ8bwKA/8h7QS0gRrpoeH6asQzkuycnQDRo2jRuMhhLPk+OwpgW
 mV2s9LW3LWjcjooW+2+2iKAi5bxJsKoL+qktzORTqDFXDKHqfeJu6fC+MMh7BmXo5U/W YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp6d106nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:32:52 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N6WqRf005513;
 Tue, 23 Apr 2024 06:32:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp6d106nv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:32:52 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43N3jcuD023043; Tue, 23 Apr 2024 06:32:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1nv20t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:32:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43N6Wlc538470108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Apr 2024 06:32:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09F0420043;
 Tue, 23 Apr 2024 06:32:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBC312004B;
 Tue, 23 Apr 2024 06:32:45 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Apr 2024 06:32:45 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v2 1/8] target/ppc: Move mul{li, lw, lwo, hw,
 hwu} instructions to decodetree.
Date: Tue, 23 Apr 2024 12:02:27 +0530
Message-Id: <20240423063234.76282-2-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240423063234.76282-1-rathc@linux.ibm.com>
References: <20240423063234.76282-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TnoCMCJmZ177jCeoRIS7CcbSK3QwtpdT
X-Proofpoint-ORIG-GUID: wiOc-TCmlAOI_iA7_gr4UrelxvTzVHjd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Moving the following instructions to decodetree specification :
	mulli                   	: D-form
	mul{lw, lwo, hw, hwu}[.]	: XO-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.
Also cleaned up code for mullw[o][.] as per review comments while
keeping the logic of the tcg ops generated semantically same.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/insn32.decode                   |  9 +++
 target/ppc/translate.c                     | 89 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 66 ++++++++++++++++
 3 files changed, 75 insertions(+), 89 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index eada59f59f..0184680db8 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -193,6 +193,9 @@
 &XO_ta          rt ra oe:bool rc:bool
 @XO_ta          ...... rt:5 ra:5 ..... oe:1 ......... rc:1      &XO_ta
 
+&XO_tab_rc      rt ra rb rc:bool
+@XO_tab_rc      ...... rt:5 ra:5 rb:5 . ......... rc:1          &XO_tab_rc
+
 %xx_xt          0:1 21:5
 %xx_xb          1:1 11:5
 %xx_xa          2:1 16:5
@@ -353,6 +356,12 @@ SUBFE           011111 ..... ..... ..... . 010001000 .  @XO
 SUBFME          011111 ..... ..... ----- . 011101000 .  @XO_ta
 SUBFZE          011111 ..... ..... ----- . 011001000 .  @XO_ta
 
+MULLI           000111 ..... ..... ................     @D
+MULLW           011111 ..... ..... ..... 0 011101011 .  @XO_tab_rc
+MULLWO          011111 ..... ..... ..... 1 011101011 .  @XO_tab_rc
+MULHW           011111 ..... ..... ..... - 001001011 .  @XO_tab_rc
+MULHWU          011111 ..... ..... ..... - 000001011 .  @XO_tab_rc
+
 ## Fixed-Point Logical Instructions
 
 CFUGED          011111 ..... ..... ..... 0011011100 -   @X
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 93ffec787c..c45547a770 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1948,90 +1948,6 @@ GEN_INT_ARITH_MODD(modud, 0x08, 0);
 GEN_INT_ARITH_MODD(modsd, 0x18, 1);
 #endif
 
-/* mulhw  mulhw. */
-static void gen_mulhw(DisasContext *ctx)
-{
-    TCGv_i32 t0 = tcg_temp_new_i32();
-    TCGv_i32 t1 = tcg_temp_new_i32();
-
-    tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);
-    tcg_gen_muls2_i32(t0, t1, t0, t1);
-    tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], t1);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-/* mulhwu  mulhwu.  */
-static void gen_mulhwu(DisasContext *ctx)
-{
-    TCGv_i32 t0 = tcg_temp_new_i32();
-    TCGv_i32 t1 = tcg_temp_new_i32();
-
-    tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);
-    tcg_gen_mulu2_i32(t0, t1, t0, t1);
-    tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], t1);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-/* mullw  mullw. */
-static void gen_mullw(DisasContext *ctx)
-{
-#if defined(TARGET_PPC64)
-    TCGv_i64 t0, t1;
-    t0 = tcg_temp_new_i64();
-    t1 = tcg_temp_new_i64();
-    tcg_gen_ext32s_tl(t0, cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_ext32s_tl(t1, cpu_gpr[rB(ctx->opcode)]);
-    tcg_gen_mul_i64(cpu_gpr[rD(ctx->opcode)], t0, t1);
-#else
-    tcg_gen_mul_i32(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
-                    cpu_gpr[rB(ctx->opcode)]);
-#endif
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-/* mullwo  mullwo. */
-static void gen_mullwo(DisasContext *ctx)
-{
-    TCGv_i32 t0 = tcg_temp_new_i32();
-    TCGv_i32 t1 = tcg_temp_new_i32();
-
-    tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);
-    tcg_gen_muls2_i32(t0, t1, t0, t1);
-#if defined(TARGET_PPC64)
-    tcg_gen_concat_i32_i64(cpu_gpr[rD(ctx->opcode)], t0, t1);
-#else
-    tcg_gen_mov_i32(cpu_gpr[rD(ctx->opcode)], t0);
-#endif
-
-    tcg_gen_sari_i32(t0, t0, 31);
-    tcg_gen_setcond_i32(TCG_COND_NE, t0, t0, t1);
-    tcg_gen_extu_i32_tl(cpu_ov, t0);
-    if (is_isa300(ctx)) {
-        tcg_gen_mov_tl(cpu_ov32, cpu_ov);
-    }
-    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
-
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-/* mulli */
-static void gen_mulli(DisasContext *ctx)
-{
-    tcg_gen_muli_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
-                    SIMM(ctx->opcode));
-}
-
 #if defined(TARGET_PPC64)
 /* mulhd  mulhd. */
 static void gen_mulhd(DisasContext *ctx)
@@ -6430,11 +6346,6 @@ GEN_HANDLER_E(cmpeqb, 0x1F, 0x00, 0x07, 0x00600000, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(cmpb, 0x1F, 0x1C, 0x0F, 0x00000001, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER_E(cmprb, 0x1F, 0x00, 0x06, 0x00400001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(isel, 0x1F, 0x0F, 0xFF, 0x00000001, PPC_ISEL),
-GEN_HANDLER(mulhw, 0x1F, 0x0B, 0x02, 0x00000400, PPC_INTEGER),
-GEN_HANDLER(mulhwu, 0x1F, 0x0B, 0x00, 0x00000400, PPC_INTEGER),
-GEN_HANDLER(mullw, 0x1F, 0x0B, 0x07, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(mullwo, 0x1F, 0x0B, 0x17, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(mulli, 0x07, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(mulld, 0x1F, 0x09, 0x07, 0x00000000, PPC_64B),
 #endif
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 0c66465d96..1a2ad58929 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -395,6 +395,72 @@ TRANS(SUBFE, do_subf_XO, true, true)
 TRANS(SUBFME, do_subf_const_XO, tcg_constant_tl(-1LL), true, true)
 TRANS(SUBFZE, do_subf_const_XO, tcg_constant_tl(0), true, true)
 
+static bool trans_MULLI(DisasContext *ctx, arg_MULLI *a)
+{
+    tcg_gen_muli_tl(cpu_gpr[a->rt], cpu_gpr[a->ra], a->si);
+    return true;
+}
+
+static bool trans_MULLW(DisasContext *ctx, arg_MULLW *a)
+{
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+
+    tcg_gen_ext32s_tl(t0, cpu_gpr[a->ra]);
+    tcg_gen_ext32s_tl(t1, cpu_gpr[a->rb]);
+    tcg_gen_mul_tl(cpu_gpr[a->rt], t0, t1);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+    }
+    return true;
+}
+
+static bool trans_MULLWO(DisasContext *ctx, arg_MULLWO *a)
+{
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+
+#if defined(TARGET_PPC64)
+    tcg_gen_ext32s_i64(t0, cpu_gpr[a->ra]);
+    tcg_gen_ext32s_i64(t1, cpu_gpr[a->rb]);
+    tcg_gen_mul_i64(cpu_gpr[a->rt], t0, t1);
+    tcg_gen_sextract_i64(t0, cpu_gpr[a->rt], 31, 1);
+    tcg_gen_sari_i64(t1, cpu_gpr[a->rt], 32);
+#else
+    tcg_gen_muls2_i32(cpu_gpr[a->rt], t1, cpu_gpr[a->ra], cpu_gpr[a->rb]);
+    tcg_gen_sari_i32(t0, cpu_gpr[a->rt], 31);
+#endif
+    tcg_gen_setcond_tl(TCG_COND_NE, cpu_ov, t0, t1);
+    if (is_isa300(ctx)) {
+        tcg_gen_mov_tl(cpu_ov32, cpu_ov);
+    }
+    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
+
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+    }
+    return true;
+}
+
+static bool do_mulhw(DisasContext *ctx, arg_XO_tab_rc *a,
+                     void (*helper)(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1,
+                                    TCGv_i32 arg2))
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    tcg_gen_trunc_tl_i32(t0, cpu_gpr[a->ra]);
+    tcg_gen_trunc_tl_i32(t1, cpu_gpr[a->rb]);
+    helper(t0, t1, t0, t1);
+    tcg_gen_extu_i32_tl(cpu_gpr[a->rt], t1);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+    }
+    return true;
+}
+
+TRANS(MULHW, do_mulhw, tcg_gen_muls2_i32)
+TRANS(MULHWU, do_mulhw, tcg_gen_mulu2_i32)
+
 static bool trans_INVALID(DisasContext *ctx, arg_INVALID *a)
 {
     gen_invalid(ctx);
-- 
2.39.3


