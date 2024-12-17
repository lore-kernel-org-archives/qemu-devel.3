Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7582EE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeDe-0000rz-J4; Tue, 17 Dec 2024 15:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeDc-0000in-9o
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:31:00 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeDa-0002Kl-Pa
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:31:00 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so3807886a91.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467457; x=1735072257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hgMZcZvLGXGFsL54iLRczsBbBVIsdOxsZ0rX2T0Yr8s=;
 b=l5HVTzDc3vqcRWPnd974Ix7gGWvJtTlt373b6sF0hH4ObjoIC0vb2h5ElnJsVcR4iZ
 55bEWmud5Z59Uwz6d66MADJEObURa3RfqK7v7iC8ojlFHVj6PUQj9wkRixdKA+yn5p/k
 NdaZ8ikbSZ1m0G0D/2MQogwgtfwznB4JG/4KbuoftAGdoWSHUGF7wlchEYPyBPJvlDO6
 h3ortMkAYSH4C73j8ocbhxrXSPiU5uKxXhEbMpFFqBEs14GNB8FAoNlLTP5hYvLDq8+x
 1nK9CxUYaQburP/2i63rkwKASXwAblsm6RkRkhCZ9SyaojApNZGpoVfId4QnNSXV1yDY
 INvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467457; x=1735072257;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hgMZcZvLGXGFsL54iLRczsBbBVIsdOxsZ0rX2T0Yr8s=;
 b=mKZCd3+4qLVIXe6h5dg6d1l7WcIOheYvS7/o1JemDPdwYx6jmhwCcT2AzHLuSNfr80
 iOLVFzkkiWxalhGk6rKkSBCtP+JXhhN6zDXj8L5YosjBK63o41GwALKcfGrptpJl15yd
 wXAkmRpULJC/xSf/7kGe9Jetjt9ye2lfmk1zEszOEOEn5nm76iR85AfQOv6X1TmKNqYP
 9VQzOmb9n5c/N2CRsU7ReQ5R89uQpdRuTRFXy++6dNKLdb93za2vRW6UeFyind32OZBv
 USg2rqtOqwy25KpkyzhpmCiDM2hBl1BHOkzzZiCB23evhmyGopJnsHPNUXyFDl/XFxIc
 5h2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7QpRshid1m1hU1S/lumKpuKECep32WS8YHkIV/DlF16eZYIxu0HXZbP1daa5X0DEQDO5FdYUApAGd@nongnu.org
X-Gm-Message-State: AOJu0YxSwC2hC06chXjSi2eWZNNJAxgcDWDcvBS97XTlQ1X7lJAm02rX
 /tUoPv56PMZLnHd4/HBueyE1mNCbNKZFHk3S63tjyI/jsVqdtub/V+gFPVPD+cE=
X-Gm-Gg: ASbGncutP7ORSvTPUCKKUZ3Mc6M25XS1O+Me4DwsyY0kcLpQ1z85vsXEF4vX2hAmObN
 rHVzr5NViZuyt5dtQs8kv5n4ZzhcGftU/bUtiMcoy8t+5iFogGbyZyXXm7SyfjOPMFtX35Q0XYK
 9Sd7RkJlHQ+VPwAV8MG3h03sKgf74I4HgSiqSV3CEorO6+ZlxoaMOLmvM5UIElYOYVVZZmQv8bT
 +uWvmdT6qd3QQWjLkKb8mW6SxVp9kPOUXyip1VjcyhAa0//pAGQxy7tybk9el8iunXkKw==
X-Google-Smtp-Source: AGHT+IHFkAfC8+NvosIfHU5Sq7Zvv62QKwoTs3tRyhmON5s+l14ZqeWSYAHmfEcaN8f60944qqHyGg==
X-Received: by 2002:a17:90b:2d45:b0:2ee:c2b5:97a0 with SMTP id
 98e67ed59e1d1-2f2e9353377mr332171a91.25.1734467457307; 
 Tue, 17 Dec 2024 12:30:57 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c0eea9sm6237776a12.65.2024.12.17.12.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:30:56 -0800 (PST)
Message-ID: <a34def51-58cc-4cb6-9139-82f2f46b0cd4@linaro.org>
Date: Tue, 17 Dec 2024 12:30:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/46] tcg/optimize: Use fold_masks_zs in fold_or
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-26-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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
>   tcg/optimize.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index ae1386c681..3d852b44e4 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2061,17 +2061,19 @@ static bool fold_not(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_or(OptContext *ctx, TCGOp *op)
>   {
> +    uint64_t z_mask, s_mask;
> +
>       if (fold_const2_commutative(ctx, op) ||
>           fold_xi_to_x(ctx, op, 0) ||
>           fold_xx_to_x(ctx, op)) {
>           return true;
>       }
>   
> -    ctx->z_mask = arg_info(op->args[1])->z_mask
> -                | arg_info(op->args[2])->z_mask;
> -    ctx->s_mask = arg_info(op->args[1])->s_mask
> -                & arg_info(op->args[2])->s_mask;
> -    return fold_masks(ctx, op);
> +    z_mask = arg_info(op->args[1])->z_mask
> +           | arg_info(op->args[2])->z_mask;
> +    s_mask = arg_info(op->args[1])->s_mask
> +           & arg_info(op->args[2])->s_mask;
> +    return fold_masks_zs(ctx, op, z_mask, s_mask);
>   }
>   
>   static bool fold_orc(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


