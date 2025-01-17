Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E7AC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 04:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYeE8-0004ZN-7Z; Thu, 16 Jan 2025 23:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYeE6-0004ZF-Rz
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 23:44:58 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYeE5-0004Ya-9A
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 23:44:58 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-219f8263ae0so30064275ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 20:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737089095; x=1737693895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eUl0fj7MYVDuVkrVvDwHU5rwBz2SYuSXgOUFfEbuRa4=;
 b=wuLrMj6MhFJexcXqPot5EXiRm7gMoFNLPlHw8W1vtTf0cqHh5Cpk3AEvz/RxgoYlGW
 GuU1HY6ztTCkrm2LiHRCS4QuaZ9POG62I+PApzgFkvCOwZN+vPC6R5o8dOBJYjV2b6O8
 wp5CXI6MvRS4BFiGA2BxNfzBAceXpIz8Vd7MAYHn+jdO2WZ2Amb8I73RQZIXaXp+CwiA
 fbXfb/TbWZllYL5dyganDAMNSocu7ooYcFaiTgRNLth6PoxSZdfUz1LJIu27o48wEfN8
 qrIdbPIB9hdKvKXoC4Et32JYdOj7L7iztoro2xVz1hFW4N+ZFjPOQD2+mhEpSk9zmqiR
 ryjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737089095; x=1737693895;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eUl0fj7MYVDuVkrVvDwHU5rwBz2SYuSXgOUFfEbuRa4=;
 b=AFGJ2tb51exqa3WFyM0kLZPvCW5G7SSp7oio3pULKhJPeIiYcQVkAyBQzx4yYg11Yx
 3iTH/KXP9SJlbQyUQcnsT0Dq2zXVo5gGBM6dMZw7/5/nSJnUCLWmZREw2N9vQZ26ajJe
 zjg+Z2Q9XFlP9AZOKmQ5XJuTlVpFaS+MNxqkii0j19rNYsq6BKmA5lgmmi624aPGr/+a
 z69OmtRlG1dmYUUeI6fbBdWiAO/w36W++7rg2G2b/A0FNcHmL+W1EbZ+lHbqFF6P5nn1
 Oi7DRlLcvWQxLxMGZkgSrOFzkET10oLMJ7aP0hesZpZb02/lScwt0YLJVqHQwcKcI6tz
 A5ng==
X-Gm-Message-State: AOJu0Yz9ACesMyJ92tqrviCztSsJQE/s0wRqRxYXaYE5paUhLRWItjYJ
 9mLMOCfAuSDXRaVM0zTOmBbw5u9K4BnvOZ/3JrqPkjO2ciK03K5zzAcgvVl4t2s=
X-Gm-Gg: ASbGnctIab1zqAKZ6FKf5PnBZUKjLqp9b/kaN4p2tcxE8rJwUeOIumbBKY08sQtM7mO
 iua4G9ofAG8tWD2+Ly2U9gb2ptNhINbF/i0BVyiSIenSgRp7ezBrrUmSuHG6HlRtEm9f6N4AwuO
 vKZZk2thtxdJVeUFjnGTAvuzmyNj+hEqrT0CtU8JiCdU3/nxZwbc7/lWPlebHtvSCfWez07/neI
 Doa/mbDSKnU78QxE8DVoyE+UfkQXWb7lXqTKDCsGFJkCwUPHqEAKbDeCuYmlHfdUmAvDgPy3EU4
 ALGRNMrgVVsVlM5kXZ3FMnY=
X-Google-Smtp-Source: AGHT+IEH7WRXySF0C7waDhggBJ7RTPVmRZVvWFAw+Mr/3HKVXAPSWYE3TJBHRXOzzm8iw13TEKe96A==
X-Received: by 2002:a05:6a20:9143:b0:1dc:bdb1:349e with SMTP id
 adf61e73a8af0-1eb214a08c1mr2200209637.17.1737089095443; 
 Thu, 16 Jan 2025 20:44:55 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a9bce1bd33fsm866603a12.35.2025.01.16.20.44.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 20:44:55 -0800 (PST)
Message-ID: <65ee37e0-d188-4795-b69c-32f82e0929e3@linaro.org>
Date: Thu, 16 Jan 2025 20:44:53 -0800
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


