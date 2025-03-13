Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD71C35FF1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspdP-00017z-Hq; Thu, 13 Mar 2025 16:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspdL-00013x-OP
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:58:28 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspdJ-0005tv-AM
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:58:27 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff4a4f901fso2474664a91.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899504; x=1742504304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qx7vcx6H110v3PixwjHurXDVVxdp6sM2X452A8B9s/0=;
 b=agc49WrYYhCXFs2K3NoNu3xt91C7DQ+SwBhccWtFrzMvJRJ1ePWjZ2ZXdbSl9peobN
 mTuX1TbzsOkyazovEZtxNsKiK9OLsbZ8rE50b5e6ZbwmGgNBZyyLGKxGF16cuh2BKNnd
 hfhI2FjIabE5srtrF3T32+ua+ba1O3jRiKbqu5XishYpy3ceWzXQiSxjOB47hj3LkpKV
 rF0mRh8p7m+YfViN0xGh+R83rKGMEuG3M0Yplvo9HYTwwYrQCDKCshD8fV+fgJjMvAYV
 +e8HWBiq2LJrpXtUzCjbt1x43KvfP7MjQlgbWqUBTA/Hi5TukRGspovE4eaGXOYqfzJ0
 be7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899504; x=1742504304;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qx7vcx6H110v3PixwjHurXDVVxdp6sM2X452A8B9s/0=;
 b=OXA1tbMPQGEF9p/DTeWVLB39LQBJt3Xc0GnrPO3i0C91Gdw0KZIPmfRqycmJx6pbfb
 GnXatCAEDeDO6bFmmlgG/90LYinBiObA/IzhhUNalBgjceUru7ks4p3QZxPtISaduXkU
 JSRZ/cT2dNmFypPaZUziea+kP84CWwsTiL0Y2wE2zpscOxJhkNJCDLicXMYnqt36iNDK
 tByfBmrJM2hu8AaAsYfBSomjJWZVTfGqfoZonHHLg1tibAMSGrMJSjbqnWzL2SJjDQeh
 QzEAZksEHrDsQhhCYjrnyrC3sFGhdi5nQRuqdqfxH2iekU5LLAflc+pWOO0aQ6O9RDt3
 8q0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5O/g/9Rbshs3gBVmmuMQZ64RhnD8IQ/JFLsau+9g+kfSTevRL2p0WxH4fbqliHjxFzIYO4sObdeZQ@nongnu.org
X-Gm-Message-State: AOJu0YzsPDTQIIlQozVJ+3AxSR6KHN+dPvpiak4USqr6CJKq4MeZQTU9
 +8aeQYE6qrjo8/BXdBAes5laVCzYzePBStwlHli4SIyTPKqBiXhGwm5ymIqceVY=
X-Gm-Gg: ASbGncutSZBwuLIyCI5LeiGv9zNcuZpNcs962xZea1fi4CSi/tX2h8tZnVAE3Ai87r2
 KhKOoSoLSM0I7Ag3y6SDQ1d5eGN+1CFJ+EPtyuAUW4TmTWGJF7oAOLFrlmTFj4vnLg2FPKGbxIv
 FvHB6U0nbIgyM18QNBESyHa17nR7Kr4hkFrpEaZ2DAzWIZrGZfLt+q5/skuwdo+8cMpSOlo9nGr
 bOaeDg5hM7ccGj12HBAHmDsCrfqCtcA93vhu6UNlXs/anPF77m4xhGFg4bQ19QAb0CEINrYwNj6
 6TlvnwIpjxuXwoTAm3hEGUL2UxWWeb5SoTz34lpT6CQOZRGkD5x+kUr5TA==
X-Google-Smtp-Source: AGHT+IGyfhURU64x/Wqa8iMYctEN/Ww0VcvL/ohl7RDUptDkR0agVLb5wAXixNsWiWKgVS54mJ0UWQ==
X-Received: by 2002:a17:90b:1f8c:b0:2ff:698d:ef7c with SMTP id
 98e67ed59e1d1-300ff3701e6mr16325350a91.29.1741899503847; 
 Thu, 13 Mar 2025 13:58:23 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3011824b98dsm4327623a91.27.2025.03.13.13.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:58:23 -0700 (PDT)
Message-ID: <859c7d86-f405-411a-8b8f-0e00ccff82fb@linaro.org>
Date: Thu, 13 Mar 2025 13:58:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/37] include/exec: Split out cpu-mmu-index.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-30-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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
> The implementation of cpu_mmu_index was split between
> cpu-common.h and cpu-all.h, depending on CONFIG_USER_ONLY.
> Unify within a new header and include only where needed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h        |  6 ------
>   include/exec/cpu-common.h     | 20 --------------------
>   include/exec/cpu-mmu-index.h  | 33 +++++++++++++++++++++++++++++++++
>   include/exec/cpu_ldst.h       |  1 +
>   accel/tcg/translator.c        |  1 +
>   semihosting/uaccess.c         |  1 +
>   target/arm/gdbstub64.c        |  3 +++
>   target/hppa/mem_helper.c      |  1 +
>   target/i386/tcg/translate.c   |  1 +
>   target/loongarch/cpu_helper.c |  1 +
>   target/microblaze/helper.c    |  1 +
>   target/microblaze/mmu.c       |  1 +
>   target/openrisc/translate.c   |  1 +
>   target/sparc/cpu.c            |  1 +
>   target/sparc/mmu_helper.c     |  1 +
>   target/tricore/helper.c       |  1 +
>   target/xtensa/mmu_helper.c    |  1 +
>   17 files changed, 49 insertions(+), 26 deletions(-)
>   create mode 100644 include/exec/cpu-mmu-index.h
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index d72c28a5d2..e62a9a4c79 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -113,8 +113,6 @@ CPUArchState *cpu_copy(CPUArchState *env);
>   
>   #ifdef CONFIG_USER_ONLY
>   
> -static inline int cpu_mmu_index(CPUState *cs, bool ifetch);
> -
>   /*
>    * Allow some level of source compatibility with softmmu.  We do not
>    * support any of the more exotic features, so only invalid pages may
> @@ -124,10 +122,6 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch);
>   #define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
>   #define TLB_WATCHPOINT      0
>   
> -static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
> -{
> -    return MMU_USER_IDX;
> -}
>   #else
>   
>   /*
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 3771b2130c..be032e1a49 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -272,24 +272,4 @@ static inline CPUState *env_cpu(CPUArchState *env)
>       return (CPUState *)env_cpu_const(env);
>   }
>   
> -#ifndef CONFIG_USER_ONLY
> -/**
> - * cpu_mmu_index:
> - * @env: The cpu environment
> - * @ifetch: True for code access, false for data access.
> - *
> - * Return the core mmu index for the current translation regime.
> - * This function is used by generic TCG code paths.
> - *
> - * The user-only version of this function is inline in cpu-all.h,
> - * where it always returns MMU_USER_IDX.
> - */
> -static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
> -{
> -    int ret = cs->cc->mmu_index(cs, ifetch);
> -    tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
> -    return ret;
> -}
> -#endif /* !CONFIG_USER_ONLY */
> -
>   #endif /* CPU_COMMON_H */
> diff --git a/include/exec/cpu-mmu-index.h b/include/exec/cpu-mmu-index.h
> new file mode 100644
> index 0000000000..8a8dc4b162
> --- /dev/null
> +++ b/include/exec/cpu-mmu-index.h
> @@ -0,0 +1,33 @@
> +/*
> + * cpu_mmu_index()
> + *
> + *  Copyright (c) 2003 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: LGPL-2.1+
> + */
> +
> +#ifndef EXEC_CPU_MMU_INDEX_H
> +#define EXEC_CPU_MMU_INDEX_H
> +
> +#include "hw/core/cpu.h"
> +
> +/**
> + * cpu_mmu_index:
> + * @env: The cpu environment
> + * @ifetch: True for code access, false for data access.
> + *
> + * Return the core mmu index for the current translation regime.
> + * This function is used by generic TCG code paths.
> + */
> +static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return MMU_USER_IDX;
> +#else
> +    int ret = cs->cc->mmu_index(cs, ifetch);
> +    tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
> +    return ret;
> +#endif
> +}
> +
> +#endif /* EXEC_CPU_MMU_INDEX_H */
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 92b4cf20fd..82e67eff68 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -67,6 +67,7 @@
>   #endif
>   
>   #include "exec/cpu-ldst-common.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/abi_ptr.h"
>   
>   #if defined(CONFIG_USER_ONLY)
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 405e0b44c4..49e1a64000 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -13,6 +13,7 @@
>   #include "qemu/error-report.h"
>   #include "exec/exec-all.h"
>   #include "exec/cpu-ldst-common.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/translator.h"
>   #include "exec/plugin-gen.h"
>   #include "tcg/tcg-op-common.h"
> diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
> index 382a366ce3..a957891166 100644
> --- a/semihosting/uaccess.c
> +++ b/semihosting/uaccess.c
> @@ -9,6 +9,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "exec/cpu-all.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/exec-all.h"
>   #include "semihosting/uaccess.h"
>   
> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> index 1a4dbec567..a9d8352b76 100644
> --- a/target/arm/gdbstub64.c
> +++ b/target/arm/gdbstub64.c
> @@ -27,6 +27,9 @@
>   #include <sys/prctl.h>
>   #include "mte_user_helper.h"
>   #endif
> +#ifdef CONFIG_TCG
> +#include "exec/cpu-mmu-index.h"
> +#endif
>   
>   int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>   {
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index fb1d93ef1f..510786518d 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -22,6 +22,7 @@
>   #include "cpu.h"
>   #include "exec/exec-all.h"
>   #include "exec/cputlb.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/page-protection.h"
>   #include "exec/helper-proto.h"
>   #include "hw/core/cpu.h"
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index a8935f487a..20a5c69795 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -20,6 +20,7 @@
>   
>   #include "qemu/host-utils.h"
>   #include "cpu.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "tcg/tcg-op.h"
> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
> index 930466ca48..8662fb36ed 100644
> --- a/target/loongarch/cpu_helper.c
> +++ b/target/loongarch/cpu_helper.c
> @@ -8,6 +8,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "internals.h"
>   #include "cpu-csr.h"
>   
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index 27fc929bee..996514ffe8 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -21,6 +21,7 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "exec/cputlb.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/page-protection.h"
>   #include "qemu/host-utils.h"
>   #include "exec/log.h"
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index f8587d5ac4..987ac9e3a7 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -22,6 +22,7 @@
>   #include "qemu/log.h"
>   #include "cpu.h"
>   #include "exec/cputlb.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/page-protection.h"
>   
>   static unsigned int tlb_decode_size(unsigned int f)
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index 7a6af183ae..5b437959ac 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -20,6 +20,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/exec-all.h"
>   #include "tcg/tcg-op.h"
>   #include "qemu/log.h"
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 5716120117..1bf00407af 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -22,6 +22,7 @@
>   #include "cpu.h"
>   #include "qemu/module.h"
>   #include "qemu/qemu-print.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "hw/qdev-properties.h"
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index 7548d01777..4a0cedd9e2 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -21,6 +21,7 @@
>   #include "qemu/log.h"
>   #include "cpu.h"
>   #include "exec/cputlb.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/page-protection.h"
>   #include "qemu/qemu-print.h"
>   #include "trace.h"
> diff --git a/target/tricore/helper.c b/target/tricore/helper.c
> index a64412e6bd..be3d97af78 100644
> --- a/target/tricore/helper.c
> +++ b/target/tricore/helper.c
> @@ -20,6 +20,7 @@
>   #include "hw/registerfields.h"
>   #include "cpu.h"
>   #include "exec/cputlb.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/page-protection.h"
>   #include "fpu/softfloat-helpers.h"
>   #include "qemu/qemu-print.h"
> diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
> index 63be741a42..96140c89c7 100644
> --- a/target/xtensa/mmu_helper.c
> +++ b/target/xtensa/mmu_helper.c
> @@ -33,6 +33,7 @@
>   #include "exec/helper-proto.h"
>   #include "qemu/host-utils.h"
>   #include "exec/cputlb.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


