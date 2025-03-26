Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12373C36005
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 02:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txGuU-00059q-CJ; Tue, 25 Mar 2025 22:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1txGuS-00059T-CA
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 22:54:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1txGuO-0002c6-Kg
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 22:54:28 -0400
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8CxieBUbONnPZqmAA--.38838S3;
 Wed, 26 Mar 2025 10:54:12 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowMBxn8VRbONnyddgAA--.25980S3;
 Wed, 26 Mar 2025 10:54:11 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch/boot: Adjust the loading position of the
 initrd
To: bibo mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
References: <20250319083216.438159-1-lixianglai@loongson.cn>
 <7eb54b16-84ad-8b3e-fe5f-bc7435917fe3@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <607fcf63-1d51-c2f8-593d-7e59702406e9@loongson.cn>
Date: Wed, 26 Mar 2025 10:51:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7eb54b16-84ad-8b3e-fe5f-bc7435917fe3@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBxn8VRbONnyddgAA--.25980S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3WFyxGF15GFW3Cw45ZFW7WrX_yoW3JFy5pr
 s7JrW5JryDArn5Jr1xJr1UWFy7Ar18G3Z8XryxXFy8JrsFyr1jqr1UXryvgryDJw4rJF1U
 Jr1UXrnrZF17JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.031,
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



Hi bibo mao:
> Xianglai,
>
> Thanks for your patch, some comments inline.
>
> On 2025/3/19 下午4:32, Xianglai Li wrote:
>> When only the -kernel parameter is used to load the elf kernel,
>> the initrd is loaded in the ram. If the initrd size is too large,
>> the loading fails, resulting in a VM startup failure.
>> This patch first loads initrd near the kernel.
>> When the nearby memory space of the kernel is insufficient,
>> it tries to load it to the starting position of high-end memory.
>> If there is still not enough, qemu will report an error
>> and ask the user to increase the memory space for the
>> virtual machine to boot.
>>
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> ---
>> Cc: Bibo Mao <maobibo@loongson.cn>
>> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Cc: Song Gao <gaosong@loongson.cn>
>> Cc: Xianglai Li <lixianglai@loongson.cn>
>>
>>   hw/loongarch/boot.c         | 66 ++++++++++++++++++++++++++++++++-----
>>   hw/loongarch/virt.c         |  1 +
>>   include/hw/loongarch/boot.h |  1 +
>>   3 files changed, 59 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>> index 354cf458c8..3f094ebb39 100644
>> --- a/hw/loongarch/boot.c
>> +++ b/hw/loongarch/boot.c
>> @@ -235,6 +235,61 @@ static int64_t load_loongarch_linux_image(const 
>> char *filename,
>>       return size;
>>   }
>>   +static void find_initrd_loadoffset(struct loongarch_boot_info *info,
>> +                uint64_t kernel_high, ssize_t kernel_size)
>> +{
>> +    hwaddr base, size, gap;
>> +    ram_addr_t initrd_end, initrd_start;
>> +    int nb_numa_nodes;
>> +    NodeInfo *numa_info;
>> +
>> +    base = VIRT_LOWMEM_BASE;
>> +    gap = VIRT_LOWMEM_SIZE;
>> +    nb_numa_nodes = info->numa_state->num_nodes;
>> +    numa_info = info->numa_state->nodes;
>> +    initrd_start = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
>> +    initrd_end = initrd_start + initrd_size;
>> +
>> +    if (nb_numa_nodes) {
>> +        size = numa_info[0].node_mem;
> why is memory size of the node0 calculated here?
> initrd memory can be put at these places:
> 1) near kernel at low memory region.
> 2) start from high memory region located at VIRT_HIGHMEM_BASE
>
> It seems that it irrelative with numa memory

When the initrd cannot be loaded in the low memory,
we plan to load the initrd to the starting address of the high memory,
so we need to determine whether the high memory has enough space to put 
the initrd.
Meanwhile, we hope that the initrd can be loaded on node0 as much as 
possible
and avoid crossing memory nodes as much as possible.

When qemu specifies the node0 memory size and when no node0 memory size 
is specified,
the calculation method of the node0 memory size is different,
so we introduce the calculation of the node0 memory here.

If the memory size of node 0 is completely unable to load initrd,
we will ask users to increase the memory size of node 0,
and do not consider loading initrd to other memory nodes,
so as to simplify the calculation process

>> +    } else {
>> +        size = info->ram_size;
>> +    }
>> +    /*
>> +     * Try to load the initrd near the kernel image
>> +     */
>> +    if (size <= gap) {
>> +        if (initrd_end <= (base + gap)) {
>> +            initrd_offset = initrd_start;
>> +            return ;
>> +        }
> no else here. otherwise the sentence as following "size -= gap;" will 
> be negative.

Yes,This is a bug, I will fix it!
>> +    }
>> +
>> +    /*
>> +     * Try to load initrd in the high memory of node0
>> +     */
>> +    size -= gap;
>> +    base = VIRT_HIGHMEM_BASE;
>> +    initrd_start = ROUND_UP(base, 64 * KiB);
>> +    initrd_end = initrd_start + initrd_size;
>> +    if (initrd_end <= (base + size)) {
> it is a little complicated,  just the following will be ok
>    if (initrd_size <= size) {
>        initrd_offset = base;
>         return;
>    }
>
Ok!!

Thanks!
Xianglai.

> Regards
> Bibo Mao
>> +        initrd_offset = initrd_start;
>> +        return ;
>> +    }
>> +
>> +    if (nb_numa_nodes == 0) {
>> +        error_report("memory too small for initial ram disk '%s',"
>> +             "You need to expand the memory space",
>> +             info->initrd_filename);
>> +    } else {
>> +        error_report("memory too small for initial ram disk '%s',"
>> +            "You need to expand the memory space of node0",
>> +            info->initrd_filename);
>> +
>> +    }
>> +    exit(1);
>> +}
>> +
>>   static int64_t load_kernel_info(struct loongarch_boot_info *info)
>>   {
>>       uint64_t kernel_entry, kernel_low, kernel_high;
>> @@ -261,16 +316,9 @@ static int64_t load_kernel_info(struct 
>> loongarch_boot_info *info)
>>       if (info->initrd_filename) {
>>           initrd_size = get_image_size(info->initrd_filename);
>>           if (initrd_size > 0) {
>> -            initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 
>> 64 * KiB);
>> -
>> -            if (initrd_offset + initrd_size > info->ram_size) {
>> -                error_report("memory too small for initial ram disk 
>> '%s'",
>> -                             info->initrd_filename);
>> -                exit(1);
>> -            }
>> -
>> +            find_initrd_loadoffset(info, kernel_high, kernel_size);
>>               initrd_size = 
>> load_image_targphys(info->initrd_filename, initrd_offset,
>> -                                              info->ram_size - 
>> initrd_offset);
>> +                                              initrd_size);
>>           }
>>             if (initrd_size == (target_ulong)-1) {
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index a5840ff968..eb62abec0e 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -750,6 +750,7 @@ static void virt_init(MachineState *machine)
>> qemu_register_powerdown_notifier(&lvms->powerdown_notifier);
>>         lvms->bootinfo.ram_size = ram_size;
>> +    lvms->bootinfo.numa_state = machine->numa_state;
>>       loongarch_load_kernel(machine, &lvms->bootinfo);
>>   }
>>   diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
>> index b3b870df1f..e3887d7cc6 100644
>> --- a/include/hw/loongarch/boot.h
>> +++ b/include/hw/loongarch/boot.h
>> @@ -98,6 +98,7 @@ struct efi_initrd {
>>     struct loongarch_boot_info {
>>       uint64_t ram_size;
>> +    struct NumaState *numa_state;
>>       const char *kernel_filename;
>>       const char *kernel_cmdline;
>>       const char *initrd_filename;
>>


