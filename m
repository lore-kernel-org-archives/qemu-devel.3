Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777D7C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 07:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOBWG-000365-Pl; Mon, 01 Jul 2024 03:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sOBWF-00035s-3z
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 03:32:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sOBWC-0000JS-Hp
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 03:32:10 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxrOpzW4JmdNILAA--.45489S3;
 Mon, 01 Jul 2024 15:32:03 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxMMRxW4JmKDo3AA--.26876S3; 
 Mon, 01 Jul 2024 15:32:03 +0800 (CST)
Subject: Re: [RFC v3 1/2] target/loongarch: Add loongson binary translation
 feature
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: QEMU devel <qemu-devel@nongnu.org>
References: <20240530064941.1289573-1-maobibo@loongson.cn>
 <20240530064941.1289573-2-maobibo@loongson.cn>
 <db19ed93-027c-4e29-aac5-e3a1edcd760b@app.fastmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <bba3338b-4c28-fc38-fc5e-f4691bfa28b1@loongson.cn>
Date: Mon, 1 Jul 2024 15:32:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <db19ed93-027c-4e29-aac5-e3a1edcd760b@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxMMRxW4JmKDo3AA--.26876S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw1UZF48ZFWUZF43Xry3WrX_yoW8Kryxp3
 47uFy5KFWUJrZ2y3Z3Zw15Xrn8ZrWxKrW29a13try8Cwn8tF1xXry0ka9I9F1DZ34rWryI
 qF15C34UuF4DAacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 db8UUUUU=
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



On 2024/7/1 下午2:57, Jiaxun Yang wrote:
> 
> 
> 在2024年5月30日五月 上午7:49，Bibo Mao写道：
>> Loongson Binary Translation (LBT) is used to accelerate binary
>> translation, which contains 4 scratch registers (scr0 to scr3), x86/ARM
>> eflags (eflags) and x87 fpu stack pointer (ftop).
>>
>> Now LBT feature is added in kvm mode, not supported in TCG mode since
>> it is not emulated. Feature variable lbt is added with OnOffAuto type,
>> If lbt feature is not supported with KVM host, it reports error if there
>> is lbt=on command line.
>>
>> If there is no any command line about lbt parameter, it checks whether
>> KVM host supports lbt feature and set the corresponding value in cpucfg.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Hi Bibo,
> 
> I was going across recent LoongArch changes and this comes into my attention:
> 
>> ---
>>   target/loongarch/cpu.c                | 53 +++++++++++++++++++++++++++
>>   target/loongarch/cpu.h                |  6 +++
>>   target/loongarch/kvm/kvm.c            | 26 +++++++++++++
>>   target/loongarch/kvm/kvm_loongarch.h  | 16 ++++++++
>>   target/loongarch/loongarch-qmp-cmds.c |  2 +-
>>   5 files changed, 102 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index b5c1ec94af..14265b6667 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -571,6 +571,30 @@ static void loongarch_cpu_disas_set_info(CPUState
>> *s, disassemble_info *info)
>>       info->print_insn = print_insn_loongarch;
>>   }
>>
>> +static void loongarch_cpu_check_lbt(CPUState *cs, Error **errp)
>> +{
>> +    CPULoongArchState *env = cpu_env(cs);
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>> +    bool kvm_supported;
>> +
>> +    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_LBT);
> 
> IMHO if there is no global states that should be saved/restored VM wise,
> this should be handled at per CPU level, preferably with CPUCFG flags hint.
> 
> We should minimize non-privilege KVM feature bits to prevent hindering
> asymmetry ISA system.
For "asymmetry ISA system", do you meaning some vcpus have LBT feature, 
however some vcpus does have LBT features? That does not exists at all.

It will be big disaster for such products, how does application use this?

Regards
Bibo
> 
> Thanks
> - Jiaxun
> 


