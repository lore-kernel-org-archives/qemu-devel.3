Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3773FCCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIlOy-0002lr-Kv; Tue, 11 Nov 2025 05:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vIlOm-0002Xr-9X
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:14:52 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vIlOk-0006Ij-A2
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:14:52 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Dx_tKUDBNpI+khAA--.8190S3;
 Tue, 11 Nov 2025 18:14:44 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxaMCRDBNp0EYvAQ--.48004S3;
 Tue, 11 Nov 2025 18:14:43 +0800 (CST)
Subject: Re: [PATCH] fix pci device can't alloc irq from fdt
From: Bibo Mao <maobibo@loongson.cn>
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
References: <20251111071436.1555402-1-lixianglai@loongson.cn>
 <caf726ca-2e17-9711-9686-4e17eef94f01@loongson.cn>
Message-ID: <91abf355-3ed7-ca6b-83b8-fe2128e4f40c@loongson.cn>
Date: Tue, 11 Nov 2025 18:12:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <caf726ca-2e17-9711-9686-4e17eef94f01@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxaMCRDBNp0EYvAQ--.48004S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw17WF4DGryUAF1rAF47Awc_yoWrWFW5pF
 WkG3WDWrWIgr109w4xXF1Uury3Ar13A3WjqwnrJF1UCwnruw10qr4qqrWvgFyUK3ykJF4U
 Xr45K34I9w1UGabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
 Ja73UjIFyTuYvjxU7XTmDUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.793,
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



On 2025/11/11 下午6:07, Bibo Mao wrote:
> 
> 
> On 2025/11/11 下午3:14, Xianglai Li wrote:
>> When we use the -kernel parameter to start an elf format kernel 
>> relying on
>> fdt, we get the following error:
>>
>> pcieport 0000:00:01.0: of_irq_parse_pci: failed with rc=-22
>> pcieport 0000:00:01.0: enabling device (0000 -> 0003)
>> pcieport 0000:00:01.0: PME: Signaling with IRQ 19
>> pcieport 0000:00:01.0: AER: enabled with IRQ 19
>> pcieport 0000:00:01.1: of_irq_parse_pci: failed with rc=-22
>> pcieport 0000:00:01.1: enabling device (0000 -> 0003)
>> pcieport 0000:00:01.1: PME: Signaling with IRQ 20
>> pcieport 0000:00:01.1: AER: enabled with IRQ 20
>> pcieport 0000:00:01.2: of_irq_parse_pci: failed with rc=-22
>> pcieport 0000:00:01.2: enabling device (0000 -> 0003)
>> pcieport 0000:00:01.2: PME: Signaling with IRQ 21
>> pcieport 0000:00:01.2: AER: enabled with IRQ 21
>> pcieport 0000:00:01.3: of_irq_parse_pci: failed with rc=-22
>> pcieport 0000:00:01.3: enabling device (0000 -> 0003)
>> pcieport 0000:00:01.3: PME: Signaling with IRQ 22
>> pcieport 0000:00:01.3: AER: enabled with IRQ 22
>> pcieport 0000:00:01.4: of_irq_parse_pci: failed with rc=-22
>>
>> This is because the description of interrupt-cell size in the interrupt
>> controller pch_pic in our fdt is incorrect, and the description of
>> interrupt-cell is missing in the pcie irq map. Now it is corrected and
>> the correct interrupt-cell is added in th pcie irq map.
>>
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> ---
>> Cc: Bibo Mao <maobibo@loongson.cn>
>> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Cc: Song Gao <gaosong@loongson.cn>
>>
>>   hw/loongarch/virt-fdt-build.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/loongarch/virt-fdt-build.c 
>> b/hw/loongarch/virt-fdt-build.c
>> index 1f0ba01f71..f1f70ed3c3 100644
>> --- a/hw/loongarch/virt-fdt-build.c
>> +++ b/hw/loongarch/virt-fdt-build.c
>> @@ -272,7 +272,7 @@ static void 
>> fdt_add_pch_pic_node(LoongArchVirtMachineState *lvms,
>>       qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0,
>>                              pch_pic_base, 0, pch_pic_size);
>>       qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", 
>> NULL, 0);
>> -    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 2);
>> +    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 1);
> The pch_pic supports irq number and trigger level, value of 
> #interrupt-cells should be 2.
> 
>>       qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
>>                             *eiointc_phandle);
>>       qemu_fdt_setprop_cell(ms->fdt, nodename, 
>> "loongson,pic-base-vec", 0);
>> @@ -395,6 +395,8 @@ static void fdt_add_pcie_node(const 
>> LoongArchVirtMachineState *lvms,
>>                                    2, base_mmio, 2, size_mmio);
>>       qemu_fdt_setprop_cells(ms->fdt, nodename, "msi-map",
>>                              0, *pch_msi_phandle, 0, 0x10000);
>> +
>> +    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 1);
>>       fdt_add_pcie_irq_map_node(lvms, nodename, pch_pic_phandle);
> Here is error report:
>    pcieport 0000:00:01.0: of_irq_parse_pci: failed with rc=-22
irq parsing from FDT table with non-pci device should be good,
such as uart, it is interrupt cell field is 2: (irq, 0x4)
   qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0x4)

only pci legacy interrupt pin parsing has problem.

Regards
Bibo Mao
> 
> I think that we should support interrupt-map fdt table in function 
> fdt_add_pcie_irq_map_node(), so that PCI trigger level is added in the 
> map table.
> 
> Regards
> Bibo Mao
>>       g_free(nodename);
>>   }
>>
> 


