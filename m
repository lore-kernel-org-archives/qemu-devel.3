Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C28CEDDA3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 00:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygnR-0001Nb-OP; Wed, 09 Oct 2024 20:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygnQ-0001NR-3G
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:12:48 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygnN-00023n-Up
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:12:47 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e2d1858cdfso77616a91.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 17:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728519164; x=1729123964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vJ672/VxZX/bhuRaPwLKTUs+vxI22kwq/zYcsUx9myY=;
 b=CarUxEOO93FNYvIV6jUa1lPSUkVWLhoHJFvAtuLL22j3L6sT2FRzrK0q+ECmujFh2u
 cS1Qp6QUz11GNpvUNOfdAU8CtbQEIZQlnB25vszy4KvWrT5MQj63bwYbuOQlXsOhMLX3
 2SAFbl9nYbu59vipanLQDKHgCV4m1GHc/BorHdAWjFunyvYcE5aWEiXRRtr7LS+WN87E
 6jtMEo9m9vw1X7u1CppjfkO+mjHX7aBJ7dHfo5dteA5Xc+JAfh8zlbnWornY5YbX561B
 wt59tNAO96wm5ouq7pzgMVvEm7KbDe6U4SqFeK+gabqVa0Qr8IL3Pel3RqXH2GvrNW6o
 LL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728519164; x=1729123964;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vJ672/VxZX/bhuRaPwLKTUs+vxI22kwq/zYcsUx9myY=;
 b=kB9KFs8xJgu/WFziLsZ+eounGjjQXgDDp+NOWj4eUlzOBIF9wKHe+G2VAxaCwLdRKr
 3/dthDarcox0LN0VEjNdabuPgNh0v2XaOM/unIcwFDhEPCvEjArxyrtt361Ul01onqg+
 GgbKFYJ3NKjY11JJCMfN0w8A0eYBAKaoRGODyifUQ4BMfhFTLIgJusbWhOAcVrbodULb
 FBzq3hnBGkosk/sJR86jQFNXE4ZLn5lB/eoQWCf/7m/LsV5F75CoYp1q/QnsBJxz5KP8
 JBd4BIeptyIKDzhEdo5s1LRFUQPkka5U1dMxwRbRWXmqOQE2xoEkSjJzp7dkNJWDprgC
 5wcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0nYNAFuCoB0urhF4SkFI+NkSpXsBcHycjrriEFL8ofxAtkOkz6PJAgaCq5V/UrnK6n+mZJwvHaCZf@nongnu.org
X-Gm-Message-State: AOJu0YyzuEQ1wJVSMv0g8tOn01hFAnHUOV0hjRt/cB2ztq8psNd1Aoad
 zKNwVxMH3WHGehno7VhVs6AcsX7JZt0f3cMWmo70WBJf+sd/f1T3p6VyycUBuoY=
X-Google-Smtp-Source: AGHT+IGwBth7thShkGp4Hb5sUL8aM5y6XEaENpqsVG3WMn1UdVa85E731K0Pj3RbY/yWQH874ZioHQ==
X-Received: by 2002:a17:90b:3613:b0:2e2:cf5c:8ee3 with SMTP id
 98e67ed59e1d1-2e2cf5c9025mr761597a91.10.1728519164367; 
 Wed, 09 Oct 2024 17:12:44 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5fa5f49sm29343a91.46.2024.10.09.17.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 17:12:42 -0700 (PDT)
Message-ID: <47e0d746-17fb-4e0f-87c1-cd9cfda4bde3@linaro.org>
Date: Wed, 9 Oct 2024 17:12:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/23] accel/tcg: Remove the victim tlb
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-16-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

On 10/9/24 08:08, Richard Henderson wrote:
> This has been functionally replaced by the IntervalTree.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h |  8 ------
>   accel/tcg/cputlb.c    | 64 -------------------------------------------
>   2 files changed, 72 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index b567abe3e2..87b864f5c4 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -198,9 +198,6 @@ struct CPUClass {
>    */
>   #define NB_MMU_MODES 16
>   
> -/* Use a fully associative victim tlb of 8 entries. */
> -#define CPU_VTLB_SIZE 8
> -
>   /*
>    * The full TLB entry, which is not accessed by generated TCG code,
>    * so the layout is not as critical as that of CPUTLBEntry. This is
> @@ -282,11 +279,6 @@ typedef struct CPUTLBDesc {
>       /* maximum number of entries observed in the window */
>       size_t window_max_entries;
>       size_t n_used_entries;
> -    /* The next index to use in the tlb victim table.  */
> -    size_t vindex;
> -    /* The tlb victim table, in two parts.  */
> -    CPUTLBEntry vtable[CPU_VTLB_SIZE];
> -    CPUTLBEntryFull vfulltlb[CPU_VTLB_SIZE];
>       CPUTLBEntryFull *fulltlb;
>       /* All active tlb entries for this address space. */
>       IntervalTreeRoot iroot;
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index b10b0a357c..561f66c723 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -328,8 +328,6 @@ static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
>       tlbfast_flush_locked(desc, fast);
>       desc->large_page_addr = -1;
>       desc->large_page_mask = -1;
> -    desc->vindex = 0;
> -    memset(desc->vtable, -1, sizeof(desc->vtable));
>       interval_tree_free_nodes(&desc->iroot, offsetof(CPUTLBEntryTree, itree));
>   }
>   
> @@ -501,15 +499,6 @@ static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry, vaddr page)
>       return tlb_hit_page_mask_anyprot(tlb_entry, page, -1);
>   }
>   
> -/**
> - * tlb_entry_is_empty - return true if the entry is not in use
> - * @te: pointer to CPUTLBEntry
> - */
> -static inline bool tlb_entry_is_empty(const CPUTLBEntry *te)
> -{
> -    return te->addr_read == -1 && te->addr_write == -1 && te->addr_code == -1;
> -}
> -
>   /* Called with tlb_c.lock held */
>   static bool tlb_flush_entry_mask_locked(CPUTLBEntry *tlb_entry,
>                                           vaddr page,
> @@ -527,28 +516,6 @@ static inline bool tlb_flush_entry_locked(CPUTLBEntry *tlb_entry, vaddr page)
>       return tlb_flush_entry_mask_locked(tlb_entry, page, -1);
>   }
>   
> -/* Called with tlb_c.lock held */
> -static void tlb_flush_vtlb_page_mask_locked(CPUState *cpu, int mmu_idx,
> -                                            vaddr page,
> -                                            vaddr mask)
> -{
> -    CPUTLBDesc *d = &cpu->neg.tlb.d[mmu_idx];
> -    int k;
> -
> -    assert_cpu_is_self(cpu);
> -    for (k = 0; k < CPU_VTLB_SIZE; k++) {
> -        if (tlb_flush_entry_mask_locked(&d->vtable[k], page, mask)) {
> -            tlb_n_used_entries_dec(cpu, mmu_idx);
> -        }
> -    }
> -}
> -
> -static inline void tlb_flush_vtlb_page_locked(CPUState *cpu, int mmu_idx,
> -                                              vaddr page)
> -{
> -    tlb_flush_vtlb_page_mask_locked(cpu, mmu_idx, page, -1);
> -}
> -
>   static void tlbfast_flush_range_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
>                                          vaddr addr, vaddr len, vaddr mask)
>   {
> @@ -593,7 +560,6 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
>   
>       tlbfast_flush_range_locked(desc, &cpu->neg.tlb.f[midx],
>                                  page, TARGET_PAGE_SIZE, -1);
> -    tlb_flush_vtlb_page_locked(cpu, midx, page);
>   
>       node = tlbtree_lookup_addr(desc, page);
>       if (node) {
> @@ -769,11 +735,6 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
>   
>       tlbfast_flush_range_locked(d, f, addr, len, mask);
>   
> -    for (vaddr i = 0; i < len; i += TARGET_PAGE_SIZE) {
> -        vaddr page = addr + i;
> -        tlb_flush_vtlb_page_mask_locked(cpu, midx, page, mask);
> -    }
> -
>       addr_mask = addr & mask;
>       last_mask = addr_mask + len - 1;
>       last_imask = last_mask | ~mask;
> @@ -1031,10 +992,6 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
>               tlb_reset_dirty_range_locked(&fast->table[i], start1, length);
>           }
>   
> -        for (size_t i = 0; i < CPU_VTLB_SIZE; i++) {
> -            tlb_reset_dirty_range_locked(&desc->vtable[i], start1, length);
> -        }
> -
>           for (CPUTLBEntryTree *t = tlbtree_lookup_range(desc, 0, -1); t;
>                t = tlbtree_lookup_range_next(t, 0, -1)) {
>               tlb_reset_dirty_range_locked(&t->copy, start1, length);
> @@ -1068,10 +1025,6 @@ static void tlb_set_dirty(CPUState *cpu, vaddr addr)
>   
>           tlb_set_dirty1_locked(tlb_entry(cpu, mmu_idx, addr), addr);
>   
> -        for (int k = 0; k < CPU_VTLB_SIZE; k++) {
> -            tlb_set_dirty1_locked(&desc->vtable[k], addr);
> -        }
> -
>           node = tlbtree_lookup_addr(desc, addr);
>           if (node) {
>               tlb_set_dirty1_locked(&node->copy, addr);
> @@ -1230,23 +1183,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       /* Note that the tlb is no longer clean.  */
>       tlb->c.dirty |= 1 << mmu_idx;
>   
> -    /* Make sure there's no cached translation for the new page.  */
> -    tlb_flush_vtlb_page_locked(cpu, mmu_idx, addr_page);
> -
> -    /*
> -     * Only evict the old entry to the victim tlb if it's for a
> -     * different page; otherwise just overwrite the stale data.
> -     */
> -    if (!tlb_hit_page_anyprot(te, addr_page) && !tlb_entry_is_empty(te)) {
> -        unsigned vidx = desc->vindex++ % CPU_VTLB_SIZE;
> -        CPUTLBEntry *tv = &desc->vtable[vidx];
> -
> -        /* Evict the old entry into the victim tlb.  */
> -        copy_tlb_helper_locked(tv, te);
> -        desc->vfulltlb[vidx] = desc->fulltlb[index];
> -        tlb_n_used_entries_dec(cpu, mmu_idx);
> -    }
> -
>       /* Replace an old IntervalTree entry, or create a new one. */
>       node = tlbtree_lookup_addr(desc, addr_page);
>       if (!node) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

