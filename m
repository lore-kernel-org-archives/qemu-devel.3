Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6516BC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrnt-0000QU-76; Mon, 05 May 2025 05:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrmy-0006Nc-Hw
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrmw-0006FE-Cv
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746436020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VttgU5Ogb+E15+62yOSNxVyme/J52fkZq7Xe4br9KnY=;
 b=Kpyqrr/5loBt70X6jQRsD6InysxEfM2V8loqAQRLrNxSyY52rCjoXGP26w8sd0YtZj9qEz
 nmdZH2j9ZjQLzfdt9fruDJEqr8h87/4vxzfuDbZ96uHv351IUFb3l0+JxeDcse9Hj01STw
 28mhtOnFlUanxnA6y4g0oVbRhlaC48E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-ZoF_uuQNMpys82QATcg-tg-1; Mon,
 05 May 2025 05:06:58 -0400
X-MC-Unique: ZoF_uuQNMpys82QATcg-tg-1
X-Mimecast-MFC-AGG-ID: ZoF_uuQNMpys82QATcg-tg_1746436017
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEECF18001D5; Mon,  5 May 2025 09:06:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA49930001A2; Mon,  5 May 2025 09:06:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Nabih Estefan <nabihestefan@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/23] tests/functional/aspeed: Move I2C test into shared
 helper for AST2700 reuse
Date: Mon,  5 May 2025 11:06:19 +0200
Message-ID: <20250505090635.778785-8-clg@redhat.com>
In-Reply-To: <20250505090635.778785-1-clg@redhat.com>
References: <20250505090635.778785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move the I2C test case into a common helper function (do_ast2700_i2c_test) so it
can be reused across multiple AST2700-based test cases. This reduces duplication
and improves maintainability.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250423072350.541742-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/test_aarch64_aspeed.py | 28 +++++++++++++------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
index c7f3b3b319fd..4b6851db2add 100755
--- a/tests/functional/test_aarch64_aspeed.py
+++ b/tests/functional/test_aarch64_aspeed.py
@@ -18,6 +18,8 @@ class AST2x00MachineSDK(QemuSystemTest):
     def do_test_aarch64_aspeed_sdk_start(self, image):
         self.require_netdev('user')
         self.vm.set_console()
+        self.vm.add_args('-device',
+                         'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
         self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
                          '-net', 'nic', '-net', 'user', '-snapshot')
 
@@ -35,6 +37,17 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.05/ast2700-default-obmc.tar.gz',
             'c1f4496aec06743c812a6e9a1a18d032f34d62f3ddb6956e924fef62aa2046a5')
 
+    def do_ast2700_i2c_test(self):
+        exec_command_and_wait_for_pattern(self,
+            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device ',
+            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d')
+        exec_command_and_wait_for_pattern(self,
+            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '0')
+        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
+                    property='temperature', value=18000)
+        exec_command_and_wait_for_pattern(self,
+            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '18000')
+
     def start_ast2700_test(self, name):
         num_cpu = 4
         uboot_size = os.path.getsize(self.scratch_file(name,
@@ -73,8 +86,6 @@ def start_ast2700_test(self, name):
                              f'loader,addr=0x430000000,cpu-num={i}')
 
         self.vm.add_args('-smp', str(num_cpu))
-        self.vm.add_args('-device',
-                         'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
         self.do_test_aarch64_aspeed_sdk_start(
             self.scratch_file(name, 'image-bmc'))
 
@@ -83,28 +94,19 @@ def start_ast2700_test(self, name):
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
 
-        exec_command_and_wait_for_pattern(self,
-            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device ',
-            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d')
-        exec_command_and_wait_for_pattern(self,
-            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '0')
-        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
-                    property='temperature', value=18000)
-        exec_command_and_wait_for_pattern(self,
-            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '18000')
-
     def test_aarch64_ast2700_evb_sdk_v09_05(self):
         self.set_machine('ast2700-evb')
 
         self.archive_extract(self.ASSET_SDK_V905_AST2700)
         self.start_ast2700_test('ast2700-a0-default')
+        self.do_ast2700_i2c_test()
 
     def test_aarch64_ast2700a1_evb_sdk_v09_05(self):
         self.set_machine('ast2700a1-evb')
 
         self.archive_extract(self.ASSET_SDK_V905_AST2700A1)
         self.start_ast2700_test('ast2700-default')
-
+        self.do_ast2700_i2c_test()
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.49.0


