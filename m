Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9460C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucK0h-000299-MS; Thu, 17 Jul 2025 04:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1ucK0c-0001vD-Lv
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:30:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1ucK0Z-00024J-DM
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:30:30 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Axz3OatHho7vYrAQ--.24782S3;
 Thu, 17 Jul 2025 16:30:18 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJDx_8OXtHho08EaAA--.12164S3;
 Thu, 17 Jul 2025 16:30:17 +0800 (CST)
Subject: Re: [PATCH v5 08/11] hw/loongarch: Implement avec set irq
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250711085915.3042395-1-gaosong@loongson.cn>
 <20250711085915.3042395-9-gaosong@loongson.cn>
 <d27adfdf-ef1e-e46c-3af0-3ceb731dc64f@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <7fefe852-c308-54bf-ef38-c261a498edab@loongson.cn>
Date: Thu, 17 Jul 2025 16:33:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d27adfdf-ef1e-e46c-3af0-3ceb731dc64f@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDx_8OXtHho08EaAA--.12164S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXFW8Gw4DGF4DGryDtw13trc_yoW5ZrW7pF
 1kArZ8WryUJrn3XwnxG345WFy5Jr1xWw17t3WIgFyIyF1Dur10gry8Xr1qgF1UCw48Xr1U
 Xr18X3W3uF17JrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.695,
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

在 2025/7/14 下午5:29, Bibo Mao 写道:
>
>
> On 2025/7/11 下午4:59, Song Gao wrote:
>> Implement avec set irq and update CSR_MSIS.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/intc/loongarch_avec.c | 34 ++++++++++++++++++++++++++++++++--
>>   1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
>> index 1f9f376898..af6c75c4a9 100644
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
>> @@ -23,12 +29,36 @@ static uint64_t loongarch_avec_mem_read(void 
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
>> +
>> +    assert(mc->possible_cpu_arch_ids(machine));
>> +    id_list = mc->possible_cpu_arch_ids(machine);
>> +    cpu = id_list->cpus[cpu_num].cpu;
>> +    env = &LOONGARCH_CPU(cpu)->env;
>> +
>> +    if (level) {
>> +        set_bit(irq_num, &env->CSR_MSGIS[irq_num / 64]);
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
> Here is physical cpuid rather than logic cpu index. We need convert 
> physical cpuid to logic cpu index.
How about the following code;
+    CPUState * cpu = cpu_by_arch_id(cpu_num);
+    cpu_num = cpu->cpu_index;

or like the IPI device add an  function pointer in LoongsonIPICommonClass
     LoongsonIPICommonClass {
     [..]
     int (*cpu_by_arch_id)(LoongsonIPICommonState *lics, int64_t id,
                           int *index, CPUState **pcs);
     [...]


Thanks.
Song Gao

>
> Regards
> Bibo Mao
>> +    irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
>> +    avec_set_irq(s, cpu_num, irq_num, 1);
>> +}
>>     static const MemoryRegionOps loongarch_avec_ops = {
>>       .read = loongarch_avec_mem_read,
>>


