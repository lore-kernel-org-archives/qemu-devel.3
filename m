Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235ADC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 10:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGkl-0003YL-Kl; Fri, 24 Jan 2025 05:17:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tbGki-0003XS-LX
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 05:17:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tbGkg-0008Pq-5D
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 05:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737713845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vQYBHD9hzClbokCnuOdauP9wECJ0iVrnacoIeBvNGmA=;
 b=HqZcg31HgmvEW0LHTIgjrTM0g6y3n1no4WaUDwRWiV2nWImNYetRnXOLauI6O5qPEexLt6
 FKkOyBBo14/ERe9+fDwWkOmcTGR3LOtf4akYZUkULXjTJsKjDNHSIreyCkL5lroDa8kWq4
 nI3i0qZMBxzVZdYLhsRQUFWJyn/d3pw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-s4kvdhQYMlmPViSXGLq8Ng-1; Fri,
 24 Jan 2025 05:17:21 -0500
X-MC-Unique: s4kvdhQYMlmPViSXGLq8Ng-1
X-Mimecast-MFC-AGG-ID: s4kvdhQYMlmPViSXGLq8Ng
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8D8219560B1; Fri, 24 Jan 2025 10:17:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.200])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A45671800358; Fri, 24 Jan 2025 10:17:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] tests/functional: Add a test for the arm microbit machine
Date: Fri, 24 Jan 2025 11:17:09 +0100
Message-ID: <20250124101709.1591761-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

We don't have any functional tests for this machine yet, thus let's
add a test with a MicroPython binary that is available online
(thanks to Joel Stanley for providing it, see:
 https://www.mail-archive.com/qemu-devel@nongnu.org/msg606064.html ).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                           |  1 +
 tests/functional/meson.build          |  1 +
 tests/functional/test_arm_microbit.py | 31 +++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100755 tests/functional/test_arm_microbit.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d9b3a0011..7b4d84bf5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1157,6 +1157,7 @@ F: hw/*/microbit*.c
 F: include/hw/*/nrf51*.h
 F: include/hw/*/microbit*.h
 F: tests/qtest/microbit-test.c
+F: tests/functional/test_arm_microbit.py
 F: docs/system/arm/nrf.rst
 
 ARM PL011 Rust device
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index bcfbb70b65..a301c38806 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -105,6 +105,7 @@ tests_arm_system_thorough = [
   'arm_cubieboard',
   'arm_emcraft_sf2',
   'arm_integratorcp',
+  'arm_microbit',
   'arm_orangepi',
   'arm_quanta_gsj',
   'arm_raspi2',
diff --git a/tests/functional/test_arm_microbit.py b/tests/functional/test_arm_microbit.py
new file mode 100755
index 0000000000..68ea4e73d6
--- /dev/null
+++ b/tests/functional/test_arm_microbit.py
@@ -0,0 +1,31 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright 2025, The QEMU Project Developers.
+#
+# A functional test that runs MicroPython on the arm microbit machine.
+
+from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+
+class MicrobitMachine(QemuSystemTest):
+
+    ASSET_MICRO = Asset('https://ozlabs.org/~joel/microbit-micropython.hex',
+        '021641f93dfb11767d4978dbb3ca7f475d1b13c69e7f4aec3382f212636bffd6')
+
+    def test_arm_microbit(self):
+        self.set_machine('microbit')
+
+        micropython = self.ASSET_MICRO.fetch()
+        self.vm.set_console()
+        self.vm.add_args('-device', f'loader,file={micropython}')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Type "help()" for more information.')
+        exec_command_and_wait_for_pattern(self, 'import machine as mch', '>>>')
+        exec_command_and_wait_for_pattern(self, 'mch.reset()', 'MicroPython')
+        wait_for_console_pattern(self, '>>>')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.48.1


