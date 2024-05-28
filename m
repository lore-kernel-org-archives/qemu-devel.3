Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B96C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 09:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBsxA-0005L7-Nx; Tue, 28 May 2024 05:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sBsx7-0005Gs-4q; Tue, 28 May 2024 05:17:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sBsx3-0003JT-QU; Tue, 28 May 2024 05:17:04 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S8Tfqf010499; Tue, 28 May 2024 09:16:51 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3DwlS?=
 =?UTF-8?Q?EW2CAxSmGRKxrvNsNqtaxRUCTglDBaq/EoNZ3+NA=3D;_b=3DAhA3+Njs+fukTV?=
 =?UTF-8?Q?xw6ShEuYjoqB0FBsIfMV5zjHARedqlCMyIuSCHU9Zgh9o/KhT33vsR_/tYyroCD?=
 =?UTF-8?Q?cn7tDmDxBqHUEie2nOzoTbLgvdjVC+vaxS67WYGjLl1DCuFV9kRpg8J3ljbu_Ho?=
 =?UTF-8?Q?Ha+S54xaK3l8q22MAUxxXW3eFhRQWL4/qwr0LCmbzRe9KjjY4Jl3R0331fxc0wo?=
 =?UTF-8?Q?iiw_J3xCC8Xjjp0AnuDhVADFnd1kA7Da8Vsv6Pf+0zVySvqcKsWnCdI8udlXA/u?=
 =?UTF-8?Q?vFZSSNXl6_PxIV//Arf7TrfcbA/aetSjhsOATY0Ne7NqJJ6pumhyyTNRZ4x6OJG?=
 =?UTF-8?Q?gfys/jQ9UFEOXuC_Kw=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydbs8g4f1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 09:16:50 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44S9Go0A016830;
 Tue, 28 May 2024 09:16:50 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydbs8g4ey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 09:16:50 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S90dq7011149; Tue, 28 May 2024 09:16:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ybtq066u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 09:16:49 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44S9GkSO28181244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 09:16:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E385F5806F;
 Tue, 28 May 2024 09:16:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8048E58043;
 Tue, 28 May 2024 09:16:42 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 May 2024 09:16:42 +0000 (GMT)
Message-ID: <1f9c8eb6-aa4f-4740-89a6-20b510b21d7d@linux.ibm.com>
Date: Tue, 28 May 2024 14:46:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/10] target/ppc: Add helpers to check for SMT
 sibling threads
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-8-npiggin@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240526122612.473476-8-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o3Dq_-sadMWp4zOSp__1YwX8aE8UncIw
X-Proofpoint-ORIG-GUID: 1oDkKYgBhLtXva0N4XnZxvuPPOGa-z8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_05,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=878 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280068
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



On 5/26/24 17:56, Nicholas Piggin wrote:
> Add helpers for TCG code to determine if there are SMT siblings
> sharing per-core and per-lpar registers. This simplifies the
> callers and makes SMT register topology simpler to modify with
> later changes.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/cpu.h             |  7 +++++++
>   target/ppc/cpu_init.c        |  2 +-
>   target/ppc/excp_helper.c     | 16 +++++++---------
>   target/ppc/misc_helper.c     | 27 ++++++---------------------
>   target/ppc/timebase_helper.c | 20 +++++++-------------
>   5 files changed, 28 insertions(+), 44 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 9a89083932..8fd6ade471 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1406,6 +1406,13 @@ struct CPUArchState {
>       uint64_t pmu_base_time;
>   };
>   
> +#define PPC_CPU_HAS_CORE_SIBLINGS(cs)                           \
> +    (cs->nr_threads > 1)
> +
> +#define PPC_CPU_HAS_LPAR_SIBLINGS(cs)                           \
> +    ((POWERPC_CPU(cs)->env.flags & POWERPC_FLAG_SMT_1LPAR) &&   \
> +     PPC_CPU_HAS_CORE_SIBLINGS(cs))
> +
>   #define _CORE_ID(cs)                                            \
>       (POWERPC_CPU(cs)->env.core_index)
>   
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index ae483e20c4..e71ee008ed 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6975,7 +6975,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
>   
>       pcc->parent_realize(dev, errp);
>   
> -    if (env_cpu(env)->nr_threads > 1) {
> +    if (PPC_CPU_HAS_CORE_SIBLINGS(cs)) {
>           env->flags |= POWERPC_FLAG_SMT;
>       }
>   
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 0cd542675f..fd45da0f2b 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -3029,7 +3029,7 @@ void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
>           brdcast = true;
>       }
>   
> -    if (cs->nr_threads == 1 || !brdcast) {
> +    if (!PPC_CPU_HAS_CORE_SIBLINGS(cs) || !brdcast) {

Since there are multiple usage of above macro in negation below as well, 
we may probably want to introduce another macro PPC_CPU_HAS_SINGLE_CORE
which checks only for nr_threads == 1. Anyways,

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


>           ppc_set_irq(cpu, PPC_INTERRUPT_HDOORBELL, 1);
>           return;
>       }
> @@ -3067,21 +3067,19 @@ void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
>       CPUState *cs = env_cpu(env);
>       PowerPCCPU *cpu = env_archcpu(env);
>       CPUState *ccs;
> -    uint32_t nr_threads = cs->nr_threads;
>       int ttir = rb & PPC_BITMASK(57, 63);
>   
>       helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSGP);
>   
> -    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> -        nr_threads = 1; /* msgsndp behaves as 1-thread in LPAR-per-thread mode*/
> -    }
> -
> -    if (!dbell_type_server(rb) || ttir >= nr_threads) {
> +    if (!dbell_type_server(rb)) {
>           return;
>       }
>   
> -    if (nr_threads == 1) {
> -        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, 1);
> +    /* msgsndp behaves as 1-thread in LPAR-per-thread mode*/
> +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
> +        if (ttir == 0) {
> +            ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, 1);
> +        }
>           return;
>       }
>   
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index 46ba3a5584..598c956cdd 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -49,9 +49,8 @@ void helper_spr_core_write_generic(CPUPPCState *env, uint32_t sprn,
>   {
>       CPUState *cs = env_cpu(env);
>       CPUState *ccs;
> -    uint32_t nr_threads = cs->nr_threads;
>   
> -    if (nr_threads == 1) {
> +    if (!PPC_CPU_HAS_CORE_SIBLINGS(cs)) {
>           env->spr[sprn] = val;
>           return;
>       }
> @@ -196,7 +195,7 @@ void helper_store_ptcr(CPUPPCState *env, target_ulong val)
>               return;
>           }
>   
> -        if (cs->nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> +        if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
>               env->spr[SPR_PTCR] = val;
>               tlb_flush(cs);
>           } else {
> @@ -243,16 +242,12 @@ target_ulong helper_load_dpdes(CPUPPCState *env)
>   {
>       CPUState *cs = env_cpu(env);
>       CPUState *ccs;
> -    uint32_t nr_threads = cs->nr_threads;
>       target_ulong dpdes = 0;
>   
>       helper_hfscr_facility_check(env, HFSCR_MSGP, "load DPDES", HFSCR_IC_MSGP);
>   
> -    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> -        nr_threads = 1; /* DPDES behaves as 1-thread in LPAR-per-thread mode */
> -    }
> -
> -    if (nr_threads == 1) {
> +    /* DPDES behaves as 1-thread in LPAR-per-thread mode */
> +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
>           if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
>               dpdes = 1;
>           }
> @@ -279,21 +274,11 @@ void helper_store_dpdes(CPUPPCState *env, target_ulong val)
>       PowerPCCPU *cpu = env_archcpu(env);
>       CPUState *cs = env_cpu(env);
>       CPUState *ccs;
> -    uint32_t nr_threads = cs->nr_threads;
>   
>       helper_hfscr_facility_check(env, HFSCR_MSGP, "store DPDES", HFSCR_IC_MSGP);
>   
> -    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> -        nr_threads = 1; /* DPDES behaves as 1-thread in LPAR-per-thread mode */
> -    }
> -
> -    if (val & ~(nr_threads - 1)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "Invalid DPDES register value "
> -                      TARGET_FMT_lx"\n", val);
> -        val &= (nr_threads - 1); /* Ignore the invalid bits */
> -    }
> -
> -    if (nr_threads == 1) {
> +    /* DPDES behaves as 1-thread in LPAR-per-thread mode */
> +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
>           ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & 0x1);
>           return;
>       }
> diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
> index 788c498d63..abe7b95696 100644
> --- a/target/ppc/timebase_helper.c
> +++ b/target/ppc/timebase_helper.c
> @@ -63,9 +63,8 @@ void helper_store_purr(CPUPPCState *env, target_ulong val)
>   {
>       CPUState *cs = env_cpu(env);
>       CPUState *ccs;
> -    uint32_t nr_threads = cs->nr_threads;
>   
> -    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
>           cpu_ppc_store_purr(env, val);
>           return;
>       }
> @@ -82,9 +81,8 @@ void helper_store_tbl(CPUPPCState *env, target_ulong val)
>   {
>       CPUState *cs = env_cpu(env);
>       CPUState *ccs;
> -    uint32_t nr_threads = cs->nr_threads;
>   
> -    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
>           cpu_ppc_store_tbl(env, val);
>           return;
>       }
> @@ -99,9 +97,8 @@ void helper_store_tbu(CPUPPCState *env, target_ulong val)
>   {
>       CPUState *cs = env_cpu(env);
>       CPUState *ccs;
> -    uint32_t nr_threads = cs->nr_threads;
>   
> -    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
>           cpu_ppc_store_tbu(env, val);
>           return;
>       }
> @@ -141,9 +138,8 @@ void helper_store_hdecr(CPUPPCState *env, target_ulong val)
>   {
>       CPUState *cs = env_cpu(env);
>       CPUState *ccs;
> -    uint32_t nr_threads = cs->nr_threads;
>   
> -    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
>           cpu_ppc_store_hdecr(env, val);
>           return;
>       }
> @@ -158,9 +154,8 @@ void helper_store_vtb(CPUPPCState *env, target_ulong val)
>   {
>       CPUState *cs = env_cpu(env);
>       CPUState *ccs;
> -    uint32_t nr_threads = cs->nr_threads;
>   
> -    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
>           cpu_ppc_store_vtb(env, val);
>           return;
>       }
> @@ -175,9 +170,8 @@ void helper_store_tbu40(CPUPPCState *env, target_ulong val)
>   {
>       CPUState *cs = env_cpu(env);
>       CPUState *ccs;
> -    uint32_t nr_threads = cs->nr_threads;
>   
> -    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
>           cpu_ppc_store_tbu40(env, val);
>           return;
>       }
> @@ -288,7 +282,7 @@ static void write_tfmr(CPUPPCState *env, target_ulong val)
>   {
>       CPUState *cs = env_cpu(env);
>   
> -    if (cs->nr_threads == 1) {
> +    if (!PPC_CPU_HAS_CORE_SIBLINGS(cs)) {
>           env->spr[SPR_TFMR] = val;
>       } else {
>           CPUState *ccs;

