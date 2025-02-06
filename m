Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACC5C02198
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 03:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfsue-00046X-0V; Wed, 05 Feb 2025 22:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1tfsuU-00045P-9m
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 22:50:39 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1tfsuQ-0006vB-7n
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 22:50:38 -0500
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8Dxfa+AMaRnWfVsAA--.57821S3;
 Thu, 06 Feb 2025 11:50:25 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowMBx3MR+MaRnFm8BAA--.4018S3;
 Thu, 06 Feb 2025 11:50:24 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: fix vcpu reset command word issue
To: bibo mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
References: <20250205120635.2516406-1-lixianglai@loongson.cn>
 <3e857bbf-834b-3ae5-f9c4-35d858db5108@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <533c8f91-e2c5-fece-276f-3a1700aa7b8b@loongson.cn>
Date: Thu, 6 Feb 2025 11:48:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3e857bbf-834b-3ae5-f9c4-35d858db5108@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBx3MR+MaRnFm8BAA--.4018S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr1xKw1ftrWxtw43tFW8AFc_yoW8AFW3pr
 Z5AFWkGFy8GrykAasrX34DXa4UXrWxKw1kWFyIqFyIkr4Yqry0q3W0qwsIgF98A3yxGa1F
 vr18Cr1UZFW7JwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.838,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Ok! I will modify it according to the suggestion.

Thanks,
Xianglai.

> On 2025/2/5 下午8:06, Xianglai Li wrote:
>> When the KVM_REG_LOONGARCH_VCPU_RESET command word
>> is sent to the kernel through the kvm_set_one_reg interface,
>> the parameter source needs to be a legal address,
>> otherwise the kernel will return an error and the command word
>> will fail to be sent.
> Hi Xianglai,
>
> Good catch, it is actually one problem and thanks for reporting it.
>
>>
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> ---
>> Cc: Bibo Mao <Maobibo@loongson.cn>
>> Cc: Song Gao <gaosong@loongson.cn>
>>
>>   target/loongarch/kvm/kvm.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>> index a3f55155b0..01cddb7012 100644
>> --- a/target/loongarch/kvm/kvm.c
>> +++ b/target/loongarch/kvm/kvm.c
>> @@ -581,9 +581,10 @@ static int kvm_loongarch_get_lbt(CPUState *cs)
>>   void kvm_arch_reset_vcpu(CPUState *cs)
>>   {
>>       CPULoongArchState *env = cpu_env(cs);
>> +    uint64_t val;
> How about set initial value here although it is not used? such as
>        uint64_t val = 0;
>>         env->mp_state = KVM_MP_STATE_RUNNABLE;
>> -    kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, 0);
>> +    kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, &val);
> Can we add return value checking here? such as
>        ret = kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, &val);
>        if (ret) {
>            error_report("... %s", strerror(errno));
>        }
>
> Regards
> Bibo Mao
>>   }
>>     static int kvm_loongarch_get_mpstate(CPUState *cs)
>>


