Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C689DC369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 07:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7rNK-0001Nc-Bl; Thu, 24 Apr 2025 03:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7rNJ-0001NJ-Cv; Thu, 24 Apr 2025 03:52:01 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7rNH-0006ez-QK; Thu, 24 Apr 2025 03:52:01 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 24 Apr
 2025 15:51:37 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 24 Apr 2025 15:51:37 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>
Subject: [PATCH v6 4/6] tests/functional/aspeed: Add to test vbootrom for
 AST2700
Date: Thu, 24 Apr 2025 15:51:32 +0800
Message-ID: <20250424075135.3715128-5-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424075135.3715128-1-jamin_lin@aspeedtech.com>
References: <20250424075135.3715128-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Add the AST2700 functional test to boot using the vbootrom image
instead of manually loading boot components with -device loader.
The boot ROM binary is now passed via the
-bios option, using the image located in pc-bios/ast27x0_bootrom.bin.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/test_aarch64_aspeed.py | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
index 2f04655b60..34ddfa852c 100755
--- a/tests/functional/test_aarch64_aspeed.py
+++ b/tests/functional/test_aarch64_aspeed.py
@@ -25,6 +25,18 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
 
         self.vm.launch()
 
+    def verify_vbootrom_firmware_flow(self):
+        wait_for_console_pattern(self, 'Found valid FIT image')
+        wait_for_console_pattern(self, '[uboot] loading')
+        wait_for_console_pattern(self, 'done')
+        wait_for_console_pattern(self, '[fdt] loading')
+        wait_for_console_pattern(self, 'done')
+        wait_for_console_pattern(self, '[tee] loading')
+        wait_for_console_pattern(self, 'done')
+        wait_for_console_pattern(self, '[atf] loading')
+        wait_for_console_pattern(self, 'done')
+        wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-A)')
+
     def verify_openbmc_boot_and_login(self, name):
         wait_for_console_pattern(self, 'U-Boot 2023.10')
         wait_for_console_pattern(self, '## Loading kernel from FIT Image')
@@ -94,6 +106,11 @@ def start_ast2700_test(self, name):
         self.do_test_aarch64_aspeed_sdk_start(
             self.scratch_file(name, 'image-bmc'))
 
+    def start_ast2700_test_vbootrom(self, name):
+        self.vm.add_args('-bios', 'ast27x0_bootrom.bin')
+        self.do_test_aarch64_aspeed_sdk_start(
+                self.scratch_file(name, 'image-bmc'))
+
     def test_aarch64_ast2700_evb_sdk_v09_06(self):
         self.set_machine('ast2700-evb')
 
@@ -110,5 +127,14 @@ def test_aarch64_ast2700a1_evb_sdk_v09_06(self):
         self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700_i2c_test()
 
+    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_06(self):
+        self.set_machine('ast2700a1-evb')
+
+        self.archive_extract(self.ASSET_SDK_V906_AST2700A1)
+        self.start_ast2700_test_vbootrom('ast2700-default')
+        self.verify_vbootrom_firmware_flow()
+        self.verify_openbmc_boot_and_login('ast2700-default')
+        self.do_ast2700_i2c_test()
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.43.0


