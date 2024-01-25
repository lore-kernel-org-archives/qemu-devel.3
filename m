Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD91C48285
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 10:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSx8T-0000qH-1G; Thu, 25 Jan 2024 05:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Usek=JD=kaod.org=clg@ozlabs.org>)
 id 1rSx8R-0000oS-HQ; Thu, 25 Jan 2024 05:39:03 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Usek=JD=kaod.org=clg@ozlabs.org>)
 id 1rSx8O-0002gJ-MP; Thu, 25 Jan 2024 05:39:03 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLHP9649Wz4x5r;
 Thu, 25 Jan 2024 21:38:53 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLHP66Yfyz4wc8;
 Thu, 25 Jan 2024 21:38:50 +1100 (AEDT)
Message-ID: <0f62f45b-7b1d-49d3-adaa-9ceb76de1a5d@kaod.org>
Date: Thu, 25 Jan 2024 11:38:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/ppc: Fix 440 tlbwe TLB invalidation gaps
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <20240117151238.93323-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240117151238.93323-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Usek=JD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/17/24 16:12, Nicholas Piggin wrote:
> The 440 software TLB write entry misses several cases that must flush
> the TCG TLB:
> - If the new size is smaller than the existing size, the EA no longer
>    covered should be flushed. This looks like an inverted inequality test.
> - If the TLB PID changes.
> - If the TLB attr bit 0 (translation address space) changes.
> - If low prot (access control) bits change.
> 
> Fix this by removing tricks to avoid TLB flushes, and just invalidate
> the TLB if any valid entry is being changed, similarly to 4xx.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Acked-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

PS: A cover letter would have been nice :) I couldn't find it.


> ---
>   target/ppc/mmu_helper.c | 35 ++++++++++-------------------------
>   1 file changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index f87d35379a..c140f3c96d 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -855,49 +855,34 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
>                         target_ulong value)
>   {
>       ppcemb_tlb_t *tlb;
> -    target_ulong EPN, RPN, size;
> -    int do_flush_tlbs;
>   
>       qemu_log_mask(CPU_LOG_MMU, "%s word %d entry %d value " TARGET_FMT_lx "\n",
>                     __func__, word, (int)entry, value);
> -    do_flush_tlbs = 0;
>       entry &= 0x3F;
>       tlb = &env->tlb.tlbe[entry];
> +
> +    /* Invalidate previous TLB (if it's valid) */
> +    if (tlb->prot & PAGE_VALID) {
> +        tlb_flush(env_cpu(env));
> +    }
> +
>       switch (word) {
>       default:
>           /* Just here to please gcc */
>       case 0:
> -        EPN = value & 0xFFFFFC00;
> -        if ((tlb->prot & PAGE_VALID) && EPN != tlb->EPN) {
> -            do_flush_tlbs = 1;
> -        }
> -        tlb->EPN = EPN;
> -        size = booke_tlb_to_page_size((value >> 4) & 0xF);
> -        if ((tlb->prot & PAGE_VALID) && tlb->size < size) {
> -            do_flush_tlbs = 1;
> -        }
> -        tlb->size = size;
> +        tlb->EPN = value & 0xFFFFFC00;
> +        tlb->size = booke_tlb_to_page_size((value >> 4) & 0xF);
>           tlb->attr &= ~0x1;
>           tlb->attr |= (value >> 8) & 1;
>           if (value & 0x200) {
>               tlb->prot |= PAGE_VALID;
>           } else {
> -            if (tlb->prot & PAGE_VALID) {
> -                tlb->prot &= ~PAGE_VALID;
> -                do_flush_tlbs = 1;
> -            }
> +            tlb->prot &= ~PAGE_VALID;
>           }
>           tlb->PID = env->spr[SPR_440_MMUCR] & 0x000000FF;
> -        if (do_flush_tlbs) {
> -            tlb_flush(env_cpu(env));
> -        }
>           break;
>       case 1:
> -        RPN = value & 0xFFFFFC0F;
> -        if ((tlb->prot & PAGE_VALID) && tlb->RPN != RPN) {
> -            tlb_flush(env_cpu(env));
> -        }
> -        tlb->RPN = RPN;
> +        tlb->RPN = value & 0xFFFFFC0F;
>           break;
>       case 2:
>           tlb->attr = (tlb->attr & 0x1) | (value & 0x0000FF00);


