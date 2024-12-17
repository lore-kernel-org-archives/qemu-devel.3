Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB6EE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNe5b-0001lX-5m; Tue, 17 Dec 2024 15:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe5Z-0001kn-CG
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:22:41 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe5W-0000oZ-Bv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:22:40 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-725dc290c00so68785b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734466956; x=1735071756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+KJ9KT2cEQGncEwsI026ZzpLTDDDDmwjOHQDqNfU+k0=;
 b=jEUXhD0hGMNm/u9xbSQdY4A1WIJ0JVQrDTfHv7w2+qv5S5h0A2k3i1CANzTxlaOCxs
 xiS+0pdxFhDrA0SQIO0djhxxZwW7FRIDz3Z/dChs09hHoyPIf5s3UVoKsQXwb7+93sj0
 GzWEeaiu+R+TRihVaNnK3A7Rqc0TB4gx/JSCGhfOkpUGju6eq3Ic9EzG17dCgIO2/H9N
 gMrAR7zj/AUozlwAADi9C2/oRo9m4CgwlOiL60HMkESPXSkNcvNSbZ4Hit6pbrHxRzj4
 AL1uagh2DR/I8jIMIvW/i2A7OWrUrcXiX6zTyoyvAp/OgbehhV/Hy/mKKJP+egEm04/R
 r8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734466956; x=1735071756;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+KJ9KT2cEQGncEwsI026ZzpLTDDDDmwjOHQDqNfU+k0=;
 b=Bh1J10Q9I11vdpA8abNMUvOEfY3+jALlYOrhOY9bEx4r3EGAEtv3+VQULHH1KBFooe
 yuxN/QzICrt/KWQJEc9kkaNO/qF/gAzAIN9sfUh8voDcc1kSTEO51bmcEBkuEalksKkS
 6VIPOC7P4kaX8qma15cxGD6ZixE1c1QrK56AFrZkYnBKaGAiOHhySOEqOaURFWzCkf3E
 dc2WeBnPARo3UlzC2Ka8x1iYNSPNUOp93o8AcG6znY5mBNjlf6PjU1zJGv+XSU8uBG5S
 MyIvE83N890yKp+Ktg4WMWFMCOU4kLsvziEUnsk07BcVpgBQrGLP60hifZAJMaEdR+r9
 1WvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuxxMbulSQG/N/3lR7oVg1MtDy5hUKaWKe1s9NJwxCgVT7o7xOdfb1lvd6sK3f7mfQFaHtHV0i1EOG@nongnu.org
X-Gm-Message-State: AOJu0YwtZCledJacF1nktVpVfT5luA1lHtckGEdJop42rWBWzPiXexb3
 CWdQcRwQFM5MZpksEWZIBgYEEd6yv+gd2BnOJ2dnIGCAP+pTfwbvMVbMxjUcdiw=
X-Gm-Gg: ASbGncuHpz9sMB4nu/LN0sDNSCfvGX1Kha+16+2BeafgDMzMoye37M8/aq9yag3q7Dx
 8hAJNuzsMpam7fStvPSANbzBB66/RBHgiN3gGu0NXKLZuNJR2SxHD4uwdScoKWJTRkRQq9m+nMc
 eXGfZrHXE5qDK2MKcKJZvEbIYGr8ESnAe5CfpaR14BL9OAICKoW0zqFwLK9mLjL7VTcIA3L5QHI
 A3VY3lD7oY0SayKPeoHsLws/UiNIpSopj377uFdWlllgPSAetbdTUCyZvym683PbmKNCA==
X-Google-Smtp-Source: AGHT+IHZSmcp2yDDsTd9Jq9v1OlzAG1aHYp8YKdQZXxgdQcVTGriZDs4Kyx/1dEOUUEobkQVCN+KUg==
X-Received: by 2002:a05:6a21:9988:b0:1e1:a920:225d with SMTP id
 adf61e73a8af0-1e5b5a6ee94mr198875637.19.1734466956381; 
 Tue, 17 Dec 2024 12:22:36 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bc058bsm7082510b3a.175.2024.12.17.12.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:22:36 -0800 (PST)
Message-ID: <fa1fcd60-0cc1-47f9-a7fd-d621273be6d2@linaro.org>
Date: Tue, 17 Dec 2024 12:22:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/46] tcg/optimize: Use fold_masks_zs in fold_eqv
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-15-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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
>   tcg/optimize.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index e6dc9f2e28..5f3a824a07 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1701,15 +1701,17 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_eqv(OptContext *ctx, TCGOp *op)
>   {
> +    uint64_t s_mask;
> +
>       if (fold_const2_commutative(ctx, op) ||
>           fold_xi_to_x(ctx, op, -1) ||
>           fold_xi_to_not(ctx, op, 0)) {
>           return true;
>       }
>   
> -    ctx->s_mask = arg_info(op->args[1])->s_mask
> -                & arg_info(op->args[2])->s_mask;
> -    return false;
> +    s_mask = arg_info(op->args[1])->s_mask
> +           & arg_info(op->args[2])->s_mask;
> +    return fold_masks_zs(ctx, op, -1, s_mask);
>   }

Should we introduce a fold_masks_s function to replace this call?

>   
>   static bool fold_extract(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


