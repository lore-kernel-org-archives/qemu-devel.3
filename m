Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60982C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 06:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhOb4-00088H-Kg; Tue, 05 Mar 2024 01:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rhOao-00086m-8f; Tue, 05 Mar 2024 01:48:08 -0500
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rhOag-0005qu-Ei; Tue, 05 Mar 2024 01:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1709621259; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=77iPO+RmmC0nTa9RMJ/QmIPzNxjOhN2jFl+Ela2Dz+g=;
 b=jqTXZ47Q//fysBiEERDoMf+231vKtmNUVXYstCLElnnSmj4tQjSCKjr6NjmAJPVkXqS2PdxXM8GwizAEJCvl8CQ1mA+o5uQTkdK8WwLOKAkK1jjCueJf4BhCkRDjLVEo5PW+wupl4Oym/umP+xAfmeo1uds/QG5xU9jy3dkHNts=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R431e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W1tHlPI_1709621257; 
Received: from 30.198.0.247(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W1tHlPI_1709621257) by smtp.aliyun-inc.com;
 Tue, 05 Mar 2024 14:47:38 +0800
Message-ID: <165adab6-d41f-4d72-b059-b13219cd5ac9@linux.alibaba.com>
Date: Tue, 5 Mar 2024 14:47:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] target/riscv: Implement privilege mode filtering
 for cycle/instret
To: Atish Patra <atishp@rivosinc.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, kaiwenxue1@gmail.com
References: <20240228185116.1321730-1-atishp@rivosinc.com>
 <20240228185116.1321730-6-atishp@rivosinc.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240228185116.1321730-6-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/2/29 2:51, Atish Patra wrote:
> Privilege mode filtering can also be emulated for cycle/instret by
> tracking host_ticks/icount during each privilege mode switch. This
> patch implements that for both cycle/instret and mhpmcounters. The
> first one requires Smcntrpmf while the other one requires Sscofpmf
> to be enabled.
>
> The cycle/instret are still computed using host ticks when icount
> is not enabled. Otherwise, they are computed using raw icount which
> is more accurate in icount mode.
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>   target/riscv/cpu.h        | 11 +++++
>   target/riscv/cpu_bits.h   |  5 ++
>   target/riscv/cpu_helper.c | 17 ++++++-
>   target/riscv/csr.c        | 96 ++++++++++++++++++++++++++++++---------
>   target/riscv/pmu.c        | 64 ++++++++++++++++++++++++++
>   target/riscv/pmu.h        |  2 +
>   6 files changed, 171 insertions(+), 24 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 174e8ba8e847..9e21d7f7d635 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -157,6 +157,15 @@ typedef struct PMUCTRState {
>       target_ulong irq_overflow_left;
>   } PMUCTRState;
>   
> +typedef struct PMUFixedCtrState {
> +        /* Track cycle and icount for each privilege mode */
> +        uint64_t counter[4];
> +        uint64_t counter_prev[4];
> +        /* Track cycle and icount for each privilege mode when V = 1*/
> +        uint64_t counter_virt[2];
> +        uint64_t counter_virt_prev[2];
> +} PMUFixedCtrState;
> +
>   struct CPUArchState {
>       target_ulong gpr[32];
>       target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
> @@ -353,6 +362,8 @@ struct CPUArchState {
>       /* PMU event selector configured values for RV32 */
>       target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
>   
> +    PMUFixedCtrState pmu_fixed_ctrs[2];
> +
>       target_ulong sscratch;
>       target_ulong mscratch;
>   
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index e866c60a400c..5fe349e313dc 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -920,6 +920,11 @@ typedef enum RISCVException {
>   #define MHPMEVENT_BIT_VUINH                BIT_ULL(58)
>   #define MHPMEVENTH_BIT_VUINH               BIT(26)
>   
> +#define MHPMEVENT_FILTER_MASK              (MHPMEVENT_BIT_MINH  | \
> +                                            MHPMEVENT_BIT_SINH  | \
> +                                            MHPMEVENT_BIT_UINH  | \
> +                                            MHPMEVENT_BIT_VSINH | \
> +                                            MHPMEVENT_BIT_VUINH)
>   #define MHPMEVENT_SSCOF_MASK               _ULL(0xFFFF000000000000)
>   #define MHPMEVENT_IDX_MASK                 0xFFFFF
>   #define MHPMEVENT_SSCOF_RESVD              16
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index d462d95ee165..33965d843d46 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -718,8 +718,21 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
>   {
>       g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
>   
> -    if (icount_enabled() && newpriv != env->priv) {
> -        riscv_itrigger_update_priv(env);
> +    /*
> +     * Invoke cycle/instret update between priv mode changes or
> +     * VS->HS mode transition is SPV bit must be set
> +     * HS->VS mode transition where virt_enabled must be set
> +     * In both cases, priv will S mode only.
> +     */
> +    if (newpriv != env->priv ||
> +       (env->priv == PRV_S && newpriv == PRV_S &&
> +        (env->virt_enabled || get_field(env->hstatus, HSTATUS_SPV)))) {
> +        if (icount_enabled()) {
> +            riscv_itrigger_update_priv(env);
> +            riscv_pmu_icount_update_priv(env, newpriv);
> +        } else {
> +            riscv_pmu_cycle_update_priv(env, newpriv);
> +        }
>       }
>       /* tlb_flush is unnecessary as mode is contained in mmu_idx */
>       env->priv = newpriv;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index ff9bac537593..482e212c5f74 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -788,32 +788,16 @@ static RISCVException write_vcsr(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +#if defined(CONFIG_USER_ONLY)
>   /* User Timers and Counters */
>   static target_ulong get_ticks(bool shift)
>   {
> -    int64_t val;
> -    target_ulong result;
> -
> -#if !defined(CONFIG_USER_ONLY)
> -    if (icount_enabled()) {
> -        val = icount_get();
> -    } else {
> -        val = cpu_get_host_ticks();
> -    }
> -#else
> -    val = cpu_get_host_ticks();
> -#endif
> -
> -    if (shift) {
> -        result = val >> 32;
> -    } else {
> -        result = val;
> -    }
> +    int64_t val = cpu_get_host_ticks();
> +    target_ulong result = shift ? val >> 32 : val;
>   
>       return result;
>   }
>   
> -#if defined(CONFIG_USER_ONLY)
>   static RISCVException read_time(CPURISCVState *env, int csrno,
>                                   target_ulong *val)
>   {
> @@ -952,6 +936,71 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
> +                                                         int counter_idx,
> +                                                         bool upper_half)
> +{
> +    uint64_t curr_val = 0;
> +    target_ulong result = 0;
> +    uint64_t *counter_arr = icount_enabled() ? env->pmu_fixed_ctrs[1].counter :
> +                            env->pmu_fixed_ctrs[0].counter;
> +    uint64_t *counter_arr_virt = icount_enabled() ?
> +                                 env->pmu_fixed_ctrs[1].counter_virt :
> +                                 env->pmu_fixed_ctrs[0].counter_virt;
> +    uint64_t cfg_val = 0;
> +
> +    if (counter_idx == 0) {
> +        cfg_val = upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
> +                  env->mcyclecfg;
> +    } else if (counter_idx == 2) {
> +        cfg_val = upper_half ? ((uint64_t)env->minstretcfgh << 32) :
> +                  env->minstretcfg;
> +    } else {
> +        cfg_val = upper_half ?
> +                  ((uint64_t)env->mhpmeventh_val[counter_idx] << 32) :
> +                  env->mhpmevent_val[counter_idx];
> +        cfg_val &= MHPMEVENT_FILTER_MASK;
> +    }
> +
> +    if (!cfg_val) {
> +        if (icount_enabled()) {
> +            curr_val = icount_get_raw();
> +        } else {
> +            curr_val = cpu_get_host_ticks();
> +        }
> +        goto done;
> +    }
> +
> +    if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
> +        curr_val += counter_arr[PRV_M];
> +    }
> +
> +    if (!(cfg_val & MCYCLECFG_BIT_SINH)) {
> +        curr_val += counter_arr[PRV_S];
> +    }
> +
> +    if (!(cfg_val & MCYCLECFG_BIT_UINH)) {
> +        curr_val += counter_arr[PRV_U];
> +    }
> +
> +    if (!(cfg_val & MCYCLECFG_BIT_VSINH)) {
> +        curr_val += counter_arr_virt[PRV_S];
> +    }
> +
> +    if (!(cfg_val & MCYCLECFG_BIT_VUINH)) {
> +        curr_val += counter_arr_virt[PRV_U];
> +    }
> +
> +done:
> +    if (riscv_cpu_mxl(env) == MXL_RV32) {
> +        result = upper_half ? curr_val >> 32 : curr_val;
> +    } else {
> +        result = curr_val;
> +    }
> +
> +    return result;
> +}
> +
>   static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
>                                           target_ulong val)
>   {
> @@ -962,7 +1011,8 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
>       counter->mhpmcounter_val = val;
>       if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        counter->mhpmcounter_prev = get_ticks(false);
> +        counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
> +                                                                ctr_idx, false);
>           if (ctr_idx > 2) {
>               if (riscv_cpu_mxl(env) == MXL_RV32) {
>                   mhpmctr_val = mhpmctr_val |
> @@ -990,7 +1040,8 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
>       mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
>       if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        counter->mhpmcounterh_prev = get_ticks(true);
> +        counter->mhpmcounterh_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
> +                                                                 ctr_idx, true);
>           if (ctr_idx > 2) {
>               riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
>           }
> @@ -1031,7 +1082,8 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>        */
>       if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        *val = get_ticks(upper_half) - ctr_prev + ctr_val;
> +        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, upper_half) -
> +                                                    ctr_prev + ctr_val;
>       } else {
>           *val = ctr_val;
>       }
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index 0e7d58b8a5c2..37309ff64cb6 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -19,6 +19,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "qemu/error-report.h"
> +#include "qemu/timer.h"
>   #include "cpu.h"
>   #include "pmu.h"
>   #include "sysemu/cpu-timers.h"
> @@ -176,6 +177,69 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu, uint32_t ctr_idx)
>       return 0;
>   }
>   
> +void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong newpriv)
> +{
> +    uint64_t delta;
> +    uint64_t *counter_arr;
> +    uint64_t *counter_arr_prev;
> +    uint64_t current_icount = icount_get_raw();
> +
> +    if (env->virt_enabled) {
> +        counter_arr = env->pmu_fixed_ctrs[1].counter_virt;
> +        counter_arr_prev = env->pmu_fixed_ctrs[1].counter_virt_prev;
> +    } else {
> +        counter_arr = env->pmu_fixed_ctrs[1].counter;
> +        counter_arr_prev = env->pmu_fixed_ctrs[1].counter_prev;
> +    }
> +
> +    if (newpriv != env->priv) {
> +        delta = current_icount - counter_arr_prev[env->priv];
> +        counter_arr_prev[newpriv] = current_icount;
> +    } else {
> +        delta = current_icount - counter_arr_prev[env->priv];
> +        if (env->virt_enabled) {
> +            /* HS->VS transition.The previous value should correspond to HS. */

Hi Atish,

Dose env->virt_enabled ensure HS->VS transition?

I think VS->VS also keeps  env->virt_enabled to be true, where the 
previous value should correspond to VS.

Thanks,
Zhiwei

> +            env->pmu_fixed_ctrs[1].counter_prev[PRV_S] = current_icount;
> +        } else if (get_field(env->hstatus, HSTATUS_SPV)) {
> +            /* VS->HS transition.The previous value should correspond to VS. */
> +            env->pmu_fixed_ctrs[1].counter_virt_prev[PRV_S] = current_icount;
> +        }
> +   }
> +
> +    counter_arr[env->priv] += delta;
> +}
> +
> +void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong newpriv)
> +{
> +    uint64_t delta;
> +    uint64_t *counter_arr;
> +    uint64_t *counter_arr_prev;
> +    uint64_t current_host_ticks = cpu_get_host_ticks();
> +
> +    if (env->virt_enabled) {
> +        counter_arr = env->pmu_fixed_ctrs[0].counter_virt;
> +        counter_arr_prev = env->pmu_fixed_ctrs[0].counter_virt_prev;
> +    } else {
> +        counter_arr = env->pmu_fixed_ctrs[0].counter;
> +        counter_arr_prev = env->pmu_fixed_ctrs[0].counter_prev;
> +    }
> +
> +    if (newpriv != env->priv) {
> +        delta = current_host_ticks - counter_arr_prev[env->priv];
> +        counter_arr_prev[newpriv] = current_host_ticks;
> +    } else {
> +        delta = current_host_ticks - counter_arr_prev[env->priv];
> +        if (env->virt_enabled) {
> +            env->pmu_fixed_ctrs[0].counter_prev[PRV_S] = current_host_ticks;
> +        } else if (get_field(env->hstatus, HSTATUS_SPV)) {
> +            env->pmu_fixed_ctrs[0].counter_virt_prev[PRV_S] =
> +            current_host_ticks;
> +        }
> +   }
> +
> +    counter_arr[env->priv] += delta;
> +}
> +
>   int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
>   {
>       uint32_t ctr_idx;
> diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
> index 505fc850d38e..50de6031a730 100644
> --- a/target/riscv/pmu.h
> +++ b/target/riscv/pmu.h
> @@ -31,3 +31,5 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
>   void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
>   int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
>                             uint32_t ctr_idx);
> +void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong newpriv);
> +void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong newpriv);

