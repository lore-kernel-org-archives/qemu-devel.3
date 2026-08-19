Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D76C5DF87
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmGe-0001FG-4F; Wed, 19 Aug 2026 15:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmGc-0001EL-Ia
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:48:06 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmGa-0000FO-RN
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:48:06 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so1012983a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787168883; x=1787773683; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jmbuQ0CF71p1Ht5ENZObOjNwAXqkFrBK4XokT6D0QRo=;
 b=FxKJhfWVkw7qLfdlQEM16rcyt2wiDIPlAbxovDop4dAqCiegIh02WzjP794TgjXWb2
 S/gnCEzlkbrCsATuN5WXEkzQNHhIRNLsChCThlyb0NJF8nyctF/A9no1ZF+yUxbexs3t
 EXRvRg2kq/0MkJP0cfwJC6ZsEAuJtzzpamWWgp91ng5MiWbN4TiespHBteiOpwxjCPtw
 E5hTlPrIQBqq8qMECjayl7pSdG2peDQLl8GMf4oCBRg1SmbLAx18aXWmZqP6uaYJP42O
 YmMzewStlf4ABZVYb53YecuC3+qY7nSsVcPa/f8ePkoxoLUKDreTyleOEHhGVl5ibZpX
 /rNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787168883; x=1787773683;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jmbuQ0CF71p1Ht5ENZObOjNwAXqkFrBK4XokT6D0QRo=;
 b=R3m22RsyGd4mmXRGW+XPVAQbdoydQRnD5ws05f5HxwJtCkWeLcNKRP37DEmCuiOoDY
 wGfmBGMmov1ehZ7ZwH4sovsV+l1zVkQX7G/I9Mc0LMXBB6nIErGx2L16zuPZvJR0B5bM
 wKFNleqY7ZZ0Mg0rFSiIoG/efzwwPdm7QcCGYlDweaOmoY++pim1Cxv8hTKcnOKkgQwd
 GnLwXZOdYBAClv/xn+hPwFoDgrxLt71BZ9bI4oEztsVnr4dVtHMnTjLmyAcy7Kvq8gVd
 oRFnZVFLxSuXYGYpWP/najk8woovoAcvdmkBcab+gWgFnfJKJsu042o3qCUAQDu1VPon
 aBEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrS/5hOfcyMlvXgj8kCbcz1FqoKA8rLhQY6k6yvxc6dEhb7hjtfemGYh+iGJMK/U/J9lgxhRZKXL/sq@nongnu.org
X-Gm-Message-State: AFuF++lN1+2NT97PbZ6kIt1gbXGgw6tTAaQ7k5JLv/2MaJWqN0LszIFY
 rEfGDO9aAYEB7VLoLlvUMfRzI3h+bL5pvDBmQh9BE9M9qYPgsheRfna/lUYEaEcvIK8=
X-Gm-Gg: AR+sD10je0z5pjgYqkyGO/MeQlMF9FhPZa9SBJLnrM6r0rU2etPA9StGTRziKIRlSKD
 0S3ol5qYEvDzVLjYdYYledmWw4FtWkqvICwz8Fq07zBtIQCfo7q+ZcsNT57P6QEurJn1nOH6Zn1
 BVW8s6YhHBnjdoCjtOG4baK3mcsGmjk0OhocSnedzkh+T0xJHeveVSr3wfqM6zRd/BJKJi4pmof
 2l080LoCJudW1d2wxRBYm+GPsnR697RpgYqIjDHfgfnv5ndbqHkSitD/ZnNQq3J/lvrZxLUJJ6z
 lERlDjOrTycrVBAsCoWnjHKaJKSF7Brk0U2rbUKYrJkjKx2dBm0xiyaWvTQkUggktaQFqhFHzhc
 xw/JPCn/56As1baA6OLHg7Zx77d7TnyOzMSzpoT6gKSFceSnqHl8tmr0TKcG2bczcqb0qgzT8NW
 f0XwNeg4kpP1TV1+LTWTbAnFCxNgulpxS3Oiy/aS8yOpP2VVj1LsN7CFNMjhGw3srqsTl22G6eG
 5qi9WK++1H3gQ==
X-Received: by 2002:a17:90b:2748:b0:392:7f74:58c9 with SMTP id
 98e67ed59e1d1-395810f2738mr13407703a91.15.1787168883450; 
 Wed, 19 Aug 2026 12:48:03 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb51271sm4055310a91.7.2026.08.19.12.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 12:48:03 -0700 (PDT)
Message-ID: <f53afd64-7e0e-4aba-87de-7446c710eac3@linaro.org>
Date: Wed, 19 Aug 2026 12:44:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] xen-mapcache: Remove 32bit support
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
 <20260818172012.3052821-5-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260818172012.3052821-5-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 8/18/26 10:20, Peter Xu wrote:
> QEMU has switched to 64bit-only hosts for all system emulations.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/xen/xen-mapcache.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 85cf0cf359..e30c07c2ee 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -26,11 +26,7 @@
>   #include <xenevtchn.h>
>   #include <xengnttab.h>
>   
> -#if HOST_LONG_BITS == 32
> -#  define MCACHE_MAX_SIZE     (1UL<<31) /* 2GB Cap */
> -#else
> -#  define MCACHE_MAX_SIZE     (1UL<<35) /* 32GB Cap */
> -#endif
> +#define MCACHE_MAX_SIZE     (1UL << 35) /* 32GB Cap */
>   
>   /* This is the size of the virtual address space reserve to QEMU that will not
>    * be use by MapCache.
> @@ -151,11 +147,7 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
>           exit(EXIT_FAILURE);
>       }
>   
> -    if (HOST_LONG_BITS == 32) {
> -        bucket_shift = 16;
> -    } else {
> -        bucket_shift = 20;
> -    }
> +    bucket_shift = 20;
>   
>       if (geteuid() == 0) {
>           rlimit_as.rlim_cur = RLIM_INFINITY;


