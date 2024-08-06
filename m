Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDBFC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 18:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbPAK-0006Np-FV; Tue, 06 Aug 2024 14:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sbPAI-0006LI-GT; Tue, 06 Aug 2024 14:44:10 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sbPAG-00005D-4a; Tue, 06 Aug 2024 14:44:10 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2A89F4E6001;
 Tue, 06 Aug 2024 20:44:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id o0Kib1wczARJ; Tue,  6 Aug 2024 20:44:01 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 366D44E6000; Tue, 06 Aug 2024 20:44:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 34B2F74577C;
 Tue, 06 Aug 2024 20:44:01 +0200 (CEST)
Date: Tue, 6 Aug 2024 20:44:01 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 7/7] target/ppc: Fix VRMA to not check virtual page class
 key protection
In-Reply-To: <20240806131318.275109-8-npiggin@gmail.com>
Message-ID: <e148b6ed-4569-4ce0-2994-bdb9a31a4515@eik.bme.hu>
References: <20240806131318.275109-1-npiggin@gmail.com>
 <20240806131318.275109-8-npiggin@gmail.com>
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

On Tue, 6 Aug 2024, Nicholas Piggin wrote:
> Hash virtual real mode addressing is defined by the architecture
> to not perform virtual page class key protection checks.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> target/ppc/mmu-hash64.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 5e1983e334..c8c2f8910a 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -993,6 +993,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>     int exec_prot, pp_prot, amr_prot, prot;
>     int need_prot;
>     hwaddr raddr;
> +    bool vrma = false;
>
>     /*
>      * Note on LPCR usage: 970 uses HID4, but our special variant of
> @@ -1022,6 +1023,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>             }
>         } else if (ppc_hash64_use_vrma(env)) {
>             /* Emulated VRMA mode */
> +            vrma = true;
>             slb = &vrma_slbe;
>             if (build_vrma_slbe(cpu, slb) != 0) {
>                 /* Invalid VRMA setup, machine check */
> @@ -1136,7 +1138,12 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>
>     exec_prot = ppc_hash64_pte_noexec_guard(cpu, pte);
>     pp_prot = ppc_hash64_pte_prot(mmu_idx, slb, pte);
> -    amr_prot = ppc_hash64_amr_prot(cpu, pte);
> +    if (vrma) {
> +        /* VRMA does not check keys */
> +        amr_prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;

This can be shortened as PAGE_RWX which I think is simpler but does not 
have to be, only if you want. With that you could also shorten the if to a 
ternary operator as

amr_prot = vrma ? PAGE_RWX : ppc_hash64_amr_prot(cpu, pte);

and save some lines.

Regards,
BALATON Zoltan

> +    } else {
> +        amr_prot = ppc_hash64_amr_prot(cpu, pte);
> +    }
>     prot = exec_prot & pp_prot & amr_prot;
>
>     need_prot = check_prot_access_type(PAGE_RWX, access_type);
>

