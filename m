Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E315AC5472C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 09:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sispT-0001Vp-L0; Tue, 27 Aug 2024 05:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sispR-0001T1-Mu
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:33 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sispC-00087m-W2
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:33 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a86883231b4so687250666b.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 02:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724752156; x=1725356956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4X6TRFYMmaxtsv96yS5TGFNVDmKt5lBez+VKj4/4Nk=;
 b=k+uaLie99cXGnV/lUbmORjQ/6/M+zgI5aDYWKKYbsthFJvuOkkQw4w4Y4ZbiEEnowB
 9SLBWDrtTCfKt6QG8kTwn0E5sPBxUtEpLGAMWDqqD48vsNWiL/o/xshvf9MEcmQpJaJF
 x3uNnY2f2vSXCw3MUYNbx5p9Cbo5ui/mNR+MOoY3J/Lta8obONa2jd8XN6YthFaQ4x/L
 SoYozlJ8bUNg3Bb96X1CbR8IiGqVPLzFw83+4dKpU0mvYvONpCHeJa5WaibJy+NHRCCY
 xogqwavN/vFwNydlSbPDoEoJ5V0gtKApwe0cUqI+rHiKAYK/SDpCm6kxDf07Eheuqa5o
 OcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724752156; x=1725356956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4X6TRFYMmaxtsv96yS5TGFNVDmKt5lBez+VKj4/4Nk=;
 b=iwRQ0UoXgw+ZVf+77xfOerYeDu082XUtB2rLgaLn2K0gjilgDVFXJhqDlvRkI7xeAb
 sZGm9Kf7sb6JLmWebHvHxssoNZfDKMGxSU/LuFygb8ZZ0SGXlMZ+71ULz2PboOFVYpUw
 aDohndiH5kV7g77EgmyBLWOyJXG8CWxOQ1ucqFVItneY6JjqW/DFjsuTxhXAQjeksw0i
 Zqwi8930nzsLDe8QEKAZduu6/6RCP/txN0ys0GsKmXvy1jRhTKXKwdgCm4TU/IimW2OU
 L/27VB6S3LBcM1I/pWxKz8UltZ4s7KCOucf1aLWR6R3X92wkJnpiKY34DD0PiDDfDO5Y
 hCZw==
X-Gm-Message-State: AOJu0Yz6ps03ER3KuMATN1SL9Gs7qzosDvLxPRdm5Xf4G+fAN+M18B8a
 gCMEsOaaMPABs0h17iLSmP+m6PSVMIPNTdN5YXSA2hzIQdi7cNdudCJlqGNC2SdByihposSLLa4
 F
X-Google-Smtp-Source: AGHT+IESsw6D14F1WGKIiWF6josWD6FsvXN6lAXq8B80nnD8ByruTHfnziwp9tSc6h0Ojh8lEg5UqQ==
X-Received: by 2002:a17:906:c14a:b0:a86:a41c:28b with SMTP id
 a640c23a62f3a-a86a52b1d91mr1002686966b.22.1724752155687; 
 Tue, 27 Aug 2024 02:49:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e582c41bsm88182066b.98.2024.08.27.02.49.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Aug 2024 02:49:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 1/7] tests/functional: Convert mips64el Fuloong2e avocado
 test (1/2)
Date: Tue, 27 Aug 2024 11:48:59 +0200
Message-ID: <20240827094905.80648-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240827094905.80648-1-philmd@linaro.org>
References: <20240827094905.80648-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
with RESCUE_YL_PATH, keep it under the 'quick' category.

  $ RESCUE_YL_PATH=/path/to/rescue-yl QEMU_TEST_ALLOW_UNTRUSTED_CODE=1 \
    make check-functional-mips64el
  1/4 qemu:func-quick+func-mips64el / func-mips64el-empty_cpu_model      OK   0.12s   1 subtests passed
  2/4 qemu:func-quick+func-mips64el / func-mips64el-version              OK   0.13s   1 subtests passed
  3/4 qemu:func-quick+func-mips64el / func-mips64el-info_usernet         OK   0.15s   1 subtests passed
  4/4 qemu:func-quick+func-mips64el / func-mips64el-mips64el_fuloong2e   OK   0.19s   1 subtests passed

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 tests/functional/meson.build                  |  4 +++
 .../test_mips64el_fuloong2e.py}               | 33 ++++++++++---------
 3 files changed, 23 insertions(+), 16 deletions(-)
 rename tests/{avocado/machine_mips_fuloong2e.py => functional/test_mips64el_fuloong2e.py} (58%)
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
2.45.2


