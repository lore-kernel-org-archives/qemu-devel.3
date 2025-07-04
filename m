Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898A1C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 20:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXmdl-0007tO-Vr; Fri, 04 Jul 2025 16:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXmdf-0007t1-9N
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 16:04:03 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXmdc-0007WZ-DY
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 16:04:03 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6120049f09fso763814eaf.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 13:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751659437; x=1752264237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fjaLey0O/axm/Woq3tMpCDfp7eQbKZ9meHYum4psoRc=;
 b=FoUZpK43ApfwW/7/06I2Zms2LBtKM84Rh1lgd46KB41jfyVZqNyVvjQYnmG0aDUtfG
 iqDzP4us6IysJ64zYduVRCKnFWFls8c/ALiFtOhszWrPUwDZvBLQaBM7yEfhwkL5yNg8
 T60NxMT5NTdhdcYIisTQPVgbbdZy2jZgvkW8eg/CzLWN2ctj267JyeJhpcg3nAtmXUS6
 EOoUkw3HvEDFnyJf/MyKAbM7KLv/rq1NiXbdBZluUnS6F5S78G3Rlc9W9ktZMzPGzE0g
 u+8nPV9hEXEoaOZhWpI6ycoJcLgck+xvY3C7Q0gqOiGMUgqQOtjgT2qURQd34syVoeg0
 lBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751659437; x=1752264237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fjaLey0O/axm/Woq3tMpCDfp7eQbKZ9meHYum4psoRc=;
 b=ky9LfqA06UQp6MC0SizJQWeGCbnOviNk4g9WYOfgoA1TjzR9BA3tb9swQ+ot6Pc5BL
 wS23kr8jU7txC4mV+BUvR6R8wosOg1CNjVepabSL+tGypXsob7uWAE7iaF/oFTn+in3x
 d7uH5O90zDOam5QIswcP2fDmrAXWMNqDdxioYPa3XNpBZ/qccHQ9s2qQSsx5aOjktrXM
 R9Kh5Dxv6AspHn+2qxg1Mzg9zj82p93fJvn6Eh0QadXd+OFZtzEMaRo2SosTzhbjhUwL
 PrA+AwcemcmBh2lRVJUmD4NZtECgH1uSk92onsk0u8sYu2b957v23NFXl06tWMxWh1IV
 nzvg==
X-Gm-Message-State: AOJu0YzkKnjMlTnkfA78vDMfLC0uscye/0/5Dht/AsF85IDco2Dp14yU
 eIfScdBH+TujXz967SG0pzxTRPhD243XIGB80twNjyhu44Witc+XN2GdogcZTceBcKo=
X-Gm-Gg: ASbGncuNBcuY5lFo3j2ptu5VBdWRrHUQ2XFI8H+gQKSQ7DEskJ2oAQZAINV+e8xbydY
 In0AcHBM5Zv1SqWrvdxDVDWV8gK1EWmLn7MYKSgyribXxDyqi/5ADCtwSjKaHDYO9W4tPYaRSvT
 PMn+J2mUPINkPXhDySr+emr/vh1vAMoJB/elBJ8mTXsyZGhAClijGsmQUJCTMQRf9iGpg7JC7yW
 CLM/Y+qTLcPjKIX6N4VP8qa2UMzRkf4nH0Y6JWGB35Zi4HfzxilHViDrw3yFDUtyhLodTSftUTJ
 lu/wQURdo4nC0SMx9YdISgo1qSQhc5IAZty8yFLb34+aSsIo3VOHIQM/QAAi9vU2+Op9jWHEMAY
 Tak6W11vJCW4hKHw9pwpSLuCTICBCH9I+NWF1QVa7Cd68o4kHiWE=
X-Google-Smtp-Source: AGHT+IEAUCDxIrlOcf8uiOinAVcfgxQAglUxx92SLUZXZ1jWTZAhc722y0eD/AgiA5gSndi+oFNhDA==
X-Received: by 2002:a05:6820:2918:b0:611:63d2:d709 with SMTP id
 006d021491bc7-61392bbf039mr2597671eaf.6.1751659437464; 
 Fri, 04 Jul 2025 13:03:57 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e4ad926sm416953eaf.1.2025.07.04.13.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 13:03:57 -0700 (PDT)
Message-ID: <7d3a794b-68ee-4a90-a970-4287be8c86bd@linaro.org>
Date: Fri, 4 Jul 2025 14:03:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [WIP-for-10.1 v2 1/5] target/arm: Add the MECEn SCR_EL3 bit
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250704151431.1033520-1-gustavo.romero@linaro.org>
 <20250704151431.1033520-2-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250704151431.1033520-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

On 7/4/25 09:14, Gustavo Romero wrote:
> The MECEn bit in SCR_EL3 enables access to the EL2 MECID registers from
> EL2, so add it to the SCR mask list to use it later on.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   target/arm/cpu.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 302c24e232..8ce30ca857 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1683,6 +1683,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
>   #define SCR_TRNDR             (1ULL << 40)
>   #define SCR_ENTP2             (1ULL << 41)
>   #define SCR_GPF               (1ULL << 48)
> +#define SCR_MECEN             (1ULL << 49)
>   #define SCR_NSE               (1ULL << 62)
>   
>   /* Return the current FPSCR value.  */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

