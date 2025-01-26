Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130DAC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc1zk-0006LG-E1; Sun, 26 Jan 2025 07:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1zd-0006KN-Rb
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:44:05 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1zb-00075E-IQ
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:44:01 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so85143295ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737895438; x=1738500238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GpCQfii3foxbAJRLa6zrJg25Oyp/X4l5pjXJt3RTpV0=;
 b=B5K5w/gh9rso89PAlHmnuoxxveNaG2459vhHer+sg8nblpH2F1AhOGXnmsnXVA9aMO
 /6EFw0eJnCYKvSQtZoRp0Mi+6UsfLgnr8QuHwJOMKJqH50JUiMKauFjwMk/+IQ30A41l
 cCaW43iJ01HKtw9C3kHX/SY7Rgj7gXmEqNX91FttGx5U+WAfCRZqoPLgqfNTZmilgdqT
 t0puqQ+MLdA9t6/B3mZT32vBt3f6PXFIMIX8p9uBkSOY2VGw3Z9MI0d1LL8k/FawYuIJ
 uVHTNg/hbLPlZ8us1CnUBHilwFTS6wR2LDUaJPl2co/kjaDlN/C1Z0sk8kTbrWTF2fSo
 QTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737895438; x=1738500238;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GpCQfii3foxbAJRLa6zrJg25Oyp/X4l5pjXJt3RTpV0=;
 b=o25XLT7IE7bxQf3oPpfvqdXawBBXmiXAVX0jerkSph7JD4u7Nr6IyYZ7CzKzYi+gFJ
 Ru01H8yTilHswEqQ7mluenFVeaHleeCdOkyTZA60h9LXbcfgE5uSOw0nQQny7ZgDFYM+
 lEdcZ1toZ8NHOmUrjHNXJatROTa2A2FrLt6LNzq7o7f/swhSNgXbFl2vW+cFXVKBWISW
 xcD2FgcH+0sbVnFqNBsfjGpyiJghJLpj5dtARYxXltjMWhukUXBe1Z48uYQ0YGbpBNQm
 RTVqx0eRddyMkxW9grA+bR8E76GM2s+CDARGn6Y976hjCEpYKKBgG0InAslf+QD3gY8/
 XpEw==
X-Gm-Message-State: AOJu0YzgGUNhHOTU5H+1hSUOpGcN+X8TJcctp3p8g9yU6uzyxqHHqnKP
 UfiBVKrJJK/8k4Te6v08upvjfyWx/K4VoyPJmX733YzFCF9TfbqPd9epylF8x8rBHzB1vLMR9Tr
 M
X-Gm-Gg: ASbGnct1XfrS7YSouhOelXlC5SYHZ+7SNsOT1YHb+alDI9dZlMFMleBmz3kpHJyAKuH
 7C1dtrJAf5qxRmVgCYGTUUZ6jqXcx1UuLzPLXa+0KcDNwOmVABfvEr3Tfvd/fVzySc8cPBglQig
 IhWpUTjfjLmv/T6Q1uk8UDhyMupUUINVURX+U3IXc4h2ZhJxtsErJKHO5Lk3orxP/3dhyvH6zeB
 JyWxYluZSZgvuUpO705m4ZKP4UrFl0UDbr1jsMih3jnXn0zhqoqEXSkfEIDkRkuWjBjPvU1rDvk
 P9J9KR55U0nXyZLia7ujuA8=
X-Google-Smtp-Source: AGHT+IHUKMBNU/suOO+mOymAmpKPtHWCzFvPVZ3OtYPnTEztnkq0H+YRZF108qBYillbNbnx53haog==
X-Received: by 2002:a17:902:c94d:b0:216:3e87:c9fc with SMTP id
 d9443c01a7336-21c353ef5damr615579845ad.5.1737895438040; 
 Sun, 26 Jan 2025 04:43:58 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9e092sm45689715ad.28.2025.01.26.04.43.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:43:57 -0800 (PST)
Message-ID: <7e368ef4-a60e-4308-aeb9-ec910361c424@linaro.org>
Date: Sun, 26 Jan 2025 04:43:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 45/76] target/arm: Implement FPCR.AH semantics for scalar
 FMIN/FMAX
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-46-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-46-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index 05036089dd7..406d76e1129 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -399,6 +399,42 @@ float32 HELPER(fcvtx_f64_to_f32)(float64 a, float_status *fpst)
>       return r;
>   }
>   
> +/*
> + * AH=1 min/max have some odd special cases:
> + * comparing two zeroes (even of different sign), (NaN, anything),
> + * or (anything, NaN) should return the second argument (possibly
> + * squashed to zero).
> + * Also, denormal outputs are not squashed to zero regardless of FZ or FZ16.
> + */
> +#define AH_MINMAX_HELPER(NAME, CTYPE, FLOATTYPE, MINMAX)                \
> +    CTYPE HELPER(NAME)(CTYPE a, CTYPE b, float_status *fpst)            \
> +    {                                                                   \
> +        bool save;                                                      \
> +        CTYPE r;                                                        \
> +        a = FLOATTYPE ## _squash_input_denormal(a, fpst);               \
> +        b = FLOATTYPE ## _squash_input_denormal(b, fpst);               \
> +        if (FLOATTYPE ## _is_zero(a) && FLOATTYPE ## _is_zero(b)) {     \

The comment says "even of different sign", the pseudocode explicitly checks different 
sign.  But of course if they're the same sign a and b are indistinguishable.  Perhaps 
slightly different wording?

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

