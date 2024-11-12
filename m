Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0235D41D66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 08:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAlqt-0001Y7-A4; Tue, 12 Nov 2024 03:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tAlqn-0001W8-Kv
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 03:02:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tAlql-0006uy-8c
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 03:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731398530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xn1Qjs/PYtU/aSg+0PL60+R7uDxL90Q0YwjYY3lU/hI=;
 b=OklZpiywnqNnQXzcfzgBJx7yDoeGKk7CfApPOLi+FzdvuqrhEpV0ZRbAbA6xWSP2BCLuah
 EQ+4xBTIJNOscaSU7AHHQTz1quLdtRHwTXEkmqJq1Hcqtx/mZdicvve/hgp3okT2az4N5M
 MsL5q3MKgLBiuwBxwz+tThGbU0T6Kxg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-_dkti1fvMGyXX5yQh9OV6Q-1; Tue, 12 Nov 2024 03:02:08 -0500
X-MC-Unique: _dkti1fvMGyXX5yQh9OV6Q-1
X-Mimecast-MFC-AGG-ID: _dkti1fvMGyXX5yQh9OV6Q
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3e7a207b659so2097195b6e.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 00:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731398527; x=1732003327;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xn1Qjs/PYtU/aSg+0PL60+R7uDxL90Q0YwjYY3lU/hI=;
 b=HSy32LQ/K/wMASkNKBHWPMrD7VTizbzAmHpcCMKsRKwvI5US2tvtNpBfptGV3qjqWD
 4GQ+lowQNP6AmAdEllZ+fiiJiJ9LusBkSn1QPorHW6TgSDIRWd5YYIKVb7oOWyvPozqR
 KQzXHiIhsCxYc+nuhSfRaAL3kAEB5H1Y1mPsbZlGJ8kT9wJ6emp2hFwFNCGmlpzTWSmB
 9qCigHubI4ZwRVdszWuTaX8uyklnoVmZOvcwCx/ge08K6w5yNxCxDDgLiAInS8PhTJ6y
 Mh6uNQJw+ChDO3ti7TAoA7Vf93/71Nzayfx9Hrfg/vYp7129++CnazYz5nZz8pYQdMy1
 Ykdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaeyzHSyimzzvyVMVIOb3cfM6xLU1vUCJQeDDkLSO1N4/tXHmXyn1TVwApn/frz1fyZEZTUoiWV84U@nongnu.org
X-Gm-Message-State: AOJu0YxBOTGUi3gPU2c+SqhigPsduEjoTe/5JB1bui23j/7l20j8ol8T
 bsiaJ9qycK2KHHcUsQxzovBJz41RYtLtwFvHIuOGyCkPd4Z4+Jpjt6qu1QtLSSdLJq7088UOGnP
 N9gAsxkQV/XfayZq7jk8J3O9m4by/fXUfznNY2euPEGT5lcYQtsmY
X-Received: by 2002:a05:6808:2212:b0:3e0:c13:9837 with SMTP id
 5614622812f47-3e7aae09629mr1637711b6e.37.1731398525920; 
 Tue, 12 Nov 2024 00:02:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQxzgLm08f2bsqrhiyyzO/E966SyqZaw9HwRRzMFqXLgdp7l/bUPurb0LjcaihZAcSgtnESQ==
X-Received: by 2002:a05:6808:2212:b0:3e0:c13:9837 with SMTP id
 5614622812f47-3e7aae09629mr1637687b6e.37.1731398525537; 
 Tue, 12 Nov 2024 00:02:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d396630f80sm68758176d6.103.2024.11.12.00.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 00:02:05 -0800 (PST)
Message-ID: <75861f28-5215-4435-a474-be8545640357@redhat.com>
Date: Tue, 12 Nov 2024 09:02:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] tests/functional: Convert Aspeed aarch64 SDK tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241112062806.838717-1-clg@redhat.com>
 <20241112062806.838717-3-clg@redhat.com>
 <e556df7b-86c6-487d-b64a-03d0e698f973@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e556df7b-86c6-487d-b64a-03d0e698f973@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 11/12/24 07:53, Thomas Huth wrote:
> On 12/11/2024 07.28, Cédric Le Goater wrote:
>> Drop the SSH connection which was introduced in the avocado tests to
>> workaround read issues when interacting with console.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/avocado/machine_aspeed.py         | 78 --------------------
>>   tests/functional/meson.build            |  2 +
>>   tests/functional/test_aarch64_aspeed.py | 97 +++++++++++++++++++++++++
>>   3 files changed, 99 insertions(+), 78 deletions(-)
>>   create mode 100644 tests/functional/test_aarch64_aspeed.py
>>
>> diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
>> index 241ef180affc..2240c82abff9 100644
>> --- a/tests/avocado/machine_aspeed.py
>> +++ b/tests/avocado/machine_aspeed.py
>> @@ -59,17 +59,6 @@ def do_test_arm_aspeed_sdk_start(self, image):
>>               self, 'boot', '## Loading kernel from FIT Image')
>>           self.wait_for_console_pattern('Starting kernel ...')
>> -    def do_test_aarch64_aspeed_sdk_start(self, image):
>> -        self.vm.set_console()
>> -        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
>> -                         '-net', 'nic', '-net', 'user,hostfwd=:127.0.0.1:0-:22')
>> -
>> -        self.vm.launch()
>> -
>> -        self.wait_for_console_pattern('U-Boot 2023.10')
>> -        self.wait_for_console_pattern('## Loading kernel from FIT Image')
>> -        self.wait_for_console_pattern('Starting kernel ...')
>> -
>>       @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
>>       def test_arm_ast2500_evb_sdk(self):
>>           """
>> @@ -133,70 +122,3 @@ def test_arm_ast2600_evb_sdk(self):
>>           year = time.strftime("%Y")
>>           self.ssh_command_output_contains('/sbin/hwclock -f /dev/rtc1', year);
>> -    def test_aarch64_ast2700_evb_sdk_v09_02(self):
>> -        """
>> -        :avocado: tags=arch:aarch64
>> -        :avocado: tags=machine:ast2700-evb
>> -        """
>> -
>> -        image_url = ('https://github.com/AspeedTech-BMC/openbmc/releases/'
>> -                     'download/v09.02/ast2700-default-obmc.tar.gz')
>> -        image_hash = 'ac969c2602f4e6bdb69562ff466b89ae3fe1d86e1f6797bb7969d787f82116a7'
>> -        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
>> -                                      algorithm='sha256')
>> -        archive.extract(image_path, self.workdir)
>> -
>> -        num_cpu = 4
>> -        image_dir = self.workdir + '/ast2700-default/'
>> -        uboot_size = os.path.getsize(image_dir + 'u-boot-nodtb.bin')
>> -        uboot_dtb_load_addr = hex(0x400000000 + uboot_size)
>> -
>> -        load_images_list = [
>> -            {
>> -                'addr': '0x400000000',
>> -                'file': image_dir + 'u-boot-nodtb.bin'
>> -            },
>> -            {
>> -                'addr': str(uboot_dtb_load_addr),
>> -                'file': image_dir + 'u-boot.dtb'
>> -            },
>> -            {
>> -                'addr': '0x430000000',
>> -                'file': image_dir + 'bl31.bin'
>> -            },
>> -            {
>> -                'addr': '0x430080000',
>> -                'file': image_dir + 'optee/tee-raw.bin'
>> -            }
>> -        ]
>> -
>> -        for load_image in load_images_list:
>> -            addr = load_image['addr']
>> -            file = load_image['file']
>> -            self.vm.add_args('-device',
>> -                             f'loader,force-raw=on,addr={addr},file={file}')
>> -
>> -        for i in range(num_cpu):
>> -            self.vm.add_args('-device',
>> -                             f'loader,addr=0x430000000,cpu-num={i}')
>> -
>> -        self.vm.add_args('-smp', str(num_cpu))
>> -        self.vm.add_args('-device',
>> -                         'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
>> -        self.do_test_aarch64_aspeed_sdk_start(image_dir + 'image-bmc')
>> -        self.wait_for_console_pattern('nodistro.0 ast2700-default ttyS12')
>> -
>> -        self.ssh_connect('root', '0penBmc', False)
>> -        self.ssh_command('dmesg -c > /dev/null')
>> -
>> -        self.ssh_command_output_contains(
>> -            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device '
>> -            '&& dmesg -c',
>> -            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d');
>> -
>> -        self.ssh_command_output_contains(
>> -            'cat /sys/class/hwmon/hwmon20/temp1_input', '0')
>> -        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
>> -                    property='temperature', value=18000)
>> -        self.ssh_command_output_contains(
>> -            'cat /sys/class/hwmon/hwmon20/temp1_input', '18000')
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 758145d1e5fa..c035eba4f9b8 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -11,6 +11,7 @@ endif
>>   # Timeouts for individual tests that can be slow e.g. with debugging enabled
>>   test_timeouts = {
>> +  'aarch64_aspeed' : 600,
>>     'aarch64_raspi4' : 480,
>>     'aarch64_sbsaref_alpine' : 720,
>>     'aarch64_sbsaref_freebsd' : 720,
>> @@ -47,6 +48,7 @@ tests_generic_bsduser = [
>>   ]
>>   tests_aarch64_system_thorough = [
>> +  'aarch64_aspeed',
>>     'aarch64_raspi3',
>>     'aarch64_raspi4',
>>     'aarch64_sbsaref',
>> diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
>> new file mode 100644
>> index 000000000000..c61e34242d5a
>> --- /dev/null
>> +++ b/tests/functional/test_aarch64_aspeed.py
>> @@ -0,0 +1,97 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that boots the ASPEED SoCs with firmware
>> +#
>> +# Copyright (C) 2022 ASPEED Technology Inc
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import sys
>> +import os
>> +
>> +from qemu_test import QemuSystemTest, Asset
>> +from qemu_test import wait_for_console_pattern
>> +from qemu_test import exec_command_and_wait_for_pattern
>> +from qemu_test.utils import archive_extract
>> +
>> +class AST2x00MachineSDK(QemuSystemTest):
>> +
>> +    def do_test_aarch64_aspeed_sdk_start(self, image):
>> +        self.vm.set_console()
>> +        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
>> +                         '-net', 'nic', '-snapshot')
> 
> Running QEMU with just "-net nic" but no other "-net" option normally produces a warning à la "warning: hub 0 is not connected to host network" ... it's likely hidden in a log file here, so it does not really matter, but in case you respin the series anyway, you could maybe also try without the "-net nic" here.


I will add a user netdev.




> Anyway,
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


Thanks,

C.


