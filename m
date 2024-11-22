Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F15EE65D2E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 07:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEOAm-0006vT-Ps; Fri, 22 Nov 2024 02:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tEOAg-0006u3-PQ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:33:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tEOAf-0000eH-Af
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732260820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GUXwaA4BCSEJyimsRFpqsk3xgO5A8rkDg+er7VoCEV8=;
 b=V6Xmm/8EQczAAfEdqCKRP1PXJpjhyqsx79DhEzts8LF5xiVw7W93QKlGqVgqL1zRhjhjQk
 BP2QuydnLI/CCbjMsYZtcD33qHp/Csnby2E9IN0i9BmPUK+UXdwnEaB9oKthWl029kOTeJ
 VxLwUQWOxp9eXCzixWT0jKvfMXBwi0Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-llHJAn0-OEuGk5REe8-8ng-1; Fri,
 22 Nov 2024 02:33:36 -0500
X-MC-Unique: llHJAn0-OEuGk5REe8-8ng-1
X-Mimecast-MFC-AGG-ID: llHJAn0-OEuGk5REe8-8ng
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CC6219560AF; Fri, 22 Nov 2024 07:33:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.194.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26A5019560A3; Fri, 22 Nov 2024 07:33:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 3/3] tests/functional: Remove sleep workarounds from Aspeed
 tests
Date: Fri, 22 Nov 2024 08:33:09 +0100
Message-ID: <20241122073309.1897944-4-clg@redhat.com>
In-Reply-To: <20241122073309.1897944-1-clg@redhat.com>
References: <20241122073309.1897944-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

These were introduced in the avocado tests to workaround read issues
when interacting with console. They are no longer necessary and we can
use the expected "login:" string or the command prompt now. Drop the
last use of exec_command.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_arm_aspeed.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
index 7644ecbae750..758737f6c24d 100755
--- a/tests/functional/test_arm_aspeed.py
+++ b/tests/functional/test_arm_aspeed.py
@@ -14,7 +14,6 @@
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import interrupt_interactive_console_until_pattern
-from qemu_test import exec_command
 from qemu_test import has_cmd
 from qemu_test.utils import archive_extract
 from zipfile import ZipFile
@@ -136,10 +135,8 @@ def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'
         self.wait_for_console_pattern('lease of 10.0.2.15')
         # the line before login:
         self.wait_for_console_pattern(pattern)
-        time.sleep(0.1)
-        exec_command(self, 'root')
-        time.sleep(0.1)
-        exec_command(self, "passw0rd")
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
+        exec_command_and_wait_for_pattern(self, 'passw0rd', '#')
 
     def do_test_arm_aspeed_buildroot_poweroff(self):
         exec_command_and_wait_for_pattern(self, 'poweroff',
@@ -158,7 +155,7 @@ def test_arm_ast2500_evb_buildroot(self):
         self.vm.add_args('-device',
                          'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
         self.do_test_arm_aspeed_buildroot_start(image_path, '0x0',
-                                                'Aspeed AST2500 EVB')
+                                                'ast2500-evb login:')
 
         exec_command_and_wait_for_pattern(self,
              'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
@@ -188,7 +185,8 @@ def test_arm_ast2600_evb_buildroot(self):
                          'ds1338,bus=aspeed.i2c.bus.3,address=0x32');
         self.vm.add_args('-device',
                          'i2c-echo,bus=aspeed.i2c.bus.3,address=0x42');
-        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'Aspeed AST2600 EVB')
+        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00',
+                                                'ast2600-evb login:')
 
         exec_command_and_wait_for_pattern(self,
              'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
@@ -209,8 +207,8 @@ def test_arm_ast2600_evb_buildroot(self):
         exec_command_and_wait_for_pattern(self,
              'echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-3/new_device',
              'i2c i2c-3: new_device: Instantiated device slave-24c02 at 0x64');
-        exec_command(self, 'i2cset -y 3 0x42 0x64 0x00 0xaa i');
-        time.sleep(0.1)
+        exec_command_and_wait_for_pattern(self,
+             'i2cset -y 3 0x42 0x64 0x00 0xaa i', '#');
         exec_command_and_wait_for_pattern(self,
              'hexdump /sys/bus/i2c/devices/3-1064/slave-eeprom',
              '0000000 ffaa ffff ffff ffff ffff ffff ffff ffff');
-- 
2.47.0


