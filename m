Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393F8CA6017
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 04:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFOLj-0006mJ-Pj; Sat, 10 Oct 2026 00:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xFOLe-0006m5-Ov
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 00:06:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xFOLa-0003D9-Gc
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 00:06:13 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxUNGwuclq0GEUAA--.59327S3;
 Sat, 10 Oct 2026 12:06:08 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxxMyvuclqZrsqAA--.63104S2;
 Sat, 10 Oct 2026 12:06:07 +0800 (CST)
Subject: Re: [PATCH v5 08/23] target/loongarch: add LVZ guest timer
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1791514848.git.prcups@krgm.moe>
 <519eadd31f0af84ce49794e1922527d7c8d99104.1791514848.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <ad1759b4-4333-2b1c-0700-4bb325d84ebf@loongson.cn>
Date: Sat, 10 Oct 2026 12:07:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <519eadd31f0af84ce49794e1922527d7c8d99104.1791514848.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxxMyvuclqZrsqAA--.63104S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ArW8KF1rGFyxtFW3CF4ftFc_yoW8KrWfpr
 ZrCF17KrWUtFZFyas7Jws8ur1DWr17Wr129a13KrWIkFsxJr1jvF1Ut39F9Fs7X3y8Gr1x
 XF1rZFn8XanxXacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vA
 pUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.591,
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



On 2026/10/9 上午11:05, SignKirigami wrote:
> Add a separate guest timer and IRQ_VTIMER.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu.c | 8 +++++++-
>   target/loongarch/cpu.h | 6 ++++++
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 5cef63a778..8e759a2987 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -770,7 +770,7 @@ static void loongarch_cpu_init(Object *obj)
>       LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>   #ifdef CONFIG_TCG
>       CPULoongArchState *env = &cpu->env;
> -    CPUTimerState *timer;
> +    CPUTimerState *timer, *guest_timer;
>   #endif
>   
>       qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, N_IRQS);
If cpu_has_lvz(), I think here N_IRQS should be N_VIRQS.

> @@ -778,8 +778,14 @@ static void loongarch_cpu_init(Object *obj)
>       timer = env_timer(env);
>       timer->irq = IRQ_TIMER;
>       timer->cs  = CPU(obj);
> +    guest_timer = env_guest_timer(env);
> +    guest_timer->irq = IRQ_VTIMER;
> +    guest_timer->cs = CPU(obj);
> +
>       timer_init_ns(&timer->timer, QEMU_CLOCK_VIRTUAL,
>                     &cpu_loongarch_timer_cb, timer);
> +    timer_init_ns(&guest_timer->timer, QEMU_CLOCK_VIRTUAL,
> +                  &cpu_loongarch_timer_cb, guest_timer);
Had better add cpu_has_lvz() when create guest timer.

Regards
Bibo Mao
>   #endif
>   #endif
>   }
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 8939dbc748..ba28d80272 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -245,6 +245,7 @@ extern const char * const fregnames[32];
>   #define IRQ_IPI     12
>   #define INT_DMSI    14
>   #define N_VIRQS     (N_IRQS * 2)
> +#define IRQ_VTIMER  (N_IRQS + IRQ_TIMER)
>   
>   #define MAX_PERF_EVENTS        16
>   #define LOONGARCH_STLB         2048 /* 2048 STLB */
> @@ -577,6 +578,11 @@ static inline CPUTimerState *env_timer(CPULoongArchState *env)
>       return &env->sys_states[0].timer_state;
>   }
>   
> +static inline CPUTimerState *env_guest_timer(CPULoongArchState *env)
> +{
> +    return &env->sys_states[1].timer_state;
> +}
> +
>   static inline bool is_la64(CPULoongArchState *env)
>   {
>       return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
> 


