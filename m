Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5E9FAD3E7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 03:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFkZ9-0006bB-Ko; Wed, 22 Apr 2026 23:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFkZ8-0006al-3H
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 23:17:22 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFkZ6-0001p1-Ao
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 23:17:21 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-50fc496c8baso13578181cf.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 20:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776914239; x=1777519039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q1iSZbPp4Noft/fcyHpWLwm2XYIFxyNCDUFwG0r5dQE=;
 b=OIeEd9nY5VRhA8sia5QrPTK7bN8eTDK04fGWWDptgEH2dkDMECSheQUc2LQQAih3KX
 Nr6tQv6Aj2GFNw0pLHRU3yyLHLFzzUfguk30Uzf+2RJzNVmDaeURs4AI8PahxD8ykxAX
 ZktKS3dhoTPCd38nzCS66v5I53S4IRCUkS4naj/IQGcdmZcyZquPw97oqNiX5RF96HxH
 pIrYem2oayev05ApJ2ZDP8eLx6LqYHhxHeIFpdLLvbHKaiELWhodQIIoMnjhiKVtP5V9
 lzqxaC969B4uPIVtxERSyvCuyU9BA0MLxGWlplW2UnQ5inAnDFIp/1Ly8jfaiyO6+vqi
 hkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776914239; x=1777519039;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q1iSZbPp4Noft/fcyHpWLwm2XYIFxyNCDUFwG0r5dQE=;
 b=Z0Zw9WZnsmiCpUpuUK6yWF1BMznovzRQw9Wvu2MdL5eUBRYHe6hCUf7M2piKhbuOtC
 pvQpOX4yKe399Bb3ikzO3PShJ9BtMvPriNdKWOkiY2HICZEQoxCgopHJsuCZZMWnu35q
 cinPosuRszha3rKyX74FFB9erdOF4AweWKhPfdWoOwGfMBWEFHvegtJMISa8ZMVvZyhi
 we5GSEt7D50AQ7Wn2Qfh8KY16msqjjITH5WyVVQ/eXLRMMDa6fwjYAAPjIRkJ1ER3tRX
 rKSFSFTleoWegm1vGzc8dEf/OffyNrl3JNDRI6h5bdgj3rgrIhkHKmguXveu5LxJfH0V
 BbSA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+y6UHcF8F4demei8Mcx1PPRHBRpp5+R2bkYvMd7ASWNsjBjEPYdxdULXzuqYZ8C4CJWimLh5rw1xka@nongnu.org
X-Gm-Message-State: AOJu0YyIcanOVxIRZSLROEaZ5sXKIDey9ChCzBergjB2Lg/L5HlwC61K
 5hL3lRTmYD0Dh1FpDLuHJPp44yIKktB/3M/6S1rSFNzC5mjPMnre3Bdb7aziIxXePcKYUy4sV54
 YJL+fNuQ=
X-Gm-Gg: AeBDietAYp8/SRjZfVX7rmeP/zcIqFafMvOU58mj4alcfKBLZ+O54xXx/m2bwAV4EWo
 V9KoVJsCOlFFBH5u9YNTIfn6OOPW0bAreEVT1ZyM1c5HgLbnXIFTzmfFkJtil7VINyAINJSogAW
 1OxMShVT3R5/FGFN+KXAGS6gVs0WrNaRvGWkWta2AyGvZm5/Z0McxJnEYzGEPUy80WIkCOJI37I
 RfVWJpEsNW54NRSny5lV+n+yjsM3+DB8Fp6AxIBvYbf+r6fTJUtuz6yeTi9hVTbVvqe778AdPci
 H94zoxvkncAv1Dy3V+SRqqJCjVqBZEirwZVxGnN5Df+hGwoRyZvtLR52DC1cMN6MgW5xTZYgtUV
 93x1Nd3xwY39MxitC/WOhvVwhGu3jIxziHs94XaYYnTvyeHm4sa+s6VWbIBEYzOsisAorrY2qHq
 JPg4ma1BqyI87+ZrtIp1q4aZcBZpp97voopPuzQjZjnzzjRSfsCDFfywGTmdO+oAJREmF9iS59X
 ui17uYX0T8wnkcrd40aeYoJ40gq
X-Received: by 2002:a05:622a:1dcb:b0:50d:9b2e:7ee3 with SMTP id
 d75a77b69052e-50e36c18fe5mr382643711cf.38.1776914238669; 
 Wed, 22 Apr 2026 20:17:18 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae797eesm144908676d6.34.2026.04.22.20.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 20:17:18 -0700 (PDT)
Message-ID: <aa013ba2-31ef-46d3-a97e-b272d43a8824@linaro.org>
Date: Thu, 23 Apr 2026 13:17:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] system/physmem: Use translate_for_debug() in
 cpu_memory_rw_debug()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-18-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417173105.1648172-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82d.google.com
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

On 4/18/26 03:31, Peter Maydell wrote:
> Currently cpu_memory_rw_debug() assumes page-granularity for translations,
> and it works in a loop where each iteration translates for the vaddr
> rounded down to a page boundary and then copies up to the end of the
> page boundary.
> 
> Rewrite it to use the new cpu_translate_for_debug(): we no longer want
> to round down the input address, and the boundary we copy up to is now
> determined by the lg_page_size it returns rather than being assumed
> to be page-sized.
> 
> This, together with the implementation of translate_for_debug for
> Arm targets, fixes the bug where semihosting would incorrectly
> fail to access parameter blocks that were in memory where the
> start of the 4K region they were in was inaccessible due to MPU
> region settings, even if the parameter block itself was readable.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3292
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   system/physmem.c | 38 ++++++++++++++++++++++++--------------
>   1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index f2d9a4ff8f..45c3a926cf 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -4036,28 +4036,38 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
>   int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>                           void *ptr, size_t len, bool is_write)
>   {
> -    hwaddr phys_addr;
> -    vaddr l, page;
>       uint8_t *buf = ptr;
>   
>       cpu_synchronize_state(cpu);
>       while (len > 0) {
>           int asidx;
> -        MemTxAttrs attrs;
> +        TranslateForDebugResult tres;
>           MemTxResult res;
> +        hwaddr blk_base, blk_size, l;
>   
> -        page = addr & TARGET_PAGE_MASK;
> -        phys_addr = cpu_get_phys_addr_attrs_debug(cpu, page, &attrs);
> -        asidx = cpu_asidx_from_attrs(cpu, attrs);
> -        /* if no physical page mapped, return an error */
> -        if (phys_addr == -1)
> +        if (!cpu_translate_for_debug(cpu, addr, &tres)) {
> +            /* Return error if no physical page mapped */
>               return -1;
> -        l = (page + TARGET_PAGE_SIZE) - addr;
> -        if (l > len)
> -            l = len;
> -        phys_addr += (addr & ~TARGET_PAGE_MASK);
> -        res = address_space_rw(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf,
> -                               l, is_write);
> +        }
> +        asidx = cpu_asidx_from_attrs(cpu, tres.attrs);
> +        /*
> +         * Clamp the amount we read to not go beyond a page even if
> +         * the CPU returned a larger lg_page_size, in case this access
> +         * is to a memory-mapped IO region.
> +         */
> +        tres.lg_page_size = MIN(tres.lg_page_size, TARGET_PAGE_BITS);
> +        /*
> +         * Find the length in bytes from tres.physaddr to the end of the
> +         * block whose size is 1 << tres.lg_page_size; we will access
> +         * that much in one go.
> +         */
> +        blk_size = 1ULL << tres.lg_page_size;
> +        blk_base = ROUND_DOWN(tres.physaddr, blk_size);
> +        l = blk_base + blk_size - tres.physaddr;
> +        l = MIN(l, len);
> +
> +        res = address_space_rw(cpu->cpu_ases[asidx].as, tres.physaddr,
> +                               tres.attrs, buf, l, is_write);

Doesn't address_space_rw handle both MMIO and RAM?

Seems to me the only thing you should be worried about here are the virtual address 
translation boundary.  So there should be no need to clamp lg_page_size to TARGET_PAGE_BITS.


r~

