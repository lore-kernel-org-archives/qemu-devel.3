Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA32D5B166
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hYG-0000NU-1f; Tue, 29 Oct 2024 04:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5hYE-0000NM-6Y
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5hY8-00064N-Kw
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730190358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Xl67X4BMSM6mb327cFJG7aSrSg6bRQTOrJNd7v+otv4=;
 b=QzufGQgyMBUchb/yipiltdU/sjGX8uZ0JEZjKAQwg+ks0U9yxZUOivUor1HB3AIbhiLTuI
 k1CDbBt9/wGf8Rpj5qjNsnJCJm0avuFIAbrSV6cXTyW7kazbbpEyPQ7xAD81YAWTNJnXgl
 /jTgs1dL2keFtzKxlln+adjkj1hU6Ac=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-WM7itI4nPpu-t3ePmsm43A-1; Tue, 29 Oct 2024 04:25:56 -0400
X-MC-Unique: WM7itI4nPpu-t3ePmsm43A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-431518ae047so32529865e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 01:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730190356; x=1730795156;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xl67X4BMSM6mb327cFJG7aSrSg6bRQTOrJNd7v+otv4=;
 b=O/tpHDBkN59kKxsx+xw5fNEJ4mNMvHki8VfXEFntNDGxiVhIhRooeuHf52B8yEKKpx
 hgHjZjaMUwrp15ZAfBjKzj7OdTx7ooh4WE/tqpDGuPUZS6t6OQHOWUrEneMeEKXS0VHo
 mrzPznNtlrmXOgWauXWFcrRuTFG/MPtbIwkBq09RFfWzieDcKvuhdrZ4+E7ZMyLwFFwi
 83mQSTac9GjP4fzH1Aw4g2ftTeo3eAJLyUKdehfWn5yrXzEXS9w7OgnVGClXR09oTVw2
 eioJM9MNM7QbQI6gyJEk4f6LAegFX81M+vkTlwZuOuWXq61PIF4DCdwiHnxH7NA7u8KU
 Jckg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXVee0WDLYulLJm8ZHAs3rHzE2TUQ/EvwP3LQjZzl89GpmbCxU0oFtczF5h9JvAPjcTK7D3Rb8OisO@nongnu.org
X-Gm-Message-State: AOJu0YxkWFc6Odl4JQSfdmxofIkaa7ZhSKwlKybWno845iyIZNM8mSh9
 wwHFuGw9vKfGqmNE2hKmx+rP6RCgkA+gYszV7f6+Pd7UQtoV9dIZVR1RjaTFGrT2Y+EkY3ZQqYF
 PTibnSpxr/HGopLT2GQGPjBQ2dSkMp/Eyr+EoTrY+cY0ibVixbTQr
X-Received: by 2002:a05:600c:1c96:b0:431:55af:a220 with SMTP id
 5b1f17b1804b1-431b5729f16mr9125225e9.12.1730190355747; 
 Tue, 29 Oct 2024 01:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+qAdQqR874dmXO3B5obveDwT4H+h+QGkwZZMO4qciZ78seyFUiBd/JSGnyUzruzu2bFKH4A==
X-Received: by 2002:a05:600c:1c96:b0:431:55af:a220 with SMTP id
 5b1f17b1804b1-431b5729f16mr9125005e9.12.1730190355409; 
 Tue, 29 Oct 2024 01:25:55 -0700 (PDT)
Received: from [192.168.10.47] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4318b56742asm166098165e9.21.2024.10.29.01.25.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 01:25:54 -0700 (PDT)
Message-ID: <537e3009-1706-4799-a57a-8369ddd2b335@redhat.com>
Date: Tue, 29 Oct 2024 09:25:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/i386: Add CPUID.24 leaf for AVX10
To: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org
Cc: mtosatti@redhat.com, xiaoyao.li@intel.com, xuelian.guo@intel.com
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-4-tao1.su@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241028024512.156724-4-tao1.su@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 10/28/24 03:45, Tao Su wrote:
> @@ -6835,6 +6850,26 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           }
>           break;
>       }
> +    case 0x24: {
> +        *eax = 0;
> +        *ebx = 0;
> +        *ecx = 0;
> +        *edx = 0;
> +        if (!(env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
> +            break;
> +        }
> +
> +        if (count == 0) {
> +            uint8_t v = kvm_arch_get_supported_cpuid(cs->kvm_state, 0x24,
> +                                                     0, R_EBX);
> +            if (env->avx10_version && env->avx10_version < v) {
> +                v = env->avx10_version;
> +            }
> +
> +            *ebx = env->features[FEAT_24_0_EBX] | v;
> +        }
> +        break;
> +    }
>       case 0x40000000:
>           /*
>            * CPUID code in kvm_arch_init_vcpu() ignores stuff

This check should be done elsewhere (called by x86_cpu_realizefn());
cpu_x86_cpuid() should only report the value:

          if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && count == 0) {
              *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
          }

Also, the check should use x86_cpu_get_supported_cpuid() because KVM is not the
only accelerator.


> 
> +    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
> +        uint8_t version =
> +            kvm_arch_get_supported_cpuid(cs->kvm_state, 0x24, 0, R_EBX);
> +
> +        if (!env->avx10_version) {
> +            env->avx10_version = version;
> +        }
> +

This should not be done here, but in max_x86_cpu_realize().  It should also
use x86_cpu_get_supported_cpuid().

For Granite Rapids you're only setting the AVX10 version in v2 and therefore
you don't need it, but there should also be (for the future) an avx10_version
field in X86CPUDefinition, which is set into the avx10-version property at
x86_cpu_load_model().

> index d845384dcd..5566a13f4f 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -662,6 +662,7 @@ typedef enum FeatureWord {
>       FEAT_XSAVE_XSS_HI,     /* CPUID[EAX=0xd,ECX=1].EDX */
>       FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
>       FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
> +    FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */

Adding FEAT_24_0_EBX should be a separate patch.

Paolo

>       FEATURE_WORDS,
>   } FeatureWord;
>   
> @@ -990,6 +991,13 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>   /* Packets which contain IP payload have LIP values */
>   #define CPUID_14_0_ECX_LIP              (1U << 31)
>   
> +/* AVX10 128-bit vector support is present */
> +#define CPUID_24_0_EBX_AVX10_128        (1U << 16)
> +/* AVX10 256-bit vector support is present */
> +#define CPUID_24_0_EBX_AVX10_256        (1U << 17)
> +/* AVX10 512-bit vector support is present */
> +#define CPUID_24_0_EBX_AVX10_512        (1U << 18)
> +
>   /* RAS Features */
>   #define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
>   #define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index fd9f198892..8e17942c3b 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1923,7 +1923,8 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
>           case 0x7:
>           case 0x14:
>           case 0x1d:
> -        case 0x1e: {
> +        case 0x1e:
> +        case 0x24: {
>               uint32_t times;
>   
>               c->function = i;


