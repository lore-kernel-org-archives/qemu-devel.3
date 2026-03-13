Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB53106FD7E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 05:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0uvh-0004yB-Rt; Fri, 13 Mar 2026 01:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0uvf-0004xQ-Vu
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 01:19:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0uve-00056W-6g
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 01:19:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso28803535e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 22:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773379155; x=1773983955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZsUrMzuE+f5PZR5bCpGksl62zlBPDohfKU1bLJRA9v8=;
 b=QWDEJHnPG/A1uchq3dEGTvOvxQDKLzvhNt3bQoegxCbbQ6IkX0PFveVLak92qkgt0/
 4PbYGq6ncY4zvIT3efrH/SQsdxAP5DWad8621GeVMxVsHtlDNdNslsfU3KHgulbCsMcG
 XghOI7z1d1EfCbkLza6VOFr+wf+8q1njegAVgEdm6plXcz5z9YNvdTywJpXgWbobFtOd
 RPs1cx5ibpJc3kV1fnkMYVR0aA3yRvvEKphlC6uCTsGi1ZSIY74XFfHfhiFKzmqXnmX1
 sicZZ8GTC97jz7mU38x9iC1DtupUC7O2UiauRKzfefYNV6tVEo15ayK79J0RFgykYAxS
 gj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773379155; x=1773983955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZsUrMzuE+f5PZR5bCpGksl62zlBPDohfKU1bLJRA9v8=;
 b=HgEMALS+KBRzACE8ZxpmG9Xi9IvxbxZgcgqwtHIH0mzdDAbHSFCJpwytJxY8oXEgd+
 0ZlmhcKdJKfEaeQOTVpbq6zw8fs5xBB57LeFTi7mlzSnpGttIiDxEKS3NVAFrxafmYbb
 2n4TBdQEtJ24utoMkyDs15TnW2e012vyYIB+S+okuYiOB8jFoBPmQL8bi/g+7MhV8wTm
 G+zQQQ5LZghZ/wvZmyotl0BigBEP51gJ8xN6i3ZNY8W3qrLF8/C7wA1rNrqbkscM0syS
 FO6Zz23SKcYMXqwM5/TJ/HujmkqJg863CIqLkkdVKqPWEu932A0mLXyW5RuXtYPtxCsX
 AoKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlMDuo1X5rmppIN7T/uEI8G8VDEfDSecZqq2aJL1eWkdRmKrQyJHFJU9+yrQHORr988hlYCqWhfuW+@nongnu.org
X-Gm-Message-State: AOJu0YzwUQFce0zMld8AA+oRoCZmNK9vJ+STMqFM2r2N6iVt1iyw3sJM
 ZIgpCzyaI8od7Cf/4HqxlRZmkzGcJG8qCw5ppA4+TG9rVoPQpS3ugvXk2UvbPYcgPsc=
X-Gm-Gg: ATEYQzxP180iMDHcwX7LsFGPO5URN4ZsMw/9pZ2iri3Z9q88/Ls5TJ8FGP+twVqfZKf
 4GFFfgtSga4klegowMwWyNT0LOiB/fOm8Mhpujdd+6/sbBTW4A2NgMzufuy1OqRez9L2PzP/N+x
 fxJ+9CPQlIVfL6NlFJBx9NaR6MvqPjXr1lX7OWb0dTEVWgMezWo16+w0sTLEVnlnKNY+aYWT9zb
 jgH/o5k4tvWAfD8I8QxDd7pb06Tke7n5WSTUwGGDAOp3at+ZJ9P0k3VRq+WDiJn2Ae7hVzpEJFo
 Tki6TvL7ISeeO/Fl9okohcFwe1ncdvUhLWXhlHFc3hqsZCL+KNFRZQD9o/5corstlzrEj3XVIsB
 ma2iDJgODkebXlvsFqFj7YcWpVyKCZ1YtYcmBlLMGshdHslrysOfrbUoTCbIlzLAyHzxVWkve8F
 r4AYCHurP8cn2z00u3X6jkT+P67ks+o630uIBI4TL9FvW0beLuyyDkvGv41gyHHG/V48z1qbWjm
 6ZO
X-Received: by 2002:a05:600c:1f0f:b0:485:3f58:da2 with SMTP id
 5b1f17b1804b1-48555b4b087mr31886355e9.16.1773379155420; 
 Thu, 12 Mar 2026 22:19:15 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5e92d5sm176855735e9.1.2026.03.12.22.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 22:19:14 -0700 (PDT)
Message-ID: <ff888136-bd37-407b-95c4-7b2fb41e112b@linaro.org>
Date: Fri, 13 Mar 2026 06:19:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/misc/allwinner-cpucfg.c: make compilation unit
 common
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20260312224702.1608408-1-pierrick.bouvier@linaro.org>
 <20260312224702.1608408-3-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260312224702.1608408-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 12/3/26 23:47, Pierrick Bouvier wrote:
> include "target/arm/cpu.h" is needed because of:

The link with "target/arm/cpu.h" is not obvious from the diff.

> bool target_aa64 = arm_feature(cpu_env(target_cpu), ARM_FEATURE_AARCH64);

This is indeed simpler than my proposal of arm_cpu_has_feature():
https://lore.kernel.org/qemu-devel/59b1ccbe-9ddb-43f0-98c4-8000a08d27b0@linaro.org/

> 
> This file is reused between various allwinner boards, including 32 and
> 64 bits cpus.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/misc/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 96b6705b7d0..392d30b1423 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -46,7 +46,7 @@ system_ss.add(when: 'CONFIG_ALLWINNER_SRAMC', if_true: files('allwinner-sramc.c'
>   system_ss.add(when: 'CONFIG_ALLWINNER_A10_CCM', if_true: files('allwinner-a10-ccm.c'))
>   system_ss.add(when: 'CONFIG_ALLWINNER_A10_DRAMC', if_true: files('allwinner-a10-dramc.c'))
>   system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-ccu.c'))
> -specific_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-cpucfg.c'))
> +system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-cpucfg.c'))

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


