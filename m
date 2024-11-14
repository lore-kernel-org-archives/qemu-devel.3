Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826EDD6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeKp-0002n6-It; Thu, 14 Nov 2024 13:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeKg-0002cK-B7
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:12:43 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeKe-0004UC-9S
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:12:42 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7edb6879196so744451a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607959; x=1732212759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y3CKPkvEK3sSrfh7PV/u2nWjQ8qbVSOM1OkBsO1sDu0=;
 b=aQwMJ5hYPhE27R4CfhkBqO8oWwlH50o60pJyaYoZVMcW5s4QL8lQXjMsIEZLIhr2eT
 obOzf2OEED5jLvbvs5rYt4ueQkKdhWnn+0s+ejXeJQuWworxODhP/B8/SoQPEyDvYqTR
 i7c0JrbanW4byFmpOMQLJazecxtWW7GQ/FWUk/kNmyAj/D8nWrV2FfwtTMHG28tn/i6t
 dasrStgCZoIQlk8wKxQXlRbCZQo8k8JScaV7ohsdI3Wny830pCvMaSG07aEe5R0w0/WA
 fiSeCtlvP1TJl/xFLMdyPIGq+v5j9p3MqfK+efWhWOepXiLiDqVuosULU2tSjHlAh0Ru
 aoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607959; x=1732212759;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y3CKPkvEK3sSrfh7PV/u2nWjQ8qbVSOM1OkBsO1sDu0=;
 b=Aczrs0IfmUXzLEM2snyHiNzBCjjAFtwhIVwGQwL7R6IlO/R1OwMPqXbZB4JzmgBeGK
 NLZyTgHurxGYMQgXtNo35qfqObSg7PD6RJw9wWyBV1OCBvKYPPnVvNj3oNFw4zhdbtGJ
 siQv8yRph3hHaGzYguuXprPzBZY17cmHSW1kB+7QArJxgLUzzaPEeDHsh2492rkYIiaf
 GrAlvNLg812tsg8lkK+j66C1mmbHtGj9B9PMmSIqQTc+1l0lcG+0/lYFMNpYSxkWlW2B
 q6hxkXoXvCzKoKVpUST8BpX9qjsaBMfaSx2Pwy/4FI0ryy905n2AjTiLrz8zNqRik9LN
 j0+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRVaoUdJVowNYs0729R6O1YSSMAbdALw3AyLC8eOc+mR+JuUGbdgmawtPgn7w9+uMgkKCtADgIvp0K@nongnu.org
X-Gm-Message-State: AOJu0YzKIi43LvtsSMOaJrJs5NUmGCl8pwX+cZr/JCW6yruN8mtgOb8E
 jezz0KRU4cxvcANZww1vSzUV40ZcZguNaDE1Pgtk1845PS4zA6qFnCL1nN4uUSy7mqJ77QhSdeZ
 mqaM5MQ==
X-Google-Smtp-Source: AGHT+IGGjwLhb0RBllU/xYfKwY+phvb/aTojGgBjVTzTqVQNxWX7bC+10k2QNv6y/TlPN3J3L4mCPQ==
X-Received: by 2002:a17:902:e5d0:b0:20c:c704:629e with SMTP id
 d9443c01a7336-211835ed7f7mr340586895ad.56.1731607958907; 
 Thu, 14 Nov 2024 10:12:38 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8b37f9319sm1382066a12.50.2024.11.14.10.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:12:38 -0800 (PST)
Message-ID: <8f4bcdd7-1a3f-45c2-8db8-01855a83b0f8@linaro.org>
Date: Thu, 14 Nov 2024 10:12:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/54] accel/tcg: Return CPUTLBEntryFull not pointer in
 probe_access_full
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-27-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

On 11/14/24 08:01, Richard Henderson wrote:
> Return a copy of the structure, not a pointer.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h     |  6 +-----
>   accel/tcg/cputlb.c          |  8 +++++---
>   target/arm/tcg/helper-a64.c |  4 ++--
>   target/arm/tcg/mte_helper.c | 15 ++++++---------
>   target/arm/tcg/sve_helper.c |  6 +++---
>   5 files changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index df7d0b5ad0..69bdb77584 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -365,10 +365,6 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
>    * probe_access_full:
>    * Like probe_access_flags, except also return into @pfull.
>    *
> - * The CPUTLBEntryFull structure returned via @pfull is transient
> - * and must be consumed or copied immediately, before any further
> - * access or changes to TLB @mmu_idx.
> - *
>    * This function will not fault if @nonfault is set, but will
>    * return TLB_INVALID_MASK if the page is not mapped, or is not
>    * accessible with @access_type.
> @@ -379,7 +375,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
>   int probe_access_full(CPUArchState *env, vaddr addr, int size,
>                         MMUAccessType access_type, int mmu_idx,
>                         bool nonfault, void **phost,
> -                      CPUTLBEntryFull **pfull, uintptr_t retaddr);
> +                      CPUTLBEntryFull *pfull, uintptr_t retaddr);
>   
>   /**
>    * probe_access_full_mmu:
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 81135524eb..84e7e633e3 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1420,20 +1420,22 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
>   
>   int probe_access_full(CPUArchState *env, vaddr addr, int size,
>                         MMUAccessType access_type, int mmu_idx,
> -                      bool nonfault, void **phost, CPUTLBEntryFull **pfull,
> +                      bool nonfault, void **phost, CPUTLBEntryFull *pfull,
>                         uintptr_t retaddr)
>   {
> +    CPUTLBEntryFull *full;
>       int flags = probe_access_internal(env_cpu(env), addr, size, access_type,
> -                                      mmu_idx, nonfault, phost, pfull, retaddr,
> +                                      mmu_idx, nonfault, phost, &full, retaddr,
>                                         true);
>   
>       /* Handle clean RAM pages.  */
>       if (unlikely(flags & TLB_NOTDIRTY)) {
>           int dirtysize = size == 0 ? 1 : size;
> -        notdirty_write(env_cpu(env), addr, dirtysize, *pfull, retaddr);
> +        notdirty_write(env_cpu(env), addr, dirtysize, full, retaddr);
>           flags &= ~TLB_NOTDIRTY;
>       }
>   
> +    *pfull = *full;
>       return flags;
>   }
>   
> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index 8f42a28d07..783864d6db 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -1883,14 +1883,14 @@ static bool is_guarded_page(CPUARMState *env, target_ulong addr, uintptr_t ra)
>   #ifdef CONFIG_USER_ONLY
>       return page_get_flags(addr) & PAGE_BTI;
>   #else
> -    CPUTLBEntryFull *full;
> +    CPUTLBEntryFull full;
>       void *host;
>       int mmu_idx = cpu_mmu_index(env_cpu(env), true);
>       int flags = probe_access_full(env, addr, 0, MMU_INST_FETCH, mmu_idx,
>                                     false, &host, &full, ra);
>   
>       assert(!(flags & TLB_INVALID_MASK));
> -    return full->extra.arm.guarded;
> +    return full.extra.arm.guarded;
>   #endif
>   }
>   
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index 9d2ba287ee..870b2875af 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -83,8 +83,7 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
>                         TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
>       return tags + index;
>   #else
> -    CPUTLBEntryFull *full;
> -    MemTxAttrs attrs;
> +    CPUTLBEntryFull full;
>       int in_page, flags;
>       hwaddr ptr_paddr, tag_paddr, xlat;
>       MemoryRegion *mr;
> @@ -110,7 +109,7 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
>       assert(!(flags & TLB_INVALID_MASK));
>   
>       /* If the virtual page MemAttr != Tagged, access unchecked. */
> -    if (full->extra.arm.pte_attrs != 0xf0) {
> +    if (full.extra.arm.pte_attrs != 0xf0) {
>           return NULL;
>       }
>   
> @@ -129,9 +128,7 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
>        * Remember these values across the second lookup below,
>        * which may invalidate this pointer via tlb resize.
>        */
> -    ptr_paddr = full->phys_addr | (ptr & ~TARGET_PAGE_MASK);
> -    attrs = full->attrs;
> -    full = NULL;
> +    ptr_paddr = full.phys_addr | (ptr & ~TARGET_PAGE_MASK);
>   
>       /*
>        * The Normal memory access can extend to the next page.  E.g. a single
> @@ -150,17 +147,17 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
>       if (!probe && unlikely(flags & TLB_WATCHPOINT)) {
>           int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
>           assert(ra != 0);
> -        cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, attrs, wp, ra);
> +        cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, full.attrs, wp, ra);
>       }
>   
>       /* Convert to the physical address in tag space.  */
>       tag_paddr = ptr_paddr >> (LOG2_TAG_GRANULE + 1);
>   
>       /* Look up the address in tag space. */
> -    tag_asi = attrs.secure ? ARMASIdx_TagS : ARMASIdx_TagNS;
> +    tag_asi = full.attrs.secure ? ARMASIdx_TagS : ARMASIdx_TagNS;
>       tag_as = cpu_get_address_space(env_cpu(env), tag_asi);
>       mr = address_space_translate(tag_as, tag_paddr, &xlat, NULL,
> -                                 tag_access == MMU_DATA_STORE, attrs);
> +                                 tag_access == MMU_DATA_STORE, full.attrs);
>   
>       /*
>        * Note that @mr will never be NULL.  If there is nothing in the address
> diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
> index f1ee0e060f..dad0d5e518 100644
> --- a/target/arm/tcg/sve_helper.c
> +++ b/target/arm/tcg/sve_helper.c
> @@ -5357,7 +5357,7 @@ bool sve_probe_page(SVEHostPage *info, bool nofault, CPUARMState *env,
>       flags = probe_access_flags(env, addr, 0, access_type, mmu_idx, nofault,
>                                  &info->host, retaddr);
>   #else
> -    CPUTLBEntryFull *full;
> +    CPUTLBEntryFull full;
>       flags = probe_access_full(env, addr, 0, access_type, mmu_idx, nofault,
>                                 &info->host, &full, retaddr);
>   #endif
> @@ -5373,8 +5373,8 @@ bool sve_probe_page(SVEHostPage *info, bool nofault, CPUARMState *env,
>       /* Require both ANON and MTE; see allocation_tag_mem(). */
>       info->tagged = (flags & PAGE_ANON) && (flags & PAGE_MTE);
>   #else
> -    info->attrs = full->attrs;
> -    info->tagged = full->extra.arm.pte_attrs == 0xf0;
> +    info->attrs = full.attrs;
> +    info->tagged = full.extra.arm.pte_attrs == 0xf0;
>   #endif
>   
>       /* Ensure that info->host[] is relative to addr, not addr + mem_off. */

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


