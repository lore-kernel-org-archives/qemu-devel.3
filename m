Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA56CAC5BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 19:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1rVm-00045P-Bl; Thu, 25 Sep 2025 15:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1rVj-00042Y-7l
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 15:20:12 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1rVV-0005gl-Ib
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 15:20:08 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-77f605f22easo1252459b3a.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 12:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758827993; x=1759432793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s8YRoxuHX85uA3mGLtSauCk7RP3VWwFPGCJP4JBrhls=;
 b=erDYmA/522LJ8pLlx3nzVk8qNAg8QD/01mmxRxaJVQ17oadkERpJ8G+cho+sQG/Zs5
 a2erZgh6juh01By59ftBoK3ya7+g0TeElwODPflMP10hWzMdQzWcU3aeDS1nEV2KB0HP
 r7SBpHH9UQL+wBS1j96xXPWg7eIe7ZQr9NYR/l4kV5XWM0aStu8lKySCsgtROfvdiQtb
 BxN16omvYYxJa9ksweyRmU1eu0jz9rrdDdm79GA3qRkc3RQ7q41euPKyi/JDwbFhPgyW
 XPlq3cGwJn4NNeQsA3RRPtCy5IRce3HjLSFmxoD2qOxzLUB2D8mmQ2r6LX9BtUx3zY2J
 pcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758827993; x=1759432793;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s8YRoxuHX85uA3mGLtSauCk7RP3VWwFPGCJP4JBrhls=;
 b=dHuVSNd209fY9GpjDCEKjuBycWy5kZjm49x/25O9j++BtShGwOANcVJoS6uBfFw30k
 KmBbB6k3vWVboEyqLJAqiWCu8rvf44ej87fpdgEa6iXOP42JhmYByinietOQjK5O/g4v
 WHyogM0qRY4avBJApoSkZO1B91QSdqfg04SDnIzU/GIxxMsGd7B5EVcBJpDZNH/wyeVI
 1WZBQKQ7MQJSe3ulPn5sLpZlqf/jsoB7dXQHIkyvA3MWazebSnGyOmsbD3K+AkZvj8O8
 tEFJ8p46zHSF3cDNkLt/CymKS0ic6J9sbztrWu2rrkwl3bmbMuBXf/DwWJ1EcQsffMk2
 ea3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHFaWtAWiWWFdR3+FaU0pBYV4USBDItpu9kDKSeKUxLALZo6iQXDZbjhBPSlDjPKDfNIbhKdg/GN0I@nongnu.org
X-Gm-Message-State: AOJu0YxRDrWXpn6b6zwF9suvvRMaBEhTVB3TQh6qeIbhrsrSsmZoF8FQ
 H2WfGbfSsu9xg6Phom1CeRQiMbRln40Mqerm2r3Jhj9Xmp43axnwLM2ND3Xz8GgHQ8YV8UUYzZO
 51U4c
X-Gm-Gg: ASbGnct1dFQ6gzf1yNfU21XifGYhh9dNfEJQaUmyUUyrcjahdp5EC+tVdueoK8QL3hR
 sqEJxYka4T+QsFG53KuIsE5xch9iA0W/yDdKR3RP12Wo8NOJp/JERf7qn9M56ztItX03zhQa0Pb
 rrmyR93heutD8VQBAc4W6zgDaN7G/o0f72ggcsArYJY7TolhlrQi1driVfImv3beO2n48RnvAeK
 vpWJhXBSOFEXUnUi1xWa3kn2CdqRn1p0iZNB0SgfgFyYVUmTO8gzFkyMdDqP5BZ3DkpZf8vIvuy
 aG3KYk3uWLM3APLM6ni0zC5LYpJvo2LQmzElK0fjkUZJZUMuWaSJaZwOjvRpugdDCeNDFXs8k+2
 MX/KAqe4yRRx7LzdMqIioj7bLoLD5EdRIjAEJ
X-Google-Smtp-Source: AGHT+IE1OJCqkcN45FybII8oBIGuWAJjjwqHJmaFX9bdLgeewJVLY/9WVylsS21389QF1tN5FYyVFQ==
X-Received: by 2002:a05:6a20:7349:b0:2cb:5f15:ebf3 with SMTP id
 adf61e73a8af0-2e7d0daec75mr6195548637.44.1758827993217; 
 Thu, 25 Sep 2025 12:19:53 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78102c06981sm2543040b3a.72.2025.09.25.12.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 12:19:52 -0700 (PDT)
Message-ID: <922f7912-7255-4a36-a5f7-669dffc964e8@linaro.org>
Date: Thu, 25 Sep 2025 12:19:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Replace magic GIC values by proper definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250925032151.73250-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250925032151.73250-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 9/24/25 20:21, Philippe Mathieu-Daudé wrote:
> Prefer the FIELD_DP64() macro and self-describing GIC
> definitions over magic values.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c44294711f8..da8aa7b9d08 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5184,7 +5184,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
>       uint64_t pfr1 = GET_IDREG(&cpu->isar, ID_PFR1);
>   
>       if (env->gicv3state) {
> -        pfr1 |= 1 << 28;
> +        pfr1 = FIELD_DP64(pfr1, ID_PFR1, GIC, 1);
>       }
>       return pfr1;
>   }
> @@ -5195,7 +5195,7 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
>       uint64_t pfr0 = GET_IDREG(&cpu->isar, ID_AA64PFR0);
>   
>       if (env->gicv3state) {
> -        pfr0 |= 1 << 24;
> +        pfr0 = FIELD_DP64(pfr0, ID_AA64PFR0, GIC, 1);
>       }
>       return pfr0;
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

