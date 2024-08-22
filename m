Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA57C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 11:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh67M-0005F1-KB; Thu, 22 Aug 2024 07:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh67L-0005E0-1H
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:36:39 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh67I-0005GJ-Fy
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:36:38 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3718c176ed7so323564f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 04:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724326594; x=1724931394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iatPzQHaiMr9IjFrHRnhPN8B7e53OxI7FQCT3YniWXE=;
 b=G20Inc7PpxHZ+UxajWciQclHYGct/3LUHGGEBTeKfBMBjBhxNVLu0VFT6hoX6XH17I
 M5UZRc/pvnJmzBTnAcpIX/ZDqNIlQ2yC9qZFERq55h/eF9ot9/EkAPYsIr1KT/U0CgY8
 cjoa3rQ9/9084RcXWvqgOl0bQWWFc8lUVQMbjUpY51JoUfGci27AEeEVs7m+2yfi41td
 Fm5WGQN9UJc4ezqdHR3ee6QQE6DYynZDd0qZ1tvqJr8bJuo2tQNATKUJi1tFFqVoyhBz
 TZyXjTNRooG0toq+2ktc5nar1eXMtcEjLKLoZZExMZBJcONYkTbXlIV2IkXl+pdaWXGK
 BsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724326594; x=1724931394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iatPzQHaiMr9IjFrHRnhPN8B7e53OxI7FQCT3YniWXE=;
 b=keuzOnMnwHyT7nHSkJ31d6VQ9c+xVJcuhrSu2JUEv5BS49ifgwPaAofqWPcLtAuDFj
 5QeVgzic2gAFxrCOhduxTSQWBxsq8qYZ8Zt2uw3qUY99AQmTXKuMUjTuu+w5wdJho5ec
 DM9pGCZqnDVgQCo0CMbCvlTKN5sAzKNL7HoIGG0+NFYkakD24TbMsBVbZy17OAYM+UhY
 VQ1BxrDuGrL4HK9Q9P3XFZegFaZbqwY+NT9LDuUToWKOZE+q8W3HDc/g0PNZYLn56tDE
 3e4ClSf/+aiobU+UCDn+nTD/VpqH8svYxyTAqdNjjoVhtlaUD3BdkLRQVLKJIB0v5jFB
 uOtg==
X-Gm-Message-State: AOJu0Yy9iTGXKW04LBNmPbgcEDgw7UYaMWoWeiAbJhgLdfJ9AxB8v5lf
 3lEzImy6Tm9CpghX5UedBt5YQEoC/CinFZjkBUFX++5n8ZeJr1IV8yN1J8crdR8XolgsMSBN9nZ
 Y
X-Google-Smtp-Source: AGHT+IF2xkM6C4qjaZVjcve0P7gcGPHsRxkFE6UuHX90hFz9TGo98v6ylvMtgmBDL+9Hj/ZBTynZnQ==
X-Received: by 2002:a5d:4584:0:b0:367:8383:6305 with SMTP id
 ffacd0b85a97d-372fd727463mr3199163f8f.55.1724326593692; 
 Thu, 22 Aug 2024 04:36:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37308264e09sm1458237f8f.103.2024.08.22.04.36.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Aug 2024 04:36:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/functional: Convert Aarch64 SBSA-Ref avocado tests
Date: Thu, 22 Aug 2024 13:36:29 +0200
Message-ID: <20240822113629.86618-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Straight forward conversion. Since SBSA_FLASH files are not
tarballs, use lzma_uncompress() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20240821082748.65853-1-thuth@redhat.com>
---
 MAINTAINERS                                   |   2 +-
 tests/functional/meson.build                  |   5 +
 .../test_aarch64_sbsaref.py}                  | 135 ++++++------------
 3 files changed, 53 insertions(+), 89 deletions(-)
 rename tests/{avocado/machine_aarch64_sbsaref.py => functional/test_aarch64_sbsaref.py} (58%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 91e5b061bf..c720c02800 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -971,7 +971,7 @@ F: hw/misc/sbsa_ec.c
 F: hw/watchdog/sbsa_gwdt.c
 F: include/hw/watchdog/sbsa_gwdt.h
 F: docs/system/arm/sbsa.rst
-F: tests/avocado/machine_aarch64_sbsaref.py
+F: tests/functional/test_aarch64_sbsaref.py
 
 Sharp SL-5500 (Collie) PDA
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index f1fce045fc..2445239a5c 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -11,6 +11,7 @@ endif
 
 # Timeouts for individual tests that can be slow e.g. with debugging enabled
 test_timeouts = {
+  'aarch64_sbsaref' : 180,
   'acpi_bits' : 240,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
@@ -26,6 +27,10 @@ tests_generic = [
   'version',
 ]
 
+tests_aarch64_thorough = [
+  'aarch64_sbsaref',
+]
+
 tests_arm_thorough = [
   'arm_canona1100',
   'arm_integratorcp',
diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
old mode 100644
new mode 100755
similarity index 58%
rename from tests/avocado/machine_aarch64_sbsaref.py
rename to tests/functional/test_aarch64_sbsaref.py
index f8bf40c192..5f9a5f7e37
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots a Linux kernel and checks the console
 #
 # SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
@@ -8,12 +10,11 @@
 
 import os
 
-from avocado import skipUnless
-from avocado.utils import archive
-
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado_qemu import interrupt_interactive_console_until_pattern
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import interrupt_interactive_console_until_pattern
+from qemu_test.utils import lzma_uncompress
+from unittest import skipUnless
 
 
 class Aarch64SbsarefMachine(QemuSystemTest):
@@ -28,6 +29,16 @@ class Aarch64SbsarefMachine(QemuSystemTest):
 
     timeout = 180
 
+    ASSET_FLASH0 = Asset(
+        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/'
+         '20240619-148232/edk2/SBSA_FLASH0.fd.xz'),
+        '0c954842a590988f526984de22e21ae0ab9cb351a0c99a8a58e928f0c7359cf7')
+
+    ASSET_FLASH1 = Asset(
+        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/'
+         '20240619-148232/edk2/SBSA_FLASH1.fd.xz'),
+        'c6ec39374c4d79bb9e9cdeeb6db44732d90bb4a334cec92002b3f4b9cac4b5ee')
+
     def fetch_firmware(self):
         """
         Flash volumes generated using:
@@ -44,39 +55,24 @@ def fetch_firmware(self):
         """
 
         # Secure BootRom (TF-A code)
-        fs0_xz_url = (
-            "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
-            "20240619-148232/edk2/SBSA_FLASH0.fd.xz"
-        )
-        fs0_xz_hash = "0c954842a590988f526984de22e21ae0ab9cb351a0c99a8a58e928f0c7359cf7"
-        tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash,
-                                      algorithm='sha256')
-        archive.extract(tar_xz_path, self.workdir)
+        fs0_xz_path = self.ASSET_FLASH0.fetch()
         fs0_path = os.path.join(self.workdir, "SBSA_FLASH0.fd")
+        lzma_uncompress(fs0_xz_path, fs0_path)
 
         # Non-secure rom (UEFI and EFI variables)
-        fs1_xz_url = (
-            "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
-            "20240619-148232/edk2/SBSA_FLASH1.fd.xz"
-        )
-        fs1_xz_hash = "c6ec39374c4d79bb9e9cdeeb6db44732d90bb4a334cec92002b3f4b9cac4b5ee"
-        tar_xz_path = self.fetch_asset(fs1_xz_url, asset_hash=fs1_xz_hash,
-                                      algorithm='sha256')
-        archive.extract(tar_xz_path, self.workdir)
+        fs1_xz_path = self.ASSET_FLASH0.fetch()
         fs1_path = os.path.join(self.workdir, "SBSA_FLASH1.fd")
+        lzma_uncompress(fs1_xz_path, fs1_path)
 
         for path in [fs0_path, fs1_path]:
             with open(path, "ab+") as fd:
                 fd.truncate(256 << 20)  # Expand volumes to 256MiB
 
+        self.set_machine('sbsa-ref')
         self.vm.set_console()
         self.vm.add_args(
-            "-drive",
-            f"if=pflash,file={fs0_path},format=raw",
-            "-drive",
-            f"if=pflash,file={fs1_path},format=raw",
-            "-machine",
-            "sbsa-ref",
+            "-drive", f"if=pflash,file={fs0_path},format=raw",
+            "-drive", f"if=pflash,file={fs1_path},format=raw",
         )
 
     def test_sbsaref_edk2_firmware(self):
@@ -110,60 +106,42 @@ def test_sbsaref_edk2_firmware(self):
         wait_for_console_pattern(self, "UEFI firmware (version 1.0")
         interrupt_interactive_console_until_pattern(self, "QEMU SBSA-REF Machine")
 
+
+    ASSET_ALPINE_ISO = Asset(
+        ('https://dl-cdn.alpinelinux.org/'
+         'alpine/v3.17/releases/aarch64/alpine-standard-3.17.2-aarch64.iso'),
+        '5a36304ecf039292082d92b48152a9ec21009d3a62f459de623e19c4bd9dc027')
+
     # This tests the whole boot chain from EFI to Userspace
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
     def boot_alpine_linux(self, cpu):
         self.fetch_firmware()
 
-        iso_url = (
-            "https://dl-cdn.alpinelinux.org/"
-            "alpine/v3.17/releases/aarch64/alpine-standard-3.17.2-aarch64.iso"
-        )
-
-        iso_hash = "5a36304ecf039292082d92b48152a9ec21009d3a62f459de623e19c4bd9dc027"
-        iso_path = self.fetch_asset(iso_url, algorithm="sha256", asset_hash=iso_hash)
+        iso_path = self.ASSET_ALPINE_ISO.fetch()
 
         self.vm.set_console()
         self.vm.add_args(
-            "-cpu",
-            cpu,
-            "-drive",
-            f"file={iso_path},media=cdrom,format=raw",
+            "-cpu", cpu,
+            "-drive", f"file={iso_path},media=cdrom,format=raw",
         )
 
         self.vm.launch()
         wait_for_console_pattern(self, "Welcome to Alpine Linux 3.17")
 
     def test_sbsaref_alpine_linux_cortex_a57(self):
-        """
-        :avocado: tags=cpu:cortex-a57
-        :avocado: tags=os:linux
-        """
         self.boot_alpine_linux("cortex-a57")
 
     def test_sbsaref_alpine_linux_neoverse_n1(self):
-        """
-        :avocado: tags=cpu:neoverse-n1
-        :avocado: tags=os:linux
-        """
         self.boot_alpine_linux("neoverse-n1")
 
     def test_sbsaref_alpine_linux_max_pauth_off(self):
-        """
-        :avocado: tags=cpu:max
-        :avocado: tags=os:linux
-        """
         self.boot_alpine_linux("max,pauth=off")
 
     def test_sbsaref_alpine_linux_max_pauth_impdef(self):
-        """
-        :avocado: tags=cpu:max
-        :avocado: tags=os:linux
-        """
         self.boot_alpine_linux("max,pauth-impdef=on")
 
-    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_sbsaref_alpine_linux_max(self):
         """
         :avocado: tags=cpu:max
@@ -172,25 +150,22 @@ def test_sbsaref_alpine_linux_max(self):
         self.boot_alpine_linux("max")
 
 
+    ASSET_OPENBSD_ISO = Asset(
+        ('https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.img'),
+        '7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5')
+
     # This tests the whole boot chain from EFI to Userspace
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
     def boot_openbsd73(self, cpu):
         self.fetch_firmware()
 
-        img_url = (
-            "https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.img"
-        )
-
-        img_hash = "7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5"
-        img_path = self.fetch_asset(img_url, algorithm="sha256", asset_hash=img_hash)
+        img_path = self.ASSET_OPENBSD_ISO.fetch()
 
         self.vm.set_console()
         self.vm.add_args(
-            "-cpu",
-            cpu,
-            "-drive",
-            f"file={img_path},format=raw,snapshot=on",
+            "-cpu", cpu,
+            "-drive", f"file={img_path},format=raw,snapshot=on",
         )
 
         self.vm.launch()
@@ -199,38 +174,22 @@ def boot_openbsd73(self, cpu):
                                  " 7.3 installation program.")
 
     def test_sbsaref_openbsd73_cortex_a57(self):
-        """
-        :avocado: tags=cpu:cortex-a57
-        :avocado: tags=os:openbsd
-        """
         self.boot_openbsd73("cortex-a57")
 
     def test_sbsaref_openbsd73_neoverse_n1(self):
-        """
-        :avocado: tags=cpu:neoverse-n1
-        :avocado: tags=os:openbsd
-        """
         self.boot_openbsd73("neoverse-n1")
 
     def test_sbsaref_openbsd73_max_pauth_off(self):
-        """
-        :avocado: tags=cpu:max
-        :avocado: tags=os:openbsd
-        """
         self.boot_openbsd73("max,pauth=off")
 
-    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_sbsaref_openbsd73_max_pauth_impdef(self):
-        """
-        :avocado: tags=cpu:max
-        :avocado: tags=os:openbsd
-        """
         self.boot_openbsd73("max,pauth-impdef=on")
 
-    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_sbsaref_openbsd73_max(self):
-        """
-        :avocado: tags=cpu:max
-        :avocado: tags=os:openbsd
-        """
         self.boot_openbsd73("max")
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


