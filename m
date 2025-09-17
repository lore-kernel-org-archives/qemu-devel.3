Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10059CAC592
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 02:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyhgK-0006fQ-PB; Tue, 16 Sep 2025 22:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uyhgH-0006ez-Rt
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 22:14:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uyhgE-0002sR-OW
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 22:14:01 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxVNBXGcpoiTMLAA--.23802S3;
 Wed, 17 Sep 2025 10:13:43 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxH8JUGcpobnuaAA--.45945S3;
 Wed, 17 Sep 2025 10:13:42 +0800 (CST)
Subject: Re: [PATCH v8 07/11] hw/loongarch: Implement dintc realize and
 unrealize
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250916122109.749813-1-gaosong@loongson.cn>
 <20250916122109.749813-8-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <e8c8626e-24f4-02cc-c18f-b69e6a710801@loongson.cn>
Date: Wed, 17 Sep 2025 10:11:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250916122109.749813-8-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxH8JUGcpobnuaAA--.45945S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1rZw15XF1DKr4xKr4UGFX_yoW8KFWrpr
 ZruFy5Kr1UXrsrJan2ga45WFsxurn3Wr1293WfKFZ2yFs8u34rXw48tr15uF9ruw1rWr1j
 qrn5A3W5ZF47JFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.599,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2025/9/16 下午8:21, Song Gao wrote:
> Implement th DINTC realize and unrealize.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/intc/loongarch_dintc.c | 23 ++++++++++++++++++++++-
>   target/loongarch/cpu.h    |  3 ++-
>   2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
> index 7173a6aa29..598c666ec6 100644
> --- a/hw/intc/loongarch_dintc.c
> +++ b/hw/intc/loongarch_dintc.c
> @@ -38,7 +38,12 @@ static const MemoryRegionOps loongarch_dintc_ops = {
>   
>   static void loongarch_dintc_realize(DeviceState *dev, Error **errp)
>   {
> +    LoongArchDINTCState *s = LOONGARCH_DINTC(dev);
>       LoongArchDINTCClass *lac = LOONGARCH_DINTC_GET_CLASS(dev);
> +    MachineState *machine = MACHINE(qdev_get_machine());
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    const CPUArchIdList  *id_list;
> +    int i;
>   
>       Error *local_err = NULL;
>       lac->parent_realize(dev, &local_err);
> @@ -47,12 +52,28 @@ static void loongarch_dintc_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    assert(mc->possible_cpu_arch_ids);
> +    id_list = mc->possible_cpu_arch_ids(machine);
> +    s->num_cpu = id_list->len;
> +    s->cpu = g_new(DINTCCore, s->num_cpu);
> +    if (s->cpu == NULL) {
> +        error_setg(errp, "Memory allocation for DINTCCore fail");
> +        return;
> +    }
> +
> +    for (i = 0; i < s->num_cpu; i++) {
> +        s->cpu[i].arch_id = id_list->cpus[i].arch_id;
> +        s->cpu[i].cpu = CPU(id_list->cpus[i].cpu);
> +        qdev_init_gpio_out(dev, &s->cpu[i].parent_irq, 1);
> +    }
> +
>       return;
>   }
>   
>   static void loongarch_dintc_unrealize(DeviceState *dev)
>   {
> -    return;
> +    LoongArchDINTCState *s = LOONGARCH_DINTC(dev);
> +    g_free(s->cpu);
>   }
>   
>   static void loongarch_dintc_init(Object *obj)
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 807a710810..237c93cdd6 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -217,9 +217,10 @@ FIELD(CSR_CRMD, WE, 9, 1)
>   extern const char * const regnames[32];
>   extern const char * const fregnames[32];
>   
> -#define N_IRQS      13
> +#define N_IRQS      15
>   #define IRQ_TIMER   11
>   #define IRQ_IPI     12
> +#define INT_DMSI    14
>   
>   #define LOONGARCH_STLB         2048 /* 2048 STLB */
>   #define LOONGARCH_MTLB         64   /* 64 MTLB */
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


