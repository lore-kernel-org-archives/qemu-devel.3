Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11ECC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 14:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbKV8-0003wT-Pv; Fri, 24 Jan 2025 09:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tbKTy-0003E2-IR
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:16:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tbKTw-0001K2-Jm
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737728183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3MQUC8M+UPWyZ0gLq5774sk5T198A7r6k+54Ow2oEro=;
 b=VcgTMur7pdRxvRXbDopbdbSdfT8vpCA3lG4yV2XQO7VJt8GIgJZkPXx1UiqDm0pO53XmSr
 jEsrXHaMkW3u40jcC8nSG9FTyHhpEs4FbyYZk64xxlTe8lw9eb7Z3g3eawsZQ+gnrbpNQc
 End+QyvG19MjfA98oY96WP3lqgYP4O8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-6dKKzFwiP0SVuXmuSbv2BA-1; Fri,
 24 Jan 2025 09:16:02 -0500
X-MC-Unique: 6dKKzFwiP0SVuXmuSbv2BA-1
X-Mimecast-MFC-AGG-ID: 6dKKzFwiP0SVuXmuSbv2BA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD2FF1801F18; Fri, 24 Jan 2025 14:15:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.187])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E84E619560A7; Fri, 24 Jan 2025 14:15:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 5/5] tests/functional/test_mips_malta: Convert the mips big
 endian replay tests
Date: Fri, 24 Jan 2025 15:15:29 +0100
Message-ID: <20250124141529.1626877-6-thuth@redhat.com>
In-Reply-To: <20250124141529.1626877-1-thuth@redhat.com>
References: <20250124141529.1626877-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Move the mips big endian replay tests from tests/avocado/replay_kernel.py
to the functional framework. Since the functional tests should be run per
target, we cannot stick all replay tests in one file. Thus let's add
these tests to the file where we already use the same asset already.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/replay_kernel.py      | 54 -----------------------------
 tests/functional/test_mips_malta.py | 29 ++++++++++++++--
 2 files changed, 26 insertions(+), 57 deletions(-)

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index a45881b9a6..b9b54a8793 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -144,24 +144,6 @@ def test_x86_64_q35(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
-    def test_mips_malta(self):
-        """
-        :avocado: tags=arch:mips
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:big
-        """
-        deb_url = ('http://snapshot.debian.org/archive/debian/'
-                   '20130217T032700Z/pool/main/l/linux-2.6/'
-                   'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb')
-        deb_hash = 'a8cfc28ad8f45f54811fc6cf74fc43ffcfe0ba04'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-2.6.32-5-4kc-malta')
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
-
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
@@ -428,39 +410,3 @@ def test_xtensa_lx60(self):
                    '/qac-best-of-multiarch/download/day02.tar.xz')
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'santas-sleigh-ride.elf')
-
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-class ReplayKernelSlow(ReplayKernelBase):
-    # Override the timeout, because this kernel includes an inner
-    # loop which is executed with TB recompilings during replay,
-    # making it very slow.
-    timeout = 180
-
-    def test_mips_malta_cpio(self):
-        """
-        :avocado: tags=arch:mips
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:big
-        :avocado: tags=slowness:high
-        """
-        deb_url = ('http://snapshot.debian.org/archive/debian/'
-                   '20160601T041800Z/pool/main/l/linux/'
-                   'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb')
-        deb_hash = 'a3c84f3e88b54e06107d65a410d1d1e8e0f340f8'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-4.5.0-2-4kc-malta')
-        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
-                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
-                      'mips/rootfs.cpio.gz')
-        initrd_hash = 'bf806e17009360a866bf537f6de66590de349a99'
-        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
-        initrd_path = self.workdir + "rootfs.cpio"
-        archive.gzip_uncompress(initrd_path_gz, initrd_path)
-
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyS0 console=tty '
-                               'rdinit=/sbin/init noreboot')
-        console_pattern = 'Boot successful.'
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
-                    args=('-initrd', initrd_path))
diff --git a/tests/functional/test_mips_malta.py b/tests/functional/test_mips_malta.py
index 3b15038d89..a745f21dd2 100755
--- a/tests/functional/test_mips_malta.py
+++ b/tests/functional/test_mips_malta.py
@@ -6,11 +6,12 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import LinuxKernelTest, Asset
+from qemu_test import Asset, skipLongRuntime
 from qemu_test import exec_command_and_wait_for_pattern
+from replay_kernel import ReplayKernelBase
 
 
-class MaltaMachineConsole(LinuxKernelTest):
+class MaltaMachineConsole(ReplayKernelBase):
 
     ASSET_KERNEL_2_63_2 = Asset(
         ('http://snapshot.debian.org/archive/debian/'
@@ -32,6 +33,14 @@ def test_mips_malta(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    def test_replay_mips_malta(self):
+        self.set_machine('malta')
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_2_63_2,
+                                     member='boot/vmlinux-2.6.32-5-4kc-malta')
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
+
     ASSET_KERNEL_4_5_0 = Asset(
         ('http://snapshot.debian.org/archive/debian/'
          '20160601T041800Z/pool/main/l/linux/'
@@ -71,6 +80,20 @@ def test_mips_malta_cpio(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
+    @skipLongRuntime()
+    def test_replay_mips_malta_cpio(self):
+        self.set_machine('malta')
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_4_5_0,
+                                      member='boot/vmlinux-4.5.0-2-4kc-malta')
+        initrd_path = self.uncompress(self.ASSET_INITRD)
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0 console=tty '
+                               'rdinit=/sbin/init noreboot')
+        console_pattern = 'Boot successful.'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
+                    args=('-initrd', initrd_path))
+
 
 if __name__ == '__main__':
-    LinuxKernelTest.main()
+    ReplayKernelBase.main()
-- 
2.48.1


