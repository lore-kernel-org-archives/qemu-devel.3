Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399E7CA0FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 13:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk1sz-000463-ME; Fri, 30 Aug 2024 09:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1so-0003Dc-My
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:41:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1sl-0005em-Hu
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725025302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AiCpW9mlrliMsd0sml8PvZbAgZSRZheKGz2GIntE/hc=;
 b=CpHjW1nOSUyg54HAzlWVfxQ4/mH2rGvAewWeza0UH2SMsNefmNe4UwmQuJRBDD9/270hGr
 34AnDN4RHtdTMyLFOawmJAXGpaZxBsrfRTrHoMxvkvs82C+k0C2Ev0ppIVYgqmKy1w9+tD
 F11IEB4QfiYL5oQLUiQ2eFiAGe3FMUE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-3W5w2x5jNKWJQ4ynAB7ctg-1; Fri,
 30 Aug 2024 09:41:37 -0400
X-MC-Unique: 3W5w2x5jNKWJQ4ynAB7ctg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34DD31955BF7; Fri, 30 Aug 2024 13:41:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA8503001FE8; Fri, 30 Aug 2024 13:41:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 38/44] tests/functional: Convert ARM bFLT linux-user
 avocado test
Date: Fri, 30 Aug 2024 15:38:32 +0200
Message-ID: <20240830133841.142644-39-thuth@redhat.com>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Straight forward conversion. Update the SHA1 hashes to
SHA256 hashes since SHA1 should not be used anymore nowadays.
Expose cpio_extract() in qemu_test.utils for possible reuse.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240822104238.75045-3-philmd@linaro.org>
[thuth: Add test to meson.build]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/load_bflt.py          | 54 -----------------------------
 tests/functional/meson.build        |  4 +++
 tests/functional/qemu_test/utils.py |  9 +++++
 tests/functional/test_arm_bflt.py   | 44 +++++++++++++++++++++++
 4 files changed, 57 insertions(+), 54 deletions(-)
 delete mode 100644 tests/avocado/load_bflt.py
 create mode 100755 tests/functional/test_arm_bflt.py

diff --git a/tests/avocado/load_bflt.py b/tests/avocado/load_bflt.py
deleted file mode 100644
index bb50cec1ee..0000000000
--- a/tests/avocado/load_bflt.py
+++ /dev/null
@@ -1,54 +0,0 @@
-# Test the bFLT loader format
-#
-# Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-
-import os
-import bz2
-import subprocess
-
-from avocado import skipUnless
-from avocado_qemu import QemuUserTest
-from avocado_qemu import has_cmd
-
-
-class LoadBFLT(QemuUserTest):
-
-    def extract_cpio(self, cpio_path):
-        """
-        Extracts a cpio archive into the test workdir
-
-        :param cpio_path: path to the cpio archive
-        """
-        cwd = os.getcwd()
-        os.chdir(self.workdir)
-        with bz2.open(cpio_path, 'rb') as archive_cpio:
-            subprocess.run(['cpio', '-i'], input=archive_cpio.read(),
-                           stderr=subprocess.DEVNULL)
-        os.chdir(cwd)
-
-    @skipUnless(*has_cmd('cpio'))
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
-    def test_stm32(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=linux_user
-        :avocado: tags=quick
-        """
-        # See https://elinux.org/STM32#User_Space
-        rootfs_url = ('https://elinux.org/images/5/51/'
-                      'Stm32_mini_rootfs.cpio.bz2')
-        rootfs_hash = '9f065e6ba40cce7411ba757f924f30fcc57951e6'
-        rootfs_path_bz2 = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
-        busybox_path = os.path.join(self.workdir, "/bin/busybox")
-
-        self.extract_cpio(rootfs_path_bz2)
-
-        res = self.run(busybox_path)
-        ver = 'BusyBox v1.24.0.git (2015-02-03 22:17:13 CET) multi-call binary.'
-        self.assertIn(ver, res.stdout_text)
-
-        res = self.run(busybox_path, ['uname', '-a'])
-        unm = 'armv7l GNU/Linux'
-        self.assertIn(unm, res.stdout_text)
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index dcede9733e..6b00d240dd 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -45,6 +45,10 @@ tests_arm_system_thorough = [
   'arm_n8x0',
 ]
 
+tests_arm_linuxuser_thorough = [
+  'arm_bflt',
+]
+
 tests_avr_system_thorough = [
   'avr_mega2560',
 ]
diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
index 99eae5fc45..2a1cb60d38 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -12,6 +12,7 @@
 import lzma
 import os
 import shutil
+import subprocess
 import tarfile
 
 def archive_extract(archive, dest_dir, member=None):
@@ -45,3 +46,11 @@ def lzma_uncompress(xz_path, output_path):
         except:
             os.remove(output_path)
             raise
+
+def cpio_extract(cpio_handle, output_path):
+    cwd = os.getcwd()
+    os.chdir(output_path)
+    subprocess.run(['cpio', '-i'],
+                   input=cpio_handle.read(),
+                   stderr=subprocess.DEVNULL)
+    os.chdir(cwd)
diff --git a/tests/functional/test_arm_bflt.py b/tests/functional/test_arm_bflt.py
new file mode 100755
index 0000000000..281925d11a
--- /dev/null
+++ b/tests/functional/test_arm_bflt.py
@@ -0,0 +1,44 @@
+#!/usr/bin/env python3
+#
+# Test the bFLT loader format
+#
+# Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import bz2
+
+from qemu_test import QemuUserTest, Asset
+from qemu_test import has_cmd
+from qemu_test.utils import cpio_extract
+from unittest import skipUnless
+
+
+class LoadBFLT(QemuUserTest):
+
+    ASSET_ROOTFS = Asset(
+        ('https://elinux.org/images/5/51/Stm32_mini_rootfs.cpio.bz2'),
+         'eefb788e4980c9e8d6c9d60ce7d15d4da6bf4fbc6a80f487673824600d5ba9cc')
+
+    @skipUnless(*has_cmd('cpio'))
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    def test_stm32(self):
+        # See https://elinux.org/STM32#User_Space
+        rootfs_path_bz2 = self.ASSET_ROOTFS.fetch()
+        busybox_path = os.path.join(self.workdir, "bin/busybox")
+
+        with bz2.open(rootfs_path_bz2, 'rb') as cpio_handle:
+            cpio_extract(cpio_handle, self.workdir)
+
+        res = self.run_cmd(busybox_path)
+        ver = 'BusyBox v1.24.0.git (2015-02-03 22:17:13 CET) multi-call binary.'
+        self.assertIn(ver, res.stdout)
+
+        res = self.run_cmd(busybox_path, ['uname', '-a'])
+        unm = 'armv7l GNU/Linux'
+        self.assertIn(unm, res.stdout)
+
+
+if __name__ == '__main__':
+    QemuUserTest.main()
-- 
2.46.0


