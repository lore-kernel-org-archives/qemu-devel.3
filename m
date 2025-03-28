Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49758C3600C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyG8M-00025e-Lk; Fri, 28 Mar 2025 16:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyG8J-00025N-Nv
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:16:51 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyG8H-0001fp-My
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:16:51 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac2bfcd2a70so331843766b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743193007; x=1743797807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+bayHFf/uF6SxyHifTJapAAmYSL26QiJX4NOWeOb29Y=;
 b=W8ccwVh7x7kNua7j8XWBh6A+mfkZlgKeOlqOxnHH6CYzoZj7viIGKFDj2eE9uVS/Vf
 oZJLLG1OP5RW5rHKhxKdyhk9je8J2ZiEO8ntJ6y9djxpEkQ7Uh1BympWTfXDzItfhqtI
 zrGENVfj0C1kcWauBrtCQSFAuHlEekr0mA4pRf4lLztnvoQzuuAcWxrhw4J9VyX4nad/
 J9uHSYwJXLcrLkwAglgEkHC9Wp0UQItOEFMDleqsisQnLJ9UIqJuFo9vGBCSGTPNHELy
 4wY09AFsU1C6fi3bqsHWXKEiLMFP0pWNmHrTJt62F94db1XJX9MfGPgQIa054NOOmwWk
 /2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743193007; x=1743797807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+bayHFf/uF6SxyHifTJapAAmYSL26QiJX4NOWeOb29Y=;
 b=IEggkC9pRiJ8PsUqEl2Z44CPOXQWQDHlMYvahECAp5BY9TtPWc5/u3sofhl34DZlkP
 LiZOv9aqCFRpAcBEvaIIrrfR6qzClSx6/Puya4f/6kg0uEuizwt2ePfC+r7YONxnQsDc
 wCcdUFxzUqaVqbeIbXxQmekSwPx3ufXO4TTwexy2CV9kdMg/ndh7NkqaWDjspI20b+wh
 cxhA5nWIIoA16hS2csUfdBqUTjjeXeCadq2We2YSKqOZnJAnhlCu7XYM/1xqN4aJHeMJ
 UQKU4j/kj7xYytFFbgsdLAXVi7co+xBhjUZ+d7+M0gw7Ae7aAb2Y9SeYmN1TVpU4EKRN
 RRrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRc3uCWjt8nmgiS+N0AcBv6sOQUzx16WqmCiQJ808n9FmzYA6uPz9QwV7rOwxIBvRMM97GykAYMdoo@nongnu.org
X-Gm-Message-State: AOJu0Yz2r606uF03dHH4scQ+cmhXFF+LcJeHzbB5GcZ7dZwMkuf0hOJi
 7A1SlWtgGSJc1aGaGF5UYUS9zDcdGtw7BHyQa2Pp5SIlKjmNUYXta7sOVvhoO+4=
X-Gm-Gg: ASbGncsPkGLSBFKvjyGeCjllCjQgEF7VlPelUD1ZHTChlHudOVObNoRoajBJRbJySJ/
 r12ffNnmtR0eSjFOqCfffofZ/Q6v69JpFRJRq93A/oqx0vPZwZPSYIQqgfAJrcTG0pBAPcZ7Nrn
 PWTVFDABaJK8v1Y/8Xe54jCE8itNHDpcH/X//VUuXgNEZ/6jaZ5dYN5Eus81Zci80qlRvJaxYUI
 QiYAiemdU/XA9uXlY9v2jZZtmynlIbJZpaXWwQ8GG377ebEU53zT9bucS0OABkHWRWZSX21TztS
 oQCJG8aYqwN6fsw8ikA9jWFft+g109h5MpLsNeEVjws5XEN72MK1hmdZTvo=
X-Google-Smtp-Source: AGHT+IEuIt5g5L2nLxbhZXRTJ1Sv3l3R2uOPMigRNE/vEyD+ZsFEBz5lwfN0sJXZgiTvOc9UoM4mDA==
X-Received: by 2002:a17:907:9693:b0:abf:6aa4:924c with SMTP id
 a640c23a62f3a-ac7389b834fmr55681166b.17.1743193007342; 
 Fri, 28 Mar 2025 13:16:47 -0700 (PDT)
Received: from [10.154.28.14] ([193.32.126.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71967fdbbsm206257466b.135.2025.03.28.13.16.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:16:46 -0700 (PDT)
Message-ID: <e5a53d83-2a4c-4c9f-82fe-6668c60d8da6@linaro.org>
Date: Fri, 28 Mar 2025 13:16:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] include/exec: Move tb_{,set_}page_addr[01] to
 translation-block.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250328200459.483089-1-richard.henderson@linaro.org>
 <20250328200459.483089-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250328200459.483089-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ej1-x630.google.com
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

On 3/28/25 13:04, Richard Henderson wrote:
> Move the accessor functions for TranslationBlock
> into the header related to the structure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h          | 49 -------------------------------
>   include/exec/translation-block.h | 50 ++++++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+), 49 deletions(-)
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 19b0eda44a..fcad3446fe 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -123,55 +123,6 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
>   #endif /* !CONFIG_USER_ONLY */
>   #endif /* CONFIG_TCG */
>   
> -static inline tb_page_addr_t tb_page_addr0(const TranslationBlock *tb)
> -{
> -#ifdef CONFIG_USER_ONLY
> -    return tb->itree.start;
> -#else
> -    return tb->page_addr[0];
> -#endif
> -}
> -
> -static inline tb_page_addr_t tb_page_addr1(const TranslationBlock *tb)
> -{
> -#ifdef CONFIG_USER_ONLY
> -    tb_page_addr_t next = tb->itree.last & TARGET_PAGE_MASK;
> -    return next == (tb->itree.start & TARGET_PAGE_MASK) ? -1 : next;
> -#else
> -    return tb->page_addr[1];
> -#endif
> -}
> -
> -static inline void tb_set_page_addr0(TranslationBlock *tb,
> -                                     tb_page_addr_t addr)
> -{
> -#ifdef CONFIG_USER_ONLY
> -    tb->itree.start = addr;
> -    /*
> -     * To begin, we record an interval of one byte.  When the translation
> -     * loop encounters a second page, the interval will be extended to
> -     * include the first byte of the second page, which is sufficient to
> -     * allow tb_page_addr1() above to work properly.  The final corrected
> -     * interval will be set by tb_page_add() from tb->size before the
> -     * node is added to the interval tree.
> -     */
> -    tb->itree.last = addr;
> -#else
> -    tb->page_addr[0] = addr;
> -#endif
> -}
> -
> -static inline void tb_set_page_addr1(TranslationBlock *tb,
> -                                     tb_page_addr_t addr)
> -{
> -#ifdef CONFIG_USER_ONLY
> -    /* Extend the interval to the first byte of the second page.  See above. */
> -    tb->itree.last = addr;
> -#else
> -    tb->page_addr[1] = addr;
> -#endif
> -}
> -
>   /* TranslationBlock invalidate API */
>   void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
>   void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last);
> diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
> index 3c69bc71a9..8b8e730561 100644
> --- a/include/exec/translation-block.h
> +++ b/include/exec/translation-block.h
> @@ -13,6 +13,7 @@
>   #include "exec/vaddr.h"
>   #ifdef CONFIG_USER_ONLY
>   #include "qemu/interval-tree.h"
> +#include "exec/target_page.h"
>   #endif
>   
>   /*
> @@ -157,4 +158,53 @@ static inline uint32_t tb_cflags(const TranslationBlock *tb)
>   bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
>   void tcg_cflags_set(CPUState *cpu, uint32_t flags);
>   
> +static inline tb_page_addr_t tb_page_addr0(const TranslationBlock *tb)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return tb->itree.start;
> +#else
> +    return tb->page_addr[0];
> +#endif
> +}
> +
> +static inline tb_page_addr_t tb_page_addr1(const TranslationBlock *tb)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    tb_page_addr_t next = tb->itree.last & TARGET_PAGE_MASK;
> +    return next == (tb->itree.start & TARGET_PAGE_MASK) ? -1 : next;
> +#else
> +    return tb->page_addr[1];
> +#endif
> +}
> +
> +static inline void tb_set_page_addr0(TranslationBlock *tb,
> +                                     tb_page_addr_t addr)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    tb->itree.start = addr;
> +    /*
> +     * To begin, we record an interval of one byte.  When the translation
> +     * loop encounters a second page, the interval will be extended to
> +     * include the first byte of the second page, which is sufficient to
> +     * allow tb_page_addr1() above to work properly.  The final corrected
> +     * interval will be set by tb_page_add() from tb->size before the
> +     * node is added to the interval tree.
> +     */
> +    tb->itree.last = addr;
> +#else
> +    tb->page_addr[0] = addr;
> +#endif
> +}
> +
> +static inline void tb_set_page_addr1(TranslationBlock *tb,
> +                                     tb_page_addr_t addr)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    /* Extend the interval to the first byte of the second page.  See above. */
> +    tb->itree.last = addr;
> +#else
> +    tb->page_addr[1] = addr;
> +#endif
> +}
> +
>   #endif /* EXEC_TRANSLATION_BLOCK_H */

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


