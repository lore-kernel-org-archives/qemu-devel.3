Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39633CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjUi-0003wx-G2; Wed, 20 May 2026 12:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjUV-0003Cb-C0; Wed, 20 May 2026 12:09:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjUT-00033E-FL; Wed, 20 May 2026 12:09:51 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KCsxq7811826; Wed, 20 May 2026 16:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=uz6MBeiL3q1xToq1f
 ekr7ZJHRYMI0huEgMQo9+wouDE=; b=lAT3vejFZVumhEB6jxOTPt/XTh5XAVtSZ
 OHW29mOLAe7TuGEKyPC8VPEIHrc1EhvlZK9zrcXTuejsyNQouORyNskQvkKh7A2g
 qjzVLAExgBHc3iZkYC4tXhmjVca1d5caxb/ttJ0AACZphfQF0aaiCO2qW2ysAoKM
 vyodAE4PRLqlBEh0gxanT4X4iENB6/lCppDXKkCozFh8CBczUnJmYAItSEvTZZBU
 QsTzZSCZ1f6cVcAxBD4Sw/bIVcjDt1Br9lNLpEoejWuhHwH0p5YBmmgbpJ2xJkWQ
 X9u0gg98dR/qVWEPdJPaPkAu0ppePdxQhsUrb6uhJMLyFPg9IYAkg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88hx6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:09:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KG96xv025884;
 Wed, 20 May 2026 16:09:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky7ttx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:09:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KG9gmo53412152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 16:09:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7159F20043;
 Wed, 20 May 2026 16:09:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63FAE20040;
 Wed, 20 May 2026 16:09:37 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.31.153]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 16:09:37 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 19/28] target/ppc: Refactor sleep and its variants to use
 a common helper
Date: Wed, 20 May 2026 21:37:19 +0530
Message-ID: <20260520160728.2283628-20-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: KVrCWs8oHtRDTX9kL8RLUV3L3PIGeJ30
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfXzVkhRA9n5tL9
 bWT2jWE5T+9cm6wM04mh1VAa8WJoBpDEdlLK6E3sInlFenWD5yevxKjgnOcXiOgpwJhZlrIDiZM
 5jCh7NLS3Fio207oD68rn5PwrTkzl4IFRvp3EuoaXEHY+4IjhjQMfaiAuHXlUKjGHIOmYBed1JC
 fkzmEYFjhwMlnyT5FNHXc8vjYQ5oVBjdy7b+v8TlwTKwAde1nIWVS6YJ4tLS//7sTQxyPe8jh+c
 m9g/4WwPPx7Z0eFsVCFaEq6Smd55nyGdKy/FQ2liBpd8StrIjwWGv9WoYwG28IsOFIx3uk7hGhm
 MytcZBzbVYI2EsMdVimR3OTLuIObC5IGgQCdP0DYAe3F1apEoxrbSY5HWLJmxQoNkR4t6kk+71D
 bt2AKyRnE7T6PYUPp3ddqkbmTtqvB8MfHPeEOVw5tAMqY33ILT+Mqo+xn/vKTdjkZDmKuOi8/JR
 ZccUnOm/bd0jIWln2Kw==
X-Proofpoint-GUID: 3Lpmfzpcc04VE7PYuXTAdNDcDdcLYIO8
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0ddccb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=AYO248uK6yRxx-YkPnAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200156
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

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Refactor sleep, doze, nap, rvwinkle and stop to use a common helper
since they share majority of the code. Also refactor gen_hlper_pminsn()
to gen_helper_PMINSN()

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
[cr: ppc32 build fix]
---
 target/ppc/helper.h                           |  2 +-
 target/ppc/tcg-excp_helper.c                  |  2 +-
 .../ppc/translate/processor-ctrl-impl.c.inc   | 99 +++----------------
 3 files changed, 16 insertions(+), 87 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index f267c0d2b8..dacc4e223e 100644
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
index 5e6c1e326d..c5ccf7cf92 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -458,7 +458,7 @@ void helper_scv(CPUPPCState *env, uint32_t lev)
     }
 }
 
-void helper_pminsn(CPUPPCState *env, uint32_t insn)
+void helper_PMINSN(CPUPPCState *env, uint32_t insn)
 {
     CPUState *cs = env_cpu(env);
 
diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc b/target/ppc/translate/processor-ctrl-impl.c.inc
index bdbc195294..3b3ed3019a 100644
--- a/target/ppc/translate/processor-ctrl-impl.c.inc
+++ b/target/ppc/translate/processor-ctrl-impl.c.inc
@@ -104,103 +104,32 @@ static bool trans_MSGSYNC(DisasContext *ctx, arg_MSGSYNC *a)
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
-
-    return true;
-}
-TRANS_FLAGS2(PM_ISA206, DOZE, do_doze);
-
-static bool do_nap(DisasContext *ctx, arg_NAP *a)
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
-    t = tcg_constant_i32(PPC_PM_NAP);
-    gen_helper_pminsn(tcg_env, t);
-    /* Stop translation, as the CPU is supposed to sleep from now */
-    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
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
-#else
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
-    t = tcg_constant_i32(PPC_PM_RVWINKLE);
-    gen_helper_pminsn(tcg_env, t);
+    t = tcg_constant_i32(type);
+    gen_helper_PMINSN(tcg_env, t);
     /* Stop translation, as the CPU is supposed to sleep from now */
     gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-#endif /* defined(CONFIG_USER_ONLY) */
-    return true;
-}
-TRANS_FLAGS2(PM_ISA206, RVWINKLE, do_rvwinkle);
-
-static bool do_stop(DisasContext *ctx, arg_STOP *a)
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
-    t = tcg_constant_i32(PPC_PM_STOP);
-    gen_helper_pminsn(tcg_env, t);
-    /* Stop translation, as the CPU is supposed to sleep from now */
-    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
+    qemu_build_not_reached();
 #endif
     return true;
 }
-TRANS_FLAGS2(ISA300, STOP, do_stop);
+TRANS_FLAGS2(PM_ISA206, DOZE, do_sleep, PPC_PM_DOZE);
+TRANS_FLAGS2(PM_ISA206, NAP, do_sleep, PPC_PM_NAP);
+TRANS_FLAGS2(PM_ISA206, SLEEP, do_sleep, PPC_PM_SLEEP);
+TRANS_FLAGS2(PM_ISA206, RVWINKLE, do_sleep, PPC_PM_RVWINKLE);
+TRANS_FLAGS2(ISA300, STOP, do_sleep, PPC_PM_STOP);
-- 
2.53.0


