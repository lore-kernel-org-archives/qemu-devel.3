Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBE5C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2PfT-0004rj-In; Fri, 04 Sep 2026 04:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x2PfR-0004r2-T1
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:53:01 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x2PfQ-00077e-0f
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:53:01 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-836c4474028so8677767b3.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 01:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788511978; cv=none;
 d=google.com; s=arc-20260327;
 b=o4IEi0LxzvQNj1Dm7y7Y5Nc2KZ0Ay1+uEMJb7W0UpvKrHQGvpXW05JpbkaWNDvVIwA
 /Xj7RKZCe4oVo8lLxCm4Ha2U8tmIJbgvYNo1Zs8RJA24lIntwMuxeOUt/W46u4E/1w7n
 s6mcpR6XVlg8zk3+oQNhgWEphTab2L9hJWCvCjXuhXxJwBWBohVEh1okmBBX+fbyi0w1
 5FO3n/x6bf4XvgH0Ar2ZQ1IpYscL6Wc09iKroeDk9qvygnHU7TqwL9yWmVypJuT+In9j
 rw7LM1Opuk18trLnLmJ7JB4zEsiSPlBU2IzQC7C91DomQcxSBk10i9/OPs9KLUvPt6/c
 xQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YU0H9nAuS37wxDxYALgdBEzrRf0vvgwOfz9NZINVtyk=;
 fh=PHFMoUamJdBOI2Ts8oQ7xUntPbB8kq8EKBfuZa376Xg=;
 b=XxqCMd/yg/WWDJ38JvneTTNUHokBAm7kdCqSLk2G15EgsjhRhiDLtK/P9ZvMmcJ6F1
 p4ulzI0coIF/sHhkwialOpUimo6wR745E/7sZo+4stLY78pUvx0el0OWH4Xd7vS5FY+e
 hyPBW2wf01QHy7cI5JIoc7rqyTF2A3A01xISENr9GeYSJ2wkx6F0esNEiAadRopqMaIg
 Mimg/rz6XfHmUpnwdZqh/rtEVPf4FtnkTzjbYLoS7D9UmJfqgd3ueB/wrs88LuA5uHGZ
 2AW2JreRTG2Jph5Xgp7s425Wdnio96rWeww6TPZ0VEXZ3HG7mShaKhN1U/tPIo5JHSbo
 DPRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788511978; x=1789116778; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YU0H9nAuS37wxDxYALgdBEzrRf0vvgwOfz9NZINVtyk=;
 b=DXGBOySSRSOIshN16u9V8M9F4+PHjjj5AVAXcZhrJKLNmLmdaNtXOh1Go/0SvNBinZ
 J4tXZeBjZL4p2273vPhgqra/1oL7BpBeEdVtT5ArRnG67i7SE4kROVUGBpCW0wTGHUGZ
 qJcRyGryvbo/30Y2rRTbY25oAUdsruwzp1YB+c3uBqEd4E7TSQ6BvMy82VwPqM+TjFn3
 QRBC5mcwxrkKgmB5MYAvkE+z7z6yAcJBIJd/V0HYdUYWC9l0Q39O2f/SaYeaVAqlUq1O
 axGWnwDs9GijnBebPw9UwwauiIPa0oRYcOxlVBdmDNwm0CelMxT/4WbY8v8KbBJZSqj3
 WlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788511978; x=1789116778;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YU0H9nAuS37wxDxYALgdBEzrRf0vvgwOfz9NZINVtyk=;
 b=lqJRog4vhM+b7SG4oq18mrbr4jrP55B1MW3x8fIifjySWuEZ9e0yaLAXk9lF86zHM3
 oN4xkMiGBTiZ76VzKTXcLdtWo5/pDxy/CYAoxxMDMWX8Ht1P8RlFROD74zuRT/P9cm4o
 +MAvFw8wJ+2nR02kiN9eYuYashYIsrX0BJiMy6OqzK6AAojYew0V2aWmPuSNFPWQuVzm
 u2o3zPubnp+AU8x7FQ9LWkeX5MdG7OkKJk0+XVicJ4lv3U0vNDSMvveHHi9jxue8vabC
 At45xC4cejrygiEomoPsoIlfhdD992BECbJp7w5xLGb1Dnq1fFqG1Pk421Ql8DfMbEUz
 opJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhxuVu8fdBpPgvBi5PhWc5raLmCqJ8lfVQ+bdcKJ51A1a7PXtkS6D4+MeHJZB3oOgQKm+12wJu9WR8@nongnu.org
X-Gm-Message-State: AFuF++lee//rk6jW7j34lilPIhSrPIKplG8JcuhZsRBimBQ3IZp8kW6S
 WSpZ4zeVvGTg1krn4q6VjHcjgxSaqiz4k9nELD2NvF9//ucKMjDBKAvWI1V1+k3Wtn2PhP2OtnS
 GfWbt7Q516c+zIKUBr5NSUguH1NmwzHY=
X-Gm-Gg: AYBFou1cEK05Si0o1io/9WSmYGz+dTqzcEnOE64j2G41BX7V50neznvP1AyfVjpUib3
 igZ9UXuRNvxBGoPYnR+GL22XZGZpD+Xai5vHnR9RCWZCERKIM8ZfEShSMJdVcsOc05iFC14z7O9
 lGGZsUFnyAavjbPoWS5zY8c7Ri7D7sgbClpGZ0F/Lw7y/mutFBQhE+oL6UWuCPUpbBLM68Fuu1G
 3tj8XSpARjwPPKfGrLLmJ3K/z2ZV1ZJZEbVh5bANwfBSpgjfS9zgN6K+KtQzM1ksamZGZKZvlri
 y2ZDY/BheZZXbnax+SS07qLKq32ERVwYPPR/27sJZiCo
X-Received: by 2002:a05:690c:c59f:b0:86a:5def:5f15 with SMTP id
 00721157ae682-8712800debamr20165177b3.29.1788511978543; Fri, 04 Sep 2026
 01:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-33-bin.meng@processmission.com>
 <87y0dipfhv.fsf@draig.linaro.org>
In-Reply-To: <87y0dipfhv.fsf@draig.linaro.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 4 Sep 2026 16:52:46 +0800
X-Gm-Features: AcwNN1XoRcVVUYWqSma1V2tDLFiFsRbYBEm6NwNA5exZ7fNtvan5tpjt_VFEeKI
Message-ID: <CAEUhbmXDFwhJrdh6w3f9pwG29W_6-ixxNiR3-jRo+4KuEHGO+g@mail.gmail.com>
Subject: Re: [PATCH 32/33] tests/functional/aarch64: Add Phytium Pi boot tests
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Alex,

On Thu, Sep 3, 2026 at 10:38=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Bin Meng <bin.meng@processmission.com> writes:
>
> > The Phytium Pi machine supports both the board firmware flow from SD
> > and direct Linux boot. Exercise both paths with an SDK image bundle so
> > firmware handoff and kernel loading regressions are caught.
> >
> > Verify U-Boot, PBF relocation, the Linux handoff, and login for the
> > firmware path. The Linux test loads the bundled kernel, DTB, and
> > initramfs and waits for the same login prompt.
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > ---
> >
> >  tests/functional/aarch64/meson.build        |  2 +
> >  tests/functional/aarch64/test_phytium_pi.py | 77 +++++++++++++++++++++
> >  2 files changed, 79 insertions(+)
> >  create mode 100644 tests/functional/aarch64/test_phytium_pi.py
> >
> > diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aa=
rch64/meson.build
> > index f0881bed16..71bf45e4ea 100644
> > --- a/tests/functional/aarch64/meson.build
> > +++ b/tests/functional/aarch64/meson.build
> > @@ -7,6 +7,7 @@ test_aarch64_timeouts =3D {
> >    'device_passthrough' : 720,
> >    'imx8mm_evk' : 240,
> >    'imx8mp_evk' : 240,
> > +  'phytium_pi' : 600,
> >    'raspi4' : 480,
> >    'reverse_debug' : 180,
> >    'rme_virt' : 1200,
> > @@ -39,6 +40,7 @@ tests_aarch64_system_thorough =3D [
> >    'imx8mp_evk',
> >    'kvm',
> >    'multiprocess',
> > +  'phytium_pi',
> >    'raspi3',
> >    'raspi4',
> >    'replay',
> > diff --git a/tests/functional/aarch64/test_phytium_pi.py b/tests/functi=
onal/aarch64/test_phytium_pi.py
> > new file mode 100644
> > index 0000000000..4ae0392bdd
> > --- /dev/null
> > +++ b/tests/functional/aarch64/test_phytium_pi.py
> > @@ -0,0 +1,77 @@
> > +#!/usr/bin/env python3
> > +#
> > +# Functional tests for the Phytium Pi machine
> > +#
> > +# Copyright (c) 2026 Process Mission
> > +#
> > +# Author:
> > +#   Bin Meng <bin.meng@processmission.com>
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +from qemu_test import Asset, LinuxKernelTest
> > +from qemu_test import skipBigDataTest, skipIfMissingCommands
> > +
> > +
> > +class PhytiumPiMachine(LinuxKernelTest):
> > +
> > +    ASSET_BUILDROOT =3D Asset(
> > +        ('https://github.com/processmission/qemu-machine-images/releas=
es/'
> > +         'download/v1.0.0/aarch64-phytium-pi-v1.0.0.tar.zst'),
> > +
> > '5219d52b862e1245b12f79ba72e9a6144f5e0cf1a50061f8fda2db0aeeb92428')
>
> Nice ;-)
>
> I've been looking into something similar to make it easy to set up
> github projects that can build and host test assets:
>
>   https://github.com/stsquad/buildroot-asset

This is actually very close to what I have been doing with
https://github.com/processmission/qemu-machine-images. It is intended
to be a common repository for QEMU machine test assets.

Each machine has a small description under:

  machine/<architecture>/<machine>/

It selects the independently built components, required images and
machine-specific QEMU launcher. The container builders, packaging,
checksums, release manifest and GitHub Actions workflow are shared.
The workflow also distinguishes between the main repository and forks.
A fork can build selected machines and upload run-scoped Actions
artifacts without publishing a release. It can optionally publish its
own development prerelease, while the main repository publishes
frozen, versioned assets.

>
> although my builds seem to take quite a bit longer that yours.

Yeah, as I only built the minimal busybox-based buildroot
configuration, which is enough for QEMU boot testing :)

>
> I wonder if there is a way to have a common repository set up but in a
> way that the forks can just build their own images. Either that or a
> core repository which everyone just forks adds their device and merges.

So perhaps qemu-machine-images could serve as a starting point for the
common repository you describe. I would be happy to accept machine
definitions from other contributors and make the add-a-machine
workflow simpler.

Your buildroot-asset project also has useful ideas, particularly
including enough Buildroot configuration and source metadata to
reproduce an image manually. It would be good to align the two efforts
instead of growing separate repositories for each maintainer or board.

>
> Anyway, test looks sane:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks for the review!

>
> > +
> > +    def _prepare_images(self):
> > +        self.set_machine('phytium-pi')
> > +
> > +        archive_path =3D self.uncompress(
> > +            self.ASSET_BUILDROOT,
> > +            target=3D'aarch64-phytium-pi-v1.0.0.tar',
> > +            format=3D'zstd')
> > +        self.archive_extract(archive_path, format=3D'tar')
> > +
> > +        self.vm.set_console(console_index=3D1)
> > +        self.vm.add_args('-smp', '4',
> > +                         '-m', '4G',
> > +                         '-display', 'none',
> > +                         '-nic', 'none',
> > +                         '-no-reboot')
> > +
> > +    @skipIfMissingCommands('zstd')
> > +    @skipBigDataTest()
> > +    def test_firmware_boot(self):
> > +        self._prepare_images()
> > +        sdcard =3D self.scratch_file('images', 'sdcard.img')
> > +
> > +        self.vm.add_args(
> > +            '-snapshot',
> > +            '-drive', f'file=3D{sdcard},format=3Draw,if=3Dsd,index=3D0=
')
> > +        self.vm.launch()
> > +
> > +        self.wait_for_console_pattern('U-Boot 2022.01')
> > +        self.wait_for_console_pattern('PBF relocate done')
> > +        self.wait_for_console_pattern('Starting kernel ...')
> > +        self.wait_for_console_pattern('Phytium login:')
> > +
> > +    @skipIfMissingCommands('zstd')
> > +    @skipBigDataTest()
> > +    def test_linux_boot(self):
> > +        self._prepare_images()
> > +        kernel =3D self.scratch_file('images', 'Image.gz')
> > +        dtb =3D self.scratch_file('images', 'phytiumpi_firefly.dtb')
> > +        initrd =3D self.scratch_file('images', 'rootfs.cpio.gz')
> > +
> > +        self.vm.add_args(
> > +            '-kernel', kernel,
> > +            '-dtb', dtb,
> > +            '-initrd', initrd,
> > +            '-append', 'console=3DttyAMA1,115200 '
> > +                       'earlycon=3Dpl011,mmio32,0x2800d000 rdinit=3D/i=
nit')
> > +        self.vm.launch()
> > +
> > +        self.wait_for_console_pattern('Booting Linux on physical CPU')
> > +        self.wait_for_console_pattern('Machine model: Phytium Pi Board=
')
> > +        self.wait_for_console_pattern('Phytium login:')
> > +
> > +
> > +if __name__ =3D=3D '__main__':
> > +    LinuxKernelTest.main()
>
> --

Regards,
Bin

