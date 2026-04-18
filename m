Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F719F99C6D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 00:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDtPr-0002ww-KW; Fri, 17 Apr 2026 20:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDtPp-0002wl-Ee
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:20:05 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDtPn-0007sv-QF
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:20:05 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ad9a9be502so7692385ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 17:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776471602; x=1777076402; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d4gETXwlEu8qnFkIKGfCZA/xdnExSKlvepxaUdtFs0k=;
 b=CTcb4dpzoZhvwlyPM5rdl2Q8iS30NXHr8lkxSs+iUI3ZWyDD70pfMu4dK+HpQqUHpD
 8W/BSp3x0sFLybBDfuSBdBnp9BBUe/EjTBw76mApINYsbgzJ6t7TMAr9l7U8J6NOcedM
 cEax3CX15X1VQNk+GDiKsc6OY42fi896JU3H03rza66TwKI+WoCM3xAy8zkUm+DYgPzv
 QTm8OnJEPM8qa5PBf/m120rNwIwINGezVZqL70w/q9R37iZODzkJSG0jhkt9tUHhtSAf
 2mnq4/1xX4MFcAwQl1226MPXcNj7sLO2YhOQJ3Cj+2RblSirnFniDo+J961tViTAeJ0M
 vnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776471602; x=1777076402;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d4gETXwlEu8qnFkIKGfCZA/xdnExSKlvepxaUdtFs0k=;
 b=lxvZJbqDiZfD/NVtFJt3cx9yimHpfuGHqgHRZyjCtqFK8QL2ctg7Rs8A1ISBKZocYO
 tiO/uis3rXte30FbTcrhp/hMkz244FvmvM7zXeCZyTrCwJpQL9Gm4uC9pqVnTiOzi05v
 RPxNdvsJfnWGd3UMFGAd9bvhZrGd5rc3K4p3vfIE5CxUo/UFemuEfrR6kYY9/JzTpcYd
 mC4vjVSW2KzW6KJZuw/y4YCO1SadZYs/zHc4PV2ZHcFKA1gQxJJ7WUWAf3GE3D0C1HGI
 h2Yod9m64KtzN5+JQncXFImBAzX7l5HwNBUzXUw9KblDqAjDAYrqMQnUHDB1y4DEyJuT
 c0CQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oCC6oBa34JHL83eoVgIn6fnIbDwJOh5SgVYiOEXaaviG1jl/H+VLUV5kEnS8ymqKvGDwXn3RmgRNa@nongnu.org
X-Gm-Message-State: AOJu0YzgTgOTPZ2aXQWJN2YS2NYC112BEkngqbhR+ey/WysY2iFUZjnL
 BEhezczaFSF6rSwuOHa1l0qk3QB6rbM4eeerIGIL4g4uon8GKiYJcl2csUw5YWjnqBE=
X-Gm-Gg: AeBDieslNg2mJmX7dJFpTMNI43bAgu6LgSEj/3nfXpURjJRZb0kiQRxH6dRd0BoS/H5
 81ibXK3fJ8vMytqDXEOi04VzhJq7twPo0h+hYKUh5G9mS6JWNi91xL/0FJTkMq4qbjreUbA9o8l
 WVBVLHCf1c9nX4aA2MavBJxm36jB4O/xz0ErkIqfw0t3FMiLg/Zq8Xb/PaqhkwkkYMg1ydNFjhd
 FDt+r9dTf3y+YDsQ0NNFQ7DNz4fYeolC1X4S8ztUl1JBoDtRW9RjPx8X6b0sazJlvIVrKYi/9tA
 2fnC03GMo+JO1vRDSucXEB7ZSulyI2miqkrHQyTCd/R7+aaaSUuPDFhSiE45pXnVRD8mWAit0L6
 d3pEQPvrHs1E8uDmx0u2UiDHn4rk2lVj8d3KCMad9lW1dG29SLnZbmuFUeRGB+FoWc2freu2Jv/
 /Gzzs5B/ny7//a6xJswEhsb2WPZEDJwUU6S/Zsj6slKkHr/YYhf0AapKQtkmUHkPh27QOuSgeX8
 GNAMdamm/6OA8JrhYOeu/gbk7hwXNo84alw7nCE59o/DauHJsn9IEBciyPACdiGuA==
X-Received: by 2002:a17:902:b182:b0:2b2:4f43:b498 with SMTP id
 d9443c01a7336-2b5f9e94b72mr37158835ad.13.1776471602021; 
 Fri, 17 Apr 2026 17:20:02 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:742f:8dfc:5be0:dc23?
 (bg30dhzyct7sk57q2zln.ip6.superloop.au.
 [2401:d002:dc0f:2100:742f:8dfc:5be0:dc23])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff8d6sm29957315ad.1.2026.04.17.17.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 17:20:01 -0700 (PDT)
Message-ID: <108fd113-a8aa-4ad3-902a-0d956e0b9c1d@linaro.org>
Date: Sat, 18 Apr 2026 10:19:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] target/mips: Check alignment for microMIPS pre-R6
 LD/ST multiple
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260417035734.32334-1-philmd@linaro.org>
 <20260417035734.32334-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417035734.32334-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/17/26 13:57, Philippe Mathieu-Daudé wrote:
> Pre-REL6 microMIPS requires alignment while REL6 microMIPS does not.
> Use @default_tcg_memop_mask in gen_ldst_multiple(), it is set to
> MO_UNALN for REL6 but MO_ALIGN for pre-REL6.
> 
> Fixes: 3c824109da0 ("target-mips: microMIPS ASE support")
> Reported-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Good enough until making it explicit in a decodetree conversion.
> ---
>   target/mips/tcg/micromips_translate.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

