Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80631E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 17:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVa8K-00072J-Ju; Wed, 08 Jan 2025 12:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVa8I-00071v-Nq
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:46:18 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVa8G-000425-U6
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:46:18 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso883845e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 09:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736358375; x=1736963175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=osOQL93kYl9MpbGNNN8H85IzUM5iDqhuG54auKW0HzU=;
 b=XNdImRl/zuOsE+0jhJUG+7920dvjvDHnUJQSNYfWdOyMfza2+AdMz50O20g9i+nnD8
 hhWma75G63joESH+ko7h8DEOq+ckgPlM35zoNiu0aEIfSZPjDiX1ci1jOySDFYuHMOGp
 Gyok17Z0wqodyXuz6vMq8Cdoqv3oWm1cvh0JvPzMMuMjHqOmW4qutr5lNM7DZugi6RHV
 lLQd3d0oL3fSikZKT/LlPMP++PqF79cDdSYwZHKHBla3GYhR8/ceXhlLKL3Vcfw38CN+
 CMEtF25GgkDm9qs7F9hFmKr+8KwjNiRyFHHOs10b+lMl8eX3zH+Oyvt0vRgYwaP7aZN3
 V1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736358375; x=1736963175;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=osOQL93kYl9MpbGNNN8H85IzUM5iDqhuG54auKW0HzU=;
 b=qSdHzqa6WJrq86Qe3s6OYfwdDAp0vrqoiVNlDcgPUp+kjpd+xs/OuKQA9+oaz43Isv
 XptlmyQN4/3sId+cRvlYSoqPByAOqC7LEhCDWPx6N2tBcX/N/8N959Y992uuAMESocjg
 3kgk90Vr/Nxvo/3+dDCRk+5tEQvVVvIMOzrY1Kq5WculiTI3e1Ee/DebAsjsN1fIrsmA
 Ph95MqgLoja6hoGWMtMdRn2DySysRX6RKxCNaHo5M5qocUndw/tsIOOoL7rQ7H/bKTro
 LNGrE0lGB9O1SZomdwdKIOpkI7NkHJhiV4WeKsnI7fW61XnNdU/THIVslv4imRbgfGGT
 jIow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpgxGIw9kvrjLhkNigpLS1xr1BvlE7QTW52rpwEYdOlH2uIO2Mnw9eTlDcFLhispBZkJv67wM8NJDn@nongnu.org
X-Gm-Message-State: AOJu0YwOU8fF8n9eVjgbvgm78zhirJc4MOB+GCD6BV3nAu9O/pKUjgYx
 ZZTzy3yEMKu15COynMjEGdLdjDCDBdgt3F04S9bJ/ZBqRdJRA5QPkkAn9Ez/TW0=
X-Gm-Gg: ASbGncvCYH0AxzAlYuYVgJ45TIam18AwX2WUvK8V0LUGOm94by/uYwcL4Cvii9VOv+v
 uuMczQdJeXq4227vshbP/5MgvPSZWNIt5EQKf2S8ZxCaxPte0rn0BIq/FQfm1KThrBQlG1dLlag
 htLtg337Fk48wN0UhSqOtkakNYIM1+DZER9uFVtQSE44gnY7ufb7MNq7Ufpgdg9oqXgr7MBEwjy
 DiYWtPR3jn9qPS5GaMlMnxHp21Bo1Aaxy1nrqdyTzZLth6DWyHv97mlGYYKBlwDG2mGRkZSf3sg
 b9v1DfD2wlI1wVQDx03kk/61
X-Google-Smtp-Source: AGHT+IHMdUooMraBHcjGUCkAKW6kvrakiQPNXG1lJaT8iTfrJ8CMjoL07sHgyE2DbZxAyX0P+d8Q0Q==
X-Received: by 2002:a05:600c:1c28:b0:434:a734:d268 with SMTP id
 5b1f17b1804b1-436e2699dfbmr35582275e9.14.1736358375231; 
 Wed, 08 Jan 2025 09:46:15 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dcc8f8dfsm41433835e9.0.2025.01.08.09.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 09:46:14 -0800 (PST)
Message-ID: <eed31d9e-7c0f-4a96-9442-48bb2c56337f@linaro.org>
Date: Wed, 8 Jan 2025 18:46:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/81] target/arm: Do not test TCG_TARGET_HAS_bitsel_vec
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 7/1/25 08:59, Richard Henderson wrote:
> Rely on tcg-op-vec.c to expand the opcode if missing.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-sve.c | 20 ++++----------------
>   1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index 49d32fabc9..732453db6f 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -596,14 +596,8 @@ static void gen_bsl1n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
>   static void gen_bsl1n_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
>                             TCGv_vec m, TCGv_vec k)
>   {
> -    if (TCG_TARGET_HAS_bitsel_vec) {
> -        tcg_gen_not_vec(vece, n, n);
> -        tcg_gen_bitsel_vec(vece, d, k, n, m);
> -    } else {

Why aren't we doing the NOT n operation here?

> -        tcg_gen_andc_vec(vece, n, k, n);
> -        tcg_gen_andc_vec(vece, m, m, k);
> -        tcg_gen_or_vec(vece, d, n, m);
> -    }
> +    tcg_gen_not_vec(vece, n, n);
> +    tcg_gen_bitsel_vec(vece, d, k, n, m);
>   }
>   
>   static void gen_bsl1n(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
> @@ -640,14 +634,8 @@ static void gen_bsl2n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
>   static void gen_bsl2n_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
>                             TCGv_vec m, TCGv_vec k)
>   {
> -    if (TCG_TARGET_HAS_bitsel_vec) {
> -        tcg_gen_not_vec(vece, m, m);
> -        tcg_gen_bitsel_vec(vece, d, k, n, m);
> -    } else {
> -        tcg_gen_and_vec(vece, n, n, k);
> -        tcg_gen_or_vec(vece, m, m, k);
> -        tcg_gen_orc_vec(vece, d, n, m);
> -    }
> +    tcg_gen_not_vec(vece, m, m);
> +    tcg_gen_bitsel_vec(vece, d, k, n, m);
>   }
>   
>   static void gen_bsl2n(unsigned vece, uint32_t d, uint32_t n, uint32_t m,


