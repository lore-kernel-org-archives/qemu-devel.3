Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1490FC0219D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 12:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thpQn-0005eZ-9s; Tue, 11 Feb 2025 07:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1thpQk-0005dF-Qw
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:31:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1thpQi-0000Gh-AG
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739277115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e3T6LDkacyjUlecTplhH/SuS4x4FyNZiKYLWy2If9XQ=;
 b=ceYwz4A5i86bzW2gcRLdClxuAWHUNjIqFK7w1Paxhdh1GfS9k03OzzAJR/S22EhwQCZjkE
 LmlHERt72wPGNQmnP4KRzpbX88a/SQbdFcOb7nDujzV890/DSui7kgh/p12RGzibW9fIDf
 EqSjRggfZnljf+YohjdDgjcYyzVr258=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-Ls33FqAMPNmyc4ZKvrjLnA-1; Tue,
 11 Feb 2025 07:31:51 -0500
X-MC-Unique: Ls33FqAMPNmyc4ZKvrjLnA-1
X-Mimecast-MFC-AGG-ID: Ls33FqAMPNmyc4ZKvrjLnA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5560C180034A; Tue, 11 Feb 2025 12:31:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1DB119560A3; Tue, 11 Feb 2025 12:31:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 1/7] tests/functional: Convert the aarch64 xen test to the
 functional framework
Date: Tue, 11 Feb 2025 13:31:38 +0100
Message-ID: <20250211123144.37617-2-thuth@redhat.com>
In-Reply-To: <20250211123144.37617-1-thuth@redhat.com>
References: <20250211123144.37617-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

This test just needs the adaption for the asset handling, then
we can move it to the functional framework.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250207144409.220006-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                          |  2 +-
 tests/avocado/boot_xen.py            | 95 ----------------------------
 tests/functional/meson.build         |  1 +
 tests/functional/test_aarch64_xen.py | 90 ++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 96 deletions(-)
 delete mode 100644 tests/avocado/boot_xen.py
 create mode 100755 tests/functional/test_aarch64_xen.py

diff --git a/MAINTAINERS b/MAINTAINERS
index fefabe0cee..ebb415bc40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2539,7 +2539,7 @@ M: Alex Bennée <alex.bennee@linaro.org>
 S: Maintained
 F: hw/core/guest-loader.c
 F: docs/system/guest-loader.rst
-F: tests/avocado/boot_xen.py
+F: tests/functional/test_aarch64_xen.py
 
 Intel Hexadecimal Object File Loader
 M: Su Hang <suhang16@mails.ucas.ac.cn>
diff --git a/tests/avocado/boot_xen.py b/tests/avocado/boot_xen.py
deleted file mode 100644
index 490a127a3e..0000000000
--- a/tests/avocado/boot_xen.py
+++ /dev/null
@@ -1,95 +0,0 @@
-# Functional test that boots a Xen hypervisor with a domU kernel and
-# checks the console output is vaguely sane .
-#
-# Copyright (c) 2020 Linaro
-#
-# Author:
-#  Alex Bennée <alex.bennee@linaro.org>
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-import os
-
-from avocado_qemu import wait_for_console_pattern
-from boot_linux_console import LinuxKernelTest
-
-
-class BootXen(LinuxKernelTest):
-    """
-    Boots a Xen hypervisor with a Linux DomU kernel.
-
-    :avocado: tags=arch:aarch64
-    :avocado: tags=accel:tcg
-    :avocado: tags=cpu:cortex-a57
-    :avocado: tags=machine:virt
-    """
-
-    timeout = 90
-    XEN_COMMON_COMMAND_LINE = 'dom0_mem=128M loglvl=all guest_loglvl=all'
-
-    def setUp(self):
-        super(BootXen, self).setUp()
-
-        # Using my own built kernel - which works
-        kernel_url = ('https://fileserver.linaro.org/'
-                      's/JSsewXGZ6mqxPr5/download?path=%2F&files='
-                      'linux-5.9.9-arm64-ajb')
-        kernel_sha1 = '4f92bc4b9f88d5ab792fa7a43a68555d344e1b83'
-        self.kernel_path = self.fetch_asset(kernel_url,
-                                            asset_hash=kernel_sha1)
-
-    def launch_xen(self, xen_path):
-        """
-        Launch Xen with a dom0 guest kernel
-        """
-        self.log.info("launch with xen_path: %s", xen_path)
-
-        self.vm.set_console()
-
-        self.vm.add_args('-machine', 'virtualization=on',
-                         '-m', '768',
-                         '-kernel', xen_path,
-                         '-append', self.XEN_COMMON_COMMAND_LINE,
-                         '-device',
-                         'guest-loader,addr=0x47000000,kernel=%s,bootargs=console=hvc0'
-                         % (self.kernel_path))
-
-        self.vm.launch()
-
-        console_pattern = 'VFS: Cannot open root device'
-        wait_for_console_pattern(self, console_pattern, "Panic on CPU 0:")
-
-    def test_arm64_xen_411_and_dom0(self):
-        # archive of file from https://deb.debian.org/debian/pool/main/x/xen/
-        xen_url = ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
-                   'download?path=%2F&files='
-                   'xen-hypervisor-4.11-arm64_4.11.4%2B37-g3263f257ca-1_arm64.deb')
-        xen_sha1 = '034e634d4416adbad1212d59b62bccdcda63e62a'
-        xen_deb = self.fetch_asset(xen_url, asset_hash=xen_sha1)
-        xen_path = self.extract_from_deb(xen_deb, "/boot/xen-4.11-arm64")
-
-        self.launch_xen(xen_path)
-
-    def test_arm64_xen_414_and_dom0(self):
-        # archive of file from https://deb.debian.org/debian/pool/main/x/xen/
-        xen_url = ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
-                   'download?path=%2F&files='
-                   'xen-hypervisor-4.14-arm64_4.14.0%2B80-gd101b417b7-1_arm64.deb')
-        xen_sha1 = 'b9d209dd689ed2b393e625303a225badefec1160'
-        xen_deb = self.fetch_asset(xen_url, asset_hash=xen_sha1)
-        xen_path = self.extract_from_deb(xen_deb, "/boot/xen-4.14-arm64")
-
-        self.launch_xen(xen_path)
-
-    def test_arm64_xen_415_and_dom0(self):
-        xen_url = ('https://fileserver.linaro.org/'
-                   's/JSsewXGZ6mqxPr5/download'
-                   '?path=%2F&files=xen-upstream-4.15-unstable.deb')
-        xen_sha1 = 'fc191172b85cf355abb95d275a24cc0f6d6579d8'
-        xen_deb = self.fetch_asset(xen_url, asset_hash=xen_sha1)
-        xen_path = self.extract_from_deb(xen_deb, "/boot/xen-4.15-unstable")
-
-        self.launch_xen(xen_path)
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 3f085bfbca..e595508bfa 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -77,6 +77,7 @@ tests_aarch64_system_thorough = [
   'aarch64_tcg_plugins',
   'aarch64_tuxrun',
   'aarch64_virt',
+  'aarch64_xen',
   'aarch64_xlnx_versal',
   'multiprocess',
 ]
diff --git a/tests/functional/test_aarch64_xen.py b/tests/functional/test_aarch64_xen.py
new file mode 100755
index 0000000000..339904221b
--- /dev/null
+++ b/tests/functional/test_aarch64_xen.py
@@ -0,0 +1,90 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Xen hypervisor with a domU kernel and
+# checks the console output is vaguely sane .
+#
+# Copyright (c) 2020 Linaro
+#
+# Author:
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from qemu_test import Asset, LinuxKernelTest, wait_for_console_pattern
+
+
+class BootXen(LinuxKernelTest):
+    """
+    Boots a Xen hypervisor with a Linux DomU kernel.
+    """
+
+    timeout = 90
+    XEN_COMMON_COMMAND_LINE = 'dom0_mem=128M loglvl=all guest_loglvl=all'
+
+    ASSET_KERNEL = Asset(
+        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
+         'download?path=%2F&files=linux-5.9.9-arm64-ajb'),
+        '00366fa51ea957c19462d2e2aefd480bef80ce727120e714ae48e0c88f261edb')
+
+    def launch_xen(self, xen_path):
+        """
+        Launch Xen with a dom0 guest kernel
+        """
+        self.set_machine('virt')
+        self.cpu = "cortex-a57"
+        self.kernel_path = self.ASSET_KERNEL.fetch()
+        self.log.info("launch with xen_path: %s", xen_path)
+
+        self.vm.set_console()
+
+        self.vm.add_args('-machine', 'virtualization=on',
+                         '-m', '768',
+                         '-kernel', xen_path,
+                         '-append', self.XEN_COMMON_COMMAND_LINE,
+                         '-device',
+                         'guest-loader,addr=0x47000000,kernel=%s,bootargs=console=hvc0'
+                         % (self.kernel_path))
+
+        self.vm.launch()
+
+        console_pattern = 'VFS: Cannot open root device'
+        wait_for_console_pattern(self, console_pattern, "Panic on CPU 0:")
+
+    ASSET_XEN_4_11 = Asset(
+        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
+         'files=xen-hypervisor-4.11-arm64_4.11.4%2B37-g3263f257ca-1_arm64.deb'),
+        'b745c2631342f9fcc0147ddc364edb62c20ecfebd430e5a3546e7d7c6891c0bc')
+
+    def test_arm64_xen_411_and_dom0(self):
+        # archive of file from https://deb.debian.org/debian/pool/main/x/xen/
+        xen_path = self.archive_extract(self.ASSET_XEN_4_11, format='deb',
+                                        member="boot/xen-4.11-arm64")
+        self.launch_xen(xen_path)
+
+    ASSET_XEN_4_14 = Asset(
+        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
+         'files=xen-hypervisor-4.14-arm64_4.14.0%2B80-gd101b417b7-1_arm64.deb'),
+        'e930a3293248edabd367d5b4b3b6448b9c99c057096ea8b47228a7870661d5cb')
+
+    def test_arm64_xen_414_and_dom0(self):
+        # archive of file from https://deb.debian.org/debian/pool/main/x/xen/
+        xen_path = self.archive_extract(self.ASSET_XEN_4_14, format='deb',
+                                        member="boot/xen-4.14-arm64")
+        self.launch_xen(xen_path)
+
+    ASSET_XEN_4_15 = Asset(
+        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
+         'files=xen-upstream-4.15-unstable.deb'),
+        '2a9a8af8acf0231844657cc28baab95bd918b0ee2d493ee4ee6f8846e1358bc9')
+
+    def test_arm64_xen_415_and_dom0(self):
+        xen_path = self.archive_extract(self.ASSET_XEN_4_15, format='deb',
+                                        member="boot/xen-4.15-unstable")
+        self.launch_xen(xen_path)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.48.1


