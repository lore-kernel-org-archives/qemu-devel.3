Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A10D59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kB4-0002Xh-AT; Wed, 06 Nov 2024 12:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8kB2-0002Wk-Em
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:50:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8kAz-0000aK-Pc
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730915440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gzsEA5SZ4N6AwUu4rrEMQcdkP/A16EOGxPXq3szFpKk=;
 b=f/JUn16wcOQNBzQF274Elko2Pi5nsVqJTOkti/2I49dbvXkq+58OOC8CtlODoumT0tcbVX
 Mg7M5bh00wEibtGt4UMrXFd+4ohLYhrLalhDm+qEmGVsH/JyBji8ZLlP5+oLbqE8I/q4HP
 3yJ+qzkvNuLzqY+cKzeEqVueMmTr/oc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-gtDeCROwO5qXp01ochfHqQ-1; Wed,
 06 Nov 2024 12:50:37 -0500
X-MC-Unique: gtDeCROwO5qXp01ochfHqQ-1
X-Mimecast-MFC-AGG-ID: gtDeCROwO5qXp01ochfHqQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9A861977024; Wed,  6 Nov 2024 17:50:33 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.5])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E54041956054; Wed,  6 Nov 2024 17:50:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH] tests/functional: Split the test_aarch64_sbsaref test
Date: Wed,  6 Nov 2024 18:50:28 +0100
Message-ID: <20241106175029.1000589-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The test_aarch64_sbsaref test is the test with the longest runtime
in our functional test suite. Split it into parts so that it can
be run on multiple CPUs in parallel.

For this we have to move the fetch_firmware() function out of the
class definition to be able to reuse it easily from the other tests
(deriving the Aarch64SbsarefAlpine and Aarch64SbsarefFreeBSD directly
from Aarch64SbsarefMachine does not work, unfortunately, since we'd
inherit the test_sbsaref_edk2_firmware() function that way, causing
it to be run multiple times - and keeping the fetch_firmware() in
a separate class without the test_sbsaref_edk2_firmware() function
also does not work since the "make precache-functional" won't work
in that case ==> turning fetch_firmware() into a static function is
the best option).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |   2 +-
 tests/functional/meson.build                  |   5 +-
 tests/functional/test_aarch64_sbsaref.py      | 159 ++++--------------
 .../functional/test_aarch64_sbsaref_alpine.py |  64 +++++++
 .../test_aarch64_sbsaref_freebsd.py           |  66 ++++++++
 5 files changed, 172 insertions(+), 124 deletions(-)
 create mode 100755 tests/functional/test_aarch64_sbsaref_alpine.py
 create mode 100755 tests/functional/test_aarch64_sbsaref_freebsd.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 0844f5da19..bd9afc24ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -923,7 +923,7 @@ F: hw/misc/sbsa_ec.c
 F: hw/watchdog/sbsa_gwdt.c
 F: include/hw/watchdog/sbsa_gwdt.h
 F: docs/system/arm/sbsa.rst
-F: tests/functional/test_aarch64_sbsaref.py
+F: tests/functional/test_aarch64_sbsaref*.py
 
 Sharp SL-5500 (Collie) PDA
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 3561f987a6..68c911f98d 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -12,7 +12,8 @@ endif
 # Timeouts for individual tests that can be slow e.g. with debugging enabled
 test_timeouts = {
   'aarch64_raspi4' : 480,
-  'aarch64_sbsaref' : 600,
+  'aarch64_sbsaref_alpine' : 720,
+  'aarch64_sbsaref_freebsd' : 720,
   'aarch64_virt' : 720,
   'acpi_bits' : 420,
   'arm_aspeed' : 600,
@@ -49,6 +50,8 @@ tests_aarch64_system_thorough = [
   'aarch64_raspi3',
   'aarch64_raspi4',
   'aarch64_sbsaref',
+  'aarch64_sbsaref_alpine',
+  'aarch64_sbsaref_freebsd',
   'aarch64_virt',
   'multiprocess',
 ]
diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index b50e1a5965..9fda396b3a 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -16,6 +16,42 @@
 from qemu_test.utils import lzma_uncompress
 from unittest import skipUnless
 
+def fetch_firmware(test):
+    """
+    Flash volumes generated using:
+
+    Toolchain from Debian:
+    aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0
+
+    Used components:
+
+    - Trusted Firmware         v2.11.0
+    - Tianocore EDK2           4d4f569924
+    - Tianocore EDK2-platforms 3f08401
+
+    """
+
+    # Secure BootRom (TF-A code)
+    fs0_xz_path = Aarch64SbsarefMachine.ASSET_FLASH0.fetch()
+    fs0_path = os.path.join(test.workdir, "SBSA_FLASH0.fd")
+    lzma_uncompress(fs0_xz_path, fs0_path)
+
+    # Non-secure rom (UEFI and EFI variables)
+    fs1_xz_path = Aarch64SbsarefMachine.ASSET_FLASH1.fetch()
+    fs1_path = os.path.join(test.workdir, "SBSA_FLASH1.fd")
+    lzma_uncompress(fs1_xz_path, fs1_path)
+
+    for path in [fs0_path, fs1_path]:
+        with open(path, "ab+") as fd:
+            fd.truncate(256 << 20)  # Expand volumes to 256MiB
+
+    test.set_machine('sbsa-ref')
+    test.vm.set_console()
+    test.vm.add_args(
+        "-drive", f"if=pflash,file={fs0_path},format=raw",
+        "-drive", f"if=pflash,file={fs1_path},format=raw",
+    )
+
 
 class Aarch64SbsarefMachine(QemuSystemTest):
     """
@@ -35,45 +71,9 @@ class Aarch64SbsarefMachine(QemuSystemTest):
          '20240619-148232/edk2/SBSA_FLASH1.fd.xz'),
         'c6ec39374c4d79bb9e9cdeeb6db44732d90bb4a334cec92002b3f4b9cac4b5ee')
 
-    def fetch_firmware(self):
-        """
-        Flash volumes generated using:
-
-        Toolchain from Debian:
-        aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0
-
-        Used components:
-
-        - Trusted Firmware         v2.11.0
-        - Tianocore EDK2           4d4f569924
-        - Tianocore EDK2-platforms 3f08401
-
-        """
-
-        # Secure BootRom (TF-A code)
-        fs0_xz_path = self.ASSET_FLASH0.fetch()
-        fs0_path = os.path.join(self.workdir, "SBSA_FLASH0.fd")
-        lzma_uncompress(fs0_xz_path, fs0_path)
-
-        # Non-secure rom (UEFI and EFI variables)
-        fs1_xz_path = self.ASSET_FLASH1.fetch()
-        fs1_path = os.path.join(self.workdir, "SBSA_FLASH1.fd")
-        lzma_uncompress(fs1_xz_path, fs1_path)
-
-        for path in [fs0_path, fs1_path]:
-            with open(path, "ab+") as fd:
-                fd.truncate(256 << 20)  # Expand volumes to 256MiB
-
-        self.set_machine('sbsa-ref')
-        self.vm.set_console()
-        self.vm.add_args(
-            "-drive", f"if=pflash,file={fs0_path},format=raw",
-            "-drive", f"if=pflash,file={fs1_path},format=raw",
-        )
-
     def test_sbsaref_edk2_firmware(self):
 
-        self.fetch_firmware()
+        fetch_firmware(self)
 
         self.vm.add_args('-cpu', 'cortex-a57')
         self.vm.launch()
@@ -101,90 +101,5 @@ def test_sbsaref_edk2_firmware(self):
         wait_for_console_pattern(self, "UEFI firmware (version 1.0")
         interrupt_interactive_console_until_pattern(self, "QEMU SBSA-REF Machine")
 
-
-    ASSET_ALPINE_ISO = Asset(
-        ('https://dl-cdn.alpinelinux.org/'
-         'alpine/v3.17/releases/aarch64/alpine-standard-3.17.2-aarch64.iso'),
-        '5a36304ecf039292082d92b48152a9ec21009d3a62f459de623e19c4bd9dc027')
-
-    # This tests the whole boot chain from EFI to Userspace
-    # We only boot a whole OS for the current top level CPU and GIC
-    # Other test profiles should use more minimal boots
-    def boot_alpine_linux(self, cpu=None):
-        self.fetch_firmware()
-
-        iso_path = self.ASSET_ALPINE_ISO.fetch()
-
-        self.vm.set_console()
-        self.vm.add_args(
-            "-drive", f"file={iso_path},media=cdrom,format=raw",
-        )
-        if cpu:
-            self.vm.add_args("-cpu", cpu)
-
-        self.vm.launch()
-        wait_for_console_pattern(self, "Welcome to Alpine Linux 3.17")
-
-    def test_sbsaref_alpine_linux_cortex_a57(self):
-        self.boot_alpine_linux("cortex-a57")
-
-    def test_sbsaref_alpine_linux_default_cpu(self):
-        self.boot_alpine_linux()
-
-    def test_sbsaref_alpine_linux_max_pauth_off(self):
-        self.boot_alpine_linux("max,pauth=off")
-
-    def test_sbsaref_alpine_linux_max_pauth_impdef(self):
-        self.boot_alpine_linux("max,pauth-impdef=on")
-
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
-                'Test might timeout due to PAuth emulation')
-    def test_sbsaref_alpine_linux_max(self):
-        self.boot_alpine_linux("max")
-
-
-    ASSET_FREEBSD_ISO = Asset(
-        ('https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/'
-         '14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso'),
-        '44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad461')
-
-    # This tests the whole boot chain from EFI to Userspace
-    # We only boot a whole OS for the current top level CPU and GIC
-    # Other test profiles should use more minimal boots
-    def boot_freebsd14(self, cpu=None):
-        self.fetch_firmware()
-
-        img_path = self.ASSET_FREEBSD_ISO.fetch()
-
-        self.vm.set_console()
-        self.vm.add_args(
-            "-drive", f"file={img_path},format=raw,snapshot=on",
-        )
-        if cpu:
-            self.vm.add_args("-cpu", cpu)
-
-        self.vm.launch()
-        wait_for_console_pattern(self, 'Welcome to FreeBSD!')
-
-    def test_sbsaref_freebsd14_cortex_a57(self):
-        self.boot_freebsd14("cortex-a57")
-
-    def test_sbsaref_freebsd14_default_cpu(self):
-        self.boot_freebsd14()
-
-    def test_sbsaref_freebsd14_max_pauth_off(self):
-        self.boot_freebsd14("max,pauth=off")
-
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
-                'Test might timeout due to PAuth emulation')
-    def test_sbsaref_freebsd14_max_pauth_impdef(self):
-        self.boot_freebsd14("max,pauth-impdef=on")
-
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
-                'Test might timeout due to PAuth emulation')
-    def test_sbsaref_freebsd14_max(self):
-        self.boot_freebsd14("max")
-
-
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/test_aarch64_sbsaref_alpine.py b/tests/functional/test_aarch64_sbsaref_alpine.py
new file mode 100755
index 0000000000..ebc29b2fb5
--- /dev/null
+++ b/tests/functional/test_aarch64_sbsaref_alpine.py
@@ -0,0 +1,64 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a kernel and checks the console
+#
+# SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
+# SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
+# SPDX-FileContributor: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import interrupt_interactive_console_until_pattern
+from unittest import skipUnless
+from test_aarch64_sbsaref import fetch_firmware
+
+
+class Aarch64SbsarefAlpine(QemuSystemTest):
+
+    ASSET_ALPINE_ISO = Asset(
+        ('https://dl-cdn.alpinelinux.org/'
+         'alpine/v3.17/releases/aarch64/alpine-standard-3.17.2-aarch64.iso'),
+        '5a36304ecf039292082d92b48152a9ec21009d3a62f459de623e19c4bd9dc027')
+
+    # This tests the whole boot chain from EFI to Userspace
+    # We only boot a whole OS for the current top level CPU and GIC
+    # Other test profiles should use more minimal boots
+    def boot_alpine_linux(self, cpu=None):
+        fetch_firmware(self)
+
+        iso_path = self.ASSET_ALPINE_ISO.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args(
+            "-drive", f"file={iso_path},media=cdrom,format=raw",
+        )
+        if cpu:
+            self.vm.add_args("-cpu", cpu)
+
+        self.vm.launch()
+        wait_for_console_pattern(self, "Welcome to Alpine Linux 3.17")
+
+    def test_sbsaref_alpine_linux_cortex_a57(self):
+        self.boot_alpine_linux("cortex-a57")
+
+    def test_sbsaref_alpine_linux_default_cpu(self):
+        self.boot_alpine_linux()
+
+    def test_sbsaref_alpine_linux_max_pauth_off(self):
+        self.boot_alpine_linux("max,pauth=off")
+
+    def test_sbsaref_alpine_linux_max_pauth_impdef(self):
+        self.boot_alpine_linux("max,pauth-impdef=on")
+
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
+                'Test might timeout due to PAuth emulation')
+    def test_sbsaref_alpine_linux_max(self):
+        self.boot_alpine_linux("max")
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/functional/test_aarch64_sbsaref_freebsd.py
new file mode 100755
index 0000000000..80298dd190
--- /dev/null
+++ b/tests/functional/test_aarch64_sbsaref_freebsd.py
@@ -0,0 +1,66 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a kernel and checks the console
+#
+# SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
+# SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
+# SPDX-FileContributor: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import interrupt_interactive_console_until_pattern
+from unittest import skipUnless
+from test_aarch64_sbsaref import fetch_firmware
+
+
+class Aarch64SbsarefFreeBSD(QemuSystemTest):
+
+    ASSET_FREEBSD_ISO = Asset(
+        ('https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/'
+         '14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso'),
+        '44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad461')
+
+    # This tests the whole boot chain from EFI to Userspace
+    # We only boot a whole OS for the current top level CPU and GIC
+    # Other test profiles should use more minimal boots
+    def boot_freebsd14(self, cpu=None):
+        fetch_firmware(self)
+
+        img_path = self.ASSET_FREEBSD_ISO.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args(
+            "-drive", f"file={img_path},format=raw,snapshot=on",
+        )
+        if cpu:
+            self.vm.add_args("-cpu", cpu)
+
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Welcome to FreeBSD!')
+
+    def test_sbsaref_freebsd14_cortex_a57(self):
+        self.boot_freebsd14("cortex-a57")
+
+    def test_sbsaref_freebsd14_default_cpu(self):
+        self.boot_freebsd14()
+
+    def test_sbsaref_freebsd14_max_pauth_off(self):
+        self.boot_freebsd14("max,pauth=off")
+
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
+                'Test might timeout due to PAuth emulation')
+    def test_sbsaref_freebsd14_max_pauth_impdef(self):
+        self.boot_freebsd14("max,pauth-impdef=on")
+
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
+                'Test might timeout due to PAuth emulation')
+    def test_sbsaref_freebsd14_max(self):
+        self.boot_freebsd14("max")
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.47.0


