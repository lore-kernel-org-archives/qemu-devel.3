Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683CAC54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 15:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIqxC-0007d8-Sg; Sat, 24 May 2025 11:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uIqxA-0007cx-2U
 for qemu-devel@nongnu.org; Sat, 24 May 2025 11:38:28 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uIqx7-0005G4-Nf
 for qemu-devel@nongnu.org; Sat, 24 May 2025 11:38:27 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-601f278369bso1676257a12.1
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 08:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748101102; x=1748705902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SOkRho4ifL0KQlTw9HAxQGYJduiEFISXV9vo1c/ohsE=;
 b=YW4NZTFhsm4Js73TIE+5nQM+VDY6vkG0HDblip5cbmeYbo01LxHQVCUtj7p0zc+Ph+
 J3CcZBwF/xYeRfVxEXxwYhlzbJfsS8dSviegRqNTpwO31x93BZGr2kFH6X/QO+YUPM16
 5/q1/vnElX4rwL3PIqvQ75bId7ZZbgggcpp7qI+71U6ETkNkJE4Jka6WuWQ2omSbBbzo
 KqPbOvAypa5nq33jqtuosPhuozJdzUbwXoVAyRvOJVyw1otZGLJdr72OIB+SQsVvRMOd
 KM/05tpOqhC1EsxIU46/azfmJlqx5u/LM1KEoaaQKfZUvi9/HszIOf/Mfkn1Z9nrBF4N
 30/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748101102; x=1748705902;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SOkRho4ifL0KQlTw9HAxQGYJduiEFISXV9vo1c/ohsE=;
 b=Zd44jRM2XS8ORLp+gPr86YND6IwGWXmYobagmRwMNHiZp8v+WU6QM0G2ByVIgYlPAF
 wjNHJvS+nXDk9D0TkJdJ7SVc8h1cdv4/KSNdr5+JwV4qPkf+QP6rwKQGFliRpqxgjQIJ
 +fX/reAZVueHvyRQ8ilnx/trNF53rbH0FJD2NaDdEDC4bgAQLI/H1R8f6IHTjQde3n5A
 nrdHojhFaaV7trecdmd8/v56vQsH58c65os4ErMSRYKiAFfDouC9vq6QdYso4CbGC8mF
 9MdrDVgECO+k6HTB7lMPs7C5fVvsViP79UcGXDQ7tCOiJVWODv6wmrqgW+Bdw801yJ+C
 ifPw==
X-Gm-Message-State: AOJu0YyR9H+MNL5vvJq2qpyEYb/QkQpezyuETZDV5yh8XDyL3cIPuAnm
 0waT9tf+eDgMV83ntCQbtbTpgzS5o5XioyHfyKuZGxl1G30ZrgCZuTwULuqZEPUheuA=
X-Gm-Gg: ASbGncvF7gxR+NKXz+oYA2XbP1yOOKEjS/IrtWG4vjFRkAaH9Qn+ha3HXvflqTflg7C
 QQFkaN+IDQ/WL+cb+dNP8baBZsL9kG4BjDqqv8RPm52gdAC1lRpNKs6M5T08WNijkbaQv67xYyU
 WxoGISqq1OAvcDt2V5rbOo0J0aY98UfMKL5pIBPH4zTDpwGNsRPIHp+5C0dCddOg151gesEDqwm
 wVgySM6MlQQhPtpu4NXGOgMsGbGRlkYB05ZqaM3q6WjHKjWmoH30E25ldlRUA1pPxQf3M0MnEB0
 Xfva/+NCkhYOEXWG113+/uhTgqQRb2O1UxcUQtyHUsgj2JY6fcWq
X-Google-Smtp-Source: AGHT+IHX8yxfzpH9XCieuhWHJfJdA5iCmT1UaN1XUJj5Ru6QtRvSdkAoZ8mS+GxmJRJKHM60VQPa6A==
X-Received: by 2002:a05:6402:3486:b0:601:89d4:968e with SMTP id
 4fb4d7f45d1cf-602dacbfd7amr2417019a12.27.1748101102408; 
 Sat, 24 May 2025 08:38:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-602d2282d3asm1267520a12.16.2025.05.24.08.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 08:38:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D30D75F782;
 Sat, 24 May 2025 16:38:20 +0100 (BST)
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
Date: Sat, 24 May 2025 16:38:20 +0100
Message-ID: <87a57210k3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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
> +
> '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')

Hmm do we need to specify a checksum type now?

  TAP version 13
  not ok 1 test_aarch64_hotplug_pci.HotplugPCI.test_hotplug_pci
  1..1
  ----------------------------------- stderr ------------------------------=
-----
  Traceback (most recent call last):
    File "/home/alex/lsrc/qemu.git/tests/functional/test_aarch64_hotplug_pc=
i.py", line 44, in test_hotplug_pci
      self.launch_kernel(self.ASSET_KERNEL.fetch(),
                         ~~~~~~~~~~~~~~~~~~~~~~~^^
    File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/asset.py", li=
ne 189, in fetch
      raise AssetError(self, "Hash does not match %s" % self.hash)
  qemu_test.asset.AssetError: https://ftp.debian.org/debian/dists/stable/ma=
in/installer-arm64/current/images/netboot/debian-installer/arm64/linux: Has=
h does not match 3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca=
3117b2

  More information on test_aarch64_hotplug_pci.HotplugPCI.test_hotplug_pci =
could be found here:
   /home/alex/lsrc/qemu.git/builds/all/tests/functional/aarch64/test_aarch6=
4_hotplug_pci.HotplugPCI.test_hotplug_pci/base.log
   /home/alex/lsrc/qemu.git/builds/all/tests/functional/aarch64/test_aarch6=
4_hotplug_pci.HotplugPCI.test_hotplug_pci/console.log

  (test program exited with status code 1)
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

In fact could we use the existing tuxrun images instead of relying on
debian stable not changing?

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

