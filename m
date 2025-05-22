Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED892C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 05:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHyiP-0007xN-6g; Thu, 22 May 2025 01:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHyiN-0007wL-BB
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:43:35 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHyiK-0003ZQ-QW
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:43:34 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b26df8f44e6so7270150a12.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 22:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747892611; x=1748497411;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o+E0blcDcCohxEl9FUWl2W/U42R6Sqpik4O7lael+Q0=;
 b=yMwPCdpvvEoAcOGgbTopvmtokqZVi6OPZL5vvl0kbPIhT7KQByobAcCgvszdt3q3EA
 LsuXcGvZF6Ybv9JfvwLrySL0c1EMGU+KT5i9bLaIY/Bx7ZXvDvJUc2sk91vOBpVbHpXg
 VCRNpMN7onPlHGTNtbs3OegH/nIOHNUwadJoWwHVEnbQCyJs9eVo3xpgpqgb3mfdprfQ
 vkV2oT1lKUVEYnLoFtX9XUFMtCKiXdQUJKMUBTL2AGCyxeDSrtffce6YUt08dVuXfqt/
 MXWBZLuFzzCgM3cqMUb9bRAm2bUYpPcwCvUGfL8mkiUf0Zs9SxmkyZ7P5ThzEH2ZeKkP
 a/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747892611; x=1748497411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o+E0blcDcCohxEl9FUWl2W/U42R6Sqpik4O7lael+Q0=;
 b=gVnk4Dj4g8XSrs9Z04/5Gu1OSh+54gwvv2zGdLksbyDP8FdOjuIAhy982USwifouPP
 pfTnWNTJK44NzjBURra12u4SQdztoFb9JrgIrTxYLpRQLDEmV0tuL2124iNVitbMwUfZ
 kz6NMUdpj5TkuheVMvDrTUjYw8A5gHmG7MN7JgZC7oF1mlsyc8EX7cdYFq/5TkUAEs5t
 dAaCp2YhHad7kR7A8M9OqaptUrk6EGAnbYIx7Sa+VvSgGTyDIsenDwZp9CBLGnRwu5tv
 IVVtsqGqVstuPMWQYRBrLqYcSp8FKe9G8AFqvYY4N4msRBolLJfm3vM1r1LTdrOps2bK
 HX+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDMkwoa+D9rnPfsGuvyoWbsZzLJio3fZLDoU2bvnS2KXXpKncuNjryLLZ1uHOJMLFA7G4wxmhZlR+e@nongnu.org
X-Gm-Message-State: AOJu0Yw0tinKchyKJ4Q+HYokB3bAPAUVPMqUZnTDmHLrhSDx+VA9Djzr
 jPFVRp7BJw2pSwN3reCyKwdGtWYZQSwph0SF/xaTPJSmQ0QdbeoHk3eQPIqqSl0c60s=
X-Gm-Gg: ASbGncuIDo4s46YX1FHZOvTUlXzpA1q6PqyiySU6MqJ3QeiVPrq6eJpx+2BuBX7Fask
 jE7LUP8JaolP+9GqByQcQf6s71ICx0O9i69gYZfQz5n6DsqHDyg+00SZjdPQjQEdJHyrLZPtEF9
 Rcqnc6BcZJdGYdTY6E+/h/uhKoZWI9ZaMaaVyOGUR0Jli7u/VkyIiGGnNLztATMmEvXl9/rU3eF
 IA3MdaG5sJU15wCKwARwFkFdhJEwz5Tmebx2aTtJNZDKyfsY0QHAJ+0Tb7XCKy4rvic2IO5r8+H
 1Mok9Tmp023LnnFJQ+w7XSS0LDbl1ncWbr2YzVK0YFZK+jHnoTj/O0emZXN6Nw==
X-Google-Smtp-Source: AGHT+IEr8cYOE/hW9pwX4j2WRUDi1E4lhkdzCTHSFTfK66y/oG1sByn+NzIfv80XO0HVPHJmIvOEVQ==
X-Received: by 2002:a17:90b:3c45:b0:2ff:592d:23bc with SMTP id
 98e67ed59e1d1-30e7d4f2ac6mr37205151a91.4.1747892611008; 
 Wed, 21 May 2025 22:43:31 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36513281sm4675741a91.45.2025.05.21.22.43.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 22:43:30 -0700 (PDT)
Message-ID: <16e8971a-aa1a-41ee-aa0a-2540eef80908@daynix.com>
Date: Thu, 22 May 2025 14:43:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/20] tests/functional: Add PCI hotplug test for
 aarch64
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-7-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250521164250.135776-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/22 1:42, Alex Bennée wrote:
> From: Gustavo Romero <gustavo.romero@linaro.org>
> 
> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
> hot-unplug on arm64.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Message-Id: <20250512144629.182340-1-gustavo.romero@linaro.org>
> [AJB: add qemu-arm link]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - add qemu-arm link to MAINTAINERS
> ---
>   MAINTAINERS                                  |  6 ++
>   tests/functional/meson.build                 |  1 +
>   tests/functional/test_aarch64_hotplug_pci.py | 74 ++++++++++++++++++++
>   3 files changed, 81 insertions(+)
>   create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7060cf49b9..818d7b9d5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2078,6 +2078,12 @@ S: Supported
>   F: include/hw/pci/pcie_doe.h
>   F: hw/pci/pcie_doe.c
>   
> +ARM PCI Hotplug
> +M: Gustavo Romero <gustavo.romero@linaro.org>
> +L: qemu-arm@nongnu.org
> +S: Supported
> +F: tests/functional/test_aarch64_hotplug_pci.py
> +
>   ACPI/SMBIOS
>   M: Michael S. Tsirkin <mst@redhat.com>
>   M: Igor Mammedov <imammedo@redhat.com>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 52b4706cfe..2d68840fa2 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -83,6 +83,7 @@ tests_aarch64_system_quick = [
>   tests_aarch64_system_thorough = [
>     'aarch64_aspeed_ast2700',
>     'aarch64_aspeed_ast2700fc',
> +  'aarch64_hotplug_pci',
>     'aarch64_imx8mp_evk',
>     'aarch64_raspi3',
>     'aarch64_raspi4',
> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
> new file mode 100755
> index 0000000000..fa1bb62c8f
> --- /dev/null
> +++ b/tests/functional/test_aarch64_hotplug_pci.py
> @@ -0,0 +1,74 @@
> +#!/usr/bin/env python3
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# The test hotplugs a PCI device and checks it on a Linux guest.
> +#
> +# Copyright (c) 2025 Linaro Ltd.
> +#
> +# Author:
> +#  Gustavo Romero <gustavo.romero@linaro.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
> +from qemu_test import BUILD_DIR
> +
> +class HotplugPCI(LinuxKernelTest):
> +
> +    ASSET_KERNEL = Asset(
> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
> +         'current/images/netboot/debian-installer/arm64/linux'),
> +        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b2')
> +
> +    ASSET_INITRD = Asset(
> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
> +         'current/images/netboot/debian-installer/arm64/initrd.gz'),
> +        '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')
> +
> +    def test_hotplug_pci(self):
> +
> +        self.set_machine('virt')
> +        self.vm.add_args('-m', '512M')
> +        self.vm.add_args('-cpu', 'cortex-a57')
> +        self.vm.add_args('-append',
> +                         'console=ttyAMA0,115200 init=/bin/sh')
> +        self.vm.add_args('-device',
> +                         'pcie-root-port,bus=pcie.0,chassis=1,slot=1,id=pcie.1')
> +        self.vm.add_args('-bios', self.build_file('pc-bios',
> +                                                  'edk2-aarch64-code.fd'))

One call of self.vm.add_args should be sufficient:

self.vm.add_args('-m', '512M',
                  '-cpu', 'cortex-a57',
                  '-append',
                  'console=ttyAMA0,115200 init=/bin/sh',
                  '-device',
                  'pcie-root-port,bus=pcie.0,chassis=1,slot=1,id=pcie.1',
                  '-bios',
                  self.build_file('pc-bios', 'edk2-aarch64-code.fd'))

> +
> +        # BusyBox prompt
> +        prompt = "~ #"
> +        self.launch_kernel(self.ASSET_KERNEL.fetch(),
> +                           self.ASSET_INITRD.fetch(),
> +                           wait_for=prompt)
> +
> +        # Check for initial state: 2 network adapters, lo and enp0s1.
> +        exec_command_and_wait_for_pattern(self,
> +                                          'ls -l /sys/class/net | wc -l',

Shorter: ls /sys/class/net | wc -l

> +                                          '2')
> +
> +        # Hotplug one network adapter to the root port, i.e. pcie.1 bus.
> +        self.vm.cmd('device_add',
> +                    driver='virtio-net-pci',
> +                    bus='pcie.1',
> +                    addr=0,
> +                    id='na')
> +        # Wait for the kernel to recognize the new device.
> +        self.wait_for_console_pattern('virtio-pci')
> +        self.wait_for_console_pattern('virtio_net')
> +
> +        # Check if there is a new network adapter.
> +        exec_command_and_wait_for_pattern(self,
> +                                          'ls -l /sys/class/net | wc -l',
> +                                          '3')
> +
> +        self.vm.cmd('device_del', id='na')
> +        exec_command_and_wait_for_pattern(self,
> +                                          'ls -l /sys/class/net | wc -l',
> +                                          '2')
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()


