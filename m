Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF88DE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 20:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOjR1-00081M-C3; Fri, 20 Dec 2024 15:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjQz-000814-5L
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:17:18 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjQx-0006cp-Jt
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:17:16 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2164b662090so20689675ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 12:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734725833; x=1735330633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Wzu3qvYrHBVxjr4KiDrCmUSLsZ1QkA2SekOGCYm13w=;
 b=PDmR7mZ4aLm/UC8hYhidpdeSETcLfdp5us0TlckjNzNJHjvPiETipWYMeWz1D5Wxhl
 310JCtHlqKYwu0F5ozf++iDJboGmS5EgYbu1xLzLurQCEPbT7vzqNOh+tQWnsOqJ+dAs
 iCi9uCRRsvTUQwrD9bhLLq0AMUzKmrCY5uzWAO+XDDmvqWHyxr3URmyrt6IT7LTwGKk8
 nb5iN1/8Kc+cz80wKIwKqTfEi07ITFQy8hcPb9pmSKBBdqudgMpGbeZdBounVAZJ6vvL
 bjE2B93+3wT1NxIgoxNLwpNLisg+JJlgzV+QiHO3Le9dL3JA23/cbhAlvCWX6xrrNC8Y
 pucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734725833; x=1735330633;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Wzu3qvYrHBVxjr4KiDrCmUSLsZ1QkA2SekOGCYm13w=;
 b=knkN518oHOSeoHFYITFSkDy52ZQzSut76wyUVGRIJrNkJ0qnpXgpYOTiIOBVCn5u+K
 Bo3ry7vnrDBOGs6Ek+6nYAJddSJECylN5jurGKK8O0WTKyU3O6lm6l+9eXmg06bxK801
 9qSmRs7WEvTpoJsMw3RAcB9r37g6ir1XqhNz964Q3U5dXydyMsXMh0jv/Ous1qTyzi7I
 dgxPKz3Z9oUoGEvCieDHHsztqNDcbHFD6COZR/UVJnJmSYVVGTYq+KTNoL++GMc19SiI
 Kvr+76RWb0TWebKRWv+kIIF1d8TNSgAiv6OuR3iukCIyq3deR9SHrvwnj/lQoAT420dB
 n6Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCsa/yzcz5b0IRNfGHq5syLrhEl3qZIwWkQaHKUZhqusWDNPnSgZZRt65129+OKT/QSZQ5wDSNn59T@nongnu.org
X-Gm-Message-State: AOJu0Yw29QQNNVsyBSmLLBaA7oYArdPsxOk9NkqQJpGKIOO5gPIe4aDJ
 Qd98n+EhUQpUQcSzc25vjxc4RlGHcZUtzzHbhVeJ5cBBprpj9eS/tfz72oaKDDo=
X-Gm-Gg: ASbGncsAXYtjG74Vz/dTyXQd7GRrT7CJ3vO/4D/QAHhwtjbdstDv/b+e/2V6sMRyqMh
 6cGWB6olNUk1OXpyW5LYBwSKOdLxnTW5lourh6A/E77F3oVs0Sd+TcBUHY/ZIqrO4nTYxXPNSiT
 NkAR7TbpO/5sXBRoj8321XSoV6GAzI+KVnMEFW0rMKvIw6osskJY1Iwa6Wn8PpHPcc6Bj/7Q4Xk
 BpcRMPk3PdivdunvZfD+UNjB8M6/SNmt+KSXZL+w+V2YNw1nMM5NRq4g4OssjdBqTNQiw==
X-Google-Smtp-Source: AGHT+IFWO//C3hcvkT2DGGiBbVazrVkhg+r0nhJ7W0vXK+AQ4dOkr2bRln9iVM7E/qzARe4l4oBV8A==
X-Received: by 2002:a17:902:d48a:b0:215:b8b6:d2ea with SMTP id
 d9443c01a7336-219e6ea1cc6mr46143565ad.15.1734725833587; 
 Fri, 20 Dec 2024 12:17:13 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dca02544sm32974715ad.255.2024.12.20.12.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 12:17:13 -0800 (PST)
Message-ID: <10227e5f-13d0-4c4b-be4f-ed72027554ff@linaro.org>
Date: Fri, 20 Dec 2024 12:17:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/51] tcg/optimize: Use fold_masks_zs in
 fold_count_zeros
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241220041104.53105-1-richard.henderson@linaro.org>
 <20241220041104.53105-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241220041104.53105-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 12/19/24 20:10, Richard Henderson wrote:
> Avoid the use of the OptContext slots. Find TempOptInfo once.
> Compute s_mask from the union of the maximum count and the
> op2 fallback for op1 being zero.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index b8e9ded821..270051acd1 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1583,10 +1583,12 @@ static bool fold_call(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
>   {
> -    uint64_t z_mask;
> +    uint64_t z_mask, s_mask;
> +    TempOptInfo *t1 = arg_info(op->args[1]);
> +    TempOptInfo *t2 = arg_info(op->args[2]);
>   
> -    if (arg_is_const(op->args[1])) {
> -        uint64_t t = arg_info(op->args[1])->val;
> +    if (t1->is_const) {
> +        uint64_t t = t1->val;
>   
>           if (t != 0) {
>               t = do_constant_folding(op->opc, ctx->type, t, 0);
> @@ -1605,8 +1607,11 @@ static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
>       default:
>           g_assert_not_reached();
>       }
> -    ctx->z_mask = arg_info(op->args[2])->z_mask | z_mask;
> -    return false;
> +    s_mask = smask_from_zmask(z_mask);
> +    z_mask |= t2->z_mask;
> +    s_mask &= t2->s_mask;
> +
> +    return fold_masks_zs(ctx, op, z_mask, s_mask);
>   }
>   
>   static bool fold_ctpop(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


