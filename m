Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3719C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtQW-0001lu-A6; Mon, 21 Jul 2025 12:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1udtPl-000114-LV
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:31:03 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1udtPj-00030H-1o
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:30:57 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-60c5b8ee2d9so9301079a12.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753115452; x=1753720252; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAFJoe4zn2cEckNZyJyl4AgIjTyqG38eTlRW/mL3ftk=;
 b=vZj1HsGRBI6yfULbmFBqXJ/DXkp7xj/1WmRiWe+XZc6kSi5Ine0StE7Kf3pAkDuibD
 mC+n3rdauGAfO+q+HkUyUkfLVUO/lWTbu0+zZgLV3o7LIg5jYR4NhAbDvQ8MYQaPtDxe
 +r9owsCaEbp/Xrcq/HsWn28IuP1OtnOZErrBKutV0I7FMe9/+AzRO3UO49D8o1FZV4cs
 2F6CQCkfsMC55UnCaArOxh8fkt8R7ZlFbLWCDv0NHwhLH3rB3YAvWM6pNdRb+p+OPRBD
 47g/qOc98PkVwr3ZrtIrDr8kbmT1KS9vQhzBJxjKj21+/Wcba026z3E4pbbMYDL6Z5sD
 4mCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753115452; x=1753720252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAFJoe4zn2cEckNZyJyl4AgIjTyqG38eTlRW/mL3ftk=;
 b=mMvXcFhzp/3aaOjT0JuD/99TaMLVW72ZEXjbJCi1AWt3rvoEWfI7jZes6Ol/AyTbSu
 oIw285E2sPVZxUpkLr23agGFfp4cuavI3kOmDyoO103GQM09guPRmuexrsmoSzoTTAxa
 2tiN9pzABWjS2em1JgZapk5KZ1+qRNBjWoRb1IFSp4or5/R8j27coR7bg5WiTnB40EsJ
 SnO1ME6tJUJ5QE6o//WVhe3CpXPPDg1WVFoo28qERgZDO/wJo5pODX9xOWXhimDFTbQG
 TafzxsgFH1PrXXrpD5TnPm1qy9fK8PsqbMgOzAvfL06Q/CAD9thHysa08oUbRed/Edu/
 Kudg==
X-Gm-Message-State: AOJu0Yxp2RE/DvwW7mzl0sjQgbfGi2CAmziBwbUuf2/h4EIk7plGfGPL
 nTA4jQ9XKViVMXK/RNokg0y6KaW3UcyLkgBogmrN0Y8AedOeif0m1FGWZbhgX4Wh98p0U2Y4K+c
 AYMBUcO7NRayonLuhhfQCpW24BYEB/AW0ETmEBRrn3Q==
X-Gm-Gg: ASbGncuFhmY/a89wYQ+Ad1kwS+OvwBHqkVB5JTp4DkLdjs4fZrOgjvsl/yTLvOF8Fun
 8QdFKZT4e8bM2Cc/4vRS2KWwPtmjkP6z1ILJVGP4kzRQpRsdE8n4bEzdKwqSZfLKnf/miYUejcY
 sm0e4aMJyrowvYDcOrh7+Y/bKynGfuADeLXu9JH+66hRCDURfY/AvhIPbXTtiQ8lBD0hIy9ka3C
 DM3rw==
X-Google-Smtp-Source: AGHT+IF4DqbPUQZgdslFXKkvu4u2DLuNi/MRvp81YTzem9JU3q1Tlpa6Aa2JQf6vyDVPT+1I5LR8FFiwhVjTs3Hp6F4=
X-Received: by 2002:a05:6402:4314:b0:608:3571:6942 with SMTP id
 4fb4d7f45d1cf-61281f1d344mr16911333a12.1.1753115452002; Mon, 21 Jul 2025
 09:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250721153326.783646-1-alex.bennee@linaro.org>
In-Reply-To: <20250721153326.783646-1-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 21 Jul 2025 19:30:25 +0300
X-Gm-Features: Ac12FXxG61FEnHPa7wGVctrh6PUPwGHxcjXl_WYsBokHFpDmOujRioE6bpKFpJk
Message-ID: <CAAjaMXbzCf69Vt5oKz-wCcmpxETLNg0o37AxX7_WR1AB954Pjw@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/functional: add hypervisor test for aarch64
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mark Burton <mburton@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, Jul 21, 2025 at 6:34=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> This is a simple test case that runs an image with kvmtool and
> kvm-unit-tests which can validate virtualisation works. This is useful
> for exercising TCG but can also be applied to any nested virt setup
> which is why it doesn't specify an accelerator.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Mark Burton <mburton@qti.qualcomm.com>
> ---
>  tests/functional/meson.build         |  1 +
>  tests/functional/test_aarch64_kvm.py | 83 ++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
>  create mode 100755 tests/functional/test_aarch64_kvm.py
>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 8bebcd4d94e..ecf965adc6c 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -89,6 +89,7 @@ tests_aarch64_system_thorough =3D [
>    'aarch64_device_passthrough',
>    'aarch64_hotplug_pci',
>    'aarch64_imx8mp_evk',
> +  'aarch64_kvm',
>    'aarch64_raspi3',
>    'aarch64_raspi4',
>    'aarch64_replay',
> diff --git a/tests/functional/test_aarch64_kvm.py b/tests/functional/test=
_aarch64_kvm.py
> new file mode 100755
> index 00000000000..a42d82872af
> --- /dev/null
> +++ b/tests/functional/test_aarch64_kvm.py
> @@ -0,0 +1,83 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that runs subsets of kvm-unit-tests on Aarch64.
> +# These can run on TCG and any accelerator supporting nested
> +# virtualisation.
> +#
> +# Copyright (c) 2025 Linaro
> +#
> +# Author:
> +#  Alex Benn=C3=A9e <alex.bennee@linaro.org>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu.machine.machine import VMLaunchFailure
> +
> +from qemu_test import Asset
> +from qemu_test import exec_command_and_wait_for_pattern as ec_and_wait
> +from qemu_test.linuxkernel import LinuxKernelTest
> +
> +
> +class Aarch64VirtKVMTests(LinuxKernelTest):
> +
> +    ASSET_KVM_TEST_KERNEL =3D Asset(
> +        'https://fileserver.linaro.org/s/HmjaxXXYHYSqbes/'
> +        'download?path=3D%2F&files=3D'
> +        'image-with-kvm-tool-and-unit-tests.gz',
> +        '34de4aaea90db5da42729e7d28b77f392c37a2f4da859f889a5234aaf097069=
6')
> +
> +    # make it easier to detect successful return to shell
> +    PS1 =3D 'RES=3D[$?] # '
> +    OK_CMD =3D 'RES=3D[0] # '
> +
> +    # base of tests
> +    KUT_BASE =3D "/usr/share/kvm-unit-tests/"
> +
> +    def _launch_guest(self, kvm_mode=3D"nvhe"):
> +
> +        self.set_machine('virt')
> +        kernel_path =3D self.ASSET_KVM_TEST_KERNEL.fetch()
> +
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               f"console=3DttyAMA0 kvm-arm.mode=3D{kvm_m=
ode}")
> +
> +        self.vm.add_args("-cpu", "cortex-a72")
> +        self.vm.add_args("-machine", "virt,gic-version=3D3,virtualizatio=
n=3Don",
> +                         '-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        self.vm.add_args("-smp", "2", "-m", "320")
> +
> +        try:
> +            self.vm.launch()
> +        except VMLaunchFailure as excp:
> +            self.log.info("unhandled launch failure: %s", excp.output)
> +            raise excp
> +
> +        self.wait_for_console_pattern('buildroot login:')
> +        ec_and_wait(self, 'root', '#')
> +        ec_and_wait(self, f"export PS1=3D'{self.PS1}'", self.OK_CMD)
> +
> +
> +    def test_aarch64_nvhe_selftest(self):
> +
> +        self._launch_guest("nvhe")
> +
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-setup", self.OK_CMD=
)
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-smp", self.OK_CMD)
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-vectors-kernel", se=
lf.OK_CMD)
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-vectors-user", self=
.OK_CMD)

These could probably be merged in _launch_guest() just as well

> +
> +
> +    def test_aarch64_vhe_selftest(self):
> +
> +        self._launch_guest("vhe")
> +
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-setup", self.OK_CMD=
)
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-smp", self.OK_CMD)
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-vectors-kernel", se=
lf.OK_CMD)
> +        ec_and_wait(self, f"{self.KUT_BASE}/selftest-vectors-user", self=
.OK_CMD)
> +
> +
> +if __name__ =3D=3D '__main__':
> +    LinuxKernelTest.main()
> --
> 2.47.2
>
>

Tested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

