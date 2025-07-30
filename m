Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA330C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhE7F-0004QT-FI; Wed, 30 Jul 2025 17:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDuZ-0001dK-Qm
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:00:31 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDuX-00042p-Rc
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:00:31 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-748e378ba4fso359668b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753909227; x=1754514027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KRb8qNQ8g3APMYQr/mIoQAVqJELnOfZrY6AAqel+j5Y=;
 b=yFWon/eOBTFLwLLKNjump+8OdQg3GWBdfPonBgnMJzIhcL/2SRmXBBoFjaK33rhfjO
 h0TdEz9RRmcXNSsPlRJBMyfP+eaz4NQ2aOa/VEp+80zjhqKEZA4TxduYuc3Zw5uJZaHB
 jkYda1U5Ks3vO0pUCj2Qji/nbsDSVLqv/maRiX9oDoZv3UVaaCZMr30TzJOQKNqlA2cZ
 ZrlyatnpgfMp0VqjRoblQxnQCKTylX79UKNuOI3nvVgNCpsGG2780OIMxRVTsZA1m9sa
 ybJlhs87wA/I72p9iOomg10jdMfjC+Rzp1u8MBIqoFmrVoD23BsPPDup0gVDByOPG0Fg
 xbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753909227; x=1754514027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KRb8qNQ8g3APMYQr/mIoQAVqJELnOfZrY6AAqel+j5Y=;
 b=RSk7jnskqrGB9elMlMybzOmmE955AST0taFgrTE3MOW/c+MRlCNILJ5Yknfb4Gik1o
 itTVIfl/2YvoFP9nKtXutcfaGnZ+f8Fg3d80NQqO9zMbE6ZaE/1WO0/4kHvuXRtgcJZk
 j54pJ3eOLnqNjBW7m4wyDlXzsZPFaSgCclBcRdYlTdyX8A8nCqiRmHvTKqwqZdRgKT9u
 Jv6zB2eoTw9XSCa17phOoa05Qx/j4Adr2s64jUCqafuUPIhy8+Uiagzk4ZXvlxTA4tXA
 0Rhn4tqNZw2dznNisgizU1Q4IDrRGNcwXpnVMFsd15V5ioid9MOZ76Wxw28yKdsiaUcV
 NZiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtXo4klL01b01MTya8RIyTYIC8sXZHmBW9oZfIxMHjos+WTWSaeNEtn/XFIPOPzwiCXrLdMa/43B7C@nongnu.org
X-Gm-Message-State: AOJu0YyhImy20GrIcSw4BKWKxAsVRunLxPf3cvxfYNVxMTvD4GXPnQPi
 pGnfsmO/+Fc8woku37AzAS9Kc4oeSMqKFvYsh0zS5J/VrZxgpPW+Zl2jOQqGesGEr1o=
X-Gm-Gg: ASbGncsnYrvZYbk1v38wwK4dBm5hkANIJ3CV8qISUd+wMHHkCaT/zYH/cwgvTkl32Ve
 InpjXM1WxYgVVZxGiGBvPxfUjRMliyR1+jAJejRFSf83vSzjiLdotf7B5klfXKBuBgXbeWD+sBt
 eI4Hr0mb2hQEeGS8X+CJlr5O1K+U1ajonjuD5lwewVuwpKLozC3Neq7GJJi46fAqd/HEbbtL/wn
 eCyWS9s6MH4r48SAkFMAaPEzrjvX/pPka175pT6G6fYwhmfI6vwb3Q+0KTenzdqcsNFKkVrctY6
 iV+eTtFCH7gSfuTcE/o9zoI8wB6bVy2TIETC50dVzwGNid++VSD5NJMJab/rYe9xgpHvGrCbiIl
 WYnpVVBfED8Ry02pfwxAEOiOnANkSORe69+M=
X-Google-Smtp-Source: AGHT+IFmXAgs4aWfA+TTL7UUvBpHPwTn1yYuqvraSqbDyJPfqy/7/EaYRjnl8+1yXsPrbM0lMLs0Xw==
X-Received: by 2002:a05:6a00:2e1c:b0:748:ff39:a0ed with SMTP id
 d2e1a72fcca58-76ab30f5299mr6857813b3a.20.1753909226538; 
 Wed, 30 Jul 2025 14:00:26 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bc6e5c741sm716898b3a.33.2025.07.30.14.00.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:00:25 -0700 (PDT)
Message-ID: <5391401d-8d58-4f33-be8e-c3901553dfcc@linaro.org>
Date: Wed, 30 Jul 2025 14:00:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/82] include/hw/core/cpu: Invert the indexing into
 CPUTLBDescFast
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-26-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> This array is within CPUNegativeOffsetState, which means the
> last element of the array has an offset from env with the
> smallest magnitude.  This can be encoded into fewer bits
> when generating TCG fast path memory references.
> 
> When we changed the NB_MMU_MODES to be a global constant,
> rather than a per-target value, we pessimized the code
> generated for targets which use only a few mmu indexes.
> By inverting the array index, we counteract that.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h | 6 +++++-
>   tcg/tcg.c             | 3 ++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index bd835b07d5..85b1ab4022 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -596,7 +596,11 @@ static inline CPUArchState *cpu_env(CPUState *cpu)
>   #ifdef CONFIG_TCG
>   static inline CPUTLBDescFast *cpu_tlb_fast(CPUState *cpu, int mmu_idx)
>   {
> -    return &cpu->neg.tlb.f[mmu_idx];
> +    /*
> +     * Invert the index order of the CPUTLBDescFast array so that lower
> +     * mmu_idx have negative offsets from env with smaller absolute values.
> +     */
> +    return &cpu->neg.tlb.f[NB_MMU_MODES - 1 - mmu_idx];
>   }
>   #endif
>   
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index afac55a203..615675d185 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -425,7 +425,8 @@ static uintptr_t G_GNUC_UNUSED get_jmp_target_addr(TCGContext *s, int which)
>   static int __attribute__((unused))
>   tlb_mask_table_ofs(TCGContext *s, int which)
>   {
> -    return (offsetof(CPUNegativeOffsetState, tlb.f[which]) -
> +    /* Invert the index order -- see cpu_tlb_fast. */
> +    return (offsetof(CPUNegativeOffsetState, tlb.f[NB_MMU_MODES - 1 - which]) -
>               sizeof(CPUNegativeOffsetState));
>   }
>   

There are some comments left behind that can become confusing with this 
change. Could be changed with previous commit.

tcg/aarch64/tcg-target.c.inc:
/* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {tmp0,tmp1}. */
tcg/arm/tcg-target.c.inc:
/* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {r0,r1}.  */

As a proposal, it could be worth to add a small function
mmuidx_to_entry() which does the inversion. This way, we save the 
comment in tlb_mask_table_ofs.

Else,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

