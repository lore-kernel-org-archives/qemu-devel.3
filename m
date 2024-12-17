Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349C8E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNePF-0001Jc-6x; Tue, 17 Dec 2024 15:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNePC-00018L-5O
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:42:58 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNePA-0003tL-Fh
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:42:57 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-216401de828so46422715ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468175; x=1735072975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B0oF5MkOGu8wtXYJuZ3adLbGU95w38wh5sUPL7flfM8=;
 b=BmXWWhkefmLKP0wmdwTZLkOWpxMIATaMAyRcqOWeD19QR+7dyDul84AdpNUTreX8eu
 TX04UR2TgjtxNqwTgI3QFacmlgWIEY7n1sE6ohRM9ckELbKxkX4vsCQ1H/nSqtLHpVhF
 xNYJzXspWUYKG1WaF2awppCKj1HAaqOwSQvZvG8fnx2R0InPfyIpSMf3+XSFslXI4nAM
 p+SO2L20HLhiZ0umBpysJ0qrQBGNRo191zfUzvF/54kjAoXn0koyuDmaQRQ1NDyzEJKs
 50BXoqQ/vw1sO8+eQrM7LYBWBUKfMF1mjtE6HoQuJiYKfb0N6v/J6+LmypKblaEnamdj
 YpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468175; x=1735072975;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B0oF5MkOGu8wtXYJuZ3adLbGU95w38wh5sUPL7flfM8=;
 b=mgjiniQdmLesxO4VUfDeuikdxloqr7ll4gtV0Fw9NMidKncHCwd+Boaqju3vjfG+yv
 b3Ys7YeGRP4SOCxi166JHSHAO6uPXjZSb6XxixYI6+KONNiP5TC+g/bcDvMdaqstkH18
 S14kma6BD5DMwDyRZhkbFcOaftREuKhKIURuEiB99hpFkWBtOguNaes/xjqg8a+Tt7NG
 2ogQh1Kypw5zGJVdEdDh5RiPtCXE42uGVVlkQYpYOT6bxuHNlgtfIgbFJqYSK/nlaSyv
 k83ff7Dc6dlbesGF6w8ndQIIf2a79OV9XV9OfH8LLDDUx/K5WZcrAfy6Nd/bqCmTtezW
 us/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUgJjQ0EFvQ/HOmS7kqkCs0Yx758JXhhRFo2qTHyxTT+5l7JJICNrgpFClPo92Opxhf3FYn5RFERBa@nongnu.org
X-Gm-Message-State: AOJu0Yw5QiC88UszawLZZUo3GVGOFjoXsPL7ZIy0rzVj9WMan4lkzJY7
 8mstO0M/wvQu5f37o5+CFlTIClOxQBsnYfbq538jvQYv5jTEZcqpr2IggLVgQA8=
X-Gm-Gg: ASbGncuAfsEEIxV8hG3isyzapPnQSGWdzaEHC48Qfuz+bXUl1LvSpG+FGJcbJwU4sLD
 nEzGoCp4veLSV4Kjq5K1KQwmE2wuGB4fSYOz+Shri/skVvF0wKt+BJYqi4/N5H82FafdcYDZbUY
 dzDyd6/DzHWpIh5kAlBJaosYWn1BaARMlT4yaErFGSkVstcBAANTNcBGfvyy0MHC3FWIJwtKmbR
 mP4d/tVtFaatSADcrAhUUjPOrkNg4N1DOi1SFARWclIxSUVmnryVXw7FtSx8foBA5Q/LQ==
X-Google-Smtp-Source: AGHT+IG0KJz8o6ToFqWB74+Mmxd4h2fNTpUIJtvnclADyFIz7+O4bi6EiIjn8nUd7CjtdD4/0XxnCA==
X-Received: by 2002:a17:903:41c6:b0:215:9d58:6f35 with SMTP id
 d9443c01a7336-218d6fbe657mr2735145ad.1.1734468174851; 
 Tue, 17 Dec 2024 12:42:54 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcb35esm63878895ad.62.2024.12.17.12.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:42:54 -0800 (PST)
Message-ID: <212872b5-9b47-4c70-acb2-38d944bdc1d0@linaro.org>
Date: Tue, 17 Dec 2024 12:42:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/46] tcg/optimize: Use fold_masks_zsa in fold_sextract
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-37-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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
>   tcg/optimize.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index c99e6f79d2..551f96dfaa 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2488,7 +2488,7 @@ static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_sextract(OptContext *ctx, TCGOp *op)
>   {
> -    uint64_t z_mask, s_mask, s_mask_old;
> +    uint64_t z_mask, s_mask, s_mask_old, a_mask = -1;
>       int pos = op->args[2];
>       int len = op->args[3];
>   
> @@ -2502,18 +2502,16 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
>   
>       z_mask = arg_info(op->args[1])->z_mask;
>       z_mask = sextract64(z_mask, pos, len);
> -    ctx->z_mask = z_mask;
>   
>       s_mask_old = arg_info(op->args[1])->s_mask;
>       s_mask = sextract64(s_mask_old, pos, len);
>       s_mask |= MAKE_64BIT_MASK(len, 64 - len);
> -    ctx->s_mask = s_mask;
>   
>       if (pos == 0) {
> -        ctx->a_mask = s_mask & ~s_mask_old;
> +        a_mask = s_mask & ~s_mask_old;
>       }
>   
> -    return fold_masks(ctx, op);
> +    return fold_masks_zsa(ctx, op, z_mask, s_mask, a_mask);
>   }
>   
>   static bool fold_shift(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


