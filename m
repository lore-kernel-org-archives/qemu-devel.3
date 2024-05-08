Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE4EC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 23:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qpJ-0002dw-7t; Wed, 08 May 2024 19:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpH-0002dR-Da; Wed, 08 May 2024 19:35:55 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpF-0002JJ-Ic; Wed, 08 May 2024 19:35:55 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 88EBA4E6030;
 Thu, 09 May 2024 01:35:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id XOGayBQsySuI; Thu,  9 May 2024 01:35:49 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 95C4E4E6013; Thu, 09 May 2024 01:35:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 93E05746E3B;
 Thu, 09 May 2024 01:35:49 +0200 (CEST)
Date: Thu, 9 May 2024 01:35:49 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v3 33/33] target/ppc: Add a macro to check for page
 protection bit
In-Reply-To: <D14ASGGTNSQB.3TX66EXAL001R@gmail.com>
Message-ID: <7c4e51de-fdff-37b6-ffe5-2e7e26cffc17@eik.bme.hu>
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <a91a1b9455f88cbbeff2652fc4f44acd89e98215.1715125376.git.balaton@eik.bme.hu>
 <D14ASGGTNSQB.3TX66EXAL001R@gmail.com>
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
>> Checking if a page protection bit is set for a given access type is a
>> common operation. Add a macro to avoid repeating the same check at
>> multiple places and also avoid a function call. As this relies on
>> access type and page protection bit values having certain relation
>> also add an assert to ensure that this assumption holds.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  target/ppc/cpu_init.c    |  4 ++++
>>  target/ppc/internal.h    | 20 ++------------------
>>  target/ppc/mmu-hash32.c  |  6 +++---
>>  target/ppc/mmu-hash64.c  |  2 +-
>>  target/ppc/mmu-radix64.c |  2 +-
>>  target/ppc/mmu_common.c  | 26 +++++++++++++-------------
>>  6 files changed, 24 insertions(+), 36 deletions(-)
>>
>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>> index 92c71b2a09..6639235544 100644
>> --- a/target/ppc/cpu_init.c
>> +++ b/target/ppc/cpu_init.c
>> @@ -7377,6 +7377,10 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
>>      resettable_class_set_parent_phases(rc, NULL, ppc_cpu_reset_hold, NULL,
>>                                         &pcc->parent_phases);
>>
>> +    /* CHECK_PROT_ACCESS relies on this MMU access and PAGE bits relation */
>> +    assert(MMU_DATA_LOAD == 0 && MMU_DATA_STORE == 1 && MMU_INST_FETCH == 2 &&
>> +           PAGE_READ == 1 && PAGE_WRITE == 2 && PAGE_EXEC == 4);
>> +
>
> Can you use qemu_build_assert() for this?

I've changed it to qemu_build_assert and seems to work.

>>      cc->class_by_name = ppc_cpu_class_by_name;
>>      cc->has_work = ppc_cpu_has_work;
>>      cc->mmu_index = ppc_cpu_mmu_index;
>> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
>> index 46176c4711..9880422ce3 100644
>> --- a/target/ppc/internal.h
>> +++ b/target/ppc/internal.h
>> @@ -234,24 +234,8 @@ void destroy_ppc_opcodes(PowerPCCPU *cpu);
>>  void ppc_gdb_init(CPUState *cs, PowerPCCPUClass *ppc);
>>  const gchar *ppc_gdb_arch_name(CPUState *cs);
>>
>> -/**
>> - * prot_for_access_type:
>> - * @access_type: Access type
>> - *
>> - * Return the protection bit required for the given access type.
>> - */
>> -static inline int prot_for_access_type(MMUAccessType access_type)
>> -{
>> -    switch (access_type) {
>> -    case MMU_INST_FETCH:
>> -        return PAGE_EXEC;
>> -    case MMU_DATA_LOAD:
>> -        return PAGE_READ;
>> -    case MMU_DATA_STORE:
>> -        return PAGE_WRITE;
>> -    }
>> -    g_assert_not_reached();
>> -}
>> +/* Check if permission bit required for the access_type is set in prot */
>> +#define CHECK_PROT_ACCESS(prot, access_type) ((prot) & (1 << (access_type)))
>
> We don't want to use a macro when an inline function will work.
>
> Does the compiler not see the pattern and transform the existing
> code into a shift? If it does then I would leave it. If not, then
> just keep prot_for_access_type but make it a shift and maybe
> comment the logic.
>
> I would call the new function check_prot_for_access_type().

That would be too long and does not fit on one line. Long names with 
underscore and 80 char line limit does not go well together. I've left 
this unchanged for now and wait for your reply on this.

Regards,
BALATON Zoltan

