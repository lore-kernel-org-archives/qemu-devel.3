Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9663E95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaCv-00048h-8I; Wed, 04 Feb 2026 05:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaCC-0002kO-VR
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:33:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaCA-0004EW-Sn
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H81VUSnjG5NUhsNhELoIUfLN6VVQFs4TBpBGHdAwLj4=;
 b=WZP+JxNWwGSy0baWG4liSwKD3EGj/A3yGwT9yWzpXCC6jySCapXu9fxzcSLC/3nwHoNoTn
 Z+wUhXvG9nNQGG8tFDWwNqO/aUPuHITMlcLv0EtxZPG9o8dQhWt2HwIz/3+yo3vTho2FpR
 kbHjNXI9JX34MNLkeU1f21IAJw5IHzM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-ZCojK-NRNhWDhQtjqEFMlw-1; Wed,
 04 Feb 2026 05:33:12 -0500
X-MC-Unique: ZCojK-NRNhWDhQtjqEFMlw-1
X-Mimecast-MFC-AGG-ID: ZCojK-NRNhWDhQtjqEFMlw_1770201191
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB5B01956050; Wed,  4 Feb 2026 10:33:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4374418004AD; Wed,  4 Feb 2026 10:33:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 43/45] tests/functional/aarch64: Parameterize I2C bus ID in
 AST2700 test
Date: Wed,  4 Feb 2026 11:31:34 +0100
Message-ID: <20260204103136.1795455-44-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane Chen <kane_chen@aspeedtech.com>

The current Aspeed AST2700 functional test case strictly uses I2C bus
1 for its sensor tests. This hard-coded approach prevents the test
logic from being reused for other machine types or configurations
where I2C bus 1 might be disabled or where a different bus needs to
be verified (e.g., I2C expanders).

This refactoring allows the same I2C verification logic to be shared
across different test scenarios by simply passing the target bus
number.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260204082113.3955407-21-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .../functional/aarch64/test_aspeed_ast2700.py | 39 +++++++++++--------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index 828ea1ca53df..d7eeab9c23fd 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -15,11 +15,17 @@
 
 class AST2x00MachineSDK(QemuSystemTest):
 
-    def do_test_aarch64_aspeed_sdk_start(self, image):
+    def do_test_aarch64_aspeed_sdk_start(self, image, bus_id):
+        bus_str = str(bus_id)
         self.require_netdev('user')
         self.vm.set_console()
-        self.vm.add_args('-device',
-                         'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
+        self.vm.add_args(
+            '-device',
+            f'tmp105,'
+            f'bus=aspeed.i2c.bus.{bus_str},'
+            f'address=0x4d,'
+            f'id=tmp-test-{bus_str}'
+        )
         self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
                          '-net', 'nic', '-net', 'user', '-snapshot')
 
@@ -75,16 +81,17 @@ def verify_openbmc_boot_and_login(self, name):
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-a1-obmc.tar.gz',
             'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76525')
 
-    def do_ast2700_i2c_test(self):
+    def do_ast2700_i2c_test(self, bus_id):
+        bus_str = str(bus_id)
         exec_command_and_wait_for_pattern(self,
-            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device ',
-            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d')
+            f'echo lm75 0x4d > /sys/class/i2c-dev/i2c-{bus_str}/device/new_device ',
+            f'i2c i2c-{bus_str}: new_device: Instantiated device lm75 at 0x4d')
         exec_command_and_wait_for_pattern(self,
-            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '0')
-        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
+            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_input', '0')
+        self.vm.cmd('qom-set', path=f'/machine/peripheral/tmp-test-{bus_str}',
                     property='temperature', value=18000)
         exec_command_and_wait_for_pattern(self,
-            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '18000')
+            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_input', '18000')
 
     def do_ast2700_pcie_test(self):
         exec_command_and_wait_for_pattern(self,
@@ -99,7 +106,7 @@ def do_ast2700_pcie_test(self):
             'ip addr show dev eth2',
             'inet 10.0.2.15/24')
 
-    def start_ast2700_test(self, name):
+    def start_ast2700_test(self, name, bus_id):
         num_cpu = 4
         load_images_list = [
             {
@@ -128,12 +135,12 @@ def start_ast2700_test(self, name):
 
         self.vm.add_args('-smp', str(num_cpu))
         self.do_test_aarch64_aspeed_sdk_start(
-            self.scratch_file(name, 'image-bmc'))
+            self.scratch_file(name, 'image-bmc'), bus_id)
 
-    def start_ast2700_test_vbootrom(self, name):
+    def start_ast2700_test_vbootrom(self, name, bus_id):
         self.vm.add_args('-bios', 'ast27x0_bootrom.bin')
         self.do_test_aarch64_aspeed_sdk_start(
-                self.scratch_file(name, 'image-bmc'))
+                self.scratch_file(name, 'image-bmc'), bus_id)
 
     def test_aarch64_ast2700a1_evb_sdk_v11_00(self):
         self.set_machine('ast2700a1-evb')
@@ -142,9 +149,9 @@ def test_aarch64_ast2700a1_evb_sdk_v11_00(self):
         self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
-        self.start_ast2700_test('ast2700-a1')
+        self.start_ast2700_test('ast2700-a1', 1)
         self.verify_openbmc_boot_and_login('ast2700-a1')
-        self.do_ast2700_i2c_test()
+        self.do_ast2700_i2c_test(1)
         self.do_ast2700_pcie_test()
 
     def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):
@@ -154,7 +161,7 @@ def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):
         self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
-        self.start_ast2700_test_vbootrom('ast2700-a1')
+        self.start_ast2700_test_vbootrom('ast2700-a1', 1)
         self.verify_vbootrom_firmware_flow()
         self.verify_openbmc_boot_start()
 
-- 
2.52.0


