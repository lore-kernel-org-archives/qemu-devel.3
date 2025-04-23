Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36962C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7UfN-0003IL-28; Wed, 23 Apr 2025 03:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uf7-0003D8-C6
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uf3-0003Fl-Hh
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XuYsJZmAHSsf0fka7NTw+O2fem47q2v31G+goYFFUD8=;
 b=H6ElPiUyVq1Gf4rFwn5CsLtI1IApYvP1zNh5l7wweUcnwOV0OlP4gOI6Z9Hws0L+rtEQrZ
 OOP1pzyfvm1xnzDm+GdiMVvRjNYk9jENUzcKH4Y+sWLvmj0ZwQKKuYFTb0l/5prLw8h76v
 VoTUNVfRxIiGlahp2xkSTCLvLq1qsbc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-NW9VvMEFO5imdiiuKPIKiw-1; Wed,
 23 Apr 2025 03:36:44 -0400
X-MC-Unique: NW9VvMEFO5imdiiuKPIKiw-1
X-Mimecast-MFC-AGG-ID: NW9VvMEFO5imdiiuKPIKiw_1745393803
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4411D1800983; Wed, 23 Apr 2025 07:36:43 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB2F019560A3; Wed, 23 Apr 2025 07:36:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 12/29] tests/functional: Move the check for the parameters from
 avocado to functional
Date: Wed, 23 Apr 2025 09:35:52 +0200
Message-ID: <20250423073610.271585-13-thuth@redhat.com>
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

test_x86_64_pc in tests/avocado/boot_linux_console.py only checks
whether the kernel parameters have correctly been passed to the
kernel in the guest by looking for them in the console output of the
guest. Let's move that to the functional test framework now, but
instead of doing it in a separate test, let's do it for all tuxrun
tests instead, so it is done automatically for all targets that have
a tuxrun test.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250414113031.151105-3-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/boot_linux_console.py      | 34 ------------------------
 tests/functional/qemu_test/tuxruntest.py |  9 ++++---
 2 files changed, 5 insertions(+), 38 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index c15f39ae1f3..cbb1e2fb506 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -9,17 +9,9 @@
 # later.  See the COPYING file in the top-level directory.
 
 import os
-import lzma
-import gzip
 import shutil
 
-from avocado import skip
-from avocado import skipUnless
-from avocado import skipUnless
 from avocado_qemu import QemuSystemTest
-from avocado_qemu import exec_command
-from avocado_qemu import exec_command_and_wait_for_pattern
-from avocado_qemu import interrupt_interactive_console_until_pattern
 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import process
 from avocado.utils import archive
@@ -68,29 +60,3 @@ def extract_from_rpm(self, rpm, path):
         process.run("rpm2cpio %s | cpio -id %s" % (rpm, path), shell=True)
         os.chdir(cwd)
         return os.path.normpath(os.path.join(self.workdir, path))
-
-class BootLinuxConsole(LinuxKernelTest):
-    """
-    Boots a Linux kernel and checks that the console is operational and the
-    kernel command line is properly passed from QEMU to the kernel
-    """
-    timeout = 90
-
-    def test_x86_64_pc(self):
-        """
-        :avocado: tags=arch:x86_64
-        :avocado: tags=machine:pc
-        """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
-                      '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
-                      '/vmlinuz')
-        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        self.vm.add_args('-kernel', kernel_path,
-                         '-append', kernel_command_line)
-        self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index ad74156f9c5..c2bd5baaae9 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -77,12 +77,12 @@ def prepare_run(self, kernel, disk, drive, dtb=None, console_index=0):
         blockdev = "driver=raw,file.driver=file," \
             + f"file.filename={disk},node-name=hd0"
 
-        kcmd_line = self.KERNEL_COMMON_COMMAND_LINE
-        kcmd_line += f" root=/dev/{self.root}"
-        kcmd_line += f" console={self.console}"
+        self.kcmd_line = self.KERNEL_COMMON_COMMAND_LINE
+        self.kcmd_line += f" root=/dev/{self.root}"
+        self.kcmd_line += f" console={self.console}"
 
         self.vm.add_args('-kernel', kernel,
-                         '-append', kcmd_line,
+                         '-append', self.kcmd_line,
                          '-blockdev', blockdev)
 
         # Sometimes we need extra devices attached
@@ -103,6 +103,7 @@ def run_tuxtest_tests(self, haltmsg):
         wait to exit cleanly.
         """
         ps1='root@tuxtest:~#'
+        self.wait_for_console_pattern(self.kcmd_line)
         self.wait_for_console_pattern('tuxtest login:')
         exec_command_and_wait_for_pattern(self, 'root', ps1)
         exec_command_and_wait_for_pattern(self, 'cat /proc/interrupts', ps1)
-- 
2.49.0


