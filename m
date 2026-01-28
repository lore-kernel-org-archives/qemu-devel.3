Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3410D35660
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 01:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkuSD-00064E-Ka; Tue, 27 Jan 2026 20:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkuRz-000620-B8
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 20:34:32 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkuRx-0007sX-GC
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 20:34:31 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2a79998d35aso40398085ad.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 17:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769564068; x=1770168868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xay8sXD9SIgbNMvf4vw0OcymSSRrLR0w4Xs1q3ENNoc=;
 b=sBO3m4sapRRjnPdYvpZw01qhsIUITwCjH1goB9Zcp56E66yKcnayy3RVgiaQ5zg7Nc
 Z1L6Fl8S2pCvG2IFHzsHS3e9oChlW3sP1ERyvV/ZzLngMDseZlN/8VI4Nt4UER3EEY6g
 3TFWmmxkYFlvZ9ryQDGHL4M0/zCNiALGDd1COcKH29Hi2xt3uuH1WdsRm+sV9WBZ7x94
 6jORV4Ys/kZd9NCG5MPlsNNKh3lZLJaQyjU3m+SzCCx4++zmyx0gEwue0d17R6bFePO9
 xWIIYl7/IrqHaeZZvdtr+FRzhMKO9kYhRtx52wSlUrnarWdcCqJWYGf/rdUWvxP0QXPd
 w33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769564068; x=1770168868;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xay8sXD9SIgbNMvf4vw0OcymSSRrLR0w4Xs1q3ENNoc=;
 b=tNy7XXpbs0KbpwhG4U8RGyz3DnLj5AZolEDuWeXsNI2dzxAVEmIzaBo9h+1FAxNx7l
 cow9UVN1h/yq+mgh6x4xEMwDF1lCEcres0tYXBVnzVBldsxKUGiaJ7bVJ+bK1pQgk/kx
 c7bVDCO6O02sWmrjSSsADole7gmEWTYb79WKPpaxNqgCgMVQ1WrHpRfUa0WT/rBhZdwq
 Z4t/CJtqWO+2f0hHHkjg2vndE4HHpnPXGr1ojZmNVccuTYwFG58W6jPqIIr/raGmrWIz
 QdZGxkZgm7cIFWmcMa/mU2D73WI9ClBSSPYJZWypI37NnCQbwU+Wyo0A+J6l6GGXNTdA
 AaIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyeti997+V7cCVM/71LS6zg5olRZwcHcrQliOiTEMsgy3+CYqZlR5rv2BK/7PKVYGTiM7v/sTgxYkW@nongnu.org
X-Gm-Message-State: AOJu0YyZNJA5VR6PGm5gyFcKMbvGMrzYPFbJKnM9MQPBy5iowUtTVfto
 hsXb8F6AzIEBe+s6QY+W3JAADcIRG/Mf3s2oSEAZ5WqQDJDTiThbpsP1xpKmvycmuVQ=
X-Gm-Gg: AZuq6aLmlx8HKH2E+KJsuqtLTl0r+2bOMVcpL3aaVh3p1E8rkz98tVbC16TslG4eLZ3
 63pIpvL3Qk85mnRtRKPQcCkak0vUH2tXJmtSlgas+0uCE8iHEu/IM7sBZ90zJSDlw6r4rXIr2YC
 IgjYD5Huv2++08A2g9rAjPuGIR4p6BTbUdSZiTD2bHE0JD9V1xGl93FMSmR6aY5iznwwgctXO9L
 sGzrmQBwyqV9WZTabpjvW/5gOPtFpYz2aV8ykjxszTqe459anyYuSSQozWWc2CZd5giZbLRUXM1
 Gew867JreqLm6Z/pcFl5UvQY6uqtMQz27RdpROyTtSJzM6aB/vmEtOxJQo2JaeCI+fyhq1eKMgo
 1F4kxmgilTmwvlMsSZnp/xaq6rtWMYsb8pLku9TVu5/g/ZvOY9uLxlyrxO811+QTy9xUSmLOYbt
 tzXfWPaRzMIL2JpgpDbGtt4gB5zCxi1w==
X-Received: by 2002:a17:903:198d:b0:2a7:bd4e:db87 with SMTP id
 d9443c01a7336-2a870dee111mr36586735ad.48.1769564067612; 
 Tue, 27 Jan 2026 17:34:27 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b6e4ac8sm5394345ad.87.2026.01.27.17.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 17:34:26 -0800 (PST)
Message-ID: <7cc87797-4cfb-4195-9a9d-21ddd355aa54@linaro.org>
Date: Wed, 28 Jan 2026 12:34:19 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] fpu/softfloat: Refactor IEEE format NaN
 classification to share code
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
 <20260127063723.442734-3-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260127063723.442734-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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

On 1/27/26 17:37, Max Chou wrote:
> The floatN_is_[quiet|signaling]_nan functions for IEEE formats
> (float16, bfloat16, float32, float64) contain duplicated logic that
> should be shared.
> This commit introduces internal helper functions:
> [float16|bfloat16|float32|float64]_is_snan_internal
> that determine if a NaN is signaling.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   fpu/softfloat-specialize.c.inc | 152 +++++++++++++++++----------------
>   1 file changed, 78 insertions(+), 74 deletions(-)
> 
> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
> index ba4fa08b7b..ce7315c996 100644
> --- a/fpu/softfloat-specialize.c.inc
> +++ b/fpu/softfloat-specialize.c.inc
> @@ -225,6 +225,22 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
>       bool z = status->floatx80_behaviour & floatx80_default_inf_int_bit_is_zero;
>       return packFloatx80(zSign, 0x7fff, z ? 0 : (1ULL << 63));
>   }
> +/*----------------------------------------------------------------------------
> +| Internal helper: Determine if float16 NaN is signaling.
> +*----------------------------------------------------------------------------*/
> +
> +static bool float16_is_snan_internal(float16 a, float_status *status)
> +{
> +    if (!float16_is_any_nan(a)) {
> +        return false;
> +    }
> +    if (no_signaling_nans(status)) {
> +        return false;
> +    }
> +    uint16_t frac = float16_val(a) & 0x3FF;
> +    bool frac_msb = (frac >> 9) & 1;
> +    return frac_msb == snan_bit_is_one(status);
> +}

I think the "internal" functions should already assume any_nan.

>   bool float16_is_quiet_nan(float16 a_, float_status *status)
>   {
> -    if (no_signaling_nans(status)) {
> -        return float16_is_any_nan(a_);
> -    } else {
> -        uint16_t a = float16_val(a_);
> -        if (snan_bit_is_one(status)) {
> -            return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
> -        } else {
> +    if (!float16_is_any_nan(a_)) {
> +        return false;
> +    }
> +    return !float16_is_snan_internal(a_, status);
> +}

Otherwise you're double-testing it in the quiet_nan tests.

Perhaps the intent would be clearer by naming them <type>_nan_is_snan.

Perhaps clearer to merge the expressions:

     return float16_is_any_nan(a) && !float16_nan_is_snan(a)
and
     return float16_is_any_nan(a) && float16_nan_is_snan(a)

for the is_quiet_nan and is_signaling_nan functions respectively?


r~

