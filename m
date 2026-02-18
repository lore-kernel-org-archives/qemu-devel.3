Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793D5E9A04E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 22:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsq1m-000866-7t; Wed, 18 Feb 2026 17:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsq1l-00085q-IJ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 17:28:13 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsq1k-0000MB-0d
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 17:28:13 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c6e72d7a4d7so183496a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 14:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771453690; x=1772058490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YO8PrTtrKjvRZRvhKvQ2hIH/jfEAIWnMCRPDZR7xxWA=;
 b=CrE4BOrm22p7k7UhVFiLjX0zcgMFq/94DzOt3QqGswxg/KMAJGWIAFMvuPbVJGb4n1
 346lJaVCFiAJO75NyJujPESO+66sbnQbfuBmbx7RnBIGlurhehNzM+7ZyMgX8hhHtPq0
 Qdp2kWwR5KM7XrL+CmqcikCwAUnQWM0q2O4RpZyJ0O2TicitigJPMt/Uhk9Fuy1c7osl
 SuM04YnmmMmasAPveEgzAkRGz1ejzDY3ApNCO2/kkPcC4s0Fi9vvOOhSpwpYYVq1stX8
 PanG4Q+kdwmM9oITWOMWnkMjuMb5KIM5BVP/L0JZIYic6cCW//t3HzoqtIUucApfWuXN
 z0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771453690; x=1772058490;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YO8PrTtrKjvRZRvhKvQ2hIH/jfEAIWnMCRPDZR7xxWA=;
 b=j9H7x6UHAJkZ0CCPSVUmmfr8TzKaJAXJZ2QEtyn1jirF3E+hNi5ehR5ohLGdnPeBUP
 oGeJDPNOBviBOx9YFCvZ3pvaEjJMKGfCOKXDspmrEkeY5v8Bzal/cuqWHwCULvIrA7bh
 f0THIJBiBNKrB5iC98lh1XkauaknFNkvSLINlaRcvgtdv8VvX1TwhR0ZSg2NKHN+69vi
 e79LPMc29CZpE0EvVrMVTNztTQdTlXL/R2jBpBcJqRUunjwNQMOkVV2355NOO234WNJu
 qo6L9iR0PQltZKeMDrdjrDmtdCZ+uvTRBsV4txrgo+C4z0KDJnfzBBnXhVsZs3Lsx++L
 LWJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyCV6IolGYrbi+ZIEZF1DbvFW7TCgze3To88XYJwDIh9IRst+riHsAJ15LKLHkHQjYwFH1wcK4CKeq@nongnu.org
X-Gm-Message-State: AOJu0YxiWqe82bI95yBjzi1ZgxvYbbsjbxKFIIE5aDlfOQg0K78LeKmz
 127+M24rdr/nZTA41sckh4Sdve9/b3rf7g8xofWGG0yIPAGlFJJOucTNwFLd/tr5NqQ=
X-Gm-Gg: AZuq6aLIxtD1O6wuhHkVKkH+KkKaoIMx+46BTrAbbRbAnLRaa5KK9ACB+Di+qrriPUm
 oN0o5Vgius2Hs5XHC+5sRPzITLHugVu6ZS31wDWD2aHZT7/hGvQuq8ZpG7pLbpE+WTU2/0JO2o1
 TZLEDMmmzKlcC9iOzylcTRdAxqaCJUFl5iBJjtAukLuXmbX76VRdcU7a0fiFSBvB8BBReb9zuxH
 w3fi34NV1Uig/z6iQyG2dKsZZRcY3YPyv7RUzeJvuUTg11VKKPiaIZyQod9Wks5bxR+jX5pe43R
 aUMMG8l9mp+YoqNK1kRY/eQ9BtXjiLp/ibXUj+YpVl1tA7geXLgluOzYn6cTV3Xkk31qmqGFkSJ
 1AQ92+Prc4OeT4zTmK3d8YLCDK4O5IkeKKOz9cZ1/gE3iKvZ7U/5AY3hpWQ2YMcknvYY4wd/Ad1
 yf4JJAMEsqMIkxq3sw9VtUS541W4Orks856wQ8POWZnu1E438g6gWxSYiNe8l9jfWqWrzy
X-Received: by 2002:a17:90b:3ecc:b0:353:e91:9b2f with SMTP id
 98e67ed59e1d1-356a7aab90emr18594252a91.37.1771453690076; 
 Wed, 18 Feb 2026 14:28:10 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3567e9dff38sm22479371a91.7.2026.02.18.14.28.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 14:28:09 -0800 (PST)
Message-ID: <a5107790-fe4c-481a-b7d5-6c796c9a1a3a@linaro.org>
Date: Wed, 18 Feb 2026 14:28:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: Move TCG-specific code out of
 debug_helper.c
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260216160349.3079657-1-peter.maydell@linaro.org>
 <20260216160349.3079657-2-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260216160349.3079657-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

On 2/16/26 8:03 AM, Peter Maydell wrote:
> The target/arm/debug_helper.c file has some code which we need
> for non-TCG accelerators, but quite a lot which is guarded by
> a CONFIG_TCG ifdef. Move all this TCG-only code out to a
> new file target/arm/tcg/debug.c.
> 
> In particular all the code requiring access to the TCG
> helper function prototypes is in the moved code, so we can
> drop the use of tcg/helper.h from debug_helper.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/debug_helper.c                  | 769 ---------------------
>   target/arm/{debug_helper.c => tcg/debug.c} | 542 +--------------
>   target/arm/tcg/meson.build                 |   2 +
>   3 files changed, 3 insertions(+), 1310 deletions(-)
>   copy target/arm/{debug_helper.c => tcg/debug.c} (53%)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

