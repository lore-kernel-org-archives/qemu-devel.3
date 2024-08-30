Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF381CA0FF4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 13:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk1rx-00043e-89; Fri, 30 Aug 2024 09:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1rs-0003Gf-1R
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1rm-0005Wc-TC
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725025235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKa18JymFuE/04dpvL3CkD3F6pYvf0w7sZ+JXzXgV2E=;
 b=Tjbr/sn3oXEfHD5txL9OoRSC1YnJOOfX0FURW6y2COvCIxHN5OxH1+7JZwGEhZ4b0r32Mv
 4zMkV2YPUpBHg/k1OVwGmd3Ca8JiiHcimnkBfNQqk+IY5B8rERaj4k7MZ+347/V/V6ynDo
 yx2dBxVmpPD8JgTA8FrcE8NPQY7hKXY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-wMrfR-PQMS2Nj3B5982kCg-1; Fri,
 30 Aug 2024 09:40:32 -0400
X-MC-Unique: wMrfR-PQMS2Nj3B5982kCg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3ED4D1955F42; Fri, 30 Aug 2024 13:40:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78211300019C; Fri, 30 Aug 2024 13:40:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 22/44] tests/functional: Convert the microblaze avocado
 tests into standalone tests
Date: Fri, 30 Aug 2024 15:38:16 +0200
Message-ID: <20240830133841.142644-23-thuth@redhat.com>
In-Reply-To: <20240830133841.142644-1-thuth@redhat.com>
References: <20240830133841.142644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The machine_microblaze.py file contained two tests, one for each
endianness. Since we only support one QEMU target binary per file
in the new functional test environment, we have to split this file
up into two files now.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 tests/avocado/machine_microblaze.py           | 61 -------------------
 tests/functional/meson.build                  |  8 +++
 .../functional/test_microblaze_s3adsp1800.py  | 40 ++++++++++++
 .../test_microblazeel_s3adsp1800.py           | 42 +++++++++++++
 5 files changed, 91 insertions(+), 62 deletions(-)
 delete mode 100644 tests/avocado/machine_microblaze.py
 create mode 100755 tests/functional/test_microblaze_s3adsp1800.py
 create mode 100755 tests/functional/test_microblazeel_s3adsp1800.py

diff --git a/MAINTAINERS b/MAINTAINERS
index bbb8fc78c5..91f5a0545f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1329,7 +1329,7 @@ M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
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
index 540e1361f8..f32afed30f 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -40,6 +40,14 @@ tests_loongarch64_system_thorough = [
   'loongarch64_virt',
 ]
 
+tests_microblaze_system_thorough = [
+  'microblaze_s3adsp1800'
+]
+
+tests_microblazeel_system_thorough = [
+  'microblazeel_s3adsp1800'
+]
+
 tests_mips64el_system_thorough = [
   'mips64el_loongson3v',
 ]
diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
new file mode 100755
index 0000000000..4f692ffdb1
--- /dev/null
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -0,0 +1,40 @@
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
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import archive_extract
+
+class MicroblazeMachine(QemuSystemTest):
+
+    timeout = 90
+
+    ASSET_IMAGE = Asset(
+        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
+         'day17.tar.xz'),
+        '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
+
+    def test_microblaze_s3adsp1800(self):
+        self.set_machine('petalogix-s3adsp1800')
+        file_path = self.ASSET_IMAGE.fetch()
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
index 0000000000..faa3927f2e
--- /dev/null
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -0,0 +1,42 @@
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
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import archive_extract
+
+class MicroblazeelMachine(QemuSystemTest):
+
+    timeout = 90
+
+    ASSET_IMAGE = Asset(
+        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
+        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
+
+    def test_microblazeel_s3adsp1800(self):
+        self.require_netdev('user')
+        self.set_machine('petalogix-s3adsp1800')
+        file_path = self.ASSET_IMAGE.fetch()
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
2.46.0


