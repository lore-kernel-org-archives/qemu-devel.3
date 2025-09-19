Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1FACA1013
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 03:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzRki-0002Hg-PY; Thu, 18 Sep 2025 23:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzRkh-0002Fi-4H; Thu, 18 Sep 2025 23:25:39 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzRkf-0007KK-9m; Thu, 18 Sep 2025 23:25:38 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 19 Sep
 2025 11:24:37 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 19 Sep 2025 11:24:37 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>, <wuhaotsh@google.com>, <titusr@google.com>
Subject: [PATCH v4 13/14] tests/functional/arm/test_aspeed_ast2600: Add PCIe
 and network test
Date: Fri, 19 Sep 2025 11:24:26 +0800
Message-ID: <20250919032431.3316764-14-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919032431.3316764-1-jamin_lin@aspeedtech.com>
References: <20250919032431.3316764-1-jamin_lin@aspeedtech.com>
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

Extend the AST2600 functional tests with PCIe and network checks.

This patch introduces a new helper "do_ast2600_pcie_test()" that runs "lspci"
on the emulated system and verifies the presence of the expected PCIe devices:

- 80:00.0 Host bridge: ASPEED Technology, Inc. Device 2600
- 80:08.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
- 81:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection

To exercise the PCIe network device, the test adds:

  -device e1000e,netdev=net1,bus=pcie.0
  -netdev user,id=net1

and assigns an IP address to the interface, verifying it with `ip addr`.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/functional/arm/test_aspeed_ast2600.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/functional/arm/test_aspeed_ast2600.py b/tests/functional/arm/test_aspeed_ast2600.py
index 87e3595584..49ffe89d91 100755
--- a/tests/functional/arm/test_aspeed_ast2600.py
+++ b/tests/functional/arm/test_aspeed_ast2600.py
@@ -101,8 +101,26 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
         'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.07/ast2600-default-obmc.tar.gz',
         'cb6c08595bcbba1672ce716b068ba4e48eda1ed9abe78a07b30392ba2278feba')
 
+    def do_ast2600_pcie_test(self):
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 80:00.0',
+            '80:00.0 Host bridge: '
+            'ASPEED Technology, Inc. Device 2600')
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 80:08.0',
+            '80:08.0 PCI bridge: '
+            'ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 81:00.0',
+            '81:00.0 Ethernet controller: '
+            'Intel Corporation 82574L Gigabit Network Connection')
+        exec_command_and_wait_for_pattern(self,
+            'ip addr show dev eth4',
+            'inet 10.0.2.15/24')
+
     def test_arm_ast2600_evb_sdk(self):
         self.set_machine('ast2600-evb')
+        self.require_netdev('user')
 
         self.archive_extract(self.ASSET_SDK_V907_AST2600)
 
@@ -110,6 +128,8 @@ def test_arm_ast2600_evb_sdk(self):
             'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test')
         self.vm.add_args('-device',
             'ds1338,bus=aspeed.i2c.bus.5,address=0x32')
+        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.0')
+        self.vm.add_args('-netdev', 'user,id=net1')
         self.do_test_arm_aspeed_sdk_start(
             self.scratch_file("ast2600-default", "image-bmc"))
 
@@ -135,6 +155,7 @@ def test_arm_ast2600_evb_sdk(self):
         year = time.strftime("%Y")
         exec_command_and_wait_for_pattern(self,
              '/sbin/hwclock -f /dev/rtc1', year)
+        self.do_ast2600_pcie_test()
 
     def test_arm_ast2600_otp_blockdev_device(self):
         self.vm.set_machine("ast2600-evb")
-- 
2.43.0


