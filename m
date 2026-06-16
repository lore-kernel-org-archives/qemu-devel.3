Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C939CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 01:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZIA2-0002l4-8H; Mon, 15 Jun 2026 21:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZIA0-0002ks-Bb
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 21:00:12 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZI9w-0002GX-D5
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 21:00:10 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-68acf0a15b3so6070843a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 18:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781571605; cv=none;
 d=google.com; s=arc-20240605;
 b=c07ZLFIdlt2UvrSU9hWjKfQ+bgfLmMvwcEFYki0j0l/9aT2XTU8a+EK/BI2XRjM4Xq
 PqRCwoln5xpQBhMKIbU4fGgdsL6AOofHpJ+AeOHSW65bj07WxJ/rO8KW0tx06ZWns2ni
 8JwDJqgdxQZrbO+JrTcXZukVwwmFCp6QttTtlvHnOdP4JcqfEB2zeQiCLuatzI/ZpeUF
 4MBozrONQExkdipPHblYAgpMboZqL98Z+Nip/LHSdKD164VVLA83Wp8JeDqRYRbLgIaJ
 mKvGk2S7DnIkp6EOvQFgCRcEiG3KDn5IIXe7VyEWDoI9uEgQTuYQyO4tQWQEgIT88Qt1
 Qa0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1E5PN35gchOkVa8iafjrFAkQGCPeP0M/94/inCg3Fbw=;
 fh=QMl3m49tuLtOusuuXCnCOZCsoZiLfsjUwXG2nLBmcSY=;
 b=MTAZjtzWD4iBXVecYrIEdqi4NYrVIbH1eounswVfpJJZd2KAOfqJDJ8xzkZzxBmXf6
 L+LF3RuSAEmD3Ne10Xe7MN+gs42yRBTHdd9lqa5fFpYgCTfdENrjHtpE2Bb70V8d4GKD
 a6lJzI6NWp+FI7WRdno9gh/gIMmZoaJXHX/4UYYEO81Vaxgss7i4FRZgNC+WA4QaiB1/
 9W7VoI0U1nnf0zMuzMfWteiTHGM+UlgnpRIPoBxDbe0NEeEaHyGOP/ZGtWIuXi2emcV0
 aNSVyy/VrDkCpK+D6mKwSkF5K7UBZkXvRiSzc6QJcAnGcp2opCYt5N0kgzGdRSlBHR06
 kDyA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781571605; x=1782176405; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1E5PN35gchOkVa8iafjrFAkQGCPeP0M/94/inCg3Fbw=;
 b=pRIvF3BSuWvmHKLvuBfQJk8VWoJ3bmnG18wBagLhPXh30/Dh13Fk3tx2pZ5toOhYuo
 GpDDHI4lkDdKXKyoiaj3psOQ28Ohqw9dBrEr+vzd26qAYeZTZ2uypl8gTCxfOKs2aOd5
 X2pYEEqVL6CR4sKTX2wfqhMl2FX7Nf6dMdda/MehmxoUcZ2fkTCpVn7zEBOvel87dWdp
 xrbs2VmDMaMAWRKQmTvXa4PuKTzKcsAvIJoZP8zULzrKFr+mKYRCXACU0rNzEUPlejfY
 4De743RgZY5cpqzCxjwvhYxhXaLuZCqY2fhOjIRn6yyM3nyRyeWKspXVwPcWRFV0Tr9n
 64Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781571605; x=1782176405;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1E5PN35gchOkVa8iafjrFAkQGCPeP0M/94/inCg3Fbw=;
 b=GCjPGaUlmmkkV0i8pDTC08i49Jt1Vzdv8L0oFbMg4JswMDaMmfkqIDt39tKDUmOUly
 uODw9UCrpdtI4FQXILNxWDS7LOkuf31KzyX3T+99VFYoBQSNvDdQhvfpo1LB9p1e8QMM
 UxwztS88A8LKja1itDTX3y2PFscoMaM3VPqWMwceinSvFW9//ajHoV/jr0drlSCJ2EO8
 lu6IfwitOBUyyshVw+kEOLZNllTlfxlZVo38n7z8KGJVMYpcdC5i/bBpS+530Kpd4TLs
 9OzO69lsNakJm06x+c8cItO4WiXjgpUEa2uGZi4zgSmiADpRplEG4TpsjP/Cmf9bCayw
 m0dQ==
X-Gm-Message-State: AOJu0Yy+hpUIPWcrvSwirhgRNFWn0lSyPjmbrvOtrVZ2xJld8b4CjQY4
 J8XR1MsckH/92jKzqqwRmey67heuF6jUu4OddTTWc0Ow2DPAdm+/7gRQHnb0S5T6/xsL2qPIrPE
 2YDnVtHva22iz9xHHQcIQ+lUNJEERNTk=
X-Gm-Gg: Acq92OGK45bZhrkBiVDYpmgdAPs6C+S6ne8BBjdt18/OLv8ROu9FiFTtlx6TvthXCsi
 EwS9nCulDthijEFQcMexS0LZTKJkbIevCo7N9SIRumRTtrqvMoQ6jL4MNMxUiu/wcDLc7LyAKZ2
 Meya5SkqCSHN41Krc+En+L3sDQUCQyC59rK0t2SRQAe2dgeuWg/ElHRMc9yb5b95pP2Jc12JEGM
 YjjEc+tiGTs24Y8kEo0anZHCrqa2L7Sq4BfYFvnO9sh3miCrwOENDFgAlBuICLiocfknypgm5WS
 4PPr/zBNn/ZiZNkvQckQb/YHvyaHnK1rrlNKSaCAd3yfXa8e
X-Received: by 2002:a05:6402:3511:b0:68f:cc85:7c1c with SMTP id
 4fb4d7f45d1cf-695087ee3b9mr644464a12.28.1781571604949; Mon, 15 Jun 2026
 18:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-5-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260610214133.1882563-5-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 10:59:38 +1000
X-Gm-Features: AVVi8CezCRiYVm4Km_6WoSfIK0MKlYDvZaU2mVTg0CZWmUsRuGx8Myo6BJepfgA
Message-ID: <CAKmqyKMah2sA8Z9aTKHp1_=7snEnABkrBNmQVhJ0xk=xHFk1ug@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] tests/functional/riscv64: add riscv-server-ref
 tests
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com, uwu@icenowy.me, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Jun 11, 2026 at 7:44=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Add two tests for the recently added riscv-server-ref machine:
>
> - a new test_opensbi.py test.  The idea is to have a quick test that can
> catch trivial regressions that would prevent OpenSBI to finish;
> - a new Linux boot "thorough" test that will boot the machine up to the
> buildroot prompt.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/functional/riscv64/meson.build        |  2 +
>  tests/functional/riscv64/test_opensbi.py    |  4 ++
>  tests/functional/riscv64/test_server_ref.py | 59 +++++++++++++++++++++
>  3 files changed, 65 insertions(+)
>  create mode 100755 tests/functional/riscv64/test_server_ref.py
>
> diff --git a/tests/functional/riscv64/meson.build b/tests/functional/risc=
v64/meson.build
> index 5871211e89..2eb12586bf 100644
> --- a/tests/functional/riscv64/meson.build
> +++ b/tests/functional/riscv64/meson.build
> @@ -2,6 +2,7 @@
>
>  test_riscv64_timeouts =3D {
>    'boston' : 120,
> +  'server_ref' : 120,
>    'tuxrun' : 120,
>  }
>
> @@ -13,6 +14,7 @@ tests_riscv64_system_quick =3D [
>  tests_riscv64_system_thorough =3D [
>    'endianness',
>    'boston',
> +  'server_ref',
>    'sifive_u',
>    'tuxrun',
>  ]
> diff --git a/tests/functional/riscv64/test_opensbi.py b/tests/functional/=
riscv64/test_opensbi.py
> index d077e40f42..057f55f90b 100755
> --- a/tests/functional/riscv64/test_opensbi.py
> +++ b/tests/functional/riscv64/test_opensbi.py
> @@ -32,5 +32,9 @@ def test_riscv_virt(self):
>          self.set_machine('virt')
>          self.boot_opensbi()
>
> +    def test_riscv_server_ref(self):
> +        self.set_machine('riscv-server-ref')
> +        self.boot_opensbi()
> +
>  if __name__ =3D=3D '__main__':
>      QemuSystemTest.main()
> diff --git a/tests/functional/riscv64/test_server_ref.py b/tests/function=
al/riscv64/test_server_ref.py
> new file mode 100755
> index 0000000000..2ecfcf60ad
> --- /dev/null
> +++ b/tests/functional/riscv64/test_server_ref.py
> @@ -0,0 +1,59 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +"""
> +riscv-server-ref board test
> +"""
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +
> +class RiscvServerRefTest(QemuSystemTest):
> +    """
> +    Test the riscv-server-ref board
> +    """
> +
> +    ASSET_KERNEL =3D Asset(
> +        ('https://github.com/danielhb/qemu-machine-boot/raw/refs/heads/'
> +         'master/riscv/images/virt64/buildroot/Image'),
> +        '6bacc876c769c1bb6057d2bf549eba67fbe83916e8223f9fe21c8e8fff665a3=
6')
> +
> +    ASSET_ROOTFS =3D Asset(
> +        ('https://github.com/danielhb/qemu-machine-boot/raw/refs/heads/'
> +         'master/riscv/images/virt64/buildroot/rootfs.ext2'),
> +        'f00bb88749f945d80675540a1338bd1ccb226574685a5b6c65ab44027d0411a=
8')
> +
> +    def test_boot_linux_test(self):
> +        self.set_machine('riscv-server-ref')
> +        kernel_path =3D self.ASSET_KERNEL.fetch()
> +        rootfs_path =3D self.ASSET_ROOTFS.fetch()
> +
> +        self.vm.add_args('-kernel', kernel_path)
> +        self.vm.add_args('-append', 'rw rootwait root=3D/dev/sda')
> +        self.vm.add_args('-drive',
> +            f'file=3D{rootfs_path},format=3Draw,id=3Dhd0,snapshot=3Don,i=
f=3Dnone')
> +        self.vm.add_args('-device', 'ahci,id=3Dahci')
> +        self.vm.add_args('-device', 'ide-hd,drive=3Dhd0,bus=3Dahci.0')
> +
> +        self.vm.set_console()
> +        self.vm.launch()
> +
> +        # Wait for OpenSBI
> +        wait_for_console_pattern(self, 'OpenSBI')
> +
> +        # Wait for Linux kernel boot
> +        wait_for_console_pattern(self, 'Linux version')
> +        wait_for_console_pattern(self, 'Machine model: qemu,riscv-server=
-ref')
> +
> +        # Test e1000e network card functionality
> +        wait_for_console_pattern(self, 'e1000e')
> +        wait_for_console_pattern(self, 'Network Connection')
> +
> +        # Wait for boot to complete - system reaches login prompt
> +        wait_for_console_pattern(self, 'Run /sbin/init as init process')
> +
> +if __name__ =3D=3D '__main__':
> +    QemuSystemTest.main()
> --
> 2.43.0
>
>

