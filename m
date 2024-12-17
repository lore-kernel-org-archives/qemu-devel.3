Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D824FE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeOc-0007U8-PM; Tue, 17 Dec 2024 15:42:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeOZ-0007Sw-Jy
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:42:19 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeOV-0003o8-PU
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:42:18 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2164b1f05caso53481155ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468134; x=1735072934; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GX6+OTZDJVuCnj0ewZSn3e/uNcGm/ye5q53lpZ6bbOk=;
 b=R+ntSRaPany8AKTnWfZxNCKAuXhl5uCBASFfhQRSSdnJyA/Xpgo6TNtv+lK+5mcJMj
 PxBi2AE6hgZNvuVatic+5DP4cew0hQ5MQnuNehij26SZ955yZRNLUgoLhqngMveqDK7p
 HW+1WIRfxSSlahKYtJlJv2uspKbNzblu9dGjDm82f2EwVx4dOA12SrN+kKn3KJytH3nY
 pLovH3Pa+0U1Pbp5HUTpwqOQqTOd27892s9I59wUC/cYf6Ue2rnDKTXqJ46nem+hoefE
 nkTHt2jkN7h18LFKwOOjmngQwAkVuba2cwejmaR27A3/sZaa1fFqPAb986/XwfyuFcWs
 jk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468134; x=1735072934;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GX6+OTZDJVuCnj0ewZSn3e/uNcGm/ye5q53lpZ6bbOk=;
 b=BWTSMvL2ettzamDamQNfkEcgLAsgMAo2sgXGH79JaETdsWXyzAYR50cxjNGG9C3K/g
 4EpwZLw8Os6BprsbbhGW3/LDOdDRi1kdytjDjPWcgirDNtphE8YlAPxosC9payApVRRH
 WuVZvRu6Qv85sqYmWGBRr6DQuk/PEe8Z7OH3AiklnygCWoA5I7YISHgkABDdLjWIkdfs
 8VwJZbgCXDEX+p2CItkM3tUcX55cSL4ji7X2KgIGsGpAujsvXuLlnRZNr5+zSz29fKFY
 82H6tNEQ8fxYmjxejVVCxFxMMUQ1L10ccvy8SYXvd07kyMKB84+j7zREBVoVlgQ01rG0
 Wu1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg6fakUjM3RknEsw4VelF+DF4aUENzedzx7JWZRY3v8OdzNGhb1ob0UPq+LUkRKMfysOLf5/V9Rizi@nongnu.org
X-Gm-Message-State: AOJu0Yz5IbPM1SPDQ8AZ43WSTgGANnH3l/f6uafiG6azXtK1eYzmRC3I
 G4E4xuWnhf0yHM9tjMe0VqyeR34aK03CitXeg9Khroxdb8HMogjm3w+PzNnacBY=
X-Gm-Gg: ASbGncuYBor/PKO5CgNtwI5xaRBJLB6Lp/d32nBOFpIPu8p85zx67dirz1zmGO+MGHK
 krA/Zuwxu+WVW429/nyW/CZRn/txA4FiSzrAcBLrye3FaWkbfN5ZEWrIqBVRAowf9ZgKLuUy/9y
 /+SsRX4QhvcOSniof8eoKlJWhYPqYnZo/R7mwNlPtPtF+r+05jed/1EnKIBN//Od8NkXnvNSXXb
 3+eU2Xk92I0pUfHsHSzyFoDSunB2rSTlH2VSzaB9DRcAS6upw3YPa+uxHG974JYzvRukw==
X-Google-Smtp-Source: AGHT+IG58hrUmsBRNq8E0ZSo74PgAie0p+F6FJefR3xYmBQvG+ndzr2S/JUgM8CeEcXkSSEIfSw3jA==
X-Received: by 2002:a17:902:d2cc:b0:215:b8b6:d2ea with SMTP id
 d9443c01a7336-218d6fe4940mr2521085ad.15.1734468134464; 
 Tue, 17 Dec 2024 12:42:14 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e54062sm61795335ad.124.2024.12.17.12.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:42:14 -0800 (PST)
Message-ID: <0f990014-07dc-4aab-bab6-484b9a9cf267@linaro.org>
Date: Tue, 17 Dec 2024 12:42:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/46] tcg/optimize: Use finish_folding in fold_cmp_vec
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-35-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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
> index dd6ef3d831..30446baabd 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2462,7 +2462,7 @@ static bool fold_cmp_vec(OptContext *ctx, TCGOp *op)
>       if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
>           op->args[3] = tcg_swap_cond(op->args[3]);
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


