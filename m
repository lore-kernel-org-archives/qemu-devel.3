Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B05C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 03:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1bjX-0003na-DR; Tue, 01 Sep 2026 23:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x1bjT-0003n6-RH
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 23:33:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x1bjQ-0000Ev-T6
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 23:33:51 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cx+9EQmZdq1p0HAA--.21713S3;
 Wed, 02 Sep 2026 11:33:36 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxpMwPmZdqkksZAA--.26266S2;
 Wed, 02 Sep 2026 11:33:35 +0800 (CST)
Subject: Re: [PATCH v4 05/14] target/loongarch: Add LVZ guest interrupt state
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1787739852.git.prcups@krgm.moe>
 <32e816aa68489d4e6b0b2b24e99a6c8a4e3469bf.1787739852.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <36d85ad3-7947-67d4-1460-485b380fc703@loongson.cn>
Date: Wed, 2 Sep 2026 11:33:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <32e816aa68489d4e6b0b2b24e99a6c8a4e3469bf.1787739852.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpMwPmZdqkksZAA--.26266S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww17JFWfGw17Xr1fJrWxKrX_yoWxur48pr
 W7CF9I9rW8GrWDJwn5ta4Y9Fn8Zr1xWw129a9ak34fCr4DJr15Xr1kK39rWFn8C348Ww1I
 vF1ru3WDWa47JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.635,
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



On 2026/8/26 下午6:30, SignKirigami wrote:
> Route configured hardware interrupts into the guest CSR bank, track guest
> interrupt requests separately, and expose guest pending and enable checks
> to the TCG runtime.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu.c         | 43 +++++++++++++++++++++++++---------
>   target/loongarch/internals.h   |  4 +++-
>   target/loongarch/tcg/tcg_cpu.c | 36 +++++++++++++++++++---------
>   3 files changed, 60 insertions(+), 23 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index c5c7f3e0e3..b12e8944de 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -57,41 +57,57 @@ static vaddr loongarch_cpu_get_pc(CPUState *cs)
>   #ifndef CONFIG_USER_ONLY
>   #include "hw/loongarch/virt.h"
>   
> -void loongarch_cpu_set_irq(void *opaque, int irq, int level)
> +void loongarch_cpu_set_irq_impl(void *opaque, int irq, int level,
> +                                bool guest)
>   {
>       LoongArchCPU *cpu = opaque;
>       CPULoongArchState *env = &cpu->env;
>       CPUState *cs = CPU(cpu);
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, guest);
> +    int interrupt = guest ? CPU_INTERRUPT_GUEST : CPU_INTERRUPT_HARD;
>   
Is it ok to keep function loongarch_cpu_set_irq() unchanged? using irq 
number to differentiate guest HW, value of irq of guest timer is defined 
as IRQ_VTIMER, such as

#define IRQ_VTIMER   (IRQ_TIMER + N_IRQS)

if (irq >= N_IRQS) {
     irq -= N_IRQS;
     guest = true;
}

The same for guest PMU/MSGINT HW in future.

>       if (irq < 0 || irq >= N_IRQS) {
>           return;
>       }

>   
> -    if (kvm_enabled()) {
> +    if (!guest && kvm_enabled()) {
>           kvm_loongarch_set_interrupt(cpu, irq, level);
>       } else if (tcg_enabled()) {
> +        if (!guest && irq >= 2 && irq < 10 &&
> +            (FIELD_EX64(sys->CSR_GINTC, CSR_GINTC, HWIP) &
> +             BIT(irq - 2))) {
> +            loongarch_cpu_set_irq_impl(opaque, irq, level, true);
> +            return;
> +        }
It is not necessary to check CSR_GINTC.

Regards
Bibo Mao
>           sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
> -        if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
> -            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> -        } else {
> -            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> +        if (!guest || env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
> +            if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
> +                cpu_interrupt(cs, interrupt);
> +            } else {
> +                cpu_reset_interrupt(cs, interrupt);
> +            }
>           }
>       }
>   }
>   
> +void loongarch_cpu_set_irq(void *opaque, int irq, int level)
> +{
> +    loongarch_cpu_set_irq_impl(opaque, irq, level, false);
> +}
> +
>   /* Check if there is pending and not masked out interrupt */
> -bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
> +bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env, bool guest)
>   {
>       uint32_t pending;
>       uint32_t status;
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, guest);
>   
>       pending = FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS);
> -    status  = FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, LIE);
> +    status = FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, LIE);
>   
>       return (pending & status) != 0;
>   }
> +
>   #endif
>   
>   #ifndef CONFIG_USER_ONLY
> @@ -100,7 +116,12 @@ bool loongarch_cpu_has_work(CPUState *cs)
>       bool has_work = false;
>   
>       if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
> -        cpu_loongarch_hw_interrupts_pending(cpu_env(cs))) {
> +        cpu_loongarch_hw_interrupts_pending(cpu_env(cs), false)) {
> +        has_work = true;
> +    }
> +
> +    if (cpu_test_interrupt(cs, CPU_INTERRUPT_GUEST) &&
> +        cpu_loongarch_hw_interrupts_pending(cpu_env(cs), true)) {
>           has_work = true;
>       }
>   
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index e01dbed40f..a23b0d3d58 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -32,6 +32,8 @@ void restore_fp_status(CPULoongArchState *env);
>   extern const VMStateDescription vmstate_loongarch_cpu;
>   
>   void loongarch_cpu_set_irq(void *opaque, int irq, int level);
> +void loongarch_cpu_set_irq_impl(void *opaque, int irq, int level,
> +                                bool guest);
>   
>   void loongarch_constant_timer_cb(void *opaque);
>   uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
> @@ -39,7 +41,7 @@ uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
>   void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
>                                                  uint64_t value);
>   bool loongarch_cpu_has_work(CPUState *cs);
> -bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
> +bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env, bool guest);
>   #endif /* !CONFIG_USER_ONLY */
>   
>   uint64_t read_fcc(CPULoongArchState *env);
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index 4b1d44a164..e84ef5f305 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -238,29 +238,43 @@ static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>       }
>   }
>   
> -static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env)
> +static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env, bool guest)
>   {
>       bool ret = 0;
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, guest);
> +    CPUSysState *host = get_sys(env, LOONGARCH_VM_LEVEL_HOST);
>   
>       ret = (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, IE) &&
> -          !(FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)));
> +          !(FIELD_EX64(host->CSR_DBG, CSR_DBG, DST)));
>   
>       return ret;
>   }
>   
>   static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>   {
> +    CPULoongArchState *env = cpu_env(cs);
> +    bool has_interrupt = false;
> +
>       if (interrupt_request & CPU_INTERRUPT_HARD) {
> -        CPULoongArchState *env = cpu_env(cs);
> -
> -        if (cpu_loongarch_hw_interrupts_enabled(env) &&
> -            cpu_loongarch_hw_interrupts_pending(env)) {
> -            /* Raise it */
> -            cs->exception_index = EXCCODE_INT;
> -            loongarch_cpu_do_interrupt(cs);
> -            return true;
> +        if (cpu_loongarch_hw_interrupts_enabled(env, false) &&
> +            cpu_loongarch_hw_interrupts_pending(env, false)) {
> +            if (env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
> +                trigger_vm_exit(env);
> +            }
> +            has_interrupt = true;
>           }
> +    } else if (interrupt_request & CPU_INTERRUPT_GUEST) {
> +        if (cpu_loongarch_hw_interrupts_enabled(env, true) &&
> +            cpu_loongarch_hw_interrupts_pending(env, true) &&
> +            env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
> +            has_interrupt = true;
> +        }
> +    }
> +    if (has_interrupt) {
> +        /* Raise it */
> +        cs->exception_index = EXCCODE_INT;
> +        loongarch_cpu_do_interrupt(cs);
> +        return true;
>       }
>       return false;
>   }
> 


