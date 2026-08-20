Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA67C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3NM-0001bI-KD; Thu, 20 Aug 2026 10:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3NG-0001Rp-Tb; Thu, 20 Aug 2026 10:04:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3NE-0005ya-OR; Thu, 20 Aug 2026 10:04:06 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8b0ZR424242; Thu, 20 Aug 2026 14:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=D9tB0/IAMNq48VTU5
 fERiDmuDkHLYxkDZVsaawvGOic=; b=eDgJLlHUAvoxYCe1Jevj5W1XgFGnisIRm
 XQn64iRqCqDcBOxHhDv4XxZDS+HjTxa+xwmRFv0hAZDyliqj0dF64vcHqS6mafq0
 kpz4tRbA/I4lFYxf5BA9vhHWV3ccqCvhoyUVCqdPSx5eLxc1j1K/ggRQHGNTHqeg
 6KGdbmNp6itPmEa2pzgR1B7AUHyuQYs6s/Z1B7Sk7h/wvT/t6dXnvLAKVbO8/O5b
 rfybNvaZCbre7CyaqrDDv5V1GsmNs9AeXgitWzPG6AuR8x0t5PV/h9wPQWOOpRBt
 ZFhO7HEOdGJRZFIlB8nKD0weQ2kHhGzFT18fk1hwGgalt1zfBPgOA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1jr9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:04:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuL4c014903;
 Thu, 20 Aug 2026 14:04:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngpq5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:04:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KE3tIB34472342
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:03:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D58CC20040;
 Thu, 20 Aug 2026 14:03:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55CA52004D;
 Thu, 20 Aug 2026 14:03:45 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:03:45 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 08/29] target/ppc: convert sraw[i] instruction via decode spec
Date: Thu, 20 Aug 2026 19:30:37 +0530
Message-ID: <20260820140114.327023-9-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820140114.327023-1-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a870952 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=8vnlzkHpZUhk_GZ0CsoA:9
X-Proofpoint-GUID: Jfb6kijoBWSj6LIJxecr0Nt2AdMfrmlp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX/hxhSPTCo+Sp
 8qumHfCD79wtpdSTBJM9CvotcqDuy7ipueOUxvvfXzmDHJbHWDclXnPV3o8/tegEFhgmGz1RbN4
 WDNgUQg50zdYFn2UG2LzMgaDJ+4GRc0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX9X3jL9FrQHlr
 8JItwvNqC9ZwJad10OexbUlHDE9Qxurq6AO1TGvYu+RSE6CG62FbZLIyThc64zoucS3SRY/hMVF
 Q42QcIH59eGFKdhio2vPXqTMR4FTCGjMeLB29U7DWamGqKjIlWqcKp7p/pAcNVo1saukVhu7b+m
 4C4jrChYOYE8wcYsQ8G4YvRsUezu0/IXuXnrTtT9rjdXulmdPAi2/2pszatWz5fv9jmWE929d/J
 TSYHs/bk1YcEG/x+CGpbBP7kF9upA99V+mJebNkPmPGJdDHRqLOyKnyJlDAJ3hWKrXA1mx7BfoB
 8vN6lkPP9XRahbKHnGR0TSxmKXDS1EDdsKzpeK7Vx1aaJSPmVIv9/KKfODCjmdlNpDdy3hK/GoC
 kA6kZ+da2SL54FSWeVXVgiJ+bxcMUhjr90XSnUqU/aBmCUC5BODQUK1PIh5CxBxb291Iapkhmww
 jKnDtulmsuNFAfERZDw==
X-Proofpoint-ORIG-GUID: uoIdFhGK0S3oYsF2k814ODemJRGcfcNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
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

From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>

Instruction converted:

- sraw
- srawi

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/helper.h                        |  2 +-
 target/ppc/insn32.decode                   |  6 ++--
 target/ppc/int_helper.c                    |  2 +-
 target/ppc/translate.c                     | 42 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 41 +++++++++++++++++++++
 5 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 6df3de6516..3aff559504 100644
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
index 66d2f455a9..af35a44223 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -507,8 +507,10 @@ HASHCHKP        011111 ..... ..... ..... 1010110010 .   @X_DW
 
 # Fixed-Point Shift Instructions
 
-SLW		011111 ..... ..... ..... 0000011000 .	@X_rc
-SRW		011111 ..... ..... ..... 1000011000 .	@X_rc
+SLW             011111 ..... ..... ..... 0000011000 .   @X_rc
+SRAW            011111 ..... ..... ..... 1100011000 .   @X_rc
+SRAWI           011111 ..... ..... ..... 1100111000 .   @X_rc
+SRW             011111 ..... ..... ..... 1000011000 .   @X_rc
 
 
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
index f2b7505634..f00071aa91 100644
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
@@ -5730,8 +5690,6 @@ GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
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


