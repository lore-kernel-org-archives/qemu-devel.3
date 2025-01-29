Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990E2C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdC5Z-0000aU-Lf; Wed, 29 Jan 2025 12:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC5X-0000VY-GC
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:42:55 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC5W-00046q-1u
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:42:55 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436341f575fso80304965e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172572; x=1738777372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W/4msfo+qvYPmEPvMWEBWlr7sfTxY/jzDjeDBRkXeG0=;
 b=FqdQrbkIMsfs6RAlqm/e7lyhfWqpPOmQoyry+vI9L8uHzkC/hy4M7gRzM/r8NhPPKO
 PUEa61Ns1Mkbn0+9hfX+OsGXEQjdX3xOq1DYibkXnxxkMWdCdpKC3UOuh39sOFa4j2f0
 EIhCq6kKkfwewHP81X2chHVksXlzB5FUum7+w4ZqTV0/S0kxPzI9viKcwWPUDjdEYLjf
 8Lyi4+zBYnDbrYHCvgTntyyjFJp6M8bDaWxT83XoBW6cNJ9Ul5o5gW17tk7yYVH34/Ha
 UdXc8jN6R/2kw6Y0gq9MsCAAtK1teMazWwau1gR7qPcen3BiNvqTJn5nPGFBjVPFgcYC
 /LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172572; x=1738777372;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W/4msfo+qvYPmEPvMWEBWlr7sfTxY/jzDjeDBRkXeG0=;
 b=hFp4oE7fqUEQRxeXbWr3vV1cMSnglDRZGTCbQuqsSGemCnDQyHrjkbMhnst4Fl0nUp
 ldEvKfjboO0/Y1dWEU9PbQnhDh6yY4gFPchufZ6x4tinAnyf6mCFEEfEQPV7JVG2Qge3
 SSYy2J7WMC+n41LsD74AGRwx4Qf7vcPGfFO4aC5EsyiZOwlMIE0n7PWDGV3i3aX2DT8E
 JwFl0jko/ZV6LMLH+4pcfpuI/KPtn4aCgqgJ6gL949k79NhIVkAb+2oTMN7ggvg+68N0
 08ospKCHwgMAm9RTu5SEm/BCSQOnJPRNFGleZMW9CnARmmlhdmCsZf5dwX4Q1Wi5GGEM
 /6XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNk33SlNdz9EhAdUNrciXA+NBfEzoeQzfnoJK6dqHGZ3kuKto/HW2QUsxhr/uHEeNLBdZ7MMM7NgMZ@nongnu.org
X-Gm-Message-State: AOJu0YxqpOryJH0Wvk4dsTBnM9IMrbXkAR+mSJMU07H/rDNLm4orjfYd
 NOOYVsoYnhL0oY8yrsdKbI1WgdlXkNKuzH5HadM/g4d2HwoPn02u6l/E2Cwmn8k=
X-Gm-Gg: ASbGncu6G+QzZTXcNK2uUFWZdMZx4UzQZcvOJuxBwpfx0wEWg55uNA0AQ8NEDBidbcd
 tFgRegHgHbt6vLcKozXaETXjP7Xhp0hQpSD67YfA0SAewzB9L0aVd4jFSgdG2g7/EgpZ3a0F44g
 T8MV83DiIpmEIQ0JzHNjAOg7pLJ+sunuVoGNQmNVZRsz4JAwbcQ0A6X/zZZLKiJZHG+NA2AeHZg
 pI65d2OZWbIEClszGcjHpe0Cly8rSiMlmjXIgf6d+ym01KaEH8TzGUvICOXlthycmK5ifNGCZiJ
 Jtzm8DGmpjJQS43shof9DXhqQAYxBC7Z4NVHZ6JKrbpSAZYO/QcOrw30ypI=
X-Google-Smtp-Source: AGHT+IE0Wy74BnNXTW8L//S4GXv+MdEZZ57Yz24TfmF0ZK5V7xNFfpAFstD2DMwWyFr18/lHGtW1zA==
X-Received: by 2002:a05:600c:4f55:b0:434:a1d3:a321 with SMTP id
 5b1f17b1804b1-438dc3aada7mr39276465e9.3.1738172572512; 
 Wed, 29 Jan 2025 09:42:52 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc518ddsm31472905e9.37.2025.01.29.09.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:42:51 -0800 (PST)
Message-ID: <3f3af28c-d024-478a-9394-382ecba503dd@linaro.org>
Date: Wed, 29 Jan 2025 18:42:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/34] target/arm: Rename FPST_FPCR_AH* to FPST_AH*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 29/1/25 02:38, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h     | 14 +++++++-------
>   target/arm/tcg/translate-a64.c |  8 ++++----
>   target/arm/tcg/translate-sve.c |  8 ++++----
>   3 files changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


