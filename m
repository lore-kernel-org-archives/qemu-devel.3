Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FA6C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 11:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzwFL-0004bL-OU; Wed, 02 Apr 2025 07:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzwFI-0004b2-Je
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 07:27:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzwFG-00088G-Ux
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 07:27:00 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso43474105e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 04:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743593216; x=1744198016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=exwzt5Cxt3d77Pf9jsdg6r4vvhKTKMZ8rWGz2yPAl3c=;
 b=iCKmFgAxaJrw8oLeYvIHtBFqVu2S7Aj9XTxXniLJOLP64yoN0AQ4sqCYorX2kHDZgS
 o2dNZS3K7yWH33iJ3ld5J7PhTkfW65A0KkhhFVUYo6M1sIG1ghy2QVq/vSySaJ9iLx/c
 mjDG5qxXbT470gEboTaYCyvTmJzXXNHgU0qMIb3AtKvMbA9NFpg6xHfOINcOzpS2hRdL
 sJ7FiMV88LPOkTpWvSQBAaB19P2LGMc8vyJD4OrCkaqJ4Y1WA5U/bUd1BF586WYQE0oA
 I+JV+aR2EjZkNjcLQIYReCcswK7uK7pPbQqi1eNN4CA3/0/+Z6Hcmiqw5eEx589t8X+q
 sNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743593216; x=1744198016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=exwzt5Cxt3d77Pf9jsdg6r4vvhKTKMZ8rWGz2yPAl3c=;
 b=cx/OASrZVsIUNcz8dU75Ty+rLLxe+G07/VLp+YOzr+ZOfddidFRNx00qCTC8vxNLdJ
 Y0dmwl9nRRb4SFD79d4e05ozk8tUyBxIYgOINJR9ATUHQt/Wj3/ROjXUSMltii1J3j+z
 XL/8E0YHNkVOUaSWl8zSipzk52F0gebB4yITrPkeApBDXxhuN3x7uulr14H9qgauiuYP
 6UeBVKlkbwqJL7PTvU+uNiKSaG5ILs2OlF4DhQXo43960GMIeiTAP4a2N4VS4zkZH4Dq
 024a21o+i5T5erC0j9z/KrauwpQJTp384IqXVuUkW/Uz6yOaWaesO0dISvXSHilAWMJq
 WqBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXPzHjx4xim5mPvWVgEw94/ombGo5glh3P0NefhWGyxtvRK2u1cZmDto1fAP1C90VcNK/WoxLSMcpL@nongnu.org
X-Gm-Message-State: AOJu0YwZFCCymqkW+qkoZy7hoYp1yzLbRJCZdo7RAngj8fyHML6ZyVVU
 XP/lt1ZEhIpxMhgy6Jp8J1Hi6vSzj/GokO+DI+Esj88m1gYgJTghBt9yGX22UQ8=
X-Gm-Gg: ASbGncu7/hXxmwReDBf5DYgqyHYDTGfej9OZjfm4/QtzoRYQLRJN4CFKcmJsFM1z+Na
 +4KrKjufIXtEbYzs3gjCwTqMdEVvrlID5bgIM4q3FfeB3XXOoNdgrux3rUk+DqZIZ3qfsLzvh7b
 siWTt5eJE/XRbqWJI66nd9KB8I5m4YNbTGjff+WUJfp2Mfg/Ac1s4/NjyRU33oCBX3XRdbBdrgx
 3ucqyTzlcv5sgGQ3JLLpWdshrMPCfq3FzUIjowtIPXwOkHcFdl6AlwbzhIzgMx0ZCIVnwVebuua
 j2AmDavCCVVzB0IieC7Ux+Dwb2fV1YGE5DNV36wrOz6g4mBLA8TtHjvI6Em+vjGdqzcH1dhM7aA
 5vAFmEXriIE06
X-Google-Smtp-Source: AGHT+IEKcqCUyp2DKh4ii+cbAd+S7xQoEbdhDwkvSSGQQ+6NLoGjnYg7Wi3jnDHWXM5Q9M5e4S75Xw==
X-Received: by 2002:a05:600c:8705:b0:43d:2313:7b4a with SMTP id
 5b1f17b1804b1-43db61b33b9mr186376655e9.3.1743593216527; 
 Wed, 02 Apr 2025 04:26:56 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb5fd144csm17581165e9.15.2025.04.02.04.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 04:26:55 -0700 (PDT)
Message-ID: <7fbd71b6-8642-4374-a573-c9cc693e381c@linaro.org>
Date: Wed, 2 Apr 2025 13:26:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/42] include/exec: Split out cpu-mmu-index.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250318213209.2579218-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi Richard,

On 18/3/25 22:31, Richard Henderson wrote:
> The implementation of cpu_mmu_index was split between cpu-common.h
> and cpu-all.h, depending on CONFIG_USER_ONLY.  We already have the
> plumbing common to user and system mode.  Using MMU_USER_IDX
> requires the cpu.h for a specific target, and so is restricted to
> when we're compiling per-target.
> 
> Include the new header only where needed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h        |  6 ------
>   include/exec/cpu-common.h     | 20 ------------------
>   include/exec/cpu-mmu-index.h  | 39 +++++++++++++++++++++++++++++++++++
>   include/exec/cpu_ldst.h       |  1 +
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
>   16 files changed, 54 insertions(+), 26 deletions(-)
>   create mode 100644 include/exec/cpu-mmu-index.h


> diff --git a/include/exec/cpu-mmu-index.h b/include/exec/cpu-mmu-index.h
> new file mode 100644
> index 0000000000..b46e622048
> --- /dev/null
> +++ b/include/exec/cpu-mmu-index.h
> @@ -0,0 +1,39 @@
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
> +#include "tcg/debug-assert.h"
> +#ifdef COMPILING_PER_TARGET
> +#include "cpu.h"

IIUC we only need "cpu.h" on user emulation. Maybe use:

   #if defined(COMPILING_PER_TARGET) && defined(CONFIG_USER_ONLY)

?

> +#endif
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
> +#ifdef COMPILING_PER_TARGET
> +# ifdef CONFIG_USER_ONLY
> +    return MMU_USER_IDX;
> +# endif
> +#endif
> +
> +    int ret = cs->cc->mmu_index(cs, ifetch);
> +    tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
> +    return ret;
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


