Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F55CA0EF5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 09:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoIEc-0005ce-Dy; Tue, 19 Aug 2025 05:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uoIET-0005XX-AF; Tue, 19 Aug 2025 05:02:18 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uoIER-0003YB-4c; Tue, 19 Aug 2025 05:02:17 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 19 Aug
 2025 17:01:44 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 19 Aug 2025 17:01:44 +0800
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
Subject: [PATCH v1 07/11] tests/functional/test_arm_aspeed_ast2600: Add PCIe
 test via root port and e1000e
Date: Tue, 19 Aug 2025 17:01:28 +0800
Message-ID: <20250819090141.3949136-8-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819090141.3949136-1-jamin_lin@aspeedtech.com>
References: <20250819090141.3949136-1-jamin_lin@aspeedtech.com>
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

Add a functional test that exercises the AST2600 PCIe RC_H by creating a
root port and an e1000e endpoint behind it. The AST2600/ASPEED driver
treats root bus 0x80 specially: only two device addresses are usable on
the root bus, addr 0 (ASPEED host bridge) and addr 8. To attach endpoints
without code changes, the test places a QEMU PCIe root port at 0x80:08.0
and hangs e1000e behind it so the endpoint enumerates on bus 0x81.

The test appends:
-device pcie-root-port,id=root_port0,slot=1,addr=8,bus=pcie.0
-device e1000e,netdev=net0,bus=root_port0
-netdev user,id=net0

It then verifies enumeration with lspci:
0001:80:00.0 Host bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
0001:80:08.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
0001:81:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
Connection

This is a temporary solution that allows attaching multiple PCIe
devices while the ASPEED drivers does not support placing endpoints directly
on bus numbers 0x80.

Reference:
https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/drivers/pci/controller/pcie-aspeed.c#L309

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/functional/test_arm_aspeed_ast2600.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/functional/test_arm_aspeed_ast2600.py b/tests/functional/test_arm_aspeed_ast2600.py
index fdae4c939d..9ffcef513d 100755
--- a/tests/functional/test_arm_aspeed_ast2600.py
+++ b/tests/functional/test_arm_aspeed_ast2600.py
@@ -110,6 +110,10 @@ def test_arm_ast2600_evb_sdk(self):
             'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test')
         self.vm.add_args('-device',
             'ds1338,bus=aspeed.i2c.bus.5,address=0x32')
+        self.vm.add_args('-device',
+            'pcie-root-port,id=root_port0,slot=1,addr=8,bus=pcie.0')
+        self.vm.add_args('-device', 'e1000e,netdev=net0,bus=root_port0')
+        self.vm.add_args('-netdev', 'user,id=net0')
         self.do_test_arm_aspeed_sdk_start(
             self.scratch_file("ast2600-default", "image-bmc"))
 
@@ -136,5 +140,15 @@ def test_arm_ast2600_evb_sdk(self):
         exec_command_and_wait_for_pattern(self,
              '/sbin/hwclock -f /dev/rtc1', year)
 
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 0001:80:00.0',
+            '0001:80:00.0 Host bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 0001:80:08.0',
+            '0001:80:08.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port')
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 0001:81:00.0',
+            '0001:81:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection')
+
 if __name__ == '__main__':
     AspeedTest.main()
-- 
2.43.0


