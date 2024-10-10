Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C56CF11F4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 13:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syt3x-0008Ix-V4; Thu, 10 Oct 2024 09:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1syrui-0006jS-ME; Thu, 10 Oct 2024 08:05:04 -0400
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1syruf-00063d-A9; Thu, 10 Oct 2024 08:05:04 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 9818AE0017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1728561896; bh=fFVBRLoXNPpVTe8dVSdU2KVuUrjPCM3c0blcCfYlR0I=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=OpQrbX/9govS306llGMDe/r9nsqvaRVqAxv8OJ+VsPKDEtjVHcBwHZg01A7715zMr
 VKsFXbryDMQR3J5o7du54JImmL3fsY/sEg5Qj/6QgqDhOaCMu08zv0ilNNMvl7I4l2
 2Ara/UQ4gP+IW2w82DfMZs+5LNRqxes5Mmh6374eZ/iTqCBEhmZxEvLu//DG9+pFgE
 3YxKNcJl6HqkNT8jRxvlaTWp6u+0F+hDJ2IwEfMlhCueHisjeYHxZKHKYX2gKSyfsw
 rgBuhyxjYDCTvfzX0eyRKx0RyLcfX46Slnouq4GpFPW/Zk+euUxGz/I1TKCNrFaLZR
 vT9mCmi1JMcnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1728561896; bh=fFVBRLoXNPpVTe8dVSdU2KVuUrjPCM3c0blcCfYlR0I=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=bCes0XtJUcy5o04pxQ3Vt6Sj7uvk0fLnv8gjlUsZyzRXeAbELCiK9HfkHbC9LkCih
 O/L61fYwRU5QulfPVY047QFflkPXGNwkzIFy7/QBwb7MvAkATFxihkeYLMASh4KaQl
 pm9LorLExL95ffKyKaNfZx8sa1cWnjrOXE/pNUMaTLGus2brMSwrLi25o7EcWTzdpj
 nbTq3qjNlECC0L2nN57L2yfiMqJVqIBy2Y37kFS+jLyH+FY/8pVPkXD5Ae8jjuBSd7
 H7xV9YuGHSW0up+ju/z4tPIKNhvW/oWi4GBzF184UJ7HwAtqqTiaTBl6CK1nJTs2/6
 mUXhJMqZNKfmQ==
Message-ID: <d3c4174e-1659-4409-9b42-7562e40ad0a8@yadro.com>
Date: Thu, 10 Oct 2024 15:04:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/10] target/riscv: Introduce helper functions for
 pmu hashtable lookup
To: Atish Patra <atishp@rivosinc.com>, <qemu-riscv@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <alexei.filippov@syntacore.com>, <palmer@dabbelt.com>,
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>,
 <bin.meng@windriver.com>, <dbarboza@ventanamicro.com>,
 <alistair.francis@wdc.com>
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
 <20241009-pmu_event_machine-v1-2-dcbd7a60e3ba@rivosinc.com>
Content-Language: en-US
From: Alexei Filippov <alexei.filippov@yadro.com>
In-Reply-To: <20241009-pmu_event_machine-v1-2-dcbd7a60e3ba@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.253;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-03.yadro.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 10 Oct 2024 09:18:36 -0400
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



On 10.10.2024 02:09, Atish Patra wrote:
> The pmu implementation requires hashtable lookup operation sprinkled
> through the file. Add a helper function that allows to consolidate
> the implementation and extend it in the future easily.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>   target/riscv/pmu.c | 56 ++++++++++++++++++++++++++----------------------------
>   1 file changed, 27 insertions(+), 29 deletions(-)
> 
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index e05ab067d2f2..a88c321a6cad 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -265,6 +265,21 @@ static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
>       counter_arr[env->priv] += delta;
>   }
>   
> +static bool riscv_pmu_htable_lookup(RISCVCPU *cpu, uint32_t key,
> +                                    uint32_t *value)
> +{
> +    GHashTable *table = cpu->pmu_event_ctr_map;
> +    gpointer val_ptr;
> +
> +    val_ptr = g_hash_table_lookup(table, GUINT_TO_POINTER(key));
> +    if (!val_ptr) {
> +        return false;
> +    }
> +
> +    *value = GPOINTER_TO_UINT(val_ptr);
> +    return true;
> +}
> +
>   void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
>                                    bool new_virt)
>   {
> @@ -277,18 +292,15 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
>       uint32_t ctr_idx;
>       int ret;
>       CPURISCVState *env = &cpu->env;
> -    gpointer value;
>   
>       if (!cpu->cfg.pmu_mask) {
>           return 0;
>       }
> -    value = g_hash_table_lookup(cpu->pmu_event_ctr_map,
> -                                GUINT_TO_POINTER(event_idx));
> -    if (!value) {
> +
> +    if (!riscv_pmu_htable_lookup(cpu, event_idx, &ctr_idx)) {
>           return -1;
>       }
>   
> -    ctr_idx = GPOINTER_TO_UINT(value);
>       if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
>           return -1;
>       }
> @@ -306,7 +318,6 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
>                                           uint32_t target_ctr)
Not sure about this kind of functions, this hardcoded dublication aren't 
scalable, check it in my patch.
>   {
>       RISCVCPU *cpu;
> -    uint32_t event_idx;
>       uint32_t ctr_idx;
>   
>       /* Fixed instret counter */
> @@ -315,14 +326,8 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
>       }
>   
>       cpu = env_archcpu(env);
> -    if (!cpu->pmu_event_ctr_map) {
> -        return false;
> -    }
> -
> -    event_idx = RISCV_PMU_EVENT_HW_INSTRUCTIONS;
> -    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
> -                               GUINT_TO_POINTER(event_idx)));
> -    if (!ctr_idx) {
> +    if (!riscv_pmu_htable_lookup(cpu, RISCV_PMU_EVENT_HW_INSTRUCTIONS,
> +                                 &ctr_idx)) {
>           return false;
>       }
>   
> @@ -332,7 +337,6 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
>   bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
>   {
>       RISCVCPU *cpu;
> -    uint32_t event_idx;
>       uint32_t ctr_idx;
>   
>       /* Fixed mcycle counter */
> @@ -341,16 +345,8 @@ bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
>       }
>   
>       cpu = env_archcpu(env);
> -    if (!cpu->pmu_event_ctr_map) {
> -        return false;
> -    }
> -
> -    event_idx = RISCV_PMU_EVENT_HW_CPU_CYCLES;
> -    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
> -                               GUINT_TO_POINTER(event_idx)));
> -
> -    /* Counter zero is not used for event_ctr_map */
> -    if (!ctr_idx) {
> +    if (!riscv_pmu_htable_lookup(cpu, RISCV_PMU_EVENT_HW_CPU_CYCLES,
> +                                &ctr_idx)) {
>           return false;
>       }
>   
> @@ -381,6 +377,7 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
>   {
>       uint32_t event_idx;
>       RISCVCPU *cpu = env_archcpu(env);
> +    uint32_t mapped_ctr_idx;
>   
>       if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->pmu_event_ctr_map) {
>           return -1;
> @@ -398,8 +395,7 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
>       }
>   
>       event_idx = value & MHPMEVENT_IDX_MASK;
> -    if (g_hash_table_lookup(cpu->pmu_event_ctr_map,
> -                            GUINT_TO_POINTER(event_idx))) {
> +    if (riscv_pmu_htable_lookup(cpu, event_idx, &mapped_ctr_idx)) {
>           return 0;
>       }
>   
> @@ -472,8 +468,10 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
>           return;
>       }
>   
> -    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
> -                               GUINT_TO_POINTER(evt_idx)));
> +    if (!riscv_pmu_htable_lookup(cpu, evt_idx, &ctr_idx)) {
> +        return;
> +    }
> +
>       if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
>           return;
>       }
> 

