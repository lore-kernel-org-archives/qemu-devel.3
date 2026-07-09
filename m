Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFCEC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 03:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whfg0-0001hA-1x; Wed, 08 Jul 2026 23:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1whffs-0001gn-My
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 23:43:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1whffp-0001Mk-9l
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 23:43:44 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxquvlGE9qHrYBAA--.7361S3;
 Thu, 09 Jul 2026 11:43:33 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxDcfkGE9qMW4GAA--.11731S2;
 Thu, 09 Jul 2026 11:43:33 +0800 (CST)
Subject: Re: [PATCH] target/loongarch/kvm: set pv features per vCPU in
 kvm_arch_init_vcpu
To: Tao Cui <cui.tao@linux.dev>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@mailo.com>,
 Tao Cui <cuitao@kylinos.cn>
References: <20260625015317.678762-1-cui.tao@linux.dev>
 <39029c52-b386-f5b3-4cfb-e912121d224d@loongson.cn>
 <765a77d3-2c35-4ecc-b2bb-8fde8e35d87b@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <623e33bc-2907-b802-fcd1-73e6e1d1b0ca@loongson.cn>
Date: Thu, 9 Jul 2026 11:43:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <765a77d3-2c35-4ecc-b2bb-8fde8e35d87b@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxDcfkGE9qMW4GAA--.11731S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZrW8Cr4xZrW7uw43KFyfAFc_yoW5KrWfpF
 97Aay5Wry5Wr4kAw18ta4UXFy5Ar4xJ3WUZF18JFy8AFsrJr12gry0qFnFgr1DA3ykXr1F
 qF45Jr9xZF15AabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
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

On 2026/7/3 下午2:05, Tao Cui wrote:
> 
> 
> 在 2026/6/25 11:14, Bibo Mao 写道:
>>
>>
>> On 2026/6/25 上午9:53, Tao Cui wrote:
>>> From: Tao Cui <cuitao@kylinos.cn>
>>>
>>> kvm_set_pv_features() programs the KVM_FEATURE cpucfg attribute, which is a
>>> per-vCPU setting. It was called from kvm_arch_put_registers() under a
>>> function-local static guard, so it ran only once for the whole VM and only
>>> the first vCPU actually got its pv features pushed to KVM.
>>>
>>> Move the call to kvm_arch_init_vcpu(), which runs once per vCPU, right
>>> after the pv features are computed, and drop the static guard.
>>>
>>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>>> ---
>>>    target/loongarch/kvm/kvm.c | 15 ++++++---------
>>>    1 file changed, 6 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>>> index d6539c12ac..985812c828 100644
>>> --- a/target/loongarch/kvm/kvm.c
>>> +++ b/target/loongarch/kvm/kvm.c
>>> @@ -816,7 +816,6 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>>>    int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>>>    {
>>>        int ret;
>>> -    static int once;
>>>          ret = kvm_loongarch_put_regs_core(cs);
>>>        if (ret) {
>>> @@ -843,14 +842,6 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>>>            return ret;
>>>        }
>>>    -    if (!once) {
>>> -        ret = kvm_set_pv_features(cs);
>>> -        if (ret) {
>>> -            return ret;
>>> -        }
>>> -        once = 1;
>>> -    }
>>> -
>>>        if (level >= KVM_PUT_FULL_STATE) {
>>>            /*
>>>             * only KVM_PUT_FULL_STATE is required, kvm kernel will clear
>>> @@ -1209,6 +1200,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>            return ret;
>>>        }
>>>    +    /* pv_features is a per-vCPU attribute; set it here, once per vCPU. */
>>> +    ret = kvm_set_pv_features(cs);
>>> +    if (ret < 0) {
>>> +        return ret;
>>> +    }
>> I prefer the old method. The pv_features is one vCPU state instead, and it will be added in vCPU VMState if migration is supported on different host kernel version.
>>
>> Here is host feature detection, not vCPU state setting.
> 
> Thanks, that makes sense. init_vcpu() is the host-detection path; the
> per-vCPU write belongs in kvm_arch_put_registers(). I'll keep it there,
> drop the VM-global static guard, and push per-vCPU under
> level >= KVM_PUT_FULL_STATE, the same gate kvm_set_stealtime() already
> uses just below.
> 
> For migration across kernel versions, I'll add env->pv_features as a
> sub-section of vmstate_loongarch_cpu (leaving version 4 untouched) so
> the value travels with the vCPU.
yes, instead pv_features is the value of pseudo register 
CPUCFG_KVM_FEATURE 0x40000004, defined in kernel file 
arch/loongarch/include/uapi/asm/kvm_para.h.

Also also remember to add field no_pv_feature in LoongArchCPU object and 
VirtMachineClass. So that with QEMU 11.1 machine type, no_pv_feature is 
true, with higer version than QEMU 11.1,  no_pv_feature is default false.

Regards
Bibo Mao
> 
> Thanks,
> Tao
> 
>>
>> Regards
>> Bibo Mao
>>> +
>>>        ret = kvm_cpu_check_ptw(cs, &local_err);
>>>        if (ret < 0) {
>>>            error_report_err(local_err);
>>>
>>
> 


