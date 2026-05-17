Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298FDCD4F4A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 16:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOeou-0008T1-SG; Sun, 17 May 2026 12:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOeoo-0008Rk-EI
 for qemu-devel@nongnu.org; Sun, 17 May 2026 12:58:22 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOeol-0001AA-VH
 for qemu-devel@nongnu.org; Sun, 17 May 2026 12:58:22 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82f8893bff3so616193b3a.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779037097; x=1779641897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F8PxS3Jc2RQ2IBM+zj7XwNkV1LT5G8S6MC9qfTc+ZV4=;
 b=yvCcFgumU6NYlpBEX66KHMK53h2thCYQRnzbSMEU7q/g20lwgopuHo8XVkheOACeUD
 s5zBiPTJ9M1lOtW+XcXCn7Yfi3kAQ5HN6dPfedvD1aRqu0ss7Lyfs0UBj4cCzM22k2FG
 DRjkQHXR79zL+voYs7a7D1XcHCJ92nStGOGboJOYHroEnYW4CF0WCfTD8+7BoXun+cfZ
 KSme7XCOikGFQxIy/0s0ZQmRQ1ipcadCIdSI41H0CeDfmZJn2gJ/2/eTH8r3ZUrY3OQj
 4V7AmF6Z7+bUgoe5j3boc7a4GZBrEvUZZLanIwwN1kPg9uJV1Q6MGTCt6WpV8MOGFUBP
 7nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779037097; x=1779641897;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F8PxS3Jc2RQ2IBM+zj7XwNkV1LT5G8S6MC9qfTc+ZV4=;
 b=Hkzlhioi4uHM78hNjISHPA7uy7yXJNc4Bv4CQt0Bz1eSIBYcXkkIZWIhpM7JNzmhiC
 RpJZ7GukFO/ax27UF7ETOv1hVYymD/6lyckGHt/n7jg6JPOq/6eXEB6lD2u55lKmSbVd
 WAfRzur3b4CfD3lrj6tqOIpFSnMiPL/NQt5t6ujgPvOGK6oHbEzjE5/zhvEpeOHIM3qL
 PMFYWfGhE75MI9T2DHj5vMV/Ej5uf7n4fcjLACw47RkZNl5KePfXjEwLYMjXShw48bPI
 nS9wx/jwHnW30AG8g41EB2qjp+qW+2XWbqgrpwA8kBrt6+UZNpXkGOANoWRJwPkDCLAk
 44Xg==
X-Gm-Message-State: AOJu0YzfpP8q6rkeIbWO5A8R9RWpufAjuwv3LGFgDo+2E6yrqOUVM+7u
 J7yOEY+GrHkBYtiUBLSziYF3ni09aBp1JuFN8Qf6w+c1+FS7pgvGsYHm45YhS/fCnpwruFOeXtp
 iSMzL
X-Gm-Gg: Acq92OFUqquL/AjRfidO7wcLeywZBzkhUIuHCSVnaoHwTAl2dgrierLrWnD1mSq8KHN
 GQBgXpERV9km/GFzw4Hvi9sI5OS7RKtA/Pv0d89/gqPwhjkYWvJq7epr9tHDTdm9d480KY5rBGP
 nBen0JJ93y/HWXiBjTyBgJWH8FBYYbPrcfrDCvo5a6xD1qj7pfGB8Cjr/8gp2s0i2uy5k0YhDzQ
 j5HVQfQOQcHADFJ0vh61jSoWKCM187gbwARk8nQsXp/shF+avSsb8qmNRkSNk7e0AJ23emeoj3u
 v+7zebX9YM+OEGNzZ4wEy7Jy8r988g1RGV/wfwyv9UUIuloVu+aeEzfVRKRHbCGECL8sZHLfit5
 M7pD3svoE+trnVmhNACyyASd2cfmzTTzRNoVyYb8h+98dfPPvE7+Lv/QnysU+CUmezn0SZnRWw/
 /O8me4m48QBzi5eGY100rX9xgnsvhWK6gaRaRv
X-Received: by 2002:a05:6a00:21ca:b0:835:3730:571e with SMTP id
 d2e1a72fcca58-83f33bcae15mr12097125b3a.5.1779037097432; 
 Sun, 17 May 2026 09:58:17 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5b296sm11056520b3a.32.2026.05.17.09.58.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 09:58:17 -0700 (PDT)
Message-ID: <70e7db28-53d2-4324-bf45-2bf5f4c85104@linaro.org>
Date: Sun, 17 May 2026 09:58:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] hw/arm/omap: Remove omap_mpu_model remnants
To: qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512203414.3633237-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 5/12/26 13:34, Peter Maydell wrote:
> The omap1.c code has handling for an mpu_model field which is
> an enum of which OMAP SoC model it is. We removed most of our
> OMAP support some time ago, and now the only OMAP SoC we
> implement is the OMAP310, which sets s->mpu_model = omap310
> in omap310_mpu_init().
> 
> That makes all the handling for other settings of mpu_model dead
> code; remove them.  This includes the omap GPIO device's mpu_model
> property which we set but which the device makes no use of, and the
> omap-id-e20 memory region (because the OMAP310 satisfies
> cpu_is_omap15xx(), so never executed the old if() block).
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c        | 28 ++--------------------------
>   hw/gpio/omap_gpio.c   |  6 ------
>   hw/misc/omap_clk.c    |  9 +--------
>   include/hw/arm/omap.h | 18 ------------------
>   4 files changed, 3 insertions(+), 58 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

