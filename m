Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA02C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5vK-0001vS-Et; Wed, 26 Aug 2026 01:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5vJ-0001r8-Mq; Wed, 26 Aug 2026 01:11:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5vH-0005QN-MO; Wed, 26 Aug 2026 01:11:41 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3VlUl1702430; Wed, 26 Aug 2026 05:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=N3DeApYRzCDE9p0jr
 eHl0OAt147rs8SaG9NMVyvuqW4=; b=boYSNLGVHg8CZBLYkrM6VcvsX82vC0ZDA
 7XevO0YYc5c04GnpT5Tf+l/owlfKEVe5SbbMRhIIb2twNh84RaRQvDxzJQnfdste
 7XBItoNdm/tr82doMPzevOwAGRVWolp8Cg48iYRqIV/x2IhGnbrxj73cHSn4t5cc
 S7Ci+MBHcew4+X94jU0lMvJw+b2YZ46qZCM4UZI5lnpxlpSOVze5SNsF5ZiEkf7K
 Z31f0Blltju0EqOUSTTUVuvSqL5jphyagg/pKVZl+1rQXiHtymwHt4Lc1scJHjni
 LX27+vq95vjVDaqFWIHH58b2iiMTsH70fhb7pHvYQBGlpe35znFXg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726emk21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:11:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q5BLX3009882;
 Wed, 26 Aug 2026 05:11:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy7xss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:11:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5BXbJ38404384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:11:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A46F2004B;
 Wed, 26 Aug 2026 05:11:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D296A20040;
 Wed, 26 Aug 2026 05:11:27 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:11:27 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 18/37] target/ppc: Move sleep & friends to decodetree
Date: Wed, 26 Aug 2026 10:38:44 +0530
Message-ID: <20260826050923.74756-19-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8e758a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=NiR63QhzpTtrMawuEWMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX/TEpOMtetA/c
 gk5MXWoOjSVF6y5nHXJGJr2QL4h9JpHjG9wAD1oq1oETuTrZWdrwkLw7uRQD/eNljJHiNzu2WeV
 XODmNc8kMMGFEcvpfdr5+3AiLNgemvM=
X-Proofpoint-GUID: i3t-TsxfNE3WT07gdWnA4w-pxJBGRIGx
X-Proofpoint-ORIG-GUID: pjHQSD6H1LraPI9dYJeM7aCnAYqlc-bu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX1aRR0mejLNq6
 5BqyTDGUuq/EQNbArddC0I75HdEQNX4KDIQ+PJgd/FH6L4kMoLEKlI5+qqN1DExcRxRBFDT8+Bs
 FvWcvYel2ZyWiyxcTEUxgQAyKGzOfrhyCtXAStSbMhoTLcbiVF2eg45Jw57L6xRXfnyHojM1GDL
 vmIC++AQIqNPCXyXzpiM0cOTi3MiPRBS/SDcDAU4KzY/Ydh+LCL1tVxLeJ3x0TWDjkbxQgEmMuc
 YsInELBtFJ5tYHDYjva+Fwp0cJvzyDKHP/9/wUr9M6jUCwkOFgHkBh3htY9/xGsVRfPgUKu602k
 yhW2atC32bsHEm9QP7KcxIeFgQjhxsyflW8DHb+S+KnnUTI+oJUl0TLGOPPWZe5is3xr2CDuDhl
 zcA8NpTDgBOyspHPAyzHj8tekgOisX5IiqMPI0N5V98qjt4JJzSgXAYqh4BiKWTFBUXVk/W/bl6
 xHVVBzrO2WDXLjnkuIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260040
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
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode                      |   8 ++
 target/ppc/translate.c                        |  85 ---------------
 .../ppc/translate/processor-ctrl-impl.c.inc   | 101 ++++++++++++++++++
 3 files changed, 109 insertions(+), 85 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 3b8387b60c..d23168a303 100644
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
index 2d5157080c..f6f7bb4e6b 100644
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
@@ -5117,11 +5037,6 @@ GEN_HANDLER_E(scv, 0x11, 0x10, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
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
2.55.0


