Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C30E6FE41
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smdLd-0007NI-Ch; Fri, 06 Sep 2024 14:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdLY-000740-E9
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:06:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdLW-00052a-Gb
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725645969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1whIWzPyVjbpmMh5f6KRyBvBw4UFuKS+BRDTi34npw=;
 b=XWcP/echAccP6OokR1eCbLwWjTgxOzBQHv4au8rv+lHdylNVSk7gOmkxQKlJl+cZFwA00X
 jC640FxBJVUzlojH4UJqXAjeHT7xkCZWDULADcPsUE5BubwpI90e9uDCMrI38O2b44zOhd
 O7hgooBIaUt6K52amhHQrXrBmE7w1DA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-s7oIuy_XOUeV_dHQv1yRDw-1; Fri,
 06 Sep 2024 14:06:03 -0400
X-MC-Unique: s7oIuy_XOUeV_dHQv1yRDw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DFAC19560AB; Fri,  6 Sep 2024 18:06:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5082B19560AF; Fri,  6 Sep 2024 18:05:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH 02/14] tests/functional: Convert the m68k Q800 Avocado test
 into a functional test
Date: Fri,  6 Sep 2024 20:05:37 +0200
Message-ID: <20240906180549.792832-3-thuth@redhat.com>
In-Reply-To: <20240906180549.792832-1-thuth@redhat.com>
References: <20240906180549.792832-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Just had to update the asset checksum to use SHA256 instead of SHA1,
but apart from that it is a pretty much straightforward conversion.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                         |  1 +
 tests/avocado/boot_linux_console.py | 24 -------------------
 tests/functional/meson.build        |  3 ++-
 tests/functional/test_m68k_q800.py  | 37 +++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 25 deletions(-)
 create mode 100755 tests/functional/test_m68k_q800.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c1bc69828..a88c2c3467 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1310,6 +1310,7 @@ F: include/hw/m68k/q800-glue.h
 F: include/hw/misc/djmemc.h
 F: include/hw/misc/iosb.h
 F: include/hw/audio/asc.h
+F: tests/functional/test_m68k_q800.py
 
 virt
 M: Laurent Vivier <laurent@vivier.eu>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 18c69d6acc..396836bf64 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1325,30 +1325,6 @@ def test_alpha_clipper(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    def test_m68k_q800(self):
-        """
-        :avocado: tags=arch:m68k
-        :avocado: tags=machine:q800
-        """
-        deb_url = ('https://snapshot.debian.org/archive/debian-ports'
-                   '/20191021T083923Z/pool-m68k/main'
-                   '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.udeb')
-        deb_hash = '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-5.3.0-1-m68k')
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyS0 vga=off')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-append', kernel_command_line)
-        self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
-        console_pattern = 'No filesystem could mount root'
-        self.wait_for_console_pattern(console_pattern)
-
     def do_test_advcal_2018(self, day, tar_hash, kernel_name, console=0):
         tar_url = ('https://qemu-advcal.gitlab.io'
                    '/qac-best-of-multiarch/download/day' + day + '.tar.xz')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index cda89c4b0c..c6bb345d2c 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -57,7 +57,8 @@ tests_loongarch64_system_thorough = [
 ]
 
 tests_m68k_system_thorough = [
-  'm68k_nextcube'
+  'm68k_nextcube',
+  'm68k_q800',
 ]
 
 tests_microblaze_system_thorough = [
diff --git a/tests/functional/test_m68k_q800.py b/tests/functional/test_m68k_q800.py
new file mode 100755
index 0000000000..3b17244b98
--- /dev/null
+++ b/tests/functional/test_m68k_q800.py
@@ -0,0 +1,37 @@
+#!/usr/bin/env python3
+#
+# Functional test for testing the q800 m68k machine
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from qemu_test import LinuxKernelTest, Asset
+
+class Q800MachineTest(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        ('https://snapshot.debian.org/'
+         'archive/debian-ports/20191021T083923Z/pool-m68k/main/l/linux/'
+         'kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.udeb'),
+        '949e50d74d4b9bc15d26c06d402717b7a4c0e32ff8100014f5930d8024de7b73')
+
+    def test_m68k_q800(self):
+        self.set_machine('q800')
+
+        deb_path = self.ASSET_KERNEL.fetch()
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinux-5.3.0-1-m68k')
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0 vga=off')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
+        console_pattern = 'No filesystem could mount root'
+        self.wait_for_console_pattern(console_pattern)
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.46.0


