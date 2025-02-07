Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D04C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPag-0007ZS-M7; Fri, 07 Feb 2025 09:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tgPae-0007Z4-Oc
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:44:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tgPac-000742-De
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738939457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=raO7uHc45lSIZ4pxe1M+IsDmQw8N1krfVFmwhG4jTDE=;
 b=aLZVdbwxJPqU93A8R8HhhBiZtgO/0jjBBH5uL5WiH6fYFIi66kmJuhyv8XmCoM2ZMugPsn
 aW7j1kfSkzJR7untG3N4xKhiErNfni5AXxekJc1xkvUsnA4JOKzy/eNS8Nf/F9j7Z9cnRx
 kcKp4ujey2/mPhwcMDktYNVf6p/+kns=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-mMBRoCQZOJuOal0YC4TCMg-1; Fri,
 07 Feb 2025 09:44:15 -0500
X-MC-Unique: mMBRoCQZOJuOal0YC4TCMg-1
X-Mimecast-MFC-AGG-ID: mMBRoCQZOJuOal0YC4TCMg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE8821955BF4; Fri,  7 Feb 2025 14:44:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.41])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C89E9195608D; Fri,  7 Feb 2025 14:44:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests/functional: Convert the aarch64 xen test to the
 functional framework
Date: Fri,  7 Feb 2025 15:44:08 +0100
Message-ID: <20250207144409.220006-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This test just needs the adaption for the asset handling, then
we can move it to the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 tests/functional/meson.build                  |  1 +
 .../test_aarch64_xen.py}                      | 75 +++++++++----------
 3 files changed, 37 insertions(+), 41 deletions(-)
 rename tests/{avocado/boot_xen.py => functional/test_aarch64_xen.py} (47%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0b97e960..4dc4c7730d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2540,7 +2540,7 @@ M: Alex Bennée <alex.bennee@linaro.org>
 S: Maintained
 F: hw/core/guest-loader.c
 F: docs/system/guest-loader.rst
-F: tests/avocado/boot_xen.py
+F: tests/functional/test_aarch64_xen.py
 
 Intel Hexadecimal Object File Loader
 M: Su Hang <suhang16@mails.ucas.ac.cn>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index faaab1b358..1054287a1e 100644
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
diff --git a/tests/avocado/boot_xen.py b/tests/functional/test_aarch64_xen.py
old mode 100644
new mode 100755
similarity index 47%
rename from tests/avocado/boot_xen.py
rename to tests/functional/test_aarch64_xen.py
index 490a127a3e..339904221b
--- a/tests/avocado/boot_xen.py
+++ b/tests/functional/test_aarch64_xen.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots a Xen hypervisor with a domU kernel and
 # checks the console output is vaguely sane .
 #
@@ -11,40 +13,29 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-import os
-
-from avocado_qemu import wait_for_console_pattern
-from boot_linux_console import LinuxKernelTest
+from qemu_test import Asset, LinuxKernelTest, wait_for_console_pattern
 
 
 class BootXen(LinuxKernelTest):
     """
     Boots a Xen hypervisor with a Linux DomU kernel.
-
-    :avocado: tags=arch:aarch64
-    :avocado: tags=accel:tcg
-    :avocado: tags=cpu:cortex-a57
-    :avocado: tags=machine:virt
     """
 
     timeout = 90
     XEN_COMMON_COMMAND_LINE = 'dom0_mem=128M loglvl=all guest_loglvl=all'
 
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
+    ASSET_KERNEL = Asset(
+        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
+         'download?path=%2F&files=linux-5.9.9-arm64-ajb'),
+        '00366fa51ea957c19462d2e2aefd480bef80ce727120e714ae48e0c88f261edb')
 
     def launch_xen(self, xen_path):
         """
         Launch Xen with a dom0 guest kernel
         """
+        self.set_machine('virt')
+        self.cpu = "cortex-a57"
+        self.kernel_path = self.ASSET_KERNEL.fetch()
         self.log.info("launch with xen_path: %s", xen_path)
 
         self.vm.set_console()
@@ -62,34 +53,38 @@ def launch_xen(self, xen_path):
         console_pattern = 'VFS: Cannot open root device'
         wait_for_console_pattern(self, console_pattern, "Panic on CPU 0:")
 
+    ASSET_XEN_4_11 = Asset(
+        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
+         'files=xen-hypervisor-4.11-arm64_4.11.4%2B37-g3263f257ca-1_arm64.deb'),
+        'b745c2631342f9fcc0147ddc364edb62c20ecfebd430e5a3546e7d7c6891c0bc')
+
     def test_arm64_xen_411_and_dom0(self):
         # archive of file from https://deb.debian.org/debian/pool/main/x/xen/
-        xen_url = ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
-                   'download?path=%2F&files='
-                   'xen-hypervisor-4.11-arm64_4.11.4%2B37-g3263f257ca-1_arm64.deb')
-        xen_sha1 = '034e634d4416adbad1212d59b62bccdcda63e62a'
-        xen_deb = self.fetch_asset(xen_url, asset_hash=xen_sha1)
-        xen_path = self.extract_from_deb(xen_deb, "/boot/xen-4.11-arm64")
-
+        xen_path = self.archive_extract(self.ASSET_XEN_4_11, format='deb',
+                                        member="boot/xen-4.11-arm64")
         self.launch_xen(xen_path)
 
+    ASSET_XEN_4_14 = Asset(
+        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
+         'files=xen-hypervisor-4.14-arm64_4.14.0%2B80-gd101b417b7-1_arm64.deb'),
+        'e930a3293248edabd367d5b4b3b6448b9c99c057096ea8b47228a7870661d5cb')
+
     def test_arm64_xen_414_and_dom0(self):
         # archive of file from https://deb.debian.org/debian/pool/main/x/xen/
-        xen_url = ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
-                   'download?path=%2F&files='
-                   'xen-hypervisor-4.14-arm64_4.14.0%2B80-gd101b417b7-1_arm64.deb')
-        xen_sha1 = 'b9d209dd689ed2b393e625303a225badefec1160'
-        xen_deb = self.fetch_asset(xen_url, asset_hash=xen_sha1)
-        xen_path = self.extract_from_deb(xen_deb, "/boot/xen-4.14-arm64")
-
+        xen_path = self.archive_extract(self.ASSET_XEN_4_14, format='deb',
+                                        member="boot/xen-4.14-arm64")
         self.launch_xen(xen_path)
 
-    def test_arm64_xen_415_and_dom0(self):
-        xen_url = ('https://fileserver.linaro.org/'
-                   's/JSsewXGZ6mqxPr5/download'
-                   '?path=%2F&files=xen-upstream-4.15-unstable.deb')
-        xen_sha1 = 'fc191172b85cf355abb95d275a24cc0f6d6579d8'
-        xen_deb = self.fetch_asset(xen_url, asset_hash=xen_sha1)
-        xen_path = self.extract_from_deb(xen_deb, "/boot/xen-4.15-unstable")
+    ASSET_XEN_4_15 = Asset(
+        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
+         'files=xen-upstream-4.15-unstable.deb'),
+        '2a9a8af8acf0231844657cc28baab95bd918b0ee2d493ee4ee6f8846e1358bc9')
 
+    def test_arm64_xen_415_and_dom0(self):
+        xen_path = self.archive_extract(self.ASSET_XEN_4_15, format='deb',
+                                        member="boot/xen-4.15-unstable")
         self.launch_xen(xen_path)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.48.1


