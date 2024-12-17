Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DFAE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNdzx-00051v-Nb; Tue, 17 Dec 2024 15:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdzq-0004xR-62
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:16:47 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdzo-0008Lg-8C
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:16:45 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2167141dfa1so619545ad.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734466602; x=1735071402; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZtLGwMd+0OMfmmtzlDrVk5OqOXK9tv9CW/qdMVYixGw=;
 b=fFbl/+QPrfhzU4kOefDPe6UgSc8Sf14f5DLJdSoa/5lWX1YrAZKJMl05mECA7JL6Fm
 Yz1yx2Wr9gRpKcAcErK3oqDCQklKTnPuxiHXJc24WEPgBktBJyxOglx1+7gKRAgY5YZu
 qHT5LTaSqwJWLnDz5q3hPEhYSCsWxw3+jE3dHfOsQiZEGHKhuZG2+S4dboeRm/T/0wvd
 uuDQ5pEBS0JzUrzVsl2jvKHH35UgEqMDB0zHH9XJlyk0tMtP3YFvwnL+QCroAdgF2PSl
 zIW7B3tOFbNFOdtfyazVsJuljYpS5zmIX/2+ITj/8CtzYcFWeDFfVpgzYa8tHQwevuKs
 0aOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734466602; x=1735071402;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZtLGwMd+0OMfmmtzlDrVk5OqOXK9tv9CW/qdMVYixGw=;
 b=vs49ipTF2zwdLmlZo03nBk3b39fXAm+GiIBbQPkKYqeEnRvfhz4/QJ8LwiIFo/JyAs
 74AkeTDqVeH+jCS7w4WVZnU89rMF3SRtJFavrr4RyBYHUlxmY7QojkWripn6R1fSnzWe
 t9DQog63GOAu/mq5KGDfH8heQn/iNzKNmaQYzehirTWumYx1zU2D+B5Hda0W/zhOWPCw
 tHj+2vDttzEhgVzNZslzDnPn1aMUseQvioG6CjnUa07jTxR22HgUhAQUslXTTjEXsGPC
 9yChk59Ab6mvzf3Kal8/yLn5a8u5AMbwGRr1ng5T9qrDKAZyBApkXRntQMaCIXzR4aF4
 2fjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKx33Avwk4jBRTkZIfmyFDI+NP9uiR/fvYECoVJQxvNM+/2iujrnljvy41Uj8iJnZY3s5XBSSQBwk8@nongnu.org
X-Gm-Message-State: AOJu0Yy5oKIzwTTsjJS2snLEoV8AoqHefXmW64yANaWOtTuUUsc8L4zc
 0wtolK+NnJbb9zUXQ2S3LbBDrzPjQ2ZyxQPiY7NcUOXZW9tSdiW3bi++clsPWWaK4jOfAYRCIA9
 Yrqkeig==
X-Gm-Gg: ASbGncujnWOAd5EtB0YoisKLxjd6TmSCrUfFBhyjlABKJCj1P2nWpS6gCF2DGj8FnVJ
 bkHN2/VFY6iG76YIReU0QTED++IYMRO31jnmIgpPLCqE1uHjrHQnx749R5JArXh4gmuXuckYEFc
 SIROWE+3OJMiifPN6npYMOuAEJwvTWXyIxjlb6N8dQ9M71rifsB2t13EigFIziuPz7U8EDmeKbh
 Is7em3Ez9/162W0JDVFycTfWBCQA7393n6KaYmX8kdDzvT9S+rEns4YC3J5A5KOwUCKfQ==
X-Google-Smtp-Source: AGHT+IGOJFN2TXKkEnWqHpP5eDJTKNquZtAEQPghNRBmTAR0MuY7sMdybE1fupYdJxg4+OlqREf7dw==
X-Received: by 2002:a17:902:d2cd:b0:215:a034:3bae with SMTP id
 d9443c01a7336-218d7536a11mr1764865ad.18.1734466602535; 
 Tue, 17 Dec 2024 12:16:42 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e7227asm63310835ad.272.2024.12.17.12.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:16:42 -0800 (PST)
Message-ID: <d06e9b1b-04fb-4a0a-99fe-025af0d503d1@linaro.org>
Date: Tue, 17 Dec 2024 12:16:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/46] tcg/optimize: Use fold_masks_zs in fold_bswap
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-9-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 12/10/24 07:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 285407ce05..3363ebd48c 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1082,7 +1082,6 @@ static bool fold_masks_zsa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
>       return true;
>   }
>   
> -__attribute__((unused))
>   static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
>                             uint64_t z_mask, uint64_t s_mask)
>   {
> @@ -1528,10 +1527,8 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
>           s_mask = 0;
>           break;
>       }
> -    ctx->z_mask = z_mask;
> -    ctx->s_mask = s_mask;
>   
> -    return fold_masks(ctx, op);
> +    return fold_masks_zs(ctx, op, z_mask, s_mask);
>   }
>   
>   static bool fold_call(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


