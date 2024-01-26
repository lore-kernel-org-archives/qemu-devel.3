Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99090C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 10:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTJhT-0000e5-TZ; Fri, 26 Jan 2024 05:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTJhH-0000bV-MS
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 05:44:33 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTJh4-0002nD-4A
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 05:44:21 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-51028acdcf0so269895e87.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 02:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706265849; x=1706870649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fauZjtje0U1FVRMrKjMx2UjITlVsoiQwgqcFx8wHmk4=;
 b=CuPEWkA/KHjOx0L8koyqP9az317GZ7FOqGnRNd5oPAHCR3xddIdoqttSvK/ec99PJD
 whspO664m+lKOW9SyAEtXaYmcrl/ISVQY6S2UsgZVceaBHCSBj5t093dhwrrjyiB8a6L
 SNH3z3XOQJqpAbCvbOkSMtCxggTOLJe8lYSBHuxMYElHRAxrymIQ4LJPNbpjJE7q61ho
 N+ibHvxsL8Y4PllCFT9Pk3KDL+NBVFX2+eJtYRxgMiks33T7EFyfwfOc2fF4emf0LfrG
 kXyzJ4BZC6ZGeEN4hG7R917YcOZHTDSqq6XsuDoGw/C7l5dyF8EBZz7zUiV8VoL5Mc8Y
 E6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706265849; x=1706870649;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fauZjtje0U1FVRMrKjMx2UjITlVsoiQwgqcFx8wHmk4=;
 b=HwQeyi+br9JDQtcNelflOVfR7eHgK1bNCStWKveja8q/mE7Mtw/1r3ui5Zg+cFN2ss
 /HGN6LNSNthCAVKfhRwpdfa6QmMXmDenfg1yczru44/dqnLpk7IRKXOHarZyWJNjTI1f
 YPxzqdNvfcBPyEECMDMasU1fcym60m/jwRtFMns87xUW54UJ0hf+8cTIqmkyfMiv4MZX
 il1pZyW1jrmQ+9+BcTkS8kNbgSONqL4iYDYBY2dCCKgIloZrMmLguZvEkcAt987pbIKH
 C07jhaasY7d0E8EPTbnq8oUhzEIohaUZCbsflHK+AYmhnclcieWRHC5uDO9rvxtA6Nc/
 nr9A==
X-Gm-Message-State: AOJu0YwuDGZqJKPNt7Xgk1Xz4bKKVpuEpv3Jzt5cH433fcUohXRebaxR
 oRCG0kRF6f8odBptwRD2QNa51t5w7IBocSpy5bwoqhA/LBamGsppc6lgC9ZOHaU=
X-Google-Smtp-Source: AGHT+IFMzEJnU8k7tPivK/ZHrbxoGbg2RttftXQbdxMboqBdH8488KOW414mOaVfwvx/B2ibfemAhw==
X-Received: by 2002:ac2:4555:0:b0:510:16f3:8087 with SMTP id
 j21-20020ac24555000000b0051016f38087mr583321lfm.32.1706265849153; 
 Fri, 26 Jan 2024 02:44:09 -0800 (PST)
Received: from [192.168.69.100] ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 x20-20020ac25dd4000000b0051023513d8bsm140051lfq.258.2024.01.26.02.44.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 02:44:08 -0800 (PST)
Message-ID: <17455043-25cf-4978-afdd-147e689a1abd@linaro.org>
Date: Fri, 26 Jan 2024 11:44:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/arm: Move v7m-related code from cpu32.c into a
 separate file
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
References: <20240126084001.879548-1-thuth@redhat.com>
 <20240126084001.879548-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240126084001.879548-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Thomas,

On 26/1/24 09:39, Thomas Huth wrote:
> Move the code to a separate file so that we do not have to compile
> it anymore if CONFIG_ARM_V7M is not set.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/arm/tcg/cpu-v7m.c   | 292 +++++++++++++++++++++++++++++++++++++
>   target/arm/tcg/cpu32.c     | 261 ---------------------------------
>   target/arm/tcg/meson.build |   4 +
>   3 files changed, 296 insertions(+), 261 deletions(-)
>   create mode 100644 target/arm/tcg/cpu-v7m.c
> 
> diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
> new file mode 100644
> index 0000000000..d61873ab6d
> --- /dev/null
> +++ b/target/arm/tcg/cpu-v7m.c
> @@ -0,0 +1,292 @@
> +/*
> + * QEMU ARM V7 TCG-only CPUs.

s/V7/v7M/

> + *
> + * Copyright (c) 2012 SUSE LINUX Products GmbH
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "hw/core/tcg-cpu-ops.h"
> +#include "internals.h"
> +#include "hw/intc/armv7m_nvic.h"
> +
> +/* CPU models. These are not needed for the AArch64 linux-user build. */
> +#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)

Could we do that in meson instead?

> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 6fca38f2cc..8c7f6b43f3 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -52,6 +52,10 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
>     'sve_helper.c',
>   ))
>   
> +arm_ss.add(when: 'CONFIG_ARM_V7M', if_true: files(

-> arm_system_ss

> +  'cpu-v7m.c'
> +))


