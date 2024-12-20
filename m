Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA049E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 20:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOjP2-0006kp-W3; Fri, 20 Dec 2024 15:15:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjP1-0006kZ-Mp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:15:15 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjOw-0002sr-Rh
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:15:15 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-216401de828so21761335ad.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 12:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734725708; x=1735330508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iqqK0zIY27eMP+z+r8D+uFKIHsMZVxoVed6uXdmN3rc=;
 b=s0+dLp4L876DFdwW24eIcU4ToSU9ykSqpxJC3E7VUcYj3SAa9i9jx65Q/UcLiJMQ2r
 4/UgPk/99bZtCtOB2bXgnNmCnDANKR2vKDk1X9nnLlyxigG025TGjcA1G9jIE9WBRciQ
 Qmx5wcOmZSgfKBoSz9O7AnEWrxX4fP8CCYH3o/ve0/3KB9MLdJcdPuTI32KozT48JvXt
 FdUI3lxG8HbH2duKPvVnA0NBKM4uk5AqYzVbGJutz4TNasc6Ux1m83L6IAwttVtXK0/+
 AOe6fMPHuy1T2AN8+fsWFTTUqVpQ/sFdyqkarzon4LQbpLc4HHUm1i1FW4FHwXH3Omfu
 b/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734725708; x=1735330508;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iqqK0zIY27eMP+z+r8D+uFKIHsMZVxoVed6uXdmN3rc=;
 b=a6KnMaZVstgcXUyuPKVurTofB54elX3rpL34C3aG69OaZ8miXD49NqrYr/OR4s321X
 p8ONLCO1Ffrbu7/UnW6kNErHfrGAJHaW4C1LwL0QHFJ9YGJ24qjqVqhDxFt0b4yiPx05
 385cpLC3YfW2SljLNvO4kTLpLTsGD7kNAjkGfy0jihsl91jJkNDTMKSWsf3PTGC/395/
 m5yeImcPp5C5mIDiZdbVo9qrEpxBvtgnyfnyFXq9lyKepKNRmGCGUqBKvXpBJXX87s5q
 Cd8kyLxhsxN0buPeD88VBOhmVzOcyOsmqK6Ledi1ssuNLbxs7M89rbjmHvGL4DHAUWih
 oXYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiey2bjTxaCXF1p03Edh1rt7HJNg9qZgW6TbGGJqtsgtITTUc5LSRrsDgzMjziELZikUAiVHRtS72c@nongnu.org
X-Gm-Message-State: AOJu0YwXE4YSH8gbNE+k2cf9PDFPGx/RfNvQXON9jlb88DXc/VAr2rS4
 Gb7+8yev+d64YytOKmprvmNRE5MZiPcvqv3+FsyBMKMjORjk1Kyi+amSdsSXPQY=
X-Gm-Gg: ASbGnctt6Qsjwa1V2EMlAq5NNdakbbDhYEtS3zbBg26AATLYfh6vBzGe6HwodpYYT8e
 JWJNPItrLRiUEdHmPQ113PNlbugTMPASa7hVuMCyY28djjFzZdc0cIefZOjc5mjBnZ1jkurvALs
 UVy8xHJalzdXrBA+gvpFneVfoEDJh5EjZOGd8iww7iafmvIZKkaCZVK3OtmYZQgdJgvuhoqvgRs
 vQSUgI1GcS1MGsUP5f9/4FGb1jcW2NqjctqR6Nk2+WCjHNEsgNxpLgVcYjss5rJSpjmsg==
X-Google-Smtp-Source: AGHT+IGd+8Xk4N+wPXyMyqlqHgHDK+jPZGIRkjqCjM8/hAoncQceD+eRviykdwVGCx17Xuus0mNGGg==
X-Received: by 2002:a17:903:22c5:b0:215:7faa:ece2 with SMTP id
 d9443c01a7336-219e6f145a8mr55783445ad.35.1734725708475; 
 Fri, 20 Dec 2024 12:15:08 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f6285sm32902795ad.215.2024.12.20.12.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 12:15:08 -0800 (PST)
Message-ID: <5a1a3cc6-68ed-4198-ac7b-a9c88ecd8fe6@linaro.org>
Date: Fri, 20 Dec 2024 12:15:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/51] tcg/optimize: Split out fold_masks_zs
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241220041104.53105-1-richard.henderson@linaro.org>
 <20241220041104.53105-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241220041104.53105-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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
> Add a routine to which masks can be passed directly, rather than
> storing them into OptContext.  To be used in upcoming patches.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 2aa57afd64..d70127b88d 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1044,10 +1044,14 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
>       return fold_const2(ctx, op);
>   }
>   
> -static bool fold_masks(OptContext *ctx, TCGOp *op)
> +/*
> + * Record "zero" and "sign" masks for the single output of @op.
> + * See TempOptInfo definition of z_mask and s_mask.
> + * If z_mask allows, fold the output to constant zero.
> + */
> +static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
> +                          uint64_t z_mask, uint64_t s_mask)
>   {
> -    uint64_t z_mask = ctx->z_mask;
> -    uint64_t s_mask = ctx->s_mask;
>       const TCGOpDef *def = &tcg_op_defs[op->opc];
>       TCGTemp *ts;
>       TempOptInfo *ti;
> @@ -1080,6 +1084,11 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
>       return true;
>   }
>   
> +static bool fold_masks(OptContext *ctx, TCGOp *op)
> +{
> +    return fold_masks_zs(ctx, op, ctx->z_mask, ctx->s_mask);
> +}
> +
>   /*
>    * An "affected" mask bit is 0 if and only if the result is identical
>    * to the first input.  Thus if the entire mask is 0, the operation

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


