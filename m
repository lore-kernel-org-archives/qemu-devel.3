Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FCFC25B78
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 09:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7tT3-0005ay-RM; Fri, 17 May 2024 05:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s7tSu-0005a6-57; Fri, 17 May 2024 05:01:24 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s7tSr-0003kF-BH; Fri, 17 May 2024 05:01:23 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D5D044E64CB;
 Fri, 17 May 2024 11:01:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id DCjJD-xaiNf1; Fri, 17 May 2024 11:01:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D35EC4E64C1; Fri, 17 May 2024 11:01:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D1A747470B7;
 Fri, 17 May 2024 11:01:15 +0200 (CEST)
Date: Fri, 17 May 2024 11:01:15 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v7 35/61] target/ppc: Remove pp_check() and reuse
 ppc_hash32_pp_prot()
In-Reply-To: <D1BP3JMB7X6H.6TYQ4FYWBZRH@gmail.com>
Message-ID: <006b775c-e2b3-c729-f758-4302a98fa07b@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
 <ed76f84bb9b16f8ecffa6ed6154b97fc7a8acdc1.1715555763.git.balaton@eik.bme.hu>
 <D1BP3JMB7X6H.6TYQ4FYWBZRH@gmail.com>
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

On Fri, 17 May 2024, Nicholas Piggin wrote:
> On Mon May 13, 2024 at 9:28 AM AEST, BALATON Zoltan wrote:
>> The ppc_hash32_pp_prot() function in mmu-hash32.c is the same as
>> pp_check() in mmu_common.c, merge these to remove duplicated code.
>> Define the common function as static lnline otherwise exporting the
>> function from mmu-hash32.c would stop the compiler inlining it which
>> results in slightly lower performance.
>>
>
> It's already hard to review patches that move code around, it's better
> to keep the changes before/after the move unless really necessary.

I could try to split this further but the series was already quite long 
and this is not too complex and also there's git diff --color-moved so I 
though this could be in in one patch.

> For mmu_common.c hunks,
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Hmm, I can't apply Rb to hunks so I think I have to ignore it for now and 
wait until you send Rb for whole patch.

Just to make it simpler could you please send a pull request for the 
patches that are already reviewed at the beginning of the series to reduce 
the number of patches I need to resend? I've already added some more and 
still have some plans to continue so moving the patches that are OK out of 
the way could help. Then I could just resend the patches starting from the 
first that's not yet reviewed. Thank you for taking time to review these.

Regards,
BALATON Zoltan

> Thanks,
> Nick
>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  target/ppc/mmu-hash32.c | 45 -----------------------------------------
>>  target/ppc/mmu-hash32.h | 36 +++++++++++++++++++++++++++++++++
>>  target/ppc/mmu_common.c | 44 ++--------------------------------------
>>  3 files changed, 38 insertions(+), 87 deletions(-)
>>
>> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
>> index 1e8f1df0f0..d5f2057eb1 100644
>> --- a/target/ppc/mmu-hash32.c
>> +++ b/target/ppc/mmu-hash32.c
>> @@ -37,51 +37,6 @@
>>  #  define LOG_BATS(...) do { } while (0)
>>  #endif
>>
>> -static int ppc_hash32_pp_prot(int key, int pp, int nx)
>> -{
>> -    int prot;
>> -
>> -    if (key == 0) {
>> -        switch (pp) {
>> -        case 0x0:
>> -        case 0x1:
>> -        case 0x2:
>> -            prot = PAGE_READ | PAGE_WRITE;
>> -            break;
>> -
>> -        case 0x3:
>> -            prot = PAGE_READ;
>> -            break;
>> -
>> -        default:
>> -            abort();
>> -        }
>> -    } else {
>> -        switch (pp) {
>> -        case 0x0:
>> -            prot = 0;
>> -            break;
>> -
>> -        case 0x1:
>> -        case 0x3:
>> -            prot = PAGE_READ;
>> -            break;
>> -
>> -        case 0x2:
>> -            prot = PAGE_READ | PAGE_WRITE;
>> -            break;
>> -
>> -        default:
>> -            abort();
>> -        }
>> -    }
>> -    if (nx == 0) {
>> -        prot |= PAGE_EXEC;
>> -    }
>> -
>> -    return prot;
>> -}
>> -
>>  static int ppc_hash32_pte_prot(int mmu_idx,
>>                                 target_ulong sr, ppc_hash_pte32_t pte)
>>  {
>> diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
>> index 7119a63d97..bf99161858 100644
>> --- a/target/ppc/mmu-hash32.h
>> +++ b/target/ppc/mmu-hash32.h
>> @@ -102,6 +102,42 @@ static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
>>      stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte1);
>>  }
>>
>> +static inline int ppc_hash32_pp_prot(bool key, int pp, bool nx)
>> +{
>> +    int prot;
>> +
>> +    if (key) {
>> +        switch (pp) {
>> +        case 0x0:
>> +            prot = 0;
>> +            break;
>> +        case 0x1:
>> +        case 0x3:
>> +            prot = PAGE_READ;
>> +            break;
>> +        case 0x2:
>> +            prot = PAGE_READ | PAGE_WRITE;
>> +            break;
>> +        default:
>> +            g_assert_not_reached();
>> +        }
>> +    } else {
>> +        switch (pp) {
>> +        case 0x0:
>> +        case 0x1:
>> +        case 0x2:
>> +            prot = PAGE_READ | PAGE_WRITE;
>> +            break;
>> +        case 0x3:
>> +            prot = PAGE_READ;
>> +            break;
>> +        default:
>> +            g_assert_not_reached();
>> +        }
>> +    }
>> +    return nx ? prot : prot | PAGE_EXEC;
>> +}
>> +
>>  typedef struct {
>>      uint32_t pte0, pte1;
>>  } ppc_hash_pte32_t;
>> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
>> index e1462a25dd..9e0bfbda67 100644
>> --- a/target/ppc/mmu_common.c
>> +++ b/target/ppc/mmu_common.c
>> @@ -77,44 +77,6 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
>>  /*****************************************************************************/
>>  /* PowerPC MMU emulation */
>>
>> -static int pp_check(int key, int pp, int nx)
>> -{
>> -    int access;
>> -
>> -    /* Compute access rights */
>> -    access = 0;
>> -    if (key == 0) {
>> -        switch (pp) {
>> -        case 0x0:
>> -        case 0x1:
>> -        case 0x2:
>> -            access |= PAGE_WRITE;
>> -            /* fall through */
>> -        case 0x3:
>> -            access |= PAGE_READ;
>> -            break;
>> -        }
>> -    } else {
>> -        switch (pp) {
>> -        case 0x0:
>> -            access = 0;
>> -            break;
>> -        case 0x1:
>> -        case 0x3:
>> -            access = PAGE_READ;
>> -            break;
>> -        case 0x2:
>> -            access = PAGE_READ | PAGE_WRITE;
>> -            break;
>> -        }
>> -    }
>> -    if (nx == 0) {
>> -        access |= PAGE_EXEC;
>> -    }
>> -
>> -    return access;
>> -}
>> -
>>  int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
>>                                      int way, int is_code)
>>  {
>> @@ -137,7 +99,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
>>                                  MMUAccessType access_type)
>>  {
>>      target_ulong ptem, mmask;
>> -    int access, ret, pteh, ptev, pp;
>> +    int ret, pteh, ptev, pp;
>>
>>      ret = -1;
>>      /* Check validity and table match */
>> @@ -156,11 +118,9 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
>>                      return -3;
>>                  }
>>              }
>> -            /* Compute access rights */
>> -            access = pp_check(ctx->key, pp, ctx->nx);
>>              /* Keep the matching PTE information */
>>              ctx->raddr = pte1;
>> -            ctx->prot = access;
>> +            ctx->prot = ppc_hash32_pp_prot(ctx->key, pp, ctx->nx);
>>              if (check_prot_access_type(ctx->prot, access_type)) {
>>                  /* Access granted */
>>                  qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
>
>
>

