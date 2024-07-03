Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94528C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 10:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOwx0-00030Y-8W; Wed, 03 Jul 2024 06:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sOwwq-0002za-2v
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:10:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sOwwm-0006Qz-HK
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:10:47 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxS_CXI4VmfHsAAA--.1464S3;
 Wed, 03 Jul 2024 18:10:31 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx08SUI4Vmd3o5AA--.57883S3; 
 Wed, 03 Jul 2024 18:10:30 +0800 (CST)
Subject: Re: [RFC v3 1/2] target/loongarch: Add loongson binary translation
 feature
To: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, QEMU devel <qemu-devel@nongnu.org>
References: <20240530064941.1289573-1-maobibo@loongson.cn>
 <20240530064941.1289573-2-maobibo@loongson.cn>
 <db19ed93-027c-4e29-aac5-e3a1edcd760b@app.fastmail.com>
 <60da2f5e-009d-4362-bf62-32a088b2848c@app.fastmail.com>
 <CAAhV-H4YqauX+dDFGK1oHrRjROSykkp-j0AfRD4a43Yea4qMxQ@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <5224f884-6327-f181-5bbf-f1d1f9f3b894@loongson.cn>
Date: Wed, 3 Jul 2024 18:10:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4YqauX+dDFGK1oHrRjROSykkp-j0AfRD4a43Yea4qMxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx08SUI4Vmd3o5AA--.57883S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF1fuFWxuw1fAFWftr4fWFX_yoWrGFW8pa
 y8CFyYkF4DJrW7A3Zav3W5Xrn0vr4xKr42vF1fGryUAwn0kr1xXr1vka9xuF1DZ34rWr1j
 vF1UK347uF4DA3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vA
 pUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.819,
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



On 2024/7/3 下午5:43, Huacai Chen wrote:
> On Wed, Jul 3, 2024 at 3:51 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>
>>
>>
>> 在2024年7月1日七月 下午2:57，Jiaxun Yang写道：
>>> 在2024年5月30日五月 上午7:49，Bibo Mao写道：
>>>> Loongson Binary Translation (LBT) is used to accelerate binary
>>>> translation, which contains 4 scratch registers (scr0 to scr3), x86/ARM
>>>> eflags (eflags) and x87 fpu stack pointer (ftop).
>>>>
>>>> Now LBT feature is added in kvm mode, not supported in TCG mode since
>>>> it is not emulated. Feature variable lbt is added with OnOffAuto type,
>>>> If lbt feature is not supported with KVM host, it reports error if there
>>>> is lbt=on command line.
>>>>
>>>> If there is no any command line about lbt parameter, it checks whether
>>>> KVM host supports lbt feature and set the corresponding value in cpucfg.
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> Hi Bibo,
>>>
>>> I was going across recent LoongArch changes and this comes into my attention:
>>>
>>>> ---
>>>>   target/loongarch/cpu.c                | 53 +++++++++++++++++++++++++++
>>>>   target/loongarch/cpu.h                |  6 +++
>>>>   target/loongarch/kvm/kvm.c            | 26 +++++++++++++
>>>>   target/loongarch/kvm/kvm_loongarch.h  | 16 ++++++++
>>>>   target/loongarch/loongarch-qmp-cmds.c |  2 +-
>>>>   5 files changed, 102 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>>>> index b5c1ec94af..14265b6667 100644
>>>> --- a/target/loongarch/cpu.c
>>>> +++ b/target/loongarch/cpu.c
>>>> @@ -571,6 +571,30 @@ static void loongarch_cpu_disas_set_info(CPUState
>>>> *s, disassemble_info *info)
>>>>       info->print_insn = print_insn_loongarch;
>>>>   }
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
>>
>> + Huacai for further discussion
>>
>> Hi Bibo, Huacai,
>>
>> I investigated the topic further and went through the thread on kernel side.
>>
>> I think Huacai and me are all on the same page that we should unify the interface for per-CPU
>> level feature probing and setting interface. Huacai purposed converting all features to VM feature
>> but I still believe CPUCFG is the best interface.
>>
>> To probe LBT before actual vcpu creation, we can borrow the approach used by other architectures
>> (kvm_arm_create_scratch_host_vcpu() & kvm_riscv_create_scratch_vcpu()).
>>
>> Kernel will reject setting unknown CPUCFG bits with -EINVAL, so to probe LBT we just need to perform
>> KVM_SET_REGS to scratch vcpu with LBT set to see if it's valid for kernel. There is no need for any other
>> probing interface.
>>
>> I do think scratch CPU interface is also necessary if we are going to implement cpu = host.
>>
>> Huacai, would you agree with me?
> For me the important thing is consistency, all vm-features or all
> vcpu-features are both accepted.
To understand features immediately is difficult job for me. There is 
supported features/used features usages etc, overall feature detection 
should be VM relative by my knowledge.

Maybe after host machine type and migration feature detection and 
checking is finished, there will be further upstanding -:(

Regards
Bibo Mao

> 
> Huacai
> 
>>
>> Thanks
>> - Jiaxun
>>
>>>
>>> Thanks
>>> - Jiaxun
>>>
>>> --
>>> - Jiaxun
>>
>> --
>> - Jiaxun


