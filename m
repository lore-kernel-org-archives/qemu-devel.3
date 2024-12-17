Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A51FE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeDY-0000d5-7g; Tue, 17 Dec 2024 15:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeDX-0000cq-3o
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:30:55 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeDV-0002Jl-F8
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:30:54 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21675fd60feso60033665ad.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467445; x=1735072245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I/CKdHB6NEHDjkp8AQkOX1mCkHbWJSgMHIwC2hebFMI=;
 b=TpPtviycNbksOyfR1kqtpJOaDjYeGrNP/W/9ElI/Q8Qrx8fp415ZjHdt671kTRJFM6
 OPrzqLV1Q7H8G0Ijw9h4Nj8l+V0XvRHnKt+ntNyj1SlkSXDZrCp9R4NC8vs4tb4B5VuM
 bEtTQ6lZqM7dighY1MEDSYh3hIAA3tsYtcDmeL9kLqGiZ7AK80kW3OPai6cuh+LNqYQd
 kJWWJASaL/8hj5y0llw9dsuKTNo7bZ4cpHO3SdiqTmXWFvB1ccf3jklb2pJ5TWyirMyt
 JSkDIiDhJuZnDSolWtKorgv0Bqup0euqSrHAcyXxeVFkbPjv9gFdh1s4G3khVCRmmRE0
 nQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467445; x=1735072245;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I/CKdHB6NEHDjkp8AQkOX1mCkHbWJSgMHIwC2hebFMI=;
 b=t4zA1AMk8fMbSo6g5ATELXKyHrEPga6j8EtGEiVrep6irah9UhlgQSmLF1dk3qzHP6
 Yk6JKfXGOvFMq7k3IMc8f8US3lVFd9YpRbONiD/hzqwag6pNLrO7uwzVFE6Fq4jpAT+V
 UpRa/e5wHf0zhmcp8DeCY4Rg3sSa4AwWNGuwXleHISFD7k/wPrfYOHMLV+VzvbGY+UgI
 s7UrgiBeq/uEjae9rREp2Na4f/xQ0315RcIa16yS0hlP+OCkB9zAussFBhK/2cmvtlV5
 GdtT0IRI/hoaM5wXuZZjHcYCmi8gcamf0r5u6hxRVzGa7bI814mEfkPzsq1MMu4c35cb
 +TyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX73tPoNkGXbOsy/LypUaERYB+QBPjq5DC8hI77QNfztg8r++nZ059bw9aOtfzu3ogp/DgYTb4ltYFT@nongnu.org
X-Gm-Message-State: AOJu0YylVrss2K74fVG+m31fKbLjvicfTv70lGM6jLhkAgs90xzKyP0N
 bSN8Cxu/kz1KtQhwg+OAbJm3s5CLzlNYYlqeUwDrg4pAs+hkrkvJtvk1/TNsHPU=
X-Gm-Gg: ASbGnctTt6AI21JMkrQI3SQgbgqZSS9LdFp5XqXQQE3kgxcCcbqZkD+DLujr3hKIcGu
 Lyh7zYvr4iNse5eEfIf+HGVWTpTAXy2P9guaghyYWUXqdZIOFR8AZofESp5vrRWirgCgQN/NCN0
 n1bD8nvCa+43riEODkK8XvJiwUT9MGV4oKwwrN9q2EfGujgA0Ju+JZPCyHPY7HD6j2cV2Ca+lWm
 /l3LPJ3ofqqHU5szRTeJOPkov9hTLZdJuduxXOGFH7JDk+FKCD8SIaHsciokrRCmf4JSQ==
X-Google-Smtp-Source: AGHT+IF0nt/ihxTXclrGKAb+Rb4GqP2XR1TtllkmYDOVm9WTQazXn2iQY+u7m5u8rI3VOEDnXSNoTw==
X-Received: by 2002:a17:903:2447:b0:216:725c:a12c with SMTP id
 d9443c01a7336-218d6fd7926mr3034175ad.9.1734467445005; 
 Tue, 17 Dec 2024 12:30:45 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e72979sm62122155ad.283.2024.12.17.12.30.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:30:44 -0800 (PST)
Message-ID: <d8248110-0513-497f-8050-246eaa999267@linaro.org>
Date: Tue, 17 Dec 2024 12:30:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/46] tcg/optimize: Use fold_masks_zs in fold_not
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-25-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-25-richard.henderson@linaro.org>
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
>   tcg/optimize.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index aa5242a380..ae1386c681 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2056,12 +2056,7 @@ static bool fold_not(OptContext *ctx, TCGOp *op)
>       if (fold_const1(ctx, op)) {
>           return true;
>       }
> -
> -    ctx->s_mask = arg_info(op->args[1])->s_mask;
> -
> -    /* Because of fold_to_not, we want to always return true, via finish. */
> -    finish_folding(ctx, op);
> -    return true;
> +    return fold_masks_zs(ctx, op, -1, arg_info(op->args[1])->s_mask);
>   }
>   
>   static bool fold_or(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


