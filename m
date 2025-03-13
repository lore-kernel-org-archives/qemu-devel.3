Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2832C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsm8s-0000hp-OW; Thu, 13 Mar 2025 13:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsm8q-0000hD-Jq
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:14:44 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsm8m-0006je-7f
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:14:43 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-301493f45aeso855803a91.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741886073; x=1742490873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O6HClS9wghb7RDw8NP+iIU8Bxx4UdVTZq7aKRfcwcXw=;
 b=jl78/bmDwkS+3VIPsEGSFUrU5IR427zV2tef5HzDzAXLGR4Y74cqmEjCKXag6UNHaC
 Dw7IVX2zX5AjA0IYjHw0wFdkyR+nt2AG5yjdr1OxGaJIsZ1qUduPr3yjD2i3ja+tEZtc
 z8LZHqx9p7e+xR0Isq4ZkqllOTM+90E0wUeEjZpneR8jOe4iBRnZXbXG+4S6uKulJZJ8
 XBay3zbh+VObZHFwe6clO0ZQC/vsWHUwejp0jHoiymI+gfsxTurGQrN4IH1BGBjv1bqt
 nc9jMK+V3sLztdYg1zXGDcVgOH3eKOHLR1T7jwj5gW/AjQADHZ58tap1Y//VwCd2FFfa
 u++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741886073; x=1742490873;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O6HClS9wghb7RDw8NP+iIU8Bxx4UdVTZq7aKRfcwcXw=;
 b=TYfnWCm2k7iSp6tHkX3S0febXbKCUxvzS8ACapsLfDMxpBenQqQVOwNZH9GziqUxB+
 tiZi2/dUFWSaCROcERN2A//dzO0plX59m31JuydfYbwGIuqR2hQRliRnMMozTRmQycPJ
 GmetSsuKRKllG6IBqjLXsZaHGTow3mlff3IGSoeacgwtkdrt7GCNffjwB5hh/A6aFVRQ
 JZ6aegCoUTY1jj8PZZYD+cIa7GKCJKQRE5g43PBfdwLcqoX8cDtLGNUjItbwrhkWbV0n
 gbytlkBCT2wa8vB8VdPF+sFZOKdrOrayYY++79VOagUwHMMEBIWImWZyoazwshKkFYT1
 vNMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb3FbBKekvWWdhdzdnjPewq9ZXWKC6jREMpb8d50BEjC34peDTUPkCyQNvRT85AGnN6Rt7dKua8MNF@nongnu.org
X-Gm-Message-State: AOJu0Yyw3/QzPquOZhqYgrRlqg2ds89/Jhclwmke94lJpAA9MORvatjO
 LrEoPLlNKla6zzXYqMFkS+9WT5vHnQZ/uu7CBkJXxbageTKzcdoeHVmTsRUNfSf9q4VrlUgH7RR
 QrJY=
X-Gm-Gg: ASbGncvcWxsgmOBg7916NqKw0ISXD0TmG7S1YDoGXTSyu+faqOH3lSo06cBq9ADpggp
 tkzEyZSL0m+sZj9WuMWR2b4cLJXDqjd/h2wlBcgCp7TTmjnmJEOp8sDL/ckT+gFYuEBb4HSvPXo
 6qlpcm85nTZueTK6fNDVcm9mbii0o4ayoa32AQO31pCYH0fpkztwiiaAcTvcUWs9LHoyrI4NENj
 pZ6HGg/2E2m4A6I3cGJF1yajqsPhTVh2YYU8rsr13a2TYlxj9FtG84TuaRTHsuaNqYJCsJGNozt
 ppfbuL6mZylQHJjDDSRaCmS6TnufppOTMZevlCzHyZmvuWVssyYI9QeEnA==
X-Google-Smtp-Source: AGHT+IFJVMAiwG/w9mKdQcVq6SVm1hRqRmsQoyhrpoGi//JMyX3kQQC8YxX7pHkJOx7zcOg5+nBhnQ==
X-Received: by 2002:a05:6a21:a24b:b0:1f5:7873:304b with SMTP id
 adf61e73a8af0-1f5bd9c2682mr666488637.26.1741886072832; 
 Thu, 13 Mar 2025 10:14:32 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea932c3sm1517055a12.63.2025.03.13.10.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 10:14:32 -0700 (PDT)
Message-ID: <51cfbbc5-c258-49af-bcab-ad1ce21ff711@linaro.org>
Date: Thu, 13 Mar 2025 10:14:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/37] accel/tcg: Perform aligned atomic reads in
 translator_ld
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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

On 3/12/25 20:44, Richard Henderson wrote:
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
> index ef1538b4fc..0260fb1915 100644
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
> +            stl_he_p(dest, t);

Should it be stq_he_p?

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


