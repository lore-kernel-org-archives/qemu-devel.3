Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA9BC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 10:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSx8f-0000ru-Dc; Thu, 25 Jan 2024 05:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Usek=JD=kaod.org=clg@ozlabs.org>)
 id 1rSx8d-0000rM-HH; Thu, 25 Jan 2024 05:39:15 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Usek=JD=kaod.org=clg@ozlabs.org>)
 id 1rSx8b-0002vM-Kw; Thu, 25 Jan 2024 05:39:15 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLHPT04Dcz4x3D;
 Thu, 25 Jan 2024 21:39:09 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLHPR0gFfz4wc8;
 Thu, 25 Jan 2024 21:39:06 +1100 (AEDT)
Message-ID: <bb1649c1-1647-43e4-a5c4-6a8c045b264d@kaod.org>
Date: Thu, 25 Jan 2024 11:39:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/ppc: Factor out 4xx ppcemb_tlb_t flushing
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <20240117151238.93323-1-npiggin@gmail.com>
 <20240117151238.93323-2-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240117151238.93323-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Usek=JD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
> Flushing the TCG TLB pages that cache a software TLB is a common
> operation, factor it into its own function.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Acked-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/mmu_helper.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index c140f3c96d..949ae87f4f 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -749,12 +749,20 @@ target_ulong helper_4xx_tlbre_lo(CPUPPCState *env, target_ulong entry)
>       return ret;
>   }
>   
> +static void ppcemb_tlb_flush(CPUState *cs, ppcemb_tlb_t *tlb)
> +{
> +    target_ulong ea;
> +
> +    for (ea = tlb->EPN; ea < tlb->EPN + tlb->size; ea += TARGET_PAGE_SIZE) {
> +        tlb_flush_page(cs, ea);
> +    }
> +}
> +
>   void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
>                            target_ulong val)
>   {
>       CPUState *cs = env_cpu(env);
>       ppcemb_tlb_t *tlb;
> -    target_ulong page, end;
>   
>       qemu_log_mask(CPU_LOG_MMU, "%s entry %d val " TARGET_FMT_lx "\n",
>                     __func__, (int)entry,
> @@ -763,13 +771,10 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
>       tlb = &env->tlb.tlbe[entry];
>       /* Invalidate previous TLB (if it's valid) */
>       if (tlb->prot & PAGE_VALID) {
> -        end = tlb->EPN + tlb->size;
>           qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
>                         TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
> -                      (int)entry, tlb->EPN, end);
> -        for (page = tlb->EPN; page < end; page += TARGET_PAGE_SIZE) {
> -            tlb_flush_page(cs, page);
> -        }
> +                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
> +        ppcemb_tlb_flush(cs, tlb);
>       }
>       tlb->size = booke_tlb_to_page_size((val >> PPC4XX_TLBHI_SIZE_SHIFT)
>                                          & PPC4XX_TLBHI_SIZE_MASK);
> @@ -805,13 +810,10 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
>                     tlb->prot & PAGE_VALID ? 'v' : '-', (int)tlb->PID);
>       /* Invalidate new TLB (if valid) */
>       if (tlb->prot & PAGE_VALID) {
> -        end = tlb->EPN + tlb->size;
>           qemu_log_mask(CPU_LOG_MMU, "%s: invalidate TLB %d start "
>                         TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
> -                      (int)entry, tlb->EPN, end);
> -        for (page = tlb->EPN; page < end; page += TARGET_PAGE_SIZE) {
> -            tlb_flush_page(cs, page);
> -        }
> +                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
> +        ppcemb_tlb_flush(cs, tlb);
>       }
>   }
>   


