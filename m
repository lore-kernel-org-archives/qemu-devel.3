Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5216DCAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 05:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ZMg-0008Dq-VF; Mon, 22 Sep 2025 01:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v0ZMV-00083I-IC
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 01:45:21 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v0ZMN-0004v0-F2
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 01:45:19 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-267fac63459so37602945ad.1
 for <qemu-devel@nongnu.org>; Sun, 21 Sep 2025 22:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758519909; x=1759124709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNCgENo9nE5qZpUTa2mjhnOx7lkfEjj5d10yyAbw+Ik=;
 b=xqJ/klNnKh0gxvzPzbEHYm38EYkftYKZ6DliZMdJR9kXMGKqfrk6JSS0KEWEjBPSp8
 UyqjCBwFub0KHdIxj5IyCe/lfUawLz/orQc8P0wZTplNPcr+YMR3Lip7Iws0nJIdzmGS
 Cr6pxR30LVHwxpGMeP8FhIdwHH67a18+9sp88kyvqmwaTaa7Y2LQSYO7Q6twE54RpDXN
 kqxykVs4VGcVazDed3w0vZG832g0eP1ttUfHPWZqQxGCELTqFpeMkue2M33zRfmj0WYl
 Cu/MkD8EWUyYoazccoQM7XSxFjDffjwyPf7zZReGZCbAErC6BhxG2ZqyN9LPySEImxBU
 jqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758519909; x=1759124709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mNCgENo9nE5qZpUTa2mjhnOx7lkfEjj5d10yyAbw+Ik=;
 b=g2wT8iNTtIuCqxMB9IinRHQ6PjxwCXM/lOG+ZxMuC7a2zmKlN0NH2gXHGHlNj/KyW0
 kqQS63WrCtPcnYgy4naTEdX/lom4QyXytnnhiGr+9Xym9TBLZpP0QJK7V77imPbffx7H
 hvuER6tvT0IYGp+awo1KfXHtSkvvUkurPKMTAqKX/1RMKRU67wAuq63GsRJ1ZngfAMtq
 DGYJJzPE01uU+LoMlWp590v4D+CyZvp0bD+93blqXszAjAcFx6ivFY8LLBauugfg2thL
 yAeExIIPcwynVzNGHCS8XKgdG8tTOKGphwJz2RjH4G+tUEPZB11FotU4WtHtemeJk+L+
 9tHQ==
X-Gm-Message-State: AOJu0Ywn2/qsq3YXcxjg1/+stDdNMBipTKEmxYOLg2l8w97vKAE1O56Z
 yxmsh3GAmytxW17cud3HhTW44kicDWSgu789W+eAIzd04PPMJfiLtcjBatj/cDmwa2eM++Qojgx
 oQ05t
X-Gm-Gg: ASbGncvmNdwCno9CE700BTem5z3Wsa6QSa6X/2hI424A2XpAwg8AvLEpTcbej4tjfe3
 Ma16Ktg+DzuS8Dz9oRR+RT5Ob6tDWZro5454VQ3iSp83qjKmyw2/5JVDfkW/SCXECAxnBjbMetE
 +fuCl2Q3e8NxeVoUykZv6ZP4pskumbGW6GUemxjerqyxgefcv78nya5LopgVCa0ES4Jq2GHfqO1
 Og3w4Vis4qjLPfM+o/y6tcn9eUs0CoLspXPjDqqqKWkjn5C/QofHN+EYLw0tVpuVTkuFNKe+Fa6
 OLgcURLrfBgq5F5NoOBpckZbHITu+PLP4+Bw7IXQBjyBs/MvdIlDjh5aUs0hWyngARk3C5dwg3n
 kwEoRpwfssswaU23zs6GPijM9tkICqIDiK+6UMl11UY1rEYo1NoW68PIcUlHEWrOtSQW+0/dE
X-Google-Smtp-Source: AGHT+IEdHk9lgFGER+L9MZ5+8C5vZhfAbXFdko6OaYPCN6Waf/7FSt0Q0ZC6TsfNLtnq7FffZFBM/g==
X-Received: by 2002:a17:902:e805:b0:267:a55a:8684 with SMTP id
 d9443c01a7336-269ba40b48dmr162881955ad.2.1758519909516; 
 Sun, 21 Sep 2025 22:45:09 -0700 (PDT)
Received: from gromero0.. (200-162-224-93.static-corp.ajato.com.br.
 [200.162.224.93]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b551c279cd5sm7691377a12.3.2025.09.21.22.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Sep 2025 22:45:09 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v3 3/4] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
Date: Mon, 22 Sep 2025 05:43:50 +0000
Message-Id: <20250922054351.14289-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922054351.14289-1-gustavo.romero@linaro.org>
References: <20250922054351.14289-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
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

reverse_debugging now uses the pygdbmi module to interact with GDB, if
it's available in the test environment, otherwise the test is skipped.
GDB is detect via the QEMU_TEST_GDB env. variable.

This commit also significantly improves the output for the test and
now prints all the GDB commands used in sequence. It also adds
some clarifications to existing comments, for example, clarifying that
once the replay-break is reached, a SIGINT is captured in GDB.

reverse_debugging is kept "skipped" for aarch64, ppc64, and x86_64, so
won't run unless QEMU_TEST_FLAKY_TESTS=1 is set in the test environment,
before running 'make check-functional' or 'meson test [...]'.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/reverse_debugging.py | 308 ++++++++++++++++----------
 1 file changed, 188 insertions(+), 120 deletions(-)

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index f9a1d395f1..38161beab8 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -1,21 +1,94 @@
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
 import logging
+import os
+import re
+import subprocess
+from pygdbmi.gdbcontroller import GdbController
+from pygdbmi.constants import GdbTimeoutError
+
 
 from qemu_test import LinuxKernelTest, get_qemu_img
 from qemu_test.ports import Ports
 
 
+class GDB:
+    def __init__(self, gdb_path, echo=True, suffix='# ', prompt="$ "):
+        gdb_cmd = [gdb_path, "-q", "--interpreter=mi2"]
+        self.gdbmi = GdbController(gdb_cmd)
+        self.echo = echo
+        self.suffix = suffix
+        self.prompt = prompt
+
+
+    def get_payload(self, response, kind):
+        output = []
+        for o in response:
+            # Unpack payloads of the same type.
+            _type, _, payload, *_ = o.values()
+            if _type == kind:
+                output += [payload]
+
+        # Some output lines do not end with \n but begin with it,
+        # so remove the leading \n and merge them with the next line
+        # that ends with \n.
+        lines = [line.lstrip('\n') for line in output]
+        lines = "".join(lines)
+        lines = lines.splitlines(keepends=True)
+
+        return lines
+
+
+    def cli(self, cmd, timeout=4.0):
+        self.response = self.gdbmi.write(cmd, timeout_sec=timeout)
+        self.cmd_output = self.get_payload(self.response, "console")
+        if self.echo:
+            print(self.suffix + self.prompt + cmd)
+
+            if len(self.cmd_output) > 0:
+                cmd_output = self.suffix.join(self.cmd_output)
+                print(self.suffix + cmd_output, end="")
+
+        return self
+
+
+    def get_addr(self):
+        pattern = r"0x[0-9A-Fa-f]+"
+        cmd_output = "".join(self.cmd_output)
+        match = re.search(pattern, cmd_output)
+
+        return int(match[0], 16) if match else None
+
+
+    def get_log(self):
+        r = self.get_payload(self.response, kind="log")
+        r = "".join(r)
+
+        return r
+
+
+    def get_console(self):
+        r = "".join(self.cmd_output)
+
+        return r
+
+
+    def exit(self):
+        self.gdbmi.exit()
+
+
 class ReverseDebugging(LinuxKernelTest):
     """
     Test GDB reverse debugging commands: reverse step and reverse continue.
@@ -28,21 +101,17 @@ class ReverseDebugging(LinuxKernelTest):
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
         if record:
-            logger.info('recording the execution...')
+            logger.info('Recording the execution...')
             mode = 'record'
         else:
-            logger.info('replaying the execution...')
+            logger.info('Replaying the execution...')
             mode = 'replay'
             vm.add_args('-gdb', 'tcp::%d' % port, '-S')
         vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s,rrsnapshot=init' %
@@ -52,145 +121,144 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
         if args:
             vm.add_args(*args)
         vm.launch()
-        console_drainer = datadrainer.LineLogger(vm.console_socket.fileno(),
-                                    logger=self.log.getChild('console'),
-                                    stop_check=(lambda : not vm.is_running()))
-        console_drainer.start()
-        return vm
 
-    @staticmethod
-    def get_reg_le(g, reg):
-        res = g.cmd(b'p%x' % reg)
-        num = 0
-        for i in range(len(res))[-2::-2]:
-            num = 0x100 * num + int(res[i:i + 2], 16)
-        return num
-
-    @staticmethod
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
-
-    def get_pc(self, g):
-        return self.get_reg(g, self.REG_PC)
-
-    def check_pc(self, g, addr):
-        pc = self.get_pc(g)
-        if pc != addr:
-            self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))
-
-    @staticmethod
-    def gdb_step(g):
-        g.cmd(b's', b'T05thread:01;')
-
-    @staticmethod
-    def gdb_bstep(g):
-        g.cmd(b'bs', b'T05thread:01;')
+        return vm
 
     @staticmethod
     def vm_get_icount(vm):
         return vm.qmp('query-replay')['return']['icount']
 
     def reverse_debugging(self, shift=7, args=None):
-        from avocado.utils import gdb
-        from avocado.utils import process
-
         logger = logging.getLogger('replay')
 
-        # create qcow2 for snapshots
-        logger.info('creating qcow2 image for VM snapshots')
+        # Create qcow2 for snapshots
+        logger.info('Creating qcow2 image for VM snapshots')
         image_path = os.path.join(self.workdir, 'disk.qcow2')
         qemu_img = get_qemu_img(self)
         if qemu_img is None:
             self.skipTest('Could not find "qemu-img", which is required to '
                           'create the temporary qcow2 image')
         cmd = '%s create -f qcow2 %s 128M' % (qemu_img, image_path)
-        process.run(cmd)
+        r = subprocess.run(cmd, capture_output=True, shell=True, text=True)
+        logger.info(r.args)
+        logger.info(r.stdout)
 
         replay_path = os.path.join(self.workdir, 'replay.bin')
 
-        # record the log
+        # Record the log.
         vm = self.run_vm(True, shift, args, replay_path, image_path, -1)
         while self.vm_get_icount(vm) <= self.STEPS:
             pass
         last_icount = self.vm_get_icount(vm)
         vm.shutdown()
 
-        logger.info("recorded log with %s+ steps" % last_icount)
+        logger.info("Recorded log with %s+ steps" % last_icount)
+
+        # Replay and run debug commands.
+        gdb_cmd = os.getenv('QEMU_TEST_GDB')
+        if not gdb_cmd:
+            test.skipTest(f"Test skipped because there is no GDB available!")
 
-        # replay and run debug commands
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
-            self.fail('Reverse step is not supported by QEMU')
-        if b'ReverseContinue+' not in r:
-            self.fail('Reverse continue is not supported by QEMU')
-
-        logger.info('stepping forward')
-        steps = []
-        # record first instruction addresses
-        for _ in range(self.STEPS):
-            pc = self.get_pc(g)
-            logger.info('saving position %x' % pc)
-            steps.append(pc)
-            self.gdb_step(g)
-
-        # visit the recorded instruction in reverse order
-        logger.info('stepping backward')
-        for addr in steps[::-1]:
-            self.gdb_bstep(g)
-            self.check_pc(g, addr)
-            logger.info('found position %x' % addr)
-
-        # visit the recorded instruction in forward order
-        logger.info('stepping forward')
-        for addr in steps:
-            self.check_pc(g, addr)
-            self.gdb_step(g)
-            logger.info('found position %x' % addr)
-
-        # set breakpoints for the instructions just stepped over
-        logger.info('setting breakpoints')
-        for addr in steps:
-            # hardware breakpoint at addr with len=1
-            g.cmd(b'Z1,%x,1' % addr, b'OK')
-
-        # this may hit a breakpoint if first instructions are executed
-        # again
-        logger.info('continuing execution')
-        vm.qmp('replay-break', icount=last_icount - 1)
-        # continue - will return after pausing
-        # This could stop at the end and get a T02 return, or by
-        # re-executing one of the breakpoints and get a T05 return.
-        g.cmd(b'c')
-        if self.vm_get_icount(vm) == last_icount - 1:
-            logger.info('reached the end (icount %s)' % (last_icount - 1))
-        else:
-            logger.info('hit a breakpoint again at %x (icount %s)' %
-                        (self.get_pc(g), self.vm_get_icount(vm)))
 
-        logger.info('running reverse continue to reach %x' % steps[-1])
-        # reverse continue - will return after stopping at the breakpoint
-        g.cmd(b'bc', b'T05thread:01;')
+        try:
+            gdb = GDB(gdb_cmd)
 
-        # assume that none of the first instructions is executed again
-        # breaking the order of the breakpoints
-        self.check_pc(g, steps[-1])
-        logger.info('successfully reached %x' % steps[-1])
+            logger.info('Connecting to gdbstub...')
 
-        logger.info('exiting gdb and qemu')
-        vm.shutdown()
+            gdb.cli("set debug remote 1")
+
+            c = gdb.cli(f"target remote localhost:{port}").get_console()
+            if not f"Remote debugging using localhost:{port}" in c:
+                self.fail("Could not connect to gdbstub!")
+
+            # Remote debug messages are in 'log' payloads.
+            r = gdb.get_log()
+            if 'ReverseStep+' not in r:
+                self.fail('Reverse step is not supported by QEMU')
+            if 'ReverseContinue+' not in r:
+                self.fail('Reverse continue is not supported by QEMU')
+
+            gdb.cli("set debug remote 0")
+
+            logger.info('Stepping forward')
+            steps = []
+            # Record first instruction addresses.
+            for _ in range(self.STEPS):
+                pc = gdb.cli("print $pc").get_addr()
+                logger.info('Saving position %x' % pc)
+                steps.append(pc)
+
+                gdb.cli("stepi")
+
+            # Visit the recorded instructions in reverse order.
+            logger.info('Stepping backward')
+            for saved_pc in steps[::-1]:
+                logger.info('Found position %x' % saved_pc)
+                gdb.cli("reverse-stepi")
+                pc = gdb.cli("print $pc").get_addr()
+                if pc != saved_pc:
+                    logger.info('Invalid PC (read %x instead of %x)' % (pc, saved_pc))
+                    self.fail('Reverse stepping failed!')
+
+            # Visit the recorded instructions in forward order.
+            logger.info('Stepping forward')
+            for saved_pc in steps:
+                logger.info('Found position %x' % saved_pc)
+                pc = gdb.cli("print $pc").get_addr()
+                if pc != saved_pc:
+                    logger.info('Invalid PC (read %x instead of %x)' % (pc, saved_pc))
+                    self.fail('Forward stepping failed!')
+
+                gdb.cli("stepi")
+
+            # Set breakpoints for the instructions just stepped over.
+            logger.info('Setting breakpoints')
+            for saved_pc in steps:
+                gdb.cli(f"break *{hex(saved_pc)}")
+
+            # This may hit a breakpoint if first instructions are executed again.
+            logger.info('Continuing execution')
+            vm.qmp('replay-break', icount=last_icount - 1)
+            # continue - will return after pausing.
+            # This can stop at the end of the replay-break and gdb gets a SIGINT,
+            # or by re-executing one of the breakpoints and gdb stops at a
+            # breakpoint.
+            gdb.cli("continue")
+
+            pc = gdb.cli("print $pc").get_addr()
+            current_icount = self.vm_get_icount(vm)
+            if current_icount == last_icount - 1:
+                print(f"# **** Hit replay-break at icount={current_icount}, pc={hex(pc)} ****")
+                logger.info('Reached the end (icount %s)' % (current_icount))
+            else:
+                print(f"# **** Hit breakpoint at icount={current_icount}, pc={hex(pc)} ****")
+                logger.info('Hit a breakpoint again at %x (icount %s)' %
+                            (pc, current_icount))
+
+            logger.info('Running reverse continue to reach %x' % steps[-1])
+            # reverse-continue - will return after stopping at the breakpoint.
+            gdb.cli("reverse-continue")
+
+            # Assume that none of the first instructions are executed again
+            # breaking the order of the breakpoints.
+            # steps[-1] is the first saved $pc in reverse order.
+            pc = gdb.cli("print $pc").get_addr()
+            first_pc_in_rev_order = steps[-1]
+            if pc == first_pc_in_rev_order:
+                print(f"# **** Hit breakpoint at the first PC in reverse order ({hex(pc)}) ****")
+                logger.info('Successfully reached breakpoint at %x' % first_pc_in_rev_order)
+            else:
+                logger.info('Failed to reach breakpoint at %x' % first_pc_in_rev_order)
+                self.fail("'reverse-continue' did not hit the first PC in reverse order!")
+
+            logger.info('Exiting GDB and QEMU...')
+            gdb.exit()
+            vm.shutdown()
+
+            logger.info('Test passed.')
+
+        except GdbTimeoutError:
+            self.fail("Connection to gdbstub timeouted...")
-- 
2.34.1


