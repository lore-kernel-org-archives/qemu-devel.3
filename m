Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19853C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 22:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEyXX-00061z-0i; Tue, 13 May 2025 18:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEyXV-00061M-0d
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:55:57 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEyXT-0003lq-CT
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:55:56 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b24f986674fso327122a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 15:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747176954; x=1747781754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LBJDbb+g+rnG8821hA+sNUH+3t1umps8kf5QOmsN0dM=;
 b=eEekhJ6WlQnt0wZusp+z9QV5rvDfaZixX2XBij8byAbVug9ZUYkdxg+iC3TR2FnqJz
 nhhtDqm4gz4+3atXMou1zLaU1lxouPnDCt/cTtCXwsNlBSJoyTZlTKtgHs0iSO187rqe
 St4KnFz+rPQQ0DhEYzjwOHrPiTrPZ4PTzt9CjQTYYqaTak4tofbI1nXQ6vFio/MrlMDS
 gKKxNSealfRH3a9k99rXvgIsH4i3kDMa9z/n+0ZI/teUjPBAc7qvtSWOYpUsfp0BtS4u
 6WcF3DcKVHg3DrREToanBaNNTkIHb0Aihn5UUH+QuGJisg8elG/F7AyBxVYPn3fc+oMr
 Y4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747176954; x=1747781754;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LBJDbb+g+rnG8821hA+sNUH+3t1umps8kf5QOmsN0dM=;
 b=kc52KB0n+dXBhcJM0ds76CAJVx6eBGzns6EL5yMHo0Z1ahnOj2mv7NfsHaMD19XQeR
 Zf9eekkcQntqPMHmGsd5+DORqfCPK5MH8RuipeS6PCxXcd4eOLLC3VpedjE573MeB8nI
 /kZWlDK7fFahD8opuACXK8qrZIGOD2e368KHW6yOP6Ri5IHd69aPZ4gaYyvTCP6bQq2o
 pYylkODa/MuDAJnG5uaHxYj3H+cEf32/vup3eSkVTcxitFFeRpJsi8uUIpC2udzPot+S
 biAklC3H1dQ4YgmmOU0785DbgBMXHWcYs5JbuUYv2WkHjk0s9XBJLtIsXkzGjhSLWbhv
 rFfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsiwOgrStldgstXbFOc2LKZLcF/C0tSqNIXlk5ZvjtMqRn+M5g8XOHXzHdRwNG3LI63IKoT4CUVrAd@nongnu.org
X-Gm-Message-State: AOJu0YxPvo8RqyUjuEDK+yerDg4umXGzXjNBpWdHqM3H1CYqw7XqLMZ4
 W/aggfm6ZvLLTtL1mkqhghLTvGVo0jylDTuYwS5s42lTlLAzA/ngOj57B0xm2js=
X-Gm-Gg: ASbGncsep1SVe9gFtlYsQOuMXFFst/I9SRaMTLbHIzPfKDUPUhwYn0Wm6bwUC4lqO3/
 2HUOkliaePsdXdogDO0xBLBV6kpEb/xu9GyCRV/1u+WgIEFa5AEr5VDjuzUAtzjyN7dzmI6z6S8
 L8nJ6w4dg7A1rDMr8xQP+vn643MgCXUf5yfvuZtuspRBbaLyB7IvLVkmPDrJFuifND5SmkYggm0
 kBGtKMjSyS/UHm2+9NKklIH6bJH+AWSqx7m5Be5fLSn3qW8iJ8TCY4sVfiSGAggpjTBaVNNi+AF
 g5expXJRAwYDMa960kTvDzWnyDc+IAEYYabxhcxQ3Y+KrcgjpidQdbrVqxGPlIGp
X-Google-Smtp-Source: AGHT+IHdeevlFHLxUccT1xfjG6u5tqxbZV9hv1bsXOwnio3wriSr/+Avu60k8tk0djcNq0ykX0Xh9w==
X-Received: by 2002:a17:90b:33c8:b0:2fa:2268:1af4 with SMTP id
 98e67ed59e1d1-30e0db01419mr7180936a91.7.1747176953809; 
 Tue, 13 May 2025 15:55:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e33482fd3sm136941a91.37.2025.05.13.15.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 15:55:53 -0700 (PDT)
Message-ID: <d7e3158c-2115-4a74-96a1-aec7fa99e172@linaro.org>
Date: Tue, 13 May 2025 15:55:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xen/arch_hvm: Unify x86 and ARM variants
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Anthony PERARD <anthony@xenproject.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250513171737.74386-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250513171737.74386-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

On 5/13/25 10:17 AM, Philippe Mathieu-Daudé wrote:
> As each target declares the same prototypes, we can
> use a single header, removing the TARGET_XXX uses.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/xen_arch_hvm.h  |  9 ---------
>   include/hw/i386/xen_arch_hvm.h | 11 -----------
>   include/hw/xen/arch_hvm.h      | 14 ++++++++++----
>   hw/arm/xen-pvh.c               |  1 -
>   4 files changed, 10 insertions(+), 25 deletions(-)
>   delete mode 100644 include/hw/arm/xen_arch_hvm.h
>   delete mode 100644 include/hw/i386/xen_arch_hvm.h
> 
> diff --git a/include/hw/arm/xen_arch_hvm.h b/include/hw/arm/xen_arch_hvm.h
> deleted file mode 100644
> index 8fd645e7232..00000000000
> --- a/include/hw/arm/xen_arch_hvm.h
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -#ifndef HW_XEN_ARCH_ARM_HVM_H
> -#define HW_XEN_ARCH_ARM_HVM_H
> -
> -#include <xen/hvm/ioreq.h>
> -void arch_handle_ioreq(XenIOState *state, ioreq_t *req);
> -void arch_xen_set_memory(XenIOState *state,
> -                         MemoryRegionSection *section,
> -                         bool add);
> -#endif
> diff --git a/include/hw/i386/xen_arch_hvm.h b/include/hw/i386/xen_arch_hvm.h
> deleted file mode 100644
> index 1000f8f5433..00000000000
> --- a/include/hw/i386/xen_arch_hvm.h
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -#ifndef HW_XEN_ARCH_I386_HVM_H
> -#define HW_XEN_ARCH_I386_HVM_H
> -
> -#include <xen/hvm/ioreq.h>
> -#include "hw/xen/xen-hvm-common.h"
> -
> -void arch_handle_ioreq(XenIOState *state, ioreq_t *req);
> -void arch_xen_set_memory(XenIOState *state,
> -                         MemoryRegionSection *section,
> -                         bool add);
> -#endif
> diff --git a/include/hw/xen/arch_hvm.h b/include/hw/xen/arch_hvm.h
> index df39c819c8f..8bacaa4ec41 100644
> --- a/include/hw/xen/arch_hvm.h
> +++ b/include/hw/xen/arch_hvm.h
> @@ -1,5 +1,11 @@
> -#if defined(TARGET_I386) || defined(TARGET_X86_64)
> -#include "hw/i386/xen_arch_hvm.h"
> -#elif defined(TARGET_ARM) || defined(TARGET_AARCH64)
> -#include "hw/arm/xen_arch_hvm.h"
> +#ifndef HW_XEN_ARCH_HVM_H
> +#define HW_XEN_ARCH_HVM_H
> +
> +#include <xen/hvm/ioreq.h>
> +#include "hw/xen/xen-hvm-common.h"
> +
> +void arch_handle_ioreq(XenIOState *state, ioreq_t *req);
> +void arch_xen_set_memory(XenIOState *state,
> +                         MemoryRegionSection *section,
> +                         bool add);
>   #endif
> diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
> index 4b26bcff7a5..1a9eeb01c8e 100644
> --- a/hw/arm/xen-pvh.c
> +++ b/hw/arm/xen-pvh.c
> @@ -10,7 +10,6 @@
>   #include "hw/boards.h"
>   #include "system/system.h"
>   #include "hw/xen/xen-pvh-common.h"
> -#include "hw/xen/arch_hvm.h"
>   
>   #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


