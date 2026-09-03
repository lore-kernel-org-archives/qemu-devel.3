Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08AEC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28Zv-0000nN-4w; Thu, 03 Sep 2026 10:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x28Zu-0000nA-5N
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:38:10 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x28Zs-0001tc-7Y
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:38:09 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c20e70a0962so308899466b.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788446286; x=1789051086; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b4dfJ/+buXqwCV6OULOBqSK2R5P74SiM8Tme8QzB/xg=;
 b=xdhKmKnziZsZTPBiY7W2rMZvoQ3ULwY9hKAFNc6lgsuULrgGbM2wDEnPpYQnOYbFPI
 uIAzUfmWNFZ4CGys5q1iH7zu9t3LRHaiYoJSMyJ2fqz8HPcIZxUEJgkCHiUt/xq/hleZ
 szUg5p/0tEgiLc1/SkDvmWAPNQkZTa3HNwl8QDKzAgOlgAA/2MLQcr+k2ty1qVIp7TjM
 wED/Al7FzDE85kXjcR1MJEl66reUmlIA8jv3Xm+rljAyQrq1BXE+/+qor8HAq4yR9eKZ
 PMuloclK8Qry6Daet+jF9mBQHvPiovbT8RTQn5uzjgi+XH/2yL8uYgRM59//U5Ls8VB5
 YZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446286; x=1789051086;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b4dfJ/+buXqwCV6OULOBqSK2R5P74SiM8Tme8QzB/xg=;
 b=dZ54qlQl9aF9o0k4FlJYxRGRn3FkBbiP/OW6eQ7KAE0oTkxWsIPYCh1YZnJ82z6joa
 TP9mzuZxG4v9mt2A5uAr2e3ZUjKb6h6k8VhHse/9Lur1oedYs4kMEjE35Kf7P0eoImVI
 6St/EX66CaZosVdsF62Cv/sASUHlmOpnnVv2PoRdM23T5YCqGnPwSnRQ6E7UvgT2X4CB
 DGT5d/+ILknP+cPwzgg+69Z9V46KS9wesvo0+8AEZ7ZhgG5SCt5VKY3QZaqW17s5rnmK
 PJfSZ5NSvcN6S0jXK2+UYxr/jnaCcUE5ZU0UyCgClr0geu/ON1f5VHuY4QouQxLwuvI8
 mYGw==
X-Gm-Message-State: AFuF++ln8LN0DT76G1fBNKakQg7e170OoyTf2SFZDQm1is84O0Y7lFiJ
 W2nVr4p8Eg2FbC3/dFRObe0rWODZMJIzTQW1IwKBvSH4MaaTfIKnjg/Em6FJd33+2639lfuOh8k
 aGOqWN/o=
X-Gm-Gg: AYBFou24qbAdfUDOzQJwmrQx3TLqYcXNYAGZxzaSBYhVtrP+zKNSzlgLp/WmnA68aOb
 H0aMfX/QwuHVAQKHloXqNuqiutGIM0gJ0svrucddBCYpf1FExWPvHlwdtaUuSX0C6m8H6FYWfUT
 07b9p6UeoRT5vq9F1B5flusm7/in63HfeecT7K4zLqvCt63PpZ8mgS4JPCsJeAcS0d2wapN5iAL
 6emdFPAFSABIo/GXVT4fXAkwPcSgKt1M3KOlXsTwyZoQkIrB1i4WBuIGHeE+HuFcnICEfPmfKHd
 I4/FAoKX4sIOBMYmeQuU01DWhZ1gb0V7f2rfMAJNUqQO1K85S6na7bRbwOsRARYjLBQBfZtaLpA
 SZSkLqqTVZRIpGH3f6VmHKY+snas58IAeDDHPZynAxncNOP45UkRpMwV9XnW1aA/7HuRv1u/m4o
 Xkh22CXiErM8MB9lYVUVoA39yzx79Cnq2+2HkOrP6A7gElBUfR73+R3mHxbMOH
X-Received: by 2002:a17:906:478a:b0:c08:417e:3696 with SMTP id
 a640c23a62f3a-c25d554d729mr805539266b.20.1788446286253; 
 Thu, 03 Sep 2026 07:38:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25f4172032sm107674766b.22.2026.09.03.07.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:38:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3FFD05F8FD;
 Thu, 03 Sep 2026 15:38:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 32/33] tests/functional/aarch64: Add Phytium Pi boot tests
In-Reply-To: <20260903112532.3276678-33-bin.meng@processmission.com> (Bin
 Meng's message of "Thu, 3 Sep 2026 19:25:12 +0800")
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-33-bin.meng@processmission.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Thu, 03 Sep 2026 15:38:04 +0100
Message-ID: <87y0dipfhv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Bin Meng <bin.meng@processmission.com> writes:

> The Phytium Pi machine supports both the board firmware flow from SD
> and direct Linux boot. Exercise both paths with an SDK image bundle so
> firmware handoff and kernel loading regressions are caught.
>
> Verify U-Boot, PBF relocation, the Linux handoff, and login for the
> firmware path. The Linux test loads the bundled kernel, DTB, and
> initramfs and waits for the same login prompt.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
>
>  tests/functional/aarch64/meson.build        |  2 +
>  tests/functional/aarch64/test_phytium_pi.py | 77 +++++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 tests/functional/aarch64/test_phytium_pi.py
>
> diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarc=
h64/meson.build
> index f0881bed16..71bf45e4ea 100644
> --- a/tests/functional/aarch64/meson.build
> +++ b/tests/functional/aarch64/meson.build
> @@ -7,6 +7,7 @@ test_aarch64_timeouts =3D {
>    'device_passthrough' : 720,
>    'imx8mm_evk' : 240,
>    'imx8mp_evk' : 240,
> +  'phytium_pi' : 600,
>    'raspi4' : 480,
>    'reverse_debug' : 180,
>    'rme_virt' : 1200,
> @@ -39,6 +40,7 @@ tests_aarch64_system_thorough =3D [
>    'imx8mp_evk',
>    'kvm',
>    'multiprocess',
> +  'phytium_pi',
>    'raspi3',
>    'raspi4',
>    'replay',
> diff --git a/tests/functional/aarch64/test_phytium_pi.py b/tests/function=
al/aarch64/test_phytium_pi.py
> new file mode 100644
> index 0000000000..4ae0392bdd
> --- /dev/null
> +++ b/tests/functional/aarch64/test_phytium_pi.py
> @@ -0,0 +1,77 @@
> +#!/usr/bin/env python3
> +#
> +# Functional tests for the Phytium Pi machine
> +#
> +# Copyright (c) 2026 Process Mission
> +#
> +# Author:
> +#   Bin Meng <bin.meng@processmission.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import Asset, LinuxKernelTest
> +from qemu_test import skipBigDataTest, skipIfMissingCommands
> +
> +
> +class PhytiumPiMachine(LinuxKernelTest):
> +
> +    ASSET_BUILDROOT =3D Asset(
> +        ('https://github.com/processmission/qemu-machine-images/releases=
/'
> +         'download/v1.0.0/aarch64-phytium-pi-v1.0.0.tar.zst'),
> +
> '5219d52b862e1245b12f79ba72e9a6144f5e0cf1a50061f8fda2db0aeeb92428')

Nice ;-)

I've been looking into something similar to make it easy to set up
github projects that can build and host test assets:

  https://github.com/stsquad/buildroot-asset

although my builds seem to take quite a bit longer that yours.

I wonder if there is a way to have a common repository set up but in a
way that the forks can just build their own images. Either that or a
core repository which everyone just forks adds their device and merges.

Anyway, test looks sane:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> +
> +    def _prepare_images(self):
> +        self.set_machine('phytium-pi')
> +
> +        archive_path =3D self.uncompress(
> +            self.ASSET_BUILDROOT,
> +            target=3D'aarch64-phytium-pi-v1.0.0.tar',
> +            format=3D'zstd')
> +        self.archive_extract(archive_path, format=3D'tar')
> +
> +        self.vm.set_console(console_index=3D1)
> +        self.vm.add_args('-smp', '4',
> +                         '-m', '4G',
> +                         '-display', 'none',
> +                         '-nic', 'none',
> +                         '-no-reboot')
> +
> +    @skipIfMissingCommands('zstd')
> +    @skipBigDataTest()
> +    def test_firmware_boot(self):
> +        self._prepare_images()
> +        sdcard =3D self.scratch_file('images', 'sdcard.img')
> +
> +        self.vm.add_args(
> +            '-snapshot',
> +            '-drive', f'file=3D{sdcard},format=3Draw,if=3Dsd,index=3D0')
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('U-Boot 2022.01')
> +        self.wait_for_console_pattern('PBF relocate done')
> +        self.wait_for_console_pattern('Starting kernel ...')
> +        self.wait_for_console_pattern('Phytium login:')
> +
> +    @skipIfMissingCommands('zstd')
> +    @skipBigDataTest()
> +    def test_linux_boot(self):
> +        self._prepare_images()
> +        kernel =3D self.scratch_file('images', 'Image.gz')
> +        dtb =3D self.scratch_file('images', 'phytiumpi_firefly.dtb')
> +        initrd =3D self.scratch_file('images', 'rootfs.cpio.gz')
> +
> +        self.vm.add_args(
> +            '-kernel', kernel,
> +            '-dtb', dtb,
> +            '-initrd', initrd,
> +            '-append', 'console=3DttyAMA1,115200 '
> +                       'earlycon=3Dpl011,mmio32,0x2800d000 rdinit=3D/ini=
t')
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('Booting Linux on physical CPU')
> +        self.wait_for_console_pattern('Machine model: Phytium Pi Board')
> +        self.wait_for_console_pattern('Phytium login:')
> +
> +
> +if __name__ =3D=3D '__main__':
> +    LinuxKernelTest.main()

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

