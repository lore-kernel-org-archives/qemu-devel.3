Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A659CA0FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 13:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk1rx-00044p-C6; Fri, 30 Aug 2024 09:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1rq-0003By-RQ
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1rm-0005Wi-Rl
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725025239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sfl/k32CB6l1DcgvbguMCEWr8OuW9Mg9tzas69X/Dis=;
 b=EjdnDEFLvYWFnMqK5uy9FzCZTCk6hEOsLYZ3gW2tsOWntxRVQLElT0bO6KD3FiliJUMmuc
 mfjlDGbGYuIUPIeS/ZFg6S7LdOQIsfHvzTUKy2wnhBIBUYTcv9DdCZbA8rFOGXIz8LiS+h
 mILnUa6BFVAClEd8MKPPm4D4zVb38Us=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-CCM2Tbd9NkaI6Pe2o90eEA-1; Fri,
 30 Aug 2024 09:40:36 -0400
X-MC-Unique: CCM2Tbd9NkaI6Pe2o90eEA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF8971955D4C; Fri, 30 Aug 2024 13:40:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 191F4300019C; Fri, 30 Aug 2024 13:40:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 23/44] tests/functional: Convert the riscv_opensbi avocado
 test into a standalone test
Date: Fri, 30 Aug 2024 15:38:17 +0200
Message-ID: <20240830133841.142644-24-thuth@redhat.com>
In-Reply-To: <20240830133841.142644-1-thuth@redhat.com>
References: <20240830133841.142644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

However, we have to mark the "spike" test as flaky now since it sometimes
fails when running the tests in parallel (the failure happens also with the
Avocado test when the host is under load, so the problem is not related
to this conversion to the functional framework).

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                            |  1 +
 tests/avocado/riscv_opensbi.py         | 63 --------------------------
 tests/functional/meson.build           |  8 ++++
 tests/functional/test_riscv_opensbi.py | 40 ++++++++++++++++
 4 files changed, 49 insertions(+), 63 deletions(-)
 delete mode 100644 tests/avocado/riscv_opensbi.py
 create mode 100755 tests/functional/test_riscv_opensbi.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 91f5a0545f..11cefa015e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -337,6 +337,7 @@ F: hw/intc/riscv*
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
index f32afed30f..700deed24a 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -61,6 +61,14 @@ tests_ppc_system_thorough = [
   'ppc_bamboo',
 ]
 
+tests_riscv32_system_quick = [
+  'riscv_opensbi',
+]
+
+tests_riscv64_system_quick = [
+  'riscv_opensbi',
+]
+
 tests_s390x_system_thorough = [
   's390x_ccw_virtio',
   's390x_topology',
diff --git a/tests/functional/test_riscv_opensbi.py b/tests/functional/test_riscv_opensbi.py
new file mode 100755
index 0000000000..de632d05cc
--- /dev/null
+++ b/tests/functional/test_riscv_opensbi.py
@@ -0,0 +1,40 @@
+#!/usr/bin/env python3
+#
+# OpenSBI boot test for RISC-V machines
+#
+# Copyright (c) 2022, Ventana Micro
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+from unittest import skipUnless
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
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'),
+                'Test is unstable when system is under load')
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
2.46.0


