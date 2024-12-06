Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F41DE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJY80-0004EU-I5; Fri, 06 Dec 2024 08:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJY7y-00047d-RT
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:12:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJY7u-000751-Pa
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733490729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0cC2sGkAVWkI0+JZagpAquyy3a7MRA+KC7K1yHInldI=;
 b=YOueOFnJoAQciACwwDfCROv+U7KWvjL0FR7H5FHWb0HZzxxvVyaxfolgFOfqEQd8HOdxFC
 TU88WidunXuQWh7P6/poTH1c3KvtSvNN3CZMfRKtMk8GgYgkSa5Qsd4kL6TBVCHtYfr20z
 21F04rclgKG2xYRjZzIs2ZPd8BGZemk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-wvsgVi5BM5uhdqgkVjFSOQ-1; Fri,
 06 Dec 2024 08:12:07 -0500
X-MC-Unique: wvsgVi5BM5uhdqgkVjFSOQ-1
X-Mimecast-MFC-AGG-ID: wvsgVi5BM5uhdqgkVjFSOQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E117A195609D; Fri,  6 Dec 2024 13:12:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.16])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E85C41955E9C; Fri,  6 Dec 2024 13:12:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 5/7] tests/functional: Introduce a specific test for ast2600
 SoC
Date: Fri,  6 Dec 2024 14:11:30 +0100
Message-ID: <20241206131132.520911-6-clg@redhat.com>
In-Reply-To: <20241206131132.520911-1-clg@redhat.com>
References: <20241206131132.520911-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

This moves the ast2600-evb tests to a new test file. No changes in the
test. The routines used to run the buildroot and sdk tests are removed
from the test_arm_aspeed.py file because now unused.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/meson.build                |   2 +
 tests/functional/test_arm_aspeed.py         | 155 --------------------
 tests/functional/test_arm_aspeed_ast2600.py | 143 ++++++++++++++++++
 3 files changed, 145 insertions(+), 155 deletions(-)
 create mode 100644 tests/functional/test_arm_aspeed_ast2600.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 6a9c20b30156..68df574ee72e 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -22,6 +22,7 @@ test_timeouts = {
   'arm_aspeed_palmetto' : 120,
   'arm_aspeed_romulus' : 120,
   'arm_aspeed_ast2500' : 480,
+  'arm_aspeed_ast2600' : 720,
   'arm_aspeed' : 600,
   'arm_bpim2u' : 500,
   'arm_collie' : 180,
@@ -74,6 +75,7 @@ tests_arm_system_thorough = [
   'arm_aspeed_palmetto',
   'arm_aspeed_romulus',
   'arm_aspeed_ast2500',
+  'arm_aspeed_ast2600',
   'arm_bpim2u',
   'arm_canona1100',
   'arm_collie',
diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
index 48cf0bfb27ca..8cf86795af3c 100755
--- a/tests/functional/test_arm_aspeed.py
+++ b/tests/functional/test_arm_aspeed.py
@@ -19,161 +19,6 @@
 from zipfile import ZipFile
 from unittest import skipUnless
 
-class AST2x00Machine(LinuxKernelTest):
-
-    def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'):
-        self.require_netdev('user')
-        self.vm.set_console()
-        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw,read-only=true',
-                         '-net', 'nic', '-net', 'user')
-        self.vm.launch()
-
-        self.wait_for_console_pattern('U-Boot 2019.04')
-        self.wait_for_console_pattern('## Loading kernel from FIT Image')
-        self.wait_for_console_pattern('Starting kernel ...')
-        self.wait_for_console_pattern('Booting Linux on physical CPU ' + cpu_id)
-        self.wait_for_console_pattern('lease of 10.0.2.15')
-        # the line before login:
-        self.wait_for_console_pattern(pattern)
-        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
-        exec_command_and_wait_for_pattern(self, 'passw0rd', '#')
-
-    def do_test_arm_aspeed_buildroot_poweroff(self):
-        exec_command_and_wait_for_pattern(self, 'poweroff',
-                                          'reboot: System halted');
-    ASSET_BR2_202311_AST2600_FLASH = Asset(
-        ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
-         'images/ast2600-evb/buildroot-2023.11/flash.img'),
-        'b62808daef48b438d0728ee07662290490ecfa65987bb91294cafb1bb7ad1a68')
-
-    def test_arm_ast2600_evb_buildroot(self):
-        self.set_machine('ast2600-evb')
-
-        image_path = self.ASSET_BR2_202311_AST2600_FLASH.fetch()
-
-        self.vm.add_args('-device',
-                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
-        self.vm.add_args('-device',
-                         'ds1338,bus=aspeed.i2c.bus.3,address=0x32');
-        self.vm.add_args('-device',
-                         'i2c-echo,bus=aspeed.i2c.bus.3,address=0x42');
-        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00',
-                                                'ast2600-evb login:')
-
-        exec_command_and_wait_for_pattern(self,
-             'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
-             'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d');
-        exec_command_and_wait_for_pattern(self,
-                             'cat /sys/class/hwmon/hwmon1/temp1_input', '0')
-        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
-                    property='temperature', value=18000);
-        exec_command_and_wait_for_pattern(self,
-                             'cat /sys/class/hwmon/hwmon1/temp1_input', '18000')
-
-        exec_command_and_wait_for_pattern(self,
-             'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-3/device/new_device',
-             'i2c i2c-3: new_device: Instantiated device ds1307 at 0x32');
-        year = time.strftime("%Y")
-        exec_command_and_wait_for_pattern(self, 'hwclock -f /dev/rtc1', year);
-
-        exec_command_and_wait_for_pattern(self,
-             'echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-3/new_device',
-             'i2c i2c-3: new_device: Instantiated device slave-24c02 at 0x64');
-        exec_command_and_wait_for_pattern(self,
-             'i2cset -y 3 0x42 0x64 0x00 0xaa i', '#');
-        exec_command_and_wait_for_pattern(self,
-             'hexdump /sys/bus/i2c/devices/3-1064/slave-eeprom',
-             '0000000 ffaa ffff ffff ffff ffff ffff ffff ffff');
-        self.do_test_arm_aspeed_buildroot_poweroff()
-
-    ASSET_BR2_202302_AST2600_TPM_FLASH = Asset(
-        ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
-         'images/ast2600-evb/buildroot-2023.02-tpm/flash.img'),
-        'a46009ae8a5403a0826d607215e731a8c68d27c14c41e55331706b8f9c7bd997')
-
-    @skipUnless(*has_cmd('swtpm'))
-    def test_arm_ast2600_evb_buildroot_tpm(self):
-        self.set_machine('ast2600-evb')
-
-        image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
-
-        tpmstate_dir = tempfile.TemporaryDirectory(prefix="qemu_")
-        socket = os.path.join(tpmstate_dir.name, 'swtpm-socket')
-
-        # We must put the TPM state dir in /tmp/, not the build dir,
-        # because some distros use AppArmor to lock down swtpm and
-        # restrict the set of locations it can access files in.
-        subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
-                        '--tpmstate', f'dir={tpmstate_dir.name}',
-                        '--ctrl', f'type=unixio,path={socket}'])
-
-        self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
-        self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
-        self.vm.add_args('-device',
-                         'tpm-tis-i2c,tpmdev=tpm0,bus=aspeed.i2c.bus.12,address=0x2e')
-        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'Aspeed AST2600 EVB')
-
-        exec_command_and_wait_for_pattern(self,
-            'echo tpm_tis_i2c 0x2e > /sys/bus/i2c/devices/i2c-12/new_device',
-            'tpm_tis_i2c 12-002e: 2.0 TPM (device-id 0x1, rev-id 1)');
-        exec_command_and_wait_for_pattern(self,
-            'cat /sys/class/tpm/tpm0/pcr-sha256/0',
-            'B804724EA13F52A9072BA87FE8FDCC497DFC9DF9AA15B9088694639C431688E0');
-
-        self.do_test_arm_aspeed_buildroot_poweroff()
-
-    def do_test_arm_aspeed_sdk_start(self, image):
-        self.require_netdev('user')
-        self.vm.set_console()
-        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
-                         '-net', 'nic', '-net', 'user', '-snapshot')
-        self.vm.launch()
-
-        self.wait_for_console_pattern('U-Boot 2019.04')
-        self.wait_for_console_pattern('## Loading kernel from FIT Image')
-        self.wait_for_console_pattern('Starting kernel ...')
-
-    ASSET_SDK_V806_AST2600_A2 = Asset(
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v08.06/ast2600-a2-obmc.tar.gz',
-        '9083506135f622d5e7351fcf7d4e1c7125cee5ba16141220c0ba88931f3681a4')
-
-    def test_arm_ast2600_evb_sdk(self):
-        self.set_machine('ast2600-evb')
-
-        image_path = self.ASSET_SDK_V806_AST2600_A2.fetch()
-
-        archive_extract(image_path, self.workdir)
-
-        self.vm.add_args('-device',
-            'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test');
-        self.vm.add_args('-device',
-            'ds1338,bus=aspeed.i2c.bus.5,address=0x32');
-        self.do_test_arm_aspeed_sdk_start(
-            self.workdir + '/ast2600-a2/image-bmc')
-
-        self.wait_for_console_pattern('ast2600-a2 login:')
-
-        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
-        exec_command_and_wait_for_pattern(self, '0penBmc', 'root@ast2600-a2:~#')
-
-        exec_command_and_wait_for_pattern(self,
-            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-5/device/new_device',
-            'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d');
-        exec_command_and_wait_for_pattern(self,
-             'cat /sys/class/hwmon/hwmon19/temp1_input', '0')
-        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
-                    property='temperature', value=18000);
-        exec_command_and_wait_for_pattern(self,
-             'cat /sys/class/hwmon/hwmon19/temp1_input', '18000')
-
-        exec_command_and_wait_for_pattern(self,
-             'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-5/device/new_device',
-             'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32');
-        year = time.strftime("%Y")
-        exec_command_and_wait_for_pattern(self,
-             '/sbin/hwclock -f /dev/rtc1', year);
-
-
 class AST2x00MachineMMC(LinuxKernelTest):
 
     ASSET_RAINIER_EMMC = Asset(
diff --git a/tests/functional/test_arm_aspeed_ast2600.py b/tests/functional/test_arm_aspeed_ast2600.py
new file mode 100644
index 000000000000..74d025e0fc76
--- /dev/null
+++ b/tests/functional/test_arm_aspeed_ast2600.py
@@ -0,0 +1,143 @@
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
+from qemu_test import Asset
+from aspeed import AspeedTest
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import has_cmd
+from qemu_test.utils import archive_extract
+from unittest import skipUnless
+
+class AST2600Machine(AspeedTest):
+
+    ASSET_BR2_202311_AST2600_FLASH = Asset(
+        ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
+         'images/ast2600-evb/buildroot-2023.11/flash.img'),
+        'b62808daef48b438d0728ee07662290490ecfa65987bb91294cafb1bb7ad1a68')
+
+    def test_arm_ast2600_evb_buildroot(self):
+        self.set_machine('ast2600-evb')
+
+        image_path = self.ASSET_BR2_202311_AST2600_FLASH.fetch()
+
+        self.vm.add_args('-device',
+                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
+        self.vm.add_args('-device',
+                         'ds1338,bus=aspeed.i2c.bus.3,address=0x32');
+        self.vm.add_args('-device',
+                         'i2c-echo,bus=aspeed.i2c.bus.3,address=0x42');
+        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00',
+                                                'ast2600-evb login:')
+
+        exec_command_and_wait_for_pattern(self,
+             'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
+             'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d');
+        exec_command_and_wait_for_pattern(self,
+                             'cat /sys/class/hwmon/hwmon1/temp1_input', '0')
+        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
+                    property='temperature', value=18000);
+        exec_command_and_wait_for_pattern(self,
+                             'cat /sys/class/hwmon/hwmon1/temp1_input', '18000')
+
+        exec_command_and_wait_for_pattern(self,
+             'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-3/device/new_device',
+             'i2c i2c-3: new_device: Instantiated device ds1307 at 0x32');
+        year = time.strftime("%Y")
+        exec_command_and_wait_for_pattern(self, 'hwclock -f /dev/rtc1', year);
+
+        exec_command_and_wait_for_pattern(self,
+             'echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-3/new_device',
+             'i2c i2c-3: new_device: Instantiated device slave-24c02 at 0x64');
+        exec_command_and_wait_for_pattern(self,
+             'i2cset -y 3 0x42 0x64 0x00 0xaa i', '#');
+        exec_command_and_wait_for_pattern(self,
+             'hexdump /sys/bus/i2c/devices/3-1064/slave-eeprom',
+             '0000000 ffaa ffff ffff ffff ffff ffff ffff ffff');
+        self.do_test_arm_aspeed_buildroot_poweroff()
+
+    ASSET_BR2_202302_AST2600_TPM_FLASH = Asset(
+        ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
+         'images/ast2600-evb/buildroot-2023.02-tpm/flash.img'),
+        'a46009ae8a5403a0826d607215e731a8c68d27c14c41e55331706b8f9c7bd997')
+
+    @skipUnless(*has_cmd('swtpm'))
+    def test_arm_ast2600_evb_buildroot_tpm(self):
+        self.set_machine('ast2600-evb')
+
+        image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
+
+        tpmstate_dir = tempfile.TemporaryDirectory(prefix="qemu_")
+        socket = os.path.join(tpmstate_dir.name, 'swtpm-socket')
+
+        # We must put the TPM state dir in /tmp/, not the build dir,
+        # because some distros use AppArmor to lock down swtpm and
+        # restrict the set of locations it can access files in.
+        subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
+                        '--tpmstate', f'dir={tpmstate_dir.name}',
+                        '--ctrl', f'type=unixio,path={socket}'])
+
+        self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
+        self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
+        self.vm.add_args('-device',
+                         'tpm-tis-i2c,tpmdev=tpm0,bus=aspeed.i2c.bus.12,address=0x2e')
+        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'Aspeed AST2600 EVB')
+
+        exec_command_and_wait_for_pattern(self,
+            'echo tpm_tis_i2c 0x2e > /sys/bus/i2c/devices/i2c-12/new_device',
+            'tpm_tis_i2c 12-002e: 2.0 TPM (device-id 0x1, rev-id 1)');
+        exec_command_and_wait_for_pattern(self,
+            'cat /sys/class/tpm/tpm0/pcr-sha256/0',
+            'B804724EA13F52A9072BA87FE8FDCC497DFC9DF9AA15B9088694639C431688E0');
+
+        self.do_test_arm_aspeed_buildroot_poweroff()
+
+    ASSET_SDK_V806_AST2600_A2 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v08.06/ast2600-a2-obmc.tar.gz',
+        '9083506135f622d5e7351fcf7d4e1c7125cee5ba16141220c0ba88931f3681a4')
+
+    def test_arm_ast2600_evb_sdk(self):
+        self.set_machine('ast2600-evb')
+
+        image_path = self.ASSET_SDK_V806_AST2600_A2.fetch()
+
+        archive_extract(image_path, self.workdir)
+
+        self.vm.add_args('-device',
+            'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test');
+        self.vm.add_args('-device',
+            'ds1338,bus=aspeed.i2c.bus.5,address=0x32');
+        self.do_test_arm_aspeed_sdk_start(
+            self.workdir + '/ast2600-a2/image-bmc')
+
+        self.wait_for_console_pattern('ast2600-a2 login:')
+
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
+        exec_command_and_wait_for_pattern(self, '0penBmc', 'root@ast2600-a2:~#')
+
+        exec_command_and_wait_for_pattern(self,
+            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-5/device/new_device',
+            'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d');
+        exec_command_and_wait_for_pattern(self,
+             'cat /sys/class/hwmon/hwmon19/temp1_input', '0')
+        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
+                    property='temperature', value=18000);
+        exec_command_and_wait_for_pattern(self,
+             'cat /sys/class/hwmon/hwmon19/temp1_input', '18000')
+
+        exec_command_and_wait_for_pattern(self,
+             'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-5/device/new_device',
+             'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32');
+        year = time.strftime("%Y")
+        exec_command_and_wait_for_pattern(self,
+             '/sbin/hwclock -f /dev/rtc1', year);
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.47.0


