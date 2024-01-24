Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9654C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 17:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSguJ-0004IA-MQ; Wed, 24 Jan 2024 12:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSguG-0004EY-7m
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:19:20 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSguE-0005YS-EV
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zkLxAs4kHM9h7SJkHoIou3sYZTwbSWrSUV2u3oOecq4=; b=VW3pfVvTdCOqzdS/SvifEO/uLv
 liiLYFaUX2M8dx0fmiNl10o8oOUt5qv8Gb2INmc1b3EvkFhUYdDNwRdQDfa6GO6qGIQe274oC4CK6
 Y7cyY1Oplr8bb+ETYoeEPT7Ao72Dgyu3nOsQvzlDpEWPpRP+A545qn3RZosIwp5QoeDY=;
Date: Wed, 24 Jan 2024 18:19:26 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>, 
 Claudio Fontana <cfontana@suse.de>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 9/9] target/i386: Extract x86_cpu_exec_halt() from
 accel/tcg/
Message-ID: <lf6xtka7t7mbai3g6t2lbjtjj4dsfzvvdxivs5dqmphwudjs76@6ekdkiqmxn3u>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124101639.30056-10-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/01/24, Philippe Mathieu-Daudé wrote:
> Move this x86-specific code out of the generic accel/tcg/.
> 
> Reported-by: Anton Johansson <anjo@rev.ng>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/tcg/helper-tcg.h        |  1 +
>  accel/tcg/cpu-exec.c                | 12 ------------
>  target/i386/tcg/sysemu/seg_helper.c | 13 +++++++++++++
>  target/i386/tcg/tcg-cpu.c           |  1 +
>  4 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
> index 253b1f561e..effc2c1c98 100644
> --- a/target/i386/tcg/helper-tcg.h
> +++ b/target/i386/tcg/helper-tcg.h
> @@ -39,6 +39,7 @@ QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR_SPACE_BITS);
>   */
>  void x86_cpu_do_interrupt(CPUState *cpu);
>  #ifndef CONFIG_USER_ONLY
> +void x86_cpu_exec_halt(CPUState *cpu);
>  bool x86_need_replay_interrupt(int interrupt_request);
>  bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  #endif
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 390a9644da..7662f4973d 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -30,9 +30,6 @@
>  #include "qemu/rcu.h"
>  #include "exec/log.h"
>  #include "qemu/main-loop.h"
> -#if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
> -#include "hw/i386/apic.h"
> -#endif
>  #include "sysemu/cpus.h"
>  #include "exec/cpu-all.h"
>  #include "sysemu/cpu-timers.h"
> @@ -672,15 +669,6 @@ static inline bool cpu_handle_halt(CPUClass *cc, CPUState *cpu)
>  {
>  #ifndef CONFIG_USER_ONLY
>      if (cpu->halted) {
> -#if defined(TARGET_I386)
> -        if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
> -            X86CPU *x86_cpu = X86_CPU(cpu);
> -            bql_lock();
> -            apic_poll_irq(x86_cpu->apic_state);
> -            cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
> -            bql_unlock();
> -        }
> -#endif /* TARGET_I386 */
>          if (cc->tcg_ops->cpu_exec_halt) {
>              cc->tcg_ops->cpu_exec_halt(cpu);
>          }
> diff --git a/target/i386/tcg/sysemu/seg_helper.c b/target/i386/tcg/sysemu/seg_helper.c
> index e6f42282bb..2db8083748 100644
> --- a/target/i386/tcg/sysemu/seg_helper.c
> +++ b/target/i386/tcg/sysemu/seg_helper.c
> @@ -20,6 +20,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> +#include "qemu/main-loop.h"
>  #include "cpu.h"
>  #include "exec/helper-proto.h"
>  #include "exec/cpu_ldst.h"
> @@ -127,6 +128,18 @@ void x86_cpu_do_interrupt(CPUState *cs)
>      }
>  }
>  
> +void x86_cpu_exec_halt(CPUState *cpu)
> +{
> +    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
> +        X86CPU *x86_cpu = X86_CPU(cpu);
> +
> +        bql_lock();
> +        apic_poll_irq(x86_cpu->apic_state);
> +        cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
> +        bql_unlock();
> +    }
> +}
> +
>  bool x86_need_replay_interrupt(int interrupt_request)
>  {
>      /*
> diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
> index 255d56d4c3..3028b57c97 100644
> --- a/target/i386/tcg/tcg-cpu.c
> +++ b/target/i386/tcg/tcg-cpu.c
> @@ -119,6 +119,7 @@ static const struct TCGCPUOps x86_tcg_ops = {
>  #else
>      .tlb_fill = x86_cpu_tlb_fill,
>      .do_interrupt = x86_cpu_do_interrupt,
> +    .cpu_exec_halt = x86_cpu_exec_halt,
>      .cpu_exec_interrupt = x86_cpu_exec_interrupt,
>      .do_unaligned_access = x86_cpu_do_unaligned_access,
>      .debug_excp_handler = breakpoint_handler,
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

