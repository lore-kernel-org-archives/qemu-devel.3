Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172A7C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 01:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkZx7-00086L-6V; Wed, 13 Mar 2024 21:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rkZx4-000861-Gb
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 21:32:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rkZx1-0004Fe-AX
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 21:32:10 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8DxWPCLU_Jl5ewYAA--.60037S3;
 Thu, 14 Mar 2024 09:31:55 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxHBOJU_JlCWJZAA--.38846S3; 
 Thu, 14 Mar 2024 09:31:55 +0800 (CST)
Subject: Re: [PATCH v6 03/17] hw/loongarch: Add slave cpu boot_code
From: maobibo <maobibo@loongson.cn>
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-4-gaosong@loongson.cn>
 <aa286d89-1741-38cc-2064-2b5613432b4b@loongson.cn>
 <1c7a3e17-265c-55bd-0dd9-5a549ec577b3@loongson.cn>
 <af231e3f-0461-d539-f0bc-561421684ca4@loongson.cn>
Message-ID: <b96de51a-9adf-0dbc-f8f2-d3d3e2a66ff8@loongson.cn>
Date: Thu, 14 Mar 2024 09:31:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <af231e3f-0461-d539-f0bc-561421684ca4@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHBOJU_JlCWJZAA--.38846S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFWrury3Ww15uFWDXr4DJrc_yoWxuw1xpr
 4kJFy5Ary5Jr1ktr1UK34UJr9IyF18Jw1DXr1xXF1UJrsIqr12gr1UXryqgr1DJr48Jr1U
 Xr1UXrnrZF13JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.763,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2024/3/11 下午2:50, maobibo wrote:
> 
> 
> On 2024/3/8 下午5:36, gaosong wrote:
>>
>>
>> 在 2024/3/8 16:27, maobibo 写道:
>>>
>>>
>>> On 2024/3/8 上午12:48, Song Gao wrote:
>>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>>> Message-Id: <20240301093839.663947-4-gaosong@loongson.cn>
>>>> ---
>>>>   hw/loongarch/boot.c | 70 
>>>> ++++++++++++++++++++++++++++++++++++++++++++-
>>>>   1 file changed, 69 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>>>> index 149deb2e01..e560ac178a 100644
>>>> --- a/hw/loongarch/boot.c
>>>> +++ b/hw/loongarch/boot.c
>>>> @@ -15,6 +15,54 @@
>>>>   #include "sysemu/reset.h"
>>>>   #include "sysemu/qtest.h"
>>>> +static const unsigned int slave_boot_code[] = {
>>>> +                  /* Configure reset ebase.         */
>>>> +    0x0400302c,   /* csrwr      $r12,0xc            */
>>>> +
>>>> +                  /* Disable interrupt.             */
>>>> +    0x0380100c,   /* ori        $r12,$r0,0x4        */
>>>> +    0x04000180,   /* csrxchg    $r0,$r12,0x0        */
>>>> +
>>>> +                  /* Clear mailbox.                 */
>>>> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
>>>> +    0x038081ad,   /* ori        $r13,$r13,0x20      */
>>>> +    0x06481da0,   /* iocsrwr.d  $r0,$r13            */
>>>> +
>>>> +                  /* Enable IPI interrupt.          */
>>>> +    0x1400002c,   /* lu12i.w    $r12,1(0x1)         */
>>>> +    0x0400118c,   /* csrxchg    $r12,$r12,0x4       */
>>>> +    0x02fffc0c,   /* addi.d     $r12,$r0,-1(0xfff)  */
>>>> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
>>>> +    0x038011ad,   /* ori        $r13,$r13,0x4       */
>>>> +    0x064819ac,   /* iocsrwr.w  $r12,$r13           */
>>>> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
>>>> +    0x038081ad,   /* ori        $r13,$r13,0x20      */
>>>> +
>>>> +                  /* Wait for wakeup  <.L11>:       */
>>>> +    0x06488000,   /* idle       0x0                 */
>>>> +    0x03400000,   /* andi       $r0,$r0,0x0         */
>>>> +    0x064809ac,   /* iocsrrd.w  $r12,$r13           */
>>>> +    0x43fff59f,   /* beqz       $r12,-12(0x7ffff4) # 48 <.L11> */
>>>> +
>>>> +                  /* Read and clear IPI interrupt.  */
>>>> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
>>>> +    0x064809ac,   /* iocsrrd.w  $r12,$r13           */
>>>> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
>>>> +    0x038031ad,   /* ori        $r13,$r13,0xc       */
>>>> +    0x064819ac,   /* iocsrwr.w  $r12,$r13           */
>>>> +
>>>> +                  /* Disable  IPI interrupt.        */
>>>> +    0x1400002c,   /* lu12i.w    $r12,1(0x1)         */
>>>> +    0x04001180,   /* csrxchg    $r0,$r12,0x4        */
>>>> +
>>>> +                  /* Read mail buf and jump to specified entry */
>>>> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
>>>> +    0x038081ad,   /* ori        $r13,$r13,0x20      */
>>>> +    0x06480dac,   /* iocsrrd.d  $r12,$r13           */
>>>> +    0x00150181,   /* move       $r1,$r12            */
>>>> +    0x4c000020,   /* jirl       $r0,$r1,0           */
>>>> +};
>>>> +
>>>>   static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t 
>>>> addr)
>>>>   {
>>>>       return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
>>>> @@ -111,8 +159,15 @@ static void 
>>>> loongarch_firmware_boot(LoongArchMachineState *lams,
>>>>       fw_cfg_add_kernel_info(info, lams->fw_cfg);
>>>>   }
>>>> +static void init_boot_rom(struct loongarch_boot_info *info, void *p)
>>>> +{
>>>> +    memcpy(p, &slave_boot_code, sizeof(slave_boot_code));
>>>> +    p += sizeof(slave_boot_code);
>>>> +}
>>>> +
>>>>   static void loongarch_direct_kernel_boot(struct 
>>>> loongarch_boot_info *info)
>>>>   {
>>>> +    void  *p, *bp;
>>>>       int64_t kernel_addr = 0;
>>>>       LoongArchCPU *lacpu;
>>>>       CPUState *cs;
>>>> @@ -126,11 +181,24 @@ static void 
>>>> loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
>>>>           }
>>>>       }
>>>> +    /* Load 'boot_rom' at [0 - 1MiB] */
>>>> +    p = g_malloc0(1 * MiB);
>>>> +    bp = p;
>>>> +    init_boot_rom(info, p);
>>>> +    rom_add_blob_fixed("boot_rom", bp, 1 * MiB, 0);
>>>> +
>>> The secondary cpu waiting on the bootrom located memory address 
>>> 0x0-0x100000.
>>>
>>> Is it possible that primary cpu clears the memory located at bootrom
>>> and then wakeup the secondary cpu?
>>>
>> I think it impossible，0-1M is ROM。
> I am not sure whether it is ok if area between 0-1M is ROM.
> 
> For the memory map table, low memory area (0 - 256M) is still ddr ram.
> And it is passed to kernel with fdt system table, rather than 
> area(1-256M). Is that right?
> 
> There are some lines like this:
>      /* Node0 memory */
>      memmap_add_entry(VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 1);
Song,

Can the base memory address of bootrom for secondary cpus be set as base 
address of flash like bios, such as VIRT_FLASH0_BASE/VIRT_FLASH1_BASE?

And ddr memory map area is kept unchanged.

Regards
Bibo Mao

> 
> Regards
> Bibo Mao
> 
>>
>> Thanks.
>> Song Gao
>>> Regards
>>> Bibo Mao
>>>
>>>>       CPU_FOREACH(cs) {
>>>>           lacpu = LOONGARCH_CPU(cs);
>>>>           lacpu->env.load_elf = true;
>>>> -        lacpu->env.elf_address = kernel_addr;
>>>> +        if (cs == first_cpu) {
>>>> +            lacpu->env.elf_address = kernel_addr;
>>>> +        } else {
>>>> +            lacpu->env.elf_address = 0;
>>>> +        }
>>>> +        lacpu->env.boot_info = info;
>>>>       }
>>>> +
>>>> +    g_free(bp);
>>>>   }
>>>>   void loongarch_load_kernel(MachineState *ms, struct 
>>>> loongarch_boot_info *info)
>>>>
> 


