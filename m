Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD2CC61DCD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpl1-0005jt-Dm; Fri, 28 Aug 2026 02:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpkz-0005il-KZ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpkx-0000s2-Kc
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S22NbX597154
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tWltawaVF3OJdrBPp
 f0viLlBnZHc4YLj1NfTPsi/60s=; b=d0Dlj61SqkzVF3nlLbfOoIQNrtX2z7wQP
 l6bjSTFg05guhGz5C7wf15K157mhHgLp2t0yr5Te4sHRFQQDUttgC9FHcVPGCVCY
 EXJExWKuXdx5h/JjL6Ekx3GUQkXJvC6qjwSGQtnCWgoON5B+9jLv9uOp5AXHR762
 g1XGW1CfmwUlgcs3YxusNPeioMgX6N+9heP0MnSSZraYAllb8cSYTzICjbMOjI5a
 lthdfAlsTQTiaB8Sf2y5zKhKW/lR+kGG7+kOtQI0gTNqJ2nZ6749bAYaPkeqkVvA
 r4XppasOzTWZxD+hAdYACTAfXe+YH1pt9t+WsdfWZKq3oyBBgO98w==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394je4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 06:08:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uFjs025170;
 Fri, 28 Aug 2026 06:08:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragvgb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 06:08:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S67vus30343768
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:07:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 346DB2004E;
 Fri, 28 Aug 2026 06:07:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49EFB20040;
 Fri, 28 Aug 2026 06:07:55 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:07:55 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 12/41] target/ppc: convert sraw[i] instruction via decode spec
Date: Fri, 28 Aug 2026 11:36:47 +0530
Message-ID: <20260828060716.91672-13-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: I3uFFRboe_MDQvDFIztTO8B1gCP7P2kL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfXxByGhvdEMafr
 6lHqDXSjBj4fSxI6yxj6+b2Fo4hPVtVQLlIpzvEDBuk/6NDczhK6mRPlXLgSzAQaWc2MYd0XoG8
 n2D+j4FzAxUr/U+2b+nRS6PeK6nNcWVMiLEXEngvu41/k0liTuK91mYonJKjvAtPeeAp6IpK/kJ
 7GWMfVTHPL9X/Y6BaaoXrbrYwmd3oex+7EwPV7s9f8WvEJKJUlx1YkvxM9tQU8TGDnI/Zxv+hkZ
 Jop0+p/KWv7yNdS819xsXnLWq3InymOUBhlKIEzfuEjRvJXaj8U0K/69UOyqawFXLvacRVRmNWM
 NikN9ZDvgoZLq5tBvsH2oOsyGWkJpubBjPoxPoErowEcIolRUeNswW2TjzDvcx2HqHxL3C28jj7
 IFE/xp0O6VW5Z4WnUCz/yYGFnVQItiHbexYb1CFc5FoXb9jxAsFemAtQx0/p6BWYqsU6cUI5obG
 IKvS80Cgp6P4vg/PYeQ==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a9125c2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=gSLKyiytl6aLGSs9OJQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX/8rH3BAK88AO
 i0wA6+U55kwWuUTdq6SLJT4kbTHb3hbAvs3ecnv4hO6Izu7cKD0cusYmQt9SWA7nyddMJh5/x1K
 ARYv3wrifpjtCszAM/VBEzouPzPhwbE=
X-Proofpoint-ORIG-GUID: URmY7z8sJQT1g5BL3Cri880v7XRR1FDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>

Move sraw and srawi to decodetree specification using the @X_rc
format. The existing shift-masking logic from gen_sraw/gen_srawi is
preserved verbatim in the new trans_SRAW/trans_SRAWI handlers.

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-9-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
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
2.52.0


