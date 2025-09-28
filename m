Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF90ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3R-0002vH-8j; Sun, 28 Sep 2025 15:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3D-0002iU-4T
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x32-00044e-7J
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:14 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SJCS9Q013138
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ax/hEyEH/4P6/UWQI
 OTzX0hmZbGRxaaN6SpwGUuv0Yc=; b=N6RCiuXQjM2jWrxO/FJtk7I+wiqTh+qon
 +TSzR2YWeau6SmKspV7XivIBeLQ/OR9gvH5BOe3nR3cZneZxrMSLy78OXkXreXtT
 xzZRmon+qs6kfrZTvh5dTcSt0U6B1CbnpXehUWxQWkSviryqXm/JjET64vKS1BPz
 n2vdlrAK9b2t+YSfAFUXc/PY/WTmDSoJSFiFaYQliTe3WSFPEzEUqOO9brfZsO9I
 MVkG3b4hnFHuyEqRUqPksOqarR2aaY5ycQZ8HMPvBczlG0Yx3CNJ7v7poPKrSmn+
 uBPPsE2V5w2A21rzF5CpeAbgRd6Yam0hDNUOvps2a5KAJsRMu+GGg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n7en0k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SEpQso024163
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evy0thnn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:59 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJQtpP18219454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:26:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7188920049;
 Sun, 28 Sep 2025 19:26:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6ECC220040;
 Sun, 28 Sep 2025 19:26:54 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:26:54 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 12/27] target/ppc: Add IBM PPE42 exception model
Date: Mon, 29 Sep 2025 00:56:14 +0530
Message-ID: <20250928192629.139822-13-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TDEPeT2OJuJuVzOswsiTiMnGiqGMGJYh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX9a7XYb751fkE
 JBcmD1zlWX6wuVdN6zUMTTyTBIYInq5MkO67zt4AZ7VvAbtvTE0LPwUQsja58HjrUb6E9poNint
 B1RoOV4unotZ2zh7aJys8yNOjTdg8olYQjuAxilhcbfAFR0i3O1qGyuuZHaf5KjrOYxy4ueibPd
 gRsVIR5tuZk4MUbzm9SODLsUfV1BsjmUKVQG3evOKuiUC7iwFb87OSTA9lRk2BWqX6luCmCug96
 GtL0H2BTb6YtH6dmjAXA61ZmVifNE5YdxEWczqhQkZ961eTU9CYNd/sBEoBUULDZ+nZjVEddVFS
 A8bBYgcdcB0pRRNs9u14RLofdbB4tXRFQiQZjCpNhiqBmfdRrHY2NxisQINBL1xzvx0I57HPgMD
 Y14Cpv/M08G56Oc+jtTfZ5t1zKZ1ew==
X-Proofpoint-GUID: TDEPeT2OJuJuVzOswsiTiMnGiqGMGJYh
X-Authority-Analysis: v=2.4 cv=T7qBjvKQ c=1 sm=1 tr=0 ts=68d98c04 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Z0Nuhz_ocfBNBuMbwawA:9 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.ibm.com>

Add support for the IBM PPE42 exception model including
new exception vectors, exception priorities and setting
of PPE42 SPRs for determining the cause of an exception.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250925201758.652077-5-milesg@linux.ibm.com
Message-ID: <20250925201758.652077-5-milesg@linux.ibm.com>
---
 target/ppc/cpu_init.c        |  39 ++++++++-
 target/ppc/excp_helper.c     | 163 +++++++++++++++++++++++++++++++++++
 target/ppc/tcg-excp_helper.c |  12 +++
 3 files changed, 213 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c78b255085..9e4ea8fd13 100644
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
@@ -7856,6 +7881,18 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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
2.43.5


