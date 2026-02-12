Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CBDEEA85C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 21:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqeQ1-00086m-JQ; Thu, 12 Feb 2026 16:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqePw-000855-GD
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqePu-00063t-5q
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770932404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6DyXuRfJJ5GP6M+MDaH6de8oQPLkW/WSQArjfskfQY=;
 b=gp26cky+8Px5bibzJjg/EQz+AAIfjeMOQN3+HAjm1gRsx+FY8Pk6gTVvaataNIa+GFRQ8T
 1XeUw6KARSPMi4iMD5iYA7qKTJeladLPdbrZA5wY+w/MyNMRdMyg7NStCmaLnh8OreL8O9
 IvYujR7wS8NA5wh5c8NK44urDz1yfko=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-UuA0qhxnOwizyzexc6tbFw-1; Thu,
 12 Feb 2026 16:40:02 -0500
X-MC-Unique: UuA0qhxnOwizyzexc6tbFw-1
X-Mimecast-MFC-AGG-ID: UuA0qhxnOwizyzexc6tbFw_1770932402
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7BD01955E88; Thu, 12 Feb 2026 21:40:01 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC9381800668; Thu, 12 Feb 2026 21:39:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PULL 01/16] tests/functional: Split Aspeed ARM tests into separate
 files
Date: Thu, 12 Feb 2026 22:39:40 +0100
Message-ID: <20260212213955.2225662-2-clg@redhat.com>
In-Reply-To: <20260212213955.2225662-1-clg@redhat.com>
References: <20260212213955.2225662-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reorganize the monolithic Aspeed functional test files into separate
files based on firmware type (Buildroot vs SDK) and specific test
scenarios. This allows the test suite to run tests in parallel more
effectively and makes it easier to identify and run specific test
scenarios independently.

Link: https://lore.kernel.org/qemu-devel/20260209065044.239378-2-clg@redhat.com
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/meson.build              | 14 +++--
 tests/functional/arm/test_aspeed_ast1060.py   |  0
 ...00.py => test_aspeed_ast2500_buildroot.py} | 14 -----
 .../functional/arm/test_aspeed_ast2500_sdk.py | 29 +++++++++
 .../arm/test_aspeed_ast2600_buildroot.py      | 41 +------------
 .../arm/test_aspeed_ast2600_buildroot_tpm.py  | 60 +++++++++++++++++++
 .../functional/arm/test_aspeed_ast2600_sdk.py | 15 -----
 .../arm/test_aspeed_ast2600_sdk_otp.py        | 34 +++++++++++
 8 files changed, 134 insertions(+), 73 deletions(-)
 mode change 100644 => 100755 tests/functional/arm/test_aspeed_ast1060.py
 rename tests/functional/arm/{test_aspeed_ast2500.py => test_aspeed_ast2500_buildroot.py} (74%)
 create mode 100755 tests/functional/arm/test_aspeed_ast2500_sdk.py
 create mode 100755 tests/functional/arm/test_aspeed_ast2600_buildroot_tpm.py
 create mode 100755 tests/functional/arm/test_aspeed_ast2600_sdk_otp.py

diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 1762a496049d..175a83a2acd7 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -4,9 +4,12 @@ test_arm_timeouts = {
   'aspeed_palmetto' : 120,
   'aspeed_romulus' : 120,
   'aspeed_witherspoon' : 120,
-  'aspeed_ast2500' : 720,
-  'aspeed_ast2600_buildroot' : 720,
-  'aspeed_ast2600_sdk' : 1200,
+  'aspeed_ast2500_sdk' : 720,
+  'aspeed_ast2500_buildroot' : 480,
+  'aspeed_ast2600_buildroot' : 480,
+  'aspeed_ast2600_buildroot_tpm' : 720,
+  'aspeed_ast2600_sdk' : 720,
+  'aspeed_ast2600_sdk_otp' : 720,
   'aspeed_bletchley' : 480,
   'aspeed_catalina' : 480,
   'aspeed_gb200nvl_bmc' : 480,
@@ -32,9 +35,12 @@ tests_arm_system_thorough = [
   'aspeed_palmetto',
   'aspeed_romulus',
   'aspeed_witherspoon',
-  'aspeed_ast2500',
+  'aspeed_ast2500_sdk',
+  'aspeed_ast2500_buildroot',
   'aspeed_ast2600_buildroot',
+  'aspeed_ast2600_buildroot_tpm',
   'aspeed_ast2600_sdk',
+  'aspeed_ast2600_sdk_otp',
   'aspeed_bletchley',
   'aspeed_catalina',
   'aspeed_gb200nvl_bmc',
diff --git a/tests/functional/arm/test_aspeed_ast1060.py b/tests/functional/arm/test_aspeed_ast1060.py
old mode 100644
new mode 100755
diff --git a/tests/functional/arm/test_aspeed_ast2500.py b/tests/functional/arm/test_aspeed_ast2500_buildroot.py
similarity index 74%
rename from tests/functional/arm/test_aspeed_ast2500.py
rename to tests/functional/arm/test_aspeed_ast2500_buildroot.py
index 5d75e20184d6..8196923ee04d 100755
--- a/tests/functional/arm/test_aspeed_ast2500.py
+++ b/tests/functional/arm/test_aspeed_ast2500_buildroot.py
@@ -37,20 +37,6 @@ def test_arm_ast2500_evb_buildroot(self):
 
         self.do_test_arm_aspeed_buildroot_poweroff()
 
-    ASSET_SDK_V1000_AST2500 = Asset(
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v10.00/ast2500-default-obmc.tar.gz',
-        '7d71a3f71d5f4d9f3451f59a73bf9baf8fd9f6a24107eb504a3216151a8b2b5b')
-
-    def test_arm_ast2500_evb_sdk(self):
-        self.set_machine('ast2500-evb')
-
-        self.archive_extract(self.ASSET_SDK_V1000_AST2500)
-
-        self.do_test_arm_aspeed_sdk_start(
-            self.scratch_file("ast2500-default", "image-bmc"))
-
-        self.wait_for_console_pattern('ast2500-default login:')
-
 
 if __name__ == '__main__':
     AspeedTest.main()
diff --git a/tests/functional/arm/test_aspeed_ast2500_sdk.py b/tests/functional/arm/test_aspeed_ast2500_sdk.py
new file mode 100755
index 000000000000..2c9211aeddc8
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_ast2500_sdk.py
@@ -0,0 +1,29 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from aspeed import AspeedTest
+
+
+class AST2500Machine(AspeedTest):
+
+    ASSET_SDK_V1000_AST2500 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v10.00/ast2500-default-obmc.tar.gz',
+        '7d71a3f71d5f4d9f3451f59a73bf9baf8fd9f6a24107eb504a3216151a8b2b5b')
+
+    def test_arm_ast2500_evb_sdk(self):
+        self.set_machine('ast2500-evb')
+
+        self.archive_extract(self.ASSET_SDK_V1000_AST2500)
+
+        self.do_test_arm_aspeed_sdk_start(
+            self.scratch_file("ast2500-default", "image-bmc"))
+
+        self.wait_for_console_pattern('ast2500-default login:')
+
+
+if __name__ == '__main__':
+    AspeedTest.main()
diff --git a/tests/functional/arm/test_aspeed_ast2600_buildroot.py b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
index 3d130b9fd189..cc5ab9796a5e 100755
--- a/tests/functional/arm/test_aspeed_ast2600_buildroot.py
+++ b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
@@ -11,7 +11,7 @@
 
 from aspeed import AspeedTest
 from qemu_test import Asset
-from qemu_test import exec_command_and_wait_for_pattern, skipIfMissingCommands
+from qemu_test import exec_command_and_wait_for_pattern
 
 
 class AST2600Machine(AspeedTest):
@@ -61,45 +61,6 @@ def test_arm_ast2600_evb_buildroot(self):
              '0000000 ffaa ffff ffff ffff ffff ffff ffff ffff')
         self.do_test_arm_aspeed_buildroot_poweroff()
 
-    ASSET_BR2_202302_AST2600_TPM_FLASH = Asset(
-        ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
-         'images/ast2600-evb/buildroot-2023.02-tpm/flash.img'),
-        'a46009ae8a5403a0826d607215e731a8c68d27c14c41e55331706b8f9c7bd997')
-
-    def _test_arm_ast2600_evb_buildroot_tpm(self, tpmstate_dir):
-        image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
-
-        socket = os.path.join(tpmstate_dir, 'swtpm-socket')
-
-        # We must put the TPM state dir in /tmp/, not the build dir,
-        # because some distros use AppArmor to lock down swtpm and
-        # restrict the set of locations it can access files in.
-        subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
-                        '--tpmstate', f'dir={tpmstate_dir}',
-                        '--ctrl', f'type=unixio,path={socket}'],
-                       check=True)
-
-        self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
-        self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
-        self.vm.add_args('-device',
-                         'tpm-tis-i2c,tpmdev=tpm0,bus=aspeed.i2c.bus.12,address=0x2e')
-        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'Aspeed AST2600 EVB')
-
-        exec_command_and_wait_for_pattern(self,
-            'echo tpm_tis_i2c 0x2e > /sys/bus/i2c/devices/i2c-12/new_device',
-            'tpm_tis_i2c 12-002e: 2.0 TPM (device-id 0x1, rev-id 1)')
-        exec_command_and_wait_for_pattern(self,
-            'cat /sys/class/tpm/tpm0/pcr-sha256/0',
-            'B804724EA13F52A9072BA87FE8FDCC497DFC9DF9AA15B9088694639C431688E0')
-
-        self.do_test_arm_aspeed_buildroot_poweroff()
-
-    @skipIfMissingCommands('swtpm')
-    def test_arm_ast2600_evb_buildroot_tpm(self):
-        self.set_machine('ast2600-evb')
-        with tempfile.TemporaryDirectory(prefix="qemu_") as tpmstate_dir:
-            self._test_arm_ast2600_evb_buildroot_tpm(tpmstate_dir)
-
 
 if __name__ == '__main__':
     AspeedTest.main()
diff --git a/tests/functional/arm/test_aspeed_ast2600_buildroot_tpm.py b/tests/functional/arm/test_aspeed_ast2600_buildroot_tpm.py
new file mode 100755
index 000000000000..7ec996e9cf22
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_ast2600_buildroot_tpm.py
@@ -0,0 +1,60 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import time
+import tempfile
+import subprocess
+
+from aspeed import AspeedTest
+from qemu_test import Asset
+from qemu_test import exec_command_and_wait_for_pattern, skipIfMissingCommands
+
+
+class AST2600Machine(AspeedTest):
+
+    ASSET_BR2_202302_AST2600_TPM_FLASH = Asset(
+        ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
+         'images/ast2600-evb/buildroot-2023.02-tpm/flash.img'),
+        'a46009ae8a5403a0826d607215e731a8c68d27c14c41e55331706b8f9c7bd997')
+
+    def _test_arm_ast2600_evb_buildroot_tpm(self, tpmstate_dir):
+        image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
+
+        socket = os.path.join(tpmstate_dir, 'swtpm-socket')
+
+        # We must put the TPM state dir in /tmp/, not the build dir,
+        # because some distros use AppArmor to lock down swtpm and
+        # restrict the set of locations it can access files in.
+        subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
+                        '--tpmstate', f'dir={tpmstate_dir}',
+                        '--ctrl', f'type=unixio,path={socket}'],
+                       check=True)
+
+        self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
+        self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
+        self.vm.add_args('-device',
+                         'tpm-tis-i2c,tpmdev=tpm0,bus=aspeed.i2c.bus.12,address=0x2e')
+        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'Aspeed AST2600 EVB')
+
+        exec_command_and_wait_for_pattern(self,
+            'echo tpm_tis_i2c 0x2e > /sys/bus/i2c/devices/i2c-12/new_device',
+            'tpm_tis_i2c 12-002e: 2.0 TPM (device-id 0x1, rev-id 1)')
+        exec_command_and_wait_for_pattern(self,
+            'cat /sys/class/tpm/tpm0/pcr-sha256/0',
+            'B804724EA13F52A9072BA87FE8FDCC497DFC9DF9AA15B9088694639C431688E0')
+
+        self.do_test_arm_aspeed_buildroot_poweroff()
+
+    @skipIfMissingCommands('swtpm')
+    def test_arm_ast2600_evb_buildroot_tpm(self):
+        self.set_machine('ast2600-evb')
+        with tempfile.TemporaryDirectory(prefix="qemu_") as tpmstate_dir:
+            self._test_arm_ast2600_evb_buildroot_tpm(tpmstate_dir)
+
+
+if __name__ == '__main__':
+    AspeedTest.main()
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functional/arm/test_aspeed_ast2600_sdk.py
index 6236aeb11cd2..971fa3390d21 100755
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py
@@ -70,21 +70,6 @@ def test_arm_ast2600_evb_sdk(self):
              '/sbin/hwclock -f /dev/rtc1', year)
         self.do_ast2600_pcie_test()
 
-    def test_arm_ast2600_otp_blockdev_device(self):
-        self.vm.set_machine("ast2600-evb")
-
-        image_path = self.archive_extract(self.ASSET_SDK_V1100_AST2600)
-        otp_img = self.generate_otpmem_image()
-
-        self.vm.set_console()
-        self.vm.add_args(
-            "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
-            "-global", "aspeed-otp.drive=otp",
-        )
-        self.do_test_arm_aspeed_sdk_start(
-            self.scratch_file("ast2600-default", "image-bmc"))
-        self.wait_for_console_pattern("ast2600-default login:")
-
 
 if __name__ == '__main__':
     AspeedTest.main()
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
new file mode 100755
index 000000000000..4066532d5dec
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
@@ -0,0 +1,34 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from aspeed import AspeedTest
+
+
+class AST2600Machine(AspeedTest):
+
+    ASSET_SDK_V1100_AST2600 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2600-default-obmc.tar.gz',
+        '64d8926a7d01b649168be96c986603b5690f06391286c438a3a772c8c7039e93')
+
+    def test_arm_ast2600_otp_blockdev_device(self):
+        self.vm.set_machine("ast2600-evb")
+
+        image_path = self.archive_extract(self.ASSET_SDK_V1100_AST2600)
+        otp_img = self.generate_otpmem_image()
+
+        self.vm.set_console()
+        self.vm.add_args(
+            "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
+            "-global", "aspeed-otp.drive=otp",
+        )
+        self.do_test_arm_aspeed_sdk_start(
+            self.scratch_file("ast2600-default", "image-bmc"))
+        self.wait_for_console_pattern("ast2600-default login:")
+
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.53.0


