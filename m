Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2271CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeQm-0003bN-J0; Tue, 17 Dec 2024 15:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeQk-0003X0-Dp
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:44:34 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeQi-00046K-QE
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:44:34 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-728ea1e0bdbso4508656b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468271; x=1735073071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=prcAUjuAU/sVVopefmWkagZNFvSrvxNPt/rZYzp5Mc4=;
 b=SaXl+JOE4VqAc/483w3o3pAHAEcy0ZXtRKfmgljUKiIdiV8zEzRlv9Y+Y1LZxtetMF
 obdg253Z9944SySQe2a/yOHWAOIS26Kod1Zs5AoEJfIAcBjtCCbf5csPM940ZP0BJgLa
 fcK8vOng7FSa7CNPdwJB4kx4pFS7IyPNXD1JPifsmnSv4cHAAfawktYs22nvJpsyAfNs
 etQaJz9qRBQC6OXkuLgVQbzFq7ckb8ZUKBuXfdgL/PiMneDnsFM3sWTfiOsfBJGqcA03
 Vw9RN1yhAl4HxWykmRHhe5F4cpdLWIRtDstaoXeRtdqOoWY1ihjO0cYJ7ck8uz+1nPis
 3iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468271; x=1735073071;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=prcAUjuAU/sVVopefmWkagZNFvSrvxNPt/rZYzp5Mc4=;
 b=fvK32To9yV9TkCQ1u1Y+MOf797KUYqgX2kPggI9Oh5QOJiV5b4xPDyznTfWiQbjjPf
 RcWai9YTjhXwQ+orzVDsBAptUgCI9N7qTLZx227lixV2nHWlkj6BT8qbvmPvuIeJ3X4T
 QlRIUg/tkGjP8v6z7jYP6T3MPenHY7T8gEKmm9DkBayzoYwsbdKKTcXATwZYrbffFns2
 GSJLv76juVnnCuyeV1FOAnHDxu8Ghenv/7mNidqGN4BvBeiW8F7vcHkrOb2rXGviVu2D
 1A4gO0xs5i73qPe9E91PtDer3KYaZNbacX2k46WmhSmhVWquhn2/krdDM00t6aXySLur
 mvsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJbNQjnCH8T/Ime5oyQShJtI+g1hDjZQS4i/hf0g8F1kiftu2JBpw9+wuM72LXi9HypT3jhqw+NfBV@nongnu.org
X-Gm-Message-State: AOJu0YyOdGbBIVdFJQ1JG8OyN9pECW+bnc01T+SSPkLdWubn/udnI3NW
 O4UKaMbhPF3ffh4Opy8D3jPqaaSoI42zPBr9cPFki04heHzJAYuODCWwjBpbIp0=
X-Gm-Gg: ASbGnctFYoGs1Cav5RoW2aJXWG5fjDiWcApv5dkNCgjSWk6z94qVKlAmG47X2pC2NOI
 zUJENDDRuKmg7o1X1rt49t2LJ3nDlit0pMcR+fPatG6BtpdFu0Za/LVT36O20XBiULOVZQ+pP+U
 2O6hNYjbp/Nz4E69JO7gvb9mELQiizc9oiYKbghH2rSFm/5k6M4DBSbvRw7GDyitkWcfYIWRgHl
 nl+zOa6B4q26QhLTDGg9121/JD+Y2STZMlyHszf1WnnIpJcP7i2U7bCsjj5eLN59Dv2ow==
X-Google-Smtp-Source: AGHT+IFf05Jzjx7OEh4jhzbnWmKeFHmITxovUyh72XloaocQRGbZk+dqfY0wWRsipaskmC3BTJnxhA==
X-Received: by 2002:a05:6a21:33a4:b0:1e1:bd5b:b82a with SMTP id
 adf61e73a8af0-1e5b48a1723mr680604637.40.1734468271453; 
 Tue, 17 Dec 2024 12:44:31 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ad5ad0sm7076512b3a.56.2024.12.17.12.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:44:31 -0800 (PST)
Message-ID: <539b9d19-9cae-4e8a-ba13-73c83ada274c@linaro.org>
Date: Tue, 17 Dec 2024 12:44:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 40/46] tcg/optimize: Use finish_folding in
 fold_tcg_ld_memcopy
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-41-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-41-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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
>   tcg/optimize.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 4cccb3b0cf..46116970f3 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2674,7 +2674,7 @@ static bool fold_tcg_ld_memcopy(OptContext *ctx, TCGOp *op)
>       TCGType type;
>   
>       if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
> -        return false;
> +        return finish_folding(ctx, op);
>       }
>   
>       type = ctx->type;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


