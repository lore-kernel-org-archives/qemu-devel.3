Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59015C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 15:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLOsj-00008t-1a; Sun, 23 Jun 2024 11:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sLOsi-00008i-0R
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 11:11:52 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sLOse-0001F3-JH
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 11:11:51 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3DF564E6001;
 Sun, 23 Jun 2024 17:11:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id I17b5quDWH91; Sun, 23 Jun 2024 17:11:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4308D4E6000; Sun, 23 Jun 2024 17:11:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 41462746E3B;
 Sun, 23 Jun 2024 17:11:42 +0200 (CEST)
Date: Sun, 23 Jun 2024 17:11:42 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, laurent@vivier.eu
Subject: Re: [PATCH 1/2] target/m68k: implement do_unaligned_access callback
 for m68k CPUs
In-Reply-To: <20240623115704.315645-2-mark.cave-ayland@ilande.co.uk>
Message-ID: <fa494396-c0a8-3799-92c4-b9832dc3445b@eik.bme.hu>
References: <20240623115704.315645-1-mark.cave-ayland@ilande.co.uk>
 <20240623115704.315645-2-mark.cave-ayland@ilande.co.uk>
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

On Sun, 23 Jun 2024, Mark Cave-Ayland wrote:
> For m68k CPUs that do not support unaligned accesses, any such access should
> cause the CPU to raise an Address Error exception.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
> target/m68k/cpu.c       |  1 +
> target/m68k/cpu.h       |  4 ++++
> target/m68k/op_helper.c | 11 +++++++++++
> 3 files changed, 16 insertions(+)
>
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index efd6bbded8..25e95f9f68 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -538,6 +538,7 @@ static const TCGCPUOps m68k_tcg_ops = {
>     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
>     .do_interrupt = m68k_cpu_do_interrupt,
>     .do_transaction_failed = m68k_cpu_transaction_failed,
> +    .do_unaligned_access = m68k_cpu_do_unaligned_access,
> #endif /* !CONFIG_USER_ONLY */

Why is it sysemu only? Shouldn't user mode cpu only emulation do the same? 
I also don't get how this is restricted to pre 68020 CPUs or account for 
differences between data and inst fetch on 20+ but I may be missing 
somerhing as I don't know this code or 68k behaviour well. So this is just 
a question, I'm not saying it's wrong but I don't understand why it's 
right.

Regards,
BALATON Zoltan

> };
>
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index b5bbeedb7a..d4c9531b1c 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -590,6 +590,10 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
>                                  unsigned size, MMUAccessType access_type,
>                                  int mmu_idx, MemTxAttrs attrs,
>                                  MemTxResult response, uintptr_t retaddr);
> +G_NORETURN void m68k_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> +                                             MMUAccessType access_type,
> +                                             int mmu_idx,
> +                                             uintptr_t retaddr);
> #endif
>
> #include "exec/cpu-all.h"
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index 15bad5dd46..417b691d8d 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -558,6 +558,17 @@ raise_exception_format2(CPUM68KState *env, int tt, int ilen, uintptr_t raddr)
>     cpu_loop_exit(cs);
> }
>
> +#if !defined(CONFIG_USER_ONLY)
> +G_NORETURN void m68k_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> +                                             MMUAccessType access_type,
> +                                             int mmu_idx, uintptr_t retaddr)
> +{
> +    CPUM68KState *env = cpu_env(cs);
> +
> +    raise_exception(env, EXCP_ADDRESS);
> +}
> +#endif
> +
> void HELPER(divuw)(CPUM68KState *env, int destr, uint32_t den, int ilen)
> {
>     uint32_t num = env->dregs[destr];
>

