Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D910BCA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnRU-000559-1R; Wed, 04 Sep 2024 06:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRQ-0004Sy-CA
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRO-0000Mb-61
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jiKAMk08Nd9GljgF49nsl0jS5O1JvMkVmtTyNvbDU4w=;
 b=cUI/+44d1mm3qnUNAz3svSpMfA0lqjzVItgzGq4lFvW/KeBXYnwsHWSGjE57/HGkP+qJGi
 niBMXkaKSfXd4AWbmj72IqZydGl+7iVyKaQ5Pfr11gj4dPPKrdAbrtSxQZ8Wqkm2I+1M+w
 h1eRuaMkELhORvDMxwCkB4MCVTuSrDs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-nR8YPxfYMhOMC64MGbUjpg-1; Wed,
 04 Sep 2024 06:40:44 -0400
X-MC-Unique: nR8YPxfYMhOMC64MGbUjpg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6900D19560B7; Wed,  4 Sep 2024 10:40:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49088195605A; Wed,  4 Sep 2024 10:40:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/42] tests/functional: Convert the m68k nextcube test with
 tesseract
Date: Wed,  4 Sep 2024 12:39:02 +0200
Message-ID: <20240904103923.451847-28-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240830133841.142644-29-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  1 +
 tests/avocado/tesseract_utils.py              | 46 -------------------
 tests/functional/meson.build                  |  4 ++
 tests/functional/qemu_test/tesseract.py       | 35 ++++++++++++++
 .../test_m68k_nextcube.py}                    | 29 ++++++------
 5 files changed, 56 insertions(+), 59 deletions(-)
 delete mode 100644 tests/avocado/tesseract_utils.py
 create mode 100644 tests/functional/qemu_test/tesseract.py
 rename tests/{avocado/machine_m68k_nextcube.py => functional/test_m68k_nextcube.py} (75%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 52b53d693e..70dd2430db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1282,6 +1282,7 @@ S: Odd Fixes
 F: hw/m68k/next-*.c
 F: hw/display/next-fb.c
 F: include/hw/m68k/next-cube.h
+F: tests/functional/test_m68k_nextcube.py
 
 q800
 M: Laurent Vivier <laurent@vivier.eu>
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
index fcb99c547d..61cdd1d598 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -43,6 +43,10 @@ tests_loongarch64_system_thorough = [
   'loongarch64_virt',
 ]
 
+tests_m68k_system_thorough = [
+  'm68k_nextcube'
+]
+
 tests_microblaze_system_thorough = [
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
similarity index 75%
rename from tests/avocado/machine_m68k_nextcube.py
rename to tests/functional/test_m68k_nextcube.py
index 1f3c883910..89385a134a
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
+from qemu_test import QemuSystemTest, Asset
+from unittest import skipUnless
 
-from tesseract_utils import tesseract_available, tesseract_ocr
+from qemu_test.tesseract import tesseract_available, tesseract_ocr
 
 PIL_AVAILABLE = True
 try:
@@ -21,19 +23,15 @@
 
 
 class NextCubeMachine(QemuSystemTest):
-    """
-    :avocado: tags=arch:m68k
-    :avocado: tags=machine:next-cube
-    :avocado: tags=device:framebuffer
-    """
 
     timeout = 15
 
+    ASSET_ROM = Asset(('https://sourceforge.net/p/previous/code/1350/tree/'
+                       'trunk/src/Rev_2.5_v66.BIN?format=raw'),
+                      '1b753890b67095b73e104c939ddf62eca9e7d0aedde5108e3893b0ed9d8000a4')
+
     def check_bootrom_framebuffer(self, screenshot_path):
-        rom_url = ('https://sourceforge.net/p/previous/code/1350/tree/'
-                   'trunk/src/Rev_2.5_v66.BIN?format=raw')
-        rom_hash = 'b3534796abae238a0111299fc406a9349f7fee24'
-        rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
+        rom_path = self.ASSET_ROM.fetch()
 
         self.vm.add_args('-bios', rom_path)
         self.vm.launch()
@@ -48,6 +46,7 @@ def check_bootrom_framebuffer(self, screenshot_path):
 
     @skipUnless(PIL_AVAILABLE, 'Python PIL not installed')
     def test_bootrom_framebuffer_size(self):
+        self.set_machine('next-cube')
         screenshot_path = os.path.join(self.workdir, "dump.ppm")
         self.check_bootrom_framebuffer(screenshot_path)
 
@@ -60,11 +59,15 @@ def test_bootrom_framebuffer_size(self):
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
2.46.0


