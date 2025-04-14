Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E553DC369B5
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 11:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4I1z-0003YI-CK; Mon, 14 Apr 2025 07:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4I1a-0003UE-Ky
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 07:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4I1Y-0003u2-89
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 07:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744630247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFT2WxGEQfpsHO7alU6ylF9NtWckt/VI7w+fHgt2l7w=;
 b=SCqtfE4wXGXc8S3NfU5zswWUZhmwxlf2SwJBpdGo8Ob2K6TeaYUUpOprWw5v3s2GVoq8Xe
 CCmuGaQqUZuUaIanKixW5ZHgsOjNNwhS3M0p2JLQl1LdSStMwjAxuz4zCzBNJ/WCn0ch1G
 9TwYm51836evkF5GdqwcdTlUsCETOls=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-gZSVycs5P7SJiiEix8Ef3g-1; Mon,
 14 Apr 2025 07:30:44 -0400
X-MC-Unique: gZSVycs5P7SJiiEix8Ef3g-1
X-Mimecast-MFC-AGG-ID: gZSVycs5P7SJiiEix8Ef3g_1744630241
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2E651956048; Mon, 14 Apr 2025 11:30:41 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E0FE1956094; Mon, 14 Apr 2025 11:30:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH v2 04/15] tests/functional: Convert the i386 replay avocado
 test
Date: Mon, 14 Apr 2025 13:30:18 +0200
Message-ID: <20250414113031.151105-5-thuth@redhat.com>
In-Reply-To: <20250414113031.151105-1-thuth@redhat.com>
References: <20250414113031.151105-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Since this was the last test in tests/avocado/replay_kernel.py,
we can remove that Avocado file now.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com
---
 MAINTAINERS                          |   1 -
 tests/avocado/replay_kernel.py       | 110 ---------------------------
 tests/functional/meson.build         |   1 +
 tests/functional/test_i386_replay.py |  28 +++++++
 4 files changed, 29 insertions(+), 111 deletions(-)
 delete mode 100644 tests/avocado/replay_kernel.py
 create mode 100755 tests/functional/test_i386_replay.py

diff --git a/MAINTAINERS b/MAINTAINERS
index af1d847f8ed..42348df9d68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3669,7 +3669,6 @@ F: include/system/replay.h
 F: docs/devel/replay.rst
 F: docs/system/replay.rst
 F: stubs/replay.c
-F: tests/avocado/replay_kernel.py
 F: tests/avocado/replay_linux.py
 F: tests/functional/*reverse_debug*.py
 F: tests/functional/*replay*.py
diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
deleted file mode 100644
index 35515323723..00000000000
--- a/tests/avocado/replay_kernel.py
+++ /dev/null
@@ -1,110 +0,0 @@
-# Record/replay test that boots a Linux kernel
-#
-# Copyright (c) 2020 ISP RAS
-#
-# Author:
-#  Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-import os
-import lzma
-import shutil
-import logging
-import time
-import subprocess
-
-from avocado import skip
-from avocado import skipUnless
-from avocado import skipUnless
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import archive
-from avocado.utils import process
-from boot_linux_console import LinuxKernelTest
-
-class ReplayKernelBase(LinuxKernelTest):
-    """
-    Boots a Linux kernel in record mode and checks that the console
-    is operational and the kernel command line is properly passed
-    from QEMU to the kernel.
-    Then replays the same scenario and verifies, that QEMU correctly
-    terminates.
-    """
-
-    timeout = 180
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=1 panic=-1 '
-
-    def run_vm(self, kernel_path, kernel_command_line, console_pattern,
-               record, shift, args, replay_path):
-        # icount requires TCG to be available
-        self.require_accelerator('tcg')
-
-        logger = logging.getLogger('replay')
-        start_time = time.time()
-        vm = self.get_vm()
-        vm.set_console()
-        if record:
-            logger.info('recording the execution...')
-            mode = 'record'
-        else:
-            logger.info('replaying the execution...')
-            mode = 'replay'
-        vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s' %
-                    (shift, mode, replay_path),
-                    '-kernel', kernel_path,
-                    '-append', kernel_command_line,
-                    '-net', 'none',
-                    '-no-reboot')
-        if args:
-            vm.add_args(*args)
-        vm.launch()
-        self.wait_for_console_pattern(console_pattern, vm)
-        if record:
-            vm.shutdown()
-            logger.info('finished the recording with log size %s bytes'
-                        % os.path.getsize(replay_path))
-            self.run_replay_dump(replay_path)
-            logger.info('successfully tested replay-dump.py')
-        else:
-            vm.wait()
-            logger.info('successfully finished the replay')
-        elapsed = time.time() - start_time
-        logger.info('elapsed time %.2f sec' % elapsed)
-        return elapsed
-
-    def run_replay_dump(self, replay_path):
-        try:
-            subprocess.check_call(["./scripts/replay-dump.py",
-                                   "-f", replay_path],
-                                  stdout=subprocess.DEVNULL)
-        except subprocess.CalledProcessError:
-            self.fail('replay-dump.py failed')
-
-    def run_rr(self, kernel_path, kernel_command_line, console_pattern,
-               shift=7, args=None):
-        replay_path = os.path.join(self.workdir, 'replay.bin')
-        t1 = self.run_vm(kernel_path, kernel_command_line, console_pattern,
-                         True, shift, args, replay_path)
-        t2 = self.run_vm(kernel_path, kernel_command_line, console_pattern,
-                         False, shift, args, replay_path)
-        logger = logging.getLogger('replay')
-        logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
-
-class ReplayKernelNormal(ReplayKernelBase):
-
-    def test_i386_pc(self):
-        """
-        :avocado: tags=arch:i386
-        :avocado: tags=machine:pc
-        """
-        kernel_url = ('https://storage.tuxboot.com/20230331/i386/bzImage')
-        kernel_hash = 'a3e5b32a354729e65910f5a1ffcda7c14a6c12a55e8213fb86e277f1b76ed956'
-        kernel_path = self.fetch_asset(kernel_url,
-                                       asset_hash=kernel_hash,
-                                       algorithm = "sha256")
-
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        console_pattern = 'VFS: Cannot open root device'
-
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 7b0f4ab0b1d..4113b221de7 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -151,6 +151,7 @@ tests_i386_system_quick = [
 ]
 
 tests_i386_system_thorough = [
+  'i386_replay',
   'i386_tuxrun',
 ]
 
diff --git a/tests/functional/test_i386_replay.py b/tests/functional/test_i386_replay.py
new file mode 100755
index 00000000000..7c4c2602da9
--- /dev/null
+++ b/tests/functional/test_i386_replay.py
@@ -0,0 +1,28 @@
+#!/usr/bin/env python3
+#
+# Replay test that boots a Linux kernel on a i386 machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from replay_kernel import ReplayKernelBase
+
+
+class I386Replay(ReplayKernelBase):
+
+    ASSET_KERNEL = Asset(
+         'https://storage.tuxboot.com/20230331/i386/bzImage',
+        'a3e5b32a354729e65910f5a1ffcda7c14a6c12a55e8213fb86e277f1b76ed956')
+
+    def test_pc(self):
+        self.set_machine('pc')
+        kernel_url = ()
+        kernel_path = self.ASSET_KERNEL.fetch()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        console_pattern = 'VFS: Cannot open root device'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
+
+
+if __name__ == '__main__':
+    ReplayKernelBase.main()
-- 
2.49.0


