Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1BBCAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0csi-0002Mi-J7; Mon, 22 Sep 2025 05:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0csV-0001yQ-TM
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:30:43 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0csM-0007jW-8K
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:30:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-468973c184bso14248225e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758533422; x=1759138222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qxr1DxP9nP+5d8JszYWZLOI5YpRCrGwfk0E1CxfzzcM=;
 b=KLoFaWhr9pw7wOut13JSKohi3AubhKwQIBy3KEPMs/yYc9Yx+3VtM5LI5Gf5H8jP5I
 deNhQdd9X6Xfn+Yh8AwWFRcZ3EXC0Y6Bs2/hbvaQEwr6K6xkX411y5j/2HsNAm7tlP3C
 aBJCEk9c0BgTzc31DF2TTl/+grgMnH6w073fHJnvYuXvII9fnNtcWxS0VPz5HsTRpslb
 GI/5gUbOtSHw3VF4iazvzYkdvJDY/7G85LkR6QGSgPTLSVQbnwdFnfSH+N3ygZfVZxjj
 StgH77C7EfhWd6sJV5vhqgZCa4EeZVTegqCzEB0Jhu4sLuiRRObxLblNjAvD7X7McMTH
 jt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758533422; x=1759138222;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qxr1DxP9nP+5d8JszYWZLOI5YpRCrGwfk0E1CxfzzcM=;
 b=pUHeaciJQS6nKpgauutxiL8pUrKcGeQOap4d3X85rX6u9zCUQy+H1TG26w+EK5PX1U
 HFjHPuT0l1dEksyBGBqYYX63Vyf970cdTcGUcSGFVllziwNmUSJeVtLXm/Lnaptpxft1
 Lnl+BFUbG1m2hcpfqKjec4pAYjgVLWuGk3XnDcCAUSG5k8Z9S1ZsNeXHu0UBLwRQrQFH
 QFo+IrrIj5c1qKj++Fyik2nj29z0pEPKU46/ifwhJ6BULjE96VTb6qg93TXPDWnIg+Jt
 /1JGFlzyQ2SoLHOxs/wHAhsmDL7d7PP03Ase6AR1aTmAxiBmUcTOCLdfS6trsKZ8tuFu
 bKCg==
X-Gm-Message-State: AOJu0YxcPH8g6Cp+UV13B2QR/fBKxdLdx2teU/U2Fz1BmNHQ32P8eRs6
 Cbnim8VsFmNb/UNJ/GUswEL9kkaCHyPDtVz7qw7HVh7i/conj6iLKg5Bjb8epE1ZHZM=
X-Gm-Gg: ASbGncvgX9JWKb3EvXrOFk4wWljLAFdZTlzLFfTYHVdtvIzThQ1GrvE5hb9yYOiNTOA
 6Odj8mHdn6EoO4K2YgYjukmschrOLwD9vPBBcrJRYiT9+9aN70wfV+IhnMHrF14sbrOqUmr6zgC
 eX9TL5I22aQhUCNBR0OHrbh8UuoeMYT5GymlKmrfbTE6AitkmGt92riblAKyjIdfyDJElTgHrid
 /HJthbZuD5VVULweG7VYPqPi9L6i/IO1VhHXIHCUwn8VtPwSfYctk9yUWPo8G2JjR17xFAYPshJ
 S/M35zkHjIh1BcWoG5/VOlQKr2e6aNjm7IxeHaStfUYQ8oMR1YpYgaBcrA2+Hf6Kv1yiir+VfhL
 ux4df5nhpyzyVpaL61JukALw=
X-Google-Smtp-Source: AGHT+IH3uGAXaYRsgv3CXqNZJ+wobWDXFUs6Q+/kTofu8Yn0dPugN9soGoGtk+t9y7LsjlbXtsk4lg==
X-Received: by 2002:a05:600c:468a:b0:45d:e326:96e7 with SMTP id
 5b1f17b1804b1-467eaa86e42mr107544115e9.29.1758533421769; 
 Mon, 22 Sep 2025 02:30:21 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46d51e5d863sm31702325e9.24.2025.09.22.02.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:30:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F2A135F7B1;
 Mon, 22 Sep 2025 10:30:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  thuth@redhat.com,  berrange@redhat.com,
 qemu-arm@nongnu.org,  manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH v3 3/4] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
In-Reply-To: <20250922054351.14289-4-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Mon, 22 Sep 2025 05:43:50 +0000")
References: <20250922054351.14289-1-gustavo.romero@linaro.org>
 <20250922054351.14289-4-gustavo.romero@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 22 Sep 2025 10:30:19 +0100
Message-ID: <87h5wuq1g4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
> reverse_debugging now uses the pygdbmi module to interact with GDB, if
> it's available in the test environment, otherwise the test is skipped.
> GDB is detect via the QEMU_TEST_GDB env. variable.
>
> This commit also significantly improves the output for the test and
> now prints all the GDB commands used in sequence. It also adds
> some clarifications to existing comments, for example, clarifying that
> once the replay-break is reached, a SIGINT is captured in GDB.
>
> reverse_debugging is kept "skipped" for aarch64, ppc64, and x86_64, so
> won't run unless QEMU_TEST_FLAKY_TESTS=3D1 is set in the test environment,
> before running 'make check-functional' or 'meson test [...]'.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  tests/functional/reverse_debugging.py | 308 ++++++++++++++++----------
>  1 file changed, 188 insertions(+), 120 deletions(-)
>
> diff --git a/tests/functional/reverse_debugging.py b/tests/functional/rev=
erse_debugging.py
> index f9a1d395f1..38161beab8 100644
> --- a/tests/functional/reverse_debugging.py
> +++ b/tests/functional/reverse_debugging.py
> @@ -1,21 +1,94 @@
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
> +import re
> +import subprocess
> +from pygdbmi.gdbcontroller import GdbController
> +from pygdbmi.constants import GdbTimeoutError
> +
>=20=20
>  from qemu_test import LinuxKernelTest, get_qemu_img
>  from qemu_test.ports import Ports
>=20=20
>=20=20
> +class GDB:
> +    def __init__(self, gdb_path, echo=3DTrue, suffix=3D'# ', prompt=3D"$=
 "):
> +        gdb_cmd =3D [gdb_path, "-q", "--interpreter=3Dmi2"]
> +        self.gdbmi =3D GdbController(gdb_cmd)
> +        self.echo =3D echo
> +        self.suffix =3D suffix
> +        self.prompt =3D prompt
> +
> +
> +    def get_payload(self, response, kind):
> +        output =3D []
> +        for o in response:
> +            # Unpack payloads of the same type.
> +            _type, _, payload, *_ =3D o.values()
> +            if _type =3D=3D kind:
> +                output +=3D [payload]
> +
> +        # Some output lines do not end with \n but begin with it,
> +        # so remove the leading \n and merge them with the next line
> +        # that ends with \n.
> +        lines =3D [line.lstrip('\n') for line in output]
> +        lines =3D "".join(lines)
> +        lines =3D lines.splitlines(keepends=3DTrue)
> +
> +        return lines
> +
> +
> +    def cli(self, cmd, timeout=3D4.0):
> +        self.response =3D self.gdbmi.write(cmd, timeout_sec=3Dtimeout)
> +        self.cmd_output =3D self.get_payload(self.response, "console")
> +        if self.echo:
> +            print(self.suffix + self.prompt + cmd)
> +
> +            if len(self.cmd_output) > 0:
> +                cmd_output =3D self.suffix.join(self.cmd_output)
> +                print(self.suffix + cmd_output, end=3D"")
> +
> +        return self
> +
> +
> +    def get_addr(self):
> +        pattern =3D r"0x[0-9A-Fa-f]+"
> +        cmd_output =3D "".join(self.cmd_output)
> +        match =3D re.search(pattern, cmd_output)
> +
> +        return int(match[0], 16) if match else None
> +
> +
> +    def get_log(self):
> +        r =3D self.get_payload(self.response, kind=3D"log")
> +        r =3D "".join(r)
> +
> +        return r
> +
> +
> +    def get_console(self):
> +        r =3D "".join(self.cmd_output)
> +
> +        return r
> +
> +
> +    def exit(self):
> +        self.gdbmi.exit()
> +
> +

Could this re-factor into a class have been a separate commit?

>  class ReverseDebugging(LinuxKernelTest):
>      """
>      Test GDB reverse debugging commands: reverse step and reverse contin=
ue.
> @@ -28,21 +101,17 @@ class ReverseDebugging(LinuxKernelTest):
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
>          if record:
> -            logger.info('recording the execution...')
> +            logger.info('Recording the execution...')

Mixing capitalisation fixes with logical change makes reviewing a pain.

>              mode =3D 'record'
>          else:
> -            logger.info('replaying the execution...')
> +            logger.info('Replaying the execution...')
>              mode =3D 'replay'
>              vm.add_args('-gdb', 'tcp::%d' % port, '-S')
>          vm.add_args('-icount', 'shift=3D%s,rr=3D%s,rrfile=3D%s,rrsnapsho=
t=3Dinit' %
> @@ -52,145 +121,144 @@ def run_vm(self, record, shift, args, replay_path,=
 image_path, port):
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
> -        return vm

I suspect dropping the console drainer could be a separate commit like
in Daniels series.

>=20=20
> -    @staticmethod
> -    def get_reg_le(g, reg):
> -        res =3D g.cmd(b'p%x' % reg)
> -        num =3D 0
> -        for i in range(len(res))[-2::-2]:
> -            num =3D 0x100 * num + int(res[i:i + 2], 16)
> -        return num
> -
> -    @staticmethod
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
> -
> -    def get_pc(self, g):
> -        return self.get_reg(g, self.REG_PC)
> -
> -    def check_pc(self, g, addr):
> -        pc =3D self.get_pc(g)
> -        if pc !=3D addr:
> -            self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))
> -
> -    @staticmethod
> -    def gdb_step(g):
> -        g.cmd(b's', b'T05thread:01;')
> -
> -    @staticmethod
> -    def gdb_bstep(g):
> -        g.cmd(b'bs', b'T05thread:01;')
> +        return vm
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
> -        logger.info('creating qcow2 image for VM snapshots')
> +        # Create qcow2 for snapshots
> +        logger.info('Creating qcow2 image for VM snapshots')
>          image_path =3D os.path.join(self.workdir, 'disk.qcow2')
>          qemu_img =3D get_qemu_img(self)
>          if qemu_img is None:
>              self.skipTest('Could not find "qemu-img", which is required =
to '
>                            'create the temporary qcow2 image')
>          cmd =3D '%s create -f qcow2 %s 128M' % (qemu_img, image_path)
> -        process.run(cmd)
> +        r =3D subprocess.run(cmd, capture_output=3DTrue, shell=3DTrue, t=
ext=3DTrue)
> +        logger.info(r.args)
> +        logger.info(r.stdout)
>=20=20
>          replay_path =3D os.path.join(self.workdir, 'replay.bin')
>=20=20
> -        # record the log
> +        # Record the log.
>          vm =3D self.run_vm(True, shift, args, replay_path, image_path, -=
1)
>          while self.vm_get_icount(vm) <=3D self.STEPS:
>              pass
>          last_icount =3D self.vm_get_icount(vm)
>          vm.shutdown()
>=20=20
> -        logger.info("recorded log with %s+ steps" % last_icount)
> +        logger.info("Recorded log with %s+ steps" % last_icount)
> +
> +        # Replay and run debug commands.
> +        gdb_cmd =3D os.getenv('QEMU_TEST_GDB')
> +        if not gdb_cmd:
> +            test.skipTest(f"Test skipped because there is no GDB
> available!")

This fails:

  test:         qemu:func-thorough+func-aarch64-thorough+thorough / func-aa=
rch64-reverse_debug
  start time:   09:24:25
  duration:     0.88s
  result:       exit status 1
  command:      ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_s=
ummary=3D1 MALLOC_PERTURB_=3D220 QEMU_TEST_QEMU_BINARY=3D/home/alex/lsrc/qe=
mu.git/builds/all/qemu-system-aarch64=20
  LD_LIBRARY_PATH=3D/home/alex/lsrc/qemu.git/builds/all/contrib/plugins:/ho=
me/alex/lsrc/qemu.git/builds/all/tests/tcg/plugins UBSAN_OPTIONS=3Dhalt_on_=
error=3D1:abort_on_error=3D1:print
  _summary=3D1:print_stacktrace=3D1 PYTHONPATH=3D/home/alex/lsrc/qemu.git/p=
ython:/home/alex/lsrc/qemu.git/tests/functional RUST_BACKTRACE=3D1 QEMU_BUI=
LD_ROOT=3D/home/alex/lsrc/qemu.git/b
  uilds/all MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summa=
ry=3D1:print_stacktrace=3D1 QEMU_TEST_QEMU_IMG=3D/home/alex/lsrc/qemu.git/b=
uilds/all/qemu-img MESON_TEST_ITERATIO
  N=3D1 /home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 /home/alex/l=
src/qemu.git/tests/functional/aarch64/test_reverse_debug.py
  ----------------------------------- stdout ------------------------------=
-----
  TAP version 13
  not ok 1 test_reverse_debug.ReverseDebugging_AArch64.test_aarch64_virt
  1..1
  ----------------------------------- stderr ------------------------------=
-----
  Traceback (most recent call last):
    File "/home/alex/lsrc/qemu.git/tests/functional/aarch64/test_reverse_de=
bug.py", line 31, in test_aarch64_virt
      self.reverse_debugging(args=3D('-kernel', kernel_path))
      ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/home/alex/lsrc/qemu.git/tests/functional/reverse_debugging.py", =
line 160, in reverse_debugging
      test.skipTest(f"Test skipped because there is no GDB available!")
      ^^^^
  NameError: name 'test' is not defined

  More information on test_reverse_debug.ReverseDebugging_AArch64.test_aarc=
h64_virt could be found here:
   /home/alex/lsrc/qemu.git/builds/all/tests/functional/aarch64/test_revers=
e_debug.ReverseDebugging_AArch64.test_aarch64_virt/base.log
   /home/alex/lsrc/qemu.git/builds/all/tests/functional/aarch64/test_revers=
e_debug.ReverseDebugging_AArch64.test_aarch64_virt/console.log

  (test program exited with status code 1)

Not sure why though as:

    cat config-host.mak
  # Automatically generated by configure - do not modify

  all:
  SRC_PATH=3D/home/alex/lsrc/qemu.git
  TARGET_DIRS=3Daarch64-linux-user aarch64_be-linux-user alpha-linux-user a=
rm-linux-user armeb-linux-user hexagon-linux-user hppa-linux-user i386-linu=
x-user loongarch64-linux-user m68k-linux-user microblaze-linux-user microbl=
azeel-linux-user mips-linux-user mips64-linux-user mips64el-linux-user mips=
el-linux-user mipsn32-linux-user mipsn32el-linux-user or1k-linux-user ppc-l=
inux-user ppc64-linux-user ppc64le-linux-user riscv32-linux-user riscv64-li=
nux-user s390x-linux-user sh4-linux-user sh4eb-linux-user sparc-linux-user =
sparc32plus-linux-user sparc64-linux-user x86_64-linux-user xtensa-linux-us=
er xtensaeb-linux-user aarch64-softmmu alpha-softmmu arm-softmmu avr-softmm=
u hppa-softmmu i386-softmmu loongarch64-softmmu m68k-softmmu microblaze-sof=
tmmu microblazeel-softmmu mips-softmmu mips64-softmmu mips64el-softmmu mips=
el-softmmu or1k-softmmu ppc-softmmu ppc64-softmmu riscv32-softmmu riscv64-s=
oftmmu rx-softmmu s390x-softmmu sh4-softmmu sh4eb-softmmu sparc-softmmu spa=
rc64-softmmu tricore-softmmu x86_64-softmmu xtensa-softmmu xtensaeb-softmmu
  GDB=3D/usr/bin/gdb-multiarch

>=20=20
> -        # replay and run debug commands
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
> -            self.fail('Reverse step is not supported by QEMU')
> -        if b'ReverseContinue+' not in r:
> -            self.fail('Reverse continue is not supported by QEMU')
> -
> -        logger.info('stepping forward')
> -        steps =3D []
> -        # record first instruction addresses
> -        for _ in range(self.STEPS):
> -            pc =3D self.get_pc(g)
> -            logger.info('saving position %x' % pc)
> -            steps.append(pc)
> -            self.gdb_step(g)
> -
> -        # visit the recorded instruction in reverse order
> -        logger.info('stepping backward')
> -        for addr in steps[::-1]:
> -            self.gdb_bstep(g)
> -            self.check_pc(g, addr)
> -            logger.info('found position %x' % addr)
> -
> -        # visit the recorded instruction in forward order
> -        logger.info('stepping forward')
> -        for addr in steps:
> -            self.check_pc(g, addr)
> -            self.gdb_step(g)
> -            logger.info('found position %x' % addr)
> -
> -        # set breakpoints for the instructions just stepped over
> -        logger.info('setting breakpoints')
> -        for addr in steps:
> -            # hardware breakpoint at addr with len=3D1
> -            g.cmd(b'Z1,%x,1' % addr, b'OK')
> -
> -        # this may hit a breakpoint if first instructions are executed
> -        # again
> -        logger.info('continuing execution')
> -        vm.qmp('replay-break', icount=3Dlast_icount - 1)
> -        # continue - will return after pausing
> -        # This could stop at the end and get a T02 return, or by
> -        # re-executing one of the breakpoints and get a T05 return.
> -        g.cmd(b'c')
> -        if self.vm_get_icount(vm) =3D=3D last_icount - 1:
> -            logger.info('reached the end (icount %s)' % (last_icount - 1=
))
> -        else:
> -            logger.info('hit a breakpoint again at %x (icount %s)' %
> -                        (self.get_pc(g), self.vm_get_icount(vm)))
>=20=20
> -        logger.info('running reverse continue to reach %x' % steps[-1])
> -        # reverse continue - will return after stopping at the breakpoint
> -        g.cmd(b'bc', b'T05thread:01;')
> +        try:
> +            gdb =3D GDB(gdb_cmd)
>=20=20
> -        # assume that none of the first instructions is executed again
> -        # breaking the order of the breakpoints
> -        self.check_pc(g, steps[-1])
> -        logger.info('successfully reached %x' % steps[-1])
> +            logger.info('Connecting to gdbstub...')
>=20=20
> -        logger.info('exiting gdb and qemu')
> -        vm.shutdown()
> +            gdb.cli("set debug remote 1")
> +
> +            c =3D gdb.cli(f"target remote localhost:{port}").get_console=
()
> +            if not f"Remote debugging using localhost:{port}" in c:
> +                self.fail("Could not connect to gdbstub!")
> +
> +            # Remote debug messages are in 'log' payloads.
> +            r =3D gdb.get_log()
> +            if 'ReverseStep+' not in r:
> +                self.fail('Reverse step is not supported by QEMU')
> +            if 'ReverseContinue+' not in r:
> +                self.fail('Reverse continue is not supported by QEMU')
> +
> +            gdb.cli("set debug remote 0")
> +
> +            logger.info('Stepping forward')
> +            steps =3D []
> +            # Record first instruction addresses.
> +            for _ in range(self.STEPS):
> +                pc =3D gdb.cli("print $pc").get_addr()
> +                logger.info('Saving position %x' % pc)
> +                steps.append(pc)
> +
> +                gdb.cli("stepi")
> +
> +            # Visit the recorded instructions in reverse order.
> +            logger.info('Stepping backward')
> +            for saved_pc in steps[::-1]:
> +                logger.info('Found position %x' % saved_pc)
> +                gdb.cli("reverse-stepi")
> +                pc =3D gdb.cli("print $pc").get_addr()
> +                if pc !=3D saved_pc:
> +                    logger.info('Invalid PC (read %x instead of %x)' % (=
pc, saved_pc))
> +                    self.fail('Reverse stepping failed!')
> +
> +            # Visit the recorded instructions in forward order.
> +            logger.info('Stepping forward')
> +            for saved_pc in steps:
> +                logger.info('Found position %x' % saved_pc)
> +                pc =3D gdb.cli("print $pc").get_addr()
> +                if pc !=3D saved_pc:
> +                    logger.info('Invalid PC (read %x instead of %x)' % (=
pc, saved_pc))
> +                    self.fail('Forward stepping failed!')
> +
> +                gdb.cli("stepi")
> +
> +            # Set breakpoints for the instructions just stepped over.
> +            logger.info('Setting breakpoints')
> +            for saved_pc in steps:
> +                gdb.cli(f"break *{hex(saved_pc)}")
> +
> +            # This may hit a breakpoint if first instructions are execut=
ed again.
> +            logger.info('Continuing execution')
> +            vm.qmp('replay-break', icount=3Dlast_icount - 1)
> +            # continue - will return after pausing.
> +            # This can stop at the end of the replay-break and gdb gets =
a SIGINT,
> +            # or by re-executing one of the breakpoints and gdb stops at=
 a
> +            # breakpoint.
> +            gdb.cli("continue")
> +
> +            pc =3D gdb.cli("print $pc").get_addr()
> +            current_icount =3D self.vm_get_icount(vm)
> +            if current_icount =3D=3D last_icount - 1:
> +                print(f"# **** Hit replay-break at icount=3D{current_ico=
unt}, pc=3D{hex(pc)} ****")
> +                logger.info('Reached the end (icount %s)' % (current_ico=
unt))
> +            else:
> +                print(f"# **** Hit breakpoint at icount=3D{current_icoun=
t}, pc=3D{hex(pc)} ****")
> +                logger.info('Hit a breakpoint again at %x (icount %s)' %
> +                            (pc, current_icount))
> +
> +            logger.info('Running reverse continue to reach %x' % steps[-=
1])
> +            # reverse-continue - will return after stopping at the break=
point.
> +            gdb.cli("reverse-continue")
> +
> +            # Assume that none of the first instructions are executed ag=
ain
> +            # breaking the order of the breakpoints.
> +            # steps[-1] is the first saved $pc in reverse order.
> +            pc =3D gdb.cli("print $pc").get_addr()
> +            first_pc_in_rev_order =3D steps[-1]
> +            if pc =3D=3D first_pc_in_rev_order:
> +                print(f"# **** Hit breakpoint at the first PC in reverse=
 order ({hex(pc)}) ****")
> +                logger.info('Successfully reached breakpoint at %x' % fi=
rst_pc_in_rev_order)
> +            else:
> +                logger.info('Failed to reach breakpoint at %x' % first_p=
c_in_rev_order)
> +                self.fail("'reverse-continue' did not hit the first PC i=
n reverse order!")
> +
> +            logger.info('Exiting GDB and QEMU...')
> +            gdb.exit()
> +            vm.shutdown()
> +
> +            logger.info('Test passed.')
> +
> +        except GdbTimeoutError:
> +            self.fail("Connection to gdbstub timeouted...")

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

