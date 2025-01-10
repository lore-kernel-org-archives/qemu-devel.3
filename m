Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B06E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWFqH-00030L-L7; Fri, 10 Jan 2025 09:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFqF-0002xh-4y
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFqD-0005At-7B
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736518704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73J5AxObrHK1njsS/fTYzNNFMPH3GWXhxq0kyMI+1Tg=;
 b=ca6sbTN1RXF+zwGM/LNWxURdH4hSPwUueVg/U20wrPlbm4BYk3EU6BOH4vkwMi067332w0
 CHZMEE0RpRf5XSqGjpSWUp9Nco153q1VdpSywJmplvvQsXoCXNIROTJ4j08aMPMKLPN/A0
 WB6SdWOAgVRdXd7GWFf98D8OtPzgF9U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-E-qFjrlyPmmLlmF3m3oGZg-1; Fri,
 10 Jan 2025 09:18:20 -0500
X-MC-Unique: E-qFjrlyPmmLlmF3m3oGZg-1
X-Mimecast-MFC-AGG-ID: E-qFjrlyPmmLlmF3m3oGZg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B17911955D80; Fri, 10 Jan 2025 14:18:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.35])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3779195E3D9; Fri, 10 Jan 2025 14:18:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 5/9] ppc/ppc405: Remove 40x exception model
Date: Fri, 10 Jan 2025 15:17:56 +0100
Message-ID: <20250110141800.1587589-6-clg@redhat.com>
In-Reply-To: <20250110141800.1587589-1-clg@redhat.com>
References: <20250110141800.1587589-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This exception model was only used by the 405 CPU family which was
removed. The rest of the PPC 4xx CPUs use the BookE exception model.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 target/ppc/cpu.h         |   8 +--
 target/ppc/helper.h      |   1 -
 target/ppc/cpu_init.c    |  11 ----
 target/ppc/excp_helper.c | 116 ---------------------------------------
 target/ppc/translate.c   |  14 -----
 5 files changed, 1 insertion(+), 149 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2f3741860076..32423cfb7368 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -196,8 +196,6 @@ typedef enum powerpc_excp_t {
     POWERPC_EXCP_UNKNOWN   = 0,
     /* Standard PowerPC exception model */
     POWERPC_EXCP_STD,
-    /* PowerPC 40x exception model      */
-    POWERPC_EXCP_40x,
     /* PowerPC 603/604/G2 exception model */
     POWERPC_EXCP_6xx,
     /* PowerPC 7xx exception model      */
@@ -2206,9 +2204,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_403_TBL           (0x3DC)
 #define SPR_403_TBU           (0x3DD)
 #define SPR_SEBR              (0x3DE)
-#define SPR_40x_SRR2          (0x3DE)
 #define SPR_SER               (0x3DF)
-#define SPR_40x_SRR3          (0x3DF)
 #define SPR_L3OHCR            (0x3E8)
 #define SPR_L3ITCR1           (0x3E9)
 #define SPR_L3ITCR2           (0x3EA)
@@ -2405,8 +2401,6 @@ enum {
 
     /* Embedded PowerPC dedicated instructions                               */
     PPC_WRTEE          = 0x0001000000000000ULL,
-    /* PowerPC 40x exception model                                           */
-    PPC_40x_EXCP       = 0x0002000000000000ULL,
     /* PowerPC 405 Mac instructions                                          */
     PPC_405_MAC        = 0x0004000000000000ULL,
     /* PowerPC 440 specific instructions                                     */
@@ -2450,7 +2444,7 @@ enum {
                         | PPC_CACHE_DCBA | PPC_CACHE_LOCK \
                         | PPC_EXTERN | PPC_SEGMENT | PPC_6xx_TLB \
                         | PPC_40x_TLB | PPC_SEGMENT_64B \
-                        | PPC_SLBI | PPC_WRTEE | PPC_40x_EXCP \
+                        | PPC_SLBI | PPC_WRTEE \
                         | PPC_405_MAC | PPC_440_SPEC | PPC_BOOKE \
                         | PPC_MFAPIDI | PPC_TLBIVA | PPC_TLBIVAX \
                         | PPC_4xx_COMMON | PPC_40x_ICBT | PPC_RFMCI \
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 86f3bbc087f6..8272ceb5d7b1 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -12,7 +12,6 @@ DEF_HELPER_4(HASHCHKP, void, env, tl, tl, tl)
 DEF_HELPER_2(store_msr, void, env, tl)
 DEF_HELPER_1(ppc_maybe_interrupt, void, env)
 DEF_HELPER_1(rfi, void, env)
-DEF_HELPER_1(40x_rfci, void, env)
 DEF_HELPER_1(rfci, void, env)
 DEF_HELPER_1(rfdi, void, env)
 DEF_HELPER_1(rfmci, void, env)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index da92dce54624..14573d1d8b92 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7420,17 +7420,6 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
          * they can be read with "p $ivor0", "p $ivor1", etc.
          */
         break;
-    case POWERPC_EXCP_40x:
-        qemu_fprintf(f, "  TCR " TARGET_FMT_lx "   TSR " TARGET_FMT_lx
-                     "    ESR " TARGET_FMT_lx "   DEAR " TARGET_FMT_lx "\n",
-                     env->spr[SPR_40x_TCR], env->spr[SPR_40x_TSR],
-                     env->spr[SPR_40x_ESR], env->spr[SPR_40x_DEAR]);
-
-        qemu_fprintf(f, " EVPR " TARGET_FMT_lx "  SRR2 " TARGET_FMT_lx
-                     "   SRR3 " TARGET_FMT_lx  "   PID " TARGET_FMT_lx "\n",
-                     env->spr[SPR_40x_EVPR], env->spr[SPR_40x_SRR2],
-                     env->spr[SPR_40x_SRR3], env->spr[SPR_40x_PID]);
-        break;
     default:
         break;
     }
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index fde9912230e9..1a4c0ae5c0f0 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -473,114 +473,6 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
 #endif
 }
 
-static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
-{
-    CPUPPCState *env = &cpu->env;
-    target_ulong msr, new_msr, vector;
-    int srr0 = SPR_SRR0, srr1 = SPR_SRR1;
-
-    /* new srr1 value excluding must-be-zero bits */
-    msr = env->msr & ~0x783f0000ULL;
-
-    /* new interrupt handler msr preserves ME unless explicitly overridden */
-    new_msr = env->msr & (((target_ulong)1 << MSR_ME));
-
-    /* HV emu assistance interrupt only exists on server arch 2.05 or later */
-    if (excp == POWERPC_EXCP_HV_EMU) {
-        excp = POWERPC_EXCP_PROGRAM;
-    }
-
-    vector = env->excp_vectors[excp];
-    if (vector == (target_ulong)-1ULL) {
-        cpu_abort(env_cpu(env),
-                  "Raised an exception without defined vector %d\n", excp);
-    }
-    vector |= env->excp_prefix;
-
-    switch (excp) {
-    case POWERPC_EXCP_CRITICAL:    /* Critical input                         */
-        srr0 = SPR_40x_SRR2;
-        srr1 = SPR_40x_SRR3;
-        break;
-    case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
-        powerpc_mcheck_checkstop(env);
-        /* machine check exceptions don't have ME set */
-        new_msr &= ~((target_ulong)1 << MSR_ME);
-        srr0 = SPR_40x_SRR2;
-        srr1 = SPR_40x_SRR3;
-        break;
-    case POWERPC_EXCP_DSI:       /* Data storage exception                   */
-        trace_ppc_excp_dsi(env->spr[SPR_40x_ESR], env->spr[SPR_40x_DEAR]);
-        break;
-    case POWERPC_EXCP_ISI:       /* Instruction storage exception            */
-        trace_ppc_excp_isi(msr, env->nip);
-        break;
-    case POWERPC_EXCP_EXTERNAL:  /* External input                           */
-        break;
-    case POWERPC_EXCP_ALIGN:     /* Alignment exception                      */
-        break;
-    case POWERPC_EXCP_PROGRAM:   /* Program exception                        */
-        switch (env->error_code & ~0xF) {
-        case POWERPC_EXCP_FP:
-            if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
-                trace_ppc_excp_fp_ignore();
-                powerpc_reset_excp_state(cpu);
-                return;
-            }
-            env->spr[SPR_40x_ESR] = ESR_FP;
-            break;
-        case POWERPC_EXCP_INVAL:
-            trace_ppc_excp_inval(env->nip);
-            env->spr[SPR_40x_ESR] = ESR_PIL;
-            break;
-        case POWERPC_EXCP_PRIV:
-            env->spr[SPR_40x_ESR] = ESR_PPR;
-            break;
-        case POWERPC_EXCP_TRAP:
-            env->spr[SPR_40x_ESR] = ESR_PTR;
-            break;
-        default:
-            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
-                      env->error_code);
-            break;
-        }
-        break;
-    case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
-        dump_syscall(env);
-
-        /*
-         * We need to correct the NIP which in this case is supposed
-         * to point to the next instruction
-         */
-        env->nip += 4;
-        break;
-    case POWERPC_EXCP_FIT:       /* Fixed-interval timer interrupt           */
-        trace_ppc_excp_print("FIT");
-        break;
-    case POWERPC_EXCP_WDT:       /* Watchdog timer interrupt                 */
-        trace_ppc_excp_print("WDT");
-        break;
-    case POWERPC_EXCP_DTLB:      /* Data TLB error                           */
-    case POWERPC_EXCP_ITLB:      /* Instruction TLB error                    */
-        break;
-    case POWERPC_EXCP_PIT:       /* Programmable interval timer interrupt    */
-        trace_ppc_excp_print("PIT");
-        break;
-    case POWERPC_EXCP_DEBUG:     /* Debug interrupt                          */
-        cpu_abort(env_cpu(env), "%s exception not implemented\n",
-                  powerpc_excp_name(excp));
-        break;
-    default:
-        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
-                  excp);
-        break;
-    }
-
-    env->spr[srr0] = env->nip;
-    env->spr[srr1] = msr;
-    powerpc_set_excp_state(cpu, vector, new_msr);
-}
-
 static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
@@ -1635,9 +1527,6 @@ static void powerpc_excp(PowerPCCPU *cpu, int excp)
     env->excp_stats[excp]++;
 
     switch (env->excp_model) {
-    case POWERPC_EXCP_40x:
-        powerpc_excp_40x(cpu, excp);
-        break;
     case POWERPC_EXCP_6xx:
         powerpc_excp_6xx(cpu, excp);
         break;
@@ -2779,11 +2668,6 @@ void raise_ebb_perfm_exception(CPUPPCState *env)
 
 /*****************************************************************************/
 /* Embedded PowerPC specific helpers */
-void helper_40x_rfci(CPUPPCState *env)
-{
-    do_rfi(env, env->spr[SPR_40x_SRR2], env->spr[SPR_40x_SRR3]);
-}
-
 void helper_rfci(CPUPPCState *env)
 {
     do_rfi(env, env->spr[SPR_BOOKE_CSRR0], env->spr[SPR_BOOKE_CSRR1]);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 918bf8f3a0cc..0f19949897f4 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -5090,19 +5090,6 @@ static void gen_icread(DisasContext *ctx)
     /* interpreted as no-op */
 }
 
-/* rfci (supervisor only) */
-static void gen_rfci_40x(DisasContext *ctx)
-{
-#if defined(CONFIG_USER_ONLY)
-    GEN_PRIV(ctx);
-#else
-    CHK_SV(ctx);
-    /* Restore CPU state */
-    gen_helper_40x_rfci(tcg_env);
-    ctx->base.is_jmp = DISAS_EXIT;
-#endif /* defined(CONFIG_USER_ONLY) */
-}
-
 static void gen_rfci(DisasContext *ctx)
 {
 #if defined(CONFIG_USER_ONLY)
@@ -5924,7 +5911,6 @@ GEN_HANDLER(dcread, 0x1F, 0x06, 0x0F, 0x00000001, PPC_4xx_COMMON),
 GEN_HANDLER2(icbt_40x, "icbt", 0x1F, 0x06, 0x08, 0x03E00001, PPC_40x_ICBT),
 GEN_HANDLER(iccci, 0x1F, 0x06, 0x1E, 0x00000001, PPC_4xx_COMMON),
 GEN_HANDLER(icread, 0x1F, 0x06, 0x1F, 0x03E00001, PPC_4xx_COMMON),
-GEN_HANDLER2(rfci_40x, "rfci", 0x13, 0x13, 0x01, 0x03FF8001, PPC_40x_EXCP),
 GEN_HANDLER_E(rfci, 0x13, 0x13, 0x01, 0x03FF8001, PPC_BOOKE, PPC2_BOOKE206),
 GEN_HANDLER(rfdi, 0x13, 0x07, 0x01, 0x03FF8001, PPC_RFDI),
 GEN_HANDLER(rfmci, 0x13, 0x06, 0x01, 0x03FF8001, PPC_RFMCI),
-- 
2.47.1


