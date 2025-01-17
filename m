Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20509C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpDJ-0000r3-Or; Fri, 17 Jan 2025 11:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYpDI-0000qq-LK
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:28:52 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYpDG-0005oc-Sm
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:28:52 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21634338cfdso60120355ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737131329; x=1737736129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r3rRpt34hxlJFEB9zVqU3838IppENG6GnqiznyECX3U=;
 b=SgDv1D4FrDAmLSjTXEGJQ+b8wYseSWVlWDmGHb2ORXtInoVBIrDTZVt+uUeKwmPJ5p
 UVlJ5t7S3b5WKrDpHWLEmA2FfbGU/82U1xdN4301yHadlf8mtPL/2m4+OJzpGemRclsb
 SSjWOHfqqhNeRBACK4sfe5+GJG7wrdufVagOtdgwFgAh+cNCaTyNchnZqbxVUsxGwepc
 xqr1bF/YTYijEDbEcVNVdZvuiahV8knpIfMV8AUg6VryYhWzL3j5Sh6XxN4NMJiynlGR
 xQTKYJ7ZN/K5sedprT2TFCprP3A2kLM69jHGME8wrdxQI0VbUvNrhiqOWR2bux6lrjZ+
 BiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737131329; x=1737736129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r3rRpt34hxlJFEB9zVqU3838IppENG6GnqiznyECX3U=;
 b=rXKa+gD1u+zDSF7zV2CSeAli/dM70EceRIyv8pxLY817R9wj37AmHUNYfWAwm03chM
 869aDeADgiscZBMvV2Ck/oEwJB9HKCTvEIpib4iXJM+i6nW82dQGC1wEnyHeU4kzXCdv
 mGfFJ8vy8lLk5tednpQdHskqJjcIjda6XO1ieR6vaKEKvmgUq/D/Py6pUvcZnA5tiag1
 oJr4OCTEyCXI8u+oO0Vb0ZcvVwfGQUjOj5kAqEk/+Y2qGhmwO+UFSZ0nmaksI2mspl+e
 XwGR+u4XNfersS4OUcCUarvfg8UU3TQJV0jH3qq4t6mdfsGyYtTq+0J/NchkUMOmmjJ4
 EfVA==
X-Gm-Message-State: AOJu0Yw14gEF1LmNhY9RgDnYCqZdgu3wCVWI69YIPbtf1gu0psoeOtaI
 3Gi/KKTW7OLIhd1UUdwD7ooxID/EF0dNms0jE63HoYj6fayr22GrfaClOaQsnhA=
X-Gm-Gg: ASbGncutszbnuzxQoZBiO1YtGbZJZ3stS4wB3VT0LAhcSOQrEZKGEaaFvsdMu+t53pf
 mXqiKv1FPHreX3kVMcYljNHpot3w/Bb+gTRx7vNHfmDDgFni6SDAtIZZInWROQ0jUA6AekBfH/p
 +vHQy1RlnvCUAzrbvTGLdlCFidSN0kxqpL0msDhx+w09JScs0K08T4CLl/hnIb4SpnQ8z0qirt+
 KT+QwIHdyEkHSKi30EUbVypMHP1bhddsAydd3J6+/ZWlkeR4RToMfHskprA6lHugXqwUlMrpA8M
 G8Nhx+sOYjTgUYYdBjXMFMg=
X-Google-Smtp-Source: AGHT+IHSJgZL2PCCCTcPTgriS+GgyL5UlEMT9nlSxkMTrcAG9vdxXEo9MYM8lG/Y4pJemrERbs9Iig==
X-Received: by 2002:a17:902:e746:b0:215:97c5:52b4 with SMTP id
 d9443c01a7336-21c35631dd4mr47502135ad.39.1737131329097; 
 Fri, 17 Jan 2025 08:28:49 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3a87efsm17888415ad.138.2025.01.17.08.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 08:28:48 -0800 (PST)
Message-ID: <cdc2943c-54ea-4380-ab1e-e9448ed5e093@linaro.org>
Date: Fri, 17 Jan 2025 08:28:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tcg: Document tb_lookup() and tcg_tb_lookup()
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250116213214.5695-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116213214.5695-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 1/16/25 13:31, Ilya Leoshkevich wrote:
> These similarly named functions serve different purposes; add
> docstrings to highlight them.
> 
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   accel/tcg/cpu-exec.c | 15 ++++++++++++++-
>   include/tcg/tcg.h    | 41 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 55 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

And queued, thanks.


r~

> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index d48b82a9325..8b773d88478 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -249,7 +249,20 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, vaddr pc,
>       return qht_lookup_custom(&tb_ctx.htable, &desc, h, tb_lookup_cmp);
>   }
>   
> -/* Might cause an exception, so have a longjmp destination ready */
> +/**
> + * tb_lookup:
> + * @cpu: CPU that will execute the returned translation block
> + * @pc: guest PC
> + * @cs_base: arch-specific value associated with translation block
> + * @flags: arch-specific translation block flags
> + * @cflags: CF_* flags
> + *
> + * Look up a translation block inside the QHT using @pc, @cs_base, @flags and
> + * @cflags. Uses @cpu's tb_jmp_cache. Might cause an exception, so have a
> + * longjmp destination ready.
> + *
> + * Returns: an existing translation block or NULL.
> + */
>   static inline TranslationBlock *tb_lookup(CPUState *cpu, vaddr pc,
>                                             uint64_t cs_base, uint32_t flags,
>                                             uint32_t cflags)
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index a77ed12b9dc..057df6c4599 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -746,10 +746,51 @@ void tcg_region_reset_all(void);
>   size_t tcg_code_size(void);
>   size_t tcg_code_capacity(void);
>   
> +/**
> + * tcg_tb_insert:
> + * @tb: translation block to insert
> + *
> + * Insert @tb into the region trees.
> + */
>   void tcg_tb_insert(TranslationBlock *tb);
> +
> +/**
> + * tcg_tb_remove:
> + * @tb: translation block to remove
> + *
> + * Remove @tb from the region trees.
> + */
>   void tcg_tb_remove(TranslationBlock *tb);
> +
> +/**
> + * tcg_tb_lookup:
> + * @tc_ptr: host PC to look up
> + *
> + * Look up a translation block inside the region trees by @tc_ptr. This is
> + * useful for exception handling, but must not be used for the purposes of
> + * executing the returned translation block. See struct tb_tc for more
> + * information.
> + *
> + * Returns: a translation block previously inserted into the region trees,
> + * such that @tc_ptr points anywhere inside the code generated for it, or
> + * NULL.
> + */
>   TranslationBlock *tcg_tb_lookup(uintptr_t tc_ptr);
> +
> +/**
> + * tcg_tb_foreach:
> + * @func: callback
> + * @user_data: opaque value to pass to @callback
> + *
> + * Call @func for each translation block inserted into the region trees.
> + */
>   void tcg_tb_foreach(GTraverseFunc func, gpointer user_data);
> +
> +/**
> + * tcg_nb_tbs:
> + *
> + * Returns: the number of translation blocks inserted into the region trees.
> + */
>   size_t tcg_nb_tbs(void);
>   
>   /* user-mode: Called with mmap_lock held.  */


