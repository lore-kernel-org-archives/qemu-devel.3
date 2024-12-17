Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39668E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeGP-0003Ne-P1; Tue, 17 Dec 2024 15:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeGN-0003NL-6u
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:33:51 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeGL-0002Yu-J6
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:33:50 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-72739105e02so6245844b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467628; x=1735072428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rcXu8q8cUK+q4AgQpumdtnWB22hYhJWIOwufUWGYIgI=;
 b=rihLACDBEjAegcknZrB6K2cKBo1VF6Hx4UR+6nw2nML9ilxDVFZPkzgL0YJUviCj/h
 kxQGeiltuG4WtgHp7/0tbqRBtAq7WbLaImUwvndcKExGjgF+4Xn7qPyetd3FZ4rJedBS
 /w97fng0BEU26BkrK4O0a8kHxZ7ulE+dZCFmFQTEcgMzFxk8Mzlx0jQsyjjVQKjcTUOX
 jcq4xa2qaZypT8uexCf3dibg1Z3RWbnQqQCDd0yBjARP+oqlXjekNO6mZz5h7LmDTgO+
 19Go0+2C+VBSfq79SjEcmwfnSwws24EQNG4K43gFMs4lgLj5Ywruy76ZO0z9qW/iFuRD
 4oLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467628; x=1735072428;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rcXu8q8cUK+q4AgQpumdtnWB22hYhJWIOwufUWGYIgI=;
 b=Ewio2/XoYd59OmjvJP/DAeChsgW6QdCkiJSXBRMhl2LI+MF+5JjuYohAje+rqyARuS
 uNDo06aR0m6YX+4QfXPR5mACZj95t7lOtuvOchu/kx0d8b7xwO7fDbPA/qKw0XNsgbBc
 H0bvGlOjQI8EIbdTMeDbeAy7o7CVW4ynAUCtiI8hJ7Xx88QEvUDC3EcwQFIKvhz+BC6Y
 EAfO1POXKdy4OM86IlaVc8XqK5DR4nXKY2Po7uckheuEZIbXLo+9RjjbklYQulWJRyHN
 XabkRnR/fTUN9IUcUPwUtJbjcokN1K9gHDEGRVR0m6XQcwqy05AS134mh2X/S0jW5Oj+
 qylw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3lyfcoHmJMHCHFwWgtoDKnrMdppfa3VuB0e/RfB/mfUgfnVfAcSsuCjuRGFbsn9gnmJ/g7yeYr4Ro@nongnu.org
X-Gm-Message-State: AOJu0YxTq0NKvs63W8uNGexR4WdzNXVUU+AANfSQuJ2ZgB8eA/PguWh3
 bf5JO2YGVZGgqs/0sfORKm4cOscdu5va4bQFBQX4mh1T4eDDazHDMokQJjk60Vs=
X-Gm-Gg: ASbGncvKc5QDFziiz/LHaXWXB5R8MEb3P39V4bdAh87L0skbcTpjZPOLJkQEY9TZ6yu
 Lr5cRv2OCoFWKFmIw06+G85WW/AJzXX7xix6R3va7cOsNTgxGCTgdr7qZ1GL6a7W0ch03neqtVB
 Ys11gbBwjtUCVZeZ6G1zx6JDTxTUsEqkqggdEpreSZTmp26DSZK2xjrMW1nYV8XB2+U3Kk75x2t
 m3ECMH0tQyoKhBbcljPxn+rD0F1UbCoBYbI7rFdwB33W+BiLe+VCLy8cYSdDXaWz7nZMw==
X-Google-Smtp-Source: AGHT+IHt0tOv1uphrrBuGZC6gtLcBmYqHs9ZnOkYCkn32jGuwusEKSmkG36GffHjfT31O1pOQcsPKg==
X-Received: by 2002:a17:90b:6cb:b0:2ee:ee77:2263 with SMTP id
 98e67ed59e1d1-2f2e91a4d0fmr395590a91.7.1734467627962; 
 Tue, 17 Dec 2024 12:33:47 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2a1ebba0dsm7019289a91.29.2024.12.17.12.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:33:47 -0800 (PST)
Message-ID: <1e285624-f6e8-4871-adc5-7489af29eb2a@linaro.org>
Date: Tue, 17 Dec 2024 12:33:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/46] tcg/optimize: Return true from fold_qemu_st,
 fold_tcg_st
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-29-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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
> Stores have no output operands, and so need no further work.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 6f41ef5adb..ee00620ce0 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2125,7 +2125,7 @@ static bool fold_qemu_st(OptContext *ctx, TCGOp *op)
>   {
>       /* Opcodes that touch guest memory stop the mb optimization.  */
>       ctx->prev_mb = NULL;
> -    return false;
> +    return true;
>   }
>   
>   static bool fold_remainder(OptContext *ctx, TCGOp *op)
> @@ -2694,7 +2694,7 @@ static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
>   
>       if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
>           remove_mem_copy_all(ctx);
> -        return false;
> +        return true;
>       }
>   
>       switch (op->opc) {
> @@ -2718,7 +2718,7 @@ static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
>           g_assert_not_reached();
>       }
>       remove_mem_copy_in(ctx, ofs, ofs + lm1);
> -    return false;
> +    return true;
>   }
>   
>   static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
> @@ -2728,8 +2728,7 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
>       TCGType type;
>   
>       if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
> -        fold_tcg_st(ctx, op);
> -        return false;
> +        return fold_tcg_st(ctx, op);
>       }
>   
>       src = arg_temp(op->args[0]);
> @@ -2751,7 +2750,7 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
>       last = ofs + tcg_type_size(type) - 1;
>       remove_mem_copy_in(ctx, ofs, last);
>       record_mem_copy(ctx, type, src, ofs, last);
> -    return false;
> +    return true;
>   }
>   
>   static bool fold_xor(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


