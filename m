Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E387E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeAb-0004Wa-8X; Tue, 17 Dec 2024 15:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeAT-0004Ns-Nk
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:27:46 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeAS-0001dm-6e
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:27:45 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2166f1e589cso59929725ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467261; x=1735072061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uwAU3nIqP1myy72b0xIOnVY0PFZjuRsVmud18l1BuW4=;
 b=G8dbP9CwsXhuhv6iv723q20sFOVtBI0W/w1gYuFo9rY+c360tYAolVl0+Yoo/ZaSL9
 OIG98JQ0rLYADmdWS6FP1xGSmfEk+p57DI8zqmyvl55J+NwgzNWqzV8cxfH16C8iaPwV
 /BPLOTDY0Rd5e/S6nDoFyr2VjPC0TYWrVTeftxx9+/YuavP58Q6AiBaaM8W0VKTWdJ64
 01J96bB45qoCLV3URmfZSUplZLIUpTePk31chsfGK78GkkecYz1adx/1Gh6G0eDzpSgY
 9XZQaL97Sr7jZJapvIsVTzp9056yMzEG7VsWMV29tbe0PTiO9zK6CQlsD3QmZg9lHRh0
 DKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467261; x=1735072061;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uwAU3nIqP1myy72b0xIOnVY0PFZjuRsVmud18l1BuW4=;
 b=jccUH1TMi/4xNBLZRowzsNmtqW8uYTIgrnZoyEfzwAKMJE/mlWZVTRCff7Y3EA6zvS
 uUhuve8TgB90r9+N1TD739/2KQSt0BaTRHPhwl6qQnjhKMGM2T8B+d5hY4TWfS9oLivj
 kV4kHFHdn8KnbbN+s9sjS637ulDIQ0xPwN1OsJq0CbDifflyn0btq08jfWgbSt2HTSdw
 hz6zwnEVXLtv4rwxxDHMqq/5nB7sWRhFJsy+Hc5yEX+L/u+edqCLK4dexoeNuj6W//FB
 f8M8xmvjAOXaGRZpLmIthBAgq8PL/Z0Z+zS9T2xzRPyoFU3oMz1H+JvC3briTjHBFu/N
 UmdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuRULE/xbtxzm+HKDtiK65PzbyhW+4l/Cia1nsC0Nr2YO6PrkaFhmQgJssEux2p+hKPGni3L7rBsdG@nongnu.org
X-Gm-Message-State: AOJu0YyvHHmZQW9xglpacWUs4ZguoMZYVoRjFn8nfcfEXCDPYAyxLKzj
 tXRxB9hb2sXNWr26Na+ge9kD5T9WoO3dg5HdgXkx6m5JU1LHAwXZeRRmFTui0aTR0Ysp+61t746
 CF+d1ew==
X-Gm-Gg: ASbGncs3PV6zIGO8UqF689Q6AsiZmPiRmmQyJgMakDjhMBgTgzGe5ECktoF9jG6418+
 cz1lMTXRAaOS9fKDHpPEinWgsB+YtFw/SI5JnLzRR88x8tcSUIEaDs0/eS/x5ld3yc1b2eMCikZ
 q/6Nbmt2eZ1l5YunnFgu2nyUmdrU+4YXsfVAf789+oVFUUF8E/0SZcEiwz5cpYN1EgC2RZ41AOG
 Wdk7bWoa4BAcoq5cyd9FlWtaRWweNewufXKjGAIxwdGNsjXCtMMILdTIdhjd5cX22bC3w==
X-Google-Smtp-Source: AGHT+IG69axpWRP356oi0zNI/aIaTUXvohs2pTYYDQq4gcu9QPfCvsOtPyFkfi1clapACXGUJXxrrw==
X-Received: by 2002:a17:903:1250:b0:215:6f9b:e447 with SMTP id
 d9443c01a7336-218d722d546mr2054485ad.30.1734467261152; 
 Tue, 17 Dec 2024 12:27:41 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e63896sm63379815ad.223.2024.12.17.12.27.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:27:40 -0800 (PST)
Message-ID: <7f508309-71cc-4c7f-afd7-778885230b21@linaro.org>
Date: Tue, 17 Dec 2024 12:27:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/46] tcg/optimize: Use finish_folding in fold_mul*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-21-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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
>   tcg/optimize.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 6d2d55f053..111969c2e3 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1952,7 +1952,7 @@ static bool fold_mul(OptContext *ctx, TCGOp *op)
>           fold_xi_to_x(ctx, op, 1)) {
>           return true;
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_mul_highpart(OptContext *ctx, TCGOp *op)
> @@ -1961,7 +1961,7 @@ static bool fold_mul_highpart(OptContext *ctx, TCGOp *op)
>           fold_xi_to_i(ctx, op, 0)) {
>           return true;
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_multiply2(OptContext *ctx, TCGOp *op)
> @@ -2006,7 +2006,7 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
>           tcg_opt_gen_movi(ctx, op2, rh, h);
>           return true;
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_nand(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


