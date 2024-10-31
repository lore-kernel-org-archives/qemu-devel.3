Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C70D767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZIg-0007GU-Fc; Thu, 31 Oct 2024 13:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6ZIY-0007An-9P
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6ZIW-0006f9-6d
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730396967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yv7vY5NI5q0uJCu2awqSYIQi3E8+d2hpL6KgEEgb2bo=;
 b=Gr+WXVBNONhKRgFy+Gtwcx/iVAM5VViWIh9aM+SRUK0iz0hLBk8iuhoJVbNb3Zt+7AXp4u
 QMkpV3cqMMLRolhklT3A4A3426c6rln2eDkwCodlcL2jM4xEEh3iHWd3BzRk32AUbMPeHU
 yXS1bTZ+cGhpMNP3T+52qhf1elCIyVI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-TZr3pr6aPnypfhplbeMOvw-1; Thu,
 31 Oct 2024 13:49:21 -0400
X-MC-Unique: TZr3pr6aPnypfhplbeMOvw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 434F31956057; Thu, 31 Oct 2024 17:49:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.53])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51C79300018D; Thu, 31 Oct 2024 17:49:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/14] tests/functional: Convert the riscv_opensbi avocado test
 into a standalone test
Date: Thu, 31 Oct 2024 18:48:32 +0100
Message-ID: <20241031174832.6574-15-thuth@redhat.com>
In-Reply-To: <20241031174832.6574-1-thuth@redhat.com>
References: <20241031174832.6574-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The avocado test defined test functions for both, riscv32 and riscv64.
Since we can run the whole file with multiple targets in the new
framework, we can now consolidate the functions so we have to only
define one function per machine now.

Message-ID: <20240821082748.65853-23-thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                            |  1 +
 tests/avocado/riscv_opensbi.py         | 63 --------------------------
 tests/functional/meson.build           | 12 ++++-
 tests/functional/test_riscv_opensbi.py | 36 +++++++++++++++
 4 files changed, 47 insertions(+), 65 deletions(-)
 delete mode 100644 tests/avocado/riscv_opensbi.py
 create mode 100755 tests/functional/test_riscv_opensbi.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 5837e4bf74..00810d2434 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -328,6 +328,7 @@ F: hw/intc/riscv*
 F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
+F: tests/functional/test_riscv*
 F: tests/tcg/riscv64/
 
 RISC-V XThead* extensions
diff --git a/tests/avocado/riscv_opensbi.py b/tests/avocado/riscv_opensbi.py
deleted file mode 100644
index bfff9cc3c3..0000000000
--- a/tests/avocado/riscv_opensbi.py
+++ /dev/null
@@ -1,63 +0,0 @@
-# OpenSBI boot test for RISC-V machines
-#
-# Copyright (c) 2022, Ventana Micro
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-
-class RiscvOpenSBI(QemuSystemTest):
-    """
-    :avocado: tags=accel:tcg
-    """
-    timeout = 5
-
-    def boot_opensbi(self):
-        self.vm.set_console()
-        self.vm.launch()
-        wait_for_console_pattern(self, 'Platform Name')
-        wait_for_console_pattern(self, 'Boot HART MEDELEG')
-
-    def test_riscv32_spike(self):
-        """
-        :avocado: tags=arch:riscv32
-        :avocado: tags=machine:spike
-        """
-        self.boot_opensbi()
-
-    def test_riscv64_spike(self):
-        """
-        :avocado: tags=arch:riscv64
-        :avocado: tags=machine:spike
-        """
-        self.boot_opensbi()
-
-    def test_riscv32_sifive_u(self):
-        """
-        :avocado: tags=arch:riscv32
-        :avocado: tags=machine:sifive_u
-        """
-        self.boot_opensbi()
-
-    def test_riscv64_sifive_u(self):
-        """
-        :avocado: tags=arch:riscv64
-        :avocado: tags=machine:sifive_u
-        """
-        self.boot_opensbi()
-
-    def test_riscv32_virt(self):
-        """
-        :avocado: tags=arch:riscv32
-        :avocado: tags=machine:virt
-        """
-        self.boot_opensbi()
-
-    def test_riscv64_virt(self):
-        """
-        :avocado: tags=arch:riscv64
-        :avocado: tags=machine:virt
-        """
-        self.boot_opensbi()
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 1336d941ea..8663d65c7a 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -143,18 +143,26 @@ tests_ppc64_system_thorough = [
   'ppc64_tuxrun',
 ]
 
-tests_rx_system_thorough = [
-  'rx_gdbsim',
+tests_riscv32_system_quick = [
+  'riscv_opensbi',
 ]
 
 tests_riscv32_system_thorough = [
   'riscv32_tuxrun',
 ]
 
+tests_riscv64_system_quick = [
+  'riscv_opensbi',
+]
+
 tests_riscv64_system_thorough = [
   'riscv64_tuxrun',
 ]
 
+tests_rx_system_thorough = [
+  'rx_gdbsim',
+]
+
 tests_s390x_system_thorough = [
   's390x_ccw_virtio',
   's390x_topology',
diff --git a/tests/functional/test_riscv_opensbi.py b/tests/functional/test_riscv_opensbi.py
new file mode 100755
index 0000000000..d077e40f42
--- /dev/null
+++ b/tests/functional/test_riscv_opensbi.py
@@ -0,0 +1,36 @@
+#!/usr/bin/env python3
+#
+# OpenSBI boot test for RISC-V machines
+#
+# Copyright (c) 2022, Ventana Micro
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
+
+class RiscvOpenSBI(QemuSystemTest):
+
+    timeout = 5
+
+    def boot_opensbi(self):
+        self.vm.set_console()
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Platform Name')
+        wait_for_console_pattern(self, 'Boot HART MEDELEG')
+
+    def test_riscv_spike(self):
+        self.set_machine('spike')
+        self.boot_opensbi()
+
+    def test_riscv_sifive_u(self):
+        self.set_machine('sifive_u')
+        self.boot_opensbi()
+
+    def test_riscv_virt(self):
+        self.set_machine('virt')
+        self.boot_opensbi()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.47.0


