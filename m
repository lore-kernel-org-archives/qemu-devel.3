Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD66EC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 13:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sglTV-0002Lt-KT; Wed, 21 Aug 2024 09:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sglTV-0002Jq-3Q
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:34:09 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sglTT-0005zU-60
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:34:08 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3719753d365so3845259f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 06:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724247245; x=1724852045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/5CVPorpmlvV8ktBAwbQAoMuBJIzpihC/1ejoYbbYU=;
 b=hVATqWsC/GK3Dwk14l6eSgvG9p9DgiNcO0DJGuUw/eF7+ZE+TTswtHgiLmtiNhV0nE
 9dTaGtskpHXYwtC78FMteLgKsY5lY/9VG2/UHs9dWrTwAq1Nwlh9vJWPaIev0fp5MikR
 7Y0qbzWXCxaRk3zSAgOS2R8GcpJhwb0Bhp7MEfpSSeBhzVC0lT1SQVQU58Na/eQm27mZ
 gyHKOGf/95yLuPJc/PWLYNL7J5koAD8dYKqnVGAFHPyTOUHJBvWIya4hvHlxqVzK/c7F
 51IqcdiyiLYzk75X1uPorcIbMDSCsdcwHQcqqSV7+j9lCPy5i9r0duUzjzgr6JG7W3I/
 Iwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724247245; x=1724852045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z/5CVPorpmlvV8ktBAwbQAoMuBJIzpihC/1ejoYbbYU=;
 b=TCyRcmDe7hoBV4y/mQ3Cv4SJOdbS1ws7CyoHaSuTt2qdMT+IQNLbiq6QsRgDhz2HnM
 xsTYYUJzpkv0yPitf6w9GxSTnqzpPTyrQ9hmsgc9Vx/fqx8KeAaU5R6sMe35wOCEaiXp
 xLwfeLQgmv30X2P5Fir151BXpvZNLNAWpfR2IVWsOTnbGNNGNcT57DhxTe/ojLD1ikQ4
 lAeWbzQBEvJPvKtFEE8LhKr9lsebbDmvjs0H6RjE+An4/sk77C4gVPEDhNK1nTNtkdqs
 25GdlnmWCjacFXFz+cD9uc1hAUpO8XzZcl9wMIMYq39QJDdH8z64c88yaRbXoxkncBF/
 XnKA==
X-Gm-Message-State: AOJu0YxbF3qWKUdybP0LZs5XapLCtRGwNoXf5TnpEqFdolSFIiermEoA
 knEPibUORyqfunSZu7easyCWFZN6h1r5dt2YWvUZaJJZ2I6V18dgeGzkCWogNh9amwJljt8XzOM
 BFKk=
X-Google-Smtp-Source: AGHT+IFuJgHwkmHmdQY9y+QiLQKaFSSDOGIm8NdouM+BCSorizLff8qKGcPYxY48Qq9sk691e//X8A==
X-Received: by 2002:a5d:6650:0:b0:371:7e3f:6c7 with SMTP id
 ffacd0b85a97d-372fd5ca80fmr1708306f8f.36.1724247245118; 
 Wed, 21 Aug 2024 06:34:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3719f0a089fsm12616686f8f.0.2024.08.21.06.34.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Aug 2024 06:34:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v2 1/3] tests/functional: Convert mips fuloong2e avocado test
Date: Wed, 21 Aug 2024 15:33:51 +0200
Message-ID: <20240821133353.65903-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821133353.65903-1-philmd@linaro.org>
References: <20240821133353.65903-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
 .../test_mips64el_fuloong2e.py}               | 30 ++++++++++---------
 3 files changed, 21 insertions(+), 15 deletions(-)
 rename tests/{avocado/machine_mips_fuloong2e.py => functional/test_mips64el_fuloong2e.py} (61%)
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
similarity index 61%
rename from tests/avocado/machine_mips_fuloong2e.py
rename to tests/functional/test_mips64el_fuloong2e.py
index 89291f47b2..b1b46b187f
--- a/tests/avocado/machine_mips_fuloong2e.py
+++ b/tests/functional/test_mips64el_fuloong2e.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional tests for the Lemote Fuloong-2E machine.
 #
 # Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
@@ -8,35 +10,35 @@
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
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


