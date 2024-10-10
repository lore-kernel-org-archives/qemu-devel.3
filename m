Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4E2CF11F4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 13:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syt3z-0008PN-Tl; Thu, 10 Oct 2024 09:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sysXN-000216-E7; Thu, 10 Oct 2024 08:45:01 -0400
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sysXK-0004fO-Eu; Thu, 10 Oct 2024 08:45:01 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 104A7E000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1728564296; bh=F2LkddVqDsLwCSJA/oMYJpvuXR4JvXhsjqcA+c9itAg=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=t8CFuO61pbR/maOx4zrHiHhBC2zvvF9DGTysw9du3PaqPuuGM0ktBxPuP+8ebYtbQ
 0PV8q8q/RutzlMvLu5IHjYQU9EjZOFOqm5AdYq+4MaY6FD8btW1NmrDjm9pGbkM6GF
 7tDJ4ya0Y99MAgokQpzAKXbXfu5MplTouBYydSI4vHacVzQWp1y3PZqOQrOnClhRAD
 0lKERu41iYAsQ1kadHNf64Soz/LULpKjkJrvLi4w0Ebu8nUXXqei5O8yngNGeqmevI
 FM39SsUNbrdufAyZ6qHZwz+JiFpD+CZMRj0S7ALtlfhFmYcoFGh2CunZ2thcm1n58+
 CmWMTOJX1zMew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1728564296; bh=F2LkddVqDsLwCSJA/oMYJpvuXR4JvXhsjqcA+c9itAg=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=zoopUuxbGYrq74Jh1A9gJSWk8b2SA3wm93rJqghBQhotULVoUjwps/CJWukkRbd9o
 Dw2tODCLJEieItmWARkbv9IQWrsr7Q/GaZE52SLRtRY/y93IbYzvIrlV5354IHXTRw
 ftALF81F4A3IE7qkjc3Nlg+c+B3vL+1CE6RQRg6w9n0htlFnHnQ+gkTn2I5N9oEGFc
 lw79rHKSDPdz2YW6ziGA3dnAz215oHkuFYbETIJzadrXPa2U6mxWqfK8/G+nrkxiEl
 OGeVtY577kKo3Y5YkDPvPA03bhb5oGosngchjwUWNETIGDfedc+fIpKtzGJBsbgJYd
 ncQPIO6LBnRQQ==
Message-ID: <fd89dafa-279d-436c-9569-f2fdc289bac9@yadro.com>
Date: Thu, 10 Oct 2024 15:44:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/10] target/riscv: Define PMU event related
 structures
To: Atish Patra <atishp@rivosinc.com>, <qemu-riscv@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <alexei.filippov@syntacore.com>, <palmer@dabbelt.com>,
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>,
 <bin.meng@windriver.com>, <dbarboza@ventanamicro.com>,
 <alistair.francis@wdc.com>
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
 <20241009-pmu_event_machine-v1-6-dcbd7a60e3ba@rivosinc.com>
Content-Language: en-US
From: Alexei Filippov <alexei.filippov@yadro.com>
In-Reply-To: <20241009-pmu_event_machine-v1-6-dcbd7a60e3ba@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
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
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>   target/riscv/cpu.h | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 2ac391a7cf74..53426710f73e 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -189,6 +189,28 @@ typedef struct PMUFixedCtrState {
>           uint64_t counter_virt_prev[2];
>   } PMUFixedCtrState;
>   
> +typedef uint64_t (*PMU_EVENT_CYCLE_FUNC)(RISCVCPU *);
> +typedef uint64_t (*PMU_EVENT_INSTRET_FUNC)(RISCVCPU *);
> +typedef uint64_t (*PMU_EVENT_TLB_FUNC)(RISCVCPU *, MMUAccessType access_type);
> +
> +typedef struct PMUEventInfo {
> +    /* Event ID (BIT [0:55] valid) */
> +    uint64_t event_id;
> +    /* Supported hpmcounters for this event */
> +    uint32_t counter_mask;
> +    /* Bitmask of valid event bits */
> +    uint64_t event_mask;
> +} PMUEventInfo;
> +
> +typedef struct PMUEventFunc {
> +    /* Get the ID of the event that can monitor cycles */
> +    PMU_EVENT_CYCLE_FUNC get_cycle_id;
> +    /* Get the ID of the event that can monitor cycles */
> +    PMU_EVENT_INSTRET_FUNC get_intstret_id;
> +    /* Get the ID of the event that can monitor TLB events*/
> +    PMU_EVENT_TLB_FUNC get_tlb_access_id;
Ok, this is kinda interesting decision, but it's not scalable. AFAIU 
none spec provide us full enum of existing events. So anytime when 
somebody will try to implement their own pmu events they would have to 
add additional callbacks, and this structure never will be fulled 
properly. And then we ended up with structure 1000+ callback with only 5 
machines wich supports pmu events. I suggest my approach with only 
read/write callbacks, where machine can decide by itself how to handle 
any of machine specific events.
> +} PMUEventFunc;
> +
>   struct CPUArchState {
>       target_ulong gpr[32];
>       target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
> @@ -386,6 +408,9 @@ struct CPUArchState {
>       target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
>   
>       PMUFixedCtrState pmu_fixed_ctrs[2];
> +    PMUEventInfo *pmu_events;
> +    PMUEventFunc pmu_efuncs;
> +    int num_pmu_events;
>   
>       target_ulong sscratch;
>       target_ulong mscratch;
> 

