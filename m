Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B0AE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 20:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOjTP-0001qi-P0; Fri, 20 Dec 2024 15:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjTN-0001mS-N7
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:19:45 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjTK-0006qe-SK
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:19:45 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-725c86bbae7so2157944b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 12:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734725974; x=1735330774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RHoaYmC0BG9+XNhfUECsFEK6gs/6x5MMtJbCZtqeQUk=;
 b=CNZdj2S5IYZvFlp7ySF+3Li5v+WxKgOuy7Ct/mW2OB1Bzno/KAvanRXvQr2dO2BajI
 03oRnE4VXzc1PyEU44UTNlvgNfpC58rM1RBORq4eHTh0Cuu7WKaLoNJOUc56pHfVhHr6
 3c0yo0fWclmZ1dU7XtkHtfsugpDcmprSHDCma330Kbf/duQqzeDkHJe5duBI+CGr1z0g
 e66sPC6y/E3adK7USJdzUzP7emxnz5CIuz+X7MM0UcfkhqVvNbqy/BK/sBdj7C2lOwG4
 PN8dUV+tCmvfQBfowPhW81SBchDltKxgLtq7jC4aeFidULcPtJ24DqtIXD/cVnCsdUsm
 Zmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734725974; x=1735330774;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RHoaYmC0BG9+XNhfUECsFEK6gs/6x5MMtJbCZtqeQUk=;
 b=n51RE+czviWAJyXZz8NYq8I1Cy+3ZCXVgDn/z4G4IUN/ATBfF3rTqDLdIO/AdMq6Bc
 nIp6Aittp4uqRSfchQqQU9tkol7p1+TJhEesVl/OVMXVsYCbdq7JKFOreEGyH7OX5Dud
 U2YA1CB0FCTtPeUksMgvASvC4ityenUJGqJGrPbHHORSlRZbXtEfSgz9O5F3uXgD8CJZ
 iZpTpSPQH9Qw8adMCsRWx9G7LX0fwdjW+wHaqmbvmqoNDkrrlyI40ifvGPdWDOpyLxXD
 tPVEQO0QohXG8IEhHjWl/Lw9rcEF1wBSnkkHcZ/1/zVOLtvFrbyssNnXNzL4QC1PdJZS
 y/CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi7LXdWo6O0Wk75DD/xAQ/SqRVCc8Hi13cLChuWU5B5whNxp9cHR3i0KM9NLlorXxk6yp1/W/9jABe@nongnu.org
X-Gm-Message-State: AOJu0YzPT+dSeNo6vEfY2H8pWNHpKSKs67z3M8x8Li1YIlFGag15tVT9
 5w51n6R50AXDxtjN/ERXmsOKTUTZ5U9qYpovxi7ud9kSrHdneNnNLKguT9vHhbQ5cC5UntsfiEt
 v
X-Gm-Gg: ASbGncuIwQ4QNmd1djdSoY7YQ2Vqs2yRXhwfmnfymIaMGkV1fK2arFEJ72Pe66IjQuU
 +EG0IU0a+2OJuDEtcIJiNJoBVu8zez+7lqvTMzXmrhEv0jJ34ChkS/HODp36m06K99I5nWuy9EP
 fXjqmE183DNnDBDWN4Hh30vnyKW6EPiwzMxkNiasR6BABiHKXBAVMTOjfu7gpVmmphLcLEVykq0
 tvQo5y3qo/5loc8Te4nIc+uRUUO5K+cZGbC4WFMWb/EFth3xkb0jagE2x27oPHQlDTA0Q==
X-Google-Smtp-Source: AGHT+IEOCVeX+hBEvkxHNUBFCEV5DnnOUxaYaED1zlDXCaL7sLZXIcGMEn+MgFnKKqu3KleXSPojsw==
X-Received: by 2002:a05:6a00:3910:b0:725:e37d:cd35 with SMTP id
 d2e1a72fcca58-72abe060d9fmr6097610b3a.18.1734725974647; 
 Fri, 20 Dec 2024 12:19:34 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb50sm3515313b3a.90.2024.12.20.12.19.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 12:19:34 -0800 (PST)
Message-ID: <2b5bd986-9dd7-4957-bf18-9c4ce070280a@linaro.org>
Date: Fri, 20 Dec 2024 12:19:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 40/51] tcg/optimize: Canonicalize s_mask in fold_exts, 
 fold_sextract
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241220041104.53105-1-richard.henderson@linaro.org>
 <20241220041104.53105-41-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241220041104.53105-41-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 12/19/24 20:10, Richard Henderson wrote:
> Simply or'ing the an input s_mask with the mask implied by
> the sign extension operation may leave disconnected bits
> to the right.  Use smask_from_smask to canonicalize.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index d0a9ea1ee4..8735dc0c9c 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1827,6 +1827,7 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
>           g_assert_not_reached();
>       }
>       s_mask |= sign << 1;
> +    s_mask = smask_from_smask(s_mask);
>   
>       if (!type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
>           return true;
> @@ -2534,8 +2535,13 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
>       }
>   
>       s_mask_old = t1->s_mask;
> +    /*
> +     * Use the sign mask from the input, force the repetitons from
> +     * the sign extension operation, and canonicalize the result.
> +     */
>       s_mask = sextract64(s_mask_old, pos, len);
>       s_mask |= MAKE_64BIT_MASK(len, 64 - len);
> +    s_mask = smask_from_smask(s_mask);
>   
>       if (pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
>           return true;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


