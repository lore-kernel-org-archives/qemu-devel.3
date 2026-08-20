Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C4AC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3P7-0005sJ-7n; Thu, 20 Aug 2026 10:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3P5-0005rf-Bj; Thu, 20 Aug 2026 10:05:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3P3-0006ek-Dt; Thu, 20 Aug 2026 10:05:59 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K96JWt2795608; Thu, 20 Aug 2026 14:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VfYNwR3GxE6/q1yIe
 vspZoAa+wahfZ3H0Lt1mpyzuyw=; b=cOxxK7i4wCcYLng9GLn9LT7H5aBa/i4nY
 8cDUSeihEInjd6n2L9oUhAXs2vj/AdYXo72cY9sbBn0+vHocKQMpjQQw8MyOd2ZB
 nYLG/qGncjd40uODOrFbmjnfRzMBRYjj/PplTEhkVajFT+2GTqORrPBwaZjnkavj
 7HBkGd52SRb3uk/ZAxULDPBFz2M/WzAc0YULQVBykcymE/XDLWxjYdXH+ZHZxJgC
 C7HlcXK10IRwkC/jMhKSxfa+tYna297LodpQghREI76sdb5rKjI59SpsFedZeXDy
 t4UbdGeN73MnKNIgzYoWom0Euq3cJBrydwyDSyY3wHF9KZySvsT2w==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0asev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:05:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuIcf027519;
 Thu, 20 Aug 2026 14:05:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqf3vv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:05:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KE5mOd44171574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:05:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F020420043;
 Thu, 20 Aug 2026 14:05:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CF0320040;
 Thu, 20 Aug 2026 14:05:38 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:05:37 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 19/29] target/ppc: Refactor sleep and its variants to use a
 common helper
Date: Thu, 20 Aug 2026 19:30:48 +0530
Message-ID: <20260820140114.327023-20-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820140114.327023-1-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: jlW1Wt1GMOBXyg1TeLLshViCOD17bMqL
X-Proofpoint-GUID: rbhTywV3huiD1ZaKderV43iBgHpfTjVc
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a8709c2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=AYO248uK6yRxx-YkPnAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX3YTwD5GRzHSM
 X5y1KQuFajwy+qB6agogzNj3YIi3rLveLwz7PzAGYWvs+KEek798sNuFul1xmwGcufWPtoclUfE
 +Vwdo4SvnxYxQ49JkjODQNvdNun0Ioo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX+b83jR1frP63
 Olg74owGPpzZnz7kCiTqf1Y39SEElde2aHehnga0UIXsTXelVTMdrjNCarnXHWaoFB6B/CpWybe
 rKxrQqAAog9RHyX5Ur8m8PjwHbZEUZTq6qEhdJI0/mxpH91di0QUFstKp1eITscFGU/6A1MvRDs
 eJXMeZq9TU5UgeQAShOXnTWpghTFBbSKNNIHaevelo1Ue2y4rqO4Ijz9XKwcSq8IPg1HR/KPsow
 PzGKuIuEonGNME5y01Bj/spAyIC6L1HI6FQnf6kBUfJNzQVMtdGdT7T+YXmR3d43Oh0dreBkBkb
 3GMr9ngKCVeApZU7UaaOm9MeBzKB27HkdRLKDGNBq0fmOsR6+GpkWxiP5RO3GG+b86BkfZ0bngf
 pbuuEJ/K3tM5Xwcnc/OCZ9xB3hsX/iJxJUcYfJtxSo6l+XFqSsh1JNlepgKHq3WDwE0ApUxaO6R
 kDa7wxh94D3q7JCuq4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105
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

Refactor sleep, doze, nap, rvwinkle and stop to use a common helper
since they share majority of the code. Also refactor gen_hlper_pminsn()
to gen_helper_PMINSN()

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


