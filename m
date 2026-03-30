Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4312FF4923
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 00:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w70xt-0000GF-HY; Sun, 29 Mar 2026 20:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w70xm-00007G-HR
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 20:58:44 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w70xl-0007Qh-0Q
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 20:58:42 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b24fdac394so6012775ad.3
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 17:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774832319; x=1775437119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TqM/PUvXgpZw438+dhBmNSrs4O0kgFpdjTtNt1VAHkM=;
 b=Ojy2mYVl4JlJJLiMA2lmntNHpgP8SDWSphu8CG7jWBOP2b5A/Knioe+w1G5JR8w33K
 lC1xb9DldregCuLOLFfzIa2dameh+GNqo0O4cygPge/36lEdeEuDJgB4XOFz0VnPznZr
 N4vjSM8dMyuivNlgLBNTKU4iPPLbIWGI5fkW1Hrv1Ol4alMZAkI17qAPd9LaW7FqmGzW
 x5sBAkHIurADnYDEZ9mq87zf656RZV+udvsXaBTRyKqw7mpp47V+R/osRXDGS137jl/t
 RegP8HHW/B4RVExqpBSeN/BCHzci0tKy9S1BGuyQPZfxNOzBWY87st+9brlK+moPf3w8
 N0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774832319; x=1775437119;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TqM/PUvXgpZw438+dhBmNSrs4O0kgFpdjTtNt1VAHkM=;
 b=WvjrjQDcWTY4Qmap2iZ0IEuKvH0/CXz8VYJS2/rCkaFWyL4InPIStXMCFSF59HtG7A
 YyZ3jarBZYiCqNzXqqrBhHoJosKii+pvIRw0cwcqSLFSjPGlwoXrYBX4vAui6djXr1OA
 OX403vgHihEz3OecqFzyGYvt4FS7eeYw8G/VOVi7JnXMzHwIMbXh14MgAu7/QswMmw3g
 cdXdENYKylXBzeSXZPyWcYLhO6qRBdf6NEL/6CwWaJKY25CpsF2HWvEgcSuM2K3zQsSZ
 iNbACd35PGsjcKUxgERTJD4NLj8V+fBdOnLuQb4qUBVadv/VoA7bvdX+s282J3yiSavI
 pk7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8cEt430u4BJj7r9zyRfI5wRfAh5F2lKMzVvs+GpoXka+BSZji9s+JUjkEKamh+2zXEW6aq/4zEQiD@nongnu.org
X-Gm-Message-State: AOJu0YwBKaZKiAde+BhKQOQ7ozyCju5f/wNSnWVM6FqBli9zxObKKGoA
 RyyP6+QL1OzxeHpQDeQNGu/Onvfvyu8c7aIphlWUhyYjR5HVbhD+d8vZReZGRj6Tnxw=
X-Gm-Gg: ATEYQzyU6hplLC1Z23rl0KPiePHEwLLFg/7sBgIeYnm35oalwQJLgP1ZwagESE8V+Dv
 ZdgNXopnoy3xtmy3Nwp9PYwDxKWTrMpxOlgtvtQLzgKUgHj6fatLVdtouA2CBOjgzicA5rvd9gW
 24L7Fitf3CajLxRislICVe4qGKUH7EKGSnEL035V0/NIxV6EM6W3ze2t3IhI3K+EZxA7NCWmnMU
 BCeCc8CEmA9C83IXsQ9Jlsnb9MmUIJBD/3qelUnw2YGOmGlAdcQinFECSC6lEtm9LwltDPwALK1
 a1pJRmhJyJP6xPgIGs//VT+I05nW7pSP8UHv2u7X4XvFG+hPFbJPpm080TgSMZGxIIWTC07piay
 4V61mKlk4MFL6x+br9HWxcZEOclIQtCGdc9tTm9h3ZTszV7+OTQd5Do7aHLP6tQmDac3SonRBbr
 Xy7pPlEgHc+0aPW7lUVikEr8gtvMmpxul1OiLXnF4=
X-Received: by 2002:a17:903:3b8e:b0:2b2:5840:80c5 with SMTP id
 d9443c01a7336-2b2584086demr120445ad.37.1774832319551; 
 Sun, 29 Mar 2026 17:58:39 -0700 (PDT)
Received: from [192.168.4.112] ([103.73.85.113])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2427c3a4esm73557685ad.78.2026.03.29.17.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Mar 2026 17:58:39 -0700 (PDT)
Message-ID: <c9bf8110-0ee9-4a91-9a6c-36544e1c0de4@linaro.org>
Date: Mon, 30 Mar 2026 10:58:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] target/arm/tcg/translate.h: remove tcg-op-gvec.h
 include
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-4-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260327165042.604105-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/28/26 02:50, Pierrick Bouvier wrote:
> Include tcg-op-gvec-common.h instead.
> No target/arm code rely on target specifics for gvec ops.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
> index 6d52606f9b7..e28eac54afb 100644
> --- a/target/arm/tcg/translate.h
> +++ b/target/arm/tcg/translate.h
> @@ -3,7 +3,7 @@
>   
>   #include "cpu.h"
>   #include "tcg/tcg-op-common.h"
> -#include "tcg/tcg-op-gvec.h"
> +#include "tcg/tcg-op-gvec-common.h"
>   #include "exec/translator.h"
>   #include "exec/translation-block.h"
>   #include "helper.h"

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

