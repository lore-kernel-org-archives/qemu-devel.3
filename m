Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8AAC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 10:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSxEq-0004CD-Tp; Thu, 25 Jan 2024 05:45:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Usek=JD=kaod.org=clg@ozlabs.org>)
 id 1rSxEV-00044m-EE; Thu, 25 Jan 2024 05:45:21 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Usek=JD=kaod.org=clg@ozlabs.org>)
 id 1rSxET-0007oj-7R; Thu, 25 Jan 2024 05:45:19 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLHXV2BLMz4x7q;
 Thu, 25 Jan 2024 21:45:14 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLHXS3SpTz4x5r;
 Thu, 25 Jan 2024 21:45:12 +1100 (AEDT)
Message-ID: <8fbf05d8-c075-4fd9-8f63-44aa78612403@kaod.org>
Date: Thu, 25 Jan 2024 11:45:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] target/ppc: optimise ppcemb_tlb_t flushing
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <20240117151238.93323-1-npiggin@gmail.com>
 <20240117151238.93323-6-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240117151238.93323-6-npiggin@gmail.com>
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
> Filter TLB flushing by PID and mmuidx.
> 
> Zoltan reports that, together with the previous TLB flush changes,
> performance of a sam460ex machine running lame to convert a wav to mp3
> is improved nearly 10%:
> 
>                    CPU time    TLB partial flushes  TLB elided flushes
> Before            37s         508238               7680722
> After             34s             73                  1143
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>



Acked-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/mmu_helper.c | 43 +++++++++++++++++++++++++++++++++++------
>   1 file changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index ba965f1779..c071b4d5e2 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -751,11 +751,20 @@ target_ulong helper_4xx_tlbre_lo(CPUPPCState *env, target_ulong entry)
>   
>   static void ppcemb_tlb_flush(CPUState *cs, ppcemb_tlb_t *tlb)
>   {
> -    target_ulong ea;
> +    unsigned mmu_idx = 0;
>   
> -    for (ea = tlb->EPN; ea < tlb->EPN + tlb->size; ea += TARGET_PAGE_SIZE) {
> -        tlb_flush_page(cs, ea);
> +    if (tlb->prot & 0xf) {
> +        mmu_idx |= 0x1;
>       }
> +    if ((tlb->prot >> 4) & 0xf) {
> +        mmu_idx |= 0x2;
> +    }
> +    if (tlb->attr & 1) {
> +        mmu_idx <<= 2;
> +    }
> +
> +    tlb_flush_range_by_mmuidx(cs, tlb->EPN, tlb->size, mmu_idx,
> +                              TARGET_LONG_BITS);
>   }
>   
>   void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
> @@ -770,7 +779,7 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
>       entry &= PPC4XX_TLB_ENTRY_MASK;
>       tlb = &env->tlb.tlbe[entry];
>       /* Invalidate previous TLB (if it's valid) */
> -    if (tlb->prot & PAGE_VALID) {
> +    if ((tlb->prot & PAGE_VALID) && tlb->PID == env->spr[SPR_40x_PID]) {
>           qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
>                         TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
>                         (int)entry, tlb->EPN, tlb->EPN + tlb->size);
> @@ -821,7 +830,7 @@ void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong entry,
>       entry &= PPC4XX_TLB_ENTRY_MASK;
>       tlb = &env->tlb.tlbe[entry];
>       /* Invalidate previous TLB (if it's valid) */
> -    if (tlb->prot & PAGE_VALID) {
> +    if ((tlb->prot & PAGE_VALID) && tlb->PID == env->spr[SPR_40x_PID]) {
>           qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
>                         TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
>                         (int)entry, tlb->EPN, tlb->EPN + tlb->size);
> @@ -851,6 +860,25 @@ target_ulong helper_4xx_tlbsx(CPUPPCState *env, target_ulong address)
>       return ppcemb_tlb_search(env, address, env->spr[SPR_40x_PID]);
>   }
>   
> +static bool mmubooke_pid_match(CPUPPCState *env, ppcemb_tlb_t *tlb)
> +{
> +    if (tlb->PID == env->spr[SPR_BOOKE_PID]) {
> +        return true;
> +    }
> +    if (!env->nb_pids) {
> +        return false;
> +    }
> +
> +    if (env->spr[SPR_BOOKE_PID1] && tlb->PID == env->spr[SPR_BOOKE_PID1]) {
> +        return true;
> +    }
> +    if (env->spr[SPR_BOOKE_PID2] && tlb->PID == env->spr[SPR_BOOKE_PID2]) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>   /* PowerPC 440 TLB management */
>   void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
>                         target_ulong value)
> @@ -863,7 +891,10 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
>       tlb = &env->tlb.tlbe[entry];
>   
>       /* Invalidate previous TLB (if it's valid) */
> -    if (tlb->prot & PAGE_VALID) {
> +    if ((tlb->prot & PAGE_VALID) && mmubooke_pid_match(env, tlb)) {
> +        qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
> +                      TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
> +                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
>           ppcemb_tlb_flush(env_cpu(env), tlb);
>       }
>   


