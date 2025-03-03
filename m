Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5FBC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 09:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2Xb-0001Zx-1s; Mon, 03 Mar 2025 04:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tp2XW-00016D-Vh; Mon, 03 Mar 2025 04:56:47 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tp2XV-0001zJ-0P; Mon, 03 Mar 2025 04:56:46 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 3 Mar
 2025 17:55:05 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 3 Mar 2025 17:55:05 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v4 20/23] tests/functional/aspeed: Introduce
 start_ast2700_test API and update hwmon path
Date: Mon, 3 Mar 2025 17:54:48 +0800
Message-ID: <20250303095457.2337631-21-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
References: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Added a new method "start_ast2700_test" to the "AST2x00MachineSDK" class and
this method centralizes the logic for starting the AST2700 test, making it
reusable for different test cases.

Modified the hwmon path to use a wildcard to handle different SDK versions:
"cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input".

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/functional/test_aarch64_aspeed.py | 33 +++++++++++++------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
index 9595498ace..07b0c7c1fd 100755
--- a/tests/functional/test_aarch64_aspeed.py
+++ b/tests/functional/test_aarch64_aspeed.py
@@ -31,33 +31,29 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.03/ast2700-default-obmc.tar.gz',
             '91225f50d255e2905ba8d8e0c80b71b9d157c3609770c7a740cd786370d85a77')
 
-    def test_aarch64_ast2700_evb_sdk_v09_03(self):
-        self.set_machine('ast2700-evb')
-
-        self.archive_extract(self.ASSET_SDK_V903_AST2700)
-
+    def start_ast2700_test(self, name):
         num_cpu = 4
-        uboot_size = os.path.getsize(self.scratch_file('ast2700-default',
+        uboot_size = os.path.getsize(self.scratch_file(name,
                                                        'u-boot-nodtb.bin'))
         uboot_dtb_load_addr = hex(0x400000000 + uboot_size)
 
         load_images_list = [
             {
                 'addr': '0x400000000',
-                'file': self.scratch_file('ast2700-default',
+                'file': self.scratch_file(name,
                                           'u-boot-nodtb.bin')
             },
             {
                 'addr': str(uboot_dtb_load_addr),
-                'file': self.scratch_file('ast2700-default', 'u-boot.dtb')
+                'file': self.scratch_file(name, 'u-boot.dtb')
             },
             {
                 'addr': '0x430000000',
-                'file': self.scratch_file('ast2700-default', 'bl31.bin')
+                'file': self.scratch_file(name, 'bl31.bin')
             },
             {
                 'addr': '0x430080000',
-                'file': self.scratch_file('ast2700-default', 'optee',
+                'file': self.scratch_file(name, 'optee',
                                           'tee-raw.bin')
             }
         ]
@@ -76,23 +72,28 @@ def test_aarch64_ast2700_evb_sdk_v09_03(self):
         self.vm.add_args('-device',
                          'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
         self.do_test_aarch64_aspeed_sdk_start(
-            self.scratch_file('ast2700-default', 'image-bmc'))
+            self.scratch_file(name, 'image-bmc'))
 
-        wait_for_console_pattern(self, 'ast2700-default login:')
+        wait_for_console_pattern(self, f'{name} login:')
 
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
-        exec_command_and_wait_for_pattern(self,
-            '0penBmc', 'root@ast2700-default:~#')
+        exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
 
         exec_command_and_wait_for_pattern(self,
             'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device ',
             'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d');
         exec_command_and_wait_for_pattern(self,
-            'cat /sys/class/hwmon/hwmon20/temp1_input', '0')
+            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '0')
         self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
                     property='temperature', value=18000)
         exec_command_and_wait_for_pattern(self,
-            'cat /sys/class/hwmon/hwmon20/temp1_input', '18000')
+            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '18000')
+
+    def test_aarch64_ast2700_evb_sdk_v09_03(self):
+        self.set_machine('ast2700-evb')
+
+        self.archive_extract(self.ASSET_SDK_V903_AST2700)
+        self.start_ast2700_test('ast2700-default')
 
 
 if __name__ == '__main__':
-- 
2.34.1


