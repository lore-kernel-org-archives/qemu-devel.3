Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72236D1AD2E
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 09:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t100j-0004Hb-1I; Wed, 16 Oct 2024 05:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t100h-0004H8-LY
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 05:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t100f-00009R-03
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 05:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729069679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=skayOzqsL9oaAMqA9Pk2lsql7oBy95/9FtnknrdcimQ=;
 b=jS8J+Ffy3nMqumeOTP0VE2kXx7mQzAsFDvXx/5Eq4yQf4J5c3FVfjtg+R0lboPPx+O/hYv
 HCw7NiLejsErfspgvqopWa7acGwKhllqQx5TYu6gYRi2UAwnImxlbq5puaqeIU5BomUt/U
 b8H95PjPN9/HtpGLjPBuuYqq1Z23wqI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-EGjmzfb3OeygTqw6trmnhQ-1; Wed,
 16 Oct 2024 05:07:56 -0400
X-MC-Unique: EGjmzfb3OeygTqw6trmnhQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A755619560B0; Wed, 16 Oct 2024 09:07:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.123])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FC2F300018D; Wed, 16 Oct 2024 09:07:44 +0000 (UTC)
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
Subject: [PATCH] tests/functional: Convert most Aspeed machine tests
Date: Wed, 16 Oct 2024 11:07:41 +0200
Message-ID: <20241016090741.2026630-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is a simple conversion of the tests with some cleanups and
adjustments to match the new test framework. Replace the zephyr image
MD5 hashes with SHA256 hashes while at it.

The SDK tests depend on a ssh class from avocado.utils which is
difficult to replace. To be addressed separately.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/avocado/machine_aspeed.py     | 252 --------------------------
 tests/functional/meson.build        |   2 +
 tests/functional/test_arm_aspeed.py | 269 ++++++++++++++++++++++++++++
 3 files changed, 271 insertions(+), 252 deletions(-)
 create mode 100644 tests/functional/test_arm_aspeed.py

diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
index 4e144bde9131..cb163e3a1106 100644
--- a/tests/avocado/machine_aspeed.py
+++ b/tests/avocado/machine_aspeed.py
@@ -19,258 +19,6 @@
 from avocado_qemu import has_cmd
 from avocado.utils import archive
 from avocado import skipUnless
-from avocado import skipUnless
-
-
-class AST1030Machine(QemuSystemTest):
-    """Boots the zephyr os and checks that the console is operational"""
-
-    timeout = 10
-
-    def test_ast1030_zephyros_1_04(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:ast1030-evb
-        :avocado: tags=os:zephyr
-        """
-        tar_url = ('https://github.com/AspeedTech-BMC'
-                   '/zephyr/releases/download/v00.01.04/ast1030-evb-demo.zip')
-        tar_hash = '4c6a8ce3a8ba76ef1a65dae419ae3409343c4b20'
-        tar_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        archive.extract(tar_path, self.workdir)
-        kernel_file = self.workdir + "/ast1030-evb-demo/zephyr.elf"
-        self.vm.set_console()
-        self.vm.add_args('-kernel', kernel_file,
-                         '-nographic')
-        self.vm.launch()
-        wait_for_console_pattern(self, "Booting Zephyr OS")
-        exec_command_and_wait_for_pattern(self, "help",
-                                          "Available commands")
-
-    def test_ast1030_zephyros_1_07(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:ast1030-evb
-        :avocado: tags=os:zephyr
-        """
-        tar_url = ('https://github.com/AspeedTech-BMC'
-                   '/zephyr/releases/download/v00.01.07/ast1030-evb-demo.zip')
-        tar_hash = '40ac87eabdcd3b3454ce5aad11fedc72a33ecda2'
-        tar_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        archive.extract(tar_path, self.workdir)
-        kernel_file = self.workdir + "/ast1030-evb-demo/zephyr.bin"
-        self.vm.set_console()
-        self.vm.add_args('-kernel', kernel_file,
-                         '-nographic')
-        self.vm.launch()
-        wait_for_console_pattern(self, "Booting Zephyr OS")
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
-class AST2x00Machine(QemuSystemTest):
-
-    timeout = 180
-
-    def wait_for_console_pattern(self, success_message, vm=None):
-        wait_for_console_pattern(self, success_message,
-                                 failure_message='Kernel panic - not syncing',
-                                 vm=vm)
-
-    def do_test_arm_aspeed(self, image):
-        self.vm.set_console()
-        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
-                         '-net', 'nic')
-        self.vm.launch()
-
-        self.wait_for_console_pattern("U-Boot 2016.07")
-        self.wait_for_console_pattern("## Loading kernel from FIT Image at 20080000")
-        self.wait_for_console_pattern("Starting kernel ...")
-        self.wait_for_console_pattern("Booting Linux on physical CPU 0x0")
-        wait_for_console_pattern(self,
-                "aspeed-smc 1e620000.spi: read control register: 203b0641")
-        self.wait_for_console_pattern("ftgmac100 1e660000.ethernet eth0: irq ")
-        self.wait_for_console_pattern("systemd[1]: Set hostname to")
-
-    def test_arm_ast2400_palmetto_openbmc_v2_9_0(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:palmetto-bmc
-        """
-
-        image_url = ('https://github.com/openbmc/openbmc/releases/download/2.9.0/'
-                     'obmc-phosphor-image-palmetto.static.mtd')
-        image_hash = ('3e13bbbc28e424865dc42f35ad672b10f2e82cdb11846bb28fa625b48beafd0d')
-        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
-                                      algorithm='sha256')
-
-        self.do_test_arm_aspeed(image_path)
-
-    def test_arm_ast2500_romulus_openbmc_v2_9_0(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:romulus-bmc
-        """
-
-        image_url = ('https://github.com/openbmc/openbmc/releases/download/2.9.0/'
-                     'obmc-phosphor-image-romulus.static.mtd')
-        image_hash = ('820341076803f1955bc31e647a512c79f9add4f5233d0697678bab4604c7bb25')
-        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
-                                      algorithm='sha256')
-
-        self.do_test_arm_aspeed(image_path)
-
-    def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'):
-        self.require_netdev('user')
-
-        self.vm.set_console()
-        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
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
-        time.sleep(0.1)
-        exec_command(self, 'root')
-        time.sleep(0.1)
-        exec_command(self, "passw0rd")
-
-    def do_test_arm_aspeed_buildroot_poweroff(self):
-        exec_command_and_wait_for_pattern(self, 'poweroff',
-                                          'reboot: System halted');
-
-    def test_arm_ast2500_evb_buildroot(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:ast2500-evb
-        """
-
-        image_url = ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
-                     'images/ast2500-evb/buildroot-2023.11/flash.img')
-        image_hash = ('c23db6160cf77d0258397eb2051162c8473a56c441417c52a91ba217186e715f')
-        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
-                                      algorithm='sha256')
-
-        self.vm.add_args('-device',
-                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
-        self.do_test_arm_aspeed_buildroot_start(image_path, '0x0', 'Aspeed AST2500 EVB')
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
-        self.do_test_arm_aspeed_buildroot_poweroff()
-
-    def test_arm_ast2600_evb_buildroot(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:ast2600-evb
-        """
-
-        image_url = ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
-                     'images/ast2600-evb/buildroot-2023.11/flash.img')
-        image_hash = ('b62808daef48b438d0728ee07662290490ecfa65987bb91294cafb1bb7ad1a68')
-        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
-                                      algorithm='sha256')
-
-        self.vm.add_args('-device',
-                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
-        self.vm.add_args('-device',
-                         'ds1338,bus=aspeed.i2c.bus.3,address=0x32');
-        self.vm.add_args('-device',
-                         'i2c-echo,bus=aspeed.i2c.bus.3,address=0x42');
-        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'Aspeed AST2600 EVB')
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
-        exec_command(self, 'i2cset -y 3 0x42 0x64 0x00 0xaa i');
-        time.sleep(0.1)
-        exec_command_and_wait_for_pattern(self,
-             'hexdump /sys/bus/i2c/devices/3-1064/slave-eeprom',
-             '0000000 ffaa ffff ffff ffff ffff ffff ffff ffff');
-        self.do_test_arm_aspeed_buildroot_poweroff()
-
-    @skipUnless(*has_cmd('swtpm'))
-    def test_arm_ast2600_evb_buildroot_tpm(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:ast2600-evb
-        """
-
-        image_url = ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
-                     'images/ast2600-evb/buildroot-2023.02-tpm/flash.img')
-        image_hash = ('a46009ae8a5403a0826d607215e731a8c68d27c14c41e55331706b8f9c7bd997')
-        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
-                                      algorithm='sha256')
-
-        # force creation of VM object, which also defines self._sd
-        vm = self.vm
-
-        socket = os.path.join(self._sd.name, 'swtpm-socket')
-
-        subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
-                        '--tpmstate', f'dir={self.vm.temp_dir}',
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
 
 class AST2x00MachineSDK(QemuSystemTest, LinuxSSHMixIn):
 
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index c90c02517a07..d4b534d33ff3 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -16,6 +16,7 @@ test_timeouts = {
   'aarch64_virt' : 360,
   'acpi_bits' : 240,
   'arm_raspi2' : 120,
+  'arm_aspeed' : 600,
   'mips_malta' : 120,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
@@ -54,6 +55,7 @@ tests_arm_system_thorough = [
   'arm_integratorcp',
   'arm_raspi2',
   'arm_vexpress',
+  'arm_aspeed',
 ]
 
 tests_arm_linuxuser_thorough = [
diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
new file mode 100644
index 000000000000..2f9a90f64d8f
--- /dev/null
+++ b/tests/functional/test_arm_aspeed.py
@@ -0,0 +1,269 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED SoCs with firmware
+#
+# Copyright (C) 2022 ASPEED Technology Inc
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import time
+import subprocess
+import tempfile
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import interrupt_interactive_console_until_pattern
+from qemu_test import exec_command
+from qemu_test import has_cmd
+from qemu_test.utils import archive_extract
+from zipfile import ZipFile
+from unittest import skipUnless
+
+class AST1030Machine(QemuSystemTest):
+
+    def test_ast1030_zephyros_1_04(self):
+        asset_url = Asset(
+            ('https://github.com/AspeedTech-BMC'
+             '/zephyr/releases/download/v00.01.04/ast1030-evb-demo.zip'),
+            '4ac6210adcbc61294927918707c6762483fd844dde5e07f3ba834ad1f91434d3')
+        kernel_name = "ast1030-evb-demo/zephyr.elf"
+        zip_file = asset_url.fetch()
+        with ZipFile(zip_file, 'r') as zf:
+                     zf.extract(kernel_name, path=self.workdir)
+        kernel_file = os.path.join(self.workdir, kernel_name)
+
+        self.set_machine('ast1030-evb')
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_file, '-nographic')
+        self.vm.launch()
+        wait_for_console_pattern(self, "Booting Zephyr OS")
+        exec_command_and_wait_for_pattern(self, "help",
+                                          "Available commands")
+
+    def test_ast1030_zephyros_1_07(self):
+        asset_url = Asset(
+            ('https://github.com/AspeedTech-BMC'
+             '/zephyr/releases/download/v00.01.07/ast1030-evb-demo.zip'),
+            'ad52e27959746988afaed8429bf4e12ab988c05c4d07c9d90e13ec6f7be4574c')
+        kernel_name = "ast1030-evb-demo/zephyr.bin"
+        zip_file = asset_url.fetch()
+        with ZipFile(zip_file, 'r') as zf:
+                     zf.extract(kernel_name, path=self.workdir)
+        kernel_file = os.path.join(self.workdir, kernel_name)
+
+        self.set_machine('ast1030-evb')
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_file, '-nographic')
+        self.vm.launch()
+        wait_for_console_pattern(self, "Booting Zephyr OS")
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
+class AST2x00Machine(QemuSystemTest):
+
+    def do_test_arm_aspeed(self, machine, image):
+        self.set_machine(machine)
+        self.vm.set_console()
+        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
+                         '-net', 'nic')
+        self.vm.launch()
+
+        wait_for_console_pattern(self, "U-Boot 2016.07")
+        wait_for_console_pattern(self, "## Loading kernel from FIT Image at 20080000")
+        wait_for_console_pattern(self, "Starting kernel ...")
+        wait_for_console_pattern(self, "Booting Linux on physical CPU 0x0")
+        wait_for_console_pattern(self,
+                "aspeed-smc 1e620000.spi: read control register: 203b0641")
+        wait_for_console_pattern(self, "ftgmac100 1e660000.ethernet eth0: irq ")
+        wait_for_console_pattern(self, "systemd[1]: Set hostname to")
+
+    def test_arm_ast2400_palmetto_openbmc_v2_9_0(self):
+        asset_url = Asset(
+            ('https://github.com/openbmc/openbmc/releases/download/2.9.0/'
+             'obmc-phosphor-image-palmetto.static.mtd'),
+            '3e13bbbc28e424865dc42f35ad672b10f2e82cdb11846bb28fa625b48beafd0d');
+        image_path = asset_url.fetch()
+
+        self.do_test_arm_aspeed('palmetto-bmc', image_path)
+
+    def test_arm_ast2500_romulus_openbmc_v2_9_0(self):
+        asset_url = Asset(
+            ('https://github.com/openbmc/openbmc/releases/download/2.9.0/'
+             'obmc-phosphor-image-romulus.static.mtd'),
+            '820341076803f1955bc31e647a512c79f9add4f5233d0697678bab4604c7bb25')
+        image_path = asset_url.fetch()
+
+        self.do_test_arm_aspeed('romulus-bmc', image_path)
+
+    def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'):
+        self.require_netdev('user')
+        self.vm.set_console()
+        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
+                         '-net', 'nic', '-net', 'user')
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'U-Boot 2019.04')
+        wait_for_console_pattern(self, '## Loading kernel from FIT Image')
+        wait_for_console_pattern(self, 'Starting kernel ...')
+        wait_for_console_pattern(self, 'Booting Linux on physical CPU ' + cpu_id)
+        wait_for_console_pattern(self, 'lease of 10.0.2.15')
+        # the line before login:
+        wait_for_console_pattern(self, pattern)
+        time.sleep(0.1)
+        exec_command(self, 'root')
+        time.sleep(0.1)
+        exec_command(self, "passw0rd")
+
+    def do_test_arm_aspeed_buildroot_poweroff(self):
+        exec_command_and_wait_for_pattern(self, 'poweroff',
+                                          'reboot: System halted');
+
+    def test_arm_ast2500_evb_buildroot(self):
+        asset_url = Asset(
+            ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
+             'images/ast2500-evb/buildroot-2023.11/flash.img'),
+            'c23db6160cf77d0258397eb2051162c8473a56c441417c52a91ba217186e715f')
+        image_path = asset_url.fetch()
+
+        self.set_machine('ast2500-evb')
+        self.vm.add_args('-device',
+                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
+        self.do_test_arm_aspeed_buildroot_start(image_path, '0x0',
+                                                'Aspeed AST2500 EVB')
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
+        self.do_test_arm_aspeed_buildroot_poweroff()
+
+    def test_arm_ast2600_evb_buildroot(self):
+        asset_url = Asset(
+            ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
+             'images/ast2600-evb/buildroot-2023.11/flash.img'),
+            'b62808daef48b438d0728ee07662290490ecfa65987bb91294cafb1bb7ad1a68')
+        image_path = asset_url.fetch()
+
+        self.set_machine('ast2600-evb')
+        self.vm.add_args('-device',
+                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
+        self.vm.add_args('-device',
+                         'ds1338,bus=aspeed.i2c.bus.3,address=0x32');
+        self.vm.add_args('-device',
+                         'i2c-echo,bus=aspeed.i2c.bus.3,address=0x42');
+        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'Aspeed AST2600 EVB')
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
+        exec_command(self, 'i2cset -y 3 0x42 0x64 0x00 0xaa i');
+        time.sleep(0.1)
+        exec_command_and_wait_for_pattern(self,
+             'hexdump /sys/bus/i2c/devices/3-1064/slave-eeprom',
+             '0000000 ffaa ffff ffff ffff ffff ffff ffff ffff');
+        self.do_test_arm_aspeed_buildroot_poweroff()
+
+    @skipUnless(*has_cmd('swtpm'))
+    def test_arm_ast2600_evb_buildroot_tpm(self):
+        asset_url = Asset(
+            ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
+             'images/ast2600-evb/buildroot-2023.02-tpm/flash.img'),
+            'a46009ae8a5403a0826d607215e731a8c68d27c14c41e55331706b8f9c7bd997')
+        image_path = asset_url.fetch()
+
+        socket_dir = tempfile.TemporaryDirectory(prefix="qemu_")
+        socket = os.path.join(socket_dir.name, 'swtpm-socket')
+
+        self.set_machine('ast2600-evb')
+
+        subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
+                        '--tpmstate', f'dir={self.vm.temp_dir}',
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
+class AST2x00MachineMMC(QemuSystemTest):
+
+    def test_arm_aspeed_emmc_boot(self):
+        asset_url = Asset(
+            ('https://fileserver.linaro.org/s/B6pJTwWEkzSDi36/download/'
+             'mmc-p10bmc-20240617.qcow2'),
+            'd523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b')
+        image_path = asset_url.fetch()
+
+        self.require_netdev('user')
+
+        self.set_machine('rainier-bmc')
+        self.vm.set_console()
+        self.vm.add_args('-drive',
+                         'file=' + image_path + ',if=sd,id=sd2,index=2',
+                         '-net', 'nic', '-net', 'user')
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'U-Boot SPL 2019.04')
+        wait_for_console_pattern(self, 'Trying to boot from MMC1')
+        wait_for_console_pattern(self, 'U-Boot 2019.04')
+        wait_for_console_pattern(self, 'eMMC 2nd Boot')
+        wait_for_console_pattern(self, '## Loading kernel from FIT Image')
+        wait_for_console_pattern(self, 'Starting kernel ...')
+        wait_for_console_pattern(self, 'Booting Linux on physical CPU 0xf00')
+        wait_for_console_pattern(self, 'mmcblk0: p1 p2 p3 p4 p5 p6 p7')
+        wait_for_console_pattern(self, 'IBM eBMC (OpenBMC for IBM Enterprise')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.47.0


