Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C206C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UFd-0007No-Rd; Mon, 28 Apr 2025 15:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9UFY-0007Er-S1
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:34:44 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9UFL-0000gm-1l
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:34:35 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso7436339b3a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745868862; x=1746473662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kjkhy3ikd8CXT2fFKdXcFGxLzOU+pRXCSrkDx2UIFXs=;
 b=GCjRdI3sXe53yvMMUMVzQrmaA4tLl7Q86y28Y8ssEmXx3EUVQn/c41PGq7DPvtRI2m
 ZR15eWz8d+49JLkvDWVUml1kl2DH0q+C7qNoZCOcqeDaxwMAdfZhwaxOZLB5UKWNfgBI
 Jq2EZZfxc5bf1kvqqEsFdTjrlznAERO4zkHfe7gyAgH1nAN2nAWDCuf/9iKHcGRXPDH0
 KfOmGL3PhIh5oBaAH3os6HwTnmRoQbl/kzFYhy015SMaZBDbhvwDqo+COvAAJX6nO48G
 Q3sg8paEnOzKqeKSoR57QVRJp7Z4oZy0t9+wrJeyhhkhkN9WhFRbgKn5sAJyAlEQbq0D
 X2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868862; x=1746473662;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kjkhy3ikd8CXT2fFKdXcFGxLzOU+pRXCSrkDx2UIFXs=;
 b=FJS3wn9/bGC0dvJZ7KNMGFbX7AiGdp1bVlOkdhCQ3BygMoEnsG2+fNfWYt8yc60nhk
 uYFXRusnYe7mx4P0KLuM4J6wUS6C8zQ9I5Rb6jm30FeKvim2cPSh/v18M2sPxruJBGnP
 1wAws8E3QVBLrIR8e09oMgIBQ7d1dIglm4IOGeS3RRudMGJ+0yL9ChvA9xaE9jMESXxr
 DUs5mTpWgn3hb8c2w0A1tgQ+p1JrnLhRR8Li8U4KFTJb7DvLqnzTymbonYnGyWdIPqRS
 0nThmaSBc5SZdk1KeUAcCxEat0j7qpxftZ2OYBPSCCjVHL3MTe3TK1A3DQFcxGTh4vZj
 IsgQ==
X-Gm-Message-State: AOJu0YxnxRFol6q/AscuaFVOMuA+6qVxXptsuvV6arQaYJvho3vZA+xq
 xt/ykErVeEFCGHMa/fq6pRrmbHbs+xDj86hh6/d+XL8lEdh61hqsz9p3jeczh2AcFPG9mjYgqvU
 q
X-Gm-Gg: ASbGncv/fbPjGVb6B8MdpwKEk9bG9kUhXh6cl2Or9b7QYCGwXxm/rJcwzV4Snjyg9bH
 v6y8TB8pHHID8A7EXR5oOrLR2gDG96Cfvm2oYih3Z/y/Xsy8gy8C/zT1tYCRRIfSmIVTQC69G/V
 2JSCMmuU/jTUoGVDmVsFY5aX3SMQ318JAhASEZ2J+szqiPMxq9mCRhEl45Kc4GRA+idROnqc33M
 iKR/63XcbgV7oUQNRMFgIL6ThdjCeGs+p5U3+zzjRhP33gqVTxGsOLcZFUv2Fx8PXStkg7b9zsx
 QEabKPyyo0DeAu0BV/misfjsXDeQ59h/fo20N6dteZf54F3oBcs4SQ==
X-Google-Smtp-Source: AGHT+IEJWR+Uz3DVZt9KYdu/mdHKD/zYJTerY5PAWb7H6QufO5JSs9PaYWwSKLe04QZ0UQGibGtN4A==
X-Received: by 2002:a05:6a20:c90d:b0:1f5:5b2a:f629 with SMTP id
 adf61e73a8af0-2046a6930a2mr15102046637.30.1745868862413; 
 Mon, 28 Apr 2025 12:34:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25914238sm8435744b3a.7.2025.04.28.12.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:34:21 -0700 (PDT)
Message-ID: <21843e8d-cdbc-4f84-a652-01ee467f2dc7@linaro.org>
Date: Mon, 28 Apr 2025 12:34:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] target/arm: fix arm_cpu_get_phys_page_attrs_debug
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 Yannis Bolliger <yannis.bolliger@protonmail.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250414153027.1486719-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250414153027.1486719-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/14/25 8:30 AM, Pierrick Bouvier wrote:
> It was reported that QEMU monitor command gva2gpa was reporting unmapped
> memory for a valid access (qemu-system-aarch64), during a copy from
> kernel to user space (__arch_copy_to_user symbol in Linux) [1].
> This was affecting cpu_memory_rw_debug also, which
> is used in numerous places in our codebase. After investigating, the
> problem was specific to arm_cpu_get_phys_page_attrs_debug.
> 
> [1] https://lists.nongnu.org/archive/html/qemu-discuss/2025-04/msg00013.html
> 
> When performing user access from a privileged space, we need to do a
> second lookup for user mmu idx, following what get_a64_user_mem_index is
> doing at translation time.
> 
> This series first extract some functions, and then perform the second lookup
> expected using extracted functions.
> 
> Besides running all QEMU tests, it was explicitely checked that during a linux
> boot sequence, accesses now report a valid physical address inconditionnally
> using this (non sent) patch:
> 
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -997,9 +997,7 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
>       if (enable) {
>           address |= flags & TLB_FLAGS_MASK;
>           flags &= TLB_SLOW_FLAGS_MASK;
> -        if (flags) {
>               address |= TLB_FORCE_SLOW;
> -        }
>       } else {
>           address = -1;
>           flags = 0;
> @@ -1658,6 +1656,10 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
>           tlb_addr = tlb_read_idx(entry, access_type) & ~TLB_INVALID_MASK;
>       }
> 
> +    vaddr page = addr & TARGET_PAGE_MASK;
> +    hwaddr physaddr = cpu_get_phys_page_debug(cpu, page);
> +    g_assert(physaddr != -1);
> +
>       full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>       flags = tlb_addr & (TLB_FLAGS_MASK & ~TLB_FORCE_SLOW);
>       flags |= full->slow_flags[access_type];
> 
> v2:
> - fix style in first commit (philmd)
> 
> Pierrick Bouvier (4):
>    target/arm/ptw: extract arm_mmu_idx_to_security_space
>    target/arm/ptw: get current security_space for current mmu_idx
>    target/arm/ptw: extract arm_cpu_get_phys_page
>    target/arm/ptw: fix arm_cpu_get_phys_page_attrs_debug
> 
>   target/arm/ptw.c | 65 +++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 48 insertions(+), 17 deletions(-)
> 

Gentle ping on this series.
Any plan to queue it to tcg-next @Richard?

Regards,
Pierrick

