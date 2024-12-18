Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7CFE77183
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 03:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNkkK-0003sL-1r; Tue, 17 Dec 2024 22:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNkkH-0003s4-S1
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 22:29:09 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNkkE-0000BM-P1
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 22:29:09 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ebb669df2eso159158b6e.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 19:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734492543; x=1735097343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=agV6bBNdOw8VtTOZgL+VaPIz8tfB9LkiE8zJ70mfHqg=;
 b=GHIyoNyRf4N7xUrtHRYyq/NLmJjgeA7E7XYM27tCVulYTLZT62HdC13JXYLkAlQoHS
 rF6Nfj1axZtoVQlmSpOEZXy+dO6HnTBH41gjb8zMnSvph1q6XhwY+C6FuDeN2C278ivp
 GMVYZDUg0a5Od5a6d4ygogUAHkhqL2PBTtzUpYOCLFvAWoubuxbfi+tL9b/JMAhMdMrh
 tMYduAcxEiddcCdXz2FW0//0YMxTVElguovU6V4brSTZcGPkxBqmsZ26SOTHIOiBlCnb
 Mr03zrSKt96sEldhgdMkY2D4a/Xr3K0ttmwIiDja8HVcsa9oolAC3YiL0XL8x8/VUvg+
 CTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734492543; x=1735097343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=agV6bBNdOw8VtTOZgL+VaPIz8tfB9LkiE8zJ70mfHqg=;
 b=jHLo/R1ZUUParxNWSSXC7jzk/4Ibj3RWr8wV+Tvykow5AFd7gq82Rc5y3E68Bqbu+U
 RjbmKSFzBdAdB//Fmef8Jz+nliBZZ9Vu37loOBWfRrmlEk7Mw+bHtEuj05JG4AlxQK/V
 8y3jguz9OXZR8dQLMYeKOtYmSF8Ng92kgxUZM/Syu7L2VDZPdascvfuumB8lVtQ3uaF0
 wUgvKAbdY6Y2s5CWwjywfXArqAd5JTjgmgvBPhVjWbGT+DF7HYHAgm7HrHT+wTnzC2IS
 l+65AI0PQDNpTm+xL+eNl5wGhMf55RnMKrogvj/q9XMNGuvlP9QcWBASlco3TbCF+xHl
 +Dzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpb1Vjv8aDth29zP+kJDDyIvAyCM1mzDMyskrlZk38x4dHiaDSEX9hrmanrFpKY278tB1ZY74/ulPX@nongnu.org
X-Gm-Message-State: AOJu0YykU4phCOc24gt3YWKkdCnhFQD5pvPeRmn1q3jFP0IDCzmAL2P5
 I0JuxwRK1VuAW4Xw493y2hXfbUC00Di8lhjD0165dvlD09UMsPfbsyX1s2VCrLs=
X-Gm-Gg: ASbGncuQwLbNPKBpTlXSxWCq7roik+nC8pr9LZLKSziWLZoQE60gcDdlRXnsFdVNm+d
 Mb+EBnfBek5EL4F3hLjJQyjg+0sVoRs4/8GY+HlfEYiIYCrZFEjhOw0864nCdwBfmTwmHHNTlpf
 ukozCFeMYD00yWTXQj4idPZJm45uuLRVwnfASnPaR6CxrYF4b+BwPhJVY4xt2LogWqkAiTuUiKG
 zkvysqHLcdNgpOQFbcsXfevHC7ZFMKFckpTDm8JIA7DUDTSEVZTcQENEJ1rq/3kqGwgsK8RuA==
X-Google-Smtp-Source: AGHT+IFkHHJM8r7ED+n/YjpcevPxjvqQJ0//S9+pW6XpFF2FYoC+Ti6zUZfhUFRcmLO6qDX6gy0acA==
X-Received: by 2002:a05:6808:1a1d:b0:3eb:4681:a890 with SMTP id
 5614622812f47-3eccd06b919mr666673b6e.8.1734492542985; 
 Tue, 17 Dec 2024 19:29:02 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb48ce949sm2713360b6e.43.2024.12.17.19.29.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 19:29:02 -0800 (PST)
Message-ID: <c9830f41-d08f-4ecc-835a-e938d66c6360@linaro.org>
Date: Tue, 17 Dec 2024 21:29:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/46] tcg/optimize: Use fold_masks_zs in fold_xor
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-42-richard.henderson@linaro.org>
 <6e176656-7c87-4dc6-8dcf-2a53a43e4981@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6e176656-7c87-4dc6-8dcf-2a53a43e4981@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

On 12/17/24 14:45, Pierrick Bouvier wrote:
> On 12/10/24 07:23, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/optimize.c | 17 +++++++----------
>>   1 file changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/tcg/optimize.c b/tcg/optimize.c
>> index 46116970f3..fec46014be 100644
>> --- a/tcg/optimize.c
>> +++ b/tcg/optimize.c
>> @@ -1093,11 +1093,6 @@ static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t 
>> z_mask)
>>       return fold_masks_zsa(ctx, op, z_mask, smask_from_zmask(z_mask), -1);
>>   }
>> -static bool fold_masks(OptContext *ctx, TCGOp *op)
>> -{
>> -    return fold_masks_zsa(ctx, op, ctx->z_mask, ctx->s_mask, ctx->a_mask);
>> -}
>> -
> 
> Not so important, but eliminating this function could be done in its own commit.

No, we get a Werror for an unused function.


r~

