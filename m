Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A284D2F7EC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 06:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Jeo-0008In-7y; Thu, 17 Oct 2024 02:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1Jem-0008Ep-1A
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1Jeg-0000yZ-2q
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729145196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bN2OTEPZQbJ/0iOK9Po6yqV/78+m6xvpmt7ljapYywI=;
 b=apuWl8F9tZGcMg5hhqpAPbeIFffZq8VGAfAOj6FvjBovywvHKGY054/iuKy2Qs1U/2+Fpt
 +EgyPkngrxyYEMVhYh0uuQCUG4B0q8qTv4CqHny/KVlJ73FQTcYZ4qEaWjLS8WajkX3ouc
 3+HWqFMfsqopbpZn/eIXhRAtvokUG4I=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-4zKdB0nzPASUfRzPWp3_Mg-1; Thu, 17 Oct 2024 02:06:35 -0400
X-MC-Unique: 4zKdB0nzPASUfRzPWp3_Mg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2fb50150039so3956451fa.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 23:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729145194; x=1729749994;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bN2OTEPZQbJ/0iOK9Po6yqV/78+m6xvpmt7ljapYywI=;
 b=T2zsoReIrLtkIaQLmqjFhota/8nMXK4ZrflxzKu1UR3SXdtKrD5ct5c3e++cJrMyBQ
 fHhpRKw96sbHxU4cDnjjJ2myAz5Ftn6CV8Jbf4haJXS0PrXRLL3jv+YUc0Bgh6JiYUE8
 Op/x1ryUgfq2j9/NvKdslFu4v2IOvmNV8+zd6ZofBrM7+pFiUQ/5QqPZJepiGcBNZRLz
 L/iDQAgMmEtZru1DZLXd/liAgx9IQOCViw/0ohj369s30jMPPgLJiXnrAjwRqBq4LzBO
 FJ5tlMcRavsRL3ZtzkFB1sR+X2BlrDoZw63mH5lMcqhcdf7qJZTgFh+ejSFGQSv9X6DV
 OysA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7ozV9+QV7nm5azuLEIpCr9TjwfIzCeC335WVRutq14evBRAdxz18KWDQkMFCbm5gZ2ZCTxWTdaPNp@nongnu.org
X-Gm-Message-State: AOJu0YylfDwEFkpRsbsV8S7mU9Hu1Y819nACHDRx0I+MZs5Y8CXJLSXQ
 hR1EnnbZWrGg/IeA+C+gEZ2dkK+R6xHDezpSsTJT8mVLfecpGzShdsO+q/R3VYMX6zxiWuLKcLR
 VmcX4ifkHeV01hzYiVeCgDJzEV53B47EqMReiwSpj44vNTpYFM1PE
X-Received: by 2002:a2e:a991:0:b0:2fb:5f9d:c2a3 with SMTP id
 38308e7fff4ca-2fb5f9dc4e5mr40970831fa.29.1729145193458; 
 Wed, 16 Oct 2024 23:06:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE640ekhSQlgp9FEwoo6xCbSh2Zsd4Q5ha7Rr0BTlA2kgurZzDzZ/HAtRNpjcmrcq26NuitA==
X-Received: by 2002:a2e:a991:0:b0:2fb:5f9d:c2a3 with SMTP id
 38308e7fff4ca-2fb5f9dc4e5mr40970581fa.29.1729145192833; 
 Wed, 16 Oct 2024 23:06:32 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d4f9416sm2306208a12.35.2024.10.16.23.06.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 23:06:32 -0700 (PDT)
Message-ID: <8b228e20-619f-4c52-a9bc-3a878a9ab34a@redhat.com>
Date: Thu, 17 Oct 2024 08:06:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Convert most Aspeed machine tests
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com
References: <20241016203835.2222792-1-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241016203835.2222792-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 16/10/2024 22.38, Cédric Le Goater wrote:
> This is a simple conversion of the tests with some cleanups and
> adjustments to match the new test framework. Replace the zephyr image
> MD5 hashes with SHA256 hashes while at it.
> 
> The SDK tests depend on a ssh class from avocado.utils which is
> difficult to replace. To be addressed separately.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>   Changes in v2:
> 
>   - define class level Asset variables
> 
>   tests/avocado/machine_aspeed.py     | 252 -------------------------
>   tests/functional/meson.build        |   2 +
>   tests/functional/test_arm_aspeed.py | 277 ++++++++++++++++++++++++++++
>   3 files changed, 279 insertions(+), 252 deletions(-)
>   create mode 100644 tests/functional/test_arm_aspeed.py
> 
> diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
> index 4e144bde9131..cb163e3a1106 100644
> --- a/tests/avocado/machine_aspeed.py
> +++ b/tests/avocado/machine_aspeed.py
> @@ -19,258 +19,6 @@
>   from avocado_qemu import has_cmd
>   from avocado.utils import archive
>   from avocado import skipUnless
> -from avocado import skipUnless
> -
> -
> -class AST1030Machine(QemuSystemTest):
> -    """Boots the zephyr os and checks that the console is operational"""
> -
> -    timeout = 10
> -
> -    def test_ast1030_zephyros_1_04(self):
> -        """
> -        :avocado: tags=arch:arm
> -        :avocado: tags=machine:ast1030-evb
> -        :avocado: tags=os:zephyr
> -        """
> -        tar_url = ('https://github.com/AspeedTech-BMC'
> -                   '/zephyr/releases/download/v00.01.04/ast1030-evb-demo.zip')
> -        tar_hash = '4c6a8ce3a8ba76ef1a65dae419ae3409343c4b20'
> -        tar_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> -        archive.extract(tar_path, self.workdir)
> -        kernel_file = self.workdir + "/ast1030-evb-demo/zephyr.elf"
> -        self.vm.set_console()
> -        self.vm.add_args('-kernel', kernel_file,
> -                         '-nographic')
> -        self.vm.launch()
> -        wait_for_console_pattern(self, "Booting Zephyr OS")
> -        exec_command_and_wait_for_pattern(self, "help",
> -                                          "Available commands")
> -
> -    def test_ast1030_zephyros_1_07(self):
> -        """
> -        :avocado: tags=arch:arm
> -        :avocado: tags=machine:ast1030-evb
> -        :avocado: tags=os:zephyr
> -        """
> -        tar_url = ('https://github.com/AspeedTech-BMC'
> -                   '/zephyr/releases/download/v00.01.07/ast1030-evb-demo.zip')
> -        tar_hash = '40ac87eabdcd3b3454ce5aad11fedc72a33ecda2'
> -        tar_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> -        archive.extract(tar_path, self.workdir)
> -        kernel_file = self.workdir + "/ast1030-evb-demo/zephyr.bin"
> -        self.vm.set_console()
> -        self.vm.add_args('-kernel', kernel_file,
> -                         '-nographic')
> -        self.vm.launch()
> -        wait_for_console_pattern(self, "Booting Zephyr OS")
> -        for shell_cmd in [
> -                'kernel stacks',
> -                'otp info conf',
> -                'otp info scu',
> -                'hwinfo devid',
> -                'crypto aes256_cbc_vault',
> -                'random get',
> -                'jtag JTAG1 sw_xfer high TMS',
> -                'adc ADC0 resolution 12',
> -                'adc ADC0 read 42',
> -                'adc ADC1 read 69',
> -                'i2c scan I2C_0',
> -                'i3c attach I3C_0',
> -                'hash test',
> -                'kernel uptime',
> -                'kernel reboot warm',
> -                'kernel uptime',
> -                'kernel reboot cold',
> -                'kernel uptime',
> -        ]: exec_command_and_wait_for_pattern(self, shell_cmd, "uart:~$")
> -
> -class AST2x00Machine(QemuSystemTest):
> -
> -    timeout = 180
> -
> -    def wait_for_console_pattern(self, success_message, vm=None):
> -        wait_for_console_pattern(self, success_message,
> -                                 failure_message='Kernel panic - not syncing',
> -                                 vm=vm)

You're losing the "failure_message='Kernel panic - not syncing'" check in 
your new code. Maybe not worth the effort to copy it over, but still, should 
be mentioned at least in the commit description, I think.

Alternatively, you could also use the LinuxKernelTest base class instead 
which has this wait_for_console_pattern magic included already.

> -    def do_test_arm_aspeed(self, image):
> -        self.vm.set_console()
> -        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
> -                         '-net', 'nic')
> -        self.vm.launch()
> -
> -        self.wait_for_console_pattern("U-Boot 2016.07")
> -        self.wait_for_console_pattern("## Loading kernel from FIT Image at 20080000")
> -        self.wait_for_console_pattern("Starting kernel ...")
> -        self.wait_for_console_pattern("Booting Linux on physical CPU 0x0")
> -        wait_for_console_pattern(self,
> -                "aspeed-smc 1e620000.spi: read control register: 203b0641")
> -        self.wait_for_console_pattern("ftgmac100 1e660000.ethernet eth0: irq ")
> -        self.wait_for_console_pattern("systemd[1]: Set hostname to")
...
> -    @skipUnless(*has_cmd('swtpm'))
> -    def test_arm_ast2600_evb_buildroot_tpm(self):
> -        """
> -        :avocado: tags=arch:arm
> -        :avocado: tags=machine:ast2600-evb
> -        """
> -
> -        image_url = ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
> -                     'images/ast2600-evb/buildroot-2023.02-tpm/flash.img')
> -        image_hash = ('a46009ae8a5403a0826d607215e731a8c68d27c14c41e55331706b8f9c7bd997')
> -        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
> -                                      algorithm='sha256')
> -
> -        # force creation of VM object, which also defines self._sd
> -        vm = self.vm
> -
> -        socket = os.path.join(self._sd.name, 'swtpm-socket')
> -
> -        subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
> -                        '--tpmstate', f'dir={self.vm.temp_dir}',
> -                        '--ctrl', f'type=unixio,path={socket}'])
> -
> -        self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
> -        self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
> -        self.vm.add_args('-device',
> -                         'tpm-tis-i2c,tpmdev=tpm0,bus=aspeed.i2c.bus.12,address=0x2e')
> -        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'Aspeed AST2600 EVB')
> -
> -        exec_command_and_wait_for_pattern(self,
> -            'echo tpm_tis_i2c 0x2e > /sys/bus/i2c/devices/i2c-12/new_device',
> -            'tpm_tis_i2c 12-002e: 2.0 TPM (device-id 0x1, rev-id 1)');
> -        exec_command_and_wait_for_pattern(self,
> -            'cat /sys/class/tpm/tpm0/pcr-sha256/0',
> -            'B804724EA13F52A9072BA87FE8FDCC497DFC9DF9AA15B9088694639C431688E0');
> -
> -        self.do_test_arm_aspeed_buildroot_poweroff()
>   
>   class AST2x00MachineSDK(QemuSystemTest, LinuxSSHMixIn):

You also copied AST2x00MachineMMC but you didn't remove it from the avocado 
test yet, so there is a hunk missing here, I think?

> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
> new file mode 100644
> index 000000000000..37e0c0734b25
> --- /dev/null
> +++ b/tests/functional/test_arm_aspeed.py
> @@ -0,0 +1,277 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED SoCs with firmware
> +#
> +# Copyright (C) 2022 ASPEED Technology Inc
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +import time
> +import subprocess
> +import tempfile
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +from qemu_test import exec_command_and_wait_for_pattern
> +from qemu_test import interrupt_interactive_console_until_pattern
> +from qemu_test import exec_command
> +from qemu_test import has_cmd
> +from qemu_test.utils import archive_extract
> +from zipfile import ZipFile
> +from unittest import skipUnless
> +
> +class AST1030Machine(QemuSystemTest):
> +
> +    ASSET_ZEPHYR_1_04 = Asset(
> +        ('https://github.com/AspeedTech-BMC'
> +         '/zephyr/releases/download/v00.01.04/ast1030-evb-demo.zip'),
> +        '4ac6210adcbc61294927918707c6762483fd844dde5e07f3ba834ad1f91434d3')
> +
> +    def test_ast1030_zephyros_1_04(self):
> +        kernel_name = "ast1030-evb-demo/zephyr.elf"
> +        zip_file = self.ASSET_ZEPHYR_1_04.fetch()
> +        with ZipFile(zip_file, 'r') as zf:
> +                     zf.extract(kernel_name, path=self.workdir)
> +        kernel_file = os.path.join(self.workdir, kernel_name)
> +
> +        self.set_machine('ast1030-evb')

It's slightly better to do the set_machine() at the very top of the 
function. set_machine() can cancel the test in case the machine is not 
available in the QEMU binary, so this should best be done before fetching 
and extracting any assets.

> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', kernel_file, '-nographic')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, "Booting Zephyr OS")
> +        exec_command_and_wait_for_pattern(self, "help",
> +                                          "Available commands")
> +
> +    ASSET_ZEPHYR_1_07 = Asset(
> +        ('https://github.com/AspeedTech-BMC'
> +         '/zephyr/releases/download/v00.01.07/ast1030-evb-demo.zip'),
> +        'ad52e27959746988afaed8429bf4e12ab988c05c4d07c9d90e13ec6f7be4574c')
> +
> +    def test_ast1030_zephyros_1_07(self):
> +        kernel_name = "ast1030-evb-demo/zephyr.bin"
> +        zip_file = self.ASSET_ZEPHYR_1_07.fetch()
> +        with ZipFile(zip_file, 'r') as zf:
> +                     zf.extract(kernel_name, path=self.workdir)
> +        kernel_file = os.path.join(self.workdir, kernel_name)
> +
> +        self.set_machine('ast1030-evb')

dito

> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', kernel_file, '-nographic')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, "Booting Zephyr OS")
> +        for shell_cmd in [
> +                'kernel stacks',
> +                'otp info conf',
> +                'otp info scu',
> +                'hwinfo devid',
> +                'crypto aes256_cbc_vault',
> +                'random get',
> +                'jtag JTAG1 sw_xfer high TMS',
> +                'adc ADC0 resolution 12',
> +                'adc ADC0 read 42',
> +                'adc ADC1 read 69',
> +                'i2c scan I2C_0',
> +                'i3c attach I3C_0',
> +                'hash test',
> +                'kernel uptime',
> +                'kernel reboot warm',
> +                'kernel uptime',
> +                'kernel reboot cold',
> +                'kernel uptime',
> +        ]: exec_command_and_wait_for_pattern(self, shell_cmd, "uart:~$")
> +
> +class AST2x00Machine(QemuSystemTest):
> +
> +    def do_test_arm_aspeed(self, machine, image):
> +        self.set_machine(machine)
> +        self.vm.set_console()
> +        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
> +                         '-net', 'nic')
> +        self.vm.launch()
> +
> +        wait_for_console_pattern(self, "U-Boot 2016.07")
> +        wait_for_console_pattern(self, "## Loading kernel from FIT Image at 20080000")
> +        wait_for_console_pattern(self, "Starting kernel ...")
> +        wait_for_console_pattern(self, "Booting Linux on physical CPU 0x0")
> +        wait_for_console_pattern(self,
> +                "aspeed-smc 1e620000.spi: read control register: 203b0641")
> +        wait_for_console_pattern(self, "ftgmac100 1e660000.ethernet eth0: irq ")
> +        wait_for_console_pattern(self, "systemd[1]: Set hostname to")
> +
> +    ASSET_PALMETTO_FLASH = Asset(
> +        ('https://github.com/openbmc/openbmc/releases/download/2.9.0/'
> +         'obmc-phosphor-image-palmetto.static.mtd'),
> +        '3e13bbbc28e424865dc42f35ad672b10f2e82cdb11846bb28fa625b48beafd0d');
> +
> +    def test_arm_ast2400_palmetto_openbmc_v2_9_0(self):
> +        image_path = self.ASSET_PALMETTO_FLASH.fetch()
> +
> +        self.do_test_arm_aspeed('palmetto-bmc', image_path)
> +
> +    ASSET_ROMULUS_FLASH = Asset(
> +        ('https://github.com/openbmc/openbmc/releases/download/2.9.0/'
> +         'obmc-phosphor-image-romulus.static.mtd'),
> +        '820341076803f1955bc31e647a512c79f9add4f5233d0697678bab4604c7bb25')
> +
> +    def test_arm_ast2500_romulus_openbmc_v2_9_0(self):
> +        image_path = self.ASSET_ROMULUS_FLASH.fetch()
> +
> +        self.do_test_arm_aspeed('romulus-bmc', image_path)
> +
> +    def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'):
> +        self.require_netdev('user')
> +        self.vm.set_console()
> +        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
> +                         '-net', 'nic', '-net', 'user')
> +        self.vm.launch()
> +
> +        wait_for_console_pattern(self, 'U-Boot 2019.04')
> +        wait_for_console_pattern(self, '## Loading kernel from FIT Image')
> +        wait_for_console_pattern(self, 'Starting kernel ...')
> +        wait_for_console_pattern(self, 'Booting Linux on physical CPU ' + cpu_id)
> +        wait_for_console_pattern(self, 'lease of 10.0.2.15')
> +        # the line before login:
> +        wait_for_console_pattern(self, pattern)
> +        time.sleep(0.1)
> +        exec_command(self, 'root')
> +        time.sleep(0.1)
> +        exec_command(self, "passw0rd")
> +
> +    def do_test_arm_aspeed_buildroot_poweroff(self):
> +        exec_command_and_wait_for_pattern(self, 'poweroff',
> +                                          'reboot: System halted');
> +
> +    ASSET_BR2_202311_AST2500_FLASH = Asset(
> +        ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
> +         'images/ast2500-evb/buildroot-2023.11/flash.img'),
> +        'c23db6160cf77d0258397eb2051162c8473a56c441417c52a91ba217186e715f')
> +
> +    def test_arm_ast2500_evb_buildroot(self):
> +        image_path = self.ASSET_BR2_202311_AST2500_FLASH.fetch()
> +
> +        self.set_machine('ast2500-evb')

dito, switch the order of the above two lines, please.

> +        self.vm.add_args('-device',
> +                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
> +        self.do_test_arm_aspeed_buildroot_start(image_path, '0x0',
> +                                                'Aspeed AST2500 EVB')
> +
> +        exec_command_and_wait_for_pattern(self,
> +             'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
> +             'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d');
> +        exec_command_and_wait_for_pattern(self,
> +                             'cat /sys/class/hwmon/hwmon1/temp1_input', '0')
> +        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
> +                    property='temperature', value=18000);
> +        exec_command_and_wait_for_pattern(self,
> +                             'cat /sys/class/hwmon/hwmon1/temp1_input', '18000')
> +
> +        self.do_test_arm_aspeed_buildroot_poweroff()
> +
> +    ASSET_BR2_202311_AST2600_FLASH = Asset(
> +        ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
> +         'images/ast2600-evb/buildroot-2023.11/flash.img'),
> +        'b62808daef48b438d0728ee07662290490ecfa65987bb91294cafb1bb7ad1a68')
> +
> +    def test_arm_ast2600_evb_buildroot(self):
> +        image_path = self.ASSET_BR2_202311_AST2600_FLASH.fetch()
> +
> +        self.set_machine('ast2600-evb')

dito

> +        self.vm.add_args('-device',
> +                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
> +        self.vm.add_args('-device',
> +                         'ds1338,bus=aspeed.i2c.bus.3,address=0x32');
> +        self.vm.add_args('-device',
> +                         'i2c-echo,bus=aspeed.i2c.bus.3,address=0x42');
> +        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'Aspeed AST2600 EVB')
> +
> +        exec_command_and_wait_for_pattern(self,
> +             'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
> +             'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d');
> +        exec_command_and_wait_for_pattern(self,
> +                             'cat /sys/class/hwmon/hwmon1/temp1_input', '0')
> +        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
> +                    property='temperature', value=18000);
> +        exec_command_and_wait_for_pattern(self,
> +                             'cat /sys/class/hwmon/hwmon1/temp1_input', '18000')
> +
> +        exec_command_and_wait_for_pattern(self,
> +             'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-3/device/new_device',
> +             'i2c i2c-3: new_device: Instantiated device ds1307 at 0x32');
> +        year = time.strftime("%Y")
> +        exec_command_and_wait_for_pattern(self, 'hwclock -f /dev/rtc1', year);
> +
> +        exec_command_and_wait_for_pattern(self,
> +             'echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-3/new_device',
> +             'i2c i2c-3: new_device: Instantiated device slave-24c02 at 0x64');
> +        exec_command(self, 'i2cset -y 3 0x42 0x64 0x00 0xaa i');
> +        time.sleep(0.1)
> +        exec_command_and_wait_for_pattern(self,
> +             'hexdump /sys/bus/i2c/devices/3-1064/slave-eeprom',
> +             '0000000 ffaa ffff ffff ffff ffff ffff ffff ffff');
> +        self.do_test_arm_aspeed_buildroot_poweroff()
> +
> +    ASSET_BR2_202302_AST2600_TPM_FLASH = Asset(
> +        ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
> +         'images/ast2600-evb/buildroot-2023.02-tpm/flash.img'),
> +        'a46009ae8a5403a0826d607215e731a8c68d27c14c41e55331706b8f9c7bd997')
> +
> +    @skipUnless(*has_cmd('swtpm'))
> +    def test_arm_ast2600_evb_buildroot_tpm(self):
> +        image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
> +
> +        socket_dir = tempfile.TemporaryDirectory(prefix="qemu_")
> +        socket = os.path.join(socket_dir.name, 'swtpm-socket')
> +
> +        self.set_machine('ast2600-evb')

Please move the set_machine() to the beginning of the function here, too.

> +        subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
> +                        '--tpmstate', f'dir={self.vm.temp_dir}',
> +                        '--ctrl', f'type=unixio,path={socket}'])
> +
> +        self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
> +        self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
> +        self.vm.add_args('-device',
> +                         'tpm-tis-i2c,tpmdev=tpm0,bus=aspeed.i2c.bus.12,address=0x2e')
> +        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'Aspeed AST2600 EVB')
> +
> +        exec_command_and_wait_for_pattern(self,
> +            'echo tpm_tis_i2c 0x2e > /sys/bus/i2c/devices/i2c-12/new_device',
> +            'tpm_tis_i2c 12-002e: 2.0 TPM (device-id 0x1, rev-id 1)');
> +        exec_command_and_wait_for_pattern(self,
> +            'cat /sys/class/tpm/tpm0/pcr-sha256/0',
> +            'B804724EA13F52A9072BA87FE8FDCC497DFC9DF9AA15B9088694639C431688E0');
> +
> +        self.do_test_arm_aspeed_buildroot_poweroff()
> +
> +class AST2x00MachineMMC(QemuSystemTest):
> +
> +    ASSET_RAINIER_EMMC = Asset(
> +        ('https://fileserver.linaro.org/s/B6pJTwWEkzSDi36/download/'
> +         'mmc-p10bmc-20240617.qcow2'),
> +        'd523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b')
> +
> +    def test_arm_aspeed_emmc_boot(self):
> +        image_path = self.ASSET_RAINIER_EMMC.fetch()
> +
> +        self.require_netdev('user')
> +
> +        self.set_machine('rainier-bmc')

dito. require_netdev() should also be done before fetching the asset, since 
it can cancel the test, too.

> +        self.vm.set_console()
> +        self.vm.add_args('-drive',
> +                         'file=' + image_path + ',if=sd,id=sd2,index=2',
> +                         '-net', 'nic', '-net', 'user')
> +        self.vm.launch()
> +
> +        wait_for_console_pattern(self, 'U-Boot SPL 2019.04')
> +        wait_for_console_pattern(self, 'Trying to boot from MMC1')
> +        wait_for_console_pattern(self, 'U-Boot 2019.04')
> +        wait_for_console_pattern(self, 'eMMC 2nd Boot')
> +        wait_for_console_pattern(self, '## Loading kernel from FIT Image')
> +        wait_for_console_pattern(self, 'Starting kernel ...')
> +        wait_for_console_pattern(self, 'Booting Linux on physical CPU 0xf00')
> +        wait_for_console_pattern(self, 'mmcblk0: p1 p2 p3 p4 p5 p6 p7')
> +        wait_for_console_pattern(self, 'IBM eBMC (OpenBMC for IBM Enterprise')

  Thomas

PS:
Note to myself: Add some comments to the documentation about set_machine() 
and require_netdev() to the documentation to state that they should come 
first in test functions.


