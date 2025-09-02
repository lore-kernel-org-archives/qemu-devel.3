Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565ACCA1002
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 02:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utGT3-00034O-9k; Mon, 01 Sep 2025 22:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1utGT0-000346-DE
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 22:09:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1utGSx-0001ap-3p
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 22:09:49 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxxtDjUbZoOpkFAA--.11340S3;
 Tue, 02 Sep 2025 10:09:39 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxZOTgUbZoKxF4AA--.48545S3;
 Tue, 02 Sep 2025 10:09:38 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch/virt: Fix the cpu hotplug issue
To: Igor Mammedov <imammedo@redhat.com>
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20250829013243.1237107-1-lixianglai@loongson.cn>
 <34bc7ebf-4a7e-d2f8-65de-529ef658be49@loongson.cn>
 <20250901135846.12a9c3e2@fedora>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <85e19964-52a1-bc97-5287-ed5e5b3ec41a@loongson.cn>
Date: Tue, 2 Sep 2025 10:07:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250901135846.12a9c3e2@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxZOTgUbZoKxF4AA--.48545S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF43ur1DAw4xWr47Zr1fGrX_yoWrZw15pr
 WUCFn0kF4kJr47Z39Fq34Y9F1qywsxKr43WFnxtrWFkw4qqr1DXF1jvw47uFWUA3Wru3WF
 vr9a9a1SvF4av3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.599,
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



On 2025/9/1 下午7:58, Igor Mammedov wrote:
> On Fri, 29 Aug 2025 10:31:57 +0800
> Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> On 2025/8/29 上午9:32, Xianglai Li wrote:
>>> The hot-plugged cpu does not register the cpu reset function, so the cpu
>>> plugged in later cannot reset properly, and there will be problems when
>>> restarting.
>>>
>>> Now register the cpu reset function in the cpu hotplug callback function.
>> Oh, it is actually one problem and it is missing :(. There is similiar
>> patch posted at:
>>   
>> https://lore.kernel.org/qemu-devel/20241031065418.3111892-1-maobibo@loongson.cn/
>>
>> I prefer to adding cpu reset in CPU object realize function rather
>> hotplug handler, and executing reset_load_elf() in board specific
>> reset callback. However peter has different thoughts.
> 
> this patch and above mentioned one expose direct boot specific
> reset_load_elf() on a generic hardware bring up path. That's
> probably isn't right.
> 
> Ideally default (cpu_reset()) reset would happen 1st during
> cpu creation/board init and then direct boot would patch
> the CPU that actually would execute payload.
> 
> PS:
> what's the reason to call reset_load_elf() on all present
> vCPUs and why hotplugged ones matter here?
> 
> Shouldn't direct booted QEMU patch BSP only?
yes, reset_load_elf() is only BSP relative, now BSP directly jumps
to kernel entry, AP jump to slave_boot_code[]. Ideally both BSP and
AP can jump to aux boot code if it boot code works like EFI bios, then 
reset_load_elf() is not necessary for BSP also. I will try it.

Regards
Bibo Mao

> 
>>
>> Regards
>> Bibo Mao
>>>
>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>> ---
>>>    hw/loongarch/boot.c         | 8 +-------
>>>    hw/loongarch/virt.c         | 4 ++++
>>>    include/hw/loongarch/virt.h | 1 +
>>>    3 files changed, 6 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>>> index 14d6c52d4e..6bc1f3d50c 100644
>>> --- a/hw/loongarch/boot.c
>>> +++ b/hw/loongarch/boot.c
>>> @@ -324,7 +324,7 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>>>        return kernel_entry;
>>>    }
>>>    
>>> -static void reset_load_elf(void *opaque)
>>> +void reset_load_elf(void *opaque)
>>>    {
>>>        LoongArchCPU *cpu = opaque;
>>>        CPULoongArchState *env = &cpu->env;
>>> @@ -429,12 +429,6 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
>>>    void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
>>>    {
>>>        LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
>>> -    int i;
>>> -
>>> -    /* register reset function */
>>> -    for (i = 0; i < ms->smp.cpus; i++) {
>>> -        qemu_register_reset(reset_load_elf, LOONGARCH_CPU(qemu_get_cpu(i)));
>>> -    }
>>>    
>>>        info->kernel_filename = ms->kernel_filename;
>>>        info->kernel_cmdline = ms->kernel_cmdline;
>>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>>> index b15ada2078..71f8ddc980 100644
>>> --- a/hw/loongarch/virt.c
>>> +++ b/hw/loongarch/virt.c
>>> @@ -1013,6 +1013,8 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
>>>        /* Notify acpi ged CPU removed */
>>>        hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &error_abort);
>>>    
>>> +    /* unregister reset function */
>>> +    qemu_unregister_reset(reset_load_elf, cpu);
>>>        cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
>>>        cpu_slot->cpu = NULL;
>>>    }
>>> @@ -1037,6 +1039,8 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>>>                                 &error_abort);
>>>        }
>>>    
>>> +    /* register reset function */
>>> +    qemu_register_reset(reset_load_elf, cpu);
>>>        cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
>>>        cpu_slot->cpu = CPU(dev);
>>>    }
>>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>>> index 602feab0f0..15ea393386 100644
>>> --- a/include/hw/loongarch/virt.h
>>> +++ b/include/hw/loongarch/virt.h
>>> @@ -71,6 +71,7 @@ struct LoongArchVirtMachineState {
>>>    OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
>>>    void virt_acpi_setup(LoongArchVirtMachineState *lvms);
>>>    void virt_fdt_setup(LoongArchVirtMachineState *lvms);
>>> +void reset_load_elf(void *opaque);
>>>    
>>>    static inline bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
>>>    {
>>>    
>>
>>


