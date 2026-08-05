Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE6CC55822
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrW8E-0002AD-BS; Wed, 05 Aug 2026 03:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wrW8B-00029v-JB
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 03:33:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wrW88-0003fe-OC
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 03:33:39 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxbZtH53JqN5EKAA--.11090S3;
 Wed, 05 Aug 2026 15:33:28 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxEuRF53JqdnQkAA--.490S2;
 Wed, 05 Aug 2026 15:33:27 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Fix SWI interrupt delivery via CSR_ESTAT
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@oss.qualcomm.com>,
 "Andrew S. Rightenburg" <andrew@rail5.org>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
References: <20260415111738.3264448-1-andrew@rail5.org>
 <a4fed950-ae06-8dac-256c-132747d3b6f6@loongson.cn>
 <4c94cd7c-29a8-4f1e-a782-92a2f64245d4@oss.qualcomm.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <b851d0a3-ab27-d039-2ea4-e4b6a1037274@loongson.cn>
Date: Wed, 5 Aug 2026 15:33:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4c94cd7c-29a8-4f1e-a782-92a2f64245d4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxEuRF53JqdnQkAA--.490S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF1fZw1xur47JFWUJw48Xwc_yoWrXF13pr
 Z7CFWUJrW8GrWkA3WYgas0vF98Zr17Gwnruwn2qFy8AwsrJr12gr10qasFgF4DCrW8Wr18
 Zr1F93WxZay7XrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
 14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
 CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
 MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
 4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU8oGQDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.999,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2026/8/5 下午3:19, Philippe Mathieu-Daudé wrote:
> On 2026-08-05 8:56, Bibo Mao wrote:
>> applied to loongarch-next with small modification.
>>
>> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/ 
>> csr_helper.c
>> index 7dc33bc180..d8d54d81e0 100644
>> --- a/target/loongarch/tcg/csr_helper.c
>> +++ b/target/loongarch/tcg/csr_helper.c
>> @@ -103,9 +103,22 @@ target_ulong helper_csrwr_estat(CPULoongArchState 
>> *env, target_ulong val)
>>   {
>>       CPUSysState *sys = env_sys(env);
>>       int64_t old_v = sys->CSR_ESTAT;
>> +    CPUState *cs = env_cpu(env);
>>
>>       /* Only IS[1:0] can be written */
>>       sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 0, 2, val);
>> +    /*
>> +     * Software interrupts (SWI0/SWI1) are latched in CSR.ESTAT.IS[1:0].
>> +     * Make sure the CPU interrupt request state tracks the pending 
>> bits,
>> +     * matching the behavior of loongarch_cpu_set_irq().
>> +     */
>> +    bql_lock();
>> +    if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
>> +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>> +    } else {
>> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>> +    }
>> +    bql_unlock();
>>
>>       return old_v;
>>   }
>>
>> On 2026/4/15 下午7:17, Andrew S. Rightenburg via qemu development wrote:
>>> In TCG mode, helper_csrwr_estat() updates CSR.ESTAT.IS[1:0] (SWI0/SWI1)
>>> when the guest writes CSR_ESTAT, but it did not update the CPU interrupt
>>> request state. As a result, software interrupts could be observed as 
>>> pending
>>> in CSR.ESTAT while no interrupt exception was taken.
>>>
>>> Update CPU_INTERRUPT_HARD after modifying CSR_ESTAT, matching the 
>>> behavior of
>>> loongarch_cpu_set_irq(). The helper runs without the Big QEMU Lock 
>>> (BQL), so
>>> take the BQL while calling cpu_interrupt().
> 
> Eh I don't understand this justification about taking the BQL...
I guess there is g_assert(bql_locked()) in cpu_interrupt() -:)
> 
> If we can not call loongarch_cpu_set_irq() directly, we should extract
> the common code in a common method and re-use, not duplicate the same
> code.
yes, I think it is better to call loongarch_cpu_set_irq() directly to 
avoid duplicated code.

Regards
Bibo Mao
> 
>>>
>>> Fixes: 5b1dedfe848b ("target/loongarch: Add LoongArch CSR instruction")
>>> Reported-by: Andrew S. Rightenburg <andrew@rail5.org>
>>> Signed-off-by: Andrew S. Rightenburg <andrew@rail5.org>
>>> ---
>>>   target/loongarch/tcg/csr_helper.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/target/loongarch/tcg/csr_helper.c 
>>> b/target/loongarch/tcg/ csr_helper.c
>>> index cd35ca93c7..0a5ed52eb6 100644
>>> --- a/target/loongarch/tcg/csr_helper.c
>>> +++ b/target/loongarch/tcg/csr_helper.c
>>> @@ -98,10 +98,22 @@ target_ulong helper_csrrd_msgir(CPULoongArchState 
>>> *env)
>>>   target_ulong helper_csrwr_estat(CPULoongArchState *env, 
>>> target_ulong val)
>>>   {
>>>       int64_t old_v = env->CSR_ESTAT;
>>> +    CPUState *cs = env_cpu(env);
>>>       /* Only IS[1:0] can be written */
>>>       env->CSR_ESTAT = deposit64(env->CSR_ESTAT, 0, 2, val);
>>> +    /*
>>> +     * Software interrupts (SWI0/SWI1) are latched in 
>>> CSR.ESTAT.IS[1:0].
>>> +     * Make sure the CPU interrupt request state tracks the pending 
>>> bits,
>>> +     * matching the behavior of loongarch_cpu_set_irq().
>>> +     */
>>> +    if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
>>> +        bql_lock();
>>> +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>>> +        bql_unlock();
>>> +    }
>>> +
>>>       return old_v;
>>>   }
>>>
>>
>>


