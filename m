Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86838C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTlT8-0008OM-4n; Tue, 16 Jul 2024 12:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTlSw-0007L5-4K; Tue, 16 Jul 2024 12:55:51 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTlSi-0003x1-B5; Tue, 16 Jul 2024 12:55:47 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WNlYt3Szzz4wbh;
 Wed, 17 Jul 2024 02:55:30 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WNlYr3BNYz4w2D;
 Wed, 17 Jul 2024 02:55:28 +1000 (AEST)
Message-ID: <80117c9b-56d6-4a88-9642-9dd965fc7077@kaod.org>
Date: Tue, 16 Jul 2024 18:55:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/19] target/ppc: Fix msgsnd for POWER8
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240716162617.32161-1-npiggin@gmail.com>
 <20240716162617.32161-2-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240716162617.32161-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, SPF_HELO_PASS=-0.001,
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

On 7/16/24 18:25, Nicholas Piggin wrote:
> POWER8 (ISA v2.07S) introduced the doorbell facility, the msgsnd
> instruction behaved mostly like msgsndp, it was addressed by TIR
> and could only send interrupts between threads on the core.
> 
> ISA v3.0 changed msgsnd to be addressed by PIR and can interrupt
> any thread in the system.
> 
> msgsnd only implements the v3.0 semantics, which can make
> multi-threaded POWER8 hang when booting Linux (due to IPIs
> failing). This change adds v2.07 semantics.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   target/ppc/excp_helper.c | 74 ++++++++++++++++++++++++----------------
>   1 file changed, 44 insertions(+), 30 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 0a9e8539a4..5368bf2ff3 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -3007,6 +3007,41 @@ static inline bool dbell_bcast_subproc(target_ulong rb)
>       return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_SUBPROC;
>   }
>   
> +/*
> + * Send an interrupt to a thread in the same core as env).
> + */
> +static void msgsnd_core_tir(CPUPPCState *env, uint32_t target_tir, int irq)
> +{
> +    PowerPCCPU *cpu = env_archcpu(env);
> +    CPUState *cs = env_cpu(env);
> +    uint32_t nr_threads = cs->nr_threads;
> +
> +    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> +        nr_threads = 1; /* msgsndp behaves as 1-thread in LPAR-per-thread mode*/
> +    }
> +
> +    if (target_tir >= nr_threads) {
> +        return;
> +    }
> +
> +    if (nr_threads == 1) {
> +        ppc_set_irq(cpu, irq, 1);
> +    } else {
> +        CPUState *ccs;
> +
> +        /* Does iothread need to be locked for walking CPU list? */
> +        bql_lock();
> +        THREAD_SIBLING_FOREACH(cs, ccs) {
> +            PowerPCCPU *ccpu = POWERPC_CPU(ccs);
> +            if (target_tir == ppc_cpu_tir(ccpu)) {
> +                ppc_set_irq(ccpu, irq, 1);
> +                break;
> +            }
> +        }
> +        bql_unlock();
> +    }
> +}
> +
>   void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
>   {
>       if (!dbell_type_server(rb)) {
> @@ -3027,6 +3062,13 @@ void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
>           return;
>       }
>   
> +    /* POWER8 msgsnd is like msgsndp (targets a thread within core) */
> +    if (!(env->insns_flags2 & PPC2_ISA300)) {
> +        msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_HDOORBELL);
> +        return;
> +    }
> +
> +    /* POWER9 and later msgsnd is a global (targets any thread) */
>       cpu = ppc_get_vcpu_by_pir(pir);
>       if (!cpu) {
>           return;
> @@ -3073,41 +3115,13 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
>    */
>   void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
>   {
> -    CPUState *cs = env_cpu(env);
> -    PowerPCCPU *cpu = env_archcpu(env);
> -    CPUState *ccs;
> -    uint32_t nr_threads = cs->nr_threads;
> -    int ttir = rb & PPC_BITMASK(57, 63);
> -
>       helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSGP);
>   
> -    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> -        nr_threads = 1; /* msgsndp behaves as 1-thread in LPAR-per-thread mode*/
> -    }
> -
> -    if (!dbell_type_server(rb) || ttir >= nr_threads) {
> -        return;
> -    }
> -
> -    if (nr_threads == 1) {
> -        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, 1);
> +    if (!dbell_type_server(rb)) {
>           return;
>       }
>   
> -    /* Does iothread need to be locked for walking CPU list? */
> -    bql_lock();
> -    THREAD_SIBLING_FOREACH(cs, ccs) {
> -        PowerPCCPU *ccpu = POWERPC_CPU(ccs);
> -        uint32_t thread_id = ppc_cpu_tir(ccpu);
> -
> -        if (ttir == thread_id) {
> -            ppc_set_irq(ccpu, PPC_INTERRUPT_DOORBELL, 1);
> -            bql_unlock();
> -            return;
> -        }
> -    }
> -
> -    g_assert_not_reached();
> +    msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_DOORBELL);
>   }
>   #endif /* TARGET_PPC64 */
>   


