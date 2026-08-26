Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8A0C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5vR-0002H5-GD; Wed, 26 Aug 2026 01:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5vQ-0002Dk-Lc; Wed, 26 Aug 2026 01:11:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5vO-0005R3-Nz; Wed, 26 Aug 2026 01:11:48 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3W6Od956230; Wed, 26 Aug 2026 05:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SEccTn1diHww0ordb
 O1MGdVCWAJS5vN10YFp0qEaeVQ=; b=oU7zupteLVuM1PRc0Jy47VDtQ0SW1H0PY
 t4TPuj9P5uOVzuw7p2uaEChN/lOETgoQUNazZRAW0EUiaIZvuCwBiV4yORU0ygfv
 duZswDxj/2EbhvT704vj158xUWFavPiZtfCg0EYgxhbmxitXGDTu+m0FKu1pfNX/
 MFSYVkoxphX3I4fu2Dj3q++RBxwquj7Llpr2hKGVuw9PKz9EuRBl5lN/78Tpb5IE
 CpNr1GnJLz3y5KBYBbIgHE5QVq6rK1RnPOYmjkCohwWnONFd3Ghe4BGpOuIwKCEl
 vTWpMDarSEyB9gdvZKbReqMemjFjpIdIK1OwQtUNo5D8kPIP8dJyQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqvkwh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:11:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q5BN5Q011994;
 Wed, 26 Aug 2026 05:11:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragg27w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:11:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5BdkA35127652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:11:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E45772004B;
 Wed, 26 Aug 2026 05:11:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC3FD20040;
 Wed, 26 Aug 2026 05:11:33 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:11:33 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 19/37] target/ppc: Refactor sleep and its variants to use a
 common helper
Date: Wed, 26 Aug 2026 10:38:45 +0530
Message-ID: <20260826050923.74756-20-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: -B1iKB8TUUikl89gp-AH4eDE5PQhlItB
X-Proofpoint-ORIG-GUID: kZvEzL85zWg8-lW-7CP3a0i1XuWcwTGc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX22Ap+BJIu3dy
 IiELYs7TGJ150jRajSZfPFxFsVQZgpzCNeKmM7BgwIamnHnr1uRji2GQTAdWBtAunLNJk6u4M1y
 pTWojSN+7+zLCdXdaeeMfsLrG5RYmf+OlL98jskm380Dq2EBJVlP09tAcVXXcbel/ufAOK0D0EG
 ea2vr4Ob3KzQYNe951dOlh9n26vay3afB+ja4AI51jl2KQ6piZTBCRxmGgIz9xmih8W0et56mKg
 Q96zaOKGJnC0W0il1e5ojuozDE8l7ICY7NkeQcsE4UNawEXzFoYmmEsxmr7lXf7ftHLU+21kkmt
 NEO4jMd4rWUfJ8b1Vfn+K86sXrms/hBkNaO3jN1x0H07oB1j9ijk6VlxnmwbiaYsOiVDPVE0v0K
 J18H8qCb7ILMF1rv84Yz+qTNHi6hM6VYgw1nrOwkPRtMtVb1uGbhpRFYCVLdMigjoVHh12vPxke
 yMwWfbr9w+77rr786VA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8e7590 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=AYO248uK6yRxx-YkPnAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX6Sy+bocGefup
 7+5Oe3aNGMIMwpX7jK8qz5zhBMgWSpCR6xvXLQP59OCAExf3BL3edb96yBP7aZD/nunFmRL3hFb
 VTqiAOSPxCTxwXYBOBVVjkU0ORSd224=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260040
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

With sleep, doze, nap, rvwinkle and stop instructions moved to
decodetree, the helper these instructions used : gen_helper_pminsn,
should now be renamed to gen_helper_PMINSN, abiding by the decodetree
standards. Do the same.
Also refactor their translation routine to use a common do_sleep routine
since they share majority of the code.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/helper.h                           |  2 +-
 target/ppc/tcg-excp_helper.c                  |  2 +-
 .../ppc/translate/processor-ctrl-impl.c.inc   | 99 +++----------------
 3 files changed, 16 insertions(+), 87 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index cd2a0948a3..7e15676122 100644
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
2.55.0


