Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6448C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3Ow-0005b8-9V; Thu, 20 Aug 2026 10:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3Ot-0005WG-PM; Thu, 20 Aug 2026 10:05:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3Or-0006bR-Gr; Thu, 20 Aug 2026 10:05:47 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8RCMC362190; Thu, 20 Aug 2026 14:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=yu0WkM0ZdE4NVAlut
 HAdaQTPX6DLvMnPXoaVaRUWUAY=; b=NZ/dzfHIWCMtH5AwyxhFtvwJLkhiOR0PP
 bj3kV4wrUm9pdIUf1BZ/VtvBDZrLuYMfECJjc8ZvnFNsmZnEPhIk0M2v7YlXRlmw
 zvZh8ZMPiaCpJRfFoyBRp38J8algmZDttgxRtowWs47i0hy/JXF1GStc2+fRg0Lq
 h5mrUSZgKHPJszKI/xSYpvRhLjDA4N2QDxssFhMB/Wak0UXK3zAKm7eKqS62BMFW
 1KDSBEy2mR7KNhCFmWlr/mI5EeR+lHBGgKnKd9Y9kgTkYeTq0IQEdU2YW93zaE8K
 DCRyea92pL2aa4F3cWlQtcdjjcE07L5I0hAQOEbNT8uiosMJCRSCw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4aneq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:05:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuIWL028361;
 Thu, 20 Aug 2026 14:05:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekexn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:05:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KE5bbd44696006
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:05:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B9E620043;
 Thu, 20 Aug 2026 14:05:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A60FE20040;
 Thu, 20 Aug 2026 14:05:29 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:05:29 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 18/29] target/ppc: Move sleep & friends to decodetree
Date: Thu, 20 Aug 2026 19:30:47 +0530
Message-ID: <20260820140114.327023-19-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820140114.327023-1-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX+lsn5jJeOH9X
 Z/Ga0or1z6WKgkPbPklnRWe806YUS55qsOlQ96qtHLGKC3LV8+fdJCSKUT3398wrE90dvYAPXQf
 yneeEhJ2uMn4N5mh9VRWdk4Vl4sGFnc=
X-Proofpoint-GUID: h-9e8s1fUunFin57p5zjnxdimNbPCP6J
X-Proofpoint-ORIG-GUID: 7Z5-OQcz54NzMAobTocsR6hlXr34RQRn
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a8709b7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=NiR63QhzpTtrMawuEWMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX0B5Py6y0tWOn
 cUh5jte1ZLLjuTFMGkq23xh+cgN5AtywzXx+M79YWS29VTnSRhWUVAu2ingjrMgZSuVkwm82ghj
 MQd4QrNSt9D55noe3e+ebFqaEBbSonIGJucawLG4BuAd7KJL9fI18WwWeawhLbsTy1puKcmDQG8
 DrTlWHA4mdEcXl48Um8tJ0912drs27LzGgMPJTfohAHE+UJGSwCtVzmSAjaTsmJKX0RR0xQe4+A
 tyOW5AI/IVA/5kCdiurrmmrb/SA6xK1zg0Ly16Hlwz0rk2oIwH4XSIWf/V44DhU+E2PUgggIEMh
 KRywm+qjxMXj6ItEAqQ8s28zMVJ4Fln4r8sKc8Z2d5Umq7QjJwPHWnBQ+ePHRF9mu9dGo96qHJC
 ZobiPNwjyNfSkas+o6ZNaX9tDNnFiGwnllCu2iV3zQ72HbgqmqRsZ1g51UYE2aSgqF69eYxNRxg
 sE5jn1YCYKeJhgt8fqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105
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


