Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F8FCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66In-0002l0-GB; Tue, 07 Oct 2025 07:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IP-0002Xg-U2
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IC-0001K7-Pd
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso47600075e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838140; x=1760442940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWo3F9qbNdVHRw5wwFFktfT+k9Kv5ZvybIwCsmnf6YU=;
 b=eVMJG7IwmG6h8PNTwUIeZPAHqesvttBadi2OCOpItdtA673L83mUv1PJYovRcz2hBv
 QyTMW2tEfsaSI01PwL+Oubis+YaeeQTO+9q1GVRim6FJIqFoiuS/LNQFZmmOupzAZ0kA
 dxW3rxtxCX1fR+K9FJgPYSupV0+V9DZocc8dRXmZW0tUlkC4bZdj/liIuFR1+AChZEId
 WJ7zOG3IM5B8ucIGZcvz7w4AA40Q456oh73ztpCuPWoCnwRtDc0SOt+fgSk+bNNf0S1g
 BGfpzeoeY5BBPccjzx+zcKFBxLLsHUlltDbHO6kUuoIyxa6YFNXZ4PxblPfeoMGmBeYL
 9C1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838140; x=1760442940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWo3F9qbNdVHRw5wwFFktfT+k9Kv5ZvybIwCsmnf6YU=;
 b=n8ywBdLz40NuxQvboTsJ1UqKAlpbf6JuySJfAyMwwL5YwDzrCkXUV4lkVH6PlDnrlw
 9rSKmiFwaxCe7y0p4zEu/lydh/Z6prMENfYqdsjf3vsjsVVEhZOiG+0YzjFdCV8x8Amp
 20pijj3qdoWu0ZXgaG33+XkVaQKMbym+EPddqS4LtF4oEkpp7/78XcNmmsN4yy9BN0Bw
 rI1r/LFtxLUuvhMQhxklLZFccOjAA3zEdmMMihVfabq4j7whD0rbXchwqY5/AtXtSt2l
 UvU58o6P+YNp8WnUtX9Vs9DINPgXoPgHx1K8GknsvGer0AMBnh4hUaTpORg+w7/ePCsa
 KAcA==
X-Gm-Message-State: AOJu0YzUnEZL8yw4Dzf8Im4oqwM2jM2YK5H0VZOKDRB0ZoQbSkWSCvdf
 WzYxBQHwvAwsJeROOtUxDBGBYZhLcoouzh/zd3R9mIPVkee30KIUET96qFIg1vD1RV0=
X-Gm-Gg: ASbGnctN7SO+9HcZfRVsawJFoUdA+Fh4aAGdru6qH5Kqwpm3loeObJMVBvvLv0fjs+n
 QWxLAR0g/pXUTO5hlOmQBDtFO6mYZMJNeY2Tjl6QSYOZPVLWQel/7j2MmgilIjuD/PhZrEWmK6o
 Fyx2RSGgfUJ2F/6I3VP0jU3qbsOmbEopmsRA9ImVGgT1D+J5aWDRKblHAPcK2xxwgHFQkOWJM6+
 GDp9H+HDnuSe2BpwlGExii83Em5nOqOGJJoZspUfcHDzEUQT3h+XkXW73TDDmpaZ+efH583A5Ls
 Qd6Ml4mNXkZKKb7I5U8LbUdAQ2hma9f5YvLowdrKR8ke2jPICrVRPLTz+pGB2Ba7OXKJzS487qw
 iKRdecwk71QIIk6EEg+lJ8yjBSLCiAs6Do07Yiq1AkEA7UxkID3k=
X-Google-Smtp-Source: AGHT+IFqbBi+IEu7ifonH6dU3O4DeIT5cvCnO6KSCxy97wZA6VjjQLvUNyi31X99Gp/tcW+3ymVsEA==
X-Received: by 2002:a05:600d:41d3:b0:46c:d476:52f3 with SMTP id
 5b1f17b1804b1-46e71152676mr102531195e9.26.1759838139883; 
 Tue, 07 Oct 2025 04:55:39 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723591fcsm201853815e9.10.2025.10.07.04.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4A2E360585;
 Tue, 07 Oct 2025 12:55:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 15/17] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
Date: Tue,  7 Oct 2025 12:55:23 +0100
Message-ID: <20251007115525.1998643-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

This commit removes Avocado as a dependency for running the
reverse_debugging test.

The main benefit, beyond eliminating an extra dependency, is that there
is no longer any need to handle GDB packets manually. This removes the
need for ad-hoc functions dealing with endianness and arch-specific
register numbers, making the test easier to read. The timeout variable
is also removed, since Meson now manages timeouts automatically.

reverse_debugging now uses the pygdbmi module to interact with GDB, if
it is available in the test environment, otherwise the test is skipped.
GDB is detect via the QEMU_TEST_GDB env. variable.

This commit also significantly improves the output for the test and
now prints all the GDB commands used in sequence. It also adds
some clarifications to existing comments, for example, clarifying that
once the replay-break is reached, a SIGINT is captured in GDB.

reverse_debugging is kept "skipped" for aarch64, ppc64, and x86_64, so
won't run unless QEMU_TEST_FLAKY_TESTS=1 is set in the test environment,
before running 'make check-functional' or 'meson test [...]'.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20251003141820.85278-9-gustavo.romero@linaro.org>
[AJB: it is and broke long line]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index 7fd8c7607f5..68cfcb39856 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -1,19 +1,23 @@
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
 from subprocess import check_output
 
-from qemu_test import LinuxKernelTest, get_qemu_img
+from qemu_test import LinuxKernelTest, get_qemu_img, GDB, \
+    skipIfMissingEnv, skipIfMissingImports
 from qemu_test.ports import Ports
 
 
@@ -29,9 +33,7 @@ class ReverseDebugging(LinuxKernelTest):
     that the execution is stopped at the last of them.
     """
 
-    timeout = 10
     STEPS = 10
-    endian_is_le = True
 
     def run_vm(self, record, shift, args, replay_path, image_path, port):
         logger = logging.getLogger('replay')
@@ -54,47 +56,17 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
         return vm
 
     @staticmethod
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
+    def get_pc(gdb: GDB):
+        return gdb.cli("print $pc").get_addr()
 
     @staticmethod
     def vm_get_icount(vm):
         return vm.qmp('query-replay')['return']['icount']
 
-    def reverse_debugging(self, shift=7, args=None):
-        from avocado.utils import gdb
+    @skipIfMissingImports("pygdbmi") # Required by GDB class
+    @skipIfMissingEnv("QEMU_TEST_GDB")
+    def reverse_debugging(self, gdb_arch, shift=7, args=None):
+        from qemu_test import GDB
 
         logger = logging.getLogger('replay')
 
@@ -124,68 +96,107 @@ def reverse_debugging(self, shift=7, args=None):
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
+
+        try:
+            logger.info('Connecting to gdbstub...')
+            self.reverse_debugging_run(vm, port, gdb_arch, last_icount)
+            logger.info('Test passed.')
+        except GDB.TimeoutError:
+            # Convert a GDB timeout exception into a unittest failure exception.
+            raise self.failureException("Timeout while connecting to or "
+                                        "communicating with gdbstub...") from None
+        except Exception:
+            # Re-throw exceptions from unittest, like the ones caused by fail(),
+            # skipTest(), etc.
+            raise
+
+    def reverse_debugging_run(self, vm, port, gdb_arch, last_icount):
+        logger = logging.getLogger('replay')
+
+        gdb_cmd = os.getenv('QEMU_TEST_GDB')
+        gdb = GDB(gdb_cmd)
+
+        r = gdb.cli("set architecture").get_log()
+        if gdb_arch not in r:
+            self.skipTest(f"GDB does not support arch '{gdb_arch}'")
+
+        gdb.cli("set debug remote 1")
+
+        c = gdb.cli(f"target remote localhost:{port}").get_console()
+        if not f"Remote debugging using localhost:{port}" in c:
+            self.fail("Could not connect to gdbstub!")
+
+        # Remote debug messages are in 'log' payloads.
+        r = gdb.get_log()
+        if 'ReverseStep+' not in r:
             self.fail('Reverse step is not supported by QEMU')
-        if b'ReverseContinue+' not in r:
+        if 'ReverseContinue+' not in r:
             self.fail('Reverse continue is not supported by QEMU')
 
+        gdb.cli("set debug remote 0")
+
         logger.info('stepping forward')
         steps = []
         # record first instruction addresses
         for _ in range(self.STEPS):
-            pc = self.get_pc(g)
+            pc = self.get_pc(gdb)
             logger.info('saving position %x' % pc)
             steps.append(pc)
-            self.gdb_step(g)
+            gdb.cli("stepi")
 
         # visit the recorded instruction in reverse order
         logger.info('stepping backward')
         for addr in steps[::-1]:
-            self.gdb_bstep(g)
-            self.check_pc(g, addr)
             logger.info('found position %x' % addr)
+            gdb.cli("reverse-stepi")
+            pc = self.get_pc(gdb)
+            if pc != addr:
+                logger.info('Invalid PC (read %x instead of %x)' % (pc, addr))
+                self.fail('Reverse stepping failed!')
 
         # visit the recorded instruction in forward order
         logger.info('stepping forward')
         for addr in steps:
-            self.check_pc(g, addr)
-            self.gdb_step(g)
             logger.info('found position %x' % addr)
+            pc = self.get_pc(gdb)
+            if pc != addr:
+                logger.info('Invalid PC (read %x instead of %x)' % (pc, addr))
+                self.fail('Forward stepping failed!')
+            gdb.cli("stepi")
 
         # set breakpoints for the instructions just stepped over
         logger.info('setting breakpoints')
         for addr in steps:
-            # hardware breakpoint at addr with len=1
-            g.cmd(b'Z1,%x,1' % addr, b'OK')
+            gdb.cli(f"break *{hex(addr)}")
 
         # this may hit a breakpoint if first instructions are executed
         # again
         logger.info('continuing execution')
         vm.qmp('replay-break', icount=last_icount - 1)
         # continue - will return after pausing
-        # This could stop at the end and get a T02 return, or by
-        # re-executing one of the breakpoints and get a T05 return.
-        g.cmd(b'c')
+        # This can stop at the end of the replay-break and gdb gets a SIGINT,
+        # or by re-executing one of the breakpoints and gdb stops at a
+        # breakpoint.
+        gdb.cli("continue")
+
         if self.vm_get_icount(vm) == last_icount - 1:
             logger.info('reached the end (icount %s)' % (last_icount - 1))
         else:
             logger.info('hit a breakpoint again at %x (icount %s)' %
-                        (self.get_pc(g), self.vm_get_icount(vm)))
+                        (self.get_pc(gdb), self.vm_get_icount(vm)))
 
         logger.info('running reverse continue to reach %x' % steps[-1])
         # reverse continue - will return after stopping at the breakpoint
-        g.cmd(b'bc', b'T05thread:01;')
+        gdb.cli("reverse-continue")
 
         # assume that none of the first instructions is executed again
         # breaking the order of the breakpoints
-        self.check_pc(g, steps[-1])
+        pc = self.get_pc(gdb)
+        if pc != steps[-1]:
+            self.fail("'reverse-continue' did not hit the first PC in reverse order!")
+
         logger.info('successfully reached %x' % steps[-1])
 
         logger.info('exiting gdb and qemu')
+        gdb.exit()
         vm.shutdown()
-- 
2.47.3


