Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DC9C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 16:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uecNu-0007Y4-30; Wed, 23 Jul 2025 12:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uecMg-0006RH-PD
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:30:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uecMe-00016J-1f
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:30:45 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45634205adaso14515e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 09:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753288241; x=1753893041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EQYk6kOfqtibST9KYSIBiUBNtBx7RNFAZiQmFHE7G4Q=;
 b=UAqw+6MPN70dgXQ49EA0AoJhiWi8KO3hrmaosOuI9EyI3v0yBKmo65k1vQTNugKF7T
 V8A17MvgRR4eycpmsHeznPCjWDq99B/UXBE1rUafCN1q3uMKTuxfjPVy46cdXw+jEJPs
 whYwdtXijLX6EGTHuSVDQXgyJOTXyqFin/0rCmROOJ/DgarrAiFVa89atDZus4oGjoec
 WlourMRYgBKYJ4j6vNYeMWoo8e2F8gnu3kZ8aitRnv2kTFjZuKfGEg0NwFrCQH0c5ypD
 p+/HZHujF8fCE1ItqTnqFHlebHsptu8RHso44lozj6KDO5biOYYITY8xWk5rHcJviSTr
 l1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753288241; x=1753893041;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EQYk6kOfqtibST9KYSIBiUBNtBx7RNFAZiQmFHE7G4Q=;
 b=O1vMhI5Y7f+LPXX7HRSyTX8KEP8Ve7ZRX0imwo1Y6IWu2fdB9P6uzdxyNjbUvhtTdZ
 s0kDZgxLfNM6jP93dDdAPvcyOaGUZLPz/fkoZ+xD61FT5q3xyYNKu9Yyh8VIYWNrkapF
 WRCLHQrme/gJnAr3T+NMKsz7qUFF9wot/qYutbfQskXWS2sSpkH1Ow0FRSIrw2QULiwP
 /MVtmT5g9CU4K9lKmdgf7QD6pc1EmgwrvMfJpIe5T84yzuiOCQVeE/h0bUkExuubxiab
 CsI8fpyEgAGP+AoXXuSDc2GNGBBngHrzNkE3a9JpSLssCZ+d+cxPB8+XwOEG+zd13z8M
 t3dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5J49Rb9gQ1U0yrqDqWxSe6CVTpTMTmX4QMfPXxcllBc0aQ5zJIwfO5hMgT07Pe4bMGowklbhXCyRa@nongnu.org
X-Gm-Message-State: AOJu0YyKYXzEJjcnHBuPrB0aoCfthqgZ7hZinThstqBbjej5ggf5DM0p
 omDmhigxaZI3/KHhinx88p6ylzsU6VkcF9mPy3QHBSimmExBI+OM0AF8y1UcCqw84+g=
X-Gm-Gg: ASbGnctM4eJIa+O2su1ubP6htfo+57UbsXhRKUyN0WUh5r7cLlNh6ohmWHv4PR3YLLE
 iPkVEBJPBnMhZ19FYyCl5t3hqcVnGP5lYuOQacUbWMTHenrXkaB1Nn9LoT6pp0Rdu3nv27484Yc
 kuQ0oMG3E7zpqdAmnsHfC3FLBHWWRYWQ1Mgsa+BswnQkDtzBAgKgke6EFJJ/Dl1ffJT7DmdjwCw
 i4qhjslfe2YMSC3p1L9G1qIotmMszywkCTSSnpd2E4dhykCUVBD5HtPK/q67xvW39xLci065bkX
 pcbZ4Ivb/QBNYQrZ8gobm+W/xvGsjK0nATUTJUqfXicqRSxyenpk+OZ82RfkHMzls9gCm4jEg+w
 lr6aHdkbmwarqOm4waF7DEy5Moplrr2jPk4dZPUJMGdUCR7ijOfO/T56WUzoYjawp4Q==
X-Google-Smtp-Source: AGHT+IFR1knPCSTW1Wkdf6jyB5/1useBV3JUaa7YIi2NiLeJdIvuwyB7AAARDup0RRtzgdqkTGBgyQ==
X-Received: by 2002:a05:600c:3544:b0:456:a1b:e906 with SMTP id
 5b1f17b1804b1-45868d78a92mr30825905e9.33.1753288241001; 
 Wed, 23 Jul 2025 09:30:41 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45863a131aasm42698745e9.2.2025.07.23.09.30.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 09:30:40 -0700 (PDT)
Message-ID: <f20200a3-1391-45d9-961d-df2fc5996341@linaro.org>
Date: Wed, 23 Jul 2025 18:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd: print bad s->arglen in unexpected response
To: Ben Dooks <ben.dooks@codethink.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
References: <20250722090547.109117-1-ben.dooks@codethink.co.uk>
 <87seinulb7.fsf@draig.linaro.org>
 <CAFEAcA8c0GRxvXUANBbNvMdTqBwBgCjTZkqc2RNjE8bRQo772w@mail.gmail.com>
 <197dd05a-eda5-44e0-9592-b886e953086f@codethink.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <197dd05a-eda5-44e0-9592-b886e953086f@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Ben,

On 23/7/25 16:55, Ben Dooks wrote:

> I am currently trying to track down two errors with mmc-spi.
> 
> The first looks like u-boot is sending a couple of CMDs (9, 10)
> in the wrong state (currently this works however with a real SD
> card) so I have a tmp-fix in to just ignore the two checks in
> these and u-boot is now working.
> 
> I'm also getting multiple versions of linux failing with QEMU10
> on Debian/testing and my own close to the current git tree with
> Linux and CMD13...
> 
> [    0.579845] EXT4-fs (mmcblk0): INFO: recovery required on readonly 
> filesystem
> [    0.580222] EXT4-fs (mmcblk0): write access will be enabled during 
> recovery
> ssi_sd: error: Unexpected response to cmd 13, arglen=16
> ssi_sd: error: Unexpected response to cmd 13, arglen=16
> ssi_sd: error: Unexpected response to cmd 13, arglen=16
> ssi_sd: error: Unexpected response to cmd 13, arglen=16

CMD13's arg len should be 2 in SSI mode.

> Then the system stops working.
> 
> Systems are riscv sifive_u and my own cva6 machine
Do you mind sharing a reproducer?

Even better if contributed as a functional test :)
(see tests/functional/test_arm_sx1.py for example).

Regards,

Phil.

