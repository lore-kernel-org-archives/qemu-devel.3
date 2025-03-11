Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D63C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5CF-0004XE-0e; Tue, 11 Mar 2025 15:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts5CC-0004VD-B1
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:23:21 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts5CA-00033X-F7
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:23:19 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22334203781so3090645ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741720996; x=1742325796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bbDdvJ1FQFWRSNc9SLoHq/Q5wiQ0norFuqa4wHUfPKA=;
 b=kLWwGFCwc/JG8qQoC8c2EiEDstxMPYimmrQCtXMXINrRKJSoFC2l7HP3XVSRVosL7r
 1QZOiJIwq7yf72htlMczbWEI0IMDjl3Ehmm6xnxOf0grQI+peaWEqU/WgLgoUXF7rlzD
 18JOt3e0mkFIAWIe6nwFn8GazmGsAjmVv10L2endC/HG+byGxg/yhFEc3Hvr15WFv8qI
 F5bK5zZHYv3pvoZ+PvRTm53y8C0yQgZ0D0JaE3GineOBEhWjmSepJN7TZpmPYOJScBs8
 ifrgiQQ4/gr8mOkejawj7w+FSiqitq5vOeETM6YxlFII409GZWvPvSuidbFV3jPnhA6D
 bDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741720996; x=1742325796;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bbDdvJ1FQFWRSNc9SLoHq/Q5wiQ0norFuqa4wHUfPKA=;
 b=ZB9dyfo8U9tGwfEW9AiIkeKy/DDOV1KLoD7HJsLl75J/OyKAzVmKY9+LEt3UMZu1br
 3x/Uq6GCmgEnuMv+IXC3TMJNOfw4EoLoK5hvU7BVrM3q/wu89C7w+KDvkbAxe1yYPwHq
 unegA1STvi60F6WUJzSeiiwJ2HXWL8SXo9YywirEgWQJU7en0F7M5s8oWXu/nRXVwCQZ
 hDJPDLwL9zJjkRELkYFtX50RvLZ+MaHCHb/xNoDsCShCIukpTmK0UojfIlTqlwHL4l4E
 QENNt1x9W03nW5Cn1U4eUxAwSDDaPt9nyd1ksySgs+boQeHlBK+5bhRihimWO2TAUE2n
 JgJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuj9qKr0Gj49nhy1wNvwRRnaJpyatMFOlH9vsxA/wsE5WeCUGfIUwOiI8RO7iqf265Js/bmPoGkVfu@nongnu.org
X-Gm-Message-State: AOJu0YynCa0Ml8y1mpjtxks9WGbGS6kvEMlWnOMmTzNHqdUcsY7uQjPN
 JymBBc8+sdNTlc+0gUpxC2v7DgJvG7A7L0+CnyN3vIwUcU6Lwe52x1Em5+w8IRNK3iUxt3LDOmz
 D
X-Gm-Gg: ASbGncsPF7Dg3128F+58A31HbrpC1g4KShen7sOvHfhxGLTGdowPQxAb1Ns462sUt2r
 Jh39uOu1LCisnWTfgrmauxHwtHUY1dUDrjrQVh11DrV6Ta5FzQBSfHfkO91iccvlgfAlmxoBJkI
 p5MzqPj6Xn4D3Lv2/D/k8Ht8y8lsNVYteP8k19SQ3VX3L8W/DO/7O4xKpFqLB2ZRSHLsgxBOaAu
 QzpBd6Fgf8Wl8LOwWCGjPGyOgNWDhntuYkgx+bYNd2VCWhkTxeR+bqA7fl9UKHBA+D5YDHBMWal
 dsWwJ0/U5Q8jAvgw3QvLotBN21KzUCrSugRm/tpcTlKX8cfWJjhQ8X4o5lAykcv/6TUjSJ7vUMg
 Qdn0Ocp2U
X-Google-Smtp-Source: AGHT+IESecxDnyZb/jJaqliWyOnDnDTSV5K8l1i4lyB9JO3iYcrjaNgbAUAZdiV/KnTR8D2PfXbPAw==
X-Received: by 2002:a05:6a20:3d84:b0:1ee:d664:17a4 with SMTP id
 adf61e73a8af0-1f58d6a50f1mr5819462637.10.1741720996168; 
 Tue, 11 Mar 2025 12:23:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af51f16c59asm5079972a12.1.2025.03.11.12.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 12:23:15 -0700 (PDT)
Message-ID: <4bb2aaac-4f04-4f60-8e54-627891861318@linaro.org>
Date: Tue, 11 Mar 2025 12:23:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] exec/memory.h: make devend_memop "target
 defines" agnostic
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
 <20250311040838.3937136-6-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311040838.3937136-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/10/25 21:08, Pierrick Bouvier wrote:
> Will allow to make system/memory.c common later.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/memory.h | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index ff3a06e6ced..60c0fb6ccd4 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -3138,25 +3138,17 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
>   MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
>                                 uint8_t c, hwaddr len, MemTxAttrs attrs);
>   
> -#ifdef COMPILING_PER_TARGET
>   /* enum device_endian to MemOp.  */
>   static inline MemOp devend_memop(enum device_endian end)
>   {
>       QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
>                         DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
>   
> -#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
> -    /* Swap if non-host endianness or native (target) endianness */
> -    return (end == DEVICE_HOST_ENDIAN) ? 0 : MO_BSWAP;
> -#else
> -    const int non_host_endianness =
> -        DEVICE_LITTLE_ENDIAN ^ DEVICE_BIG_ENDIAN ^ DEVICE_HOST_ENDIAN;
> -
> -    /* In this case, native (target) endianness needs no swap.  */
> -    return (end == non_host_endianness) ? MO_BSWAP : 0;
> -#endif
> +    bool big_endian = (end == DEVICE_NATIVE_ENDIAN
> +                       ? target_words_bigendian()
> +                       : end == DEVICE_BIG_ENDIAN);
> +    return big_endian ? MO_BE : MO_LE;
>   }
> -#endif /* COMPILING_PER_TARGET */
>   
>   /*
>    * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,


