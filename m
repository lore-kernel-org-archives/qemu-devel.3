Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DECC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3QS-0000pd-UL; Thu, 20 Aug 2026 10:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3QR-0000mN-3v; Thu, 20 Aug 2026 10:07:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3QP-0006xF-2y; Thu, 20 Aug 2026 10:07:22 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8tbaU362185; Thu, 20 Aug 2026 14:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KSW1G1nXC0+V1NUJe
 HhBvISafVzElPIhKh1HnJRoPUk=; b=pFD3VPI9bfKZrtORS6hrKWDU5BqfmFjcW
 EEREWG1uSOnnAZacmT4OfAGdCAWvSsKu2v/O5HSObL21r99IvGTObuSxdMgy0KkK
 DEOd2/fa6LSmo8Dmii5g9U3bn/nBB1Bw8Tph8ZwMCa9Jgg+EX5iQCbMa/MtOWDAf
 Rk0prmbg9RiIWjtYcAOCdt8EI2haBsySuynRn4ympWPg1VBXaCMmIUGDTnL+IvLV
 gZxUlEN9mWeOiH9fiIRGaE9NYSnppYRaXMQElOqwBJfEgaa4E9cJvv0aZFp/dxvC
 jrppvRr+nlv/rZWgCnMsMYEEIGIsLT9AWu1zIvzZTRI+s5t9wOQWQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4ansy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:07:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuHF6014751;
 Thu, 20 Aug 2026 14:07:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngpqt1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:07:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KE7Cel36241684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:07:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A2CC20043;
 Thu, 20 Aug 2026 14:07:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 537D320040;
 Thu, 20 Aug 2026 14:07:03 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:07:02 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 27/29] target/ppc: Move mfmsr,
 mtmsr[d] instructions to decodetree
Date: Thu, 20 Aug 2026 19:30:56 +0530
Message-ID: <20260820140114.327023-28-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820140114.327023-1-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX3zdYd/V/RNE7
 bE4eFtm39btHuW6SWXhOLTvUN+3BiyR0RDa5J+fYtlC9gIqnVCGfoPK5ZaSSKeo1L4aBVb8I6tJ
 hkmJPf8ldKxoyGcNNUlnq6GPdd3BAcc=
X-Proofpoint-GUID: fxDQd6tQIHAfi8dwY4RMS55R2OMt8yWK
X-Proofpoint-ORIG-GUID: F10r35HbryGS_-uzs0RtIsvWXt0kdZmC
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a870a16 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=fRY7pOLSFYBF0tKEtWUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX1YZtkAJIOTX9
 ZfJFI/JCw3aDwACmWTDoA5sIqvg2zKeGCBOZd6w3Llu89TvTWea7ekQleb+IdWNkAGCnbuZVbVd
 nInF9hoI9nrFlB7kWe8czmln9ooILZRC3SHCFciEyqYwcS9DDSJ6wFetJrWQXd5q0ScelewKUnK
 IoyNtLwHtByCk72gy0GkcCUXt5FOO8WBVH2uDn5awzGKz1iXwOlA8alszqhNA0ZHkq0CdVSNKnH
 8MmlV/iTTtL3BabYEP7g9cZf+KTHTjZXFoa1y+gmTNiSnPShU11wgkBL94PHYfV9HAhV5PGoNgl
 bpI/Y5p6iOKI4rLMjf+LgHYbi/vKsDatPUijZNGg0elF3jEhJrX91evhdtgVh6b/vJ/fwkc54Hf
 vMWTgN2cMIGhBk10fejYjpsIvZtAM003ZpPVFkDJmxOZXVYXWEVSasIoUyZqbL8uTVuokxa/Jh5
 NP25epZIm0hndIt+pWw==
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

From: Vishal Chourasia <vishalc@linux.ibm.com>

Moving the following instructions to decodetree specification:
            mfmsr                           : X-form
            mtmsr[d]                        : X-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the
`-d in_asm,op` flag.

This also includes improvements from review feedback:
- Gate MFMSR/MTMSR on PPC_MISC via TRANS_FLAGS()
- Use UINT32_MAX instead of 0xFFFFFFFF for clarity

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode             |  5 ++
 target/ppc/translate.c               | 97 ----------------------------
 target/ppc/translate/misc-impl.c.inc | 64 ++++++++++++++++++
 3 files changed, 69 insertions(+), 97 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index b0fa85b93e..f7ab08704f 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -315,6 +315,11 @@
 &M              ra rs sh mb me rc:bool
 @M              ...... rs:5 ra:5 sh:5 mb:5 me:5 rc:1 &M
 
+### MSR
+MFMSR           011111 ..... ----- ----- 0001010011 -   @X_t
+MTMSR           011111 ..... ---- . ----- 0010010010 -  @X_rs_l
+MTMSRD          011111 ..... ---- . ----- 0010110010 -  @X_rs_l
+
 ### Fixed-Point Load Instructions
 
 LBZ             100010 ..... ..... ................     @D
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 9db9d1e070..9d29134fa1 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2843,13 +2843,6 @@ static void gen_mcrxrx(DisasContext *ctx)
 }
 #endif
 
-/* mfmsr */
-static void gen_mfmsr(DisasContext *ctx)
-{
-    CHK_SV(ctx);
-    tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], cpu_msr);
-}
-
 /* mfspr */
 static inline void gen_op_mfspr(DisasContext *ctx)
 {
@@ -2923,93 +2916,6 @@ static void gen_mftb(DisasContext *ctx)
     gen_op_mfspr(ctx);
 }
 
-/* mtmsr */
-#if defined(TARGET_PPC64)
-static void gen_mtmsrd(DisasContext *ctx)
-{
-    if (unlikely(!is_book3s_arch2x(ctx))) {
-        gen_invalid(ctx);
-        return;
-    }
-
-    CHK_SV(ctx);
-
-#if !defined(CONFIG_USER_ONLY)
-    TCGv t0, t1;
-    target_ulong mask;
-
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-
-    translator_io_start(&ctx->base);
-
-    if (ctx->opcode & 0x00010000) {
-        /* L=1 form only updates EE and RI */
-        mask = (1ULL << MSR_RI) | (1ULL << MSR_EE);
-    } else {
-        /* mtmsrd does not alter HV, S, ME, or LE */
-        mask = ~((1ULL << MSR_LE) | (1ULL << MSR_ME) | (1ULL << MSR_S) |
-                 (1ULL << MSR_HV));
-        /*
-         * XXX: we need to update nip before the store if we enter
-         *      power saving mode, we will exit the loop directly from
-         *      ppc_store_msr
-         */
-        gen_update_nip(ctx, ctx->base.pc_next);
-    }
-
-    tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)], mask);
-    tcg_gen_andi_tl(t1, cpu_msr, ~mask);
-    tcg_gen_or_tl(t0, t0, t1);
-
-    gen_helper_store_msr(tcg_env, t0);
-
-    /* Must stop the translation as machine state (may have) changed */
-    ctx->base.is_jmp = DISAS_EXIT_UPDATE;
-#endif /* !defined(CONFIG_USER_ONLY) */
-}
-#endif /* defined(TARGET_PPC64) */
-
-static void gen_mtmsr(DisasContext *ctx)
-{
-    CHK_SV(ctx);
-
-#if !defined(CONFIG_USER_ONLY)
-    TCGv t0, t1;
-    target_ulong mask = 0xFFFFFFFF;
-
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-
-    translator_io_start(&ctx->base);
-    if (ctx->opcode & 0x00010000) {
-        /* L=1 form only updates EE and RI */
-        mask &= (1ULL << MSR_RI) | (1ULL << MSR_EE);
-    } else {
-        if (likely(!(ctx->insns_flags2 & PPC2_PPE42))) {
-            /* mtmsr does not alter S, ME, or LE */
-            mask &= ~((1ULL << MSR_LE) | (1ULL << MSR_ME) | (1ULL << MSR_S));
-        }
-
-        /*
-         * XXX: we need to update nip before the store if we enter
-         *      power saving mode, we will exit the loop directly from
-         *      ppc_store_msr
-         */
-        gen_update_nip(ctx, ctx->base.pc_next);
-    }
-
-    tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)], mask);
-    tcg_gen_andi_tl(t1, cpu_msr, ~mask);
-    tcg_gen_or_tl(t0, t0, t1);
-
-    gen_helper_store_msr(tcg_env, t0);
-
-    /* Must stop the translation as machine state (may have) changed */
-    ctx->base.is_jmp = DISAS_EXIT_UPDATE;
-#endif
-}
-
 /* mtspr */
 static void gen_mtspr(DisasContext *ctx)
 {
@@ -4687,15 +4593,12 @@ GEN_HANDLER(hrfid, 0x13, 0x12, 0x08, 0x03FF8001, PPC_64H),
 GEN_HANDLER(sc, 0x11, 0x11, 0xFF, 0x03FFF01D, PPC_FLOW),
 GEN_HANDLER(sc, 0x11, 0x01, 0xFF, 0x03FFF01D, PPC_FLOW),
 GEN_HANDLER(mcrxr, 0x1F, 0x00, 0x10, 0x007FF801, PPC_MISC),
-GEN_HANDLER(mfmsr, 0x1F, 0x13, 0x02, 0x001FF801, PPC_MISC),
 GEN_HANDLER(mfspr, 0x1F, 0x13, 0x0A, 0x00000001, PPC_MISC),
 GEN_HANDLER(mftb, 0x1F, 0x13, 0x0B, 0x00000001, PPC_MFTB),
 #if defined(TARGET_PPC64)
-GEN_HANDLER(mtmsrd, 0x1F, 0x12, 0x05, 0x001EF801, PPC_64B),
 GEN_HANDLER_E(setb, 0x1F, 0x00, 0x04, 0x0003F801, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(mcrxrx, 0x1F, 0x00, 0x12, 0x007FF801, PPC_NONE, PPC2_ISA300),
 #endif
-GEN_HANDLER(mtmsr, 0x1F, 0x12, 0x04, 0x001EF801, PPC_MISC),
 GEN_HANDLER(mtspr, 0x1F, 0x13, 0x0E, 0x00000000, PPC_MISC),
 GEN_HANDLER(mfsr, 0x1F, 0x13, 0x12, 0x0010F801, PPC_SEGMENT),
 GEN_HANDLER(mfsrin, 0x1F, 0x13, 0x14, 0x001F0001, PPC_SEGMENT),
diff --git a/target/ppc/translate/misc-impl.c.inc b/target/ppc/translate/misc-impl.c.inc
index 890fbb209e..54712f9b73 100644
--- a/target/ppc/translate/misc-impl.c.inc
+++ b/target/ppc/translate/misc-impl.c.inc
@@ -161,3 +161,67 @@ static bool trans_MCRF(DisasContext *ctx, arg_MCRF *a)
     tcg_gen_mov_i32(cpu_crf[a->bf], cpu_crf[a->bfa]);
     return true;
 }
+
+static bool do_mfmsr(DisasContext *ctx, arg_X_t *a)
+{
+    REQUIRE_SV(ctx);
+    tcg_gen_mov_tl(cpu_gpr[a->rt], cpu_msr);
+    return true;
+}
+TRANS_FLAGS(MISC, MFMSR, do_mfmsr)
+
+static bool do_mtmsr(DisasContext *ctx, arg_X_rs_l *a, bool is_mtmsrd)
+{
+    REQUIRE_SV(ctx);
+#if !defined(CONFIG_USER_ONLY)
+    TCGv t0, t1;
+    target_ulong mask;
+
+    if (is_mtmsrd) {
+        if (unlikely(!is_book3s_arch2x(ctx))) {
+            gen_invalid(ctx);
+            return true;
+        }
+        mask = ~(target_ulong)0;
+    } else {
+        mask = UINT32_MAX;
+    }
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    translator_io_start(&ctx->base);
+
+    if (a->l) {
+        /* L=1 form only updates EE and RI */
+        mask &= (1ULL << MSR_RI) | (1ULL << MSR_EE);
+    } else {
+        if (is_mtmsrd) {
+            /* mtmsrd does not alter HV, S, ME, or LE */
+            mask &= ~((1ULL << MSR_LE) | (1ULL << MSR_ME) |
+                      (1ULL << MSR_S)  | (1ULL << MSR_HV));
+        } else if (likely(!(ctx->insns_flags2 & PPC2_PPE42))) {
+            /* mtmsr does not alter S, ME, or LE */
+            mask &= ~((1ULL << MSR_LE) | (1ULL << MSR_ME) | (1ULL << MSR_S));
+        }
+        /*
+         * XXX: we need to update nip before the store if we enter
+         *      power saving mode, we will exit the loop directly from
+         *      ppc_store_msr
+         */
+        gen_update_nip(ctx, ctx->base.pc_next);
+    }
+
+    tcg_gen_andi_tl(t0, cpu_gpr[a->rs], mask);
+    tcg_gen_andi_tl(t1, cpu_msr, ~mask);
+    tcg_gen_or_tl(t0, t0, t1);
+
+    gen_helper_store_msr(tcg_env, t0);
+
+    /* Must stop the translation as machine state (may have) changed */
+    ctx->base.is_jmp = DISAS_EXIT_UPDATE;
+#endif /* !CONFIG_USER_ONLY */
+    return true;
+}
+
+TRANS_FLAGS(MISC, MTMSR, do_mtmsr, false)
+TRANS64(MTMSRD, do_mtmsr, true)
-- 
2.55.0


