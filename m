Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F99E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 18:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQsNz-0001vv-RR; Thu, 26 Dec 2024 13:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQsNy-0001uo-B1
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 13:15:02 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQsNw-0008FI-Nm
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 13:15:02 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2efe25558ddso6042539a91.2
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 10:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735236899; x=1735841699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yZxcQV/uJ1VCGNHwpU/aUUMEKkIOqwamSiGVpPx0Y/k=;
 b=pCU9mGXJ9spjpnIomRX4h2RcdtL6PbCKYVIu1mSX7Pw3++OnR6dPP/xBmD7zZ2XqqB
 E9/GtKmwMUVS9fNPObi7AtHh/lvBMWxdWSlHPGBj82WrnyNIrU1bjV6f4ByTlrk9MYmi
 ewQ/iPYrGD2Tk9XLZDRvZPXaXvF3SQQGSkh1Q68tZ5aYtA1SjYde+RygfjU7Xt3QQjai
 Y+DPXi5TlEA9FOTDjvvZNXiuerjS0JC92rnJl6KN7nvgMrDsroOW9upNYevRXZogIW5j
 Cz4S47TydiCDuhcyMwQ5nLPxs2AboKfuXkK61xQb1lZcd8qzRqCflVPEur2ooMNI5M5u
 ggDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735236899; x=1735841699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yZxcQV/uJ1VCGNHwpU/aUUMEKkIOqwamSiGVpPx0Y/k=;
 b=aJwEpJO4qO5twE9odimrj2cpHQn6jv//im+2jW9CWmITJCERDZGsXry2fBHdmjuJut
 Sh2NhGZJNWNOiY1NIWjjJ83TdEWDbySCkK6VnY1CeZiw0EzzmVdeJI/QYM8sPPz8dGpL
 dYz7iIVJr0i45szTW3b3aVAZ2+kp9x9S2TYKkKjsMqQrCxTDWXy8jzwIwYT8c7Mx+QQJ
 XoS2MiJR38IYWnLGO8dqlQYMjUEpbR7A9IiCFaa/KVbKHr8scFvaAszKj+0Id+KnJpvp
 kUdJC/w6NP2LTa5GSuOKj6vzLOl/x3Me2eUkSMpHRrhu3OqXcxTrNsfWfzQBFz842nMu
 HPSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwFIXPJzyciTntulNRf4wuVF+DjBnNTwQ37ZJ7g/fDHGyv5mMiZCSkbMipSfYKzGZl6vIwYObZgh4j@nongnu.org
X-Gm-Message-State: AOJu0Ywl4syLQRza12PeiFY8Tuq4y6BoWsd4a1y6VjJJZQZmNFjB9xts
 J8uSN2iLCCqS8qdTM7f/WB0L7pQd6lpNEtZFBI5IVsVV7RD5ysRXnxsl1QlO2DQ=
X-Gm-Gg: ASbGncuiD/5CXAbcY/BLMxOSJsYAEZ9JVAma39nGwEOx3C2ArksuAwdk5IMgq5THEAs
 lre+hw3XATRgTylo6plf/x7/1h+kBj0r+67cqVTfjEr9AY3cs9Fbo+V6/TCHH41VjGFhdjTQCvz
 V8wPLrTRcVbHlWoR7/WziNVSNMiMYFe9YQGTajZsVnE0qNySspbus6+7G2XNMGbL5wJlSlzaee2
 ABG7NIGjYBIiTbP4q1jwDDDWPf/j1QAeHph54tsEmDL4Gc2hJSqrNyc5w5L4q7SSIC7HTN0M7k9
 UQbywJvvF3/D1jC1Vzi/MS5jE2xA1VoPpmaQrJg=
X-Google-Smtp-Source: AGHT+IE4NV355kxmdyl3W20w1UAz82/8btfdOsJZ4ymXHc5Qse3T84cj1kcN7Q3y2/at1jcERpLLeg==
X-Received: by 2002:a17:90b:53c7:b0:2ee:b2e6:4275 with SMTP id
 98e67ed59e1d1-2f452ee7147mr30001370a91.26.1735236898755; 
 Thu, 26 Dec 2024 10:14:58 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ed644846sm17755604a91.28.2024.12.26.10.14.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 10:14:58 -0800 (PST)
Message-ID: <e6843d5d-4b49-4737-b950-650cefa034e3@linaro.org>
Date: Thu, 26 Dec 2024 10:14:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw: cast 1 to 1ULL
To: Tigran Sogomonian <tsogomonian@astralinux.ru>, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
References: <20241226095815.15377-1-tsogomonian@astralinux.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241226095815.15377-1-tsogomonian@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 12/26/24 01:58, Tigran Sogomonian wrote:
> To prevent integer overflow it is worth casting 1 to 1ULL.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Tigran Sogomonian <tsogomonian@astralinux.ru>
> ---
>   hw/misc/mps2-fpgaio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
> index d07568248d..297cb1b602 100644
> --- a/hw/misc/mps2-fpgaio.c
> +++ b/hw/misc/mps2-fpgaio.c
> @@ -198,7 +198,7 @@ static void mps2_fpgaio_write(void *opaque, hwaddr offset, uint64_t value,
>   
>               s->led0 = value & MAKE_64BIT_MASK(0, s->num_leds);
>               for (i = 0; i < s->num_leds; i++) {
> -                led_set_state(s->led[i], value & (1 << i));
> +                led_set_state(s->led[i], value & (1ULL << i));
>               }
>           }
>           break;

s->num_leds is bounded by MPS2FPGAIO_MAX_LEDS, which is 32.
There is no possible integer overflow here.

Please give more than a cursory look at the code.


r~

