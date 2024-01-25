Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1EBC48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 10:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSxDa-000398-TY; Thu, 25 Jan 2024 05:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Usek=JD=kaod.org=clg@ozlabs.org>)
 id 1rSxDY-00037y-Br; Thu, 25 Jan 2024 05:44:20 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Usek=JD=kaod.org=clg@ozlabs.org>)
 id 1rSxDW-00061K-KO; Thu, 25 Jan 2024 05:44:20 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLHWJ63VLz4wc8;
 Thu, 25 Jan 2024 21:44:12 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLHWG6qYkz4wbR;
 Thu, 25 Jan 2024 21:44:10 +1100 (AEDT)
Message-ID: <732c0657-bc44-457a-868f-8abcc5a67225@kaod.org>
Date: Thu, 25 Jan 2024 11:44:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/ppc: 4xx don't flush TLB for a newly written
 software TLB entry
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <20240117151238.93323-1-npiggin@gmail.com>
 <20240117151238.93323-3-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240117151238.93323-3-npiggin@gmail.com>
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
> BookE software TLB is implemented by flushing old translations from the
> relevant TCG TLB whenever software TLB entries change. This means a new
> software TLB entry should not have any corresponding cached TCG TLB
> translations, so there is nothing to flush. The exception is multiple
> software TLBs that cover the same address and address space, but that
> is a programming error and results in undefined behaviour, and flushing
> does not give an obviously better outcome in that case either.
> 
> Remove the unnecessary flush of a newly written software TLB entry.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Acked-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/mmu_helper.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 949ae87f4f..68632bf54e 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -808,13 +808,6 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
>                     tlb->prot & PAGE_WRITE ? 'w' : '-',
>                     tlb->prot & PAGE_EXEC ? 'x' : '-',
>                     tlb->prot & PAGE_VALID ? 'v' : '-', (int)tlb->PID);
> -    /* Invalidate new TLB (if valid) */
> -    if (tlb->prot & PAGE_VALID) {
> -        qemu_log_mask(CPU_LOG_MMU, "%s: invalidate TLB %d start "
> -                      TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
> -                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
> -        ppcemb_tlb_flush(cs, tlb);
> -    }
>   }
>   
>   void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong entry,


