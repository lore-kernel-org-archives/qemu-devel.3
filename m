Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA68E65D35
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 09:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEPa2-0005h5-OG; Fri, 22 Nov 2024 04:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tEPZz-0005Yz-QW
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 04:03:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tEPZx-0007io-Qg
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 04:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732266233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nev+u7GyGdCHE5hv80G3nO4d4cH3yj3Bu5EOasMDJc=;
 b=EmJ58cC8ztYp0EtI8uElBEG97+U/O4UN3lAdoNH3zxIvYomtFjIw2lWuwbFUAwgJuHx6pv
 5JyDlO11JI4MSp2pwaZV65v2cdI8Nefy60t1kC9kXdWb4JNZY/ledAwxoZLZU82I4/QqD2
 ISukLHHIqmeP2+oMe2c7r7oevftKd9U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-wtxcHaGbNWC_zI_zgShHGg-1; Fri,
 22 Nov 2024 04:03:49 -0500
X-MC-Unique: wtxcHaGbNWC_zI_zgShHGg-1
X-Mimecast-MFC-AGG-ID: wtxcHaGbNWC_zI_zgShHGg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6572E19560AF; Fri, 22 Nov 2024 09:03:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.194.14])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34DC71955F3E; Fri, 22 Nov 2024 09:03:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 2/3] tests/functional: Convert Aspeed arm SDK tests
Date: Fri, 22 Nov 2024 10:03:21 +0100
Message-ID: <20241122090322.1934697-3-clg@redhat.com>
In-Reply-To: <20241122090322.1934697-1-clg@redhat.com>
References: <20241122090322.1934697-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Drop the SSH connection which was introduced in the avocado tests to
workaround read issues when interacting with console.

EXTRA_BOOTARGS was introduced to reduce the console output at Linux
boot time. This didn't have the desired effect as we still had issues
when trying to match patterns on the console and we had to use the ssh
connection as a workaround.

While at it, remove the U-Boot EXTRA_BOOTARGS variable which has
become useless.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/machine_aspeed.py     | 124 ----------------------------
 tests/functional/test_arm_aspeed.py |  68 +++++++++++++++
 2 files changed, 68 insertions(+), 124 deletions(-)
 delete mode 100644 tests/avocado/machine_aspeed.py

diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
deleted file mode 100644
index 2240c82abff9..000000000000
--- a/tests/avocado/machine_aspeed.py
+++ /dev/null
@@ -1,124 +0,0 @@
-# Functional test that boots the ASPEED SoCs with firmware
-#
-# Copyright (C) 2022 ASPEED Technology Inc
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-import time
-import os
-import tempfile
-import subprocess
-
-from avocado_qemu import LinuxSSHMixIn
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado_qemu import exec_command
-from avocado_qemu import exec_command_and_wait_for_pattern
-from avocado_qemu import interrupt_interactive_console_until_pattern
-from avocado_qemu import has_cmd
-from avocado.utils import archive
-from avocado import skipUnless
-
-class AST2x00MachineSDK(QemuSystemTest, LinuxSSHMixIn):
-
-    EXTRA_BOOTARGS = (
-        'quiet '
-        'systemd.mask=org.openbmc.HostIpmi.service '
-        'systemd.mask=xyz.openbmc_project.Chassis.Control.Power@0.service '
-        'systemd.mask=modprobe@fuse.service '
-        'systemd.mask=rngd.service '
-        'systemd.mask=obmc-console@ttyS2.service '
-    )
-
-    # FIXME: Although these tests boot a whole distro they are still
-    # slower than comparable machine models. There may be some
-    # optimisations which bring down the runtime. In the meantime they
-    # have generous timeouts and are disable for CI which aims for all
-    # tests to run in less than 60 seconds.
-    timeout = 240
-
-    def wait_for_console_pattern(self, success_message, vm=None):
-        wait_for_console_pattern(self, success_message,
-                                 failure_message='Kernel panic - not syncing',
-                                 vm=vm)
-
-    def do_test_arm_aspeed_sdk_start(self, image):
-        self.require_netdev('user')
-        self.vm.set_console()
-        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
-                         '-net', 'nic', '-net', 'user,hostfwd=:127.0.0.1:0-:22')
-        self.vm.launch()
-
-        self.wait_for_console_pattern('U-Boot 2019.04')
-        interrupt_interactive_console_until_pattern(
-            self, 'Hit any key to stop autoboot:', 'ast#')
-        exec_command_and_wait_for_pattern(
-            self, 'setenv bootargs ${bootargs} ' + self.EXTRA_BOOTARGS, 'ast#')
-        exec_command_and_wait_for_pattern(
-            self, 'boot', '## Loading kernel from FIT Image')
-        self.wait_for_console_pattern('Starting kernel ...')
-
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-    def test_arm_ast2500_evb_sdk(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:ast2500-evb
-        :avocado: tags=flaky
-        """
-
-        image_url = ('https://github.com/AspeedTech-BMC/openbmc/releases/'
-                     'download/v08.06/ast2500-default-obmc.tar.gz')
-        image_hash = ('e1755f3cadff69190438c688d52dd0f0d399b70a1e14b1d3d5540fc4851d38ca')
-        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
-                                      algorithm='sha256')
-        archive.extract(image_path, self.workdir)
-
-        self.do_test_arm_aspeed_sdk_start(
-            self.workdir + '/ast2500-default/image-bmc')
-        self.wait_for_console_pattern('nodistro.0 ast2500-default ttyS4')
-
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-    def test_arm_ast2600_evb_sdk(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:ast2600-evb
-        :avocado: tags=flaky
-        """
-
-        image_url = ('https://github.com/AspeedTech-BMC/openbmc/releases/'
-                     'download/v08.06/ast2600-a2-obmc.tar.gz')
-        image_hash = ('9083506135f622d5e7351fcf7d4e1c7125cee5ba16141220c0ba88931f3681a4')
-        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
-                                      algorithm='sha256')
-        archive.extract(image_path, self.workdir)
-
-        self.vm.add_args('-device',
-                         'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test');
-        self.vm.add_args('-device',
-                         'ds1338,bus=aspeed.i2c.bus.5,address=0x32');
-        self.do_test_arm_aspeed_sdk_start(
-            self.workdir + '/ast2600-a2/image-bmc')
-        self.wait_for_console_pattern('nodistro.0 ast2600-a2 ttyS4')
-
-        self.ssh_connect('root', '0penBmc', False)
-        self.ssh_command('dmesg -c > /dev/null')
-
-        self.ssh_command_output_contains(
-             'echo lm75 0x4d > /sys/class/i2c-dev/i2c-5/device/new_device ; '
-             'dmesg -c',
-             'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d');
-        self.ssh_command_output_contains(
-                             'cat /sys/class/hwmon/hwmon19/temp1_input', '0')
-        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
-                    property='temperature', value=18000);
-        self.ssh_command_output_contains(
-                             'cat /sys/class/hwmon/hwmon19/temp1_input', '18000')
-
-        self.ssh_command_output_contains(
-             'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-5/device/new_device ; '
-             'dmesg -c',
-             'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32');
-        year = time.strftime("%Y")
-        self.ssh_command_output_contains('/sbin/hwclock -f /dev/rtc1', year);
-
diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
index 5fb1adf46439..c2c152229b78 100755
--- a/tests/functional/test_arm_aspeed.py
+++ b/tests/functional/test_arm_aspeed.py
@@ -252,6 +252,74 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
 
         self.do_test_arm_aspeed_buildroot_poweroff()
 
+    def do_test_arm_aspeed_sdk_start(self, image):
+        self.require_netdev('user')
+        self.vm.set_console()
+        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
+                         '-net', 'nic', '-net', 'user', '-snapshot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('U-Boot 2019.04')
+        self.wait_for_console_pattern('## Loading kernel from FIT Image')
+        self.wait_for_console_pattern('Starting kernel ...')
+
+    ASSET_SDK_V806_AST2500 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v08.06/ast2500-default-obmc.tar.gz',
+        'e1755f3cadff69190438c688d52dd0f0d399b70a1e14b1d3d5540fc4851d38ca')
+
+    def test_arm_ast2500_evb_sdk(self):
+        self.set_machine('ast2500-evb')
+
+        image_path = self.ASSET_SDK_V806_AST2500.fetch()
+
+        archive_extract(image_path, self.workdir)
+
+        self.do_test_arm_aspeed_sdk_start(
+            self.workdir + '/ast2500-default/image-bmc')
+
+        self.wait_for_console_pattern('ast2500-default login:')
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
+
 class AST2x00MachineMMC(LinuxKernelTest):
 
     ASSET_RAINIER_EMMC = Asset(
-- 
2.47.0


