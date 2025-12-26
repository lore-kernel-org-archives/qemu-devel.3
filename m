Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D6CE8FDA3
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 15:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ9bU-0001Tz-UX; Fri, 26 Dec 2025 10:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZ9bT-0001Tf-R2
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 10:19:43 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZ9bR-0004Hz-Eb
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 10:19:42 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso39548475e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 07:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766762380; x=1767367180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XwARbWuvKIDlSHgUwY6NGRbLAGYA93KBqDO97Dk+5HI=;
 b=nzwjWV0pI+dNmzACsM63ojWhDb8ikSeQnPHFZPbT5Z9s4RX6QhTr2PqUFvyEvRJlFp
 QheGzXN6QrhoLHd49zIqXKB/IIR5OsLQJrjf3iOPe7qkjgQLyfRdQy/HzZgeKWzRBT0e
 eR0C+FqbP8ribKzIlAUuwme80tysM90ZyEztOaZIgNtDng4tP0joKArKWIrUmXbXG0o8
 ULPECH1gPLznVPhPnJ7NOUG+LFE49JwlCOMmUOHD1P0PVAEHPhxwwGN52Qb0vHs/OHVJ
 OZxxOfllOaWs69lkYGjOjTTufMitKGneCBJFuh2urMsqxZo8N5AeISTxyUxNfFbDU3Kc
 uDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766762380; x=1767367180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XwARbWuvKIDlSHgUwY6NGRbLAGYA93KBqDO97Dk+5HI=;
 b=vntgmCMMuj0VhM8Gf0Uhq6a0z1HpvmJY7WYVcZpWezjr33PgESNg5FMxmPoxAKFVOI
 Po+A5QU5sW3NN8zHXzkccUENuy3BwJiagIy3wz2InRnAWBy2jHCpWlKI0n4tD/JS+B7Y
 VY3MHCaI5cmV9wq7NQS0751UWuYYJTkDnvgpvAbiWdNBS5y+dgALFC9NwDMh552Q1W+1
 hkKXNtbUo7pDZlU3walja17nZfW6mURT9Tb1BVKN6DihsyDGMHn9sU3OvBo0SgRDCnGc
 2CLhLmMgc9WbkYm9d6wpBSjJvJqMX1d+EffGzAnjc1yed4zYZCB0dJhRcNboqfrQx0nJ
 VFsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHrnqGvMtcMlKaTluVjOL6Z4jbhBgUu4rnV9lwAu8kQzfk8XQgtrizVnpOSNjRA4OLQlUdkAJDGAMb@nongnu.org
X-Gm-Message-State: AOJu0Ywxi/ObpFyc2jE3Bksy4kOxGCm2YSMJjkR0AKKzsY7iZVCdXsBb
 AZOCfXbSe1y0T2ktyNlKHc749GCbyPTy4JyU+vofJ9P1roZbDTKQdWSiDECZnAEPsws=
X-Gm-Gg: AY/fxX4P6g2/2iBdJPr6Id8umAqnxgUmYWIqTcnpQlzHPxRXP4o38psOr4vkyynd01k
 8q7atRnTB3nXUeyOFKKvVdL/t/8YaP72lzbW6GEn3Eieel2IoZZFl3U/MMRnaLoak89+WKqiFBp
 tyRqZG5XzicuYPRcJvuFQTeinZe5WFEhduLMVGJMYtnGP3ala9GBKGbkgn+sUFYioW6BcCCE140
 ZGh0+Du5QHKTSyi2tomtv9miCSyKkSO/MelQ+lncC466JuUvW6GOGVFWK8wDK/ZkIibtNPW31fU
 NsN3Ac1YQAwvvbvYgZJNzmjmoj+j6wtpwi29rNWHdKEML5eeI3jFIF57GlIFrUPXCjKw/6H9td+
 2xCnyWwMiNuEiiow2X8q6rTqFsMn0Wvi0+VkyS5xwbcWw8BJaku57eM7aM3dPBcBWEMn6NKh0o7
 UbFLp3esB0vhzS7LfAFJPLHsEGp46gnikQgNROsVu+ju8lOo+ZTBVNW3BIm5+YyA==
X-Google-Smtp-Source: AGHT+IGKisCz90SPTPbuKjPXqAHFRuPr4aWsVZnTgmmiWU09U9qH6VEkBRQrpCMSoGAVmj2/Lx5hJQ==
X-Received: by 2002:a05:6000:2303:b0:42f:f627:3a88 with SMTP id
 ffacd0b85a97d-4324e3ebfb0mr29942433f8f.4.1766762379694; 
 Fri, 26 Dec 2025 07:19:39 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830f3sm44636667f8f.22.2025.12.26.07.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Dec 2025 07:19:39 -0800 (PST)
Message-ID: <4f617585-87d5-4e01-8f36-38f68bbec9dc@linaro.org>
Date: Fri, 26 Dec 2025 16:19:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/tcg/vfp_helper: Fix incorrect bit field
 deposition in rsqrte_f64
Content-Language: en-US
To: Li-Hang Lin <lihang.lin@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20251226064225.791454-1-lihang.lin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251226064225.791454-1-lihang.lin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 26/12/25 07:42, Li-Hang Lin wrote:
> Fix an error in rsqrte_f64() where the sign bit was being
> placed incorrectly. Specifically, ensure f64_sign is deposited
> into bit 63.
> 
> Additionally, update the comments regarding the exponent (exp) bit
> width to reflect the correct double-precision specifications.
> 

Fixes: d719cbc7641 ("arm/helper.c: re-factor rsqrte and add rsqrte_f16")

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Li-Hang Lin <lihang.lin@gmail.com>
> ---
>   target/arm/tcg/vfp_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
> index e156e3774a..60188b2c7e 100644
> --- a/target/arm/tcg/vfp_helper.c
> +++ b/target/arm/tcg/vfp_helper.c
> @@ -1078,8 +1078,8 @@ float64 HELPER(rsqrte_f64)(float64 input, float_status *s)
>   
>       f64_frac = recip_sqrt_estimate(&f64_exp, 3068, f64_frac, false);
>   
> -    /* result = sign : result_exp<4:0> : estimate<7:0> : Zeros(44) */
> -    val = deposit64(0, 61, 1, f64_sign);
> +    /* result = sign : result_exp<10:0> : estimate<7:0> : Zeros(44) */
> +    val = deposit64(0, 63, 1, f64_sign);
>       val = deposit64(val, 52, 11, f64_exp);
>       val = deposit64(val, 44, 8, extract64(f64_frac, 52 - 8, 8));
>       return make_float64(val);


