Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB45C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7X0x-00048k-Di; Wed, 23 Apr 2025 06:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7X0w-00048N-D4
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:07:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7X0u-0002jd-C0
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:07:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso49466545e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745402850; x=1746007650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JCatk8pcZ95qAgzGN5z08V1j0C53qK3mk955bo1kZCo=;
 b=ACz/va5ESAZW8GRYYa70sXDgJxARJAZc7nst8FXyLqayeaFbhO2+Y2SaqxEEZfWhNz
 4yKtu65Oykrrg0ZqOzbfAEv+lxgUWvycLhLdVrtWrs57jSgsSxRJUSrfc7ug7PWKFLlb
 K+52CFxxYMBXT0eVKeP/ZkoTEULbpXFCv9TCyuNnNtZDyKNBpksbeb+p+uAid9wWTp8k
 0Y00G55JJKKHc2fMyVW2yCH71vGhxdQKO1VrFGF6gNBZSzXrCwd+EQTUE6DXTy8Rfxvf
 8UlTkOdV1nXF6oMsz2vtvm5E0UbUQvfP7+Kvc7WCEvkjXacR3zU+hGAtljrb0si3ePZ7
 gaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745402850; x=1746007650;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JCatk8pcZ95qAgzGN5z08V1j0C53qK3mk955bo1kZCo=;
 b=X/goT/vShnu87OZpx02jnM0mhlzQpmysLHjpFCLqrrnh8YIzwVj1lh7ROw6tDbWxuw
 8JVd7WxVX4CM2Ty+wG44nuFa1w/jCbsWPmTifFWraCpRo2AbbAbQOjrTkyQxymcNtWut
 MOcLKZTokqiH9Wur2ZGRGby8b8d6tvCuvmlL23mK2Bxg3AROzSoKz2p9c+JjRy/MbV0b
 QjUIjN/DV58E8Af6RJxPYkwDNIgTC2/F/2c5Q/+Yxxgd2mzygP5CGzF0rFlO9xZ6dIo/
 wMC5Um//kGZCOX4BsWeqArTvU1Bcz07wLfVo/nRK5xOZgU2aaYJULjsov3LVSRZpqfxH
 jDSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1gSms2TjS50IY3eqEMuNASy/4UQUjYHc2gnsU5wcPJV6bHNc/FU0MC9HibBy8Ir2c7hwdpQDxKxJR@nongnu.org
X-Gm-Message-State: AOJu0YzLBzccWrbl4SNQGKWZEOppjFX71qIT0Vs3QSXsyK14LLbUwrPw
 +7yVAtiGYyH4J02Qw/aHY+onpzRQa7mSmP32HqEzKsKvuuIO/8xu7+QiFlzxFTiVs88PFqdB6le
 G
X-Gm-Gg: ASbGncu+2qfvz+KGPW7Q2m5N/nkLTnAbXJ/YANsw9KqPlC+8kUOtZEk7Hvoj7/Vmj2f
 I4R9wKThTCHnyjHX00uUwNLMB31jPDhNYJs+WNWZ8v0FOQzR8QjQ97CV8ZePQgu4ykONOkiykgL
 Vn2O58sEQT3CrwjkIZx0aYFr19kzs6ccQnM9vBM+toAtXPVqeHhMp5289mVYbxG5UxsjFNO3Pmi
 eVWGAI+CK55yzhVaXAmm/caoC64n2LMULY+YAfC3LPOO068JfmT6DiHbJ8PvbnTKqF17aqobZjF
 NM1qvVH9kNI9EJTlRJuad8pn0hJ03HVlqbjuWevFaA4NqruHWgZI1lz36bIBUIuMc2PUp0PkdrZ
 aUWHTV9jG
X-Google-Smtp-Source: AGHT+IF35wAZQhIyzUymSDT6Zg87mR6mvXq1aQ7DJWrCR326/fMiWzey3vEPzgPnOKBphTRRhMgzfQ==
X-Received: by 2002:a05:600c:a405:b0:439:91dd:cf9c with SMTP id
 5b1f17b1804b1-4407163e193mr166813995e9.10.1745402850319; 
 Wed, 23 Apr 2025 03:07:30 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d179cfsm20468075e9.4.2025.04.23.03.07.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:07:29 -0700 (PDT)
Message-ID: <34e3bbb8-b1d1-4248-8a8c-7efdd9592363@linaro.org>
Date: Wed, 23 Apr 2025 12:07:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 070/147] accel/tcg: Remove cpu-all.h, exec-all.h from
 tb-internal.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-71-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-71-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 22/4/25 21:26, Richard Henderson wrote:
> Not used by tb-internal.h, but add an include for
> target_page.h in tb-maint.c.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tb-internal.h | 2 --
>   accel/tcg/tb-maint.c    | 1 +
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


