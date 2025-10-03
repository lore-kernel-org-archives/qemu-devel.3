Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492BFCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 14:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4gd3-0004Py-N5; Fri, 03 Oct 2025 10:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gd0-0004Pb-MT
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:19:22 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gcY-0000Oe-UR
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:19:22 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-27ee41e0798so33098985ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759501129; x=1760105929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GkmGB0fPzMGy7Tp7qDwLBzDcUa3k6aQq/mGbwNslIs=;
 b=GspJU1tyOxoBIl4WCZM9Es57fR7Q9kIcYtIodZ2ih4Aw+fX3rfPYxHhxw0sbcAOu+c
 F8PR7X/rdDtit/+KsulxylALzhQfyhBk6lG6YyC7JDr0BGq5bebXrPCDm0vEKlHdWmbL
 sTt/G/DokeYrPzaC7FxmHaU1AmmdjcrN1nr3tVubG0x6TTDjNjufZmHKpM5UpO9l3bZT
 OcZ62WB3A3esYBX46F4oSVCb7M5i8+ZAsRxdY+3/9IajK8sXeEZmTygoDIpf/4YPnn7y
 6O93z7IeWd9POE6I8L2f8pXjzNKdvV8FND3oBqGodGFYMgi6b1gCsScjr1amvD05m0iO
 eC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759501129; x=1760105929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GkmGB0fPzMGy7Tp7qDwLBzDcUa3k6aQq/mGbwNslIs=;
 b=qtsykR46Q1/gn3hT0s2F4MwaTOysUQqnY4qKCDY1kLIywFnlM0Msx+6SyKnlgX6O+F
 v5o1IQrfSV5iCdMPDSle6beKt37OwkrBACANnkdesUdEVuSST6YXFiwrtSc0k/BJ+88g
 xv5PpJBnzjslcruBMOoteJDRECNEcpbUcG3VtGr462OtS1k0hrhINV4BPG5nbdBX55/L
 TxZhwTS7HiE8D1sqSkY4b8cLve5NHKTtrk9O2gOu5UK8E71n4di7qIOdN+NmdK2MWicP
 EwFPMVdRxBO8pVvP4jm2uEoTYJZBEBsVYDkjtq7edUKWot0pCq1i30vANuNI1Pqkhlnv
 Zdxw==
X-Gm-Message-State: AOJu0YypVpyJRdeasuSUVuf2VxitweEYGPPynuAL6TFtv71LRlKCY77z
 FlaD+nKULiG5ww8ojh6Gz+FnbHlqfvSEOrNxqNYTcNof1ixGz9vr7yvELvUjmZbWkUM2gx2fuHd
 BzhSO
X-Gm-Gg: ASbGncvaqPnKo8JkIytczsD56JQxj4gq+upk4J9wAGFFJ/1UyCApmB/fo3aPWTtjTr4
 PYKq9Z8zycV9nmlkNz8HlHjdE5luAe1him2IYVq0rpMbif8bmMZ534/r+GuYXvgVp/0REj556is
 j6XJhQNjhC22LgvkiaROzz3OiH61OVMasAvWSfWw2FPBAxLZH8/RJ/2xeIfT6QTrs/Hw/TTdNHW
 OUPxK57pMoI/J/ruk0tSSbEA0m7AVIVUbQ1uK4x8tDuPkQc2R/faPkUWHwIdsyI2BujG4aqatP8
 OFoLJITNSUS+sGghws3cIZkcBiXI6wShX2S5Lwkrgy32UxIIu+fzLWkgoJFqY0VF19P8ylMfFph
 CGeCQrtek/+L2N7QrqujKZmCGBPEgU4UEAMonZ7xrvr3euVhdQhEB+bvh
X-Google-Smtp-Source: AGHT+IGOhsNogcDIS/4nBOvRtYTSV0os6hHLqhmlxsceKS3WLb+HLWJnw+UfjIoGAT/IZAZvcNaENg==
X-Received: by 2002:a17:903:40ce:b0:24e:e5c9:ecfd with SMTP id
 d9443c01a7336-28e9a679fd6mr43518345ad.42.1759501128633; 
 Fri, 03 Oct 2025 07:18:48 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d5635sm51759645ad.102.2025.10.03.07.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 07:18:48 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 8/9] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
Date: Fri,  3 Oct 2025 14:18:19 +0000
Message-Id: <20251003141820.85278-9-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003141820.85278-1-gustavo.romero@linaro.org>
References: <20251003141820.85278-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/reverse_debugging.py | 138 ++++++++++++++------------
 1 file changed, 74 insertions(+), 64 deletions(-)

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index 7fd8c7607f..2a2e51b912 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -1,19 +1,22 @@
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
+from qemu_test import LinuxKernelTest, get_qemu_img, GDB, skipIfMissingEnv, skipIfMissingImports
 from qemu_test.ports import Ports
 
 
@@ -29,9 +32,7 @@ class ReverseDebugging(LinuxKernelTest):
     that the execution is stopped at the last of them.
     """
 
-    timeout = 10
     STEPS = 10
-    endian_is_le = True
 
     def run_vm(self, record, shift, args, replay_path, image_path, port):
         logger = logging.getLogger('replay')
@@ -54,47 +55,17 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
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
 
@@ -124,68 +95,107 @@ def reverse_debugging(self, shift=7, args=None):
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
2.34.1


