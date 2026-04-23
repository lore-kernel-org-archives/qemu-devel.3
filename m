Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197A0FAD3EF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjp3-0004Wq-NV; Wed, 22 Apr 2026 22:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjox-0004VS-TC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:29:43 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjow-0002RF-0w
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:29:39 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-8d65f4073bfso830744885a.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 19:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776911376; x=1777516176; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WJl5uIGeubjw5eMBBcZrVzTYzOteaPmJsuft1HJPUic=;
 b=Af/z59aYRbWXLTO+nhnR5/vzs3GK4Cd2ZchnJtlI8UHOIdSkVLKDoez5HmDbDhnuSI
 jjlF2mKVe78SpOzWSyWfDZoYUpppM/x0HHs02i9xUh1K50WLQms8jh/+M8FCFTJLBsLw
 p25iBmn1AkWgasn6vUbFXBXSIlI52Kc7Ag3gTEgJ9yA53dFVFt7UD7ZNLYCWYB0ph0ie
 5fvv2s8jTpTbrHgUORDPGKF2ouv8e2SlRig0UbXCpsmUFrsQj/K+Bou1z2xDGI7JgL++
 /xS6UTi1GsePGBwgrBROHVs1RPaGbc2RjCghBWzW881AV4kGKZwBNty2IJ/tVEcN0TFn
 ppcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776911376; x=1777516176;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WJl5uIGeubjw5eMBBcZrVzTYzOteaPmJsuft1HJPUic=;
 b=b0Jls1VgsYDZLLIg464JpsDWZ1JdzawVuwNWBmofReEeTSmw806uWQ6uDws2HSOF/f
 Y23zvZhLAnRSgbpwx4SiYWNX/rSrMzyCVdexfWfVDLa392HdvjYCuNocTFeJTc4P6FWX
 9KzkPadI4jmUDzxldPQRnZzrSRlx1xH7r6FjLOC3FE76TZVLiLdtGPVHVNcHkZ8n32vz
 cROzNG/ztRS2IaXM3qnJLK3LsykI1C+AHnImgUOH1nVEnmjAngL4HoAYMVswa186dIgS
 nP8EasWUVqXEb5p2/D1DljEsXciGDhAacYTbv3fQ7tC0pvLarVLQXZMMu7RkZr32RbfF
 +hyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Tas8F8NHJ0Nd+hX7p6Ed88vIn8BORgylB8OCeOG55CsXOz6MmBy142LqOg7bI+IjSjBpnbE/9tzum@nongnu.org
X-Gm-Message-State: AOJu0Yywndm2206+VCNpe3BI7jZEn4gnNOEnsox3yObhUc6k4P5Pm5og
 epgKby8PYjEHw82rLdCyxsG6WEYMLJhZXcZtfjaVlcQWEUERgv0sxoBMiGw9e/ftd4E=
X-Gm-Gg: AeBDieuVyXvqSiyQK+GlOj3SbZ5uuHA1pjf2KlKIZh+OVfBFzQv+yMWB0/GknD0ZiLm
 fijJ1sRWhVocW6teQbmMR2KgAVTxXGmhNKkLydc76DXUzezi4HuVqoPaMz9P1UNcEEmunuFUsjo
 PTHtdIl8UZ+PQzQOhXfNtICZIeSlLpKRGLP0ClhNd3LlAlm97OzjQg5ojPZ223/br2mu8waKuNs
 I+4J7YzyiX3F8s9j1WU9UkRjAlSYJrDWMVVDG5lM8Kh2j1+GiGCzXpWIv/pVbNeIyDJz6rBbhK6
 l21po7QrCmkPb1jwHgET8q2yZ7dJlsQshbIY9CH5bHj94EsMY3ddYaLsSyGVxmkKnYCG5wGD0yd
 npryh/ckcc9SQcMlSRDgmzbf1M6bnEG1Yr988Epu/H7f7AVZpHgN6nj/Swfsbgwl4MQExlidGvI
 oyNzEB20sGCa5uxkbFJ7V4XFNI61Y7DYMBSdZ8xs504OQN1KeKJiEP1FrYTPVfRBiYFJPXjZ38s
 TYB7dSm+Gcyzj2+irRJoYp0JzfT8JJDACoVxro=
X-Received: by 2002:a05:620a:2a08:b0:8ee:54a3:ba2b with SMTP id
 af79cd13be357-8ee54a3c105mr1438776285a.47.1776911376398; 
 Wed, 22 Apr 2026 19:29:36 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ee585e9fcdsm622228085a.16.2026.04.22.19.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 19:29:36 -0700 (PDT)
Message-ID: <a518ef56-b11b-494e-a6ac-39acafc3d331@linaro.org>
Date: Thu, 23 Apr 2026 12:29:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] target/s390x: Make get_phys_page_debug handle
 non-page-aligned addrs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417173105.1648172-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72b.google.com
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

On 4/18/26 03:30, Peter Maydell wrote:
> Currently our implementations ofSysemuCPUOps::get_phys_page_debug
> andSysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
> non-page-aligned virtual address and returns the corresponding
> non-page-aligned physical address" and "only returns a page-aligned
> physical address".  This is awkward for callsites, which in practice
> all want the physical address for an arbitrary virtual address and
> have to work around the possibility of getting a page-aligned
> address, and it doesn't account for protection being possibly on a
> sub-page-sized granularity.  We want to standardize on the
> implementation having to handle non-page-aligned addresses.
> 
> s390x already has an implementation of "give me the actual physical
> address, not rounded down", in s390_get_phys_addr_debug(), so we can
> use this for theSysemuCPUOps::get_phys_page_debug method, and merge
> the s390_cpu_get_phys_page_debug() function into
> s390_get_phys_addr_debug() which is now its only caller.
> 
> This leaves the function implementing the method with a name
> that doesn't match the method name, but we will fix that shortly
> by renaming the method to *_addr_* for all targets.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/s390x/cpu-system.c     |  2 +-
>   target/s390x/helper.c         | 20 +++++---------------
>   target/s390x/s390x-internal.h |  1 -
>   3 files changed, 6 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

