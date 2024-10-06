Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44B5CFB424
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 18:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxWGw-00051E-Au; Sun, 06 Oct 2024 14:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sxWGo-00050r-P7; Sun, 06 Oct 2024 14:46:19 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sxWGm-0003TU-1f; Sun, 06 Oct 2024 14:46:18 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8C10E4E6013;
 Sun, 06 Oct 2024 20:46:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 0XM6N0iDLlXF; Sun,  6 Oct 2024 20:46:09 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8DA4F4E6039; Sun, 06 Oct 2024 20:46:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8C131746F60;
 Sun, 06 Oct 2024 20:46:09 +0200 (CEST)
Date: Sun, 6 Oct 2024 20:46:09 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 1/2] hw/ppc: Consolidate e500 initial mapping creation
 functions
In-Reply-To: <C252CEDD-75BE-4A32-9EA3-98FECBF36BA8@gmail.com>
Message-ID: <d386c6a9-3ca7-b4be-dab7-21bf8a8888f0@eik.bme.hu>
References: <cover.1721131193.git.balaton@eik.bme.hu>
 <485a90bca642c894d94c8dbcadac58448c0bfa71.1721131193.git.balaton@eik.bme.hu>
 <C252CEDD-75BE-4A32-9EA3-98FECBF36BA8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 15 Aug 2024, Bernhard Beschow wrote:
> Am 16. Juli 2024 12:07:57 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> Add booke206_set_tlb() utility function and use it to replace very
>> similar create_initial_mapping functions in e500 machines.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> hw/ppc/e500.c         | 41 +++++++++++++++++++----------------------
>> hw/ppc/e500.h         |  2 --
>> hw/ppc/ppce500_spin.c | 30 +++++++++---------------------
>> include/hw/ppc/ppc.h  |  5 +++++
>> 4 files changed, 33 insertions(+), 45 deletions(-)
>>
>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>> index 3bd12b54ab..8682bc7838 100644
>> --- a/hw/ppc/e500.c
>> +++ b/hw/ppc/e500.c
>> @@ -721,11 +721,21 @@ static int ppce500_prep_device_tree(PPCE500MachineState *machine,
>>                                     kernel_base, kernel_size, true);
>> }
>>
>> -hwaddr booke206_page_size_to_tlb(uint64_t size)
>> +static hwaddr booke206_page_size_to_tlb(uint64_t size)
>> {
>>     return 63 - clz64(size / KiB);
>> }
>>
>> +void booke206_set_tlb(ppcmas_tlb_t *tlb, target_ulong va, hwaddr pa,
>> +                      hwaddr len)
>> +{
>> +    tlb->mas1 = booke206_page_size_to_tlb(len) << MAS1_TSIZE_SHIFT;
>> +    tlb->mas1 |= MAS1_VALID;
>> +    tlb->mas2 = va & TARGET_PAGE_MASK;
>> +    tlb->mas7_3 = pa & TARGET_PAGE_MASK;
>> +    tlb->mas7_3 |= MAS3_UR | MAS3_UW | MAS3_UX | MAS3_SR | MAS3_SW | MAS3_SX;
>> +}
>> +
>> static int booke206_initial_map_tsize(CPUPPCState *env)
>> {
>>     struct boot_info *bi = env->load_info;
>> @@ -751,25 +761,6 @@ static uint64_t mmubooke_initial_mapsize(CPUPPCState *env)
>>     return (1ULL << 10 << tsize);
>> }
>>
>> -/* Create -kernel TLB entries for BookE. */
>> -static void mmubooke_create_initial_mapping(CPUPPCState *env)
>> -{
>> -    ppcmas_tlb_t *tlb = booke206_get_tlbm(env, 1, 0, 0);
>> -    hwaddr size;
>> -    int ps;
>> -
>> -    ps = booke206_initial_map_tsize(env);
>> -    size = (ps << MAS1_TSIZE_SHIFT);
>> -    tlb->mas1 = MAS1_VALID | size;
>> -    tlb->mas2 = 0;
>> -    tlb->mas7_3 = 0;
>> -    tlb->mas7_3 |= MAS3_UR | MAS3_UW | MAS3_UX | MAS3_SR | MAS3_SW | MAS3_SX;
>> -
>> -#ifdef CONFIG_KVM
>> -    env->tlb_dirty = true;
>> -#endif
>> -}
>> -
>> static void ppce500_cpu_reset_sec(void *opaque)
>> {
>>     PowerPCCPU *cpu = opaque;
>> @@ -786,6 +777,8 @@ static void ppce500_cpu_reset(void *opaque)
>>     CPUState *cs = CPU(cpu);
>>     CPUPPCState *env = &cpu->env;
>>     struct boot_info *bi = env->load_info;
>> +    uint64_t map_size = mmubooke_initial_mapsize(env);
>> +    ppcmas_tlb_t *tlb = booke206_get_tlbm(env, 1, 0, 0);
>>
>>     cpu_reset(cs);
>>
>> @@ -796,11 +789,15 @@ static void ppce500_cpu_reset(void *opaque)
>>     env->gpr[4] = 0;
>>     env->gpr[5] = 0;
>>     env->gpr[6] = EPAPR_MAGIC;
>> -    env->gpr[7] = mmubooke_initial_mapsize(env);
>> +    env->gpr[7] = map_size;
>>     env->gpr[8] = 0;
>>     env->gpr[9] = 0;
>>     env->nip = bi->entry;
>> -    mmubooke_create_initial_mapping(env);
>> +    /* create initial mapping */
>> +    booke206_set_tlb(tlb, 0, 0, map_size);
>
> Both invocations of booke206_set_tlb() are followed by:
>
>> +#ifdef CONFIG_KVM
>> +    env->tlb_dirty = true;
>> +#endif
>
> Doesn't it make sense to move these three lines into booke206_set_tlb()? The two copies you're resolving did so, too.

No because tlb_dirty is in env and booke206_set_tlb only operates on the 
tlb entry. I don't want to pass the env just for this as this way it 
separates operations on tlb and on env and is also more consistent with 
the ppc440 case.

Regards,
BALATON Zoltan

> Best regards,
> Bernhard
>
>> }
>>
>> static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
>> diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
>> index 8c09ef92e4..01db102625 100644
>> --- a/hw/ppc/e500.h
>> +++ b/hw/ppc/e500.h
>> @@ -41,8 +41,6 @@ struct PPCE500MachineClass {
>>
>> void ppce500_init(MachineState *machine);
>>
>> -hwaddr booke206_page_size_to_tlb(uint64_t size);
>> -
>> #define TYPE_PPCE500_MACHINE      "ppce500-base-machine"
>> OBJECT_DECLARE_TYPE(PPCE500MachineState, PPCE500MachineClass, PPCE500_MACHINE)
>>
>> diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
>> index dfbe759481..208d87569a 100644
>> --- a/hw/ppc/ppce500_spin.c
>> +++ b/hw/ppc/ppce500_spin.c
>> @@ -33,6 +33,7 @@
>> #include "hw/hw.h"
>> #include "hw/sysbus.h"
>> #include "sysemu/hw_accel.h"
>> +#include "hw/ppc/ppc.h"
>> #include "e500.h"
>> #include "qom/object.h"
>>
>> @@ -70,30 +71,12 @@ static void spin_reset(DeviceState *dev)
>>     }
>> }
>>
>> -static void mmubooke_create_initial_mapping(CPUPPCState *env,
>> -                                     target_ulong va,
>> -                                     hwaddr pa,
>> -                                     hwaddr len)
>> -{
>> -    ppcmas_tlb_t *tlb = booke206_get_tlbm(env, 1, 0, 1);
>> -    hwaddr size;
>> -
>> -    size = (booke206_page_size_to_tlb(len) << MAS1_TSIZE_SHIFT);
>> -    tlb->mas1 = MAS1_VALID | size;
>> -    tlb->mas2 = (va & TARGET_PAGE_MASK) | MAS2_M;
>> -    tlb->mas7_3 = pa & TARGET_PAGE_MASK;
>> -    tlb->mas7_3 |= MAS3_UR | MAS3_UW | MAS3_UX | MAS3_SR | MAS3_SW | MAS3_SX;
>> -#ifdef CONFIG_KVM
>> -    env->tlb_dirty = true;
>> -#endif
>> -}
>> -
>> static void spin_kick(CPUState *cs, run_on_cpu_data data)
>> {
>>     CPUPPCState *env = cpu_env(cs);
>>     SpinInfo *curspin = data.host_ptr;
>> -    hwaddr map_size = 64 * MiB;
>> -    hwaddr map_start;
>> +    hwaddr map_start, map_size = 64 * MiB;
>> +    ppcmas_tlb_t *tlb = booke206_get_tlbm(env, 1, 0, 1);
>>
>>     cpu_synchronize_state(cs);
>>     stl_p(&curspin->pir, env->spr[SPR_BOOKE_PIR]);
>> @@ -107,7 +90,12 @@ static void spin_kick(CPUState *cs, run_on_cpu_data data)
>>     env->gpr[9] = 0;
>>
>>     map_start = ldq_p(&curspin->addr) & ~(map_size - 1);
>> -    mmubooke_create_initial_mapping(env, 0, map_start, map_size);
>> +    /* create initial mapping */
>> +    booke206_set_tlb(tlb, 0, map_start, map_size);
>> +    tlb->mas2 |= MAS2_M;
>> +#ifdef CONFIG_KVM
>> +    env->tlb_dirty = true;
>> +#endif
>>
>>     cs->halted = 0;
>>     cs->exception_index = -1;
>> diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
>> index d5d119ea7f..070524b02e 100644
>> --- a/include/hw/ppc/ppc.h
>> +++ b/include/hw/ppc/ppc.h
>> @@ -116,6 +116,11 @@ enum {
>>
>> #define PPC_SERIAL_MM_BAUDBASE 399193
>>
>> +#ifndef CONFIG_USER_ONLY
>> +void booke206_set_tlb(ppcmas_tlb_t *tlb, target_ulong va, hwaddr pa,
>> +                      hwaddr len);
>> +#endif
>> +
>> /* ppc_booke.c */
>> void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t flags);
>> #endif
>
>

