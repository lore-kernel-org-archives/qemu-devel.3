Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26952C71159
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 06:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS8y4-0002YV-Ro; Thu, 19 Jun 2025 02:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uS8xz-0002Xa-AH; Thu, 19 Jun 2025 02:41:46 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uS8xx-0001s1-3q; Thu, 19 Jun 2025 02:41:42 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 19 Jun
 2025 14:41:17 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 19 Jun 2025 14:41:17 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [RFC v5 4/4] tests/functional: Add integration tests for ASPEED OTP
 memory model
Date: Thu, 19 Jun 2025 14:41:13 +0800
Message-ID: <20250619064115.4182202-5-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619064115.4182202-1-kane_chen@aspeedtech.com>
References: <20250619064115.4182202-1-kane_chen@aspeedtech.com>
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

Introduce a functional test suite to validate the ASPEED OTP memory
device integration under different machine configurations.

The following cases are covered:
- AST2600 with blockdev + device + machine parameter (full binding)
- AST2600 fallback with no machine parameter
- AST2600 with only blockdev + device (no machine param)
- AST2600 with only machine parameter (no backend/device)
- AST1030 fallback test with Zephyr-based image

The tests ensure that the OTP model behaves correctly across boot-time
binding variations and fallback paths, and that firmware boot is
successful under each condition.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 tests/functional/meson.build           |  1 +
 tests/functional/test_aspeed_otpmem.py | 82 ++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 tests/functional/test_aspeed_otpmem.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index e9f19d54a2..ce999eeab1 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -41,6 +41,7 @@ test_timeouts = {
   'arm_replay' : 240,
   'arm_tuxrun' : 240,
   'arm_sx1' : 360,
+  'aspeed_otpmem': 1200,
   'intel_iommu': 300,
   'mips_malta' : 480,
   'mipsel_malta' : 420,
diff --git a/tests/functional/test_aspeed_otpmem.py b/tests/functional/test_aspeed_otpmem.py
new file mode 100644
index 0000000000..67d2a7ecf6
--- /dev/null
+++ b/tests/functional/test_aspeed_otpmem.py
@@ -0,0 +1,82 @@
+
+import os
+import time
+import tempfile
+import subprocess
+
+from qemu_test import LinuxKernelTest, Asset
+from aspeed import AspeedTest
+from qemu_test import exec_command_and_wait_for_pattern, skipIfMissingCommands
+
+class AspeedOtpMemoryTest(AspeedTest):
+    # AST2600 SDK image
+    ASSET_SDK_V906_AST2600 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.06/ast2600-default-obmc.tar.gz',
+        '768d76e247896ad78c154b9cff4f766da2ce65f217d620b286a4a03a8a4f68f5')
+
+    # AST1030 Zephyr image
+    ASSET_ZEPHYR_3_00 = Asset(
+        ('https://github.com/AspeedTech-BMC'
+         '/zephyr/releases/download/v00.03.00/ast1030-evb-demo.zip'),
+        '37fe3ecd4a1b9d620971a15b96492a81093435396eeac69b6f3e384262ff555f')
+    def generate_otpmem_image(self):
+        path = self.scratch_file("otpmem.img")
+        pattern = b'\x00\x00\x00\x00\xff\xff\xff\xff' * (16 * 1024 // 8)
+        with open(path, "wb") as f:
+            f.write(pattern)
+        return path
+
+    def test_ast2600_otp_fallback(self):
+        image_path = self.archive_extract(self.ASSET_SDK_V906_AST2600)
+        bmc_image = self.scratch_file("ast2600-default", "image-bmc")
+        self.vm.set_machine("ast2600-evb")
+        self.vm.set_console()
+        self.do_test_arm_aspeed_sdk_start(
+            self.scratch_file("ast2600-default", "image-bmc"))
+        self.wait_for_console_pattern('ast2600-default login:')
+
+    def test_ast2600_otp_blockdev_device(self):
+        image_path = self.archive_extract(self.ASSET_SDK_V906_AST2600)
+        otp_img = self.generate_otpmem_image()
+        self.vm.set_console()
+        self.vm.add_args(
+            "-blockdev", f"node-name=otpmem,driver=file,filename={otp_img}",
+            "-device", "aspeed.otpmem,drive=otpmem,id=otpmem-drive",
+            "-machine", "ast2600-evb,otpmem=otpmem-drive"
+        )
+        self.do_test_arm_aspeed_sdk_start(self.scratch_file("ast2600-default", "image-bmc"))
+        self.wait_for_console_pattern("ast2600-default login:")
+
+    def test_ast2600_otp_only_blockdev(self):
+        image_path = self.archive_extract(self.ASSET_SDK_V906_AST2600)
+        otp_img = self.generate_otpmem_image()
+        self.vm.set_machine("ast2600-evb")
+        self.vm.set_console()
+        self.vm.add_args(
+            "-blockdev", f"node-name=otpmem,driver=file,filename={otp_img}",
+            "-device", "aspeed.otpmem,drive=otpmem,id=otpmem-drive",
+        )
+        self.do_test_arm_aspeed_sdk_start(self.scratch_file("ast2600-default", "image-bmc"))
+        self.wait_for_console_pattern("ast2600-default login:")
+
+    def test_ast2600_otp_only_machine_param(self):
+        image_path = self.archive_extract(self.ASSET_SDK_V906_AST2600)
+        self.vm.set_console()
+        self.vm.add_args(
+            "-machine", "ast2600-evb,otpmem=otpmem-drive"
+        )
+        self.do_test_arm_aspeed_sdk_start(self.scratch_file("ast2600-default", "image-bmc"))
+        self.wait_for_console_pattern("ast2600-default login:")
+
+    def test_ast1030_otp_fallback(self):
+        kernel_name = "ast1030-evb-demo/zephyr.elf"
+        kernel_file = self.archive_extract(self.ASSET_ZEPHYR_3_00, member=kernel_name)
+
+        self.vm.set_machine("ast1030-evb")
+        self.vm.set_console()
+        self.vm.add_args("-kernel", kernel_file)
+        self.vm.launch()
+        self.wait_for_console_pattern("Booting Zephyr OS")
+
+if __name__ == '__main__':
+    AspeedTest.main()
\ No newline at end of file
-- 
2.43.0


