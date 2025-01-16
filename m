Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C71C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRhB-0002Qn-KU; Thu, 16 Jan 2025 10:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYRh9-0002QU-Ak
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:22:07 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYRh7-00060e-Ba
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:22:06 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21654fdd5daso18999245ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737040924; x=1737645724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=249OkPv8wccfOTfDDb+64dpBEQsJ0BUVMW+Lh4dFj5M=;
 b=Q64ziyrswrUchikw3kHiLU9+JRSDjfBpH7BoddMt5WD8cIIYab9leVEQ3g6Ip7xf5b
 QMtHqCDT/xJrZKB/jEsufeG2xXIP8B0dcphpaUnaiSo66SAzaOAiohiPJ2slfS/XC3Nq
 4tjQhGBa4XPI3YENBQt7CANUGBMq6qdav4GOD3Nk0d5HZooQ/TsaQoElYpsOtWGiVD/Y
 pi0WZ/H54ynEwNI/Rk+LR+bYdmm/F9km5PMlBjqDOXLfOhc5Egx+BCYcHYAxTBQKYR2f
 vJbfa3ojCT6y3Av5WjqCUwMEBr3hWlVY0n9FelnSTnNx0G9vdJRt5G9Y6c+6yHo5udcY
 IWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737040924; x=1737645724;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=249OkPv8wccfOTfDDb+64dpBEQsJ0BUVMW+Lh4dFj5M=;
 b=gOhHTvhNil43s6zYzqD8caVemAV9Nv9FZy7razAkq2AsqYlBXnWPJdA6jZFTMjCaSO
 WxP2wbruPK4WLoYVeF5ngvvkFOUsHWIh6+WFjKIZy+ovrnDGZSn8os0xUeXo2r/8mjbI
 /iM0q8jSS63BrhTNpAAE50vsg87fxP73wN8xFy5rDNWzxOYNqGkZybFImpIHKydvSY/b
 1fnPfOkuMnLkcmwcfI+60FNQNXgw689isBej7BFHYAr5/yg7c4FPPlrn3vWTJB1RHKtv
 iFePFtAXvkE3oKSm6YQd2xGUw2VkA0LQIC7WKVb7C1AwQjNxWskrhl8+MYjNKhkOs3FY
 omjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeqvVpDvWZzRlC5O+wsbO0nNx0VHaHKRjCSj+O+cpiyE88adETbX33DZdm78DKzRgUHWNSkcV8kWnm@nongnu.org
X-Gm-Message-State: AOJu0YyThZ3Si3VBwBIfvh4n4GCpiYELha+lIjyKI9P0NKEi1aiEtNEO
 Oh2fvoPc22Wfz/c3UEDcw7NuaUN1hxo0RsnZaXzrw38OlSC6AEzI/z3OISDICr8=
X-Gm-Gg: ASbGncsd1AneSy7NMeBtUtiduf4Yavu/7Tq9FyBEoyNGCSUgTiBrI3DSM7Tq7fLKU6+
 qDjpg48NHq/wXlt/oRwjB998KgB2z1Dpz79qpM9HBAl+rJdR/HUQtZHt30upN8Zl9DLnBqKBRJf
 1Ti3ytAptxAO1dCVoKo/sUINxafx59OzL/P9bBe1ux3ylcPnxR2OU6K8rCkp+lSYwGc6MIE+KyG
 5f4JRFilUmOPFyvpPo43ce6V7xjAAI5UxJiv82m+vMKnWHzK4Nduj8pJ8W258KjdDCnXN4uSwgc
 LSY1L6wdNKl32InzNstBPKA=
X-Google-Smtp-Source: AGHT+IFqfC9hedX1ADS5NDYX9E9OaZSohp0E3UqZX7LbmljlT7J4TK9sfxi2Zz0DpIR0t2OZ7ejhDQ==
X-Received: by 2002:a17:902:e885:b0:215:aae1:40f0 with SMTP id
 d9443c01a7336-21a83da6ebbmr584316935ad.0.1737040923628; 
 Thu, 16 Jan 2025 07:22:03 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3ac93bsm1620295ad.157.2025.01.16.07.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 07:22:03 -0800 (PST)
Message-ID: <7f645bf5-3d57-4803-a937-f8e558391e8d@linaro.org>
Date: Thu, 16 Jan 2025 07:22:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/i386: Do not raise Invalid for 0 * Inf + QNaN
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250116112536.4117889-1-peter.maydell@linaro.org>
 <20250116112536.4117889-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116112536.4117889-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/16/25 03:25, Peter Maydell wrote:
> In commit 8adcff4ae7 ("fpu: handle raising Invalid for infzero in
> pick_nan_muladd") we changed the handling of 0 * Inf + QNaN to always
> raise the Invalid exception regardless of target architecture.  (This
> was a change affecting hppa, i386, sh4 and tricore.) However, this
> was incorrect for i386, which documents in the SDM section 14.5.2
> that for the 0 * Inf + NaN case that it will only raise the Invalid
> exception when the input is an SNaN.  (This is permitted by the IEEE
> 754-2008 specification, which documents that whether we raise Invalid
> for 0 * Inf + QNaN is implementation defined.)
> 
> Adjust the softfloat pick_nan_muladd code to allow the target to
> suppress the raising of Invalid for the inf * zero + NaN case (as an
> extra flag orthogonal to its choice for when to use the default NaN),
> and enable that for x86.
> 
> We do not revert here the behaviour change for hppa, sh4 or tricore:
>   * The sh4 manual is clear that it should signal Invalid
>   * The tricore manual is a bit vague but doesn't say it shouldn't
>   * The hppa manual doesn't talk about fused multiply-add corner
>     cases at all
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 8adcff4ae7 (""fpu: handle raising Invalid for infzero in pick_nan_muladd")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/fpu/softfloat-types.h | 16 +++++++++++++---
>   target/i386/tcg/fpu_helper.c  |  5 ++++-
>   fpu/softfloat-parts.c.inc     |  5 +++--
>   3 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
> index 9d37cdfaa8e..c51b2a5b3de 100644
> --- a/include/fpu/softfloat-types.h
> +++ b/include/fpu/softfloat-types.h
> @@ -278,11 +278,21 @@ typedef enum __attribute__((__packed__)) {
>       /* No propagation rule specified */
>       float_infzeronan_none = 0,
>       /* Result is never the default NaN (so always the input NaN) */
> -    float_infzeronan_dnan_never,
> +    float_infzeronan_dnan_never = 1,
>       /* Result is always the default NaN */
> -    float_infzeronan_dnan_always,
> +    float_infzeronan_dnan_always = 2,
>       /* Result is the default NaN if the input NaN is quiet */
> -    float_infzeronan_dnan_if_qnan,
> +    float_infzeronan_dnan_if_qnan = 3,
> +    /*
> +     * Don't raise Invalid for 0 * Inf + NaN. Default is to raise.
> +     * IEEE 754-2008 section 7.2 makes it implementation defined whether
> +     * 0 * Inf + QNaN raises Invalid or not. Note that 0 * Inf + SNaN will
> +     * raise the Invalid flag for the SNaN anyway.
> +     *
> +     * This is a flag which can be ORed in with any of the above
> +     * DNaN behaviour options.
> +     */
> +    float_infzeronan_suppress_invalid = (1 << 7),

Why 128 and not 4?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

