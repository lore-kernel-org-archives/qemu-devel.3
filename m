Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5764C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 06:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tceld-0008W4-5L; Tue, 28 Jan 2025 01:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tcelI-0008M9-MR; Tue, 28 Jan 2025 01:07:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tcelE-0000du-AA; Tue, 28 Jan 2025 01:07:46 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RLIpOs010713;
 Tue, 28 Jan 2025 06:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zHvNaR
 3s2Bv1LOfzV272t8HSn1zJC1ap6uTi0C2MurA=; b=p7wiya/y1CSRLv3h5jNN/y
 fqmuDyLUcwc/yOMcPlYptycud/UpylHyjDx/nIC7twLRNiTDsq0smuC3moy74wgf
 GRw6d+Wahhuf09DLFy3pRqsKp20f2b+lLaxl8vgt8q/UQnxvCKEuk1h0Bcw6O8iq
 0uK3mSsywvEXGK0W9BFoh6fcCUOAVz8S+UzMJFS89z8l1ldueqI5NIOblXZO2Od8
 iSmZuTI/FXCBmVWt4jtlDuxxDwQWOo/ROp4tEtsIuFEQSzt3KEinhtyHMf32YAsh
 H4ihjRtlIBZZ4F17auU09i9dRocwEgUppIrozZfd3sXjpjKT/sbIpyonTL4XJDxA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdybk9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 06:07:40 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50S67dbR002047;
 Tue, 28 Jan 2025 06:07:40 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdybk9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 06:07:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50S4tC7U012336;
 Tue, 28 Jan 2025 06:07:38 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dany2130-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 06:07:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50S67c4A27329258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 06:07:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0548458052;
 Tue, 28 Jan 2025 06:07:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58C6358056;
 Tue, 28 Jan 2025 06:07:35 +0000 (GMT)
Received: from [9.124.214.156] (unknown [9.124.214.156])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jan 2025 06:07:34 +0000 (GMT)
Message-ID: <758609bc-c399-4de9-94eb-e0b3215e1df9@linux.ibm.com>
Date: Tue, 28 Jan 2025 11:37:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] target/ppc: Move TCG specific exception handlers
 to tcg-excp_helper.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-5-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250127102620.39159-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UbOsAsWke2428p1NVPYJrDz4wC4xUJk5
X-Proofpoint-ORIG-GUID: N1aFumftkbp2-gZVxGnr_hLCpesbzuS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_01,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280044
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
> Move the TCGCPUOps handlers to a new unit: tcg-excp_helper.c,
> only built when TCG is selected.
> 

Nice.
Just a thought - will the filename look better as excp_helper-tcg.c ?
That naming usually help developers when using tab completion.

> See in target/ppc/cpu_init.c:
> 
>      #ifdef CONFIG_TCG
>      static const TCGCPUOps ppc_tcg_ops = {
>        ...
>        .do_unaligned_access = ppc_cpu_do_unaligned_access,
>        .do_transaction_failed = ppc_cpu_do_transaction_failed,
>        .debug_excp_handler = ppc_cpu_debug_excp_handler,
>        .debug_check_breakpoint = ppc_cpu_debug_check_breakpoint,
>        .debug_check_watchpoint = ppc_cpu_debug_check_watchpoint,
>      };
>      #endif /* CONFIG_TCG */
> 

Thanks for capturing this in commit log.

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   target/ppc/excp_helper.c     | 173 ------------------------------
>   target/ppc/tcg-excp_helper.c | 202 +++++++++++++++++++++++++++++++++++
>   target/ppc/meson.build       |   1 +
>   3 files changed, 203 insertions(+), 173 deletions(-)
>   create mode 100644 target/ppc/tcg-excp_helper.c
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 7ed4bbec035..b05eb7f5aec 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -3144,178 +3144,5 @@ void helper_book3s_trace(CPUPPCState *env, target_ulong prev_ip)
>       raise_exception_err(env, POWERPC_EXCP_TRACE, error_code);
>   }
>   
> -void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
> -                                 MMUAccessType access_type,
> -                                 int mmu_idx, uintptr_t retaddr)
> -{
> -    CPUPPCState *env = cpu_env(cs);
> -    uint32_t insn;
> -
> -    /* Restore state and reload the insn we executed, for filling in DSISR.  */
> -    cpu_restore_state(cs, retaddr);
> -    insn = ppc_ldl_code(env, env->nip);
> -
> -    switch (env->mmu_model) {
> -    case POWERPC_MMU_SOFT_4xx:
> -        env->spr[SPR_40x_DEAR] = vaddr;
> -        break;
> -    case POWERPC_MMU_BOOKE:
> -    case POWERPC_MMU_BOOKE206:
> -        env->spr[SPR_BOOKE_DEAR] = vaddr;
> -        break;
> -    default:
> -        env->spr[SPR_DAR] = vaddr;
> -        break;
> -    }
> -
> -    cs->exception_index = POWERPC_EXCP_ALIGN;
> -    env->error_code = insn & 0x03FF0000;
> -    cpu_loop_exit(cs);
> -}
> -
> -void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> -                                   vaddr vaddr, unsigned size,
> -                                   MMUAccessType access_type,
> -                                   int mmu_idx, MemTxAttrs attrs,
> -                                   MemTxResult response, uintptr_t retaddr)
> -{
> -    CPUPPCState *env = cpu_env(cs);
> -
> -    switch (env->excp_model) {
> -#if defined(TARGET_PPC64)
> -    case POWERPC_EXCP_POWER8:
> -    case POWERPC_EXCP_POWER9:
> -    case POWERPC_EXCP_POWER10:
> -    case POWERPC_EXCP_POWER11:
> -        /*
> -         * Machine check codes can be found in processor User Manual or
> -         * Linux or skiboot source.
> -         */
> -        if (access_type == MMU_DATA_LOAD) {
> -            env->spr[SPR_DAR] = vaddr;
> -            env->spr[SPR_DSISR] = PPC_BIT(57);
> -            env->error_code = PPC_BIT(42);
> -
> -        } else if (access_type == MMU_DATA_STORE) {
> -            /*
> -             * MCE for stores in POWER is asynchronous so hardware does
> -             * not set DAR, but QEMU can do better.
> -             */
> -            env->spr[SPR_DAR] = vaddr;
> -            env->error_code = PPC_BIT(36) | PPC_BIT(43) | PPC_BIT(45);
> -            env->error_code |= PPC_BIT(42);
> -
> -        } else { /* Fetch */
> -            /*
> -             * is_prefix_insn_excp() tests !PPC_BIT(42) to avoid fetching
> -             * the instruction, so that must always be clear for fetches.
> -             */
> -            env->error_code = PPC_BIT(36) | PPC_BIT(44) | PPC_BIT(45);
> -        }
> -        break;
> -#endif
> -    default:
> -        /*
> -         * TODO: Check behaviour for other CPUs, for now do nothing.
> -         * Could add a basic MCE even if real hardware ignores.
> -         */
> -        return;
> -    }
> -
> -    cs->exception_index = POWERPC_EXCP_MCHECK;
> -    cpu_loop_exit_restore(cs, retaddr);
> -}
> -
> -void ppc_cpu_debug_excp_handler(CPUState *cs)
> -{
> -#if defined(TARGET_PPC64)
> -    CPUPPCState *env = cpu_env(cs);
> -
> -    if (env->insns_flags2 & PPC2_ISA207S) {
> -        if (cs->watchpoint_hit) {
> -            if (cs->watchpoint_hit->flags & BP_CPU) {
> -                env->spr[SPR_DAR] = cs->watchpoint_hit->hitaddr;
> -                env->spr[SPR_DSISR] = PPC_BIT(41);
> -                cs->watchpoint_hit = NULL;
> -                raise_exception(env, POWERPC_EXCP_DSI);
> -            }
> -            cs->watchpoint_hit = NULL;
> -        } else if (cpu_breakpoint_test(cs, env->nip, BP_CPU)) {
> -            raise_exception_err(env, POWERPC_EXCP_TRACE,
> -                                PPC_BIT(33) | PPC_BIT(43));
> -        }
> -    }
> -#endif
> -}
> -
> -bool ppc_cpu_debug_check_breakpoint(CPUState *cs)
> -{
> -#if defined(TARGET_PPC64)
> -    CPUPPCState *env = cpu_env(cs);
> -
> -    if (env->insns_flags2 & PPC2_ISA207S) {
> -        target_ulong priv;
> -
> -        priv = env->spr[SPR_CIABR] & PPC_BITMASK(62, 63);
> -        switch (priv) {
> -        case 0x1: /* problem */
> -            return env->msr & ((target_ulong)1 << MSR_PR);
> -        case 0x2: /* supervisor */
> -            return (!(env->msr & ((target_ulong)1 << MSR_PR)) &&
> -                    !(env->msr & ((target_ulong)1 << MSR_HV)));
> -        case 0x3: /* hypervisor */
> -            return (!(env->msr & ((target_ulong)1 << MSR_PR)) &&
> -                     (env->msr & ((target_ulong)1 << MSR_HV)));
> -        default:
> -            g_assert_not_reached();
> -        }
> -    }
> -#endif
> -
> -    return false;
> -}
> -
> -bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
> -{
> -#if defined(TARGET_PPC64)
> -    CPUPPCState *env = cpu_env(cs);
> -
> -    if (env->insns_flags2 & PPC2_ISA207S) {
> -        if (wp == env->dawr0_watchpoint) {
> -            uint32_t dawrx = env->spr[SPR_DAWRX0];
> -            bool wt = extract32(dawrx, PPC_BIT_NR(59), 1);
> -            bool wti = extract32(dawrx, PPC_BIT_NR(60), 1);
> -            bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
> -            bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
> -            bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
> -
> -            if ((env->msr & ((target_ulong)1 << MSR_PR)) && !pr) {
> -                return false;
> -            } else if ((env->msr & ((target_ulong)1 << MSR_HV)) && !hv) {
> -                return false;
> -            } else if (!sv) {
> -                return false;
> -            }
> -
> -            if (!wti) {
> -                if (env->msr & ((target_ulong)1 << MSR_DR)) {
> -                    if (!wt) {
> -                        return false;
> -                    }
> -                } else {
> -                    if (wt) {
> -                        return false;
> -                    }
> -                }
> -            }
> -
> -            return true;
> -        }
> -    }
> -#endif
> -
> -    return false;
> -}
> -
>   #endif /* !CONFIG_USER_ONLY */
>   #endif /* CONFIG_TCG */
> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
> new file mode 100644
> index 00000000000..3402dbe05ee
> --- /dev/null
> +++ b/target/ppc/tcg-excp_helper.c
> @@ -0,0 +1,202 @@
> +/*
> + *  PowerPC exception emulation helpers for QEMU (TCG specific)
> + *
> + *  Copyright (c) 2003-2007 Jocelyn Mayer
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "qemu/osdep.h"
> +#include "exec/cpu_ldst.h"
> +
> +#include "hw/ppc/ppc.h"
> +#include "internal.h"
> +#include "cpu.h"
> +#include "trace.h"
> +
> +#ifndef CONFIG_USER_ONLY
> +
> +void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
> +                                 MMUAccessType access_type,
> +                                 int mmu_idx, uintptr_t retaddr)
> +{
> +    CPUPPCState *env = cpu_env(cs);
> +    uint32_t insn;
> +
> +    /* Restore state and reload the insn we executed, for filling in DSISR.  */
> +    cpu_restore_state(cs, retaddr);
> +    insn = ppc_ldl_code(env, env->nip);
> +
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_SOFT_4xx:
> +        env->spr[SPR_40x_DEAR] = vaddr;
> +        break;
> +    case POWERPC_MMU_BOOKE:
> +    case POWERPC_MMU_BOOKE206:
> +        env->spr[SPR_BOOKE_DEAR] = vaddr;
> +        break;
> +    default:
> +        env->spr[SPR_DAR] = vaddr;
> +        break;
> +    }
> +
> +    cs->exception_index = POWERPC_EXCP_ALIGN;
> +    env->error_code = insn & 0x03FF0000;
> +    cpu_loop_exit(cs);
> +}
> +
> +void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> +                                   vaddr vaddr, unsigned size,
> +                                   MMUAccessType access_type,
> +                                   int mmu_idx, MemTxAttrs attrs,
> +                                   MemTxResult response, uintptr_t retaddr)
> +{
> +    CPUPPCState *env = cpu_env(cs);
> +
> +    switch (env->excp_model) {
> +#if defined(TARGET_PPC64)
> +    case POWERPC_EXCP_POWER8:
> +    case POWERPC_EXCP_POWER9:
> +    case POWERPC_EXCP_POWER10:
> +    case POWERPC_EXCP_POWER11:
> +        /*
> +         * Machine check codes can be found in processor User Manual or
> +         * Linux or skiboot source.
> +         */
> +        if (access_type == MMU_DATA_LOAD) {
> +            env->spr[SPR_DAR] = vaddr;
> +            env->spr[SPR_DSISR] = PPC_BIT(57);
> +            env->error_code = PPC_BIT(42);
> +
> +        } else if (access_type == MMU_DATA_STORE) {
> +            /*
> +             * MCE for stores in POWER is asynchronous so hardware does
> +             * not set DAR, but QEMU can do better.
> +             */
> +            env->spr[SPR_DAR] = vaddr;
> +            env->error_code = PPC_BIT(36) | PPC_BIT(43) | PPC_BIT(45);
> +            env->error_code |= PPC_BIT(42);
> +
> +        } else { /* Fetch */
> +            /*
> +             * is_prefix_insn_excp() tests !PPC_BIT(42) to avoid fetching
> +             * the instruction, so that must always be clear for fetches.
> +             */
> +            env->error_code = PPC_BIT(36) | PPC_BIT(44) | PPC_BIT(45);
> +        }
> +        break;
> +#endif
> +    default:
> +        /*
> +         * TODO: Check behaviour for other CPUs, for now do nothing.
> +         * Could add a basic MCE even if real hardware ignores.
> +         */
> +        return;
> +    }
> +
> +    cs->exception_index = POWERPC_EXCP_MCHECK;
> +    cpu_loop_exit_restore(cs, retaddr);
> +}
> +
> +void ppc_cpu_debug_excp_handler(CPUState *cs)
> +{
> +#if defined(TARGET_PPC64)
> +    CPUPPCState *env = cpu_env(cs);
> +
> +    if (env->insns_flags2 & PPC2_ISA207S) {
> +        if (cs->watchpoint_hit) {
> +            if (cs->watchpoint_hit->flags & BP_CPU) {
> +                env->spr[SPR_DAR] = cs->watchpoint_hit->hitaddr;
> +                env->spr[SPR_DSISR] = PPC_BIT(41);
> +                cs->watchpoint_hit = NULL;
> +                raise_exception(env, POWERPC_EXCP_DSI);
> +            }
> +            cs->watchpoint_hit = NULL;
> +        } else if (cpu_breakpoint_test(cs, env->nip, BP_CPU)) {
> +            raise_exception_err(env, POWERPC_EXCP_TRACE,
> +                                PPC_BIT(33) | PPC_BIT(43));
> +        }
> +    }
> +#endif
> +}
> +
> +bool ppc_cpu_debug_check_breakpoint(CPUState *cs)
> +{
> +#if defined(TARGET_PPC64)
> +    CPUPPCState *env = cpu_env(cs);
> +
> +    if (env->insns_flags2 & PPC2_ISA207S) {
> +        target_ulong priv;
> +
> +        priv = env->spr[SPR_CIABR] & PPC_BITMASK(62, 63);
> +        switch (priv) {
> +        case 0x1: /* problem */
> +            return env->msr & ((target_ulong)1 << MSR_PR);
> +        case 0x2: /* supervisor */
> +            return (!(env->msr & ((target_ulong)1 << MSR_PR)) &&
> +                    !(env->msr & ((target_ulong)1 << MSR_HV)));
> +        case 0x3: /* hypervisor */
> +            return (!(env->msr & ((target_ulong)1 << MSR_PR)) &&
> +                     (env->msr & ((target_ulong)1 << MSR_HV)));
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }
> +#endif
> +
> +    return false;
> +}
> +
> +bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
> +{
> +#if defined(TARGET_PPC64)
> +    CPUPPCState *env = cpu_env(cs);
> +
> +    if (env->insns_flags2 & PPC2_ISA207S) {
> +        if (wp == env->dawr0_watchpoint) {
> +            uint32_t dawrx = env->spr[SPR_DAWRX0];
> +            bool wt = extract32(dawrx, PPC_BIT_NR(59), 1);
> +            bool wti = extract32(dawrx, PPC_BIT_NR(60), 1);
> +            bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
> +            bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
> +            bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
> +
> +            if ((env->msr & ((target_ulong)1 << MSR_PR)) && !pr) {
> +                return false;
> +            } else if ((env->msr & ((target_ulong)1 << MSR_HV)) && !hv) {
> +                return false;
> +            } else if (!sv) {
> +                return false;
> +            }
> +
> +            if (!wti) {
> +                if (env->msr & ((target_ulong)1 << MSR_DR)) {
> +                    if (!wt) {
> +                        return false;
> +                    }
> +                } else {
> +                    if (wt) {
> +                        return false;
> +                    }
> +                }
> +            }
> +
> +            return true;
> +        }
> +    }
> +#endif
> +
> +    return false;
> +}
> +
> +#endif /* !CONFIG_USER_ONLY */
> diff --git a/target/ppc/meson.build b/target/ppc/meson.build
> index db3b7a0c33b..8eed1fa40ca 100644
> --- a/target/ppc/meson.build
> +++ b/target/ppc/meson.build
> @@ -14,6 +14,7 @@ ppc_ss.add(when: 'CONFIG_TCG', if_true: files(
>     'int_helper.c',
>     'mem_helper.c',
>     'misc_helper.c',
> +  'tcg-excp_helper.c',
>     'timebase_helper.c',
>     'translate.c',
>     'power8-pmu.c',

