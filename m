Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796DACAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyBrO-0004jd-Ui; Mon, 15 Sep 2025 12:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyBrN-0004f6-I3
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:15:21 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyBrE-0003mq-3b
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:15:20 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3e46fac8421so3628055f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757952900; x=1758557700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tPATanRi59ugkGNdltMfXEtggHA8w4O5+78fUt07hwM=;
 b=ajB6jIaeDB3lawKKrOVZ/r4ER9PS7x0hDb9wMdvvEpf/Jffhh/GX1onFJ/TmE7gWyH
 jzNfRnbPeqivJVvp9XNjW71CQqZ6Xx+msTPPxt5ck9B+oz4AU/LvNoD70JykXpM+/pLw
 LHR7XeCWd4cKU05ntK+9bwA4ekddXf9ijyOu9yWgEh1/AEdS6bdfh5YiYX+DTx77jkYl
 if0ayC8ioR3bWiXXRMuD9+8nC/E5QheEFCf3qxAYfOTcC/rvzOsGlX3TOOi9yGSc0oJp
 /4KEdqZA20RDJn+OopvK8FvAzy64enDvlXyWG58oW2K4XKJ1oicI+Ij8nag5lpS3Fnld
 GUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757952900; x=1758557700;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tPATanRi59ugkGNdltMfXEtggHA8w4O5+78fUt07hwM=;
 b=EstQvz68UsHYuEDtF35G/sJaB09Gq0oLBWxoWbKr7N3AXx4hwmvpgCC7unovwB0L9Y
 Xcf1tP2D0rHI6LQ8HfDusyhShQjbRQmWoHnWlLI4z0f5LJHEn8dBA55pFeozPQQoFkR0
 VccXmQOYd+Mu1FO5lIXlEatjrCYZTFhnaj2EhxXO1T9Wizhl+u+Ykd6oAo27VloZsK1k
 nc7rbbpqQYrUK+N8gv0/OTTbDqKYkKBpeqXVE2kWHXckLCKdu2zjYKfVWCGqxjvPgwLO
 7AftwbhZP7nJezbQ2G0Ll5y+RRLeUyI/TG3E6C0Fj0+GNEI4HPfi3FphNInxlPrtJcRx
 X9Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9+2k5gyGlG8axsEPPeR3pHgGanYPeBGcjru5r3quf+9EVZyptEbGqSifa3+XC/XJQjyRh3sdLquNu@nongnu.org
X-Gm-Message-State: AOJu0YyhJv2PTap1vMASJ3nB9hgXYcjO05OmqE7YhkOukzDCSwqA4g0Z
 CV5j02GnO0Ew315xepCR3twX2xSMHqJh66sBjLqsmMkUpjILSOwBvjjKTqOxHgwAEun65MaGo0w
 /wf8zgkc=
X-Gm-Gg: ASbGnctgNwcpizc/IUSYBDsXzp84z8GBt1aL+Vbt/AxonmNhBQ/lDI7L9aTmpK14JZx
 3+XUStaG9BEW8Lx/tAdrGueicT/Z3wV7Jbb3/ZJYCLFdJGAwMlsSngKCT5vCe34qfgOy2ivdO5M
 UQW4M0UNdgbMZnHsiI0Md36/mBfABPA63etP93JcKdM3CO3eJfa+X1HiQixkHGbt9NnuvyjJrSa
 3ICt4OBN/z+e5gnh+gCMG5WpS+TfcYjRUT1BhVYXp1DTQnkpwf72WlwvXzghqbvO/S7pd1h/ja1
 l+cTqDTQ2yL8C21RlMjRuN95NKtez860O2F3A6FPckqaCZCBvleljkIIN43oWmMHYiqGf6ZBpPJ
 KprlhLo+uNBL7uSTpH7saRWc=
X-Google-Smtp-Source: AGHT+IFWtTpeSYc/UE2AgUsuPYcCCp2RtqqQTJoK2zGig4YpI8lK6xhsBSIa3w22c+6Fd8V2e7z5Lw==
X-Received: by 2002:a05:6000:2281:b0:3e7:1f63:6e7d with SMTP id
 ffacd0b85a97d-3e7659ee4e1mr14787758f8f.45.1757952899451; 
 Mon, 15 Sep 2025 09:14:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f290d1512sm98091995e9.16.2025.09.15.09.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 09:14:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5EDA65F867;
 Mon, 15 Sep 2025 17:14:56 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [RFC PATCH 2/2] tests/functional: Adapt reverse_debugging to
 run w/o Avocado
In-Reply-To: <20250915124207.42053-3-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 15 Sep 2025 14:42:07 +0200")
References: <20250915124207.42053-1-thuth@redhat.com>
 <20250915124207.42053-3-thuth@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 17:14:56 +0100
Message-ID: <87zfavofpb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> From: Gustavo Romero <gustavo.romero@linaro.org>
>
> This commit removes Avocado as a dependency for running the
> reverse_debugging test.
>
> The main benefit, beyond eliminating an extra dependency, is that there
> is no longer any need to handle GDB packets manually. This removes the
> need for ad-hoc functions dealing with endianness and arch-specific
> register numbers, making the test easier to read. The timeout variable
> is also removed, since Meson now manages timeouts automatically.
>
> The reverse_debugging test is now executed through running GDB via a
> python script. The test itself is only responsible for invoking
> GDB with the appropriate arguments and for passing the test script to
> GDB.
>
> reverse_debugging is kept "skipped" for aarch64, ppc64, and x86_64, so
> won't run unless QEMU_TEST_FLAKY_TESTS=3D1 is set in the test environment,
> before running 'make check-functional' or 'meson test [...]'.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> [thuth: Rework the test to run without tests/guest-debug/run-test.py]
> Signed-off-by: Thomas Huth <thuth@redhat.com>

I certainly prefer this approach to importing the python modules. Caveat
to proper splitting but you can at least have:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  .../functional/aarch64/test_reverse_debug.py  |  16 +-
>  tests/functional/ppc64/test_reverse_debug.py  |  18 +-
>  tests/functional/reverse_debugging.py         | 235 +++++++++++-------
>  tests/functional/x86_64/test_reverse_debug.py |  20 +-
>  4 files changed, 171 insertions(+), 118 deletions(-)
>
> diff --git a/tests/functional/aarch64/test_reverse_debug.py b/tests/funct=
ional/aarch64/test_reverse_debug.py
> index 85e35645db0..a84ddd07acb 100755
> --- a/tests/functional/aarch64/test_reverse_debug.py
> +++ b/tests/functional/aarch64/test_reverse_debug.py
> @@ -2,7 +2,7 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -# Reverse debugging test
> +# Reverse debugging test for aarch64
>  #
>  # Copyright (c) 2020 ISP RAS
>  #
> @@ -12,14 +12,13 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>=20=20
> -from qemu_test import Asset, skipIfMissingImports, skipFlakyTest
> -from reverse_debugging import ReverseDebugging
> +from qemu_test import QemuSystemTest
> +from qemu_test import Asset, skipFlakyTest
>=20=20
> +from reverse_debugging import reverse_debug
>=20=20
> -@skipIfMissingImports('avocado.utils')
> -class ReverseDebugging_AArch64(ReverseDebugging):
>=20=20
> -    REG_PC =3D 32
> +class ReverseDebugging_AArch64(QemuSystemTest):
>=20=20
>      ASSET_KERNEL =3D Asset(
>          ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
> @@ -29,9 +28,8 @@ class ReverseDebugging_AArch64(ReverseDebugging):
>      def test_aarch64_virt(self):
>          self.set_machine('virt')
>          self.cpu =3D 'cortex-a53'
> -        kernel_path =3D self.ASSET_KERNEL.fetch()
> -        self.reverse_debugging(args=3D('-kernel', kernel_path))
> +        reverse_debug(self, self.ASSET_KERNEL)
>=20=20
>=20=20
>  if __name__ =3D=3D '__main__':
> -    ReverseDebugging.main()
> +    QemuSystemTest.main()
> diff --git a/tests/functional/ppc64/test_reverse_debug.py b/tests/functio=
nal/ppc64/test_reverse_debug.py
> index 5931adef5a9..7da5ede06c8 100755
> --- a/tests/functional/ppc64/test_reverse_debug.py
> +++ b/tests/functional/ppc64/test_reverse_debug.py
> @@ -2,7 +2,7 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -# Reverse debugging test
> +# Reverse debugging test for ppc64
>  #
>  # Copyright (c) 2020 ISP RAS
>  #
> @@ -12,14 +12,12 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>=20=20
> -from qemu_test import skipIfMissingImports, skipFlakyTest
> -from reverse_debugging import ReverseDebugging
> +from qemu_test import QemuSystemTest, skipFlakyTest
>=20=20
> +from reverse_debugging import reverse_debug
>=20=20
> -@skipIfMissingImports('avocado.utils')
> -class ReverseDebugging_ppc64(ReverseDebugging):
>=20=20
> -    REG_PC =3D 0x40
> +class ReverseDebugging_ppc64(QemuSystemTest):
>=20=20
>      @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
>      def test_ppc64_pseries(self):
> @@ -27,15 +25,13 @@ def test_ppc64_pseries(self):
>          # SLOF branches back to its entry point, which causes this test
>          # to take the 'hit a breakpoint again' path. That's not a proble=
m,
>          # just slightly different than the other machines.
> -        self.endian_is_le =3D False
> -        self.reverse_debugging()
> +        reverse_debug(self)
>=20=20
>      @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
>      def test_ppc64_powernv(self):
>          self.set_machine('powernv')
> -        self.endian_is_le =3D False
> -        self.reverse_debugging()
> +        reverse_debug(self)
>=20=20
>=20=20
>  if __name__ =3D=3D '__main__':
> -    ReverseDebugging.main()
> +    QemuSystemTest.main()
> diff --git a/tests/functional/reverse_debugging.py b/tests/functional/rev=
erse_debugging.py
> index f9a1d395f1d..c889247defa 100644
> --- a/tests/functional/reverse_debugging.py
> +++ b/tests/functional/reverse_debugging.py
> @@ -1,21 +1,72 @@
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
>  import logging
> +import os
> +import subprocess
> +import sys
> +
> +try:
> +    import gdb
> +    _has_gdb =3D True
> +except ModuleNotFoundError:
> +    _has_gdb =3D False
>=20=20
>  from qemu_test import LinuxKernelTest, get_qemu_img
>  from qemu_test.ports import Ports
>=20=20
>=20=20
> +def reverse_debug(test, asset_kernel=3DNone, shift=3D7, args=3DNone):
> +
> +    # Now launch gdb with our test and collect the result.
> +    gdb_cmd =3D os.getenv('QEMU_TEST_GDB')
> +    assert(gdb_cmd)
> +
> +    # Run quietly and ignore .gdbinit.
> +    gdb_cmd +=3D " -q -n -batch"
> +    # Disable pagination.
> +    gdb_cmd +=3D " -ex 'set pagination off'"
> +    # Disable prompts in case of crash.
> +    gdb_cmd +=3D " -ex 'set confirm off'"
> +    # Finally the test script itself.
> +    argv =3D [__file__]
> +    gdb_cmd +=3D f" -ex \"py sys.argv=3D{argv}\""
> +    gdb_cmd +=3D " -x %s" % __file__
> +
> +    test.log.info("GDB CMD: %s" % gdb_cmd)
> +
> +    gdb_env =3D dict(os.environ)
> +    gdb_pythonpath =3D gdb_env.get("PYTHONPATH", "").split(os.pathsep)
> +    gdb_pythonpath.append(os.path.dirname(os.path.realpath(__file__)))
> +    gdb_env["PYTHONPATH"] =3D os.pathsep.join(gdb_pythonpath)
> +    gdb_env["QEMU_TEST_MACHINE"] =3D test.machine
> +    if test.cpu:
> +        gdb_env["QEMU_TEST_CPU"] =3D test.cpu
> +    if asset_kernel:
> +        gdb_env["QEMU_TEST_KERNEL"] =3D asset_kernel.fetch()
> +    result =3D subprocess.run(gdb_cmd, shell=3DTrue, check=3DFalse,
> +                            stdout=3Dsubprocess.PIPE,
> +                            stderr=3Dsubprocess.STDOUT,
> +                            encoding=3D'utf8',
> +                            env=3Dgdb_env)
> +    test.log.info("gdb output:\n %s" % result.stdout)
> +    if result.returncode !=3D 0:
> +        test.fail(f"gdb failed with return code {result.returncode}")
> +    else:
> +        test.log.info("gdb run succeeded!")
> +
> +
>  class ReverseDebugging(LinuxKernelTest):
>      """
>      Test GDB reverse debugging commands: reverse step and reverse contin=
ue.
> @@ -28,13 +79,9 @@ class ReverseDebugging(LinuxKernelTest):
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
> @@ -52,59 +99,58 @@ def run_vm(self, record, shift, args, replay_path, im=
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
> -    def reverse_debugging(self, shift=3D7, args=3DNone):
> -        from avocado.utils import gdb
> -        from avocado.utils import process
> +    def test_reverse_debugging(self):
> +
> +        shift =3D 7
> +
> +        self.set_machine(os.getenv('QEMU_TEST_MACHINE'))
> +        self.cpu =3D os.getenv('QEMU_TEST_CPU')
> +        kernel_path =3D os.getenv('QEMU_TEST_KERNEL')
> +        args =3D None
> +        if kernel_path:
> +            args =3D ['-kernel', kernel_path]
>=20=20
>          logger =3D logging.getLogger('replay')
>=20=20
> -        # create qcow2 for snapshots
> +        # Create qcow2 for snapshots
>          logger.info('creating qcow2 image for VM snapshots')
>          image_path =3D os.path.join(self.workdir, 'disk.qcow2')
>          qemu_img =3D get_qemu_img(self)
> @@ -112,11 +158,11 @@ def reverse_debugging(self, shift=3D7, args=3DNone):
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
> @@ -125,72 +171,91 @@ def reverse_debugging(self, shift=3D7, args=3DNone):
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
> -                        (self.get_pc(g), self.vm_get_icount(vm)))
> +            logger.info('Hit a breakpoint again at %x (icount %s)' %
> +                        (self.get_pc(), self.vm_get_icount(vm)))
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
> +        gdb.execute('print "test succeeded"')
> +        gdb.execute("exit 0")
> +
> +    @staticmethod
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
> +
> +if __name__ =3D=3D '__main__':
> +    if not _has_gdb:
> +        sys.exit("This script must be launched via tests/guest-debug/run=
-test.py!")
> +    ReverseDebugging.main()
> diff --git a/tests/functional/x86_64/test_reverse_debug.py b/tests/functi=
onal/x86_64/test_reverse_debug.py
> index d713e91e144..e823f0d4953 100755
> --- a/tests/functional/x86_64/test_reverse_debug.py
> +++ b/tests/functional/x86_64/test_reverse_debug.py
> @@ -2,7 +2,7 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -# Reverse debugging test
> +# Reverse debugging test for x86_64
>  #
>  # Copyright (c) 2020 ISP RAS
>  #
> @@ -12,25 +12,19 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>=20=20
> -from qemu_test import skipIfMissingImports, skipFlakyTest
> -from reverse_debugging import ReverseDebugging
> +from qemu_test import QemuSystemTest, skipFlakyTest
>=20=20
> +from reverse_debugging import reverse_debug
>=20=20
> -@skipIfMissingImports('avocado.utils')
> -class ReverseDebugging_X86_64(ReverseDebugging):
>=20=20
> -    REG_PC =3D 0x10
> -    REG_CS =3D 0x12
> -    def get_pc(self, g):
> -        return self.get_reg_le(g, self.REG_PC) \
> -            + self.get_reg_le(g, self.REG_CS) * 0x10
> +class ReverseDebugging_X86_64(QemuSystemTest):
>=20=20
>      @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2922")
>      def test_x86_64_pc(self):
>          self.set_machine('pc')
> -        # start with BIOS only
> -        self.reverse_debugging()
> +        # Start with BIOS only
> +        reverse_debug(self)
>=20=20
>=20=20
>  if __name__ =3D=3D '__main__':
> -    ReverseDebugging.main()
> +    QemuSystemTest.main()

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

