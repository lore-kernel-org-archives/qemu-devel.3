Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0DAC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufPBz-0003Jl-MX; Fri, 25 Jul 2025 16:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufPBA-0002VI-Jj
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:38:08 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufPB9-0003rZ-0x
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:38:08 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so1884879b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753475885; x=1754080685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n2XaM7w1k8jHGLQY7qCFWoGF323gCt5TiraGXrMJyWY=;
 b=vS3AaYfhvrydWy+8JNXv7VUTijaq8c1jM1AeFsTuyLJ/BJlJdoJOmFqvaWsTji8QHZ
 29D84BaM/cUW/y1qP6GLhKkEREEJH1s3zQa0ljc3BNOdKHpIegKX48MnBo3WI9O+SSwD
 RR73Imy6Rrnh/fSOFbBTelNGk/wVaF644VZrMXSwj1ZczdLiBPSdMFEuM+ONRcgQuHRk
 T/LgjREepP9Zm84pgG2QVtDZkR/cSxJnoLrcdDkyHbFrngpJsHufm8g/ITKMpvBx4PVB
 Oa7ScmuX6LYOTWmC28CmSgltP9fP63U/p4IYpN/dQe1TV1nSJuIr1SUG+uOVi4AkvMDm
 RGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753475885; x=1754080685;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n2XaM7w1k8jHGLQY7qCFWoGF323gCt5TiraGXrMJyWY=;
 b=GeZ4nMGZTU4Pk3PoPms6UEV1b5JBjFD20PNneACTejhbUVihMk/BK/acidwgyZaO35
 AzG3iLymAYERgqeYAiyC78pg21PKTpnMbX662+iGqM9CcEp9sTbdw4uZdVyjitwL4CGp
 91JJLjUrlP0BY5GI1yI7Ny1p/gTpfUNPGwJRjLaM/sJiyU1HA641RS3kPMhjPIFwg5ZB
 ktwumAM40vSKLraiWy0ZUIFVuD8xI++AKV/An6NeWRUivOLmXgbmInXoVUYro1D35VX2
 1awaojo135KWJ7TNvoLr/BKDeuwrFO+9vzHdlG872TcculmDvKN3ratYSvj6KnnrWx7h
 966Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnNFSHybTm9EP4sH/gh5EaHDNA+R/5sXs6Ezu0o/FyWGnRHShufacsPnEy92C5k6Ac1O6qkY1MXUt+@nongnu.org
X-Gm-Message-State: AOJu0Yyh8s02FaaUvmJvz/xew0YXLsdHwrQfhrInhC1GE8eK+GkqW0cV
 nbfg8CfORqufvBok25O6Ms5KDiOVjsnao3lmkHZcW73k9ku/E2ko67ZvQCoYx3pEAqI=
X-Gm-Gg: ASbGncsG4VGKYSzYY2s7AAXgBcSUnXdEAEB/ZqgiCtnf9hlc9YtWZK1EQozHxLE9quh
 SMpiPMO0DxZfAAeBJAWvA9j3+YGJqiUuSsnSgrvxlcPRFWhW3fu9RXN5r2WvUrjI7PHHnZ8xn1F
 lAuOAbB9Rno03I5gGbmbiAX2jjvluyJJQPqK2wdE36Kzh/bRZmUvA8kIdR3tsY/e8X3Z2f9hFia
 mE/9bLOob9Y89rhKOU8/Pd0rrF2RNpeYrcNk+XMeMbRNXIAqlNDODVNb329ZSSj6Wpwb1kek3a7
 BHhwgN3Aesc3aFRHBwvyEL0gE0e7lax1hyRKDw+mOBR4FSxCWGsr/3tQduV7sg7EUFGfK5lFxJa
 RVyeKkSxuzNfuqp92Rbec+bt1M2g67EpqkCg6TTeMi3B16Dc2xDRLzd46C9lr5RPmbV8MxSI5zD
 qj+C4iZzFPvwiY
X-Google-Smtp-Source: AGHT+IEoqQq8jrCbmxXIH9Sg2XJukXEyV6+JQeAbegO5dGgKEVeWreOSninqpqxLahShyQQvReo/ZQ==
X-Received: by 2002:a05:6a20:7d8b:b0:232:3141:5879 with SMTP id
 adf61e73a8af0-23d70190c3cmr4220776637.33.1753475885488; 
 Fri, 25 Jul 2025 13:38:05 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640b1e5c94sm384430b3a.94.2025.07.25.13.38.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 13:38:05 -0700 (PDT)
Message-ID: <43139d06-4844-46a2-934b-ee0c6bdcb991@linaro.org>
Date: Fri, 25 Jul 2025 10:38:02 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] include/exec/target_page.h: move page-target.c to
 header
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250725202016.21325-1-pierrick.bouvier@linaro.org>
 <20250725202016.21325-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725202016.21325-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/25/25 10:20, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build                |  2 +-
>   include/exec/target_page.h | 11 ++++++++++-
>   page-target.c              | 10 ----------
>   3 files changed, 11 insertions(+), 12 deletions(-)

> diff --git a/page-target.c b/page-target.c
> index 8fcd5443b52..66f03c61cd4 100644
> --- a/page-target.c
> +++ b/page-target.c
> @@ -9,13 +9,3 @@
>   #include "qemu/osdep.h"
>   #include "exec/target_page.h"
>   
> -/* Convert target pages to MiB (2**20). */
> -size_t qemu_target_pages_to_MiB(size_t pages)
> -{
> -    int page_bits = TARGET_PAGE_BITS;
> -
> -    /* So far, the largest (non-huge) page size is 64k, i.e. 16 bits. */
> -    g_assert(page_bits < 20);
> -
> -    return pages >> (20 - page_bits);
> -}

You didn't completely remove the file, though you clearly intended to do so.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

