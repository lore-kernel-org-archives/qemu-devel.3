Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76692C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWgCJ-0006Jt-GE; Wed, 24 Jul 2024 13:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWgCC-0005mu-LI
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWgC1-0005wU-Ry
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721843664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fQ8gZbWh4Enhh7BTzUsWyevQnHlCtto6qzj/sj5Ygo=;
 b=AuvNBFTkYbj4VnyCeE+MurGUIsQlmF0bJZtVwhwc/fAhR1rgAOO5rf7Rc+ew+qleMpJvj7
 0eboQ3o1OZgMP3LGwQVMvReOsPUg+l7Ts/N/RF7n2z3ooCSmtWYXGlXPJuZ6NypocFmT8e
 A/ksDYASPTNxyK73Td11Y9e7hstJev4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-004kloNGM1aU8Mzy1Wbjsw-1; Wed,
 24 Jul 2024 13:54:16 -0400
X-MC-Unique: 004kloNGM1aU8Mzy1Wbjsw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3FE719540F1; Wed, 24 Jul 2024 17:54:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.144])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0AB81955D45; Wed, 24 Jul 2024 17:54:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 14/23] tests/functional: Convert the microblaze avocado
 tests into standalone tests
Date: Wed, 24 Jul 2024 19:52:32 +0200
Message-ID: <20240724175248.1389201-15-thuth@redhat.com>
In-Reply-To: <20240724175248.1389201-1-thuth@redhat.com>
References: <20240724175248.1389201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The machine_microblaze.py file contained two tests, one for each
endianess. Since we only support one QEMU target binary per file
in the new functional test environment, we have to split this file
up into two files now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 tests/avocado/machine_microblaze.py           | 61 -------------------
 tests/functional/meson.build                  |  8 +++
 .../functional/test_microblaze_s3adsp1800.py  | 38 ++++++++++++
 .../test_microblazeel_s3adsp1800.py           | 41 +++++++++++++
 5 files changed, 88 insertions(+), 62 deletions(-)
 delete mode 100644 tests/avocado/machine_microblaze.py
 create mode 100755 tests/functional/test_microblaze_s3adsp1800.py
 create mode 100755 tests/functional/test_microblazeel_s3adsp1800.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 209fe0f728..02cf39e94d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1327,7 +1327,7 @@ M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
 F: hw/microblaze/petalogix_s3adsp1800_mmu.c
 F: include/hw/char/xilinx_uartlite.h
-F: tests/avocado/machine_microblaze.py
+F: tests/functional/test_microblaze*.py
 
 petalogix_ml605
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
diff --git a/tests/avocado/machine_microblaze.py b/tests/avocado/machine_microblaze.py
deleted file mode 100644
index 807709cd11..0000000000
--- a/tests/avocado/machine_microblaze.py
+++ /dev/null
@@ -1,61 +0,0 @@
-# Functional test that boots a microblaze Linux kernel and checks the console
-#
-# Copyright (c) 2018, 2021 Red Hat, Inc.
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later. See the COPYING file in the top-level directory.
-
-import time
-from avocado_qemu import exec_command, exec_command_and_wait_for_pattern
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import archive
-
-class MicroblazeMachine(QemuSystemTest):
-
-    timeout = 90
-
-    def test_microblaze_s3adsp1800(self):
-        """
-        :avocado: tags=arch:microblaze
-        :avocado: tags=machine:petalogix-s3adsp1800
-        """
-
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day17.tar.xz')
-        tar_hash = '08bf3e3bfb6b6c7ce1e54ab65d54e189f2caf13f'
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        archive.extract(file_path, self.workdir)
-        self.vm.set_console()
-        self.vm.add_args('-kernel', self.workdir + '/day17/ballerina.bin')
-        self.vm.launch()
-        wait_for_console_pattern(self, 'This architecture does not have '
-                                       'kernel memory protection')
-        # Note:
-        # The kernel sometimes gets stuck after the "This architecture ..."
-        # message, that's why we don't test for a later string here. This
-        # needs some investigation by a microblaze wizard one day...
-
-    def test_microblazeel_s3adsp1800(self):
-        """
-        :avocado: tags=arch:microblazeel
-        :avocado: tags=machine:petalogix-s3adsp1800
-        """
-
-        self.require_netdev('user')
-        tar_url = ('http://www.qemu-advent-calendar.org/2023/download/'
-                   'day13.tar.gz')
-        tar_hash = '6623d5fff5f84cfa8f34e286f32eff6a26546f44'
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        archive.extract(file_path, self.workdir)
-        self.vm.set_console()
-        self.vm.add_args('-kernel', self.workdir + '/day13/xmaton.bin')
-        self.vm.add_args('-nic', 'user,tftp=' + self.workdir + '/day13/')
-        self.vm.launch()
-        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
-        time.sleep(0.1)
-        exec_command(self, 'root')
-        time.sleep(0.1)
-        exec_command_and_wait_for_pattern(self,
-                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
-                '821cd3cab8efd16ad6ee5acc3642a8ea')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index e0e1be68bb..a2c0398b03 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -34,6 +34,14 @@ tests_loongarch64_thorough = [
   'loongarch64_virt',
 ]
 
+tests_microblaze_thorough = [
+  'microblaze_s3adsp1800'
+]
+
+tests_microblazeel_thorough = [
+  'microblazeel_s3adsp1800'
+]
+
 tests_mips64el_thorough = [
   'mips64el_loongson3v',
 ]
diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
new file mode 100755
index 0000000000..3e46fa7453
--- /dev/null
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a microblaze Linux kernel and checks the console
+#
+# Copyright (c) 2018, 2021 Red Hat, Inc.
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later. See the COPYING file in the top-level directory.
+
+import time
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import archive_extract
+
+class MicroblazeMachine(QemuSystemTest):
+
+    timeout = 90
+
+    def test_microblaze_s3adsp1800(self):
+        self.set_machine('petalogix-s3adsp1800')
+        tar_url = ('https://qemu-advcal.gitlab.io'
+                   '/qac-best-of-multiarch/download/day17.tar.xz')
+        tar_hash = '08bf3e3bfb6b6c7ce1e54ab65d54e189f2caf13f'
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        archive_extract(file_path, self.workdir)
+        self.vm.set_console()
+        self.vm.add_args('-kernel', self.workdir + '/day17/ballerina.bin')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'This architecture does not have '
+                                       'kernel memory protection')
+        # Note:
+        # The kernel sometimes gets stuck after the "This architecture ..."
+        # message, that's why we don't test for a later string here. This
+        # needs some investigation by a microblaze wizard one day...
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
new file mode 100755
index 0000000000..3ec694db69
--- /dev/null
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -0,0 +1,41 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a microblaze Linux kernel and checks the console
+#
+# Copyright (c) 2018, 2021 Red Hat, Inc.
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later. See the COPYING file in the top-level directory.
+
+import time
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import archive_extract
+
+class MicroblazeelMachine(QemuSystemTest):
+
+    timeout = 90
+
+    def test_microblazeel_s3adsp1800(self):
+        self.require_netdev('user')
+        self.set_machine('petalogix-s3adsp1800')
+        tar_url = ('http://www.qemu-advent-calendar.org/2023/download/'
+                   'day13.tar.gz')
+        tar_hash = '6623d5fff5f84cfa8f34e286f32eff6a26546f44'
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        archive_extract(file_path, self.workdir)
+        self.vm.set_console()
+        self.vm.add_args('-kernel', self.workdir + '/day13/xmaton.bin')
+        self.vm.add_args('-nic', 'user,tftp=' + self.workdir + '/day13/')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
+        time.sleep(0.1)
+        exec_command(self, 'root')
+        time.sleep(0.1)
+        exec_command_and_wait_for_pattern(self,
+                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
+                '821cd3cab8efd16ad6ee5acc3642a8ea')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


