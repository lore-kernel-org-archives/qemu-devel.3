Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6E9C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 20:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK1BC-0005pS-TU; Tue, 27 May 2025 16:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uK1B7-0005lx-UZ
 for qemu-devel@nongnu.org; Tue, 27 May 2025 16:45:44 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uK1B6-0006ME-Eb
 for qemu-devel@nongnu.org; Tue, 27 May 2025 16:45:41 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-231e98e46c0so31766005ad.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 13:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748378739; x=1748983539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=99shOz3LKl9HwnBQBLr0U6Wj5CmMdwHk4gt8Kopny58=;
 b=CcB2A8hvoILZeaPHEqUVDJP+6HsQ6PpJBH/VWrNI2PerZH2iJPolE8IScsDpiMagYe
 ie2IQfDAYTQ5XJOGI35G7X2Z4mgwEgyqlqfcHebwlHgD6FqbRmgzMZbdyAL50/lCPSIJ
 5e6sMaQJM5w6EtOmfnlrlW0KIWM6LeFAdK4isaBit+XriAf8roHPZMS350cTcu4LO6XH
 OnU0NS5MDbZNH6RdWRLXQDp7M0EY71qOL4ywbPJMGwZeCijBGzt5X/1S1h1YcHeNx0Fe
 D0Orcwkr6gQwRXsPY//4cEmvVu18M7ihYS/E5RN3H8aBY6YoVCDXWVSwh4O//chQquqf
 LpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748378739; x=1748983539;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=99shOz3LKl9HwnBQBLr0U6Wj5CmMdwHk4gt8Kopny58=;
 b=X+2xMdyXbnDRdAo3i1ROcVxkX3HaMaYXINjqR956h9OyCabQgvobuZ1sgJGyntn1Y0
 u6wx05FPgcxjgVxM6DhfBwe/p5zOKj7h3S5IAKfAQk4ZOD9c9XiTIhPTc3xZN5t3aNSP
 Q8CAd/HOS8MFbb1PQ3gwi4k5jiE/eMfazdy6xJGUmJ03Xr6YvP/uI9ZZyiJd93fs//1k
 IKHXNsKOsFva/CZJU5rn+S0EwpEg5JLWWlauFXePgPJVkutQ0smBACqB0W7PUCC/LCj/
 S0X9ZXNfBgx4ABmPI3QAG7Zoi0uYaw456RkzgAy8xiHLb8YVzTfae9ymjBIE/XvOk6WG
 R4rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM+77B/CnZjQd369SBKaekCXMhzAlXK1kC7Y7OMIsnbMpS+5AJQE/W3bOSFJ/9XggPGsEeKZiZ80fO@nongnu.org
X-Gm-Message-State: AOJu0Yw+a1jm4T/Ilnfgsrx4+a8t9Ss0GdRIFSq4Q7tC90UcB8nIVrM7
 wHAcejkAbwi3ZwpIgg1Ktr9mJ2Hmw1uQT9Uxw2dusZhtXVeltZN1Sg7RI/dSff6iO3g=
X-Gm-Gg: ASbGnctDXDcW5nOkGgdpNzML9jsv1H3tPOuN31/UOnilM4ni39Czxga+fjwX0CGyGAm
 07ZSQor7EIfQDDXn9hhsU/MRpN+A+ernMfe1Gntt7Jg28MV4KHgu8p3CZnEzT4UC/Z4SDRtQV8L
 wCS7ka0kTZt/IbyZZJbyrJhUCaj/TIEvKSoO+zAIXxRw4rzbWFmW2f5HvA6hyMt6gHp+VjSZEqF
 o/ihHLT9srIHZLiVlkAhS192sFqWFrftWmjUv3x3rfKTfZh2wYc0bL5kdZBsbJ40Uw1t96BKgk+
 k0D0pXNdYwYCX33j45JS3XFyDNQeDL78ho5HR61U1+SzI7rfmg+tgsxhQMD2kNOF
X-Google-Smtp-Source: AGHT+IGBCOQ3FZdu6Db2sgypcDj4MYEA7NSuJiYRPr2DFykXIYHZz9XMyaHh6WGeh0J5ifeI/aIFVQ==
X-Received: by 2002:a17:903:230d:b0:224:1001:6787 with SMTP id
 d9443c01a7336-23414f3380dmr232584525ad.4.1748378738703; 
 Tue, 27 May 2025 13:45:38 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-234cc23868fsm36155ad.207.2025.05.27.13.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 13:45:38 -0700 (PDT)
Message-ID: <1aaaa590-50b1-4b8f-8dbb-2f2f4da24df8@linaro.org>
Date: Tue, 27 May 2025 13:45:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Fix atomic_mmu_lookup vs TLB_FORCE_SLOW
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250524144031.49810-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250524144031.49810-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 5/24/25 7:40 AM, Richard Henderson wrote:
> When we moved TLB_MMIO and TLB_DISCARD_WRITE to TLB_SLOW_FLAGS_MASK,
> we failed to update atomic_mmu_lookup to properly reconstruct flags.
> 
> Fixes: 24b5e0fdb543 ("include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE to slow flags")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 5f6d7c601c..86d0deb08c 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1871,8 +1871,12 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>           goto stop_the_world;
>       }
>   
> -    /* Collect tlb flags for read. */
> +    /* Finish collecting tlb flags for both read and write. */
> +    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>       tlb_addr |= tlbe->addr_read;
> +    tlb_addr &= TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
> +    tlb_addr |= full->slow_flags[MMU_DATA_STORE];
> +    tlb_addr |= full->slow_flags[MMU_DATA_LOAD];
>

[...]

Looks good to me.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


