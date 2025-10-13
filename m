Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA59FCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8HvB-0004WD-OO; Mon, 13 Oct 2025 08:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hus-0004QO-CQ
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hui-0007sv-Mm
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9XJQoWj0w1litKRtm7b6WTU9qbMY5CqhuJH/7tfqOI=;
 b=iumP59N8pxWcQZJHBZ1cZWoWrwTPQ2UmfV68aaHlhFmqpdaMy07vpQkf30088Rp+dWnyqC
 c7hd0v6fk7kpjR5A2k2OBkfrb6wgZJXEvyREMUqY+Jn+/5VqcohKPWOYJ7jH0OkerZX9qH
 ghmgX7Kslm3Rlx8TQhHvM1t5vp1x3Bo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-WdDIGCHnN2aMOSfkr7yc2w-1; Mon,
 13 Oct 2025 08:44:27 -0400
X-MC-Unique: WdDIGCHnN2aMOSfkr7yc2w-1
X-Mimecast-MFC-AGG-ID: WdDIGCHnN2aMOSfkr7yc2w_1760359466
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7147218004D8; Mon, 13 Oct 2025 12:44:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F33BD180047F; Mon, 13 Oct 2025 12:44:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/29] tests/functional/aarch64/aspeed_ast2700: Add PCIe and
 network tests
Date: Mon, 13 Oct 2025 14:43:52 +0200
Message-ID: <20251013124421.71977-2-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

Extend the AST2700 and AST2700fc functional tests with PCIe and network
checks.

This patch introduces a helper "do_ast2700_pcie_test()" that runs "lspci"
on the emulated system and verifies the expected PCIe devices:

- 0002:00:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
- 0002:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection

Additional changes:
- Add `-device e1000e,netdev=net1,bus=pcie.2 -netdev user,id=net1` to the
  AST2700 and AST2700fc test machines.
- In the AST2700 vbootrom test, assign an IP address to the e1000e
  interface and verify it using `ip addr`.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250919093017.338309-15-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .../functional/aarch64/test_aspeed_ast2700.py | 21 +++++++++++++++++++
 .../aarch64/test_aspeed_ast2700fc.py          | 13 ++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index a3db26729499..0973fce0e995 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -69,6 +69,16 @@ def do_ast2700_i2c_test(self):
         exec_command_and_wait_for_pattern(self,
             'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '18000')
 
+    def do_ast2700_pcie_test(self):
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 0002:00:00.0',
+            '0002:00:00.0 PCI bridge: '
+            'ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 0002:01:00.0',
+            '0002:01:00.0 Ethernet controller: '
+            'Intel Corporation 82574L Gigabit Network Connection')
+
     def start_ast2700_test(self, name):
         num_cpu = 4
         uboot_size = os.path.getsize(self.scratch_file(name,
@@ -125,20 +135,31 @@ def test_aarch64_ast2700a0_evb_sdk_v09_06(self):
 
     def test_aarch64_ast2700a1_evb_sdk_v09_06(self):
         self.set_machine('ast2700a1-evb')
+        self.require_netdev('user')
 
         self.archive_extract(self.ASSET_SDK_V906_AST2700A1)
+        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
+        self.vm.add_args('-netdev', 'user,id=net1')
         self.start_ast2700_test('ast2700-default')
         self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700_i2c_test()
+        self.do_ast2700_pcie_test()
 
     def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_07(self):
         self.set_machine('ast2700a1-evb')
+        self.require_netdev('user')
 
         self.archive_extract(self.ASSET_SDK_V907_AST2700A1_VBOOROM)
+        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
+        self.vm.add_args('-netdev', 'user,id=net1')
         self.start_ast2700_test_vbootrom('ast2700-default')
         self.verify_vbootrom_firmware_flow()
         self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700_i2c_test()
+        self.do_ast2700_pcie_test()
+        exec_command_and_wait_for_pattern(self,
+            'ip addr show dev eth2',
+            'inet 10.0.2.15/24')
 
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
index b85370e182ea..28b66614d970 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
@@ -20,6 +20,8 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
         self.vm.set_console()
         self.vm.add_args('-device',
                          'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
+        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
+        self.vm.add_args('-netdev', 'user,id=net1')
         self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
                          '-net', 'nic', '-net', 'user', '-snapshot')
 
@@ -49,6 +51,16 @@ def do_ast2700_i2c_test(self):
         exec_command_and_wait_for_pattern(self,
             'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '18000')
 
+    def do_ast2700_pcie_test(self):
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 0002:00:00.0',
+            '0002:00:00.0 PCI bridge: '
+            'ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 0002:01:00.0',
+            '0002:01:00.0 Ethernet controller: '
+            'Intel Corporation 82574L Gigabit Network Connection')
+
     def do_ast2700fc_ssp_test(self):
         self.vm.shutdown()
         self.vm.set_console(console_index=1)
@@ -128,6 +140,7 @@ def test_aarch64_ast2700fc_sdk_v09_06(self):
         self.start_ast2700fc_test('ast2700-default')
         self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700_i2c_test()
+        self.do_ast2700_pcie_test()
         self.do_ast2700fc_ssp_test()
         self.do_ast2700fc_tsp_test()
 
-- 
2.51.0


