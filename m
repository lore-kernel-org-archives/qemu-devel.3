Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E98FD2ED11
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 05:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi4BD-0001az-Um; Tue, 20 Jan 2026 00:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vi4B7-00018F-Gs; Tue, 20 Jan 2026 00:21:21 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vi4B5-00053q-FU; Tue, 20 Jan 2026 00:21:20 -0500
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
Subject: [PATCH v5 22/22] test/functional/aarch64: Add I2C test for AST1700 IO
 expanders
Date: Tue, 20 Jan 2026 13:18:53 +0800
Message-ID: <20260120051859.1920565-23-kane_chen@aspeedtech.com>
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

Extend the AST2700 test suite to verify I2C connectivity on AST1700
IO expanders using the DCSCM image. This validates the new bus-label
naming scheme by testing communication on both primary and
expander-attached I2C buses.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 .../functional/aarch64/test_aspeed_ast2700.py | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index 438f7eb37c..f2bdac5177 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -50,10 +50,21 @@ def verify_openbmc_boot_and_login(self, name):
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
 
+    def bring_up_ast1700_and_login(self, name):
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')
+        exec_command_and_wait_for_pattern(self, '0', '=>')
+        exec_command_and_wait_for_pattern(self, 'cp.b 100420000 403000000 800000; bootm 403000000#conf-ast2700-dcscm_ast1700-evb.dtb', f'{name} login:')
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
+        exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
+
     ASSET_SDK_V908_AST2700A1 = Asset(
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2700-default-obmc.tar.gz',
             'eac3dc409b7ea3cd4b03d4792d3cebd469792ad893cb51e1d15f0fc20bd1e2cd')
 
+    ASSET_SDK_V908_AST2700A1_DCSCM = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2700-dcscm-obmc.tar.gz',
+            '59dc1282db886087342419824edf91806bb4f83febf916ec5350238aa5613268')
+
     def do_ast2700_i2c_test(self, bus_id):
         bus_str = str(bus_id)
         exec_command_and_wait_for_pattern(self,
@@ -148,5 +159,18 @@ def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_08(self):
         self.verify_vbootrom_firmware_flow()
         self.verify_openbmc_boot_start()
 
+    def test_aarch64_ast2700a1_evb_ioexp_v09_08(self):
+        self.set_machine('ast2700a1-evb')
+        self.require_netdev('user')
+
+        self.archive_extract(self.ASSET_SDK_V908_AST2700A1_DCSCM)
+        self.vm.set_machine('ast2700a1-evb,fmc-model=w25q512jv')
+        self.vm.add_args('-device',
+                         'tmp105,bus=ioexp0.0,address=0x4d,id=tmp-test-16')
+        self.start_ast2700_test_vbootrom('ast2700-dcscm', 8)
+        self.bring_up_ast1700_and_login('ast2700-dcscm')
+        self.do_ast2700_i2c_test(8)
+        self.do_ast2700_i2c_test(16)
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.43.0


