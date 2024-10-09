Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB65CCEDDA6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygS1-0007oK-KE; Wed, 09 Oct 2024 19:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygRy-0007WB-08
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:50:38 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygRw-00077S-4x
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:50:37 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71df4620966so329317b3a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728517834; x=1729122634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=heeqIyBUYzKot/2ufWWlBpB2QyLn1HJOz+zp1zGZ4DQ=;
 b=PWKEFbZy27iP5MBLyTXGt0cmYdQblkVtGzgXEHQliDrJjze0dS3ilsDPZ9U6ONLffn
 ap76oCELmvioRBFthv0jhe0KGw132xbTaAMAmxqCg5VdstZDZm6TvSPms9y8vsZK2OUr
 MBF+UBypaaAXQAETOox3EYwXDh0hI0dWDJxS2jwZTMldIihn4zrTyMT4T5HXO7QyYwbm
 cE6PN9seEvagTx3ntMZSABOsAENoH6++SwI6adNfjKL6irn+eRNmmXjy4nE2itdnAj5K
 8ing9bQDL+WGo+PAxOgIh2O9lU/tK+AaHtWzLvKqfsYJsPWI8NefOikcxUzAF9wMwiBv
 TbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728517834; x=1729122634;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=heeqIyBUYzKot/2ufWWlBpB2QyLn1HJOz+zp1zGZ4DQ=;
 b=c1hkiOHT1xosjGY5gqYxHp9H1+Sl7qQdL0YloOv9fo+auS6YQNiMXeKkiPtTazz9z3
 GJjSUPWp+GpQpdhYHVJ7UUQIcL7PzwmfLMC1xJre/qGHlYeJIAW+FR9gYQWgIekl3y6V
 LVNOlSc6bYgqpHcibMw+Na7xU70Vwbv3rpgPQoT4626ZviVTB27dX5qMmN8SwqOPABT1
 E9u/Z7tHajEgTTns/ldUabr4lBnDbIr5HZ8EMOJi+up+n+/DeLOoe7jnPCAL1eMy9po0
 T03ZDk9E13VjuCSg3uNq+6cZY1I2719YgLHMlgO68nubZMKfJHbhASTm4q6oijb/LUz0
 U80w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9hFrMZWDT1UwbXQKgrIvF8yfaeE4K3gTWt4SYopcldLCxlDrht89hhbQ/kHp+bjwVFbSVH1BdhR3r@nongnu.org
X-Gm-Message-State: AOJu0YzodqKyOetuQdK1IHZtj6t4GkQrgWCy8AKg0Xlaaxgrppu01+zU
 3qFMQLI5Fwo63OPuWxFHLHFE9JAq7ecjwxLvTuYeIfxeVIAY0/y4CcoGP03lbN0=
X-Google-Smtp-Source: AGHT+IFBpmm3EoWZVr1EVl6xA1qNBaWysAOMW+fw8UdKo5PSYdQtkwPwdKLmf4J6l7LT2ZiRW0zS1Q==
X-Received: by 2002:a05:6a21:9102:b0:1d2:e81c:adc0 with SMTP id
 adf61e73a8af0-1d8a3cb1d99mr8965696637.46.1728517834511; 
 Wed, 09 Oct 2024 16:50:34 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d622fcsm8603582b3a.143.2024.10.09.16.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 16:50:34 -0700 (PDT)
Message-ID: <4d3478bb-ffdb-4296-83f2-1cb0968d443d@linaro.org>
Date: Wed, 9 Oct 2024 16:50:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/23] accel/tcg: Populate IntervalTree in
 tlb_set_page_full
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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
> Add or replace an entry in the IntervalTree for each
> page installed into softmmu.  We do not yet use the
> tree for anything else.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 34 ++++++++++++++++++++++++++++------
>   1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 435c2dc132..d964e1b2e8 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -305,6 +305,17 @@ static void tlbfast_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
>       memset(fast->table, -1, sizeof_tlb(fast));
>   }
>   
> +static CPUTLBEntryTree *tlbtree_lookup_range(CPUTLBDesc *desc, vaddr s, vaddr l)
> +{
> +    IntervalTreeNode *i = interval_tree_iter_first(&desc->iroot, s, l);
> +    return i ? container_of(i, CPUTLBEntryTree, itree) : NULL;
> +}
> +
> +static CPUTLBEntryTree *tlbtree_lookup_addr(CPUTLBDesc *desc, vaddr addr)
> +{
> +    return tlbtree_lookup_range(desc, addr, addr);
> +}
> +
>   static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
>   {
>       tlbfast_flush_locked(desc, fast);
> @@ -1086,7 +1097,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       MemoryRegionSection *section;
>       unsigned int index, read_flags, write_flags;
>       uintptr_t addend;
> -    CPUTLBEntry *te, tn;
> +    CPUTLBEntry *te;
> +    CPUTLBEntryTree *node;
>       hwaddr iotlb, xlat, sz, paddr_page;
>       vaddr addr_page;
>       int asidx, wp_flags, prot;
> @@ -1194,6 +1206,15 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>           tlb_n_used_entries_dec(cpu, mmu_idx);
>       }
>   
> +    /* Replace an old IntervalTree entry, or create a new one. */
> +    node = tlbtree_lookup_addr(desc, addr_page);
> +    if (!node) {
> +        node = g_new(CPUTLBEntryTree, 1);
> +        node->itree.start = addr_page;
> +        node->itree.last = addr_page + TARGET_PAGE_SIZE - 1;
> +        interval_tree_insert(&node->itree, &desc->iroot);
> +    }
> +
>       /* refill the tlb */
>       /*
>        * When memory region is ram, iotlb contains a TARGET_PAGE_BITS
> @@ -1215,15 +1236,15 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       full->phys_addr = paddr_page;
>   
>       /* Now calculate the new entry */
> -    tn.addend = addend - addr_page;
> +    node->copy.addend = addend - addr_page;
>   
> -    tlb_set_compare(full, &tn, addr_page, read_flags,
> +    tlb_set_compare(full, &node->copy, addr_page, read_flags,
>                       MMU_INST_FETCH, prot & PAGE_EXEC);
>   
>       if (wp_flags & BP_MEM_READ) {
>           read_flags |= TLB_WATCHPOINT;
>       }
> -    tlb_set_compare(full, &tn, addr_page, read_flags,
> +    tlb_set_compare(full, &node->copy, addr_page, read_flags,
>                       MMU_DATA_LOAD, prot & PAGE_READ);
>   
>       if (prot & PAGE_WRITE_INV) {
> @@ -1232,10 +1253,11 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       if (wp_flags & BP_MEM_WRITE) {
>           write_flags |= TLB_WATCHPOINT;
>       }
> -    tlb_set_compare(full, &tn, addr_page, write_flags,
> +    tlb_set_compare(full, &node->copy, addr_page, write_flags,
>                       MMU_DATA_STORE, prot & PAGE_WRITE);
>   
> -    copy_tlb_helper_locked(te, &tn);
> +    node->full = *full;
> +    copy_tlb_helper_locked(te, &node->copy);
>       tlb_n_used_entries_inc(cpu, mmu_idx);
>       qemu_spin_unlock(&tlb->c.lock);
>   }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

