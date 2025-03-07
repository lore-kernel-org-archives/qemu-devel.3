Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDC2C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 04:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqPB2-0004VN-Mn; Thu, 06 Mar 2025 23:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqPAg-0004Sq-Fq
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 23:18:50 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqPAe-0008QZ-FW
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 23:18:50 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso2307055a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 20:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741321126; x=1741925926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dFAjZdCbyiJHacoDTjhAsPPb3neNW4fKSdp0x9cUook=;
 b=Jvdjnu9tWoiKjOi0CVX1WnqHeUjFbvPGW/rgZK/tZlmsZ/a9xJweaAtn0rartxPpju
 o4MAIVyXdkbmXQFFWYnGIwFILW/2QdEHfhNFJjeUH3NlJAETqJxSFHcdAVxXNhUYEnsX
 H8EHb1Q9kB8OPglhd/au8J6L8ATVbFBCHAy6uOoYlcjiD2moPnf9w9L+24lnFXj0flH5
 4xvpT9X36BDZKNabhcakRck6b0Wgefo1fseQOt0vF3YvILOfWSw4Nk+PscNOOdQw9l2N
 dSpDRTOpDerJg8d8EQQkVzRgqgSn+CHYNYklm23LpRRALU+/13lS0Yd6sCoP2j9VmMRT
 Gh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741321126; x=1741925926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dFAjZdCbyiJHacoDTjhAsPPb3neNW4fKSdp0x9cUook=;
 b=dT4umHREqBM1QixaaYmmmvGxlyhN6hPq08KxZa3iHna8weVLqa4ezMKJRv21u9OhYN
 YFCKxflOBWD5ZyHNuDQPNHKezrJbicWsV6YSTtf079t+sz48rqg/DQ0rrd5RpkT9bZTF
 vrzzYBKFgks+KNu41KJWI3cc1PmbZgTXKy/tdtR3RFV9qZwdWLedasKbhttHy+fRi00H
 CQdkgJ49++3Rji97WnnOMmp+pA0G24wBaN8ZQAfdCGibYdfB7csatVJad7ObroJ8k7l2
 EPcIMR1+imSabmmTQ5kjtidhW6jXK6BjtxP81KAl5v5wVLxRO9zB0TZj4TAiyihkWnF5
 qDhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlsi8M3uDarfh1YsZ4IDK8x35Hdf8RXGdWjpAAc8rAEkipoH2KJr/jZJFquMyVZNIHESW0fnYSvTyL@nongnu.org
X-Gm-Message-State: AOJu0YwVRiGwPruM4kJ4yDUG/vqZFr96QCArIin1X3oc36Csgz1xhXWa
 KDLQ5DKk9Rp0KYAWx25InQGm486jGk/lF/rvqnAwo6r5ReRLsrTFaavwzQGKoOE=
X-Gm-Gg: ASbGncsjQcVwMYSViiWMh83GjVN7eLEAMk5WcndH8RjqJnrqY+Z0gh1kPUmwzLc7ed7
 +PVjHCXrr1AjKs3fG2GphZSDNgQeg5F2J60caAcz0u2iAKqUFMeK2gk7+erhIoCP8zjoAc/2H4w
 EUEpdu8r026pZASGps4ngnZMo4eI7xquKSOZ1//bvgMysWmTpQUTOvsBDo+LSd8EBBDTDzUzfQQ
 /bi4IO6G75n/8dwGlNN+U7hX0oGyJoQFs5+euw8xTnc/K3h8SMvSGqQ2Gw1tfIH0msvmaDbkNn6
 tGV1qBY/96sjlU+IjOaTk8J2It2uVFz4UlbOlzIuM0BM6FBa0/+bDwPaDQ==
X-Google-Smtp-Source: AGHT+IGXEn+b6iOX/+FG4B12I4OtXhcjrSey27k5eDoSw02A3t8cWUGAg/65IrZGT3XATB0ZR7W5UQ==
X-Received: by 2002:a17:90b:38cd:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-2ff7ce8e5dfmr3140286a91.11.1741321125780; 
 Thu, 06 Mar 2025 20:18:45 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693f6b3asm2080994a91.42.2025.03.06.20.18.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 20:18:45 -0800 (PST)
Message-ID: <9b2b869e-74bb-4532-8ac9-fb641f4f924e@linaro.org>
Date: Thu, 6 Mar 2025 20:18:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/exec: Move TARGET_PAGE_{SIZE,MASK,BITS} to
 target_page.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org
References: <20250306234108.378881-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250306234108.378881-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

On 3/6/25 15:41, Richard Henderson wrote:
> Re-use the TARGET_PAGE_BITS_VARY mechanism to define
> TARGET_PAGE_SIZE and friends when not compiling per-target.
> Inline qemu_target_page_{size,mask,bits} as they are now trivial.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> After this, we could in fact remove qemu_target_page_foo(), etc.
> We certainly don't need to convert any more uses of TARGET_PAGE_FOO.
> 
> r~
> 
> ---
>   include/exec/cpu-all.h     | 21 +-------------
>   include/exec/poison.h      |  5 ----
>   include/exec/target_page.h | 58 ++++++++++++++++++++++++++++++++++----
>   page-target.c              | 18 ------------
>   page-vary-target.c         |  2 ++
>   5 files changed, 55 insertions(+), 49 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 09f537d06f..8f7aebb088 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -105,26 +105,7 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
>   
>   /* page related stuff */
>   #include "exec/cpu-defs.h"
> -#ifdef TARGET_PAGE_BITS_VARY
> -# include "exec/page-vary.h"
> -extern const TargetPageBits target_page;
> -# ifdef CONFIG_DEBUG_TCG
> -#  define TARGET_PAGE_BITS   ({ assert(target_page.decided); \
> -                                target_page.bits; })
> -#  define TARGET_PAGE_MASK   ({ assert(target_page.decided); \
> -                                (target_long)target_page.mask; })
> -# else
> -#  define TARGET_PAGE_BITS   target_page.bits
> -#  define TARGET_PAGE_MASK   ((target_long)target_page.mask)
> -# endif
> -# define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
> -#else
> -# define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
> -# define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
> -# define TARGET_PAGE_MASK    ((target_long)-1 << TARGET_PAGE_BITS)
> -#endif
> -
> -#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
> +#include "exec/target_page.h"
>   
>   CPUArchState *cpu_copy(CPUArchState *env);
>   
> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index f4283f693a..ce43a12965 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -44,11 +44,6 @@
>   #pragma GCC poison TARGET_FMT_ld
>   #pragma GCC poison TARGET_FMT_lu
>   
> -#pragma GCC poison TARGET_PAGE_SIZE
> -#pragma GCC poison TARGET_PAGE_MASK
> -#pragma GCC poison TARGET_PAGE_BITS
> -#pragma GCC poison TARGET_PAGE_ALIGN
> -
>   #pragma GCC poison CPU_INTERRUPT_HARD
>   #pragma GCC poison CPU_INTERRUPT_EXITTB
>   #pragma GCC poison CPU_INTERRUPT_HALT
> diff --git a/include/exec/target_page.h b/include/exec/target_page.h
> index 98ffbb5c23..8e89e5cbe6 100644
> --- a/include/exec/target_page.h
> +++ b/include/exec/target_page.h
> @@ -14,10 +14,56 @@
>   #ifndef EXEC_TARGET_PAGE_H
>   #define EXEC_TARGET_PAGE_H
>   
> -size_t qemu_target_page_size(void);
> -int qemu_target_page_mask(void);
> -int qemu_target_page_bits(void);
> -int qemu_target_page_bits_min(void);
> -
> -size_t qemu_target_pages_to_MiB(size_t pages);
> +/*
> + * If compiling per-target, get the real values.
> + * For generic code, reuse the mechanism for variable page size.
> + */
> +#ifdef COMPILING_PER_TARGET
> +#include "cpu-param.h"
> +#include "exec/target_long.h"
> +#define TARGET_PAGE_TYPE  target_long
> +#else
> +#define TARGET_PAGE_BITS_VARY
> +#define TARGET_PAGE_TYPE  int
> +#endif
> +
> +#ifdef TARGET_PAGE_BITS_VARY
> +# include "exec/page-vary.h"
> +extern const TargetPageBits target_page;
> +# ifdef CONFIG_DEBUG_TCG
> +#  define TARGET_PAGE_BITS   ({ assert(target_page.decided); \
> +                                target_page.bits; })
> +#  define TARGET_PAGE_MASK   ({ assert(target_page.decided); \
> +                                (TARGET_PAGE_TYPE)target_page.mask; })
> +# else
> +#  define TARGET_PAGE_BITS   target_page.bits
> +#  define TARGET_PAGE_MASK   ((TARGET_PAGE_TYPE)target_page.mask)
> +# endif
> +# define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
> +#else
> +# define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
> +# define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
> +# define TARGET_PAGE_MASK    ((TARGET_PAGE_TYPE)-1 << TARGET_PAGE_BITS)
> +#endif
> +
> +#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
> +
> +static inline size_t qemu_target_page_size(void)
> +{
> +    return TARGET_PAGE_SIZE;
> +}
> +
> +static inline int qemu_target_page_mask(void)
> +{
> +    return TARGET_PAGE_MASK;
> +}
> +
> +static inline int qemu_target_page_bits(void)
> +{
> +    return TARGET_PAGE_BITS;
> +}
> +
> +int qemu_target_page_bits_min(void);
> +size_t qemu_target_pages_to_MiB(size_t pages);
> +
>   #endif
> diff --git a/page-target.c b/page-target.c
> index 82211c8593..321e43d06f 100644
> --- a/page-target.c
> +++ b/page-target.c
> @@ -8,24 +8,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "exec/target_page.h"
> -#include "exec/cpu-defs.h"
> -#include "cpu.h"
> -#include "exec/cpu-all.h"
> -
> -size_t qemu_target_page_size(void)
> -{
> -    return TARGET_PAGE_SIZE;
> -}
> -
> -int qemu_target_page_mask(void)
> -{
> -    return TARGET_PAGE_MASK;
> -}
> -
> -int qemu_target_page_bits(void)
> -{
> -    return TARGET_PAGE_BITS;
> -}
>   
>   int qemu_target_page_bits_min(void)
>   {
> diff --git a/page-vary-target.c b/page-vary-target.c
> index 343b4adb95..1b4a9a10be 100644
> --- a/page-vary-target.c
> +++ b/page-vary-target.c
> @@ -37,5 +37,7 @@ void finalize_target_page_bits(void)
>   {
>   #ifdef TARGET_PAGE_BITS_VARY
>       finalize_target_page_bits_common(TARGET_PAGE_BITS_MIN);
> +#else
> +    finalize_target_page_bits_common(TARGET_PAGE_BITS);
>   #endif
>   }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


