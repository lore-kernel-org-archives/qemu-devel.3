Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48C3C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBs9y-0005U0-2i; Mon, 05 May 2025 05:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBs9v-0005Qc-Ty
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:30:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBs9t-0001yx-CJ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:30:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso25655815e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746437443; x=1747042243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qv3rq5yGh2mLBRhb+E3fQnVk4ENFL4Q1j6/V3C5+lP0=;
 b=Puqllv8MVWXjgnZ8Cq/OHHoxvYesyU86v4an2vlF2cRx7+l1pUJb9zkjsIvNxQTWea
 yt0owBYnT8H/ytzpkM4GSYO3M8j6Gne1tEwj0/pTon8o/bQEkFHBkyFHDn6HuQMfT3oi
 0BPvYl/TZBgOMYwZqhcRtXIxTCdqS4EV3SoEgWBDvBT5KcDdixIMwgdnDakcFLL1mNzi
 sawpXYzzW9tddM5pzp+xfuMsmL5V6eQFdb+5H5lttQJKqRjlscXbYL/CHZIe4MvKCTYV
 XGT9Sszb2aDnZSUViHVh71PCNZ8aQfCcT1EuBhyU6JFujgvnNNulf3eyqEg9Nq76kumC
 nRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746437443; x=1747042243;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qv3rq5yGh2mLBRhb+E3fQnVk4ENFL4Q1j6/V3C5+lP0=;
 b=qCeRSM6Atc8d97Sy72Ovc4zzbPnHojrzv9GZDfwvh17g/IoJ+49nAA0aCUWPtpJRP6
 /+pLiaBd2a+s+L6VFR2RcdvXQhNtCRiIN+eGCbrWRG8BiIQ4QinVwpYMmhT1vOEmJBCo
 Ohp36eGWFUX6bvrx0Hqvde/PEDmBK+uninpoV0MeF6fpgm9GuGTyI6d4LvYnr+qEsx+h
 snBjobFicEwqyDm5WgnTU7r+byEtJdqUhtVBr8T3lblVWZr05tPJvKkCIuskPFH3c+Vh
 q7h2NajP7pyvh6UcIL4mkyV9BBqQmBs0/xdzkzKqn1GdYh9MnAKyHICvKZ0+J28k6hNn
 kBxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBJ+C04OKSlKWmcGYYAh7kY4NQUPRnPFa8vg5bgeijYSzLgjEpHdZRRnkC+jozNHtR5htRQ6ZeXC1N@nongnu.org
X-Gm-Message-State: AOJu0Yw/BnukcPZz+N219zcVwJU9kwyZcaJgq0D5hLi5PyOwZ9zTDYZ0
 vcmfNQWIeTeTzx4A8CDjep3HOUgCU7lYUMvEl/B+un8c+aXWf6SKEz8ZUBvANVQ=
X-Gm-Gg: ASbGncs8B47N8PIvD8O8yNQJf2ehu+ovEKIoPXrwvotf3QxgDppuxzTEziAAjatsh6N
 wzE8PLDr6Gk6iE2GDknkFVE1sMtIwTh6mMsz24iqbjXq6ocaaxdOA7OglekMvT/YhUoIY/nWdWY
 YUm0eURpyzVz/N7y+LgWlZo5p5rVsDzduxgICxK33///r1BJ6a6BtxAIB1orx5sB5eVMED0voMz
 6Zxl/fBtnOD+C754D5TglbepEROv2lIYeEE1QCdO3eeJnVBHqyoJTJCCvp/HeoxE1BT2ZONKWIs
 SJl8KU39USWd5xSMUMgIy2EeUDw7WNZQAXddG4b+VJJZ905isXb5NJFRRp9cfFNHF/NTCVHYtCD
 bR5sqTj3up737e6kHxg==
X-Google-Smtp-Source: AGHT+IHYQqUUw6smWsL2tCLcD9FS1HDmQRZT2fUBKhr9NkCSk/o3UL5zSzX6GvJYWhfOiq3IUGNUhg==
X-Received: by 2002:a05:600c:3acd:b0:43b:c6a7:ac60 with SMTP id
 5b1f17b1804b1-441bb88c9f1mr93095225e9.10.1746437442874; 
 Mon, 05 May 2025 02:30:42 -0700 (PDT)
Received: from [10.194.152.213] (29.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.29]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0b9fsm9635389f8f.4.2025.05.05.02.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:30:42 -0700 (PDT)
Message-ID: <bd2c7755-7662-4b18-9bea-e019955bd645@linaro.org>
Date: Mon, 5 May 2025 11:30:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] aspeed: ast27x0: Correct hex notation for device
 addresses
To: Steven Lee <steven_lee@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, longzl2@lenovo.com, yunlin.tang@aspeedtech.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20250502103449.3091642-1-steven_lee@aspeedtech.com>
 <20250502103449.3091642-3-steven_lee@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250502103449.3091642-3-steven_lee@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 2/5/25 12:34, Steven Lee via wrote:
> Corrected the hexadecimal notation for several device addresses in the
> aspeed_soc_ast2700_memmap array by changing the uppercase 'X' to
> lowercase 'x'.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Change-Id: I45426e18ea8e68d7ccdf9b60c4ea235c4da33cc3

What is this 'Change-Id' tag for?

> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/arm/aspeed_ast27x0.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)


