Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D9FE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeAU-0004Nn-7g; Tue, 17 Dec 2024 15:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeAJ-0004Iv-Lh
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:27:40 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeAH-0001b5-AS
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:27:34 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7265c18d79bso6122412b3a.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467252; x=1735072052; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eGnqYzd3CDUxV6dARu/ZUyZomitMoQyZQbVr+hQgIck=;
 b=VYfTtIGc01/6xA5RKnUMvOp5VhYGUpoDgg8scV11lrPr4bbanJW4SpyHPenC1W1LlR
 lD3fkri4T+FvN6xs/2abyLgqtw748AufcuPneYl/01LxS2wHQbiF7Pd3WnKdzRR7vX3/
 l/bG6MV5vzOFHaylISdtDH1s1yg52BcIQCXTT9qSMry3ZTnScaI/KsgTotsKXxUvpZvg
 QEqUoAbX4jUnIjeCBANFPPB6yl1sPxS6uBgJV+8vdN3rajIEHM5f+m+EfqH9j8snSViV
 DNhCEnaISAT9tmVTpLpgIuWErzMLX0RpiRIJWIqnY36DaqHAKqagEJhmLzrGfqOS+xJ4
 +Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467252; x=1735072052;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eGnqYzd3CDUxV6dARu/ZUyZomitMoQyZQbVr+hQgIck=;
 b=Nb3F4wI+DQrhAzULRkUj5A3FFUAKDyCPjXNoHeeQWu1zS+/89j/GGTBBZVnshOvYw5
 P6CfOg8eMucF/f5uRjxz75k1UF2WQJcZ0cP5Gdt3KzZnhnu9qLrjhJDTIke9DqVKQH1T
 3UjftIDFRoH/dF/m6yJTLhXiIddriA3ymCQqnIr+N4Wi7YuOJmemndjwzMc4GatGVg96
 dpO0KGRYi2/2y3tXlCxt5HmBfFGrx2Z/gjNrPtCc80aGuT9OuQnUxXuMKkDnt1Csz8G8
 POnCx/PTX7GuuKpU9+yiZvGr/MQXGH5ekeZjOMcorv2oiy6WuMy+oDWUStaCaZCd4bfl
 +8Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA6bP5Ner0F04S3Xpr7YPz3gBpR+awtNohvS4nTKMchO9XWu5OLTS3oF39nC/2IsPrBa6dihK773v5@nongnu.org
X-Gm-Message-State: AOJu0Yxn72INkdQVxQLCewJCiygIKXnOCKPjZENHpe4GYSophLluVdQ3
 JmLy0g9epxO7O2sAQzvpFXwIA0vyMXkoXl+7ow1QwPqF5EjtL5tvQcW5KyKC0aA=
X-Gm-Gg: ASbGncvyQj0xLkeJixzmHQIvgXT5/T88mpfIDWtOkpkAmUPsgqHEW4/v//dn+E43Y1C
 VRzwWIf9seED/wH/0tnQzW3uNJQ/4ungdYlRswgsU6bn6nr+6ZnqUFJsyai5ZgvfUh2OYvpSzor
 TnoDx3GmXCnT0TbLkR7nOUFLrISbu6RahhvMMcK3jYVQoct1DG/Rg/j4PQlNabKL6uZ7GShnPEh
 dDBf2NbBu0ymMUhcBYB/NjiO0VFouJrVEsrUc6MNnuAX/B6lvbtcWsG/Z4nY+MpocCE8A==
X-Google-Smtp-Source: AGHT+IHAAyr23n+OYsQ1zn8LO253TPHM5PUoA1p1IVLBboOBEDMTSmi27qEuaxqFpHG1uH1MpFFcmw==
X-Received: by 2002:a05:6a00:2c87:b0:729:597:4fb2 with SMTP id
 d2e1a72fcca58-72a8cd37353mr661319b3a.0.1734467251926; 
 Tue, 17 Dec 2024 12:27:31 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918b78f72sm7049611b3a.116.2024.12.17.12.27.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:27:31 -0800 (PST)
Message-ID: <03aadb2a-dc2c-48c0-a64f-2b5f54bc6a35@linaro.org>
Date: Tue, 17 Dec 2024 12:27:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/46] tcg/optimize: Use fold_masks_zs in fold_movcond
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-20-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-20-richard.henderson@linaro.org>
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
>   tcg/optimize.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 260e3ea072..6d2d55f053 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1874,6 +1874,7 @@ static bool fold_mov(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_movcond(OptContext *ctx, TCGOp *op)
>   {
> +    uint64_t z_mask, s_mask;
>       int i;
>   
>       /* If true and false values are the same, eliminate the cmp. */
> @@ -1895,10 +1896,10 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
>           return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[4 - i]);
>       }
>   
> -    ctx->z_mask = arg_info(op->args[3])->z_mask
> -                | arg_info(op->args[4])->z_mask;
> -    ctx->s_mask = arg_info(op->args[3])->s_mask
> -                & arg_info(op->args[4])->s_mask;
> +    z_mask = arg_info(op->args[3])->z_mask
> +           | arg_info(op->args[4])->z_mask;
> +    s_mask = arg_info(op->args[3])->s_mask
> +           & arg_info(op->args[4])->s_mask;
>   
>       if (arg_is_const(op->args[3]) && arg_is_const(op->args[4])) {
>           uint64_t tv = arg_info(op->args[3])->val;
> @@ -1941,7 +1942,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
>               }
>           }
>       }
> -    return false;
> +    return fold_masks_zs(ctx, op, z_mask, s_mask);
>   }
>   
>   static bool fold_mul(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


