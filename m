Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A92BCA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliJo-0000l1-6U; Tue, 12 Aug 2025 02:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliJL-0008WB-Ut
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:16:42 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliJJ-00054b-Kr
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:16:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-459e3926cbbso21070965e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754979393; x=1755584193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KQQpPpv8WXEQc9zukuQOFNzDFXRFj7DWgsdGTibAnpI=;
 b=F/1qFcyRDseVD6Xn97BWZTWR47t+NGoiVizXN4Tv02YezkEXW1R9+7AzwCXhxz3TVo
 ch7eAhSnzFxm6BxSVBv7OgeGNfa1IynZE3n3YP/lUwX8p9cvPsEs645DwUAhlqw61scR
 bPXxxzDqu9YZ8qNbXN65Somwa2nIsO5+ChfaVgSVT79iYuEpWLPegxdUxLlE8T/69OhV
 9CmI4g7jm/kyYY1i7SAbZ1EiZG00TzDLsmh8vd9FyEUnFrM87y0en0kGTCe900UrmlXw
 xmcGEHwF/F3zXaZehasd6H9YQpXhxQhs6TP/kSgjqxGO+60q1XWI7f0ATzXiF6wa5SwS
 X4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979393; x=1755584193;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KQQpPpv8WXEQc9zukuQOFNzDFXRFj7DWgsdGTibAnpI=;
 b=Xb4iHbLB9qVmTBL/DFB8JoxxbsOR5PFEEYZAcwDZvmDyZRZ3L8Jovma5NFCRKtpUB+
 qLsRGk3AHwz8QUBpEIyK2Z6c9p3F9uHy6Iloi7gviCkW8dzj4X1sFaLwR7VNuIjQLwLJ
 u4hhFksoCYeLwvS/iTEiEUXxW/+Aks5ms7GYVy7balJ07GMamy7SN7IQXYiKdGnRA8ZZ
 8AtuAQgNqWke/U7fhbKWBPuyfp5WCXPxUkzW20rQrcc6ZHlNpr5kttUam7TCAzGdBRvz
 mByi3D2Hw8tUi3cTBst9QzAa290UC987JrwL0jTVYCgFQHSqmkk/Km6uOu+sg93PfcDj
 SIGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1VhNn1JYHKzxf/rLAuaHUcgCeiqRlzJDEaK/DfKdDHg6llawEAddKqRZKGn4IPG4tHjH43JpK2S9d@nongnu.org
X-Gm-Message-State: AOJu0YwckF4nQCAXcMJzzBS9/mvrgEk9q732h3BgxYcNScdw0v0BuF+5
 b6dTtJ3W9mTDR6yfXvZDxWlBQtTVWL6x7I6YZapRyghX57BwwM3Ev4KTpo1v402nQZA=
X-Gm-Gg: ASbGncuO5sMf6rd3P4JHQxTgIIuhf2Fu47IlYR8tWEOqRufwJwaJ0VhnNNtl73uRo2Y
 q6UDA5XA3mYAq5GTL6mXM27KCnbLUT/Xq4N0nZOzh4J79Iv+AysVRwFcmCfDn5dwOsUgAGbhHT4
 /ZEuC21vcvqHiRbRGKO+FQlzy7SLa1vE4y10c3XvtRUm/niIoLiI6kqI/4uARJmA6mlRxw270RB
 3T9ukC70A4ZdtjT4cxSPuSHYchodZ1XxW2TZgxpE9tx67aAwwEZCqYeB7p4tOyNUcHKVmYXinaj
 30OBiXHE63odvbVM/NNzTjKfOkeIUcLHan6swkahGQubXqNPiNu3sgNpFN/TfcAZUzJcvmJo8yi
 d8yZTRnHRSFtSYYDWVzWptO9D5qIxZ8KFt2TnK4k2BfI/uYy5w0N3K7hHDa7mQLz2Bw==
X-Google-Smtp-Source: AGHT+IHIlMnM3fAxLGQxSjVcxHxvfIJCM0gKCtGaLdfY4udmqdO78YzoSj+3adLr22QWeqE30kqAPw==
X-Received: by 2002:a05:600c:5308:b0:458:caec:a741 with SMTP id
 5b1f17b1804b1-45a10c4724dmr17496215e9.24.1754979392693; 
 Mon, 11 Aug 2025 23:16:32 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b90d147485sm5304764f8f.19.2025.08.11.23.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:16:32 -0700 (PDT)
Message-ID: <b91de2ce-067e-4c06-86c9-82d1ce1304d7@linaro.org>
Date: Tue, 12 Aug 2025 08:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 31/85] include/hw/core/cpu: Widen MMUIdxMap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-32-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802232953.413294-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 3/8/25 01:28, Richard Henderson wrote:
> Widen MMUIdxMap to 32 bits.  Do not yet expand NB_MMU_MODES,
> but widen the map type in preparation.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h | 2 +-
>   accel/tcg/cputlb.c    | 3 ---
>   2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 23eb849a9b..fc9a2291d5 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -201,7 +201,7 @@ struct CPUClass {
>    * Fix the number of mmu modes to 16.
>    */
>   #define NB_MMU_MODES 16
> -typedef uint16_t MMUIdxMap;
> +typedef uint32_t MMUIdxMap;
>   
>   /* Use a fully associative victim tlb of 8 entries. */
>   #define CPU_VTLB_SIZE 8
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 2a6aa01c57..416aaa1040 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -89,9 +89,6 @@
>    */
>   QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
>   
> -/* We currently can't handle more than 16 bits in the MMUIDX bitmask.
> - */
> -QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);

Maybe explain why it is safe to remove this check?

>   #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
>   
>   static inline size_t tlb_n_entries(CPUTLBDescFast *fast)


