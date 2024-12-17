Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9C2E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeLl-0005gN-KW; Tue, 17 Dec 2024 15:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeLg-0005fo-SA
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:39:21 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeLe-0003H4-JT
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:39:20 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21683192bf9so54879635ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467957; x=1735072757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9LXXzkclIvSEN+AK3+4g/+gVuDTsi+zO6XLZY2MEO9o=;
 b=Y8594g/neTDTaSVRQ69XWricPr/gwUSdhtT8EZVHkF9sG8KR39iO1JA/cDcbSEgafn
 e0j/SlCGhFOykTMC3aZnKFkk0ZMC6G/ncOGveh3ytltPjK5p1aivkrMilctRjzCHl2CL
 olFZe7TaSY0IoCvaNRayvj6IDfWhs/iNATHrN/TvatXOO0sfbZ3RQYnczXO/6gM5FT/Y
 CL++or2+xH8z42iWvVPYiTI2G7dcEAtW77GM/MaB5FKSP4+hVY+2YwQhyRl+W9kKHvTa
 xrWTclRE5BKFabzIgK+arV5pyNwKjpGYdUS+5xMLEl2uqX6C5LY5gSrVYSJySJtBDABx
 vD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467957; x=1735072757;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9LXXzkclIvSEN+AK3+4g/+gVuDTsi+zO6XLZY2MEO9o=;
 b=QeWGoamZ1PoAA+931DZzHI2PFS2IX4DeHVzOKwjf04Z9+NBHAuKJQe10N1iqbNR+Td
 bTS81UY7CCcsKQBvYm00SMHoHSIEh5zGB6fVupnh2784g4GmqhafPJxGi3ml9hbgQhh6
 6Qs03ZN6c56qZoBzZJx+Yq7hOQyrtV40SHMAdHOuB34ex31xnyl1OGdDp7jKMJZEtzgu
 Mi9ZFbBAy9TN1GwhgEndgIWiDKIu6Q0NHVb+4qT+hukjfLVEc68TKyfdBmJjg07/cYsU
 roFgwYA8EYMYwdeSzq5wcFnJ/zNvepB4n/0BDfgDREGIduuuhZN0I2/EQjVCblZmwqjW
 X5SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsphsw4FHh44aT+1vPxcRT3cgpVyxcDiF5AeX0T9G/TsPRJfKffBFzJdLwFYG2Kk+sY2p1wXmvFvlx@nongnu.org
X-Gm-Message-State: AOJu0YztWYMGpzOlwY6C96CtjW4IH2xDdh6lFm852IzSeqcQDXa0eK0X
 ZiYWEyVC95x+0zJDip3DbnK5z9U/G9H6nrGv0+6qyFi9qi7YyKhhNf4uvoGn24C4MFa4/r9/jwK
 UexJnkw==
X-Gm-Gg: ASbGncuA9smAAQKr1+ViamebkS+tRsJoPatcSTQGhsvlqOOblVYiQxFsFyAX7dC7djM
 xth4l3Ddw0kb5UuNua/QUIB3Pm/Ajk9zlDPUIcCqBsAXOYUAYRSAwChj765lH5M7xituBsKEHor
 za5jiUYa6K/dyPxGfa6Tb2/NBFtjDcGGF8wXdwqyrgcQKMc5V/PBsJlp0Qg7ifyZ+gXfXb8g15K
 dywa+a6YlAkNS4l5jNtiume/WEy6YfUsVZ/3+zpo+OTgbhO7baplMExEKth9j09HVtT/A==
X-Google-Smtp-Source: AGHT+IElqh4k5TAu7VVMcT5BdsNzP58cRBahb35I3FbuOwC8Q+9+3mw+GAyyj0CeWMsREIc57+UX7g==
X-Received: by 2002:a17:903:22c8:b0:215:af12:b61a with SMTP id
 d9443c01a7336-218d726c0cfmr2119725ad.50.1734467957230; 
 Tue, 17 Dec 2024 12:39:17 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e50126sm63357095ad.163.2024.12.17.12.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:39:16 -0800 (PST)
Message-ID: <1e788434-c117-4006-b089-32ee4ddbe50d@linaro.org>
Date: Tue, 17 Dec 2024 12:39:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/46] tcg/optimize: Use fold_masks_z in fold_setcond
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-32-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-32-richard.henderson@linaro.org>
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
>   tcg/optimize.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 7b1d437c27..cfd4c08f11 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2349,9 +2349,7 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
>           fold_setcond_tst_pow2(ctx, op, false);
>       }
>   
> -    ctx->z_mask = 1;
> -    ctx->s_mask = smask_from_zmask(1);
> -    return false;
> +    return fold_masks_z(ctx, op, 1);
>   }
>   
>   static bool fold_negsetcond(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


