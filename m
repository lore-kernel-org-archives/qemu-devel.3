Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E92E73165
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 02:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn5qz-0002YM-Vo; Mon, 02 Feb 2026 21:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5qx-0002Xa-T7; Mon, 02 Feb 2026 21:09:19 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5qw-0006uM-Fn; Mon, 02 Feb 2026 21:09:19 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 10:08:57 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 10:08:57 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v2 5/8] tests/functional/aarch64/test_aspeed_ast2700: Enable
 PCIe2 DTS status for AST2700 tests
Date: Tue, 3 Feb 2026 10:08:50 +0800
Message-ID: <20260203020855.1642884-6-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203020855.1642884-1-jamin_lin@aspeedtech.com>
References: <20260203020855.1642884-1-jamin_lin@aspeedtech.com>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PCIe2 is disabled by default starting from SDK v10.00.

Add a helper function to stop U-Boot autoboot and update the device
tree at runtime, setting the PCIe2 node status to "okay" before
booting Linux. This allows the AST2700 functional test to verify
the PCIe2 root complex behavior correctly.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 .../functional/aarch64/test_aspeed_ast2700.py  | 18 ++++++++++++++++--
 .../aarch64/test_aspeed_ast2700fc.py           | 18 ++++++++++++++++--
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index 0ced1a2502..1f1b5749f4 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -9,7 +9,7 @@
 import os
 
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import wait_for_console_pattern, exec_command
 from qemu_test import exec_command_and_wait_for_pattern
 
 
@@ -37,9 +37,23 @@ def verify_vbootrom_firmware_flow(self):
         wait_for_console_pattern(self, 'done')
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-A)')
 
+    def enable_ast2700_pcie2(self):
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')
+        exec_command_and_wait_for_pattern(self, '\012', '=>')
+        exec_command_and_wait_for_pattern(self,
+            'cp 100420000 403000000 900000', '=>')
+        exec_command_and_wait_for_pattern(self,
+            'bootm start 403000000', '=>')
+        exec_command_and_wait_for_pattern(self, 'bootm loados', '=>')
+        exec_command_and_wait_for_pattern(self, 'bootm ramdisk', '=>')
+        exec_command_and_wait_for_pattern(self, 'bootm prep', '=>')
+        exec_command_and_wait_for_pattern(self,
+            'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=>')
+        exec_command(self, 'bootm go')
+
     def verify_openbmc_boot_start(self):
         wait_for_console_pattern(self, 'U-Boot 2023.10')
-        wait_for_console_pattern(self, '## Loading kernel from FIT Image')
+        self.enable_ast2700_pcie2()
         wait_for_console_pattern(self, 'Linux version ')
 
     def verify_openbmc_boot_and_login(self, name):
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
index 8dbc8f234f..a1d8046f58 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
@@ -9,7 +9,7 @@
 import os
 
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import wait_for_console_pattern, exec_command
 from qemu_test import exec_command_and_wait_for_pattern
 
 
@@ -27,9 +27,23 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
 
         self.vm.launch()
 
+    def enable_ast2700_pcie2(self):
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')
+        exec_command_and_wait_for_pattern(self, '\012', '=>')
+        exec_command_and_wait_for_pattern(self,
+            'cp 100420000 403000000 900000', '=>')
+        exec_command_and_wait_for_pattern(self,
+            'bootm start 403000000', '=>')
+        exec_command_and_wait_for_pattern(self, 'bootm loados', '=>')
+        exec_command_and_wait_for_pattern(self, 'bootm ramdisk', '=>')
+        exec_command_and_wait_for_pattern(self, 'bootm prep', '=>')
+        exec_command_and_wait_for_pattern(self,
+            'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=>')
+        exec_command(self, 'bootm go')
+
     def verify_openbmc_boot_and_login(self, name):
         wait_for_console_pattern(self, 'U-Boot 2023.10')
-        wait_for_console_pattern(self, '## Loading kernel from FIT Image')
+        self.enable_ast2700_pcie2()
         wait_for_console_pattern(self, 'Starting kernel ...')
 
         wait_for_console_pattern(self, f'{name} login:')
-- 
2.43.0


