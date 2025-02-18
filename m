Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25067C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPYQ-0002VH-BJ; Tue, 18 Feb 2025 10:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPWa-0008Ha-DS
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPWV-0008JE-UB
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739892515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ICHhKhiYbxESBHKgCxX68O2/8O1L9GogX/4hpil68Nc=;
 b=D6/dPxZ5fHVBJhQFcOLLwumI9wX7gd6tkvDXr86agQCz1B6ABkfmmZVvFZ8OlWowqpkUcS
 fwZ+cjyEHgPo+RTN5+dMeWlZD+65oQTnvWWRrEL4dnTF1jR7Vnz0/detQ7DPPj6bcp2w1M
 aDycXce0hLAI3QfP9208+ZA0LaGETyI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-wi2ZP_6yOCi_y1do961cQQ-1; Tue,
 18 Feb 2025 10:28:30 -0500
X-MC-Unique: wi2ZP_6yOCi_y1do961cQQ-1
X-Mimecast-MFC-AGG-ID: wi2ZP_6yOCi_y1do961cQQ_1739892509
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B36119030A9; Tue, 18 Feb 2025 15:28:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 264A1180035F; Tue, 18 Feb 2025 15:28:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 14/14] tests/functional: Convert the i386 replay avocado test
Date: Tue, 18 Feb 2025 16:27:44 +0100
Message-ID: <20250218152744.228335-15-thuth@redhat.com>
In-Reply-To: <20250218152744.228335-1-thuth@redhat.com>
References: <20250218152744.228335-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since this was the last test in tests/avocado/replay_kernel.py,
we can remove that Avocado file now.

Signed-off-by: Thomas Huth <thuth@redhat.com
---
 tests/avocado/replay_kernel.py       | 110 ---------------------------
 tests/functional/meson.build         |   1 +
 tests/functional/test_i386_replay.py |  28 +++++++
 3 files changed, 29 insertions(+), 110 deletions(-)
 delete mode 100644 tests/avocado/replay_kernel.py
 create mode 100755 tests/functional/test_i386_replay.py

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
index 3054aa18570..d496bbe935b 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -141,6 +141,7 @@ tests_i386_system_quick = [
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
2.48.1


