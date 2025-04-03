Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CADC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 14:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0LxW-00027X-68; Thu, 03 Apr 2025 10:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0LxT-000275-S1
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 10:54:20 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0LxR-0004EM-WE
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 10:54:19 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2240b4de12bso15184095ad.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743692056; x=1744296856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qxDM+M6wzjleqC4S1XpefuRxhLcdFPawRl51YXMm+lw=;
 b=kmKCbohhU2jPmqYWb7lyWmPFoBca8bK6bqXSOwQ99C5RisDJLO0OagV2LYRgadr1zT
 hlFtHvBpJI2utU1lz96Eu7XdcmQBGo6e5EAOCEgC5RTpPEKxTelmZVc2EEmM9E60ibPc
 y7gu2x3TvLrxHFyhu2MDOQHGApaSdVxZmg55mXhk24XwpznfL+QiVo3iPVAFw2YoVgz7
 tdzIjpTjiPEZyTXf0zymHfe72r5YfgmvzFTILDaxsdsFWs/8edM0969V7wm9YNauUpB4
 gSZq5TZxndihLPWYqF9CVGb5lG8l0zRUYFG3mb5HCP/4HpDGgUU1hUUNEl4tXewXgi+s
 0Djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743692056; x=1744296856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qxDM+M6wzjleqC4S1XpefuRxhLcdFPawRl51YXMm+lw=;
 b=k6G6HsnMHIDReD68OcghxCClp83eg+keKIZkozS2SCqxr19VAYGxf57cHK6QbHh35q
 DFRs6ke0V84Jzy8XNZ4CSOkUOg9ZQHkCE9bh0HO9yTsiSkBIaVvdx84gS6zzv7ZQmgXS
 vBggTYN3tINM6DWj2t/vv0ydkBNsADunh1hfLBV9zC6ghRdG2QjYfJWvaI0VO0HBYdFG
 L9WUopFQ8iO6ZUSjctaHwM4c6/YHYMgYuVSdewSncj/8iildmFO9qiB/VfIko+pz3/QP
 JcsQ/ttPxvX/JocsRXPm0SE26iiU6K6qIVEG8sAO5zaqoTc20F65Yu9t8pUpqgd5luZv
 wbsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXVwXkkAcuMSR2aGXtcvqTKmMaU7exHOs1W2mrasNABeM5rcrnFj8XuEH1h6s3rExRRafOY9bNg8Uk@nongnu.org
X-Gm-Message-State: AOJu0YzGtnfOsZrK2lSUurvbLqFWQi8znCUb4SHKjmJejnBlVBCz4KYF
 jMjFg3dyfEd22sYRYk15jDx+oMkm8iew5tClViEpTal9CbqrfQ3Ay45TZvbXIB4=
X-Gm-Gg: ASbGncvokfRvtj2GRWREmp2gNfp9ycgYo1yOJSX3b6noyJ3vBSm3oh3C5nQKsrkUZQb
 mY+RVO6kcWnj0K02qTsDLDhZKwdtAhhR4uPt9IYMOhjnvOAcjT+xx/YhKJFBdHRYePrG8ontG9N
 rnUJO3FE/WiSaU9BQ3C6vuD5ZbPpRPjix+QWWPTj8mk9vMGONYTaheqeJ7RLOjUABg6xLTzWBtp
 +rDwFMymIMt/jPOAiI7xU4VpUH35QwUzw/+6lqAuz+xKP568F5TiCN0XNypw5f0TeVPZw+VeLGR
 NuDeF1CHVGSmpbC22BrVlj6nmY/tL1vuvZ1PeGi66xW/OUvf39+srXoDOsTV+ju2OD110wVDca0
 UNkJgMcs5
X-Google-Smtp-Source: AGHT+IH1XwC7zB+3kYaFD9gbrcYVKGQH/KZDgKpHksZPGcKTyUTZNicf7snNcN2AHwA1DzDC8g416A==
X-Received: by 2002:a17:902:da85:b0:21f:c67:a68a with SMTP id
 d9443c01a7336-22977d9af67mr35498665ad.31.1743692056509; 
 Thu, 03 Apr 2025 07:54:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785bfddfsm15505455ad.66.2025.04.03.07.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 07:54:16 -0700 (PDT)
Message-ID: <92e627b4-fd41-4382-afa8-438a409c903e@linaro.org>
Date: Thu, 3 Apr 2025 07:54:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 38/43] tcg: Move cpu_req_mo() macro to
 target-agnostic 'backend-ldst.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250402212319.58349-1-philmd@linaro.org>
 <20250402212319.58349-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250402212319.58349-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/2/25 14:23, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/backend-ldst.h    | 41 +++++++++++++++++++++++++++++++++++++
>   accel/tcg/internal-common.h | 27 ++++++++++++++++++++++++
>   accel/tcg/internal-target.h | 28 -------------------------
>   accel/tcg/cputlb.c          |  1 +
>   accel/tcg/user-exec.c       |  1 +
>   5 files changed, 70 insertions(+), 28 deletions(-)
>   create mode 100644 accel/tcg/backend-ldst.h
> 
> diff --git a/accel/tcg/backend-ldst.h b/accel/tcg/backend-ldst.h
> new file mode 100644
> index 00000000000..9c3a407a5af
> --- /dev/null
> +++ b/accel/tcg/backend-ldst.h
> @@ -0,0 +1,41 @@
> +/*
> + * Internal memory barrier helpers for QEMU (target agnostic)
> + *
> + *  Copyright (c) 2003 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef ACCEL_TCG_BACKEND_LDST_H
> +#define ACCEL_TCG_BACKEND_LDST_H
> +
> +#include "tcg-target-mo.h"
> +
> +/**
> + * tcg_req_mo:
> + * @guest_mo: Guest default memory order
> + * @type: TCGBar
> + *
> + * Filter @type to the barrier that is required for the guest
> + * memory ordering vs the host memory ordering.  A non-zero
> + * result indicates that some barrier is required.
> + */
> +#define tcg_req_mo(guest_mo, type) \
> +    ((type) & guest_mo & ~TCG_TARGET_DEFAULT_MO)
> +
> +/**
> + * cpu_req_mo:
> + * @cpu: CPUState
> + * @type: TCGBar
> + *
> + * If tcg_req_mo indicates a barrier for @type is required
> + * for the guest memory model, issue a host memory barrier.
> + */
> +#define cpu_req_mo(cpu, type)     \
> +    do {                          \
> +        if (tcg_req_mo(cpu->cc->tcg_ops->guest_default_memory_order, type)) { \
> +            smp_mb();             \
> +        }                         \
> +    } while (0)
> +
> +#endif
> diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
> index 2f00560d102..829ae9389d2 100644
> --- a/accel/tcg/internal-common.h
> +++ b/accel/tcg/internal-common.h
> @@ -108,4 +108,31 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
>       return get_page_addr_code_hostp(env, addr, NULL);
>   }
>   
> +/**
> + * tcg_req_mo:
> + * @guest_mo: Guest default memory order
> + * @type: TCGBar
> + *
> + * Filter @type to the barrier that is required for the guest
> + * memory ordering vs the host memory ordering.  A non-zero
> + * result indicates that some barrier is required.
> + */
> +#define tcg_req_mo(guest_mo, type) \
> +    ((type) & guest_mo & ~TCG_TARGET_DEFAULT_MO)
> +
> +/**
> + * cpu_req_mo:
> + * @cpu: CPUState
> + * @type: TCGBar
> + *
> + * If tcg_req_mo indicates a barrier for @type is required
> + * for the guest memory model, issue a host memory barrier.
> + */
> +#define cpu_req_mo(cpu, type)     \
> +    do {                          \
> +        if (tcg_req_mo(cpu->cc->tcg_ops->guest_default_memory_order, type)) { \
> +            smp_mb();             \
> +        }                         \
> +    } while (0)
> +
>   #endif

I assume you meant to remove this from here in v2.


r~

> diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
> index f5a3fd7e402..9a9cef31406 100644
> --- a/accel/tcg/internal-target.h
> +++ b/accel/tcg/internal-target.h
> @@ -13,7 +13,6 @@
>   #include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "tb-internal.h"
> -#include "tcg-target-mo.h"
>   #include "exec/mmap-lock.h"
>   
>   /*
> @@ -44,31 +43,4 @@ void page_table_config_init(void);
>   G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
>   #endif /* CONFIG_USER_ONLY */
>   
> -/**
> - * tcg_req_mo:
> - * @guest_mo: Guest default memory order
> - * @type: TCGBar
> - *
> - * Filter @type to the barrier that is required for the guest
> - * memory ordering vs the host memory ordering.  A non-zero
> - * result indicates that some barrier is required.
> - */
> -#define tcg_req_mo(guest_mo, type) \
> -    ((type) & guest_mo & ~TCG_TARGET_DEFAULT_MO)
> -
> -/**
> - * cpu_req_mo:
> - * @cpu: CPUState
> - * @type: TCGBar
> - *
> - * If tcg_req_mo indicates a barrier for @type is required
> - * for the guest memory model, issue a host memory barrier.
> - */
> -#define cpu_req_mo(cpu, type)     \
> -    do {                          \
> -        if (tcg_req_mo(cpu->cc->tcg_ops->guest_default_memory_order, type)) { \
> -            smp_mb();             \
> -        }                         \
> -    } while (0)
> -
>   #endif /* ACCEL_TCG_INTERNAL_H */
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 35b1ff03a51..d9fb68d7198 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -48,6 +48,7 @@
>   #include "qemu/plugin-memory.h"
>   #endif
>   #include "tcg/tcg-ldst.h"
> +#include "backend-ldst.h"
>   
>   
>   /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 3f4d6824460..5eef8e7f186 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -37,6 +37,7 @@
>   #include "qemu/int128.h"
>   #include "trace.h"
>   #include "tcg/tcg-ldst.h"
> +#include "backend-ldst.h"
>   #include "internal-common.h"
>   #include "internal-target.h"
>   #include "tb-internal.h"


