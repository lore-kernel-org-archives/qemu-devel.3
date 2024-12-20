Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08756E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 09:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOZS3-0002Q9-LX; Fri, 20 Dec 2024 04:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1tOZS2-0002Pz-G3
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 04:37:42 -0500
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1tOZS0-0000Ea-J4
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 04:37:42 -0500
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id EAB64A013F; Fri, 20 Dec 2024 10:29:30 +0100 (CET)
Date: Fri, 20 Dec 2024 10:29:30 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/5] spapr: Fix vpa dispatch count for record-replay
In-Reply-To: <4b3897e1-c9dd-45aa-bb6f-d8679fc78d25@linux.ibm.com>
Message-ID: <alpine.LMD.2.03.2412201027180.18242@eik.bme.hu>
References: <20241219034035.1826173-1-npiggin@gmail.com>
 <20241219034035.1826173-3-npiggin@gmail.com>
 <4b3897e1-c9dd-45aa-bb6f-d8679fc78d25@linux.ibm.com>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 20 Dec 2024, Harsh Prateek Bora wrote:
> Hi Nick,
>
> On 12/19/24 09:10, Nicholas Piggin wrote:
>> The dispatch count is a field in guest memory that the hypervisor
>> increments when preempting and dispatching the guest. This was not
>> being done deterministically with respect to icount, because tcg
>> exec exit is not deterministic (e.g., an async event could cause it).
>> 
>> Change vpa dispatch count increment to keep track of whether the
>> vCPU is considered dispatched or not, and only consider it preempted
>> when calling cede / confer / join / stop-self / etc.
>> 
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   include/hw/ppc/spapr_cpu_core.h |  3 +++
>>   hw/ppc/spapr.c                  | 36 ++-------------------------------
>>   hw/ppc/spapr_hcall.c            | 33 ++++++++++++++++++++++++++++++
>>   hw/ppc/spapr_rtas.c             |  1 +
>>   4 files changed, 39 insertions(+), 34 deletions(-)
>> 
>
> <snipped>
>
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 5e1d020e3df..907e09c2c36 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -487,6 +487,36 @@ static target_ulong h_register_vpa(PowerPCCPU *cpu, 
>> SpaprMachineState *spapr,
>>       return ret;
>>   }
>>   +void vpa_dispatch(CPUState *cs, SpaprCpuState *spapr_cpu, bool dispatch)
>> +{
>> +    uint32_t counter;
>> +
>> +    if (!dispatch) {
>> +        assert(spapr_cpu->dispatched);
>> +    } else {
>> +        assert(!spapr_cpu->dispatched);
>> +    }
>
> Would it look better as:
>       assert(!(dispatch == spapr_cpu->dispatched));

That's more cryptic than the one above. Maybe with ternary operator to 
avoid the if? Like
assert(dispatch ? spapr_cpu->dispatched : !spapr_cpu->dispatched)

Regards,
BALATON Zoltan

>> +    spapr_cpu->dispatched = dispatch;
>> +
>> +    return;
>
> Returning here unconditionally makes below code unreachable.
>
>> +
>> +    if (!spapr_cpu->vpa_addr) {
>> +        return;
>> +    }
>
> This could be moved to beginning or just after assert.
>
> regards,
> Harsh
>
>> +
>> +    /* These are only called by TCG, KVM maintains dispatch state */
>> +    counter = ldl_be_phys(cs->as, spapr_cpu->vpa_addr + 
>> VPA_DISPATCH_COUNTER);
>> +    counter++;
>> +    if ((counter & 1) != dispatch) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "VPA: incorrect dispatch counter value for "
>> +                      "%s partition %u, correcting.\n",
>> +                      dispatch ? "preempted" : "running", counter);
>> +        counter++;
>> +    }
>> +    stl_be_phys(cs->as, spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, 
>> counter);
>> +}
>> +
>>   static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>                              target_ulong opcode, target_ulong *args)
>>   {
>> @@ -505,6 +535,7 @@ static target_ulong h_cede(PowerPCCPU *cpu, 
>> SpaprMachineState *spapr,
>>         if (!cpu_has_work(cs)) {
>>           cs->halted = 1;
>> +        vpa_dispatch(cs, spapr_cpu, false);
>>           cs->exception_index = EXCP_HLT;
>>           cs->exit_request = 1;
>>           ppc_maybe_interrupt(env);
>> @@ -531,6 +562,8 @@ static target_ulong h_confer_self(PowerPCCPU *cpu)
>>       cs->exit_request = 1;
>>       ppc_maybe_interrupt(&cpu->env);
>>   +    vpa_dispatch(cs, spapr_cpu, false);
>> +
>>       return H_SUCCESS;
>>   }
>>   diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index f329693c554..8ce42302234 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -216,6 +216,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, 
>> SpaprMachineState *spapr,
>>        */
>>       env->spr[SPR_PSSCR] |= PSSCR_EC;
>>       cs->halted = 1;
>> +    vpa_dispatch(cs, spapr_cpu_state(cpu), false);
>>       ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
>>       kvmppc_set_reg_ppc_online(cpu, 0);
>>       qemu_cpu_kick(cs);
>
>

