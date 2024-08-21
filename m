Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6911BC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 11:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgjXc-00022m-1Q; Wed, 21 Aug 2024 07:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgjXZ-000221-UM
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 07:30:14 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgjXU-0007xP-Gg
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 07:30:11 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3718eaf4046so4316953f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 04:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724239804; x=1724844604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0w11mdwk0mjTNE8eisSs7ZI23VdKiIpk79+Xx1lAkyo=;
 b=m4KrWtw3Xkv4Cg0DnPNRLEBIAku/g/eqdWBaDazSAXhWLGXDMMe0ra25vOJa1+FkHj
 KHOwVzuIn4qAyhYyNG7X8nheMYfpiTn5mT0fkp3uF+fS30qcpCWqWH/nwP+KnIx9UfA+
 +ZncHW9LRJwF5k6zbvrRcOAVf3HtZg2QAwXWKZOa6hsBairE0tVeFHznge97mgnFQTC4
 eRwZoOe6hoktzOjD6VVCud/OpVNmHRN3Qf5NDf1hjQqIX2B/lBtcbIy3i9hazMbzorFd
 6NUZgf3Rloic68ZLEehtJXe7D5IsYP3EnxD2KzdV0BSFsV81cWBNsrFr8eQZaW56mT+o
 TCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724239804; x=1724844604;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0w11mdwk0mjTNE8eisSs7ZI23VdKiIpk79+Xx1lAkyo=;
 b=q7fKcwnrZ+x+56JsLlkwJ1TyfgWfEsO69cyneP1Hm/K9ID9lbrupVuGxUnWaaa9jn3
 rwT1KYoeyI6yYjnIw5FBbHw+rWXOqHhPPOwQvE+jaoIxJizde2N+Wsx0F56fKjqK9oN/
 8tffpPD/lrYxO0Dlla2BAlex+HOjo61UUpeN7aMOKQdx06FsoMTZLgho/y5yKx5372Fe
 BQiegVbE/crFgPAx8kJUTznFlWis3O20+gsL0PXpZAIK220VJa3wnNjfPDFBjjnaBFCM
 xRmlDiV7PNxmaHvS2nAUpUM4kiKgtquqgTndpp4F3mCipIAhu/g2+TsnUtk3nzHDPFvP
 JZyQ==
X-Gm-Message-State: AOJu0Yw+EW3PYA0Ocd+wl1OW0fweKDe2tfVSj5+c6TR/G6EpoUlfojcm
 BYcO3F+q6ASzjjhMDC6E2SF6rBYbVDnOWE+84yZm9lKvrcwwVwGS5uJMfQRMHQrqfwpfLyENq4/
 Dnvg=
X-Google-Smtp-Source: AGHT+IHkMQiY33WUEhMjivAIcdHAREDPmvi2pruyMZQZUiQ7Bq+GVT3GkeCEswAfeN/FNHBVaMNLHg==
X-Received: by 2002:adf:f509:0:b0:368:4489:8efb with SMTP id
 ffacd0b85a97d-372fd720fd7mr1618173f8f.40.1724239804469; 
 Wed, 21 Aug 2024 04:30:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37195c57d48sm13355521f8f.53.2024.08.21.04.30.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Aug 2024 04:30:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] tests/functional: Convert mips fuloong2e avocado test
Date: Wed, 21 Aug 2024 13:29:59 +0200
Message-ID: <20240821112959.54237-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Since the asset is expected locally and the test is guarded
with QEMU_TEST_ALLOW_UNTRUSTED_CODE, keep it under the 'quick'
category.

  $ RESCUE_YL_PATH=/path/to/rescue-yl QEMU_TEST_ALLOW_UNTRUSTED_CODE=1 \
    make check-functional-mips64el
  1/4 qemu:func-quick+func-mips64el / func-mips64el-empty_cpu_model      OK   0.12s   1 subtests passed
  2/4 qemu:func-quick+func-mips64el / func-mips64el-version              OK   0.13s   1 subtests passed
  3/4 qemu:func-quick+func-mips64el / func-mips64el-info_usernet         OK   0.15s   1 subtests passed
  4/4 qemu:func-quick+func-mips64el / func-mips64el-mips64el_fuloong2e   OK   0.19s   1 subtests passed

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20240821082748.65853-1-thuth@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 tests/functional/meson.build                  |  4 +++
 .../test_mips64el_fuloong2e.py}               | 32 +++++++++----------
 3 files changed, 21 insertions(+), 17 deletions(-)
 rename tests/{avocado/machine_mips_fuloong2e.py => functional/test_mips64el_fuloong2e.py} (56%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 25e71ac14c..77fbb5d42e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1384,7 +1384,7 @@ S: Odd Fixes
 F: hw/mips/fuloong2e.c
 F: hw/pci-host/bonito.c
 F: include/hw/pci-host/bonito.h
-F: tests/avocado/machine_mips_fuloong2e.py
+F: tests/functional/test_mips64el_fuloong2e.py
 
 Loongson-3 virtual platforms
 M: Huacai Chen <chenhuacai@kernel.org>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 12e08e365b..8d28313a65 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -51,6 +51,10 @@ tests_microblazeel_thorough = [
   'microblazeel_s3adsp1800'
 ]
 
+tests_mips64el_quick = [
+  'mips64el_fuloong2e',
+]
+
 tests_mips64el_thorough = [
   'mips64el_loongson3v',
 ]
diff --git a/tests/avocado/machine_mips_fuloong2e.py b/tests/functional/test_mips64el_fuloong2e.py
old mode 100644
new mode 100755
similarity index 56%
rename from tests/avocado/machine_mips_fuloong2e.py
rename to tests/functional/test_mips64el_fuloong2e.py
index 89291f47b2..523dce4ec4
--- a/tests/avocado/machine_mips_fuloong2e.py
+++ b/tests/functional/test_mips64el_fuloong2e.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional tests for the Lemote Fuloong-2E machine.
 #
 # Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
@@ -9,34 +11,32 @@
 
 import os
 
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from unittest import skipUnless
 
 class MipsFuloong2e(QemuSystemTest):
 
     timeout = 60
 
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
-    @skipUnless(os.getenv('RESCUE_YL_PATH'), 'RESCUE_YL_PATH not available')
+    ASSET_KERNEL = Asset(
+        # http://dev.lemote.com/files/resource/download/rescue/rescue-yl
+        ('file://' + os.getenv('RESCUE_YL_PATH')),
+        'ab588d3316777c62cc81baa20ac92e98b01955c244dff3794b711bc34e26e51d')
+
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_linux_kernel_isa_serial(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:fuloong2e
-        :avocado: tags=endian:little
-        :avocado: tags=device:bonito64
-        :avocado: tags=device:via686b
-        """
         # Recovery system for the Yeeloong laptop
         # (enough to test the fuloong2e southbridge, accessing its ISA bus)
-        # http://dev.lemote.com/files/resource/download/rescue/rescue-yl
-        kernel_hash = 'ec4d1bd89a8439c41033ca63db60160cc6d6f09a'
-        kernel_path = self.fetch_asset('file://' + os.getenv('RESCUE_YL_PATH'),
-                                       asset_hash=kernel_hash)
+        kernel_path = self.ASSET_KERNEL.fetch()
 
+        self.set_machine('fuloong2e')
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_path)
         self.vm.launch()
         wait_for_console_pattern(self, 'Linux version 2.6.27.7lemote')
         cpu_revision = 'CPU revision is: 00006302 (ICT Loongson-2)'
         wait_for_console_pattern(self, cpu_revision)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


