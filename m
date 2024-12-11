Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8F6E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOyW-00086U-Ri; Wed, 11 Dec 2024 10:50:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLOyS-0007zG-66
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:50:04 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLOyP-0003Il-5W
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:50:02 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3eb7f3b1342so620563b6e.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733932199; x=1734536999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SyA7OvtkMMzmtzs/BVQ4bVImEXrar99JNoaOeAp3D3o=;
 b=I/9XIs/is+spzWXSDnRDCSp5XcUJXW6teLmN/nKQxBIMyYuL+5f6CZ7i2XBVSmofZe
 stnEOGwDMfufaK/bhedIs3JplxlOc1BPivcM2pD3xBb9AfDuPsNN8lyElRcRKFVyTYOe
 b1Uw7ttg+E+9Kk5wRf+aBwZ7YtBpWk1krkCyDSHnh1PBJBn+2P9Hb7ad5AFBw3lWDtjr
 ZmZZf3r7tdnx4Sxpzw5lnbg4now6MdMYPWLnRt3lPBzoFuNg/6Y37G0QWLnUerAilOe7
 v0rTA0vXhQ1lZsLqYJT2Xf+zTR4F8GYQ9Wz3bZZu2/Lxt3wNevbD9adA3cZ2m380SiIs
 uEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932199; x=1734536999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SyA7OvtkMMzmtzs/BVQ4bVImEXrar99JNoaOeAp3D3o=;
 b=R/4LumyVdTk+juPS5WCxFKAH3WsiU9osP3eRJFl1LkDrOqZN9P7idA8UmAHYWISSfl
 EWiAosdtI+ZXb5MIFbimU0jvAopF+IzvYVg/CAKa7/l14jxebS7xPup/0vxmjpH3saQC
 /0GnRNGj+2egcAi8zd/7dxWFZ7rQpVy52MDg5eS4aZsXC87EezqDcl/A0OeUkQ8ltv68
 Qs+F7Mt+vz3XjhEDE10EGcivRBIdli9LjE7sV5Pe67gyW69itKyJ1yjrxAQ0Rj+TQeJx
 XbBBhXbR/Stvf2sPUB2ViA3NMZ+DpG9D2AQdu0130eIVjpTol9I/O8QIUu7gKixpBM1T
 mLCA==
X-Gm-Message-State: AOJu0YwnPQr1qjS/Ek2dZ6rtBC5/BWIOEECVcbKv+HvEI+zLr5TZLeSQ
 sLzEGIAJLTK1El18ecW13WPzqKUIZ0hpWAqMFG7bqt45yu7vVIh6JVwOhqscrwCJ0s4Jkz4YqTA
 Ban70qwVc
X-Gm-Gg: ASbGncuajV4xVvwW52xo1rykia83XStzJGCKkcOgo52yPgF3O6Ih/5QDWXma6ldRxMv
 HV7Nhw2UC8IR2EUmCb4SpA7L6pFgTSermUvoEykFxI5s8s9PsKdKHy11RVfSBscF/fM4ZEImJnM
 4YR2LPPuzifpbdBcrfuvLiyT/xFXRErKkvNIuVYQCTq/Bwf+ok0b6/+CvRY6lWWZabMaYpRTwMU
 aMG8AxdDXeONDpEWaUlx9t0RqD2YnuNvNklh4SCrz1kA2TMFW9X1MD3IxgAE/anXKGFTnc=
X-Google-Smtp-Source: AGHT+IEBYh7UurpU9YtY8Xc4437DJqP8zNN0tcjiQo0CMIWDdkrFj6wYKC0PhvxqwW4TvH1AL3V8Mw==
X-Received: by 2002:a05:6808:1b0e:b0:3eb:6e47:2fe1 with SMTP id
 5614622812f47-3eb940d726amr36617b6e.33.1733932199686; 
 Wed, 11 Dec 2024 07:49:59 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb8be9ab58sm166584b6e.38.2024.12.11.07.49.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 07:49:59 -0800 (PST)
Message-ID: <df903976-8245-448d-84a6-0a968d6601c1@linaro.org>
Date: Wed, 11 Dec 2024 09:49:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] target/arm: Add decodetree entry for DSB nXS
 variant
To: qemu-devel@nongnu.org
References: <20241211144440.2700268-1-peter.maydell@linaro.org>
 <20241211144440.2700268-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241211144440.2700268-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 12/11/24 08:44, Peter Maydell wrote:
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
> The DSB nXS variant is always both a reads and writes request type.
> Ignore the domain field like we do in plain DSB and perform a full
> system barrier operation.
> 
> The DSB nXS variant is part of FEAT_XS made mandatory from Armv8.7.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> [PMM: added missing "UNDEF unless feature present" check]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      | 3 +++
>   target/arm/tcg/translate-a64.c | 9 +++++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index 331a8e180c0..c4f516abc18 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -245,6 +245,9 @@ WFIT            1101 0101 0000 0011 0001 0000 001 rd:5
>   
>   CLREX           1101 0101 0000 0011 0011 ---- 010 11111
>   DSB_DMB         1101 0101 0000 0011 0011 domain:2 types:2 10- 11111
> +# For the DSB nXS variant, types always equals MBReqTypes_All and we ignore the
> +# domain bits.
> +DSB_nXS         1101 0101 0000 0011 0011 -- 10 001 11111
>   ISB             1101 0101 0000 0011 0011 ---- 110 11111
>   SB              1101 0101 0000 0011 0011 0000 111 11111
>   
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index b2851ea5032..953386c0416 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -1959,6 +1959,15 @@ static bool trans_DSB_DMB(DisasContext *s, arg_DSB_DMB *a)
>       return true;
>   }
>   
> +static bool trans_DSB_nXS(DisasContext *s, arg_DSB_nXS *a)
> +{
> +    if (!dc_isar_feature(aa64_xs, s)) {
> +        return false;
> +    }
> +    tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
> +    return true;
> +}
> +
>   static bool trans_ISB(DisasContext *s, arg_ISB *a)
>   {
>       /*

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

