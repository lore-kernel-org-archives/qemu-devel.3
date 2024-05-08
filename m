Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAEAC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 15:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4jBI-00075a-UP; Wed, 08 May 2024 11:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4jBG-000757-LD; Wed, 08 May 2024 11:26:06 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4jBD-0005Lg-Ce; Wed, 08 May 2024 11:26:04 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 333F34E6010;
 Wed, 08 May 2024 17:26:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id jAtowhCBasuh; Wed,  8 May 2024 17:25:59 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3DAAC4E6001; Wed, 08 May 2024 17:25:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3C3067470B7;
 Wed, 08 May 2024 17:25:59 +0200 (CEST)
Date: Wed, 8 May 2024 17:25:59 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v3 26/33] target/ppc/mmu_common.c: Simplify
 ppc_booke_xlate() part 1
In-Reply-To: <D14AJB3VXJL0.18D5ZU7FZFOLN@gmail.com>
Message-ID: <8ea53cfc-963f-000c-f5dc-d6bd61db3fbb@eik.bme.hu>
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <5074c129ebfea0e1dfc22ef4691d8b62038d59b2.1715125376.git.balaton@eik.bme.hu>
 <D14AJB3VXJL0.18D5ZU7FZFOLN@gmail.com>
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

On Wed, 8 May 2024, Nicholas Piggin wrote:
> On Wed May 8, 2024 at 10:15 AM AEST, BALATON Zoltan wrote:
>> Move setting error_code that appears in every case out in front and
>> hoist the common fall through case for BOOKE206 as well which allows
>> removing the nested switches.
>>
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  target/ppc/mmu_common.c | 41 ++++++++++++-----------------------------
>>  1 file changed, 12 insertions(+), 29 deletions(-)
>>
>> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
>> index 788e2bebd5..c725a7932f 100644
>> --- a/target/ppc/mmu_common.c
>> +++ b/target/ppc/mmu_common.c
>> @@ -1205,58 +1205,41 @@ static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
>>      }
>>
>>      log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
>> +    env->error_code = 0;
>> +    if (ret == -1) {
>> +        if (env->mmu_model == POWERPC_MMU_BOOKE206) {
>> +            booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
>> +        }
>> +    }
>>      if (access_type == MMU_INST_FETCH) {
>>          switch (ret) {
>>          case -1:
>>              /* No matches in page tables or TLB */
>> -            switch (env->mmu_model) {
>> -            case POWERPC_MMU_BOOKE206:
>> -                booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
>> -                /* fall through */
>> -            case POWERPC_MMU_BOOKE:
>> -                cs->exception_index = POWERPC_EXCP_ITLB;
>> -                env->error_code = 0;
>> -                env->spr[SPR_BOOKE_DEAR] = eaddr;
>> -                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
>> -                break;
>> -            default:
>> -                g_assert_not_reached();
>> -            }
>> +            cs->exception_index = POWERPC_EXCP_ITLB;
>> +            env->spr[SPR_BOOKE_DEAR] = eaddr;
>> +            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
>>              break;
>>          case -2:
>>              /* Access rights violation */
>>              cs->exception_index = POWERPC_EXCP_ISI;
>> -            env->error_code = 0;
>>              break;
>>          case -3:
>>              /* No execute protection violation */
>>              cs->exception_index = POWERPC_EXCP_ISI;
>>              env->spr[SPR_BOOKE_ESR] = 0;
>
> I don't know BookE well but AFAIKS it says ESR if not set explicitly
> is generally cleared to 0 by interrupts which I guess is the case here.
> I don't see why the same would not apply to the -2 case either. That
> would reduce special cases.
>
> Although that's a behaviour change. It's possible current beahviour is
> deliberate or matches some particular CPU. Not something for this
> series.

I don't know what the correct behaviour should be so I just tried to keep 
what was there. After this clean it should be simpler to find out and 
correct this later.

Regards,
BALATON Zoltan

> Thanks,
> Nick
>
>> -            env->error_code = 0;
>>              break;
>>          }
>>      } else {
>>          switch (ret) {
>>          case -1:
>>              /* No matches in page tables or TLB */
>> -            switch (env->mmu_model) {
>> -            case POWERPC_MMU_BOOKE206:
>> -                booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
>> -                /* fall through */
>> -            case POWERPC_MMU_BOOKE:
>> -                cs->exception_index = POWERPC_EXCP_DTLB;
>> -                env->error_code = 0;
>> -                env->spr[SPR_BOOKE_DEAR] = eaddr;
>> -                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
>> -                break;
>> -            default:
>> -                g_assert_not_reached();
>> -            }
>> +            cs->exception_index = POWERPC_EXCP_DTLB;
>> +            env->spr[SPR_BOOKE_DEAR] = eaddr;
>> +            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
>>              break;
>>          case -2:
>>              /* Access rights violation */
>>              cs->exception_index = POWERPC_EXCP_DSI;
>> -            env->error_code = 0;
>>              env->spr[SPR_BOOKE_DEAR] = eaddr;
>>              env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
>>              break;
>
>
>

