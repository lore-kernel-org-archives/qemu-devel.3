Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF223C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4FwQ-0000A6-QC; Tue, 07 May 2024 04:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s4FwN-00009v-Pw
 for qemu-devel@nongnu.org; Tue, 07 May 2024 04:12:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s4FwL-0007Us-7u
 for qemu-devel@nongnu.org; Tue, 07 May 2024 04:12:47 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxNvB24jlmBroIAA--.23866S3;
 Tue, 07 May 2024 16:12:38 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxhFZy4jlmS8QTAA--.22703S3; 
 Tue, 07 May 2024 16:12:36 +0800 (CST)
Subject: Re: [PATCH] target/loongarch/kvm: Fix VM recovery from disk failures
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Tianrui Zhao <zhaotianrui@loongson.cn>,
 pbonzini@redhat.com, peter.maydell@linaro.org, richard.henderson@linaro.org,
 maobibo@loongson.cn, lixianglai@loongso.cn
References: <20240430012356.2620763-1-gaosong@loongson.cn>
 <f9956c18-3530-4fc2-8150-beba7b673f89@linaro.org> <87edanlzlz.fsf@suse.de>
 <ZjJjl2fIU1s24uFD@x1n> <87o79oo00b.fsf@suse.de>
From: gaosong <gaosong@loongson.cn>
Message-ID: <c9bfd6a4-befb-c17d-a87d-15eeecdfb75a@loongson.cn>
Date: Tue, 7 May 2024 16:12:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87o79oo00b.fsf@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxhFZy4jlmS8QTAA--.22703S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF1fJry7Cr48Zw1Dur1xJFc_yoWrXr1xp3
 4DA3WqkFWrJr97Jwn2yw1rWF9Iyr1UKF42gFs7Kr18uF90qrnaqr4kt347uF1fAa4rGr1I
 vr1xJF9xXF45A3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
 e5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.593,
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


Thanks for the comments !

在 2024/5/2 下午8:45, Fabiano Rosas 写道:
> Peter Xu <peterx@redhat.com> writes:
>
>> On Tue, Apr 30, 2024 at 11:00:24AM -0300, Fabiano Rosas wrote:
>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>
>>>> (Cc'ing migration maintainers)
>>>>
>>>> On 30/4/24 03:23, Song Gao wrote:
>>>>> vmstate does not save kvm_state_conter,
>>>>> which can cause VM recovery from disk to fail.
>>>> Cc: qemu-stable@nongnu.org
>>>> Fixes: d11681c94f ("target/loongarch: Implement kvm_arch_init_vcpu")
>>>>
>>>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>>>> ---
>>>>>    target/loongarch/machine.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
>>>>> index c7029fb9b4..4cd1bf06ff 100644
>>>>> --- a/target/loongarch/machine.c
>>>>> +++ b/target/loongarch/machine.c
>>>>> @@ -191,6 +191,8 @@ const VMStateDescription vmstate_loongarch_cpu = {
>>>>>            VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
>>>>>                                 0, vmstate_tlb, LoongArchTLB),
>>>>>    
>>>>> +        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
>>>>> +
>>>>>            VMSTATE_END_OF_LIST()
>>>>>        },
>>>>>        .subsections = (const VMStateDescription * const []) {
>>>> The migration stream is versioned, so you should increase it,
>>>> but this field is only relevant for KVM (it shouldn't be there
>>>> in non-KVM builds). IMHO the correct migration way to fix that
>>>> is (untested):
>>>>
>>>> -- >8 --
>>>> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
>>>> index c7029fb9b4..08032c6d71 100644
>>>> --- a/target/loongarch/machine.c
>>>> +++ b/target/loongarch/machine.c
>>>> @@ -8,8 +8,27 @@
>>>>    #include "qemu/osdep.h"
>>>>    #include "cpu.h"
>>>>    #include "migration/cpu.h"
>>>> +#include "sysemu/kvm.h"
>>>>    #include "vec.h"
>>>>
>>>> +#ifdef CONFIG_KVM
>>>> +static bool kvmcpu_needed(void *opaque)
>>>> +{
>>>> +    return kvm_enabled();
>>>> +}
>>>> +
>>>> +static const VMStateDescription vmstate_kvmtimer = {
>>>> +    .name = "cpu/kvmtimer",
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .needed = kvmcpu_needed,
>>>> +    .fields = (const VMStateField[]) {
>>>> +        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    }
>>>> +};
>>>> +#endif /* CONFIG_KVM */
>>>> +
>>>>    static const VMStateDescription vmstate_fpu_reg = {
>>>>        .name = "fpu_reg",
>>>>        .version_id = 1,
>>>> @@ -194,6 +213,9 @@ const VMStateDescription vmstate_loongarch_cpu = {
>>>>            VMSTATE_END_OF_LIST()
>>>>        },
>>>>        .subsections = (const VMStateDescription * const []) {
>>>> +#ifdef CONFIG_KVM
>>>> +        &vmstate_kvmcpu,
>>>> +#endif
>>>>            &vmstate_fpu,
>>>>            &vmstate_lsx,
>>>>            &vmstate_lasx,
>>>> ---
>>> LGTM, I'd just leave only the .needed function under CONFIG_KVM instead
>>> of the whole subsection.
>> But when !KVM it means there's no ".needed" and it'll still be migrated?
> I expressed myself poorly, I meant put the return from .needed under
> CONFIG_KVM. But that is not even necessary, kvm_enabled() is enough.
>
>> IMHO it depends on whether loongarch is in the state already of trying to
>> keep its ABI at all.  I think we should still try to enjoy the time when
>> that ABI is not required, then we can simply add whatever fields, and let
>> things break with no big deal.
>>
>> Note that if with CONFIG_KVM it means it can break migration between kvm
>> v.s. tcg when only one qemu enabled kvm when compile.
Just remove CONIFG_KVM  would be OK?

Thanks.
Song Gao
>>    Considering the
>> patch is from the maintainer (which seems to say "breaking that is all
>> fine!") I'd say the original patch looks good actually, as it allows kvm /
>> tcg migrations too as a baseline.
> I'm fine with this approach as well.
>
>> Thanks,


