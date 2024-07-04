Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E07C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLfe-0000Qd-KG; Thu, 04 Jul 2024 08:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sPLfc-0000QH-E3; Thu, 04 Jul 2024 08:34:40 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sPLfa-0004Ol-A0; Thu, 04 Jul 2024 08:34:40 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6C6004E6004;
 Thu, 04 Jul 2024 14:34:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id PPVamdzY5eBo; Thu,  4 Jul 2024 14:34:31 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6F0424E6001; Thu, 04 Jul 2024 14:34:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6CEE5746E3B;
 Thu, 04 Jul 2024 14:34:31 +0200 (CEST)
Date: Thu, 4 Jul 2024 14:34:31 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 11/43] target/ppc/mmu_common.c: Remove pte_update_flags()
In-Reply-To: <D2GJ736YGATJ.2B6B20NSYPM4K@gmail.com>
Message-ID: <8f2565ea-b02d-c1c9-0466-e4994a01b0b9@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <87df776b2534cc0ad2523d17c99453edb5de3459.1716763435.git.balaton@eik.bme.hu>
 <D2GJ736YGATJ.2B6B20NSYPM4K@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Thu, 4 Jul 2024, Nicholas Piggin wrote:
> On Mon May 27, 2024 at 9:12 AM AEST, BALATON Zoltan wrote:
>> This function is used only once, its return value is ignored and one
>> of its parameter is a return value from a previous call. It is better
>> to inline it in the caller and remove it.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  target/ppc/mmu_common.c | 41 +++++++++++++----------------------------
>>  1 file changed, 13 insertions(+), 28 deletions(-)
>>
>> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
>> index e3537c63c0..c4902b7632 100644
>> --- a/target/ppc/mmu_common.c
>> +++ b/target/ppc/mmu_common.c
>> @@ -119,39 +119,14 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
>>      }
>>  }
>>
>> -static int pte_update_flags(mmu_ctx_t *ctx, target_ulong *pte1p,
>> -                            int ret, MMUAccessType access_type)
>> -{
>> -    int store = 0;
>> -
>> -    /* Update page flags */
>> -    if (!(*pte1p & 0x00000100)) {
>> -        /* Update accessed flag */
>> -        *pte1p |= 0x00000100;
>> -        store = 1;
>> -    }
>> -    if (!(*pte1p & 0x00000080)) {
>> -        if (access_type == MMU_DATA_STORE && ret == 0) {
>> -            /* Update changed flag */
>> -            *pte1p |= 0x00000080;
>> -            store = 1;
>> -        } else {
>> -            /* Force page fault for first write access */
>> -            ctx->prot &= ~PAGE_WRITE;
>> -        }
>> -    }
>> -
>> -    return store;
>> -}
>> -
>>  /* Software driven TLB helpers */
>>
>>  static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
>>                              target_ulong eaddr, MMUAccessType access_type)
>>  {
>>      ppc6xx_tlb_t *tlb;
>> -    int nr, best, way;
>> -    int ret;
>> +    target_ulong *pte1p;
>> +    int nr, best, way, ret;
>>
>>      best = -1;
>>      ret = -1; /* No TLB found */
>> @@ -204,7 +179,17 @@ done:
>>                        " prot=%01x ret=%d\n",
>>                        ctx->raddr & TARGET_PAGE_MASK, ctx->prot, ret);
>>          /* Update page flags */
>> -        pte_update_flags(ctx, &env->tlb.tlb6[best].pte1, ret, access_type);
>> +        pte1p = &env->tlb.tlb6[best].pte1;
>> +        *pte1p |= 0x00000100; /* Update accessed flag */
>> +        if (!(*pte1p & 0x00000080)) {
>> +            if (access_type == MMU_DATA_STORE && ret == 0) {
>> +                /* Update changed flag */
>> +                *pte1p |= 0x00000080;
>> +            } else {
>> +                /* Force page fault for first write access */
>> +                ctx->prot &= ~PAGE_WRITE;
>
> Out of curiosity, I guess this unusual part is because ctx->prot can get
> PAGE_WRITE set in the bat lookup, then it has to be cleared if the PTE
> does not have changed bit?

I have no idea. I was just trying to clean up this code to make it simpler 
with this series. I think historically there was a single function that 
handled all models but as these became too different it was split up by 
MMU models. It could be some of this are remnants of some old code where 
some other model needed it and not needed any more or this could be merged 
with hash32 but I did not try to find that out, just try to make sure not 
to break it any more than it might already be broken.

Regards,
BALATON Zoltan

>> +            }
>> +        }
>>      }
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>
>>  #if defined(DUMP_PAGE_TABLES)
>>      if (qemu_loglevel_mask(CPU_LOG_MMU)) {
>
>

