Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D063CD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ5kK-0004Lm-8m; Mon, 15 Jun 2026 07:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZ5kH-0004LV-1c
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:44:49 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZ5kE-0005Px-Td
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:44:48 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bebac79fff8so394385466b.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 04:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781523885; cv=none;
 d=google.com; s=arc-20240605;
 b=kp2dXdeAR5suo6rxIIfoUFsdLKfH5ThEfbIVfgxmHN8SDOkZhXbY6Jt1tV7z0kwkC4
 oIK0ReWyGk6+Vtyi0c26EL3bPBmVMPMBvCudqOyYtZr9952in3p74aXL4oqgFldQFPwE
 UCYccYgzwO8dKg0pWCYJdZeNtFijQmC6hm6bUHOE8JkhUn27zYXIpFeJUo0laaQgkA+a
 X3Zj3yNKLJauYVH2IVh2ghIGetdVS+x3g3leiZuDG/zIc1f+OSBsGQElDHvxJttkNVBS
 gHHx7BmTRo6FOtw0VFhDJCA8SeAlfVj5FEmCtKrQLzZ4oPb8yo+A8SiUfmmhG3A6ZBWQ
 bR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+T+44FihAnSRM9I9TPNNZpwPuQOAxcZISWQWYChdOlM=;
 fh=UxcirIdfO8UamGJ2cf8nbjTCliwId+xJScvylhv0zRw=;
 b=MOw0qoWxLKC8Mx7sjAtq7LpxWK5lUJkU+KzY5phbzZQwbaAo8J3EFInCc8kmxcmGZ9
 gX/7bK211XtsXlAwXEiLBkVUtfFrTiPpBtBbEsrN/bRuZYVnEyfRPneRF06bykRA+E02
 dW0TA6JnqYnEgu59uWu6nwhuOVznA0HJYuHfMaBzqF24fiDDEg9sPNuR0MiIFK+GPy9X
 gkFVULyp2vnyjkJfIWuY0sg6QLqna62VqDnynlsTTKsaa5uAiYGDgNVaPfXF9kA3uNj5
 VtGJBMqXsX81ykR3RfPmoNasRwH5QwRMZ9RNSRfZ13MWSzzi/m6HgACv0oMti4uqYIKt
 40Gg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781523885; x=1782128685; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+T+44FihAnSRM9I9TPNNZpwPuQOAxcZISWQWYChdOlM=;
 b=PO6A1QqjVVEEFlbrTDExN7J0C3PyDuOXkFfUbKmLnz3YcqxPITnXp1wJMShvRETR2Q
 SNWS7wu+TzrX5mU0Pa3W6KUga/XoH5h8EohNAQw8EEai7dcfSMze9cn/jyoAewmas3WB
 ANPJ77XrMq3wyYMh1xnBye/U8xzAJxrMp/Z/nmKfI02QT41cLQYNmLakBxP1mHJrDRL+
 gRdp7rJniGynTZgOt4b+sG0+VHp/rYWzZAF71m/XsgUORtvAZ1IxR4riJ3ajOefXRwD1
 APpi3FqSX/wFL1ICwGefYvA13tpYCVn7+fXBkjoTRu8IC/NBmM6DBGjLy22PH6JnLsts
 /4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781523885; x=1782128685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+T+44FihAnSRM9I9TPNNZpwPuQOAxcZISWQWYChdOlM=;
 b=hVBP9JI/v1qCazw12bC9e6c+cnRTRnao40vOb2KVNgXuM7wcWnGf7SySPX+78Pe3F8
 vz7WbDYDBz5NX6iZpI5UZ4giOTDuYqMHNiEwoE2pRJizE84NsXoQ6RsFONL8cMzrvdGR
 izPDhyCYO5xj1323OL0iRwd0YbkK0NqTqBpYg6x/PntWcR/SIMmBlg8ZCmmivnLWEmES
 r9Llsx9IJEwAZMIpkxfNY6CKugnYOKp5c34KlUVoj9063zxdRHmqT4LE5Y4jeiwaejEv
 mpMp5/RB3kIdxNy2lrMstL/mD87Uyj+3LAf6XSWBlyC5RzYbtp9JLN0xKcBhaNJ1++OU
 i4wg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0aj8EEDm2Bj6Ymd3wwkyTi8SRLHgdONu3OiKyfe9CLBhIa4phfmR7R4UDkDN8qcI3yxsvMwu/gM/p@nongnu.org
X-Gm-Message-State: AOJu0YxChcGmHM9cXmbvC7tJgSaJyUns5AcL/Xss1bcjR7AsIpCTCJub
 1zG7CiD9/Vf0JADy0jdeEI/u3EdZ8vwLmbsREj5fhWC4gQr5Toa98rXfJUCWwIwMXHfSe7l74p2
 GcjI3Kqz6Y/10FTGc6+Khk5A+M4ZAwcE=
X-Gm-Gg: Acq92OEMGAVZAowpgMrxztd1NX9ktVHmabxN/vbdYEyv90OYy4n6zr1VGHjcnqArWLY
 NzLED0MsLs4ePA2b5WkxncbSToBHG2BlK+k58cvFpp0K7qLWn5mTHOqGZIWmet10AgnOLjdYbfz
 iTXUmvYdusC5ig1n2IHhrSJuirtpPtqhPidzWSvol5b4QlgQuuVwk8SGZXvRyJzNh+0btLSFoT3
 vzz7PazWBp1TTuuNixe/BeZWiQD57Ey0/mAATVS76Y4Y9UUuUd4IsMZrfH8YcyX87p6Pd7U+qhV
 VoSZ1Iom
X-Received: by 2002:a17:907:3f87:b0:bd5:151d:2d31 with SMTP id
 a640c23a62f3a-bfe28907f3emr639160266b.13.1781523884457; Mon, 15 Jun 2026
 04:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260603065859.592063-1-joel@jms.id.au>
 <20260603065859.592063-10-joel@jms.id.au>
In-Reply-To: <20260603065859.592063-10-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2026 21:44:17 +1000
X-Gm-Features: AVVi8Cd69KX0w5BynUEE-YMynpUya7K1kGM-tpm8xfg4FYoXGgRb2SfOvMep3qE
Message-ID: <CAKmqyKNcs3pupVFnveJM-exqGhFGAVo-jsTGW3Gr5UffHrP-4Q@mail.gmail.com>
Subject: Re: [PATCH v8 09/12] tests/functional/riscv64: Add tt-atlantis tests
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62c.google.com
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

On Wed, Jun 3, 2026 at 5:02=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote:
>
> From: Nicholas Piggin <npiggin@gmail.com>
>
> Add OpenSBI and Linux boot tests for the tt-atlantis machine. Based on
> tests/functional/riscv64/test_sifive_u.py.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS                                  |  1 +
>  tests/functional/riscv64/meson.build         |  1 +
>  tests/functional/riscv64/test_opensbi.py     |  4 ++
>  tests/functional/riscv64/test_tt_atlantis.py | 57 ++++++++++++++++++++
>  4 files changed, 63 insertions(+)
>  create mode 100755 tests/functional/riscv64/test_tt_atlantis.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e52aa769c9ae..f4b7e7fd43a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1793,6 +1793,7 @@ S: Supported
>  F: docs/system/riscv/tt_*.rst
>  F: hw/riscv/tt_*.c
>  F: include/hw/riscv/tt_*.h
> +F: tests/functional/riscv64/test_tt_*.py
>
>  AMD Microblaze-V Generic Board
>  M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> diff --git a/tests/functional/riscv64/meson.build b/tests/functional/risc=
v64/meson.build
> index b996c89d7df9..c4456fabd757 100644
> --- a/tests/functional/riscv64/meson.build
> +++ b/tests/functional/riscv64/meson.build
> @@ -13,5 +13,6 @@ tests_riscv64_system_quick =3D [
>  tests_riscv64_system_thorough =3D [
>    'boston',
>    'sifive_u',
> +  'tt_atlantis',
>    'tuxrun',
>  ]
> diff --git a/tests/functional/riscv64/test_opensbi.py b/tests/functional/=
riscv64/test_opensbi.py
> index d077e40f4278..0f8beb7e7a8c 100755
> --- a/tests/functional/riscv64/test_opensbi.py
> +++ b/tests/functional/riscv64/test_opensbi.py
> @@ -28,6 +28,10 @@ def test_riscv_sifive_u(self):
>          self.set_machine('sifive_u')
>          self.boot_opensbi()
>
> +    def test_riscv_tt_atlantis(self):
> +        self.set_machine('tt-atlantis')
> +        self.boot_opensbi()
> +
>      def test_riscv_virt(self):
>          self.set_machine('virt')
>          self.boot_opensbi()
> diff --git a/tests/functional/riscv64/test_tt_atlantis.py b/tests/functio=
nal/riscv64/test_tt_atlantis.py
> new file mode 100755
> index 000000000000..48abd5cd27c2
> --- /dev/null
> +++ b/tests/functional/riscv64/test_tt_atlantis.py
> @@ -0,0 +1,57 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots a Linux kernel on a Tenstorrent Atlantis ma=
chine
> +# and checks the console
> +#
> +# Copyright (c) Linaro Ltd.
> +# Copyright 2026 Tenstorrent
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import Asset, LinuxKernelTest
> +
> +
> +class TTAtlantis(LinuxKernelTest):
> +
> +    ASSET_KERNEL =3D Asset(
> +        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
> +        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb=
0')
> +    ASSET_ROOTFS =3D Asset(
> +        ('https://github.com/groeck/linux-build-test/raw/'
> +         '9819da19e6eef291686fdd7b029ea00e764dc62f/rootfs/riscv64/'
> +         'rootfs.ext2.gz'),
> +        'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28=
b')
> +
> +    def do_test_riscv64_tt_atlantis(self, connect_disk):
> +        self.set_machine('tt-atlantis')
> +        kernel_path =3D self.ASSET_KERNEL.fetch()
> +        rootfs_path =3D self.uncompress(self.ASSET_ROOTFS)
> +
> +        self.vm.set_console()
> +        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'early=
con=3Dsbi '
> +
> +        if connect_disk:
> +            kernel_command_line +=3D 'root=3D/dev/vda panic=3D-1 noreboo=
t rootwait '
> +            self.vm.add_args('-device',
> +                             'virtio-blk,drive=3Ddrive0,serial=3D0x1234,=
bus=3Dpcie.0')
> +            self.vm.add_args('-drive',
> +                             f'file=3D{rootfs_path},if=3Dnone,id=3Ddrive=
0,format=3Draw')
> +            pattern =3D 'Boot successful.'
> +        else:
> +            kernel_command_line +=3D 'panic=3D0 noreboot '
> +            pattern =3D 'Cannot open root device'
> +
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +
> +        self.vm.launch()
> +        self.wait_for_console_pattern(pattern)
> +
> +    def test_riscv64_tt_atlantis(self):
> +        # tt-atlantis machine has no PCI host yet, so no disk
> +        self.do_test_riscv64_tt_atlantis(False)
> +
> +
> +if __name__ =3D=3D '__main__':
> +    LinuxKernelTest.main()
> --
> 2.47.3
>
>

