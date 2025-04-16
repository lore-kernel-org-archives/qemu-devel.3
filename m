Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3E0C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 07:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4wqP-00043M-DW; Wed, 16 Apr 2025 03:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4wqN-00042i-6p
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 03:05:59 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4wqL-0007rT-4Q
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 03:05:58 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso61730145e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 00:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744787155; x=1745391955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YIx/tzhNr8Jvc4YO4daHolVTKAjvMLQTjpQ39O7mwZ0=;
 b=XbQ2e1rLzq3EU3bh6pqtky4u/tvgsi7HCjzRONmTwUKrfk2BY8zyCRwYkZOwurD/d2
 7176lkBDyP4f7ZpGnaigswyTXy4zclDramkefcwpe3FBFhaciRBnr7tm+n1GsA7hZPqG
 Aowpev6t6vNvw3qhwRSs9wtpx2caFOMfUr0uBbDLgY38wbDwfclmnJcr4N2TBKpy0Gig
 ntWca7hPOEuxl6YSLfmeK3JcDdgVYLhNN2Zs1026vCm7mt416tBdI19sMDhK9gQBSlLO
 8+79hv0pfWvfK8wfaFspI1s7WQomk/eppo9qgBuZPu3J8nQNwczgUzitjNvHW5EuA53H
 UonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744787155; x=1745391955;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YIx/tzhNr8Jvc4YO4daHolVTKAjvMLQTjpQ39O7mwZ0=;
 b=S7J1vKss6YFzlOZE6EInMTJChDLo4Df8qIc/YMKQXRKHawWvkzpNn6Td4TBZEpMnaq
 Q7SitlmzZfLsbhVudXbzPXYBYBnftHxVrXz3Vb0FcZqT2piAaFNNrwIqgwdk1HAlOrtV
 UTQhisNkN1rDCW8RxiFmBK9C0sS9Q5VTYOVGraki1QC9kRvFypB+SkY4w1gNVAYsHDxv
 rGK/dOL6L6uK6HZ3LwMidXMUNWUf8hqEpSTjcY2LvF+uOvX8W/UzsTJdwPpmLxX2BMZN
 NeAlCM2yCF//NKTOX1oKPURDHX8gp1UIwe7MDvNa6Wp/zFOoCticUE7GBaTKORltzA/V
 RSLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4fPRkLdlSvacMDRvXdRe2Ueu8jKA7rUVJEceLFvpSaFV3PSuuY2o/L1ZkNi50mD7eEqcA3vt1B+lL@nongnu.org
X-Gm-Message-State: AOJu0Yx8CErNhmt2RytFqzYe7DyGejrZYh59IBfIYLKiTitJBo19y/9L
 AzlabcWCKgBSBBzatL8MaHSNbd+pQIIvfzVfhh+DUpwBE1dTVVGAOpvh9owtQWE=
X-Gm-Gg: ASbGncuIK8cskt4EprIQOKU5ijXY2+eYqqIPU/IAugsRbScLbl5lfSezi1Yir4FmG2V
 QcACVGa+k0PywaVqk23ewbJBujsBJZ0uY2npabCEodlHlSXJQi9podK3sCEcmtPRNOcwC3bTTMz
 FtAE6gZvu796d9dsMHsCcvecnoYhHzq/09c8iCN4hf5Epj+wDE0+nBADvCUeRyPJT/lpr2GnAlm
 +N2giifylLwOEGM04WaKB8CCkZL4XcxtAOU2T5cPSRj5ZCHM/A4OJ/sLhH2XoCeSv1wUCxv9SLh
 SaMnJV4OH6YtBgAEi47nmnFfliOrdGGZMZtOzJPnGYFoKkBlmj7QBSFoM67lB4JkDHrsCgiEd9n
 2O21RSpAQWEk=
X-Google-Smtp-Source: AGHT+IFipyU0KfT7IKaCtAb8OZw7POQGbqpNxakowsqg9Um7ugEjgajp4CA1+M7In4mmzGDFM4a4cw==
X-Received: by 2002:a05:600c:b98:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-4405d5fcc9emr4950755e9.6.1744787154834; 
 Wed, 16 Apr 2025 00:05:54 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4d352esm12025585e9.16.2025.04.16.00.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 00:05:54 -0700 (PDT)
Message-ID: <78701758-6eee-41e5-9fbf-c123651f44b8@linaro.org>
Date: Wed, 16 Apr 2025 09:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 157/163] tcg: Merge INDEX_op_st*_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-158-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-158-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 15/4/25 21:25, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    | 15 ++++----------
>   tcg/optimize.c           | 28 +++++++------------------
>   tcg/tcg-op.c             | 14 ++++++-------
>   tcg/tcg.c                | 45 +++++++++++++---------------------------
>   tcg/tci.c                | 36 +++++++++-----------------------
>   tcg/tci/tcg-target.c.inc | 20 +++++++-----------
>   6 files changed, 50 insertions(+), 108 deletions(-)


> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 1da23755e3..cbc519624a 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -30,14 +30,6 @@


> @@ -2926,19 +2918,16 @@ static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
>       }
>   
>       switch (op->opc) {
> -    CASE_OP_32_64(st8):
> +    case INDEX_op_st8:
>           lm1 = 0;
>           break;
> -    CASE_OP_32_64(st16):
> +    case INDEX_op_st16:
>           lm1 = 1;
>           break;
> -    case INDEX_op_st32_i64:
> -    case INDEX_op_st_i32:
> +    case INDEX_op_st32:
>           lm1 = 3;
>           break;
> -    case INDEX_op_st_i64:
> -        lm1 = 7;
> -        break;
> +    case INDEX_op_st:
>       case INDEX_op_st_vec:
>           lm1 = tcg_type_size(ctx->type) - 1;
>           break;

Unrelated nitpicking comment while looking at what lm1 is,
I'd find clearer for tcg_type_size() to return an unsigned
type, and lm1 be a uintptr_t one. Matter of taste I suppose.

Regardless,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


