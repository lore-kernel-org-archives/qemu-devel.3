Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A93C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9epY-0001oR-PK; Tue, 29 Apr 2025 02:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9epI-0001m4-3o
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:52:23 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9epG-0001f0-E1
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:52:19 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso44197785e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 23:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745909536; x=1746514336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7zbCfy9rllF3cg9v4WoCsWISuDBGnOGV7W1YhT5T/GU=;
 b=Pre1Q13bUn4mcg1scAOSOMc5M5A+6sf5mgFZIUuAUqs2znaLZ3NtIgyAHKCPGFN98/
 jeeL9zw292uB0e7u0I2Vppu/NM+WkQDzG8rZw/UUv50waiTybiiMDnVICmANkCVphee8
 0tNFgVO0RcX7E9CC+7MDcs1QCVTYUYMA33CccfaI65dp/RAS/jrJBIzjMXLPP+eUtcTf
 DFYXs4MhBCG9f2vYzDvBUMuZpanxt3Gdd6lDnVeCgeWWz0F/r8T6xIrV2ipKBvUPFI9s
 RLRRHeleqmN95SfWDOXALFxPRox0PDps8bYrmRptO9tBFkRNC5DWA1Xv49W39icQaLz8
 qFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745909536; x=1746514336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7zbCfy9rllF3cg9v4WoCsWISuDBGnOGV7W1YhT5T/GU=;
 b=p8AQNOq1EUxAwWanKVVkY2IH93uKkdg50UHQSt9ksDmhR+548MKevTldbLxpM95JqZ
 xxitYHZ7FE3OpWWGINLCRvQPGP6tCpOW0BY4zH3VrVcAuoke8e8gjp6aLh7CBbR6TLxJ
 gKtZlPOS1Bel9UiZjiZT7RNgp1/2x/xvqcwSMAU4ryVuRv0g3LPOEtpmSCEd7OydG8Gq
 jSAQoIIvf9mqs9UX5iVMemlk0VFgNGZQ4C6Pdgz6rK1w3IIszHa0a09+4pW+2jwxo+zj
 kH+J9eS0Jmz3ocjvtnCq3FjG+s8Hbpg471jNwvBgQuKmtwdkgoDfgJdZZIDxRxUcXAar
 lwEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWneMR3gGn7I4tIXlHtCz7u7WP2BgqemJdJ+yTkzEHXG0YOyWt/nDaH6Dhk6rO0J+51phM8zhNu8kr@nongnu.org
X-Gm-Message-State: AOJu0YyNQRyZu1qAc3G2F2OS6VpgKUR/m8DdQwvagrvGuQ2zXZ1o32t0
 FdxTQP+k3+dyPNhWLjJ9Pdp4E4PVbrnPBB92lmrlcptkfGDN6l+EVo6Xl22bJaw8gBStSLbvf/x
 D
X-Gm-Gg: ASbGncvrLCQAB4iu6y25WpTSykAwoKbUGvkOVGXu8ItHY6ByNGQjeTAm6PTQha/jegy
 hn5drsZokBKmqdVHf3s437vPCwXBpqJbgWkkVerO+6vEHNgnbxd1Y9IPMrFqiTvKF/xcoX7JADR
 E3zaPm4G1YWe2eYAeZV2P8xkOXEluB416oPfApu9KZFjkspn5t+HNIGyTsXMqegkUb3Oe2gqZZb
 IfYNHKL2HQQCRzXROyr6RpBwxy6y1TnV0NQv8TglcaFE/X20DkcBgOyNFkZEJLgnlcXkgFXaWXd
 GEKJGemb5il7ioO1Yo8jcYmYGZf2KqDwjQ5FzzjjHA7c99Y/9lIcaYBXuyCuynm0FhBH/yg/0Un
 kIefDBvd/
X-Google-Smtp-Source: AGHT+IHBas2At3FBk9oJecj02XTxpZ0xSMbazDP0+rbZJ1hcJDO4jHh6OI5jwf9yqc11jc6gp/EblA==
X-Received: by 2002:a05:600c:3b0a:b0:43c:f5fe:5c26 with SMTP id
 5b1f17b1804b1-441ac84b60emr17991375e9.4.1745909536653; 
 Mon, 28 Apr 2025 23:52:16 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a531dc6csm144512875e9.24.2025.04.28.23.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 23:52:16 -0700 (PDT)
Message-ID: <aad93be3-1136-40e6-a9cf-29eba433a787@linaro.org>
Date: Tue, 29 Apr 2025 08:52:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/hvf: fix a compilation error
To: Wei Liu <wei.liu@kernel.org>, qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <aBBws1ikCDfyC0RI@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aBBws1ikCDfyC0RI@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 29/4/25 08:24, Wei Liu wrote:
> Include exec/target_page.h to fix the following build error.
> 
> x86_64-softmmu.a.p/target_i386_hvf_hvf.c.o -c ../target/i386/hvf/hvf.c
> ../target/i386/hvf/hvf.c:139:49: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
>    139 |             uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
>        |                                                 ^
> ../target/i386/hvf/hvf.c:141:45: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
>    141 |             hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
>        |                                             ^
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> I suspect 58d00538ceeef990 and its follow-up patches caused this issue but I
> unfortunately don't have cycles to investigate further.

Yeah sorry we don't have HVF intel covered anymore in our CI so we
missed this. It is due to commit 9c2ff9cdc9b, see same fix:

https://lore.kernel.org/qemu-devel/20250425174310.70890-1-philmd@linaro.org/

> ---
>   target/i386/hvf/hvf.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 23ebf2550a..99e37a33e5 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -76,6 +76,7 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/accel.h"
>   #include "target/i386/cpu.h"
> +#include "exec/target_page.h"
>   
>   static Error *invtsc_mig_blocker;
>   



