Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75202CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjVj-0007GL-0j; Wed, 20 May 2026 12:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjVR-0006ws-HA; Wed, 20 May 2026 12:10:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjVO-0003X6-8A; Wed, 20 May 2026 12:10:48 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KAhnPc3252234; Wed, 20 May 2026 16:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=B4D0pIAeCKMPznoqw
 mnFgjiYJd+LRvsplY+og7RVoJs=; b=NxQLkZOEgXM+J7csqQL6o2Txi40JdyBTa
 Dfe6ksbjc4AgzqjV5vCMOW9evQVwV6Vbj7TsAt4rYCM0phAOUvTt+L5sJ2ZIzMUt
 xoNcFpj74yPKpd7IVNdZ2XuHYV+pqXfe0NJh4b44VPfGPELzk4nizq7/c51+XBIs
 qpBADjCeN674GtHyPwSE0Q9zyfRwwhUGFHAMYgQyfLZC9RMVEJgazqOERvpDpofM
 ELArqYywvcwbtA8dEU2TZP191qiFT7cpuZCe7Jt8NXGivQqjpG2CzroHRaCbKlV8
 7lUAo5Z76MuwZV+No+SGOVKt/GfeNNNF1BaBjiZx44kqbYeijN0RA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6haw9xxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:10:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KG974P024343;
 Wed, 20 May 2026 16:10:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq8asb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:10:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KGAdRK59703636
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 16:10:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABF0C20043;
 Wed, 20 May 2026 16:10:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7170E20040;
 Wed, 20 May 2026 16:10:34 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.31.153]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 16:10:34 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 28/28] target/ppc: Move system call and rfi instructions
 to decodetree
Date: Wed, 20 May 2026 21:37:28 +0530
Message-ID: <20260520160728.2283628-29-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfXxPesqQ08mPIw
 TUM2kAYf0Upc+ZxIo1wcLhXKJhO/6/7lyhsOIshs95eS/CVviYzmqq6PNYP+fm8H2wQLFmoIABA
 NCtK+3GaqhMOOLoic+gAZ+uSxttkNVnWwTyNDayEuk/IbQngUd9FOjG2yuI4CZgmZalR84iDE/K
 DfWvQ0Zyy1Wjrd1rK0ewjeUH0Sb3QITKjEwaA93CrMvJcZS1KY5KUzwQ847XHHczpkvOVJRMC61
 P0uJPOTgocMonyW6hwnNPmw2BJvBP0feJ3smbWocKnLbtCn4s+k7QQAe2NhymV8bpp/sLI5icpX
 VkuXNjcT/vVQXkx1/o/ErYEzFtyZWqOadVwjqV03Wf8ljY/UiOVci75yZDhj70/aCdxuXUFVACw
 yVlP5seCKroxpIstnLPtJfZnQw9ghtEiaH61dz4WiKanVlfxhPhcmmmdJBKcaP4dLEa2IPLno5H
 1Z+vfwWZxeEFGfcIraw==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0ddd04 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=YmvlJOrxzi765e-HvEIA:9
X-Proofpoint-ORIG-GUID: ixqpbPJTfhbJonGtktlhbjnnqmIuR_p2
X-Proofpoint-GUID: q6IkcV3rO08jM5zCdcxy7Y-snPrvgK-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200156
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

From: Vishal Chourasia <vishalc@linux.ibm.com>

Moving the following instructions to decodetree specification:
    sc, scv                         : SC-form
    rfi, rfid, rfscv, hrfid         : XL-form

This builds upon the previous work that moved mfmsr and mtmsr[d]
instructions to decodetree.

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the
`-d in_asm,op` flag, and also by booting a pseries qemu guest.

This also includes improvements from review feedback:
- Rename helpers to uppercase (RFI/RFID/RFSCV/HRFID) to match ISA mnemonics
- Add TRANS_FLAGS_NOT() and TRANS64_FLAGS() macro variants
- Add REQUIRE_INSNS_FLAGS_NOT() check for flag exclusion
- Specify lev field as uint8_t in SC instruction format
- Remove redundant masking in SCV since lev is already 7-bit
- Replace TARGET_PPC64 ifdefs with REQUIRE_64BIT() macro
- Gate SC, SCV, RFI, RFID, RFSCV, and HRFID with appropriate flags
- Replace runtime is_book3s_arch2x() check in RFI with TRANS_FLAGS_NOT(SEGMENT_64B)
- Consolidate CONFIG_USER_ONLY guards into single block

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/helper.h                  |   8 +-
 target/ppc/insn32.decode             |  11 +++
 target/ppc/tcg-excp_helper.c         |   8 +-
 target/ppc/translate.c               | 139 ++++-----------------------
 target/ppc/translate/misc-impl.c.inc | 105 ++++++++++++++++++++
 5 files changed, 144 insertions(+), 127 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 22babb80e9..02d960ca6b 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -11,7 +11,7 @@ DEF_HELPER_4(HASHCHKP, void, env, tl, tl, tl)
 #if !defined(CONFIG_USER_ONLY)
 DEF_HELPER_2(store_msr, void, env, tl)
 DEF_HELPER_1(ppc_maybe_interrupt, void, env)
-DEF_HELPER_1(rfi, void, env)
+DEF_HELPER_1(RFI, void, env)
 DEF_HELPER_1(40x_rfci, void, env)
 DEF_HELPER_1(rfci, void, env)
 DEF_HELPER_1(rfdi, void, env)
@@ -19,9 +19,9 @@ DEF_HELPER_1(rfmci, void, env)
 #if defined(TARGET_PPC64)
 DEF_HELPER_2(scv, noreturn, env, i32)
 DEF_HELPER_2(PMINSN, void, env, i32)
-DEF_HELPER_1(rfid, void, env)
-DEF_HELPER_1(rfscv, void, env)
-DEF_HELPER_1(hrfid, void, env)
+DEF_HELPER_1(RFID, void, env)
+DEF_HELPER_1(RFSCV, void, env)
+DEF_HELPER_1(HRFID, void, env)
 DEF_HELPER_2(rfebb, void, env, tl)
 DEF_HELPER_2(store_lpcr, void, env, tl)
 DEF_HELPER_2(store_pcr, void, env, tl)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 6e387c4988..b42375c364 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -199,6 +199,9 @@
 &X_rs_l         rs l:bool
 @X_rs_l         ...... rs:5 .... l:1 ..... .......... .         &X_rs_l
 
+&SC             lev:uint8_t
+@SC             ...... ..... ..... .... lev:7 ... . .           &SC
+
 &X_uim5         xt uim:uint8_t
 @X_uim5         ...... ..... ..... uim:5 .......... .           &X_uim5 xt=%x_xt
 
@@ -320,6 +323,14 @@ MFMSR           011111 ..... ----- ----- 0001010011 -   @X_t
 MTMSR           011111 ..... ---- . ----- 0010010010 -  @X_rs_l
 MTMSRD          011111 ..... ---- . ----- 0010110010 -  @X_rs_l
 
+### System Call and Return from Interrupt
+SC              010001 ----- ----- ---- ....... --- 1 -         @SC
+SCV             010001 ----- ----- ---- ....... --- 0 1         @SC
+RFI             010011 ----- ----- ----- 0000110010 -
+RFID            010011 ----- ----- ----- 0000010010 -
+RFSCV           010011 ----- ----- ----- 0001010010 -
+HRFID           010011 ----- ----- ----- 0100010010 -
+
 ### Fixed-Point Byte-Reverse Instructions
 BRW             011111 ..... ..... ----- 0010011011 -   @X_sa
 BRD             011111 ..... ..... ----- 0010111011 -   @X_sa
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index c5ccf7cf92..149a2fe745 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -527,13 +527,13 @@ static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
     check_tlb_flush(env, false);
 }
 
-void helper_rfi(CPUPPCState *env)
+void helper_RFI(CPUPPCState *env)
 {
     do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1] & 0xfffffffful);
 }
 
 #ifdef TARGET_PPC64
-void helper_rfid(CPUPPCState *env)
+void helper_RFID(CPUPPCState *env)
 {
     /*
      * The architecture defines a number of rules for which bits can
@@ -544,12 +544,12 @@ void helper_rfid(CPUPPCState *env)
     do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1]);
 }
 
-void helper_rfscv(CPUPPCState *env)
+void helper_RFSCV(CPUPPCState *env)
 {
     do_rfi(env, env->lr, env->ctr);
 }
 
-void helper_hrfid(CPUPPCState *env)
+void helper_HRFID(CPUPPCState *env)
 {
     do_rfi(env, env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
 }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index cf8fe54bd4..5dad1d970a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2681,110 +2681,6 @@ static inline void gen_setlr(DisasContext *ctx, target_ulong nip)
     tcg_gen_movi_tl(cpu_lr, nip);
 }
 
-/***                           System linkage                              ***/
-
-/* rfi (supervisor only) */
-static void gen_rfi(DisasContext *ctx)
-{
-#if defined(CONFIG_USER_ONLY)
-    GEN_PRIV(ctx);
-#else
-    /*
-     * This instruction doesn't exist anymore on 64-bit server
-     * processors compliant with arch 2.x
-     */
-    if (is_book3s_arch2x(ctx)) {
-        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
-        return;
-    }
-    /* Restore CPU state */
-    CHK_SV(ctx);
-    translator_io_start(&ctx->base);
-    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
-    gen_helper_rfi(tcg_env);
-    ctx->base.is_jmp = DISAS_EXIT;
-#endif
-}
-
-#if defined(TARGET_PPC64)
-static void gen_rfid(DisasContext *ctx)
-{
-#if defined(CONFIG_USER_ONLY)
-    GEN_PRIV(ctx);
-#else
-    /* Restore CPU state */
-    CHK_SV(ctx);
-    translator_io_start(&ctx->base);
-    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
-    gen_helper_rfid(tcg_env);
-    ctx->base.is_jmp = DISAS_EXIT;
-#endif
-}
-
-#if !defined(CONFIG_USER_ONLY)
-static void gen_rfscv(DisasContext *ctx)
-{
-#if defined(CONFIG_USER_ONLY)
-    GEN_PRIV(ctx);
-#else
-    /* Restore CPU state */
-    CHK_SV(ctx);
-    translator_io_start(&ctx->base);
-    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
-    gen_helper_rfscv(tcg_env);
-    ctx->base.is_jmp = DISAS_EXIT;
-#endif
-}
-#endif
-
-static void gen_hrfid(DisasContext *ctx)
-{
-#if defined(CONFIG_USER_ONLY)
-    GEN_PRIV(ctx);
-#else
-    /* Restore CPU state */
-    CHK_HV(ctx);
-    translator_io_start(&ctx->base);
-    gen_helper_hrfid(tcg_env);
-    ctx->base.is_jmp = DISAS_EXIT;
-#endif
-}
-#endif
-
-/* sc */
-#if defined(CONFIG_USER_ONLY)
-#define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL_USER
-#else
-#define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL
-#endif
-static void gen_sc(DisasContext *ctx)
-{
-    uint32_t lev;
-
-    /*
-     * LEV is a 7-bit field, but the top 6 bits are treated as a reserved
-     * field (i.e., ignored). ISA v3.1 changes that to 5 bits, but that is
-     * for Ultravisor which TCG does not support, so just ignore the top 6.
-     */
-    lev = (ctx->opcode >> 5) & 0x1;
-    gen_exception_err(ctx, POWERPC_SYSCALL, lev);
-}
-
-#if defined(TARGET_PPC64)
-#if !defined(CONFIG_USER_ONLY)
-static void gen_scv(DisasContext *ctx)
-{
-    uint32_t lev = (ctx->opcode >> 5) & 0x7F;
-
-    /* Set the PC back to the faulting instruction. */
-    gen_update_nip(ctx, ctx->cia);
-    gen_helper_scv(tcg_env, tcg_constant_i32(lev));
-
-    ctx->base.is_jmp = DISAS_NORETURN;
-}
-#endif
-#endif
-
 /***                                Trap                                   ***/
 
 /* Check for unconditional traps (always or never) */
@@ -4044,6 +3940,13 @@ static int64_t dw_compose_ea(DisasContext *ctx, int x)
         }                                               \
     } while (0)
 
+#define REQUIRE_INSNS_FLAGS_NOT(CTX, NAME) \
+    do {                                                \
+        if (((CTX)->insns_flags & PPC_##NAME) != 0) {   \
+            return false;                               \
+        }                                               \
+    } while (0)
+
 /* Then special-case the check for 64-bit so that we elide code for ppc32. */
 #if TARGET_LONG_BITS == 32
 # define REQUIRE_64BIT(CTX)  return false
@@ -4123,10 +4026,23 @@ static int64_t dw_compose_ea(DisasContext *ctx, int x)
         REQUIRE_INSNS_FLAGS2(ctx, FLAGS2);                     \
         return FUNC(ctx, a, ##__VA_ARGS__);                    \
     }
+#define TRANS_FLAGS_NOT(FLAGS, NAME, FUNC, ...) \
+    static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
+    {                                                          \
+        REQUIRE_INSNS_FLAGS_NOT(ctx, FLAGS);                   \
+        return FUNC(ctx, a, ##__VA_ARGS__);                    \
+    }
 
 #define TRANS64(NAME, FUNC, ...) \
     static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
     { REQUIRE_64BIT(ctx); return FUNC(ctx, a, ##__VA_ARGS__); }
+#define TRANS64_FLAGS(FLAGS, NAME, FUNC, ...) \
+    static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
+    {                                                          \
+        REQUIRE_64BIT(ctx);                                    \
+        REQUIRE_INSNS_FLAGS(ctx, FLAGS);                       \
+        return FUNC(ctx, a, ##__VA_ARGS__);                    \
+    }
 #define TRANS64_FLAGS2(FLAGS2, NAME, FUNC, ...) \
     static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
     {                                                          \
@@ -4568,21 +4484,6 @@ GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
 /* handles stfdp, stxsd, stxssp */
 GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
-/* ISA v3.0 changed the extended opcode from 62 to 30 */
-GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
-#if defined(TARGET_PPC64)
-GEN_HANDLER(rfid, 0x13, 0x12, 0x00, 0x03FF8001, PPC_64B),
-#if !defined(CONFIG_USER_ONLY)
-/* Top bit of opc2 corresponds with low bit of LEV, so use two handlers */
-GEN_HANDLER_E(scv, 0x11, 0x10, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(scv, 0x11, 0x00, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(rfscv, 0x13, 0x12, 0x02, 0x03FF8001, PPC_NONE, PPC2_ISA300),
-#endif
-GEN_HANDLER(hrfid, 0x13, 0x12, 0x08, 0x03FF8001, PPC_64H),
-#endif
-/* Top bit of opc2 corresponds with low bit of LEV, so use two handlers */
-GEN_HANDLER(sc, 0x11, 0x11, 0xFF, 0x03FFF01D, PPC_FLOW),
-GEN_HANDLER(sc, 0x11, 0x01, 0xFF, 0x03FFF01D, PPC_FLOW),
 GEN_HANDLER(mcrxr, 0x1F, 0x00, 0x10, 0x007FF801, PPC_MISC),
 GEN_HANDLER(mfspr, 0x1F, 0x13, 0x0A, 0x00000001, PPC_MISC),
 GEN_HANDLER(mftb, 0x1F, 0x13, 0x0B, 0x00000001, PPC_MFTB),
diff --git a/target/ppc/translate/misc-impl.c.inc b/target/ppc/translate/misc-impl.c.inc
index 54712f9b73..d41c82a998 100644
--- a/target/ppc/translate/misc-impl.c.inc
+++ b/target/ppc/translate/misc-impl.c.inc
@@ -225,3 +225,108 @@ static bool do_mtmsr(DisasContext *ctx, arg_X_rs_l *a, bool is_mtmsrd)
 
 TRANS_FLAGS(MISC, MTMSR, do_mtmsr, false)
 TRANS64(MTMSRD, do_mtmsr, true)
+
+/*
+ * System Call and Return from Interrupt Instructions
+ */
+
+static bool do_SC(DisasContext *ctx, arg_SC *a, uint32_t excp)
+{
+    uint32_t lev;
+
+    /*
+     * LEV is a 7-bit field, but the top 6 bits are treated as a reserved
+     * field (i.e., ignored). ISA v3.1 changes that to 5 bits, but that is
+     * for Ultravisor which TCG does not support, so just ignore the top 6.
+     */
+    lev = a->lev & 0x1;
+    gen_exception_err(ctx, excp, lev);
+    return true;
+}
+
+static bool do_SCV(DisasContext *ctx, arg_SC *a)
+{
+#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+    /* Set the PC back to the faulting instruction. */
+    gen_update_nip(ctx, ctx->cia);
+    gen_helper_scv(tcg_env, tcg_constant_i32(a->lev));
+
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+#else
+    gen_invalid(ctx);
+    return true;
+#endif
+}
+
+/*
+ * Common helper for return-from-interrupt instructions
+ */
+enum {
+    RFI = 0,
+    RFID = 1,
+    HRFID = 2,
+    RFSCV = 3,
+};
+
+static bool do_rfi(DisasContext *ctx, arg_RFID *a, int kind)
+{
+#if defined(CONFIG_USER_ONLY)
+    gen_priv_opc(ctx);
+    return true;
+#elif defined(TARGET_PPC64)
+    /* Privilege check */
+    switch (kind) {
+    case HRFID:
+        REQUIRE_HV(ctx);
+        break;
+    case RFI:
+    case RFID:
+    case RFSCV:
+        REQUIRE_SV(ctx);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    translator_io_start(&ctx->base);
+    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
+
+    switch (kind) {
+    case RFI:
+        gen_helper_RFI(tcg_env);
+        break;
+    case RFID:
+        gen_helper_RFID(tcg_env);
+        break;
+    case HRFID:
+        gen_helper_HRFID(tcg_env);
+        break;
+    case RFSCV:
+        gen_helper_RFSCV(tcg_env);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    ctx->base.is_jmp = DISAS_EXIT;
+    return true;
+#else
+    gen_invalid(ctx);
+    return true;
+#endif
+}
+
+#if defined(CONFIG_USER_ONLY)
+TRANS_FLAGS(FLOW, SC, do_SC, POWERPC_EXCP_SYSCALL_USER)
+#else
+TRANS_FLAGS(FLOW, SC, do_SC, POWERPC_EXCP_SYSCALL)
+#endif
+
+TRANS64_FLAGS2(ISA300, SCV, do_SCV)
+
+TRANS_FLAGS_NOT(SEGMENT_64B, RFI, do_rfi, RFI)
+TRANS64(RFID, do_rfi, RFID)
+TRANS64(HRFID, do_rfi, HRFID)
+TRANS64_FLAGS2(ISA300, RFSCV, do_rfi, RFSCV)
+
-- 
2.53.0


