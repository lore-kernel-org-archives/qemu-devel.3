Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8EDC35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tux4E-0000R8-5w; Wed, 19 Mar 2025 13:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tux3s-00006y-Sn
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:18:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tux3q-0006F0-0w
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:18:35 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22622ddcc35so32787425ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742404711; x=1743009511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OiYC2nqrAzuzOzC+HYX2/T6GF/J1oizDwWj6GKfAsw8=;
 b=qVena2eKB73pK5rN5SSicqAvXpTjo/I57BO4qAP4EcTDaWHuwZxrd5LFccauX7BQyL
 cgf+9/4yn56JqMT/18q9L7TDZli7iDv63l3jmunU9uw5FIz3t7FSfLlEzWROxf65+wqY
 EAQKvEDhUfW81xeq+kxJaxaVw0XwYtW47S0qI1t8QUk4YQqK+/Q1RrvjAMPeQYzD6uIL
 uFyME/+vkXj0ohZqtQOr4S2Pq3kIiYZodDr+u5MiusKaXs92lkcP/C0SoRhRs0GU0bFK
 LN/tc3HvTg6safhbmpAottN3cktkfU7j82xIF31Wm1z/0WRrKS5udPH27o0p6fcw+yXv
 rvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742404711; x=1743009511;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OiYC2nqrAzuzOzC+HYX2/T6GF/J1oizDwWj6GKfAsw8=;
 b=Noihc26OBlu8+LpPUZmLykHKQ9YlaOiSW0eRK7DdrAG/JOpgH6whCq0hmLKYHn/wUP
 6O8Opo15EKj180ya4TXjXgiCliAr3zve/vXRt298SBvZiUjQ5MLFjFLoX9JnbZmaDINW
 U0qwpJF0FTBgEc+qNoKeys4qBiGU9q0jYTB5sgn+3Ec1WisHAylfPTANln8UUA6wjBia
 GKPiROGZxQKoPQRaspMmmxwIlllsLcVlyvCLq0L7G9GHLkEz87f4/fJcWr/PgHNCkuqn
 IwN4/tivZBJUxNY4cen3a5Ria73di1ARkvKAMPoaMMD/NJALybbIIXNoGv3Md1CgIelc
 lv0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0iIzVmHokoyv86MBFR9KQhbYbs9OEAq6Aq5qojBUHsFoR4/5ZlbJNDRoeSC8by4SSrwX5KDS3Nrih@nongnu.org
X-Gm-Message-State: AOJu0YzQL4FILIq3Ht6J/it3TZNnVIkaGuGGFq4qFpVDlJEEJV9SLkwa
 lrJjiQK/vHb6w/KD4rSXxyr+Vx/CUKrqgN0IEjgppP2gXnFFRDeylWuYg4JgQgs=
X-Gm-Gg: ASbGnct7w6hI6ANMRSL8+msxp//gxMi5KxxV2dulrSo68sJvyM19+gdm3j8jE3bBJ9G
 I/L1Z0wecTDPQREv2KmoF04e5M0SZ+wvghhysQ3a0B5b7BgIGl7G3l3fHtR9QIopuR+ErBYERgy
 4/6k8TJY9HWHx+y1U9Zs0dMrqKVQcTw/7hjKicG4Si44OVzqmRbBS8i3Q/likYv2L4C4QIvxmq3
 q4M+P+pJemXVhKyr9r6a4TGetfVBx4cUc+F2U87yJl3Wv+TjUU71ZpcqLR96qVf1EwAl8pjbjSi
 NxfsoIn2iRONKkrgbY7QRFHon5DFH3qKHgWDhM2dVMKrszfn42xE4HCUzH4hyYyxPN1F
X-Google-Smtp-Source: AGHT+IEZwjVzEZ775I0nH9F2n2yd1gTfj29L+4jwg65gSwYgxp3hpyVb/XJjPTDz8J8Mj0Bqh2R94g==
X-Received: by 2002:a05:6a00:b8b:b0:736:3e50:bfec with SMTP id
 d2e1a72fcca58-7376d5f8129mr6512836b3a.8.1742404711483; 
 Wed, 19 Mar 2025 10:18:31 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167dfa2sm12320433b3a.107.2025.03.19.10.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 10:18:31 -0700 (PDT)
Message-ID: <42b115d9-ab63-43f1-9ca8-db7c23d9fa66@linaro.org>
Date: Wed, 19 Mar 2025 10:18:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/42] accel/tcg: Perform aligned atomic reads in
 translator_ld
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/18/25 14:31, Richard Henderson wrote:
> Perform aligned atomic reads in translator_ld, if possible.
> According to
> 
> https://lore.kernel.org/qemu-devel/20240607101403.1109-1-jim.shu@sifive.com/
> 
> this is required for RISC-V Ziccif.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translator.c | 42 ++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index ef1538b4fc..157be33bf6 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -265,12 +265,14 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
>   
>       if (likely(((base ^ last) & TARGET_PAGE_MASK) == 0)) {
>           /* Entire read is from the first page. */
> -        memcpy(dest, host + (pc - base), len);
> -        return true;
> +        goto do_read;
>       }
>   
>       if (unlikely(((base ^ pc) & TARGET_PAGE_MASK) == 0)) {
> -        /* Read begins on the first page and extends to the second. */
> +        /*
> +         * Read begins on the first page and extends to the second.
> +         * The unaligned read is never atomic.
> +         */
>           size_t len0 = -(pc | TARGET_PAGE_MASK);
>           memcpy(dest, host + (pc - base), len0);
>           pc += len0;
> @@ -329,7 +331,39 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
>           host = db->host_addr[1];
>       }
>   
> -    memcpy(dest, host + (pc - base), len);
> + do_read:
> +    /*
> +     * Assume aligned reads should be atomic, if possible.
> +     * We're not in a position to jump out with EXCP_ATOMIC.
> +     */
> +    host += pc - base;
> +    switch (len) {
> +    case 2:
> +        if (QEMU_IS_ALIGNED(pc, 2)) {
> +            uint16_t t = qatomic_read((uint16_t *)host);
> +            stw_he_p(dest, t);
> +            return true;
> +        }
> +        break;
> +    case 4:
> +        if (QEMU_IS_ALIGNED(pc, 4)) {
> +            uint32_t t = qatomic_read((uint32_t *)host);
> +            stl_he_p(dest, t);
> +            return true;
> +        }
> +        break;
> +#ifdef CONFIG_ATOMIC64
> +    case 8:
> +        if (QEMU_IS_ALIGNED(pc, 8)) {
> +            uint64_t t = qatomic_read__nocheck((uint64_t *)host);
> +            stq_he_p(dest, t);
> +            return true;
> +        }
> +        break;
> +#endif
> +    }
> +    /* Unaligned or partial read from the second page is not atomic. */
> +    memcpy(dest, host, len);
>       return true;
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



