Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8D1D7833A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAF0-0005O6-Id; Mon, 02 Dec 2024 12:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAEy-0005Dl-RD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:29:44 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAEx-00018P-Bh
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:29:44 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ea55e95d0fso2202238b6e.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160582; x=1733765382; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xzdNKETfGbOeiqpi1FTlOQaAtdf3y+dbZP8wdUSxzlw=;
 b=nCRTr+Hl2BJmgT1XTL9jBhHJnj/Nb3+YHYp73dOCObdzIptxc9lYrCch97XzPr/IM7
 a8CKMd+GP+YSoBJB9QY1enpuI6YpvGzDU53j36dIMKZ/ZOGHPNBgb2LDkmwXlwGMxMnl
 +WINbIUFagObOiO5SOPggbbjiv+xXjCV/+OyrdsK8Dgg0vI8q4h03Zt98hPxO+R1/m4i
 N8bxfBwcUbxH7921fQkvlMwCHnhvVifMmecOJBS7YygpCUM0KW3uMIhktk3kTwPsAuyJ
 5H14qeXpU9Lko0MBVi8y+dGuXOISp/vh235lXEpflmY9iCgcWPF7GJAzDWfD1g9hSnnS
 ozmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160582; x=1733765382;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xzdNKETfGbOeiqpi1FTlOQaAtdf3y+dbZP8wdUSxzlw=;
 b=qj0MkEn4fI2P00V2/gB4ZcgOI1qVBKx86tuionvEJdxT6B0ae672LlB9t7aX5mnFzo
 iq2vU/1K3Sv4sCTHA6XVB7epe9nsxOqVOrpptTrf/95hlP16JyZFe+ht7dmQN9NjU/oI
 MSh1iZ4h1LF4Zkf4wWmrV3AWQTDTl4z0La8apmPS9ZqVtIZ0+ELhVIpjH5yFwKTy4NN0
 Wg/i4MHvWiFxIQW2hfrwxLlTWRVaYI7RhFHtuSA98k+nhCFBHp/HAOuqJhfLq8Q+nCLO
 mRqqE2zp6Y+E4ot7xZ5Gkij3jQUeFn5uvrz2iI9UCfAHyVGKPr6xf3pB6YxfQaLYQ7lW
 oPIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRPZ3WjIE9ewwcq6rJ0x0LrUCVH4HUQZo811LL7Pof0+RD0ZfklILx65FghzvALCuNWWGns/L5yGe4@nongnu.org
X-Gm-Message-State: AOJu0Yy7LLXhwEoVOF8pdadcq9cAVs3aSVB18qK15E7jA7x8hqzeWB8X
 ud07PvFIXOkzSZXIJxwvr1khR3t8L/a7DRlm6A62i2WkXV43BHAVf8cl/YRXS/E=
X-Gm-Gg: ASbGnctvN9lrCRzuccHs6kQD7V9pB8GtI2dF9giS78kK+FBhlk8zioCJ6tvPHf2WhgD
 HYRO8utPm/TRcZXiYd2soQJNtvEC6ACTf6rXKYtYrxvht3H04zA90BFHZJu+z4+DM0/abX3ttEv
 Hbruh6rwrpQ3C9n0oxnB8oH59WUUpfabKm426oMV60z4YyZPuNHO/1k9k6oF2D3dLxfazsHmzNG
 v77kCtVYw3VM0Fi9VyU7mQuh+MB0F1vpwFvxCmvarEKeSzRa/qMJBCmwOPVmGFeHR+NuQI=
X-Google-Smtp-Source: AGHT+IHDYOUpGpKxPXl6biI0D2rqAbNVUGpW+tZ+W8G2TX0Ws/og1sRkDByIU44HpDCVcdXHtisqMg==
X-Received: by 2002:a05:6808:2e9b:b0:3e9:2090:c030 with SMTP id
 5614622812f47-3ea6dc297a0mr19198026b6e.25.1733160582011; 
 Mon, 02 Dec 2024 09:29:42 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea8610196asm2363895b6e.29.2024.12.02.09.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:29:41 -0800 (PST)
Message-ID: <6ce27168-c0cb-4ff5-99aa-7635b93141df@linaro.org>
Date: Mon, 2 Dec 2024 11:29:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 41/54] target/loongarch: Set default NaN
 pattern explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-42-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-42-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:13, Peter Maydell wrote:
> Set the default NaN pattern explicitly for loongarch.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/loongarch/tcg/fpu_helper.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
> index aea5e0fe5e6..a83acf64b08 100644
> --- a/target/loongarch/tcg/fpu_helper.c
> +++ b/target/loongarch/tcg/fpu_helper.c
> @@ -38,6 +38,8 @@ void restore_fp_status(CPULoongArchState *env)
>        */
>       set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
>       set_float_3nan_prop_rule(float_3nan_prop_s_cab, &env->fp_status);
> +    /* Default NaN: sign bit clear, msb frac bit set */
> +    set_float_default_nan_pattern(0b01000000, &env->fp_status);
>   }
>   
>   int ieee_ex_to_loongarch(int xcpt)


