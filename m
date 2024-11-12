Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71E6D41D5F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 06:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAkmX-0004ku-C1; Tue, 12 Nov 2024 01:53:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAkmW-0004kc-38
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 01:53:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAkmU-0004SQ-BE
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 01:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731394420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y2XEIL8CP1uIhOHiF/8IqVJzwhwY4J1LX7HMKBaQ70k=;
 b=ZbBOSHRclL5F4QieCWfWRvRxJRwuIQyfI2qxKUqidKdkVbjCoMx38wuJ57ICWldAovdSX3
 CcD2PfsfHNlIe0jT041iP3UWvE9DeguPfzJRfhhRXUjivLlISagSiq8gSQEigMwArVes5f
 uFEzmq4FFAJfGsCe5QVMnmOSt5A5js0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-rS2sy6_SP4Og45EByA5EBQ-1; Tue, 12 Nov 2024 01:53:39 -0500
X-MC-Unique: rS2sy6_SP4Og45EByA5EBQ-1
X-Mimecast-MFC-AGG-ID: rS2sy6_SP4Og45EByA5EBQ
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5c936f71759so3990059a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 22:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731394418; x=1731999218;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y2XEIL8CP1uIhOHiF/8IqVJzwhwY4J1LX7HMKBaQ70k=;
 b=i/o3KQqlfYMuHkrKLSZ75tZMUgM/6JAWvIrggyO2aoYBNpvxRd3ZKtYxSp+B1F2+Ld
 t5xy3VEWnX1ZDKatWmsY2y8dSobNtemmfnmOM7YAIVasLpuq41+XhRaVOlYi8lK0z5zA
 FQqBUl7xthfAQ/J+hdwMNVN9+v8F88bLcUMhGyb59e+YN0va8uNZiHrWdfZA3lKTM/3R
 d5on8nz6pvT5MhTZtzIuctv/Gkc4vxs13+bCIGQ01lYKKlCooHlBJlaMR5nIgcQo6KG7
 T5El2U6fXphi9XMk0Sbq9Tw/9iAdXVYUm2bMe/TmMdCwqnRNTLUNYxb+/0M5URJA89un
 xAVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK+s5AzyfUAxxzGCHD/6EIbbyHROYZeepU17ZeEuwK8xCNcvsy9PskP4E4HMBX3e6vO7rYeX53oYQP@nongnu.org
X-Gm-Message-State: AOJu0YwuY8/iMD/nJZ7xiEDM6Z3BIjkLoODPu822EY9jYZmP6Q25XBuo
 d2BDJzMluKmcBX/TJbgipsb1xDLr5aoKNigYb12WPbP+da893DyPqGNdaJT7qMgUdhojGeCXRPE
 KHXB7lht6/GPlsgUb2jU0fAOJYkildp0xRQgDKMHQEq/Z6kGgVf7E
X-Received: by 2002:a05:6402:40d2:b0:5c9:74e3:acbb with SMTP id
 4fb4d7f45d1cf-5cf0a31b348mr13464742a12.10.1731394418015; 
 Mon, 11 Nov 2024 22:53:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGp3ekWW9aweAjodlnHsLdimrJ3wIVeQNldS4yx44UX+Lt+3WQJ1s6rwEJTWWvzJVT5t2TaiA==
X-Received: by 2002:a05:6402:40d2:b0:5c9:74e3:acbb with SMTP id
 4fb4d7f45d1cf-5cf0a31b348mr13464722a12.10.1731394417623; 
 Mon, 11 Nov 2024 22:53:37 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-175.web.vodafone.de.
 [109.42.50.175]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03bb6dd4sm5664361a12.41.2024.11.11.22.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 22:53:37 -0800 (PST)
Message-ID: <e556df7b-86c6-487d-b64a-03d0e698f973@redhat.com>
Date: Tue, 12 Nov 2024 07:53:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] tests/functional: Convert Aspeed aarch64 SDK tests
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241112062806.838717-1-clg@redhat.com>
 <20241112062806.838717-3-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241112062806.838717-3-clg@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/11/2024 07.28, Cédric Le Goater wrote:
> Drop the SSH connection which was introduced in the avocado tests to
> workaround read issues when interacting with console.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/avocado/machine_aspeed.py         | 78 --------------------
>   tests/functional/meson.build            |  2 +
>   tests/functional/test_aarch64_aspeed.py | 97 +++++++++++++++++++++++++
>   3 files changed, 99 insertions(+), 78 deletions(-)
>   create mode 100644 tests/functional/test_aarch64_aspeed.py
> 
> diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
> index 241ef180affc..2240c82abff9 100644
> --- a/tests/avocado/machine_aspeed.py
> +++ b/tests/avocado/machine_aspeed.py
> @@ -59,17 +59,6 @@ def do_test_arm_aspeed_sdk_start(self, image):
>               self, 'boot', '## Loading kernel from FIT Image')
>           self.wait_for_console_pattern('Starting kernel ...')
>   
> -    def do_test_aarch64_aspeed_sdk_start(self, image):
> -        self.vm.set_console()
> -        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
> -                         '-net', 'nic', '-net', 'user,hostfwd=:127.0.0.1:0-:22')
> -
> -        self.vm.launch()
> -
> -        self.wait_for_console_pattern('U-Boot 2023.10')
> -        self.wait_for_console_pattern('## Loading kernel from FIT Image')
> -        self.wait_for_console_pattern('Starting kernel ...')
> -
>       @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
>       def test_arm_ast2500_evb_sdk(self):
>           """
> @@ -133,70 +122,3 @@ def test_arm_ast2600_evb_sdk(self):
>           year = time.strftime("%Y")
>           self.ssh_command_output_contains('/sbin/hwclock -f /dev/rtc1', year);
>   
> -    def test_aarch64_ast2700_evb_sdk_v09_02(self):
> -        """
> -        :avocado: tags=arch:aarch64
> -        :avocado: tags=machine:ast2700-evb
> -        """
> -
> -        image_url = ('https://github.com/AspeedTech-BMC/openbmc/releases/'
> -                     'download/v09.02/ast2700-default-obmc.tar.gz')
> -        image_hash = 'ac969c2602f4e6bdb69562ff466b89ae3fe1d86e1f6797bb7969d787f82116a7'
> -        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
> -                                      algorithm='sha256')
> -        archive.extract(image_path, self.workdir)
> -
> -        num_cpu = 4
> -        image_dir = self.workdir + '/ast2700-default/'
> -        uboot_size = os.path.getsize(image_dir + 'u-boot-nodtb.bin')
> -        uboot_dtb_load_addr = hex(0x400000000 + uboot_size)
> -
> -        load_images_list = [
> -            {
> -                'addr': '0x400000000',
> -                'file': image_dir + 'u-boot-nodtb.bin'
> -            },
> -            {
> -                'addr': str(uboot_dtb_load_addr),
> -                'file': image_dir + 'u-boot.dtb'
> -            },
> -            {
> -                'addr': '0x430000000',
> -                'file': image_dir + 'bl31.bin'
> -            },
> -            {
> -                'addr': '0x430080000',
> -                'file': image_dir + 'optee/tee-raw.bin'
> -            }
> -        ]
> -
> -        for load_image in load_images_list:
> -            addr = load_image['addr']
> -            file = load_image['file']
> -            self.vm.add_args('-device',
> -                             f'loader,force-raw=on,addr={addr},file={file}')
> -
> -        for i in range(num_cpu):
> -            self.vm.add_args('-device',
> -                             f'loader,addr=0x430000000,cpu-num={i}')
> -
> -        self.vm.add_args('-smp', str(num_cpu))
> -        self.vm.add_args('-device',
> -                         'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
> -        self.do_test_aarch64_aspeed_sdk_start(image_dir + 'image-bmc')
> -        self.wait_for_console_pattern('nodistro.0 ast2700-default ttyS12')
> -
> -        self.ssh_connect('root', '0penBmc', False)
> -        self.ssh_command('dmesg -c > /dev/null')
> -
> -        self.ssh_command_output_contains(
> -            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device '
> -            '&& dmesg -c',
> -            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d');
> -
> -        self.ssh_command_output_contains(
> -            'cat /sys/class/hwmon/hwmon20/temp1_input', '0')
> -        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
> -                    property='temperature', value=18000)
> -        self.ssh_command_output_contains(
> -            'cat /sys/class/hwmon/hwmon20/temp1_input', '18000')
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 758145d1e5fa..c035eba4f9b8 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -11,6 +11,7 @@ endif
>   
>   # Timeouts for individual tests that can be slow e.g. with debugging enabled
>   test_timeouts = {
> +  'aarch64_aspeed' : 600,
>     'aarch64_raspi4' : 480,
>     'aarch64_sbsaref_alpine' : 720,
>     'aarch64_sbsaref_freebsd' : 720,
> @@ -47,6 +48,7 @@ tests_generic_bsduser = [
>   ]
>   
>   tests_aarch64_system_thorough = [
> +  'aarch64_aspeed',
>     'aarch64_raspi3',
>     'aarch64_raspi4',
>     'aarch64_sbsaref',
> diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
> new file mode 100644
> index 000000000000..c61e34242d5a
> --- /dev/null
> +++ b/tests/functional/test_aarch64_aspeed.py
> @@ -0,0 +1,97 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED SoCs with firmware
> +#
> +# Copyright (C) 2022 ASPEED Technology Inc
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import sys
> +import os
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +from qemu_test import exec_command_and_wait_for_pattern
> +from qemu_test.utils import archive_extract
> +
> +class AST2x00MachineSDK(QemuSystemTest):
> +
> +    def do_test_aarch64_aspeed_sdk_start(self, image):
> +        self.vm.set_console()
> +        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
> +                         '-net', 'nic', '-snapshot')

Running QEMU with just "-net nic" but no other "-net" option normally 
produces a warning à la "warning: hub 0 is not connected to host network" 
... it's likely hidden in a log file here, so it does not really matter, but 
in case you respin the series anyway, you could maybe also try without the 
"-net nic" here.

Anyway,
Reviewed-by: Thomas Huth <thuth@redhat.com>


