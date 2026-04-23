Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E22FAD3E7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 03:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFkR8-0004Xt-HF; Wed, 22 Apr 2026 23:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFkR6-0004Wx-Nq
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 23:09:04 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFkR5-0006L1-4I
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 23:09:04 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-50d7c12e48eso62316041cf.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 20:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776913742; x=1777518542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i6n4iVpFte6TXMP8Rvu7ivOJJf16+qCMCZcrAAIiBpo=;
 b=ALWtHAmv3kFmHIFHQAqWpC18zHOanVb0InqkiXRFUSnhtFHcY3eQHCsnr9xMSWBXqR
 GWCRgGzsQgsL0son7P6swbRK7kc4TlAUCLhFczfkQNaP54DylNlINdGmRRH2q3z77hcn
 2xI23o6hzaSCF4XOKNyet0KhIQ6ugPTV7ctpNWEFf2Ml7VY0Vb0naHGqcElTu3OQcMNP
 pf5S6eStYu2exyvZAWV0JaPh4pkCW31SM8pbZCiJHdJ+HCtFHz/YSmkI55jclWEFjJSc
 eEGfMs3HnLkGyvb0Lo/U3PqfUYnZqJVJiGfKrjVS8+AD9MWo8byagNNW7nfGIsiFo5+K
 D+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776913742; x=1777518542;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i6n4iVpFte6TXMP8Rvu7ivOJJf16+qCMCZcrAAIiBpo=;
 b=CQpIjahWh8HbPj2V7SQ4/KTjnICWFULvC9ifUhPcZEtyrIh6zhaVqvxqcGijErmA+Y
 Ky5YUw5iXQ7bTieA1rPL+cVeM9yzh+KKR3s+sXFrPedbBTVRTTCKkeOfyia2QeuCIQyb
 i6AnqUvJ5DPPhmojwahNJVhjaNU3K7Nj2u5J2GJLB0jK6m6LIzWUN1ekXdHpxLVjJYCA
 YID31qAqb1HBc8z4oZbUpsi+vIKqg/DFb6doVkuv7GscKhxG5gkV6JgwbtXUNd8R7ZvH
 r/abmde4P6Z0K3nubQ830YwR6QjEJJE5iYq01x4U76XRuM9KiAEXg5KcvUjYJyVGdPZs
 SQXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7NqUcSGJGLgz7XO0l/x5Bgt+ilYLmL51bQZKnEkumltaZFdYGU979xjshLDDiWq4kdM8hJ5syXDPq@nongnu.org
X-Gm-Message-State: AOJu0YzaUN2yA5ZXt6OinNKPgrUO0VCEJMeBjg2ylAz/A3vlwn0c4Pz8
 b2Sf/NOaOdkZIFiVjiB+38TGXIMcwDTv5JRZl0d9/qClHGoKbeiePn5jchxp9vfebrI=
X-Gm-Gg: AeBDietUN5Cm19QW9G5qgXy6No9NzWcZNo9SL5RohmQsrXqMR7mmE2ZrkTvK5IAnhnM
 TU0jF2dcmODFL4jgyuqC4YasUqBXscrEA6WPRF3Kxl/ow93IZg/ZtRGYiGFworkYDJxA8FHsGpL
 hr1wX1A7A8naMrHFplrNsBxdF8BxmfqdaX/g+3pXK9jigZd+RVln2G8+kybxjmD28DEuwRV/DPm
 xx/5ENb4jEr0u3uu/B1VNYPnjsF02HNWUSTb7g1IhVXfMTx2PJ/y4/z5szI7OgJ7Rnkr2Qj63vn
 3BeXJ2i0NNGJTQrQGTFD18X82IsIp/IGn7ftA7p9a3o1rQ4qHWknal7EMlgzgqQRGM0rZb1kXRq
 Hrz/TMI/79JMjUXbejYkndzqFRacBncbM4vNNAwgvQaTL5mM8NapBGiNpv6powSfCIaMVCYG3oJ
 Ap00r0z2opM5mWw+1VAl4/aVd3EmidR9jztyZxQL9kMXfWntdu6RcKGI80R3vU8pYQ4ae3Nc4Zp
 K2xbIze0rhaHh/UvnaeDa41OxB1
X-Received: by 2002:a05:622a:22a3:b0:509:11bd:9d3 with SMTP id
 d75a77b69052e-50e365f7250mr301916681cf.1.1776913741799; 
 Wed, 22 Apr 2026 20:09:01 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50fb11f9986sm66028541cf.22.2026.04.22.20.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 20:09:01 -0700 (PDT)
Message-ID: <fdbef0ff-453f-4e3b-b7bd-a164cc38b341@linaro.org>
Date: Thu, 23 Apr 2026 13:08:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] hw/core: Implement cpu_get_phys_addr_attrs_debug()
 with cpu_translate_for_debug()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-16-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417173105.1648172-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x834.google.com
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
> Implement cpu_get_phys_addr_attrs_debug() with
> cpu_translate_for_debug(), so that CPUs can implement only the
> translate_for_debug method and have all of the wrapper functions
> cpu_translate_for_debug(), cpu_get_phys_addr_attrs_debug() and
> cpu_get_phys_addr_debug() work.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/core/cpu-system.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
> index cab65d549a..be5cb48126 100644
> --- a/hw/core/cpu-system.c
> +++ b/hw/core/cpu-system.c
> @@ -90,19 +90,14 @@ bool cpu_translate_for_debug(CPUState *cpu, vaddr addr,
>   hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
>                                        MemTxAttrs *attrs)
>   {
> -    hwaddr paddr;
> +    TranslateForDebugResult result;
>   
> -    if (cpu->cc->sysemu_ops->get_phys_addr_attrs_debug) {
> -        paddr = cpu->cc->sysemu_ops->get_phys_addr_attrs_debug(cpu, addr,
> -                                                               attrs);
> -    } else {
> -        /* Fallback for CPUs which don't implement the _attrs_ hook */
> -        *attrs = MEMTXATTRS_UNSPECIFIED;
> -        paddr = cpu->cc->sysemu_ops->get_phys_addr_debug(cpu, addr);
> +    if (!cpu_translate_for_debug(cpu, addr, &result)) {
> +        return -1;
>       }
> -    /* Indicate that this is a debug access. */
> -    attrs->debug = 1;
> -    return paddr;
> +
> +    *attrs = result.attrs;
> +    return result.physaddr;
>   }
>   
>   hwaddr cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr)

As far as it goes,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

But I'll note there's exactly one user in system/physmem.c, so it'd be better to drop this 
function entirely.


r~

