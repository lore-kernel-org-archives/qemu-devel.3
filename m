Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D836FA374A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 12:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp5lJ-0006tn-B5; Fri, 13 Sep 2024 08:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sp5lH-0006st-LL; Fri, 13 Sep 2024 08:50:55 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sp5lF-0007Bb-20; Fri, 13 Sep 2024 08:50:54 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8CA2D4E602B;
 Fri, 13 Sep 2024 14:50:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id jLmQqVCo83cq; Fri, 13 Sep 2024 14:50:47 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8445C4E6004; Fri, 13 Sep 2024 14:50:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7F6F4746F60;
 Fri, 13 Sep 2024 14:50:47 +0200 (CEST)
Date: Fri, 13 Sep 2024 14:50:47 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com, 
 danielhb413@gmail.com
Subject: Re: [PATCH v3 09/10] target/ppc: simplify var usage in
 ppc_next_unmasked_interrupt
In-Reply-To: <20240913041337.912876-10-harshpb@linux.ibm.com>
Message-ID: <e09919a0-061d-90e0-8107-68e509ce08aa@eik.bme.hu>
References: <20240913041337.912876-1-harshpb@linux.ibm.com>
 <20240913041337.912876-10-harshpb@linux.ibm.com>
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

On Fri, 13 Sep 2024, Harsh Prateek Bora wrote:
> As previously done for arch specific handlers, simplify var usage in
> ppc_next_unmasked_interrupt by caching the env->pending_interrupts and
> env->spr[SPR_LPCR] in local vars and using it later at multiple places.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
> target/ppc/excp_helper.c | 54 ++++++++++++++++++++--------------------
> 1 file changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index d0e0f609a0..4eeeedff5b 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -2022,31 +2022,31 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
>
> static int ppc_next_unmasked_interrupt(CPUPPCState *env)
> {
> +    uint32_t pending_interrupts = env->pending_interrupts;
> +    target_ulong lpcr = env->spr[SPR_LPCR];
> +    bool async_deliver;

Maybe easier to review if split into one patch for each variable added so 
it's easier to see what's replaced and that nothing is missed.

Regards,
BALATON Zoltan

> +
> #ifdef TARGET_PPC64
>     switch (env->excp_model) {
>     case POWERPC_EXCP_POWER7:
> -        return p7_next_unmasked_interrupt(env, env->pending_interrupts,
> -                                          env->spr[SPR_LPCR]);
> +        return p7_next_unmasked_interrupt(env, pending_interrupts, lpcr);
>     case POWERPC_EXCP_POWER8:
> -        return p8_next_unmasked_interrupt(env, env->pending_interrupts,
> -                                          env->spr[SPR_LPCR]);
> +        return p8_next_unmasked_interrupt(env, pending_interrupts, lpcr);
>     case POWERPC_EXCP_POWER9:
>     case POWERPC_EXCP_POWER10:
>     case POWERPC_EXCP_POWER11:
> -        return p9_next_unmasked_interrupt(env, env->pending_interrupts,
> -			                  env->spr[SPR_LPCR]);
> +        return p9_next_unmasked_interrupt(env, pending_interrupts, lpcr);
>     default:
>         break;
>     }
> #endif
> -    bool async_deliver;
>
>     /* External reset */
> -    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
> +    if (pending_interrupts & PPC_INTERRUPT_RESET) {
>         return PPC_INTERRUPT_RESET;
>     }
>     /* Machine check exception */
> -    if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
> +    if (pending_interrupts & PPC_INTERRUPT_MCK) {
>         return PPC_INTERRUPT_MCK;
>     }
> #if 0 /* TODO */
> @@ -2065,9 +2065,9 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
>     async_deliver = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
>
>     /* Hypervisor decrementer exception */
> -    if (env->pending_interrupts & PPC_INTERRUPT_HDECR) {
> +    if (pending_interrupts & PPC_INTERRUPT_HDECR) {
>         /* LPCR will be clear when not supported so this will work */
> -        bool hdice = !!(env->spr[SPR_LPCR] & LPCR_HDICE);
> +        bool hdice = !!(lpcr & LPCR_HDICE);
>         if ((async_deliver || !FIELD_EX64_HV(env->msr)) && hdice) {
>             /* HDEC clears on delivery */
>             return PPC_INTERRUPT_HDECR;
> @@ -2075,18 +2075,18 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
>     }
>
>     /* Hypervisor virtualization interrupt */
> -    if (env->pending_interrupts & PPC_INTERRUPT_HVIRT) {
> +    if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
>         /* LPCR will be clear when not supported so this will work */
> -        bool hvice = !!(env->spr[SPR_LPCR] & LPCR_HVICE);
> +        bool hvice = !!(lpcr & LPCR_HVICE);
>         if ((async_deliver || !FIELD_EX64_HV(env->msr)) && hvice) {
>             return PPC_INTERRUPT_HVIRT;
>         }
>     }
>
>     /* External interrupt can ignore MSR:EE under some circumstances */
> -    if (env->pending_interrupts & PPC_INTERRUPT_EXT) {
> -        bool lpes0 = !!(env->spr[SPR_LPCR] & LPCR_LPES0);
> -        bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
> +    if (pending_interrupts & PPC_INTERRUPT_EXT) {
> +        bool lpes0 = !!(lpcr & LPCR_LPES0);
> +        bool heic = !!(lpcr & LPCR_HEIC);
>         /* HEIC blocks delivery to the hypervisor */
>         if ((async_deliver && !(heic && FIELD_EX64_HV(env->msr) &&
>             !FIELD_EX64(env->msr, MSR, PR))) ||
> @@ -2096,45 +2096,45 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
>     }
>     if (FIELD_EX64(env->msr, MSR, CE)) {
>         /* External critical interrupt */
> -        if (env->pending_interrupts & PPC_INTERRUPT_CEXT) {
> +        if (pending_interrupts & PPC_INTERRUPT_CEXT) {
>             return PPC_INTERRUPT_CEXT;
>         }
>     }
>     if (async_deliver != 0) {
>         /* Watchdog timer on embedded PowerPC */
> -        if (env->pending_interrupts & PPC_INTERRUPT_WDT) {
> +        if (pending_interrupts & PPC_INTERRUPT_WDT) {
>             return PPC_INTERRUPT_WDT;
>         }
> -        if (env->pending_interrupts & PPC_INTERRUPT_CDOORBELL) {
> +        if (pending_interrupts & PPC_INTERRUPT_CDOORBELL) {
>             return PPC_INTERRUPT_CDOORBELL;
>         }
>         /* Fixed interval timer on embedded PowerPC */
> -        if (env->pending_interrupts & PPC_INTERRUPT_FIT) {
> +        if (pending_interrupts & PPC_INTERRUPT_FIT) {
>             return PPC_INTERRUPT_FIT;
>         }
>         /* Programmable interval timer on embedded PowerPC */
> -        if (env->pending_interrupts & PPC_INTERRUPT_PIT) {
> +        if (pending_interrupts & PPC_INTERRUPT_PIT) {
>             return PPC_INTERRUPT_PIT;
>         }
>         /* Decrementer exception */
> -        if (env->pending_interrupts & PPC_INTERRUPT_DECR) {
> +        if (pending_interrupts & PPC_INTERRUPT_DECR) {
>             return PPC_INTERRUPT_DECR;
>         }
> -        if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
> +        if (pending_interrupts & PPC_INTERRUPT_DOORBELL) {
>             return PPC_INTERRUPT_DOORBELL;
>         }
> -        if (env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
> +        if (pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
>             return PPC_INTERRUPT_HDOORBELL;
>         }
> -        if (env->pending_interrupts & PPC_INTERRUPT_PERFM) {
> +        if (pending_interrupts & PPC_INTERRUPT_PERFM) {
>             return PPC_INTERRUPT_PERFM;
>         }
>         /* Thermal interrupt */
> -        if (env->pending_interrupts & PPC_INTERRUPT_THERM) {
> +        if (pending_interrupts & PPC_INTERRUPT_THERM) {
>             return PPC_INTERRUPT_THERM;
>         }
>         /* EBB exception */
> -        if (env->pending_interrupts & PPC_INTERRUPT_EBB) {
> +        if (pending_interrupts & PPC_INTERRUPT_EBB) {
>             /*
>              * EBB exception must be taken in problem state and
>              * with BESCR_GE set.
>

