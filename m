Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E16CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 15:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuCBf-0004uW-Us; Thu, 04 Sep 2025 11:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uuCBO-0004my-Ai
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:47:35 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uuCBF-0000B9-G7
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:47:30 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-544b17b85d0so497544e0c.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 08:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757000836; x=1757605636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JzPi6AAJjNLSF/pZx0QvPsk9TOqjtDlLVQ/0eg1jp74=;
 b=ibYgSAGiYPW9pqMK1YnlOjoNFhLARbnX59sGH4HnrMkJ+p4PN7F5tQOjWVi7gU9jQT
 2hlUGhNCUgOsnRoM/cVVxNbVC8uPxrR2fCWJCTAHG1dlex3fv3UETR4eno1rFZ16t7gk
 5WFuLbscR2J6eCCv8JYPEZtLtOz1D3uH3bc73rXBo13ZB6h1azmUeM9qjC7QBnbWksws
 QkLmm31v60C24QVGedpnjEf7jjS+VQCjG43dQXi3t5hjVhd/ioJU6fepj4WcqBx6POol
 5DoP7q2XguSb1heL0bgfGMx8Wzm72MGf7+zG0SqpAo0vIDCrm3HZrmAFofxMzwn7YK64
 JsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757000836; x=1757605636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JzPi6AAJjNLSF/pZx0QvPsk9TOqjtDlLVQ/0eg1jp74=;
 b=Q/T9Igo/bFpgxirAhFPaqVgA4fWkCandoHY00qwzmHM+Z7SGLDPQZJaJD+b2asnHwM
 5hsVQvQ0+9xrqCDVu+jpydrD4v/CELZQT4x4waIs/9VwzhzXie/FngwiOWkdQ0X8kX6c
 cAZ0wqPAglaSccDrzOH9JsUNfNR3dos80d+AlzsM/VfK82CygE/kobtelcYUUMu6Pohz
 s70HQCNZlFHbrH+USTEFm76XmHRtUQL101VLTRpCZbf5qFE/4jj9dkRVmoMCzBUQTo9E
 gjx4KZURueBRBOwghvbBfsFHebb1WoHQ4Pocbta2GwfIatIlJPKEGfTe4NQ6NsMmdqbC
 h74A==
X-Gm-Message-State: AOJu0YyRQykjEnJB4haWZ3zDGe/SZQgtkv8Zzq65XmfbZFnIB0uGlM4h
 t29gHh85uiz6MU0Zd+VwIkkuO2Zm7Ly//K4DCMOpFODSXovaC/I3yeSUiABCRI4aoou0VcJDJSl
 aKqdlO2QZOw==
X-Gm-Gg: ASbGnctY5qOCVWabNdXzyPexEiJsbBbS7GuOgm7PsrsadF1ikSiqpL2CBvK635A3kCK
 lYDmhRcUgoLQ99Wy48DiW2Wsm8zO5fvs4+PBm7FL46E/8EBsLP+Ulei9VUAkaLUgmnofFalUbaG
 JwoWv2a//Ea1dIdt4BfKJwpFe/wJDahw39ZrxFFpQvCqYnj7/ojAIJ/GXnfp0hgiEfDEZjbfhNi
 CstsQPnN1odPswrJMQfamlrOI648ESee2gPw3Ifpe8y5+dGfHfUzfK8hC2BlHTw84gv/XY6RlMs
 IZ60jTUWjxGOqVjHRs2F/6/cLOjBPTtCRFNMQ4RMKRgNf6P7Wc7pC7rOWFk63BOIJdkhWr1brni
 g6PpvZS1p2iyInqWF7jeOgP91oM6g
X-Google-Smtp-Source: AGHT+IFDh1roZkToHC0TsV+nW+ooeZiJGwJkGjVByot9FbfjcQYyYBvQEHYyGKq5XnN6Pv/l7jfC0g==
X-Received: by 2002:a05:6122:45a8:b0:545:ef3e:2f94 with SMTP id
 71dfb90a1353d-545ef3e36d1mr364183e0c.1.1757000835703; 
 Thu, 04 Sep 2025 08:47:15 -0700 (PDT)
Received: from gromero0.. ([186.215.58.133]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-544a666da0csm6497022e0c.28.2025.09.04.08.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 08:47:15 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	1844144@gmail.com,
	gustavo.romero@linaro.org
Subject: [PATCH v2 5/5] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
Date: Thu,  4 Sep 2025 15:46:40 +0000
Message-Id: <20250904154640.52687-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904154640.52687-1-gustavo.romero@linaro.org>
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa2e.google.com
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

This commit removes Avocado as a dependency for running the
reverse_debugging test.

The main benefit, beyond eliminating an extra dependency, is that there
is no longer any need to handle GDB packets manually. This removes the
need for ad-hoc functions dealing with endianness and arch-specific
register numbers, making the test easier to read. The timeout variable
is also removed, since Meson now manages timeouts automatically.

The reverse_debugging test is now executed through a runner, because it
requires GDB in addition to QMP. The runner is responsible for invoking
GDB with the appropriate arguments and for passing the test script to
GDB.

Since the test now runs inside GDB, its output, particularly from
'stepi' commands, which cannot be disabled, interleaves with the TAP
output from unittest. To avoid this conflict, the test no longer uses
Meson’s 'tap' protocol and instead relies on the simpler 'exitcode'
protocol.

reverse_debugging is kept "skipped" for aarch64, ppc64, and x86_64, so
won't run unless QEMU_TEST_FLAKY_TESTS=1 is set in the test environment,
before running 'make check-functional' or 'meson test [...]'.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/aarch64/meson.build          |   7 +-
 .../functional/aarch64/test_reverse_debug.py  |  15 +-
 tests/functional/ppc64/meson.build            |   7 +-
 tests/functional/ppc64/test_reverse_debug.py  |  17 +-
 tests/functional/reverse_debugging.py         | 175 +++++++++---------
 tests/functional/x86_64/meson.build           |   7 +-
 tests/functional/x86_64/test_reverse_debug.py |  21 +--
 7 files changed, 131 insertions(+), 118 deletions(-)

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index 04846c6eb1..4f3168dd55 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -32,7 +32,6 @@ tests_aarch64_system_thorough = [
   'raspi3',
   'raspi4',
   'replay',
-  'reverse_debug',
   'rme_virt',
   'rme_sbsaref',
   'sbsaref',
@@ -46,3 +45,9 @@ tests_aarch64_system_thorough = [
   'xen',
   'xlnx_versal',
 ]
+
+if is_variable('gdb_runner')
+tests_aarch64_system_thorough_with_runner = [
+    ['reverse_debug', gdb_runner, 'exitcode'],
+]
+endif
diff --git a/tests/functional/aarch64/test_reverse_debug.py b/tests/functional/aarch64/test_reverse_debug.py
index 8bc91ccfde..8b6f82c227 100755
--- a/tests/functional/aarch64/test_reverse_debug.py
+++ b/tests/functional/aarch64/test_reverse_debug.py
@@ -1,26 +1,25 @@
-#!/usr/bin/env python3
-#
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-# Reverse debugging test
+# Reverse debugging test for aarch64
 #
 # Copyright (c) 2020 ISP RAS
+# Copyright (c) 2025 Linaro Limited
 #
 # Author:
 #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
+#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import Asset, skipIfMissingImports, skipFlakyTest
+# ReverseDebugging must be imported always first because of the check
+# in it for not running this test without the GDB runner.
 from reverse_debugging import ReverseDebugging
+from qemu_test import Asset, skipFlakyTest
 
 
-@skipIfMissingImports('avocado.utils')
 class ReverseDebugging_AArch64(ReverseDebugging):
 
-    REG_PC = 32
-
     ASSET_KERNEL = Asset(
         ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
          'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
@@ -35,4 +34,4 @@ def test_aarch64_virt(self):
 
 
 if __name__ == '__main__':
-    ReverseDebugging.main()
+    ReverseDebugging_AArch64.main()
diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/meson.build
index 842fe0fc71..e81f8b0003 100644
--- a/tests/functional/ppc64/meson.build
+++ b/tests/functional/ppc64/meson.build
@@ -20,6 +20,11 @@ tests_ppc64_system_thorough = [
   'powernv',
   'pseries',
   'replay',
-  'reverse_debug',
   'tuxrun',
 ]
+
+if is_variable('gdb_runner')
+tests_ppc64_system_thorough_with_runner = [
+    ['reverse_debug', gdb_runner, 'exitcode'],
+]
+endif
diff --git a/tests/functional/ppc64/test_reverse_debug.py b/tests/functional/ppc64/test_reverse_debug.py
index 5931adef5a..e70ca85d0a 100755
--- a/tests/functional/ppc64/test_reverse_debug.py
+++ b/tests/functional/ppc64/test_reverse_debug.py
@@ -1,41 +1,38 @@
-#!/usr/bin/env python3
-#
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-# Reverse debugging test
+# Reverse debugging test for ppc64
 #
 # Copyright (c) 2020 ISP RAS
+# Copyright (c) 2025 Linaro Limited
 #
 # Author:
 #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
+#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import skipIfMissingImports, skipFlakyTest
+# ReverseDebugging must be imported always first because of the check
+# in it for not running this test without the GDB runner.
 from reverse_debugging import ReverseDebugging
+from qemu_test import skipFlakyTest
 
 
-@skipIfMissingImports('avocado.utils')
 class ReverseDebugging_ppc64(ReverseDebugging):
 
-    REG_PC = 0x40
-
     @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
     def test_ppc64_pseries(self):
         self.set_machine('pseries')
         # SLOF branches back to its entry point, which causes this test
         # to take the 'hit a breakpoint again' path. That's not a problem,
         # just slightly different than the other machines.
-        self.endian_is_le = False
         self.reverse_debugging()
 
     @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
     def test_ppc64_powernv(self):
         self.set_machine('powernv')
-        self.endian_is_le = False
         self.reverse_debugging()
 
 
 if __name__ == '__main__':
-    ReverseDebugging.main()
+    ReverseDebugging_ppc64.main()
diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index f9a1d395f1..bb0b176579 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -1,16 +1,26 @@
-# Reverse debugging test
-#
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
+# Reverse debugging test
+#
 # Copyright (c) 2020 ISP RAS
+# Copyright (c) 2025 Linaro Limited
 #
 # Author:
 #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
+#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
-import os
+
+try:
+    import gdb
+except ModuleNotFoundError:
+    from sys import exit
+    exit("This script must be launched via tests/guest-debug/run-test.py!")
 import logging
+import os
+import subprocess
+
 
 from qemu_test import LinuxKernelTest, get_qemu_img
 from qemu_test.ports import Ports
@@ -28,13 +38,9 @@ class ReverseDebugging(LinuxKernelTest):
     that the execution is stopped at the last of them.
     """
 
-    timeout = 10
     STEPS = 10
-    endian_is_le = True
 
     def run_vm(self, record, shift, args, replay_path, image_path, port):
-        from avocado.utils import datadrainer
-
         logger = logging.getLogger('replay')
         vm = self.get_vm(name='record' if record else 'replay')
         vm.set_console()
@@ -52,59 +58,48 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
         if args:
             vm.add_args(*args)
         vm.launch()
-        console_drainer = datadrainer.LineLogger(vm.console_socket.fileno(),
-                                    logger=self.log.getChild('console'),
-                                    stop_check=(lambda : not vm.is_running()))
-        console_drainer.start()
+
         return vm
 
     @staticmethod
-    def get_reg_le(g, reg):
-        res = g.cmd(b'p%x' % reg)
-        num = 0
-        for i in range(len(res))[-2::-2]:
-            num = 0x100 * num + int(res[i:i + 2], 16)
-        return num
+    def gdb_connect(host, port):
+        # Set debug on connection to get the qSupport string.
+        gdb.execute("set debug remote 1")
+        r = gdb.execute(f"target remote {host}:{port}", False, True)
+        gdb.execute("set debug remote 0")
+
+        return r
 
     @staticmethod
-    def get_reg_be(g, reg):
-        res = g.cmd(b'p%x' % reg)
-        return int(res, 16)
-
-    def get_reg(self, g, reg):
-        # value may be encoded in BE or LE order
-        if self.endian_is_le:
-            return self.get_reg_le(g, reg)
-        else:
-            return self.get_reg_be(g, reg)
+    def get_pc():
+        val = gdb.parse_and_eval("$pc")
+        pc = int(val)
 
-    def get_pc(self, g):
-        return self.get_reg(g, self.REG_PC)
+        return pc
 
-    def check_pc(self, g, addr):
-        pc = self.get_pc(g)
+    def check_pc(self, addr):
+        logger = logging.getLogger('reply')
+        pc = self.get_pc()
         if pc != addr:
-            self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))
+            logger.info('Invalid PC (read %x instead of %x)' % (pc, addr))
+            gdb.execute("exit 1")
 
     @staticmethod
-    def gdb_step(g):
-        g.cmd(b's', b'T05thread:01;')
+    def gdb_step():
+        gdb.execute("stepi")
 
     @staticmethod
-    def gdb_bstep(g):
-        g.cmd(b'bs', b'T05thread:01;')
+    def gdb_bstep():
+        gdb.execute("reverse-stepi")
 
     @staticmethod
     def vm_get_icount(vm):
         return vm.qmp('query-replay')['return']['icount']
 
     def reverse_debugging(self, shift=7, args=None):
-        from avocado.utils import gdb
-        from avocado.utils import process
-
         logger = logging.getLogger('replay')
 
-        # create qcow2 for snapshots
+        # Create qcow2 for snapshots
         logger.info('creating qcow2 image for VM snapshots')
         image_path = os.path.join(self.workdir, 'disk.qcow2')
         qemu_img = get_qemu_img(self)
@@ -112,11 +107,11 @@ def reverse_debugging(self, shift=7, args=None):
             self.skipTest('Could not find "qemu-img", which is required to '
                           'create the temporary qcow2 image')
         cmd = '%s create -f qcow2 %s 128M' % (qemu_img, image_path)
-        process.run(cmd)
+        subprocess.run(cmd, shell=True)
 
         replay_path = os.path.join(self.workdir, 'replay.bin')
 
-        # record the log
+        # Record the log.
         vm = self.run_vm(True, shift, args, replay_path, image_path, -1)
         while self.vm_get_icount(vm) <= self.STEPS:
             pass
@@ -125,72 +120,84 @@ def reverse_debugging(self, shift=7, args=None):
 
         logger.info("recorded log with %s+ steps" % last_icount)
 
-        # replay and run debug commands
+        # Replay and run debug commands.
         with Ports() as ports:
             port = ports.find_free_port()
             vm = self.run_vm(False, shift, args, replay_path, image_path, port)
-        logger.info('connecting to gdbstub')
-        g = gdb.GDBRemote('127.0.0.1', port, False, False)
-        g.connect()
-        r = g.cmd(b'qSupported')
-        if b'qXfer:features:read+' in r:
-            g.cmd(b'qXfer:features:read:target.xml:0,ffb')
-        if b'ReverseStep+' not in r:
+        logger.info('Connecting to gdbstub')
+        r = self.gdb_connect('127.0.0.1', port)
+        if 'ReverseStep+' not in r:
             self.fail('Reverse step is not supported by QEMU')
-        if b'ReverseContinue+' not in r:
+        if 'ReverseContinue+' not in r:
             self.fail('Reverse continue is not supported by QEMU')
 
-        logger.info('stepping forward')
+        logger.info('Stepping forward')
         steps = []
-        # record first instruction addresses
+        # Record first instruction addresses.
         for _ in range(self.STEPS):
-            pc = self.get_pc(g)
-            logger.info('saving position %x' % pc)
+            pc = self.get_pc()
+            logger.info('Saving position %x' % pc)
             steps.append(pc)
-            self.gdb_step(g)
+            self.gdb_step()
 
-        # visit the recorded instruction in reverse order
-        logger.info('stepping backward')
+        # Visit the recorded instruction in reverse order.
+        logger.info('Stepping backward')
         for addr in steps[::-1]:
-            self.gdb_bstep(g)
-            self.check_pc(g, addr)
-            logger.info('found position %x' % addr)
+            self.gdb_bstep()
+            self.check_pc(addr)
+            logger.info('Found position %x' % addr)
 
-        # visit the recorded instruction in forward order
-        logger.info('stepping forward')
+        # Visit the recorded instruction in forward order.
+        logger.info('Stepping forward')
         for addr in steps:
-            self.check_pc(g, addr)
-            self.gdb_step(g)
-            logger.info('found position %x' % addr)
+            self.check_pc(addr)
+            self.gdb_step()
+            logger.info('Found position %x' % addr)
 
-        # set breakpoints for the instructions just stepped over
-        logger.info('setting breakpoints')
+        # Set breakpoints for the instructions just stepped over.
+        logger.info('Setting breakpoints')
         for addr in steps:
             # hardware breakpoint at addr with len=1
-            g.cmd(b'Z1,%x,1' % addr, b'OK')
+            gdb.execute(f"break *{hex(addr)}")
 
-        # this may hit a breakpoint if first instructions are executed
-        # again
-        logger.info('continuing execution')
+        # This may hit a breakpoint if first instructions are executed again.
+        logger.info('Continuing execution')
         vm.qmp('replay-break', icount=last_icount - 1)
-        # continue - will return after pausing
+        # continue - will return after pausing.
         # This could stop at the end and get a T02 return, or by
         # re-executing one of the breakpoints and get a T05 return.
-        g.cmd(b'c')
+        gdb.execute("continue")
         if self.vm_get_icount(vm) == last_icount - 1:
-            logger.info('reached the end (icount %s)' % (last_icount - 1))
+            logger.info('Reached the end (icount %s)' % (last_icount - 1))
         else:
-            logger.info('hit a breakpoint again at %x (icount %s)' %
+            logger.info('Hit a breakpoint again at %x (icount %s)' %
                         (self.get_pc(g), self.vm_get_icount(vm)))
 
-        logger.info('running reverse continue to reach %x' % steps[-1])
-        # reverse continue - will return after stopping at the breakpoint
-        g.cmd(b'bc', b'T05thread:01;')
+        logger.info('Running reverse continue to reach %x' % steps[-1])
+        # reverse continue - will return after stopping at the breakpoint.
+        gdb.execute("reverse-continue")
 
-        # assume that none of the first instructions is executed again
-        # breaking the order of the breakpoints
-        self.check_pc(g, steps[-1])
-        logger.info('successfully reached %x' % steps[-1])
+        # Assume that none of the first instructions is executed again
+        # breaking the order of the breakpoints.
+        # steps[-1] is the first saved $pc in reverse order.
+        self.check_pc(steps[-1])
+        logger.info('Successfully reached %x' % steps[-1])
 
-        logger.info('exiting gdb and qemu')
+        logger.info('Exiting GDB and QEMU...')
+        # Disconnect from the VM.
+        gdb.execute("disconnect")
+        # Guarantee VM is shutdown.
         vm.shutdown()
+        # Gently exit from GDB.
+        gdb.execute("exit 0")
+
+    def main():
+        try:
+            LinuxKernelTest.main()
+        except SystemExit:
+            # If the test is marked with @skipFlakyTest, then it will be exited
+            # via sys.exit() before we have the chance to exit from GDB gently.
+            # Because recent versions of GDB will return a failure value if this
+            # happens, we catch the SystemExit and exit from GDB gently with 77,
+            # which meson interprets correctly as a skipped test.
+            gdb.execute("exit 77")
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index d0b4667bb8..b5e0c9a0d7 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -29,8 +29,13 @@ tests_x86_64_system_thorough = [
   'multiprocess',
   'netdev_ethtool',
   'replay',
-  'reverse_debug',
   'tuxrun',
   'virtio_balloon',
   'virtio_gpu',
 ]
+
+if is_variable('gdb_runner')
+    tests_x86_64_system_thorough_with_runner = [
+        ['reverse_debug', gdb_runner, 'exitcode'],
+    ]
+endif
diff --git a/tests/functional/x86_64/test_reverse_debug.py b/tests/functional/x86_64/test_reverse_debug.py
index d713e91e14..465f7e0abb 100755
--- a/tests/functional/x86_64/test_reverse_debug.py
+++ b/tests/functional/x86_64/test_reverse_debug.py
@@ -1,36 +1,31 @@
-#!/usr/bin/env python3
-#
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-# Reverse debugging test
+# Reverse debugging test for x86_64
 #
 # Copyright (c) 2020 ISP RAS
+# Copyright (c) 2025 Linaro Limited
 #
 # Author:
 #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
+#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import skipIfMissingImports, skipFlakyTest
+# ReverseDebugging must be imported always first because of the check
+# in it for not running this test without the GDB runner.
 from reverse_debugging import ReverseDebugging
+from qemu_test import skipFlakyTest
 
 
-@skipIfMissingImports('avocado.utils')
 class ReverseDebugging_X86_64(ReverseDebugging):
 
-    REG_PC = 0x10
-    REG_CS = 0x12
-    def get_pc(self, g):
-        return self.get_reg_le(g, self.REG_PC) \
-            + self.get_reg_le(g, self.REG_CS) * 0x10
-
     @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2922")
     def test_x86_64_pc(self):
         self.set_machine('pc')
-        # start with BIOS only
+        # Start with BIOS only
         self.reverse_debugging()
 
 
 if __name__ == '__main__':
-    ReverseDebugging.main()
+    ReverseDebugging_X86_64.main()
-- 
2.34.1


