Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3255AC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 01:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thISa-0006Ji-IK; Sun, 09 Feb 2025 20:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1thISU-0006JM-AJ
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 20:19:35 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1thISQ-00065d-FB
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 20:19:32 -0500
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8DxvnMYVKlns9dwAA--.32960S3;
 Mon, 10 Feb 2025 09:19:20 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowMBxXsUVVKlnLmsJAA--.35757S3;
 Mon, 10 Feb 2025 09:19:19 +0800 (CST)
Subject: Re: [PATCH V2] target/loongarch: fix vcpu reset command word issue
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, kvm-devel <kvm@vger.kernel.org>
Cc: Bibo Mao <Maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <20250208075023.5647-1-lixianglai@loongson.cn>
 <62ad5a5b-9860-42dc-a4f3-37f504f3ded6@linaro.org>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <cced0ac9-3f5b-0c5b-1c11-c45f6848a020@loongson.cn>
Date: Mon, 10 Feb 2025 09:17:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <62ad5a5b-9860-42dc-a4f3-37f504f3ded6@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBxXsUVVKlnLmsJAA--.35757S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw4kAFy3trykKrWxXrWDGFX_yoW8ZF1fpF
 WkAFZ7KFy8GrykJwn7X34DZa4DZrWxG34kXa4IqFy0yr1jqryvg3W0qwsIgFn8Aw48GF4Y
 vr18Cr1jvFW7J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CP
 fJUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.37,
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

Hi Philippe Mathieu-Daudé:
> Hi,
>
> On 8/2/25 08:50, Xianglai Li wrote:
>> When the KVM_REG_LOONGARCH_VCPU_RESET command word
>> is sent to the kernel through the kvm_set_one_reg interface,
>> the parameter source needs to be a legal address,
>> otherwise the kernel will return an error and the command word
>> will fail to be sent.
>>
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> ---
>> Cc: Bibo Mao <Maobibo@loongson.cn>
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Cc: Song Gao <gaosong@loongson.cn>
>> Cc: Xianglai Li <lixianglai@loongson.cn>
>>
>> CHANGE:
>> V2<-V1:
>>    1.Sets the initial value of the variable and
>>    adds a function return value judgment and prints a log
>>
>>   target/loongarch/kvm/kvm.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>> index a3f55155b0..3f499e60ab 100644
>> --- a/target/loongarch/kvm/kvm.c
>> +++ b/target/loongarch/kvm/kvm.c
>> @@ -581,9 +581,14 @@ static int kvm_loongarch_get_lbt(CPUState *cs)
>>   void kvm_arch_reset_vcpu(CPUState *cs)
>>   {
>>       CPULoongArchState *env = cpu_env(cs);
>> +    int ret = 0;
>> +    uint64_t unused = 0;
>>         env->mp_state = KVM_MP_STATE_RUNNABLE;
>> -    kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, 0);
>> +    ret = kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, &unused);
>> +    if (ret) {
>> +        error_report("Failed to set KVM_REG_LOONGARCH_VCPU_RESET");
>
> If this call fails, I'd not rely on the state of the VM. What about:
>
> if (ret < 0) {
>     error_report("Failed to set KVM_REG_LOONGARCH_VCPU_RESET: %s",
>                  strerror(errno));
>     exit(EXIT_FAILURE);
> }
>
> ?
>
I'll second that!

Thanks,
Xianglai.
>> +    }
>>   }
>>     static int kvm_loongarch_get_mpstate(CPUState *cs)
>


