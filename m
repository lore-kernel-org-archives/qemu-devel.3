Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2333C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 14:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Upo-0000Ra-IO; Fri, 04 Sep 2026 10:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Upm-0000QE-Dz
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 10:24:02 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Uph-0005Rn-I4
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 10:24:01 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-482dd6ee390so1067482f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788531836; x=1789136636; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FOHwcRT1ha8NxbaA7v7ojIm3nHwfpWFciO6qhEa6coQ=;
 b=oiHaVz4VOBKcGpxL9dRIwxFRA/FzdA/tKeJ93dhyMzRdW4LZt+TbSuqu/f/HgsLi0X
 Sb/iFZ3BULYIS9PX35yXva2jalE5ifbnQoc7zbyTifLmamJsyp8/es2fwW9GNhzd68aO
 bQty1Unz4QT58FY1EE9cCQcdGykZWHNvbHybm1SK0mZrM8EzoepU7Tk8+07Gc+qFd5I8
 OYngkLmY4D5s5+lyl8DMFL4zBeAI3cs9O3acQqOzHcmlELbh5Vwr4MxWYZgVW8nTGBsr
 TsLSZ5J/3eLlamJzLv7duAyrodMR5jwmiCByllF/6ilgr9f2YEsnqizpdICCpum9YcfN
 4A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788531836; x=1789136636;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FOHwcRT1ha8NxbaA7v7ojIm3nHwfpWFciO6qhEa6coQ=;
 b=IkXLG0U/9NSUQGa/qYIp9BmRzwOZ4WrI0/r2AHmOSGV46MTADJZandFM1uY8kTVdBN
 81RdZqNbVmav6D62QGXT0yOgeP/QFlpB3HHFikT+So44nr1gKVgV2flsQYyRxCAeNBq8
 rpy9+lAT4StGP58lux6DfFEY3hxNxzmHGfAnPnlYELnCcspRb25R93ZQIWPAlTfih/Ut
 SN7iBmajZWy+SAKA76nPxUR9FnbyB0ZPS1KIrhU0JQ0x5iC/jW9UiT8Uv+rZcQjiZXIY
 ryhtkPCJSxWrk1OkvpK+P9i+932zwfTRsdeAVBzYknhOwEx3WEa45wY/O8wZfvjahC50
 U5xA==
X-Forwarded-Encrypted: i=1;
 AKwUvByiFdukoBuZAnfjsHNWAS0K+0LR2A9mVx9bq2q1c6+mIgHzv+JFLfTAdyAKVS1jTqerEYIAKC/ngju6@nongnu.org
X-Gm-Message-State: AFuF++kw5ojIWfEqjAISYX3vv51jaatUkpFX1tQz48a2d74cJ+kqszqT
 LlCBOTzRHiIBn47d8e4mU8lAFGMs3dtYbRb62Gg1qWTpW2MN6rybg+FXyf92yaZNOUM=
X-Gm-Gg: AYBFou0LZ2eCXhLD3GLEiXwwbLKav1hhPzijrqC5X6uK/VRto5zHUJ7nOyTKe9qLpYN
 uaWpPR72moVJsDXOe2Jm6rnmIG/1w0i9nxKKKWFE8prpHlblpQjdz5A5bxHD/SDrJo3JzgrPlce
 ZlzN0CZ91DxK91666dGDBR2CeZyoXuwRfOoJde0MPLtyjyYY6xYWJU0pLdVdothg+MAOJ0IHPM0
 30CA2o6bilJcdi3PYhduu5mMl5oy1uszQDpWBoCLhSPtq1Jr7xPR/jOZiwtYAI30kz7gdXcXr+J
 CGBfVz9zK4RjiB/YCq7X/q6IHS+24GalOIs6vzGiXC1LaN6EySrqnSqrfcHk9NkVKt9fuaZkQOi
 4YXe1rOHQSL9SSqTL3pHrzHgAlMvNxD2Hq7NS2+d20mWC09eOV4Dx18dpKmGoCxG5S+yzk3qWGt
 B5E96NmWIdqjAdruMwQVVtLLhVhs9RbyDvZjv64HBBrufg1uSs0b+f3TkHvRf876wjKna3Eh4=
X-Received: by 2002:a5d:588d:0:b0:485:8c16:a338 with SMTP id
 ffacd0b85a97d-4858c16a615mr3941388f8f.45.1788531835477; 
 Fri, 04 Sep 2026 07:23:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883a9234sm6680716f8f.14.2026.09.04.07.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:23:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9218E5F954;
 Fri, 04 Sep 2026 15:23:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Bin Meng <bin.meng@processmission.com>,  QEMU <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org
Subject: Re: [PATCH 32/33] tests/functional/aarch64: Add Phytium Pi boot tests
In-Reply-To: <CAEUhbmXDFwhJrdh6w3f9pwG29W_6-ixxNiR3-jRo+4KuEHGO+g@mail.gmail.com>
 (Bin Meng's message of "Fri, 4 Sep 2026 16:52:46 +0800")
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-33-bin.meng@processmission.com>
 <87y0dipfhv.fsf@draig.linaro.org>
 <CAEUhbmXDFwhJrdh6w3f9pwG29W_6-ixxNiR3-jRo+4KuEHGO+g@mail.gmail.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Fri, 04 Sep 2026 15:23:53 +0100
Message-ID: <87mrtxp01y.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Bin Meng <bmeng.cn@gmail.com> writes:

> Hi Alex,
>
> On Thu, Sep 3, 2026 at 10:38=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>> Bin Meng <bin.meng@processmission.com> writes:
>>
>> > The Phytium Pi machine supports both the board firmware flow from SD
>> > and direct Linux boot. Exercise both paths with an SDK image bundle so
>> > firmware handoff and kernel loading regressions are caught.
>> >
>> > Verify U-Boot, PBF relocation, the Linux handoff, and login for the
>> > firmware path. The Linux test loads the bundled kernel, DTB, and
>> > initramfs and waits for the same login prompt.
>> >
>> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
>> > ---
>> >
>> >  tests/functional/aarch64/meson.build        |  2 +
>> >  tests/functional/aarch64/test_phytium_pi.py | 77 +++++++++++++++++++++
>> >  2 files changed, 79 insertions(+)
>> >  create mode 100644 tests/functional/aarch64/test_phytium_pi.py
>> >
>> > diff --git a/tests/functional/aarch64/meson.build b/tests/functional/a=
arch64/meson.build
>> > index f0881bed16..71bf45e4ea 100644
>> > --- a/tests/functional/aarch64/meson.build
>> > +++ b/tests/functional/aarch64/meson.build
>> > @@ -7,6 +7,7 @@ test_aarch64_timeouts =3D {
>> >    'device_passthrough' : 720,
>> >    'imx8mm_evk' : 240,
>> >    'imx8mp_evk' : 240,
>> > +  'phytium_pi' : 600,
>> >    'raspi4' : 480,
>> >    'reverse_debug' : 180,
>> >    'rme_virt' : 1200,
>> > @@ -39,6 +40,7 @@ tests_aarch64_system_thorough =3D [
>> >    'imx8mp_evk',
>> >    'kvm',
>> >    'multiprocess',
>> > +  'phytium_pi',
>> >    'raspi3',
>> >    'raspi4',
>> >    'replay',
>> > diff --git a/tests/functional/aarch64/test_phytium_pi.py b/tests/funct=
ional/aarch64/test_phytium_pi.py
>> > new file mode 100644
>> > index 0000000000..4ae0392bdd
>> > --- /dev/null
>> > +++ b/tests/functional/aarch64/test_phytium_pi.py
>> > @@ -0,0 +1,77 @@
>> > +#!/usr/bin/env python3
>> > +#
>> > +# Functional tests for the Phytium Pi machine
>> > +#
>> > +# Copyright (c) 2026 Process Mission
>> > +#
>> > +# Author:
>> > +#   Bin Meng <bin.meng@processmission.com>
>> > +#
>> > +# SPDX-License-Identifier: GPL-2.0-or-later
>> > +
>> > +from qemu_test import Asset, LinuxKernelTest
>> > +from qemu_test import skipBigDataTest, skipIfMissingCommands
>> > +
>> > +
>> > +class PhytiumPiMachine(LinuxKernelTest):
>> > +
>> > +    ASSET_BUILDROOT =3D Asset(
>> > +        ('https://github.com/processmission/qemu-machine-images/relea=
ses/'
>> > +         'download/v1.0.0/aarch64-phytium-pi-v1.0.0.tar.zst'),
>> > +
>> > '5219d52b862e1245b12f79ba72e9a6144f5e0cf1a50061f8fda2db0aeeb92428')
>>
>> Nice ;-)
>>
>> I've been looking into something similar to make it easy to set up
>> github projects that can build and host test assets:
>>
>>   https://github.com/stsquad/buildroot-asset
>
> This is actually very close to what I have been doing with
> https://github.com/processmission/qemu-machine-images. It is intended
> to be a common repository for QEMU machine test assets.
>
> Each machine has a small description under:
>
>   machine/<architecture>/<machine>/
>
> It selects the independently built components, required images and
> machine-specific QEMU launcher. The container builders, packaging,
> checksums, release manifest and GitHub Actions workflow are shared.
> The workflow also distinguishes between the main repository and forks.
> A fork can build selected machines and upload run-scoped Actions
> artifacts without publishing a release. It can optionally publish its
> own development prerelease, while the main repository publishes
> frozen, versioned assets.
>
>>
>> although my builds seem to take quite a bit longer that yours.
>
> Yeah, as I only built the minimal busybox-based buildroot
> configuration, which is enough for QEMU boot testing :)
>
>>
>> I wonder if there is a way to have a common repository set up but in a
>> way that the forks can just build their own images. Either that or a
>> core repository which everyone just forks adds their device and merges.
>
> So perhaps qemu-machine-images could serve as a starting point for the
> common repository you describe. I would be happy to accept machine
> definitions from other contributors and make the add-a-machine
> workflow simpler.
>
> Your buildroot-asset project also has useful ideas, particularly
> including enough Buildroot configuration and source metadata to
> reproduce an image manually. It would be good to align the two efforts
> instead of growing separate repositories for each maintainer or board.

I agree.

Let me see if I can port my vkmark test image to your repo and add the
metadata export to the image type.=20

>
>>
>> Anyway, test looks sane:
>>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Thanks for the review!
>
>>
>> > +
>> > +    def _prepare_images(self):
>> > +        self.set_machine('phytium-pi')
>> > +
>> > +        archive_path =3D self.uncompress(
>> > +            self.ASSET_BUILDROOT,
>> > +            target=3D'aarch64-phytium-pi-v1.0.0.tar',
>> > +            format=3D'zstd')
>> > +        self.archive_extract(archive_path, format=3D'tar')
>> > +
>> > +        self.vm.set_console(console_index=3D1)
>> > +        self.vm.add_args('-smp', '4',
>> > +                         '-m', '4G',
>> > +                         '-display', 'none',
>> > +                         '-nic', 'none',
>> > +                         '-no-reboot')
>> > +
>> > +    @skipIfMissingCommands('zstd')
>> > +    @skipBigDataTest()
>> > +    def test_firmware_boot(self):
>> > +        self._prepare_images()
>> > +        sdcard =3D self.scratch_file('images', 'sdcard.img')
>> > +
>> > +        self.vm.add_args(
>> > +            '-snapshot',
>> > +            '-drive', f'file=3D{sdcard},format=3Draw,if=3Dsd,index=3D=
0')
>> > +        self.vm.launch()
>> > +
>> > +        self.wait_for_console_pattern('U-Boot 2022.01')
>> > +        self.wait_for_console_pattern('PBF relocate done')
>> > +        self.wait_for_console_pattern('Starting kernel ...')
>> > +        self.wait_for_console_pattern('Phytium login:')
>> > +
>> > +    @skipIfMissingCommands('zstd')
>> > +    @skipBigDataTest()
>> > +    def test_linux_boot(self):
>> > +        self._prepare_images()
>> > +        kernel =3D self.scratch_file('images', 'Image.gz')
>> > +        dtb =3D self.scratch_file('images', 'phytiumpi_firefly.dtb')
>> > +        initrd =3D self.scratch_file('images', 'rootfs.cpio.gz')
>> > +
>> > +        self.vm.add_args(
>> > +            '-kernel', kernel,
>> > +            '-dtb', dtb,
>> > +            '-initrd', initrd,
>> > +            '-append', 'console=3DttyAMA1,115200 '
>> > +                       'earlycon=3Dpl011,mmio32,0x2800d000 rdinit=3D/=
init')
>> > +        self.vm.launch()
>> > +
>> > +        self.wait_for_console_pattern('Booting Linux on physical CPU')
>> > +        self.wait_for_console_pattern('Machine model: Phytium Pi Boar=
d')
>> > +        self.wait_for_console_pattern('Phytium login:')
>> > +
>> > +
>> > +if __name__ =3D=3D '__main__':
>> > +    LinuxKernelTest.main()
>>
>> --
>
> Regards,
> Bin

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

