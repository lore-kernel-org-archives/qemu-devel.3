Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0011FCD4F28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 06:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJQen-0007TX-LX; Thu, 13 Nov 2025 01:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vJQek-0007Sk-By
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 01:18:07 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vJQei-0008GL-6j
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 01:18:06 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cx6tEWeBVp0cAiAA--.10184S3;
 Thu, 13 Nov 2025 14:17:59 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxT+YTeBVpWVoxAQ--.5704S3;
 Thu, 13 Nov 2025 14:17:57 +0800 (CST)
Subject: Re: [PATCH V2 2/2] fix pci device can't alloc irq from fdt
To: lixianglai <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
References: <cover.1762917185.git.lixianglai@loongson.cn>
 <7f6ec86e3425b12a337d71d963a0e26577c84f51.1762917185.git.lixianglai@loongson.cn>
 <342b3d95-dc51-f938-ddd1-bd3b5c1b7688@loongson.cn>
 <03f05c5e-7cd1-b508-166e-52167407b8a0@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <66171815-abeb-4f12-5622-19f35507f11d@loongson.cn>
Date: Thu, 13 Nov 2025 14:15:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <03f05c5e-7cd1-b508-166e-52167407b8a0@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxT+YTeBVpWVoxAQ--.5704S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtFy8Gr13CF1fWr1Dtr1rZrc_yoW3WF4rpr
 ykJF1UJryUJr10qr17Xr1UXry5Jr1UJ3WUJr18XF18Kr47Ar12gr1UXr1qgr1UGr48Jr4U
 Jr15Jr1xZF1UJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
 Ja73UjIFyTuYvjxUzZ2-UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.736,
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



On 2025/11/13 下午2:07, lixianglai wrote:
> Hi Bibo Mao :
>> On 2025/11/12 上午11:26, Xianglai Li wrote:
>>> When we use the -kernel parameter to start an elf format kernel 
>>> relying on
>>> fdt, we get the following error:
>>>
>>> pcieport 0000:00:01.0: of_irq_parse_pci: failed with rc=-22
>>> pcieport 0000:00:01.0: enabling device (0000 -> 0003)
>>> pcieport 0000:00:01.0: PME: Signaling with IRQ 19
>>> pcieport 0000:00:01.0: AER: enabled with IRQ 19
>>> pcieport 0000:00:01.1: of_irq_parse_pci: failed with rc=-22
>>> pcieport 0000:00:01.1: enabling device (0000 -> 0003)
>>> pcieport 0000:00:01.1: PME: Signaling with IRQ 20
>>> pcieport 0000:00:01.1: AER: enabled with IRQ 20
>>> pcieport 0000:00:01.2: of_irq_parse_pci: failed with rc=-22
>>> pcieport 0000:00:01.2: enabling device (0000 -> 0003)
>>> pcieport 0000:00:01.2: PME: Signaling with IRQ 21
>>> pcieport 0000:00:01.2: AER: enabled with IRQ 21
>>> pcieport 0000:00:01.3: of_irq_parse_pci: failed with rc=-22
>>> pcieport 0000:00:01.3: enabling device (0000 -> 0003)
>>> pcieport 0000:00:01.3: PME: Signaling with IRQ 22
>>> pcieport 0000:00:01.3: AER: enabled with IRQ 22
>>> pcieport 0000:00:01.4: of_irq_parse_pci: failed with rc=-22
>>>
>>> This is because  the description of interrupt-cell is missing in the 
>>> pcie
>>> irq map.  And there is a lack of a description of the interrupt trigger
>>> type.  Now it is corrected and the correct interrupt-cell is added in 
>>> the
>>> pcie irq map.
>>>
>>> Refer to the implementation in arm and add some comments.
>>>
>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>> ---
>>> Cc: Bibo Mao <maobibo@loongson.cn>
>>> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> Cc: Song Gao <gaosong@loongson.cn>
>>>
>>>   hw/loongarch/virt-fdt-build.c | 43 +++++++++++++++++++++++------------
>>>   1 file changed, 28 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/hw/loongarch/virt-fdt-build.c 
>>> b/hw/loongarch/virt-fdt-build.c
>>> index 7333019cf7..73ac28bcba 100644
>>> --- a/hw/loongarch/virt-fdt-build.c
>>> +++ b/hw/loongarch/virt-fdt-build.c
>>> @@ -317,10 +317,13 @@ static void fdt_add_pcie_irq_map_node(const 
>>> LoongArchVirtMachineState *lvms,
>>>                                         uint32_t *pch_pic_phandle)
>>>   {
>>>       int pin, dev;
>>> -    uint32_t irq_map_stride = 0;
>>> +    int irq_map_stride = 0;
>> This change may be unnecessary.
>>>       uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS * 10] = {};
>>>       uint32_t *irq_map = full_irq_map;
>>>       const MachineState *ms = MACHINE(lvms);
>>> +    uint32_t pch_pic_handle = *pch_pic_phandle;
>> This change may be unnecessary also, let us keep smallest modification.
>>> +    uint32_t pin_mask;
>>> +    uint32_t devfn_mask;
>>>         /*
>>>        * This code creates a standard swizzle of interrupts such that
>>> @@ -339,31 +342,39 @@ static void fdt_add_pcie_irq_map_node(const 
>>> LoongArchVirtMachineState *lvms,
>>>               int irq_nr = 16 + ((pin + PCI_SLOT(devfn)) % 
>>> PCI_NUM_PINS);
>>>               int i = 0;
>>>   -            /* Fill PCI address cells */
>>> -            irq_map[i] = cpu_to_be32(devfn << 8);
>>> -            i += 3;
>>> -
>>> -            /* Fill PCI Interrupt cells */
>>> -            irq_map[i] = cpu_to_be32(pin + 1);
>>> -            i += 1;
>>> -
>>> -            /* Fill interrupt controller phandle and cells */
>>> -            irq_map[i++] = cpu_to_be32(*pch_pic_phandle);
>>> -            irq_map[i++] = cpu_to_be32(irq_nr);
>>> +            uint32_t map[] = {
>>> +                devfn << 8, 0, 0,             /* devfn */
>> Is there any specification for two consecutive 0, 0 with 
>> interrupt-map? Although many of code is copied from other places, we 
>> had better know howto since the problem comes out already -:)
>>
> In the fdt specification, it is stipulated that address-cells require 
> three cells in the interrupt-map, among which the first cell stores devfn.
> The other two cells default to 0, which corresponds to the laddr 
> variable in the linux kernel function of_irq_parse_pci.
> 
> By searching the Internet, the other two cells correspond respectively 
> to the high and low bits of the pci device configuration space address.
> Since interrupt information is described here and no memory address is 
> needed, it is set to 0 by default.
Got it, thanks for the patient explanation.
I have no other issues.

Regards
Bibo Mao
> 
> Thanks!
> Xianglai.
> 
>> Regards
>> Bibo Mao
>>> +                pin + 1,                      /* PCI pin */
>>> +                pch_pic_handle,              /* interrupt controller 
>>> handle */
>>> +                irq_nr,                       /* irq number */
>>> +                FDT_IRQ_TYPE_LEVEL_HIGH };    /* irq trigger level */
>>>                 if (!irq_map_stride) {
>>> -                irq_map_stride = i;
>>> +                irq_map_stride = sizeof(map) / sizeof(uint32_t);
>>>               }
>>> +
>>> +            /* Convert map to big endian */
>>> +            for (i = 0; i < irq_map_stride; i++) {
>>> +                irq_map[i] = cpu_to_be32(map[i]);
>>> +            }
>>> +
>>>               irq_map += irq_map_stride;
>>>           }
>>>       }
>>>   -
>>>       qemu_fdt_setprop(ms->fdt, nodename, "interrupt-map", full_irq_map,
>>>                        PCI_NUM_PINS * PCI_NUM_PINS *
>>>                        irq_map_stride * sizeof(uint32_t));
>>> +
>>> +    /* The pci slot only needs to specify the matching of the lower 
>>> bit */
>>> +    devfn_mask = cpu_to_be16(PCI_DEVFN((PCI_NUM_PINS - 1), 0));
>>> +    /* The pci pin only needs to match the specified low bit */
>>> +    pin_mask = (1 << ((PCI_NUM_PINS - 1))) - 1;
>>> +
>>>       qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupt-map-mask",
>>> -                     0x1800, 0, 0, 0x7);
>>> +                           devfn_mask,
>>> +                           0, 0,
>>> +                           pin_mask);
>>>   }
>>>     static void fdt_add_pcie_node(const LoongArchVirtMachineState *lvms,
>>> @@ -400,6 +411,8 @@ static void fdt_add_pcie_node(const 
>>> LoongArchVirtMachineState *lvms,
>>>                                    2, base_mmio, 2, size_mmio);
>>>       qemu_fdt_setprop_cells(ms->fdt, nodename, "msi-map",
>>>                              0, *pch_msi_phandle, 0, 0x10000);
>>> +
>>> +    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 1);
>>>       fdt_add_pcie_irq_map_node(lvms, nodename, pch_pic_phandle);
>>>       g_free(nodename);
>>>   }
>>>


