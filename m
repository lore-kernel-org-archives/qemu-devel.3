Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814FDD2F7F8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 07:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Kdv-0003gU-H8; Thu, 17 Oct 2024 03:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t1Kdt-0003fM-EV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t1Kdr-0005le-AZ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729148990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mGMadB4Jiy4rLa8uQYBel2SnbD5TRfdF+vw/dVk4Fo4=;
 b=Gzx6ZBwOoQBE1klR9+wnLFnSGWy4K/gv//CJzRwwwO4zlAri6cR96uYKnUTL/rRxPX5N5x
 xsxNQ6nDnAbMmTgDkXNGl4YlzNpFkTBXqu6VS0KVBkvZmdlK8p+0JDJzGrVC24fud2SpbR
 Me8buJOvzPvQqxxMNIT7GVMq/I927TA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-K1xF6Kd6Oq-mgWibLVhLXA-1; Thu, 17 Oct 2024 03:09:49 -0400
X-MC-Unique: K1xF6Kd6Oq-mgWibLVhLXA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43159c07193so4378545e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 00:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729148986; x=1729753786;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGMadB4Jiy4rLa8uQYBel2SnbD5TRfdF+vw/dVk4Fo4=;
 b=Y9P78auAYzRInoz+FgDpEC/IG3+TShu3/jey1EJnSBIQ0Dl0blaeMl+J5cm2GOIHA8
 3cRZCrUhNZAhOSV4jW0q7nv4k+D6gMpXTfUqpoChqF2MQ357QRTRBpgHdftW9EfH3Ia5
 2hWUIS6Hbnt/CPYzHPw4JPfN342Uxw8SDuX5sh/yjZHOK2QwqVdqePXvpcnCYfknloOI
 Qgu24lg/luslB5s6GVpINchiTYW41W+/zpSTb2cDxpLr5lV0UHMMXg5KKO1CJhRdTkiX
 haStiqntVn8dS0iUFduMME96TsfdUDXHHAWwTuJKG+bKtw1jSZ2SXhID1rVHircReIj9
 U77Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVedGTXBcVRlm/u2aKX++bX+/fIMtGNdRFQq3lSVZfNBPb9kUt+f0XxVY3ep2SWh67m1aMevV6EpyZR@nongnu.org
X-Gm-Message-State: AOJu0YyyrrWr20pzcJj/0uuld2kigkqO+rztI6LxrGoMZDrDEy6vTSDU
 WK3BODloFLGK4hSXkmeAQpEHxbtc1old3Ttk7z0+GrAPR42N2qvdROn6i9QSgkqjw+OB7B3StE1
 AsN3voAPTqS08LW9yLsE+JDxjBcPHO1WmpJMjy5pWuPOYTNTT0Gfo
X-Received: by 2002:a05:600c:5251:b0:42a:a6b8:f09f with SMTP id
 5b1f17b1804b1-43125607846mr189279825e9.23.1729148985518; 
 Thu, 17 Oct 2024 00:09:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEm0g4jXOxiuxEXjXoUS/H7I5zz6zPv2idrc8zmVgmIOK1/zabDBREMviYZyDfHKY6QfI88A==
X-Received: by 2002:a05:600c:5251:b0:42a:a6b8:f09f with SMTP id
 5b1f17b1804b1-43125607846mr189279545e9.23.1729148985003; 
 Thu, 17 Oct 2024 00:09:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c3dfe5sm16333755e9.22.2024.10.17.00.09.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 00:09:44 -0700 (PDT)
Message-ID: <c7b4442c-5356-4000-bda3-e7239c3eddde@redhat.com>
Date: Thu, 17 Oct 2024 09:09:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Convert most Aspeed machine tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com
References: <20241016203835.2222792-1-clg@redhat.com>
 <8b228e20-619f-4c52-a9bc-3a878a9ab34a@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <8b228e20-619f-4c52-a9bc-3a878a9ab34a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
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

On 10/17/24 08:06, Thomas Huth wrote:
> On 16/10/2024 22.38, Cédric Le Goater wrote:
>> This is a simple conversion of the tests with some cleanups and
>> adjustments to match the new test framework. Replace the zephyr image
>> MD5 hashes with SHA256 hashes while at it.
>>
>> The SDK tests depend on a ssh class from avocado.utils which is
>> difficult to replace. To be addressed separately.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Changes in v2:
>>
>>   - define class level Asset variables
>>
>>   tests/avocado/machine_aspeed.py     | 252 -------------------------
>>   tests/functional/meson.build        |   2 +
>>   tests/functional/test_arm_aspeed.py | 277 ++++++++++++++++++++++++++++
>>   3 files changed, 279 insertions(+), 252 deletions(-)
>>   create mode 100644 tests/functional/test_arm_aspeed.py
>>
>> diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
>> index 4e144bde9131..cb163e3a1106 100644
>> --- a/tests/avocado/machine_aspeed.py
>> +++ b/tests/avocado/machine_aspeed.py
>> @@ -19,258 +19,6 @@
>>   from avocado_qemu import has_cmd
>>   from avocado.utils import archive
>>   from avocado import skipUnless
>> -from avocado import skipUnless
>> -
>> -
>> -class AST1030Machine(QemuSystemTest):
>> -    """Boots the zephyr os and checks that the console is operational"""
>> -
>> -    timeout = 10
>> -
>> -    def test_ast1030_zephyros_1_04(self):
>> -        """
>> -        :avocado: tags=arch:arm
>> -        :avocado: tags=machine:ast1030-evb
>> -        :avocado: tags=os:zephyr
>> -        """
>> -        tar_url = ('https://github.com/AspeedTech-BMC'
>> -                   '/zephyr/releases/download/v00.01.04/ast1030-evb-demo.zip')
>> -        tar_hash = '4c6a8ce3a8ba76ef1a65dae419ae3409343c4b20'
>> -        tar_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
>> -        archive.extract(tar_path, self.workdir)
>> -        kernel_file = self.workdir + "/ast1030-evb-demo/zephyr.elf"
>> -        self.vm.set_console()
>> -        self.vm.add_args('-kernel', kernel_file,
>> -                         '-nographic')
>> -        self.vm.launch()
>> -        wait_for_console_pattern(self, "Booting Zephyr OS")
>> -        exec_command_and_wait_for_pattern(self, "help",
>> -                                          "Available commands")
>> -
>> -    def test_ast1030_zephyros_1_07(self):
>> -        """
>> -        :avocado: tags=arch:arm
>> -        :avocado: tags=machine:ast1030-evb
>> -        :avocado: tags=os:zephyr
>> -        """
>> -        tar_url = ('https://github.com/AspeedTech-BMC'
>> -                   '/zephyr/releases/download/v00.01.07/ast1030-evb-demo.zip')
>> -        tar_hash = '40ac87eabdcd3b3454ce5aad11fedc72a33ecda2'
>> -        tar_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
>> -        archive.extract(tar_path, self.workdir)
>> -        kernel_file = self.workdir + "/ast1030-evb-demo/zephyr.bin"
>> -        self.vm.set_console()
>> -        self.vm.add_args('-kernel', kernel_file,
>> -                         '-nographic')
>> -        self.vm.launch()
>> -        wait_for_console_pattern(self, "Booting Zephyr OS")
>> -        for shell_cmd in [
>> -                'kernel stacks',
>> -                'otp info conf',
>> -                'otp info scu',
>> -                'hwinfo devid',
>> -                'crypto aes256_cbc_vault',
>> -                'random get',
>> -                'jtag JTAG1 sw_xfer high TMS',
>> -                'adc ADC0 resolution 12',
>> -                'adc ADC0 read 42',
>> -                'adc ADC1 read 69',
>> -                'i2c scan I2C_0',
>> -                'i3c attach I3C_0',
>> -                'hash test',
>> -                'kernel uptime',
>> -                'kernel reboot warm',
>> -                'kernel uptime',
>> -                'kernel reboot cold',
>> -                'kernel uptime',
>> -        ]: exec_command_and_wait_for_pattern(self, shell_cmd, "uart:~$")
>> -
>> -class AST2x00Machine(QemuSystemTest):
>> -
>> -    timeout = 180
>> -
>> -    def wait_for_console_pattern(self, success_message, vm=None):
>> -        wait_for_console_pattern(self, success_message,
>> -                                 failure_message='Kernel panic - not syncing',
>> -                                 vm=vm)
> 
> You're losing the "failure_message='Kernel panic - not syncing'" check in your new code. Maybe not worth the effort to copy it over, but still, should be mentioned at least in the commit description, I think.
> 
> Alternatively, you could also use the LinuxKernelTest base class instead which has this wait_for_console_pattern magic included already.

Ah ! I didn't know. I will use LinuxKernelTest instead.

> 
>> -    def do_test_arm_aspeed(self, image):
>> -        self.vm.set_console()
>> -        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
>> -                         '-net', 'nic')
>> -        self.vm.launch()
>> -
>> -        self.wait_for_console_pattern("U-Boot 2016.07")
>> -        self.wait_for_console_pattern("## Loading kernel from FIT Image at 20080000")
>> -        self.wait_for_console_pattern("Starting kernel ...")
>> -        self.wait_for_console_pattern("Booting Linux on physical CPU 0x0")
>> -        wait_for_console_pattern(self,
>> -                "aspeed-smc 1e620000.spi: read control register: 203b0641")
>> -        self.wait_for_console_pattern("ftgmac100 1e660000.ethernet eth0: irq ")
>> -        self.wait_for_console_pattern("systemd[1]: Set hostname to")
> ...
>> -    @skipUnless(*has_cmd('swtpm'))
>> -    def test_arm_ast2600_evb_buildroot_tpm(self):
>> -        """
>> -        :avocado: tags=arch:arm
>> -        :avocado: tags=machine:ast2600-evb
>> -        """
>> -
>> -        image_url = ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
>> -                     'images/ast2600-evb/buildroot-2023.02-tpm/flash.img')
>> -        image_hash = ('a46009ae8a5403a0826d607215e731a8c68d27c14c41e55331706b8f9c7bd997')
>> -        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
>> -                                      algorithm='sha256')
>> -
>> -        # force creation of VM object, which also defines self._sd
>> -        vm = self.vm
>> -
>> -        socket = os.path.join(self._sd.name, 'swtpm-socket')
>> -
>> -        subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
>> -                        '--tpmstate', f'dir={self.vm.temp_dir}',
>> -                        '--ctrl', f'type=unixio,path={socket}'])
>> -
>> -        self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
>> -        self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
>> -        self.vm.add_args('-device',
>> -                         'tpm-tis-i2c,tpmdev=tpm0,bus=aspeed.i2c.bus.12,address=0x2e')
>> -        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'Aspeed AST2600 EVB')
>> -
>> -        exec_command_and_wait_for_pattern(self,
>> -            'echo tpm_tis_i2c 0x2e > /sys/bus/i2c/devices/i2c-12/new_device',
>> -            'tpm_tis_i2c 12-002e: 2.0 TPM (device-id 0x1, rev-id 1)');
>> -        exec_command_and_wait_for_pattern(self,
>> -            'cat /sys/class/tpm/tpm0/pcr-sha256/0',
>> -            'B804724EA13F52A9072BA87FE8FDCC497DFC9DF9AA15B9088694639C431688E0');
>> -
>> -        self.do_test_arm_aspeed_buildroot_poweroff()
>>   class AST2x00MachineSDK(QemuSystemTest, LinuxSSHMixIn):
> 
> You also copied AST2x00MachineMMC but you didn't remove it from the avocado test yet, so there is a hunk missing here, I think?

oh. yes, I should remove it from the avocado test.

I was initially hesitating on having multiple test_arm_aspeed.py files:
one per machine or one per fw image type. This to set the timeout more
precisely in the meson.build file, since the SDK FW takes longer to
boot, and also to handle more complex test scenarios, like the SDK.

What would be your recommandation ?


Btw, I have been trying to rewrite the LinuxSSHMixIn class with a
minimal ssh Session class. It is not trivial :/
  
>> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
>> new file mode 100644
>> index 000000000000..37e0c0734b25
>> --- /dev/null
>> +++ b/tests/functional/test_arm_aspeed.py
>> @@ -0,0 +1,277 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that boots the ASPEED SoCs with firmware
>> +#
>> +# Copyright (C) 2022 ASPEED Technology Inc
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import os
>> +import time
>> +import subprocess
>> +import tempfile
>> +
>> +from qemu_test import QemuSystemTest, Asset
>> +from qemu_test import wait_for_console_pattern
>> +from qemu_test import exec_command_and_wait_for_pattern
>> +from qemu_test import interrupt_interactive_console_until_pattern
>> +from qemu_test import exec_command
>> +from qemu_test import has_cmd
>> +from qemu_test.utils import archive_extract
>> +from zipfile import ZipFile
>> +from unittest import skipUnless
>> +
>> +class AST1030Machine(QemuSystemTest):
>> +
>> +    ASSET_ZEPHYR_1_04 = Asset(
>> +        ('https://github.com/AspeedTech-BMC'
>> +         '/zephyr/releases/download/v00.01.04/ast1030-evb-demo.zip'),
>> +        '4ac6210adcbc61294927918707c6762483fd844dde5e07f3ba834ad1f91434d3')
>> +
>> +    def test_ast1030_zephyros_1_04(self):
>> +        kernel_name = "ast1030-evb-demo/zephyr.elf"
>> +        zip_file = self.ASSET_ZEPHYR_1_04.fetch()
>> +        with ZipFile(zip_file, 'r') as zf:
>> +                     zf.extract(kernel_name, path=self.workdir)
>> +        kernel_file = os.path.join(self.workdir, kernel_name)
>> +
>> +        self.set_machine('ast1030-evb')
> 
> It's slightly better to do the set_machine() at the very top of the function. set_machine() can cancel the test in case the machine is not available in the QEMU binary, so this should best be done before fetching and extracting any assets.

Should set_machine() be the first call of a test function ?

[ ... ]

> PS:
> Note to myself: Add some comments to the documentation about set_machine() and require_netdev() to the documentation to state that they should come first in test functions.

Yes. That would be a good idea.

Thanks for the review,

C.





