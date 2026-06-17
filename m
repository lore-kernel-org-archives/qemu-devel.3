Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4938ACD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZuFi-0001xT-Kz; Wed, 17 Jun 2026 13:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZuFc-0001ww-Jq
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:40:32 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZuFa-0006AS-DR
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:40:32 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2c0c1e0d00bso918665ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781718029; x=1782322829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UwxtA9br3csfxKC7JIJGabh7qk5/h8UQp5sFR3C2XQE=;
 b=E3CJoudql0fmQDIISm5zcYNRCEL+k7jQGiBgtMTEOG4jCc4L/54iAZgCo8Zkuk5ump
 k7PFRzSFxf1QMKeSPVsb84q9iF4GjIKdEZDY+K7+MKvcD/XuIvaf7VzuPvAsiL+GaKVQ
 eY7vUMN+t5kvrIvxbXfgVETYHPKV12Qii1d3zYsQKM484Q7jZbZU6SjolgsEFXCzlGea
 RudVRS9dSxsS1cDbxTmCpOQ2RpetJ4DWSC652NsDvKLPErtSDbpE941d1qxf78eTM7PW
 u7Ewll+qpZPT7gg1p/3yb0HpzKxxLNNMsjleiyWrQaZT+RJ5DLbF5F0M6XvT5m7slpNK
 hE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781718029; x=1782322829;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UwxtA9br3csfxKC7JIJGabh7qk5/h8UQp5sFR3C2XQE=;
 b=flicZu64qXRER6cQo7xmBmPUS3k2XX9cELlNWNaF1WC7zdr6PNQ3tnbtZJvO100QuS
 53JdsMfIzgFzb7qcL4X0N/bPO+2vQujZSUSVZGGZnmPwA6Dif0Jg4b4yIKBC0h8Bf4Aj
 7ETAfvkk6qO0CdCNuTTVr9CY3KFPKQW/PxRifImj7sdC7CVjl0ydNZT5i/sGADuZq/Bq
 Sro8nCFLg6nzktsDUF/rMaA3lh122C0PXDicNs4FJV0ImMCZzObPzkmoPkg1dagCavLN
 8LgDi0r3KIk/AJKxkvA2chAh3Dmb7HbZjyvOTnCuXoYtxSn/PP/rY/7/sw1sHzjzOykX
 2fnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/QObeVfBHMLplXzuAtrTDbmIr7elIIOy2w/JTMzGPygU6WLPx1zMFNzIqSRqZJzVDINOiCoBubrpWE@nongnu.org
X-Gm-Message-State: AOJu0YyHqQOVDEIvsAjM8zf35sDzmPUw+UnX3sMSECw7O+CRh5+y8gVc
 qVQohWLcGTW7DmjB1XvXunGvekyG3iFzApyz5liBx/ZVTtSmlGyjNjBaR4yB65IM3yA=
X-Gm-Gg: AfdE7cmO6oJKMIa3R5ZHap4IqUba71vmOaXmlFgtN+wIJODSuD64OdbGkSptukkR/fQ
 Mi9mUnh3F2LOvpzgG8h6OFoc73QxV43pR9D3lgPgvGd6Cyity2vOhx/599ROehdsBOnTBHdwzfr
 Zj9lwctKDgw0hK729mVDCSmFTdmQOHtkv+uJ5o6pn22miZfYtMOjvWocekjPFWUGE4csF4indid
 x2hdzg2ZZ/L7j1D6S13YOJoQsfcsLkxFh9xpdoOaqZsKre2zMXqgkE28GWW1fmHKRKSVJ/XkbHx
 QkQT1aj0UMDlIz6IO7zkRVidNJKzKA1VTKle+IOmGD18S3A8md6bQfGqhthHDdZNCEe0enT3MRX
 oik9UjZBBN74eFKcr7fMjw6COg7s6MQ18opVGH6sxOMQfuPq7nOWbTd7Cx79RNI2j6yIkzJEOV5
 BicCSOyoBxD0hvbjUTK/2fudxK3qxm2g/f7tJcNKmT8q7wiD2X5aqLJsOF+A==
X-Received: by 2002:a17:903:2f82:b0:2c0:cf44:3b3b with SMTP id
 d9443c01a7336-2c6bc20b7e5mr46778555ad.24.1781718028607; 
 Wed, 17 Jun 2026 10:40:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c433558449sm178154875ad.78.2026.06.17.10.40.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 10:40:28 -0700 (PDT)
Message-ID: <1f8e7a36-e236-4849-8882-476c749beb93@linaro.org>
Date: Wed, 17 Jun 2026 10:40:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] accel/tcg: Move cpu_loop_exit_requested() out of
 'exec/cpu-common.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260617171438.75914-1-philmd@oss.qualcomm.com>
 <20260617171438.75914-10-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260617171438.75914-10-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/17/26 10:14, Philippe Mathieu-Daudé wrote:
> cpu_loop_exit_requested() is part of the TCG cpu-loop API,
> defined in "accel/tcg/cpu-loop.h". Ideally we'd move it
> declaration there, but it is defined inlined and access
> CPUState internal fields, itself defined in "hw/core/cpu.h".
> Since keeping it inlined in the 3 call sites is important,
> move the definition to "hw/core/cpu.h" and call it a day.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/exec/cpu-common.h     | 19 -------------------
>   include/hw/core/cpu.h         | 20 ++++++++++++++++++++
>   target/arm/tcg/helper-a64.c   |  1 +
>   target/s390x/tcg/mem_helper.c |  1 +
>   4 files changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 9919ffb1838..aedd60a6986 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -62,25 +62,6 @@ void cpu_destroy_address_spaces(CPUState *cpu);
>   void list_cpus(void);
>   
>   #ifdef CONFIG_TCG
> -#include "qemu/atomic.h"
> -
> -/**
> - * cpu_loop_exit_requested:
> - * @cpu: The CPU state to be tested
> - *
> - * Indicate if somebody asked for a return of the CPU to the main loop
> - * (e.g., via cpu_exit() or cpu_interrupt()).
> - *
> - * This is helpful for architectures that support interruptible
> - * instructions. After writing back all state to registers/memory, this
> - * call can be used to check if it makes sense to return to the main loop
> - * or to continue executing the interruptible instruction.
> - */
> -static inline bool cpu_loop_exit_requested(const CPUState *cpu)
> -{
> -    return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
> -}
> -
>   G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
>   G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
>   G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 72666189774..eaf30d13e8e 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -612,6 +612,26 @@ static inline CPUTLBDescFast *cpu_tlb_fast(CPUState *cpu, int mmu_idx)
>   {
>       return &cpu->neg.tlb.f[mmuidx_to_fast_index(mmu_idx)];
>   }
> +
> +#include "qemu/atomic.h"

We already use qatomic_load_acquire within this header (without including atomic.h).
Just put the include properly at the top of the file.

> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index a0f9215f1c9..cdac560d086 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -43,6 +43,7 @@
>   #include "user/page-protection.h"
>   #endif
>   #include "vec_internal.h"
> +#include "hw/core/cpu.h">
>   #define HELPER_H "tcg/helper-a64-defs.h"
>   #include "exec/helper-info.c.inc"
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
> index 8474a694110..bfe0208324c 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -43,6 +43,7 @@
>   #include "hw/core/boards.h"
>   #include "system/memory.h"
>   #endif
> +#include "hw/core/cpu.h"
>   
>   #ifdef CONFIG_USER_ONLY
>   # define user_or_likely(X)    true

Do we honestly need these?  This *must* have been done by target/arch/cpu.h.


r~


