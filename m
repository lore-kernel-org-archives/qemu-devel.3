Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAB6CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 14:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8JXk-0001Yu-5V; Mon, 13 Oct 2025 10:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8JXj-0001Ym-5Y
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 10:28:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8JXb-0005Hy-Jk
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 10:28:54 -0400
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so1997556f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760365725; x=1760970525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8h9fUM+Hk0zw6TerfJguiP6zeSyIMvkdbuS4MMpGq+c=;
 b=mUVIF1lXqnoIeY0T7bNmX5RsD+Bg+QV1f4BiuiNsXDxX7hrDmhyA6sDXvq52Nwi6Xp
 klAgMs5Ztqhx9C9AUV+vdyhbGUQuU+J/o93H6OjygLarsWGMdYUcFNcUY2pOWZxHJJN2
 06nMVvgSUfehI80f9h6kkwQ2sveDkw+IyfGXZU4mU/rVEWqyYzFdrVmC6eRHt5EYhtL1
 0RlUMikwYUyce1HFEH9WqKco9rmTpJOCUvm06JDv6LJL3QWxBIaXNf8QLYCfUkVuYh89
 OrV5TcvbWTdpW//yNSom9+ZtkO1Sy+wIWYnEQzvGDincMo3CFvPxxR6srfQmOiDUUDxn
 P6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760365725; x=1760970525;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8h9fUM+Hk0zw6TerfJguiP6zeSyIMvkdbuS4MMpGq+c=;
 b=nXKWA9CN1hrR1jFeAagj/M9NNiVj6P3loSDuCtb1vXQw9OVm/v3Td9ndL7wzsp7Bd2
 CIs2ri0A5EXdokD9hMTtyyKDVKjO1xv0ahPgrj509IGhmWXEtlRr/yyjkSlz/YpNBPDX
 ouYdv2AGcCxIJdPedNHpb3beygPi5CXZzrbXESAuOYc3fz8cAfCBxQpZIetVMM8Az/Uq
 HQwb21XfB7ZNODFiyDmU/LUeELx0CH+IiEHlcae1KtLysq5KaIXUUtSJZxfzs4zn/qVl
 WgHBqbTMNul8DWVOSBZmAyyVfC3V4qdhqMUAl/ibkIsSfajmrKB3t/6o8JwQqnlESjzj
 2BbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVFSrgA88UKCQqXNcX5x/kXihgBeFlNMNJBbdaOhG40NhQfWJvXIaxigAjYhzRT/d+MrEonAjCZNSC@nongnu.org
X-Gm-Message-State: AOJu0Yxk14u0R/ahUFJGMU71RbP5yPUT/GBrwjlcWWRmYlsUrdoJFyIR
 I9aYHAj4cF9cmdODTwjB3YIqJrtYRtCvSscpAsjqaUbhOOmMmOKOeD8Z+PHDRqXuqkQ=
X-Gm-Gg: ASbGncu2r3AB2c4nMnxvpUuCN5kBFfz02DEH5Pmt1nThcIyvQEwGXGYY+jwXHUClh2N
 DkGP0xChIjUopKUcM9rjSgT1uxuWzqKFu2PKuBVUcINltfT/U2sPDiItCSGyrvV/mMbbZeS5RwM
 gAt+sTaG//dWrR5IZ0NCwbZr2hibgyxfThPfbvw2WhraBPelp8adBskfhXAvYALD4mILAp8KMOp
 9n2Vfnvm2JSEN3UGurpwXaPwWfqeJgPe/3NmkNUfPTFJ/wD/uE+c9Bwv307ckEUSrmY6FW/5S0H
 W3y2x//t8kmpqvGeXMnxXEWqs0002R2tPhLZ0zCr/vWYJyktkgT4rjK4mM2NnTd3g7zXmHgXN5o
 bP61ttD9GnkgMXCokGoyOOSYWndDUnHaMLPUn/3LdpvejLfRepMQoq04ZuyabocAUge8g/ZvrZ7
 7kQkVN/yaH3z8feq5EGubfVcA=
X-Google-Smtp-Source: AGHT+IHQ9R5swp+7pEjgE1/7ZvCBb4WdMDNUhywv3/pNwPkfnLtndBo0lvd0BtQUXMLnYr0NMmn1bw==
X-Received: by 2002:a05:6000:40da:b0:3f8:8aa7:465d with SMTP id
 ffacd0b85a97d-4266e7d4580mr12476876f8f.30.1760365724592; 
 Mon, 13 Oct 2025 07:28:44 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e8b31sm18705704f8f.54.2025.10.13.07.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 07:28:44 -0700 (PDT)
Message-ID: <e897e120-df6a-4482-82fa-0d1d703cf4b3@linaro.org>
Date: Mon, 13 Oct 2025 16:28:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Hoist first page lookup above pointer_wrap
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, qemu-stable@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251004192414.1404950-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251004192414.1404950-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

On 4/10/25 21:24, Richard Henderson wrote:
> For strict alignment targets we registered cpu_pointer_wrap_notreached,
> but generic code used it before recognizing the alignment exception.
> Hoist the first page lookup, so that the alignment exception happens first.
> 
> Cc: qemu-stable@nongnu.org
> Buglink: https://bugs.debian.org/1112285
> Fixes: a4027ed7d4be ("target: Use cpu_pointer_wrap_notreached for strict align targets")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 2a6aa01c57..a09c2ed857 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1744,6 +1744,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>                          uintptr_t ra, MMUAccessType type, MMULookupLocals *l)
>   {
>       bool crosspage;
> +    vaddr last;
>       int flags;
>   
>       l->memop = get_memop(oi);
> @@ -1753,13 +1754,15 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>   
>       l->page[0].addr = addr;
>       l->page[0].size = memop_size(l->memop);
> -    l->page[1].addr = (addr + l->page[0].size - 1) & TARGET_PAGE_MASK;
> +    l->page[1].addr = 0;
>       l->page[1].size = 0;
> -    crosspage = (addr ^ l->page[1].addr) & TARGET_PAGE_MASK;
>   
> +    /* Lookup and recognize exceptions from the first page. */
> +    mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
> +
> +    last = addr + l->page[0].size - 1;
> +    crosspage = (addr ^ last) & TARGET_PAGE_MASK;
>       if (likely(!crosspage)) {
> -        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
> -
>           flags = l->page[0].flags;
>           if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
>               mmu_watch_or_dirty(cpu, &l->page[0], type, ra);
> @@ -1769,18 +1772,18 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>           }
>       } else {
>           /* Finish compute of page crossing. */
> -        int size0 = l->page[1].addr - addr;
> +        vaddr addr1 = last & TARGET_PAGE_MASK;
> +        int size0 = addr1 - addr;
>           l->page[1].size = l->page[0].size - size0;
>           l->page[0].size = size0;
> -
>           l->page[1].addr = cpu->cc->tcg_ops->pointer_wrap(cpu, l->mmu_idx,
> -                                                         l->page[1].addr, addr);
> +                                                         addr1, addr);
>   
>           /*
> -         * Lookup both pages, recognizing exceptions from either.  If the
> -         * second lookup potentially resized, refresh first CPUTLBEntryFull.
> +         * Lookup and recognize exceptions from the second page.
> +         * If the lookup potentially resized the table, refresh the
> +         * first CPUTLBEntryFull pointer.
>            */
> -        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
>           if (mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra)) {
>               uintptr_t index = tlb_index(cpu, l->mmu_idx, addr);
>               l->page[0].full = &cpu->neg.tlb.d[l->mmu_idx].fulltlb[index];

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


