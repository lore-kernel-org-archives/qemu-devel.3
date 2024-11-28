Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2732AD6910C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 13:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGeXD-0007n7-5n; Thu, 28 Nov 2024 08:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeX6-0007mB-CJ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:26:12 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeX0-0002Ew-7d
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:26:10 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-29737adb604so426020fac.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 05:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732800364; x=1733405164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=77b6evkQsMGCzAy1q3Bsxgf2tyj5Tagv4erAZvqqo5k=;
 b=j7yjIdlm5z9p/s1+/wuhYPaeXtgOlcKVuBk5BqxUvyXhjiTCde3nDwH3IlN6yv0yJo
 rf9VovxoPmqEIAwJm/C8YaShzW0cQX4tEz7eIPgAY4URHO/pAgCZ6oZYaMdkQpmn2uee
 JQ7H46vasTsRUvlJG5eVxtz/z81lBwHEJSffQxXX+X7CzYbUE8UpXn9rvldDYRKwFTnU
 vTui+b0lA91JRGR9p8gozqkjNhPwfF9ARwuEiaW5Z1A6CIa7S3/CNhcZ1To6Q9C7fwDC
 MlJcVe/cMpPBUb45K3U0IcKdm3HtpCHvneJubg0elk/V6sFY2dpLT/TqBDx5GaaWbHo0
 DTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732800364; x=1733405164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=77b6evkQsMGCzAy1q3Bsxgf2tyj5Tagv4erAZvqqo5k=;
 b=IdS4PK34kshGiJFWYf1qy5I+8tQy4+ix1dT/I9KQPi0NRjZF/7WvhbNKWS0iZ3Lfd8
 wztMC8tenCRC31qg/if+BoQV6VZnW9xO1OdQMdnmJyVJkszPa+tpuNlzJKD4xv+f5jIM
 yZR9dLnPuv/blV2RU8h2tFrdzlG9Hw5K0+7pnN/hhHTpsvxYKWncbOrY9UBpYHfipZlE
 9lNisVc7g7NgRcQWFWtljEn8+swKrem7n0BzSS6tPxQz0NaM6F625YlwvFx9EsjImrDz
 tG4lyvZ85qgzhuyx4MvhWgDSiSKYx9Mey0C63nYPkGMLc7tjdFT50S1pn7K/YOKbDruQ
 m0ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWKaEzW3W/Igemon6jo1lMccrocW327xQkvsAvIu7siCz2V7N4E5SyzZKzifQyQ8038m3tPKEb0mOF@nongnu.org
X-Gm-Message-State: AOJu0YybhMQZTQC9nIv4WPDv9gGMr/MI45clGmqFBy0HPXosp0VgWWrW
 PJUt+D44fzIwhGsFI+o4r84qsZe+cO9oyLhbYRUDTOXlzkmbCobRCxTftjs5kBU=
X-Gm-Gg: ASbGncunxTxxB58XNEoIiKz4nedBERX5P/ltmhhE9ZZmp+CsYIpykE9nf2hQpL/x3wY
 aIQR/NmJHk+G83FnDrZ54H8rb9wqxcjCUU1Ynywo5s8HDvWoG1zWqLv4VJrJdp0AbA5nAdccb54
 /SlpJiOVEYFLRMteCMZUMLG8BoZlxEHkc8gAugw6zCjsVDaJ2s+NqmcdRqUjloBJOmT5AYZbjny
 Fq9RlkY8/6XGloThClOO2Qi9j3pN65FUCCg+8uMxnebo6kYERJSDzDCyHQjo+vVl+Gymxg/5u1M
 lhW++2z8iSYfm9THvArSXfEksJtc
X-Google-Smtp-Source: AGHT+IF0oyf/Q6jqV9WZ3ZJCevjHHI/HTDzMXyFaE50tN/W0x6kyBC/iq1BXhu0wkt8dZCTFQ9a5lw==
X-Received: by 2002:a05:6870:2f15:b0:296:a1fc:91b5 with SMTP id
 586e51a60fabf-29dc3fa43b7mr6245953fac.8.1732800364205; 
 Thu, 28 Nov 2024 05:26:04 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29de8f31cefsm396693fac.2.2024.11.28.05.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 05:26:03 -0800 (PST)
Message-ID: <61327755-e626-4185-913d-bc6298a58482@linaro.org>
Date: Thu, 28 Nov 2024 07:26:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 03/25] softfloat: Allow runtime choice of inf * 0
 + NaN result
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

On 11/28/24 04:42, Peter Maydell wrote:
> +/*
> + * Rule for result of fused multiply-add 0 * Inf + NaN.
> + * This must be a NaN, but implementations differ on whether this
> + * is the input NaN or the default NaN.
> + *
> + * You don't need to set this if default_nan_mode is enabled.
> + * When not in default-NaN mode, it is an error for the target
> + * not to set the rule in float_status if it uses muladd, and we
> + * will assert if we need to handle an input NaN and no rule was
> + * selected.
> + */
> +typedef enum __attribute__((__packed__)) {
> +    /* No propagation rule specified */
> +    float_infzeronan_none = 0,
> +    /* Result is never the default NaN (so always the input NaN) */
> +    float_infzeronan_dnan_never = 0,

Both 0?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

