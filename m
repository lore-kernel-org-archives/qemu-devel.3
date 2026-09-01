Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF947C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Ixp-0003zo-MX; Tue, 01 Sep 2026 03:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x1Ixf-0003zR-Pp
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 03:31:16 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x1IxZ-0004wi-Kd
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 03:31:15 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxKvAyf5Zq4UoHAA--.20430S3;
 Tue, 01 Sep 2026 15:30:58 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxTs8uf5ZqA7gYAA--.52210S2;
 Tue, 01 Sep 2026 15:30:56 +0800 (CST)
Subject: Re: [PATCH v3 6/8] target/loongarch: Add LVZ CPU runtime control
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1783673526.git.prcups@krgm.moe>
 <6b2c0a4b5a78df100ea7e36bfa8cfd31e1d6eeb6.1783673526.git.prcups@krgm.moe>
 <8d612056-5403-ba82-5e39-87ee08bdcb96@loongson.cn>
 <V1D66i6GR6mtEwfPu_3HXA@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20eb629f-4792-5bf8-9bae-0520d70c8747@loongson.cn>
Date: Tue, 1 Sep 2026 15:30:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <V1D66i6GR6mtEwfPu_3HXA@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxTs8uf5ZqA7gYAA--.52210S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoWDGw1kZw4DZr4xAw15ZrWxXwc_yoW7GFW3Go
 WrJa1aya17Jw4rCF1DC3s2qw4jqFy8CF4DCFWfCw43CanxKw1j934rKr48Jr4xKF1kWFW8
 Ca47tF4IvrWSvF1fl-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYx7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5
 WrAUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.034,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2026/8/23 下午3:59, SignKirigami wrote:
> On 2026年7月13日星期一 中国标准时间 17:10:24，Bibo Mao wrote：
>>
>> On 2026/7/10 下午5:00, SignKirigami wrote:
>>> Wire the LVZ CPU property, VM entry bookkeeping, VM exit trigger, guest
>>> interrupt delivery, guest constant timer support and guest CSR helpers
>>> into the LoongArch TCG runtime, leaving memory translation and PTW
>>> changes for a separate patch.
>> This patch is critical exception and interrupt handling in different VM
>> mode, I think it should be separated with different small patches with
>> every VM special exception handling, interrupt handling, guest timer
>> emulation for better review.
>>>
>>> Signed-off-by: SignKirigami <prcups@krgm.moe>
>>> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
>>> ---
>>>    target/loongarch/cpu.c                | 277 +++++++++++++++++++-------
>>>    target/loongarch/internals.h          |   8 +-
>>>    target/loongarch/machine.c            | 125 +++++++++++-
>>>    target/loongarch/tcg/constant_timer.c |  74 ++++++-
>>>    target/loongarch/tcg/csr_helper.c     | 136 ++++++++++++-
>>>    target/loongarch/tcg/helper.h         |  13 +-
>>>    target/loongarch/tcg/op_helper.c      |  45 ++++-
>>>    target/loongarch/tcg/tcg_cpu.c        |  65 ++++--
>>>    8 files changed, 641 insertions(+), 102 deletions(-)
>>>
>>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>>> index 492b17e136..093b2a057f 100644
>>> --- a/target/loongarch/cpu.c
>>> +++ b/target/loongarch/cpu.c
>>> @@ -62,17 +62,22 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>>>        LoongArchCPU *cpu = opaque;
>>>        CPULoongArchState *env = &cpu->env;
>>>        CPUState *cs = CPU(cpu);
>>> -    CPUSysState *sys = env_sys(env);
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>>    
>>>        if (irq < 0 || irq >= N_IRQS) {
>>>            return;
>>>        }
>>>    
>>> +    if (FIELD_EX64(host->CSR_GINTC, CSR_GINTC, HWIP) & BIT(irq)) {
>>> +        loongarch_cpu_set_irq_guest(opaque, irq, level);
>>> +        return;
>>> +    }
>> Should this piece of code be moved to helper_csrwr_gintc()?
> This piece means when host interrupt is set and corresponding bit of HWIP is true,
There is no relationship between host interrupt injection and HWIP 
checking of CSR_GINTC.
   1. host interrupt injection is to inject intterupt to host.
   2. CSR_GINTC writing about HWIP bit will update CSR_ESTAT of guest
   3. guest interrupt injection happend in helper_ertn() when return to 
guest, and checking guest CSR_ESTAT register.

All these three steps are separate, I think it not necessary to inject 
interrupt to guest in function loongarch_cpu_set_irq() and 
helper_csrwr_gintc().

Regards
Bibo Mao
> the host interrupt should be converted to guest interrupt.
In generic I think guest interrupt checking should happen in

>>
>>> +
>>>        if (kvm_enabled()) {
>>>            kvm_loongarch_set_interrupt(cpu, irq, level);
>>>        } else if (tcg_enabled()) {
>>> -        sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
>>> -        if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
>>> +        host->CSR_ESTAT = deposit64(host->CSR_ESTAT, irq, 1, level != 0);
>>> +        if (FIELD_EX64(host->CSR_ESTAT, CSR_ESTAT, IS)) {
>>>                cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>>>            } else {
>>>                cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>>> @@ -80,18 +85,66 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>>>        }
>>>    }
>>>    
>>> +void loongarch_cpu_set_irq_guest(void *opaque, int irq, int level)
>>> +{
>>> +    LoongArchCPU *cpu = opaque;
>>> +    CPULoongArchState *env = &cpu->env;
>>> +    CPUState *cs = CPU(cpu);
>>> +    CPUSysState *guest = &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
>>> +
>>> +    if (irq < 0 || irq >= N_IRQS) {
>>> +        return;
>>> +    }
>>> +
>>> +    guest->CSR_ESTAT = deposit64(guest->CSR_ESTAT, irq, 1, level != 0);
>>> +    if (env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
>>> +        if (FIELD_EX64(guest->CSR_ESTAT, CSR_ESTAT, IS)) {
>>> +            cpu_interrupt(cs, CPU_INTERRUPT_GUEST);
>>> +        } else {
>>> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_GUEST);
>>> +        }
>>> +    }
>>> +}
>>> +
>>>    /* Check if there is pending and not masked out interrupt */
>>>    bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
>>>    {
>>>        uint32_t pending;
>>>        uint32_t status;
>>> -    CPUSysState *sys = env_sys(env);
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>>    
>>> -    pending = FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS);
>>> -    status  = FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, LIE);
>>> +    pending = FIELD_EX64(host->CSR_ESTAT, CSR_ESTAT, IS);
>>> +    status  = FIELD_EX64(host->CSR_ECFG, CSR_ECFG, LIE);
>>>    
>>>        return (pending & status) != 0;
>>>    }
>>> +
>>> +static inline bool cpu_loongarch_hw_interrupts_enabled_guest(
>>> +    CPULoongArchState *env)
>>> +{
>>> +    return FIELD_EX64(env->sys_states[LOONGARCH_VM_LEVEL_GUEST].CSR_CRMD,
>>> +                      CSR_CRMD, IE);
>>> +}
>>> +
>>> +static inline bool cpu_loongarch_hw_interrupts_pending_guest(
>>> +    CPULoongArchState *env)
>>> +{
>>> +    uint32_t pending;
>>> +    uint32_t status;
>>> +    CPUSysState *guest = &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
>>> +
>>> +    pending = FIELD_EX64(guest->CSR_ESTAT, CSR_ESTAT, IS);
>>> +    status = FIELD_EX64(guest->CSR_ECFG, CSR_ECFG, LIE);
>>> +
>>> +    return (pending & status) != 0;
>>> +}
>>> +
>>> +bool loongarch_guest_has_interrupt(CPULoongArchState *env)
>>> +{
>>> +    return env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST &&
>>> +           cpu_loongarch_hw_interrupts_enabled_guest(env) &&
>>> +           cpu_loongarch_hw_interrupts_pending_guest(env);
>>> +}
>>>    #endif
>>>    
>>>    #ifndef CONFIG_USER_ONLY
>>> @@ -104,22 +157,77 @@ bool loongarch_cpu_has_work(CPUState *cs)
>>>            has_work = true;
>>>        }
>>>    
>>> +    if (cpu_test_interrupt(cs, CPU_INTERRUPT_GUEST) &&
>>> +        loongarch_guest_has_interrupt(cpu_env(cs))) {
>>> +        has_work = true;
>>> +    }
>>> +
>>>        return has_work;
>>>    }
>>>    #endif /* !CONFIG_USER_ONLY */
>>>    
>>> +uint8_t get_tgid(CPULoongArchState *env)
>>> +{
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>> +
>>> +    if (env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
>>> +        return get_gid(env);
>>> +    }
>>> +
>>> +    if (FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, USETGID)) {
>>> +        return FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, TGID);
>>> +    } else if (will_return_to_guest(env)) {
>>> +        return get_gid(env);
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +bool will_return_to_guest(CPULoongArchState *env)
>>> +{
>>> +    if (!has_lvz_capability(env) ||
>>> +        env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
>>> +        return false;
>>> +    }
>>> +    return FIELD_EX64(env->sys_states[LOONGARCH_VM_LEVEL_HOST].CSR_GSTAT,
>>> +                      CSR_GSTAT, PVM);
>>> +}
>>> +
>>> +bool has_lvz_capability(CPULoongArchState *env)
>>> +{
>>> +    return FIELD_EX32(env->cpucfg[2], CPUCFG2, LVZ);
>>> +}
>>> +
>>> +uint8_t get_gid(CPULoongArchState *env)
>>> +{
>>> +    return FIELD_EX64(env->sys_states[LOONGARCH_VM_LEVEL_HOST].CSR_GSTAT,
>>> +                      CSR_GSTAT, GID);
>>> +}
>>> +
>>> +void trigger_vm_exit(CPULoongArchState *env)
>>> +{
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>> +
>>> +    if (env_vm_level(env) != LOONGARCH_VM_LEVEL_GUEST) {
>>> +        return;
>>> +    }
>>> +
>>> +    cpu_loongarch_set_guest_timer(env_archcpu(env), false);
>>> +    host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, PVM, 1);
>>> +    env->vm_exit = true;
>>> +}
>>> +
>>>    static void loongarch_la464_init_csr(DeviceState *dev)
>>>    {
>>>    #ifndef CONFIG_USER_ONLY
>>>        static bool initialized;
>>>        LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>>>        CPULoongArchState *env = &cpu->env;
>>> -    CPUSysState *sys = env_sys(env);
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>>        int i, num;
>>>    
>>>        if (!initialized) {
>>>            initialized = true;
>>> -        num = FIELD_EX64(sys->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
>>> +        num = FIELD_EX64(host->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
>>>            for (i = num; i < 16; i++) {
>>>                set_csr_flag(LOONGARCH_CSR_SAVE(i), CSRFL_UNUSED);
>>>            }
>>> @@ -251,11 +359,32 @@ static void loongarch_set_ptw(Object *obj, bool value, Error **errp)
>>>        cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, HPTW, value);
>>>    }
>>>    
>>> +static bool loongarch_get_lvz(Object *obj, Error **errp)
>>> +{
>>> +    return LOONGARCH_CPU(obj)->lvz != ON_OFF_AUTO_OFF;
>>> +}
>>> +
>>> +static void loongarch_set_lvz(Object *obj, bool value, Error **errp)
>>> +{
>>> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>>> +
>>> +    cpu->lvz = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>>> +
>>> +    if (kvm_enabled()) {
>>> +        return;
>>> +    }
>>> +
>>> +    cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LVZ, value);
>>> +    cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LVZ_VER,
>>> +                                    value ? 1 : 0);
>>> +}
>>> +
>>>    static void loongarch_cpu_post_init(Object *obj)
>>>    {
>>>        LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>>>    
>>>        cpu->lbt = ON_OFF_AUTO_OFF;
>>> +    cpu->lvz = ON_OFF_AUTO_AUTO;
>>>        cpu->pmu = ON_OFF_AUTO_OFF;
>>>        cpu->lsx = ON_OFF_AUTO_AUTO;
>>>        cpu->lasx = ON_OFF_AUTO_AUTO;
>>> @@ -267,6 +396,8 @@ static void loongarch_cpu_post_init(Object *obj)
>>>                                 loongarch_set_msgint);
>>>        object_property_add_bool(obj, "ptw", loongarch_get_ptw,
>>>                                 loongarch_set_ptw);
>>> +    object_property_add_bool(obj, "lvz", loongarch_get_lvz,
>>> +                             loongarch_set_lvz);
>>>        /* lbt is enabled only in kvm mode, not supported in tcg mode */
>>>    
>>>        if (kvm_enabled()) {
>>> @@ -278,11 +409,11 @@ static void loongarch_la464_initfn(Object *obj)
>>>    {
>>>        LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>>>        CPULoongArchState *env = &cpu->env;
>>> -    CPUSysState *sys;
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>> +    CPUSysState *guest = &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
>>>        uint32_t data = 0, field;
>>>        int i;
>>>    
>>> -    set_sys_state(env, &env->sys_states[0]);
>>>        for (i = 0; i < 21; i++) {
>>>            env->cpucfg[i] = 0x0;
>>>        }
>>> @@ -322,6 +453,8 @@ static void loongarch_la464_initfn(Object *obj)
>>>        data = FIELD_DP32(data, CPUCFG2, FP_VER, 1);
>>>        data = FIELD_DP32(data, CPUCFG2, LSX, 1),
>>>        data = FIELD_DP32(data, CPUCFG2, LASX, 1),
>>> +    data = FIELD_DP32(data, CPUCFG2, LVZ, 1);
>>> +    data = FIELD_DP32(data, CPUCFG2, LVZ_VER, 1);
>>>        data = FIELD_DP32(data, CPUCFG2, LLFTP, 1);
>>>        data = FIELD_DP32(data, CPUCFG2, LLFTP_VER, 1);
>>>        data = FIELD_DP32(data, CPUCFG2, LSPW, 1);
>>> @@ -386,19 +519,19 @@ static void loongarch_la464_initfn(Object *obj)
>>>        data = FIELD_DP32(data, CPUCFG20, L3IU_SIZE, 6);
>>>        env->cpucfg[20] = data;
>>>    
>>> -    sys = env_sys(env);
>>> -    sys->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
>>> +    host->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
>>> +    guest->CSR_ASID = host->CSR_ASID;
>>>    
>>> -    sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM, 8);
>>> -    sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, TIMER_BITS, 0x2f);
>>> -    sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, VSMAX, 7);
>>> +    host->CSR_PRCFG1 = FIELD_DP64(host->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM, 8);
>>> +    host->CSR_PRCFG1 = FIELD_DP64(host->CSR_PRCFG1, CSR_PRCFG1, TIMER_BITS, 0x2f);
>>> +    host->CSR_PRCFG1 = FIELD_DP64(host->CSR_PRCFG1, CSR_PRCFG1, VSMAX, 7);
>>>    
>>> -    sys->CSR_PRCFG2 = 0x3ffff000;
>>> +    host->CSR_PRCFG2 = 0x3ffff000;
>>>    
>>> -    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, TLB_TYPE, 2);
>>> -    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, MTLB_ENTRY, 63);
>>> -    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
>>> -    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
>>> +    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, TLB_TYPE, 2);
>>> +    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, MTLB_ENTRY, 63);
>>> +    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
>>> +    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
>>>    
>>>        cpu->msgint = ON_OFF_AUTO_OFF;
>>>        cpu->ptw = ON_OFF_AUTO_OFF;
>>> @@ -412,7 +545,6 @@ static void loongarch_la132_initfn(Object *obj)
>>>        uint32_t data = 0;
>>>        int i;
>>>    
>>> -    set_sys_state(env, &env->sys_states[0]);
>>>        for (i = 0; i < 21; i++) {
>>>            env->cpucfg[i] = 0x0;
>>>        }
>>> @@ -439,6 +571,7 @@ static void loongarch_la132_initfn(Object *obj)
>>>        data = FIELD_DP32(data, CPUCFG1, CRC, 1);
>>>        env->cpucfg[1] = data;
>>>        cpu->msgint = ON_OFF_AUTO_OFF;
>>> +    cpu->lvz = ON_OFF_AUTO_OFF;
>>>        cpu->ptw = ON_OFF_AUTO_OFF;
>>>    }
>>>    
>>> @@ -596,11 +729,10 @@ static void loongarch_host_initfn(Object *obj)
>>>    
>>>    static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>>>    {
>>> -    uint8_t tlb_ps;
>>>        CPUState *cs = CPU(obj);
>>>        LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(obj);
>>>        CPULoongArchState *env = cpu_env(cs);
>>> -    CPUSysState *sys = env_sys(env);
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>>    
>>>        if (lacc->parent_phases.hold) {
>>>            lacc->parent_phases.hold(obj, type);
>>> @@ -622,63 +754,72 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>>>    #endif
>>>        env->fcsr0 = 0x0;
>>>    
>>> -    int n;
>>>        /* Set csr registers value after reset, see the manual 6.4. */
>>> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PLV, 0);
>>> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, IE, 0);
>>> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
>>> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PG, 0);
>>> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATF, 0);
>>> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATM, 0);
>>> -
>>> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, FPE, 0);
>>> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, SXE, 0);
>>> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, ASXE, 0);
>>> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, BTE, 0);
>>> -
>>> -    sys->CSR_MISC = 0;
>>> -
>>> -    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, VS, 0);
>>> -    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, LIE, 0);
>>> -
>>> -    sys->CSR_ESTAT = sys->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
>>> -    sys->CSR_RVACFG = FIELD_DP64(sys->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
>>> -    sys->CSR_CPUID = cs->cpu_index;
>>> -    sys->CSR_TCFG = FIELD_DP64(sys->CSR_TCFG, CSR_TCFG, EN, 0);
>>> -    sys->CSR_LLBCTL = FIELD_DP64(sys->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
>>> -    sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
>>> -    sys->CSR_MERRCTL = FIELD_DP64(sys->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
>>> -    sys->CSR_TID = cs->cpu_index;
>>> +    host->CSR_CRMD = FIELD_DP64(host->CSR_CRMD, CSR_CRMD, PLV, 0);
>>> +    host->CSR_CRMD = FIELD_DP64(host->CSR_CRMD, CSR_CRMD, IE, 0);
>>> +    host->CSR_CRMD = FIELD_DP64(host->CSR_CRMD, CSR_CRMD, DA, 1);
>>> +    host->CSR_CRMD = FIELD_DP64(host->CSR_CRMD, CSR_CRMD, PG, 0);
>>> +    host->CSR_CRMD = FIELD_DP64(host->CSR_CRMD, CSR_CRMD, DATF, 0);
>>> +    host->CSR_CRMD = FIELD_DP64(host->CSR_CRMD, CSR_CRMD, DATM, 0);
>>> +
>>> +    host->CSR_EUEN = FIELD_DP64(host->CSR_EUEN, CSR_EUEN, FPE, 0);
>>> +    host->CSR_EUEN = FIELD_DP64(host->CSR_EUEN, CSR_EUEN, SXE, 0);
>>> +    host->CSR_EUEN = FIELD_DP64(host->CSR_EUEN, CSR_EUEN, ASXE, 0);
>>> +    host->CSR_EUEN = FIELD_DP64(host->CSR_EUEN, CSR_EUEN, BTE, 0);
>>> +
>>> +    host->CSR_MISC = 0;
>>> +
>>> +    host->CSR_ECFG = FIELD_DP64(host->CSR_ECFG, CSR_ECFG, VS, 0);
>>> +    host->CSR_ECFG = FIELD_DP64(host->CSR_ECFG, CSR_ECFG, LIE, 0);
>>> +
>>> +    host->CSR_ESTAT = host->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
>>> +    host->CSR_RVACFG = FIELD_DP64(host->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
>>> +    host->CSR_CPUID = cs->cpu_index;
>>> +    host->CSR_TCFG = FIELD_DP64(host->CSR_TCFG, CSR_TCFG, EN, 0);
>>> +    host->CSR_LLBCTL = FIELD_DP64(host->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
>>> +    host->CSR_TLBRERA = FIELD_DP64(host->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
>>> +    host->CSR_MERRCTL = FIELD_DP64(host->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
>>> +    host->CSR_TID = cs->cpu_index;
>>> +    host->CSR_GSTAT = 0;
>>> +    host->CSR_GCFG = 0;
>>> +    host->CSR_GINTC = 0;
>>> +    host->CSR_GCNTC = 0;
>>> +    host->CSR_GTLBC = 0;
>>> +    host->CSR_TRGP = 0;
>>>        /*
>>>         * Workaround for edk2-stable202408, CSR PGD register is set only if
>>>         * its value is equal to zero for boot cpu, it causes reboot issue.
>>>         *
>>>         * Here clear CSR registers relative with TLB.
>>>         */
>>> -    sys->CSR_PGDH = 0;
>>> -    sys->CSR_PGDL = 0;
>>> -    sys->CSR_PWCH = 0;
>>> -    sys->CSR_EENTRY = 0;
>>> -    sys->CSR_TLBRENTRY = 0;
>>> -    sys->CSR_MERRENTRY = 0;
>>> +    host->CSR_PGDH = 0;
>>> +    host->CSR_PGDL = 0;
>>> +    host->CSR_PWCH = 0;
>>> +    host->CSR_EENTRY = 0;
>>> +    host->CSR_TLBRENTRY = 0;
>>> +    host->CSR_MERRENTRY = 0;
>>>        /* set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits from CSR_PRCFG2 */
>>> -    if (sys->CSR_PRCFG2 == 0) {
>>> -        sys->CSR_PRCFG2 = 0x3fffff000;
>>> +    if (host->CSR_PRCFG2 == 0) {
>>> +        host->CSR_PRCFG2 = 0x3fffff000;
>>>        }
>>> -    tlb_ps = ctz32(sys->CSR_PRCFG2);
>>> -    sys->CSR_STLBPS = FIELD_DP64(sys->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
>>> -    sys->CSR_PWCL = FIELD_DP64(sys->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
>>> -    for (n = 0; n < 4; n++) {
>>> -        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV0, 0);
>>> -        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV1, 0);
>>> -        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV2, 0);
>>> -        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV3, 0);
>>> +    uint8_t tlb_ps = ctz32(host->CSR_PRCFG2);
>>> +    host->CSR_STLBPS = FIELD_DP64(host->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
>>> +    host->CSR_PWCL = FIELD_DP64(host->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
>>> +    for (int n = 0; n < 4; n++) {
>>> +        host->CSR_DMW[n] = FIELD_DP64(host->CSR_DMW[n], CSR_DMW, PLV0, 0);
>>> +        host->CSR_DMW[n] = FIELD_DP64(host->CSR_DMW[n], CSR_DMW, PLV1, 0);
>>> +        host->CSR_DMW[n] = FIELD_DP64(host->CSR_DMW[n], CSR_DMW, PLV2, 0);
>>> +        host->CSR_DMW[n] = FIELD_DP64(host->CSR_DMW[n], CSR_DMW, PLV3, 0);
>>>        }
>>> +    if (FIELD_EX32(env->cpucfg[2], CPUCFG2, LVZ)) {
>>> +         host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, GIDBIT, 8);
>>> +    }
>>> +    set_sys_state(env, &env->sys_states[LOONGARCH_VM_LEVEL_HOST]);
>>>    
>>>    #ifndef CONFIG_USER_ONLY
>>>        env->pc = 0x1c000000;
>>> -#ifdef CONFIG_TCG
>>> -    memset(env->tlb, 0, sizeof(env->tlb));
>>> +#if defined(CONFIG_TCG)
>>> +    memset(host->tlb, 0, sizeof(host->tlb));
>>>    #endif
>>>        if (kvm_enabled()) {
>>>            kvm_arch_reset_vcpu(cs);
>>> @@ -739,6 +880,8 @@ static void loongarch_cpu_init(Object *obj)
>>>    #ifdef CONFIG_TCG
>>>        timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
>>>                      &loongarch_constant_timer_cb, cpu);
>>> +    timer_init_ns(&cpu->guest_timer, QEMU_CLOCK_VIRTUAL,
>>> +                  &loongarch_constant_timer_cb_guest, cpu);
>>>    #endif
>>>    #endif
>>>    }
>>> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
>>> index e01dbed40f..8a06ab9868 100644
>>> --- a/target/loongarch/internals.h
>>> +++ b/target/loongarch/internals.h
>>> @@ -32,14 +32,18 @@ void restore_fp_status(CPULoongArchState *env);
>>>    extern const VMStateDescription vmstate_loongarch_cpu;
>>>    
>>>    void loongarch_cpu_set_irq(void *opaque, int irq, int level);
>>> +void loongarch_cpu_set_irq_guest(void *opaque, int irq, int level);
>>>    
>>>    void loongarch_constant_timer_cb(void *opaque);
>>> +void loongarch_constant_timer_cb_guest(void *opaque);
>>>    uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
>>> -uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
>>> +uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu, bool guest);
>>> +void cpu_loongarch_set_guest_timer(LoongArchCPU *cpu, bool on);
>>>    void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
>>> -                                               uint64_t value);
>>> +                                               uint64_t value, bool guest);
>>>    bool loongarch_cpu_has_work(CPUState *cs);
>>>    bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
>>> +bool loongarch_guest_has_interrupt(CPULoongArchState *env);
>>>    #endif /* !CONFIG_USER_ONLY */
>>>    
>>>    uint64_t read_fcc(CPULoongArchState *env);
>>> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
>>> index 931a5ca5ba..f10101d501 100644
>>> --- a/target/loongarch/machine.c
>>> +++ b/target/loongarch/machine.c
>>> @@ -7,6 +7,7 @@
>>>    
>>>    #include "qemu/osdep.h"
>>>    #include "cpu.h"
>>> +#include "internals.h"
>>>    #include "migration/vmstate.h"
>>>    #include "system/tcg.h"
>>>    #include "vec.h"
>>> @@ -200,18 +201,139 @@ static const VMStateDescription vmstate_tlb = {
>>>        .minimum_version_id = 0,
>>>        .needed = tlb_needed,
>>>        .fields = (const VMStateField[]) {
>>> -        VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
>>> +        VMSTATE_STRUCT_ARRAY(env.sys_states[0].tlb, LoongArchCPU,
>>> +                             LOONGARCH_TLB_MAX,
>>>                                 0, vmstate_tlb_entry, LoongArchTLB),
>>>            VMSTATE_END_OF_LIST()
>>>        }
>>>    };
>>> +
>>> +static const VMStateDescription vmstate_lvz_sys = {
>>> +    .name = "cpu/lvz-sys",
>>> +    .version_id = 1,
>>> +    .minimum_version_id = 1,
>>> +    .fields = (const VMStateField[]) {
>>> +        VMSTATE_UINT64(CSR_CRMD, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_PRMD, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_EUEN, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_MISC, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_ECFG, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_ESTAT, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_ERA, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_BADV, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_BADI, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_EENTRY, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TLBIDX, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TLBEHI, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TLBELO0, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TLBELO1, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_ASID, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_PGDL, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_PGDH, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_PGD, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_PWCL, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_PWCH, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_STLBPS, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_RVACFG, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_CPUID, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_PRCFG1, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_PRCFG2, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_PRCFG3, CPUSysState),
>>> +        VMSTATE_UINT64_ARRAY(CSR_SAVE, CPUSysState, 16),
>>> +        VMSTATE_UINT64(CSR_TID, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TCFG, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TVAL, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_CNTC, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TICLR, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_LLBCTL, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_IMPCTL1, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_IMPCTL2, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TLBRENTRY, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TLBRBADV, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TLBRERA, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TLBRSAVE, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TLBRELO0, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TLBRELO1, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TLBREHI, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TLBRPRMD, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_MERRCTL, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_MERRINFO1, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_MERRINFO2, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_MERRENTRY, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_MERRERA, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_MERRSAVE, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_CTAG, CPUSysState),
>>> +        VMSTATE_UINT64_ARRAY(CSR_DMW, CPUSysState, 4),
>>> +        VMSTATE_UINT64(CSR_DBG, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_DERA, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_DSAVE, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_GSTAT, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_GCFG, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_GINTC, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_GCNTC, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_GTLBC, CPUSysState),
>>> +        VMSTATE_UINT64(CSR_TRGP, CPUSysState),
>>> +        VMSTATE_END_OF_LIST()
>>> +    },
>>> +};
>>> +
>>> +static bool lvz_needed(void *opaque)
>>> +{
>>> +    LoongArchCPU *cpu = opaque;
>>> +
>>> +    return FIELD_EX64(cpu->env.cpucfg[2], CPUCFG2, LVZ);
>>> +}
>>> +
>>> +static const VMStateDescription vmstate_lvz = {
>>> +    .name = "cpu/lvz",
>>> +    .version_id = 1,
>>> +    .minimum_version_id = 1,
>>> +    .needed = lvz_needed,
>>> +    .fields = (const VMStateField[]) {
>>> +        VMSTATE_UINT64(env.sys_states[0].CSR_GSTAT, LoongArchCPU),
>>> +        VMSTATE_UINT64(env.sys_states[0].CSR_GCFG, LoongArchCPU),
>>> +        VMSTATE_UINT64(env.sys_states[0].CSR_GINTC, LoongArchCPU),
>>> +        VMSTATE_UINT64(env.sys_states[0].CSR_GCNTC, LoongArchCPU),
>>> +        VMSTATE_UINT64(env.sys_states[0].CSR_GTLBC, LoongArchCPU),
>>> +        VMSTATE_UINT64(env.sys_states[0].CSR_TRGP, LoongArchCPU),
>>> +        VMSTATE_STRUCT(env.sys_states[1], LoongArchCPU, 0,
>>> +                       vmstate_lvz_sys, CPUSysState),
>>> +        VMSTATE_STRUCT_ARRAY(env.sys_states[1].tlb, LoongArchCPU,
>>> +                             LOONGARCH_TLB_MAX,
>>> +                             0, vmstate_tlb_entry, LoongArchTLB),
>>> +        VMSTATE_END_OF_LIST()
>>> +    },
>>> +};
>>> +#endif
>>> +
>>> +static int loongarch_cpu_post_load(void *opaque, int version_id)
>>> +{
>>> +    LoongArchCPU *cpu = opaque;
>>> +    CPULoongArchState *env = &cpu->env;
>>> +    bool guest = FIELD_EX64(env->sys_states[LOONGARCH_VM_LEVEL_HOST].CSR_GSTAT,
>>> +                            CSR_GSTAT, VM);
>>> +
>>> +    set_sys_state(env, &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUEST :
>>> +                                                LOONGARCH_VM_LEVEL_HOST]);
>>> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>>> +    if (guest) {
>>> +        cpu_loongarch_set_guest_timer(cpu, true);
>>> +    }
>>> +    if (guest && loongarch_guest_has_interrupt(env)) {
>>> +        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_GUEST);
>>> +    } else {
>>> +        cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_GUEST);
>>> +    }
>>>    #endif
>>> +    return 0;
>>> +}
>>>    
>>>    /* LoongArch CPU state */
>>>    const VMStateDescription vmstate_loongarch_cpu = {
>>>        .name = "cpu",
>>>        .version_id = 4,
>>>        .minimum_version_id = 4,
>>> +    .post_load = loongarch_cpu_post_load,
>>>        .fields = (const VMStateField[]) {
>>>            VMSTATE_UINT64_ARRAY(env.gpr, LoongArchCPU, 32),
>>>            VMSTATE_UINT64(env.pc, LoongArchCPU),
>>> @@ -285,6 +407,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
>>>            &vmstate_lasx,
>>>    #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>>>            &vmstate_tlb,
>>> +        &vmstate_lvz,
>>>    #endif
>>>            &vmstate_lbt,
>>>            &vmstate_msgint,
>>> diff --git a/target/loongarch/tcg/constant_timer.c b/target/loongarch/tcg/constant_timer.c
>>> index f56e76d482..4d7d4bccbc 100644
>>> --- a/target/loongarch/tcg/constant_timer.c
>>> +++ b/target/loongarch/tcg/constant_timer.c
>>> @@ -20,30 +20,64 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu)
>>>        return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / TIMER_PERIOD;
>>>    }
>>>    
>>> -uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu)
>>> +uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu, bool guest)
>>>    {
>>> +    CPULoongArchState *env = &cpu->env;
>>>        uint64_t now, expire;
>>> +    CPUSysState *sys = sys_state_if(env, guest);
>>> +
>>> +    if (guest && env_vm_level(env) != LOONGARCH_VM_LEVEL_GUEST) {
>>> +        return sys->CSR_TVAL;
>>> +    }
>>>    
>>>        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>>> -    expire = timer_expire_time_ns(&cpu->timer);
>>> +    expire = timer_expire_time_ns(guest ? &cpu->guest_timer : &cpu->timer);
>>>    
>>>        return (expire - now) / TIMER_PERIOD;
>>>    }
>>>    
>>>    void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
>>> -                                               uint64_t value)
>>> +                                               uint64_t value, bool guest)
>>>    {
>>>        CPULoongArchState *env = &cpu->env;
>>> -    CPUSysState *sys = env_sys(env);
>>>        uint64_t now, next;
>>> +    CPUSysState *sys = sys_state_if(env, guest);
>>> +    QEMUTimer *timer = guest ? &cpu->guest_timer : &cpu->timer;
>>>    
>>>        sys->CSR_TCFG = value;
>>> +    if (guest && env_vm_level(env) != LOONGARCH_VM_LEVEL_GUEST) {
>>> +        return;
>>> +    }
>>> +
>>>        if (value & CONSTANT_TIMER_ENABLE) {
>>>            now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>>>            next = now + (value & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
>>> -        timer_mod(&cpu->timer, next);
>>> +        timer_mod(timer, next);
>>> +    } else {
>>> +        timer_del(timer);
>>> +    }
>>> +}
>>> +
>>> +void cpu_loongarch_set_guest_timer(LoongArchCPU *cpu, bool on)
>>> +{
>>> +    CPULoongArchState *env = &cpu->env;
>>> +    CPUSysState *guest = &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
>>> +    uint64_t now, next, ticks;
>>> +
>>> +    if (!(guest->CSR_TCFG & CONSTANT_TIMER_ENABLE)) {
>>> +        return;
>>> +    }
>>> +
>>> +    if (on) {
>>> +        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>>> +        ticks = guest->CSR_TVAL ? guest->CSR_TVAL :
>>> +                                  (guest->CSR_TCFG & CONSTANT_TIMER_TICK_MASK);
>>> +        guest->CSR_TVAL = 0;
>>> +        next = now + ticks * TIMER_PERIOD;
>>> +        timer_mod(&cpu->guest_timer, next);
>>>        } else {
>>> -        timer_del(&cpu->timer);
>>> +        guest->CSR_TVAL = cpu_loongarch_get_constant_timer_ticks(cpu, true);
>>> +        timer_del(&cpu->guest_timer);
>>>        }
>>>    }
>>>    
>>> @@ -51,16 +85,36 @@ void loongarch_constant_timer_cb(void *opaque)
>>>    {
>>>        LoongArchCPU *cpu  = opaque;
>>>        CPULoongArchState *env = &cpu->env;
>>> -    CPUSysState *sys = env_sys(env);
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>>        uint64_t now, next;
>>>    
>>> -    if (FIELD_EX64(sys->CSR_TCFG, CSR_TCFG, PERIODIC)) {
>>> +    if (FIELD_EX64(host->CSR_TCFG, CSR_TCFG, PERIODIC)) {
>>>            now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>>> -        next = now + (sys->CSR_TCFG & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
>>> +        next = now + (host->CSR_TCFG & CONSTANT_TIMER_TICK_MASK) *
>>> +                     TIMER_PERIOD;
>>>            timer_mod(&cpu->timer, next);
>>>        } else {
>>> -        sys->CSR_TCFG = FIELD_DP64(sys->CSR_TCFG, CSR_TCFG, EN, 0);
>>> +        host->CSR_TCFG = FIELD_DP64(host->CSR_TCFG, CSR_TCFG, EN, 0);
>>>        }
>>>    
>>>        loongarch_cpu_set_irq(opaque, IRQ_TIMER, 1);
>>>    }
>>> +
>>> +void loongarch_constant_timer_cb_guest(void *opaque)
>>> +{
>>> +    LoongArchCPU *cpu = opaque;
>>> +    CPULoongArchState *env = &cpu->env;
>>> +    CPUSysState *guest = &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
>>> +    uint64_t now, next;
>>> +
>>> +    if (FIELD_EX64(guest->CSR_TCFG, CSR_TCFG, PERIODIC)) {
>>> +        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>>> +        next = now + (guest->CSR_TCFG & CONSTANT_TIMER_TICK_MASK) *
>>> +                     TIMER_PERIOD;
>>> +        timer_mod(&cpu->guest_timer, next);
>>> +    } else {
>>> +        guest->CSR_TCFG = FIELD_DP64(guest->CSR_TCFG, CSR_TCFG, EN, 0);
>>> +    }
>>> +
>>> +    loongarch_cpu_set_irq_guest(opaque, IRQ_TIMER, 1);
>>> +}
>>> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
>>> index 7dc33bc180..9ddb43222a 100644
>>> --- a/target/loongarch/tcg/csr_helper.c
>>> +++ b/target/loongarch/tcg/csr_helper.c
>>> @@ -60,6 +60,26 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
>>>        return v;
>>>    }
>>>    
>>> +target_ulong helper_gcsrrd_pgd(CPULoongArchState *env)
>>> +{
>>> +    int64_t v;
>>> +    CPUSysState *guest = &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
>>> +
>>> +    if (guest->CSR_TLBRERA & 0x1) {
>>> +        v = guest->CSR_TLBRBADV;
>>> +    } else {
>>> +        v = guest->CSR_BADV;
>>> +    }
>>> +
>>> +    if ((v >> 63) & 0x1) {
>>> +        v = guest->CSR_PGDH;
>>> +    } else {
>>> +        v = guest->CSR_PGDL;
>>> +    }
>>> +
>>> +    return v;
>>> +}
>>> +
>>>    target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
>>>    {
>>>        LoongArchCPU *lac = env_archcpu(env);
>>> @@ -74,7 +94,14 @@ target_ulong helper_csrrd_tval(CPULoongArchState *env)
>>>    {
>>>        LoongArchCPU *cpu = env_archcpu(env);
>>>    
>>> -    return cpu_loongarch_get_constant_timer_ticks(cpu);
>>> +    return cpu_loongarch_get_constant_timer_ticks(cpu, false);
>>> +}
>>> +
>>> +target_ulong helper_gcsrrd_tval(CPULoongArchState *env)
>>> +{
>>> +    LoongArchCPU *cpu = env_archcpu(env);
>>> +
>>> +    return cpu_loongarch_get_constant_timer_ticks(cpu, true);
>>>    }
>>>    
>>>    target_ulong helper_csrrd_msgir(CPULoongArchState *env)
>>> @@ -110,6 +137,29 @@ target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
>>>        return old_v;
>>>    }
>>>    
>>> +target_ulong helper_gcsrwr_estat(CPULoongArchState *env, target_ulong val)
>>> +{
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>> +    CPUSysState *guest = &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
>>> +    int64_t old_v = guest->CSR_ESTAT;
>>> +
>>> +    guest->CSR_ESTAT = deposit64(guest->CSR_ESTAT, 0, 2, val);
>>> +    if (env_vm_level(env) != LOONGARCH_VM_LEVEL_GUEST) {
>>> +        guest->CSR_ESTAT = deposit64(guest->CSR_ESTAT, 2, 11,
>>> +                                     extract64(val, 2, 11));
>>> +        if (extract64(val, 2, 8) &
>>> +            FIELD_EX64(host->CSR_GINTC, CSR_GINTC, HWIC)) {
>>> +            host->CSR_ESTAT = deposit64(host->CSR_ESTAT, 2, 8,
>>> +                                        extract64(host->CSR_ESTAT, 2, 8) &
>>> +                                        ~extract64(val, 2, 8));
>>> +        }
>>> +        guest->CSR_ESTAT = deposit64(guest->CSR_ESTAT, 16, 15,
>>> +                                     extract64(val, 16, 15));
>>> +    }
>>> +
>>> +    return old_v;
>>> +}
>>> +
>>>    target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
>>>    {
>>>        CPUSysState *sys = env_sys(env);
>>> @@ -123,13 +173,36 @@ target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
>>>        return old_v;
>>>    }
>>>    
>>> +target_ulong helper_gcsrwr_asid(CPULoongArchState *env, target_ulong val)
>>> +{
>>> +    CPUSysState *guest = &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
>>> +    int64_t old_v = guest->CSR_ASID;
>>> +
>>> +    guest->CSR_ASID = deposit64(guest->CSR_ASID, 0, 10, val);
>>> +    if (old_v != guest->CSR_ASID) {
>>> +        tlb_flush(env_cpu(env));
>>> +    }
>>> +    return old_v;
>>> +}
>>> +
>>>    target_ulong helper_csrwr_tcfg(CPULoongArchState *env, target_ulong val)
>>>    {
>>>        LoongArchCPU *cpu = env_archcpu(env);
>>>        CPUSysState *sys = env_sys(env);
>>>        int64_t old_v = sys->CSR_TCFG;
>>>    
>>> -    cpu_loongarch_store_constant_timer_config(cpu, val);
>>> +    cpu_loongarch_store_constant_timer_config(cpu, val, false);
>>> +
>>> +    return old_v;
>>> +}
>>> +
>>> +target_ulong helper_gcsrwr_tcfg(CPULoongArchState *env, target_ulong val)
>>> +{
>>> +    LoongArchCPU *cpu = env_archcpu(env);
>>> +    CPUSysState *guest = &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
>>> +    int64_t old_v = guest->CSR_TCFG;
>>> +
>>> +    cpu_loongarch_store_constant_timer_config(cpu, val, true);
>>>    
>>>        return old_v;
>>>    }
>>> @@ -147,6 +220,65 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
>>>        return old_v;
>>>    }
>>>    
>>> +target_ulong helper_gcsrwr_ticlr(CPULoongArchState *env, target_ulong val)
>>> +{
>>> +    LoongArchCPU *cpu = env_archcpu(env);
>>> +    int64_t old_v = 0;
>>> +
>>> +    if (val & 0x1) {
>>> +        bql_lock();
>>> +        loongarch_cpu_set_irq_guest(cpu, IRQ_TIMER, 0);
>>> +        bql_unlock();
>>> +    }
>>> +    return old_v;
>>> +}
>>> +
>>> +target_ulong helper_csrwr_gstat(CPULoongArchState *env, target_ulong val)
>>> +{
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>> +    int64_t old_v = host->CSR_GSTAT;
>>> +    uint8_t old_gid = FIELD_EX64(host->CSR_GSTAT, CSR_GSTAT, GID);
>>> +
>>> +    host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, PVM,
>>> +                                 FIELD_EX64(val, CSR_GSTAT, PVM));
>>> +    host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, GID,
>>> +                                 FIELD_EX64(val, CSR_GSTAT, GID));
>>> +
>>> +    if (old_gid != FIELD_EX64(host->CSR_GSTAT, CSR_GSTAT, GID)) {
>>> +        tlb_flush(env_cpu(env));
>>> +    }
>>> +
>>> +    return old_v;
>>> +}
>>> +
>>> +target_ulong helper_csrwr_gtlbc(CPULoongArchState *env, target_ulong val)
>>> +{
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>> +    int64_t old_v = host->CSR_GTLBC;
>>> +    uint8_t old_use_tgid = FIELD_EX64(old_v, CSR_GTLBC, USETGID);
>>> +    uint8_t old_tgid = FIELD_EX64(old_v, CSR_GTLBC, TGID);
>>> +
>>> +    host->CSR_GTLBC = val;
>>> +    if (old_use_tgid != FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, USETGID) ||
>>> +        old_tgid != FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, TGID)) {
>>> +        tlb_flush(env_cpu(env));
>>> +    }
>>> +
>>> +    return old_v;
>>> +}
>>> +
>>> +target_ulong helper_csrwr_gintc(CPULoongArchState *env, target_ulong val)
>>> +{
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>> +    CPUSysState *guest = &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
>>> +    int64_t old_v = host->CSR_GINTC;
>>> +
>>> +    host->CSR_GINTC = val & 0xffff00;
>>> +    guest->CSR_ESTAT = deposit64(guest->CSR_ESTAT, 2, 8, extract64(val, 0, 8));
>>> +
>>> +    return old_v;
>>> +}
>>> +
>>>    target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
>>>    {
>>>        uint8_t shift, ptbase;
>>> diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
>>> index 8a6c62f116..69f6cb352a 100644
>>> --- a/target/loongarch/tcg/helper.h
>>> +++ b/target/loongarch/tcg/helper.h
>>> @@ -14,7 +14,7 @@ DEF_HELPER_FLAGS_3(asrtgt_d, TCG_CALL_NO_WG, void, env, tl, tl)
>>>    
>>>    DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
>>>    DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
>>> -DEF_HELPER_FLAGS_2(cpucfg, TCG_CALL_NO_RWG_SE, tl, env, tl)
>>> +DEF_HELPER_FLAGS_2(cpucfg, TCG_CALL_NO_WG_SE, tl, env, tl)
>>>    
>>>    /* Floating-point helper */
>>>    DEF_HELPER_FLAGS_3(fadd_s, TCG_CALL_NO_WG, i64, env, i64, i64)
>>> @@ -98,14 +98,23 @@ DEF_HELPER_1(rdtime_d, i64, env)
>>>    #ifndef CONFIG_USER_ONLY
>>>    /* CSRs helper */
>>>    DEF_HELPER_1(csrrd_pgd, i64, env)
>>> +DEF_HELPER_1(gcsrrd_pgd, i64, env)
>>>    DEF_HELPER_1(csrrd_cpuid, i64, env)
>>>    DEF_HELPER_1(csrrd_tval, i64, env)
>>> +DEF_HELPER_1(gcsrrd_tval, i64, env)
>>>    DEF_HELPER_1(csrrd_msgir, i64, env)
>>>    DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
>>>    DEF_HELPER_2(csrwr_estat, i64, env, tl)
>>> +DEF_HELPER_2(gcsrwr_estat, i64, env, tl)
>>>    DEF_HELPER_2(csrwr_asid, i64, env, tl)
>>> +DEF_HELPER_2(gcsrwr_asid, i64, env, tl)
>>>    DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
>>> +DEF_HELPER_2(gcsrwr_tcfg, i64, env, tl)
>>>    DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
>>> +DEF_HELPER_2(gcsrwr_ticlr, i64, env, tl)
>>> +DEF_HELPER_2(csrwr_gstat, i64, env, tl)
>>> +DEF_HELPER_2(csrwr_gtlbc, i64, env, tl)
>>> +DEF_HELPER_2(csrwr_gintc, i64, env, tl)
>>>    DEF_HELPER_2(csrwr_pwcl, i64, env, tl)
>>>    DEF_HELPER_2(csrwr_pwch, i64, env, tl)
>>>    DEF_HELPER_2(iocsrrd_b, i64, env, tl)
>>> @@ -134,6 +143,8 @@ DEF_HELPER_4(lddir, tl, env, tl, i32, i32)
>>>    DEF_HELPER_4(ldpte, void, env, tl, tl, i32)
>>>    DEF_HELPER_1(ertn, void, env)
>>>    DEF_HELPER_1(idle, void, env)
>>> +DEF_HELPER_2(hvcl, void, env, i32)
>>> +DEF_HELPER_1(gspr, void, env)
>>>    #endif
>>>    
>>>    /* LoongArch LSX  */
>>> diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
>>> index e63ac66daa..2829929738 100644
>>> --- a/target/loongarch/tcg/op_helper.c
>>> +++ b/target/loongarch/tcg/op_helper.c
>>> @@ -12,6 +12,7 @@
>>>    #include "exec/helper-proto.h"
>>>    #include "accel/tcg/cpu-ldst.h"
>>>    #include "internals.h"
>>> +#include "qemu/main-loop.h"
>>>    #include "qemu/crc32c.h"
>>>    #include <zlib.h> /* for crc32 */
>>>    #include "cpu-csr.h"
>>> @@ -46,20 +47,20 @@ target_ulong helper_bitswap(target_ulong v)
>>>    /* loongarch assert op */
>>>    void helper_asrtle_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
>>>    {
>>> -    CPUSysState *sys = env_sys(env);
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>>    
>>>        if (rj > rk) {
>>> -        sys->CSR_BADV = rj;
>>> +        host->CSR_BADV = rj;
>>>            do_raise_exception(env, EXCCODE_BCE, GETPC());
>>>        }
>>>    }
>> is this specail for host? or can VM trigger this expcetion?
>>
>>>    
>>>    void helper_asrtgt_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
>>>    {
>>> -    CPUSysState *sys = env_sys(env);
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>>    
>>>        if (rj <= rk) {
>>> -        sys->CSR_BADV = rj;
>>> +        host->CSR_BADV = rj;
>>>            do_raise_exception(env, EXCCODE_BCE, GETPC());
>>>        }
>>>    }
>> Ditto, is this specail for host? or can VM trigger this expcetion?
>>
>>> @@ -85,6 +86,10 @@ target_ulong helper_crc32c(target_ulong val, target_ulong m, uint64_t sz)
>>>    
>>>    target_ulong helper_cpucfg(CPULoongArchState *env, target_ulong rj)
>>>    {
>>> +    if (env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
>>> +        trigger_vm_exit(env);
>>> +        do_raise_exception(env, EXCCODE_GSPR, GETPC());
>>> +    }
>>>        return rj >= ARRAY_SIZE(env->cpucfg) ? 0 : env->cpucfg[rj];
>>>    }
>>>    
>>> @@ -111,6 +116,7 @@ void helper_ertn(CPULoongArchState *env)
>>>    {
>>>        uint64_t csr_pplv, csr_pie;
>>>        CPUSysState *sys = env_sys(env);
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>>    
>>>        if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
>>>            csr_pplv = FIELD_EX64(sys->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV);
>>> @@ -134,6 +140,18 @@ void helper_ertn(CPULoongArchState *env)
>>>        sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, IE, csr_pie);
>>>    
>>>        env->lladdr = 1;
>>> +    if (will_return_to_guest(env)) {
>>> +        host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, VM, 1);
>>> +        set_sys_state(env, &env->sys_states[LOONGARCH_VM_LEVEL_GUEST]);
>>> +        cpu_loongarch_set_guest_timer(env_archcpu(env), true);
>>> +        bql_lock();
>>> +        if (loongarch_guest_has_interrupt(env)) {
>>> +            cpu_interrupt(env_cpu(env), CPU_INTERRUPT_GUEST);
>>> +        } else {
>>> +            cpu_reset_interrupt(env_cpu(env), CPU_INTERRUPT_GUEST);
>>> +        }
>>> +        bql_unlock();
>>> +    }
>>>    }
>>>    
>>>    void helper_idle(CPULoongArchState *env)
>>> @@ -143,4 +161,23 @@ void helper_idle(CPULoongArchState *env)
>>>        cs->halted = 1;
>>>        do_raise_exception(env, EXCP_HLT, 0);
>>>    }
>>> +
>>> +void helper_hvcl(CPULoongArchState *env, uint32_t code)
>>> +{
>>> +    (void)code;
>>> +
>>> +    if (env_vm_level(env) != LOONGARCH_VM_LEVEL_GUEST) {
>>> +        do_raise_exception(env, EXCCODE_INE, GETPC());
>>> +        return;
>>> +    }
>>> +
>>> +    trigger_vm_exit(env);
>>> +    do_raise_exception(env, EXCCODE_HVC, GETPC());
>> I remember that hypercall instruction can only happen in VM mode with
>> PLV == 0, there should be exception even in VM mode with user mode PLV == 3.
>>
>>> +}
>>> +
>>> +void helper_gspr(CPULoongArchState *env)
>>> +{
>>> +    trigger_vm_exit(env);
>>> +    do_raise_exception(env, EXCCODE_GSPR, GETPC());
>>> +}
>> It is strange that there is helper_gspr(), gspr is not a instruction and
>> it is a exception cause special for VM.
>>
>> Can we call do_raise_exception(env, EXCCODE_GSPR, GETPC()) directy?
>>
>> Regards
>> Bibo Mao
>>>    #endif
>>> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
>>> index 4b1d44a164..594daa74b2 100644
>>> --- a/target/loongarch/tcg/tcg_cpu.c
>>> +++ b/target/loongarch/tcg/tcg_cpu.c
>>> @@ -44,6 +44,10 @@ static const struct TypeExcp excp_names[] = {
>>>        {EXCCODE_BCE, "Bound Check Exception"},
>>>        {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
>>>        {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
>>> +    {EXCCODE_GSPR, "Guest Sensitive and Privileged Resources"},
>>> +    {EXCCODE_HVC, "Hypervisor call"},
>>> +    {EXCCODE_GCSC, "Guest CSR visited by Software"},
>>> +    {EXCCODE_GCHC, "Guest CSR visited by Hardware"},
>>>        {EXCP_HLT, "EXCP_HLT"},
>>>    };
>>>    
>>> @@ -78,9 +82,11 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
>>>    static void loongarch_cpu_do_interrupt(CPUState *cs)
>>>    {
>>>        CPULoongArchState *env = cpu_env(cs);
>>> -    CPUSysState *sys = env_sys(env);
>>>        bool update_badinstr = 1;
>>>        int cause = -1;
>>> +    bool real_guest = !env->vm_exit && env_vm_level(env);
>>> +    CPUSysState *sys = &env->sys_states[real_guest];
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>>        bool tlbfill = FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
>>>        uint32_t vec_size = FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, VS);
>>>        uint64_t last_pc = env->pc;
>>> @@ -96,17 +102,17 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>>>    
>>>        switch (cs->exception_index) {
>>>        case EXCCODE_DBP:
>>> -        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DCL, 1);
>>> -        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, ECODE, 0xC);
>>> +        host->CSR_DBG = FIELD_DP64(host->CSR_DBG, CSR_DBG, DCL, 1);
>>> +        host->CSR_DBG = FIELD_DP64(host->CSR_DBG, CSR_DBG, ECODE, 0xC);
>>>            goto set_DERA;
>>>        set_DERA:
>>> -        sys->CSR_DERA = env->pc;
>>> -        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DST, 1);
>>> -        set_pc(env, sys->CSR_EENTRY + 0x480);
>>> +        host->CSR_DERA = env->pc;
>>> +        host->CSR_DBG = FIELD_DP64(host->CSR_DBG, CSR_DBG, DST, 1);
>>> +        set_pc(env, host->CSR_EENTRY + 0x480);
>>>            break;
>>>        case EXCCODE_INT:
>>> -        if (FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)) {
>>> -            sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DEI, 1);
>>> +        if (FIELD_EX64(host->CSR_DBG, CSR_DBG, DST)) {
>>> +            host->CSR_DBG = FIELD_DP64(host->CSR_DBG, CSR_DBG, DEI, 1);
>>>                goto set_DERA;
>>>            }
>>>            QEMU_FALLTHROUGH;
>>> @@ -117,6 +123,10 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>>>            update_badinstr = 0;
>>>            break;
>>>        case EXCCODE_BCE:
>>> +    case EXCCODE_GSPR:
>>> +    case EXCCODE_GCHC:
>>> +    case EXCCODE_GCSC:
>>> +    case EXCCODE_HVC:
>>>            sys->CSR_BADV = env->pc;
>>>            QEMU_FALLTHROUGH;
>>>        case EXCCODE_SYS:
>>> @@ -218,6 +228,12 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>>>            qemu_plugin_vcpu_exception_cb(cs, last_pc);
>>>        }
>>>        cs->exception_index = -1;
>>> +    if (env->vm_exit) {
>>> +        host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, VM, 0);
>>> +        set_sys_state(env, &env->sys_states[LOONGARCH_VM_LEVEL_HOST]);
>>> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_GUEST);
>>> +    }
>>> +    env->vm_exit = false;
>>>    }
>>>    
>>>    static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>>> @@ -228,9 +244,9 @@ static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>>>                                                    uintptr_t retaddr)
>>>    {
>>>        CPULoongArchState *env = cpu_env(cs);
>>> -    CPUSysState *sys = env_sys(env);
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>>    
>>> -    sys->CSR_BADV = addr;
>>> +    host->CSR_BADV = addr;
>>>        if (access_type == MMU_INST_FETCH) {
>>>            do_raise_exception(env, EXCCODE_ADEF, retaddr);
>>>        } else {
>>> @@ -241,26 +257,35 @@ static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>>>    static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env)
>>>    {
>>>        bool ret = 0;
>>> -    CPUSysState *sys = env_sys(env);
>>> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
>>>    
>>> -    ret = (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, IE) &&
>>> -          !(FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)));
>>> +    ret = (FIELD_EX64(host->CSR_CRMD, CSR_CRMD, IE) &&
>>> +          !(FIELD_EX64(host->CSR_DBG, CSR_DBG, DST)));
>>>    
>>>        return ret;
>>>    }
>>>    
>>>    static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>>>    {
>>> -    if (interrupt_request & CPU_INTERRUPT_HARD) {
>>> -        CPULoongArchState *env = cpu_env(cs);
>>> +    CPULoongArchState *env = cpu_env(cs);
>>>    
>>> +    if (interrupt_request & CPU_INTERRUPT_HARD) {
>>>            if (cpu_loongarch_hw_interrupts_enabled(env) &&
>>>                cpu_loongarch_hw_interrupts_pending(env)) {
>>> +            if (env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
>>> +                trigger_vm_exit(env);
>>> +            }
>>>                /* Raise it */
>>>                cs->exception_index = EXCCODE_INT;
>>>                loongarch_cpu_do_interrupt(cs);
>>>                return true;
>>>            }
>>> +    } else if (interrupt_request & CPU_INTERRUPT_GUEST) {
>>> +        if (loongarch_guest_has_interrupt(env)) {
>>> +            cs->exception_index = EXCCODE_INT;
>>> +            loongarch_cpu_do_interrupt(cs);
>>> +            return true;
>>> +        }
>>>        }
>>>        return false;
>>>    }
>>> @@ -279,6 +304,9 @@ static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
>>>        uint32_t flags;
>>>    
>>>        flags = sys->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
>>> +    if (env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
>>> +        flags |= HW_FLAGS_GUEST_MODE;
>>> +    }
>>>        flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
>>>        flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
>>>        flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
>>> @@ -306,6 +334,13 @@ static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
>>>        CPULoongArchState *env = cpu_env(cs);
>>>        CPUSysState *sys = env_sys(env);
>>>    
>>> +    if (env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
>>> +        if (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG)) {
>>> +            return MMU_GUEST_IDX + FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
>>> +        }
>>> +        return MMU_GUEST_DA_IDX;
>>> +    }
>>> +
>>>        if (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG)) {
>>>            return FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
>>>        }
>>>
>>
>>
> 
> 
> 


