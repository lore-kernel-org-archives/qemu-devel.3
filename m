Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C3BC71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 02:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRLfN-0000CU-VA; Mon, 16 Jun 2025 22:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uRLfL-0000CE-Hd
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 22:03:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uRLfJ-0005E7-K2
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 22:03:11 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxNHDVzFBoWxMYAQ--.55226S3;
 Tue, 17 Jun 2025 10:03:01 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAxzxvLzFBofcgdAQ--.37904S3;
 Tue, 17 Jun 2025 10:02:54 +0800 (CST)
Subject: Re: [PATCH 08/10] hw/loongarch: Implement avec set_irq
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250609104833.839811-1-gaosong@loongson.cn>
 <20250609104833.839811-9-gaosong@loongson.cn>
 <1cf3a214-407b-8d85-cc70-6576e413ec7d@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <7bc57b80-d97c-78ef-5d42-c9877c183e81@loongson.cn>
Date: Tue, 17 Jun 2025 10:05:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1cf3a214-407b-8d85-cc70-6576e413ec7d@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxzxvLzFBofcgdAQ--.37904S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF45Cw4xXFy3tFW7XrWDAwc_yoW5Kr47pF
 ykAFZ8XFyUJFs3Xr9rGw15uFy5Jr4xW3W7tF1SgFyIkF4qkr10grW8XrnIgF1UC3y8Xr1U
 Xr18Xa1fuF17JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j83kZU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.129,
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

在 2025/6/11 下午2:26, Bibo Mao 写道:
>
>
> On 2025/6/9 下午6:48, Song Gao wrote:
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/intc/loongarch_avec.c | 37 ++++++++++++++++++++++++++++++++++---
>>   1 file changed, 34 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
>> index c692fef43c..f609ed9aaa 100644
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
>> @@ -23,12 +29,32 @@ static uint64_t loongarch_avec_mem_read(void 
>> *opaque,
>>       return 0;
>>   }
>>   +static void avec_set_irq(LoongArchAVECState *s, int cpu_num, int 
>> irq_num, int level)
>> +{
>> +   MachineState *machine = MACHINE(qdev_get_machine());
>> +   MachineClass *mc = MACHINE_GET_CLASS(machine);
>> +   const CPUArchIdList *id_list = NULL;
>> +
>> +   assert(mc->possible_cpu_arch_ids(machine));
>> +   id_list = mc->possible_cpu_arch_ids(machine);
>> +   CPUState *cpu = id_list->cpus[cpu_num].cpu;
>> +   CPULoongArchState *env = &LOONGARCH_CPU(cpu)->env;
> The format is strange here. Variable env is declared after normal 
> sentence, there is such issue in many places.
>      id_list = mc->possible_cpu_arch_ids(machine);
>
>> +   set_bit(irq_num, &env->CSR_MSGIS[irq_num / 64]);
>> +   qemu_set_irq(s->cpu[cpu_num].parent_irq[irq_num], 1);
> Why is parent_irq array here?  I think one parent irq line is enough.
>
ok , i'll correct on v3.
>> +}
>> +
>>   static void loongarch_avec_mem_write(void *opaque, hwaddr addr,
>>                                        uint64_t val, unsigned size)
>>   {
>> -    return;
>> -}
>> +    int irq_num, cpu_num = 0;
>> +    LoongArchAVECState *s = LOONGARCH_AVEC(opaque);
>> +    uint64_t msg_addr = addr + VIRT_PCH_MSI_ADDR_LOW;
>> +
>> +    cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
>> +    irq_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
> blank line here.
Got it.
>> +    avec_set_irq(s, cpu_num, irq_num, 1);
>> +}
>>     static const MemoryRegionOps loongarch_avec_ops = {
>>       .read = loongarch_avec_mem_read,
>> @@ -38,7 +64,12 @@ static const MemoryRegionOps loongarch_avec_ops = {
>>     static void avec_irq_handler(void *opaque, int irq, int level)
>>   {
>> -    return;
>> +    int cpu_num, irq_num = 0;
>> +    LoongArchAVECState *s = LOONGARCH_AVEC(opaque);
>> +    cpu_num = irq / 256;
>> +    irq_num = irq % 256;
>> +
>> +    avec_set_irq(s, cpu_num, irq_num, level);
>>   }
> When is the function avec_irq_handler() called?
>
when some deviec gpio_out connect to avec gpio_in, since we define the 
avec qdev_init_gpio_in at
avec realize  and the avec_Irq_handler is the callback function.

Thanks.
Song Gao
> Regards
> Bibo Mao
>>     static void loongarch_avec_realize(DeviceState *dev, Error **errp)
>>


