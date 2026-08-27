Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CB3C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaCa-0000ie-Od; Thu, 27 Aug 2026 09:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaCZ-0000hA-LB; Thu, 27 Aug 2026 09:31:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaCX-0001X4-OM; Thu, 27 Aug 2026 09:31:31 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVcC03056420; Thu, 27 Aug 2026 13:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MAnq5AAytXqTkpSSb
 H2iM6eJJylcr7iKFKMeUw/bkB8=; b=Tde5q+PaT/qZ1RNzdDDfFEDSvx1n/OAfr
 ehXwehPXi4VTNVfEB4F+JEoRlDeE8mSdVewhH+Z221nu+cVG/+bxr1MRr686vQdF
 s83UoIie5MGYejfujeYW/NABy33s/JM50jPzAXJdD266nnDVpbpRG16R9dhF31xh
 EItljcmLf0/ht+jD+8X28mqcJuCl+3Ws++hdS1y6+BmSN/gY1humL132KAbaUE8n
 iL5Goij94leIyuPXGkTFurNH2YNDJeTsS1Iljft860t9EDW/v3nzHwDjJkFD3F1x
 i/+mvXutFYcm333qGG6O+BsL0CKeluksrayBWF4N5L/F2St+/75Sw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxn9g5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:31:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQS1I013375;
 Thu, 27 Aug 2026 13:31:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qgh08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:31:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RDVMQH45351340
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 13:31:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7F7E2004D;
 Thu, 27 Aug 2026 13:31:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9378E20043;
 Thu, 27 Aug 2026 13:31:16 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.111.12.1]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 13:31:16 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3 08/37] target/ppc: convert sraw[i] instruction via decode
 spec
Date: Thu, 27 Aug 2026 18:59:23 +0530
Message-ID: <20260827133010.278889-9-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827133010.278889-1-rathc@linux.ibm.com>
References: <20260827133010.278889-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX1OnoZaOhwtMf
 SSUZgKZuWVQZGlIIA28HhjD3oaw0FFSpoarGfbbyMU32/XUyxd67YgtRhy5+zkogbtfI/+1EOXQ
 K+6KdZF1VO1KaK+WP2+xzrqPM1dyOvE=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a903c2f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=gSLKyiytl6aLGSs9OJQA:9
X-Proofpoint-ORIG-GUID: pJQlU7Bsego_PIChIFNXslVPU0-i3wbo
X-Proofpoint-GUID: NK7B7KG6m77q_GZnwty5qySfhO5XSftn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfXyTLxQVF/ojOk
 GCiM/sOwbxgIDGZrmYUq+uuHv24Rj9sQ6rdRjhMVPnU+t/RgTCQkGz+kAi5aY9Usuk4J6ZwrvPW
 meKS+SJ1v6NoSEoqDDlRVAKeaLstZ9NnYMYJ3bnm1TS6ltunHm23hayEwmfFqrjOmbzfMcRRIpt
 KmTes15f0nyMFYKTHrDbbH8LulnupNv9yWcw7BR1O8i8EC0m1jYLBVKLqeoVYoYgXg/a/6alFJk
 tahzMflTWW+ggtVB87QvrcmCYj9ODKp4nLwIezyv8WdPnddJl2oELKhyVRsSLpmqa4yWdpfisjS
 BRMHGmhJdUnXTPvLiN4rcP14Jhp0gaAxVIE26keMY3/W6FADjiCeCYVz5CfZr+29jCRlsqivkLY
 +1xKMep7/zEJXsbky6aJhQrLuzyFmSqgnknSHK6fvwlh4XPfxZOgWjxwV9jF6jvHBQLzl1UMU0W
 /eSXkKT7YwI5f4n5aZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270113
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

From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>

Move sraw and srawi to decodetree specification using the @X_rc
format. The existing shift-masking logic from gen_sraw/gen_srawi is
preserved verbatim in the new trans_SRAW/trans_SRAWI handlers.

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/helper.h                        |  2 +-
 target/ppc/insn32.decode                   |  2 ++
 target/ppc/int_helper.c                    |  2 +-
 target/ppc/translate.c                     | 42 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 41 +++++++++++++++++++++
 5 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index a0d08d6192..d4a9334ce8 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -64,7 +64,7 @@ DEF_HELPER_4(DIVWE, tl, env, tl, tl, i32)
 
 DEF_HELPER_FLAGS_1(POPCNTB, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(CMPB, TCG_CALL_NO_RWG_SE, tl, tl, tl)
-DEF_HELPER_3(sraw, tl, env, tl, tl)
+DEF_HELPER_3(SRAW, tl, env, tl, tl)
 DEF_HELPER_FLAGS_2(CFUGED, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(PDEPD, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(PEXTD, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 189f9c6fe7..ef0fe12959 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -509,6 +509,8 @@ HASHCHKP        011111 ..... ..... ..... 1010110010 .   @X_DW
 
 SLW             011111 ..... ..... ..... 0000011000 .   @X_rc
 SRW             011111 ..... ..... ..... 1000011000 .   @X_rc
+SRAW            011111 ..... ..... ..... 1100011000 .   @X_rc
+SRAWI           011111 ..... ..... ..... 1100111000 .   @X_rc
 
 ## BCD Assist
 
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index dc55ccadf7..b161f930ec 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -235,7 +235,7 @@ target_ulong helper_CMPB(target_ulong rs, target_ulong rb)
 }
 
 /* shift right arithmetic helper */
-target_ulong helper_sraw(CPUPPCState *env, target_ulong value,
+target_ulong helper_SRAW(CPUPPCState *env, target_ulong value,
                          target_ulong shift)
 {
     int32_t ret;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3d26e1144e..53acd54ad4 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2316,46 +2316,6 @@ GEN_PPC64_R4(rldimi, 0x1E, 0x06);
 /***                             Integer shift                             ***/
 
 
-/* sraw & sraw. */
-static void gen_sraw(DisasContext *ctx)
-{
-    gen_helper_sraw(cpu_gpr[rA(ctx->opcode)], tcg_env,
-                    cpu_gpr[rS(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
-    }
-}
-
-/* srawi & srawi. */
-static void gen_srawi(DisasContext *ctx)
-{
-    int sh = SH(ctx->opcode);
-    TCGv dst = cpu_gpr[rA(ctx->opcode)];
-    TCGv src = cpu_gpr[rS(ctx->opcode)];
-    if (sh == 0) {
-        tcg_gen_ext32s_tl(dst, src);
-        tcg_gen_movi_tl(cpu_ca, 0);
-        if (is_isa300(ctx)) {
-            tcg_gen_movi_tl(cpu_ca32, 0);
-        }
-    } else {
-        TCGv t0;
-        tcg_gen_ext32s_tl(dst, src);
-        tcg_gen_andi_tl(cpu_ca, dst, (1ULL << sh) - 1);
-        t0 = tcg_temp_new();
-        tcg_gen_sari_tl(t0, dst, TARGET_LONG_BITS - 1);
-        tcg_gen_and_tl(cpu_ca, cpu_ca, t0);
-        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
-        if (is_isa300(ctx)) {
-            tcg_gen_mov_tl(cpu_ca32, cpu_ca);
-        }
-        tcg_gen_sari_tl(dst, dst, sh);
-    }
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, dst);
-    }
-}
-
 #if defined(TARGET_PPC64)
 /* sld & sld. */
 static void gen_sld(DisasContext *ctx)
@@ -5717,8 +5677,6 @@ GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(rlwimi, 0x14, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(rlwinm, 0x15, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(sraw, 0x1F, 0x18, 0x18, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(srawi, 0x1F, 0x18, 0x19, 0x00000000, PPC_INTEGER),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(sld, 0x1F, 0x1B, 0x00, 0x00000000, PPC_64B),
 GEN_HANDLER(srad, 0x1F, 0x1A, 0x18, 0x00000000, PPC_64B),
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 9d04b96316..234404e459 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -1454,3 +1454,44 @@ static bool trans_SRW(DisasContext *ctx, arg_SRW *a)
     }
     return true;
 }
+
+/* sraw & sraw. */
+static bool trans_SRAW(DisasContext *ctx, arg_SRAW *a)
+{
+    gen_helper_SRAW(cpu_gpr[a->ra], tcg_env,
+                    cpu_gpr[a->rt], cpu_gpr[a->rb]);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+    }
+    return true;
+}
+
+/* srawi & srawi. */
+static bool trans_SRAWI(DisasContext *ctx, arg_SRAWI *a)
+{
+    TCGv dst = cpu_gpr[a->ra];
+    TCGv src = cpu_gpr[a->rt];
+    if (a->rb == 0) {
+        tcg_gen_ext32s_tl(dst, src);
+        tcg_gen_movi_tl(cpu_ca, 0);
+        if (is_isa300(ctx)) {
+            tcg_gen_movi_tl(cpu_ca32, 0);
+        }
+    } else {
+        TCGv t0;
+        tcg_gen_ext32s_tl(dst, src);
+        tcg_gen_andi_tl(cpu_ca, dst, (1ULL << a->rb) - 1);
+        t0 = tcg_temp_new();
+        tcg_gen_sari_tl(t0, dst, TARGET_LONG_BITS - 1);
+        tcg_gen_and_tl(cpu_ca, cpu_ca, t0);
+        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
+        if (is_isa300(ctx)) {
+            tcg_gen_mov_tl(cpu_ca32, cpu_ca);
+        }
+        tcg_gen_sari_tl(dst, dst, a->rb);
+    }
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, dst);
+    }
+    return true;
+}
-- 
2.55.0


