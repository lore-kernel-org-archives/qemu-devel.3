Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F94C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 17:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3tb-0000bq-Da; Mon, 19 May 2025 13:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uH3tA-000089-Lh
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uH3t8-0000St-Es
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747674173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GF1TnPinob2l4EmXUL83/ChqDdovsfU8ISM22SPljTo=;
 b=Ww1FLy47iCtAskM4EcxTAKOYp6Skd7BpXfynOmyt2rKkUu69067YSjyd+7IH8tVvZ4rQkZ
 RqfZHh6Uwjx8q+Uk7k0+eYXaELSEwCiIcmalCikZUnKHxzIqJNittnYb0AuIRJRwu2ij6D
 ezm7K/hXLqkZpeAQ6ku6eFQJNaA0qLc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-zeCuMcZEPyydS8Yh9SiOYg-1; Mon,
 19 May 2025 13:02:49 -0400
X-MC-Unique: zeCuMcZEPyydS8Yh9SiOYg-1
X-Mimecast-MFC-AGG-ID: zeCuMcZEPyydS8Yh9SiOYg_1747674168
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A769180036D; Mon, 19 May 2025 17:02:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F3AA1956096; Mon, 19 May 2025 17:02:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/functional: Add a test for the Stellaris arm machines
Date: Mon, 19 May 2025 19:02:42 +0200
Message-ID: <20250519170242.520805-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The 2023 edition of the QEMU advent calendar featured an image
that we can use to test whether the lm3s6965evb machine is basically
still working.

And for the lm3s811evb there is a small test kernel on github
which can be used to check its UART.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                            |  1 +
 tests/functional/meson.build           |  1 +
 tests/functional/test_arm_stellaris.py | 48 ++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100755 tests/functional/test_arm_stellaris.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 57dddcc80d6..49b008cdac4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1002,6 +1002,7 @@ F: hw/display/ssd03*
 F: include/hw/input/gamepad.h
 F: include/hw/timer/stellaris-gptm.h
 F: docs/system/arm/stellaris.rst
+F: tests/functional/test_arm_stellaris.py
 
 STM32L4x5 SoC Family
 M: Samuel Tardieu <sam@rfc1149.net>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 52b4706cfe8..557d59ddf4d 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -137,6 +137,7 @@ tests_arm_system_thorough = [
   'arm_raspi2',
   'arm_replay',
   'arm_smdkc210',
+  'arm_stellaris',
   'arm_sx1',
   'arm_vexpress',
   'arm_virt',
diff --git a/tests/functional/test_arm_stellaris.py b/tests/functional/test_arm_stellaris.py
new file mode 100755
index 00000000000..cbd21cb1a0b
--- /dev/null
+++ b/tests/functional/test_arm_stellaris.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python3
+#
+# Functional test that checks the serial console of the stellaris machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+
+class StellarisMachine(QemuSystemTest):
+
+    ASSET_DAY22 = Asset(
+        'https://www.qemu-advent-calendar.org/2023/download/day22.tar.gz',
+        'ae3a63ef4b7a22c21bfc7fc0d85e402fe95e223308ed23ac854405016431ff51')
+
+    def test_lm3s6965evb(self):
+        self.set_machine('lm3s6965evb')
+        kernel_path = self.archive_extract(self.ASSET_DAY22,
+                                           member='day22/day22.bin')
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path)
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'In a one horse open')
+
+    ASSET_NOTMAIN = Asset(
+        'https://github.com/Ahelion/QemuArmM4FDemoSw/raw/master/build/notmain.bin',
+        '6ceda031aa081a420fca2fca9e137fa681d6e3820d820ad1917736cb265e611a')
+
+    def test_lm3s811evb(self):
+        self.set_machine('lm3s811evb')
+        kernel_path = self.ASSET_NOTMAIN.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-cpu', 'cortex-m4')
+        self.vm.add_args('-kernel', kernel_path)
+        self.vm.launch()
+
+        # The test kernel emits an initial '!' and then waits for input.
+        # For each character that we send it responds with a certain
+        # other ASCII character.
+        wait_for_console_pattern(self, '!')
+        exec_command_and_wait_for_pattern(self, '789', 'cdf')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.49.0


