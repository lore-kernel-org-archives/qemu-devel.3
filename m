Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F31BE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeSD-0005ga-WC; Tue, 17 Dec 2024 15:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeSA-0005UJ-BP
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:46:04 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeS1-0004Th-Rs
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:46:01 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21636268e43so70243675ad.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468352; x=1735073152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pEXsy8oX+kU9/cc2sPaYUbT1D5I1C39ITTU/4YXsU/Y=;
 b=jaKKX6Mhds+omViaO/rW21pz+2aWEwxR117B5xmRoEedbscBUgHfk0Y1OXbDE9gw96
 vqu/5Xt2qYNq/rg6nEaA6J5mANNpjKDeuKPuhm3iiImrHX7FZo7cuc0qS6kySg5MUyQp
 3Y5JseA+wnf5QO7eDlheprizTi2bFDwqRh4H6ze7+bxw3sDpE/q0PVYwVsUCqRioINvs
 ttUdxmjBI0ZpzHMuVkLKUrq907iKUCawS8qNNuM9plkDHAo2eJlIRIDwhzeZpNeAUioK
 K3Ff6r6QNYPfiRGBRAad+xh8PbvZj2/zst6szxZobaLP3973JdZIHLV3ytOaJo9U3/Xr
 zXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468352; x=1735073152;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pEXsy8oX+kU9/cc2sPaYUbT1D5I1C39ITTU/4YXsU/Y=;
 b=Q6mT+UbhCBC9VsBrR0rGEHMUyU1QR0fqz6JE6/BQ0rzilrntS+eUdF21T8JYo885e6
 OZUBHdvvsTkk9jJ5fknVj11m79OTOkCwbQFhEzl8pcSm816aDtqjNk16ctTpB6IIma+l
 qxYbK+rIGMWL8m836utzYwD9dHAvJK1Nby/haPZDHdPp0fHQQRdZNKDpKOWl4hL82BG3
 D16IPW1e+6mrdKSsyun1nKbMWFUNTC4xZPMMGmd0gEzkHQ59d4K6iNrRl1HQF6yEkfNp
 4hGQUnUZFKOG5U+wCZkH55zfWWnNYp0ObbVxFvh3w1lN2fKlbj/DY24VtpoDdPc48POX
 QDXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5A5hF4JaNFK75+wA0Qt/eUFTopuiterwAAaZLZPY65nDTDDPsdmJaVg3jGYKZsdXz+JBr2jPk2u15@nongnu.org
X-Gm-Message-State: AOJu0YydmTxsaP8UBJPz7P14a596cRStY7fIuPZtjgW2gGZZFQKvXcwF
 Hw2hPSYu1jLE+0S294PO1+bIsPydZln5bBpD4czjyNB+l4UkMiMv0wA7LU+wuymIOIs79+ZVuGi
 WEr4nSA==
X-Gm-Gg: ASbGnctgI9WG3bvDpRDvV3NxdOPpFQbD1XStP60nNFWK5vbyoqaqslVBpg/veTIJhvM
 tX0LTjUMtETtQ3Fx/7xWnorGLF55qjBiGfy12h0kkQ1Svm++S4A1vh54uOVzGGz/2T8yJ8zkItu
 7IZGLaOvYBsojw71qFTiQiU3EwqsN1yW+aloVMgkcxlLee3mv8f7ha1iOXDt5rOfdhPAFVrKt2M
 s6mMkuqaf85XQflvfUKawmQ2g1xTqFxeG9UzM+ilfuRcClBB8djNVhnoX4qQPnzLmTTpA==
X-Google-Smtp-Source: AGHT+IHIjnMSL6GpWazVuVmDFQTqd4M2BBAVD+QQdjGjlFu7xkvC0anGKAGnCS1X+6Rv34mIeKd/bQ==
X-Received: by 2002:a17:902:fc47:b0:215:853d:38 with SMTP id
 d9443c01a7336-218d70f6e34mr3813505ad.25.1734468352268; 
 Tue, 17 Dec 2024 12:45:52 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6d918sm63248655ad.262.2024.12.17.12.45.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:45:51 -0800 (PST)
Message-ID: <fab6836d-0718-451d-943c-a75b3d7f3e18@linaro.org>
Date: Tue, 17 Dec 2024 12:45:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 42/46] tcg/optimize: Use finish_folding in fold_bitsel_vec
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-43-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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
> index fec46014be..24ec14f476 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2821,7 +2821,7 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
>               return fold_orc(ctx, op);
>           }
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   /* Propagate constants and copies, fold constant expressions. */

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


