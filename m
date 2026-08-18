Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA459C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHUQ-0006vZ-Nd; Tue, 18 Aug 2026 06:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wwHUO-0006uW-Vt
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 06:56:17 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wwHUN-0002Aj-B1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 06:56:16 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3B48458349E;
 Tue, 18 Aug 2026 12:56:14 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 0ApgKiEWO-6Z; Tue, 18 Aug 2026 12:56:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D7F39583492; Tue, 18 Aug 2026 12:56:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D687A583224;
 Tue, 18 Aug 2026 12:56:11 +0200 (CEST)
Date: Tue, 18 Aug 2026 12:56:11 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: 54weasels <54weasels@gmail.com>
cc: qemu-devel@nongnu.org, laurent@vivier.eu
Subject: Re: [PATCH v4 3/6] target/m68k: Fix NMI pending for Level 7 interrupts
In-Reply-To: <20260818022225.31801-4-54weasels@gmail.com>
Message-ID: <42bbf4b2-8491-0f2a-f8c1-c07870c73189@eik.bme.hu>
References: <20260818022225.31801-1-54weasels@gmail.com>
 <20260818022225.31801-4-54weasels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 17 Aug 2026, 54weasels wrote:
> High level description:
> Level 7 interrupts are Non-Maskable Interrupts (NMI) on the M68k architecture. The hardware asserts an NMI only on the rising edge of the level 7 signal. The current QEMU implementation treats level 7 like a standard level interrupt. This patch ensures proper NMI edge-triggered semantics for level 7, which is strictly required by the Sun-3 keyboard/mouse NMI routing logic.
>
> Impact on existing functionality:
> Corrects NMI edge-triggering for all M68k boards, adhering closely to the Motorola specifications. Existing boards will now correctly require an edge transition to trigger consecutive NMIs.
>
> Context: This patch was originally submitted as part of the monolithic Sun-3 Machine Emulation series (https://patchew.org/QEMU/20260503015756.99176-1-54weasels@gmail.com/) and has been split into atomic components.
> ---
> target/m68k/cpu.h       |  1 +
> target/m68k/helper.c    |  6 ++++++
> target/m68k/op_helper.c | 14 ++++++--------
> 3 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 7cf3791108..058777b891 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -148,6 +148,7 @@ typedef struct CPUArchState {
>
>     int pending_vector;
>     int pending_level;
> +    bool nmi_pending;

What's the difference between nmi_pending and pending_level == 7? If 
nothing do we need a new variable for it or could just test pending_level?

Regards,
BALATON Zoltan

>     /* Fields up to this point are cleared by a CPU reset */
>     struct {} end_reset_fields;
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 68f523ea84..93739ccda7 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -949,6 +949,12 @@ void m68k_set_irq_level(M68kCPU *cpu, int level, uint8_t vector)
>     CPUState *cs = CPU(cpu);
>     CPUM68KState *env = &cpu->env;
>
> +    if (level == 7 && env->pending_level != 7) {
> +        env->nmi_pending = true;
> +    } else if (level != 7) {
> +        env->nmi_pending = false;
> +    }
> +
>     env->pending_level = level;
>     env->pending_vector = vector;
>     if (level) {
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index 38f7a68981..30af4a2631 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -522,14 +522,12 @@ bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> {
>     CPUM68KState *env = cpu_env(cs);
>
> -    if (interrupt_request & CPU_INTERRUPT_HARD
> -        && ((env->sr & SR_I) >> SR_I_SHIFT) < env->pending_level) {
> -        /*
> -         * Real hardware gets the interrupt vector via an IACK cycle
> -         * at this point.  Current emulated hardware doesn't rely on
> -         * this, so we provide/save the vector when the interrupt is
> -         * first signalled.
> -         */
> +    if (env->nmi_pending) {
> +        env->nmi_pending = false;
> +        cs->exception_index = env->pending_vector;
> +        do_interrupt_m68k_hardirq(env);
> +        return true;
> +    } else if (((env->sr & SR_I) >> SR_I_SHIFT) < env->pending_level) {
>         cs->exception_index = env->pending_vector;
>         do_interrupt_m68k_hardirq(env);
>         return true;
>

