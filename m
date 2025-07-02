Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C639EC8303D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 03:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWnyc-0005e3-Sv; Tue, 01 Jul 2025 23:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uWnyZ-0005db-Fv
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 23:17:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uWnyS-0005BU-RY
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 23:17:34 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxG6zBpGRovvogAQ--.31104S3;
 Wed, 02 Jul 2025 11:17:22 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxZOS9pGRoqSwGAA--.35198S3;
 Wed, 02 Jul 2025 11:17:20 +0800 (CST)
Subject: Re: [PATCH v3 7/9] hw/loongarch: Implement avec set irq
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250627030138.2482055-1-gaosong@loongson.cn>
 <20250627030138.2482055-8-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <eac2cad7-d0a9-9d65-e98e-1e0f5d719a42@loongson.cn>
Date: Wed, 2 Jul 2025 11:15:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250627030138.2482055-8-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxZOS9pGRoqSwGAA--.35198S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXrWUKw1kWr4DWF1UGw17Jwc_yoW5GFWUpa
 n3AF90gr15Jr47Za9xG345ZrnxXr40gryxX3ZFkF92kFyDWr18WrWkJr9rtF48C345WrWj
 vrn5Ga15W3W7JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
 WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7pnQ
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.077,
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



On 2025/6/27 上午11:01, Song Gao wrote:
> Implement avec set irq and update CSR_MSIS and CSR_MSGIR.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/intc/loongarch_avec.c | 44 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
> index c686ac9483..5959d05d13 100644
> --- a/hw/intc/loongarch_avec.c
> +++ b/hw/intc/loongarch_avec.c
> @@ -16,6 +16,12 @@
>   #include "migration/vmstate.h"
>   #include "trace.h"
>   #include "hw/qdev-properties.h"
> +#include "target/loongarch/cpu.h"
> +
> +/* msg addr field */
> +FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
> +FIELD(MSG_ADDR, CPU_NUM, 12, 8)
> +FIELD(MSG_ADDR, FIX, 28, 12)
>   
>   static uint64_t loongarch_avec_mem_read(void *opaque,
>                                           hwaddr addr, unsigned size)
> @@ -23,12 +29,46 @@ static uint64_t loongarch_avec_mem_read(void *opaque,
>       return 0;
>   }
>   
> +static void avec_set_irq(LoongArchAVECState *s, int cpu_num, int irq_num, int level)
> +{
> +    MachineState *machine = MACHINE(qdev_get_machine());
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    const CPUArchIdList *id_list = NULL;
> +    CPUState *cpu;
> +    CPULoongArchState *env;
> +    int i;
> +
> +    assert(mc->possible_cpu_arch_ids(machine));
> +    id_list = mc->possible_cpu_arch_ids(machine);
> +    cpu = id_list->cpus[cpu_num].cpu;
> +    env = &LOONGARCH_CPU(cpu)->env;
> +
> +    if (level) {
> +        set_bit(irq_num, &env->CSR_MSGIS[irq_num / 64]);
> +        env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, INTNUM, irq_num);
> +        env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, ACTIVE, 0);
> +
> +        for (i = 0; i < ARRAY_SIZE(env->CSR_MSGIS); i++) {
> +            if (env->CSR_MSGIS[i]) {
> +                return;
> +            }
> +        }
> +        qemu_set_irq(s->cpu[cpu_num].parent_irq, 0);
Here such code can inject interrupt to cpu side.
   if (level) {
       set_bit(irq_num, &env->CSR_MSGIS[irq_num / 64]);
       qemu_set_irq(s->cpu[cpu_num].parent_irq, 1);
   }

Regards
Bibo Mao
> +    }
> +    qemu_set_irq(s->cpu[cpu_num].parent_irq, level);
> +}
> +
>   static void loongarch_avec_mem_write(void *opaque, hwaddr addr,
>                                        uint64_t val, unsigned size)
>   {
> -    return;
> -}
> +    int irq_num, cpu_num = 0;
> +    LoongArchAVECState *s = LOONGARCH_AVEC(opaque);
> +    uint64_t msg_addr = addr + VIRT_AVEC_BASE;
>   
> +    cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
> +    irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
> +    avec_set_irq(s, cpu_num, irq_num, 1);
> +}
>   
>   static const MemoryRegionOps loongarch_avec_ops = {
>       .read = loongarch_avec_mem_read,
> 


