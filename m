Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A36C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 07:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWrjk-0006Hc-Lx; Wed, 02 Jul 2025 03:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uWrji-0006HO-5q
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:18:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uWrjf-0004Zw-6d
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:18:29 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bx7eI73WRoTg8hAQ--.36778S3;
 Wed, 02 Jul 2025 15:18:19 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJBxpeQ43WRofmgGAA--.36788S3;
 Wed, 02 Jul 2025 15:18:19 +0800 (CST)
Subject: Re: [PATCH v3 7/9] hw/loongarch: Implement avec set irq
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250627030138.2482055-1-gaosong@loongson.cn>
 <20250627030138.2482055-8-gaosong@loongson.cn>
 <eac2cad7-d0a9-9d65-e98e-1e0f5d719a42@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <ca4adb80-dfd0-b1d2-50ab-9b6cace43081@loongson.cn>
Date: Wed, 2 Jul 2025 15:21:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <eac2cad7-d0a9-9d65-e98e-1e0f5d719a42@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxpeQ43WRofmgGAA--.36788S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw18ZF47tr47WF43uF1fXwc_yoW5KFyxpF
 1kArZ8WryUJrn3XrnxG345ZFy3Jr10q3W7XF1IgFyIyF4DCr10grW8XrnFgF1UAw4rGr4U
 Zr18Xw43ZF17JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcDDGUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

在 2025/7/2 上午11:15, Bibo Mao 写道:
>
>
> On 2025/6/27 上午11:01, Song Gao wrote:
>> Implement avec set irq and update CSR_MSIS and CSR_MSGIR.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/intc/loongarch_avec.c | 44 ++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 42 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
>> index c686ac9483..5959d05d13 100644
>> --- a/hw/intc/loongarch_avec.c
>> +++ b/hw/intc/loongarch_avec.c
>> @@ -16,6 +16,12 @@
>>   #include "migration/vmstate.h"
>>   #include "trace.h"
>>   #include "hw/qdev-properties.h"
>> +#include "target/loongarch/cpu.h"
>> +
>> +/* msg addr field */
>> +FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
>> +FIELD(MSG_ADDR, CPU_NUM, 12, 8)
>> +FIELD(MSG_ADDR, FIX, 28, 12)
>>     static uint64_t loongarch_avec_mem_read(void *opaque,
>>                                           hwaddr addr, unsigned size)
>> @@ -23,12 +29,46 @@ static uint64_t loongarch_avec_mem_read(void 
>> *opaque,
>>       return 0;
>>   }
>>   +static void avec_set_irq(LoongArchAVECState *s, int cpu_num, int 
>> irq_num, int level)
>> +{
>> +    MachineState *machine = MACHINE(qdev_get_machine());
>> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
>> +    const CPUArchIdList *id_list = NULL;
>> +    CPUState *cpu;
>> +    CPULoongArchState *env;
>> +    int i;
>> +
>> +    assert(mc->possible_cpu_arch_ids(machine));
>> +    id_list = mc->possible_cpu_arch_ids(machine);
>> +    cpu = id_list->cpus[cpu_num].cpu;
>> +    env = &LOONGARCH_CPU(cpu)->env;
>> +
>> +    if (level) {
>> +        set_bit(irq_num, &env->CSR_MSGIS[irq_num / 64]);
>> +        env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, 
>> INTNUM, irq_num);
>> +        env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, 
>> ACTIVE, 0);
>> +
>> +        for (i = 0; i < ARRAY_SIZE(env->CSR_MSGIS); i++) {
>> +            if (env->CSR_MSGIS[i]) {
>> +                return;
>> +            }
>> +        }
>> +        qemu_set_irq(s->cpu[cpu_num].parent_irq, 0);
and thecheck CSR_MSGIS[4] is from v2 comment.
> Here such code can inject interrupt to cpu side.
>   if (level) {
>       set_bit(irq_num, &env->CSR_MSGIS[irq_num / 64]);
>       qemu_set_irq(s->cpu[cpu_num].parent_irq, 1);
>   }
>
but, we also need set CSRIR,  Otherwise, it will cause the kernel to 
faill into a deep loop on avec driver avecintc_irq_dispatch();

Thanks.
Song Gao.
> Regards
> Bibo Mao
>> +    }
>> +    qemu_set_irq(s->cpu[cpu_num].parent_irq, level);
>> +}
>> +
>>   static void loongarch_avec_mem_write(void *opaque, hwaddr addr,
>>                                        uint64_t val, unsigned size)
>>   {
>> -    return;
>> -}
>> +    int irq_num, cpu_num = 0;
>> +    LoongArchAVECState *s = LOONGARCH_AVEC(opaque);
>> +    uint64_t msg_addr = addr + VIRT_AVEC_BASE;
>>   +    cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
>> +    irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
>> +    avec_set_irq(s, cpu_num, irq_num, 1);
>> +}
>>     static const MemoryRegionOps loongarch_avec_ops = {
>>       .read = loongarch_avec_mem_read,
>>


