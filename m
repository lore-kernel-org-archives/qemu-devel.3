Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44108CAC5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 04:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyjKS-000503-0s; Tue, 16 Sep 2025 23:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyjKQ-0004zP-5J; Tue, 16 Sep 2025 23:59:34 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyjKN-0006g6-EG; Tue, 16 Sep 2025 23:59:33 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 17 Sep
 2025 11:59:18 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 17 Sep 2025 11:59:18 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <thuth@redhat.com>, Kane-Chen-AS
 <kane_chen@aspeedtech.com>
Subject: [PATCH v2 2/3] tests/functional/arm: Add AST1030 boot test with
 generated OTP image
Date: Wed, 17 Sep 2025 11:59:16 +0800
Message-ID: <20250917035917.4141723-3-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917035917.4141723-1-kane_chen@aspeedtech.com>
References: <20250917035917.4141723-1-kane_chen@aspeedtech.com>
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Add a functional test that boots an AST1030 machine with a generated
OTP image. The test verifies that OTP contents are read during early
boot and that the system reaches the expected console prompt.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 tests/functional/arm/test_aspeed_ast1030.py | 24 +++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast1030.py b/tests/functional/arm/test_aspeed_ast1030.py
index 42126b514f..e47b597d0b 100755
--- a/tests/functional/arm/test_aspeed_ast1030.py
+++ b/tests/functional/arm/test_aspeed_ast1030.py
@@ -7,17 +7,18 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
+from aspeed import AspeedTest
 from qemu_test import exec_command_and_wait_for_pattern
 
 
-class AST1030Machine(LinuxKernelTest):
+class AST1030Machine(AspeedTest):
 
     ASSET_ZEPHYR_3_02 = Asset(
         ('https://github.com/AspeedTech-BMC'
          '/zephyr/releases/download/v00.03.02/ast1030-evb-demo.zip'),
         '1ec83caab3ddd5d09481772801be7210e222cb015ce22ec6fffb8a76956dcd4f')
 
-    def test_ast1030_zephyros_3_02(self):
+    def test_arm_ast1030_zephyros_3_02(self):
         self.set_machine('ast1030-evb')
 
         kernel_name = "ast1030-evb-demo-3/zephyr.elf"
@@ -36,7 +37,7 @@ def test_ast1030_zephyros_3_02(self):
          '/zephyr/releases/download/v00.01.07/ast1030-evb-demo.zip'),
         'ad52e27959746988afaed8429bf4e12ab988c05c4d07c9d90e13ec6f7be4574c')
 
-    def test_ast1030_zephyros_1_07(self):
+    def test_arm_ast1030_zephyros_1_07(self):
         self.set_machine('ast1030-evb')
 
         kernel_name = "ast1030-evb-demo/zephyr.bin"
@@ -68,6 +69,21 @@ def test_ast1030_zephyros_1_07(self):
                 'kernel uptime',
         ]: exec_command_and_wait_for_pattern(self, shell_cmd, "uart:~$")
 
+    def test_arm_ast1030_otp_blockdev_device(self):
+        self.vm.set_machine("ast1030-evb")
+
+        kernel_name = "ast1030-evb-demo-3/zephyr.elf"
+        kernel_file = self.archive_extract(self.ASSET_ZEPHYR_3_02, member=kernel_name)
+        otp_img = self.generate_otpmem_image()
+
+        self.vm.set_console()
+        self.vm.add_args(
+            "-kernel", kernel_file,
+            "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
+            "-global", "aspeed-otp.drive=otp",
+        )
+        self.vm.launch()
+        self.wait_for_console_pattern("Booting Zephyr OS")
 
 if __name__ == '__main__':
-    LinuxKernelTest.main()
+    AspeedTest.main()
-- 
2.43.0


