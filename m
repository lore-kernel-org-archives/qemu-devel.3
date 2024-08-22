Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85614C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 10:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh5HR-0003XO-37; Thu, 22 Aug 2024 06:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh5HP-0003Wk-UP
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 06:42:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh5HN-0001A6-TO
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 06:42:59 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37182eee02dso349587f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 03:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724323376; x=1724928176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DC8WY1PhyTAf9am5ZSe2JMSlfNoWjsSxlIuu/lXOwxk=;
 b=KXlFDSlXcJ7ZDQdDXRcnWfghd1SjHNoUjXpVIMnBm5UdDRFd1ORv9cyy4HyIm/L0N1
 Q3Vlwure3OgzxkFHmeP4Za/N4m+qVHeyQuzt4SV5v7ZwnPv7H2TpD8+Df2C2VM7O+4I2
 rb1g/LrovNsJ8PTPM7zNXUuZS2PFUeu0OMteM3b/j1gL8vg9RBxgMvfLgaFBdfwsPvvm
 1wIWTHJYlxTuJNHsh/WpW25UTmdsp/AxC8/XF74S6RlUlpgKMXGVg2ecmlJRnw+f8jfy
 IdZBYJNGlZv92xdoHw9zakVWto1w3q4e0cqyvLKluzUN7NWS3yWY51TBWhnSmmRv6KsC
 YVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724323376; x=1724928176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DC8WY1PhyTAf9am5ZSe2JMSlfNoWjsSxlIuu/lXOwxk=;
 b=oViHZdB5VsxO/9x5d5t//PldktA3IZ9o22TfP4AoVGoSkQFeW898f+CW4kDQdwnuZQ
 uAsyAUxIFzUnV0FvEilrhRICPutoQHAFiqAF9L+nwi88BiJPAis+uiTlhT6f4S093kI1
 864MEgEADLmoDvt1g6BdmYeeLdVL6R8vOEaEkMG2VNqkUo9W5vm+U25lUQ+oXKz83jZM
 Tx4+GS7VkE7rvAUWWSJfNTZanAXdbD4oemuVfRQvIvbO5mWK0tTvjLL27Q2wtcsoM2Ay
 wf52OtmEQAMVoL6jPg4FMlxz33UovT7mrHJu0HZBG0p8rbqmZBFNr1bJpeEJWOKi1kSW
 7H5A==
X-Gm-Message-State: AOJu0YwUOq1+zNDPqwrEALC1M0gLfsNaCS07P8g8NrMqv+6v6UGTne0t
 BQgpIB0f8CBqQOPOMwEFP9KkcMSkR5F9nBpySrdWUjlc2y1r2ZlJPRbixOwwPVEFP9glfTlBTtd
 0
X-Google-Smtp-Source: AGHT+IF0txux8SMKsMk+6xA7HolxzrMWXAJtS+DYe713cIRf694nJ6GwfX5soAUQJwwu3pTgR+O9nw==
X-Received: by 2002:adf:b317:0:b0:360:8c88:ab82 with SMTP id
 ffacd0b85a97d-373052a6411mr1584842f8f.30.1724323375957; 
 Thu, 22 Aug 2024 03:42:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373082657bdsm1356514f8f.107.2024.08.22.03.42.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Aug 2024 03:42:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 2/3] tests/functional: Convert ARM bFLT linux-user avocado test
Date: Thu, 22 Aug 2024 12:42:37 +0200
Message-ID: <20240822104238.75045-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822104238.75045-1-philmd@linaro.org>
References: <20240822104238.75045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Straight forward conversion. Update the SHA1 hashes to
SHA256 hashes since SHA1 should not be used anymore nowadays.
Expose cpio_extract() in qemu_test.utils for possible reuse.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Missing meson plumbing, i.e. adding to tests_arm_thorough[]
---
 tests/avocado/load_bflt.py          | 54 -----------------------------
 tests/functional/qemu_test/utils.py |  9 +++++
 tests/functional/test_arm_bflt.py   | 44 +++++++++++++++++++++++
 3 files changed, 53 insertions(+), 54 deletions(-)
 delete mode 100644 tests/avocado/load_bflt.py
 create mode 100755 tests/functional/test_arm_bflt.py

diff --git a/tests/avocado/load_bflt.py b/tests/avocado/load_bflt.py
deleted file mode 100644
index 264489ee25..0000000000
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
-        busybox_path = os.path.join(self.workdir, "bin/busybox")
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
2.45.2


