Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6258EC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6k8u-0002fA-5h; Wed, 16 Sep 2026 03:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1x6k8k-0002cG-1d
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 03:33:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1x6k8g-0003Rm-Ad
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 03:33:08 -0400
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8AxdvAtRqpqv4cMAA--.36553S3;
 Wed, 16 Sep 2026 15:33:01 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowJDxg8wqRqpqolUhAA--.44203S2;
 Wed, 16 Sep 2026 15:32:59 +0800 (CST)
Subject: Re: [PATCH v3] target/loongarch: Fix data race in CSR_ESTAT
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>,
 shankerwangmiao@gmail.com
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20260901034833.2215072-1-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <d0000abf-1f83-c3c6-dd1e-0ebaec3dc98f@loongson.cn>
Date: Wed, 16 Sep 2026 15:31:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260901034833.2215072-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxg8wqRqpqolUhAA--.44203S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXFWDZr48Aw13WFWfAw4UKFX_yoW5Wr1Dpr
 W7uF90gw4kKrWDZa4DGa9xZF98Zr4fWF1IvF4akryfCrWUJw45Wrykt3s7XF1Du34rWF40
 vFWrGFW5WF4UCFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcCD7
 UUUUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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


> The CSR_ESTAT register of a CPU can be read and written by both the
> CPU thread and other threads (e.g., the interrupt controller thread).
> Currently the possible readers and writers of CSR_ESTAT are:
>
> The access from the CPU thread is not synchronized with the access from
> other threads, which may lead to data races. The above readers and
> writers shall all run on the corresponding CPU thread except for
> loongarch_cpu_set_irq(). To fix this, the access to CSR_ESTAT in
> loongarch_cpu_set_irq() is moved to the CPU thread by using
> async_run_on_cpu().
>
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> Changes in v3:
>    1. Combine irq and level into 32 bit int type.
>    2. Rename do_set_cpu_estat() with loongarch_cpu_self_set_irq().
>
> Changes in v2:
>    Simplify the changes to move the access to CSR_ESTAT from the only
>    unsynchronized loongarch_cpu_set_irq() to the CPU thread using
>    async_run_on_cpu() to avoid the race condition.
> ---
>   target/loongarch/cpu.c | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 84a130956d..3bfc9a8034 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -75,13 +75,26 @@ void loongarch_cpu_update_irq(LoongArchCPU *cpu, uint64_t old)
>       }
>   }
>   
> -void loongarch_cpu_set_irq(void *opaque, int irq, int level)
> +static void loongarch_cpu_self_set_irq(CPUState *cs, run_on_cpu_data data)
>   {
> -    LoongArchCPU *cpu = opaque;
> -    CPULoongArchState *env = &cpu->env;
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +    CPULoongArchState *env = cpu_env(cs);
>       CPUSysState *sys = env_sys(env);
> +    int irq, level;
>       uint64_t old;
>   
> +    irq = data.host_int & ~BIT(31);
> +    level = (data.host_int >> 31) & 1;
> +    old = sys->CSR_ESTAT;
> +    sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
> +    loongarch_cpu_update_irq(cpu, old);
> +}
> +
> +void loongarch_cpu_set_irq(void *opaque, int irq, int level)
> +{
> +    LoongArchCPU *cpu = opaque;
> +    CPUState *cs = CPU(cpu);
> +
>       if (irq < 0 || irq >= N_IRQS) {
>           return;
>       }
> @@ -89,9 +102,9 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>       if (kvm_enabled()) {
>           kvm_loongarch_set_interrupt(cpu, irq, level);
>       } else if (tcg_enabled()) {
> -        old = sys->CSR_ESTAT;
> -        sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
> -        loongarch_cpu_update_irq(cpu, old);
> +        irq |= (level & 1) << 31;
> +        async_run_on_cpu(cs, loongarch_cpu_self_set_irq,
> +                         RUN_ON_CPU_HOST_INT(irq));
>       }
>   }
>   
>
> base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475


  Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>



