Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC05C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 12:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sivM7-0001yf-SA; Tue, 27 Aug 2024 08:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sivM2-0001lp-7x
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 08:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sivLz-0007xe-LQ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 08:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724761878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0MJDPiINwl8QMTDF8TlkQfz9bDZEiNfISi0S4+j9LM=;
 b=PO0IZQh9Nhpv/buBLKFjWZ3JKqn6oOxcxqwDFyCCXcr+pkv71DPqf3SXnyikX4rLmHdpMs
 /+7aIdQpD6Et24XF7GwO3nSa4z6qjO9TsyG3DZzgjDbntAJGnI+xkzn7clh9eOu/8WbBuW
 OlJxhh/ep7+BbfYTJcnkIla8JGLC9zA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-ub2Ts2jpOKCwhaSmO80qsA-1; Tue,
 27 Aug 2024 08:31:16 -0400
X-MC-Unique: ub2Ts2jpOKCwhaSmO80qsA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 542561954B22; Tue, 27 Aug 2024 12:31:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84CEE1956053; Tue, 27 Aug 2024 12:31:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 2/2] tests/functional: Convert the m68k Q800 Avocado test into
 a functional test
Date: Tue, 27 Aug 2024 14:31:07 +0200
Message-ID: <20240827123107.34475-3-thuth@redhat.com>
In-Reply-To: <20240827123107.34475-1-thuth@redhat.com>
References: <aeb7bd72-095f-43cf-8216-18c341310915@linaro.org>
 <20240827123107.34475-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 25e71ac14c..972476cd7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1309,6 +1309,7 @@ F: include/hw/m68k/q800-glue.h
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
index 851f33c459..bf7a554a1d 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -40,7 +40,8 @@ tests_loongarch64_thorough = [
 ]
 
 tests_m68k_thorough = [
-  'm68k_nextcube'
+  'm68k_nextcube',
+  'm68k_q800',
 ]
 
 tests_microblaze_thorough = [
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


