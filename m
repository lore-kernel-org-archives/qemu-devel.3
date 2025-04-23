Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0667C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WxF-0000Rk-WF; Wed, 23 Apr 2025 06:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WxC-0000Lq-Gu
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:03:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Wx4-0002EW-CK
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:03:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso51020115e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745402612; x=1746007412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EVo5jxIlrjhDneSFPnthlYb1oHlfufRmjgTTX0MzmTY=;
 b=u5JR1fREWQJx/OStxzA3siivBZ2Ro7ktJsrWK59aCJbenvM6qEnOwOsE31cpTSgPJt
 t4LqSGUhcO8z5w6KoeQnJbnSXA22R4hMG6AvJv04bngvb4KCKz711Afpx8yAbpRUEkEx
 P1Azo/wPc7p+/uoN5L7IBP8HpqcelXejYjnNkb2wocTJw7N++k3TpwRVENaC8RGVzSeo
 xF9K5yx6DJ9v5+3djEgkYAWX6xmyRTaw4K4wju87BC+sho9jo8chGHjpmEPtwcqYceAf
 AeHbT9RDCKcsZptP+LPm9pXo+oEeq4tgw/5OamZiSDgwnrgm80k2gheKnFmy+A2ZYHtt
 ldmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745402612; x=1746007412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EVo5jxIlrjhDneSFPnthlYb1oHlfufRmjgTTX0MzmTY=;
 b=QdGsR/uapQNDDHE10shoe+NKRHxtGIJMNlNP8y27z15f4PIaRLZn6IUHif6NwaGaKW
 YpABCCZln1qhEyEl2gMMqK7S46/12nqwsiEDHNHTCGF3f6l6dQiqXNZoUBQa2rNV6Gte
 a01oy382u+WcMcm0tJ3iV+XBDzWHPkwZjMLtoFdqjIKr5anVlNCm/nYqcXZHPOrBKesi
 A4OGgRL3Fi8rNTrg2sIGaLe/ceb4qSTCjkvacsjFn9MjnT4UyIog39eyb57pP18gN3Wq
 HChHyK0LsNIDQG89919xLk8Yy2XPBS+GaNABLL1MDy/O5LbpBRjr/laQ1muauNyLI+MN
 xO5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUvpSdvOQd+ZzbIubT6hD1yhKxkqCRZIlD96s7yB28Uyf5wdhbqZXbPHAnnQwmih+BkU5qC95WlSmd@nongnu.org
X-Gm-Message-State: AOJu0Yzr/iQRTyL5U9E9lF0kaDDp/vtEyWYWTKeVGEOtfuHMlxVa27oD
 cpTjUtI5Mxr38QqqKa6c2nyCS1FQevAJNRWR+blOQ3WLZdN3ky6Jh5M4ySjLbtXTfP5W1+siKtV
 b
X-Gm-Gg: ASbGncsGJ3QH7jLOyY/iCNxiQ6iOx/ZMBZytvcXpcb1CCC9lnFv7crPu2j5+P7aUj9x
 Ilg9yodFAW1mqKlnjcDvev0ZDBpER1qK7yY6AOI9ochdsH5r4LVf5x3ksZLN5VVHz2fJQLr0W1E
 LYp2tzswELPVuXhAVpwEKci1lwWwXL9DaG//yGMTYFA6atli6q/5eTG71pElAUHWcZ8FlqEihPC
 XttYbGFcWz7H/IAx6daQyj7XWVE/iX4B3sCe9MIgxC75mKQPhE5XySfA2KU/KylRsDcfRKNDnPl
 Ab8BUA2uWu1e1wQjeJBb+A5ddoS7uDwl9hQVQxQiGihqkSs9e3V0AqFkCBPQ9Wm37VX6aIv2om4
 cm8pyREnA
X-Google-Smtp-Source: AGHT+IEj9iNZ3DXU1IZ/Y/TJj+patnGMLpzCtsXUQq9Axcr4JvlvBo6BkBFUSZKItIKLDI7LaguI9w==
X-Received: by 2002:a05:600c:3d86:b0:43c:f332:703a with SMTP id
 5b1f17b1804b1-4406ac1046fmr189557095e9.31.1745402612539; 
 Wed, 23 Apr 2025 03:03:32 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa433170sm18011779f8f.25.2025.04.23.03.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:03:32 -0700 (PDT)
Message-ID: <071a47a7-bc91-4f1b-8901-fc523444ca14@linaro.org>
Date: Wed, 23 Apr 2025 12:03:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 064/147] accel/tcg: Pass CPUTLBEntryFull to
 tlb_reset_dirty_range_locked
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-65-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-65-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Richard,

On 22/4/25 21:26, Richard Henderson wrote:
> While we're renaming things, don't modify addr; save it for
> reuse in the qatomic_set.  Compute the host address into a
> new local variable.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 10090067f7..5df98d93d0 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -882,18 +882,16 @@ void tlb_unprotect_code(ram_addr_t ram_addr)
>    *
>    * Called with tlb_c.lock held.
>    */
> -static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
> +static void tlb_reset_dirty_range_locked(CPUTLBEntryFull *full, CPUTLBEntry *ent,
>                                            uintptr_t start, uintptr_t length)
>   {
> -    uintptr_t addr = tlb_entry->addr_write;
> +    const uintptr_t addr = ent->addr_write;

Can we introduce 'int flags' here, and add the CPUTLBEntryFull
argument in the following patch?

>   
>       if ((addr & (TLB_INVALID_MASK | TLB_MMIO |
>                    TLB_DISCARD_WRITE | TLB_NOTDIRTY)) == 0) {
> -        addr &= TARGET_PAGE_MASK;
> -        addr += tlb_entry->addend;
> -        if ((addr - start) < length) {
> -            qatomic_set(&tlb_entry->addr_write,
> -                        tlb_entry->addr_write | TLB_NOTDIRTY);
> +        uintptr_t host = (addr & TARGET_PAGE_MASK) + ent->addend;
> +        if ((host - start) < length) {
> +            qatomic_set(&ent->addr_write, addr | TLB_NOTDIRTY);
>           }
>       }
>   }
> @@ -918,16 +916,18 @@ void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
>   
>       qemu_spin_lock(&cpu->neg.tlb.c.lock);
>       for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
> +        CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
> +        CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
> +        unsigned int n = tlb_n_entries(fast);
>           unsigned int i;
> -        unsigned int n = tlb_n_entries(&cpu->neg.tlb.f[mmu_idx]);
>   
>           for (i = 0; i < n; i++) {
> -            tlb_reset_dirty_range_locked(&cpu->neg.tlb.f[mmu_idx].table[i],
> +            tlb_reset_dirty_range_locked(&desc->fulltlb[i], &fast->table[i],
>                                            start, length);
>           }
>   
>           for (i = 0; i < CPU_VTLB_SIZE; i++) {
> -            tlb_reset_dirty_range_locked(&cpu->neg.tlb.d[mmu_idx].vtable[i],
> +            tlb_reset_dirty_range_locked(&desc->vfulltlb[i], &desc->vtable[i],
>                                            start, length);
>           }
>       }


