Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AA8CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKLP-0002EG-Br; Tue, 04 Nov 2025 11:57:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKLK-0002DY-Ho
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:57:14 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKLH-0006QM-0F
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:57:13 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b719ca8cb8dso230770766b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762275427; x=1762880227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Tn9FyySxwsl7mmNEcQ7XGbxGTEfSqgDvAZ6QyoxlO0=;
 b=k65TL7XiKjQMxxIp/VALis6fNuAc6UTpMyA4ktzkIT6WaOhceWu24DRgt5ML9DUdPF
 xZ546K9pLwzd971ptCqxCI2O28+jUYAJoWA5ZQHYU/KkWhGzPHzPXjl//V1a+r6UOsqs
 M+gZKRZc9aE3XZUMhlJ9acUSYjhqTvgwtGMdgTWhTEr82XPOM/YR/yGgsLwX4ScIjmVl
 zWsz1oCHkPGrdWuoDTWVaJveHO112Cu+pcNWsLLhd0L88CnTJt0iEI5v0vmg9yQPTQqT
 4rib+jPlVmd53wEgUG8hhIWN2mqRRxNmjtj7EXdWYXLo2QAxqlPAt1XPb+LOm4UIhZ92
 o7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762275427; x=1762880227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Tn9FyySxwsl7mmNEcQ7XGbxGTEfSqgDvAZ6QyoxlO0=;
 b=GLIbXaxklnUo4Qu3pWH+Zao80W4HfRRQwX5KQHRZjBWHLBg86XoftmY/xNyyU557oY
 dXhGNIEoUZruW/J7YIe6Mt7IHzCBSR4yJyKlPOX9UVStjUAz+8hGXv1yCPCqfEz/6DuT
 WYap8efwM5L04W+f2CPV5u7HCsQoYOpNkYFyvDqhe5ezRhdZDPmBmRswKVxZyw36Qe/e
 /0lcuY/q10bdGeA1PMAdLdzD5k/a333D+/nkc+y1QW9SHmPrP+CzA6MGb9ZLfRNRT0xn
 eX1ToaH/pD7OTDpvX3bPlg89IM3SumW0sPYt3rVYKzU7g7q33px7RcWbgRrbsl3Skzqg
 5vhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw69IqIm6ai1ZC80trdpxCSHL3g+RMME7fcf604ktdeYHnJWEqtCY0JxS3HdrmfyzESyWzNj2RDoat@nongnu.org
X-Gm-Message-State: AOJu0YzdAcO1lCbcYuKvgwz6a4udNtn5Dk461tsRzNf8uXXWtAbegUhP
 G3AHFxlXfYSaNDVsV6HUfLRlJ/O+RfW8eZKXQD4ncZIWh+rP5O59uppLMiSw3gE7bcA=
X-Gm-Gg: ASbGncusptCkDl6o5WN3d3ky/lmfmYNincFI8pludJtQWWA4k+ZKhyzRlSTkZvEChqJ
 Ol8q3wnsgqrtXTUJh0850Do4TBuS5oEicyNhbx09bhkEf4Jh+MexlX/d8PNQvoy7CKDmpNyG0S1
 iRpwOR5JItePz0OkA4c6TkNXeVjtZ7mIbPYkOyhnW9bva2nh4l6h7DHiXNCfUGb23q3RkgQZOZP
 AWLDai7op9cSFTtq0u76dRYOimeBFtgHsTMryMs8RIHRo0u6u89iznq3l1yLZanHcf7Z5vrQU0W
 qJzt006VsBE0RU7fCbUmopW7o+rjJfmTaIS5mOx3NvZcA4vyLdfi/mZl/0/rQ2JymDmxjxhUVex
 /u/kZE6AB703NK9qfgpp8YIIXl03EMV7jgfdnb48bzef2aXycm/Dnw2KTJU5ruWdaA5sFmaHO+/
 0nQoAZDd1ULgi4z6CshLk=
X-Google-Smtp-Source: AGHT+IEaB3aWICT+b7L+TM/DTX21Lo1aBlpp0xUzSy4UP95CLlrsnIm/9UO2P8JrSzvNwNVwhqLKTQ==
X-Received: by 2002:a17:907:2d89:b0:b71:c2be:3dd7 with SMTP id
 a640c23a62f3a-b71c2be49dcmr578445566b.25.1762275427459; 
 Tue, 04 Nov 2025 08:57:07 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7240751077sm255828166b.75.2025.11.04.08.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 08:57:06 -0800 (PST)
Message-ID: <b9121cd6-75b3-4c5f-ae13-ba995de34872@linaro.org>
Date: Tue, 4 Nov 2025 17:57:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] docs: Add eMMC device model description
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
 <b9c3ff21e7170fef5d0e7d08698a113d2a64e649.1762261430.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b9c3ff21e7170fef5d0e7d08698a113d2a64e649.1762261430.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 4/11/25 14:03, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/system/device-emulation.rst |  1 +
>   docs/system/devices/emmc.rst     | 53 ++++++++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+)
>   create mode 100644 docs/system/devices/emmc.rst
> 
> diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
> index db714ad47a..971325527a 100644
> --- a/docs/system/device-emulation.rst
> +++ b/docs/system/device-emulation.rst
> @@ -88,6 +88,7 @@ Emulated Devices
>      devices/canokey.rst
>      devices/ccid.rst
>      devices/cxl.rst
> +   devices/emmc.rst
>      devices/igb.rst
>      devices/ivshmem-flat.rst
>      devices/ivshmem.rst
> diff --git a/docs/system/devices/emmc.rst b/docs/system/devices/emmc.rst
> new file mode 100644
> index 0000000000..7e15b62270
> --- /dev/null
> +++ b/docs/system/devices/emmc.rst
> @@ -0,0 +1,53 @@

I'll getting:

WARNING: Does new file 'docs/system/devices/emmc.rst' need 
'SPDX-License-Identifier'?

Should I add (on your behalf):

.. SPDX-License-Identifier: GPL-2.0-or-later

?

> +==============
> +eMMC Emulation
> +==============
> +

