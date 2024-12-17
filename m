Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B77E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeBH-0006Au-Nx; Tue, 17 Dec 2024 15:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeBG-0006AB-3S
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:28:34 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeBE-0001pT-G5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:28:33 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21644aca3a0so68369825ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467311; x=1735072111; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HCga/STO+9ee5TFp2AhUGxquIvBMfkH6EWuytQUOcvQ=;
 b=UKLhHrL2tHV90BCYHByYkDGdFfCLvCdqaHegG+IC5qiGR+kK1FJ/y8nmc4DODGam6J
 zkAjiGexpb9DiESu/CZNDgMqqXR8ZFGg8tm3C1D/Gj+M0XTHxsXu9WyOaBWNW9Ku7Mug
 ffZ8OZzX/9LF6rBGjY/zVyaDcVBu1313SVqWab3A747HE0yGHB5K+JkzMWL1a1KAW4W1
 iVkKJwxB6IPUAfRLJaFbo7H6xSg098Q1y43FbCKzlV4U79sNo61QZ/pOI5o4oCCk8etJ
 5HAJwNa8PE/M7VUpfmFtA/1erYlYLZ4nfb3YRub1JD5XInxt6ILVB6vVSvSfl/1oTdod
 PMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467311; x=1735072111;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HCga/STO+9ee5TFp2AhUGxquIvBMfkH6EWuytQUOcvQ=;
 b=pPGHLBP5Lv4pMDFe9mAoNzEv10JHwdTnWrwVeiFb0oAJ+NLAiaQivtHfvN3/fGgiAu
 mmmUvVdYVqdaubh+EASl+5JL30LeG+SazypM356G/3xth9UEvtqx+mKU4u8BtGNwNq0a
 CBP03JXSH0r6cmPx3XP0FsK2FNOA9d8i83m5CTZocKkKkngkEKdnlEfSB8LQn+eRJ18o
 /q58GxgeHoAR2bFYQ/oXsldJC+GHBXTsN/FUlbwHJhycc3RcovT8LxjvNoNlGAj/PltJ
 HhLP6SjdAKZQ3b2CvjbQBELpI7aWVcamjuZvKNlMj0YlErNRZPmKpT3+A9AqDApr4Ep1
 zxWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/sBEH/6Cj5PgG2YYdZBKSX/CSnQtovGepmFEtTz758DGpsRq63N2OOCNV5tLPxHd1hdajQk1cW8gw@nongnu.org
X-Gm-Message-State: AOJu0Yw2tKHMIrMNp79jnGDV008V2qOstOz2CphDGv6tllm/KNtnKRWV
 jYmGnfnsxG4hHGwiQoqqCWbuvtxU65ns5L5Ky6Pkhf8AwZiHTaAOlpWvLpe9VRE=
X-Gm-Gg: ASbGncu+xExlmPIYOhDQEwvSTswg4xMRxxR39Wn+GX+1HgjEa6YCOKqnyYlnzJnFVNX
 1f2Mj8GSluiLUIQeZXw6Yh1Oh9D0LIGSqq/AGuspk956dZsRcCu511CZ1/fCY7IU0ZSbyIaBl8i
 b0QumY0xbIvdoI7uETBX0x82HSgMKHoYLyB/hP9WKpS+/0aPM4GnP35yoDAHE/nnihVs/NA3Lcu
 KE0s05jgYVJGvPgicS0rEIvYMEYrokHWaafmfYA2OZanRudGIIrB2l51ajCYsVjNPOKdw==
X-Google-Smtp-Source: AGHT+IEAAQoxxDhlPd3iFNPEuh2HwNFJ2NNPY0SdTRc3Ivk/DLYLZVRPGUVtX5G71+YxC47LKtBjUQ==
X-Received: by 2002:a17:902:e741:b0:212:615f:c1 with SMTP id
 d9443c01a7336-218d6fdd64amr2615135ad.14.1734467311062; 
 Tue, 17 Dec 2024 12:28:31 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e652bfsm63147485ad.243.2024.12.17.12.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:28:30 -0800 (PST)
Message-ID: <dbe22398-09e6-4b8f-8518-d9c13703c9f5@linaro.org>
Date: Tue, 17 Dec 2024 12:28:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/46] tcg/optimize: Use fold_masks_zs in fold_nand
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-22-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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
> index 111969c2e3..924ee165ba 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2011,14 +2011,16 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_nand(OptContext *ctx, TCGOp *op)
>   {
> +    uint64_t s_mask;
> +
>       if (fold_const2_commutative(ctx, op) ||
>           fold_xi_to_not(ctx, op, -1)) {
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
>   static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


