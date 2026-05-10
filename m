Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F7DCD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 05:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLwuV-0006Ex-Cw; Sun, 10 May 2026 01:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1wLwuI-0006Ef-Jx
 for qemu-devel@nongnu.org; Sun, 10 May 2026 01:40:53 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1wLwuG-0008Ne-B2
 for qemu-devel@nongnu.org; Sun, 10 May 2026 01:40:50 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 0271A240101
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 07:40:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu; s=2017;
 t=1778391643; bh=y16Wz/0q9iJ9XLAxD1DqvGybk2CTc4VexuCaTBH8n4Q=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=Z6G6Ceqh3PNsi2sKQWQwbl/IuwpmNr46I7ZX6S93NJeg+PfHYS0KUYuIngHZmIjjF
 s/mN+AeCLBRve/h8KFBbdj7ZM0W7MsU6AbJv6xarZFZK3UnsfZZVOkbpe12ubE32ll
 oyMOZvkT/gb4K/XJELVUCSywWsoSbjIK1dShRmV7hxZLY+m/qM4/oq7VpVmCJutpGA
 4U0ANpmRTiKl75bWcZrwYm83bM2ydhghfmxjWDgmWHo8RErrr6S4YFYP6UA++Rvck3
 fkV71ZRSGjzbX3cSIm6JnHHX0pYQz31T5WwLTy12ZvDWHki7qF9Ukg7LDzfvzit5+k
 1p8RqZARLlZ5w==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gCsCF2WYTz9rxK;
 Sun, 10 May 2026 07:40:41 +0200 (CEST)
Date: Sun, 10 May 2026 05:40:42 +0000
From: Thomas Huth <th.huth+qemu@posteo.eu>
To: 54weasels <54weasels@gmail.com>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, thuth@redhat.com
Subject: Re: [PATCH 1/7] target/m68k: Implement Physical Bus Error exception
 handling
Message-ID: <20260510074039.003600dd@tpx1>
In-Reply-To: <20260503015756.99176-2-54weasels@gmail.com>
References: <20260503015756.99176-1-54weasels@gmail.com>
 <20260503015756.99176-2-54weasels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth+qemu@posteo.eu;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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


 Hi!

Thanks for your patches ... some comments inline below...

Am Sat,  2 May 2026 18:57:50 -0700
schrieb 54weasels <54weasels@gmail.com>:

> The M68020 natively maps hardware Bus Error (BERR) timeouts into a Long Bus Cycle Fault (Format 0xB). This commit adds the memory exception routing to natively synthesize these EXCP_ACCESS cycle faults. It also implements the double-fault / watchdog reset behavior required for Sun-3 hardware diagnostics, properly handles FSAVE/FRESTORE for 68881 FPU stubs, and properly constructs the 84-byte internal bus fault frame.
> 
> Signed-off-by: 54weasels <54weasels@gmail.com>
> ---
>  target/m68k/cpu.c       |   5 +-
>  target/m68k/cpu.h       |  18 +++-
>  target/m68k/helper.c    | 130 ++++++++++++++++++++++++++++-
>  target/m68k/op_helper.c | 176 ++++++++++++++++++++++++++--------------
>  target/m68k/translate.c |  31 +++++--
>  5 files changed, 283 insertions(+), 77 deletions(-)
> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index d849a4a90f..af375f0bce 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

Looking at the comment at the top of this file, it clearly states that this
file is licensed under the Lesser GPL, so this change is wrong.

>  /*
>   * QEMU Motorola 68k CPU
>   *
> @@ -51,8 +52,8 @@ static TCGTBCPUState m68k_get_tb_cpu_state(CPUState *cs)
>      flags = (env->macsr >> 4) & TB_FLAGS_MACSR;
>      if (env->sr & SR_S) {
>          flags |= TB_FLAGS_MSR_S;
> -        flags |= (env->sfc << (TB_FLAGS_SFC_S_BIT - 2)) & TB_FLAGS_SFC_S;
> -        flags |= (env->dfc << (TB_FLAGS_DFC_S_BIT - 2)) & TB_FLAGS_DFC_S;
> +    flags |= (env->sfc << TB_FLAGS_SFC_S_BIT) & TB_FLAGS_SFC_S;
> +    flags |= (env->dfc << TB_FLAGS_DFC_S_BIT) & TB_FLAGS_DFC_S;

Wrong indentation now?

>      }
>      if (M68K_SR_TRACE(env->sr) == M68K_SR_TRACE_ANY_INS) {
>          flags |= TB_FLAGS_TRACE;
...
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index 8148a8852e..84d5270767 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>  /*
>   *  M68K helper routines
>   *
> @@ -25,6 +26,7 @@
>  #include "qemu/plugin.h"
>  
>  #if !defined(CONFIG_USER_ONLY)
> +#include "system/runstate.h"
>  
>  static void cf_rte(CPUM68KState *env)
>  {
> @@ -73,6 +75,12 @@ throwaway:
>          case 7:
>              sp += 52;
>              break;
> +        case 0xa: /* Short Bus Cycle Fault (Format 0xA) */
> +            sp += 32 - 8; /* 32 bytes total - 8 bytes header = 24 bytes */
> +            break;
> +        case 0xb: /* Long Bus Cycle Fault (Format 0xB) */
> +            sp += 92 - 8; /* 92 bytes total - 8 bytes header = 84 bytes */
> +            break;
>          }
>      }
>      env->aregs[7] = sp;
> @@ -342,56 +350,80 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
>      switch (cs->exception_index) {
>      case EXCP_ACCESS:
>          if (env->mmu.fault) {
> -            cpu_abort(cs, "DOUBLE MMU FAULT\n");
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "M68K: Double MMU Fault. Halting CPU and requesting reset.\n");
> +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +            cs->halted = 1;
> +            cs->exception_index = EXCP_HLT;
> +            cpu_loop_exit(cs);
>          }
>          env->mmu.fault = true;
> -        /* push data 3 */
> -        sp -= 4;
> -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> -        /* push data 2 */
> -        sp -= 4;
> -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> -        /* push data 1 */
> -        sp -= 4;
> -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> -        /* write back 1 / push data 0 */
> -        sp -= 4;
> -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> -        /* write back 1 address */
> -        sp -= 4;
> -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> -        /* write back 2 data */
> -        sp -= 4;
> -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> -        /* write back 2 address */
> -        sp -= 4;
> -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> -        /* write back 3 data */
> -        sp -= 4;
> -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> -        /* write back 3 address */
> -        sp -= 4;
> -        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
> -        /* fault address */
> -        sp -= 4;
> -        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
> -        /* write back 1 status */
> -        sp -= 2;
> -        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> -        /* write back 2 status */
> -        sp -= 2;
> -        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> -        /* write back 3 status */
> -        sp -= 2;
> -        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> -        /* special status word */
> -        sp -= 2;
> -        cpu_stw_be_mmuidx_ra(env, sp, env->mmu.ssw, MMU_KERNEL_IDX, 0);
> -        /* effective address */
> -        sp -= 4;
> -        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
> -
> -        do_stack_frame(env, &sp, 7, oldsr, 0, env->pc);
> +
> +        if (m68k_feature(env, M68K_FEATURE_M68040)) {
> +            /* push data 3 */
> +            sp -= 4;
> +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +            /* push data 2 */
> +            sp -= 4;
> +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +            /* push data 1 */
> +            sp -= 4;
> +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +            /* write back 1 / push data 0 */
> +            sp -= 4;
> +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +            /* write back 1 address */
> +            sp -= 4;
> +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +            /* write back 2 data */
> +            sp -= 4;
> +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +            /* write back 2 address */
> +            sp -= 4;
> +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +            /* write back 3 data */
> +            sp -= 4;
> +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +            /* write back 3 address */
> +            sp -= 4;
> +            cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
> +            /* fault address */
> +            sp -= 4;
> +            cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
> +            /* write back 1 status */
> +            sp -= 2;
> +            cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +            /* write back 2 status */
> +            sp -= 2;
> +            cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +            /* write back 3 status */
> +            sp -= 2;
> +            cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +            /* special status word */
> +            sp -= 2;
> +            cpu_stw_be_mmuidx_ra(env, sp, env->mmu.ssw, MMU_KERNEL_IDX, 0);
> +            /* effective address */
> +            sp -= 4;
> +            cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
> +
> +            do_stack_frame(env, &sp, 7, oldsr, 0, env->pc);
> +        } else {
> +            /* M68020 Long Bus Cycle Fault (Format 0xB) */
> +            /*
> +             * 84 bytes of internal state are pushed before the generic
> +             * 8-byte header
> +             */
> +            sp -= 84;
> +            for (int i = 0; i < 84; i += 4) {
> +                cpu_stl_be_mmuidx_ra(env, sp + i, 0, MMU_KERNEL_IDX, 0);
> +            }
> +            /* Offset 0x02 from internal frame: SSW */
> +            cpu_stw_be_mmuidx_ra(env, sp + 2, env->mmu.ssw, MMU_KERNEL_IDX, 0);
> +            /* Offset 0x08 from internal frame: Fault Address */
> +            cpu_stl_be_mmuidx_ra(env, sp + 8, env->mmu.ar, MMU_KERNEL_IDX, 0);
> +
> +            do_stack_frame(env, &sp, 0xb, oldsr, 0, env->pc);
> +        }

Your patch got quite big already and does multiple things at once ... could
you maybe split independent parts like the above fixup for the stack frame
layout into a separate patch, so that this can get reviewed more easily?

> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index abc1c79f3c..d6fcd6c4d9 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

This file is also LPGL, not GPL.

 Thomas

