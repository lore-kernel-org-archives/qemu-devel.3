Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22526E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 06:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLGHG-0006xN-MR; Wed, 11 Dec 2024 01:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGG4-0004f7-Bg
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:31:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGFu-0008ST-8E
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733898688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yvG5gbZQ92Iq8P4CJcVESFV4rOyBoEwuYyVDzOr1Eqo=;
 b=GH9Q92OiHH8Xv99dxo4hjzFwNTCtTgaJKhL8VaqxENNWWZIRKKOufYwKzMIkQAkz/zBQnl
 AJVQbMrObun8B6mi29jC4JpW9b4ozpxiWstV3loVKhk59kgS+jj7H6Sr0f4UfYyCxkRSJn
 WC9ghEidRYgMbVTIQPQfwn++I5EUM8k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-taScA8SfMCWEfyWIpmUvRA-1; Wed,
 11 Dec 2024 01:31:26 -0500
X-MC-Unique: taScA8SfMCWEfyWIpmUvRA-1
X-Mimecast-MFC-AGG-ID: taScA8SfMCWEfyWIpmUvRA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2D411955D4B; Wed, 11 Dec 2024 06:31:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.194.144])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 54008195605A; Wed, 11 Dec 2024 06:31:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 08/24] tests/functional: Introduce a specific test for ast1030
 SoC
Date: Wed, 11 Dec 2024 07:30:42 +0100
Message-ID: <20241211063058.1222038-9-clg@redhat.com>
In-Reply-To: <20241211063058.1222038-1-clg@redhat.com>
References: <20241211063058.1222038-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

This simply moves the ast1030 tests to a new test file. No changes.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/20241206131132.520911-2-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/meson.build                |  1 +
 tests/functional/test_arm_aspeed.py         | 64 ----------------
 tests/functional/test_arm_aspeed_ast1030.py | 81 +++++++++++++++++++++
 3 files changed, 82 insertions(+), 64 deletions(-)
 create mode 100644 tests/functional/test_arm_aspeed_ast1030.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index d6d2c0196c76..66f10da99d63 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -66,6 +66,7 @@ tests_alpha_system_thorough = [
 
 tests_arm_system_thorough = [
   'arm_aspeed',
+  'arm_aspeed_ast1030',
   'arm_bpim2u',
   'arm_canona1100',
   'arm_collie',
diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
index d88170ac2415..9e58fcd84009 100755
--- a/tests/functional/test_arm_aspeed.py
+++ b/tests/functional/test_arm_aspeed.py
@@ -19,70 +19,6 @@
 from zipfile import ZipFile
 from unittest import skipUnless
 
-class AST1030Machine(LinuxKernelTest):
-
-    ASSET_ZEPHYR_1_04 = Asset(
-        ('https://github.com/AspeedTech-BMC'
-         '/zephyr/releases/download/v00.01.04/ast1030-evb-demo.zip'),
-        '4ac6210adcbc61294927918707c6762483fd844dde5e07f3ba834ad1f91434d3')
-
-    def test_ast1030_zephyros_1_04(self):
-        self.set_machine('ast1030-evb')
-
-        zip_file = self.ASSET_ZEPHYR_1_04.fetch()
-
-        kernel_name = "ast1030-evb-demo/zephyr.elf"
-        with ZipFile(zip_file, 'r') as zf:
-                     zf.extract(kernel_name, path=self.workdir)
-        kernel_file = os.path.join(self.workdir, kernel_name)
-
-        self.vm.set_console()
-        self.vm.add_args('-kernel', kernel_file, '-nographic')
-        self.vm.launch()
-        self.wait_for_console_pattern("Booting Zephyr OS")
-        exec_command_and_wait_for_pattern(self, "help",
-                                          "Available commands")
-
-    ASSET_ZEPHYR_1_07 = Asset(
-        ('https://github.com/AspeedTech-BMC'
-         '/zephyr/releases/download/v00.01.07/ast1030-evb-demo.zip'),
-        'ad52e27959746988afaed8429bf4e12ab988c05c4d07c9d90e13ec6f7be4574c')
-
-    def test_ast1030_zephyros_1_07(self):
-        self.set_machine('ast1030-evb')
-
-        zip_file = self.ASSET_ZEPHYR_1_07.fetch()
-
-        kernel_name = "ast1030-evb-demo/zephyr.bin"
-        with ZipFile(zip_file, 'r') as zf:
-                     zf.extract(kernel_name, path=self.workdir)
-        kernel_file = os.path.join(self.workdir, kernel_name)
-
-        self.vm.set_console()
-        self.vm.add_args('-kernel', kernel_file, '-nographic')
-        self.vm.launch()
-        self.wait_for_console_pattern("Booting Zephyr OS")
-        for shell_cmd in [
-                'kernel stacks',
-                'otp info conf',
-                'otp info scu',
-                'hwinfo devid',
-                'crypto aes256_cbc_vault',
-                'random get',
-                'jtag JTAG1 sw_xfer high TMS',
-                'adc ADC0 resolution 12',
-                'adc ADC0 read 42',
-                'adc ADC1 read 69',
-                'i2c scan I2C_0',
-                'i3c attach I3C_0',
-                'hash test',
-                'kernel uptime',
-                'kernel reboot warm',
-                'kernel uptime',
-                'kernel reboot cold',
-                'kernel uptime',
-        ]: exec_command_and_wait_for_pattern(self, shell_cmd, "uart:~$")
-
 class AST2x00Machine(LinuxKernelTest):
 
     def do_test_arm_aspeed(self, machine, image):
diff --git a/tests/functional/test_arm_aspeed_ast1030.py b/tests/functional/test_arm_aspeed_ast1030.py
new file mode 100644
index 000000000000..380a76ec015c
--- /dev/null
+++ b/tests/functional/test_arm_aspeed_ast1030.py
@@ -0,0 +1,81 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED SoCs with firmware
+#
+# Copyright (C) 2022 ASPEED Technology Inc
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
+from zipfile import ZipFile
+
+class AST1030Machine(LinuxKernelTest):
+
+    ASSET_ZEPHYR_1_04 = Asset(
+        ('https://github.com/AspeedTech-BMC'
+         '/zephyr/releases/download/v00.01.04/ast1030-evb-demo.zip'),
+        '4ac6210adcbc61294927918707c6762483fd844dde5e07f3ba834ad1f91434d3')
+
+    def test_ast1030_zephyros_1_04(self):
+        self.set_machine('ast1030-evb')
+
+        zip_file = self.ASSET_ZEPHYR_1_04.fetch()
+
+        kernel_name = "ast1030-evb-demo/zephyr.elf"
+        with ZipFile(zip_file, 'r') as zf:
+                     zf.extract(kernel_name, path=self.workdir)
+        kernel_file = os.path.join(self.workdir, kernel_name)
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_file, '-nographic')
+        self.vm.launch()
+        self.wait_for_console_pattern("Booting Zephyr OS")
+        exec_command_and_wait_for_pattern(self, "help",
+                                          "Available commands")
+
+    ASSET_ZEPHYR_1_07 = Asset(
+        ('https://github.com/AspeedTech-BMC'
+         '/zephyr/releases/download/v00.01.07/ast1030-evb-demo.zip'),
+        'ad52e27959746988afaed8429bf4e12ab988c05c4d07c9d90e13ec6f7be4574c')
+
+    def test_ast1030_zephyros_1_07(self):
+        self.set_machine('ast1030-evb')
+
+        zip_file = self.ASSET_ZEPHYR_1_07.fetch()
+
+        kernel_name = "ast1030-evb-demo/zephyr.bin"
+        with ZipFile(zip_file, 'r') as zf:
+                     zf.extract(kernel_name, path=self.workdir)
+        kernel_file = os.path.join(self.workdir, kernel_name)
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_file, '-nographic')
+        self.vm.launch()
+        self.wait_for_console_pattern("Booting Zephyr OS")
+        for shell_cmd in [
+                'kernel stacks',
+                'otp info conf',
+                'otp info scu',
+                'hwinfo devid',
+                'crypto aes256_cbc_vault',
+                'random get',
+                'jtag JTAG1 sw_xfer high TMS',
+                'adc ADC0 resolution 12',
+                'adc ADC0 read 42',
+                'adc ADC1 read 69',
+                'i2c scan I2C_0',
+                'i3c attach I3C_0',
+                'hash test',
+                'kernel uptime',
+                'kernel reboot warm',
+                'kernel uptime',
+                'kernel reboot cold',
+                'kernel uptime',
+        ]: exec_command_and_wait_for_pattern(self, shell_cmd, "uart:~$")
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.1


