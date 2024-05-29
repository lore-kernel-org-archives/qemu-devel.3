Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44564C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCtW-00057O-1q; Wed, 29 May 2024 02:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oWzJ=NA=kaod.org=clg@ozlabs.org>)
 id 1sCCtU-00056a-4p; Wed, 29 May 2024 02:34:40 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oWzJ=NA=kaod.org=clg@ozlabs.org>)
 id 1sCCtR-0006Ya-Sh; Wed, 29 May 2024 02:34:39 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Vq03Y120Dz4x0H;
 Wed, 29 May 2024 16:34:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vq03V2ScVz4wqM;
 Wed, 29 May 2024 16:34:29 +1000 (AEST)
Message-ID: <b298b542-ee6b-4a84-b1ff-1230dfdce09b@kaod.org>
Date: Wed, 29 May 2024 08:34:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/10] target/ppc: Add helpers to check for SMT
 sibling threads
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-8-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240526122612.473476-8-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=oWzJ=NA=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 5/26/24 14:26, Nicholas Piggin wrote:
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

        (cs)->nr_threads

> +
> +#define PPC_CPU_HAS_LPAR_SIBLINGS(cs)                           \
> +    ((POWERPC_CPU(cs)->env.flags & POWERPC_FLAG_SMT_1LPAR) &&   \
> +     PPC_CPU_HAS_CORE_SIBLINGS(cs))
> +

I tend to prefer static inline when things get complex.

The rest looks good.

Thanks,

C.



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


