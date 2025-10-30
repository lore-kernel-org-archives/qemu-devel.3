Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0C8CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 22:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEath-0004jM-Ix; Thu, 30 Oct 2025 18:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEatf-0004j7-SK
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 18:13:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEatV-0005Ib-B0
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 18:13:31 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so15192075e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 15:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761862393; x=1762467193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YS0IU10RXyDjqU8FZNXGtP2hgQD+ICxb4DMG3AOxq7Q=;
 b=TVn79xI91wwgIar11SB/QNu+k/xmyApbjsTlHbmXx+z6gFZl4Au/1g3Aj7ANZT0dpG
 cSnp5P/lqqeV7fgTaY4wdZ49ZVyIIyMnkTEmJxOe1ouXUUpPg0uJcGu0kyA6HNaOqcHp
 3J7Pauv896PrvNH7rgnHUrgFyiOZTgdGSuP6F/fnbxLcjYDalDWjC5bb03q//91V5mKy
 t+J+HQigqerh5VoH/DWnqpwvgpNAJh2OmOVtmKYYA5BnYN1NElON25nPwGq83Qw4Nj4s
 oDvDKgofgort4G6WIwC7S0p9+MIQT7G8TIjrTjMJQQvxKzFOqtIEcpR/H68b7epGclB3
 5tUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761862393; x=1762467193;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YS0IU10RXyDjqU8FZNXGtP2hgQD+ICxb4DMG3AOxq7Q=;
 b=XXWFJlEaCUd/PuSu//0ksJqM7H6y0cy/Mnw3tbV5o4osi5R/Vka4n+iXB0fenoUxnt
 HqEtxZgGYoXz4FGTeGezpva1/koV5Hp2WY4CC35zOGqJtpbK7E92PLFS/JGmRt8o6sKl
 id2W2mwUA41v8tszPEXccITsMXLguqFPaJbyxhoJYEZdLaknKPu/LcUF+AHh0RgPCrrV
 fniyJ5lZTpeP2cWBgVOt0+oiAOe8soLhCiOUlI2Z64tkl/LLhRtdhKQvjmqbBjr2WajQ
 scCWsOsprMeQ+w2T9NKDMUXoxZgQrvcfiVCYVeNlyWhGulTOeWEVFeSkeHngiT3uIKnm
 3Xgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCooljOx4H5SDM7fSebBHKBzRXdUeWhdgvnBbn7UCug+g2FIho/v2+L1fNYgTMXfEGrLYiHYVwMyFd@nongnu.org
X-Gm-Message-State: AOJu0Yyc8dKrSn3rNS1N0eul/BF5nf2P9wK1bPt/k/J+FZUO00g5MJ9O
 08bv/4XxZZICEFKNrnqWDFZHcpOOUnHjtLNFBuOcteXfPAsy6YcemIEwP07upOH+HSE=
X-Gm-Gg: ASbGncvk8HBIN7L2NwIB/isHfZJQ+XsLsG/YtqeCFnZDOHkuNHGxV/VfOLb88Jrz+Bq
 x7gHG0LW076jaY0WEl2JzB4kSOw689BvlwupkdN3G0bvlLMp6I5pxvR057g6+Kr64/bDPYO4N9P
 fAXEoaxOGBRsvMKkGQUkHm+VwxPWagUEmoE9RkkXDuuEm06VIpbU/GlUFub0BlHLE6XM10ykwq1
 QRCt8YBCn4WbJlcJbRAZ/TJHg0tfPTLn4ziQrsI7fyZP+qrbZkwrokwMpv2d/2vQDtZ3axK+NVo
 UMWBjTy+M7KhnCN7Kt+akY8yLpDfmnHLktqPqxJDHaCAJmCeR7nfx0zpFr2PcfEqljQbiAe1MD9
 v2beE8q1bMi7u0GJwx4wQb0n/lp4HTN0eBJ/q8l92fqLVFCQ88B80uRtK/3qjd4/jeyyKAdCEZs
 BW1wpQhauHOW9PpAO7ChCnLx+91rVwluRyGxXzeDZIGjk2+oKdKNJvZ4U=
X-Google-Smtp-Source: AGHT+IEK9PD+uN4Z38SXXnDCMiCm7DIdnrqKqV4fL4jvXYcylGubnWHBhNNcpqCpRBCzFbzK9hYbdQ==
X-Received: by 2002:a05:600c:1c93:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-47730794401mr11885595e9.4.1761862393262; 
 Thu, 30 Oct 2025 15:13:13 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429b9b436efsm4944576f8f.23.2025.10.30.15.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 15:13:12 -0700 (PDT)
Message-ID: <ac02623e-df6a-4ed0-b973-08267c4e7d68@linaro.org>
Date: Thu, 30 Oct 2025 23:13:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] timers: properly prefix init_clocks()
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20251030173302.1379174-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251030173302.1379174-1-alex.bennee@linaro.org>
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

On 30/10/25 18:33, Alex Bennée wrote:
> Otherwise we run the risk of name clashing, for example with
> stm32l4x5_usart-test.c should we shuffle the includes.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/qemu/timer.h              | 5 +++--
>   tests/unit/test-aio-multithread.c | 2 +-
>   util/main-loop.c                  | 2 +-
>   util/qemu-timer.c                 | 2 +-
>   4 files changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


