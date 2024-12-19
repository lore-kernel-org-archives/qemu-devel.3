Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2786AE7718C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJIg-0001Xp-Iz; Thu, 19 Dec 2024 11:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOIio-00067p-Ta
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:45:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOIil-0005gZ-Of
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734623149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DvqJ+FafYd4WInDyhQKuiEW0OxqaFnjxt7W+IX3DgJw=;
 b=JxA1ZaH6CqqCJc1eXUO7sTXbXaPQhz9LujMYRN1xfXFXI3O9FuT92yx0CajZTSPOVLhv4J
 MoN6YDFulyK7Oxhdh7A22FCMoX+pBWOMNnhO3Pk1zDjs6ZJfx/ysC2j3geUC6fq+aVqCS2
 lWzIRcIK3gnnRjAhoLDuo1B9FNS/2lk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-7XNxnwhVNh6FnMVixpEUlA-1; Thu, 19 Dec 2024 10:45:47 -0500
X-MC-Unique: 7XNxnwhVNh6FnMVixpEUlA-1
X-Mimecast-MFC-AGG-ID: 7XNxnwhVNh6FnMVixpEUlA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3860bc1d4f1so591245f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734623147; x=1735227947;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DvqJ+FafYd4WInDyhQKuiEW0OxqaFnjxt7W+IX3DgJw=;
 b=epbsRM4IaVPryYp45vu8K1j7uG6ntCcqD80BchNh6SBO2XeyE60+FArcvJKI9VuWLD
 BRjZUnUjoyVzGr4Bs9NdT9e4F6zBZYBF3WmojPkLASaXrlgekx0/vPkfWJIu+4JYYNpB
 pOzIY0e7r6bWx/VJpan21ZbEC7dftyIpQR65b5f3HZJRxYqOfirtITAxhDc6uwZdIyCg
 /wWiLSww5IUNEWaO83IlhV+07KF1MA8s5CE9gPuvFVitOk4Cta03X99GMkt+/1nKp3PV
 urqfXDVmB+NCvPvskV/XH2pEmhmbGmL+Bxrk62ez9iX6rEADv+ojUJX0fghn2kZP9anC
 xgfg==
X-Gm-Message-State: AOJu0YxYdoZiEhAmrGQT5U0bYb0DQ/apkh2y4tf74nbYWoEXUctN0k9P
 Iq7PFFodpgo2XQNi1UOdg0t3Tlwxoo66txTOpoAT1l22ezSQ/6gmBqwBAXnRNOwB23XKy/g/M3K
 MRrFjMOndgs1IpZPIZxfzDG3b7tMpPY7pa7SuHwgAyH+QWuosZete
X-Gm-Gg: ASbGncuNnnPDmwi/pyolSub9o1ESaIq8wRfLo24rMprTCbFETN3u0qiyyhK64mBBi0V
 EmWt7LwqbV3uaEOcm/WU9PdQvwWtUCUDyUiFk6a13hKUx4WmJvp7yiCyLomuqz1XAI5jsN6xkPG
 KcREXbsClYsNs04UY9wXp/ubs8edPg8W5ra/6BYUnfvQKnoM9NoCkBH+c0czeXNNvIohHpmafnI
 3/3aYXeVgYlzjDhc8/bq1W7hsbmG9zO2KBUR7Tmcw5jnSzGjITx0L6CXDumh7ddovzPL8jikGd2
 vfMl2Z/Y+ZitiHnZ+x+CgMf3en2EzIJpnU13Fgl51UfXcAGbxnjBGa3IankYZbjVaS6PZYD/2vO
 bVJfNAw==
X-Received: by 2002:a05:6000:4b0b:b0:386:3711:ff8c with SMTP id
 ffacd0b85a97d-388e4d5db4fmr7106034f8f.23.1734623146584; 
 Thu, 19 Dec 2024 07:45:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzk9FPZ3Lz47GDsV5jf3ZW4R5EF6O7kx67rnCw4KVbBmiWtfKI4uzX0DKKHrl65aqvyY3PnQ==
X-Received: by 2002:a05:6000:4b0b:b0:386:3711:ff8c with SMTP id
 ffacd0b85a97d-388e4d5db4fmr7106005f8f.23.1734623146142; 
 Thu, 19 Dec 2024 07:45:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686?
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b11495sm55255045e9.19.2024.12.19.07.45.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 07:45:45 -0800 (PST)
Message-ID: <ef4ee225-a1dc-49ca-8e5a-a35f783f9586@redhat.com>
Date: Thu, 19 Dec 2024 16:45:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] Host Memory Backends and Memory devices queue
 2024-12-18
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
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
 <bd138636-6895-4e71-8cd8-715799f3c28b@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <bd138636-6895-4e71-8cd8-715799f3c28b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On 19.12.24 16:41, Philippe Mathieu-Daudé wrote:
> On 19/12/24 15:05, David Hildenbrand wrote:
>> On 19.12.24 14:11, David Hildenbrand wrote:
>>> On 19.12.24 14:04, Philippe Mathieu-Daudé wrote:
>>>> Hi,
>>>>
>>>> On 19/12/24 12:18, David Hildenbrand wrote:
>>>>> On 19.12.24 01:04, David Hildenbrand wrote:
>>>>>> On 18.12.24 22:09, Stefan Hajnoczi wrote:
>>>>>>> On Wed, 18 Dec 2024 at 05:55, David Hildenbrand <david@redhat.com>
>>>>
>>>>
>>>>>>> Please take a look at the following s390x-related CI failures:
>>>>>>
>>>>>> Thanks, most of them seem related to this PULL.
>>>>>>
>>>>>>
>>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972912
>>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972809
>>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972931
>>>>>>
>>>>>> ../hw/s390x/s390-virtio-ccw.c: In function ‘s390_set_memory_limit’:
>>>>>> ../hw/s390x/s390-virtio-ccw.c:138:9: error: ‘hw_limit’ may be used
>>>>>> uninitialized [-Werror=maybe-uninitialized]
>>>>>>        138 |         error_report("host supports a maximum of %"
>>>>>> PRIu64 "
>>>>>> GB",
>>>>>>            |
>>>>>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>        139 |                      hw_limit / GiB);
>>>>>>            |                      ~~~~~~~~~~~~~~~
>>>>>> ../hw/s390x/s390-virtio-ccw.c:130:14: note: ‘hw_limit’ declared here
>>>>>>        130 |     uint64_t hw_limit;
>>>>>>            |              ^~~~~~~~
>>>>>>
>>>>>> Looks weird. Without kvm_enabled() ret = 0, so ret cannot be
>>>>>> -E2BIG and consequently that code won't be executed.
>>>>>>
>>>>>> Anyhow, I'll simply initialize hw_limit to 0 to silence the warning.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972861
>>>>>>
>>>>>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-skeys.c.o: in
>>>>>> function `qemu_s390_enable_skeys':
>>>>>> /builds/qemu-project/qemu/build/../hw/s390x/s390-skeys.c:256:
>>>>>> undefined reference to `s390_get_memory_limit'
>>>>>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-hypercall.c.o: in
>>>>>> function `handle_virtio_ccw_notify':
>>>>>> /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:46:
>>>>>> undefined reference to `virtio_ccw_get_vdev'
>>>>>> /usr/bin/ld: /builds/qemu-project/qemu/build/../hw/s390x/s390-
>>>>>> hypercall.c:47: undefined reference to `virtio_queue_get_num'
>>>>>> /usr/bin/ld: /builds/qemu-project/qemu/build/../hw/s390x/s390-
>>>>>> hypercall.c:56: undefined reference to `virtio_queue_notify'
>>>>>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-hypercall.c.o: in
>>>>>> function `handle_storage_limit':
>>>>>> /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:64:
>>>>>> undefined reference to `s390_get_memory_limit'
>>>>>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-hypercall.c.o: in
>>>>>> function `handle_virtio_ccw_notify':
>>>>>> /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:52:
>>>>>> undefined reference to `virtio_get_queue'
>>>>>> /usr/bin/ld: /builds/qemu-project/qemu/build/../hw/s390x/s390-
>>>>>> hypercall.c:52: undefined reference to
>>>>>> `virtio_queue_set_shadow_avail_idx'
>>>>>>
>>>>>> We're building with "--without-default-devices' '--without-default-
>>>>>> feature".
>>>>>> Consequently, we won't even have CONFIG_S390_CCW_VIRTIO
>>>>>>
>>>>>> So we won't compile s390-virtio-ccw.c, but we will compile things like
>>>>>> s390-stattrib.c,
>>>>>> s390-hypercall.c, ... which to me is extremely odd.
>>>>>>
>>>>>> Is this maybe a leftover from the time when we had the old machine
>>>>>> type? What value
>>>>>> is it to compile all these files without even having a machine that
>>>>>> could make use
>>>>>> of these?
>>>>
>>>>
>>>>> The following on top seems to make everything happy. I wish the
>>>>> CONFIG_S390_CCW_VIRTIO stuff would't have to be so complicated, just to
>>>>> handle odd configs that don't really make sense.
>>>>>
>>>>>
>>>>> I'll do some more testing, then squash the changes into the respective
>>>>> patches and resend.
>>>>>
>>>>>
>>>>> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
>>>>> index 094435cd3b..3bbebfd817 100644
>>>>> --- a/hw/s390x/meson.build
>>>>> +++ b/hw/s390x/meson.build
>>>>> @@ -12,7 +12,6 @@ s390x_ss.add(files(
>>>>>        's390-pci-inst.c',
>>>>>        's390-skeys.c',
>>>>>        's390-stattrib.c',
>>>>> -  's390-hypercall.c',
>>>>>        'sclp.c',
>>>>>        'sclpcpu.c',
>>>>>        'sclpquiesce.c',
>>>>> @@ -28,7 +27,10 @@ s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
>>>>>      s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
>>>>>        'tod-tcg.c',
>>>>>      ))
>>>>> -s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files('s390-
>>>>> virtio-ccw.c'))
>>>>> +s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files(
>>>>> +  's390-virtio-ccw.c',
>>>>> +  's390-hypercall.c',
>>>>> +))
>>>>>      s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-
>>>>> ccw.c'))
>>>>>      s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-
>>>>> vfio.c'))
>>>>>
>>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>>>> index 248566f8dc..097ec78826 100644
>>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>>> @@ -127,7 +127,7 @@ static void subsystem_reset(void)
>>>>>      static void s390_set_memory_limit(S390CcwMachineState *s390ms,
>>>>>                                        uint64_t new_limit)
>>>>>      {
>>>>> -    uint64_t hw_limit;
>>>>> +    uint64_t hw_limit = 0;
>>>>>          int ret = 0;
>>>>>
>>>>>          assert(!s390ms->memory_limit && new_limit);
>>>>> @@ -145,13 +145,6 @@ static void
>>>>> s390_set_memory_limit(S390CcwMachineState *s390ms,
>>>>>          s390ms->memory_limit = new_limit;
>>>>>      }
>>>>>
>>>>> -uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
>>>>> -{
>>>>> -    /* We expect to be called only after the limit was set. */
>>>>> -    assert(s390ms->memory_limit);
>>>>> -    return s390ms->memory_limit;
>>>>> -}
>>>>> -
>>>>>      static void s390_set_max_pagesize(S390CcwMachineState *s390ms,
>>>>>                                        uint64_t pagesize)
>>>>>      {
>>>>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/
>>>>> s390-
>>>>> virtio-ccw.h
>>>>> index 5a730f5d07..599740a998 100644
>>>>> --- a/include/hw/s390x/s390-virtio-ccw.h
>>>>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>>>>> @@ -35,7 +35,12 @@ struct S390CcwMachineState {
>>>>>          SCLPDevice *sclp;
>>>>>      };
>>>>>
>>>>> -uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms);
>>>>
>>>> Pre-existing, I'm surprised this hw/ declaration is used
>>>> in s390_pv_vm_try_disable_async() in target/s390x/kvm/pv.c.
>>>
>>> That is added in patch #12, though.
>>>
>>>>
>>>>
>>>> In hw/s390x/Kconfig, S390_CCW_VIRTIO doesn't depend on KVM,
>>>
>>> Right.
>>>
>>>> but due to this call, KVM depends on S390_CCW_VIRTIO...
>>>
>>> Right, that's why I opted for inlining for now.
>>>
>>>>
>>>>> +static inline uint64_t s390_get_memory_limit(S390CcwMachineState
>>>>> *s390ms)
>>>>> +{
>>>>> +    /* We expect to be called only after the limit was set. */
>>>>> +    assert(s390ms->memory_limit);
>>>>> +    return s390ms->memory_limit;
>>>>> +}
>>>>
>>>> Short term, no better suggestion than inlining :(
>>>
>>> Yes. And I suspect we do have similar compilation problems, that simply
>>> nobody noticed so far.
>>>
>>> For example, hpage_1m_allowed() resides in hw/s390x/s390-virtio-ccw.c,
>>> but is called from target/s390x/kvm/kvm.c ...
>>>
>>> So building QEMU with KVM but without CONFIG_S390_CCW_VIRTIO should make
>>> the linker unhappy :/ :(
>>
>> And indeed with KVM, what a mess.
>>
>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/target_s390x_kvm_kvm.c.o: in
>> function `kvm_s390_set_max_pagesize':
>> /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:300: undefined
>> reference to `hpage_1m_allowed'
>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/target_s390x_kvm_kvm.c.o: in
>> function `kvm_arch_init':
>> /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:376: undefined
>> reference to `ri_allowed'
>> /usr/bin/ld: /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:381:
>> undefined reference to `cpu_model_allowed'
>> /usr/bin/ld: /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:391:
>> undefined reference to `cpu_model_allowed'
>> /usr/bin/ld: /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:381:
>> undefined reference to `cpu_model_allowed'
>> /usr/bin/ld: /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:391:
>> undefined reference to `cpu_model_allowed'
>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/target_s390x_kvm_kvm.c.o: in
>> function `handle_diag':
>> /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:1590: undefined
>> reference to `handle_diag_500'
>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/target_s390x_kvm_kvm.c.o: in
>> function `kvm_s390_cpu_models_supported':
>> /home/dhildenb/qemu/build/../target/s390x/kvm/kvm.c:2354: undefined
>> reference to `cpu_model_allowed'
>>
>> I can fix the handle_diag_500() similarly up here as done for TCG,
>> although I think
>> we want to clean this up differently.
>>
>> Most code doesn't make any sense without an actual s390x machine.
> 
> Agreed, don't waste time on that now, I'll likely have a look at
> that in few months.

Great, thanks!

> 
>>
>> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
>> index dd0322c43a..32cf70bb19 100644
>> --- a/target/s390x/kvm/kvm.c
>> +++ b/target/s390x/kvm/kvm.c
>> @@ -51,6 +51,7 @@
>>    #include "hw/s390x/s390-virtio-ccw.h"
>>    #include "hw/s390x/s390-virtio-hcall.h"
>>    #include "target/s390x/kvm/pv.h"
>> +#include CONFIG_DEVICES
>>
>>    #define kvm_vm_check_mem_attr(s, attr) \
>>        kvm_vm_check_attr(s, KVM_S390_VM_MEM_CTRL, attr)
>> @@ -1494,9 +1495,11 @@ static int handle_e3(S390CPU *cpu, struct kvm_run
>> *run, uint8_t ipbl)
>>    static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
>>    {
>>        CPUS390XState *env = &cpu->env;
>> -    int ret;
>> +    int ret = -EINVAL;
>>
>> +#ifdef CONFIG_S390_CCW_VIRTIO
>>        ret = s390_virtio_hypercall(env);
>> +#endif /* CONFIG_S390_CCW_VIRTIO */
>>        if (ret == -EINVAL) {
>>            kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
>>            return 0;
>>
>> stupid "none"-only configs that probably nobody needs ...
> 
> I'm using it as starting point for heterogeneous machines...
> This is why I noticed your PR comment and jumped in =)

I assume you mean not having multiple-machines per QEMU (meaning: 
single-binary instead of per-arch binaries), but a single machine that 
comprises multiple architectures? (like, having an arm and a riscv core)?

I see how that can be useful, but not necessarily with s390x in the 
pitcure ... :)

In any case, thanks for your comments!

-- 
Cheers,

David / dhildenb


