Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB4CE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIbd-0007Wq-8I; Wed, 11 Dec 2024 04:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIbH-0006Tl-8O
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIbF-0007vl-C3
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEm+37RehXJ9eA3Toyf1R/UmqsKjaI9g2uThb7iEFcc=;
 b=XEGFaprlTVLO90VCAuuAU8qCTEgBXBy+mj6m+sNXgEn4Fd8L7M8PrQoFzTRnUJq9qgb0vI
 9AZpp0RcJdwjxwOw5Rok81m8/FIgwNB7LA7oaFMXHqzciuzKkDTq4XDLS6wB6zs0algx/9
 WQ/H/+fdZ5aoekpFaR6qATfLr0fFa2k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-K-j0iLqCM7evp7qWGlDCXQ-1; Wed,
 11 Dec 2024 04:01:39 -0500
X-MC-Unique: K-j0iLqCM7evp7qWGlDCXQ-1
X-Mimecast-MFC-AGG-ID: K-j0iLqCM7evp7qWGlDCXQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABBD41955F42; Wed, 11 Dec 2024 09:01:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D9481956094; Wed, 11 Dec 2024 09:01:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 23/26] tests/functional: Convert the smdkc210 avocado test
Date: Wed, 11 Dec 2024 10:00:07 +0100
Message-ID: <20241211090014.619351-24-thuth@redhat.com>
In-Reply-To: <20241211090014.619351-1-thuth@redhat.com>
References: <20241211090014.619351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

A straight forward conversion, just the hashsums needed to be
updated to sha256 now.

Message-ID: <20241206102358.1186644-4-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                           |  1 +
 tests/avocado/boot_linux_console.py   | 41 -------------------
 tests/functional/meson.build          |  1 +
 tests/functional/test_arm_smdkc210.py | 57 +++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 41 deletions(-)
 create mode 100755 tests/functional/test_arm_smdkc210.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 435a87b146..9b1c3459b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -720,6 +720,7 @@ S: Odd Fixes
 F: hw/*/exynos*
 F: include/hw/*/exynos*
 F: docs/system/arm/exynos.rst
+F: tests/functional/test_arm_smdkc210.py
 
 Calxeda Highbank
 M: Rob Herring <robh@kernel.org>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 5d5795e41b..3250168ccf 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -132,47 +132,6 @@ def test_arm_virt(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    def test_arm_exynos4210_initrd(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:smdkc210
-        :avocado: tags=accel:tcg
-        """
-        deb_url = ('https://snapshot.debian.org/archive/debian/'
-                   '20190928T224601Z/pool/main/l/linux/'
-                   'linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb')
-        deb_hash = 'fa9df4a0d38936cb50084838f2cb933f570d7d82'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-4.19.0-6-armmp')
-        dtb_path = '/usr/lib/linux-image-4.19.0-6-armmp/exynos4210-smdkv310.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
-
-        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
-                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
-                      'arm/rootfs-armv5.cpio.gz')
-        initrd_hash = '2b50f1873e113523967806f4da2afe385462ff9b'
-        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
-        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
-        archive.gzip_uncompress(initrd_path_gz, initrd_path)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'earlycon=exynos4210,0x13800000 earlyprintk ' +
-                               'console=ttySAC0,115200n8 ' +
-                               'random.trust_cpu=off cryptomgr.notests ' +
-                               'cpuidle.off=1 panic=-1 noreboot')
-
-        self.vm.add_args('-kernel', kernel_path,
-                         '-dtb', dtb_path,
-                         '-initrd', initrd_path,
-                         '-append', kernel_command_line,
-                         '-no-reboot')
-        self.vm.launch()
-
-        self.wait_for_console_pattern('Boot successful.')
-        # TODO user command, for now the uart is stuck
-
     def test_arm_cubieboard_initrd(self):
         """
         :avocado: tags=arch:arm
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index af38494e14..8c21b53ccc 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -75,6 +75,7 @@ tests_arm_system_thorough = [
   'arm_integratorcp',
   'arm_orangepi',
   'arm_raspi2',
+  'arm_smdkc210',
   'arm_sx1',
   'arm_vexpress',
   'arm_tuxrun',
diff --git a/tests/functional/test_arm_smdkc210.py b/tests/functional/test_arm_smdkc210.py
new file mode 100755
index 0000000000..967752feeb
--- /dev/null
+++ b/tests/functional/test_arm_smdkc210.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import shutil
+
+from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test.utils import gzip_uncompress
+
+class Smdkc210Machine(LinuxKernelTest):
+
+    ASSET_DEB = Asset(
+        ('https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/'
+         'main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb'),
+        '421804e7579ef40d554c962850dbdf1bfc79f7fa7faec9d391397170dc806c3e')
+
+    ASSET_ROOTFS = Asset(
+        ('https://github.com/groeck/linux-build-test/raw/'
+         '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/arm/'
+         'rootfs-armv5.cpio.gz'),
+        '334b8d256db67a3f2b3ad070aa08b5ade39624e0e7e35b02f4359a577bc8f39b')
+
+    def test_arm_exynos4210_initrd(self):
+        self.set_machine('smdkc210')
+
+        deb_path = self.ASSET_DEB.fetch()
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-4.19.0-6-armmp')
+        dtb_path = '/usr/lib/linux-image-4.19.0-6-armmp/exynos4210-smdkv310.dtb'
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+
+        initrd_path_gz = self.ASSET_ROOTFS.fetch()
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=exynos4210,0x13800000 earlyprintk ' +
+                               'console=ttySAC0,115200n8 ' +
+                               'random.trust_cpu=off cryptomgr.notests ' +
+                               'cpuidle.off=1 panic=-1 noreboot')
+
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Boot successful.')
+        # TODO user command, for now the uart is stuck
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.1


