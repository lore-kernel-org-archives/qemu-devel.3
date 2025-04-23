Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1BCC369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Y02-0001bL-BU; Wed, 23 Apr 2025 07:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Xzb-0001KH-Dk
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:10:16 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XzW-0000oR-SN
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:10:13 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso3837920f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745406608; x=1746011408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LWz9gy6BGt+Il4OdXmpOZtOL72RyKjZFu5Xkxs4NXlQ=;
 b=Cjp/com4DnqgnrYTF93hwoBXoGvomrg00GbrojYUV1lCnWTlnt3wsKQm9VdW96mKEW
 Byurto0c5JHj17WqYYuqRTd/LNnRg0UIKOWSBmRQembPgt/6pyxnw5kGyLzRumGFgUQv
 +YNQ+pk41kdXL4vXTLL8yg5pCVxOaB4uwnGv62MhxKTTlk4Qq77oA5kPm50IkwFVLNIg
 NpIMeVOmbWFvyQQkUtVfNV310re5B8u3QuwqVcQ7OW9vaDGveLb49xEMlc+Kg3B1CoHy
 yifFTk7GLzexgLxMaALvcaxbmgT3aK/tiF0V+C3MLpywATa0I2ka9rIrj911dikVgaZR
 3sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745406608; x=1746011408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LWz9gy6BGt+Il4OdXmpOZtOL72RyKjZFu5Xkxs4NXlQ=;
 b=t+FsoHFMBay0j46f5gtgnYjXpcR6IAOHAhDZOyHFhsOUDJwDyunrg52cWNhWIF/Z4L
 UzLJhljizxfX1gUEjON7n8XPv/By/zqxB4D+A0CT9YTAO/xtwuPQioHitqNQekCzW5TR
 KUgLXzw8MNB3+t9H5FdtcR9VKA64vIZhDEWWSKWsK+T5ZuhL1onYZcDf0n8lhr29ZVdR
 hGf8oqzbDra1k2XlKjiRnh0NcxZqvgTdqRC4rnN3PM4GE9CVqOdw7RC2IrTp0S+YASFr
 Vr+1YKoGfoSYGTxqOko+lZTvcyXAZIpJhgGuid28ynt/zZCorjIk4919pf3bz0Lws/25
 n0OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVi7bwnm1ep8X1gjQb49WQIykDBje942w+SnCpwjhxXIIhw9oqQOi263oypoaTwESJFG/bNdTQSpSc@nongnu.org
X-Gm-Message-State: AOJu0YzQM33zAFDg9rckMNbKcKiFZOeMB99NFLmXkeYFrO0Jr6KEuzOS
 1xQih9TyQkuFV5WRZVorgOBdWi4V1EVSp/iXYf/X4WqI9OdgzDYUvqXBpqw/erc=
X-Gm-Gg: ASbGncsEbrW6oxdGT0VFhV9a51m507MWPMOIheztHGkYGrBIpNRdYS3pv1RU7EGiNwG
 x0bjbuLS68mVC45p8aiMvIPCyyyJRBSjV9jKe+5VUC/hY/5UaoPKAIXgok0Tkf76+prGBwECS6y
 3SAWnhgsoFD8lc8it5eY/JyQ41pWImfLe/Ra8IGeYsgIvavqXvBydyqWzk3/dz5cs0wkBIVdaMA
 IcHZpnfxp9zOvGOuxVL1vydu02XhLIFV3Tpc03Fr2ofZGqyZ3mFQjEUVcuA0S0H86TFwGVFxX0K
 5DNbSL6JllgOMxZeGWFnhEUNJqAjvjFU3DjCGJB8P7AYMEiI2tJAXaaepEoqYU78aFqac7kRyIk
 RUJvExyu5
X-Google-Smtp-Source: AGHT+IGtZ1UoPjts/76ebqsFQnGvcwZxYXSahLeORTTnSZr2aqbOTXea71J8vl6aRGS+Nu9T9bWjIw==
X-Received: by 2002:a5d:584e:0:b0:39c:140c:25e with SMTP id
 ffacd0b85a97d-39efba560b1mr14962145f8f.24.1745406608017; 
 Wed, 23 Apr 2025 04:10:08 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d35ba5sm21822375e9.26.2025.04.23.04.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 04:10:07 -0700 (PDT)
Message-ID: <c843aeff-cbf5-4ee0-ab8e-0508ab601b93@linaro.org>
Date: Wed, 23 Apr 2025 13:10:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 005/147] exec/memory.h: make devend_memop "target defines"
 agnostic
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 22/4/25 21:25, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Will allow to make system/memory.c common later.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250317183417.285700-6-pierrick.bouvier@linaro.org>
> ---
>   include/exec/memory.h | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index cc5915033c..577f473446 100644
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

Nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   
>   /*
>    * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,


