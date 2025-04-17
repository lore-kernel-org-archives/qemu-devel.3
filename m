Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF15FC369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 03:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Fg9-00014X-39; Wed, 16 Apr 2025 23:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u5Fg2-0000xX-Ur; Wed, 16 Apr 2025 23:12:34 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u5Fg1-0000cO-9B; Wed, 16 Apr 2025 23:12:34 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 17 Apr
 2025 11:12:11 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 17 Apr 2025 11:12:11 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>
Subject: [PATCH v4 07/10] tests/functional/aspeed: Move I2C test into shared
 helper for AST2700 reuse
Date: Thu, 17 Apr 2025 11:12:04 +0800
Message-ID: <20250417031209.2647703-8-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417031209.2647703-1-jamin_lin@aspeedtech.com>
References: <20250417031209.2647703-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the I2C test case into a common helper function (do_ast2700_i2c_test) so it
can be reused across multiple AST2700-based test cases. This reduces duplication
and improves maintainability.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/functional/test_aarch64_aspeed.py | 28 +++++++++++++------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
index c25c966278..441f7f3919 100755
--- a/tests/functional/test_aarch64_aspeed.py
+++ b/tests/functional/test_aarch64_aspeed.py
@@ -18,6 +18,8 @@ class AST2x00MachineSDK(QemuSystemTest):
     def do_test_aarch64_aspeed_sdk_start(self, image):
         self.require_netdev('user')
         self.vm.set_console()
+        self.vm.add_args('-device',
+                         'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
         self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
                          '-net', 'nic', '-net', 'user', '-snapshot')
 
@@ -35,6 +37,17 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.05/ast2700-default-obmc.tar.gz',
             'c1f4496aec06743c812a6e9a1a18d032f34d62f3ddb6956e924fef62aa2046a5')
 
+    def do_ast2700_i2c_test(self):
+        exec_command_and_wait_for_pattern(self,
+            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device ',
+            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d');
+        exec_command_and_wait_for_pattern(self,
+            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '0')
+        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
+                    property='temperature', value=18000)
+        exec_command_and_wait_for_pattern(self,
+            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '18000')
+
     def start_ast2700_test(self, name):
         num_cpu = 4
         uboot_size = os.path.getsize(self.scratch_file(name,
@@ -73,8 +86,6 @@ def start_ast2700_test(self, name):
                              f'loader,addr=0x430000000,cpu-num={i}')
 
         self.vm.add_args('-smp', str(num_cpu))
-        self.vm.add_args('-device',
-                         'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
         self.do_test_aarch64_aspeed_sdk_start(
             self.scratch_file(name, 'image-bmc'))
 
@@ -83,28 +94,19 @@ def start_ast2700_test(self, name):
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
 
-        exec_command_and_wait_for_pattern(self,
-            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device ',
-            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d');
-        exec_command_and_wait_for_pattern(self,
-            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '0')
-        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
-                    property='temperature', value=18000)
-        exec_command_and_wait_for_pattern(self,
-            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '18000')
-
     def test_aarch64_ast2700_evb_sdk_v09_05(self):
         self.set_machine('ast2700-evb')
 
         self.archive_extract(self.ASSET_SDK_V905_AST2700)
         self.start_ast2700_test('ast2700-a0-default')
+        self.do_ast2700_i2c_test()
 
     def test_aarch64_ast2700a1_evb_sdk_v09_05(self):
         self.set_machine('ast2700a1-evb')
 
         self.archive_extract(self.ASSET_SDK_V905_AST2700A1)
         self.start_ast2700_test('ast2700-default')
-
+        self.do_ast2700_i2c_test()
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.43.0


