Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7614CD4847
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnRn-0007IV-5d; Wed, 04 Sep 2024 06:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRk-00070Q-Bg
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRh-0000Ty-VI
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zCKtLmGUpSzIGM3A2iYrWFV3rIa/PLuCFzNEn4QBQc=;
 b=LxyDGxlp76t9fipL7G3UjCe1tJb3wlNYHFcfzwMpWAnbFFlKEdEqPMetLQrEIls2RAH2e1
 V4XtLPyesn68qpvYctMhOPdyepYv+cFAh9a7rcAYfc9pCsSbO4saywZzgST5RKlpdQd1R4
 GJJ5+FvGx1CrYpPjqUbp4TnYZ3Jj0pc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-VFuTqON_PRqVR70QFzAKvw-1; Wed,
 04 Sep 2024 06:41:02 -0400
X-MC-Unique: VFuTqON_PRqVR70QFzAKvw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3D6D1955D4B; Wed,  4 Sep 2024 10:41:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F1ED1955F45; Wed,  4 Sep 2024 10:40:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/42] tests/functional: Convert mips64el Fuloong2e avocado
 test (1/2)
Date: Wed,  4 Sep 2024 12:39:09 +0200
Message-ID: <20240904103923.451847-35-thuth@redhat.com>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Straight forward conversion. Update the SHA1 hashes to
SHA256 hashes since SHA1 should not be used anymore nowadays.

Since the asset is expected locally and the test is guarded
with RESCUE_YL_PATH, keep it under the 'quick' category.

  $ RESCUE_YL_PATH=/path/to/rescue-yl QEMU_TEST_ALLOW_UNTRUSTED_CODE=1 \
    make check-functional-mips64el
  1/4 qemu:func-quick+func-mips64el / func-mips64el-empty_cpu_model      OK   0.12s   1 subtests passed
  2/4 qemu:func-quick+func-mips64el / func-mips64el-version              OK   0.13s   1 subtests passed
  3/4 qemu:func-quick+func-mips64el / func-mips64el-info_usernet         OK   0.15s   1 subtests passed
  4/4 qemu:func-quick+func-mips64el / func-mips64el-mips64el_fuloong2e   OK   0.19s   1 subtests passed

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240827094905.80648-2-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240830133841.142644-37-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 tests/functional/meson.build                  |  4 +++
 .../test_mips64el_fuloong2e.py}               | 33 ++++++++++---------
 3 files changed, 23 insertions(+), 16 deletions(-)
 rename tests/{avocado/machine_mips_fuloong2e.py => functional/test_mips64el_fuloong2e.py} (58%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index f49ab1e454..e221f3460f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1383,7 +1383,7 @@ S: Odd Fixes
 F: hw/mips/fuloong2e.c
 F: hw/pci-host/bonito.c
 F: include/hw/pci-host/bonito.h
-F: tests/avocado/machine_mips_fuloong2e.py
+F: tests/functional/test_mips64el_fuloong2e.py
 
 Loongson-3 virtual platforms
 M: Huacai Chen <chenhuacai@kernel.org>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 78d3a83a5a..35c4bad23f 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -64,6 +64,10 @@ tests_microblazeel_system_thorough = [
   'microblazeel_s3adsp1800'
 ]
 
+tests_mips64el_system_quick = [
+  'mips64el_fuloong2e',
+]
+
 tests_mips64el_system_thorough = [
   'mips64el_loongson3v',
 ]
diff --git a/tests/avocado/machine_mips_fuloong2e.py b/tests/functional/test_mips64el_fuloong2e.py
old mode 100644
new mode 100755
similarity index 58%
rename from tests/avocado/machine_mips_fuloong2e.py
rename to tests/functional/test_mips64el_fuloong2e.py
index 89291f47b2..7688a32713
--- a/tests/avocado/machine_mips_fuloong2e.py
+++ b/tests/functional/test_mips64el_fuloong2e.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional tests for the Lemote Fuloong-2E machine.
 #
 # Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
@@ -8,35 +10,36 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import os
+import subprocess
 
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
+from unittest import skipUnless
 
 class MipsFuloong2e(QemuSystemTest):
 
     timeout = 60
 
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     @skipUnless(os.getenv('RESCUE_YL_PATH'), 'RESCUE_YL_PATH not available')
-    def test_linux_kernel_isa_serial(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:fuloong2e
-        :avocado: tags=endian:little
-        :avocado: tags=device:bonito64
-        :avocado: tags=device:via686b
-        """
+    def test_linux_kernel_2_6_27_isa_serial(self):
         # Recovery system for the Yeeloong laptop
         # (enough to test the fuloong2e southbridge, accessing its ISA bus)
         # http://dev.lemote.com/files/resource/download/rescue/rescue-yl
-        kernel_hash = 'ec4d1bd89a8439c41033ca63db60160cc6d6f09a'
-        kernel_path = self.fetch_asset('file://' + os.getenv('RESCUE_YL_PATH'),
-                                       asset_hash=kernel_hash)
+        sha = 'ab588d3316777c62cc81baa20ac92e98b01955c244dff3794b711bc34e26e51d'
+        kernel_path = os.getenv('RESCUE_YL_PATH')
+        output = subprocess.check_output(['sha256sum', kernel_path])
+        checksum = output.split()[0]
+        assert checksum.decode("utf-8") == sha
 
+        self.set_machine('fuloong2e')
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_path)
         self.vm.launch()
         wait_for_console_pattern(self, 'Linux version 2.6.27.7lemote')
         cpu_revision = 'CPU revision is: 00006302 (ICT Loongson-2)'
         wait_for_console_pattern(self, cpu_revision)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


