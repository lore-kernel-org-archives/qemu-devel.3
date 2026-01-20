Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C404D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 05:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi4BB-0001G7-Oh; Tue, 20 Jan 2026 00:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vi4B3-0000yM-M1; Tue, 20 Jan 2026 00:21:19 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vi4B2-00053q-0i; Tue, 20 Jan 2026 00:21:17 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 Jan
 2026 13:19:08 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 Jan 2026 13:19:08 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v5 21/22] test/functional/aarch64: Parameterize I2C bus ID in
 AST2700 test
Date: Tue, 20 Jan 2026 13:18:52 +0800
Message-ID: <20260120051859.1920565-22-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
References: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

The current Aspeed AST2700 functional test case strictly uses I2C bus
1 for its sensor tests. This hard-coded approach prevents the test
logic from being reused for other machine types or configurations
where I2C bus 1 might be disabled or where a different bus needs to
be verified (e.g., I2C expanders).

This refactoring allows the same I2C verification logic to be shared
across different test scenarios by simply passing the target bus
number.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 .../functional/aarch64/test_aspeed_ast2700.py | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index 0ced1a2502..438f7eb37c 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -15,11 +15,12 @@
 
 class AST2x00MachineSDK(QemuSystemTest):
 
-    def do_test_aarch64_aspeed_sdk_start(self, image):
+    def do_test_aarch64_aspeed_sdk_start(self, image, bus_id):
+        bus_str = str(bus_id)
         self.require_netdev('user')
         self.vm.set_console()
         self.vm.add_args('-device',
-                         'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
+                         f'tmp105,bus=aspeed.i2c.bus.{bus_str},address=0x4d,id=tmp-test-{bus_str}')
         self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
                          '-net', 'nic', '-net', 'user', '-snapshot')
 
@@ -53,16 +54,17 @@ def verify_openbmc_boot_and_login(self, name):
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2700-default-obmc.tar.gz',
             'eac3dc409b7ea3cd4b03d4792d3cebd469792ad893cb51e1d15f0fc20bd1e2cd')
 
-    def do_ast2700_i2c_test(self):
+    def do_ast2700_i2c_test(self, bus_id):
+        bus_str = str(bus_id)
         exec_command_and_wait_for_pattern(self,
-            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device ',
-            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d')
+            f'echo lm75 0x4d > /sys/class/i2c-dev/i2c-{bus_str}/device/new_device ',
+            f'i2c i2c-{bus_str}: new_device: Instantiated device lm75 at 0x4d')
         exec_command_and_wait_for_pattern(self,
-            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '0')
-        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
+            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_input', '0')
+        self.vm.cmd('qom-set', path=f'/machine/peripheral/tmp-test-{bus_str}',
                     property='temperature', value=18000)
         exec_command_and_wait_for_pattern(self,
-            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '18000')
+            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_input', '18000')
 
     def do_ast2700_pcie_test(self):
         exec_command_and_wait_for_pattern(self,
@@ -116,12 +118,12 @@ def start_ast2700_test(self, name):
 
         self.vm.add_args('-smp', str(num_cpu))
         self.do_test_aarch64_aspeed_sdk_start(
-            self.scratch_file(name, 'image-bmc'))
+            self.scratch_file(name, 'image-bmc'), 1)
 
-    def start_ast2700_test_vbootrom(self, name):
+    def start_ast2700_test_vbootrom(self, name, bus_id):
         self.vm.add_args('-bios', 'ast27x0_bootrom.bin')
         self.do_test_aarch64_aspeed_sdk_start(
-                self.scratch_file(name, 'image-bmc'))
+                self.scratch_file(name, 'image-bmc'), bus_id)
 
     def test_aarch64_ast2700a1_evb_sdk_v09_08(self):
         self.set_machine('ast2700a1-evb')
@@ -132,7 +134,7 @@ def test_aarch64_ast2700a1_evb_sdk_v09_08(self):
         self.vm.add_args('-netdev', 'user,id=net1')
         self.start_ast2700_test('ast2700-default')
         self.verify_openbmc_boot_and_login('ast2700-default')
-        self.do_ast2700_i2c_test()
+        self.do_ast2700_i2c_test(1)
         self.do_ast2700_pcie_test()
 
     def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_08(self):
@@ -142,7 +144,7 @@ def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_08(self):
         self.archive_extract(self.ASSET_SDK_V908_AST2700A1)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
-        self.start_ast2700_test_vbootrom('ast2700-default')
+        self.start_ast2700_test_vbootrom('ast2700-default', 1)
         self.verify_vbootrom_firmware_flow()
         self.verify_openbmc_boot_start()
 
-- 
2.43.0


