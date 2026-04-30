Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B91FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIKMf-0007i5-RB; Thu, 30 Apr 2026 01:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIKMd-0007gG-He
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:55:07 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIKMb-0003Cq-LI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:55:07 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso3115805e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777528503; x=1778133303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VzNkBIqd5Dm/V2aBMvgTV/HLYvDmtDopQ/oXqfpmU7A=;
 b=DS2hdlfT4Xpfg1YWYI43S726YwD8IZ6o4r6uwqB6/Gb7a8P9SuWKTWUoKHc3dEKKmf
 +XMb5XVp2SuPiINbCUgOwVNaMo2dir9YHYGU2EfRKAHnFvltvC8Ud3kzil1gGpwJ5gzW
 V69VBX2WriiSFpvI7tDeWPGAPW2Vj8kbKm8mKEunvN45SxA7WaghVBYj+VocxKgD1wWw
 uB4LK6tfa1GX8pYaZZlbxWIG76G7X7GYGPtLSKHaXcoDKYU8JBe83siXnBjC1BpX4V/B
 CZID4sjhKUJfP5ek97XPeuYbL/HivaMN3uZ1j/BYnvH+EvMO6hqRSPdypEkXrjrBe4DP
 +qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777528503; x=1778133303;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VzNkBIqd5Dm/V2aBMvgTV/HLYvDmtDopQ/oXqfpmU7A=;
 b=piYIIEzFs1wsvd42c6VelSE3uqzjwidYbXKy78LBbtI0Jcw3gyQurzBr/4QaU14/yK
 d0y0uIDPzYD1BB6N1LPaLSJPY7sXi0x5084RUsrO9WEfJQ0KV3WObJEfgQQ57SWEoe1U
 JwUroSNZmTK3WMFZuthkbfbSpDt2ocPeY80TuzxI8hGbcHRLYRBDfQUwV7FgO9v/4FaU
 7ViBnKntv1aBe60qI7fP15xq24liaiN2zBsi03UO7lK8yWng2FdyA5GBTUbMcWAVooso
 pJ4EBM5JRGPPhHyD4NKvaAlrI4hjvxvJcvILSvVeqfuh77bTw36KpDJa7thRENFsa3ga
 gayQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FFResmlYlROTu2TSosGKcuc9kRshSL1bQTSEiwMDiJI1hpQFmfA7poh29EIGGlHh67dybANC8ZDM2@nongnu.org
X-Gm-Message-State: AOJu0Ywn9wmd8RieEv1OKZ8gpIRx7YWs1zfSuM7IeJxm/XWjWsrSkPab
 2oqPUkTgOW/8s6AZ8DcFcDfnxQMM5bm5mk+07GuOON4x4D1ou4Zfz1+9pMEcXA8BUcU=
X-Gm-Gg: AeBDiesD/2v01epcqAnVS9JoJuZxIZsNsY88jDomgj1p+dS/Tbyf6+Xx1hcdq7IGKVY
 VA4bid4zP+CeNvQ6As6BbyAZPyFCNSkse/0WanKAN9q7s1y7R6ycbtsdrr9WDL/Sl9uHDxd4307
 yWxR2J2lmHZu0aqjJJFVBMFpw8j9+NtreFwzaUz5bCKhZSmjBccohaZDN8llvxXmGBOpCI5JAO1
 HQSqz30xAY+bGTKdwHXS2YOiaIpmyvMg/xXLCAq1Y/9eglvGpqvrZFJoqTnF3ORaal/Ei1zoKVp
 JMFnwM80vQxMWBpLiNXtRQh1HkpezXE/AAkMp0v1wCqdZetb+A6xeu/GTRKXd5I2XUIauF0r6wr
 Pk7+EPUY4JH9kC/Fcowj6dXmKC+/RiGXQLd3thEASS2ELRDTZ9935kWQRA0rC57FlaCULcdv2DE
 hTcQi2PQVv1tLs4RF+uPhdaaS8rMO/9okj/XOG1+6311Ya7pgn6xiZMYnzT5Rt7nGw7GQFH8j8q
 Uz3
X-Received: by 2002:a05:600d:10:b0:489:1a65:dd6e with SMTP id
 5b1f17b1804b1-48a8444a2damr17928185e9.8.1777528502872; 
 Wed, 29 Apr 2026 22:55:02 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a820c8556sm40105095e9.4.2026.04.29.22.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:55:02 -0700 (PDT)
Message-ID: <d4bcf6ae-f5bb-41fc-941e-4d43d3cf9e88@linaro.org>
Date: Thu, 30 Apr 2026 07:55:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/40] fpu: Return struct from parts{64,128}_silence_nan
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 30/4/26 02:04, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c                | 10 +++++-----
>   fpu/softfloat-parts.c.inc      |  6 +++---
>   fpu/softfloat-specialize.c.inc | 20 ++++++++++++++------
>   3 files changed, 22 insertions(+), 14 deletions(-)


> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
> index dd65432813..2723bf5e61 100644
> --- a/fpu/softfloat-specialize.c.inc
> +++ b/fpu/softfloat-specialize.c.inc
> @@ -179,16 +179,24 @@ static uint64_t parts_silence_nan_frac(uint64_t frac, float_status *status)
>       return frac;
>   }
>   
> -static void parts64_silence_nan(FloatParts64 *p, float_status *status)
> +static FloatParts64 parts64_silence_nan(const FloatParts64 *p,
> +                                        float_status *status)
>   {
> -    p->frac = parts_silence_nan_frac(p->frac, status);
> -    p->cls = float_class_qnan;
> +    FloatParts64 r = *p;
> +
> +    r.frac = parts_silence_nan_frac(r.frac, status);
> +    r.cls = float_class_qnan;
> +    return r;
>   }
>   
> -static void parts128_silence_nan(FloatParts128 *p, float_status *status)
> +static FloatParts128 parts128_silence_nan(const FloatParts128 *p,
> +                                          float_status *status)
>   {
> -    p->frac_hi = parts_silence_nan_frac(p->frac_hi, status);
> -    p->cls = float_class_qnan;
> +    FloatParts128 r = *p;
> +
> +    r.frac_hi = parts_silence_nan_frac(r.frac_hi, status);
> +    r.cls = float_class_qnan;
> +    return r;
>   }

Why not use compound literal like the rest?

     static FloatParts64 parts64_silence_nan(const FloatParts64 *p,
                                             float_status *status)
     {
         return (FloatParts64) {
             .frac = parts_silence_nan_frac(p->frac, status),
             .cls = float_class_qnan,
         };
     }

     static FloatParts128 parts128_silence_nan(const FloatParts128 *p,
                                               float_status *status)
     {
         return (FloatParts128) {
             .frac_hi = parts_silence_nan_frac(p->frac_hi, status),
             .cls = float_class_qnan,
         };
     }


