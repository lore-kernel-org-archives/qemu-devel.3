Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595D2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJIc-000119-Np; Thu, 19 Dec 2024 11:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIeR-0005e1-1v
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:41:23 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIeO-0004tx-Lq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:41:22 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so567533f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734622879; x=1735227679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=230voEAVIdoM3GiK2Lk/6qE75mi3X3jK00czcVLjJHM=;
 b=NJs9iwepgZ9SkjIld9rzM35Zto1E1VUGfWhRQFo5iY7aSrLga5QNDdqzzs0T+Lxx7Y
 V182fIQcx16gSLnuqs8Uh2MPs3ItWKspWZxIxjG9/T2E9e0m2QjU9X9FOYo7kJ2tCBiJ
 D/+GwW23Nro0leqksOlK7+dl8psynNpLP7aqZkWUQhPxalNRrU1jUB7ZWt8SxMwhb8Ox
 MBmT/u0e92lASPy+07wEcIWQH6C10MJfGLM29EDCte9pKsF0Et7X8P3HriEnNrA2D5mg
 NKUg5rfeNHY79IlMKPjuowkMBSXnEKhCHkvIGxWibyCtGU7LfMhRK6ISyxZIO+2WL0BU
 xx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734622879; x=1735227679;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=230voEAVIdoM3GiK2Lk/6qE75mi3X3jK00czcVLjJHM=;
 b=bjkDzi8o+5YRMIylDW2P7T80HS1f2mJ1hQue/58YwTZlVBkh78bQtKHQ99hfTxJHJR
 /a4YEPjKM2skVKqeCybm5R/qB5xjY7GQaxDLHLt6rCTrW74D6hZkb4XchxO83uge6Ank
 ERVr1HLSz3bcph/mFRFSCr2aRWJnLu2KvuQeNGGu1+cxUP8puhGX5RTYPNBAAuMyxbIl
 YCCTmQouRwse4oj1Vmq72Hu9o9Wtj1L6qODW/ETotr9wlmF8rAxx/EvyX0RgVmKfEc1W
 sHQp+3ODLFARvSvmq0ZhbUuiT2xAsuzUQlsgoHYU3dILj21QOqSqzgZ1IRXl77QmsPv2
 D8uQ==
X-Gm-Message-State: AOJu0YwHBiRchSLtjww3Q6x54R69F0/926lXFGIWgxY+jnHoaYg3ycUe
 YDV3OHGf8gHCKD/OTM7VNTq3/RyDf3q5D7xCczOMndYHvSv+bA62k1k4PhMQhf8=
X-Gm-Gg: ASbGncv/l8EprxZP+c36Yer7ccv/gd/239ZvhXZAuGetThZXeFtn8OQAWtOmVTSGd6c
 t3ZX/jRvE5ZgBqtjw7ZDbfwmHaA/JBmV38p+UFVTnjIHJgsDp6aLjaVTv8xcrtUREe2IqbijE0h
 KvVOjue4Qo44std3fxuPrzXFxH5A2RJbJdGPm96ED3XcoiETqxtk2PZ0/idppJ/4wkuozI5E8pZ
 vMTBu/Qfy83+UuT3aVAZXCB1Z53sGZpbbL/ev//CydmebzuR2xb9oyC25ytsN0nxfK9TkI=
X-Google-Smtp-Source: AGHT+IGw9wLPsUC1lVFMDShijNyJD3LuSIx1BfJ0c+rxN6rVJs/z27L+ARehDuPZZSW9uFPbDeO8Qg==
X-Received: by 2002:a05:6000:18a4:b0:385:e013:b842 with SMTP id
 ffacd0b85a97d-388e4d42b6emr8066863f8f.14.1734622878841; 
 Thu, 19 Dec 2024 07:41:18 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828f8fsm1809189f8f.12.2024.12.19.07.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 07:41:18 -0800 (PST)
Message-ID: <bd138636-6895-4e71-8cd8-715799f3c28b@linaro.org>
Date: Thu, 19 Dec 2024 16:41:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] Host Memory Backends and Memory devices queue
 2024-12-18
To: David Hildenbrand <david@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
 <CAJSP0QUoerckBWX=0PD_82jFwVbmtvftWf5QqSWxpK0Ttc+uvQ@mail.gmail.com>
 <2e6400d9-6fee-41ed-a317-329f275912c6@redhat.com>
 <d19ab3d3-737d-4faa-a7d7-639b4ea3b172@redhat.com>
 <4080b391-95d3-4cd8-a9fc-d68fda6bc160@linaro.org>
 <ea932dfd-df30-43d8-9cdb-ecbb5db92a7e@redhat.com>
 <233f096f-5707-4a18-858e-50471ecebf67@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <233f096f-5707-4a18-858e-50471ecebf67@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 19/12/24 15:05, David Hildenbrand wrote:
> On 19.12.24 14:11, David Hildenbrand wrote:
>> On 19.12.24 14:04, Philippe Mathieu-Daudé wrote:
>>> Hi,
>>>
>>> On 19/12/24 12:18, David Hildenbrand wrote:
>>>> On 19.12.24 01:04, David Hildenbrand wrote:
>>>>> On 18.12.24 22:09, Stefan Hajnoczi wrote:
>>>>>> On Wed, 18 Dec 2024 at 05:55, David Hildenbrand <david@redhat.com>
>>>
>>>
>>>>>> Please take a look at the following s390x-related CI failures:
>>>>>
>>>>> Thanks, most of them seem related to this PULL.
>>>>>
>>>>>
>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972912
>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972809
>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972931
>>>>>
>>>>> ../hw/s390x/s390-virtio-ccw.c: In function ‘s390_set_memory_limit’:
>>>>> ../hw/s390x/s390-virtio-ccw.c:138:9: error: ‘hw_limit’ may be used
>>>>> uninitialized [-Werror=maybe-uninitialized]
>>>>>       138 |         error_report("host supports a maximum of %" 
>>>>> PRIu64 "
>>>>> GB",
>>>>>           |
>>>>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>       139 |                      hw_limit / GiB);
>>>>>           |                      ~~~~~~~~~~~~~~~
>>>>> ../hw/s390x/s390-virtio-ccw.c:130:14: note: ‘hw_limit’ declared here
>>>>>       130 |     uint64_t hw_limit;
>>>>>           |              ^~~~~~~~
>>>>>
>>>>> Looks weird. Without kvm_enabled() ret = 0, so ret cannot be
>>>>> -E2BIG and consequently that code won't be executed.
>>>>>
>>>>> Anyhow, I'll simply initialize hw_limit to 0 to silence the warning.
>>>>>
>>>>>
>>>>>>
>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972861
>>>>>
>>>>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-skeys.c.o: in
>>>>> function `qemu_s390_enable_skeys':
>>>>> /builds/qemu-project/qemu/build/../hw/s390x/s390-skeys.c:256:
>>>>> undefined reference to `s390_get_memory_limit'
>>>>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-hypercall.c.o: in
>>>>> function `handle_virtio_ccw_notify':
>>>>> /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:46:
>>>>> undefined reference to `virtio_ccw_get_vdev'
>>>>> /usr/bin/ld: /builds/qemu-project/qemu/build/../hw/s390x/s390-
>>>>> hypercall.c:47: undefined reference to `virtio_queue_get_num'
>>>>> /usr/bin/ld: /builds/qemu-project/qemu/build/../hw/s390x/s390-
>>>>> hypercall.c:56: undefined reference to `virtio_queue_notify'
>>>>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-hypercall.c.o: in
>>>>> function `handle_storage_limit':
>>>>> /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:64:
>>>>> undefined reference to `s390_get_memory_limit'
>>>>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-hypercall.c.o: in
>>>>> function `handle_virtio_ccw_notify':
>>>>> /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:52:
>>>>> undefined reference to `virtio_get_queue'
>>>>> /usr/bin/ld: /builds/qemu-project/qemu/build/../hw/s390x/s390-
>>>>> hypercall.c:52: undefined reference to
>>>>> `virtio_queue_set_shadow_avail_idx'
>>>>>
>>>>> We're building with "--without-default-devices' '--without-default-
>>>>> feature".
>>>>> Consequently, we won't even have CONFIG_S390_CCW_VIRTIO
>>>>>
>>>>> So we won't compile s390-virtio-ccw.c, but we will compile things like
>>>>> s390-stattrib.c,
>>>>> s390-hypercall.c, ... which to me is extremely odd.
>>>>>
>>>>> Is this maybe a leftover from the time when we had the old machine
>>>>> type? What value
>>>>> is it to compile all these files without even having a machine that
>>>>> could make use
>>>>> of these?
>>>
>>>
>>>> The following on top seems to make everything happy. I wish the
>>>> CONFIG_S390_CCW_VIRTIO stuff would't have to be so complicated, just to
>>>> handle odd configs that don't really make sense.
>>>>
>>>>
>>>> I'll do some more testing, then squash the changes into the respective
>>>> patches and resend.
>>>>
>>>>
>>>> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
>>>> index 094435cd3b..3bbebfd817 100644
>>>> --- a/hw/s390x/meson.build
>>>> +++ b/hw/s390x/meson.build
>>>> @@ -12,7 +12,6 @@ s390x_ss.add(files(
>>>>       's390-pci-inst.c',
>>>>       's390-skeys.c',
>>>>       's390-stattrib.c',
>>>> -  's390-hypercall.c',
>>>>       'sclp.c',
>>>>       'sclpcpu.c',
>>>>       'sclpquiesce.c',
>>>> @@ -28,7 +27,10 @@ s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
>>>>     s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
>>>>       'tod-tcg.c',
>>>>     ))
>>>> -s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files('s390-
>>>> virtio-ccw.c'))
>>>> +s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files(
>>>> +  's390-virtio-ccw.c',
>>>> +  's390-hypercall.c',
>>>> +))
>>>>     s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270- 
>>>> ccw.c'))
>>>>     s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci- 
>>>> vfio.c'))
>>>>
>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>>> index 248566f8dc..097ec78826 100644
>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>> @@ -127,7 +127,7 @@ static void subsystem_reset(void)
>>>>     static void s390_set_memory_limit(S390CcwMachineState *s390ms,
>>>>                                       uint64_t new_limit)
>>>>     {
>>>> -    uint64_t hw_limit;
>>>> +    uint64_t hw_limit = 0;
>>>>         int ret = 0;
>>>>
>>>>         assert(!s390ms->memory_limit && new_limit);
>>>> @@ -145,13 +145,6 @@ static void
>>>> s390_set_memory_limit(S390CcwMachineState *s390ms,
>>>>         s390ms->memory_limit = new_limit;
>>>>     }
>>>>
>>>> -uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
>>>> -{
>>>> -    /* We expect to be called only after the limit was set. */
>>>> -    assert(s390ms->memory_limit);
>>>> -    return s390ms->memory_limit;
>>>> -}
>>>> -
>>>>     static void s390_set_max_pagesize(S390CcwMachineState *s390ms,
>>>>                                       uint64_t pagesize)
>>>>     {
>>>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/ 
>>>> s390-
>>>> virtio-ccw.h
>>>> index 5a730f5d07..599740a998 100644
>>>> --- a/include/hw/s390x/s390-virtio-ccw.h
>>>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>>>> @@ -35,7 +35,12 @@ struct S390CcwMachineState {
>>>>         SCLPDevice *sclp;
>>>>     };
>>>>
>>>> -uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms);
>>>
>>> Pre-existing, I'm surprised this hw/ declaration is used
>>> in s390_pv_vm_try_disable_async() in target/s390x/kvm/pv.c.
>>
>> That is added in patch #12, though.
>>
>>>
>>>
>>> In hw/s390x/Kconfig, S390_CCW_VIRTIO doesn't depend on KVM,
>>
>> Right.
>>
>>> but due to this call, KVM depends on S390_CCW_VIRTIO...
>>
>> Right, that's why I opted for inlining for now.
>>
>>>
>>>> +static inline uint64_t s390_get_memory_limit(S390CcwMachineState 
>>>> *s390ms)
>>>> +{
>>>> +    /* We expect to be called only after the limit was set. */
>>>> +    assert(s390ms->memory_limit);
>>>> +    return s390ms->memory_limit;
>>>> +}
>>>
>>> Short term, no better suggestion than inlining :(
>>
>> Yes. And I suspect we do have similar compilation problems, that simply
>> nobody noticed so far.
>>
>> For example, hpage_1m_allowed() resides in hw/s390x/s390-virtio-ccw.c,
>> but is called from target/s390x/kvm/kvm.c ...
>>
>> So building QEMU with KVM but without CONFIG_S390_CCW_VIRTIO should make
>> the linker unhappy :/ :(
> 
> And indeed with KVM, what a mess.
> 
> /usr/bin/ld: libqemu-s390x-softmmu.a.p/target_s390x_kvm_kvm.c.o: in 
> function `kvm_s390_set_max_pagesize':
> /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:300: undefined 
> reference to `hpage_1m_allowed'
> /usr/bin/ld: libqemu-s390x-softmmu.a.p/target_s390x_kvm_kvm.c.o: in 
> function `kvm_arch_init':
> /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:376: undefined 
> reference to `ri_allowed'
> /usr/bin/ld: /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:381: 
> undefined reference to `cpu_model_allowed'
> /usr/bin/ld: /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:391: 
> undefined reference to `cpu_model_allowed'
> /usr/bin/ld: /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:381: 
> undefined reference to `cpu_model_allowed'
> /usr/bin/ld: /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:391: 
> undefined reference to `cpu_model_allowed'
> /usr/bin/ld: libqemu-s390x-softmmu.a.p/target_s390x_kvm_kvm.c.o: in 
> function `handle_diag':
> /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:1590: undefined 
> reference to `handle_diag_500'
> /usr/bin/ld: libqemu-s390x-softmmu.a.p/target_s390x_kvm_kvm.c.o: in 
> function `kvm_s390_cpu_models_supported':
> /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:2354: undefined 
> reference to `cpu_model_allowed'
> 
> I can fix the handle_diag_500() similarly up here as done for TCG, 
> although I think
> we want to clean this up differently.
> 
> Most code doesn't make any sense without an actual s390x machine.

Agreed, don't waste time on that now, I'll likely have a look at
that in few months.

> 
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index dd0322c43a..32cf70bb19 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -51,6 +51,7 @@
>   #include "hw/s390x/s390-virtio-ccw.h"
>   #include "hw/s390x/s390-virtio-hcall.h"
>   #include "target/s390x/kvm/pv.h"
> +#include CONFIG_DEVICES
> 
>   #define kvm_vm_check_mem_attr(s, attr) \
>       kvm_vm_check_attr(s, KVM_S390_VM_MEM_CTRL, attr)
> @@ -1494,9 +1495,11 @@ static int handle_e3(S390CPU *cpu, struct kvm_run 
> *run, uint8_t ipbl)
>   static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
>   {
>       CPUS390XState *env = &cpu->env;
> -    int ret;
> +    int ret = -EINVAL;
> 
> +#ifdef CONFIG_S390_CCW_VIRTIO
>       ret = s390_virtio_hypercall(env);
> +#endif /* CONFIG_S390_CCW_VIRTIO */
>       if (ret == -EINVAL) {
>           kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
>           return 0;
> 
> stupid "none"-only configs that probably nobody needs ...

I'm using it as starting point for heterogeneous machines...
This is why I noticed your PR comment and jumped in =)

