Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9857ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so08d-0005ZO-DB; Tue, 10 Sep 2024 08:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so08X-0004kU-96
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so08S-0005CC-Ln
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725971895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ml1r1n6NPK0zJab7LZ/SZK7JH5cfPmS5xxctirOPnCI=;
 b=CWjsHIeMiBClwsCcdrIyfRf1pV0Xo3gW0cCtXlwzsDV6J4mzYCUIkbCKTMcyw3IqmEuoM0
 4bJjdKutSlpqdChuObA6yTwPOxInx0Pgo22+EzIRaFo5VNcCBowDzWaV7tIm/6E7g4RDNv
 D/BxlnrtVx37QJo1SglTvyhmFzRbzk4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-_3f_rzHFOFu1uk_2fs5plg-1; Tue,
 10 Sep 2024 08:38:13 -0400
X-MC-Unique: _3f_rzHFOFu1uk_2fs5plg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 068EE1944D24; Tue, 10 Sep 2024 12:38:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.120])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C38719560AB; Tue, 10 Sep 2024 12:38:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 18/22] tests/functional: Convert the Alpha Clipper Avocado test
Date: Tue, 10 Sep 2024 14:37:19 +0200
Message-ID: <20240910123726.182975-19-thuth@redhat.com>
In-Reply-To: <20240910123726.182975-1-thuth@redhat.com>
References: <20240910123726.182975-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Straight forward conversion, just switch to SHA256 hashsum now.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240906180549.792832-13-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/boot_linux_console.py    | 21 --------------
 tests/functional/meson.build           |  4 +++
 tests/functional/test_alpha_clipper.py | 38 ++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 21 deletions(-)
 create mode 100755 tests/functional/test_alpha_clipper.py

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index a8eac44d9f..75aab90320 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -882,27 +882,6 @@ def test_arm_orangepi_uboot_netbsd9(self):
         # Wait for user-space
         wait_for_console_pattern(self, 'Starting root file system check')
 
-    def test_alpha_clipper(self):
-        """
-        :avocado: tags=arch:alpha
-        :avocado: tags=machine:clipper
-        """
-        kernel_url = ('http://archive.debian.org/debian/dists/lenny/main/'
-                      'installer-alpha/20090123lenny10/images/cdrom/vmlinuz')
-        kernel_hash = '3a943149335529e2ed3e74d0d787b85fb5671ba3'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        uncompressed_kernel = archive.uncompress(kernel_path, self.workdir)
-
-        self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        self.vm.add_args('-nodefaults',
-                         '-kernel', uncompressed_kernel,
-                         '-append', kernel_command_line)
-        self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
-
     def do_test_advcal_2018(self, day, tar_hash, kernel_name, console=0):
         tar_url = ('https://qemu-advcal.gitlab.io'
                    '/qac-best-of-multiarch/download/day' + day + '.tar.xz')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index a79083b0f9..e1903132a1 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -41,6 +41,10 @@ tests_aarch64_system_thorough = [
   'aarch64_virt',
 ]
 
+tests_alpha_system_thorough = [
+  'alpha_clipper',
+]
+
 tests_arm_system_thorough = [
   'arm_canona1100',
   'arm_integratorcp',
diff --git a/tests/functional/test_alpha_clipper.py b/tests/functional/test_alpha_clipper.py
new file mode 100755
index 0000000000..c1fbf0e395
--- /dev/null
+++ b/tests/functional/test_alpha_clipper.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on an Alpha Clipper machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test.utils import gzip_uncompress
+
+
+class AlphaClipperTest(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        ('http://archive.debian.org/debian/dists/lenny/main/'
+         'installer-alpha/20090123lenny10/images/cdrom/vmlinuz'),
+        '34f53da3fa32212e4f00b03cb944b2ad81c06bc8faaf9b7193b2e544ceeca576')
+
+    def test_alpha_clipper(self):
+        self.set_machine('clipper')
+        kernel_path = self.ASSET_KERNEL.fetch()
+
+        uncompressed_kernel = os.path.join(self.workdir, 'vmlinux')
+        gzip_uncompress(kernel_path, uncompressed_kernel)
+
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        self.vm.add_args('-nodefaults',
+                         '-kernel', uncompressed_kernel,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.46.0


