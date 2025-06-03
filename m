Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71730C5B552
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 18:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMWYl-000080-Sv; Tue, 03 Jun 2025 14:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uMWYj-00007O-Kl
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 14:40:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uMWYd-0005ix-2G
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 14:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748976015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yqh7Nu0xgDQ7FYCcGCDLQAXdlbXUZbEz7wnWoayqOzY=;
 b=ICcY8LGNCssebXTfb2cnkWVzJxbyb68MrMUkVPtHMtcKAN7rk5jGQy31/APt7YadREH8/B
 PwWxKWZweIkG7PsfKs1x9G9OAbGKQKzFgsIUDAmy9VCYYTi9qogHuOfyKyLeUN0j9oxrxk
 uyfB6Xj2SmyAfvNzOOfeUizZ4I5Zjqs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-zYCMkxLeOpCyZQLP7IM2Ow-1; Tue,
 03 Jun 2025 14:40:12 -0400
X-MC-Unique: zYCMkxLeOpCyZQLP7IM2Ow-1
X-Mimecast-MFC-AGG-ID: zYCMkxLeOpCyZQLP7IM2Ow_1748976011
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 077831954B17; Tue,  3 Jun 2025 18:40:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.37])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F7FD180049D; Tue,  3 Jun 2025 18:40:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH] tests/functional: Add a test for the Arduino UNO machine
Date: Tue,  3 Jun 2025 20:40:05 +0200
Message-ID: <20250603184007.24521-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Check whether we can run a kernel that prints something to the
serial console.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                      |  3 ++-
 tests/functional/meson.build     |  1 +
 tests/functional/test_avr_uno.py | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100755 tests/functional/test_avr_uno.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d1023635ee..eb56bc0ad1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -219,7 +219,7 @@ S: Maintained
 F: docs/system/target-avr.rst
 F: gdb-xml/avr-cpu.xml
 F: target/avr/
-F: tests/functional/test_avr_mega2560.py
+F: tests/functional/test_avr_*.py
 
 Hexagon TCG CPUs
 M: Brian Cain <brian.cain@oss.qualcomm.com>
@@ -1237,6 +1237,7 @@ Arduino
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: hw/avr/arduino.c
+F: tests/functional/test_avr_uno.py
 
 HP-PARISC Machines
 ------------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 0de1caa0f72..3c50bde9349 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -151,6 +151,7 @@ tests_arm_linuxuser_thorough = [
 
 tests_avr_system_thorough = [
   'avr_mega2560',
+  'avr_uno',
 ]
 
 tests_hppa_system_quick = [
diff --git a/tests/functional/test_avr_uno.py b/tests/functional/test_avr_uno.py
new file mode 100755
index 00000000000..adb3b73da4f
--- /dev/null
+++ b/tests/functional/test_avr_uno.py
@@ -0,0 +1,32 @@
+#!/usr/bin/env python3
+#
+# QEMU AVR Arduino UNO functional test
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
+
+
+class UnoMachine(QemuSystemTest):
+
+    ASSET_UNO = Asset(
+        ('https://github.com/RahulRNandan/LED_Blink_AVR/raw/'
+         'c6d602cbb974a193/build/main.elf'),
+        '3009a4e2cf5c5b65142f538abdf66d4dc6bc6beab7e552fff9ae314583761b72')
+
+    def test_uno(self):
+        """
+        The binary constantly prints out 'LED Blink'
+        """
+        self.set_machine('arduino-uno')
+        rom_path = self.ASSET_UNO.fetch()
+
+        self.vm.add_args('-bios', rom_path)
+        self.vm.set_console()
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'LED Blink')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.49.0


