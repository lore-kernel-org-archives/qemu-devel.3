Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8823EC36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 00:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twsNq-0001aa-Cb; Mon, 24 Mar 2025 20:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twsNp-0001aP-5K
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 20:43:09 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twsNm-0001Cc-Pk
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 20:43:08 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-301e05b90caso7614305a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 17:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742863384; x=1743468184; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yV4JPWtUvhZxf9xmsbEeZlN8aocOou+iTwnREPKh/nU=;
 b=lttevpZcyQoVrWN/71NUyZLSm7w5igJz/ERvX9uyg6tkaqO8sapv5PQ1oNNRZ3oO68
 5J25z94AzZ9kvVN+Pbwg1CGFHfzscfAZkybqpWTMA7Sd042C3seCW6yKm76rt7W82brc
 pz6v3VfjPYvkWZ+4mR4Y+eKXiSECopY40dsfNjecCNkLBnvZBq54UkErk80vMtnFSgMN
 K4nCuaWFAEOsF1X1JTcz7nZ8g/ebEieUPXZ4kh9Wi2eqfv2m7fnEMVzrYU42H4ZW9ACF
 uNpJwUO6YwJQi4YGEFImSbd/6npHw6q8IETGpLhgoI3b+unQx9mZ0lTbZTbSoRyim8wV
 pzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742863384; x=1743468184;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yV4JPWtUvhZxf9xmsbEeZlN8aocOou+iTwnREPKh/nU=;
 b=OKnxm+Wg18E6cpJHTBLAPLakUrlIWwX2MVeOut7SEG9/6bGJ+hjwqPujM4rGczKzu5
 8qkVOGDW/X5TYCp9nAB0k0EL3nSKmddAaoLredLo/+LH0skFSVJIL5v2X5M2OZiesaJq
 J2Eb9I+iJ5XpWlEUQZZ/PCU87sK0Sh9nUO085hlO4SypcNac1KfWrEbKv+5kVj9DSFg5
 LngOdxHIvX8FWfi0dVNN+xRkuuYRzE7bISk63V/rNcWZX1008mdyK42bm8SUid3oi54H
 cwREcRnA6RU3eWaFcmemfcsl7RJ98J5EKzgODIeaVxTweDlfxX+nMw6h2xEWYBAnn1pu
 GhVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIHMUBYfbWm6NT7PEDVZFYCflue8SmYGbU8vyiMWrxCr1okMHoPHBi+Fz7VINNwqDzR+eIfHZVy2ht@nongnu.org
X-Gm-Message-State: AOJu0YwW9bTovshP2X870HY47j8XS4E2lUB0R7sMAFUq0z39vWy+d2mk
 DZovqTChC5Tthpu7NA36oowaiydZuRkIjZfoj01fcPbGE7Jfedw24ZNB1qBre9Q=
X-Gm-Gg: ASbGnctL7yI8e0bFJd0Ypjd2WgGXstHN+MRprWtRCCB/CLsi6CRbmNQgunnUDu8tZOP
 IhkVUT4jBW7uWXjgqr5WgTJPHDp2fIwqSCkilyylUMbYOOp9ONQt7sQcstCj+a0QpbmWJe1tlWO
 zMoBoOqit+mBeEU7qI8R1BqYxdY4nAg6Ssd7cX8FB027nyMe22afMYyk0uHEmMb0vrUpaU9GUAq
 1MNy83L6GGu3b1qTbE+K5RSeqq7R6k3WKk5lJjRLa51ayjQ6m2d6bRKMlvx1twONU9wbNqixvi1
 sGykKS9rF/LNd7QL5N6f8/txPmzYnEMRQctLj9v2/gT5ZHLV5J1UKnl2YA==
X-Google-Smtp-Source: AGHT+IF/sWBDQGX8cM79wEDOEcNbIPKRcNAKyJJbyy7oSqEo+JTRg7hQAsSjAWxEXKsc6Bu0VLpZWQ==
X-Received: by 2002:a17:90b:17c7:b0:2f5:88bb:12f with SMTP id
 98e67ed59e1d1-3030fea9355mr19668987a91.21.1742863384108; 
 Mon, 24 Mar 2025 17:43:04 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f807533sm8867293a91.49.2025.03.24.17.43.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 17:43:03 -0700 (PDT)
Message-ID: <2fa24813-733d-461a-bf57-45e6fc7edbe5@linaro.org>
Date: Mon, 24 Mar 2025 17:43:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] hw/core/cpu: Use size_t for memory_rw_debug len
 argument
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

On 3/23/25 10:37, Richard Henderson wrote:
> Match the prototype of cpu_memory_rw_debug().
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h     | 2 +-
>   target/sparc/cpu.h        | 2 +-
>   target/sparc/mmu_helper.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 5d11d26556..abd8764e83 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -154,7 +154,7 @@ struct CPUClass {
>   
>       int (*mmu_index)(CPUState *cpu, bool ifetch);
>       int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
> -                           uint8_t *buf, int len, bool is_write);
> +                           uint8_t *buf, size_t len, bool is_write);
>       void (*dump_state)(CPUState *cpu, FILE *, int flags);
>       void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
>       int64_t (*get_arch_id)(CPUState *cpu);
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 462bcb6c0e..68f8c21e7c 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -604,7 +604,7 @@ void dump_mmu(CPUSPARCState *env);
>   
>   #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
>   int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
> -                              uint8_t *buf, int len, bool is_write);
> +                              uint8_t *buf, size_t len, bool is_write);
>   #endif
>   
>   /* translate.c */
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index 7548d01777..3821cd91ec 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -389,7 +389,7 @@ void dump_mmu(CPUSPARCState *env)
>    * that the sparc ABI is followed.
>    */
>   int sparc_cpu_memory_rw_debug(CPUState *cs, vaddr address,
> -                              uint8_t *buf, int len, bool is_write)
> +                              uint8_t *buf, size_t len, bool is_write)
>   {
>       CPUSPARCState *env = cpu_env(cs);
>       target_ulong addr = address;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


