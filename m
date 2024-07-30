Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E2EC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqHj-0002Gq-4k; Tue, 30 Jul 2024 13:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqHa-000246-Sd
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqHZ-0002fU-4O
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722359103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pd/ERo3Hy/CXw9w92gfMzgoqJ3+ARjcIKyJjvfszr8Q=;
 b=ipG8Tb6RMVwrLH0yVuBlpZjB1le/wyJBZ1DkZWNxh4jxibpEcm+nIuVuXdWgDmp8NVA9W2
 LS5mRqQQaScWCANtwy3yveoDc4IVuYVY9q8lglbjreyJ7+pqiql4i0bIgFfwPOLcXHgpmC
 tfG4vyL4JwayBm1YbSlElGTL/N5Wtu4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-pD2w7Z80PBC8nJPs_uo_qA-1; Tue,
 30 Jul 2024 13:04:59 -0400
X-MC-Unique: pD2w7Z80PBC8nJPs_uo_qA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4E101955D47; Tue, 30 Jul 2024 17:04:57 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE3BA3000193; Tue, 30 Jul 2024 17:04:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 16/24] tests/functional: Convert the riscv_opensbi avocado
 test into a standalone test
Date: Tue, 30 Jul 2024 18:03:36 +0100
Message-ID: <20240730170347.4103919-17-berrange@redhat.com>
In-Reply-To: <20240730170347.4103919-1-berrange@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The avocado test defined test functions for both, riscv32 and riscv64.
Since we can run the whole file with multiple targets in the new
framework, we can now consolidate the functions so we have to only
define one function per machine now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/riscv_opensbi.py         | 63 --------------------------
 tests/functional/meson.build           |  8 ++++
 tests/functional/test_riscv_opensbi.py | 36 +++++++++++++++
 3 files changed, 44 insertions(+), 63 deletions(-)
 delete mode 100644 tests/avocado/riscv_opensbi.py
 create mode 100755 tests/functional/test_riscv_opensbi.py

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
index d6a1a3a116..55021c4e4d 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -55,6 +55,14 @@ tests_ppc_thorough = [
   'ppc_bamboo',
 ]
 
+tests_riscv32_quick = [
+  'riscv_opensbi',
+]
+
+tests_riscv64_quick = [
+  'riscv_opensbi',
+]
+
 tests_s390x_thorough = [
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
2.45.2


