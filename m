Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127F4C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaDi-0004jf-DJ; Thu, 27 Aug 2026 09:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaDf-0004Rp-1X; Thu, 27 Aug 2026 09:32:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaDc-0001pC-AB; Thu, 27 Aug 2026 09:32:38 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVWkG3001457; Thu, 27 Aug 2026 13:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=e+Ox+Xc7MIbqsWXb/
 ebHzVdCOfbGRcq1lCTNVLBqUag=; b=Og66FRj4zQV1G2Q7JWo3E3tEDotrRhIcI
 0UqUHLyEE1jcL6POMzAgrty+LSG25HMlRbdS+Rklv4sYD0Br9WpIcoPJhziB/YlE
 tar/v4sxF2/d5m73GfbO+kVvEA9FSF4v9LUwQQRWfR2PDQZktYIyGdlJ1kgecU4A
 RQm3tsAl7aloDtRZ8OKVaKCe764gn8UndEjWV4DZWoIgWQ6rpSLctgFefNItoosV
 +CgE+5vlmbk8V3PA3OBYo2AsDsxDVhxGvf7GK9PtnfqxrBBZtORPCkb0CSPkI0CT
 XgCRE0IWfTSQtWeojM6mmkGK1mTi7qGIi6ZqVoBd0Qldm6ronQq8A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g55pge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:32:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQLJG013308;
 Thu, 27 Aug 2026 13:32:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qgh6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:32:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RDWSx88585566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 13:32:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C25AA20040;
 Thu, 27 Aug 2026 13:32:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC1D220043;
 Thu, 27 Aug 2026 13:32:21 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.111.12.1]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 13:32:21 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3 18/37] target/ppc: Move sleep & friends to decodetree
Date: Thu, 27 Aug 2026 18:59:33 +0530
Message-ID: <20260827133010.278889-19-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827133010.278889-1-rathc@linux.ibm.com>
References: <20260827133010.278889-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: SBdGsmgPd0pNHzaR5WEiaWVi16WOXahw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX8wSh64o0YPMU
 HsBSzlNond6XOAtdU03MewYlDWMz1GlXcLG910HT2888FQGqKqXSmOb8DEbC4bcPhcZtmbCKHh6
 6uQ16UaHiWw2zPqRZq65ChuuWgYr2dw=
X-Proofpoint-GUID: O905L2hfxvbVJrQHw2r5DEXkfmv4hsod
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a903c71 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=NiR63QhzpTtrMawuEWMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfXyvV6GHrt2RRY
 Fe/x7SnISwPKDcC08tBL3IT5+j01KrMajYGd3LNcvA7WzvsZ0hOnPAKqtRiIuS8XrNGA0oHLfAR
 KurgvMXkjWPPmB7Ht2na3ym/8bHAe0bwmSdq1pB/wH3Lpw47nrSlkTt/1NPxP+TYIeLdpDorZGx
 UJKTw2RwmADZZX4BUCbMrdJ/SplzHIceFEm5Vkdk1XP/UpuCi38Flazb6h+hLuUx2N21zJozaaE
 /WUi61B9mDpDABY+lL3tGLARWV3p8rqb1dBp940R9QtXF1PoNL+dKYL8S8C2wy6LWm1a3SDbAn/
 gj7cdFjmCckN/koseSFv7eYOPpLvUqyMRt8byaL9Qm6fQeByncluzXZJrBd7cC/IZWtZonogMf6
 OVkzJCHbUGFNqB1mrvG7RIMbWFn5jofBIdIWMs0D8dolvsSk76J9RMiBisUKole7x0+qenglXiU
 8RUty+X27c9SiZ1eXDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270113
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
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode                      |   8 ++
 target/ppc/translate.c                        |  85 ---------------
 .../ppc/translate/processor-ctrl-impl.c.inc   | 100 ++++++++++++++++++
 3 files changed, 108 insertions(+), 85 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index da32ac1d28..b833244932 100644
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
index e5ed4d2cc4..9d9823f92d 100644
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
@@ -5104,11 +5024,6 @@ GEN_HANDLER_E(scv, 0x11, 0x10, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
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
index 8abbb89630..a96c9c87ce 100644
--- a/target/ppc/translate/processor-ctrl-impl.c.inc
+++ b/target/ppc/translate/processor-ctrl-impl.c.inc
@@ -103,3 +103,103 @@ static bool trans_MSGSYNC(DisasContext *ctx, arg_MSGSYNC *a)
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
+#endif /* defined(CONFIG_USER_ONLY) */
+    return true;
+}
+TRANS_FLAGS2(ISA300, STOP, do_stop);
-- 
2.55.0


