Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD9CC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 06:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv9RX-0006RS-2O; Thu, 20 Mar 2025 02:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tv9RS-0006RA-Q4
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:31:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tv9RP-0002kb-9U
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:31:46 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxOGpEtttnTRmeAA--.6147S3;
 Thu, 20 Mar 2025 14:31:33 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxj8UztttnOTFVAA--.52487S3;
 Thu, 20 Mar 2025 14:31:29 +0800 (CST)
Subject: Re: [PATCH v5 2/6] hw/loongarch/virt: Fix error handling in cpu plug
To: Markus Armbruster <armbru@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250320032158.1762751-1-maobibo@loongson.cn>
 <20250320032158.1762751-3-maobibo@loongson.cn> <875xk4i5wb.fsf@pond.sub.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <c1e74ed3-f60a-0bd6-9806-b5ec111e466d@loongson.cn>
Date: Thu, 20 Mar 2025 14:30:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <875xk4i5wb.fsf@pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxj8UztttnOTFVAA--.52487S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF4rWw43Ww1DCrW8Kw18tFc_yoW5uFy7pr
 Wvya1qvF1qkFW2v34Iqry5tw1Fvr4ftrW8XrWvyry5Zwn8Xrn0yFW2ywn8Kr4fCry0va18
 Zw4rCFs8uFnavFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU8oGQDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.598,
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



On 2025/3/20 下午2:16, Markus Armbruster wrote:
> Bibo Mao <maobibo@loongson.cn> writes:
> 
>> In function virt_cpu_plug(), it will send cpu plug message to interrupt
>> controller extioi and ipi irqchip. If there is problem in this function,
>> system should continue to run and keep state the same before cpu is
>> added.
>>
>> Object cpuslot::cpu is set at last only when there is no any error.
>> If there is, send cpu unplug message to extioi and ipi irqchip, and then
>> return immediately.
>>
>> Fixes: ab9935d2991e (hw/loongarch/virt: Implement cpu plug interface)
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/virt.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index a5840ff968..5118f01e4b 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -981,8 +981,6 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
>>       Error *err = NULL;
>>   
>> -    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
>> -    cpu_slot->cpu = CPU(dev);
>>       if (lvms->ipi) {
>>           hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev, &err);
>>           if (err) {
>> @@ -995,6 +993,10 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>>           hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev, &err);
>>           if (err) {
>>               error_propagate(errp, err);
>> +            if (lvms->ipi) {
>> +                /* Send unplug message to restore, discard error here */
>> +                hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->ipi), dev, NULL);
>> +            }
>>               return;
>>           }
>>       }
>> @@ -1003,9 +1005,20 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>>           hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>>           if (err) {
>>               error_propagate(errp, err);
>> +            if (lvms->ipi) {
>> +                hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->ipi), dev, NULL);
>> +            }
>> +
>> +            if (lvms->extioi) {
>> +                hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->extioi),
>> +                                       dev, NULL);
>> +            }
>> +            return;
>>           }
>>       }
>>   
>> +    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
>> +    cpu_slot->cpu = CPU(dev);
>>       return;
>>   }
> 
> Hmm.
> 
> You're right about the problem: virt_cpu_plug() neglects to revert
> changes when it fails.
> 
> You're probably right to move the assignment to cpu_slot->cpu to the
> end.  Anything you can delay until success is assured you don't have to
> revert.  I say "probably" because the code that now runs before the
> assignment might theoretically "see" the assignment, and I didn't
> examine it to exclude that.
> 
> Where I have doubts is the code to revert changes.
> 
> The hotplug_handler_plug() error checkign suggests it can fail.
> 
> Can hotplug_handler_unplug() fail, too?  The error checking in
> virt_cpu_unplug() right above suggests it can.
Basically from existing code about ipi/extioi hotplug handler, it is
impossible to there is error, here is only for future use.

If there is error in function virt_cpu_plug(), undo() such as 
hotplug_handler_unplug() should be called. However if undo() reports 
error, I do not know how to handle it, here just discard error in 
function undo().

Regards
Bibo Mao
> 
> What happens if it fails in virt_cpu_plug()?
> 


