Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F93CD3B7CA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 09:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFs99-0004lj-Id; Tue, 26 Nov 2024 04:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFs95-0004lB-Nd
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 04:46:11 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFs93-0005zD-VC
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 04:46:11 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-53da209492cso6841290e87.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 01:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732614368; x=1733219168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=utOlLiB1oR3lMYaNsbhIs9qYb6RkQxsFS+ZnaRw29QQ=;
 b=xAfB4JAx8ccBfOmry+8ghfE6MmXuyIS1i/IlAtFkwgHueCy6thh8oWiPZd0UZSyHLo
 WaRxAwAFzGWPfw+Q2kd0EHG0JfEYvPfOZ4Ioovea2M2usDSh+1AVTO4FlpGUzeW5VkEy
 5dKSyM2bmut/yIzb4QXlVh4gxytRZA9IGvLWPJvqRsRi4427lJFu6txhU3QYuhqam+2w
 i0fvY7+O1KT1eB6F0b5q2JBPEXkZ70GfJZYPJbsdNmEZ4lkXB5WAga5cFTLenpDfjyPh
 wfb9Ac0XylK8/4xmVvIuJn+/MmIYWz5Z8hXVen5najGTfZfRvigAlDQ1KLW2vX6nJT7z
 eX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732614368; x=1733219168;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=utOlLiB1oR3lMYaNsbhIs9qYb6RkQxsFS+ZnaRw29QQ=;
 b=lGETpxn4WDQrcPzOCE3ALfY1n2yLvFWOqWnFVz33Za6fSO5rJ8RFKn0YXEcJXxZRbM
 K43bi/p9ZQY30/QVNxII4vr3xwsU7Le5x0H+3xu0EIbEfMz/7AsLr7rkb4MUpKpgJbQ0
 VlM9OdgxuA9csX5VFZokPxqhflKrQeQ1Pxjg6pu/Z+NLBkqVbYgq9K81c8ewrSGvqk2x
 lSbCLbDQuEEf0UghizFxxXVbf/S0yNSxNrIN3QtSm2sPq3VDCJilxCe8/frWOsyDjQ/r
 x7IGRsTbF8ZSwqEfauCACcr+Gl2nm5sBTZXM9+HtQJKvg8otKkYMQPZwKB12o9YwMRAg
 KogQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkA6bXeWID6/WSK7Dl0UCmDYr3ld+s3pFzUD/l/BEsTTl/qGp9aWmsD9Yn6B7VOtiuYFM7mPQ6+Mvt@nongnu.org
X-Gm-Message-State: AOJu0Yz2YTwnO0ah7tjN9psdYX6CrHtq5h34ivcDMB6WYvfduFJCfKPZ
 7+irz0ijuMCIgl37HOxGp8lz4T2ld6+RYZq2/PjebR+fJT6ZeCHU/AEKrv50xRI=
X-Gm-Gg: ASbGncvQ8jqKO8MrwzIJvB7fHSf2QA+PvHsgdQFeFBr/uCu4vPja3xpd/XpHPyg+a3s
 7cbRdBWjxLHvAr3JYA7gABTjViFJEBUr2xjhlYo8ooHUu76Jkp10rc4cL55r3I/j8IwdS0M6Fn0
 unx5NuFINBhILrTBZdzEIwWolsXmy/1QrlI8tm1S4ll3i85D9qmBEXnYXm5X9as24kSlRwCVtWD
 2pyATUGFTWs6Y9uk56omp7g4nahYRA0jOpxQQqgA6Omt7Hh6TJhdkD6vDCf/SzEvw==
X-Google-Smtp-Source: AGHT+IGQWM6uXzGcNGnkQNOhuHw97egQRdbE7AkCaRYHafH78NNtcslkaJUAwejq3eS7g3joDs3QMQ==
X-Received: by 2002:a05:6512:2356:b0:539:e2cc:d380 with SMTP id
 2adb3069b0e04-53dd389c8cbmr6294994e87.27.1732614367757; 
 Tue, 26 Nov 2024 01:46:07 -0800 (PST)
Received: from [192.168.69.197] ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc4123sm13084777f8f.79.2024.11.26.01.46.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 01:46:07 -0800 (PST)
Message-ID: <04e11ba4-2e3d-4e98-a125-977da8c75d7c@linaro.org>
Date: Tue, 26 Nov 2024 10:46:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/60] kvm: Introduce kvm_arch_pre_create_vcpu()
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-8-xiaoyao.li@intel.com>
 <fbe5da1d-9a0e-4aa4-91f9-dfb729f39dc9@linaro.org>
 <68c65132-0f2e-44eb-b084-bf70edd51417@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <68c65132-0f2e-44eb-b084-bf70edd51417@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 25/11/24 08:27, Xiaoyao Li wrote:
> On 11/13/2024 2:28 PM, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 5/11/24 06:23, Xiaoyao Li wrote:
>>> Introduce kvm_arch_pre_create_vcpu(), to perform arch-dependent
>>> work prior to create any vcpu. This is for i386 TDX because it needs
>>> call TDX_INIT_VM before creating any vcpu.
>>>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>> Changes in v3:
>>> - pass @errp to kvm_arch_pre_create_vcpu(); (Per Daniel)
>>> ---
>>>   accel/kvm/kvm-all.c  | 10 ++++++++++
>>>   include/sysemu/kvm.h |  1 +
>>>   2 files changed, 11 insertions(+)
>>>
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index 930a5bfed58f..1732fa1adecd 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -523,6 +523,11 @@ void kvm_destroy_vcpu(CPUState *cpu)
>>>       }
>>>   }
>>> +int __attribute__ ((weak)) kvm_arch_pre_create_vcpu(CPUState *cpu, 
>>> Error **errp)
>>
>> We don't use the weak attribute. Maybe declare stubs for each arch?
> 
> Or define TARGET_KVM_HAVE_PRE_CREATE_VCPU to avoid touching other ARCHes?
> 
> 8<------------------------------------------------------------------
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -536,10 +531,12 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
> 
>       trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> 
> +#ifdef TARGET_KVM_HAVE_PRE_CREATE_VCPU
>       ret = kvm_arch_pre_create_vcpu(cpu, errp);
>       if (ret < 0) {
>           goto err;
>       }
> +#endif
> 
>       ret = kvm_create_vcpu(cpu);
>       if (ret < 0) {
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 643ca4950543..bb76bf090fec 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -374,7 +374,9 @@ int kvm_arch_get_default_type(MachineState *ms);
> 
>   int kvm_arch_init(MachineState *ms, KVMState *s);
> 
> +#ifdef TARGET_KVM_HAVE_PRE_CREATE_VCPU
>   int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
> +#enfid
>   int kvm_arch_init_vcpu(CPUState *cpu);
>   int kvm_arch_destroy_vcpu(CPUState *cpu);
> 
> 
> 
> I'm OK with either. Please let me what is your preference!

Personally stubs because it is simpler to find where to
implement something, but it is Paolo's area, so his
preference takes over.

