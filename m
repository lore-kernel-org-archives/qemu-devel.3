Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9178D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeFg-0005jn-DR; Thu, 14 Nov 2024 13:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeFe-0005jG-Pl
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:07:30 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeFc-0003XC-V2
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:07:30 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e5a62031aso725951b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607647; x=1732212447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T52hxt9CTfM//vcUFWPckjVMIEn3R4B+9RgGDzM6KOA=;
 b=tyOWVZESmwVdtx/zWY0MxFRes+M4MTD6NjFujQURxS3t+Y1/CyvlfN2s9vCCW17KV5
 GUehzym2Vuwe2Mzh4X6TJPtU3659emrcJ/BuOQUadUgksuGpY8lYdl/rVXzBLcvmx98L
 O7wITJBSqgNmTSXPPXgQyEhE7UEx/opks/zZuof3Ecj6Pp9mHgU/Fo/qzGOmk9ArZ7rG
 ClzJZYvCLrg/2EczKxLcHdM0F7obTkMAmDevZk9g+R97CJ2CUp1r+uaueVN0WIPj6gPA
 uli/5PcP/DEYnuZT6pf7cdiL/JzT5ToOsQSGuSRvtVDEi3vkxqR3FEqz4Dz0Nmkvi4B5
 m1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607647; x=1732212447;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T52hxt9CTfM//vcUFWPckjVMIEn3R4B+9RgGDzM6KOA=;
 b=bEBWr5/U28l9VXqUF6zyMrfJICPrVWA7qAnKODy4s/N+Jhkxk99Y1HdPDmbhwu3JHH
 0xVPJvoazBSUBe3ZpFxJnrqRhHwOb5sKJ6pV1LbyLqJUMhRh4ZKF/ees7NUGqqP9OhMC
 R1stFvqAUKgKRr90G7IqZFmegIjZmADo7tHgZGx4kd1JOVVPDgwzzRmmAqzti+h48qFC
 G7OslIFFmIaGVvOQrUtwiKJvLED/wBdYdmpBKk3SfcUgsMaL7YAnmAEMs4c6BTYKH2DZ
 Ssd2jPUAHHmMUKIanx0ICLllGtOOVHnHvCC7q++OszifVJBqkxZ1Owbf4nk4I2gBVpe9
 tiYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOtRj2Mgn5mMMsi5eSRdpNEpehRsMCLFNJbCuaRoGwVQ2KXg7Sftzk6XF12I9Du3PZFH9ui+Kx21kq@nongnu.org
X-Gm-Message-State: AOJu0YxHW/XUr87/vxDKMMD3mpnm5iEv36NpnOHJLT9NpRG34DYsinom
 kwQQxRFLvWey0A2Gfn8ZjwL4vSxwwWqkm0MxOAr9MSO9FCpeJFWnTYHejEaWfKNjD2V5ZmJeeP9
 a2daaGg==
X-Google-Smtp-Source: AGHT+IFqu+/XDVVU/LtFQf+Ajf4Gwd1Lc7BAOzG9c7BwfuOgpYpJc5XLFegPA9zczwszVJBr3pWcsw==
X-Received: by 2002:a05:6a00:4f86:b0:71e:3b8f:92e with SMTP id
 d2e1a72fcca58-72469c5e94emr3932390b3a.3.1731607647230; 
 Thu, 14 Nov 2024 10:07:27 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a5ce7a4sm1545923b3a.3.2024.11.14.10.07.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:07:26 -0800 (PST)
Message-ID: <77371ae7-f123-4577-b44b-44ad7d9d19cd@linaro.org>
Date: Thu, 14 Nov 2024 10:07:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/54] accel/tcg: Remove the victim tlb
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-19-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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



On 11/14/24 08:00, Richard Henderson wrote:
> This has been functionally replaced by the IntervalTree.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h |  8 -----
>   accel/tcg/cputlb.c    | 74 -------------------------------------------
>   2 files changed, 82 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 1ebc999a73..8eda0574b2 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -201,9 +201,6 @@ struct CPUClass {
>    */
>   #define NB_MMU_MODES 16
>   
> -/* Use a fully associative victim tlb of 8 entries. */
> -#define CPU_VTLB_SIZE 8
> -
>   /*
>    * The full TLB entry, which is not accessed by generated TCG code,
>    * so the layout is not as critical as that of CPUTLBEntry. This is
> @@ -285,11 +282,6 @@ typedef struct CPUTLBDesc {
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
> index ea4b78866b..8caa8c0f1d 100644
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
> @@ -361,11 +359,6 @@ static inline void tlb_n_used_entries_inc(CPUState *cpu, uintptr_t mmu_idx)
>       cpu->neg.tlb.d[mmu_idx].n_used_entries++;
>   }
>   
> -static inline void tlb_n_used_entries_dec(CPUState *cpu, uintptr_t mmu_idx)
> -{
> -    cpu->neg.tlb.d[mmu_idx].n_used_entries--;
> -}
> -
>   void tlb_init(CPUState *cpu)
>   {
>       int64_t now = get_clock_realtime();
> @@ -496,20 +489,6 @@ static bool tlb_hit_page_mask_anyprot(CPUTLBEntry *tlb_entry,
>               page == (tlb_entry->addr_code & mask));
>   }
>   
> -static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry, vaddr page)
> -{
> -    return tlb_hit_page_mask_anyprot(tlb_entry, page, -1);
> -}
> -
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
> @@ -522,28 +501,6 @@ static bool tlb_flush_entry_mask_locked(CPUTLBEntry *tlb_entry,
>       return false;
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
> @@ -588,7 +545,6 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
>   
>       tlbfast_flush_range_locked(desc, &cpu->neg.tlb.f[midx],
>                                  page, TARGET_PAGE_SIZE, -1);
> -    tlb_flush_vtlb_page_locked(cpu, midx, page);
>   
>       node = tlbtree_lookup_addr(desc, page);
>       if (node) {
> @@ -764,11 +720,6 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
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
> @@ -1017,10 +968,6 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
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
> @@ -1054,10 +1001,6 @@ static void tlb_set_dirty(CPUState *cpu, vaddr addr)
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
> @@ -1216,23 +1159,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
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


