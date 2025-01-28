Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852CEC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 15:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcnWd-0002LZ-Rg; Tue, 28 Jan 2025 10:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcnWc-0002L9-B2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:29:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcnWa-0004wR-Ns
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738078152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mAQDM6qHfX2kRPn8z9DWXC7M3EqrDePFHHJ6Wk42zM4=;
 b=Ccq2h9qvb9hIUM71TCUTd2zdKZi5hrYb0NpOgBAa7tQjR6dFijTor1ijbt9PybKc1n44pX
 HDGuJGyBLsmXgTUwEy96ugCd4ciqeFMLGrwtbWvNd9oAEYkbbv+lbduEFj2wGEVe0kSV87
 S3t3dT7S1TnHtZggyAwijYxHhijwghw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-b9ownlZcMQK_Ioet83deuw-1; Tue,
 28 Jan 2025 10:29:03 -0500
X-MC-Unique: b9ownlZcMQK_Ioet83deuw-1
X-Mimecast-MFC-AGG-ID: b9ownlZcMQK_Ioet83deuw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E4B21802ABD; Tue, 28 Jan 2025 15:28:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77E2D18088AA; Tue, 28 Jan 2025 15:28:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/5] tests/functional: Add the ReplayKernelBase class
Date: Tue, 28 Jan 2025 16:28:36 +0100
Message-ID: <20250128152839.184599-3-thuth@redhat.com>
In-Reply-To: <20250128152839.184599-1-thuth@redhat.com>
References: <20250128152839.184599-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Copy the ReplayKernelBase class from the avocado tests. We are going
to need it to convert the related replay tests in the following patches.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                       |  1 +
 tests/functional/replay_kernel.py | 84 +++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 tests/functional/replay_kernel.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b4d84bf5f..414b6f35fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3632,6 +3632,7 @@ F: stubs/replay.c
 F: tests/avocado/replay_kernel.py
 F: tests/avocado/replay_linux.py
 F: tests/avocado/reverse_debugging.py
+F: tests/functional/*replay*.py
 F: qapi/replay.json
 
 IOVA Tree
diff --git a/tests/functional/replay_kernel.py b/tests/functional/replay_kernel.py
new file mode 100644
index 0000000000..8e8ac7d052
--- /dev/null
+++ b/tests/functional/replay_kernel.py
@@ -0,0 +1,84 @@
+# Record/replay test that boots a Linux kernel
+#
+# Copyright (c) 2020 ISP RAS
+#
+# Author:
+#  Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+import logging
+import time
+import subprocess
+
+from qemu_test.linuxkernel import LinuxKernelTest
+
+class ReplayKernelBase(LinuxKernelTest):
+    """
+    Boots a Linux kernel in record mode and checks that the console
+    is operational and the kernel command line is properly passed
+    from QEMU to the kernel.
+    Then replays the same scenario and verifies, that QEMU correctly
+    terminates.
+    """
+
+    timeout = 180
+    REPLAY_KERNEL_COMMAND_LINE = 'printk.time=1 panic=-1 '
+
+    def run_vm(self, kernel_path, kernel_command_line, console_pattern,
+               record, shift, args, replay_path):
+        # icount requires TCG to be available
+        self.require_accelerator('tcg')
+
+        logger = logging.getLogger('replay')
+        start_time = time.time()
+        vm = self.get_vm()
+        vm.set_console()
+        if record:
+            logger.info('recording the execution...')
+            mode = 'record'
+        else:
+            logger.info('replaying the execution...')
+            mode = 'replay'
+        vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s' %
+                    (shift, mode, replay_path),
+                    '-kernel', kernel_path,
+                    '-append', kernel_command_line,
+                    '-net', 'none',
+                    '-no-reboot')
+        if args:
+            vm.add_args(*args)
+        vm.launch()
+        self.wait_for_console_pattern(console_pattern, vm)
+        if record:
+            vm.shutdown()
+            logger.info('finished the recording with log size %s bytes'
+                        % os.path.getsize(replay_path))
+            self.run_replay_dump(replay_path)
+            logger.info('successfully tested replay-dump.py')
+        else:
+            vm.wait()
+            logger.info('successfully finished the replay')
+        elapsed = time.time() - start_time
+        logger.info('elapsed time %.2f sec' % elapsed)
+        return elapsed
+
+    def run_replay_dump(self, replay_path):
+        try:
+            subprocess.check_call(["./scripts/replay-dump.py",
+                                   "-f", replay_path],
+                                  stdout=subprocess.DEVNULL)
+        except subprocess.CalledProcessError:
+            self.fail('replay-dump.py failed')
+
+    def run_rr(self, kernel_path, kernel_command_line, console_pattern,
+               shift=7, args=None):
+        replay_path = os.path.join(self.workdir, 'replay.bin')
+        t1 = self.run_vm(kernel_path, kernel_command_line, console_pattern,
+                         True, shift, args, replay_path)
+        t2 = self.run_vm(kernel_path, kernel_command_line, console_pattern,
+                         False, shift, args, replay_path)
+        logger = logging.getLogger('replay')
+        logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
-- 
2.48.1


