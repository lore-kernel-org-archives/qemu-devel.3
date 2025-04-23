Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC97DC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 19:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7fWQ-0004ZR-Gw; Wed, 23 Apr 2025 15:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7fWF-0004Wg-Gq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 15:12:28 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7fWA-0005PF-MC
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 15:12:25 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224171d6826so2426005ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745435537; x=1746040337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WSpaOewUGDfsmJ/JH2DEOD3bJQ8vU8Qu1u0PpJ4lyC4=;
 b=ys4ZXlt5O31pZTWNKGUpzZElLe0fTIJZo7F4zVmefrAsv1XBcYgJCYDzYLQJS6aMZZ
 NCb6KkPmloblyyBwqu3V29F59mOge9jfZ6YNZ6h9fGVN4GYhmV1CpWhQzx47Xzns9BtQ
 gemmrkc/FLKmu4H7FF/XyUIZD8dnbCfODBkRfZ50oHlvmvtsiwu43v6rk+T84mvP8NwY
 zd8kY9LtC2f/M4Uu/2ByLHn58H92/I0XfCmTvgcZ2APcOVOEcEJlE2cmUmee2W9c8wnQ
 GtCA9VpAabP9LMbT2OGPkXnJ3F3500y5N+u4BURXE+eDE8byiTePiXFrUuarGoncwMSH
 UTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745435537; x=1746040337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WSpaOewUGDfsmJ/JH2DEOD3bJQ8vU8Qu1u0PpJ4lyC4=;
 b=Yh9ZuRLgqHQlIuiUoU+mv2ZR53g1GLjOnoiKEkpqF/CIuYI8ECz9tM4a+AqCI12nvL
 /z6wZmMG5YSSC+x7x9pAjHmBjDCrPy4mp+dgZ6BxRa90VKM+2CaHRBT6WkjqUNuaWBZq
 Y7mWhh2RH76BOpfnGJhK1Lg1A3ViVJ11QOWFsdGGwbnG7AU+eXKuGo5S7qKp22pHolMa
 LJGqKAZDmaG7gdzgqLpdj4ENsFDv2F3dDjZmdWxvKzsiYLzsd6pVIItSSO8hnLBVwLDS
 tzU6HzZDoMT8I6zewtPlnkbLnfoPD9x+dKANUFCMqXN8td96aB809TwezvP0H1zMsYK0
 ZxMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhmhkM0ZuO8+Ohrc2QaovnEiHdy76VMtaxeQpOS4bwx5SzkP0/2UBZzFZotFjGpZ7DjWKXy3tnSEFX@nongnu.org
X-Gm-Message-State: AOJu0YxqpXlNfPWKoRJrRbgm+Evrep1zrOa4AE7BGfkcSAWcg/WYydH5
 daF7qcDIQd5GU+0f03LWBc6wCLBwb6cL6cDz/Pwjxhi1SRGTbbVovOU7v9Is8rI=
X-Gm-Gg: ASbGncuOGHmwRtCjXKW6gyDrQk5rHiDC0KYjq29TkVZGzADRyYUrARyX4IkanzUHuc2
 W+CB3xKHFMOTBTC42QXw+uCuFgwwLS0WA2/eSafOPXnSyBIDOVjY2QavB4/a6Onubec7MptIY9R
 HKLU3wspD60c5lU1e6LWsO1fJeWZ+aZEhDo5hnQ8fR4qYNzZxX4l4gjjiqlwelmNcNHI37nij+W
 LZQr09CLo2iiHOC5RiL+LerSBi+uK/e+Ss/Tbt9oMl/xP4VOcZ9CpZrykSP4stkNYCZOmZgyJOT
 /lqzeCYmHfyiwANP6S5n+VuvOHuhKwqCKqOQwLWJ2uu/8MWnovesq+a5+xTYW2VQpAZIX4pVJHN
 nPK1xds4=
X-Google-Smtp-Source: AGHT+IEnz1RJKHW8WQXzrLS23bdzAWEV6xOQ50rmhimfSNvQXASPIAGA4H15CN2Dt8C6F7lCoC/+Cw==
X-Received: by 2002:a17:902:f14c:b0:220:e1e6:4472 with SMTP id
 d9443c01a7336-22c5357f2f4mr229752595ad.13.1745435532627; 
 Wed, 23 Apr 2025 12:12:12 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eceb74sm107895415ad.166.2025.04.23.12.12.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 12:12:12 -0700 (PDT)
Message-ID: <6f2805ef-2fcd-4525-a7fd-cad59c64f38c@linaro.org>
Date: Wed, 23 Apr 2025 12:12:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 06/19] hw/arm: Filter machine types for
 qemu-system-arm/aarch64 binaries
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-7-philmd@linaro.org>
 <a4a65446-07b7-4048-993a-6d0d7848b163@linaro.org>
 <0d3d3209-4513-4366-a105-6b71aa9caa88@linaro.org>
 <1937ddb0-a87d-4a87-ac73-3be72ded0c55@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1937ddb0-a87d-4a87-ac73-3be72ded0c55@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/23/25 10:43, Pierrick Bouvier wrote:
>>>> +        .interfaces     = (InterfaceInfo[]) {
>>>> +            { TYPE_TARGET_ARM_MACHINE },
>>>> +            { TYPE_TARGET_AARCH64_MACHINE },
>>>> +            { },
>>>> +        },
>>>
>>> Don't replicate these anonymous arrays.
>>> You want common
>>>
>>> extern InterfaceInfo arm_aarch64_machine_interfaces[];
>>> extern InterfaceInfo aarch64_machine_interfaces[];
>>>
>>> to be shared by all.
>>
> 
> @Richard:
> Is it a concern regarding code maintenance, or potential impact on .data?

I was thinking of impact on .data, especially with so many.


r~

