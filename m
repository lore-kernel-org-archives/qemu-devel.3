Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC80C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyG8l-00027s-UU; Fri, 28 Mar 2025 16:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyG8l-00027e-4C
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:17:19 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyG8j-0001hj-9d
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:17:18 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso6689426a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743193035; x=1743797835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ww95bsiF3BSgA3qgKlnwTM01GDd6OadQkadyFuIYkyc=;
 b=jSe8dExmbJhjtKXOt2jY++P9qtQP1Up/DrohZilsLMIpnKAtreyxj4WlRbEsks9Zql
 F0JRlIutjwYJGr4gzRl/9iV5tFtNFkHHwYSA7o4XPP67K5J0kGgEGxAZuenoOflCl6fH
 InrTRs19KmPopfm3uAasoVX9K7sxvow+/qYRDPWy4MSFnHrmSt5reid7n029DtXMBNWZ
 tw5phZarL+fMliCn6kBYUfThXMfggPZqxh/4yCKgISNkbTgejG1149hPHSZVqJU0JYkq
 KPBAMfBw+ZWRPGdshresGTea1C2nqVrGXkBhr8rm3NXQZo9U4+7sviUKCCx5pNMxQxn/
 hRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743193035; x=1743797835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ww95bsiF3BSgA3qgKlnwTM01GDd6OadQkadyFuIYkyc=;
 b=w//Law4S180iCokkdYqwC7Bq4Moij7RzX545bZ5MWbi7BfMrsLc+CpjaFYRCa4+jXO
 AilWISmi5jU3dSS96TWDuBVo7M4rn6APqs8QOkh2zmhLlJCI73F/xQvsMuZiPoc7sEz5
 qppl+odnHtXnjdIIfnTABhqiy6lvk+syEKP6yxKwq9/7Un+EiCv7ZLZG/cwuh5C0h3cL
 ITT6KMvW11uKd//TubLLktajO4p3z2tfsf0KHQTswwKa+qq/YJCtDGKWPslqJTjR+Nji
 d3vQSzpsiiZS7QZwmLU1ESYZRvORNpU7wyKLCtqVPGEzwe3TNdtC/fQkMI+RZrp7JtSL
 8m0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFxKLMpFUGYVizNdfYpFxoqTw7VpR7D26q189f1DetPcXdah3AvamLlFcx6rx8jWkaaRrEuLj3PM//@nongnu.org
X-Gm-Message-State: AOJu0YwfjeVZL6Rs9mySs79fJtzLhagiw/pWWZUzdgIAD6bQxkCeDKEB
 u0UUqendFkt1A4lKG/LGHfhA2vPF9k+dRaXSr9SduO34+PovTTVdjOn/xMoWYfQ=
X-Gm-Gg: ASbGncvLcXj7QmNdtgHn5boOlSuwZeIed41kLxh8MX/lH83HWLtqNQ7m4L5UHin/U79
 dm7lY88fRnZbqdbCbIf0UV3mkHQnEiaZpOxzfcmwoBiiIlIT++Kmd2v1mGVTfqOjQNSB25RgX0g
 qekj6CKUr0XS8/o5NznjEyPSzcKtRqJHfDXwNj0PxptII8nalsFSS/0H4pqIGy2omxIzge5U6my
 WoJrsvPUyQvqoWnW9FEVTT7kQkxMvwYcRQQTt8HQzcIgNb0R/k6xN8vy4xPX+HbZ1K2Xjz3ix8j
 qiRcXrBWoBd92RtstcKahCKYfZjXFGwFU2hlcSZXimSM17qFkTylxLGY9qV8KaPsj5Q6nQ==
X-Google-Smtp-Source: AGHT+IEfQ/s9vQy+RvR3iygiHCKGWZannu9KuwVLnr52GC6eSczz1YDWYqgmRVT33vWVk9lF0VI+rQ==
X-Received: by 2002:a05:6402:5186:b0:5e0:8840:5032 with SMTP id
 4fb4d7f45d1cf-5edc44bb6e4mr3693871a12.3.1743193034927; 
 Fri, 28 Mar 2025 13:17:14 -0700 (PDT)
Received: from [10.154.28.14] ([193.32.126.156])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc17b212fsm1791919a12.62.2025.03.28.13.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:17:14 -0700 (PDT)
Message-ID: <f6c01c0b-6145-4012-8406-e6e8cc890604@linaro.org>
Date: Fri, 28 Mar 2025 13:17:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] accel/tcg: Move get_page_addr_code* declarations
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250328200459.483089-1-richard.henderson@linaro.org>
 <20250328200459.483089-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250328200459.483089-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ed1-x52d.google.com
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

On 3/28/25 13:04, Richard Henderson wrote:
> Move the declarations from exec/exec-all.h to the
> private accel/tcg/internal-common.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal-common.h | 34 ++++++++++++++++++++++++++++++++++
>   include/exec/exec-all.h     | 34 ----------------------------------
>   accel/tcg/translator.c      |  1 +
>   3 files changed, 35 insertions(+), 34 deletions(-)
> 
> diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
> index 9b6ab3a8cc..2f00560d10 100644
> --- a/accel/tcg/internal-common.h
> +++ b/accel/tcg/internal-common.h
> @@ -74,4 +74,38 @@ uint32_t curr_cflags(CPUState *cpu);
>   
>   void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
>   
> +/**
> + * get_page_addr_code_hostp()
> + * @env: CPUArchState
> + * @addr: guest virtual address of guest code
> + *
> + * See get_page_addr_code() (full-system version) for documentation on the
> + * return value.
> + *
> + * Sets *@hostp (when @hostp is non-NULL) as follows.
> + * If the return value is -1, sets *@hostp to NULL. Otherwise, sets *@hostp
> + * to the host address where @addr's content is kept.
> + *
> + * Note: this function can trigger an exception.
> + */
> +tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
> +                                        void **hostp);
> +
> +/**
> + * get_page_addr_code()
> + * @env: CPUArchState
> + * @addr: guest virtual address of guest code
> + *
> + * If we cannot translate and execute from the entire RAM page, or if
> + * the region is not backed by RAM, returns -1. Otherwise, returns the
> + * ram_addr_t corresponding to the guest code at @addr.
> + *
> + * Note: this function can trigger an exception.
> + */
> +static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
> +                                                vaddr addr)
> +{
> +    return get_page_addr_code_hostp(env, addr, NULL);
> +}
> +
>   #endif
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index fcad3446fe..f52a680f42 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -143,40 +143,6 @@ struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
>                                                hwaddr index, MemTxAttrs attrs);
>   #endif
>   
> -/**
> - * get_page_addr_code_hostp()
> - * @env: CPUArchState
> - * @addr: guest virtual address of guest code
> - *
> - * See get_page_addr_code() (full-system version) for documentation on the
> - * return value.
> - *
> - * Sets *@hostp (when @hostp is non-NULL) as follows.
> - * If the return value is -1, sets *@hostp to NULL. Otherwise, sets *@hostp
> - * to the host address where @addr's content is kept.
> - *
> - * Note: this function can trigger an exception.
> - */
> -tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
> -                                        void **hostp);
> -
> -/**
> - * get_page_addr_code()
> - * @env: CPUArchState
> - * @addr: guest virtual address of guest code
> - *
> - * If we cannot translate and execute from the entire RAM page, or if
> - * the region is not backed by RAM, returns -1. Otherwise, returns the
> - * ram_addr_t corresponding to the guest code at @addr.
> - *
> - * Note: this function can trigger an exception.
> - */
> -static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
> -                                                vaddr addr)
> -{
> -    return get_page_addr_code_hostp(env, addr, NULL);
> -}
> -
>   #if !defined(CONFIG_USER_ONLY)
>   
>   MemoryRegionSection *
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 7ef04fc597..307a513487 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -17,6 +17,7 @@
>   #include "exec/translator.h"
>   #include "exec/plugin-gen.h"
>   #include "tcg/tcg-op-common.h"
> +#include "internal-common.h"
>   #include "internal-target.h"
>   #include "disas/disas.h"
>   #include "tb-internal.h"

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


