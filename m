Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD26D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBe9R-00080T-Pa; Thu, 14 Nov 2024 13:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe8w-0007jR-0Z
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:00:41 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe8t-0002Qw-JU
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:00:33 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e9e377aeadso749658a91.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607229; x=1732212029; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vrehIPsZm9eziuLg9OVENvB+s77/3Vtpkt6oSD0lO6E=;
 b=sDFDrNy0+0IjrWvlLb9EStoRwxxjbXSLxOw2W3BiOGSj19+SB/JabzpU4wWFOFaRIW
 0e5nUVKbXwUf+umaz19YKBpxm4sLvpzohOhAE69FLvJN5V0fVv3a4u/Nt/gBE5hx3aes
 o3rl/nCkYq6epMp13NKr2QCvH/IwpqsIBFiUz50wPdDiCWXSC6Hz2V4X0oNZFr6AJVkc
 oIetpcqauqjGS94f2YKuyRMGVvv4OgnmL7WCODuaK9/GlsawG3Sv2NHBUeSwb63tPFSh
 85Fkj5Q9rOXD80TZ1t0GXfA0xWQa8zPl0XHlat3XWI6yPSTngwjAsGLCnHmZcUzW/5Rr
 LHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607229; x=1732212029;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vrehIPsZm9eziuLg9OVENvB+s77/3Vtpkt6oSD0lO6E=;
 b=lgrYLKNOFM3Mmeo3TNsruh+r3Iw/PbTE2U6cDEIgjTmDwVx2/B2cSEkIbhX1nt8kw6
 xmA9VdkZ7Z8521HLyHAcYkyB+QZDRSZlJyYPPDbh9BVuZC1wc1Utc0qcU4qXbtppgJbm
 Ha11OqZZORc7kdbvNp0zrYG64DdzLNXSrng/jsar0M2G8ISc6JF3BED5OD1zpDmPQTmG
 4PE0D/mfPpa2UZnl++/Ci52P2+6C1rNNUeNx/uAOJJPP1/M8VQVPEAoAMCvLQoedTgDQ
 5FYI5r2h7VmgAlSt5z3v8pC83J3BysAX5817xeujjTF3mqxI0AuoPoddsFK4dmgVmOx5
 cnag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGaNjCEYMApDE+srogb7Y9btmJEV4rr6vtrbdjY8hGghXSW/PnZfNG+E43eMRp3pclRoOD1zALXKxC@nongnu.org
X-Gm-Message-State: AOJu0Yx7Dy8WwU7rOwea4JhQ3wbo6NRd4XY7WHNLataAsjQCVWCg4zr1
 KXxiqkzPta4LbtSLud6mrpttq1j6TnT97Bw2MrtZjzPtzO2LVmtx9X7vDykM3Kk=
X-Google-Smtp-Source: AGHT+IHhgsmThqISZ6VXpoe6ViUDYqeJWBEsDx/TWaLsuwjYRnDMtmhL/Vb4UPbKG3l84z0OEvRJyQ==
X-Received: by 2002:a17:90b:3d8f:b0:2e2:c421:894b with SMTP id
 98e67ed59e1d1-2e9f2c7851amr9231444a91.14.1731607228318; 
 Thu, 14 Nov 2024 10:00:28 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea06fbb293sm1465914a91.48.2024.11.14.10.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:00:27 -0800 (PST)
Message-ID: <dcd8514f-c7cd-454d-bdc8-b93b8f61f045@linaro.org>
Date: Thu, 14 Nov 2024 10:00:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/54] accel/tcg: Populate IntervalTree in
 tlb_set_page_full
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-11-richard.henderson@linaro.org>
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
> index aa51fc1d26..ea6a5177de 100644
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
> @@ -1072,7 +1083,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       MemoryRegionSection *section;
>       unsigned int index, read_flags, write_flags;
>       uintptr_t addend;
> -    CPUTLBEntry *te, tn;
> +    CPUTLBEntry *te;
> +    CPUTLBEntryTree *node;
>       hwaddr iotlb, xlat, sz, paddr_page;
>       vaddr addr_page;
>       int asidx, wp_flags, prot;
> @@ -1180,6 +1192,15 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
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
> @@ -1201,15 +1222,15 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
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
> @@ -1218,10 +1239,11 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
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


