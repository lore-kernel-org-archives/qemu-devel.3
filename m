Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7426E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeCQ-0007fW-Jv; Tue, 17 Dec 2024 15:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeCO-0007e5-Lz
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:29:44 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeCL-00021i-AA
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:29:43 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-728e78c4d7bso72588b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467380; x=1735072180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ExHBUH8c3Q1ahKfNnBx3QcBl7GW9SBJZRv88vt8CjHY=;
 b=IGhHsQkM5gSr+dsknmsEMwIFM8yPLbpaHvCnNDneMxW+FYl3yWkW6Jc1LDLuk2Y2kr
 BEu0FFpqbbTuc2WD65f+eS+WSrZvoQdBe1ciMAr45k0RE7gw7ZFl7Lid0P7AN9DBbqm2
 zdkvovtZDR9kHWhMjnUtXdq4wbgQv46alR+C3d+M7xVYNJvmXtGmlyfQmoeQDgr7nzSL
 FdhMTWIOiHcFNlarE1/+B7UqGicmERJPrgzXD+g3Kr9THWWbm2t2/JTxBikRdUe+tiB8
 o8REX5F/P80dTclWcoprjrDeXPCpDHvmcjW8ZaTFQQkwOVOXzZhr90HtE5xxdscuqgDY
 iqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467380; x=1735072180;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ExHBUH8c3Q1ahKfNnBx3QcBl7GW9SBJZRv88vt8CjHY=;
 b=DfvBXv58UncUBhmRimRt8uRZCSmoU8Qutp6dmML3RsKZbgXQwN0VQLZagybESPcp/h
 WX1GHF2Wwog5+LN4QrRi/Jl1pfMbrO7B1c1zcp9MaeuxejyLqmYA7aEW9UgzzZAjuCRm
 FR6n4puXzjgX/YCssP3f+CSzMh633WqmYp2B0ggkMN325ppjcimIvyUXGLFdH7FYohJP
 5blx4cqrc4SKUpX2zxyqEImlFtDLlX1FxytHQJ3HPEoz9fxA84o1SEjDpSskh+IahQg/
 HRn+n2YCcc9zuN7D375NjPU1grANhZxPng75RhMKfgn1TwEpJIKRSvNS/7uF/G7WGd+j
 HPUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMxgW2ilRGHFp6EI7B3NlhDBvxDTFLbkvRh3yRev8O9Exfq8GhpRIWTZe9QmTBFcrhyioJybqhvhVj@nongnu.org
X-Gm-Message-State: AOJu0YxksE7X/5DHofpRSWvtT4FwO3yFjO+38msJl1+dkWnIZburbjv7
 kepq+VHxJYwGmYKU9wDaVcBb1/WmW2Ok74hrk+cBNIdS2iA48KGov9X2Dr3dayE=
X-Gm-Gg: ASbGncvhus9Qdp2AvBdwqiBRKu3cUZVaqTbJy8BOtFNor/RLMPUjt9XqRdcogM/Ri2c
 UFMro7zsLfxRFWmjA6BSrifS76eIXWJx/JvnPm/ZWl/2UtmMihmvvH1JJEthnRDClCkQdr/z9Cs
 GeQHjMMY6aUSwfnWAKGwYlOGLI866bSqP6wUPgxcFbV32yThbsA7SV3xc4GTgX8RNpoI3fydBp6
 jvurh9xdmeGmHLptpzvCtezXaDt+dEs2iR+g+8lB6lfDrXNg13DInSLaKN9DyAOBeQUeA==
X-Google-Smtp-Source: AGHT+IFS4ZmuzUmWijad2bPVoWb5v+1LpoVKPU5Ioj8e+HPDXv7DgW7wobj6DZdGd4ESrrroQbzA/w==
X-Received: by 2002:aa7:88c2:0:b0:728:f21b:ce4c with SMTP id
 d2e1a72fcca58-72a8f86ee62mr249095b3a.5.1734467379862; 
 Tue, 17 Dec 2024 12:29:39 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918af0f01sm7118707b3a.87.2024.12.17.12.29.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:29:39 -0800 (PST)
Message-ID: <715b1a90-956f-4634-8b5b-729bd0d8b481@linaro.org>
Date: Tue, 17 Dec 2024 12:29:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/46] tcg/optimize: Use fold_masks_zs in fold_nor
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-24-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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
> index cc3dc91d3f..aa5242a380 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2039,14 +2039,16 @@ static bool fold_neg(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_nor(OptContext *ctx, TCGOp *op)
>   {
> +    uint64_t s_mask;
> +
>       if (fold_const2_commutative(ctx, op) ||
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
>   
>   static bool fold_not(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


