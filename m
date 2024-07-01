Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691AEC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 09:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sODFt-0002hb-6q; Mon, 01 Jul 2024 05:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sODFq-0002hF-AQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 05:23:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sODFn-0005r4-KW
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 05:23:22 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxHuuAdYJmN9kLAA--.45294S3;
 Mon, 01 Jul 2024 17:23:12 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxRcV8dYJmUFU3AA--.52129S3; 
 Mon, 01 Jul 2024 17:23:10 +0800 (CST)
Subject: Re: [RFC v3 1/2] target/loongarch: Add loongson binary translation
 feature
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: QEMU devel <qemu-devel@nongnu.org>
References: <20240530064941.1289573-1-maobibo@loongson.cn>
 <20240530064941.1289573-2-maobibo@loongson.cn>
 <db19ed93-027c-4e29-aac5-e3a1edcd760b@app.fastmail.com>
 <bba3338b-4c28-fc38-fc5e-f4691bfa28b1@loongson.cn>
 <cdc0d448-8e3b-44f7-89ca-a15ea48acd2b@app.fastmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <fc3829c2-4164-f11a-8158-498198b8a677@loongson.cn>
Date: Mon, 1 Jul 2024 17:23:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cdc0d448-8e3b-44f7-89ca-a15ea48acd2b@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxRcV8dYJmUFU3AA--.52129S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uryfXFy8ury7Wr4kJr4xAFc_yoW8CrWDpa
 y2vFWF9ry7tr4Iy3s2g3ZrJFsYyrWIyw47Zry5Gry7A3Z0gF1DJr93AFZY9a93Zr1fXF4I
 vrsrK347uFyUZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
 daVFxhVjvjDU0xZFpf9x07j5WrAUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.587,
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



On 2024/7/1 下午4:42, Jiaxun Yang wrote:
> 
> 
> 在2024年7月1日七月 上午8:32，maobibo写道：
> [...]
>>>>
>>>> +static void loongarch_cpu_check_lbt(CPUState *cs, Error **errp)
>>>> +{
>>>> +    CPULoongArchState *env = cpu_env(cs);
>>>> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>>>> +    bool kvm_supported;
>>>> +
>>>> +    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_LBT);
>>>
>>> IMHO if there is no global states that should be saved/restored VM wise,
>>> this should be handled at per CPU level, preferably with CPUCFG flags hint.
>>>
>>> We should minimize non-privilege KVM feature bits to prevent hindering
>>> asymmetry ISA system.
>> For "asymmetry ISA system", do you meaning some vcpus have LBT feature,
>> however some vcpus does have LBT features? That does not exists at all.
> 
> Yes, we should always prepare for the future :-)
> 
>  From Weiwu's presentations, I believe LASX asymmetry product is already on the
> roadmap. So for LBT it's also a possibility.
I never hear such product plan with different LASX/LSX capability even 
for the future big-little product.

> 
> Even if such product won't land in near future, we should still try our best
> to bound to vCPU creation, not to the system.
> 
>>
>> It will be big disaster for such products, how does application use this?
> 
> Affinity placement etc, there are many possibilities.
> 
> On Arm side, there are already systems with Big.Little asymmetry CPU that
> some of the processor equipped 32 bit EL0 mode while others doesn't. They
> managed that well with affinity.
> 
> See: arm64: Allow mismatched 32-bit EL0 support
Is it only 32 bit EL0 mode or 32bit compatible mode and 64 bit also?

What is the detailed product name and how does Linux/KVM support this 
product?

Regards
Bibo Mao
> 
> Thanks
>>
>> Regards
>> Bibo
>>>
>>> Thanks
>>> - Jiaxun
>>>
> 


