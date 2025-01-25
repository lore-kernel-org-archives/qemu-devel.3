Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1E6C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbk9B-0001os-C3; Sat, 25 Jan 2025 12:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbk9A-0001oS-FF
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:40:40 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbk98-0007aX-R5
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:40:40 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2156e078563so44330895ad.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737826837; x=1738431637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zjcIffbyiZu2LNP/z0YXUsZZA15p/pO47tOL62BmJsM=;
 b=vUao0cl/g3SbnM0+bNbQzOjIez9RQ6xrEfYhuCR4oVg95WrutcWryWkYyqsbTAwV4v
 IuvX8ntaxMx02Eo6Il3xIhEAHiRnuQkYiSRhTH78+znQbuy2MJSo/bReZj4kOlfBPaiH
 Bu3N711pVnt6S/4lTbFYGZr09MQKJxBssY06kDhFzWntL6ED88HPyJBkzVIUuijMNS1W
 wq7qqdULUn8NxBC0fEGfuB4keuUrw9kwfV7a8F/4QGoKuMIOPU6vZB+QPDifU+D/0sr9
 eEff6zqpsZkrz2ePseSUGFtQ0pdtm/XjrRqFYyuC9DZiU3ARHLnOqkZGjwRoSH/V+YgJ
 Pc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737826837; x=1738431637;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zjcIffbyiZu2LNP/z0YXUsZZA15p/pO47tOL62BmJsM=;
 b=Hha1YCVjcjGf4JMsNu7QA15ZY5fkNaiH+MWsxsT2OJfcZ/6UfdGZAm0NgukBjfBgL8
 k10Z999gREMd2ZOr5J/2/IGz/95SWwlQWEyQO7M+zeeU69kvfy5E5/IwgfaFNFbJKK8T
 8mX67rQriIhaG6T9k2ra4W3EYrzXxyDZ3EjyTHpE7Y1K0VKIRoZnlZ6zx7TusXQdjYOX
 9R8rGcYxjC5CBltAcuRQkJC5dEj8a47v1/xRXtrniCqdtDofLySIqADn32wpng2cBvU3
 hDwFFeaLpC/VmdpTFX1L7/NetfOqcbetnO3Y3ixuahhj7kD8tKkqG0nMxNd0dv46s0Jx
 Z9gg==
X-Gm-Message-State: AOJu0YzioJhejIwCtv+eqlqvXtzwieU2eb15W7Knm4/9IHE5FhlStsfd
 SGwzqkgDSoWzRd7szZJAdRTCKGl0gCIFhTBMlJF/qVd29/3ycQSLASiNvh0sQtRjlNeJ0IeFCqz
 w
X-Gm-Gg: ASbGncvXmYpsc6Ym4MRSByn+7HIWnYfQlclA7p1YejYw+WLlJtz8pNktv8QyLPyoRNy
 SU4zDgf6IusuUEF8j+p7EC03x5JO75a7g6aR5n3EJpjDdWtxZhqG5BL30QCh+16FxvTQPgJftEe
 Hmuc86QvAs8T9N9acfTiSeZrwnp83wv8Git5v66Oi1zFZ2pkPURqHdAG1C7DcztnoIyiH62eoil
 U7BW+hnYVGzxVGbOc0gILN2ak8Mf4hSNDd2swrgWODD4pDEGrAxGG/SnOx1migZ5wGhXmjvuqQC
 WW5Hitw7qmcahob2wAdZJw==
X-Google-Smtp-Source: AGHT+IGif6e11G8q/eUzgbwWqVJCNk9AEnboVJ9Mj4XtOl3dW7QlXSj4fUqxnccXKJBOUsL1ghi2eQ==
X-Received: by 2002:a17:902:cecd:b0:216:6f1a:1c77 with SMTP id
 d9443c01a7336-21c355e8942mr573770025ad.43.1737826837263; 
 Sat, 25 Jan 2025 09:40:37 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414d9e9sm34619715ad.171.2025.01.25.09.40.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 09:40:36 -0800 (PST)
Message-ID: <600d07d3-500a-451c-80e4-5f98bd46c117@linaro.org>
Date: Sat, 25 Jan 2025 09:40:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/76] target/arm: Use FPST_FPCR_AH for FRECPE, FRECPS,
 FRECPX, FRSQRTE, FRSQRTS
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-34-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-34-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:27, Peter Maydell wrote:
> For the instructions FRECPE, FRECPS, FRECPX, FRSQRTE, FRSQRTS, use
> FPST_FPCR_AH or FPST_FPCR_AH_F16 when FPCR.AH is 1, so that they get
> the required behaviour changes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> select_fpst() is another function I'm not super happy wit hthe
> naming of, because again it should only be used for the subset
> of insns which have this particular behaviour, but the current
> name kind of implies more generality than that. Suggestions welcome.
> ---
>   target/arm/tcg/translate.h     |  13 ++++
>   target/arm/tcg/translate-a64.c | 119 +++++++++++++++++++++++++--------
>   target/arm/tcg/translate-sve.c |  30 ++++++---
>   3 files changed, 127 insertions(+), 35 deletions(-)
> 
> diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
> index d6edd8db76b..680ca52a181 100644
> --- a/target/arm/tcg/translate.h
> +++ b/target/arm/tcg/translate.h
> @@ -746,6 +746,19 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
>       return statusptr;
>   }
>   
> +/*
> + * Return the ARMFPStatusFlavour to use based on element size and
> + * whether FPCR.AH is set.
> + */
> +static inline ARMFPStatusFlavour select_fpst(DisasContext *s, MemOp esz)
> +{
> +    if (s->fpcr_ah) {
> +        return esz == MO_16 ? FPST_FPCR_AH_F16 : FPST_FPCR_AH;
> +    } else {
> +        return esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64;
> +    }
> +}
> +

translate-a64.h, I think.

Otherwise.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

