Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7867C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 07:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvWvl-0005Uv-K8; Fri, 21 Mar 2025 03:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tvWvc-0005UM-It
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 03:36:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tvWvY-0001QJ-Cl
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 03:36:27 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxGHHzFt1nuNufAA--.8700S3;
 Fri, 21 Mar 2025 15:36:19 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBx3MTxFt1nsJBXAA--.56493S3;
 Fri, 21 Mar 2025 15:36:19 +0800 (CST)
Subject: Re: [PATCH v6 3/6] hw/loongarch/virt: Fix error handling in cpu unplug
To: Markus Armbruster <armbru@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20250321031259.2419842-1-maobibo@loongson.cn>
 <20250321031259.2419842-4-maobibo@loongson.cn> <87ecyq98y1.fsf@pond.sub.org>
 <87d1b58e-1b8b-f582-753b-574c4ba44a6b@loongson.cn>
 <87ldsy7sry.fsf@pond.sub.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <ff30bac6-9004-0ba2-505a-3406e66623da@loongson.cn>
Date: Fri, 21 Mar 2025 15:35:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87ldsy7sry.fsf@pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3MTxFt1nsJBXAA--.56493S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZrWUZw4DCr4fGrW5Gr45Arc_yoWrWF48pr
 Wkt3WDKFyDZFyjv34Ivr98tFy0yrs7JrW0q34vyry5Jw4qgrn7tFW3A3Z09rWxC340qa1F
 qr4rGFnxuFnY9FXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU8PCzJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.608,
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



On 2025/3/21 下午3:21, Markus Armbruster wrote:
> bibo mao <maobibo@loongson.cn> writes:
> 
>> +Igor
>>
>>
>> On 2025/3/21 下午2:47, Markus Armbruster wrote:
>>> Bibo Mao <maobibo@loongson.cn> writes:
>>>
>>>> In function virt_cpu_unplug(), it will send cpu unplug message to
>>>> interrupt controller extioi and ipi irqchip. If there is problem in
>>>> this function, system should continue to run and keep state the same
>>>> before cpu is removed.
>>>>
>>>> If error happends in cpu unplug stage, send cpu plug message to extioi
>>>> and ipi irqchip to restore to previous stage, and then return immediately.
>>>>
>>>> Fixes: 2cd6857f6f5b (hw/loongarch/virt: Implement cpu unplug interface)
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>    hw/loongarch/virt.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>>>> index 8563967c8b..503362a69e 100644
>>>> --- a/hw/loongarch/virt.c
>>>> +++ b/hw/loongarch/virt.c
>>>> @@ -958,6 +958,8 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
>>>>        hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->extioi), dev, &err);
>>>>        if (err) {
>>>>            error_propagate(errp, err);
>>>> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev,
>>>> +                             &error_abort);
>>>>            return;
>>>>        }
>>>>    
>>>> @@ -965,6 +967,10 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
>>>>        hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>>>>        if (err) {
>>>>            error_propagate(errp, err);
>>>> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev,
>>>> +                             &error_abort);
>>>> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev,
>>>> +                             &error_abort);
>>>>            return;
>>>>        }
>>>
>>> virt_cpu_unplug() calls hotplug_handler_unplug() three times to notify
>>> ipi, extioi, and acpi_get.  If any notification fails, virt_cpu_unplug()
>>> calls hotplug_handler_plug() to "un-notify" the preceeding ones, if any.
>>> This must not fail.
>>>
>>> virt_cpu_plug() does it the other way round (see previous patch).
>>>
>>> So, hotplug_handler_plug() must not fail in virt_cpu_unplug(), yet we
>>> check for it to fail in virt_cpu_plug().
>>>
>>> Can it really fail in virt_cpu_plug()?
>>>
>>> If yes, why can't it fail in virt_cpu_unplug()?
>> you can check function acpi_cpu_plug_cb()/loongarch_ipi_cpu_plug(), that
>> is cpuplug callback for acpi_ged and ipi. it will not fail.
>>
>> If *virt_cpu_pre_plug()* pass, it will succeed.
>>
>> Regards
>> Bibo Mao
>>
>>>
>>> Same questions for hotplug_handler_unplug().
> 
> Let me restate my argument.
> 
> We call hotplug_handler_plug() on the happy path, and on error recovery
> paths.  Four cases:
> 
> 1. Can fail on the happy path
> 
>     Error recovery is required.
> 
> 1.1 Can fail on the error recovery path
> 
>      Error recovery is required, but broken.
> 
> 1.2 Can't fail on the error recovery path
> 
>      Error recovery is required and works, but why it works is not
>      obvious.  Deserves a comment explaining why hotplug_handler_plug()
>      can't fail here even though it can fail on the happy path next door.
> 
> 2. Can't fail on the happy path
> 
>     Error recovery is unreachable.
> 
> 2.1 Can fail on the error recovery path
> 
>      Error recovery is unreachable and broken.  Possibly a time bomb, and
>      possibly misleading readers.
> 
> 2.2 Can't fail on the error recovery path
> 
>      Error recovery is unreachable and would work, but why it would work
>      is again a not obvious.
> 
> Which of the four cases is it?
By my understanding, it is "2. Can't fail on the happy path",  and Error 
recovery is unreachable.

I have said that it is impossible and recovery is only for future use.

do you mean recovery should be removed? And directly &error_abort is 
used in virt_cpu_plug() such as:
static void virt_cpu_plug(HotplugHandler *hotplug_dev,
                           DeviceState *dev, Error **errp)
{
   if (lvms->ipi) {
     hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev, &error_abort);

Regards
Bibo Mao


