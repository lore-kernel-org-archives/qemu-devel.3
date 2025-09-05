Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C795CA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuQl0-0008UU-Vp; Fri, 05 Sep 2025 03:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuQkx-0008U1-Th
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:21:11 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuQku-0005Ff-5C
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:21:11 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-afebb6d4093so364740066b.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 00:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757056865; x=1757661665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0sl4FUh407HpXKEaMaBaTSzd6a0fletkFs/HN0R0U1Y=;
 b=eb/Sb2mXKzoKCYXX9VL8YgGfd24jS8D46SJ34JIMXr3/KMPBWK/pMkY6jRjkFWDQmr
 Dago9JP/+8L5qOHXuO04Fu1GIr7kbAIkkYlYdx4bbC9v98qw27mieBF05EvKkbXa0h8L
 UT69uchGNFqCuTiOn+7NwQmvjXLa8w6kq2GCG8J6eT3J4abI+c/mAdgxQllIcZB59VRZ
 Lx41uXJmcLJ6b5qFo7VnFuKYs8bvqZttlbnHtfuW4DgFXWxFCiLPDlVGXlelByA8Jrap
 /3BFEH/gjpc1NLZVlr+PD8IkCwuG2/QvaetklNr4XyOXbkaa7yIpeSdC9cIQ4sonKWbu
 +QYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757056865; x=1757661665;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0sl4FUh407HpXKEaMaBaTSzd6a0fletkFs/HN0R0U1Y=;
 b=fwXAtZuAglGKrOcoA0oWWgEoxXgOguk0DPhj5yDftC6nN2v5rOpwF7hU4Ily3LVlJe
 OoEFzbMNdRyfon2TSg2DadJqR3WCLpGVwSGWOCCFgocMZR66H41oajkkpaDZ6dikzSY2
 7uiIdF4ZQc2E5OFhXCOlAEX/egLwLZBeFbRda0gsVgMrllBirssTBu1a9ulISz2WrXw3
 nZ0icCowpgGPgWOdyNFnKRC7HQ0047ryM4SrwMAtypN0OHPsYjcj0WsMpPtoYVgD7ae8
 xjv+1wPAWlgwGF94PADpOMYkiJimzvnPByZZKQmFwDBITagLF0x2Ax0IZcAPH0w9sP8T
 ZIzQ==
X-Gm-Message-State: AOJu0Yzitf7dWZUiKyJLyiKqzffe//U/JJAomDoiP7JJduNENS0+tmsm
 i5ChIBZzixbKeJEeGdcz4Jo3Pa3O4GeuDHXG8eXMUeotll2fIJL9YKhi8clNppTSewI=
X-Gm-Gg: ASbGnctapFVYuY9vPj8vpJSycXCSBar33d4Xaanpdl+2AhIVg08rVviQg8UV1DH3blm
 QPZZltcYTKw3zPdMZvhjcidzrD4pZYLxks5iazwYOiJwOpbsmm9NppdGvVHWebd/WjzuBxneXu8
 G/oc20MT6xs0C4h034/b0K0qO3SK9W85VnlolivWxb8mvabsDi85ptbE1HgJY2eSFcURJuct1qb
 qfn2YpYz9tozqCfbJsgwIXuOYHC5Kjtr2gU2vWoAmwIPtj7x8pqH8U60OBLZWID4Rn004UHha4W
 m1VxfMXLRe3qOipoE9J3ZkMdKKt6Yk6OP9E3Nep6B2PaAHEpjf+g/CGxo21Ews2a1/f+JBvUzjO
 xBNXJ7EvTist3L65rc/bR10s=
X-Google-Smtp-Source: AGHT+IE8HecJVtf9AVwFHj7Zc8GVfHW0EkZEJBpOiHPVvUmqmlG7FpnJmNe7qjSiEJz3mUckvBRgRg==
X-Received: by 2002:a17:906:6a17:b0:b04:7b7f:33cc with SMTP id
 a640c23a62f3a-b047b7f362amr545285766b.62.1757056864589; 
 Fri, 05 Sep 2025 00:21:04 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc4bbc07sm16374784a12.30.2025.09.05.00.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 00:21:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 745F85F879;
 Fri, 05 Sep 2025 08:21:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  thuth@redhat.com,  berrange@redhat.com,
 qemu-arm@nongnu.org,  1844144@gmail.com
Subject: Re: [PATCH v2 5/5] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
In-Reply-To: <20250904154640.52687-6-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 4 Sep 2025 15:46:40 +0000")
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
 <20250904154640.52687-6-gustavo.romero@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 05 Sep 2025 08:21:02 +0100
Message-ID: <87ecslxt41.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> This commit removes Avocado as a dependency for running the
> reverse_debugging test.
>
> The main benefit, beyond eliminating an extra dependency, is that there
> is no longer any need to handle GDB packets manually. This removes the
> need for ad-hoc functions dealing with endianness and arch-specific
> register numbers, making the test easier to read. The timeout variable
> is also removed, since Meson now manages timeouts automatically.
>
> The reverse_debugging test is now executed through a runner, because it
> requires GDB in addition to QMP. The runner is responsible for invoking
> GDB with the appropriate arguments and for passing the test script to
> GDB.
>
> Since the test now runs inside GDB, its output, particularly from
> 'stepi' commands, which cannot be disabled, interleaves with the TAP
> output from unittest. To avoid this conflict, the test no longer uses
> Meson=E2=80=99s 'tap' protocol and instead relies on the simpler 'exitcod=
e'
> protocol.
>
> reverse_debugging is kept "skipped" for aarch64, ppc64, and x86_64, so
> won't run unless QEMU_TEST_FLAKY_TESTS=3D1 is set in the test environment,
> before running 'make check-functional' or 'meson test [...]'.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>

Could we split this between the architectures to make for better
bisectability. Otherwise looks good:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  tests/functional/aarch64/meson.build          |   7 +-
>  .../functional/aarch64/test_reverse_debug.py  |  15 +-
>  tests/functional/ppc64/meson.build            |   7 +-
>  tests/functional/ppc64/test_reverse_debug.py  |  17 +-
>  tests/functional/reverse_debugging.py         | 175 +++++++++---------
>  tests/functional/x86_64/meson.build           |   7 +-
>  tests/functional/x86_64/test_reverse_debug.py |  21 +--
>  7 files changed, 131 insertions(+), 118 deletions(-)
>
> diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarc=
h64/meson.build
> index 04846c6eb1..4f3168dd55 100644
> --- a/tests/functional/aarch64/meson.build
> +++ b/tests/functional/aarch64/meson.build
> @@ -32,7 +32,6 @@ tests_aarch64_system_thorough =3D [
>    'raspi3',
>    'raspi4',
>    'replay',
> -  'reverse_debug',
>    'rme_virt',
>    'rme_sbsaref',
>    'sbsaref',
> @@ -46,3 +45,9 @@ tests_aarch64_system_thorough =3D [
>    'xen',
>    'xlnx_versal',
>  ]
> +
> +if is_variable('gdb_runner')
> +tests_aarch64_system_thorough_with_runner =3D [
> +    ['reverse_debug', gdb_runner, 'exitcode'],
> +]
> +endif
> diff --git a/tests/functional/aarch64/test_reverse_debug.py b/tests/funct=
ional/aarch64/test_reverse_debug.py
> index 8bc91ccfde..8b6f82c227 100755
> --- a/tests/functional/aarch64/test_reverse_debug.py
> +++ b/tests/functional/aarch64/test_reverse_debug.py
> @@ -1,26 +1,25 @@
> -#!/usr/bin/env python3
> -#
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -# Reverse debugging test
> +# Reverse debugging test for aarch64
>  #
>  # Copyright (c) 2020 ISP RAS
> +# Copyright (c) 2025 Linaro Limited
>  #
>  # Author:
>  #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> +#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>=20=20
> -from qemu_test import Asset, skipIfMissingImports, skipFlakyTest
> +# ReverseDebugging must be imported always first because of the check
> +# in it for not running this test without the GDB runner.
>  from reverse_debugging import ReverseDebugging
> +from qemu_test import Asset, skipFlakyTest
>=20=20
>=20=20
> -@skipIfMissingImports('avocado.utils')
>  class ReverseDebugging_AArch64(ReverseDebugging):
>=20=20
> -    REG_PC =3D 32
> -
>      ASSET_KERNEL =3D Asset(
>          ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
>           'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
> @@ -35,4 +34,4 @@ def test_aarch64_virt(self):
>=20=20
>=20=20
>  if __name__ =3D=3D '__main__':
> -    ReverseDebugging.main()
> +    ReverseDebugging_AArch64.main()
> diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/=
meson.build
> index 842fe0fc71..e81f8b0003 100644
> --- a/tests/functional/ppc64/meson.build
> +++ b/tests/functional/ppc64/meson.build
> @@ -20,6 +20,11 @@ tests_ppc64_system_thorough =3D [
>    'powernv',
>    'pseries',
>    'replay',
> -  'reverse_debug',
>    'tuxrun',
>  ]
> +
> +if is_variable('gdb_runner')
> +tests_ppc64_system_thorough_with_runner =3D [
> +    ['reverse_debug', gdb_runner, 'exitcode'],
> +]
> +endif
> diff --git a/tests/functional/ppc64/test_reverse_debug.py b/tests/functio=
nal/ppc64/test_reverse_debug.py
> index 5931adef5a..e70ca85d0a 100755
> --- a/tests/functional/ppc64/test_reverse_debug.py
> +++ b/tests/functional/ppc64/test_reverse_debug.py
> @@ -1,41 +1,38 @@
> -#!/usr/bin/env python3
> -#
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -# Reverse debugging test
> +# Reverse debugging test for ppc64
>  #
>  # Copyright (c) 2020 ISP RAS
> +# Copyright (c) 2025 Linaro Limited
>  #
>  # Author:
>  #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> +#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>=20=20
> -from qemu_test import skipIfMissingImports, skipFlakyTest
> +# ReverseDebugging must be imported always first because of the check
> +# in it for not running this test without the GDB runner.
>  from reverse_debugging import ReverseDebugging
> +from qemu_test import skipFlakyTest
>=20=20
>=20=20
> -@skipIfMissingImports('avocado.utils')
>  class ReverseDebugging_ppc64(ReverseDebugging):
>=20=20
> -    REG_PC =3D 0x40
> -
>      @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
>      def test_ppc64_pseries(self):
>          self.set_machine('pseries')
>          # SLOF branches back to its entry point, which causes this test
>          # to take the 'hit a breakpoint again' path. That's not a proble=
m,
>          # just slightly different than the other machines.
> -        self.endian_is_le =3D False
>          self.reverse_debugging()
>=20=20
>      @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
>      def test_ppc64_powernv(self):
>          self.set_machine('powernv')
> -        self.endian_is_le =3D False
>          self.reverse_debugging()
>=20=20
>=20=20
>  if __name__ =3D=3D '__main__':
> -    ReverseDebugging.main()
> +    ReverseDebugging_ppc64.main()
> diff --git a/tests/functional/reverse_debugging.py b/tests/functional/rev=
erse_debugging.py
> index f9a1d395f1..bb0b176579 100644
> --- a/tests/functional/reverse_debugging.py
> +++ b/tests/functional/reverse_debugging.py
> @@ -1,16 +1,26 @@
> -# Reverse debugging test
> -#
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> +# Reverse debugging test
> +#
>  # Copyright (c) 2020 ISP RAS
> +# Copyright (c) 2025 Linaro Limited
>  #
>  # Author:
>  #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> +#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
> -import os
> +
> +try:
> +    import gdb
> +except ModuleNotFoundError:
> +    from sys import exit
> +    exit("This script must be launched via tests/guest-debug/run-test.py=
!")
>  import logging
> +import os
> +import subprocess
> +
>=20=20
>  from qemu_test import LinuxKernelTest, get_qemu_img
>  from qemu_test.ports import Ports
> @@ -28,13 +38,9 @@ class ReverseDebugging(LinuxKernelTest):
>      that the execution is stopped at the last of them.
>      """
>=20=20
> -    timeout =3D 10
>      STEPS =3D 10
> -    endian_is_le =3D True
>=20=20
>      def run_vm(self, record, shift, args, replay_path, image_path, port):
> -        from avocado.utils import datadrainer
> -
>          logger =3D logging.getLogger('replay')
>          vm =3D self.get_vm(name=3D'record' if record else 'replay')
>          vm.set_console()
> @@ -52,59 +58,48 @@ def run_vm(self, record, shift, args, replay_path, im=
age_path, port):
>          if args:
>              vm.add_args(*args)
>          vm.launch()
> -        console_drainer =3D datadrainer.LineLogger(vm.console_socket.fil=
eno(),
> -                                    logger=3Dself.log.getChild('console'=
),
> -                                    stop_check=3D(lambda : not vm.is_run=
ning()))
> -        console_drainer.start()
> +
>          return vm
>=20=20
>      @staticmethod
> -    def get_reg_le(g, reg):
> -        res =3D g.cmd(b'p%x' % reg)
> -        num =3D 0
> -        for i in range(len(res))[-2::-2]:
> -            num =3D 0x100 * num + int(res[i:i + 2], 16)
> -        return num
> +    def gdb_connect(host, port):
> +        # Set debug on connection to get the qSupport string.
> +        gdb.execute("set debug remote 1")
> +        r =3D gdb.execute(f"target remote {host}:{port}", False, True)
> +        gdb.execute("set debug remote 0")
> +
> +        return r
>=20=20
>      @staticmethod
> -    def get_reg_be(g, reg):
> -        res =3D g.cmd(b'p%x' % reg)
> -        return int(res, 16)
> -
> -    def get_reg(self, g, reg):
> -        # value may be encoded in BE or LE order
> -        if self.endian_is_le:
> -            return self.get_reg_le(g, reg)
> -        else:
> -            return self.get_reg_be(g, reg)
> +    def get_pc():
> +        val =3D gdb.parse_and_eval("$pc")
> +        pc =3D int(val)
>=20=20
> -    def get_pc(self, g):
> -        return self.get_reg(g, self.REG_PC)
> +        return pc
>=20=20
> -    def check_pc(self, g, addr):
> -        pc =3D self.get_pc(g)
> +    def check_pc(self, addr):
> +        logger =3D logging.getLogger('reply')
> +        pc =3D self.get_pc()
>          if pc !=3D addr:
> -            self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))
> +            logger.info('Invalid PC (read %x instead of %x)' % (pc, addr=
))
> +            gdb.execute("exit 1")
>=20=20
>      @staticmethod
> -    def gdb_step(g):
> -        g.cmd(b's', b'T05thread:01;')
> +    def gdb_step():
> +        gdb.execute("stepi")
>=20=20
>      @staticmethod
> -    def gdb_bstep(g):
> -        g.cmd(b'bs', b'T05thread:01;')
> +    def gdb_bstep():
> +        gdb.execute("reverse-stepi")
>=20=20
>      @staticmethod
>      def vm_get_icount(vm):
>          return vm.qmp('query-replay')['return']['icount']
>=20=20
>      def reverse_debugging(self, shift=3D7, args=3DNone):
> -        from avocado.utils import gdb
> -        from avocado.utils import process
> -
>          logger =3D logging.getLogger('replay')
>=20=20
> -        # create qcow2 for snapshots
> +        # Create qcow2 for snapshots
>          logger.info('creating qcow2 image for VM snapshots')
>          image_path =3D os.path.join(self.workdir, 'disk.qcow2')
>          qemu_img =3D get_qemu_img(self)
> @@ -112,11 +107,11 @@ def reverse_debugging(self, shift=3D7, args=3DNone):
>              self.skipTest('Could not find "qemu-img", which is required =
to '
>                            'create the temporary qcow2 image')
>          cmd =3D '%s create -f qcow2 %s 128M' % (qemu_img, image_path)
> -        process.run(cmd)
> +        subprocess.run(cmd, shell=3DTrue)
>=20=20
>          replay_path =3D os.path.join(self.workdir, 'replay.bin')
>=20=20
> -        # record the log
> +        # Record the log.
>          vm =3D self.run_vm(True, shift, args, replay_path, image_path, -=
1)
>          while self.vm_get_icount(vm) <=3D self.STEPS:
>              pass
> @@ -125,72 +120,84 @@ def reverse_debugging(self, shift=3D7, args=3DNone):
>=20=20
>          logger.info("recorded log with %s+ steps" % last_icount)
>=20=20
> -        # replay and run debug commands
> +        # Replay and run debug commands.
>          with Ports() as ports:
>              port =3D ports.find_free_port()
>              vm =3D self.run_vm(False, shift, args, replay_path, image_pa=
th, port)
> -        logger.info('connecting to gdbstub')
> -        g =3D gdb.GDBRemote('127.0.0.1', port, False, False)
> -        g.connect()
> -        r =3D g.cmd(b'qSupported')
> -        if b'qXfer:features:read+' in r:
> -            g.cmd(b'qXfer:features:read:target.xml:0,ffb')
> -        if b'ReverseStep+' not in r:
> +        logger.info('Connecting to gdbstub')
> +        r =3D self.gdb_connect('127.0.0.1', port)
> +        if 'ReverseStep+' not in r:
>              self.fail('Reverse step is not supported by QEMU')
> -        if b'ReverseContinue+' not in r:
> +        if 'ReverseContinue+' not in r:
>              self.fail('Reverse continue is not supported by QEMU')
>=20=20
> -        logger.info('stepping forward')
> +        logger.info('Stepping forward')
>          steps =3D []
> -        # record first instruction addresses
> +        # Record first instruction addresses.
>          for _ in range(self.STEPS):
> -            pc =3D self.get_pc(g)
> -            logger.info('saving position %x' % pc)
> +            pc =3D self.get_pc()
> +            logger.info('Saving position %x' % pc)
>              steps.append(pc)
> -            self.gdb_step(g)
> +            self.gdb_step()
>=20=20
> -        # visit the recorded instruction in reverse order
> -        logger.info('stepping backward')
> +        # Visit the recorded instruction in reverse order.
> +        logger.info('Stepping backward')
>          for addr in steps[::-1]:
> -            self.gdb_bstep(g)
> -            self.check_pc(g, addr)
> -            logger.info('found position %x' % addr)
> +            self.gdb_bstep()
> +            self.check_pc(addr)
> +            logger.info('Found position %x' % addr)
>=20=20
> -        # visit the recorded instruction in forward order
> -        logger.info('stepping forward')
> +        # Visit the recorded instruction in forward order.
> +        logger.info('Stepping forward')
>          for addr in steps:
> -            self.check_pc(g, addr)
> -            self.gdb_step(g)
> -            logger.info('found position %x' % addr)
> +            self.check_pc(addr)
> +            self.gdb_step()
> +            logger.info('Found position %x' % addr)
>=20=20
> -        # set breakpoints for the instructions just stepped over
> -        logger.info('setting breakpoints')
> +        # Set breakpoints for the instructions just stepped over.
> +        logger.info('Setting breakpoints')
>          for addr in steps:
>              # hardware breakpoint at addr with len=3D1
> -            g.cmd(b'Z1,%x,1' % addr, b'OK')
> +            gdb.execute(f"break *{hex(addr)}")
>=20=20
> -        # this may hit a breakpoint if first instructions are executed
> -        # again
> -        logger.info('continuing execution')
> +        # This may hit a breakpoint if first instructions are executed a=
gain.
> +        logger.info('Continuing execution')
>          vm.qmp('replay-break', icount=3Dlast_icount - 1)
> -        # continue - will return after pausing
> +        # continue - will return after pausing.
>          # This could stop at the end and get a T02 return, or by
>          # re-executing one of the breakpoints and get a T05 return.
> -        g.cmd(b'c')
> +        gdb.execute("continue")
>          if self.vm_get_icount(vm) =3D=3D last_icount - 1:
> -            logger.info('reached the end (icount %s)' % (last_icount - 1=
))
> +            logger.info('Reached the end (icount %s)' % (last_icount - 1=
))
>          else:
> -            logger.info('hit a breakpoint again at %x (icount %s)' %
> +            logger.info('Hit a breakpoint again at %x (icount %s)' %
>                          (self.get_pc(g), self.vm_get_icount(vm)))
>=20=20
> -        logger.info('running reverse continue to reach %x' % steps[-1])
> -        # reverse continue - will return after stopping at the breakpoint
> -        g.cmd(b'bc', b'T05thread:01;')
> +        logger.info('Running reverse continue to reach %x' % steps[-1])
> +        # reverse continue - will return after stopping at the breakpoin=
t.
> +        gdb.execute("reverse-continue")
>=20=20
> -        # assume that none of the first instructions is executed again
> -        # breaking the order of the breakpoints
> -        self.check_pc(g, steps[-1])
> -        logger.info('successfully reached %x' % steps[-1])
> +        # Assume that none of the first instructions is executed again
> +        # breaking the order of the breakpoints.
> +        # steps[-1] is the first saved $pc in reverse order.
> +        self.check_pc(steps[-1])
> +        logger.info('Successfully reached %x' % steps[-1])
>=20=20
> -        logger.info('exiting gdb and qemu')
> +        logger.info('Exiting GDB and QEMU...')
> +        # Disconnect from the VM.
> +        gdb.execute("disconnect")
> +        # Guarantee VM is shutdown.
>          vm.shutdown()
> +        # Gently exit from GDB.
> +        gdb.execute("exit 0")
> +
> +    def main():
> +        try:
> +            LinuxKernelTest.main()
> +        except SystemExit:
> +            # If the test is marked with @skipFlakyTest, then it will be=
 exited
> +            # via sys.exit() before we have the chance to exit from GDB =
gently.
> +            # Because recent versions of GDB will return a failure value=
 if this
> +            # happens, we catch the SystemExit and exit from GDB gently =
with 77,
> +            # which meson interprets correctly as a skipped test.
> +            gdb.execute("exit 77")
> diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_6=
4/meson.build
> index d0b4667bb8..b5e0c9a0d7 100644
> --- a/tests/functional/x86_64/meson.build
> +++ b/tests/functional/x86_64/meson.build
> @@ -29,8 +29,13 @@ tests_x86_64_system_thorough =3D [
>    'multiprocess',
>    'netdev_ethtool',
>    'replay',
> -  'reverse_debug',
>    'tuxrun',
>    'virtio_balloon',
>    'virtio_gpu',
>  ]
> +
> +if is_variable('gdb_runner')
> +    tests_x86_64_system_thorough_with_runner =3D [
> +        ['reverse_debug', gdb_runner, 'exitcode'],
> +    ]
> +endif
> diff --git a/tests/functional/x86_64/test_reverse_debug.py b/tests/functi=
onal/x86_64/test_reverse_debug.py
> index d713e91e14..465f7e0abb 100755
> --- a/tests/functional/x86_64/test_reverse_debug.py
> +++ b/tests/functional/x86_64/test_reverse_debug.py
> @@ -1,36 +1,31 @@
> -#!/usr/bin/env python3
> -#
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -# Reverse debugging test
> +# Reverse debugging test for x86_64
>  #
>  # Copyright (c) 2020 ISP RAS
> +# Copyright (c) 2025 Linaro Limited
>  #
>  # Author:
>  #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> +#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>=20=20
> -from qemu_test import skipIfMissingImports, skipFlakyTest
> +# ReverseDebugging must be imported always first because of the check
> +# in it for not running this test without the GDB runner.
>  from reverse_debugging import ReverseDebugging
> +from qemu_test import skipFlakyTest
>=20=20
>=20=20
> -@skipIfMissingImports('avocado.utils')
>  class ReverseDebugging_X86_64(ReverseDebugging):
>=20=20
> -    REG_PC =3D 0x10
> -    REG_CS =3D 0x12
> -    def get_pc(self, g):
> -        return self.get_reg_le(g, self.REG_PC) \
> -            + self.get_reg_le(g, self.REG_CS) * 0x10
> -
>      @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2922")
>      def test_x86_64_pc(self):
>          self.set_machine('pc')
> -        # start with BIOS only
> +        # Start with BIOS only
>          self.reverse_debugging()
>=20=20
>=20=20
>  if __name__ =3D=3D '__main__':
> -    ReverseDebugging.main()
> +    ReverseDebugging_X86_64.main()

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

