Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363A4C83F34
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 22:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uctBG-000058-AS; Fri, 18 Jul 2025 18:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucsee-0002OV-QF
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:30:13 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucseb-0004JX-K1
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:30:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-748feca4a61so1545411b3a.3
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752874202; x=1753479002; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SQQ5xIVD/yvCKQ3QdErieZqMSJu7Bnkl0YFpDSNRV7A=;
 b=aoCiVyjN0AoF3tBO9fo2BRz7FEF5PDLGjWhRpfqJyrdfQBsIBsxxypRxbgaXNB3EeX
 xoT4cX92GwiCY6WW96z10AUcytL1SRaeCcOEtJhbXSCq0NXIDEE3chImrR1VXMrH34sm
 xBzel+Isn87HqUvryzNCQV2b621WcE65SCQmA9xCpzzIahl5qHrXLWyMejSw7jEsVgmt
 uHtp3aDGNvGNuH7Hsos8Frsb0ou/KDaZWqDnxUZsBvfzFrxRcMXa1f1ev087DxL3J1t0
 oBpXHaXok6Ti1Ud6U1nO6Ndxi6xYRJiiDxHFHwMKRT9M0CC509coU3VrfxB/93aJ4nG6
 oQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752874202; x=1753479002;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SQQ5xIVD/yvCKQ3QdErieZqMSJu7Bnkl0YFpDSNRV7A=;
 b=DF5Vy5SenlhdcyUI1ZKvIF2DA7pxdFKLEqESrQZ5CGMjtXQLFuPz/JJd17Hr6syGbZ
 tD7I5cEdo4yR1a4kOmSw0G3ZEzZhOmCm0GmQ0MzQiGui/3eY8OyofSETXNbcqaRknaG9
 Os4suP3UMWvMKkm9ZjLsNXdsaNAd7LgDraX9qZHT6oSDLUfxflZvGZgDzfiORvQocwJk
 Rw8iVgbMW0fuJp8MNGKeNiUd5AlDvZ0SGKuCYHdCjOEIKIi0dP5zZ83rdKMa60TnfYfv
 vXWU9b0XyWGw6L77pgixcDUr8NRNstc+bUXI0N82mJul+tSqaeEZKU6w5h+5ZT3w8tMo
 aqiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnO71IZlYskCMwtr2bBZpQ1FeuFAhL6EQN+rMruTe+7E/Ko5Mtcf3x3WRcB0e49aTj5UtmSv8pY1/c@nongnu.org
X-Gm-Message-State: AOJu0YyOHkbYXyl+npczDDjL4Bl47nnVOJkYwY1fFSHPJf1va2Y0A2Iu
 QWXMu0C+TkoJ8h6/oeRUUQeRLxEjqwOW2GHKwgbS4/vwicxEjdpdFJLwd6U54jRGG4/R7JB3Vg8
 e8XlE
X-Gm-Gg: ASbGncvLUuf+vurOJvBmMWPHIQ1uIxH3gTd0j82+Ar1Tk/aUU6+IegYUVpWe4EovGB+
 VC1vPlm7sdY1k3ROToY/Bkf38UpLw13NRKBFSIe7g4P8u73Vtur3Se2uT79Dka7HGpDP9+Txd1z
 fXkawuDj57sGLIzYCXps20dMy7Bfxa9aNKMG7/pU3UjYKNW5G8PRgC09Fed/V2G9+dQJfU+Zv9T
 1JGVpKwZ8qce3+SXSZH7nmpf7JyEhkc1lZe6fw8Z4i9e83ZyL56qh+LZSZreqicu+XWAGO/Vjc3
 berbiNi2anNx+REmchuBffYNUsw+6DhuS7k39vbIghkuZ5S3JJuvBs9hYSMeXMwzN+MXSTiT8ZS
 qyZuE7XsfAuS0Ig3iGdJOZ+RzpXqbkcUkT18PZup+rg==
X-Google-Smtp-Source: AGHT+IEmVYJ/Cru7O04xlQ56pCxjA236cYlxQlQjy92VlYFTagCsW5ARRCIiOuIf9byO+puNHybJgQ==
X-Received: by 2002:a05:6a00:2350:b0:747:b04e:941a with SMTP id
 d2e1a72fcca58-7572427c3f1mr13923324b3a.17.1752874201616; 
 Fri, 18 Jul 2025 14:30:01 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cb67900fsm1760330b3a.101.2025.07.18.14.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 14:30:01 -0700 (PDT)
Message-ID: <6ff7f979-6112-4705-91b0-bfa7a9e25a14@linaro.org>
Date: Fri, 18 Jul 2025 14:29:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 01/10] target/arm: Add BFADD, BFSUB, BFMUL
 (unpredicated)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250718173032.2498900-1-peter.maydell@linaro.org>
 <20250718173032.2498900-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250718173032.2498900-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/18/25 10:30, Peter Maydell wrote:
> FEAT_SVE_B16B16 adds bfloat16 versions of the SVE floating point
> (unpredicated) instructions, which are encoded via sz==0b00.
> 
> Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper.h        | 3 +++
>   target/arm/tcg/translate-sve.c | 6 +++++-
>   target/arm/tcg/vec_helper.c    | 3 +++
>   3 files changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

