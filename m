Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8882C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 23:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqKx4-0002F0-7X; Thu, 06 Mar 2025 18:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqKx2-0002Er-Vg
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 18:48:29 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqKx1-0003BY-0v
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 18:48:28 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff6ae7667dso2435213a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 15:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741304904; x=1741909704; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bRqePB45GBZN7ZCafFyXPJdA45kXj2KqJmuQlAKgyVI=;
 b=ydctkEqFdCZ6Et9L3n9mObMnQNLgnvEnrmr0qQYhR8v8vfT8oeI7OAl5VNQw5k2ulw
 aimmzO04W9U/AfSAxZBt1V7xwDRRgDKbGr6fTqR5Ki7iqc0w5zKSxFPmnOeYHPAYE8wZ
 gRUCQfstGWTrN8MTkWlSbYCNlYtoaQLbvRVSZ6x90MkfDKudfvIfYCXoQ7m/1dGqsVIG
 lvQMoAPeCMMmFJPe/38MOILXutSkB30mz8I76OL0ngu99RFZwbmq66XT2Du4kcaMp13f
 IfqRnLgXB/g3TDwv/sXuMOM61U7Ry1brhMy3xxrrgOQ7LRkn0ySF6MaX3OxKcRQcdxgb
 XjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741304904; x=1741909704;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bRqePB45GBZN7ZCafFyXPJdA45kXj2KqJmuQlAKgyVI=;
 b=ENpyJkFkfsP5EtiXinkpNADveq4OnLccrdegkC+o2Uamy9lZFCvQx/TetvC5vggS3j
 7oM+J1HAR+M87vUr+VSB9oOtmy2NTOm6/EUuV7doWGkJzwTSLv2WKKfMH/f1lK855S2u
 xI/SMqdNYVPg1ts5wTArXYQttbZJq94GO9u7p8aItI7A/EAvyaGHttSboUAbrz9C/Vmv
 qJATxxKq7mU0S84aSO97czBfG5Hz0KPb2NNQ+eTOgkQZKs1/OG+Pt2IJVRA2o9GA+MXU
 2ZcM496VgUVU0nrif+sFlKFaQaCNJEMOGao05FdMcJx8spA70zX6xjewWtLL/dK/OSre
 wWKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWyK1cLbcrhcu/q7V5srcl0sz1yNgFvdY/Nk5tK5vu99cBAmg3cHlTKJxZmL3R/0I7h8PXedbVUO+b@nongnu.org
X-Gm-Message-State: AOJu0YytwKExhTunWm7xHykFwL1VE0z0zzIwgSoowRlGyFyq6hXH1nZj
 /ryfkAO0Sftr2lNC+Rbk+f0mF3V+eoQPXtIKzAM0SnlHTtCAWr6Abtded9EeqGs=
X-Gm-Gg: ASbGncu8Wqvqmj5usVADpbxjLI0HivU+DlJakk22GXvZ+7d94cqW5cqk+LFxD1R7vPa
 fHPtQ3NpNNRxsbFOd5kotzhZjRoZGqa+MPVpaSWeAg1ByLAKIACe7unbMi1b/oSTA2RprCdM+Og
 eaYTQ8dq8ilUGbOj1iZgR74dVLqzHuYPaInLmBuATAL3PNrk3WHQyDtsWQjadKexfBqCaIVAqY/
 0/h+WUshDYjGO9bj/adxaSfdjvLxLdEUKih8TUJM4zkYLrW//tBGYMSq0R+439wuC/4c+Usomv/
 wI5tndxA1uanZARGe4XH9xYyakQ8NHv+BbmkUMRiVcz0WTVC2wPt4n1QqpnDZ/P85ZAIEaMpOa5
 tdvaIaFrz
X-Google-Smtp-Source: AGHT+IEagHWqJTlY3DlGElqcxzUFTX0pRGOgK963Lb1LCbReHEWvS1IyxbEFKtYAszTrOwJk+OYKNg==
X-Received: by 2002:a17:90b:380e:b0:2f2:a664:df1a with SMTP id
 98e67ed59e1d1-2ff7ce594ccmr1990723a91.2.1741304904499; 
 Thu, 06 Mar 2025 15:48:24 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693739ecsm2060406a91.26.2025.03.06.15.48.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 15:48:23 -0800 (PST)
Message-ID: <a69053d3-83e7-4f25-9b41-92648b474376@linaro.org>
Date: Thu, 6 Mar 2025 15:48:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Restrict CPU_TLB_DYN_*_BITS definitions to
 accel/tcg/
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250305191859.71608-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250305191859.71608-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 3/5/25 11:18, Philippe Mathieu-Daudé wrote:
> CPU_TLB_DYN_*_BITS definitions are only used by accel/tcg/cputlb.c
> and accel/tcg/translate-all.c. Move them to accel/tcg/tb-internal.h.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tb-internal.h | 27 +++++++++++++++++++++++++++
>   include/exec/cpu-defs.h | 26 --------------------------
>   2 files changed, 27 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
> index 90be61f296a..abd423fcf58 100644
> --- a/accel/tcg/tb-internal.h
> +++ b/accel/tcg/tb-internal.h
> @@ -13,6 +13,33 @@
>   #include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   
> +#ifdef CONFIG_SOFTMMU
> +
> +#define CPU_TLB_DYN_MIN_BITS 6
> +#define CPU_TLB_DYN_DEFAULT_BITS 8
> +
> +# if HOST_LONG_BITS == 32
> +/* Make sure we do not require a double-word shift for the TLB load */
> +#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
> +# else /* HOST_LONG_BITS == 64 */
> +/*
> + * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
> + * 2**34 == 16G of address space. This is roughly what one would expect a
> + * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
> + * Skylake's Level-2 STLB has 16 1G entries.
> + * Also, make sure we do not size the TLB past the guest's address space.
> + */
> +#  ifdef TARGET_PAGE_BITS_VARY
> +#   define CPU_TLB_DYN_MAX_BITS                                  \
> +    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
> +#  else
> +#   define CPU_TLB_DYN_MAX_BITS                                  \
> +    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
> +#  endif
> +# endif
> +
> +#endif /* CONFIG_SOFTMMU */
> +
>   #ifdef CONFIG_USER_ONLY
>   #include "user/page-protection.h"
>   /*
> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index ae18398fa99..9f955f53fde 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -46,30 +46,4 @@
>   
>   #include "exec/target_long.h"
>   
> -#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
> -#define CPU_TLB_DYN_MIN_BITS 6
> -#define CPU_TLB_DYN_DEFAULT_BITS 8
> -
> -# if HOST_LONG_BITS == 32
> -/* Make sure we do not require a double-word shift for the TLB load */
> -#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
> -# else /* HOST_LONG_BITS == 64 */
> -/*
> - * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
> - * 2**34 == 16G of address space. This is roughly what one would expect a
> - * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
> - * Skylake's Level-2 STLB has 16 1G entries.
> - * Also, make sure we do not size the TLB past the guest's address space.
> - */
> -#  ifdef TARGET_PAGE_BITS_VARY
> -#   define CPU_TLB_DYN_MAX_BITS                                  \
> -    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
> -#  else
> -#   define CPU_TLB_DYN_MAX_BITS                                  \
> -    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
> -#  endif
> -# endif
> -
> -#endif /* CONFIG_SOFTMMU && CONFIG_TCG */
> -
>   #endif


