Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584B1D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 17:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBe3D-0003so-D6; Thu, 14 Nov 2024 12:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe3C-0003se-5G
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:54:38 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe3A-0000zQ-59
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:54:37 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20ce5e3b116so9371195ad.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 09:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731606874; x=1732211674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8S9wprSDXh3BGjuWZy6I987zqyyrFKFCWkdRVBkLEMc=;
 b=KVNYa1jd8j566ihf711cG5FCBFvYXEZe3A7dmWOuA9LvPVBYLFXyKGQ8yQYaocJy5a
 ILIKvCXgFjkbqs3mKMCw27BRLKfUSaC+4UwH08mzWhtEAJTC324U0cbAffASukI3QiDm
 xGHNHxj96j7QZRIRldQxYYBfDvLys6OvTFAficpIiPUIT8t/BBA2mo4TrKc4aH2+Wv/4
 LUUPJd05WAFOwK0bdzKFzrzNQ/4kvxWOU1+9x0aqLofQ9Gaiu4nOQB/DvtpFEw7fB2yq
 JzPdmrN/CCP3gJ/24B48zLBb4p6yl4FMNVsn0KTjYdwLKb1aPzepGiqyAHj+CiCW4ZBZ
 YFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731606874; x=1732211674;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8S9wprSDXh3BGjuWZy6I987zqyyrFKFCWkdRVBkLEMc=;
 b=qBOUrI9G9dIPazN8nRX53bXNJXTCkmTq0jCE7hFl+bMD/ImOr04hJVzZBpOZ8McVMK
 g5FriqTz1G/8rKGwsALhYPH+e70ZTd0sOhPIXh+qBf+uB8KRXPv7dH81PTY3W4249ALl
 /8EdOJVWQ7bkzC41TvHp1hGi42knbaymjk+HJkMMLX6WneZWYvzioymuyecRIciuO/cp
 qswtZqVUM6O28Xto9PF5zn66l8TF5SpSxqgRGMQTzFMIlmfXZQfRW+sPsmRBrfomqFay
 Snt3pT53VX638ex+VDOS5vkZrjFN+Eb97uoADbZ++LnyXd+xr168tRbuLY7yq2QnGUEg
 Dn2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlmWZSTloU9PfdHHTs22Srr0mz66O89iBPkkl9FcJFaE7uYGpOBBq6TeL9jaDhBHsXLb2NSVD5Vq7P@nongnu.org
X-Gm-Message-State: AOJu0YwKoXleQJGQnzJBAn+obid6FbO6RxPGN1GBSSttyghzPCOfbydV
 8KUdnRv/tJZEjB7ZWr3slg4MWZwBiQOj7BGRUOsp62nBV1qr+7c0nFh8NXR/qVUyfhBvgl2bBE0
 T+NXENw==
X-Google-Smtp-Source: AGHT+IH0svC20ucyAOTtu5qai0mrmXwgANlbfQN8XsO6FZalfpNcfOfy+cT9h8qMYk76JT2XlRgoQg==
X-Received: by 2002:a17:902:c949:b0:20b:b21e:db21 with SMTP id
 d9443c01a7336-211c50ce289mr34518815ad.47.1731606874416; 
 Thu, 14 Nov 2024 09:54:34 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7c5539asm13508545ad.98.2024.11.14.09.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 09:54:33 -0800 (PST)
Message-ID: <9b490586-b86d-4a5a-b243-1373590a6b8e@linaro.org>
Date: Thu, 14 Nov 2024 09:54:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/54] accel/tcg: Fix flags usage in mmu_lookup1,
 atomic_mmu_lookup
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
> The INVALID bit should only be auto-cleared when we have
> just called tlb_fill, not along the victim_tlb_hit path.
> 
> In atomic_mmu_lookup, rename tlb_addr to flags, as that
> is what we're actually carrying around.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 33 ++++++++++++++++++++++-----------
>   1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 46fa0ae802..77b972fd93 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1652,7 +1652,7 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
>       uint64_t tlb_addr = tlb_read_idx(entry, access_type);
>       bool maybe_resized = false;
>       CPUTLBEntryFull *full;
> -    int flags;
> +    int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
>   
>       /* If the TLB entry is for a different page, reload and try again.  */
>       if (!tlb_hit(tlb_addr, addr)) {
> @@ -1663,8 +1663,14 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
>               maybe_resized = true;
>               index = tlb_index(cpu, mmu_idx, addr);
>               entry = tlb_entry(cpu, mmu_idx, addr);
> +            /*
> +             * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
> +             * to force the next access through tlb_fill.  We've just
> +             * called tlb_fill, so we know that this entry *is* valid.
> +             */
> +            flags &= ~TLB_INVALID_MASK;
>           }
> -        tlb_addr = tlb_read_idx(entry, access_type) & ~TLB_INVALID_MASK;
> +        tlb_addr = tlb_read_idx(entry, access_type);
>       }
>   
>       full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
> @@ -1814,10 +1820,10 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       MemOp mop = get_memop(oi);
>       uintptr_t index;
>       CPUTLBEntry *tlbe;
> -    vaddr tlb_addr;
>       void *hostaddr;
>       CPUTLBEntryFull *full;
>       bool did_tlb_fill = false;
> +    int flags;
>   
>       tcg_debug_assert(mmu_idx < NB_MMU_MODES);
>   
> @@ -1828,8 +1834,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       tlbe = tlb_entry(cpu, mmu_idx, addr);
>   
>       /* Check TLB entry and enforce page permissions.  */
> -    tlb_addr = tlb_addr_write(tlbe);
> -    if (!tlb_hit(tlb_addr, addr)) {
> +    flags = TLB_FLAGS_MASK;
> +    if (!tlb_hit(tlb_addr_write(tlbe), addr)) {
>           if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
>                               addr & TARGET_PAGE_MASK)) {
>               tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
> @@ -1837,8 +1843,13 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>               did_tlb_fill = true;
>               index = tlb_index(cpu, mmu_idx, addr);
>               tlbe = tlb_entry(cpu, mmu_idx, addr);
> +            /*
> +             * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
> +             * to force the next access through tlb_fill.  We've just
> +             * called tlb_fill, so we know that this entry *is* valid.
> +             */
> +            flags &= ~TLB_INVALID_MASK;
>           }
> -        tlb_addr = tlb_addr_write(tlbe) & ~TLB_INVALID_MASK;
>       }
>   
>       /*
> @@ -1874,11 +1885,11 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>           goto stop_the_world;
>       }
>   
> -    /* Collect tlb flags for read. */
> -    tlb_addr |= tlbe->addr_read;
> +    /* Collect tlb flags for read and write. */
> +    flags &= tlbe->addr_read | tlb_addr_write(tlbe);
>   
>       /* Notice an IO access or a needs-MMU-lookup access */
> -    if (unlikely(tlb_addr & (TLB_MMIO | TLB_DISCARD_WRITE))) {
> +    if (unlikely(flags & (TLB_MMIO | TLB_DISCARD_WRITE))) {
>           /* There's really nothing that can be done to
>              support this apart from stop-the-world.  */
>           goto stop_the_world;
> @@ -1887,11 +1898,11 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
>       full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>   
> -    if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
> +    if (unlikely(flags & TLB_NOTDIRTY)) {
>           notdirty_write(cpu, addr, size, full, retaddr);
>       }
>   
> -    if (unlikely(tlb_addr & TLB_FORCE_SLOW)) {
> +    if (unlikely(flags & TLB_FORCE_SLOW)) {
>           int wp_flags = 0;
>   
>           if (full->slow_flags[MMU_DATA_STORE] & TLB_WATCHPOINT) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


