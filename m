Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D539DC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyGT4-0002Gq-6i; Fri, 28 Mar 2025 16:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyGT2-0002G6-Ch
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:38:16 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyGSz-00048M-O0
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:38:15 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so435211666b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743194292; x=1743799092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d9EnVl9s2P+Lgj71AX5kjcQwbusZmnmuRhjjOzqDFzo=;
 b=RuiNN+ogZEGRTcMb5CrUX6aNTRDBgtVn530LojQNM5tA7U3iD6Sxs/AjYN3Gq0Q7U8
 ZeFG8Xks6NlZ60kjFk5sZesZrIXftk1YdKE3K7vStERDG5tGdEzkDrXZ/V0eYjKDuETg
 3AfKUNqgYP2pOFdWaERnhHkbo35g8juMCMm7f4Qs6t3AkKn47B6lMZK6DOIprgXBHe8d
 8LQvZSU4nFBZzkUVm3PjSrAwOUY8RYhmfbsVQBp915FFQjJ80/D+McJ1L1sicPhRrgVf
 cHbSJdk4jmbwJKWjYoHvEjdxMw/gabvZ9/mxWxc/2xE3E979JwkS9KQSakXt0r8RFOq7
 TYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743194292; x=1743799092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d9EnVl9s2P+Lgj71AX5kjcQwbusZmnmuRhjjOzqDFzo=;
 b=OjyD8X+hL8FKYDp/ztRiqxr6jS/xK2RVahcMzG69alzmewOAWsYlU6QrH0apEDiKaa
 8x1WAvd3mCDH/RMhaC2bIujuQLyVsc93yThlvVeVSXvJCwhOgP2FjUnx9tNfbH0jFdoi
 OvSQ99Dr1PD0M+rEqOdfy5+hwnsO0JB3gVTqjACVwCmBzyEFp5FEfGlkzQVW/1ybbbZ3
 oJjBXEU/CKQFWrVn3Aw+wcqmYMoDEhpLqTE5PfRggW3TtKy9gqw5olbVvayXU7I45MCZ
 6dPeYYFpu6jF82tSEA2kDqn5qBbbD0xz4q+FZGC7MNy4TbdjmALJ9CnBF70SM2B58G4m
 pnxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8wXzgoBpvP8MMzlNPmtHvwqYKFF14u3NapwR0yj9geIDFAKQisXIebWw39EZjUQ0524w+QZbJrht1@nongnu.org
X-Gm-Message-State: AOJu0YwuEljCkTKTx9GsEYgQAHZNMQ8Tpoel2xZQEPcO5h9tWOiWX1o9
 a/a7w/Bsza4ImWyBhEW3ePHqdXA77fgBtqviOpvwUh0+6so+Aa3R+33jPNzdJ2g=
X-Gm-Gg: ASbGncumi62UUtn376EhLiM22rEVwTWyif2H6W9Rq3haaQkIbjZrLeOiCkRnG/FSzxE
 qkf91ZZQFiJucb3RHuDCEGq5jGtYvRiemiSgMrk4KVizvzCd84F59Mk/CvzqEdlsJZ56/Gy3Q/N
 N0LKCf873iz1DrAIAZmLONWFWIkgIHrKitBRKuu5q8a6Odwfqp8Q+fGCZ8Grf6cONztx9aw5wI5
 /yTATB5atFQnKeJTvRubJsZx56EcPbGABhbK3vcpg/xiXt+r6EfMb0OD3F6+Zb5wn+iyxqVGRC9
 O0k2sX6W8S8mspeOvENq0Y8NcizjkGVF4LmHEID2Ri9OAb8buz5+1qvnhIQ=
X-Google-Smtp-Source: AGHT+IHKy/2GRH18TSCYz+M1c2A/Q5NKOKH3aSG2/XnfmsNyy6MhYB+RZxa4sECk/RyDX6W7qlv2bQ==
X-Received: by 2002:a17:907:97c9:b0:ac2:622f:39c1 with SMTP id
 a640c23a62f3a-ac738a27e47mr54843466b.22.1743194291779; 
 Fri, 28 Mar 2025 13:38:11 -0700 (PDT)
Received: from [10.154.28.14] ([193.32.126.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71967fdbbsm208513166b.135.2025.03.28.13.38.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:38:10 -0700 (PDT)
Message-ID: <4c16b4e5-c5b1-4c1e-9d5b-c94bafd0a6c9@linaro.org>
Date: Fri, 28 Mar 2025 13:38:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] page-vary: Restrict scope of TARGET_PAGE_BITS_MIN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250328200459.483089-1-richard.henderson@linaro.org>
 <20250328200459.483089-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250328200459.483089-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ej1-x636.google.com
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
> The only place we really need to know the minimum is within
> page-vary-target.c.  Rename the target/arm TARGET_PAGE_BITS_MIN
> to TARGE_PAGE_BITS_LEGACY to emphasize what it really means.
> Move the assertions related to minimum page size as well.
> 

s/TARGE_PAGE_BITS_LEGACY/TARGET_PAGE_BITS_LEGACY

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-defs.h    | 10 ++--------
>   include/exec/poison.h      |  1 +
>   include/exec/target_page.h |  1 -
>   include/qemu/osdep.h       |  6 ++++++
>   target/alpha/cpu-param.h   |  1 -
>   target/arm/cpu-param.h     |  3 +--
>   target/ppc/cpu-param.h     |  1 -
>   accel/tcg/cputlb.c         |  1 -
>   page-vary-target.c         | 39 +++++++++++++++++++++++++++++++++++---
>   9 files changed, 46 insertions(+), 17 deletions(-)
> 
> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index 9f955f53fd..e01acb7c90 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -34,14 +34,8 @@
>   #ifndef TARGET_VIRT_ADDR_SPACE_BITS
>   # error TARGET_VIRT_ADDR_SPACE_BITS must be defined in cpu-param.h
>   #endif
> -#ifndef TARGET_PAGE_BITS
> -# ifdef TARGET_PAGE_BITS_VARY
> -#  ifndef TARGET_PAGE_BITS_MIN
> -#   error TARGET_PAGE_BITS_MIN must be defined in cpu-param.h
> -#  endif
> -# else
> -#  error TARGET_PAGE_BITS must be defined in cpu-param.h
> -# endif
> +#if !defined(TARGET_PAGE_BITS) && !defined(TARGET_PAGE_BITS_VARY)
> +# error TARGET_PAGE_BITS must be defined in cpu-param.h
>   #endif
>   
>   #include "exec/target_long.h"
> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index 4180a5a489..c4f7ee22bf 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -44,6 +44,7 @@
>   #pragma GCC poison TARGET_FMT_lu
>   
>   #pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS
> +#pragma GCC poison TARGET_PAGE_BITS_LEGACY
>   
>   #pragma GCC poison CONFIG_ALPHA_DIS
>   #pragma GCC poison CONFIG_HPPA_DIS
> diff --git a/include/exec/target_page.h b/include/exec/target_page.h
> index e4bd7f7767..ca0ebbc8bb 100644
> --- a/include/exec/target_page.h
> +++ b/include/exec/target_page.h
> @@ -41,7 +41,6 @@ extern const TargetPageBits target_page;
>   # endif
>   # define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
>   #else
> -# define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
>   # define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
>   # define TARGET_PAGE_MASK    ((TARGET_PAGE_TYPE)-1 << TARGET_PAGE_BITS)
>   #endif
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 4397a90680..321a52d7f0 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -50,6 +50,12 @@
>    */
>   #pragma GCC poison TARGET_WORDS_BIGENDIAN
>   
> +/*
> + * TARGET_PAGE_BITS_MIN was repaced by TARGET_PAGE_BITS_LEGACY
> + * for system mode.  Prevent it from creeping back in.
> + */

s/repaced/replaced

> +#pragma GCC poison TARGET_PAGE_BITS_MIN
> +
>   #include "qemu/compiler.h"
>   
>   /* Older versions of C++ don't get definitions of various macros from
> diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
> index ff06e41497..63989e71c0 100644
> --- a/target/alpha/cpu-param.h
> +++ b/target/alpha/cpu-param.h
> @@ -18,7 +18,6 @@
>    * a 4k minimum to match x86 host, which can minimize emulation issues.
>    */
>   # define TARGET_PAGE_BITS_VARY
> -# define TARGET_PAGE_BITS_MIN 12
>   # define TARGET_VIRT_ADDR_SPACE_BITS  63
>   #else
>   # define TARGET_PAGE_BITS 13
> diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
> index 896b35bd6d..a7ae42d17d 100644
> --- a/target/arm/cpu-param.h
> +++ b/target/arm/cpu-param.h
> @@ -24,7 +24,6 @@
>   # else
>   /* Allow user-only to vary page size from 4k */
>   #  define TARGET_PAGE_BITS_VARY
> -#  define TARGET_PAGE_BITS_MIN  12
>   # endif
>   # else
>   #  define TARGET_PAGE_BITS 12
> @@ -35,7 +34,7 @@
>    * have to support 1K tiny pages.
>    */
>   # define TARGET_PAGE_BITS_VARY
> -# define TARGET_PAGE_BITS_MIN  10
> +# define TARGET_PAGE_BITS_LEGACY 10
>   #endif /* !CONFIG_USER_ONLY */
>   
>   /* ARM processors have a weak memory model */
> diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
> index 6c4525fdf3..553ad2f4c6 100644
> --- a/target/ppc/cpu-param.h
> +++ b/target/ppc/cpu-param.h
> @@ -33,7 +33,6 @@
>   #ifdef CONFIG_USER_ONLY
>   /* Allow user-only to vary page size from 4k */
>   # define TARGET_PAGE_BITS_VARY
> -# define TARGET_PAGE_BITS_MIN 12
>   #else
>   # define TARGET_PAGE_BITS 12
>   #endif
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 39314e86f3..0de46903dd 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -49,7 +49,6 @@
>   #endif
>   #include "tcg/tcg-ldst.h"
>   
> -QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS_MIN) - 1));
>   
>   /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
>   /* #define DEBUG_TLB */
> diff --git a/page-vary-target.c b/page-vary-target.c
> index 6251d948cf..d83f9a6a90 100644
> --- a/page-vary-target.c
> +++ b/page-vary-target.c
> @@ -23,19 +23,45 @@
>   #include "exec/page-vary.h"
>   #include "exec/target_page.h"
>   
> +
> +/*
> + * For system mode, the minimum comes from the number of bits
> + * required for maximum alignment (6) and the number of bits
> + * required for TLB_FLAGS_MASK (3).
> + *
> + * For user mode, TARGET_PAGE_BITS_VARY is a hack to allow the target
> + * page size to match the host page size.  Mostly, this reduces the
> + * ordinary target page size to run on a host with 4KiB pages (i.e. x86).
> + * There is no true minimum required by the implementation, but keep the
> + * same minimum as for system mode for sanity.
> + * See linux-user/mmap.c, mmap_h_lt_g and mmap_h_gt_g.
> + */
> +#define TARGET_PAGE_BITS__MIN 9
> +
> +#ifndef TARGET_PAGE_BITS_VARY
> +QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS__MIN);
> +#endif
> +
> +#ifndef CONFIG_USER_ONLY
> +#include "exec/tlb-flags.h"
> +
> +QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS__MIN) - 1));
> +
>   int migration_legacy_page_bits(void)
>   {
>   #ifdef TARGET_PAGE_BITS_VARY
> -    return TARGET_PAGE_BITS_MIN;
> +    QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS_LEGACY < TARGET_PAGE_BITS__MIN);
> +    return TARGET_PAGE_BITS_LEGACY;
>   #else
>       return TARGET_PAGE_BITS;
>   #endif
>   }
> +#endif
>   
>   bool set_preferred_target_page_bits(int bits)
>   {
> +    assert(bits >= TARGET_PAGE_BITS__MIN);
>   #ifdef TARGET_PAGE_BITS_VARY
> -    assert(bits >= TARGET_PAGE_BITS_MIN);
>       return set_preferred_target_page_bits_common(bits);
>   #else
>       return true;
> @@ -44,5 +70,12 @@ bool set_preferred_target_page_bits(int bits)
>   
>   void finalize_target_page_bits(void)
>   {
> -    finalize_target_page_bits_common(TARGET_PAGE_BITS_MIN);
> +#ifndef TARGET_PAGE_BITS_VARY
> +    finalize_target_page_bits_common(TARGET_PAGE_BITS);
> +#elif defined(CONFIG_USER_ONLY)
> +    assert(target_page.bits != 0);
> +    finalize_target_page_bits_common(target_page.bits);
> +#else
> +    finalize_target_page_bits_common(TARGET_PAGE_BITS_LEGACY);
> +#endif
>   }

Great!

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Any chance we would rename TARGET_PAGE_BITS__MIN? (MIN_ALL? ALL_MIN? 
ARCH_MIN? any other idea)
I know it's restricted to this file only, but the __ is surprising.

