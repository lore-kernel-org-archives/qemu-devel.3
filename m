Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA28D66BA1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVxQw-0002T3-JB; Wed, 17 Dec 2025 14:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVxQf-0002OY-8q
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:43:24 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVxQZ-0003NM-2L
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:43:18 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a0ac29fca1so40734275ad.2
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 11:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766000593; x=1766605393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sCbm130wfICCVEszSwMPZOU2ojZmV3lmpTjNYolO7qw=;
 b=B+cYVsCVKjeuOxi81ePJ38cJBRR/sNUDvx0C9h801nCpfZJA4g00NMta4PZmL1jGgd
 yBcGJsHDNvG5duaBs06rsAQ34hYhZMnXGa/CsAz8M1BfMe5JPGHXTFgQejSCYTT2zneQ
 31XzzfsfM4kbGOUVO1mRgrTjRG5Z/1TTGVwx0asGGX3b2NndzEX83Ih9LEUk3eQtaLp1
 3WrTh58MEz7/qPkXiFGaTN9HqmZ0cmyEvwqskrGcuoRlSlUtV4BI2UOdcLddWSh4kups
 YO1ovA5CsG/kMI2t9HelkRq5IjhO4w0Ef21PKXN8F9jDF515nSX0pLfCtG38xVR7MffO
 Yg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766000593; x=1766605393;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sCbm130wfICCVEszSwMPZOU2ojZmV3lmpTjNYolO7qw=;
 b=AFcKPK5UwoMH+RTL7xzS8eKXGwxxY0HIzyoo2ksjzIztwE2tw1KWOg5OPyRL4RoT+r
 sbOPdBogLiVvNfDrqgJnGIeLV1XNPJCrKeJiea8V2veOnWGtdbMNzU1g0YDDqS3Gs0sa
 ogtdD4l1Wun5PvjgZIMZRlDCmbnsozPvS31bOiOS4FOFwrPNo9hnb3CPgejCiG792GAp
 hcTl/CIrTRCYx3Q1MrZ1GZLj0He3Vq2zCvcNn2uJngi9vxEIEdugYwGoT6K4I52/nXTj
 550QaInuItZbFKYowlz9S95TL6u9fbCn3yaqg3VuKDit+tltdCHKzN/y7LSnKzssAHfY
 4ssQ==
X-Gm-Message-State: AOJu0YxGQsB6R7ywueNETcsv+M3fzsHA3Br+lhjI5mMQoO8CoEj08KoQ
 N82qi0fOviZ8i8Tz72sjQUQgp+/IOG8mIAe42gbTuBb6Bm/XQ20UTJSmoQbZ/LNieJDNKMh8a35
 X4WbGcj0=
X-Gm-Gg: AY/fxX5H02/HISo2KHC9jxwah3sgvPyv0FNylwX8ulXGc0cesODLMgzVatJa/zMd3pN
 2Bh9gNKYH3H9duj9tmKorsZtGeSsSKV0etzluw+3tRRUU56ysvH3bo0xJ75xYYH8r9L3hvb6jrS
 0iudcb9vEpTcHJuTTR5EMdghjrirhDW/hcvjV8T3b0D0luD4VOQqVxGz/DaWadHdmcErG0KWtBT
 dMxIA15CvnURBv306xSxQ1FPqDYf178DEVgdVTvlQWUxmCACw9tJq3PYWNHrRdkn94u/9SRtHgG
 NKJq+6p0ogc6xiqw3tlyh4CrZG99OUW/DoKxPpHOnzw4eMhdK1+GOlyOmzEWHjZUbb4C3+kpZbq
 t0u4u7ZeL+wrCWd9bk5wNWV5BdBpgkB9phnNxDXmoLtmKHvFHriDkyE/2htXdPh1TVjaKzpFvNE
 bs32QxHAhtGn1mEQQud9Xh6PrxBTuppg==
X-Google-Smtp-Source: AGHT+IFsOFWFKBl5g+WVWBAr9spntc9KDQ3683Q4tUSwZ9AC9jQDAG8N6SQ+ZW8ZGBOk1TnedDOuAg==
X-Received: by 2002:a17:903:11ce:b0:2a1:3e15:380e with SMTP id
 d9443c01a7336-2a13e153987mr66379645ad.34.1766000591958; 
 Wed, 17 Dec 2025 11:43:11 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d1926cecsm1140405ad.74.2025.12.17.11.43.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 11:43:11 -0800 (PST)
Message-ID: <3c671cc1-5472-4a68-ba98-888450a967ab@linaro.org>
Date: Thu, 18 Dec 2025 06:43:07 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] system/physmem: Use explicit endianness in
 subpage_ops::read/write()
To: qemu-devel@nongnu.org
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217143150.94463-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 12/18/25 01:31, Philippe Mathieu-Daudé wrote:
> Replace the ldn_p/stn_p() calls by their explicit endianness
> variants. Duplicate the MemoryRegionOps, replacing the single
> DEVICE_NATIVE_ENDIAN entry by a pair of LITTLE and BIG ones.
> Select the proper MemoryRegionOps in subpage_init().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/physmem.c | 81 ++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 64 insertions(+), 17 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 1292f49095f..d8465f085bd 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2896,8 +2896,8 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
>   static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
>                                     bool is_write, MemTxAttrs attrs);
>   
> -static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
> -                                unsigned len, MemTxAttrs attrs)
> +static MemTxResult subpage_read_le(void *opaque, hwaddr addr, uint64_t *data,
> +                                   unsigned len, MemTxAttrs attrs)
>   {
>       subpage_t *subpage = opaque;
>       uint8_t buf[8];
> @@ -2911,12 +2911,32 @@ static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
>       if (res) {
>           return res;
>       }
> -    *data = ldn_p(buf, len);
> +    *data = ldn_le_p(buf, len);
>       return MEMTX_OK;
>   }
>   
> -static MemTxResult subpage_write(void *opaque, hwaddr addr,
> -                                 uint64_t value, unsigned len, MemTxAttrs attrs)
> +static MemTxResult subpage_read_be(void *opaque, hwaddr addr, uint64_t *data,
> +                                   unsigned len, MemTxAttrs attrs)
> +{
> +    subpage_t *subpage = opaque;
> +    uint8_t buf[8];
> +    MemTxResult res;
> +
> +#if defined(DEBUG_SUBPAGE)
> +    printf("%s: subpage %p len %u addr " HWADDR_FMT_plx "\n", __func__,
> +           subpage, len, addr);
> +#endif

It would be worth converting these to trace points before replicating.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> +    res = flatview_read(subpage->fv, addr + subpage->base, attrs, buf, len);
> +    if (res) {
> +        return res;
> +    }
> +    *data = ldn_be_p(buf, len);
> +    return MEMTX_OK;
> +}
> +
> +static MemTxResult subpage_write_le(void *opaque, hwaddr addr,
> +                                    uint64_t value, unsigned len,
> +                                    MemTxAttrs attrs)
>   {
>       subpage_t *subpage = opaque;
>       uint8_t buf[8];
> @@ -2926,7 +2946,23 @@ static MemTxResult subpage_write(void *opaque, hwaddr addr,
>              " value %"PRIx64"\n",
>              __func__, subpage, len, addr, value);
>   #endif
> -    stn_p(buf, len, value);
> +    stn_le_p(buf, len, value);
> +    return flatview_write(subpage->fv, addr + subpage->base, attrs, buf, len);
> +}
> +
> +static MemTxResult subpage_write_be(void *opaque, hwaddr addr,
> +                                    uint64_t value, unsigned len,
> +                                    MemTxAttrs attrs)
> +{
> +    subpage_t *subpage = opaque;
> +    uint8_t buf[8];
> +
> +#if defined(DEBUG_SUBPAGE)
> +    printf("%s: subpage %p len %u addr " HWADDR_FMT_plx
> +           " value %"PRIx64"\n",
> +           __func__, subpage, len, addr, value);
> +#endif
> +    stn_be_p(buf, len, value);
>       return flatview_write(subpage->fv, addr + subpage->base, attrs, buf, len);
>   }
>   
> @@ -2944,15 +2980,26 @@ static bool subpage_accepts(void *opaque, hwaddr addr,
>                                    len, is_write, attrs);
>   }
>   
> -static const MemoryRegionOps subpage_ops = {
> -    .read_with_attrs = subpage_read,
> -    .write_with_attrs = subpage_write,
> -    .impl.min_access_size = 1,
> -    .impl.max_access_size = 8,
> -    .valid.min_access_size = 1,
> -    .valid.max_access_size = 8,
> -    .valid.accepts = subpage_accepts,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +static const MemoryRegionOps subpage_ops[2] = {
> +    [0 ... 1] = {
> +        .impl = {
> +            .min_access_size = 1,
> +            .max_access_size = 8,
> +        },
> +        .valid = {
> +            .min_access_size = 1,
> +            .max_access_size = 8,
> +            .accepts = subpage_accepts,
> +        },
> +    },
> +
> +    [0].endianness = DEVICE_LITTLE_ENDIAN,
> +    [0].read_with_attrs = subpage_read_le,
> +    [0].write_with_attrs = subpage_write_le,
> +
> +    [1].endianness = DEVICE_BIG_ENDIAN,
> +    [1].read_with_attrs = subpage_read_be,
> +    [1].write_with_attrs = subpage_write_be,
>   };
>   
>   static int subpage_register(subpage_t *mmio, uint32_t start, uint32_t end,
> @@ -2983,8 +3030,8 @@ static subpage_t *subpage_init(FlatView *fv, hwaddr base)
>       mmio = g_malloc0(sizeof(subpage_t) + TARGET_PAGE_SIZE * sizeof(uint16_t));
>       mmio->fv = fv;
>       mmio->base = base;
> -    memory_region_init_io(&mmio->iomem, NULL, &subpage_ops, mmio,
> -                          NULL, TARGET_PAGE_SIZE);
> +    memory_region_init_io(&mmio->iomem, NULL, &subpage_ops[target_big_endian()],
> +                          mmio, NULL, TARGET_PAGE_SIZE);
>       mmio->iomem.subpage = true;
>   #if defined(DEBUG_SUBPAGE)
>       printf("%s: %p base " HWADDR_FMT_plx " len %08x\n", __func__,


