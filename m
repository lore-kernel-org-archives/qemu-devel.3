Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548F2C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsFE-0002Id-Oc; Mon, 05 May 2025 05:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBsEu-0002AK-25
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:35:59 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBsEr-0002s3-Rm
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:35:55 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso2878759f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746437752; x=1747042552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nLFdg+WeKMYJmRI/CsVqOv0HZrGd1voypicygNWAQ2s=;
 b=YaJ9kJo6S3FwZElMUpZl5bPbBFScyNc0DHRqPQKl+ODx2ooXLymU28BuTdg5QeqKfo
 lt1Zf+fwYacmt+MVym4CouvpILGvmoZBNf5HGXphTaxhW3MXj3MAD5ZqMU9Z5F/13oBN
 NuRxKFpY/Gr0SpDBUT3ntbvEURx1MpixQsafgGU+17bFbb/Ffgpe2hSJeqmsBCYHbLoT
 lasMadAdLJFu4oNuWi/9Me1a4vqm8vRGqhMxIZmdYYGofQdThgq6gyx5W8dTIDqYcD+p
 LMSRTwxTy6eyQKslHHE6pdwcWFf1K5HsWH0SE9tOcWyjqv+djkjaAgBoFXuNS8Z6WL5z
 g6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746437752; x=1747042552;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nLFdg+WeKMYJmRI/CsVqOv0HZrGd1voypicygNWAQ2s=;
 b=vu5QsY/BElfKMKSpYfVEoGLptZ+JY+YFX7H0wS87UbtQM5rD0An1hm3keHTilkeiuO
 6zKocZ9CYxoYco6H+sqbZC70H2+rpzYNXc5ah4whuW+KfgX6r4tW8TFx4rvohC/7CKak
 jLM0vJuGV2muNFvZOtowz9/wVfTqCHFcxrZWtZ+sMB70kkIO03Dh3c5cjBzTVlC3PLnW
 iay1L9Sp7EtAO3C+t5xb2ISFoclJv0/jG1Idj50UQKCy8EXDT5cJIPfXIFS6XIKNsmDU
 6WOoqja6phHFcbbOjrKfGMVyVX9MQTzNOauywk3MqAD75E3sl7CJieVlKYUZopDv0y9L
 lOMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuZVN0Z+Loh8Xt38wmcVQNVlpYSwM84cEzHxcYkQ7pyFHZtdjVAAUGzu0QOm4UxIWIwsm8XQ4X3nXP@nongnu.org
X-Gm-Message-State: AOJu0YzpPgwbmp8o4K/xSLKunCy38ZsRcaavgwbIbwzzBdER1apR78Pv
 3hDR0UVXSB1SNLRKBogyK85I2oBVZ9x3YGMofiwyd24Ylux4D/blA+bncVfe1C8=
X-Gm-Gg: ASbGnctsTd274UGiQqEom9mdfKXIPxqcmdUAUpmzAouTmHv1HkpPXZn2L17y8lzuS+y
 ZbrqfUYltUBT3qfp5cSkfYfgVMxNMORhemQgDXbBdQdSfXO/UceVPZ5QDlxelNOy2h7dnmVsSpO
 oveXx8fiDmP0NFgrQN6qmV1Bpa8pzJHMJCiTpfZvVx6Ai3OYf2lEqB6cekxf3CqrdNrOxMboO3U
 GngpWNkUoRTc/7+ZfnzFM+AnhWvLWZCEIvlyourGMi2PjYCVo9KBDs5GwE6YZvSJGK8UCkG+wFR
 /w+mkzl37tCQUx+KEH4dGB1SQ+567leI/o70H9iG5nwPCm625ExVtbvJguYPbX6s8VcYTtN3gck
 bhp8wL0ScE3excVX16g==
X-Google-Smtp-Source: AGHT+IFtTC0XCYAQD074we1L0zBqu3GqHAhdVVpJiCG2oyN5OOr3CQhOWxcjQHPj9C1o3gki4InEag==
X-Received: by 2002:a05:6000:2409:b0:3a0:82d2:2c98 with SMTP id
 ffacd0b85a97d-3a09cf38e7fmr6253970f8f.52.1746437751649; 
 Mon, 05 May 2025 02:35:51 -0700 (PDT)
Received: from [10.194.152.213] (29.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.29]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b2449dsm9740606f8f.101.2025.05.05.02.35.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:35:51 -0700 (PDT)
Message-ID: <3031f1d7-b842-4fee-adde-89a9e824ee57@linaro.org>
Date: Mon, 5 May 2025 11:35:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/23] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250505090635.778785-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250505090635.778785-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Hi Cédric,

On 5/5/25 11:06, Cédric Le Goater wrote:
> The following changes since commit e578dcc7e1590b20a84036afe5bdfa8d23a6048e:
> 
>    pc-bios: Add AST27x0 vBootrom (2025-05-02 09:47:14 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-aspeed-20250505
> 
> for you to fetch changes up to f32ef57f7de98ec36da52b0a13bd5d18ac4bd583:
> 
>    docs: Add support for ast2700fc machine (2025-05-05 09:42:16 +0200)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * Fixed AST2700 SPI model issues
> * Updated SDK images
> * Added FW support to the AST2700 EVB machines
> * Introduced an AST27x0 multi-SoC machine
> 
> ----------------------------------------------------------------
> Jamin Lin (12):
>        tests/functional/aspeed: Update test ASPEED SDK v09.06 for AST2500
>        tests/functional/aspeed: Update test ASPEED SDK v09.06 for AST2600
>        tests/functional/aspeed: Update test ASPEED SDK v03.00 for AST1030
>        hw/arm/aspeed_ast27x0: Rename variable sram_name to name in ast2700 realize
>        tests/functional/aspeed: Move I2C test into shared helper for AST2700 reuse
>        tests/functional/aspeed: Update test ASPEED SDK v09.06
>        tests/functional/aspeed: extract boot and login sequence into helper function
>        hw/arm/aspeed_ast27x0 Introduce vbootrom memory region
>        hw/arm/aspeed: Add support for loading vbootrom image via "-bios"
>        tests/functional/aspeed: Add to test vbootrom for AST2700
>        docs/system/arm/aspeed: move AST2700 content to new section
>        docs/system/arm/aspeed: Support vbootrom for AST2700
> 
> Joe Komlodi (1):
>        hw/ssi/aspeed_smc: Allow 64-bit wide flash accesses
> 
> Steven Lee (9):
>        aspeed: ast27x0: Map unimplemented devices in SoC memory
>        aspeed: ast27x0: Correct hex notation for device addresses
>        hw/intc/aspeed: Add support for AST2700 SSP INTC
>        hw/intc/aspeed: Add support for AST2700 TSP INTC
>        hw/arm/aspeed_ast27x0-ssp: Introduce AST27x0 A1 SSP SoC
>        hw/arm/aspeed_ast27x0-tsp: Introduce AST27x0 A1 TSP SoC
>        hw/arm: Introduce ASPEED AST2700 A1 full core machine
>        tests/function/aspeed: Add functional test for ast2700fc
>        docs: Add support for ast2700fc machine
> 
> Troy Lee (1):
>        hw/arm: ast27x0: Wire up EHCI controllers

If you ever have to send a v2, please remove the 'Change-Id:' tags.

