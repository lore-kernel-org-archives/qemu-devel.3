Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC83DC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU54x-0001in-6e; Wed, 17 Jul 2024 09:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU54o-0001FH-Ba
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:52:15 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU54m-0004Xm-5V
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:52:14 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2eefc3d707dso9111781fa.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721224330; x=1721829130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o3prwc8i8KjPKTzImRLqp5LTDSxC5nsQLP1EJDs9kRI=;
 b=l4vvT7lleG48pbyvbKnFBNA+iEbeMY2bbZkceLTsHr2okB5S/UD0f9QH/WqXAUl8sM
 UleZpnHZU2WsjAIKU53ZccY5XD0U4804KQOPb6ioj2nMog56Vk4DL5B6bB1TwIqZkA39
 9lVjEUKyUl48s0a3nG5S2f3BXhydsx/iT/7jTnuXnKVK/t7WYCgqp7sParUMSoCJm256
 BQfxkXM+TXsjiC3wGuiKIuF0nRoT+BzauQd7TbNghSKNd3FNfGfCcQBfdpO/frCJHpKd
 T1+rSJoPLGC7JHAyoCoCRLyHwhrA2ookQpviuMcT/M4cTSsB8pnhUq/1ztaIXY13j4fc
 ycRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721224330; x=1721829130;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o3prwc8i8KjPKTzImRLqp5LTDSxC5nsQLP1EJDs9kRI=;
 b=JEe9zwb2H0kj2MrHlGWB8+ss9wswWWT2UjHwSnd+BUHy22ems/dLGWBeX8E3nL8GaS
 Nv9F+l9osJUI9ux782dLrixqSQidMQY+EACeDSF8IDOQNE7tCF9QWK4Maljg4lJGn1in
 86oldMUiLSczWvN91pISQj/D+MtzQYMI5ib4jwce3w/9u7LkY4qmxzMGkdi49i4p6nSD
 jbAd8iPfTJkcao6Me8pQvcQaqJ9x7ACtx7PqVQY0jQwjpQyV1UusBaL6canPQDK5ZNBq
 Zj4TLWWbHeYQ0IXPSEpFL8UeecUVVmM8g7IzZ9nvkUashOn353Po/RU3LMozv0K9XyhS
 9Wiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt9Wp3ICs7gMo7Lr1/V1YEGz5iC8cejaM8tBvJlY9fL5iIw/0Y3qOt7b88Mjzzh1V8NEnPGez9zoo3qMxVgL+Hpoz+ZKw=
X-Gm-Message-State: AOJu0YzjbPrpYDTmMvvAcK6Si0iO+Z0GIbIGoUZlyIi4kkk9aakP3QZQ
 SC3wyIQZclT2swo5yuHKfzmYCKYrVvmAQhYiUqzsLd1dv7EUd5pYugwNnRkVWEw=
X-Google-Smtp-Source: AGHT+IGZRjysXRm2iETp29EQpWRAhgGDcvUw/m+mxJztUrYV6VoSTRv5vbYqyPZM2m8rBCpe5ClbwQ==
X-Received: by 2002:a2e:a4b7:0:b0:2ee:8407:2f58 with SMTP id
 38308e7fff4ca-2eefd09f9c9mr11735041fa.17.1721224329461; 
 Wed, 17 Jul 2024 06:52:09 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5edb41asm170699155e9.36.2024.07.17.06.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 06:52:09 -0700 (PDT)
Message-ID: <55050833-24d4-47d1-af16-5033ff8ad4aa@linaro.org>
Date: Wed, 17 Jul 2024 15:52:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/machine_aspeed.py: Add eMMC boot tests
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240717130657.648701-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240717130657.648701-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

On 17/7/24 15:06, Cédric Le Goater wrote:
> The image was built using the process described in commit c8cb19876d3e
> ("hw/sd/sdcard: Support boot area in emmc image") with artefacts from
> the latest successful build of the IBM P10 BMC platform available on:
> 
>    https://jenkins.openbmc.org/job/ci-openbmc/distro=ubuntu,label=docker-builder,target=p10bmc/lastSuccessfulBuild/
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---

BTW this patch is

Based-on: <20240717063022.549849-1-clg@redhat.com>

>   tests/avocado/machine_aspeed.py | 38 +++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
> index f66ad38d3503..1deb8472818f 100644
> --- a/tests/avocado/machine_aspeed.py
> +++ b/tests/avocado/machine_aspeed.py
> @@ -439,3 +439,41 @@ def test_aarch64_ast2700_evb_sdk_v09_02(self):
>           self.wait_for_console_pattern('nodistro.0 ast2700-default ttyS12')
>           self.ssh_connect('root', '0penBmc', False)
>   
> +class AST2x00MachineMMC(QemuSystemTest):
> +
> +    timeout = 240
> +
> +    def wait_for_console_pattern(self, success_message, vm=None):
> +        wait_for_console_pattern(self, success_message,
> +                                 failure_message='Kernel panic - not syncing',
> +                                 vm=vm)
> +
> +    def test_arm_aspeed_emmc_boot(self):
> +        """
> +        :avocado: tags=arch:arm
> +        :avocado: tags=machine:rainier-bmc
> +        """
> +
> +        image_url = ('https://fileserver.linaro.org/s/B6pJTwWEkzSDi36/download/'
> +                     'mmc-p10bmc-20240617.qcow2')
> +        image_hash = ('d523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b')
> +        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
> +                                      algorithm='sha256')
> +
> +        self.require_netdev('user')
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-drive',
> +                         'file=' + image_path + ',if=sd,id=sd2,index=2',
> +                         '-net', 'nic', '-net', 'user')
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('U-Boot SPL 2019.04')
> +        self.wait_for_console_pattern('Trying to boot from MMC1')
> +        self.wait_for_console_pattern('U-Boot 2019.04')
> +        self.wait_for_console_pattern('eMMC 2nd Boot')
> +        self.wait_for_console_pattern('## Loading kernel from FIT Image')
> +        self.wait_for_console_pattern('Starting kernel ...')
> +        self.wait_for_console_pattern('Booting Linux on physical CPU 0xf00')
> +        self.wait_for_console_pattern('mmcblk0: p1 p2 p3 p4 p5 p6 p7')
> +        self.wait_for_console_pattern('IBM eBMC (OpenBMC for IBM Enterprise')


