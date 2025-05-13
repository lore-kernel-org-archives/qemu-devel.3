Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A0EC3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 22:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEya6-0006t8-Q2; Tue, 13 May 2025 18:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEya5-0006sr-Ca
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:58:37 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEya2-0003q6-LV
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:58:37 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7427a4def77so1762391b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 15:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747177097; x=1747781897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l7D8ike5Q5xecvrtoVTlNOY5Y4yLl093QboNct1bXIA=;
 b=X6tdRWk852OLMttO4EIowNgO574uICxyTVKR/O0ojPdk8Gcav4Yg8ufyScHIU18xrj
 U+SWcSEP2LT+lQ14+LDaulTFKd2d87SPY8m2pnwWf+VSD3MzwRl5ALzsLEe2a3hEUKAE
 ye+8LOdD06HgoRECcpd2AWr7QbuWGowVN2J4LdeBbnBN/GauDzHYVXU+yTLYUsNNXs03
 joeW5fRicQ2PkcY77chuzfaFsoU4SD3BgDOCvePAVo/stFieEKQ5PCM8eKWpLDukEY3/
 NlvV2W8z44Y3GmtKdoh94110dc5+tIwh5/325OYs8/mVssp7ksUzib+A3+A72v2qaprN
 O6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747177097; x=1747781897;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l7D8ike5Q5xecvrtoVTlNOY5Y4yLl093QboNct1bXIA=;
 b=Upo8cRw1QTvBdq46jQOkyfTAMz2H0ZS1XDzdHVmJ0UoB6sefqbIk2ARDSjnnbHVPIa
 5DiukROvEuFVPk6kg3izwJRAVymbEXVax5P9lrrQMk5yPGn8l1k9mhtZKmUzHruL4CPv
 xBFvADn4GfGD0IDZ/4eF7JZ+y1w3iEriwTYcv+owVAfXu2s4oLsg7ibxiDWA8w93ZTrz
 2vJS4n4EmZ7Cg3qkwyFneND1kmOkXfsUHKjle6NRNgnb+Fcqfm5BiHMQHcMSh8oAOxQV
 BQu92ViDJjvvK7bPvmO1Lp0wiJCmNvLraylgSQ692Yp93Zamwdpx3nxnDo3ASLZI+Oss
 dYMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG8gVLHBnfCinsoHm+z5ZaheKdrBDCEkA4Af6BY6kRqekJXOYHq67AhawWjTnJ1ClorkUQ+64OnNnV@nongnu.org
X-Gm-Message-State: AOJu0Yy3b1O0Ec3iXrBJYda8wCcxy13k4Ltrr4nzZuj/0JPsDw1Z0fKv
 SZ3zPKVXLck5Esm74XDkOnmXvGBqSIzvalXhlufleznxZC/debvp3vmTKAgtSTs=
X-Gm-Gg: ASbGncsc+J8jBW8TfTWzBfWbLT76nJUBBWcB5jOwceq3wqxU5rFXRAEBgJ9z5W51hkO
 ByuAjboz1endrOW1WcGpq9CX4rPNYU+qyB7mRQXL08WzrFdmIudHVm21e4HWLezqCmCKTz3CkvA
 yrWRUMO51CQ0oFL09jpB23XSygbqxBV5OoC4LkSnUyG21d9Ftqi4mbI3ysgh2rZjQ6Hn3UCBi8e
 YDcmTWYoniSZ1/eXO3GJsAFnsfU+HK+X6aPnR22V83sGQoLADzrp5ET6itTW7/tfbEYx2EIFZie
 piWt3iEA9CRPV5wo2F1ZGS2bFF5RpZm4GHFIcyTHDrnM+HlPa3DsA5sOw0gOTH4t
X-Google-Smtp-Source: AGHT+IEmNvTkqKUamDjoXzLW5r+0XcVEaRCx5jaYmTOnNfIT2CJPzmJTBSjU9J91CuxCP28rtKCEAg==
X-Received: by 2002:a05:6a00:2308:b0:73e:23bb:e750 with SMTP id
 d2e1a72fcca58-7428934c348mr1620622b3a.23.1747177097515; 
 Tue, 13 May 2025 15:58:17 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237739a62sm8319369b3a.71.2025.05.13.15.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 15:58:17 -0700 (PDT)
Message-ID: <6deffa70-2144-4aeb-a329-2d416be921b3@linaro.org>
Date: Tue, 13 May 2025 15:58:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/19] target/arm: Only link with zlib when TCG is enabled
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
 <20250513173928.77376-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250513173928.77376-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 5/13/25 10:39 AM, Philippe Mathieu-Daudé wrote:
> Since commit 538b764d341 ("target/arm: Move minor arithmetic
> helpers out of helper.c") we only use the zlib helpers under
> TCG.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/meson.build     | 1 -
>   target/arm/tcg/meson.build | 2 ++
>   2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


