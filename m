Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22601C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 11:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7C0H-0000vO-Mc; Tue, 22 Apr 2025 07:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7C0B-0000ta-LE
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 07:41:23 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7C09-00089p-FV
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 07:41:23 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so6356391f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 04:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745322079; x=1745926879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zI20vdCU3DZBX4N2VwQ9zKRVDbYA6xrFjzmm8KOiBBk=;
 b=n9DiUXpBzFarlvPXqaTuHsfZ/0IO0EiTsgIkL6llsHVFqZ/U9kvBEViSbZ6KnCAXw6
 fteevWPPD3DzQgxW+wpsLElDFAnBWmfVOaNPU8IgGXnN31I33OIDQpqEjEI93gbKm0WD
 OPfWgznG/BuyxDaKNBl1d5OZloDBJGIeODKu91B8y6FJpBLKEYNVqLGg/9tzii7cywwJ
 G07rOqrXB6sWcMIhigpBbXfKbQQqxJw1P44DSQnM1/6Le79XS+Dw8V8o1U9riC7eAgzP
 gu6VdiYRe3FcO6VNAw5shBrgxln0NFPZFIu3NNkeNgC+KdI1T0NAdO2kJHQ3+z3AfVMx
 pbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745322079; x=1745926879;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zI20vdCU3DZBX4N2VwQ9zKRVDbYA6xrFjzmm8KOiBBk=;
 b=mlCtw4nvf/6AETIY4BB3pp4/iSvJk7cTF9YkiqVgtkIt2Jl6NMuNG1FtApqwSZwlcj
 C8eAW1tJ4ng+USOoMgKQQwcyHYe7p/OLADB2Yoy2LlRs/5T134E8eN2Q4Y5QZBZIV9S4
 CwF82aYzxv68SdmTFA95/rlFDg0SSkAaAkVTDb50OZH5F4XZAsx+H+LEVy8oGX/LfHUd
 OFMZJge9cEi4Y63Q3v1dkIx77vQNhqCr3+9I1bIfombBXM47sk2UMu3GLlVCq1gvtKwZ
 jUL5TVnFyU0aZtsEocxCb1SEjRcJeAW4A+oa6NaUgOGMjyW2ZYZyUqstLfCnyQcSAl0p
 DtvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe4odZHZ+KXsBZode6snjLfxCxQdphP3XlhLTx71lITK4U/H78We5vSmQemT8mESBDWDGtqr/pvufd@nongnu.org
X-Gm-Message-State: AOJu0YxlqcPLzvwiI8rwhfwfMlZsdeTL3NIE6oBD7e32FJPE6UIJMF4q
 4e+/+qKljytw+dgim4NCmgfC9nzO7W05vq6GbxNFocOCsKz5XcyP55jnbTwb7S8=
X-Gm-Gg: ASbGnctcpil1N8I2U3/lORPtXQgrx2Hz34s3M4CP5EcmATU68Rlv9JM5lFKGU743lFu
 HsYsniur0cLtc1KpsLqM7zMzHk6iR9HHLxhTT4WbuHxNxuK6m4M89UVeybENcHmxY5Yn1bIF0Z/
 caIsdYx7YRmcJTdaMyI8CJCDsoyu3+igOebDQzsvAU+Yhz+XkRPY5NZ/7DLAZDhRRRC2a6jnHfc
 xOHuT7ikHuhT25YINsh5zDsLSQdF82j+fotxDz6wooOnN42tD0AQFMkuX1z8KbF4fiKb0C/XsdO
 Q/W7owxKc0W/33E4b0CWd4FMBH6LZyP6sIz2/F7VEssHRbdjsdgOfR1ckNywjNo2zK4ssJARi2G
 xPnkAy9khezTcsSHNHvQ=
X-Google-Smtp-Source: AGHT+IFoS2GGweEN40zCwyN56b9Zmb3jMNX6Hr985qCxZA31Vfohf6usZqIRA5oRbqdtZrqfWpfL1A==
X-Received: by 2002:a05:6000:4201:b0:391:456b:6ab7 with SMTP id
 ffacd0b85a97d-39efba5db9bmr10960878f8f.34.1745322078900; 
 Tue, 22 Apr 2025 04:41:18 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5cf313sm171554275e9.30.2025.04.22.04.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 04:41:18 -0700 (PDT)
Message-ID: <495a29ff-c87d-4a69-96ba-c3ef1d6ce3d8@linaro.org>
Date: Tue, 22 Apr 2025 13:41:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] tests/functional/aspeed: Update test ASPEED SDK
 v03.00 for AST1030
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250422091504.3666464-1-jamin_lin@aspeedtech.com>
 <20250422091504.3666464-4-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422091504.3666464-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Hi Jamin,

On 22/4/25 11:15, Jamin Lin via wrote:
> Updated test to target SDK version v03.00.
> Removed redundant test case to simplify validation.

> Cleaned up unsupported shell commands.

Does that mean coverage is reduced?

> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/functional/test_arm_aspeed_ast1030.py | 40 ++++-----------------
>   1 file changed, 7 insertions(+), 33 deletions(-)


> @@ -49,17 +30,10 @@ def test_ast1030_zephyros_1_07(self):
>           self.wait_for_console_pattern("Booting Zephyr OS")
>           for shell_cmd in [
>                   'kernel stacks',
> -                'otp info conf',
> -                'otp info scu',
>                   'hwinfo devid',
>                   'crypto aes256_cbc_vault',
> -                'random get',
> -                'jtag JTAG1 sw_xfer high TMS',
> -                'adc ADC0 resolution 12',
> -                'adc ADC0 read 42',
> -                'adc ADC1 read 69',
> -                'i2c scan I2C_0',
> -                'i3c attach I3C_0',
> +                'jtag jtag@7e6e4100 sw_xfer high TMS',
> +                'iic scan i2c@7e7b0080',
>                   'hash test',
>                   'kernel uptime',
>                   'kernel reboot warm',


