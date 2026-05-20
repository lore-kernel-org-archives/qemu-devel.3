Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AABCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjUb-0003Xz-Rz; Wed, 20 May 2026 12:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjUQ-00033n-Vh; Wed, 20 May 2026 12:09:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjUO-00032c-32; Wed, 20 May 2026 12:09:45 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K859ba2166376; Wed, 20 May 2026 16:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0SoqquIShR3sba9sF
 lHq/RbxkoTHcg6cBRBbde3DslI=; b=SPXhWfiHuA/5VgcaQfSfnop186m+orkS/
 AhkWp9NlobPpSYxcSvgg7GrVP8BQ5W2n/EHZKrPjQVRVcZqzi4w9pIGcr4EiHmYq
 +TgKwqXZEqcsIpttfhtjokuisiB7IGnE1Ux8SKud2KkNz6hDmFwOvWsPIOkuZnXi
 1Q+RsuUJ20bbAf7reKq9aatOQL/51+Y0NIQLLmI1KEZZ81hZARZdrgwqcTwtew0m
 S02ddAhNVAW2KWOll7AMS2bIg8yND6UZgGqpBseq1Ig2iGXAGYA9X1U+lYgCyq/O
 uSQSO+10QTx91rKXhmlQ/HKVIbFNGORblqROoj267YH2wVzKXbXeg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h752x1b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:09:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KG94Dw024324;
 Wed, 20 May 2026 16:09:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq8aka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:09:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KG9bgg23921292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 16:09:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E874720040;
 Wed, 20 May 2026 16:09:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA5E420043;
 Wed, 20 May 2026 16:09:31 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.31.153]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 16:09:31 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 18/28] target/ppc: Move sleep & friends to decodetree
Date: Wed, 20 May 2026 21:37:18 +0530
Message-ID: <20260520160728.2283628-19-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0ddcc5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=NiR63QhzpTtrMawuEWMA:9
X-Proofpoint-ORIG-GUID: cXk9zud7NcKxC38hmINypEYU-GUG5BaZ
X-Proofpoint-GUID: wcBHPjft0vbmQWgFt1vz5dODIQeD82vz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfX4QRn0c7xRi/U
 63lS436Jnm+sijF51000I0SEtQC+oJhdh2NM7hC3Z+bo/IBvoxawPSIjlZIqkpXKGNCG1Rv8mYm
 ZMp0b0O8JsN8WXdsvWs9yR30WLNGTavkmXkoyCyam0Ab0B63Nzt9u5G/LZOiqi7ewavy/T31J01
 h0xGQxByX3mmQGC53HzlkDGwAzD8dhsRcL7zD8fl/e1yKPOQGONzVMHeuc+WaVqdk5lFt9Tuuzk
 S2xe4ej0rW3DEwB5xuwvhwvnCU9s7Kct3MpiQWnpRYLn43LvDHxZjVndr4Gsj/WJ9DaYAAAhz9D
 kEYSZaYu+LiHjbqrVnz2FkKoRnufGXzaQ3AcYcOMcd5RoO41NeohRsVE/aaIznTex9BZi7IzMey
 c0JZOZEYcnKFs8Ur13SIZ5INMTpPEgy2cdlqdRpS48w0MBN68tj3ohIvSUfcuX+K6LNX8K+3sh1
 DOBAduJU5XQ0kmcgHqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200156
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Convert the following instructions to decode tree specification:

doze
nap
sleep
rvwinkle
stop

The functionality was tested by comparing the qemu -D log -d op,in_asm
output as well as single stepping gdb to confirm behavior was not
changed for ISA3.x (stop) as well as ISA206 (doze, nap, sleep,
rvwinkle).

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode                      |   8 ++
 target/ppc/translate.c                        |  85 ---------------
 .../ppc/translate/processor-ctrl-impl.c.inc   | 101 ++++++++++++++++++
 3 files changed, 109 insertions(+), 85 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 2c002f8513..a4454a2292 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -913,6 +913,14 @@ VPERMR          000100 ..... ..... ..... ..... 111011   @VA
 
 VSEL            000100 ..... ..... ..... ..... 101010   @VA
 
+## Power Management Instructions
+
+DOZE            010011 ----- ----- ----- 0110010010 -
+NAP             010011 ----- ----- ----- 0110110010 -
+SLEEP           010011 ----- ----- ----- 0111010010 -
+RVWINKLE        010011 ----- ----- ----- 0111110010 -
+STOP            010011 ----- ----- ----- 0101110010 -
+
 ## Vector Integer Shift Instruction
 
 VSLB            000100 ..... ..... ..... 00100000100    @VX
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4a7fa6a6a9..d1e9ab61e9 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2728,86 +2728,6 @@ static inline void gen_check_tlb_flush(DisasContext *ctx, bool global) { }
 #endif
 
 #if defined(TARGET_PPC64)
-static void gen_doze(DisasContext *ctx)
-{
-#if defined(CONFIG_USER_ONLY)
-    GEN_PRIV(ctx);
-#else
-    TCGv_i32 t;
-
-    CHK_HV(ctx);
-    translator_io_start(&ctx->base);
-    t = tcg_constant_i32(PPC_PM_DOZE);
-    gen_helper_pminsn(tcg_env, t);
-    /* Stop translation, as the CPU is supposed to sleep from now */
-    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-#endif /* defined(CONFIG_USER_ONLY) */
-}
-
-static void gen_nap(DisasContext *ctx)
-{
-#if defined(CONFIG_USER_ONLY)
-    GEN_PRIV(ctx);
-#else
-    TCGv_i32 t;
-
-    CHK_HV(ctx);
-    translator_io_start(&ctx->base);
-    t = tcg_constant_i32(PPC_PM_NAP);
-    gen_helper_pminsn(tcg_env, t);
-    /* Stop translation, as the CPU is supposed to sleep from now */
-    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-#endif /* defined(CONFIG_USER_ONLY) */
-}
-
-static void gen_stop(DisasContext *ctx)
-{
-#if defined(CONFIG_USER_ONLY)
-    GEN_PRIV(ctx);
-#else
-    TCGv_i32 t;
-
-    CHK_HV(ctx);
-    translator_io_start(&ctx->base);
-    t = tcg_constant_i32(PPC_PM_STOP);
-    gen_helper_pminsn(tcg_env, t);
-    /* Stop translation, as the CPU is supposed to sleep from now */
-    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-#endif /* defined(CONFIG_USER_ONLY) */
-}
-
-static void gen_sleep(DisasContext *ctx)
-{
-#if defined(CONFIG_USER_ONLY)
-    GEN_PRIV(ctx);
-#else
-    TCGv_i32 t;
-
-    CHK_HV(ctx);
-    translator_io_start(&ctx->base);
-    t = tcg_constant_i32(PPC_PM_SLEEP);
-    gen_helper_pminsn(tcg_env, t);
-    /* Stop translation, as the CPU is supposed to sleep from now */
-    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-#endif /* defined(CONFIG_USER_ONLY) */
-}
-
-static void gen_rvwinkle(DisasContext *ctx)
-{
-#if defined(CONFIG_USER_ONLY)
-    GEN_PRIV(ctx);
-#else
-    TCGv_i32 t;
-
-    CHK_HV(ctx);
-    translator_io_start(&ctx->base);
-    t = tcg_constant_i32(PPC_PM_RVWINKLE);
-    gen_helper_pminsn(tcg_env, t);
-    /* Stop translation, as the CPU is supposed to sleep from now */
-    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-#endif /* defined(CONFIG_USER_ONLY) */
-}
-
 static inline TCGv gen_write_bhrb(TCGv_ptr base, TCGv offset, TCGv mask, TCGv value)
 {
     TCGv_ptr tmp = tcg_temp_new_ptr();
@@ -5141,11 +5061,6 @@ GEN_HANDLER_E(scv, 0x11, 0x10, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(scv, 0x11, 0x00, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(rfscv, 0x13, 0x12, 0x02, 0x03FF8001, PPC_NONE, PPC2_ISA300),
 #endif
-GEN_HANDLER_E(stop, 0x13, 0x12, 0x0b, 0x03FFF801, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(doze, 0x13, 0x12, 0x0c, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
-GEN_HANDLER_E(nap, 0x13, 0x12, 0x0d, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
-GEN_HANDLER_E(sleep, 0x13, 0x12, 0x0e, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
-GEN_HANDLER_E(rvwinkle, 0x13, 0x12, 0x0f, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
 GEN_HANDLER(hrfid, 0x13, 0x12, 0x08, 0x03FF8001, PPC_64H),
 #endif
 /* Top bit of opc2 corresponds with low bit of LEV, so use two handlers */
diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc b/target/ppc/translate/processor-ctrl-impl.c.inc
index 8abbb89630..bdbc195294 100644
--- a/target/ppc/translate/processor-ctrl-impl.c.inc
+++ b/target/ppc/translate/processor-ctrl-impl.c.inc
@@ -103,3 +103,104 @@ static bool trans_MSGSYNC(DisasContext *ctx, arg_MSGSYNC *a)
     /* interpreted as no-op */
     return true;
 }
+
+static bool do_doze(DisasContext *ctx, arg_DOZE *a)
+{
+    REQUIRE_64BIT(ctx);
+
+#if defined(CONFIG_USER_ONLY)
+    gen_priv_opc(ctx);
+#else
+    TCGv_i32 t;
+
+    REQUIRE_HV(ctx);
+    translator_io_start(&ctx->base);
+    t = tcg_constant_i32(PPC_PM_DOZE);
+    gen_helper_pminsn(tcg_env, t);
+    /* Stop translation, as the CPU is supposed to sleep from now */
+    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
+#endif /* defined(CONFIG_USER_ONLY) */
+
+    return true;
+}
+TRANS_FLAGS2(PM_ISA206, DOZE, do_doze);
+
+static bool do_nap(DisasContext *ctx, arg_NAP *a)
+{
+    REQUIRE_64BIT(ctx);
+
+#if defined(CONFIG_USER_ONLY)
+    gen_priv_opc(ctx);
+#else
+    TCGv_i32 t;
+
+    REQUIRE_HV(ctx);
+    translator_io_start(&ctx->base);
+    t = tcg_constant_i32(PPC_PM_NAP);
+    gen_helper_pminsn(tcg_env, t);
+    /* Stop translation, as the CPU is supposed to sleep from now */
+    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
+#endif /* defined(CONFIG_USER_ONLY) */
+    return true;
+}
+TRANS_FLAGS2(PM_ISA206, NAP, do_nap);
+
+static bool do_sleep(DisasContext *ctx, arg_SLEEP *a)
+{
+    REQUIRE_64BIT(ctx);
+
+#if defined(CONFIG_USER_ONLY)
+    gen_priv_opc(ctx);
+#else
+    TCGv_i32 t;
+
+    REQUIRE_HV(ctx);
+    translator_io_start(&ctx->base);
+    t = tcg_constant_i32(PPC_PM_SLEEP);
+    gen_helper_pminsn(tcg_env, t);
+    /* Stop translation, as the CPU is supposed to sleep from now */
+    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
+#endif /* defined(CONFIG_USER_ONLY) */
+    return true;
+}
+TRANS_FLAGS2(PM_ISA206, SLEEP, do_sleep);
+
+static bool do_rvwinkle(DisasContext *ctx, arg_RVWINKLE *a)
+{
+    REQUIRE_64BIT(ctx);
+
+#if defined(CONFIG_USER_ONLY)
+    gen_priv_opc(ctx);
+#else
+    TCGv_i32 t;
+
+    REQUIRE_HV(ctx);
+    translator_io_start(&ctx->base);
+    t = tcg_constant_i32(PPC_PM_RVWINKLE);
+    gen_helper_pminsn(tcg_env, t);
+    /* Stop translation, as the CPU is supposed to sleep from now */
+    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
+#endif /* defined(CONFIG_USER_ONLY) */
+    return true;
+}
+TRANS_FLAGS2(PM_ISA206, RVWINKLE, do_rvwinkle);
+
+static bool do_stop(DisasContext *ctx, arg_STOP *a)
+{
+    REQUIRE_64BIT(ctx);
+
+#if defined(CONFIG_USER_ONLY)
+    gen_priv_opc(ctx);
+#else
+    TCGv_i32 t;
+
+    REQUIRE_HV(ctx);
+    translator_io_start(&ctx->base);
+    t = tcg_constant_i32(PPC_PM_STOP);
+    gen_helper_pminsn(tcg_env, t);
+    /* Stop translation, as the CPU is supposed to sleep from now */
+    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
+#endif
+    return true;
+}
+TRANS_FLAGS2(ISA300, STOP, do_stop);
-- 
2.53.0


