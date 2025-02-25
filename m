Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70680C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 19:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn0wB-0002ML-MG; Tue, 25 Feb 2025 14:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn0w2-0002L7-7v
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:49:45 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn0vy-00020j-6p
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:49:41 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22185cddbffso2558385ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 11:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740512976; x=1741117776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LkkuvpjQv2Dcdin1ywf6MyyxzWOtF/gvlsWCxcoTZvs=;
 b=zuT0BCD/EPbxInmqxheb2SjAhtniXZKcCFMFOOYEaCt+pAjxOhu906oLm2i1FOJm8k
 c3p/sOdbalvx9C7nKic5RyayoL+e9vUpV5KDzG+XsbiZsL64Pn29zZB+A5JdkmOp6Nbw
 ZBB3yti/Ob9zRg0ks76oDeRE4xfasxtyBNelEGSa3vCsHGv7ayqOJMwGtJn5nr8jlDeJ
 ylRYryKEYGo0hfBxpGwVNVAu5whPn6h7sGzWGidVIkOiFxwZoVa0CFmRZC77mxPjjhzq
 oKJ3kDFou260Mo0aajNmZ2U6X2fKFobikwfekHDD4uL61GI1swAqtRWsztvtMACDC5cn
 Stzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740512976; x=1741117776;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LkkuvpjQv2Dcdin1ywf6MyyxzWOtF/gvlsWCxcoTZvs=;
 b=EOlTlPsXcZ1ojUoynhUD5/Dh/buXpyLpUXwjPOq+jDFxrYRqiMUcuh2xvd+DI/f0OD
 K+4BfKryeRUNp102LmzIYw9/KOPdJS7EpYR84LqM/MeYxetei9JM2Pc3gKvuWyHxSxLI
 APkp8jsUCZmoMlRMWF13hJhDmR2gfvxGaQqBgPqULSk7gbEZMOtwZcfVpnHLMc7KbHzy
 PeCBjisLLO8SAMocQCx3ec9lzqNInE0gdDEH5yUqgXMdAPqoy8iyOudgVeW44uoYnuuG
 8Wkn3GDvyjOtOFfUXwTGe+caj3T8jZSaqSPhO+adXnoqdUgmNEHlsJzeo6njeKTPEL3S
 HkpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+PxrQh4LG1IAEPGR4iNT4Ic+9e9sD0nw1Vzn3jLCgmeJT0GIM3BP5Sy2SpXcBXo3/vyO36mUm9kDB@nongnu.org
X-Gm-Message-State: AOJu0YxnYSsflnxyz6+b4icPKeN1dhrvXn59XqdTcbZsVLf5ex4rftnG
 MEDRXq5C1sIhOXxd86eHJ9IJrjRPzVZfmIaIyE/XdIHKB02neokb1MVQNN5zaRk=
X-Gm-Gg: ASbGnctdqc22lcqo3jSGHgbpAnilmjVZ74CIrhTRZM/vfUUJNPHHoe7qKmazjHz6Zpo
 Q2e8+5qHAhszx68wrXh6DlLbjSbkQd0lOjkUD4wszZX83/0iaIsSyMvGmsuavlDYM8MGmZhCBfl
 f7/vjnBS1URnRZ2YknByMDKXJv1qOyw9Bcbm6N9WoY/6cypMCW1vqc0oUw+2i2ktMMgzIYDCvJH
 yiRQOGnNY2fxZW4r9ZKqsjMk6bG3Wd3b1loQ/CYYQWvcEYRSa3lRskC+QegnPpxbkWvSGpRvRaD
 2lbq+3akKNPSOjb6yA0A02TTEQkX8Ao2FLkfv0Ty45GaeJrIKhGJY4bMiNajCP0vn4HIblzHgE1
 tSZ0l3IE=
X-Google-Smtp-Source: AGHT+IHfTJ6YdX0HQF5SLY9OBrUMFwUu9cN2YGRIJxBIkTfufdh9aXUV1wH4Q+te92rySppnLrmzsg==
X-Received: by 2002:a05:6a21:3d8d:b0:1f0:e2a9:fb2a with SMTP id
 adf61e73a8af0-1f0e2a9fb91mr12567840637.4.1740512976225; 
 Tue, 25 Feb 2025 11:49:36 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aeda8574dbasm1771308a12.42.2025.02.25.11.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 11:49:35 -0800 (PST)
Message-ID: <d033b2d7-a2b6-4ed8-ac46-85b52d46f8ea@linaro.org>
Date: Tue, 25 Feb 2025 11:49:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cputlb: introduce tlb_flush_other_cpu for reset use
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
 <20250225184628.3590671-4-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250225184628.3590671-4-alex.bennee@linaro.org>
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

On 2/25/25 10:46, Alex Bennée wrote:
> The commit 30933c4fb4 (tcg/cputlb: remove other-cpu capability from
> TLB flushing) introduced a regression that only shows up when
> --enable-debug-tcg is used. The main use case of tlb_flush outside of
> the current_cpu context is for handling reset and CPU creation. Rather
> than revert the commit introduce a new helper and tweak the
> documentation to make it clear where it should be used.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - appraently reset can come from both cpu context and outside
>    - add cpu_common_post_load fixes
> ---
>   include/exec/exec-all.h   | 20 ++++++++++++++++----
>   accel/tcg/cputlb.c        | 11 +++++++++++
>   accel/tcg/tcg-accel-ops.c |  2 +-
>   cpu-target.c              |  2 +-
>   target/i386/machine.c     |  2 +-
>   5 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index d9045c9ac4..cf030001ca 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -64,12 +64,24 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr);
>    * tlb_flush:
>    * @cpu: CPU whose TLB should be flushed
>    *
> - * Flush the entire TLB for the specified CPU. Most CPU architectures
> - * allow the implementation to drop entries from the TLB at any time
> - * so this is generally safe. If more selective flushing is required
> - * use one of the other functions for efficiency.
> + * Flush the entire TLB for the specified current CPU.
> + *
> + * Most CPU architectures allow the implementation to drop entries
> + * from the TLB at any time so this is generally safe. If more
> + * selective flushing is required use one of the other functions for
> + * efficiency.
>    */
>   void tlb_flush(CPUState *cpu);
> +/**
> + * tlb_flush_other_cpu:
> + * @cpu: CPU whose TLB should be flushed
> + *
> + * Flush the entire TLB for a specified CPU. For cross vCPU flushes
> + * you shuld be using a more selective function. This is really only
> + * used for flushing CPUs being reset from outside their current
> + * context.
> + */
> +void tlb_flush_other_cpu(CPUState *cpu);
>   /**
>    * tlb_flush_all_cpus_synced:
>    * @cpu: src CPU of the flush
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index ad158050a1..fc16a576f0 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -417,6 +417,17 @@ void tlb_flush(CPUState *cpu)
>       tlb_flush_by_mmuidx(cpu, ALL_MMUIDX_BITS);
>   }
>   
> +void tlb_flush_other_cpu(CPUState *cpu)
> +{
> +    if (qemu_cpu_is_self(cpu)) {
> +        tlb_flush(cpu);
> +    } else {
> +        async_run_on_cpu(cpu,
> +                         tlb_flush_by_mmuidx_async_work,
> +                         RUN_ON_CPU_HOST_INT(ALL_MMUIDX_BITS));
> +    }
> +}

I'm not convinced this is necessary.

> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 6e3f1fa92b..e85d317d34 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -85,7 +85,7 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
>   {
>       tcg_flush_jmp_cache(cpu);
>   
> -    tlb_flush(cpu);
> +    tlb_flush_other_cpu(cpu);
>   }

I would really like to believe that at this point, hold phase, the cpu is *not* running. 
Therefore it is safe to zero out the softmmu tlb data structures.

>   
>   /* mask must never be zero, except for A20 change call */
> diff --git a/cpu-target.c b/cpu-target.c
> index 667688332c..8eb1633c02 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -56,7 +56,7 @@ static int cpu_common_post_load(void *opaque, int version_id)
>       /* 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
>          version_id is increased. */
>       cpu->interrupt_request &= ~0x01;
> -    tlb_flush(cpu);
> +    tlb_flush_other_cpu(cpu);

Likewise, in post_load, the cpu is *not* running.

> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index d9d4f25d1a..e66f46758a 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -401,7 +401,7 @@ static int cpu_post_load(void *opaque, int version_id)
>           env->dr[7] = dr7 & ~(DR7_GLOBAL_BP_MASK | DR7_LOCAL_BP_MASK);
>           cpu_x86_update_dr7(env, dr7);
>       }
> -    tlb_flush(cs);
> +    tlb_flush_other_cpu(cs);
>       return 0;

Likewise.


r~

