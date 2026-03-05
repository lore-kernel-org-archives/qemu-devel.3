Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2809BF513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 21:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGjM-0006Mp-Fj; Thu, 05 Mar 2026 16:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyGjL-0006MY-CV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:59:39 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyGjJ-0008V0-PH
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:59:39 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso71689735e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 13:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772747976; x=1773352776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AhvdEgbWbb60CUEgoGGrbB8sqJEe9ifPj9q7uHtYrHg=;
 b=xQtzt9zRqMFZVSXOaEGsxgqFfTWJXIUcmzxYrm9kWEs4ji32EjKmuLwxgoFSj4j8SH
 d7AwCh0E3Q+yyb/P0+dqspWjpDy2yK78KlPn0AdFMclRZCjVdpviFbrgUBpcXevCwBub
 RPYTyOCMeXXIp7TtlcLE3uQWB1IE1ohlf2MQMKE9szpRei2OKra5OTfiX487XDsvjV1T
 7GewqtsSwd3M656F4udS5jhibCzRvjQzqReNqJmFD90YMNki9Zfy5B015dPRfhk/+3+9
 jdN4P3uuRwPsz+gFOHq6viZ6CFCL3AQ1In/TXmy3W8Idgbh8Z3kqg0Cd6NzL7gkwktg8
 ieiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772747976; x=1773352776;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AhvdEgbWbb60CUEgoGGrbB8sqJEe9ifPj9q7uHtYrHg=;
 b=PLt15mKtKNWNYzkOULtwDeULgKRDIodkCBXMbFGNWvF2Vt/jkiqPPmP3Q1j2iigtqK
 wSa1OqAsTWlPOXPwInERmr3ta2JYcb/czmov7/3G4FD2WyOKgOKjbumhyZJEa3vRRWKK
 JT9q5BHxpRNzqGWFN7BMT3sXlI6N3KgAkdk1LCInpnMu6lJJ4RUXtv9FznqbIZR/Dr9f
 d0ZrVWDgGBsIiKAcUeyoBcHHKmHhzp2SCCti10MbfEdEGaV0Oq/dUwH9AhjvGArxAbce
 dYkG/EjKC66nD3d12a5uIVBPFeb2PvtD9MD1qehAT4Y5hiqb0b3H5Vnw7zO9/xb/nKQq
 RG9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqgpZSJh7WBtuvtE1ylaNwohzkCLEkXkNHZMB1TN6W74uIzClKeDpyQQ6dFBmkIeiIvawFVJ13KHUW@nongnu.org
X-Gm-Message-State: AOJu0YwoTuWJEyKTPOVhdjbvlR4Qy8Vh+lG1jNpZsm0VLjl8km/Ntu7N
 u+eUx/3yzlUjb8EOaSgtWkwauBLyXU/9XT0n+/jGk5ilUaq2wfo+D2PneKhrpatV1V8=
X-Gm-Gg: ATEYQzzp6ZiOgK0J4V3l00BgfjHRVOge4N1hbsOkyIdm4diK6Hzug1ZQ9qokn4icxJH
 eHF5l+vqYwwBZapOr9XL9f30WBi64eL/L9KkUfTCEcmL+i75ucmcjObISkG81yrVpYYRG32ePk4
 OQ83tCUl+bdjwRopDfKxNfGe6dXFFL2pb1IW0rpOr2fZvyPY/xtSjzTX/yDkDQxXhjItDup3oSU
 MIUGHJWxZ3IotGM4yLpxzPiWNfJn8bkEExzYX59oYWVKkb4/69Oghv3u8rsnrR8X9k7FuDKsdWZ
 49PYyq0Q4TXdhxl+66wGNuqfHOpEycCom3N/b3gqFwmloBkoxcBuwDDAX3N7V7GfF/6vVPrhUs2
 NXjIs41bL2SLpMSngNM1rYulWvvtQeImoOkUNEvBM7UfWUV0wdJiW1Efkcx8+y7MqXJejB/abFO
 qFgifuXBkD5otjG0x3SsRzMSTAHu9Yo0rRSKkr1OF9EpAeUrSodTWUzuwP61MSp0RFeg==
X-Received: by 2002:a05:600c:3510:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-485235b4e40mr15624265e9.14.1772747975765; 
 Thu, 05 Mar 2026 13:59:35 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851faf089csm55861545e9.12.2026.03.05.13.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 13:59:35 -0800 (PST)
Message-ID: <ca77a80b-cd67-45f5-9a40-9e800ce8e4a7@linaro.org>
Date: Thu, 5 Mar 2026 22:59:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/12] accel, hw/arm, include/system/hvf:
 infrastructure changes for HVF vGIC
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
 <20260228220837.35275-4-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260228220837.35275-4-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 28/2/26 23:08, Mohamed Mediouni wrote:
> Misc changes needed for HVF vGIC enablement.
> 
> Note: x86_64 macOS exposes interrupt controller virtualisation since macOS 12.
> Keeping an #ifdef here in case we end up supporting that...
> 
> However, given that x86_64 macOS is on its way out, it'll probably (?) not be supported in Qemu.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/hvf/hvf-all.c        | 50 ++++++++++++++++++++++++++++++++++++++
>   accel/stubs/hvf-stub.c     |  1 +
>   hw/arm/virt.c              | 23 +++++++++++++++---
>   hw/intc/arm_gicv3_common.c |  3 +++
>   include/system/hvf.h       |  3 +++
>   system/vl.c                |  2 ++
>   6 files changed, 78 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

