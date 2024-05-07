Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D57C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 23:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4UWx-0004rz-C3; Tue, 07 May 2024 19:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1s4UWt-0004re-8U
 for qemu-devel@nongnu.org; Tue, 07 May 2024 19:47:27 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1s4UWp-0001Ew-V1
 for qemu-devel@nongnu.org; Tue, 07 May 2024 19:47:25 -0400
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 9F4A8A0112; Wed,  8 May 2024 01:40:00 +0200 (CEST)
Date: Wed, 8 May 2024 01:40:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 24/28] target/ppc/mmu_common.c: Remove BookE handling
 from get_physical_address_wtlb()
In-Reply-To: <D13EDO9E2R7L.E6416WEFSMYL@gmail.com>
Message-ID: <alpine.LMD.2.03.2405080129400.14319@eik.bme.hu>
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <cd05e33ea86d301cf64aa3925a6302b92249ee3c.1714606359.git.balaton@eik.bme.hu>
 <D13EDO9E2R7L.E6416WEFSMYL@gmail.com>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 7 May 2024, Nicholas Piggin wrote:
> On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
>> This function is no longer called for BookE MMU model so remove parts
>> related to it. This has uncovered a few may be used uninitialised
>> warnings that are also fixed.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  target/ppc/mmu_common.c | 25 +++++--------------------
>>  1 file changed, 5 insertions(+), 20 deletions(-)
>>
>> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
>> index a1f98f8de4..d61c41d8c9 100644
>> --- a/target/ppc/mmu_common.c
>> +++ b/target/ppc/mmu_common.c
>> @@ -684,12 +684,10 @@ static int mmubooke_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
>>          ret = mmubooke_check_tlb(env, tlb, &raddr, &ctx->prot, address,
>>                                   access_type, i);
>>          if (ret != -1) {
>> -            if (ret >= 0) {
>> -                ctx->raddr = raddr;
>> -            }
>>              break;
>>          }
>>      }
>> +    ctx->raddr = raddr;
>>      qemu_log_mask(CPU_LOG_MMU,
>>                    "%s: access %s " TARGET_FMT_lx " => " HWADDR_FMT_plx
>>                    " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
>> @@ -897,9 +895,6 @@ static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
>>              ret = mmubooke206_check_tlb(env, tlb, &raddr, &ctx->prot, address,
>>                                          access_type, mmu_idx);
>>              if (ret != -1) {
>> -                if (ret >= 0) {
>> -                    ctx->raddr = raddr;
>> -                }
>>                  goto found_tlb;
>>              }
>>          }
>> @@ -907,6 +902,7 @@ static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
>>
>>  found_tlb:
>>
>> +    ctx->raddr = raddr;
>
> Not sure about the uninitialized warnings here either, caller probably
> should not be using ctx->raddr unless we returned 0...
>
>>      qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " => "
>>                    HWADDR_FMT_plx " %d %d\n", __func__,
>>                    ret < 0 ? "refused" : "granted", address, raddr,
>> @@ -1163,20 +1159,9 @@ static int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
>>                                       MMUAccessType access_type, int type,
>>                                       int mmu_idx)
>>  {
>> -    bool real_mode;
>> -
>> -    if (env->mmu_model == POWERPC_MMU_BOOKE) {
>> -        return mmubooke_get_physical_address(env, ctx, eaddr, access_type);
>> -    } else if (env->mmu_model == POWERPC_MMU_BOOKE206) {
>> -        return mmubooke206_get_physical_address(env, ctx, eaddr, access_type,
>> -                                                mmu_idx);
>> -    }
>
> This could just go in the previous patch when you split booke xlate?

Removing this uncovers the warnings so I keep it here to separate it from 
the previous change. I gave up on trying to resolve these warnings and 
untangle the embedded functions from mmu_ctx_t which would be needed to 
move these booke functions out from this file. The other problem is that 
these booke get_physical_address functions and mmu40x_get_physical_address 
all use ppcemb_tlb_check which then needs to be in the same file and 
static to be inlined and not run too slow but 40x is still in jumbo_xlate 
so I just leave it for now and may return to it later or let somebody else 
continue from here. I think this series moves forward enough for now and I 
don't have more time now.

>> -
>> -    real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
>> -                                      : !FIELD_EX64(env->msr, MSR, DR);
>> -    if (real_mode && (env->mmu_model == POWERPC_MMU_SOFT_6xx ||
>> -                      env->mmu_model == POWERPC_MMU_SOFT_4xx ||
>> -                      env->mmu_model == POWERPC_MMU_REAL)) {
>> +    bool real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
>> +                                           : !FIELD_EX64(env->msr, MSR, DR);
>> +    if (real_mode) {
>>          memset(ctx, 0, sizeof(*ctx));
>>          ctx->raddr = eaddr;
>>          ctx->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>
> This still changes beahviour of MPC8xx MMU doesn't it? It's supposed
> to abort always.

I don't think it can get here because there's still an abort case in 
ppc_tlb_invalidate_all() which is called from ppc_cpu_reset_hold() so it 
will likely crash before it could call anything here. But if you think 
it's necessary I could add a case for it in ppc_xlate() maybe.

Regards,
BALATON Zoltan

