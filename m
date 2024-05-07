Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8A5C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 15:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4MnU-0003MQ-Ld; Tue, 07 May 2024 11:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4Mn4-0003FN-UT; Tue, 07 May 2024 11:31:42 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4Mn1-00035d-IF; Tue, 07 May 2024 11:31:37 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E57034E603D;
 Tue, 07 May 2024 17:31:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id MfvTJPg-KUJU; Tue,  7 May 2024 17:31:30 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EBF204E602E; Tue, 07 May 2024 17:31:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EA2EB746E3B;
 Tue, 07 May 2024 17:31:30 +0200 (CEST)
Date: Tue, 7 May 2024 17:31:30 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 20/28] target/ppc/mmu_common.c: Make
 get_physical_address_wtlb() static
In-Reply-To: <D13CPVTK824I.8DR4MRXLJRPB@gmail.com>
Message-ID: <8fee9a89-c5f9-0d08-a76a-bf6521021ff3@eik.bme.hu>
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <55ea002eb081fd1fdc6ff6f0e3f25ba892044e9d.1714606359.git.balaton@eik.bme.hu>
 <D13CPVTK824I.8DR4MRXLJRPB@gmail.com>
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

On Tue, 7 May 2024, Nicholas Piggin wrote:
> On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
>> This function is not used from any other files so make it static and
>> fix the maybe used uninitialised warnings this has uncovered.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  target/ppc/internal.h   | 5 +----
>>  target/ppc/mmu_common.c | 5 ++++-
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
>> index 601c0b533f..7a99f08dc8 100644
>> --- a/target/ppc/internal.h
>> +++ b/target/ppc/internal.h
>> @@ -261,10 +261,7 @@ typedef struct mmu_ctx_t mmu_ctx_t;
>>  bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>>                        hwaddr *raddrp, int *psizep, int *protp,
>>                        int mmu_idx, bool guest_visible);
>> -int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
>> -                                     target_ulong eaddr,
>> -                                     MMUAccessType access_type, int type,
>> -                                     int mmu_idx);
>> +
>>  /* Software driven TLB helpers */
>>  int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
>>                                      int way, int is_code);
>> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
>> index 762b13805b..4852cb5571 100644
>> --- a/target/ppc/mmu_common.c
>> +++ b/target/ppc/mmu_common.c
>> @@ -666,6 +666,7 @@ static int mmubooke_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
>>      hwaddr raddr = (hwaddr)-1ULL;
>>      int i, ret = -1;
>>
>> +    ctx->prot = 0;
>>      for (i = 0; i < env->nb_tlb; i++) {
>>          tlb = &env->tlb.tlbe[i];
>>          ret = mmubooke_check_tlb(env, tlb, &raddr, &ctx->prot, address,
>> @@ -873,6 +874,7 @@ static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
>>      hwaddr raddr = (hwaddr)-1ULL;
>>      int i, j, ways, ret = -1;
>>
>> +    ctx->prot = 0;
>>      for (i = 0; i < BOOKE206_MAX_TLBN; i++) {
>>          ways = booke206_tlb_ways(env, i);
>>          for (j = 0; j < ways; j++) {
>
> The prot warnings are valid AFAIKS, used uninit by qemu_log_mask call.
>
> So, I see what the booke _check_tlb() functions are doing with
> *prot now and that is to assign it iff return value is 0 or -2 or
> -3, matching TLB address (and possibly mismatch prot).
>
> Would it be better to fix it as:
>
>    qemu_log_mask(CPU_LOG_MMU,
>                  "%s: access %s " TARGET_FMT_lx " => " HWADDR_FMT_plx
>                  " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
>                  address, raddr, ret == -1 ? 0 : ctx->prot, ret);
>
> This way it's clearer that we're only printing it when a TLB was
> found, and it won't silence other possible use-uninitialised?

I can do that.

>> @@ -1144,7 +1146,7 @@ void dump_mmu(CPUPPCState *env)
>>      }
>>  }
>>
>> -int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
>> +static int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
>>                                       target_ulong eaddr,
>>                                       MMUAccessType access_type, int type,
>>                                       int mmu_idx)
>> @@ -1163,6 +1165,7 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
>>      if (real_mode && (env->mmu_model == POWERPC_MMU_SOFT_6xx ||
>>                        env->mmu_model == POWERPC_MMU_SOFT_4xx ||
>>                        env->mmu_model == POWERPC_MMU_REAL)) {
>> +        memset(ctx, 0, sizeof(*ctx));
>>          ctx->raddr = eaddr;
>>          ctx->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>>          return 0;
>
> I wonder why the compiler doesn't see these, they are all in the return
> not-zero cases that should be quite visible?
>
> What if you leave the static change to the end of your series, do the
> simplifications allow the compiler to work it out? I prefer not to
> squash such compiler warnings if it can be avoided.

Even removing this memser at the end of the series brings back the 
warnings so this has to stay for now. Maybe this can be cleaned up later 
but I'd like to focus on booke now.

Regards,
BALATON Zoltan

