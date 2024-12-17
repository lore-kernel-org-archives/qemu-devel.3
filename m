Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DF5E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNdnd-0000QE-IY; Tue, 17 Dec 2024 15:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdnT-0000PV-KO
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:04:01 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdnQ-0005g8-Oo
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:03:59 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-725d9f57d90so4273011b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734465835; x=1735070635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KwQDgS5jFu950QzDTC3CrBVjwoffyOxtBa/VlJVg2aw=;
 b=AYzwxOHfSCjzWr+LG4Zqt9R5CIVMQnmqicOyvTYioEYDIVSzUJRLjP7E+pzCDihF0H
 i0eDJa74sn5WwLSbt4eMZJ4BEqKbZeqf1SU9lZ75vV745OPmUzqfaI6rHbCiYp9LgXvI
 uM9rhOkpPXokMxSNdPjgRjL6GtAPrPDsuj3iW50i3IvD2ilJFwbe8OazMpBcE8ls15x2
 o1v++q97UUy956U2sjniug3XzLK44d0oavC1hA2jm2Pz7KDNJvtH5g8+qnMLpWxKjEL8
 yy7KMxWIv6FokywGEJftfGQj4ypxSqtw5t/vXJI5GHcH1isOnOPifWt9QvBRpxbvVHQH
 8iNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734465835; x=1735070635;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KwQDgS5jFu950QzDTC3CrBVjwoffyOxtBa/VlJVg2aw=;
 b=rhfeImjyJ4Id9YxHBAZdK+hiEYVtKkMYKKgKLqDVUX6jMRiCqgxzS9cfzfNOyBwojQ
 0PYrhrDincmvqczRZpHw32/wmqSERpBU4V0Z7KGpRUwoLPzGxlg14fXoOVXeiTQhcjUK
 63llUIISPNOKgBdeOVbbnhxdkjLSyGtzjjshVfm0yVb7u7zlHCremgW24F/uoBKdEWkE
 Q4n5/J1E1h9uxRDeFFwj1aYfaEtE38Kjpu6CQoA4LXH5SgykJsWYRot/WG79eb5IHpQU
 guosOqeOyjLn2eWBptWhUNxP7LJC4QUVDqRMaK+WUJ/cCUXgTkAnretydUOFsw7IPcFQ
 ICKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNW5VxOBFqN6pwjiblbxs5mub4z8yr5D5rWHwxBiyT0ojwUsD1gi89y1B1QgwbdCxi+mnNXr7KtlCr@nongnu.org
X-Gm-Message-State: AOJu0YwUZQkfrmj4ZIpeJGWx/7mcWvYGGDuK3VckUX+HhbthRJ341z0z
 MxPKQM4r7RrMMe8wH0ymnKkalyLFQa3ry+Yr5k14rURBm73YVyUZ0Su8VcKdDc/Cmctgph7egIz
 xn8ltaQ==
X-Gm-Gg: ASbGncvthhGRu9OACfVb6vWXdCa/mJceZT/ZuU7SXED6hQ+6r4KDWXsK81OFpj27WjL
 XTyBsyP64w0VX/l3Ww3/+J8S/8bHySjYoa1EkcCJMEt0fb0Qns69y93jxNeX+iUxrEboME38h9T
 k8ziX0CsTf6isO/qGI20bNk8vRbbrOYWdVDG+mBvhUUm11tEF3WZWZlEcQnm61RRtYOOZxInTgo
 o0hV6ICfUSUaxmDuz/SKEeZvIKAGcAR2A4R2bJ5oWpNRMYfvZmsRJHibU6hd4JVQYDqUA==
X-Google-Smtp-Source: AGHT+IGrgbH/PYALjFkF+7wWz8EzEaMTHK3I3auX51v02uVdwij8Q8maNAODDyLPGw8wl++799dhnw==
X-Received: by 2002:a05:6a20:734b:b0:1e0:c89c:1e04 with SMTP id
 adf61e73a8af0-1e5b49bc067mr446296637.43.1734465835100; 
 Tue, 17 Dec 2024 12:03:55 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ad56acsm7341782b3a.61.2024.12.17.12.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:03:54 -0800 (PST)
Message-ID: <f64769f6-ce7e-4502-9ce9-19bb57306752@linaro.org>
Date: Tue, 17 Dec 2024 12:03:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/46] tcg/optimize: Add fold_masks_zsa, fold_masks_zs,
 fold_masks_z
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-4-richard.henderson@linaro.org>
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
> Add additional routines to pass masks directly, rather than
> storing them into OptContext.  To be used in upcoming patches.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 1a9e3258e3..6644d24da6 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1045,11 +1045,9 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
>       return fold_const2(ctx, op);
>   }
>   
> -static bool fold_masks(OptContext *ctx, TCGOp *op)
> +static bool fold_masks_zsa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
> +                           uint64_t s_mask, uint64_t a_mask)
>   {
> -    uint64_t a_mask = ctx->a_mask;
> -    uint64_t z_mask = ctx->z_mask;
> -    uint64_t s_mask = ctx->s_mask;
>       const TCGOpDef *def = &tcg_op_defs[op->opc];
>       TCGTemp *ts;
>   
> @@ -1083,6 +1081,24 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
>       return true;
>   }
>   
> +__attribute__((unused))
> +static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
> +                          uint64_t z_mask, uint64_t s_mask)
> +{
> +    return fold_masks_zsa(ctx, op, z_mask, s_mask, -1);
> +}
> +
> +__attribute__((unused))
> +static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
> +{
> +    return fold_masks_zsa(ctx, op, z_mask, smask_from_zmask(z_mask), -1);
> +}
> +
> +static bool fold_masks(OptContext *ctx, TCGOp *op)
> +{
> +    return fold_masks_zsa(ctx, op, ctx->z_mask, ctx->s_mask, ctx->a_mask);
> +}
> +
>   /*
>    * Convert @op to NOT, if NOT is supported by the host.
>    * Return true f the conversion is successful, which will still

I see the direction, but why not simply use a structure for this?

If I understand correctly, we'll only pass the masks to callees, so it's 
easy to pass the pointer down (without any heap allocation needed), and 
we can have associated builder functions to create the struct only with 
a limited set of masks, or directly from an existing "ctx".

