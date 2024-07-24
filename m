Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BE0C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWgDP-00033l-Vm; Wed, 24 Jul 2024 13:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWgCi-0000B2-D8
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWgCa-00061A-Fd
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721843697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HG7eUfDGlcxerSL0HZi4cDvZ7LNvLXtyR8x7NMPMCLg=;
 b=ZeQbAm3knNZPLgXpr7R5QXQf1xC0lZdmekc8JUBbSwNUVMfTBRCqtBL/dG8gcgmNX9sVtA
 DiNstpUblO7Q76ErPcpIpra1HXvZOE1r/0yoo15ig+sJPDGu0sYXYV97X5lpA1ssfmA9Gc
 uEXSluRLsp51MBsQCjcXvXTSfPyk3tE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-U809HdEuN3uKshoVw5vnZw-1; Wed,
 24 Jul 2024 13:54:50 -0400
X-MC-Unique: U809HdEuN3uKshoVw5vnZw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00AC01979201; Wed, 24 Jul 2024 17:54:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.144])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 262721955D42; Wed, 24 Jul 2024 17:54:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 20/23] tests/functional: Convert the m68k nextcube test
 with tesseract
Date: Wed, 24 Jul 2024 19:52:38 +0200
Message-ID: <20240724175248.1389201-21-thuth@redhat.com>
In-Reply-To: <20240724175248.1389201-1-thuth@redhat.com>
References: <20240724175248.1389201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The code that handles running of tesseract needs to be tweaked a little
bit to be able to run without the functions from avocado.utils, and
while we're at it, drop some legacy stuff that was still there due to
Tesseract 3 support that we already dropped a while ago.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/tesseract_utils.py              | 46 -------------------
 tests/functional/meson.build                  |  4 ++
 tests/functional/qemu_test/tesseract.py       | 35 ++++++++++++++
 .../test_m68k_nextcube.py}                    | 20 ++++----
 4 files changed, 50 insertions(+), 55 deletions(-)
 delete mode 100644 tests/avocado/tesseract_utils.py
 create mode 100644 tests/functional/qemu_test/tesseract.py
 rename tests/{avocado/machine_m68k_nextcube.py => functional/test_m68k_nextcube.py} (86%)
 mode change 100644 => 100755

diff --git a/tests/avocado/tesseract_utils.py b/tests/avocado/tesseract_utils.py
deleted file mode 100644
index 476f528147..0000000000
--- a/tests/avocado/tesseract_utils.py
+++ /dev/null
@@ -1,46 +0,0 @@
-# ...
-#
-# Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later. See the COPYING file in the top-level directory.
-
-import re
-import logging
-
-from avocado.utils import process
-from avocado.utils.path import find_command, CmdNotFoundError
-
-def tesseract_available(expected_version):
-    try:
-        find_command('tesseract')
-    except CmdNotFoundError:
-        return False
-    res = process.run('tesseract --version')
-    try:
-        version = res.stdout_text.split()[1]
-    except IndexError:
-        version = res.stderr_text.split()[1]
-    return int(version.split('.')[0]) >= expected_version
-
-    match = re.match(r'tesseract\s(\d)', res)
-    if match is None:
-        return False
-    # now this is guaranteed to be a digit
-    return int(match.groups()[0]) >= expected_version
-
-
-def tesseract_ocr(image_path, tesseract_args='', tesseract_version=3):
-    console_logger = logging.getLogger('tesseract')
-    console_logger.debug(image_path)
-    if tesseract_version == 4:
-        tesseract_args += ' --oem 1'
-    proc = process.run("tesseract {} {} stdout".format(tesseract_args,
-                                                       image_path))
-    lines = []
-    for line in proc.stdout_text.split('\n'):
-        sline = line.strip()
-        if len(sline):
-            console_logger.debug(sline)
-            lines += [sline]
-    return lines
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 74347cf545..109e0408e4 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -36,6 +36,10 @@ tests_loongarch64_thorough = [
   'loongarch64_virt',
 ]
 
+tests_m68k_thorough = [
+  'm68k_nextcube'
+]
+
 tests_microblaze_thorough = [
   'microblaze_s3adsp1800'
 ]
diff --git a/tests/functional/qemu_test/tesseract.py b/tests/functional/qemu_test/tesseract.py
new file mode 100644
index 0000000000..c4087b7c11
--- /dev/null
+++ b/tests/functional/qemu_test/tesseract.py
@@ -0,0 +1,35 @@
+# ...
+#
+# Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later. See the COPYING file in the top-level directory.
+
+import re
+import logging
+
+from . import has_cmd, run_cmd
+
+def tesseract_available(expected_version):
+    if not has_cmd('tesseract'):
+        return False
+    (stdout, stderr, ret) = run_cmd([ 'tesseract', '--version'])
+    if ret:
+        return False
+    version = stdout.split()[1]
+    return int(version.split('.')[0]) >= expected_version
+
+def tesseract_ocr(image_path, tesseract_args=''):
+    console_logger = logging.getLogger('console')
+    console_logger.debug(image_path)
+    (stdout, stderr, ret) = run_cmd(['tesseract', image_path,
+                                     'stdout'])
+    if ret:
+        return None
+    lines = []
+    for line in stdout.split('\n'):
+        sline = line.strip()
+        if len(sline):
+            console_logger.debug(sline)
+            lines += [sline]
+    return lines
diff --git a/tests/avocado/machine_m68k_nextcube.py b/tests/functional/test_m68k_nextcube.py
old mode 100644
new mode 100755
similarity index 86%
rename from tests/avocado/machine_m68k_nextcube.py
rename to tests/functional/test_m68k_nextcube.py
index 1f3c883910..4595032af5
--- a/tests/avocado/machine_m68k_nextcube.py
+++ b/tests/functional/test_m68k_nextcube.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots a VM and run OCR on the framebuffer
 #
 # Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
@@ -8,10 +10,10 @@
 import os
 import time
 
-from avocado_qemu import QemuSystemTest
-from avocado import skipUnless
+from qemu_test import QemuSystemTest
+from unittest import skipUnless
 
-from tesseract_utils import tesseract_available, tesseract_ocr
+from qemu_test.tesseract import tesseract_available, tesseract_ocr
 
 PIL_AVAILABLE = True
 try:
@@ -21,11 +23,6 @@
 
 
 class NextCubeMachine(QemuSystemTest):
-    """
-    :avocado: tags=arch:m68k
-    :avocado: tags=machine:next-cube
-    :avocado: tags=device:framebuffer
-    """
 
     timeout = 15
 
@@ -48,6 +45,7 @@ def check_bootrom_framebuffer(self, screenshot_path):
 
     @skipUnless(PIL_AVAILABLE, 'Python PIL not installed')
     def test_bootrom_framebuffer_size(self):
+        self.set_machine('next-cube')
         screenshot_path = os.path.join(self.workdir, "dump.ppm")
         self.check_bootrom_framebuffer(screenshot_path)
 
@@ -60,11 +58,15 @@ def test_bootrom_framebuffer_size(self):
     # that it is still alpha-level software.
     @skipUnless(tesseract_available(4), 'tesseract OCR tool not available')
     def test_bootrom_framebuffer_ocr_with_tesseract(self):
+        self.set_machine('next-cube')
         screenshot_path = os.path.join(self.workdir, "dump.ppm")
         self.check_bootrom_framebuffer(screenshot_path)
-        lines = tesseract_ocr(screenshot_path, tesseract_version=4)
+        lines = tesseract_ocr(screenshot_path)
         text = '\n'.join(lines)
         self.assertIn('Testing the FPU', text)
         self.assertIn('System test failed. Error code', text)
         self.assertIn('Boot command', text)
         self.assertIn('Next>', text)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


