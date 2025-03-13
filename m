Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5848BC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspc6-0008BY-7h; Thu, 13 Mar 2025 16:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspc4-0008BE-Fa
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:57:08 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspc2-0005jk-Jj
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:57:08 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so39415185ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899425; x=1742504225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oG/F8jh6PSifR/9oRP4zx2fIrXD6o6WfXqa4TEXdTM0=;
 b=Xn5ciR/SDyvnrGstN5Kb5t4seSSSMAJ16RIPWKHkqj8m91tBYfMjCdqf0ZWBAgvpXB
 HWDzBEoIVQM1MzXH5XGLSZCpPErHu1RV7fTh63Dn70BUt5I00FZMcD+MYHWbw6yeZq6S
 T8Ruw9B0z/CKN2a4sA/x3oA2bCmtvh7EssWjr+FVjOu+nstJfg7Sf9/y16o/sNZL48VQ
 f95dDW2YBHeHkB6yW3y2Z7NBqGJBzgQqqXU6sfe6l+6ilY44H2kFBks0q+GKp8yqZ+G5
 ZYbVEKm+mO9RNQgBxiSieLRMIwBEawG/86TJ6/WL+p6AIdMyCsOgafxBZJAL1Upoycnu
 KQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899425; x=1742504225;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oG/F8jh6PSifR/9oRP4zx2fIrXD6o6WfXqa4TEXdTM0=;
 b=K9QBTzXhfxBFqm1eAutQKL4KAgGduYNUwz4YGS2HOQmkn/BP53xoPWGq+oA2GQKlH1
 qPI2YsUdcvmgvrb3NvFagec54Fuxsk/B8Qbvg1LJcw9GNfx7Bc5ezNqlTEkUj8ynycYf
 zWeGhFGXJ2Fsb9Yly3BZK96Gnbl2cyR6w9YxKgIFiRv3wWLm2/eMxEl3sOoAMKvH4/79
 8yc6b/AYtqaSVzbHwXbX5v+voYKr/PFt1jMz3VYH8JAbKOpfsI+cTYpO9IIsXPx3tro1
 cofVLcIlbGF07KTbLj7cHG/4Ybyv+4ZgmhC0Qv0nvhZyaP0o6x0GTyuROBK0gys9d/IG
 eiWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLqokMWP21Vr2hcbZ1mq8s9xO85eG6x5wjefjhRaut+avub1+sjsT29gTrpWx+Krlz55UfIpX3/eHC@nongnu.org
X-Gm-Message-State: AOJu0YyShRO3IVV8ZpAZrc+A4it7GBPTfyQRa/prsZxvIH9xAUE8fxBp
 8kX3XmX/dR43VihOrrrh1hJUKpFl0+ZD4vK1XUFpMAKWWrFNLifpQAAbq2R0xss=
X-Gm-Gg: ASbGnct+UIlVp/lKS/+PHck+YLL9a+d4ZT3zfWW6SYAPJnhoEbIoiasNUQk0yChBRZA
 791GwqS0IPv/7vsr1ELQIGglBfr46RoGcS3DnAagOH/2JJSuk7t0xQAzSXc7J5b8b8p21ybvFR4
 KEWWpi8lyhyVhS6nGVTtgxwQiF361J7aBTPtxAJxdiCj+6A99QLLIb10oXuIQBAML6dFGa5hpOk
 pGW/BbHjOb43NjblxzPejuh867SN9yfItphB40qn1dpLkmLz+arRcK+n+hPdYLEnI48RvqwKKg/
 SQjGSkjNC/dRgR3pwx8MIU+BBKcLj8cI6r8TQSmo+Y7sZmgaI52riEH8AA==
X-Google-Smtp-Source: AGHT+IEEoIIJIXFzckUZ8T5jenSlNDA82rXVZl5QjRBsgm1hQRmDTvP43GTpbPoZZPZMFfMKUmCFMg==
X-Received: by 2002:a17:902:d482:b0:224:1219:934b with SMTP id
 d9443c01a7336-225e0b298eemr265425ad.50.1741899425067; 
 Thu, 13 Mar 2025 13:57:05 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbc666sm17945545ad.159.2025.03.13.13.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:57:04 -0700 (PDT)
Message-ID: <5fe840b6-3e18-4ef5-b649-0acc6a8838ea@linaro.org>
Date: Thu, 13 Mar 2025 13:57:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/37] common-user: Split out watchpoint-stub.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-26-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/12/25 20:45, Richard Henderson wrote:
> Uninline the user-only stubs from hw/core/cpu.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h         | 23 -----------------------
>   common-user/watchpoint-stub.c | 28 ++++++++++++++++++++++++++++
>   common-user/meson.build       |  1 +
>   3 files changed, 29 insertions(+), 23 deletions(-)
>   create mode 100644 common-user/watchpoint-stub.c
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 5d11d26556..2fdb115b19 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1109,35 +1109,12 @@ static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
>       return false;
>   }
>   
> -#if defined(CONFIG_USER_ONLY)
> -static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
> -                                        int flags, CPUWatchpoint **watchpoint)
> -{
> -    return -ENOSYS;
> -}
> -
> -static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
> -                                        vaddr len, int flags)
> -{
> -    return -ENOSYS;
> -}
> -
> -static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
> -                                                CPUWatchpoint *wp)
> -{
> -}
> -
> -static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
> -{
> -}
> -#else
>   int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
>                             int flags, CPUWatchpoint **watchpoint);
>   int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
>                             vaddr len, int flags);
>   void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
>   void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
> -#endif
>   
>   /**
>    * cpu_get_address_space:
> diff --git a/common-user/watchpoint-stub.c b/common-user/watchpoint-stub.c
> new file mode 100644
> index 0000000000..2489fca4f3
> --- /dev/null
> +++ b/common-user/watchpoint-stub.c
> @@ -0,0 +1,28 @@
> +/*
> + * CPU watchpoint stubs
> + *
> + * Copyright (c) 2003 Fabrice Bellard
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/cpu.h"
> +
> +int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
> +                          int flags, CPUWatchpoint **watchpoint)
> +{
> +    return -ENOSYS;
> +}
> +
> +int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len, int flags)
> +{
> +    return -ENOSYS;
> +}
> +
> +void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *wp)
> +{
> +}
> +
> +void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
> +{
> +}
> diff --git a/common-user/meson.build b/common-user/meson.build
> index ac9de5b9e3..4dba482863 100644
> --- a/common-user/meson.build
> +++ b/common-user/meson.build
> @@ -7,4 +7,5 @@ common_user_inc += include_directories('host/' / host_arch)
>   user_ss.add(files(
>     'safe-syscall.S',
>     'safe-syscall-error.c',
> +  'watchpoint-stub.c',
>   ))

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


