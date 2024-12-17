Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930E5E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNdyN-0004FQ-UE; Tue, 17 Dec 2024 15:15:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdyK-0004Es-5K
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:15:14 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdyH-0007wQ-LX
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:15:11 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7ea8de14848so3126087a12.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734466508; x=1735071308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xb2ybXdUTAdzc3aBDL5M5ayiOFSdSHqlo0qFW65lrs0=;
 b=t2yiQ2vWcHdOIFdq4Jg1+usOlLDBIZzyDCbGywCK0C+ZVZp/gme6io9jymugGnZveu
 cLrjl6YfHy4duQCSeXDd7i4ffwCqRMb12jAWnvOIXIx6Ph8Xgig8Q9JIe20UNm3bWYhl
 /2V7cMecUjTJOr/K+0qA7CSEHsoKvAo8X+RUQ7T+LYHZi7PZO1VoZlD4b8kv+36yyEC/
 oJdz86qsSMSmTXYUUjm8JRyAz6hrdbnYleoXrVqIiS5Bd2W7Nl0UsrCuXt/Sf3M4mPIw
 AMw8oh63ZJgBz6juCJN3ESSi0ZdtRVHPZOiZz93HmQDp+B5DctJz7MKlfvIw36N4fYUr
 FhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734466508; x=1735071308;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xb2ybXdUTAdzc3aBDL5M5ayiOFSdSHqlo0qFW65lrs0=;
 b=hBrn8UXVr2VYDi5/s7LKo/I8nvYfNjFxB2Sl4sGO/Lvow3FTEfmtJfJCK8UEedhbdU
 INhlpPQ45t9oKUpGMfo5iHOTRhIMhl9/ANvwhNBOgQMq+KRCpxFWwaZiOXA72Q2p2rhz
 GXB1sbe89TDrVr2czLbegOQABFYCC+mpvf0e32tz2lj7E06H4UVWdVit4R8SbxQ7PKKE
 TJnJhZsWZ1fy/tMoCv67tfw0VC7wn/3xTq3lNbdFQvNP+iDmk3oyzHJ/WzHpB1eg+mc9
 uSirdPM24DuJ1uoJ/EMR++uHbT0pL/o8RXESLQL2BYBiU4KuIxZmbVYjYaNdAEB+gjzE
 l/qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFlDUqgXrpo1eXd88PjX6kydwlItXMl4JLlU2ZMqx84mNyt26MUWSTy6BZjjq54kJ9oKqDpp5dKxnD@nongnu.org
X-Gm-Message-State: AOJu0Yxe6N41cWLj8D826LMu1lgaP0WNc5MSyCeoiz+teqD3QkbP+RQW
 mTvCzbd+XxFfgvuXoBYiaLIKx9M23oqYn81+ipRBmU3RCDYzh5BBQ9IzkOk5EcQ=
X-Gm-Gg: ASbGnct96dGAeugS/fRr2Yu0jRBYlGtV4TD8jBIMKBfhQp6arbBlmhXep3Uah8a5M/N
 mJaTQ8TUdQQffOkw9YuOw4tz+VzpmC50TXmiPcsdKKzDhVjEaBF2v6qo9TDeTW0I3wsHF1R4/qX
 8HE3JYD3zwzg/Jd2xiCZyuNyMbFpZza9Zc3b6FOuapN8X5Prs7eRISbdSPn5Ih3ybDwgaEMdr5J
 duyYmNxPBVwgknhgErsuF9XUP1X6K786+U5ThHHBbuyziLa4epykNtldBqRHDjfDSBXeA==
X-Google-Smtp-Source: AGHT+IHsbkqmuEOXpCYkUqw3yU6ZZh6a2n6cphRG5lw/980BapIoh0edxRQye6rk1/U4dyXLTVAKSg==
X-Received: by 2002:a17:90a:e184:b0:2ee:d433:7c50 with SMTP id
 98e67ed59e1d1-2f2e93786ebmr248359a91.23.1734466507855; 
 Tue, 17 Dec 2024 12:15:07 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142fa1cedsm10460916a91.33.2024.12.17.12.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:15:07 -0800 (PST)
Message-ID: <e486ec9d-e199-4585-865e-1b94f55408c4@linaro.org>
Date: Tue, 17 Dec 2024 12:15:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/46] tcg/optimize: Use fold_masks_zsa in fold_and
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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
> Avoid the use of the OptContext slots.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 135b14974f..000ac0f810 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1306,7 +1306,7 @@ static bool fold_add2(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_and(OptContext *ctx, TCGOp *op)
>   {
> -    uint64_t z1, z2;
> +    uint64_t z1, z2, z_mask, s_mask, a_mask = -1;
>   
>       if (fold_const2_commutative(ctx, op) ||
>           fold_xi_to_i(ctx, op, 0) ||
> @@ -1317,24 +1317,24 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
>   
>       z1 = arg_info(op->args[1])->z_mask;
>       z2 = arg_info(op->args[2])->z_mask;
> -    ctx->z_mask = z1 & z2;
> +    z_mask = z1 & z2;
>   
>       /*
>        * Sign repetitions are perforce all identical, whether they are 1 or 0.
>        * Bitwise operations preserve the relative quantity of the repetitions.
>        */
> -    ctx->s_mask = arg_info(op->args[1])->s_mask
> -                & arg_info(op->args[2])->s_mask;
> +    s_mask = arg_info(op->args[1])->s_mask
> +           & arg_info(op->args[2])->s_mask;
>   
>       /*
>        * Known-zeros does not imply known-ones.  Therefore unless
>        * arg2 is constant, we can't infer affected bits from it.
>        */
>       if (arg_is_const(op->args[2])) {
> -        ctx->a_mask = z1 & ~z2;
> +        a_mask = z1 & ~z2;
>       }
>   
> -    return fold_masks(ctx, op);
> +    return fold_masks_zsa(ctx, op, z_mask, s_mask, a_mask);
>   }
>   
>   static bool fold_andc(OptContext *ctx, TCGOp *op)

Call me young and naive, but having a masks struct, with a, s, z fields 
would be more readable IMHO, and less error prone between the "local" 
and the "context" values.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


