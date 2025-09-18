Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302B0CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 18:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzJNc-0007Rg-Na; Thu, 18 Sep 2025 14:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uzJNB-0007Jh-3S; Thu, 18 Sep 2025 14:28:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uzJN0-0006TP-NK; Thu, 18 Sep 2025 14:28:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ID9Jq6027573;
 Thu, 18 Sep 2025 18:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4qG1+0S4P3ELuxmD7
 o2NOvTNsM5fkJkYjQbKseluy9E=; b=s+ZY1VLW76t8nyajY5ufxX891vrL4ByHq
 BqJqKGHjYj2zQyiD2AjXmsk8fiAjiQq/uO66Tb2dwV7hScdfw/Bu7+gbdwW5vipU
 ZZ+NQw9erzqHwhcvq7PYmFUv8TqwdlPJxmgI94Z4B29HvrRdygSOQEsEP4dCUI0t
 qy5sGrqKNli2eJUwGdCDczW7cDqIdcg9GLc8DNKcfGUb3MozwEy9bBgrSmFYZF/+
 kfNW3WTG69XDpy0ftzuOtAoV5PG5aEGQz/WsjmkmV61gsnD3tZYF7Q0IAf1NqT8X
 2L1tan5OoaE6jG9N5SQFN7NnOUUnbrSlQ9GYvx1qGdXO9RTRamlnw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pc77y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 18:28:19 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IISIXh008158;
 Thu, 18 Sep 2025 18:28:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pc77u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 18:28:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IHkCjs022290;
 Thu, 18 Sep 2025 18:28:17 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxq07x2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 18:28:17 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58IISGdh59113742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 18:28:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 154C85805C;
 Thu, 18 Sep 2025 18:28:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49D585805E;
 Thu, 18 Sep 2025 18:28:15 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Sep 2025 18:28:15 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v5 4/9] target/ppc: Add IBM PPE42 exception model
Date: Thu, 18 Sep 2025 13:27:11 -0500
Message-ID: <20250918182731.528944-5-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918182731.528944-1-milesg@linux.ibm.com>
References: <20250918182731.528944-1-milesg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX4BGJ3tvjW3L9
 nHBT0CoxKqaTaZxXIsR00lmCOEltramZ8XAgbhTe22GgWOgb/8N754zfpFRXdvks1yenX9j1WOr
 rMiG8dbGWXizoBQugx0Y3970FqdTjxuSxa2a+tPZ5UfbB2yGLeA5y9qaAOwzVcOhAd7q6SLBkSd
 bTrNoyQtvhvwpqW8kvjsN9dQzA024VpJfOTmJcMKFAEFUVjhKNMQM3f3ubIi/+rGLHHvEJsKSrc
 zlHKV1BwOqf6DBbRfp+7cETymftlOfbM8emN4vhvWoyjFYOp2BQR1OVxRMCVpozeAkdGIyKfuoq
 99vbF62P/m1EBx4fIot++QrNaF1k6etQcp0tgcYULyN9e1tQQDAwpfudSUpr8isWWOL9il+9SQt
 sY8Uyeqc
X-Proofpoint-ORIG-GUID: JyDeQMvJdKmSd9N7FNf_XUtEj9-93GE4
X-Proofpoint-GUID: qfSVExOdOdpS3pYJZYOOdtHW_yQiNlJS
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cc4f43 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=h1b_CP1ddBs6gX6iP-IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add support for the IBM PPE42 exception model including
new exception vectors, exception priorities and setting
of PPE42 SPRs for determining the cause of an exception.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 target/ppc/cpu_init.c        |  39 ++++++++-
 target/ppc/excp_helper.c     | 163 +++++++++++++++++++++++++++++++++++
 target/ppc/tcg-excp_helper.c |  12 +++
 3 files changed, 213 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b42673c6b5..097e3b3818 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -1720,6 +1720,30 @@ static void init_excp_4xx(CPUPPCState *env)
 #endif
 }
 
+static void init_excp_ppe42(CPUPPCState *env)
+{
+#if !defined(CONFIG_USER_ONLY)
+    /* Machine Check vector changed after version 0 */
+    if (((env->spr[SPR_PVR] & 0xf00000ul) >> 20) == 0) {
+        env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000000;
+    } else {
+        env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000020;
+    }
+    env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000040;
+    env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000060;
+    env->excp_vectors[POWERPC_EXCP_ISI]      = 0x00000080;
+    env->excp_vectors[POWERPC_EXCP_EXTERNAL] = 0x000000A0;
+    env->excp_vectors[POWERPC_EXCP_ALIGN]    = 0x000000C0;
+    env->excp_vectors[POWERPC_EXCP_PROGRAM]  = 0x000000E0;
+    env->excp_vectors[POWERPC_EXCP_DECR]     = 0x00000100;
+    env->excp_vectors[POWERPC_EXCP_FIT]      = 0x00000120;
+    env->excp_vectors[POWERPC_EXCP_WDT]      = 0x00000140;
+    env->ivpr_mask = 0xFFFFFE00UL;
+    /* Hardware reset vector */
+    env->hreset_vector = 0x00000040UL;
+#endif
+}
+
 static void init_excp_MPC5xx(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -2245,6 +2269,7 @@ static void init_proc_ppe42(CPUPPCState *env)
 {
     register_ppe42_sprs(env);
 
+    init_excp_ppe42(env);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
     /* Allocate hardware IRQ controller */
@@ -2278,7 +2303,7 @@ static void ppe42_class_common_init(PowerPCCPUClass *pcc)
                     (1ull << MSR_IPE) |
                     R_MSR_SIBRCA_MASK;
     pcc->mmu_model = POWERPC_MMU_REAL;
-    pcc->excp_model = POWERPC_EXCP_40x;
+    pcc->excp_model = POWERPC_EXCP_PPE42;
     pcc->bus_model = PPC_FLAGS_INPUT_PPE42;
     pcc->bfd_mach = bfd_mach_ppc_403;
     pcc->flags = POWERPC_FLAG_PPE42 | POWERPC_FLAG_BUS_CLK;
@@ -7855,6 +7880,18 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
          * they can be read with "p $ivor0", "p $ivor1", etc.
          */
         break;
+    case POWERPC_EXCP_PPE42:
+        qemu_fprintf(f, "SRR0 " TARGET_FMT_lx " SRR1 " TARGET_FMT_lx "\n",
+                     env->spr[SPR_SRR0], env->spr[SPR_SRR1]);
+
+        qemu_fprintf(f, "  TCR " TARGET_FMT_lx "   TSR " TARGET_FMT_lx
+                     "    ISR " TARGET_FMT_lx "   EDR " TARGET_FMT_lx "\n",
+                     env->spr[SPR_PPE42_TCR], env->spr[SPR_PPE42_TSR],
+                     env->spr[SPR_PPE42_ISR], env->spr[SPR_PPE42_EDR]);
+
+        qemu_fprintf(f, "  PIR " TARGET_FMT_lx "   IVPR " TARGET_FMT_lx "\n",
+                     env->spr[SPR_PPE42_PIR], env->spr[SPR_PPE42_IVPR]);
+        break;
     case POWERPC_EXCP_40x:
         qemu_fprintf(f, "  TCR " TARGET_FMT_lx "   TSR " TARGET_FMT_lx
                      "    ESR " TARGET_FMT_lx "   DEAR " TARGET_FMT_lx "\n",
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 1efdc4066e..d8bca19fff 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -949,6 +949,125 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     powerpc_set_excp_state(cpu, vector, new_msr);
 }
 
+static void powerpc_excp_ppe42(PowerPCCPU *cpu, int excp)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong msr, new_msr, vector;
+    target_ulong mcs = PPE42_ISR_MCS_INSTRUCTION;
+    bool promote_unmaskable;
+
+    msr = env->msr;
+
+    /*
+     * New interrupt handler msr preserves SIBRC and ME unless explicitly
+     * overridden by the exception.  All other MSR bits are zeroed out.
+     */
+    new_msr = env->msr & (((target_ulong)1 << MSR_ME) | R_MSR_SIBRC_MASK);
+
+    /* HV emu assistance interrupt only exists on server arch 2.05 or later */
+    if (excp == POWERPC_EXCP_HV_EMU) {
+        excp = POWERPC_EXCP_PROGRAM;
+    }
+
+    /*
+     * Unmaskable interrupts (Program, ISI, Alignment and DSI) are promoted to
+     * machine check if MSR_UIE is 0.
+     */
+    promote_unmaskable = !(msr & ((target_ulong)1 << MSR_UIE));
+
+
+    switch (excp) {
+    case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
+        break;
+    case POWERPC_EXCP_DSI:       /* Data storage exception                   */
+        trace_ppc_excp_dsi(env->spr[SPR_PPE42_ISR], env->spr[SPR_PPE42_EDR]);
+        if (promote_unmaskable) {
+            excp = POWERPC_EXCP_MCHECK;
+            mcs = PPE42_ISR_MCS_DSI;
+        }
+        break;
+    case POWERPC_EXCP_ISI:       /* Instruction storage exception            */
+        trace_ppc_excp_isi(msr, env->nip);
+        if (promote_unmaskable) {
+            excp = POWERPC_EXCP_MCHECK;
+            mcs = PPE42_ISR_MCS_ISI;
+        }
+        break;
+    case POWERPC_EXCP_EXTERNAL:  /* External input                           */
+        break;
+    case POWERPC_EXCP_ALIGN:     /* Alignment exception                      */
+        if (promote_unmaskable) {
+            excp = POWERPC_EXCP_MCHECK;
+            mcs = PPE42_ISR_MCS_ALIGNMENT;
+        }
+        break;
+    case POWERPC_EXCP_PROGRAM:   /* Program exception                        */
+        if (promote_unmaskable) {
+            excp = POWERPC_EXCP_MCHECK;
+            mcs = PPE42_ISR_MCS_PROGRAM;
+        }
+        switch (env->error_code & ~0xF) {
+        case POWERPC_EXCP_INVAL:
+            trace_ppc_excp_inval(env->nip);
+            env->spr[SPR_PPE42_ISR] &= ~((target_ulong)1 << PPE42_ISR_PTR);
+            break;
+        case POWERPC_EXCP_TRAP:
+            env->spr[SPR_PPE42_ISR] |= ((target_ulong)1 << PPE42_ISR_PTR);
+            break;
+        default:
+            /* Should never occur */
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
+                      env->error_code);
+            break;
+        }
+#ifdef CONFIG_TCG
+        env->spr[SPR_PPE42_EDR] = ppc_ldl_code(env, env->nip);
+#endif
+        break;
+    case POWERPC_EXCP_DECR:      /* Decrementer exception                    */
+        break;
+    case POWERPC_EXCP_FIT:       /* Fixed-interval timer interrupt           */
+        trace_ppc_excp_print("FIT");
+        break;
+    case POWERPC_EXCP_WDT:       /* Watchdog timer interrupt                 */
+        trace_ppc_excp_print("WDT");
+        break;
+    case POWERPC_EXCP_RESET:     /* System reset exception                   */
+        /* reset exceptions don't have ME set */
+        new_msr &= ~((target_ulong)1 << MSR_ME);
+        break;
+    default:
+        cpu_abort(env_cpu(env), "Invalid PPE42 exception %d. Aborting\n",
+                  excp);
+        break;
+    }
+
+    env->spr[SPR_SRR0] = env->nip;
+    env->spr[SPR_SRR1] = msr;
+
+    vector = env->excp_vectors[excp];
+    if (vector == (target_ulong)-1ULL) {
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
+    }
+    vector |= env->spr[SPR_PPE42_IVPR];
+
+    if (excp == POWERPC_EXCP_MCHECK) {
+        /* Also set the Machine Check Status (MCS) */
+        env->spr[SPR_PPE42_ISR] &= ~R_PPE42_ISR_MCS_MASK;
+        env->spr[SPR_PPE42_ISR] |= (mcs & R_PPE42_ISR_MCS_MASK);
+        env->spr[SPR_PPE42_ISR] &= ~((target_ulong)1 << PPE42_ISR_MFE);
+
+        /* Machine checks halt execution if MSR_ME is 0 */
+        powerpc_mcheck_checkstop(env);
+
+        /* machine check exceptions don't have ME set */
+        new_msr &= ~((target_ulong)1 << MSR_ME);
+    }
+
+    powerpc_set_excp_state(cpu, vector, new_msr);
+}
+
 static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
@@ -1589,6 +1708,9 @@ void powerpc_excp(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_POWER11:
         powerpc_excp_books(cpu, excp);
         break;
+    case POWERPC_EXCP_PPE42:
+        powerpc_excp_ppe42(cpu, excp);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -1945,6 +2067,43 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
 }
 #endif /* TARGET_PPC64 */
 
+static int ppe42_next_unmasked_interrupt(CPUPPCState *env)
+{
+    bool async_deliver;
+
+    /* External reset */
+    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
+        return PPC_INTERRUPT_RESET;
+    }
+    /* Machine check exception */
+    if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
+        return PPC_INTERRUPT_MCK;
+    }
+
+    async_deliver = FIELD_EX64(env->msr, MSR, EE);
+
+    if (async_deliver != 0) {
+        /* Watchdog timer */
+        if (env->pending_interrupts & PPC_INTERRUPT_WDT) {
+            return PPC_INTERRUPT_WDT;
+        }
+        /* External Interrupt */
+        if (env->pending_interrupts & PPC_INTERRUPT_EXT) {
+            return PPC_INTERRUPT_EXT;
+        }
+        /* Fixed interval timer */
+        if (env->pending_interrupts & PPC_INTERRUPT_FIT) {
+            return PPC_INTERRUPT_FIT;
+        }
+        /* Decrementer exception */
+        if (env->pending_interrupts & PPC_INTERRUPT_DECR) {
+            return PPC_INTERRUPT_DECR;
+        }
+    }
+
+    return 0;
+}
+
 static int ppc_next_unmasked_interrupt(CPUPPCState *env)
 {
     uint32_t pending_interrupts = env->pending_interrupts;
@@ -1970,6 +2129,10 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
     }
 #endif
 
+    if (env->excp_model == POWERPC_EXCP_PPE42) {
+        return ppe42_next_unmasked_interrupt(env);
+    }
+
     /* External reset */
     if (pending_interrupts & PPC_INTERRUPT_RESET) {
         return PPC_INTERRUPT_RESET;
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index f835be5156..edecfb8572 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -229,6 +229,18 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     case POWERPC_MMU_BOOKE206:
         env->spr[SPR_BOOKE_DEAR] = vaddr;
         break;
+    case POWERPC_MMU_REAL:
+        if (env->flags & POWERPC_FLAG_PPE42) {
+            env->spr[SPR_PPE42_EDR] = vaddr;
+            if (access_type == MMU_DATA_STORE) {
+                env->spr[SPR_PPE42_ISR] |= PPE42_ISR_ST;
+            } else {
+                env->spr[SPR_PPE42_ISR] &= ~PPE42_ISR_ST;
+            }
+        } else {
+            env->spr[SPR_DAR] = vaddr;
+        }
+        break;
     default:
         env->spr[SPR_DAR] = vaddr;
         break;
-- 
2.43.0


