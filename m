Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367D2D58D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFaz9-0007jC-Iw; Mon, 25 Nov 2024 10:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFayo-0006zv-G2
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:27 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFaym-0002Z8-3m
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:26 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a2f3bae4so3268185e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548380; x=1733153180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7UAnsHqaDmxl6AZGGFsULH2SSaadxWmdCZAtd1JK2s=;
 b=gDN3/a28knBp5e1pPEGJTslUrF/3qJcXTHbXy12kKmYWaEnuMA44SWSfu13w1Y9gQU
 VMSuXaFDIjob4hJPRCUicsy5V7rw1FoV+n5b5ktHY5E3nRPdOlfjG2wVOzfPriKuFOlW
 ZoHq2/uXmqiEK4hfeWmWz3jL5RqKiJveJpScQnMOSHIlyJNgsHBvE1wbD76Dk8QUjl+6
 iKrTISfCN2AuWB9BH2y0biSIWyjDelyzXCUrTMK6v4ZXpnST1vQbDpF1c+Ea/dv5dydr
 pfOcVWDCzVJ1VqzVbjohcaspUMixctptubGzXGGIuOpwmVNBEtDwFqOXex6O3jeG/MbF
 W+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548380; x=1733153180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7UAnsHqaDmxl6AZGGFsULH2SSaadxWmdCZAtd1JK2s=;
 b=b2nbP0mOFEi5t9B5dwcYPoUj+SSixQLUYefWBtZ1scA7pccwfmwoMX76P7GwdQoE6c
 dFHrckvy+0kp4DcNhWeX3qcLyWkkUXWPOWp5qXEPWYj28ck+L5F/hPOBkquaZlAoME2r
 AV2KHIZWFprUnN3l/wBmn1fwVq1HdXf2yo4Dak1VzszwLCibwQ2BaOhwG4lbYmm1x5e7
 bcrsxJIyjfqiMDMNlxHeuL9SVCRm5v5iH8stQK0Yb7xFwTSrhlN5NioECsaDcWNMXEMK
 kYwE5l/BBzpDCjj7Z8CdDCVNv6htIGy63Mx8aZAI+yE7T0l6HWcsNgFRuu1oNl9H5Z16
 SZfg==
X-Gm-Message-State: AOJu0YxYs5asffkBHYvVcNP3uCYUGUtwXr22QsohCltqmFSoBBPB4Wi+
 DO0rWZd7t5CXgysyZX+z/fRfzNF2Ha3/4znhq4bgHRcpALZ+AqRTs9Q+xCivpG3ksS+iUwPJdPu
 Q
X-Gm-Gg: ASbGncsqfq78schakQY/A/dnkQ78QEJEjg2TqoZx9KsWoj/yB0ynxK3GzYLAtuTiME5
 m/UexpSk8rlg5YyG+YS8tzHxGYdg3+XY9SyOFPwcjrduAC+WSua0LmXvrpRRM7j1gveWxGaCazZ
 BcMUMyau6r6UApbq12pUSTbyP1Fav0QGwMqlVd5/4ldSE+wZ9eIULOMBI3NzRLVX5HfaK2llh/h
 6kSWYWFbkvo1xFHEgZWTzW/qnHjJD3EGUZRWGQse49ReUpF
X-Google-Smtp-Source: AGHT+IF34VEFuVBjw+i6ru2KJNRvIVH/JuRrs+foXlqeGcnQdPd5RYB8lQ9/i1krvX11GgeC4Ljgqg==
X-Received: by 2002:a5d:5f4b:0:b0:382:1831:f7db with SMTP id
 ffacd0b85a97d-38260b59bc9mr10841842f8f.19.1732548380448; 
 Mon, 25 Nov 2024 07:26:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fafe338sm10582103f8f.33.2024.11.25.07.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:26:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 467D863A55;
 Mon, 25 Nov 2024 15:21:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org (open list:ASPEED BMCs)
Subject: [PULL 27/28] tests/functional: Convert Aspeed arm SDK tests
Date: Mon, 25 Nov 2024 15:21:04 +0000
Message-Id: <20241125152105.2100395-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

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
Message-Id: <20241122090322.1934697-3-clg@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
deleted file mode 100644
index 2240c82abf..0000000000
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
index 5fb1adf464..c2c152229b 100755
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
2.39.5


