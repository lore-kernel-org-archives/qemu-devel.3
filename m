Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C966C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhE3Z-0002jT-LN; Wed, 30 Jul 2025 17:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDo4-0006XC-U6
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:53:49 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDo3-0002aU-1n
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:53:48 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-31f28d0495fso245385a91.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753908825; x=1754513625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rvrcyMNIhyyYnKMjoSul8PYvDdUDvG3/Vn6mVAm0oPI=;
 b=g7DYdWc8x07oCCDESfrwSPMSDj8QZSlfQx1Gla19n1sRpzQvjukViW7BpRjBhq8a+R
 ZpuNQ43A38IYxkKuiVEYcBEO+DQPk7b+1Ku02fXQmZsSi2R3GnFAUzM7A/sUkU/ljIAK
 i193wZ/4rzPGMdoHPZO2zypn882bMJ9hjUFJM04XJKLyyrE3wSFPrl/DHoFu/LYrwg6t
 Nxmpaj+KA0bbb+CpeR7WvrpYOrmei400NETA+Y4JzZsROJ0BPj1Lh+vn+LB9HgMOv/CE
 g4XT6YmcadFZRySVCR8CBsnS5YdSats2UMyyP2FxqeU3PqIbRcgwKM3YPnVVSvejIO3k
 7ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753908825; x=1754513625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rvrcyMNIhyyYnKMjoSul8PYvDdUDvG3/Vn6mVAm0oPI=;
 b=lX2o2CNtGcEHYXHp8PWTfy/FB0ysaj1V5Rb2r/oHDkfxdUQ51QHb+BFMscI/Mtjk9n
 ViFghrlhpgQk7UczirswqbBuQY284lI4fho8YhFswafZAe8uN58uT62trW7Ps9FR56DH
 2z8J4S7ZtEFsRuqHe62XOeayXoiLwv8bUx6QBiil03kNGKf4WqPOXys17bdnULoqMD3W
 BfLkESHPxyg+FgOYvFT0LpBUP0TT6UiSPNMBBT5FqmzkpAWPy7BjFoAWX6046TqA8PHr
 yL9TwNLYx+uZRej06yvwX984ioGKLv6xkkgH44KjPoOCRTGyGRffCEzPUNZljDG3Ii9y
 KcUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVNCjQvc6YXJH4svw71IZGn3OxcpILQ1cvio/I696WmrNT+o5RiUyFsjOcpTeZCuboootB6+qkTIQH@nongnu.org
X-Gm-Message-State: AOJu0Yz+HaLI+HgSTy5N6idGLsUi/Qd4KvY7u1N/nlyfXBAPWtIVGK0Y
 oGPhf6uSUNUFCv4B2sjDVBu7HgvLwdiP76pUq6rVls2lsoU4YBgTDahnstE60du9GFxNzoGw/8Q
 F4+GP
X-Gm-Gg: ASbGncva91aHBI5T4pge7Wf1GUCwqsZRzXK2PyfyFmI5lorhreOAbOJmDzQcR83hIte
 veJD4bVyXzTpcUWxN/NMMyVMNzKIlzFgJpcsSkEw/e8ScMR3JASFyAvi7VXsuGeMX9FesgaW5u/
 ACFR/X+1E3A5E7drLibbrPKo7z99GsTS0zOqh7XVE8XKQBePk0wNkp2C3oo68iuiVTgzA+q9knO
 TxJDbE0okj/8PuXeEThCoCuyoF5CsKfGMK9FcRoHx316L2Bo/J7sjZ3yHV+QC4OvDhE53XkaJSQ
 YS8VouykH2B59FBtMJvuTOzhrx0e2HMxDPwW9KeQFoOsRo6D805ESr82gcMkQtyjllk9rVKQxCT
 5P0i6Tka5ayt6LHWaSnzVL1n9bCdq2kCJ28E=
X-Google-Smtp-Source: AGHT+IG4OQx4B+AAs9A7NPBEOqdEAY+/o1ia3JLg3LOnq6rFAJYk9Itnp8+4FHVrN/OSZNTiRvX9ZA==
X-Received: by 2002:a17:90b:17ca:b0:31e:94d2:c36f with SMTP id
 98e67ed59e1d1-31f5ddb5201mr7180268a91.8.1753908825243; 
 Wed, 30 Jul 2025 13:53:45 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63da57b4sm2848303a91.5.2025.07.30.13.53.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:53:44 -0700 (PDT)
Message-ID: <9b3b9cdd-c6d5-4c98-8fd9-be0402ad1804@linaro.org>
Date: Wed, 30 Jul 2025 13:53:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/82] include/hw/core/cpu: Introduce cpu_tlb_fast
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-25-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Encapsulate access to cpu->neg.tlb.f[] in a function.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h |  7 +++++++
>   accel/tcg/cputlb.c    | 16 ++++++++--------
>   2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 1153cadb70..bd835b07d5 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -593,6 +593,13 @@ static inline CPUArchState *cpu_env(CPUState *cpu)
>       return (CPUArchState *)(cpu + 1);
>   }
>   
> +#ifdef CONFIG_TCG
> +static inline CPUTLBDescFast *cpu_tlb_fast(CPUState *cpu, int mmu_idx)
> +{
> +    return &cpu->neg.tlb.f[mmu_idx];
> +}
> +#endif
> +
>   typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
>   extern CPUTailQ cpus_queue;
>   
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index d324f33339..2a6aa01c57 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -129,7 +129,7 @@ static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
>   static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
>                                     vaddr addr)
>   {
> -    uintptr_t size_mask = cpu->neg.tlb.f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
> +    uintptr_t size_mask = cpu_tlb_fast(cpu, mmu_idx)->mask >> CPU_TLB_ENTRY_BITS;
>   
>       return (addr >> TARGET_PAGE_BITS) & size_mask;
>   }
> @@ -138,7 +138,7 @@ static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
>   static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
>                                        vaddr addr)
>   {
> -    return &cpu->neg.tlb.f[mmu_idx].table[tlb_index(cpu, mmu_idx, addr)];
> +    return &cpu_tlb_fast(cpu, mmu_idx)->table[tlb_index(cpu, mmu_idx, addr)];
>   }
>   
>   static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
> @@ -292,7 +292,7 @@ static void tlb_flush_one_mmuidx_locked(CPUState *cpu, int mmu_idx,
>                                           int64_t now)
>   {
>       CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
> -    CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
> +    CPUTLBDescFast *fast = cpu_tlb_fast(cpu, mmu_idx);
>   
>       tlb_mmu_resize_locked(desc, fast, now);
>       tlb_mmu_flush_locked(desc, fast);
> @@ -331,7 +331,7 @@ void tlb_init(CPUState *cpu)
>       cpu->neg.tlb.c.dirty = 0;
>   
>       for (i = 0; i < NB_MMU_MODES; i++) {
> -        tlb_mmu_init(&cpu->neg.tlb.d[i], &cpu->neg.tlb.f[i], now);
> +        tlb_mmu_init(&cpu->neg.tlb.d[i], cpu_tlb_fast(cpu, i), now);
>       }
>   }
>   
> @@ -342,7 +342,7 @@ void tlb_destroy(CPUState *cpu)
>       qemu_spin_destroy(&cpu->neg.tlb.c.lock);
>       for (i = 0; i < NB_MMU_MODES; i++) {
>           CPUTLBDesc *desc = &cpu->neg.tlb.d[i];
> -        CPUTLBDescFast *fast = &cpu->neg.tlb.f[i];
> +        CPUTLBDescFast *fast = cpu_tlb_fast(cpu, i);
>   
>           g_free(fast->table);
>           g_free(desc->fulltlb);
> @@ -667,7 +667,7 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
>                                      unsigned bits)
>   {
>       CPUTLBDesc *d = &cpu->neg.tlb.d[midx];
> -    CPUTLBDescFast *f = &cpu->neg.tlb.f[midx];
> +    CPUTLBDescFast *f = cpu_tlb_fast(cpu, midx);
>       vaddr mask = MAKE_64BIT_MASK(0, bits);
>   
>       /*
> @@ -923,7 +923,7 @@ void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
>       qemu_spin_lock(&cpu->neg.tlb.c.lock);
>       for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
>           CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
> -        CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
> +        CPUTLBDescFast *fast = cpu_tlb_fast(cpu, mmu_idx);
>           unsigned int n = tlb_n_entries(fast);
>           unsigned int i;
>   
> @@ -1316,7 +1316,7 @@ static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
>   
>           if (cmp == page) {
>               /* Found entry in victim tlb, swap tlb and iotlb.  */
> -            CPUTLBEntry tmptlb, *tlb = &cpu->neg.tlb.f[mmu_idx].table[index];
> +            CPUTLBEntry tmptlb, *tlb = &cpu_tlb_fast(cpu, mmu_idx)->table[index];
>   
>               qemu_spin_lock(&cpu->neg.tlb.c.lock);
>               copy_tlb_helper_locked(&tmptlb, tlb);

It's sad, my eyes were just getting used to read those accesses :)
More seriously, that's clearer, thanks.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

