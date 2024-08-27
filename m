Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C21C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 09:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sispe-00022B-SK; Tue, 27 Aug 2024 05:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sispd-0001zQ-8W
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:45 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sispb-0008Ad-6o
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:45 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-53345604960so5706727e87.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 02:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724752181; x=1725356981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SRm13bKO9QDQJ19FR2MtATnHDWXRSONTJTrN3dMHxs=;
 b=D6aR4jxTXQ4C3Nl3wIfh5wBKket3/xJtdmyJiE2kNzopG9EqGucCJvxTGI/55EHmZm
 XxgDFNN4661wZKAtksbR8wIHPlWuQqUofath8LbzpuAzlGwzAGp84HiCzHk+WU4iUaT4
 imHJB7ZFT4sS23AlaDRT8LqO44O+EykR7dOswuvHFVUbi9SkJI5UMtx/LFz+z79t7ISa
 H7ZUj3HoaB/QMLaRd3250JvCnjm0ylfvEtwEQtFCVqvnB6zZc7Q1u8jf9p1xx78E7KHl
 8IjNpJgcUb8n76SPfzaplrjE41iztdzqhkrUiBXe7Fz+IMDZ5Btg0WlutgcwoVEwd5j4
 XBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724752181; x=1725356981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/SRm13bKO9QDQJ19FR2MtATnHDWXRSONTJTrN3dMHxs=;
 b=O2K/qp3sX8kPuuzlZVgQVTka6TBNqyOa7Mva70cgEdCqhfUMZ2FL62Ojv/fWgLBak0
 /23w7d6n8QywKct6HqeXZo0FdD3CVnZDZTbWJ3/TXcyVmD8Pp9+gMO0QnHisuxjkv3Qq
 8K98zU6BSROmE4fdyfEifmUOTQAxhG9vHfOP82clbtojCCympw//4tMDsHKmmuOiJWtZ
 GJWVXApwf8s2YXIdDtMDhFel+pvqblT5p8GJLeBDyNJTcQXTRAIcS55jjGp7ebxiCtui
 QQEAmKWZjUgUZpsFMP34jqtT2+/eONT1j8UxgT8zw3dMAYNtc0+fPoeUOiU91ZxKOD6f
 KPtg==
X-Gm-Message-State: AOJu0Yy/kqO7B7OEMxCCVF4WdEMkRasCW+OUkfDBCdbIu0ZOKCU/N37J
 QVskfrzbor+xnXXR4kcijKm3Q3LGDqdcdb1Ksz4Ozi+cT7Iaw+3jBbokjepsHb5YV8Ue77lGKJB
 R
X-Google-Smtp-Source: AGHT+IEN1lB5JpS5AZaRs3y0y//AS28KhjXKf0+OciCZnUr8zZrO0i20WEPblgen6GQYRGMbncXFFA==
X-Received: by 2002:a05:6512:23a9:b0:530:ad8b:de0a with SMTP id
 2adb3069b0e04-534387557d1mr8274778e87.9.1724752180964; 
 Tue, 27 Aug 2024 02:49:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e594d9eesm87951866b.189.2024.08.27.02.49.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Aug 2024 02:49:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 5/7] tests/functional: Convert mips32el Malta YAMON avocado
 test
Date: Tue, 27 Aug 2024 11:49:03 +0200
Message-ID: <20240827094905.80648-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240827094905.80648-1-philmd@linaro.org>
References: <20240827094905.80648-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

Straight forward conversion using the Python standard zipfile
module instead of avocado.utils package. Update the SHA1 hashes
to SHA256 hashes since SHA1 should not be used anymore nowadays.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                             |  2 +-
 tests/avocado/machine_mips_malta.py     | 54 -------------------------
 tests/functional/meson.build            |  4 ++
 tests/functional/test_mips64el_malta.py |  3 ++
 tests/functional/test_mipsel_malta.py   | 47 +++++++++++++++++++++
 5 files changed, 55 insertions(+), 55 deletions(-)
 delete mode 100644 tests/avocado/machine_mips_malta.py
 create mode 100755 tests/functional/test_mipsel_malta.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a91017979..4b480135f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1368,7 +1368,7 @@ F: hw/mips/malta.c
 F: hw/pci-host/gt64120.c
 F: include/hw/southbridge/piix.h
 F: tests/avocado/linux_ssh_mips_malta.py
-F: tests/avocado/machine_mips_malta.py
+F: tests/functional/test_mipsel_malta.py
 F: tests/functional/test_mips64el_malta.py
 
 Mipssim
diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
deleted file mode 100644
index 05c64e18c4..0000000000
--- a/tests/avocado/machine_mips_malta.py
+++ /dev/null
@@ -1,54 +0,0 @@
-# Functional tests for the MIPS Malta board
-#
-# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or later.
-# See the COPYING file in the top-level directory.
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-
-import os
-
-from avocado.utils import archive
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import interrupt_interactive_console_until_pattern
-from avocado_qemu import wait_for_console_pattern
-
-
-class MaltaMachine(QemuSystemTest):
-
-    def do_test_yamon(self):
-        rom_url = ('https://s3-eu-west-1.amazonaws.com/'
-                   'downloads-mips/mips-downloads/'
-                   'YAMON/yamon-bin-02.22.zip')
-        rom_hash = '8da7ecddbc5312704b8b324341ee238189bde480'
-        zip_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
-
-        archive.extract(zip_path, self.workdir)
-        yamon_path = os.path.join(self.workdir, 'yamon-02.22.bin')
-
-        self.vm.set_console()
-        self.vm.add_args('-bios', yamon_path)
-        self.vm.launch()
-
-        prompt =  'YAMON>'
-        pattern = 'YAMON ROM Monitor'
-        interrupt_interactive_console_until_pattern(self, pattern, prompt)
-        wait_for_console_pattern(self, prompt)
-        self.vm.shutdown()
-
-    def test_mipsel_malta_yamon(self):
-        """
-        :avocado: tags=arch:mipsel
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        """
-        self.do_test_yamon()
-
-    def test_mips64el_malta_yamon(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        """
-        self.do_test_yamon()
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index a82dbd43bb..f8e482a87c 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -51,6 +51,10 @@ tests_microblazeel_thorough = [
   'microblazeel_s3adsp1800'
 ]
 
+tests_mipsel_thorough = [
+  'mipsel_malta',
+]
+
 tests_mips64el_quick = [
   'mips64el_fuloong2e',
 ]
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index 9f33146c89..2c781d0c8d 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -183,5 +183,8 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         self.do_test_i6400_framebuffer_logo(8)
 
 
+from test_mipsel_malta import MaltaMachineYAMON
+
+
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/test_mipsel_malta.py
new file mode 100755
index 0000000000..f31f96b012
--- /dev/null
+++ b/tests/functional/test_mipsel_malta.py
@@ -0,0 +1,47 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the little-endian 32-bit MIPS Malta board
+#
+# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import interrupt_interactive_console_until_pattern
+from qemu_test import wait_for_console_pattern
+from zipfile import ZipFile
+
+
+class MaltaMachineYAMON(QemuSystemTest):
+
+    ASSET_YAMON_ROM = Asset(
+        ('https://s3-eu-west-1.amazonaws.com/downloads-mips/mips-downloads/'
+         'YAMON/yamon-bin-02.22.zip'),
+        'eef86f0eed0ef554f041dcd47b87eebea0e6f9f1184ed31f7e9e8b4a803860ab')
+
+    def test_mipsel_malta_yamon(self):
+        yamon_bin = 'yamon-02.22.bin'
+        zip_path = self.ASSET_YAMON_ROM.fetch()
+        with ZipFile(zip_path, 'r') as zf:
+            zf.extract(yamon_bin, path=self.workdir)
+        yamon_path = os.path.join(self.workdir, yamon_bin)
+
+        self.set_machine('malta')
+        self.vm.set_console()
+        self.vm.add_args('-bios', yamon_path)
+        self.vm.launch()
+
+        prompt =  'YAMON>'
+        pattern = 'YAMON ROM Monitor'
+        interrupt_interactive_console_until_pattern(self, pattern, prompt)
+        wait_for_console_pattern(self, prompt)
+        self.vm.shutdown()
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


