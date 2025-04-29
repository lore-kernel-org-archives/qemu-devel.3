Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D6BC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 22:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9t2H-0000bV-5v; Tue, 29 Apr 2025 18:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9t2F-0000aq-1C
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 18:02:39 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9t2D-0004wq-38
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 18:02:38 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-74019695377so2339214b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 15:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745964155; x=1746568955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=673vfcXckcwVgxogLtZYHU/ZF/jsaUBLKWNXQ1xE/GA=;
 b=TEKRD5DN2eegs8svePnmTNXbDQH1E8VuU/coRAxQWFRWynvrq4xMFkArA5x2V3sIHJ
 9QshzNYTNKO68yf3ZBhwZoUpAFs7ekY5VDOW2LDjDJyLaEBUvumD2RnbdgbPowciySG+
 7Nwv10E1VQ6FA/YDmqG5/NwXk8WvDuo4Kb0aAKl/Elch4HFLGsRbf3wK4UMNk4g53baY
 2cZe4DJW5R/unYFPU/eVHxGWErRMXgaU5if9zcuAsiTk/Ao68O+b+LyfU5vIXcyXBW/K
 6Ck6HVHmPk0OpGgSplA6PrEILHPm7R+56HmzQQinDcOW9w22iflLYTMcKkLR7qwnGC7f
 96CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745964155; x=1746568955;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=673vfcXckcwVgxogLtZYHU/ZF/jsaUBLKWNXQ1xE/GA=;
 b=blxA/JsWsf9VaH33Yi9VdZ8mPu/itrmw/lZUjAaEQvxfcmWMfHALsPuJpAh5jfafuI
 C23cF82X55vP9B+Frh5ezL9k3885g57pVX0y3XhwKPfgzw2tcCSO4cOHY26x1tUSlXB5
 o4kMXWEMa/s7Ep0Na7JYbiIZOVzOhOZe37CL81QRN6zZxKE84Ujx5ulK0xMBw/DOYo5D
 oLflwmabGKMgN2cUQhtHITYvTHr5sXJ9bBJ/TkdrJZmt9+fPDMrMiP9/Sd5ZYHjl+Rqi
 sjQX4MIKwglib/Roge8w2qg1JWFiETuo4ka5CJk/72ITzHm6PZMNzYvsxeR0oXIR8i4r
 M6zQ==
X-Gm-Message-State: AOJu0YwAF2xWaqVTObaj0KjgnKWKFfcmYMjKf1MjRPcmCrU54vh6iVDg
 BmdIrRkuNQxFrn3vGtI7Z+2mJVgXvxNPXpOhizAD/aiy7iUqEFVVR7a/A0fEhig=
X-Gm-Gg: ASbGncti3QuN+9B2PyZmNXU6S0idTUyAuOFZ3nduje2JbLo9If83vUSlB48jTAHgD04
 bLdjhTneEK22OHQQ8CycbboI0/OA9fA9YwBDGMJ6X1sSvmCkSD+WLfYbzlm2XRbj+dRI9Zg/2kX
 fLUuwPygJzPd4wGG3LkBqyfZwxgz/Z5qg6I+kxZlJx3KLn1YtwXl9Ve9lYNf4gAx927/Mk1ne8Y
 KvJGaQzLAohmIxjcQeYWUs/uaaJV6rutMGcZY8NkRqm0PBJZzPNh8gKuVNTIWxtUG3TQdTcwKQh
 hNo+gBMKc5Pp6xkmZ28FqT79N0mZjscjkPT+3JLEs8kDMxhwjhqRYw==
X-Google-Smtp-Source: AGHT+IHGsu3aaaZ8AgfQnKJoDLS8J+k1ti2SO5D4FRDqu2askuRacbj0XulqEPxKT1UI/1sN+VOcPg==
X-Received: by 2002:a05:6a00:3981:b0:737:6d4b:f5f8 with SMTP id
 d2e1a72fcca58-74038a67154mr1037049b3a.17.1745964155371; 
 Tue, 29 Apr 2025 15:02:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a5c376sm197194b3a.129.2025.04.29.15.02.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 15:02:34 -0700 (PDT)
Message-ID: <b044596b-46a0-47ca-a1f0-61160c59efc9@linaro.org>
Date: Tue, 29 Apr 2025 15:02:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] target/arm/kvm_arm: copy definitions from kvm
 headers
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
 <20250429050010.971128-6-pierrick.bouvier@linaro.org>
 <87msbz45y6.fsf@draig.linaro.org>
 <d455055c-a13b-4e00-b921-5ede2be08e89@linaro.org>
In-Reply-To: <d455055c-a13b-4e00-b921-5ede2be08e89@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/29/25 2:14 PM, Pierrick Bouvier wrote:
> On 4/29/25 3:28 AM, Alex Bennée wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>
>>> "linux/kvm.h" is not included for code compiled without
>>> COMPILING_PER_TARGET, and headers are different depending architecture
>>> (arm, arm64).
>>> Thus we need to manually expose some definitions that will
>>> be used by target/arm, ensuring they are the same for arm amd aarch64.
>>>
>>> As well, we must but prudent to not redefine things if code is already
>>> including linux/kvm.h, thus the #ifndef COMPILING_PER_TARGET guard.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    target/arm/kvm_arm.h | 15 +++++++++++++++
>>>    1 file changed, 15 insertions(+)
>>>
>>> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
>>> index c8ddf8beb2e..eedd081064c 100644
>>> --- a/target/arm/kvm_arm.h
>>> +++ b/target/arm/kvm_arm.h
>>> @@ -16,6 +16,21 @@
>>>    #define KVM_ARM_VGIC_V2   (1 << 0)
>>>    #define KVM_ARM_VGIC_V3   (1 << 1)
>>>    
>>> +#ifndef COMPILING_PER_TARGET
>>> +
>>> +/* we copy those definitions from asm-arm and asm-aarch64, as they are the same
>>> + * for both architectures */
>>> +#define KVM_ARM_IRQ_CPU_IRQ 0
>>> +#define KVM_ARM_IRQ_CPU_FIQ 1
>>> +#define KVM_ARM_IRQ_TYPE_CPU 0
>>> +typedef unsigned int __u32;
>>> +struct kvm_vcpu_init {
>>> +    __u32 target;
>>> +    __u32 features[7];
>>> +};
>>> +
>>> +#endif /* COMPILING_PER_TARGET */
>>> +
>>
>> I'm not keen on the duplication. It seems to be the only reason we have
>> struct kvm_vcpu_init is for kvm_arm_create_scratch_host_vcpu() where the
>> only *external* user passes in a NULL.
>>
> 
> I'm not keen about it either, so thanks for pointing it.
> 
>> If kvm_arm_create_scratch_host_vcpu() is made internal static to
>> target/arm/kvm.c which will should always include the real linux headers
>> you just need a QMP helper.
>>
> 
> Yes, sounds like the good approach! Thanks.
>

Alas this function is used in target/arm/arm-qmp-cmds.c, and if we move 
the code using it, it pulls QAPI, which is target dependent at this time.

Since struct kvm_vcpu_init is only used by pointer, I could workaround 
this by doing a simple forward declaration in kvm_arm.h.

>> For the IRQ types is this just a sign of target/arm/cpu.c needing
>> splitting into TCG and KVM bits?
>>
> 
> I'll move relevant functions to target/arm/kvm.c, so cpu.c can be
> isolated from this.
> 
>>
>>>    /**
>>>     * kvm_arm_register_device:
>>>     * @mr: memory region for this device
>>
> 


