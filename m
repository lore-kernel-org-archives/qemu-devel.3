Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E78CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1pAi-0003vI-0Y; Thu, 25 Sep 2025 12:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1v1pAX-0003rv-EM; Thu, 25 Sep 2025 12:50:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1v1pAK-0007mD-Ln; Thu, 25 Sep 2025 12:50:09 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAiN0n016511;
 Thu, 25 Sep 2025 16:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vQyYmZ
 zT6vc365PAONBhYsu0j5EVZvanu7PHxkzOcjs=; b=UFLHUVtB0hu7V4odDOQjRq
 NGxv+VBhfAY2MvbQ6hSW/r/moZdRt8O3WLoEr+4+SkJB357r8dJYzqjQ+aQLK0IT
 mXl2dVDDQ+nK155gmohWfmcSmCNPW6kwQ7L7/6LRpt3eySLmecKqPJDmvwRgfL+/
 MaPmBnfz7W12M1xTnuEtUT+NfSFs6GT0GOC8Nio7SYrdwVr6NfvSaTjkdYtVwyRS
 +o8QtH5fio8FLz6ZwdNLbmgV2TzPKzNAWL0ghj7dfINItKk4PdduKeIv2UriNoZW
 caxbyGDYKpsr1QPMFB2dWDCFH+htb1xZ7I0chd0lfKAqKqzOjRILO2yb2ighDiSg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpqph4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 16:49:49 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PGnmnH032110;
 Thu, 25 Sep 2025 16:49:48 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpqph4v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 16:49:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PFsQDq008331;
 Thu, 25 Sep 2025 16:49:48 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a6yy74ht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 16:49:48 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PGnkDr33030666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 16:49:46 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BA035805A;
 Thu, 25 Sep 2025 16:49:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 608AE58054;
 Thu, 25 Sep 2025 16:49:43 +0000 (GMT)
Received: from [9.124.219.9] (unknown [9.124.219.9])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Sep 2025 16:49:43 +0000 (GMT)
Message-ID: <18f62b28-d4ea-4b7c-8e61-375520b6ecb9@linux.ibm.com>
Date: Thu, 25 Sep 2025 22:19:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] target/ppc: Add IBM PPE42 exception model
To: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, thuth@redhat.com, richard.henderson@linaro.org
References: <20250918182731.528944-1-milesg@linux.ibm.com>
 <20250918182731.528944-5-milesg@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20250918182731.528944-5-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FrEF/3rq c=1 sm=1 tr=0 ts=68d572ad cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=d5ZefqyIOgouv2tcOSQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rhzJUZKCD1qNTZEDuj2ylVGQiRbhpim-
X-Proofpoint-GUID: SbXAzKW_uEoABOMk_dshjtHqcMOHxHAO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNCBTYWx0ZWRfX8gMFKXwlIUIV
 kwPDJhH8zVvbIcZk5tBkzhfipm0K0olrgbYdbOXtPioHsjOCnegrtapXQpa/w5FM3xkUbMwxr/X
 FDnK1evPsQRjCFGOtnvpO01/QO56miQVMkWz+UbKvB/wIyT7nQq2bpq0kjdCtjgJKh6CTL7uYIA
 xfSRLMpbQRROe+0rodc7ss5hnMVzXbf5Uo1yorceUbYMl1CJIbJlIPlJ87HMX8rFvRar0SyLvRw
 GDggGebDIhsXx1UnvfOYU8RXrN0esWWG2TYYzJdSxPPKQGRbr2pVPo6yquIDrrCVJnarzhT24lB
 gqIf8neD+fdwQ8LKOQ3PI7KH+dL7CAQ5bJVYyS8hL6urZPsv5ziAM+HNG21vD11svboWxOI4tUx
 oGfL/u5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190224
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 9/18/25 23:57, Glenn Miles wrote:
> Add support for the IBM PPE42 exception model including
> new exception vectors, exception priorities and setting
> of PPE42 SPRs for determining the cause of an exception.
>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/cpu_init.c        |  39 ++++++++-
>   target/ppc/excp_helper.c     | 163 +++++++++++++++++++++++++++++++++++
>   target/ppc/tcg-excp_helper.c |  12 +++
>   3 files changed, 213 insertions(+), 1 deletion(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index b42673c6b5..097e3b3818 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -1720,6 +1720,30 @@ static void init_excp_4xx(CPUPPCState *env)
>   #endif
>   }
>   
> +static void init_excp_ppe42(CPUPPCState *env)
> +{
> +#if !defined(CONFIG_USER_ONLY)
> +    /* Machine Check vector changed after version 0 */
> +    if (((env->spr[SPR_PVR] & 0xf00000ul) >> 20) == 0) {
> +        env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000000;
> +    } else {
> +        env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000020;
> +    }
> +    env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000040;
> +    env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000060;
> +    env->excp_vectors[POWERPC_EXCP_ISI]      = 0x00000080;
> +    env->excp_vectors[POWERPC_EXCP_EXTERNAL] = 0x000000A0;
> +    env->excp_vectors[POWERPC_EXCP_ALIGN]    = 0x000000C0;
> +    env->excp_vectors[POWERPC_EXCP_PROGRAM]  = 0x000000E0;
> +    env->excp_vectors[POWERPC_EXCP_DECR]     = 0x00000100;
> +    env->excp_vectors[POWERPC_EXCP_FIT]      = 0x00000120;
> +    env->excp_vectors[POWERPC_EXCP_WDT]      = 0x00000140;
> +    env->ivpr_mask = 0xFFFFFE00UL;
> +    /* Hardware reset vector */
> +    env->hreset_vector = 0x00000040UL;
> +#endif
> +}
> +
>   static void init_excp_MPC5xx(CPUPPCState *env)
>   {
>   #if !defined(CONFIG_USER_ONLY)
> @@ -2245,6 +2269,7 @@ static void init_proc_ppe42(CPUPPCState *env)
>   {
>       register_ppe42_sprs(env);
>   
> +    init_excp_ppe42(env);
>       env->dcache_line_size = 32;
>       env->icache_line_size = 32;
>       /* Allocate hardware IRQ controller */
> @@ -2278,7 +2303,7 @@ static void ppe42_class_common_init(PowerPCCPUClass *pcc)
>                       (1ull << MSR_IPE) |
>                       R_MSR_SIBRCA_MASK;
>       pcc->mmu_model = POWERPC_MMU_REAL;
> -    pcc->excp_model = POWERPC_EXCP_40x;
> +    pcc->excp_model = POWERPC_EXCP_PPE42;
>       pcc->bus_model = PPC_FLAGS_INPUT_PPE42;
>       pcc->bfd_mach = bfd_mach_ppc_403;
>       pcc->flags = POWERPC_FLAG_PPE42 | POWERPC_FLAG_BUS_CLK;
> @@ -7855,6 +7880,18 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>            * they can be read with "p $ivor0", "p $ivor1", etc.
>            */
>           break;
> +    case POWERPC_EXCP_PPE42:
> +        qemu_fprintf(f, "SRR0 " TARGET_FMT_lx " SRR1 " TARGET_FMT_lx "\n",
> +                     env->spr[SPR_SRR0], env->spr[SPR_SRR1]);
> +
> +        qemu_fprintf(f, "  TCR " TARGET_FMT_lx "   TSR " TARGET_FMT_lx
> +                     "    ISR " TARGET_FMT_lx "   EDR " TARGET_FMT_lx "\n",
> +                     env->spr[SPR_PPE42_TCR], env->spr[SPR_PPE42_TSR],
> +                     env->spr[SPR_PPE42_ISR], env->spr[SPR_PPE42_EDR]);
> +
> +        qemu_fprintf(f, "  PIR " TARGET_FMT_lx "   IVPR " TARGET_FMT_lx "\n",
> +                     env->spr[SPR_PPE42_PIR], env->spr[SPR_PPE42_IVPR]);
> +        break;
>       case POWERPC_EXCP_40x:
>           qemu_fprintf(f, "  TCR " TARGET_FMT_lx "   TSR " TARGET_FMT_lx
>                        "    ESR " TARGET_FMT_lx "   DEAR " TARGET_FMT_lx "\n",
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 1efdc4066e..d8bca19fff 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -949,6 +949,125 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
>       powerpc_set_excp_state(cpu, vector, new_msr);
>   }
>   
> +static void powerpc_excp_ppe42(PowerPCCPU *cpu, int excp)
> +{
> +    CPUPPCState *env = &cpu->env;
> +    target_ulong msr, new_msr, vector;
> +    target_ulong mcs = PPE42_ISR_MCS_INSTRUCTION;
> +    bool promote_unmaskable;
> +
> +    msr = env->msr;
> +
> +    /*
> +     * New interrupt handler msr preserves SIBRC and ME unless explicitly
> +     * overridden by the exception.  All other MSR bits are zeroed out.
> +     */
> +    new_msr = env->msr & (((target_ulong)1 << MSR_ME) | R_MSR_SIBRC_MASK);
> +
> +    /* HV emu assistance interrupt only exists on server arch 2.05 or later */
> +    if (excp == POWERPC_EXCP_HV_EMU) {
> +        excp = POWERPC_EXCP_PROGRAM;
> +    }
> +
> +    /*
> +     * Unmaskable interrupts (Program, ISI, Alignment and DSI) are promoted to
> +     * machine check if MSR_UIE is 0.
> +     */
> +    promote_unmaskable = !(msr & ((target_ulong)1 << MSR_UIE));
> +
> +
> +    switch (excp) {
> +    case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
> +        break;
> +    case POWERPC_EXCP_DSI:       /* Data storage exception                   */
> +        trace_ppc_excp_dsi(env->spr[SPR_PPE42_ISR], env->spr[SPR_PPE42_EDR]);
> +        if (promote_unmaskable) {
> +            excp = POWERPC_EXCP_MCHECK;
> +            mcs = PPE42_ISR_MCS_DSI;
> +        }
> +        break;
> +    case POWERPC_EXCP_ISI:       /* Instruction storage exception            */
> +        trace_ppc_excp_isi(msr, env->nip);
> +        if (promote_unmaskable) {
> +            excp = POWERPC_EXCP_MCHECK;
> +            mcs = PPE42_ISR_MCS_ISI;
> +        }
> +        break;
> +    case POWERPC_EXCP_EXTERNAL:  /* External input                           */
> +        break;
> +    case POWERPC_EXCP_ALIGN:     /* Alignment exception                      */
> +        if (promote_unmaskable) {
> +            excp = POWERPC_EXCP_MCHECK;
> +            mcs = PPE42_ISR_MCS_ALIGNMENT;
> +        }
> +        break;
> +    case POWERPC_EXCP_PROGRAM:   /* Program exception                        */
> +        if (promote_unmaskable) {
> +            excp = POWERPC_EXCP_MCHECK;
> +            mcs = PPE42_ISR_MCS_PROGRAM;
> +        }
> +        switch (env->error_code & ~0xF) {
> +        case POWERPC_EXCP_INVAL:
> +            trace_ppc_excp_inval(env->nip);
> +            env->spr[SPR_PPE42_ISR] &= ~((target_ulong)1 << PPE42_ISR_PTR);
> +            break;
> +        case POWERPC_EXCP_TRAP:
> +            env->spr[SPR_PPE42_ISR] |= ((target_ulong)1 << PPE42_ISR_PTR);
> +            break;
> +        default:
> +            /* Should never occur */
> +            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
> +                      env->error_code);
> +            break;
> +        }
> +#ifdef CONFIG_TCG
> +        env->spr[SPR_PPE42_EDR] = ppc_ldl_code(env, env->nip);
> +#endif
> +        break;
> +    case POWERPC_EXCP_DECR:      /* Decrementer exception                    */
> +        break;
> +    case POWERPC_EXCP_FIT:       /* Fixed-interval timer interrupt           */
> +        trace_ppc_excp_print("FIT");
> +        break;
> +    case POWERPC_EXCP_WDT:       /* Watchdog timer interrupt                 */
> +        trace_ppc_excp_print("WDT");
> +        break;
> +    case POWERPC_EXCP_RESET:     /* System reset exception                   */
> +        /* reset exceptions don't have ME set */
> +        new_msr &= ~((target_ulong)1 << MSR_ME);
> +        break;
> +    default:
> +        cpu_abort(env_cpu(env), "Invalid PPE42 exception %d. Aborting\n",
> +                  excp);
> +        break;
> +    }
> +
> +    env->spr[SPR_SRR0] = env->nip;
> +    env->spr[SPR_SRR1] = msr;
> +
> +    vector = env->excp_vectors[excp];
> +    if (vector == (target_ulong)-1ULL) {
> +        cpu_abort(env_cpu(env),
> +                  "Raised an exception without defined vector %d\n", excp);
> +    }
> +    vector |= env->spr[SPR_PPE42_IVPR];
> +
> +    if (excp == POWERPC_EXCP_MCHECK) {
> +        /* Also set the Machine Check Status (MCS) */
> +        env->spr[SPR_PPE42_ISR] &= ~R_PPE42_ISR_MCS_MASK;
> +        env->spr[SPR_PPE42_ISR] |= (mcs & R_PPE42_ISR_MCS_MASK);
> +        env->spr[SPR_PPE42_ISR] &= ~((target_ulong)1 << PPE42_ISR_MFE);
> +
> +        /* Machine checks halt execution if MSR_ME is 0 */
> +        powerpc_mcheck_checkstop(env);
> +
> +        /* machine check exceptions don't have ME set */
> +        new_msr &= ~((target_ulong)1 << MSR_ME);
> +    }
> +
> +    powerpc_set_excp_state(cpu, vector, new_msr);
> +}
> +
>   static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
>   {
>       CPUPPCState *env = &cpu->env;
> @@ -1589,6 +1708,9 @@ void powerpc_excp(PowerPCCPU *cpu, int excp)
>       case POWERPC_EXCP_POWER11:
>           powerpc_excp_books(cpu, excp);
>           break;
> +    case POWERPC_EXCP_PPE42:
> +        powerpc_excp_ppe42(cpu, excp);
> +        break;
>       default:
>           g_assert_not_reached();
>       }
> @@ -1945,6 +2067,43 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
>   }
>   #endif /* TARGET_PPC64 */
>   
> +static int ppe42_next_unmasked_interrupt(CPUPPCState *env)
> +{
> +    bool async_deliver;
> +
> +    /* External reset */
> +    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
> +        return PPC_INTERRUPT_RESET;
> +    }
> +    /* Machine check exception */
> +    if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
> +        return PPC_INTERRUPT_MCK;
> +    }
> +
> +    async_deliver = FIELD_EX64(env->msr, MSR, EE);
> +
> +    if (async_deliver != 0) {
> +        /* Watchdog timer */
> +        if (env->pending_interrupts & PPC_INTERRUPT_WDT) {
> +            return PPC_INTERRUPT_WDT;
> +        }
> +        /* External Interrupt */
> +        if (env->pending_interrupts & PPC_INTERRUPT_EXT) {
> +            return PPC_INTERRUPT_EXT;
> +        }
> +        /* Fixed interval timer */
> +        if (env->pending_interrupts & PPC_INTERRUPT_FIT) {
> +            return PPC_INTERRUPT_FIT;
> +        }
> +        /* Decrementer exception */
> +        if (env->pending_interrupts & PPC_INTERRUPT_DECR) {
> +            return PPC_INTERRUPT_DECR;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>   static int ppc_next_unmasked_interrupt(CPUPPCState *env)
>   {
>       uint32_t pending_interrupts = env->pending_interrupts;
> @@ -1970,6 +2129,10 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
>       }
>   #endif
>   
> +    if (env->excp_model == POWERPC_EXCP_PPE42) {
> +        return ppe42_next_unmasked_interrupt(env);
> +    }
> +
>       /* External reset */
>       if (pending_interrupts & PPC_INTERRUPT_RESET) {
>           return PPC_INTERRUPT_RESET;
> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
> index f835be5156..edecfb8572 100644
> --- a/target/ppc/tcg-excp_helper.c
> +++ b/target/ppc/tcg-excp_helper.c
> @@ -229,6 +229,18 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>       case POWERPC_MMU_BOOKE206:
>           env->spr[SPR_BOOKE_DEAR] = vaddr;
>           break;
> +    case POWERPC_MMU_REAL:
> +        if (env->flags & POWERPC_FLAG_PPE42) {
> +            env->spr[SPR_PPE42_EDR] = vaddr;
> +            if (access_type == MMU_DATA_STORE) {
> +                env->spr[SPR_PPE42_ISR] |= PPE42_ISR_ST;
> +            } else {
> +                env->spr[SPR_PPE42_ISR] &= ~PPE42_ISR_ST;
> +            }
> +        } else {
> +            env->spr[SPR_DAR] = vaddr;
> +        }
> +        break;
>       default:
>           env->spr[SPR_DAR] = vaddr;
>           break;

