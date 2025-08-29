Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97C4CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN85-0001bI-5l; Sat, 30 Aug 2025 11:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1urtHm-0002Yh-Oy
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:12:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1urtHi-0006R2-R2
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:12:34 -0400
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8BxWNHSUrFor3wEAA--.9142S3;
 Fri, 29 Aug 2025 15:12:18 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowJDxrcHPUrFoJyxwAA--.64494S3;
 Fri, 29 Aug 2025 15:12:17 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch/virt: Fix the cpu hotplug issue
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20250829013243.1237107-1-lixianglai@loongson.cn>
 <34bc7ebf-4a7e-d2f8-65de-529ef658be49@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <a2825117-0fc1-1f5a-8128-d322ce94de06@loongson.cn>
Date: Fri, 29 Aug 2025 15:11:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <34bc7ebf-4a7e-d2f8-65de-529ef658be49@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxrcHPUrFoJyxwAA--.64494S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw43uFykXryDGw4xCF18CrX_yoWrWr1fpr
 WkAF1UJrWUCrn7Z39rG345uFyDJr13K3ZxWF17tFW0kr4DXr1jqr1jvwnFgF1UAw48WF18
 Zr1kZw17ZF43ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU24SoDUUU
 U
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.357,
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

Hi Bibo Mao:
>
>
> On 2025/8/29 上午9:32, Xianglai Li wrote:
>> The hot-plugged cpu does not register the cpu reset function, so the cpu
>> plugged in later cannot reset properly, and there will be problems when
>> restarting.
>>
>> Now register the cpu reset function in the cpu hotplug callback 
>> function.
> Oh, it is actually one problem and it is missing :(. There is similiar 
> patch posted at:
>
> https://lore.kernel.org/qemu-devel/20241031065418.3111892-1-maobibo@loongson.cn/ 
>
>

This patch seems more reasonable. Please ignore the patch I currently 
submitted,
Hope it will be merged in soon.

Thanks!
Xianglai.

> I prefer to adding cpu reset in CPU object realize function rather 
> hotplug handler, and executing reset_load_elf() in board specific
> reset callback. However peter has different thoughts.
>
> Regards
> Bibo Mao
>>
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> ---
>>   hw/loongarch/boot.c         | 8 +-------
>>   hw/loongarch/virt.c         | 4 ++++
>>   include/hw/loongarch/virt.h | 1 +
>>   3 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>> index 14d6c52d4e..6bc1f3d50c 100644
>> --- a/hw/loongarch/boot.c
>> +++ b/hw/loongarch/boot.c
>> @@ -324,7 +324,7 @@ static int64_t load_kernel_info(struct 
>> loongarch_boot_info *info)
>>       return kernel_entry;
>>   }
>>   -static void reset_load_elf(void *opaque)
>> +void reset_load_elf(void *opaque)
>>   {
>>       LoongArchCPU *cpu = opaque;
>>       CPULoongArchState *env = &cpu->env;
>> @@ -429,12 +429,6 @@ static void 
>> loongarch_direct_kernel_boot(MachineState *ms,
>>   void loongarch_load_kernel(MachineState *ms, struct 
>> loongarch_boot_info *info)
>>   {
>>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
>> -    int i;
>> -
>> -    /* register reset function */
>> -    for (i = 0; i < ms->smp.cpus; i++) {
>> -        qemu_register_reset(reset_load_elf, 
>> LOONGARCH_CPU(qemu_get_cpu(i)));
>> -    }
>>         info->kernel_filename = ms->kernel_filename;
>>       info->kernel_cmdline = ms->kernel_cmdline;
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index b15ada2078..71f8ddc980 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -1013,6 +1013,8 @@ static void virt_cpu_unplug(HotplugHandler 
>> *hotplug_dev,
>>       /* Notify acpi ged CPU removed */
>>       hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, 
>> &error_abort);
>>   +    /* unregister reset function */
>> +    qemu_unregister_reset(reset_load_elf, cpu);
>>       cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
>>       cpu_slot->cpu = NULL;
>>   }
>> @@ -1037,6 +1039,8 @@ static void virt_cpu_plug(HotplugHandler 
>> *hotplug_dev,
>>                                &error_abort);
>>       }
>>   +    /* register reset function */
>> +    qemu_register_reset(reset_load_elf, cpu);
>>       cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
>>       cpu_slot->cpu = CPU(dev);
>>   }
>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>> index 602feab0f0..15ea393386 100644
>> --- a/include/hw/loongarch/virt.h
>> +++ b/include/hw/loongarch/virt.h
>> @@ -71,6 +71,7 @@ struct LoongArchVirtMachineState {
>>   OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, 
>> LOONGARCH_VIRT_MACHINE)
>>   void virt_acpi_setup(LoongArchVirtMachineState *lvms);
>>   void virt_fdt_setup(LoongArchVirtMachineState *lvms);
>> +void reset_load_elf(void *opaque);
>>     static inline bool 
>> virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
>>   {
>>


