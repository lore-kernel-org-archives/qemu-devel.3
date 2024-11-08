Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCEDD5E154
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 10:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9MSn-0004Ag-Om; Fri, 08 Nov 2024 05:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9MSl-0004A1-Lx
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9MSj-000698-HF
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731062612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rp1ir+SnVCLcwYZd+vjawH4pbd6w92V7uEr6koHU048=;
 b=Bux5ZWSIZtKqbTXJGMTiydsslrmmHAK8QB+U8Yrb59kXLdpbUjBslRiBxAj8JnZULPaFtU
 iJAE14Isq7+IwuVX4FbVEYQLcGh9eBwXLvmhqOYx+BapmxPaKMcjTi2ptcVSNulz0JbBSv
 iZcWRO5X72VqF91hXPjvEUO4+E01Ozo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-r7cmDoH3MCa8w14GWVMZ4A-1; Fri,
 08 Nov 2024 05:43:25 -0500
X-MC-Unique: r7cmDoH3MCa8w14GWVMZ4A-1
X-Mimecast-MFC-AGG-ID: r7cmDoH3MCa8w14GWVMZ4A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA166195609E; Fri,  8 Nov 2024 10:43:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C37F51953882; Fri,  8 Nov 2024 10:43:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/10] tests/functional: Convert the riscv_opensbi avocado test
 into a standalone test
Date: Fri,  8 Nov 2024 11:43:02 +0100
Message-ID: <20241108104312.534448-3-thuth@redhat.com>
In-Reply-To: <20241108104312.534448-1-thuth@redhat.com>
References: <20241108104312.534448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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
index 0844f5da19..844944fb39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -329,6 +329,7 @@ F: hw/intc/riscv*
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
index d5296bff8b..b5691f9a97 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -146,18 +146,26 @@ tests_ppc64_system_thorough = [
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


