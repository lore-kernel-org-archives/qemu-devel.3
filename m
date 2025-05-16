Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC781C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 09:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFrma-00011x-2g; Fri, 16 May 2025 05:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uFrmW-0000zq-TD
 for qemu-devel@nongnu.org; Fri, 16 May 2025 05:55:09 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uFrmU-0005iG-Bo
 for qemu-devel@nongnu.org; Fri, 16 May 2025 05:55:08 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-442ea341570so12181925e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 02:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747389303; x=1747994103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSgqKzvi7C1rLa9QXmxg/eY5WB2iA6wXC36TIRo8uYE=;
 b=u0QYAu7xYff4GGPW9oQGOrI7j1j5zMSXJ0UNkfpWBIlI1+oPm71wN1REY0tQExTzDq
 C+HyW1Zac25AX2p0FMWrHLBDKwpdh1/BLrZSGTFsfDkRMhuMZ6gsuqfTgzY022c7XBPc
 0iF8AxvsZEmsZZ5+xeHhkeFg7sfjgkMw+Q0+0OD1uOTVLoGtN04INrLvjUgx7yHgWEsg
 ZhckxPfPp1J6a01We1qBwDCw5PMiMSzNB6bFZmD4GAGrL9UBAq8G2H4gJLPQxPJj/uI4
 0497D3TlcdSSOnGm9w61rGwCSFbmE8L0CUpqgeQsS3+X+M5XVZlu++A51GCaqmxV/qiB
 J/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747389303; x=1747994103;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CSgqKzvi7C1rLa9QXmxg/eY5WB2iA6wXC36TIRo8uYE=;
 b=NXRzYK7IhZqCT+WHHxT34yqdYjS3TQHJ2k9igreShm5YvSy4PEsKqep66E/TSiu53m
 IdW5y5Kzlv92PH5bp+Nc0dq3kI3NGZXjxDrU3E9unSp6dhSXTk7du3p3YTJchsQ4PdKd
 /gN+zqzDcB0UN5Ru0jRP97Bk+4IH9FWK4qfFJ9DK8i9jmqGk/6vH1GdgPFYS0gI5+RZu
 l1LLI2/wzLFt3J5c2QZNQJTrZq2FmuxxUVtsZaCR/9NhUbxue8gh4CNgryzTnjvZRVO1
 rKY2FoG9PbJ8MHFFvebaZdINrSNdFB+DgNlo+6PHBrRNj5i4V6nI247VAqkkJ0NFDsO4
 6ukg==
X-Gm-Message-State: AOJu0YxAaFxHyXOpRt4K3B226a2VTvD1yFCBbdYg53qwJSGSHM3jIlab
 HkpaF4sX0gqd4cAGEknN9OcXYaNuoMoJPMd7YU1fW6E77QHnmWX5UZmlKsP0elhKqug=
X-Gm-Gg: ASbGncu5mnCI+0OSpH25H3Uf0F8I/rDAXS8RvmcmGEFGDARUh+l4pBw4mZPGCJ8Wm+m
 l5HvQnbF7MFFCNGhQkZ2zWPRCuKGY2IUrkH0v0JWo5oJVgioCRKLU9rZceBYFokqaoxCJ16ALYG
 4R3PKpRlBtsU2TBEnkzw6ddW1spCrHV4bb3LfHlMdAB81vvMoo20a+w4c870nM7DXS7BgHbI6Id
 jc+4ghmasmctnZbil4yZbDwtQNRrzXafvRMEsO4k69ik/k1gX60Ur5tvbxqnA7aoK58pBpb5u93
 3QR45bbDWOXMIVUBY9KGj0GQ547I6nJ3Y6Ykhus0+jdHxDJYcFcddA==
X-Google-Smtp-Source: AGHT+IGkUChnq9paTdqeucrzsXFWkH8ybDz4b0hQ7NKqmOe87/cfZFQv212iMD4euRYHumZNA9CFlw==
X-Received: by 2002:a05:600c:3b86:b0:43b:ce36:7574 with SMTP id
 5b1f17b1804b1-442fefefcfcmr13356785e9.11.1747389303594; 
 Fri, 16 May 2025 02:55:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd59700asm28828285e9.34.2025.05.16.02.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 02:55:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 33BA55F904;
 Fri, 16 May 2025 10:55:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  thuth@redhat.com,  berrange@redhat.com,
 eric.auger@redhat.com,  philmd@linaro.org,  peter.maydell@linaro.org,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v4] tests/functional: Add PCI hotplug test for aarch64
In-Reply-To: <20250512144629.182340-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Mon, 12 May 2025 15:45:45 +0100")
References: <20250512144629.182340-1-gustavo.romero@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 16 May 2025 10:55:02 +0100
Message-ID: <87frh4yj61.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
> hot-unplug on arm64.

Queued to maintainer/may-2025, thanks.

>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  MAINTAINERS                                  |  5 ++
>  tests/functional/meson.build                 |  1 +
>  tests/functional/test_aarch64_hotplug_pci.py | 74 ++++++++++++++++++++
>  3 files changed, 80 insertions(+)
>  create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23174b4ca7..9ebb768214 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2065,6 +2065,11 @@ S: Supported
>  F: include/hw/pci/pcie_doe.h
>  F: hw/pci/pcie_doe.c
>=20=20
> +ARM PCI Hotplug
> +M: Gustavo Romero <gustavo.romero@linaro.org>
> +S: Supported
> +F: tests/functional/test_aarch64_hotplug_pci.py
> +
>  ACPI/SMBIOS
>  M: Michael S. Tsirkin <mst@redhat.com>
>  M: Igor Mammedov <imammedo@redhat.com>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 52b4706cfe..2d68840fa2 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -83,6 +83,7 @@ tests_aarch64_system_quick =3D [
>  tests_aarch64_system_thorough =3D [
>    'aarch64_aspeed_ast2700',
>    'aarch64_aspeed_ast2700fc',
> +  'aarch64_hotplug_pci',
>    'aarch64_imx8mp_evk',
>    'aarch64_raspi3',
>    'aarch64_raspi4',
> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functio=
nal/test_aarch64_hotplug_pci.py
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
> +from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_=
pattern
> +from qemu_test import BUILD_DIR
> +
> +class HotplugPCI(LinuxKernelTest):
> +
> +    ASSET_KERNEL =3D Asset(
> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm6=
4/'
> +         'current/images/netboot/debian-installer/arm64/linux'),
> +        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b=
2')
> +
> +    ASSET_INITRD =3D Asset(
> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm6=
4/'
> +         'current/images/netboot/debian-installer/arm64/initrd.gz'),
> +        '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b=
4')
> +
> +    def test_hotplug_pci(self):
> +
> +        self.set_machine('virt')
> +        self.vm.add_args('-m', '512M')
> +        self.vm.add_args('-cpu', 'cortex-a57')
> +        self.vm.add_args('-append',
> +                         'console=3DttyAMA0,115200 init=3D/bin/sh')
> +        self.vm.add_args('-device',
> +                         'pcie-root-port,bus=3Dpcie.0,chassis=3D1,slot=
=3D1,id=3Dpcie.1')
> +        self.vm.add_args('-bios', self.build_file('pc-bios',
> +                                                  'edk2-aarch64-code.fd'=
))
> +
> +        # BusyBox prompt
> +        prompt =3D "~ #"
> +        self.launch_kernel(self.ASSET_KERNEL.fetch(),
> +                           self.ASSET_INITRD.fetch(),
> +                           wait_for=3Dprompt)
> +
> +        # Check for initial state: 2 network adapters, lo and enp0s1.
> +        exec_command_and_wait_for_pattern(self,
> +                                          'ls -l /sys/class/net | wc -l',
> +                                          '2')
> +
> +        # Hotplug one network adapter to the root port, i.e. pcie.1 bus.
> +        self.vm.cmd('device_add',
> +                    driver=3D'virtio-net-pci',
> +                    bus=3D'pcie.1',
> +                    addr=3D0,
> +                    id=3D'na')
> +        # Wait for the kernel to recognize the new device.
> +        self.wait_for_console_pattern('virtio-pci')
> +        self.wait_for_console_pattern('virtio_net')
> +
> +        # Check if there is a new network adapter.
> +        exec_command_and_wait_for_pattern(self,
> +                                          'ls -l /sys/class/net | wc -l',
> +                                          '3')
> +
> +        self.vm.cmd('device_del', id=3D'na')
> +        exec_command_and_wait_for_pattern(self,
> +                                          'ls -l /sys/class/net | wc -l',
> +                                          '2')
> +
> +if __name__ =3D=3D '__main__':
> +    LinuxKernelTest.main()

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

