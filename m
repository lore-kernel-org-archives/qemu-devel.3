Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD53E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNdzV-0004pi-DQ; Tue, 17 Dec 2024 15:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdzU-0004pK-19
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:16:24 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdzS-0008F0-4L
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:16:23 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-725ee6f56b4so5036267b3a.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734466580; x=1735071380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E1MqIxH5rYYrZazVybfGGgLbq+zcLkQHWJarQIC/A88=;
 b=DaIb9qu2SsWlz6Wu1Lisu6aSH1nQP0UwYZmdvFFS9nRIUOkBPGhzDPw51byNw9dlRE
 XGp24I6C39KtqIAaokbjodgWJGEBJ52/l7BN3Ml861aGJnUHF2y0L03loicYRCezf53O
 ZnixuFm9RoUs4zcA8GduTpMYTWkcDCT6c2o1DF/qlBd0LVZXatOmMHdrlQrL+6xF5fBM
 c9lvtcK/sdM6a6nJxFZJHM9BJ38Iach1fAhe/GT//UZZjL5wYlvy+wuccU1NoCQ6qmpx
 GsfBmQd9zfc0zjp2fT6qalpqgB4GIiZoMd9sxgNnFLfIUbLa/r8HxUPv+jLPfCLHz7ap
 zmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734466580; x=1735071380;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E1MqIxH5rYYrZazVybfGGgLbq+zcLkQHWJarQIC/A88=;
 b=KlmNStCq+KneMx2rhl2YPEfd64pgEht0kwqA8Smg7HHWdDp9JXOOHCYXSWjA8X+4Rc
 v0OPtl3UB0+3e/f/ubHmh+4QO/2tjNS4n+VhWOXwm0LN5yagbvRL14HpxcGNjkfVU+14
 n1PM6AiO7CBMRJTXkFzVWv5yhRgM56QjkuWA8/DAL+NeWRI7R615u3jNAodIKyYo49UB
 02qrbrCgshGzN6R6xJqTszr5MYuWQ2w+khygv5xbfDezShVMVJTFY/gAETwD67iy++Yw
 nEKzOs37YnVR8Jo7+pZ0jfjOqlPd8ub/JoFDEHyL78KrXTAyV3JIPBLeRMPwTE9YL29K
 WTtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0W/b8+1+bdJXNW7s2AKiQteauhysGF/fSIAhMHIuClUairfXHpxTqn8fZMg91Kke6hxZgEBOcVips@nongnu.org
X-Gm-Message-State: AOJu0YwpvD2dE+kkM/q7DNtRN3g8bnXx+pZDY32ZDsuFEQUjrXJToOHj
 dRd6+1j2w17j15Ysz2VR6Ns/2GpcC/qYJkj84xaG/pNSnA9Gac53pYFOduANNhLqu5fgNko6uHs
 MXiHRhA==
X-Gm-Gg: ASbGncvhg4WOiYqaZeXxe6F7ndjBAaBQdHGeeeDcw46eB/VTxwxz6m4BLl3g767H5jF
 UZJTczR9iUzIpyl+Y9oPJkhqbCL9uBt1/Odn3R32zr5q9GQ17eUnXrP9dS4IuhD1Kalb8NHSmfq
 +DayAFNC0nif8qTHBXX9uJ8lw0VvFvikWCCYAHFD2kaT8dsExtBH/nikznxopELndH1FDIPmavI
 Mwsjfj8Jt/LTmTjXVeZynNposniXBcDdH9Xx+JrjTos0GgWor3eODyo+eCizAmxaAkS9A==
X-Google-Smtp-Source: AGHT+IHuHnt+nxx702wV9N7+9ftmVOToDOP+4C0Y3hWwX6Z+MuXESonQ+OlCuOl0H4Xo0bgqy80ZPQ==
X-Received: by 2002:a05:6a00:1948:b0:728:eb62:a132 with SMTP id
 d2e1a72fcca58-72a8d2642cemr423482b3a.15.1734466580329; 
 Tue, 17 Dec 2024 12:16:20 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918b78f7dsm7057601b3a.97.2024.12.17.12.16.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:16:19 -0800 (PST)
Message-ID: <f92ca954-e3a5-4961-b57b-0757d73dae81@linaro.org>
Date: Tue, 17 Dec 2024 12:16:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/46] tcg/optimize: Use fold_masks_zsa in fold_andc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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
>   tcg/optimize.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 000ac0f810..285407ce05 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1339,7 +1339,7 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_andc(OptContext *ctx, TCGOp *op)
>   {
> -    uint64_t z1;
> +    uint64_t z_mask, s_mask, a_mask = -1;
>   
>       if (fold_const2(ctx, op) ||
>           fold_xx_to_i(ctx, op, 0) ||
> @@ -1348,7 +1348,7 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
>           return true;
>       }
>   
> -    z1 = arg_info(op->args[1])->z_mask;
> +    z_mask = arg_info(op->args[1])->z_mask;
>   
>       /*
>        * Known-zeros does not imply known-ones.  Therefore unless
> @@ -1356,14 +1356,13 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
>        */
>       if (arg_is_const(op->args[2])) {
>           uint64_t z2 = ~arg_info(op->args[2])->z_mask;
> -        ctx->a_mask = z1 & ~z2;
> -        z1 &= z2;
> +        a_mask = z_mask & ~z2;
> +        z_mask &= z2;
>       }
> -    ctx->z_mask = z1;
>   
> -    ctx->s_mask = arg_info(op->args[1])->s_mask
> -                & arg_info(op->args[2])->s_mask;
> -    return fold_masks(ctx, op);
> +    s_mask = arg_info(op->args[1])->s_mask
> +           & arg_info(op->args[2])->s_mask;
> +    return fold_masks_zsa(ctx, op, z_mask, s_mask, a_mask);
>   }
>   
>   static bool fold_brcond(OptContext *ctx, TCGOp *op)

I'm not sure eliminating z1 is worth the loss in readability here.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


