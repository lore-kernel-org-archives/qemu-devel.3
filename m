Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA113CCA472
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yQo-0001gH-Oo; Wed, 01 Oct 2025 11:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yQi-0001ad-5K
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:07:44 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yPV-0000ix-N9
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:07:42 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-279e2554b5fso9774355ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331180; x=1759935980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hSyuB+zquHrxue8iAHxOXVu7rZELFV4qzCL0Y+t5BaM=;
 b=USgTtUSaiybehab/BQhpuwbGSfaEVrlYfxDXbqlS5kn1NuXThM86DWEcNkKuzGXnhk
 I5HmksvMiUA3gfEXJsSDRoSEcH8fvTPJauwDcHlXcYEFBP+QIDPAwTLPW/teezD1Vfxk
 9HuhOmSUDifdYJSCNMVb1gHHETaFtA7ARlNw+DbPDO0PIshr2SFNX+re6yf2fM+BrcAi
 RHX1mc+DqLekQn/jK3s51sEwoKte8OAZ+FvcwahOUFsaLDppKc7VlnwK7+bmg4OCUUtY
 qHRDiUd4hJvuIq6ci7/lWoUMMG+iZ1Gfm5bmUNjWB5dlvZ2Jresi1W+GvHqDwJGevfXJ
 uWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331180; x=1759935980;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hSyuB+zquHrxue8iAHxOXVu7rZELFV4qzCL0Y+t5BaM=;
 b=B/T8oOn0ftj1mD0E1np+Hg6Kpn7vepZwocwJ9ZqDJHWdP+D8UUz6NeM+o3ggK9krwI
 9G0QTY171xloMaBTw29pzkUumjqApyPxyn7RzI8gTME+ZY41Gl1ZHtKs5ReVQdz1MAYX
 Eqmh7dS3o3uZHcuMcrGWAMFJaBRGW4u/jKPWQpok7dHLPlSORTj+J013tmNM2z4CNZmP
 +q6PKs078wYeBdawNGejltxXcN3fuWoM1EDWUgJAFBzR2RnfhHvEJX9vTKODUl+NtZON
 NgQVzszjHIrllpgcQbIkou8g1ZanSslEB8HxfR08rWq9HfSIAbP7hJwrEHtnCmcb8zr3
 3MDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHhCigEtSeY5j6YWwfn4etZE0ZgvpUhSgcxn0+oXLVaMOMHl3RzPfG8dF7OcSSg1XOyvDmdKQVNIZm@nongnu.org
X-Gm-Message-State: AOJu0Yxy1/yPcViFK6MY0OHhDbPVjFqhRYiGWKhNrFQ7Y2+pGHc0MxgM
 FIOTZFAyBRmSK6dhDKVVH5vrZyy4VJXTx/ldm1n43cKNxbAekwC7IGdP2aw9j+W5SE4=
X-Gm-Gg: ASbGnctjzREtKYBmLLeGhJZHW+Ym2d/D2CCdk+9Sgn1d7BCnU7/bglTEQu6jc+Fcbky
 LgaOMrmc/akXRT4mF/SQYie2z1qt8Yg5SGCQG9+6WEul1x6k+EbIMqLS4hIDuKDlwY9C9dwhERu
 hLIhTdLIfHhT55fTW5s/5s4he+FQZbXepoH3BVUWUEknWLjK0nfsnnFuu0bczEO/PxRNe/1z4Hj
 GGsWymS6luMHeqrKyz8/Odzsu86R2xOmivFCk5/v5IeVV8bHmKCjgsV1aWxGeqZj2xj/i6a17BV
 qmdhT0DURYsG17eKh9/LKg1RgbrgPzSdP2K1u7Nxm6LcqJcxvgCHXByaGdOXss3DchKoc9qDXOM
 prEsCH4nglSYtz0Z4kmRyloWHL6egozX9/E751O6Xr/KuZJE6zgkdlVPRO65rhiVmjv+0dSNMts
 uIje6QJ4Zq4aUTEsiqNQTQKja/ZuXMiqU=
X-Google-Smtp-Source: AGHT+IFKY861LwRjSuvG+phhirbBUopsKVAqpKL7J2ACR7lHVwYNe8Au3lRjJc1dMqyfBfoMCrpEsA==
X-Received: by 2002:a17:903:37cd:b0:271:6af4:17c with SMTP id
 d9443c01a7336-28d16d64cb6mr87624325ad.1.1759331180072; 
 Wed, 01 Oct 2025 08:06:20 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed66cdd76sm190398835ad.4.2025.10.01.08.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 08:06:19 -0700 (PDT)
Message-ID: <aa09afd3-b897-42ec-817f-c4a30d090a00@linaro.org>
Date: Wed, 1 Oct 2025 08:06:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/25] accel/tcg: Rename @start argument of
 tlb_reset_dirty*()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> Generally we want to clarify terminology and avoid confusions,
> prefering @start with (exclusive) @end, and base @addr with
> @length (for inclusive range).
> 
> Here as tlb_reset_dirty() and tlb_reset_dirty_range_all()
> operate on a range, rename @start as @addr.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cputlb.h | 4 ++--
>   accel/tcg/cputlb.c    | 6 +++---
>   system/physmem.c      | 8 ++++----
>   3 files changed, 9 insertions(+), 9 deletions(-)

Eh.  I suppose.

What we *really* want is to abolish both end and length.  They both lead to the silliness 
that is system/memory.h using Int128 for ranges.  Both end and length allow an empty 
range, which we don't actually need, but do not allow a range covering the entire 2**64.

We should be using first/last, where first==last is a 1 byte inclusive range, and first==0 
&& last==UINT64_MAX is the entire 2**64.

I'm not sure where you're going with this other than swapping names.


r~

> 
> diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
> index db7cbf97826..995fe31ef75 100644
> --- a/include/exec/cputlb.h
> +++ b/include/exec/cputlb.h
> @@ -32,8 +32,8 @@ void tlb_unprotect_code(ram_addr_t ram_addr);
>   
>   #ifndef CONFIG_USER_ONLY
>   /* Called with rcu_read_lock held. */
> -void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length);
> -void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
> +void tlb_reset_dirty(CPUState *cpu, uintptr_t addr, uintptr_t length);
> +void tlb_reset_dirty_range_all(ram_addr_t addr, ram_addr_t length);
>   #endif
>   
>   /**
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 2a6aa01c57c..6807328df82 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -916,7 +916,7 @@ static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
>    * We must take tlb_c.lock to avoid racing with another vCPU update. The only
>    * thing actually updated is the target TLB entry ->addr_write flags.
>    */
> -void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
> +void tlb_reset_dirty(CPUState *cpu, uintptr_t addr, uintptr_t length)
>   {
>       int mmu_idx;
>   
> @@ -929,12 +929,12 @@ void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
>   
>           for (i = 0; i < n; i++) {
>               tlb_reset_dirty_range_locked(&desc->fulltlb[i], &fast->table[i],
> -                                         start, length);
> +                                         addr, length);
>           }
>   
>           for (i = 0; i < CPU_VTLB_SIZE; i++) {
>               tlb_reset_dirty_range_locked(&desc->vfulltlb[i], &desc->vtable[i],
> -                                         start, length);
> +                                         addr, length);
>           }
>       }
>       qemu_spin_unlock(&cpu->neg.tlb.c.lock);
> diff --git a/system/physmem.c b/system/physmem.c
> index 000bde90c2e..098824ad1d2 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -882,16 +882,16 @@ found:
>       return block;
>   }
>   
> -void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
> +void tlb_reset_dirty_range_all(ram_addr_t addr, ram_addr_t length)
>   {
>       CPUState *cpu;
> -    ram_addr_t start1;
> +    ram_addr_t start, start1;
>       RAMBlock *block;
>       ram_addr_t end;
>   
>       assert(tcg_enabled());
> -    end = TARGET_PAGE_ALIGN(start + length);
> -    start &= TARGET_PAGE_MASK;
> +    end = TARGET_PAGE_ALIGN(addr + length);
> +    start = addr & TARGET_PAGE_MASK;
>   
>       RCU_READ_LOCK_GUARD();
>       block = qemu_get_ram_block(start);


