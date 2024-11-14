Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88850D6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeET-00056j-9o; Thu, 14 Nov 2024 13:06:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeEI-00054u-3f
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:06:11 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeEE-0003NC-Lf
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:06:04 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e2dc61bc41so764805a91.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607561; x=1732212361; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Vwx0KVAT9TB13u09SSCdbW8wVSRMT8CBqutgOr+noQ=;
 b=SwP10MkkqVyb7rFgceJOaMkYqVf3xB0sfs7IFXwjs5wYQPQIhV+mVTNSkCZrT4puRu
 9Z+PBcbOWa6y/Ks7MWa+D3ADd4W7pF9I6B1J5sFkXTLNzRir5iV3+IQfpz48+C9tgh/u
 /QxQbFXWKjfuhBUInisPVT/BOYA4taHaumT1ryefV0eZWNH3SPuhLgMXQXnSC1gVSjW4
 +ROcMJWgwCemK61GnsbUT+ywskND7euc0pbd+6QpBxdIAlYG5JXI/ZjosRUcqarmGyrZ
 u3D/d5QpFyzAlDk7Uc7yHoN2SzPk1dc9SlDAAJXd+7ZlRgVioFQ8s+s3eVObB99OFG72
 XP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607561; x=1732212361;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Vwx0KVAT9TB13u09SSCdbW8wVSRMT8CBqutgOr+noQ=;
 b=KMDqrt9KQVAqgxUKfgfz1+dxaoq3w1DjdwB1Wu6NrvjaFQkQxUbRs86/WP528EqWMP
 4lUFEnzsf3qW9O6vlMode/Ow/YgVZH5LpvYcMlTAWc29J5H7M0luJN4RzX8qTn+d42h4
 d03Dbd/P5K1OOKdF48rL3UmFMcbymV86JpItvB5tICBgTZRFK0xI3QlOg72cCFxCjIVW
 bRYmGl9ptZ2ZLeWizsEKRKs+GZgSiQ+GYuX5FcfdPjkUFzy8PZ8m5iiee0AWrzYWdmmC
 9mGjGHbGRa7IlCfzvQ2OV6xBJc21jGz02pV/Yg9xOCtwNoXmtGHDFsMw2HoClOaa3Gw2
 Ic5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaulgVFmazgn8+pPmNVTEtpEBmgcS19pjittLNR5w8V8k1Z2oSLq6O+7d9Cell0UCNlJ8oM3kqRAe2@nongnu.org
X-Gm-Message-State: AOJu0Yz8gl2gg9zb1rxUYM+pDlxtctmtuma0WDNAR/ugW0i7bJwvx6ej
 ARvNwG7vq6w7JnQC+HFvWyrzTOhck0WoNb6pdEET5T02VqKZuUhygS7Rpsh/lCA=
X-Google-Smtp-Source: AGHT+IE4uYVnumnXSGvg2J2ENzKIvIBBLGz43amRXQiCfkwKyN+UkKOZDDwMoG0DofwVsHmGaoI7qQ==
X-Received: by 2002:a17:90b:2890:b0:2e2:991c:d7a6 with SMTP id
 98e67ed59e1d1-2ea06320aa7mr3502030a91.19.1731607561091; 
 Thu, 14 Nov 2024 10:06:01 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea141b7dafsm108117a91.20.2024.11.14.10.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:06:00 -0800 (PST)
Message-ID: <c8fca764-69eb-4cca-b864-71e33e08d60a@linaro.org>
Date: Thu, 14 Nov 2024 10:06:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/54] accel/tcg: Replace victim_tlb_hit with
 tlbtree_hit
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-18-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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
> Change from a linear search on the victim tlb
> to a balanced binary tree search on the interval tree.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 59 ++++++++++++++++++++++++----------------------
>   1 file changed, 31 insertions(+), 28 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 3aab72ea82..ea4b78866b 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1384,35 +1384,38 @@ static void io_failed(CPUState *cpu, CPUTLBEntryFull *full, vaddr addr,
>       }
>   }
>   
> -/* Return true if ADDR is present in the victim tlb, and has been copied
> -   back to the main tlb.  */
> -static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
> -                           MMUAccessType access_type, vaddr addr)
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
> -
> -        if (tlb_hit(tlb_read_idx(vtlb, access_type), addr)) {
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
> @@ -1453,7 +1456,7 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
>       CPUTLBEntryFull *full;
>   
>       if (!tlb_hit(tlb_addr, addr)) {
> -        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, addr)) {
> +        if (!tlbtree_hit(cpu, mmu_idx, access_type, addr)) {
>               if (!tlb_fill_align(cpu, addr, access_type, mmu_idx,
>                                   0, fault_size, nonfault, retaddr)) {
>                   /* Non-faulting page table read failed.  */
> @@ -1733,7 +1736,7 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
>   
>       /* If the TLB entry is for a different page, reload and try again.  */
>       if (!tlb_hit(tlb_addr, addr)) {
> -        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, addr)) {
> +        if (!tlbtree_hit(cpu, mmu_idx, access_type, addr)) {
>               tlb_fill_align(cpu, addr, access_type, mmu_idx,
>                              memop, data->size, false, ra);
>               maybe_resized = true;
> @@ -1912,7 +1915,7 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       /* Check TLB entry and enforce page permissions.  */
>       flags = TLB_FLAGS_MASK;
>       if (!tlb_hit(tlb_addr_write(tlbe), addr)) {
> -        if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE, addr)) {
> +        if (!tlbtree_hit(cpu, mmu_idx, MMU_DATA_STORE, addr)) {
>               tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
>                              mop, size, false, retaddr);
>               did_tlb_fill = true;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


