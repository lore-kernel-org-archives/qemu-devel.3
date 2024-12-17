Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0546E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNe9B-0002ky-J4; Tue, 17 Dec 2024 15:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe9A-0002ko-II
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:26:24 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe98-0001T0-PS
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:26:24 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-728f1525565so6827017b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467178; x=1735071978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E4fL5A3Qk0ALAWmtE2ZOcr1ZupHwTAH0oUb+3ALATs8=;
 b=M+yIRhMzep8pEk4y6uOXPhrTz/D0i9K+Mj7y1uD3H+2B1+PeRU8eS7IicyYcuYVc04
 a1zQLCKi0b7igNe0klgOG367J39o80NPw/+Xss8kFkXQTjMKzcBsLxPjWWSvQJv7kuAe
 tid+XISX1Mu71LZ4Lzysmg+/DuOC+eZUVSWhKSp7vxuugJOUWppFEElZe7pMWVeR8SGb
 B0kJAj6mE4U5TmEp0UlEA6Th+JWwF4+LTgFiv435orWXO6brfx4mpWiXIXb6qj78ZoCT
 e0eXeim5hXKSXF9GhoKoPQMOf8414c7eforWh2btrJUJ/uXNvhv/fBv5FhLuPpl2Xmy7
 ALmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467178; x=1735071978;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E4fL5A3Qk0ALAWmtE2ZOcr1ZupHwTAH0oUb+3ALATs8=;
 b=SAwZfNpSOE3BqObDJuVfrIMA3n70n5Ceg/VYnCuLhmT6ON5t80wafjlL7xGJbYFWrg
 CCs2xsAUEWNET6q3wiHbdwMIDWdnNPg3Vqe3leMQfJbLLnZ9VkGkvrJgbIjLmLZW0Dx6
 KuNWrVckJ/U17MB/V7NVgk3auKWDqnCwEy2MNW2TXDeV3Tr4uXaErX4VyP5Jwiln2BtL
 Eidtr2DiWQwa/xnRhOTLxqYoSrxo0eiRxDk/VuO69jcgAPeTvXnwTPTyjdLUnSo32Vzv
 PpQJt9bU8+TQ4j/241fHpMwxrn+VV4otGuSORWKzouXdJLElwzdGXGUMrky6DG2xn9cs
 +xkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgQJZ0qN5rAn7XPZY+tBSsmn2pVLXoBNTbmt71jNWbA/azJ9YzyXnSOsxP9sNpZmsFgEsRSaXJU8vK@nongnu.org
X-Gm-Message-State: AOJu0YyM1HSYMr3iQzn6bemv8V0VBzdWZ4m5yHJf3wSGz14Q79NYoJc+
 P1ePhlY+QIHuE6OZuv44Hc9a/KgucDHuEgv0qW7Qmy1w69tdpwwgfu3ySyD7iDpcjCB8YHmR7E1
 dILZp3g==
X-Gm-Gg: ASbGncs7eMWKQ0FTUQn7JcRsrXB8IAXPfBSeqDBXFgVEUTS/kWsihP2sW81YXe8cAa6
 osxoy15Z3LsWswMReDtuTi4CzIrnIA4dtA9sOfpLeU/U1JLBQsR4MCv+2ovHphXnx9ytyxsv5OM
 oQXvBhsQGSmAq121pKffG9PtbMTJHcml/VfFYMf6TT5wOT9AOMRJQp+Mu590pOIdM1feZZJChDW
 wdItnKHoSd7q47cyYX8jaoRN1X2GX79w19Crj98SEXoHEm/dqcmTftGgb5CshKFQ8vhpQ==
X-Google-Smtp-Source: AGHT+IG+6VfZ+60PpgFPmDko4j9NH6TZIcsbuk7ebTbD7S5Ol637Id0I/Q7XLszzO2Eu64t2NINF4Q==
X-Received: by 2002:a05:6a20:244f:b0:1e1:9f77:da92 with SMTP id
 adf61e73a8af0-1e5b4889167mr495349637.33.1734467178204; 
 Tue, 17 Dec 2024 12:26:18 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918b78e73sm7304239b3a.109.2024.12.17.12.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:26:17 -0800 (PST)
Message-ID: <913734cb-d2a1-4099-91d4-c7f650d02e51@linaro.org>
Date: Tue, 17 Dec 2024 12:26:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/46] tcg/optimize: Use fold_masks_zsa in fold_extract
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-16-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
>   tcg/optimize.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 5f3a824a07..955151f4cf 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1716,7 +1716,7 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_extract(OptContext *ctx, TCGOp *op)
>   {
> -    uint64_t z_mask_old, z_mask;
> +    uint64_t z_mask_old, z_mask, s_mask, a_mask = -1;
>       int pos = op->args[2];
>       int len = op->args[3];
>   
> @@ -1731,12 +1731,11 @@ static bool fold_extract(OptContext *ctx, TCGOp *op)
>       z_mask_old = arg_info(op->args[1])->z_mask;
>       z_mask = extract64(z_mask_old, pos, len);
>       if (pos == 0) {
> -        ctx->a_mask = z_mask_old ^ z_mask;
> +        a_mask = z_mask_old ^ z_mask;
>       }
> -    ctx->z_mask = z_mask;
> -    ctx->s_mask = smask_from_zmask(z_mask);
> +    s_mask = smask_from_zmask(z_mask);
>   
> -    return fold_masks(ctx, op);
> +    return fold_masks_zsa(ctx, op, z_mask, s_mask, a_mask);
>   }

In this case, we could have a fold_masks_za function.

Sometimes, we put special values for one flag, or sometimes we call 
smask_from_zmask, or we rely on the implicit behaviour of the 
fold_masks_* variant, so this makes it a bit hard to follow.

Either we should go fully explicit (only fold_masks, with the three 
masks, and every call site has to mention them), or specialized 
functions for every situation we need to support. But a mix in the 
middle feels a bit awkward.

>   
>   static bool fold_extract2(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


