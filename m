Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027D1CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0hYF-00021y-0r; Mon, 22 Sep 2025 10:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0hYA-00021T-My
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:29:54 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0hY6-0008Hh-MV
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:29:54 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b55197907d1so2149334a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758551388; x=1759156188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gItZqtQLULgn9lMh+IRKCPmTNhZFZYZIx3SMzMK3PBg=;
 b=fZNrhydcpOnRd+Ub0Wwqee1yTqn+P9YkfUgO8TyDxT9/6s9hfkO0Ac1Dx6OKw73Zb6
 IO8xPNWMUWXR3O13oM/C1zrg+Z77+Z432wKxerA4BACC2/15gJ3mcK3DpfLkAvU8DB2N
 63khDZxtwjB3ft3QVNY2+AKjQBAfRvKzEUNbu59ix+NB5joCnYrLQqEw2JyqoLO3V1N+
 TkYtx4nJ/v3qoJJ/C/ZHTPS7Wxg94+ogWdYH3p5Hw6SNvx39k5Us9dxQtTkuj51QBwF6
 laYDaM5Ld9/YN3Sf1Gi0H6b9WoHucyNeJMjopn4ZmtoEENZMVWuvZq+vcq5xZ1IjgCSm
 Axlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758551388; x=1759156188;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gItZqtQLULgn9lMh+IRKCPmTNhZFZYZIx3SMzMK3PBg=;
 b=ni20uMKXZZ8EX+OZxo3pWJNHSngDVL9YI6tk/haMrisKngx23IZ7JUhXOASY5Nuv7Y
 yon4CkhhFu1flLk2plnQPZIkis+RpFUebyS7NNL0GZ4hrP9EMrFmEn+kLInY+FPE2cdO
 EECcJ297J2rsGcQYrT+UFikEQGjOOcX6tc3DX6iJpZe5aZ1T7oUyqNVdWIlNev55m+5T
 EaaKxOVt2hM8CBObfr1URtA+VsxzttDX9N2+4pr89PKqLVhzRe/TQt230CQ2s8Ye5xbX
 cQYnDPgk1jU52sLQ6hbtOH2hk7aDia7rx29311aqdOMAGhbNkly9r0O52DPq2yS03HKh
 pVmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCJmbjlFCEIMu7iaOZTXqS84jfdEN4i8HLvlCMFAba/CBmXbwjQPx24p1N75QGAL56oyghRUuRQyMC@nongnu.org
X-Gm-Message-State: AOJu0YzwizGLKLZ/CtBK+eX1PXfgqYSw+L2gJqZ/TRU0+GugLXRAlEsu
 w4uBSBTSPRkIadGDe4TpInMN03WY1IFv6EdV9pMXeESnRd8R+3lljuCHNWlbAfZFCPoSBuQ/Wv8
 vwfQw
X-Gm-Gg: ASbGnctRhfp/keRnBVe778vP0uq9pu9GrWlbgXG/rgNuMoZFh0IFyfpztiOEseIRaQq
 +vvpCzIBcGPKhCHyZ7UinaPVpN1K5FlKjQuKyYSJHiueVKCIFF7MDdxRbO103NtRQlAIxq8D4Gg
 yk4p4iIBJKbGPZW06uO8k1iDmvzYdcUUQ54le4+vdx6EHHv0DYR3I6PxZoz1tBDeweBNpuJ8+UB
 vaFj2PiyBkbIJkgP3w7OQ2CyfHM62SK726bxYVc+kny1PDZsH1xMYyA12i4FeITy2TCSW0KEAws
 CMbViWRVxjRcNjWfkYcaRq718WiuUfZwG17ARu8/tY1hz/900r4LhS6vDUDWr3C4D3GX0KDqWme
 85cOd78+ZTfAOnAV3BLOkxhssa4LXF8UtlBig
X-Google-Smtp-Source: AGHT+IHKNdcKIimnOfEJmUD6ORNAsdGWxlgYteD1t+OqoHdG6GyG8aaO1ikEK8NVYqViHIqz+natiw==
X-Received: by 2002:a17:903:4b04:b0:23f:f96d:7579 with SMTP id
 d9443c01a7336-269ba516bb2mr188629675ad.37.1758551388248; 
 Mon, 22 Sep 2025 07:29:48 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269800531c6sm135442465ad.14.2025.09.22.07.29.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 07:29:47 -0700 (PDT)
Message-ID: <e30ee507-9e75-44e6-a901-fa9562b1697e@linaro.org>
Date: Mon, 22 Sep 2025 07:29:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/loongarch: Set file tcg_cpu.c separate from
 cpu.c
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250922073400.1308169-1-maobibo@loongson.cn>
 <20250922073400.1308169-4-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250922073400.1308169-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 9/22/25 00:33, Bibo Mao wrote:
> Remove inline included with file tcg_cpu.c, and set it separate
> with file target/loongarch/cpu.c
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c               |  9 ---------
>   target/loongarch/tcg/meson.build     |  1 +
>   target/loongarch/tcg/tcg_cpu.c       | 13 ++++++++++++-
>   target/loongarch/tcg/tcg_loongarch.h |  1 +
>   4 files changed, 14 insertions(+), 10 deletions(-)

I think this should be squashed with patch 1.
The intermediate #include of tcg/tcg_cpu.c was odd.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 6eb8c3214a..b449ede56d 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -28,11 +28,6 @@
>   #ifdef CONFIG_KVM
>   #include <linux/kvm.h>
>   #endif
> -#ifdef CONFIG_TCG
> -#include "accel/tcg/cpu-ldst.h"
> -#include "accel/tcg/cpu-ops.h"
> -#include "tcg/tcg.h"
> -#endif
>   #include "tcg/tcg_loongarch.h"
>   
>   const char * const regnames[32] = {
> @@ -653,10 +648,6 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>       }
>   }
>   
> -#ifdef CONFIG_TCG
> -#include "tcg/tcg_cpu.c"
> -#endif /* CONFIG_TCG */
> -
>   #ifndef CONFIG_USER_ONLY
>   #include "hw/core/sysemu-cpu-ops.h"
>   
> diff --git a/target/loongarch/tcg/meson.build b/target/loongarch/tcg/meson.build
> index bdf34f9673..b7adfe46f1 100644
> --- a/target/loongarch/tcg/meson.build
> +++ b/target/loongarch/tcg/meson.build
> @@ -7,6 +7,7 @@ loongarch_ss.add([zlib, gen])
>   loongarch_ss.add(files(
>     'fpu_helper.c',
>     'op_helper.c',
> +  'tcg_cpu.c',
>     'translate.c',
>     'vec_helper.c',
>   ))
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index f09a695968..c7f49838e3 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -4,6 +4,17 @@
>    *
>    * Copyright (c) 2025 Loongson Technology Corporation Limited
>    */
> +#include "qemu/osdep.h"
> +#include "qemu/accel.h"
> +#include "qemu/error-report.h"
> +#include "qemu/log.h"
> +#include "accel/accel-cpu-target.h"
> +#include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/cpu-ops.h"
> +#include "exec/translation-block.h"
> +#include "exec/target_page.h"
> +#include "tcg_loongarch.h"
> +#include "internals.h"
>   
>   #ifndef CONFIG_USER_ONLY
>   static void loongarch_cpu_do_interrupt(CPUState *cs)
> @@ -232,7 +243,7 @@ static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
>       return MMU_DA_IDX;
>   }
>   
> -static const TCGCPUOps loongarch_tcg_ops = {
> +const TCGCPUOps loongarch_tcg_ops = {
>       .guest_default_memory_order = 0,
>       .mttcg_supported = true,
>   
> diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
> index 47702893e3..7fb627f2d6 100644
> --- a/target/loongarch/tcg/tcg_loongarch.h
> +++ b/target/loongarch/tcg/tcg_loongarch.h
> @@ -9,6 +9,7 @@
>   #include "cpu.h"
>   #include "cpu-mmu.h"
>   
> +extern const TCGCPUOps loongarch_tcg_ops;
>   void loongarch_csr_translate_init(void);
>   
>   bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,


