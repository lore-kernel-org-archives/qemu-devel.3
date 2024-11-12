Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044DCD41D79
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 13:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAr4J-0006q7-Ct; Tue, 12 Nov 2024 08:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAr4D-0006oR-HJ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:36:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAr4B-0001K8-EM
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731418581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pKzBLcMcXHy5XpA8wTRqmi6vMEHO+sLY8chTa4yGjVk=;
 b=FpZflWh31Ns9T8ltGAybZPLSgYN5IhkewzYZSyr85+QGHzwBthgcB0Fmz7eUGhr3UOCjao
 /fNkyKce6B28N5/NVQH7lFuWJHMBEuo0j/KxKiUWhotoLn8RALm1OuTh2rISBrN/4KG3DJ
 eYdeWMOv889FXZshp5O1A4FLgUnf9CE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-8K59gFK3O6mMfPAFBN_ppg-1; Tue, 12 Nov 2024 08:36:19 -0500
X-MC-Unique: 8K59gFK3O6mMfPAFBN_ppg-1
X-Mimecast-MFC-AGG-ID: 8K59gFK3O6mMfPAFBN_ppg
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7180c44f9dfso4831048a34.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 05:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731418578; x=1732023378;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pKzBLcMcXHy5XpA8wTRqmi6vMEHO+sLY8chTa4yGjVk=;
 b=G7TCb+wZW6IjrEoOWpSznciVaY+VSOMq+WMDwIS2Fc8z+Qz2hU5/qLG+GgdTww0NBE
 RZGEZDL4K8g2IcutfOyLx98itg+emsudDI19zMw/kbTr/LnU3kU1A0RB4DhczsDOd/oR
 aRDEtrERG+7AVoHC4G9fDf+CZo57sRpEIRiJVNLZblej0qNHMJV3PNyDhfWS4Uij+BF8
 CJUSdBsQ6HI/r9KRDbYsuD3zENAAgasgOD5sXqvdUteJ7iYnUIGd5Qr6COtTuE9IpQI3
 5OwaQow4KeHl8Af8QBpREw40alK8LpRYxlzz4+1nwYvLAOM+RSwndrDtlJwAAuKtHq/9
 teuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEFZmWCuD/YL0y86aGxA7jl88TjsviVMvY8qdn/vUErXSR1RcDTiq8Sglu/lNBbM2tcCaUIbVSNyAY@nongnu.org
X-Gm-Message-State: AOJu0YzXZgavzhQ93ELaTmTk+rVy/lvom/H6JYroUkHhe9ks5DQff0Of
 EuHJkIgV4KvvIYZaBnVd+LkXoljBrCCYjXA7BOtq84yY4c7JP67f6Q+VphVKkzLaIGM/QGWoTuR
 kdsdud0nXWfNkfhVAVT4bACHlYF0pw0fbTiq2XqT5Jj7RO43kOQMV
X-Received: by 2002:a05:6358:d047:b0:1c3:81a4:d0f7 with SMTP id
 e5c5f4694b2df-1c641f66142mr640595555d.22.1731418578606; 
 Tue, 12 Nov 2024 05:36:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeNFb5EAKNR+DIOpsY1Y7XLCXn8HcwZCqIAtxyEe9wYNhIzOj5ZqtoP1P2eJgMZ0moCB0t0w==
X-Received: by 2002:a05:6358:d047:b0:1c3:81a4:d0f7 with SMTP id
 e5c5f4694b2df-1c641f66142mr640593955d.22.1731418578239; 
 Tue, 12 Nov 2024 05:36:18 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-115.web.vodafone.de.
 [109.42.49.115]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d39643aeb2sm71326836d6.80.2024.11.12.05.36.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 05:36:17 -0800 (PST)
Message-ID: <c2fe0e26-9dcf-458c-926a-5be0a2a39181@redhat.com>
Date: Tue, 12 Nov 2024 14:36:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tests/functional: Remove sleep workarounds from
 Aspeed tests
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241112130246.970281-1-clg@redhat.com>
 <20241112130246.970281-5-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241112130246.970281-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/11/2024 14.02, Cédric Le Goater wrote:
> These were introduced in the avocado tests to workaround read issues
> when interacting with console. They are no longer necessary and we can
> use the expected  "login:" string now.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/test_arm_aspeed.py | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
> index 7644ecbae750..2c9009f686fd 100755
> --- a/tests/functional/test_arm_aspeed.py
> +++ b/tests/functional/test_arm_aspeed.py
> @@ -136,10 +136,8 @@ def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'
>           self.wait_for_console_pattern('lease of 10.0.2.15')
>           # the line before login:
>           self.wait_for_console_pattern(pattern)
> -        time.sleep(0.1)
> -        exec_command(self, 'root')
> -        time.sleep(0.1)
> -        exec_command(self, "passw0rd")
> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
> +        exec_command_and_wait_for_pattern(self, 'passw0rd', '#')
>   
>       def do_test_arm_aspeed_buildroot_poweroff(self):
>           exec_command_and_wait_for_pattern(self, 'poweroff',
> @@ -158,7 +156,7 @@ def test_arm_ast2500_evb_buildroot(self):
>           self.vm.add_args('-device',
>                            'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
>           self.do_test_arm_aspeed_buildroot_start(image_path, '0x0',
> -                                                'Aspeed AST2500 EVB')
> +                                                'ast2500-evb login:')
>   
>           exec_command_and_wait_for_pattern(self,
>                'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
> @@ -188,7 +186,8 @@ def test_arm_ast2600_evb_buildroot(self):
>                            'ds1338,bus=aspeed.i2c.bus.3,address=0x32');
>           self.vm.add_args('-device',
>                            'i2c-echo,bus=aspeed.i2c.bus.3,address=0x42');
> -        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'Aspeed AST2600 EVB')
> +        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00',
> +                                                'ast2600-evb login:')
>   
>           exec_command_and_wait_for_pattern(self,
>                'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
> @@ -210,7 +209,6 @@ def test_arm_ast2600_evb_buildroot(self):
>                'echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-3/new_device',
>                'i2c i2c-3: new_device: Instantiated device slave-24c02 at 0x64');
>           exec_command(self, 'i2cset -y 3 0x42 0x64 0x00 0xaa i');

Could we please wait for the shell prompt here now? i.e.:

          exec_command_and_wait_for_pattern(self,
              'i2cset -y 3 0x42 0x64 0x00 0xaa i', '#')

or something similar?

With such a fix included:
Reviewed-by: Thomas Huth <thuth@redhat.com>


> -        time.sleep(0.1)
>           exec_command_and_wait_for_pattern(self,
>                'hexdump /sys/bus/i2c/devices/3-1064/slave-eeprom',
>                '0000000 ffaa ffff ffff ffff ffff ffff ffff ffff');


