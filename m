Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A15C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 11:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s91Ju-0008Ld-V9; Mon, 20 May 2024 07:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s91Jr-0008Kt-OH; Mon, 20 May 2024 07:36:44 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s91Jp-0005LO-Ok; Mon, 20 May 2024 07:36:43 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9A16C4E602E;
 Mon, 20 May 2024 13:36:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id KSg2ZRnrO7Ng; Mon, 20 May 2024 13:36:36 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A05B84E6000; Mon, 20 May 2024 13:36:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9E9E27470B7;
 Mon, 20 May 2024 13:36:36 +0200 (CEST)
Date: Mon, 20 May 2024 13:36:36 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: npiggin@gmail.com, qemu-ppc@nongnu.org, danielhb413@gmail.com, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH 4/6] target/ppc: optimize p9 exception handling
 routines
In-Reply-To: <06c687a4-d67e-644d-da99-5e0f10b0993c@eik.bme.hu>
Message-ID: <6a401192-c4b5-4253-98ed-148ea43e7dc0@eik.bme.hu>
References: <20240520103329.381158-1-harshpb@linux.ibm.com>
 <20240520103329.381158-5-harshpb@linux.ibm.com>
 <06c687a4-d67e-644d-da99-5e0f10b0993c@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 20 May 2024, BALATON Zoltan wrote:
> On Mon, 20 May 2024, Harsh Prateek Bora wrote:
>> Currently, p9 exception handling has multiple if-condition checks where
>> it does an indirect access to pending_interrupts via env. Cache the
>> value during entry and reuse later to avoid multiple indirect accesses.
>> 
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>> target/ppc/excp_helper.c | 39 +++++++++++++++++++++------------------
>> 1 file changed, 21 insertions(+), 18 deletions(-)
>> 
>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>> index 0712098cf7..4f158196bb 100644
>> --- a/target/ppc/excp_helper.c
>> +++ b/target/ppc/excp_helper.c
>> @@ -1844,8 +1844,10 @@ static int p8_next_unmasked_interrupt(CPUPPCState 
>> *env)
>> 
>> static int p9_interrupt_powersave(CPUPPCState *env)
>> {
>> +    uint32_t pending_interrupts = env->pending_interrupts;
>> +
>
> LPCR also seems to be used a lot and other similar *_powersave functions only 
> use pending_interrupts and LPCR so maybe you could change these functions to 
> take the pending_interrupts and lpcr as parameters and pass them from the 
> caller that already have it so even this dereference could be saved?

(In that case this patch may need to be split in two as well.)

Regards,
BALATON Zoltan

>>     /* External Exception */
>> -    if ((env->pending_interrupts & PPC_INTERRUPT_EXT) &&
>> +    if ((pending_interrupts & PPC_INTERRUPT_EXT) &&
>>         (env->spr[SPR_LPCR] & LPCR_EEE)) {
>>         bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
>>         if (!heic || !FIELD_EX64_HV(env->msr) ||
>> @@ -1854,35 +1856,35 @@ static int p9_interrupt_powersave(CPUPPCState *env)
>>         }
>>     }
>>     /* Decrementer Exception */
>> -    if ((env->pending_interrupts & PPC_INTERRUPT_DECR) &&
>> +    if ((pending_interrupts & PPC_INTERRUPT_DECR) &&
>>         (env->spr[SPR_LPCR] & LPCR_DEE)) {
>>         return PPC_INTERRUPT_DECR;
>>     }
>>     /* Machine Check or Hypervisor Maintenance Exception */
>>     if (env->spr[SPR_LPCR] & LPCR_OEE) {
>> -        if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
>> +        if (pending_interrupts & PPC_INTERRUPT_MCK) {
>>             return PPC_INTERRUPT_MCK;
>>         }
>> -        if (env->pending_interrupts & PPC_INTERRUPT_HMI) {
>> +        if (pending_interrupts & PPC_INTERRUPT_HMI) {
>>             return PPC_INTERRUPT_HMI;
>>         }
>>     }
>>     /* Privileged Doorbell Exception */
>> -    if ((env->pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
>> +    if ((pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
>>         (env->spr[SPR_LPCR] & LPCR_PDEE)) {
>>         return PPC_INTERRUPT_DOORBELL;
>>     }
>>     /* Hypervisor Doorbell Exception */
>> -    if ((env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
>> +    if ((pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
>>         (env->spr[SPR_LPCR] & LPCR_HDEE)) {
>>         return PPC_INTERRUPT_HDOORBELL;
>>     }
>>     /* Hypervisor virtualization exception */
>> -    if ((env->pending_interrupts & PPC_INTERRUPT_HVIRT) &&
>> +    if ((pending_interrupts & PPC_INTERRUPT_HVIRT) &&
>>         (env->spr[SPR_LPCR] & LPCR_HVEE)) {
>>         return PPC_INTERRUPT_HVIRT;
>>     }
>> -    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
>> +    if (pending_interrupts & PPC_INTERRUPT_RESET) {
>>         return PPC_INTERRUPT_RESET;
>>     }
>>     return 0;
>> @@ -1891,11 +1893,12 @@ static int p9_interrupt_powersave(CPUPPCState *env)
>> static int p9_next_unmasked_interrupt(CPUPPCState *env)
>> {
>>     CPUState *cs = env_cpu(env);
>> +    uint32_t pending_interrupts = env->pending_interrupts;
>>
>>     /* Ignore MSR[EE] when coming out of some power management states */
>>     bool msr_ee = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
>> 
>> -    assert((env->pending_interrupts & P9_UNUSED_INTERRUPTS) == 0);
>> +    assert((pending_interrupts & P9_UNUSED_INTERRUPTS) == 0);
>>
>>     if (cs->halted) {
>>         if (env->spr[SPR_PSSCR] & PSSCR_EC) {
>> @@ -1914,12 +1917,12 @@ static int p9_next_unmasked_interrupt(CPUPPCState 
>> *env)
>>     }
>>
>>     /* Machine check exception */
>> -    if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
>> +    if (pending_interrupts & PPC_INTERRUPT_MCK) {
>>         return PPC_INTERRUPT_MCK;
>>     }
>>
>>     /* Hypervisor decrementer exception */
>> -    if (env->pending_interrupts & PPC_INTERRUPT_HDECR) {
>> +    if (pending_interrupts & PPC_INTERRUPT_HDECR) {
>>         /* LPCR will be clear when not supported so this will work */
>>         bool hdice = !!(env->spr[SPR_LPCR] & LPCR_HDICE);
>>         if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hdice) {
>> @@ -1929,7 +1932,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState 
>> *env)
>>     }
>>
>>     /* Hypervisor virtualization interrupt */
>> -    if (env->pending_interrupts & PPC_INTERRUPT_HVIRT) {
>> +    if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
>>         /* LPCR will be clear when not supported so this will work */
>>         bool hvice = !!(env->spr[SPR_LPCR] & LPCR_HVICE);
>>         if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hvice) {
>> @@ -1938,7 +1941,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState 
>> *env)
>>     }
>>
>>     /* External interrupt can ignore MSR:EE under some circumstances */
>> -    if (env->pending_interrupts & PPC_INTERRUPT_EXT) {
>> +    if (pending_interrupts & PPC_INTERRUPT_EXT) {
>>         bool lpes0 = !!(env->spr[SPR_LPCR] & LPCR_LPES0);
>>         bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
>>         /* HEIC blocks delivery to the hypervisor */
>> @@ -1950,20 +1953,20 @@ static int p9_next_unmasked_interrupt(CPUPPCState 
>> *env)
>>     }
>>     if (msr_ee != 0) {
>>         /* Decrementer exception */
>> -        if (env->pending_interrupts & PPC_INTERRUPT_DECR) {
>> +        if (pending_interrupts & PPC_INTERRUPT_DECR) {
>>             return PPC_INTERRUPT_DECR;
>>         }
>> -        if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
>> +        if (pending_interrupts & PPC_INTERRUPT_DOORBELL) {
>>             return PPC_INTERRUPT_DOORBELL;
>>         }
>> -        if (env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
>> +        if (pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
>>             return PPC_INTERRUPT_HDOORBELL;
>>         }
>> -        if (env->pending_interrupts & PPC_INTERRUPT_PERFM) {
>> +        if (pending_interrupts & PPC_INTERRUPT_PERFM) {
>>             return PPC_INTERRUPT_PERFM;
>>         }
>>         /* EBB exception */
>> -        if (env->pending_interrupts & PPC_INTERRUPT_EBB) {
>> +        if (pending_interrupts & PPC_INTERRUPT_EBB) {
>>             /*
>>              * EBB exception must be taken in problem state and
>>              * with BESCR_GE set.
>> 
>
>

