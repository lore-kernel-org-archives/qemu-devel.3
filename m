Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5E9EE499C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 18:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soSB1-0007oh-Uw; Wed, 11 Sep 2024 14:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soSB0-0007lP-7p
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 14:34:50 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soSAy-0001dE-Cu
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 14:34:49 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-718a3b8a2dcso58725b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726079686; x=1726684486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V/i1ZmdbBPVABSZUyZVnrQX5i9t6t3Pqe9fosEVLpAQ=;
 b=QadkbaWjA3eU8J9+D4mPodPb0bxpyVDopPpqLDYZcnj4zqNaSlQ/Nx428SUE6OBV8l
 bc9kKAHUNJMVZL+mw9jnVVNj4Zv01WXSt6i4WXVleB/ZSiKHOgxOymTlM4bB5jeRd74f
 piroieGGcJHuhZlklF1XwQuB3WiD9hXWOg9zkWOcpeqiKG2qAMo3ZzzVdPE6k5h7W8Si
 X33tzngVTEegWKUXtm2rs7b9abDnOMAl+LEf5LqviEMX1fQSkN5CX94WiMVXO1GurFa5
 kDNuwspQ7Xi3JUeoSngu6B2Awt3D00WGIsAi8p9TPydMCNgpEzA0E0h7f0xiqA3893Ck
 K8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726079686; x=1726684486;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V/i1ZmdbBPVABSZUyZVnrQX5i9t6t3Pqe9fosEVLpAQ=;
 b=OkhOdDuZvEWC+rRzfOUzQCKNLU2D1p0la066jg0vWuh72zkHf8vlwrzMQIyKxeRT/A
 272UH/F15sb3eiT0peJkAG8Obc4pbC+LVvlG/lA70aEgyRRqyW/pr4BI8tZCHG2y0TG3
 1BAHZFBN+j9uda/KdO5FB569YHWXNNKyvH5xevGlFC8xFghs0cxV95KekNLYMUOz6UFq
 6LznxkK8jcMH/4hPEW2Aa5kenv1p/AocXTKZ/9V9YjjpIqtspkN8i1D++nZCQ2NJZEci
 SeB5YZRiVRYOz4plcMIWcKv2XMn5Uz4opMMUuIkORiJVHl6Rjc0PwN7/LakLUjucw8+e
 TGeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuJGqvg3oN1Y66WPWSSii7HL1GRLs8ykkTdHecdQLz2HZ+QkHnm52LrUHkSJdtW9dtGS+qcGDiloEU@nongnu.org
X-Gm-Message-State: AOJu0YxUeEdRxqRIGI/QFkCYupcm+k2DENlIg1a41HoSoaObrfy3/72c
 xFeTebty9lPPIRy7nCmukJUXBpe2BbNjusIJFZ8CctjKODwDJhc8Uo6TadiuRsU=
X-Google-Smtp-Source: AGHT+IGajp8aZVwL8m5oszWUNBp0KLEB0+FGuPqFCsFm4usYUvTDYtmSbDMlEi3YqN1GyhRKHnTYDg==
X-Received: by 2002:aa7:8894:0:b0:706:284f:6a68 with SMTP id
 d2e1a72fcca58-719262289demr354020b3a.23.1726079685829; 
 Wed, 11 Sep 2024 11:34:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe665fsm3280763b3a.83.2024.09.11.11.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 11:34:45 -0700 (PDT)
Message-ID: <6c97e5d3-75a9-4884-8a6f-6498dfc5b12d@linaro.org>
Date: Wed, 11 Sep 2024 11:34:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] util: Add RISC-V vector extension probe in
 cpuinfo
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
 <20240911132630.461-2-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240911132630.461-2-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 9/11/24 06:26, LIU Zhiwei wrote:
> While the compiler doesn't support RISCV_HWPROBE_EXT_ZVE64X,
> we use RISCV_HWPROBE_IMA_V instead.

Language is incorrect here.  The compiler has nothing to do with it.
Perhaps "If the installed kernel header files do not support...".

However, if you use only RISCV_HWPROBE_IMA_V, then you do not have any of the additional 
guarantees of Zve64x.

The kernel api for RISCV_HWPROBE_EXT_ZVE64X was introduced in 6.10.
If that is acceptable as a minimum, the simplest solution is

#ifndef RISCV_HWPROBE_EXT_ZVE64X
#define RISCV_HWPROBE_EXT_ZVE64X        (1ULL << 39)
#endif

If the running kernel is old, then the bit will not be set and we will not attempt to use RVV.

If we need to support older kernels, then we'll have to go back to probing with vsetvl to 
determine if all of the additional guarantees of Zve64x are met.


r~


> 
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   host/include/riscv/host/cpuinfo.h |  2 ++
>   util/cpuinfo-riscv.c              | 24 ++++++++++++++++++++++--
>   2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/host/include/riscv/host/cpuinfo.h b/host/include/riscv/host/cpuinfo.h
> index 2b00660e36..cdc784e7b6 100644
> --- a/host/include/riscv/host/cpuinfo.h
> +++ b/host/include/riscv/host/cpuinfo.h
> @@ -10,9 +10,11 @@
>   #define CPUINFO_ZBA             (1u << 1)
>   #define CPUINFO_ZBB             (1u << 2)
>   #define CPUINFO_ZICOND          (1u << 3)
> +#define CPUINFO_ZVE64X          (1u << 4)
>   
>   /* Initialized with a constructor. */
>   extern unsigned cpuinfo;
> +extern unsigned riscv_lg2_vlenb;
>   
>   /*
>    * We cannot rely on constructor ordering, so other constructors must
> diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
> index 497ce12680..bab782745b 100644
> --- a/util/cpuinfo-riscv.c
> +++ b/util/cpuinfo-riscv.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/host-utils.h"
>   #include "host/cpuinfo.h"
>   
>   #ifdef CONFIG_ASM_HWPROBE_H
> @@ -12,6 +13,7 @@
>   #endif
>   
>   unsigned cpuinfo;
> +unsigned riscv_lg2_vlenb;
>   static volatile sig_atomic_t got_sigill;
>   
>   static void sigill_handler(int signo, siginfo_t *si, void *data)
> @@ -33,7 +35,7 @@ static void sigill_handler(int signo, siginfo_t *si, void *data)
>   /* Called both as constructor and (possibly) via other constructors. */
>   unsigned __attribute__((constructor)) cpuinfo_init(void)
>   {
> -    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND;
> +    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND | CPUINFO_ZVE64X;
>       unsigned info = cpuinfo;
>   
>       if (info) {
> @@ -49,6 +51,9 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>   #endif
>   #if defined(__riscv_arch_test) && defined(__riscv_zicond)
>       info |= CPUINFO_ZICOND;
> +#endif
> +#if defined(__riscv_arch_test) && defined(__riscv_zve64x)
> +    info |= CPUINFO_ZVE64X;
>   #endif
>       left &= ~info;
>   
> @@ -64,7 +69,8 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>               && pair.key >= 0) {
>               info |= pair.value & RISCV_HWPROBE_EXT_ZBA ? CPUINFO_ZBA : 0;
>               info |= pair.value & RISCV_HWPROBE_EXT_ZBB ? CPUINFO_ZBB : 0;
> -            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB);
> +            info |= pair.value & RISCV_HWPROBE_IMA_V ? CPUINFO_ZVE64X : 0;
> +            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZVE64X);
>   #ifdef RISCV_HWPROBE_EXT_ZICOND
>               info |= pair.value & RISCV_HWPROBE_EXT_ZICOND ? CPUINFO_ZICOND : 0;
>               left &= ~CPUINFO_ZICOND;
> @@ -112,6 +118,20 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>           assert(left == 0);
>       }
>   
> +    if (info & CPUINFO_ZVE64X) {
> +        /*
> +         * We are guaranteed by RVV-1.0 that VLEN is a power of 2.
> +         * We are guaranteed by Zve64x that VLEN >= 64, and that
> +         * EEW of {8,16,32,64} are supported.
> +         *
> +         * Cache VLEN in a convenient form.
> +         */
> +        unsigned long vlenb;
> +        /* Read csr "vlenb" with "csrr %0, vlenb" : "=r"(vlenb) */
> +        asm volatile(".insn i 0x73, 0x2, %0, zero, -990" : "=r"(vlenb));
> +        riscv_lg2_vlenb = ctz32(vlenb);
> +    }
> +
>       info |= CPUINFO_ALWAYS;
>       cpuinfo = info;
>       return info;


