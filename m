Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEEDE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGh-0003J0-Bx; Thu, 19 Dec 2024 11:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOGDB-0008WT-Bo
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 08:05:05 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOGD9-0001sm-5Y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 08:05:05 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-725f4623df7so731771b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 05:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734613501; x=1735218301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1tXuvZuQM+RjdVqq4gLXtYtavrGzu2dIZheB+s1Bo+k=;
 b=K3ABfCfkECWf7LKPVdDKWlL2lM4iTxNTQKtVhxGrFsXmOrPGeNpiNUcxLPIEeqeCvw
 e+S/p5AjpBJCB3TBe3u8G0xOTCGKkofCj96NOrPv8EpPOxsSRks1Wu5J1zEeU52/ohIy
 lbg40RSWDRd4kWyx/n8AY3IESAsWmyvgDYc6K0mhqaJcPjixB8ewS0CYJexpLfGGyi5N
 a9hG8sFJfxcUSCRsgiwgMaw9hDQaJRNmP6gcb99we3FVuKOB438CnbyPWnHNx4raz4fs
 MvPh7517Cq+vs6xOyPGUGCjfbDBb6QfWa4P+Wr+yf3EzkIiFUfPjAwlVzyZaaHn5HN9J
 JqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734613501; x=1735218301;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1tXuvZuQM+RjdVqq4gLXtYtavrGzu2dIZheB+s1Bo+k=;
 b=cbg2040eREq8fr0p+DP8/dVE1CpdASC88bK2X/2hAUdzspKeQ+iT3iyahqP6zNFcSL
 nb7ZHRu9x/RL4d1n1JO23uPSaOX6vTOx4TN7lcTsBo9/GAywtlgy5yJ7min2+j+j6bUq
 qmywB2uN4B+FrXixScjbqjJORCFz5+YeOCpLw9vmZrPj1HHtt6V4LlEKnJEHh4lwYvq7
 sGzluNLak9g7caK/VT2ZtUXBPjxMMPYt0HBkSEgA1BRY1SfsAmsBUl5NyxlBwTlWdwVt
 SFHGwUHdozSWlLCqSlSlZ960qm130SUoVgPaKprIUZOmbRuI8EDdwJ5J0dq7J2r+RKtz
 36cw==
X-Gm-Message-State: AOJu0YylfbdelckfX6j/VnbMUX6RIy5HyC33QpdVczok0b5w7XEQSPeP
 HPj+Nu35WjGBQJ2f1UWA8O8PoOKqegViWOw+fSRXrm6W3hthBBvYn7iyWlaYzmw=
X-Gm-Gg: ASbGncuF9yX6RYfun+gZ1y+Jjs+n11L1f1PQGk4CqPBjfTG8g2kn+v9XhZYSamHP947
 WZn3i9Pc0RC5Ib+4NDF5RPqUceSO36FXlQTahVMqMJqcvtHOLZjkJXCD7u1VvXk5uk5tJv0pp+K
 uBoaeH6ZTSqsy/9i6wE5oBkj7BREHLWNEhk2nW5cTadXE7SpyqNMnOU/6V6soWhBOr2V2DRke+m
 GuIhOE8lqWbBuX5OBqm8fhq6q3XtyO/FtnNvIcZShtKYzVqymvZBF4AcxLxQEgX0Q==
X-Google-Smtp-Source: AGHT+IFGV9rtrIiWDuQgIhpg5bKj7jZ7obiQo0ZzHDsIlOfWFD5scLuwIzohUAcQCCeS6EoCQn0bzg==
X-Received: by 2002:a05:6a00:44cb:b0:724:592d:aa5f with SMTP id
 d2e1a72fcca58-72a8d2c3c0fmr10935989b3a.19.1734613501194; 
 Thu, 19 Dec 2024 05:05:01 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbb87sm1217353b3a.113.2024.12.19.05.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 05:05:00 -0800 (PST)
Message-ID: <4080b391-95d3-4cd8-a9fc-d68fda6bc160@linaro.org>
Date: Thu, 19 Dec 2024 14:04:52 +0100
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
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d19ab3d3-737d-4faa-a7d7-639b4ea3b172@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42a.google.com
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

Hi,

On 19/12/24 12:18, David Hildenbrand wrote:
> On 19.12.24 01:04, David Hildenbrand wrote:
>> On 18.12.24 22:09, Stefan Hajnoczi wrote:
>>> On Wed, 18 Dec 2024 at 05:55, David Hildenbrand <david@redhat.com> 


>>> Please take a look at the following s390x-related CI failures:
>>
>> Thanks, most of them seem related to this PULL.
>>
>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972912
>>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972809
>>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972931
>>
>> ../hw/s390x/s390-virtio-ccw.c: In function ‘s390_set_memory_limit’:
>> ../hw/s390x/s390-virtio-ccw.c:138:9: error: ‘hw_limit’ may be used 
>> uninitialized [-Werror=maybe-uninitialized]
>>     138 |         error_report("host supports a maximum of %" PRIu64 " 
>> GB",
>>         |         
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     139 |                      hw_limit / GiB);
>>         |                      ~~~~~~~~~~~~~~~
>> ../hw/s390x/s390-virtio-ccw.c:130:14: note: ‘hw_limit’ declared here
>>     130 |     uint64_t hw_limit;
>>         |              ^~~~~~~~
>>
>> Looks weird. Without kvm_enabled() ret = 0, so ret cannot be
>> -E2BIG and consequently that code won't be executed.
>>
>> Anyhow, I'll simply initialize hw_limit to 0 to silence the warning.
>>
>>
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972861
>>
>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-skeys.c.o: in 
>> function `qemu_s390_enable_skeys':
>> /builds/qemu-project/qemu/build/../hw/s390x/s390-skeys.c:256: 
>> undefined reference to `s390_get_memory_limit'
>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-hypercall.c.o: in 
>> function `handle_virtio_ccw_notify':
>> /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:46: 
>> undefined reference to `virtio_ccw_get_vdev'
>> /usr/bin/ld: /builds/qemu-project/qemu/build/../hw/s390x/s390- 
>> hypercall.c:47: undefined reference to `virtio_queue_get_num'
>> /usr/bin/ld: /builds/qemu-project/qemu/build/../hw/s390x/s390- 
>> hypercall.c:56: undefined reference to `virtio_queue_notify'
>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-hypercall.c.o: in 
>> function `handle_storage_limit':
>> /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:64: 
>> undefined reference to `s390_get_memory_limit'
>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-hypercall.c.o: in 
>> function `handle_virtio_ccw_notify':
>> /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:52: 
>> undefined reference to `virtio_get_queue'
>> /usr/bin/ld: /builds/qemu-project/qemu/build/../hw/s390x/s390- 
>> hypercall.c:52: undefined reference to 
>> `virtio_queue_set_shadow_avail_idx'
>>
>> We're building with "--without-default-devices' '--without-default- 
>> feature".
>> Consequently, we won't even have CONFIG_S390_CCW_VIRTIO
>>
>> So we won't compile s390-virtio-ccw.c, but we will compile things like 
>> s390-stattrib.c,
>> s390-hypercall.c, ... which to me is extremely odd.
>>
>> Is this maybe a leftover from the time when we had the old machine 
>> type? What value
>> is it to compile all these files without even having a machine that 
>> could make use
>> of these?


> The following on top seems to make everything happy. I wish the
> CONFIG_S390_CCW_VIRTIO stuff would't have to be so complicated, just to
> handle odd configs that don't really make sense.
> 
> 
> I'll do some more testing, then squash the changes into the respective
> patches and resend.
> 
> 
> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
> index 094435cd3b..3bbebfd817 100644
> --- a/hw/s390x/meson.build
> +++ b/hw/s390x/meson.build
> @@ -12,7 +12,6 @@ s390x_ss.add(files(
>     's390-pci-inst.c',
>     's390-skeys.c',
>     's390-stattrib.c',
> -  's390-hypercall.c',
>     'sclp.c',
>     'sclpcpu.c',
>     'sclpquiesce.c',
> @@ -28,7 +27,10 @@ s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
>   s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
>     'tod-tcg.c',
>   ))
> -s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files('s390- 
> virtio-ccw.c'))
> +s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files(
> +  's390-virtio-ccw.c',
> +  's390-hypercall.c',
> +))
>   s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
>   s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 248566f8dc..097ec78826 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -127,7 +127,7 @@ static void subsystem_reset(void)
>   static void s390_set_memory_limit(S390CcwMachineState *s390ms,
>                                     uint64_t new_limit)
>   {
> -    uint64_t hw_limit;
> +    uint64_t hw_limit = 0;
>       int ret = 0;
> 
>       assert(!s390ms->memory_limit && new_limit);
> @@ -145,13 +145,6 @@ static void 
> s390_set_memory_limit(S390CcwMachineState *s390ms,
>       s390ms->memory_limit = new_limit;
>   }
> 
> -uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
> -{
> -    /* We expect to be called only after the limit was set. */
> -    assert(s390ms->memory_limit);
> -    return s390ms->memory_limit;
> -}
> -
>   static void s390_set_max_pagesize(S390CcwMachineState *s390ms,
>                                     uint64_t pagesize)
>   {
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390- 
> virtio-ccw.h
> index 5a730f5d07..599740a998 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -35,7 +35,12 @@ struct S390CcwMachineState {
>       SCLPDevice *sclp;
>   };
> 
> -uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms);

Pre-existing, I'm surprised this hw/ declaration is used
in s390_pv_vm_try_disable_async() in target/s390x/kvm/pv.c.


In hw/s390x/Kconfig, S390_CCW_VIRTIO doesn't depend on KVM,
but due to this call, KVM depends on S390_CCW_VIRTIO...

> +static inline uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
> +{
> +    /* We expect to be called only after the limit was set. */
> +    assert(s390ms->memory_limit);
> +    return s390ms->memory_limit;
> +}

Short term, no better suggestion than inlining :(

> 
>   #define S390_PTF_REASON_NONE (0x00 << 8)
>   #define S390_PTF_REASON_DONE (0x01 << 8)
> diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/ 
> misc_helper.c
> index 3732d79185..be1870b07d 100644
> --- a/target/s390x/tcg/misc_helper.c
> +++ b/target/s390x/tcg/misc_helper.c
> @@ -44,6 +44,7 @@
>   #include "hw/boards.h"
>   #include "hw/s390x/tod.h"
>   #endif
> +#include CONFIG_DEVICES
> 
>   /* #define DEBUG_HELPER */
>   #ifdef DEBUG_HELPER
> @@ -117,12 +118,14 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, 
> uint32_t r3, uint32_t num)
> 
>       switch (num) {
>       case 0x500:
> +#ifdef CONFIG_S390_CCW_VIRTIO
>           /* QEMU/KVM hypercall */
>           bql_lock();
>           handle_diag_500(env_archcpu(env), GETPC());
>           bql_unlock();
>           r = 0;
>           break;
> +#endif /* CONFIG_S390_CCW_VIRTIO */
>       case 0x44:
>           /* yield */
>           r = 0;
> 


