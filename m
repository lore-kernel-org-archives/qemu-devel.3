Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B575DCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 18:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKgcn-00040E-Sp; Wed, 06 May 2026 14:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKgck-0003zk-I7
 for qemu-devel@nongnu.org; Wed, 06 May 2026 14:05:30 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKgci-0002ha-R1
 for qemu-devel@nongnu.org; Wed, 06 May 2026 14:05:30 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-479d68a9063so2413128b6e.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778090727; x=1778695527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gZDVtU0wNSgdMpt2vn2l2S8cglOIJJs+bSMexVCmVgA=;
 b=U3kTCQ/frsgY6QaompZMEQKrjz395+hwTBvkNYyntCoKPzTsKF8PtlkKiTPOyRQxoq
 Q+GSGUfQun9+bQNHJ24ZviwaPNVNDw3JXMeEJIYMnVQGEf7StDkhVCJ+++J0qJN9ivuT
 s/rk7676ZBuJfSFqksnBYIu3LlsWyZvPRs3pvybOw9cEub55UM3mK8mGRkJWcSL1GFya
 IPrt0JsQu713KOSZFwqSjWWmFeOGgMYYbHvyyZlN+gJLC2fKbytQlGsRTpkDNalLUJxS
 HsIMr6otKWji9XOsTBKIji8AG6O/9mL0Ife1sxYnKIpjeNqqeymvS6Bx4mGE5cxFtbmz
 xsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778090727; x=1778695527;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gZDVtU0wNSgdMpt2vn2l2S8cglOIJJs+bSMexVCmVgA=;
 b=ILR+YuxpF6Pg1C5luB67qoYUFs1rdkWO2UPppUTh9lATACxG01m+//Us7V26eO2bLQ
 R1A8AJPuHzgObBVYmQq2WiWGjeAA8N44MQ0I/NcwnwBBbodxxg6iigD4grig2HIahjSU
 rvNiCuKPhpv216+Zgg87Pv+8V9OanKMTXdCPXxWZWviVIVAIU8B+MXSqzHeBPDxsoRPw
 aMcFauhwta5d31IYv5bh0jFmcqfK+rB+HF9l9x1q1WUaMkSzH7MP7Yl70Mkn60gEAbiN
 76RZ3j8FlDiz4D1J/uWLhrhVUraQ/d6aCi2eb0WTt4J8BAFxnXJO2GtwV2u2Z10/5p4j
 VuyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fle7TQGlZjTupaNbk28hyyhIrWq/IqKz2kmIFKBaBLfnJfGYZBj4sVkYZDiWZl+LKcDd929G0bET/@nongnu.org
X-Gm-Message-State: AOJu0YzqUY46RmknDmSQuwmsb57qcRfChsjx6CiFAb0cvePQsmKjT/ga
 I7EV0bxY+SiSTg/hm6DtrpPa19A9xZ1DliKWxlFR8FDqFh/XyPCKzMo3zuJH9y5QVzI=
X-Gm-Gg: AeBDievlPB6K/7NjGE3kCSG5xjdxC48/GAN+tYavGO24p9fVpqfirSb6q03T4KFDqxZ
 6Yt+87Qfg0aZsRaHwE2CjJrYX1W82l30vw8Uy5OgwQBWQV3RZncjEsJEfJwd9DNulNg9uLp9gYf
 UWeKawnq+YdbFY4dGi4773aywMKIKcPgWA4dZSl9SO8nZYZJLfB3WBQd0V6ZVoyKjNvyEblA07H
 p4EF0ZeqFznNDSsGsUMnE9Zr13uvv3tSgz4iH6iQKRCEo3PVkGLGLRYSQlAPXelrzYqDmi0AvS/
 7XTLWYqyEweTFqiXoB2PpYKl1iTS9ZBUE1aJbQOM/iuiqU1Btpyx5Hwa8qUU00sRXWZXJ48hDIP
 6DqR+aiSRImWvu63ilZ9mTfvErsB6rjY+Oor5xfCxXolFCnjgeAXBMD7BupoQdybvI/RynaIIcC
 g8Cv+Uo1JerH3/KIYFjb0wEfEAHFTXVVXqy6PtX75TPcgn7Vs4xENLZLIgpUNXhZzSn6Z+WOvvO
 jq3r0NjpY8ErWrxsKH0HSU17XB99Ag=
X-Received: by 2002:a05:6808:3a06:b0:479:fb10:1287 with SMTP id
 5614622812f47-480424e1e9dmr2385483b6e.36.1778090727090; 
 Wed, 06 May 2026 11:05:27 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:339c:eb71:5878:bb6f?
 ([2600:381:c938:6375:339c:eb71:5878:bb6f])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935904sm10859943b6e.11.2026.05.06.11.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 11:05:26 -0700 (PDT)
Message-ID: <02070874-6c51-4b71-97f2-1312b5a3b231@linaro.org>
Date: Wed, 6 May 2026 13:05:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/15] target/arm: tag is not a part of PAuth with MTX
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
 <20260504-feat-mte4-v5-12-232a648e63c6@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260504-feat-mte4-v5-12-232a648e63c6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/4/26 10:50, Gabriel Brookman wrote:
> As described in the section on MTX, tag bits should not be used to store
> or compute the PAC when MTX is set. See also Authenticate(),
> InsertPAC(), and Strip().
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
>   target/arm/internals.h        | 12 +++++++++++-
>   target/arm/tcg/pauth_helper.c | 18 +++++++++++++++++-
>   2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index d313d36603..31b7e1c85e 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1809,7 +1809,17 @@ static inline uint64_t pauth_ptr_mask(ARMVAParameters param)
>       int bot_pac_bit = 64 - param.tsz;
>       int top_pac_bit = 64 - 8 * param.tbi;
>   
> -    return MAKE_64BIT_MASK(bot_pac_bit, top_pac_bit - bot_pac_bit);
> +    uint64_t mask = MAKE_64BIT_MASK(bot_pac_bit, top_pac_bit - bot_pac_bit);
> +
> +    /*
> +     * If mtx is enabled, second nibble is not part of PAC. See
> +     * InsertPAC().
> +     */
> +    if (param.mtx) {
> +        mask &= ~MAKE_64BIT_MASK(56, 4);
> +    }
> +
> +    return mask;
>   }

Ok.


> diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
> index 67c0d59d9e..3d83ca4c3c 100644
> --- a/target/arm/tcg/pauth_helper.c
> +++ b/target/arm/tcg/pauth_helper.c
> @@ -342,9 +342,16 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
>       }
>   
>       /* Build a pointer with known good extension bits.  */
> -    top_bit = 64 - 8 * param.tbi;
> +    top_bit = 64 - 8 * (param.tbi || param.mtx);
>       bot_bit = 64 - param.tsz;
>       ext_ptr = deposit64(ptr, bot_bit, top_bit - bot_bit, ext);
> +    /*
> +     * If mtx is active but not tbi, then the top 4 bits are replaced with the
> +     * ext bit, while leaving bits 56-59 alone. See InsertPAC().
> +     */
> +    if (param.mtx && !param.tbi) {
> +        ext_ptr = deposit64(ext_ptr, 60, 4, ext);
> +    }
>   
>       pac = pauth_computepac(env, ext_ptr, modifier, *key);
>   
> @@ -377,6 +384,11 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
>       if (param.tbi) {
>           ptr &= ~MAKE_64BIT_MASK(bot_bit, 55 - bot_bit + 1);
>           pac &= MAKE_64BIT_MASK(bot_bit, 54 - bot_bit + 1);
> +    } else if (param.mtx) {
> +        ptr &= ~(MAKE_64BIT_MASK(60, 4) |
> +                 MAKE_64BIT_MASK(bot_bit, 55 - bot_bit + 1));
> +        pac &= MAKE_64BIT_MASK(60, 4) |
> +               MAKE_64BIT_MASK(bot_bit, 54 - bot_bit + 1);
>       } else {
>           ptr &= MAKE_64BIT_MASK(0, bot_bit);
>           pac &= ~(MAKE_64BIT_MASK(55, 1) | MAKE_64BIT_MASK(0, bot_bit));

Looks ok, but I wonder if this function should be re-written using pauth_ptr_mask.

> @@ -424,6 +436,10 @@ static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
>       cmp_mask = MAKE_64BIT_MASK(bot_bit, top_bit - bot_bit);
>       cmp_mask &= ~MAKE_64BIT_MASK(55, 1);
>   
> +    if (param.mtx) {
> +        cmp_mask &= ~MAKE_64BIT_MASK(56, 4);
> +    }

Likewise.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

