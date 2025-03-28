Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE557C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyGEy-0006Cl-Al; Fri, 28 Mar 2025 16:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyGEw-0006C2-Lx
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:23:42 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyGEo-0002Li-W8
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:23:36 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso414347766b.3
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743193413; x=1743798213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1x6sHAMxZ1XBwLoRXFPjJEj7GHPCztnAuUyT2DMD0No=;
 b=SffkH1XnW+ZJ/8fSWQ7exkWXccxGc/Y+waJqa+4tT45d8cX6bVrC2+NlfX/ljYymlD
 ddGvCK6Fq5hjyCWsHwB2XBjeeRJwOTElgCXfq7oYcjV7cc8RUG8I8L2rsHc9H03NkKPS
 MjFORFiI7NGDo/C/JTkBVCNwNj0WSR+ePQlKxdOXWjndOGifGwjNipujunIeC19ybh02
 uCtagfFM0nhVFox3JSPyx2y6m5ECxW4q8Xb2yw9VAy/HH1DofcaXh6wNEue8cl/T/ihs
 dqvgmWrfRiWrWutLYb3+eiBQ2MCpKBFsxE+aScU0IbOyPb6v+aXPSHR0Jr7qtTchHz3h
 Am5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743193413; x=1743798213;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1x6sHAMxZ1XBwLoRXFPjJEj7GHPCztnAuUyT2DMD0No=;
 b=BaCGo6A2gZDg66ZmHllaajju/IFZ3X5xBvVnqxc5QH1qjXIwCseE0DkGfjfDVj+H8Q
 sf2TXZ+Qxk6FnP+NKDPyn35HkAT6BfV7Zm6vKUms7kPdIs6Q0CFZOww7/lWWvI7tRbpt
 7NS2EO2peuAIcYCAqqf3EyyrdDuFnaJTs7qX1KnqLm6nJdaE9poRBeJyxMIXKa7YZSJm
 kkIEyIRdChRgg88Md93/oJ6suxvi+DMVwPE8ntgk4xwx8vvM08fp6chNsl6CdIpyt+pQ
 1WSu0NLaqz83TY7Qoj5TSAqtWXem9FNEhzhIpKzEOY8/3lPw3Ht56lkN5sOVDW0WzgOp
 J3nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+1O+5SEKquxw03jYHutoZtSZ7blHuC0q9A/dP5F3MqLP7wWnrf0efRXVpl+JZBhHAu6Nu6Cr9dCAA@nongnu.org
X-Gm-Message-State: AOJu0YyppinJ1PEBA4JY6oIhxX7o+8MUSBqkZkp4uDRAOX3HE6/WGc5t
 16cSfj3eqMZ6k9ZiZRNd7ZYVJsaJT586DUkNVW2iYk+PzFjLmjdPINqLE3OD4Oo=
X-Gm-Gg: ASbGncthCuUjICi3X6qLZZtOOSET5IJ7A/vVSXY4RJ+VZE56ADfF4HD0SqB0ttGH00F
 URQ9H5nRc0qI0cboNRLZ8VyVslSrtkBZ8T0FFiZkbrh2dtW3aI+DtDZUHIcDYWkWPVO2qIyRDjW
 yjzlZlBKr4KyVxTAxVXK3PhcoMH7CTLQDmbxRTbpPP/VJbTdAo/wR8LHix3gmtkAoWprnocLaXV
 TTI5Ehfo/iiEfpTk+7hjsSJy9WxTTG8CIFSJiM4wf15spYTW92szcuUkT2VwbErLehEa2x2ROdb
 fPlSXf0u/2451rhXMjvgiS4W9kIANEWdutDt8SwgOU1kglsZ+pt8M2kfny8=
X-Google-Smtp-Source: AGHT+IHQatjWPyYQhyhT6ZhXoD/xJ8b2wXj5HBhqw0hybx1yz33nol90oWnUTxP+76Krm6DVK3NTTw==
X-Received: by 2002:a17:906:7955:b0:ac3:3e40:e183 with SMTP id
 a640c23a62f3a-ac738975d0bmr63510266b.3.1743193413019; 
 Fri, 28 Mar 2025 13:23:33 -0700 (PDT)
Received: from [10.154.28.14] ([193.32.126.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71961f8acsm209181366b.98.2025.03.28.13.23.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:23:32 -0700 (PDT)
Message-ID: <77796c03-cbe8-422b-bdd0-dcf94f80184c@linaro.org>
Date: Fri, 28 Mar 2025 13:23:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] include/exec: Redefine tlb-flags with absolute values
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250328200459.483089-1-richard.henderson@linaro.org>
 <20250328200459.483089-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250328200459.483089-8-richard.henderson@linaro.org>
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
> Don't base the values on TARGET_PAGE_BITS_MIN, but do verify
> that TLB_FLAGS_MASK does not overlap minimum page size.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/tlb-flags.h | 68 +++++++++++++++++++---------------------
>   accel/tcg/cputlb.c       |  2 ++
>   2 files changed, 34 insertions(+), 36 deletions(-)
> 
> diff --git a/include/exec/tlb-flags.h b/include/exec/tlb-flags.h
> index 54a6bae768..357e79095c 100644
> --- a/include/exec/tlb-flags.h
> +++ b/include/exec/tlb-flags.h
> @@ -19,54 +19,29 @@
>   #ifndef TLB_FLAGS_H
>   #define TLB_FLAGS_H
>   
> -#include "exec/cpu-defs.h"
> +/*
> + * Flags returned for lookup of a TLB virtual address.
> + */
>   
>   #ifdef CONFIG_USER_ONLY
>   
>   /*
> - * Allow some level of source compatibility with softmmu.  We do not
> - * support any of the more exotic features, so only invalid pages may
> - * be signaled by probe_access_flags().
> + * Allow some level of source compatibility with softmmu.
> + * Invalid is set when the page does not have requested permissions.
> + * MMIO is set when we want the target helper to use the functional
> + * interface for load/store so that plugins see the access.
>    */
> -#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
> -#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
> -#define TLB_WATCHPOINT      0
> +#define TLB_INVALID_MASK     (1 << 0)
> +#define TLB_MMIO             (1 << 1)
> +#define TLB_WATCHPOINT       0
>   
>   #else
>   
> -/*
> - * Flags stored in the low bits of the TLB virtual address.
> - * These are defined so that fast path ram access is all zeros.
> - * The flags all must be between TARGET_PAGE_BITS and
> - * maximum address alignment bit.
> - *
> - * Use TARGET_PAGE_BITS_MIN so that these bits are constant
> - * when TARGET_PAGE_BITS_VARY is in effect.
> - *
> - * The count, if not the placement of these bits is known
> - * to tcg/tcg-op-ldst.c, check_max_alignment().
> - */
> -/* Zero if TLB entry is valid.  */
> -#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
> -/*
> - * Set if TLB entry references a clean RAM page.  The iotlb entry will
> - * contain the page physical address.
> - */
> -#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
> -/* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
> -#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 3))
> -
> -/*
> - * Use this mask to check interception with an alignment mask
> - * in a TCG backend.
> - */
> -#define TLB_FLAGS_MASK \
> -    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_FORCE_SLOW)
> -
>   /*
>    * Flags stored in CPUTLBEntryFull.slow_flags[x].
>    * TLB_FORCE_SLOW must be set in CPUTLBEntry.addr_idx[x].
>    */
> +
>   /* Set if TLB entry requires byte swap.  */
>   #define TLB_BSWAP            (1 << 0)
>   /* Set if TLB entry contains a watchpoint.  */
> @@ -82,6 +57,27 @@
>       (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED | \
>        TLB_DISCARD_WRITE | TLB_MMIO)
>   
> +/*
> + * Flags stored in CPUTLBEntry.addr_idx[x].
> + * These must be above the largest alignment (64 bytes),
> + * and below the smallest page size (1024 bytes).
> + * This leaves bits [9:6] available for use.
> + */
> +
> +/* Zero if TLB entry is valid.  */
> +#define TLB_INVALID_MASK     (1 << 6)
> +/* Set if TLB entry references a clean RAM page.  */
> +#define TLB_NOTDIRTY         (1 << 7)
> +/* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
> +#define TLB_FORCE_SLOW       (1 << 8)
> +
> +/*
> + * Use this mask to check interception with an alignment mask
> + * in a TCG backend.
> + */
> +#define TLB_FLAGS_MASK \
> +    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_FORCE_SLOW)
> +
>   /* The two sets of flags must not overlap. */
>   QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
>   
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index a717f357d5..39314e86f3 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -49,6 +49,8 @@
>   #endif
>   #include "tcg/tcg-ldst.h"
>   
> +QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS_MIN) - 1));
> +
>   /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
>   /* #define DEBUG_TLB */
>   /* #define DEBUG_TLB_LOG */

Hurrah!

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Maybe we could define MEMOP_MAX_ALIGNMENT, reuse use that in 
check_max_alignment(), and add a compile time check here as well.

We can as well mention in a comment that all architectures now have the 
same placement for those flags, simplifying MMU management when we'll 
mix several architectures.

