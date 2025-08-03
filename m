Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD60C87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiMNU-0008Eg-Le; Sat, 02 Aug 2025 20:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiMCQ-0007Lo-K6
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:03:39 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiMCO-0000qV-9a
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:03:38 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-71b4b36d0bdso19585987b3.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 17:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754179415; x=1754784215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cqdTsJsQpSAF8yNj+ImSJNXn2g68v69bka0DncLxVPI=;
 b=dFmsZdRjGzUd9yByRm2K0bQCX6YgBZRW/oR3l/5qWjyf+5SezJzg8I1KyC/OH/M6U3
 8K6upjV6+KYbJyrNE5+vRSglZnRwyX4YArAY7ULDfiWNLWaN8JsF5kLNj2HJY9zfSeDe
 1JyKg9gFxsURsrpF9ZUOWc1wa2NKa26CXjbEGPmVTvLA7jXZmg0A0wpdT84g0Aez5R3Q
 BS3SuU3xHo2dy7SbHcHJpFgg4MjaypwaAPS1/v86HEWfsCay9gcrSvRi3G8c2/v2eaUE
 5VEB8E3FHgcG81JuVPJG0GlZvgv3n1zyWYV6hbxLhhU0tTrz3N0SMpt+0xaWIIDFrnlc
 0eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754179415; x=1754784215;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cqdTsJsQpSAF8yNj+ImSJNXn2g68v69bka0DncLxVPI=;
 b=RgvZATx2WYJf71E5Q6cpSBlVRpxNBbxPj9K2bUKpWUgsfaQX4kZ0u8dxuX2LnNRgon
 oR662Yvz0Oi8vxoRR+UVw2Hca5eIY+hGHnN/0f4IIb9Gz3WnQ/sTDIe1pLco/ezblTXR
 xUgYzXuEDqTa7fa9g2mCtTFTmYUxgwTGn7e4ZmyT3KRpyutsnXHLn3QxgigQjD3xgpKn
 uC07LxxyAOxaT0MrGKksdHbDryvc3on+Aj2H1oZ+oVisfpIGyH5hjJG1YuESzUoNE5ka
 HdBsOxI2tqVRBsgxQntQe9oSS7gSnMeaBoP7hdcNDf7CfIZLzkrNKSfw1Co0MrwtuCBi
 ccmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU6Y9MF8CbdJGLaksx+rot09SycktqRQ8s3tNNHGGizdDYx5ptWl1E2YCnd0zdA8qTJEX3c6jup6YW@nongnu.org
X-Gm-Message-State: AOJu0Yznk3Hg6Y36AqSPL6tWk6PDUl8h/0+B3Yot2p072nbEZiqPop8X
 hWWmsmWthjevmaziRYaLlVqNChoiV8kJO/XoovDmpw4Kfx+Gh2rzoPbgXBtWQm9lSDE=
X-Gm-Gg: ASbGnctEC1N4pJOmZlwdH4IGWBBP9BgdmAjeQIRtMU3d+RyQZ69SGMM7+rlQsjfNa9u
 3nL0zr2l5pios2Oxf85r47/k30sD+Hjjql81mrDvc0t83DBvRtt4Y0KVPvbnvU53+l5oMmKNtpM
 z3BnC13yLqU8QgrWpZy+63eDVwJYVj2iAyCBKkjTkdEudysA8HKwt+L/pbFzM3NgxY3Hqfxh38a
 a1XhjEFMnOaNSbtG26vaMPYG5yDb8PDfwKLKp5VihaJL+VJ9SJl0F7fr5uy9b9C13K/rcBImfP3
 oGLP3Po6clclsl55O+sDAf7A+RlnOhKaLsRH0HqSNZtvw92GRxYCwW7N3QWn+7QDTqh8zYo9e7L
 TGdWhw+rGG5MydlG6RbZ0VhNBYRkIR7/ICPZ5FCkE60pSup9zjux8d3STGlbfkpuEkKXudRZsJB
 8=
X-Google-Smtp-Source: AGHT+IE83T21+t2TDeD9n6L2wyCglZN8kQvcanAiXx10oRMgNM9BwG395ThBA2Nndxfox8LRDYuf2w==
X-Received: by 2002:a05:690c:2e86:b0:71a:28aa:3283 with SMTP id
 00721157ae682-71b7f08f850mr42388237b3.33.1754179415028; 
 Sat, 02 Aug 2025 17:03:35 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a5ce7b5sm18521457b3.71.2025.08.02.17.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 17:03:34 -0700 (PDT)
Message-ID: <23a34997-9fcf-4b0b-b5ee-0a49972897f4@linaro.org>
Date: Sun, 3 Aug 2025 10:03:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] whpx: Move around files before introducing
 AArch64 support
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: "open list:ARM" <qemu-arm@nongnu.org>
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-3-mohamed@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250802081800.76030-3-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112b.google.com
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

On 8/2/25 18:17, Mohamed Mediouni wrote:
> Switch to a design where we can share whpx code between x86 and AArch64 when it makes sense to do so.
> 
> Signed-off-by: Mohamed Mediouni<mohamed@unpredictable.fr>
> 
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                                           | 2 ++
>   accel/meson.build                                     | 1 +
>   accel/whpx/meson.build                                | 6 ++++++
>   {target/i386 => accel}/whpx/whpx-accel-ops.c          | 4 ++--
>   {target/i386/whpx => include/system}/whpx-accel-ops.h | 0
>   target/i386/whpx/meson.build                          | 1 -
>   target/i386/whpx/whpx-all.c                           | 4 ++--
>   target/i386/whpx/whpx-internal.h                      | 1 +
>   8 files changed, 14 insertions(+), 5 deletions(-)
>   create mode 100644 accel/whpx/meson.build
>   rename {target/i386 => accel}/whpx/whpx-accel-ops.c (97%)
>   rename {target/i386/whpx => include/system}/whpx-accel-ops.h (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

