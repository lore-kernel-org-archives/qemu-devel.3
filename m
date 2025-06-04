Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED622C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 07:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMiC6-0006ar-Qu; Wed, 04 Jun 2025 03:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMiBt-0006Zr-Qk
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:05:39 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMiBr-0005yZ-UA
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:05:37 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a375888197so3304335f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 00:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749020733; x=1749625533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3iqwpMsHPeTQZyO3Yb6WrCZ1/LWdOuIemu5yw9Jcnqo=;
 b=YaQGJ4WeRApo/xY8bs3vO/OeZ8A/eKvh+AUAKbKIzmMZd1fVPd4l4NFJ8sBodGE/ax
 xvDaphAKZUK7DEep1obXZIh1bbDPSf3o9E5KHvLqu040RARb1r4YqAQApaZiqii9K+Xp
 udxMxqJ4L81IV7XZoYZQ+pkUztqWy0whbf8mc2qdEO2KC2xmkctVQ2yIqyILxS8JsuHj
 c0/LUW0HeQ1F4NkjNEl94/H1k58WMrWnTQvWgckYVFHx3Cd+Q3u0TWfsH+KAQ6/W01kl
 Ey9S+s2Euvrm6aN1cf2EhMn+bZGrMSo1fuGM89JPwSQI6hShfZSPwUOmrnqPXJk93Ft/
 8hSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749020733; x=1749625533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3iqwpMsHPeTQZyO3Yb6WrCZ1/LWdOuIemu5yw9Jcnqo=;
 b=Pdi43E4Mq/i3vOFZaB9VISdpLlrpJB2YW21URX6b0fbT6BTHMcMJXN3htNCasfuvOB
 XEA/fnwNSqUJn9n8/Vo/Zf5aTAM5bmBIuDaZJIHMwWbsOx7E/5lu2OAwbnHPu/EN10je
 rLMfiEjUtq2Sz4X0gHMyJnaahExs9Jab+OZDZt8N17Rpaezc6fbnpPzdFMUjbR3jRf75
 eW2V+LxCcxMF5YJQdC+55ZD56P9pm23EtgHuB4pylfTSfv2Ddz8abvXXic7sYPBKcn6/
 DPh8jbgQP8TA+mRibD2Ljv6vlWMa+5MzW/UqueqwNHE4gMzTj+ts6q0G6W1jVHO2E0E0
 pqmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT5x2F3vBnTaIR2LHx7RxN9t/QNGK+A5fjDgEzChGXa3MESB0qeObhxT+zGrY8SExU+OjOaumZCtnq@nongnu.org
X-Gm-Message-State: AOJu0YyZg3tL2SAkLHRxaD/etpMi6WyAy9RT1JgBrwZZgVU0/gsNTp1z
 Yolb46J+jL2r6ZfDTXQeFfMt+NWNDN07H8o7QLuyNACmMoT4CHL9XwuZSNnrHWy49dc=
X-Gm-Gg: ASbGncv2Z6oixE0PV7gvaRZgeGJrVkgut4NUxCm382V2ow0VIHOg1Ps55upt2CkU2Oh
 npyXRazgne8IR+0om8t7S3xJMlwlUCTm1YGkMzi8UNlgoQUr7H2sPF3G91u2D+6RnL9Z5m5w21V
 WSEb4kxy1f4qWwKk3/lF3Ay/LypF5e2XqBLP5RsQIcvo+DVtSElgp9WP5e3sTkHvlZDvLDRixd6
 TvGcTVMGh/pW3ol2CoO/7OKa1X9RAasZhCz/mkrzzQBKuSs9DJKHw3OSzIpBJ6DLqrcWbGqM71z
 w1Ah2f070dBlvhEfAmfOhfzBAbs1ULaZIG7wlUfZfRkJltGqkEGwNBdwyxWZss88HPlVhWAPcMx
 KH6g3el8m35K83tXwG1Nt0JLAy6sdRQ==
X-Google-Smtp-Source: AGHT+IHt8+oBz6ELlTxGV3/gpsBzzTMeQ0x35K40OKpubuJAJ0Hq6WSgYF7d0z5LEA4JEZwdBUwHqQ==
X-Received: by 2002:a05:6000:4287:b0:3a4:c590:10eb with SMTP id
 ffacd0b85a97d-3a51d975bacmr1026828f8f.48.1749020733132; 
 Wed, 04 Jun 2025 00:05:33 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f0097205sm20841839f8f.79.2025.06.04.00.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 00:05:32 -0700 (PDT)
Message-ID: <89a30560-1d59-4e55-b421-4eacf355df2e@linaro.org>
Date: Wed, 4 Jun 2025 09:05:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Speed up the avr_mega2560 test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>
References: <20250603184710.25651-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250603184710.25651-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 3/6/25 20:47, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We can simply check for the expected pattern on the console,
> no need to wait for two seconds here to search for the pattern
> in the log at the end.

IIRC this was due to problem with console reader, now fixed.

> While we're at it, also remove the obsolete "timeout" variable
> from this test.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/test_avr_mega2560.py | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

