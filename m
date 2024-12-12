Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2526E77183
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkaG-0006gD-Vg; Thu, 12 Dec 2024 09:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkaF-0006g4-UW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:54:32 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkaD-0007Re-Tw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:54:31 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3eb9ba53f90so152950b6e.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734015268; x=1734620068; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VRvUebOVmRg5c3TlOLC/mYPsu0kJTpaQzS8I0qhrzlU=;
 b=amdQTEM0LBYiZj2LwPwrayiPDiqtmMEBxN45vcCV0paKtqBXSNzzWxC+/uYV88Kkug
 xup9cbOlRFW3vgoOO7ApOruy7VD7vHsWvp2NMqyXB7GeG0vEU0NLeChbqc1184CkMOyR
 EBv9HV5NlfxxgqsI4HQS7gny84NWj7W8mABWLGmIoF/w95TLK36fa7JPWrfqkxuleS7m
 KPFd3Mc6PS0Wz7l4zCgNihOzDPDhYeOBBlui3N+Sc2CBuOffMXA+xxY7cqrOfr+nLCFd
 wQJ25HH7GueCvgAn+nqcyRCRltsMg/B0yjQTh92A2HxqBj0IS2MgKKDTKpaPxc1j5+Dh
 7HVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734015268; x=1734620068;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VRvUebOVmRg5c3TlOLC/mYPsu0kJTpaQzS8I0qhrzlU=;
 b=iFEbwaPXDB05c5DwuyTatZ04XDNv+f7CD2wvjModLUmFcdHTXbIC/SBC5AhMhgFkVl
 xCM6aXrumkAajZWoJy737n2BLawDvSwEt6vQNHHCs7SSqWNHMMrnAF6HNRIR49Jp5jLG
 izUDh7+vRoNeWXSD2+Qi0fCajAHz5nV66Gk+pbgxCdRLzW2pqyOHNae2MB+JvkKuHQ9c
 lHjHsb+nSOguQXu3a5opwmVOoaUV0CRLqaclcyChs9tHwIdh/Nt5ly0ZWyjUxO/Lvb5V
 8kA3siU1IYRzPUM+VKG7r4l1DYtKQ+ymzZhseRtRacmzQYrEsT1XGSpPivpzXAbG49Om
 WXAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmNb4PgrKrpHaf0nW7M0bHW6ty7ifolbZyisUmxscnCtOjp6tv9iodIAYi04gj2NvUCk5cUIHfCWys@nongnu.org
X-Gm-Message-State: AOJu0Ywx6+BNkQSV/tJu83yce2me2MmdoSUQBxwo6/6vDzrZi94+Pnxz
 NSy8mf7ZSbPIeKX6wMMUHs3VP9eSmUkxUgMmMLFmPbXMPRzEj6Xsrd2ZL2xGFwE=
X-Gm-Gg: ASbGncuW3fh3zv9eQ3boocjuH09v9y0hmj+gryL7JP9H7h9NKQM7MMB4VUqHSlsuqQ/
 v97hID8xe50Qq8ObfHlxVztBEUN8uJLQJ3+1re/fyvM3zaJLAdClYTlrFao+/loomRq2kyLrLqN
 /eggz8WoGcreEu7hyRAkl96I3OGuCsQbqR83jMqsjdoVAQFOj7jiio417/EA+Bnnip9n1uqGRJt
 O18pPsW1Ys2dRg7cs1LwXMFdKN9gjzACrUxQrA84OU5a3joN2ZUHFYG1e8zuFsV7ptLn4DsCKOc
 qeqUIYk67EaQIa58qvP+qrC4CRGG5U5xcFU=
X-Google-Smtp-Source: AGHT+IH6042u6hllbDDdpAKqolIxPv3pdKj8oTfz4jhDjAV8WE3DWLvqZIZkZZz3B7hVpxnn55Ys/Q==
X-Received: by 2002:a05:6808:1441:b0:3e6:63bb:ed4e with SMTP id
 5614622812f47-3eb85cbfdafmr2986417b6e.27.1734015266489; 
 Thu, 12 Dec 2024 06:54:26 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e2849c400sm490953a34.46.2024.12.12.06.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 06:54:26 -0800 (PST)
Message-ID: <30531a5b-3ab4-44a7-be9b-48edfa6dfa05@linaro.org>
Date: Thu, 12 Dec 2024 08:54:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/tcg: fix potential integer overflow in
 iwmmxt_macuw()
To: gerben@altlinux.org, philmd@linaro.org, andrew@openedhand.com,
 qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org, Denis Sergeev <zeff@altlinux.org>
References: <20241212142716.523980-1-gerben@altlinux.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212142716.523980-1-gerben@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

On 12/12/24 08:27, gerben@altlinux.org wrote:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> The function iwmmxt_macuw() could potentially cause an integer
> overflow when summing up four 32-bit multiplications.
> This occurs because the intermediate results may exceed the 32-bit
> range before being cast to uint64_t. The fix ensures each
> multiplication is explicitly cast to uint64_t prior to summation,
> preventing potential issues and ensuring correctness.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Sergeev <zeff@altlinux.org>
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>   target/arm/tcg/iwmmxt_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/iwmmxt_helper.c b/target/arm/tcg/iwmmxt_helper.c
> index 610b1b2103..19c709655e 100644
> --- a/target/arm/tcg/iwmmxt_helper.c
> +++ b/target/arm/tcg/iwmmxt_helper.c
> @@ -140,7 +140,7 @@ uint64_t HELPER(iwmmxt_macsw)(uint64_t a, uint64_t b)
>   
>   uint64_t HELPER(iwmmxt_macuw)(uint64_t a, uint64_t b)
>   {
> -#define MACU(SHR) ( \
> +#define MACU(SHR) (uint64_t)( \
>           (uint32_t) ((a >> SHR) & 0xffff) * \
>           (uint32_t) ((b >> SHR) & 0xffff))
>       return MACU(0) + MACU(16) + MACU(32) + MACU(48);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

