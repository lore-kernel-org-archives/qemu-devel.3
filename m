Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA80C197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 22:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnmCj-0001U0-MS; Thu, 27 Feb 2025 17:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnmCb-0001Pl-4i
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:18:00 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnmCY-0001u8-JM
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:17:55 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38f403edb4eso869797f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 14:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740694673; x=1741299473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4sKjcLdkKb9+zhMa6NSpWpTUO9KQKXAqbxieNXe6b8g=;
 b=w247L6dLOepqACZ8llNm0pPAzn1WJHy3fk1er7ju43To02pphh15hkQ9YeYi2UcXsC
 LAJs8tgcot+8db/Rh5y0CkHWxI5P4GsSPzBWwfT5e4tFjLLQtSXeqbCirLvoqw5/Lf4K
 clQ5eYQKjlh3h5rml8gXv6ozaq//7rRLCuArBoI18VQ/2F+Oz5sS0h+ecZcVDrhpxiVp
 sp3UHT8u8Sjh6IOm9U85uEF1n8lDsZw1Ao47BP4RxxV4SRCOrXB94BiADwrDEaYvlKVW
 Q6GVdebO6memMtCAYAWNTieOU4B6b0LCC+5u5pOjdpTxjfxWP1PPBHCDu5w+DrLScJD9
 dHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740694673; x=1741299473;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4sKjcLdkKb9+zhMa6NSpWpTUO9KQKXAqbxieNXe6b8g=;
 b=jIS97wEzwoz02+24o8p7G5HWa6CkbNbzWCHcrAedeBaWNJ7Sz4H5C+TotwSo82Yhq4
 T4FY2rLkRkVtIEFI75TJUhCdi2Lf+LujG2sFfR4j+QsclGSAOn2w55mMkFXndxnEHkXK
 T743HHgEezJEt0tG8BNrRcEiD0ajh/S6waYpcZ4N9a4iJ5lmAggjUiGvvJ9M193T4fyf
 FMP1vhwo8L0X2lvoD5jwenOMRIVIB+n7IWQgQlOGGEPuia7WEsnu8vd5hiaqORxjtbGJ
 30FMLpK2TdtustAXlRr7w6fJVBkVWaCGuBJp16ah3QPOPHsMPYHwpyEYlw69LOobfL+s
 Uzow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeHp3E7Q/wt9bFsSgURjdThCWdG7zafZw0X7M7aoyh2CLwa2rUpoFvWCHTkKJtHPCJkFnyWullerZa@nongnu.org
X-Gm-Message-State: AOJu0YyhsNuJN0Xgp8aBK9mH9uERz1wTakDCzlv5Nl9KfK4xgwxRemuK
 QpTI3P4iut6JD/wuPbvGTNDtc7FJ5gVQbRbRnE6PE5PD+HIDNdFpM7v8mVugK1g=
X-Gm-Gg: ASbGncuvl2IY/Wx60WR4v3jEePyPdjFwna/kwlvxbhvAY05G8WYahygBQ+7XvAl07RD
 25wS/+o8yHwtnB5YUyGYlnpjLWdpGw2ef2Tz4jmQDT4w8ejy/VirkEmhdPaWy7B49lJ1r2DcJEi
 YxbzFtFzfMQYKLztn9xWMf+WApPv4mHNoOiyJe6PfYNEHop5szlwTWP8kiTOei5qC3DfLgs62ry
 DSNVJtfnMhwyWQklHvm1EOCk/A8127kdAArGop0VPQ+9WVAcrk70jzOfVxJbIMdrM5KqtgVtfNd
 SWF6oRogai4lnMMsNftLrD5ABzbx+Wb+2SZRKDdXG9qhjuaH1uzqXzS12UuUcBTfP1fT+A==
X-Google-Smtp-Source: AGHT+IFueO4NxxUNr2OovEib1SXHH5KEmFHIJ0vHwZG+XM8yedL18/ZgbAF9ypSGviW5Dm368yEu2A==
X-Received: by 2002:a5d:5985:0:b0:390:eb32:3fc1 with SMTP id
 ffacd0b85a97d-390ec7d1e4bmr764063f8f.27.1740694672717; 
 Thu, 27 Feb 2025 14:17:52 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e484489esm3357524f8f.68.2025.02.27.14.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 14:17:52 -0800 (PST)
Message-ID: <b248a5be-d593-48b3-b94d-f1b99c72632b@linaro.org>
Date: Thu, 27 Feb 2025 23:17:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/arm/omap1: Convert information printfs to
 tracepoints
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250227170117.1726895-1-peter.maydell@linaro.org>
 <20250227170117.1726895-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250227170117.1726895-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 27/2/25 18:01, Peter Maydell wrote:
> The omap1 code uses raw printf() statements to print information
> about some events; convert these to tracepoints.
> 
> In particular, this will stop the functional test for the sx1
> from printing the not-very-helpful note
>   "omap_clkm_write: clocking scheme set to synchronous scalable"
> to the test's default.log.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c      | 27 ++++++++++++++-------------
>   hw/arm/trace-events |  7 +++++++
>   2 files changed, 21 insertions(+), 13 deletions(-)


> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 7790db780e0..70b137a6cfd 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -1,5 +1,12 @@
>   # See docs/devel/tracing.rst for syntax documentation.
>   
> +# omap1.c
> +omap1_clocking_scheme(const char *scheme) "omap1 CLKM: clocking scheme set to %s"
> +omap1_backlight(int output) "omap1 PWL: backlight now at %d/256"

omap1_pwl_...

> +omap1_buzz(int freq) "omap1 PWT: %dHz buzz on"
> +omap1_silence(void) "omap1 PWT: buzzer silenced"

omap1_pwt_...

> +omap1_led(const char *onoff) "omap1 LPG: LED is %s"

omap1_lpg_led

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


