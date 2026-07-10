Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54F9C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi6r4-0001ph-IP; Fri, 10 Jul 2026 04:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wi6qx-0001oN-UQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:45:00 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wi6qv-0002LC-8R
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:44:59 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Axx+oDsVBqbDUCAA--.9446S3;
 Fri, 10 Jul 2026 16:44:51 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxEuQAsVBqeiEIAA--.24787S2;
 Fri, 10 Jul 2026 16:44:50 +0800 (CST)
Subject: Re: [PATCH v2 1/3] target/loongarch/kvm: advertise pv features per
 vCPU
To: Tao Cui <cui.tao@linux.dev>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@mailo.com>,
 Tao Cui <cuitao@kylinos.cn>
References: <20260710005029.345378-1-cui.tao@linux.dev>
 <20260710005029.345378-2-cui.tao@linux.dev>
 <70dc23f1-f346-2d47-4a42-e2195ea9e622@loongson.cn>
 <4f914264-be8e-4b5b-a54a-14a911855529@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <471614c4-7f4e-74e2-fbf6-eb6873c67d17@loongson.cn>
Date: Fri, 10 Jul 2026 16:44:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4f914264-be8e-4b5b-a54a-14a911855529@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxEuQAsVBqeiEIAA--.24787S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr1kKrW7WFWkuw1kZw47Awc_yoW7Xr1kpF
 s5AFy5WFZ8Gr4kAw4DJas8XryYyr1xJa1DXr18JFy8AF4DGr12gr109FnF9F1DA397Wr1F
 qF45try7ZFy5ArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
 Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
 14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4s2-UUUUU
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



On 2026/7/10 下午4:09, Tao Cui wrote:
> 
> 
> 在 2026/7/10 10:58, Bibo Mao 写道:
>>
>>
>> On 2026/7/10 上午8:50, Tao Cui wrote:
>>> From: Tao Cui <cuitao@kylinos.cn>
>>>
>>> kvm_set_pv_features() programs the KVM_FEATURE cpucfg attribute, which is a
>>> per-vCPU setting. It was called from kvm_arch_put_registers() under a
>>> function-local static guard, so it ran only once for the whole VM: only the
>>> first vCPU got its pv features pushed to KVM, and on SMP guests the others
>>> never saw KVM_FEATURE_IPI / KVM_FEATURE_STEAL_TIME.
>>>
>>> Drop the static guard and push pv features per vCPU under
>>> KVM_PUT_FULL_STATE, the same gate kvm_set_stealtime() already uses. Host
>>> feature detection stays in kvm_arch_init_vcpu(); the per-vCPU state write
>>> belongs in kvm_arch_put_registers().
>>>
>>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>>> ---
>>>    target/loongarch/kvm/kvm.c | 15 ++++++---------
>>>    1 file changed, 6 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>>> index d6539c12ac..c557ee3c3d 100644
>>> --- a/target/loongarch/kvm/kvm.c
>>> +++ b/target/loongarch/kvm/kvm.c
>>> @@ -816,7 +816,6 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>>>    int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>>>    {
>>>        int ret;
>>> -    static int once;
>>>          ret = kvm_loongarch_put_regs_core(cs);
>>>        if (ret) {
>>> @@ -843,19 +842,17 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>>>            return ret;
>>>        }
>>>    -    if (!once) {
>>> +    if (level >= KVM_PUT_FULL_STATE) {
>>> +        /*
>>> +         * pv_features and steal time are per-vCPU state. Push them on
>>> +         * full-state sync so every vCPU gets its own settings; the kernel
>>> +         * clears the steal-time guest_addr on KVM_PUT_RESET_STATE.
>>> +         */
>>>            ret = kvm_set_pv_features(cs);
>> pv feature is a little different from steal-time. steal-time guest_addr is created from guest OS, pv feature is created from VMM at beginning. steal-time guest_addr can be set for many times, and there is bit KVM_STEAL_PHYS_VALID checking with steal-time guest_addr, however pv feature can be set only once with existing method.
>>
> 
> Hi Bibo,
> 
> Thanks for catching this — I hadn't fully considered the double-call path.
> 
> KVM_PUT_FULL_STATE fires both at realize (cpu_synchronize_post_init) and
> on incoming migration load (cpu_synchronize_all_post_init), so
> kvm_set_pv_features() runs twice on the destination.
> 
>> Although I do not understand flow of VM migration, with KVM_PUT_FULL_STATE state changing, there are at least two places where this state is set, one is from cpu_common_realizefn() which calls cpu_synchronize_post_init(), the other is qemu_loadvm_state()/qemu_loadvm_state_main() which calls cpu_synchronize_all_post_init().
>>
>> It seems that VM will fail to migrate since kvm_set_pv_features is called twice at least here. Do you test VM migration with this patch?
> 
> I did test migration (virt-11.2 -> virt-11.2, virt-11.1 -> virt-11.1) and
> it passed, but that was on a single host — source and destination computed
> the same pv_features. The kernel (kvm_loongarch_cpucfg_set_attr) only
> rejects a re-set when the value differs:
> 
>      if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED) &&
>          ((kvm->arch.pv_features & valid) != val))
>          return -EINVAL;
> 
> So a cross-host migration where the two sides compute different pv_features
> would indeed fail on the second set.
> 
> I'll add a per-vCPU guard so the push happens exactly once (at the first
> FULL_STATE sync); subsequent syncs are skipped and the destination keeps
> advertising the features its own host supports. Does that sound like the
> right direction?
I do not consider pv feature migration supports before. There are two 
points from my side when VM migrates from hostA to hostB, maybe there 
are other requirements out of my knowledge :(
   1. the pv feature value got from running vCPUs on hostA should be 
supported on hostB.
   2. if VM is rebooted or one vCPU is hot added, the pv feature value 
got from new added vCPU on hostB should be the same with boot CPU0, 
which is got from hostA.

Regards
Bibo Mao
> 
> Thanks,
> Tao
> 
>>
>> Regards
>> Bibo Mao
>>>            if (ret) {
>>>                return ret;
>>>            }
>>> -        once = 1;
>>> -    }
>>>    -    if (level >= KVM_PUT_FULL_STATE) {
>>> -        /*
>>> -         * only KVM_PUT_FULL_STATE is required, kvm kernel will clear
>>> -         * guest_addr for KVM_PUT_RESET_STATE
>>> -         */
>>>            ret = kvm_set_stealtime(cs);
>>>            if (ret) {
>>>                return ret;
>>>
>>


