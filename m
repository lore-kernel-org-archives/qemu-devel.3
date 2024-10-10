Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B92CEDDA3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 00:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syglk-0000ha-UJ; Wed, 09 Oct 2024 20:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygli-0000gN-1g
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:11:02 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syglg-0001sy-66
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:11:01 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7db90a28cf6so1093130a12.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 17:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728519058; x=1729123858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NaRmKnK0sOe7YHiifiFufAPMmqmP8oGQl4kXWwOmgXg=;
 b=GG2+0CW8zOv3gDk7W1ZdLKPY2eJwKNiEQjzvgKb72uQKS8TcPT6MdNhXiBWMTEMc5C
 qJPIOFKJEnNOtnz1nXM6gQf1QMxB+PqCWyyZMWbPQr9qrYDs3YtAJmyQb94O8DwdR44t
 ZklfugaNohFMkK+S+WfBEwiIhDHpVxAilKcKG5B4hFHXiXfZw2AC47fal8BLJfLS/Y5g
 a8YnPacALw8Ot0PnPru5FwVXNhEpzfeEbPkRc0OJXg8FVS6su6lOENaMnRwlh53IDoDW
 J/+83bznjszGj1hV6vx1WGzCpfKo2TZDr5957rZ8Hrw+6cCRGQe2vAjpiXm4C3cBoOVX
 QwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728519058; x=1729123858;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NaRmKnK0sOe7YHiifiFufAPMmqmP8oGQl4kXWwOmgXg=;
 b=qQCxg2VrQAKctOkT20JvZa0uSZIC2mLRZRBZ0hBYATRTe4xHe+Ax6WdLBP5xXu/sbD
 6lE5vknDHWwDkPMPrKBzmS8Dtq7Op00YKfiOMY9KY8zdMUjoMTECLkcXNX+p8D7bMoMj
 qluAVSdb7fdYRZzfUryn0rkqroTmChpIXATYOjl8qtlkVTo5P0mW3ey2nLyoFOh3giuV
 FfpzkIB9ZK74PhageWtOqk6v4M4PC50qt7Mwt86aaK0jCv6jUPpZL78g+BMN7p7T/yAZ
 CnGpBof7x+g5UoE2hNq2WKyQRS2/p+UL6Rjhgy3b9l8VKwx8DAaV21OnWWj0idVTADUE
 3nRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0qEE7vQhKxo6eiGzs0aCkYUuFLRrSdPrlGENI+WR1qY8gb3xdmZWRVE/R/WIsYRu2/Ye8WioHPKob@nongnu.org
X-Gm-Message-State: AOJu0YwqNp5IHKvbmIoMlnUsMmMzUdI0zEOM5nYLTlUG4Gy6wZr0qob+
 g5POE1xbeGcFw5dL1QnAPSroNzfkcY4i3LfF4zmMQTXMhbPcE6KRpqo+EPXgb0eXGaepMjhHqxw
 TjfI=
X-Google-Smtp-Source: AGHT+IFHzoHSFZMQgbGWVosWhqmUf3dT7dMft5rkjy/PrD089SKhJxH6lIJetO9Ja/2IZYXfdAsoHQ==
X-Received: by 2002:a17:90a:ee8e:b0:2d8:85fc:464c with SMTP id
 98e67ed59e1d1-2e2c8059fe0mr2201340a91.11.1728519058370; 
 Wed, 09 Oct 2024 17:10:58 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a571a2ecsm2322682a91.33.2024.10.09.17.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 17:10:57 -0700 (PDT)
Message-ID: <a55f268b-ca9c-49b9-b6f2-8bb9c0b966d0@linaro.org>
Date: Wed, 9 Oct 2024 17:10:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/23] accel/tcg: Replace victim_tlb_hit with tlbtree_hit
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-15-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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
> Change from a linear search on the victim tlb
> to a balanced binary tree search on the interval tree.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 62 +++++++++++++++++++++++-----------------------
>   1 file changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index ec989f1290..b10b0a357c 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1398,36 +1398,38 @@ static void io_failed(CPUState *cpu, CPUTLBEntryFull *full, vaddr addr,
>       }
>   }
>   
> -/* Return true if ADDR is present in the victim tlb, and has been copied
> -   back to the main tlb.  */
> -static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
> -                           MMUAccessType access_type, vaddr page)
> +/*
> + * Return true if ADDR is present in the interval tree,
> + * and has been copied back to the main tlb.
> + */
> +static bool tlbtree_hit(CPUState *cpu, int mmu_idx,
> +                        MMUAccessType access_type, vaddr addr)
>   {
> -    size_t vidx;
> +    CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
> +    CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
> +    CPUTLBEntryTree *node;
> +    size_t index;
>   
>       assert_cpu_is_self(cpu);
> -    for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
> -        CPUTLBEntry *vtlb = &cpu->neg.tlb.d[mmu_idx].vtable[vidx];
> -        uint64_t cmp = tlb_read_idx(vtlb, access_type);
> -
> -        if (cmp == page) {
> -            /* Found entry in victim tlb, swap tlb and iotlb.  */
> -            CPUTLBEntry tmptlb, *tlb = &cpu->neg.tlb.f[mmu_idx].table[index];
> -
> -            qemu_spin_lock(&cpu->neg.tlb.c.lock);
> -            copy_tlb_helper_locked(&tmptlb, tlb);
> -            copy_tlb_helper_locked(tlb, vtlb);
> -            copy_tlb_helper_locked(vtlb, &tmptlb);
> -            qemu_spin_unlock(&cpu->neg.tlb.c.lock);
> -
> -            CPUTLBEntryFull *f1 = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
> -            CPUTLBEntryFull *f2 = &cpu->neg.tlb.d[mmu_idx].vfulltlb[vidx];
> -            CPUTLBEntryFull tmpf;
> -            tmpf = *f1; *f1 = *f2; *f2 = tmpf;
> -            return true;
> -        }
> +    node = tlbtree_lookup_addr(desc, addr);
> +    if (!node) {
> +        /* There is no cached mapping for this page. */
> +        return false;
>       }
> -    return false;
> +
> +    if (!tlb_hit(tlb_read_idx(&node->copy, access_type), addr)) {
> +        /* This access is not permitted. */
> +        return false;
> +    }

This is not something we were checking before. If this is an addition, 
maybe it would be better to split this out of this commit. Or maybe I 
missed a step in previous commits :)

> +
> +    /* Install the cached entry. */
> +    index = tlbfast_index(fast, addr);
> +    qemu_spin_lock(&cpu->neg.tlb.c.lock);
> +    copy_tlb_helper_locked(&fast->table[index], &node->copy);
> +    qemu_spin_unlock(&cpu->neg.tlb.c.lock);
> +
> +    desc->fulltlb[index] = node->full;
> +    return true;
>   }
>   
>   static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
> @@ -1469,7 +1471,7 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
>       CPUTLBEntryFull *full;
>   
>       if (!tlb_hit_page(tlb_addr, page_addr)) {
> -        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, page_addr)) {
> +        if (!tlbtree_hit(cpu, mmu_idx, access_type, page_addr)) {
>               if (!tlb_fill_align(cpu, addr, access_type, mmu_idx,
>                                   0, fault_size, nonfault, retaddr)) {
>                   /* Non-faulting page table read failed.  */
> @@ -1749,8 +1751,7 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
>   
>       /* If the TLB entry is for a different page, reload and try again.  */
>       if (!tlb_hit(tlb_addr, addr)) {
> -        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type,
> -                            addr & TARGET_PAGE_MASK)) {
> +        if (!tlbtree_hit(cpu, mmu_idx, access_type, addr)) {
>               tlb_fill_align(cpu, addr, access_type, mmu_idx,
>                              memop, data->size, false, ra);
>               maybe_resized = true;
> @@ -1929,8 +1930,7 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       /* Check TLB entry and enforce page permissions.  */
>       flags = TLB_FLAGS_MASK;
>       if (!tlb_hit(tlb_addr_write(tlbe), addr)) {
> -        if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
> -                            addr & TARGET_PAGE_MASK)) {
> +        if (!tlbtree_hit(cpu, mmu_idx, MMU_DATA_STORE, addr)) {
>               tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
>                              mop, size, false, retaddr);
>               did_tlb_fill = true;

Else, hurrah!
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

