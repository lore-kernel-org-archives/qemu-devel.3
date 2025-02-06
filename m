Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956E4C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6US-0001xB-5U; Thu, 06 Feb 2025 13:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6UD-0001ck-Ls
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:20:31 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6U9-0007Ak-FE
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:20:23 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso9218295e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738866020; x=1739470820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ie2Aap8uDi4hXmhvL5POerHfWz13WhEE8katg3LkvQw=;
 b=KKPqI0OXeAxaGXqy1FPOd3mKGdZv7vYKGCMcJFI/2Zchld8KYe51H9FOL3WQuWHupT
 7TSLy+BHWYiyA02y0dRsgZMiS0WDrSmYB47B+Bs7Kkoy4NkJq4kB3aUqrobAxAo792Hv
 waZ1NL6/a2QEqiI4yxNl4bc4lWPWzoI5qXjP6De1SXJ8+3yGlKoobg59eRxzwvNBHwKN
 xHLaEPR1IUaD6PryRDg7bAT3hYLwXFr69pFlCxdAed+O6qBCdfzyBGoqXn5GrvXdQAn5
 VPoMPXmjWhEPM5tAM77khDDTxSykfjKgpiJGyod9h8zZ9cEXlM32N/gXPaOJ7mqRQF/o
 qILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866020; x=1739470820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ie2Aap8uDi4hXmhvL5POerHfWz13WhEE8katg3LkvQw=;
 b=e5sxQ5dtNmAOKDVpHOeNR/mMyukZe4z9wQBlnLt17gnGf7HGrXCoAHwi5ro9in6U1R
 mVxPcFKYZC8Xcqr33wdRX6S31W7sTNTqMMkp3e4b2PjNlFHyZZLot5bU+SIGbHVyjE/t
 +HA9nvWsaRk13afZfsuMYobd5rPxpKxctnXsLM9oPQDnKbZ/S9WaFCqC9cyONlBb3dEy
 aeYCsYvPM14LBKZkE3PR/DcDiz9Sko9KooAfFJFJLzRSGOhyBS4pd8pD5TtR2L1g+uQu
 6uWsmr/e09k8eAhPLryYyUVqXOfDTtdWHneZiP353aF5ePd/MEv7V4SD879CNxVdvXo5
 4Wkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkI9gfTtmSuh8fD3aRw+CLLuH9FyB0vYkz7EyVkDEaJjUYBoOqTN19kH7wiGDoXopgXNqf+Y4VH3ph@nongnu.org
X-Gm-Message-State: AOJu0YwPa9vrsxN03mk0LSP+EdkrMoCODkLs6+C65cKC8LaLBPKxW47s
 tmsc4boD7jVhw6dxTmtE9jBogNTcldPys6iHKGdptyIG128OKi1uZedkNh6PnT0KagCiADl01fG
 XvpI=
X-Gm-Gg: ASbGncsxu8sO3EVCEYlaEq2ZL1Eu5hzo4m0fu8CyL1RK/iWQNIIGMilV+HwNdMkpg+j
 1OXlp97+ElBxkZGNYzhsdHSxauMQQSxY18XmsT2b1mO5k1iKGzVKNZHPkQdUFRqNp2Q/PzTAn2K
 aeqh4eWVHb/OpWranNEN9tzcI+7U1+0Ww3al7bKyHycY5g8pTv1cgR2yPHtOscn5CtYi8m9pxJA
 yctP1dBKtS2DjNWtJlqT/7Mu5nk8pBXf6w87H7qtni0cAJHrksmptoRMFDrxZz4anP0KExKyC7e
 Yd/u4aCOMfbAodLLI3TIsI++Tch7U54sdhb98v1l459e1QE/Q4bEIz9Am6s=
X-Google-Smtp-Source: AGHT+IFoQ6X/qe+HWswQeusmkWcQcxaRDxwpNDVp4JdDI+fWD2GW/edSwm8t5Huv+l3u9vV3wSz7WQ==
X-Received: by 2002:a05:600c:4f47:b0:434:a367:2bd9 with SMTP id
 5b1f17b1804b1-4392499090cmr4526465e9.14.1738866019828; 
 Thu, 06 Feb 2025 10:20:19 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d96548bsm62453195e9.21.2025.02.06.10.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 10:20:19 -0800 (PST)
Message-ID: <8d49efff-dfaf-41d1-9bba-eade02c58f1e@linaro.org>
Date: Thu, 6 Feb 2025 19:20:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/tricore: Inline TARGET_LONG_BITS in
 decode_rr_logical_shift()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250206173258.36624-1-philmd@linaro.org>
 <7f6fc0ae-6cdd-4996-b411-762019efb003@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7f6fc0ae-6cdd-4996-b411-762019efb003@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 6/2/25 18:47, Richard Henderson wrote:
> On 2/6/25 09:32, Philippe Mathieu-Daudé wrote:
>> We only support 32-bit TriCore architecture.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/tricore/translate.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
>> index 6819b776686..c5b783b6a70 100644
>> --- a/target/tricore/translate.c
>> +++ b/target/tricore/translate.c
>> @@ -5936,7 +5936,7 @@ static void decode_rr_logical_shift(DisasContext 
>> *ctx)
>>           break;
>>       case OPC2_32_RR_CLO:
>>           tcg_gen_not_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
>> -        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], TARGET_LONG_BITS);
>> +        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], 32);
>>           break;
>>       case OPC2_32_RR_CLO_H:
>>           gen_helper_clo_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
>> @@ -5948,7 +5948,7 @@ static void decode_rr_logical_shift(DisasContext 
>> *ctx)
>>           gen_helper_cls_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
>>           break;
>>       case OPC2_32_RR_CLZ:
>> -        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], TARGET_LONG_BITS);
>> +        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], 32);
>>           break;
>>       case OPC2_32_RR_CLZ_H:
>>           gen_helper_clz_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
> 
> Leave it alone unless you swap /_tl/_i32/ ?

I was expecting something like that, fair enough :)


