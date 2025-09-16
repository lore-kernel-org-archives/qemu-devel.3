Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65C3CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyQg5-0004lH-Mv; Tue, 16 Sep 2025 04:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyQfx-0004eR-VN; Tue, 16 Sep 2025 04:04:34 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyQfv-0002G3-I1; Tue, 16 Sep 2025 04:04:33 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 16 Sep
 2025 16:04:07 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 16 Sep 2025 16:04:07 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <thuth@redhat.com>, Kane-Chen-AS
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 2/3] tests/functional/arm: Add AST1030 boot test with
 generated OTP image
Date: Tue, 16 Sep 2025 16:04:04 +0800
Message-ID: <20250916080406.2430111-3-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916080406.2430111-1-kane_chen@aspeedtech.com>
References: <20250916080406.2430111-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
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
 tests/functional/arm/test_aspeed_ast1030.py | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast1030.py b/tests/functional/arm/test_aspeed_ast1030.py
index 42126b514f..2cad85c196 100755
--- a/tests/functional/arm/test_aspeed_ast1030.py
+++ b/tests/functional/arm/test_aspeed_ast1030.py
@@ -7,10 +7,11 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
+from aspeed import AspeedTest
 from qemu_test import exec_command_and_wait_for_pattern
 
 
-class AST1030Machine(LinuxKernelTest):
+class AST1030Machine(AspeedTest):
 
     ASSET_ZEPHYR_3_02 = Asset(
         ('https://github.com/AspeedTech-BMC'
@@ -68,6 +69,21 @@ def test_ast1030_zephyros_1_07(self):
                 'kernel uptime',
         ]: exec_command_and_wait_for_pattern(self, shell_cmd, "uart:~$")
 
+    def test_ast1030_otp_blockdev_device(self):
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


