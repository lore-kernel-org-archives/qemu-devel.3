Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89441C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzplU-0006hj-FY; Fri, 28 Aug 2026 02:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplS-0006Zm-LL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplQ-0000wi-Ez
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:34 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S22wFg3688599
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=sw9q9ogDOP5PDgir7
 8SPadWAWqHkUoEC+BupL5vdE1E=; b=ctJoCVWaSP80UqGTQ8xR2KYd2lv59CX2d
 MTYR0wNhZiBlSTsewlm/53YQ1aiQ7QOs0QULKN6+SEfxO4VE6TqLomFGuhJ/0h5H
 BMV5B2jXr+egop8Of+fUAhkBlJFUaAAqroCVV29X6T2RB+oh/9p0Pu7160ihlU5E
 XmnornrGbYdU+9mKodVKXYlP3E2qblU3LBEToo9++iqDwbdG1gxHzKSSHzzDzw5W
 7jVpWpO1Of+zFjH6ziDj8t+zrXbhY6NpPi6I2x35dDN6plAzqW/Ea8qtBKaTRoMA
 rIpDRVx3aQjWoDATsi9yUbUiLntUuQoRuj1MzR5G5T+c6JsRfVRsA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726f2841-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uFr2007424
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsymc0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S68Qib41812236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:08:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CBFE20043;
 Fri, 28 Aug 2026 06:08:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7937020040;
 Fri, 28 Aug 2026 06:08:24 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:08:24 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 23/41] target/ppc: Refactor sleep and its variants to use a
 common helper
Date: Fri, 28 Aug 2026 11:36:58 +0530
Message-ID: <20260828060716.91672-24-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a9125df cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=AYO248uK6yRxx-YkPnAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX3kcJa2mv3cjn
 qWogqGs+swiQxzbFLC7jzEhzXnk5x2/psJlDaCNpxzcNe/U9mn/t9W09u2Wn9TUTNoah+T5jjeY
 tJh1ASHGJeNwYEul8CJZKmtWAhwBCoc=
X-Proofpoint-GUID: iHJq6D06fsnQLoaTv1gAjLl1oDMyuiOV
X-Proofpoint-ORIG-GUID: iHJq6D06fsnQLoaTv1gAjLl1oDMyuiOV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX/ic8dbpYrI9t
 FDz34YEAZM0iWannl2Fgzre/iI0z5HIQgs936PstaD0z+NbcSdUV9rsNx5dJ17Fhsxoz8JP4Zun
 AHgsA4eBJ5VX94O/R0afcS4iATHfpeAtuSBYSnNXNL9YWUSl+DgBuSwbcZ8F/JgwrrjqNpge1QJ
 Ay2HgQJaJYLtwkBUl+RkFZXZAcbZXX0CIbHP5H+nIYLGKj/HF6sMjfI7MOayvNYOpb20sJG4WKa
 m9+E4/laHblSiDmn7AZ7cAynt4mZohA6Rrn4jVyAHU1CWUAu7Sm68AA32xL+qEP0nRewe7JOmJH
 YDgXSOtIH2aSWOwcsTOrc8CNxP1yDPHdIVKAi2h+aO798vWisNFtAqVoy0sE2zwMuslgSqf86CK
 dOEsfcLZNgkAUbwnEViFH14eD+nKTAEWsTcRFOmgmmGuYuQBr1cbjxU9nPS1ezDb2PC5xXmO39r
 4Dvhpm9wHLmp1LXV/Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
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

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

With sleep, doze, nap, rvwinkle and stop instructions moved to
decodetree, the helper these instructions used : gen_helper_pminsn,
should now be renamed to gen_helper_PMINSN, abiding by the decodetree
standards. Do the same.
Also refactor their translation routine to use a common do_sleep routine
since they share majority of the code.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-20-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/helper.h                           |  2 +-
 target/ppc/tcg-excp_helper.c                  |  2 +-
 .../ppc/translate/processor-ctrl-impl.c.inc   | 99 +++----------------
 3 files changed, 17 insertions(+), 86 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index e7bf43bf4b..6e14f02598 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -18,7 +18,7 @@ DEF_HELPER_1(rfdi, void, env)
 DEF_HELPER_1(rfmci, void, env)
 #if defined(TARGET_PPC64)
 DEF_HELPER_2(scv, noreturn, env, i32)
-DEF_HELPER_2(pminsn, void, env, i32)
+DEF_HELPER_2(PMINSN, void, env, i32)
 DEF_HELPER_1(rfid, void, env)
 DEF_HELPER_1(rfscv, void, env)
 DEF_HELPER_1(hrfid, void, env)
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index b04f07a637..c4ffa2dfbb 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -459,7 +459,7 @@ void helper_scv(CPUPPCState *env, uint32_t lev)
     }
 }
 
-void helper_pminsn(CPUPPCState *env, uint32_t insn)
+void helper_PMINSN(CPUPPCState *env, uint32_t insn)
 {
     CPUState *cs = env_cpu(env);
 
diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc b/target/ppc/translate/processor-ctrl-impl.c.inc
index a96c9c87ce..cfcca28267 100644
--- a/target/ppc/translate/processor-ctrl-impl.c.inc
+++ b/target/ppc/translate/processor-ctrl-impl.c.inc
@@ -104,102 +104,33 @@ static bool trans_MSGSYNC(DisasContext *ctx, arg_MSGSYNC *a)
     return true;
 }
 
-static bool do_doze(DisasContext *ctx, arg_DOZE *a)
-{
-    REQUIRE_64BIT(ctx);
-
-#if defined(CONFIG_USER_ONLY)
-    gen_priv_opc(ctx);
-#else
-    TCGv_i32 t;
-
-    REQUIRE_HV(ctx);
-    translator_io_start(&ctx->base);
-    t = tcg_constant_i32(PPC_PM_DOZE);
-    gen_helper_pminsn(tcg_env, t);
-    /* Stop translation, as the CPU is supposed to sleep from now */
-    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-#endif /* defined(CONFIG_USER_ONLY) */
-    return true;
-}
-TRANS_FLAGS2(PM_ISA206, DOZE, do_doze);
-
-static bool do_nap(DisasContext *ctx, arg_NAP *a)
+/*
+ * Helper to handle DOZE, NAP, SLEEP, RVWINKLE & STOP. Since none of them use
+ * any arguments just use a placeholder arg_SLEEP.
+ */
+static bool do_sleep(DisasContext *ctx, arg_SLEEP *a, powerpc_pm_insn_t type)
 {
     REQUIRE_64BIT(ctx);
 
 #if defined(CONFIG_USER_ONLY)
     gen_priv_opc(ctx);
-#else
+#elif defined(TARGET_PPC64)
     TCGv_i32 t;
 
     REQUIRE_HV(ctx);
     translator_io_start(&ctx->base);
-    t = tcg_constant_i32(PPC_PM_NAP);
-    gen_helper_pminsn(tcg_env, t);
+    t = tcg_constant_i32(type);
+    gen_helper_PMINSN(tcg_env, t);
     /* Stop translation, as the CPU is supposed to sleep from now */
     gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-#endif /* defined(CONFIG_USER_ONLY) */
-    return true;
-}
-TRANS_FLAGS2(PM_ISA206, NAP, do_nap);
-
-static bool do_sleep(DisasContext *ctx, arg_SLEEP *a)
-{
-    REQUIRE_64BIT(ctx);
-
-#if defined(CONFIG_USER_ONLY)
-    gen_priv_opc(ctx);
 #else
-    TCGv_i32 t;
-
-    REQUIRE_HV(ctx);
-    translator_io_start(&ctx->base);
-    t = tcg_constant_i32(PPC_PM_SLEEP);
-    gen_helper_pminsn(tcg_env, t);
-    /* Stop translation, as the CPU is supposed to sleep from now */
-    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-#endif /* defined(CONFIG_USER_ONLY) */
-    return true;
-}
-TRANS_FLAGS2(PM_ISA206, SLEEP, do_sleep);
-
-static bool do_rvwinkle(DisasContext *ctx, arg_RVWINKLE *a)
-{
-    REQUIRE_64BIT(ctx);
-
-#if defined(CONFIG_USER_ONLY)
-    gen_priv_opc(ctx);
-#else
-    TCGv_i32 t;
-
-    REQUIRE_HV(ctx);
-    translator_io_start(&ctx->base);
-    t = tcg_constant_i32(PPC_PM_RVWINKLE);
-    gen_helper_pminsn(tcg_env, t);
-    /* Stop translation, as the CPU is supposed to sleep from now */
-    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-#endif /* defined(CONFIG_USER_ONLY) */
+    qemu_build_not_reached();
+#endif
     return true;
 }
-TRANS_FLAGS2(PM_ISA206, RVWINKLE, do_rvwinkle);
-
-static bool do_stop(DisasContext *ctx, arg_STOP *a)
-{
-    REQUIRE_64BIT(ctx);
 
-#if defined(CONFIG_USER_ONLY)
-    gen_priv_opc(ctx);
-#else
-    TCGv_i32 t;
-
-    REQUIRE_HV(ctx);
-    translator_io_start(&ctx->base);
-    t = tcg_constant_i32(PPC_PM_STOP);
-    gen_helper_pminsn(tcg_env, t);
-    /* Stop translation, as the CPU is supposed to sleep from now */
-    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-#endif /* defined(CONFIG_USER_ONLY) */
-    return true;
-}
-TRANS_FLAGS2(ISA300, STOP, do_stop);
+TRANS_FLAGS2(PM_ISA206, DOZE, do_sleep, PPC_PM_DOZE);
+TRANS_FLAGS2(PM_ISA206, NAP, do_sleep, PPC_PM_NAP);
+TRANS_FLAGS2(PM_ISA206, SLEEP, do_sleep, PPC_PM_SLEEP);
+TRANS_FLAGS2(PM_ISA206, RVWINKLE, do_sleep, PPC_PM_RVWINKLE);
+TRANS_FLAGS2(ISA300, STOP, do_sleep, PPC_PM_STOP);
-- 
2.52.0


