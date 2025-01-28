Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332BEC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 11:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcjQ8-00076p-9e; Tue, 28 Jan 2025 06:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tcjQ2-00076G-KR; Tue, 28 Jan 2025 06:06:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tcjPz-00019b-HZ; Tue, 28 Jan 2025 06:06:09 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RLISFd009873;
 Tue, 28 Jan 2025 11:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2wgAdB
 GR15oDj8Db1fqS8W/zK0Z5aGTeB/5YxjCcjLo=; b=dWrdVaIV/+hNtdT0BL5qus
 KJ5Jy9Q2R5pX54GdYq9RCSRQGSZQ4669jt2UuGQp3UlrQ7+tkvsX4xUyka01YDd4
 I+IBdeLqzr2n7KrjB7cYNO3HwF8C3dgw1q0Ekuq5PFCTKiCp4E553AcMoH+G4wTc
 9cK7v222UVtIj+r4XyWPR9n1hAt9G7J+/0WnyscKXv11qfMIPTDzqxrXoQZlUTzj
 m/FFgVY8351LsrifCgak08bcjmeXIwy0VsqnDm7+TCHAqZnqL0xt0q0HUje9SOVV
 9Ljq3CWjdFhksxix2fEws0VwWZcFld9ic/Fah1FuExgMT84kJ42l8EbVuH8a/2ww
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdycw7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 11:06:04 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50SB633J022473;
 Tue, 28 Jan 2025 11:06:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdycw76-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 11:06:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50S88cfJ012444;
 Tue, 28 Jan 2025 11:06:02 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dany32vu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 11:06:02 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50SB61oU30212614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 11:06:01 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 731AE58133;
 Tue, 28 Jan 2025 11:06:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54A1A58132;
 Tue, 28 Jan 2025 11:05:59 +0000 (GMT)
Received: from [9.124.214.156] (unknown [9.124.214.156])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jan 2025 11:05:59 +0000 (GMT)
Message-ID: <6345e260-8478-4e9e-8377-cb51ed5a0a26@linux.ibm.com>
Date: Tue, 28 Jan 2025 16:35:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] target/ppc: Restrict ppc_tcg_hv_emu() to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-11-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250127102620.39159-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6vMgDDGxg1g-lCG3bzC-aUA8xSZX4uhe
X-Proofpoint-ORIG-GUID: _XbSVVvjLAV5wRw7oAwc0nyYfb6HTQrU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=725 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280085
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 1/27/25 15:56, Philippe Mathieu-Daudé wrote:
> Make is_prefix_insn_excp() prototype but have it guarded by
> a tcg_enabled() check. Inline part of it in powerpc_excp_books().
> 
> Extract POWERPC_EXCP_HV_EMU handling code to ppc_tcg_hv_emu(),
> also exposing its prototype in "internal.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/internal.h        |   6 +++
>   target/ppc/excp_helper.c     | 101 +++++------------------------------
>   target/ppc/tcg-excp_helper.c |  75 ++++++++++++++++++++++++++
>   3 files changed, 93 insertions(+), 89 deletions(-)
> 
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 62186bc1e61..0e66b29ec68 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -291,6 +291,12 @@ bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
>   bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
>   
>   G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason);
> +
> +#if defined(TARGET_PPC64)
> +bool is_prefix_insn_excp(CPUPPCState *env, int excp);
> +void ppc_tcg_hv_emu(CPUPPCState *env, target_ulong *new_msr,
> +                    int *srr0, int *srr1);
> +#endif /* TARGET_PPC64 */
>   #endif /* !CONFIG_USER_ONLY */
>   
>   FIELD(GER_MSK, XMSK, 0, 4)
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 6a12402b23a..56a56148a40 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -19,6 +19,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/log.h"
> +#include "system/kvm.h"
>   #include "system/tcg.h"
>   #include "system/system.h"
>   #include "system/runstate.h"
> @@ -1194,81 +1195,6 @@ static bool books_vhyp_handles_hv_excp(PowerPCCPU *cpu)
>       return false;
>   }
>   
> -#ifdef CONFIG_TCG
> -static bool is_prefix_insn(CPUPPCState *env, uint32_t insn)
> -{
> -    if (!(env->insns_flags2 & PPC2_ISA310)) {
> -        return false;
> -    }
> -    return ((insn & 0xfc000000) == 0x04000000);
> -}
> -
> -static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
> -{
> -    CPUPPCState *env = &cpu->env;
> -
> -    if (!(env->insns_flags2 & PPC2_ISA310)) {
> -        return false;
> -    }
> -
> -    if (!tcg_enabled()) {
> -        /*
> -         * This does not load instructions and set the prefix bit correctly
> -         * for injected interrupts with KVM. That may have to be discovered
> -         * and set by the KVM layer before injecting.
> -         */
> -        return false;
> -    }
> -
> -    switch (excp) {
> -    case POWERPC_EXCP_MCHECK:
> -        if (!(env->error_code & PPC_BIT(42))) {
> -            /*
> -             * Fetch attempt caused a machine check, so attempting to fetch
> -             * again would cause a recursive machine check.
> -             */
> -            return false;
> -        }
> -        break;
> -    case POWERPC_EXCP_HDSI:
> -        /* HDSI PRTABLE_FAULT has the originating access type in error_code */
> -        if ((env->spr[SPR_HDSISR] & DSISR_PRTABLE_FAULT) &&
> -            (env->error_code == MMU_INST_FETCH)) {
> -            /*
> -             * Fetch failed due to partition scope translation, so prefix
> -             * indication is not relevant (and attempting to load the
> -             * instruction at NIP would cause recursive faults with the same
> -             * translation).
> -             */
> -            return false;
> -        }
> -        break;
> -
> -    case POWERPC_EXCP_DSI:
> -    case POWERPC_EXCP_DSEG:
> -    case POWERPC_EXCP_ALIGN:
> -    case POWERPC_EXCP_PROGRAM:
> -    case POWERPC_EXCP_FPU:
> -    case POWERPC_EXCP_TRACE:
> -    case POWERPC_EXCP_HV_EMU:
> -    case POWERPC_EXCP_VPU:
> -    case POWERPC_EXCP_VSXU:
> -    case POWERPC_EXCP_FU:
> -    case POWERPC_EXCP_HV_FU:
> -        break;
> -    default:
> -        return false;
> -    }
> -
> -    return is_prefix_insn(env, ppc_ldl_code(env, env->nip));
> -}
> -#else
> -static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
> -{
> -    return false;
> -}
> -#endif
> -
>   static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>   {
>       CPUPPCState *env = &cpu->env;
> @@ -1310,7 +1236,15 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>       }
>       vector |= env->excp_prefix;
>   
> -    if (is_prefix_insn_excp(cpu, excp)) {
> +    if (env->insns_flags2 & PPC2_ISA310) {

I guess you meant checking for ! of above.
is_prefix_insn_excp() returns false for ! of above.

> +        /* nothing to do */
> +    } else if (kvm_enabled()) {
> +        /*
> +         * This does not load instructions and set the prefix bit correctly
> +         * for injected interrupts with KVM. That may have to be discovered
> +         * and set by the KVM layer before injecting.
> +         */
> +    } else if (tcg_enabled() && is_prefix_insn_excp(env, excp)) {
>           msr |= PPC_BIT(34);
>       }
>   
> @@ -1484,20 +1418,9 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>           new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
>           break;
>   #ifdef CONFIG_TCG
> -    case POWERPC_EXCP_HV_EMU: {
> -        uint32_t insn = ppc_ldl_code(env, env->nip);
> -        env->spr[SPR_HEIR] = insn;
> -        if (is_prefix_insn(env, insn)) {
> -            uint32_t insn2 = ppc_ldl_code(env, env->nip + 4);
> -            env->spr[SPR_HEIR] <<= 32;
> -            env->spr[SPR_HEIR] |= insn2;
> -        }
> -        srr0 = SPR_HSRR0;
> -        srr1 = SPR_HSRR1;
> -        new_msr |= (target_ulong)MSR_HVB;
> -        new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
> +    case POWERPC_EXCP_HV_EMU:
> +        ppc_tcg_hv_emu(env, &new_msr, &srr0, &srr1);

Naming suggestion: ppc_excp_hv_emu may be more apt.

Thanks,
Harsh

>           break;
> -    }
>   #endif
>       case POWERPC_EXCP_VPU:       /* Vector unavailable exception             */
>       case POWERPC_EXCP_VSXU:       /* VSX unavailable exception               */
> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
> index 268a1614597..dc5601a4577 100644
> --- a/target/ppc/tcg-excp_helper.c
> +++ b/target/ppc/tcg-excp_helper.c
> @@ -283,4 +283,79 @@ uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
>       return insn;
>   }
>   
> +#if defined(TARGET_PPC64)
> +
> +static bool is_prefix_insn(CPUPPCState *env, uint32_t insn)
> +{
> +    if (!(env->insns_flags2 & PPC2_ISA310)) {
> +        return false;
> +    }
> +    return ((insn & 0xfc000000) == 0x04000000);
> +}
> +
> +bool is_prefix_insn_excp(CPUPPCState *env, int excp)
> +{
> +    switch (excp) {
> +    case POWERPC_EXCP_MCHECK:
> +        if (!(env->error_code & PPC_BIT(42))) {
> +            /*
> +             * Fetch attempt caused a machine check, so attempting to fetch
> +             * again would cause a recursive machine check.
> +             */
> +            return false;
> +        }
> +        break;
> +    case POWERPC_EXCP_HDSI:
> +        /* HDSI PRTABLE_FAULT has the originating access type in error_code */
> +        if ((env->spr[SPR_HDSISR] & DSISR_PRTABLE_FAULT) &&
> +            (env->error_code == MMU_INST_FETCH)) {
> +            /*
> +             * Fetch failed due to partition scope translation, so prefix
> +             * indication is not relevant (and attempting to load the
> +             * instruction at NIP would cause recursive faults with the same
> +             * translation).
> +             */
> +            return false;
> +        }
> +        break;
> +
> +    case POWERPC_EXCP_DSI:
> +    case POWERPC_EXCP_DSEG:
> +    case POWERPC_EXCP_ALIGN:
> +    case POWERPC_EXCP_PROGRAM:
> +    case POWERPC_EXCP_FPU:
> +    case POWERPC_EXCP_TRACE:
> +    case POWERPC_EXCP_HV_EMU:
> +    case POWERPC_EXCP_VPU:
> +    case POWERPC_EXCP_VSXU:
> +    case POWERPC_EXCP_FU:
> +    case POWERPC_EXCP_HV_FU:
> +        break;
> +    default:
> +        return false;
> +    }
> +
> +    return is_prefix_insn(env, ppc_ldl_code(env, env->nip));
> +}
> +
> +void ppc_tcg_hv_emu(CPUPPCState *env, target_ulong *new_msr,
> +                    int *srr0, int *srr1)
> +{
> +    uint32_t insn = ppc_ldl_code(env, env->nip);
> +
> +    env->spr[SPR_HEIR] = insn;
> +    if (is_prefix_insn(env, insn)) {
> +        uint32_t insn2 = ppc_ldl_code(env, env->nip + 4);
> +
> +        env->spr[SPR_HEIR] <<= 32;
> +        env->spr[SPR_HEIR] |= insn2;
> +    }
> +    *srr0 = SPR_HSRR0;
> +    *srr1 = SPR_HSRR1;
> +    *new_msr |= (target_ulong)MSR_HVB;
> +    *new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
> +}
> +
> +#endif /* TARGET_PPC64 */
> +
>   #endif /* !CONFIG_USER_ONLY */

