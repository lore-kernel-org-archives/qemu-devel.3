Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA63CDE021
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 16:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1str5d-00082Q-0K; Thu, 26 Sep 2024 12:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1str5Z-0007n0-5q
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 12:11:33 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1str5X-0004Nt-6R
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 12:11:32 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7e6bb2aa758so513791a12.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727367089; x=1727971889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pUgF7KKnjKozU+bAXljfkafMdBi6K6GocohJYE3eMHk=;
 b=SHX1ppwlRos2o3qYcsMI38KtxDtSjx+xd0Z/srFclZHKqU6HVVodhsWwrplg93IlIb
 9BDzaQEAVy+bALvkcrUHlZlv714+EhH0+HbVK7bMfSKw06tdFF+NcjbPTXy5vmlSBY3Z
 pwq5Cvel94DuW9FltxIO6MIo5qFw3NYrQ96WYcz6iKzI1AY7jWGzMPsAc6QDHg0u75Pq
 mmveUXAcnWlGiT3iLk89mOagw76eGhlFRotESXchRmHXIxEeaPvC0bPSq57PKZZ4rdMz
 hUaulnHDvnj3vnQUb+EjFW2xt0/AAfFWZFcrv5C7AJQqiW/9yhzJO5rCYxUuZ3qnf+lE
 ssxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727367089; x=1727971889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pUgF7KKnjKozU+bAXljfkafMdBi6K6GocohJYE3eMHk=;
 b=M+mrLlINkYBtZlIpjlHgz18NmLe6dtJBUQUuzASnm3QQAGmY8JFHV7W2LcGo6HgJvD
 yb6n7fSmvXj+oCxBGWZW1puiM/K5/EAbTzWlF3FXJbOZmFwUJrIxGlEVA3Nrs25xzA55
 mSNCs4ID8IkxgTgf4Zxr9dIdOShtIS844xuMU5OqRMTBVe3bD7BGzmWJs+p48BuQeMhb
 2AnzykkDKXZFh3P0nY4C+S1cLEmuMvGuLyYVKzuE79Q5JDjM7V+uaLWTDxLTZqwu2k+I
 DbPaKzmKxpChXx5U9kDhFijyw29jcfeaSAhUKGE3DRo8g4dgjCnMgkCVUu3Fb6BxtG/N
 VjFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJGXPvl3yej0bxfNq0kzgbTrmf9NMJSNa89reXNej/mmsJMQ/1Urbk7g7v3jUUYKK13DuSIgDceh/x@nongnu.org
X-Gm-Message-State: AOJu0YwaNSyZLi12hVY6S8q7r82R+id3p8H+KBPBwPl5KENnOEPG2B+3
 RldGo4nNbaygPvLAsLoHmBZTIGRc0b2mL6Wf1i+Vm4lquoFHUGNQOEu6NuU+Hic=
X-Google-Smtp-Source: AGHT+IEJbs/+y2kvBZT5K9RNqmHitNVfxN8iWiNnRdDcbl0U57rVo5tfUUbKbKAHQUJUkhEC2PfnBg==
X-Received: by 2002:a05:6a20:3b19:b0:1cf:53ea:7fbc with SMTP id
 adf61e73a8af0-1d4fa6a1496mr271005637.18.1727367089198; 
 Thu, 26 Sep 2024 09:11:29 -0700 (PDT)
Received: from [192.168.0.100] ([187.75.38.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e6db2c8704sm83269a12.52.2024.09.26.09.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 09:11:28 -0700 (PDT)
Message-ID: <f3da8f58-615b-42ed-a99d-20bfd9ec6b56@linaro.org>
Date: Thu, 26 Sep 2024 13:11:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm/kvm: add support for MTE
To: Cornelia Huck <cohuck@redhat.com>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, darren@os.amperecomputing.com
References: <20240920073725.410373-1-gankulkarni@os.amperecomputing.com>
 <87tte3sxkx.fsf@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <87tte3sxkx.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Cornelia and Ganapatrao,

On 9/25/24 14:54, Cornelia Huck wrote:
> On Fri, Sep 20 2024, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>
> Mostly nit-picking below, otherwise LGTM.
>
>> Extend the 'mte' property for the virt machine to cover KVM as
>> well. For KVM, we don't allocate tag memory, but instead enable
>> the capability.
>>
>> If MTE has been enabled, we need to disable migration, as we do not
>> yet have a way to migrate the tags as well. Therefore, MTE will stay
>> off with KVM unless requested explicitly.
>>
>> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
>> which broke TCG since it made the TCG -cpu max
>> report the presence of MTE to the guest even if the board hadn't
>> enabled MTE by wiring up the tag RAM. This meant that if the guest
>> then tried to use MTE QEMU would segfault accessing the
>> non-existent tag RAM.
> I think the more canonical way to express this would be
>
> [$AUTHOR: reworked original patch by doing X to avoid problem Y]
>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> Also, the S-o-b chain is a bit confusing that way, because you are
> listed as author of the patch, but I'm in the chain in front of you -- I
> think I should still be listed as the author?
>
>> ---
>>
>> Changes since V2:
>> 	Updated with review comments.
>>
>> Changes since V1:
>> 	Added code to enable MTE before reading register
>> id_aa64pfr1 (unmasked MTE bits).
>>
>> This patch is boot tested on ARM64 with KVM and on X86 with TCG for mte=on
>> and default case(i.e, no mte).
>>
>>   hw/arm/virt.c        | 72 ++++++++++++++++++++++++++------------------
>>   target/arm/cpu.c     | 11 +++++--
>>   target/arm/cpu.h     |  2 ++
>>   target/arm/kvm.c     | 57 +++++++++++++++++++++++++++++++++++
>>   target/arm/kvm_arm.h | 19 ++++++++++++
>>   5 files changed, 129 insertions(+), 32 deletions(-)
>>
> (...)
>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 19191c2391..8a2fc471ce 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -2390,14 +2390,21 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>>   
>>   #ifndef CONFIG_USER_ONLY
>>           /*
>> -         * If we do not have tag-memory provided by the machine,
>> +         * If we do not have tag-memory provided by the TCG,
> Maybe
>
> "If we run with TCG and do not have tag-memory provided by the machine"
>
> ?

Yep, I agree, this is better.


>>            * reduce MTE support to instructions enabled at EL0.
>>            * This matches Cortex-A710 BROADCASTMTE input being LOW.
>>            */
>> -        if (cpu->tag_memory == NULL) {
>> +        if (tcg_enabled() && cpu->tag_memory == NULL) {
>>               cpu->isar.id_aa64pfr1 =
>>                   FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
>>           }
>> +
>> +        /*
>> +         * Clear MTE bits, if not enabled in KVM mode.
> Maybe add "This matches the MTE bits being masked by KVM in that case."?

Clearing the MTE bits is also necessary when MTE is supported by the
host (and so KVM can enable the MTE capability - so won't mask the MTE
bits, but the user didn't want MTE enabled in the guest (mte=on no given
or explicitly set to =off), so this comment is not always true?

How about something like:

"If MTE is supported by the host but could not be enabled on KVM mode or
MTE should not be enabled on the guest (e.i. mte=off), clear guest's MTE 
bits."

I do assume MTE is supported by the host (i.e. MTE bits >= 2 in the host)
because otherwise condition "if (cpu_isar_feature(aa64_mte, cpu)) { ... 
}" is not
taken; and at this point cpu->isar->id_aa64pfr1 is set from the host's 
bits via
kvm_arm_set_cpu_features_from_host() and kvm_arm_get_host_cpu_features ().


>> +         */
>> +        if (kvm_enabled() && !cpu->kvm_mte) {
>> +                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
>> +        }
>>   #endif
>>       }
>>   
> (...)
>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 849e2e21b3..af7a98517d 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -39,6 +39,7 @@
>>   #include "hw/acpi/acpi.h"
>>   #include "hw/acpi/ghes.h"
>>   #include "target/arm/gtimer.h"
>> +#include "migration/blocker.h"
>>   
>>   const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>>       KVM_CAP_LAST_INFO
>> @@ -119,6 +120,20 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>>       if (vmfd < 0) {
>>           goto err;
>>       }
>> +
>> +    /*
>> +     * MTE capability must be enabled by the VMM before creating
>> +     * any VCPUs. The MTE bits of the ID_AA64PFR1 register are masked
>> +     * if MTE is not enabled, allowing them to be probed correctly.
> This reads a bit confusing. Maybe
>
> "The MTE capability must be enabled by the VMM before creating any VCPUs
> in order to allow the MTE bits of the ID_AA64PFR1 register to be probed
> correctly, as they are masked if MTE is not enabled."

I agree.


>
>> +     */
>> +    if (kvm_arm_mte_supported()) {
>> +        KVMState kvm_state;
>> +
>> +        kvm_state.fd = kvmfd;
>> +        kvm_state.vmfd = vmfd;
>> +        kvm_vm_enable_cap(&kvm_state, KVM_CAP_ARM_MTE, 0);
>> +    }
>> +
>>       cpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
>>       if (cpufd < 0) {
>>           goto err;
> (...)
>

Comments aside:

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

