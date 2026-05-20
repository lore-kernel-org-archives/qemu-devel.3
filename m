Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5E3CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjVI-0006i5-2b; Wed, 20 May 2026 12:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjVF-0006dT-8F; Wed, 20 May 2026 12:10:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjVC-0003Qk-Mc; Wed, 20 May 2026 12:10:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KBgYib3935189; Wed, 20 May 2026 16:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=q4caVHg7aIV4db6NR
 v60MshPPR0ucxZ1ZzzA1gHlx/c=; b=UvcaaDsomIiH9AcI9gf2t6EA7dUA1OLCs
 I1BcOCIjrgrkIqj4XhcypwiTCg2IZYC3pViV2rJ2oxSGvNk8o8HW2Kpoz094As21
 nIAkDMupewfW0tTgIX0/gYO8p7GQNn6uJbZArEqm0KBK0J1kYBvsDljoqJyJ8zkm
 +SczRKss64o9ppXhufRKc+9b4iLKgUusHcNGlggBojaB5gP17l93AleH1hyC1mTU
 nFZI9lbsdCqDZvdAwGtA+yMk6AuAjh4B57CwMP5NEpsenTRp0WDTDb+rXaUGtTQc
 /S39B3UZRWv5MaaW2p73AhcjiMsiRuFoisYZOJKIsQLNcykDKJcug==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y30ha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:10:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KG96To025888;
 Wed, 20 May 2026 16:10:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky7ty8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:10:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KGAR0046465316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 16:10:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42B5B2004B;
 Wed, 20 May 2026 16:10:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C15720040;
 Wed, 20 May 2026 16:10:20 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.31.153]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 16:10:19 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 26/28] target/ppc: Move mfmsr,
 mtmsr[d] instructions to decodetree
Date: Wed, 20 May 2026 21:37:26 +0530
Message-ID: <20260520160728.2283628-27-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfX571ISNfyY/ov
 tiS6HVuev4QJXQc8ftm/EY1EhsIqlFIUJ4foQ6JwYWSnf+mBoKP/zSzPB28HFtW1HkqOcswUYOc
 vkxs+WgIuX/HtZuXr2xuwjnrPKV3oa4mkvshRKGadEbm6gt/s4rDaw0ZdsiSnY9x1XcTc3yMNuc
 ysNq12UdziSCDzXWgma7jcj01UaAkLA2RZ1rYYNU4TXT07MiEjbJcTYQLy/W2/V2OIYH6VXBlk2
 OKbIfd7o2Pj+ceGlm7iM8Pu/Tj+LCmZLC7GSLWud1gR7ymvcT3jwR4uo+mAzjdceqXbE46ns9cY
 pJodyTuLlJjSRNPRh6ZBYbVV9IEF4NpFy4gLMyNPeFQJDx+VWmHa7/vZQgqB2+E9dcVnwXEpoTs
 20DY5DFWdT9bkrA/QjQAFjYTG2ENw0iLMjQxo7oQEVLL4/041AKYmdyG2XrMrLVw46YqnwuSM3F
 l11kqbobj7Rx7lg/ZiA==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0ddcf8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=fRY7pOLSFYBF0tKEtWUA:9
X-Proofpoint-ORIG-GUID: ZTKjzRRSpZ0HS8tAXKEKHX1E92Pj9v03
X-Proofpoint-GUID: YDmJaJ9wjUpWDTAVm8k0N-D8rAR9Em7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200156
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
index 15f4a57fa0..c5e24968e4 100644
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
index bd22b7032d..bb7d704a6b 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2845,13 +2845,6 @@ static void gen_mcrxrx(DisasContext *ctx)
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
@@ -2925,93 +2918,6 @@ static void gen_mftb(DisasContext *ctx)
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
@@ -4713,15 +4619,12 @@ GEN_HANDLER(hrfid, 0x13, 0x12, 0x08, 0x03FF8001, PPC_64H),
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
2.53.0


