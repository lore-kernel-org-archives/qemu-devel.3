Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E85FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcXz-00049N-Ng; Wed, 06 May 2026 09:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKcXw-00048R-Kh
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:44:16 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKcXs-0002BE-WE
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:44:15 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-65c364b893aso5614242d50.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075051; x=1778679851; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fI9JpdPlkioAZvqoyFS3ftYkVDPhNASi8259Q8zcpN4=;
 b=IGHK3FCnM/v1GzR+XNtloytiUpLqoUPULBGn60FVg9jNaqoOQkXhb6BMvSwXIEN7ny
 TUgxHFaLw9EV18J6bw1x8YahLYXzb2iRCpTsDpUP2KzvqbXUkQD6rzJePiBd6C6i54jk
 NaQe7hbO9AKWTelD5C3UsDH/rq2X6pjOnMSzVsdNQV5ceIA/d3NTghvtbswwImoYWIrY
 /c8/kbOpRrJj+KUIOYjEtZQ+iK9Yn6nDieuIc85P0tl0SKyc1cZXm3rK/RvftOajFbB/
 2sUKt1/3r9bGTxZoUMOoD9uxZO2uFIajHPm7pRn26GxhjMhymrI8PufilbqN6BojA3P0
 bpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075051; x=1778679851;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fI9JpdPlkioAZvqoyFS3ftYkVDPhNASi8259Q8zcpN4=;
 b=mi2X1R58dXdq+hQWKw1ob1LfOasqd/WVuRCSkzSNSaA6P6QSLlhhvxQhFIwWQAFOIy
 ziNJCQGG0YXE/UqblLRKfglNIR7XTKqLoVPDe20ivbcn9B2ouS8lukKijxMBLnvdNxeR
 rQKwKm7lzHxyg3pJc+SEVLD2DqFdFyxKkrDBbIwJ991woex9DIKMCFzqVx2mR/pu9S0U
 pflVq4kjDdaPphm5He8bKDtIDr17YxAmabzSxiUKqgD/Y2qXW8jm8NXBmVbuB3HMkJpZ
 tWW65+7C9nstUp7GiF4Jt3d8TMjYfrwRT96E6aDHszXclOeqYYeeABDNj+IlS+RNACH9
 8QRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uc0m1OCv6dzEPJlghKaNYUJ3NyBkKWPBsiBaVcCpnHqSP0kau/w8cLbwRbxxkcQt2zeDkoRN/WF+Y@nongnu.org
X-Gm-Message-State: AOJu0Yzt2QjSmrdbRQk3mo2LXmPNkko0MEaOBoMdOKepqiq+mTOxmirK
 seSQkqFEccNpEYI/nMRYsjim5kNLIfbOE7DlB11zs8t1db+r5zbsfN4BJYodfxU2PmA=
X-Gm-Gg: AeBDietl1CKS/6va6jwHSnhWf62nbYE6uCPsDwMfLIdRjfzV+8Gxs6+0dCyaQ2vvlFA
 7CWAgl0YLkOAmMrNakFqA0gsyju9D3o3f3SOKzuXhD/xROHIRmEB/HUv8pTFgY8KkXV+hK3xW13
 BRl9Ld3kNddJ1Nvh/HHxBD1ANK8ygGlwt6EBDShgbApAe737HnMm/JRNKFCvcVIAgPABFzQEm7M
 qJamca/ObvKOIHaiImxe3a2RpYe3oC3pCCoBJu9fql6R23FSBL4fOGSsT0llqrhWUfTHfVWSJsh
 fveCZcpxGX4NVONsKtqD/GUHirn3h7XuXZtJ3e//utKOWGJ+RuCH7yZyJXl/Kg5JQ0dlOwT+ONK
 nL3cWyMMQ8qjTxlJ5vxsglpCZAFtRKtHMRfw0TYy3rU7nc/oDSi65f1eRFFx69UBRUKYMr1fgyZ
 5/inPJMEt0uPUbHLBEputiJyC43DFTfCka5Ujltl6buqMRyPaFE4l1rgE5OZheCZC72evv+XjVQ
 SVwB6CaA54S7+2m0tyB
X-Received: by 2002:a05:690c:c189:b0:7ba:ee75:f119 with SMTP id
 00721157ae682-7bdf5dc7b82mr35430647b3.15.1778075050931; 
 Wed, 06 May 2026 06:44:10 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:5307:cd92:1ec8:e891?
 ([2600:381:c938:6375:5307:cd92:1ec8:e891])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7bd6683794dsm79926517b3.27.2026.05.06.06.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 06:44:10 -0700 (PDT)
Message-ID: <39d0700c-4185-4683-8249-1d014c579c59@linaro.org>
Date: Wed, 6 May 2026 08:44:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/15] target/arm: add canonical tag check, mtx helpers
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
 <20260504-feat-mte4-v5-7-232a648e63c6@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260504-feat-mte4-v5-7-232a648e63c6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb134.google.com
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

On 5/4/26 10:50, Gabriel Brookman wrote:
> Add a helper that checks whether mtx is active from MTEDESC and a
> helper that checks whether a tag matches the selector bit. These
> helpers will be used for the subsequent commits.
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
>   target/arm/internals.h | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 6df2c547c5..779eafabc8 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1629,6 +1629,12 @@ static inline uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
>       return deposit64(ptr, 56, 4, rtag);
>   }
>   
> +/* Return true if mtx bits mean that the access is canonically checked.  */
> +static inline bool mtx_check(uint32_t desc, int bit55)
> +{
> +    return (desc >> (R_MTEDESC_MTX_SHIFT + bit55)) & 1;
> +}

Unused, so belongs to some other patch.


Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> +
>   /* Return true if tbi or mtx bits mean that the access is tag checked.  */
>   static inline bool tbi_or_mtx_check(uint32_t desc, int bit55)
>   {
> @@ -1636,6 +1642,12 @@ static inline bool tbi_or_mtx_check(uint32_t desc, int bit55)
>       return desc & (mask << bit55);
>   }
>   
> +/* Return whether or not the second nibble of a VA matches bit 55.  */
> +static inline bool tag_is_canonical(int ptr_tag, int bit55)
> +{
> +    return ((ptr_tag + bit55) & 0xf) == 0;
> +}
> +
>   /* Return true if tcma bits mean that the access is unchecked.  */
>   static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
>   {
> @@ -1643,7 +1655,7 @@ static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
>        * We had extracted bit55 and ptr_tag for other reasons, so fold
>        * (ptr<59:55> == 00000 || ptr<59:55> == 11111) into a single test.
>        */
> -    bool match = ((ptr_tag + bit55) & 0xf) == 0;
> +    bool match = tag_is_canonical(ptr_tag, bit55);
>       bool tcma = (desc >> (R_MTEDESC_TCMA_SHIFT + bit55)) & 1;
>       return tcma && match;
>   }
> 


