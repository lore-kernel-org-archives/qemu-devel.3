Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D5CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeDm-00012Y-S2; Tue, 17 Dec 2024 15:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeDk-0000zr-HB
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:31:08 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeDj-0002LY-4i
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:31:08 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2166f1e589cso59960305ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467466; x=1735072266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NGlnFgRsV4bC+E3+Iu8G2yUE8E+ZcW94EDBcXDk/mig=;
 b=yfhqQvkFZYhfl6EDRo3tzv4M2UZzyXV6Tv3EEjU8psR0nTbSME8vT2vYmL4LJYhF1s
 2huy+G76FD8RHPoIcJCKk38dL7g4BssyeJtdalq0UWsCcTFseQGcK27UhIGhm5B6B4pb
 fqu9GfgwmaOQP9wdsvYorz6ehYTpIgM6vxBmGnctgI2yzFWaqBF2AMhzZn8Ljk9WoZCM
 T4cdtWo6CBrTPWOAARgaCOubJmoCq5s05VsPeo1Eag1OwpKryXWKOpAwmCyFnANqWM8y
 d5haeN79AdcjgPqJrqVM8KgG9dUP122Dbj/L9u4zJhvzkeQRsTW22mX4gZvkvFC9cvy9
 7gTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467466; x=1735072266;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NGlnFgRsV4bC+E3+Iu8G2yUE8E+ZcW94EDBcXDk/mig=;
 b=Vg1TbO3rkeBovg9sEL0nnuaZJTnIwOHf6M3QPQd5r+ztf5+aBSbOm8WPnWellrfIZY
 oB57bRM5BHTWQxtgyxNuFUuNJbkEzxEqjFTZtlWeLrsJdXuUKlMfz9v8Ep4R0R/DU4Pb
 raq1aHgISh3haEF9xS5HdazCDbEramGLNNH9T0G8672S2iBkozH331cwd6ON5eQCCMai
 kSRsE82g0qzIMbvx8dOQgCTGLM82h6UL/in2YW6nijMndgX1EXthDUBkVwSU+YxlNcr3
 MdPDmdq6MZdWjqA6fcUaW4MYFll3nwIL5UBzEX7DG9XiO/th6DciAGjuJZuPThXCnT3U
 jUcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2yptJW8BtT9HMkoFkGJZe5ZuPqPkYAUFzZ4j4qLW8YF8arpWlwabQGnfV24gl/2Sa/m+NnC/f2g+c@nongnu.org
X-Gm-Message-State: AOJu0YwNemN2pHH2yXwJHNG8aBqbz2nkrXAgu7NxFgdtUbQXyEPLhwdu
 OXSGRCb8scUfRVuXdnhJUhOfwLquLZiBr8+yxsL9AcD4W7Lhti4p/2TMC50PgRk=
X-Gm-Gg: ASbGncsGQaMS6Lv24o3XzLobqEFs9EL1vTwr2SMG6GbuOZNlIswwOHowkHX6ADVDoBE
 xzUZ2lWCXf7fBc0uNF4VrqIzybdzfoaHw5oQCFlKFFVEfgwNCKKDbe6PG9bo+8jlRB70j07+V/D
 b00GgCp8zNyN+g00fX/H45h7QEM4IxLkj0U8Ew3C3+L0OL+0b8KcZzpbWpG++y3S7E2dZdH4Dsl
 XZaZ24Grr/9/k3caAhN9TVufUc/fEIJ1S/cpK2wgOlcSN5u4Za0VLY/GsV+LQVs7FNsdw==
X-Google-Smtp-Source: AGHT+IHGBak8P+uBAiX4YreGXNFri9Q4nD/iPZPPe1GCqXE11zGIWA2M6vKEuBN7qSwvki3ScLWrhg==
X-Received: by 2002:a17:903:1ca:b0:215:7719:24f6 with SMTP id
 d9443c01a7336-218d7215c35mr2453115ad.23.1734467465757; 
 Tue, 17 Dec 2024 12:31:05 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e64289sm63650385ad.234.2024.12.17.12.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:31:05 -0800 (PST)
Message-ID: <35034863-04d4-49ae-a40b-5df33abc928f@linaro.org>
Date: Tue, 17 Dec 2024 12:31:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/46] tcg/optimize: Use fold_masks_zs in fold_orc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-27-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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
> index 3d852b44e4..76ad02d73b 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2078,6 +2078,8 @@ static bool fold_or(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_orc(OptContext *ctx, TCGOp *op)
>   {
> +    uint64_t s_mask;
> +
>       if (fold_const2(ctx, op) ||
>           fold_xx_to_i(ctx, op, -1) ||
>           fold_xi_to_x(ctx, op, -1) ||
> @@ -2085,9 +2087,9 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
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
>   
>   static bool fold_qemu_ld(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


