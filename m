Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BC8C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfy7e-0005n5-4O; Thu, 06 Feb 2025 04:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfy7c-0005mB-0x
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:24:32 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfy7a-0002fn-E4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:24:31 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso3993165e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738833869; x=1739438669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fKNhj6bAZJIRl/H2MLmtIBXk+VXz7QFWq/juP1WJVu8=;
 b=GffoifZaQU03dHooxwU6ncupDYXdzBvzRrCCvYf4Zo8urGgqedvvtPTHcaQPEa92lL
 VTd6xIIKrq/c3MiU8kwo4XbAp/eZQS/WtGOAo5Ju432v0fiCwYsCb1CkikQydgocq6Nl
 Rv1j99PxYnvokczw3lDaX7tQD5ieDtHfT4ASyAVTs8VK8IKTMqfbckfS72FK1ersQqMY
 Rz5ip5ncORiypd2UUcmdVlUZf+WDxEjheRvXfc5wO9qNGajXwQYltHY8887BXgeLY5Rp
 GrjN3oHjdNY1+dy+gifwCMUSvUFNVRSdGUu0j3ZiplqhJRugz2UiQ0BytPkaetMYOBcQ
 pxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738833869; x=1739438669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fKNhj6bAZJIRl/H2MLmtIBXk+VXz7QFWq/juP1WJVu8=;
 b=gq5koOhQjQ8OoZattzewSe5Q4KVCrEjy0G10UT4aa567AT+kn/HkMF0Kzgm2yfKKJv
 COFCY/K6u6Dh+ARyxp3fC7ti8QA6gFZE5xGrE1I96+sFf+txyGmxeBIU/vnahsoDaDcB
 6bKBUL+rs75LQe0UMlaa3ofYoq1aQxLUDdMA80L6idxZSmOkm1j740+tjlXHaUJ9nSxH
 cJvgQje0tJgK9nW3Y98lL9ssqvEGR/bOTi8PIufXehMBz5BXWG2QUWph7AlxkovNgJT0
 uJku/R9Ga2N8IN1cnDEiuj2YvIsmq4kSuXOBs2LIuuCvo0+ZYQbp2AqpHEhKNF/uKjhY
 PMbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfmWtifOEj35brzz5++R43662Lb84mCj8X81844Tww2D72IF79x1+w5I0yaQSxgZG/xxbiFApzr61O@nongnu.org
X-Gm-Message-State: AOJu0YzVT4sT9ZSgHohio3IH+JvQV9REvrlBRjGGRaxN1Pj8p0JqHoIN
 6SUoMCIlbmTp5h4cd7Z0VfIq7KSjC2/daEXsl0ualVxMPJ3eZVRVAVhDD9OfGJE=
X-Gm-Gg: ASbGncsqcZoKTMzTTSIJ7urYSignuZKx09J2q6WX8ctq1eHtkiLpqThDU7y8caWwCKD
 rHdECOunrFNFxQgiLLfJ9PMMPAXsawDKlQa8HBF/iPCWXW9nBKellHesEicVIL8NYExiuzTZMQW
 LT1KYFME6Di64Od0fQjFguW5+Ylwj2mHpMTG8D83N8HNe1RJ8UsOiOtBiWOWRkLGRRbze9WE8jd
 OXnP01VEEju963hssMShVHcB3Jfi6nhB1l7ApKBfeN6hhyknr17q5aV8Q2FXuz5pmPSbMqmVQfB
 +dH0c/A1L5qwQNZZOR+gGSLT+xCsoRejox2BL2bqhDkwxmxU7194iKJvrjU=
X-Google-Smtp-Source: AGHT+IE4yi180CS03alw6Ui59YoRkduMQd7rHaLwGiXX12QxikHUPnFMDlZzsVn+ABcCZtNJJ6QMGA==
X-Received: by 2002:a05:600c:1393:b0:434:fd01:2e5f with SMTP id
 5b1f17b1804b1-4390d56f60amr48358185e9.29.1738833868893; 
 Thu, 06 Feb 2025 01:24:28 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d966faasm49362345e9.23.2025.02.06.01.24.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 01:24:28 -0800 (PST)
Message-ID: <5b1a3d9a-e898-4dca-bc7a-9a182556b519@linaro.org>
Date: Thu, 6 Feb 2025 10:24:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/17] hw/misc: Support NPCM8XX CLK Module Registers
To: Hao Wu <wuhaotsh@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com,
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com,
 titusr@google.com, chli30@nuvoton.corp-partner.google.com
References: <20250206013105.3228344-1-wuhaotsh@google.com>
 <20250206013105.3228344-14-wuhaotsh@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206013105.3228344-14-wuhaotsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On 6/2/25 02:31, Hao Wu wrote:
> NPCM8XX adds a few new registers and have a different set of reset
> values to the CLK modules. This patch supports them.
> 
> This patch doesn't support the new clock values generated by these
> registers. Currently no modules use these new clock values so they
> are not necessary at this point.
> Implementation of these clocks might be required when implementing
> these modules.
> 
> Reviewed-by: Titus Rwantare <titusr@google.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>   hw/misc/npcm_clk.c         | 113 ++++++++++++++++++++++++++++++++++++-
>   include/hw/misc/npcm_clk.h |  10 +++-
>   2 files changed, 120 insertions(+), 3 deletions(-)


> +enum NPCM8xxCLKRegisters {
> +    NPCM8XX_CLK_CLKEN1,
> +    NPCM8XX_CLK_CLKSEL,
> +    NPCM8XX_CLK_CLKDIV1,
> +    NPCM8XX_CLK_PLLCON0,
> +    NPCM8XX_CLK_PLLCON1,
> +    NPCM8XX_CLK_SWRSTR,
> +    NPCM8XX_CLK_IPSRST1         = 0x20 / sizeof(uint32_t),
> +    NPCM8XX_CLK_IPSRST2,
> +    NPCM8XX_CLK_CLKEN2,
> +    NPCM8XX_CLK_CLKDIV2,
> +    NPCM8XX_CLK_CLKEN3,
> +    NPCM8XX_CLK_IPSRST3,
> +    NPCM8XX_CLK_WD0RCR,
> +    NPCM8XX_CLK_WD1RCR,
> +    NPCM8XX_CLK_WD2RCR,
> +    NPCM8XX_CLK_SWRSTC1,
> +    NPCM8XX_CLK_SWRSTC2,
> +    NPCM8XX_CLK_SWRSTC3,
> +    NPCM8XX_CLK_TIPRSTC,
> +    NPCM8XX_CLK_PLLCON2,
> +    NPCM8XX_CLK_CLKDIV3,
> +    NPCM8XX_CLK_CORSTC,
> +    NPCM8XX_CLK_PLLCONG,
> +    NPCM8XX_CLK_AHBCKFI,
> +    NPCM8XX_CLK_SECCNT,
> +    NPCM8XX_CLK_CNTR25M,
> +    /* Registers unique to NPCM8XX SoC */
> +    NPCM8XX_CLK_CLKEN4,
> +    NPCM8XX_CLK_IPSRST4,
> +    NPCM8XX_CLK_BUSTO,
> +    NPCM8XX_CLK_CLKDIV4,
> +    NPCM8XX_CLK_WD0RCRB,
> +    NPCM8XX_CLK_WD1RCRB,
> +    NPCM8XX_CLK_WD2RCRB,
> +    NPCM8XX_CLK_SWRSTC1B,
> +    NPCM8XX_CLK_SWRSTC2B,
> +    NPCM8XX_CLK_SWRSTC3B,
> +    NPCM8XX_CLK_TIPRSTCB,
> +    NPCM8XX_CLK_CORSTCB,
> +    NPCM8XX_CLK_IPSRSTDIS1,
> +    NPCM8XX_CLK_IPSRSTDIS2,
> +    NPCM8XX_CLK_IPSRSTDIS3,
> +    NPCM8XX_CLK_IPSRSTDIS4,
> +    NPCM8XX_CLK_CLKENDIS1,
> +    NPCM8XX_CLK_CLKENDIS2,
> +    NPCM8XX_CLK_CLKENDIS3,
> +    NPCM8XX_CLK_CLKENDIS4,
> +    NPCM8XX_CLK_THRTL_CNT,
> +    NPCM8XX_CLK_REGS_END,

I suppose by '_END' you mean '_COUNT'. Better define
unrelated to the enum, to avoid confusing static
analyzers:

#define NPCM8XX_CLK_REGS_COUNT (NPCM8XX_CLK_THRTL_CNT + 1)

> +};

