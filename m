Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A43BFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEQa-0004q7-O8; Wed, 29 Apr 2026 19:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ericsonjoseph@gmail.com>)
 id 1wICoi-00010s-Df
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:51:36 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ericsonjoseph@gmail.com>)
 id 1wICog-0004Hv-7D
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:51:36 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2d8fa0fadfeso217141eec.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777499490; x=1778104290; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5PebPglHoe6H/36VNwDhbR2OIGR9F5WehVi5N/W11q8=;
 b=Op6wWrug93x551st9CxQyFGJgaQCkivBI850kDNPEArCZb62DtVZNhfgM0nANGZh0W
 TbfS1oXlFLuF1dJhGWVxO45YR9suafwZzJcP6sYv43x1vzm/3S/G9JghCV2tdHwF5yMa
 fFW+/Pw4AMAlpMwlj5LkNMEasfshe7qbAByiLbAZnzsfPb3tiBxJmCEI9JtIwkYn99ic
 g1j7ZLGmWBpP5BBjIDuRfQRXVoJzy2NuMgsEPOTa+nQO93fw+4zQhib+oeMhcBVXFwCa
 0m6m/gR038ON3NVXKodMPgWd4TxqC5LwCpC76F7AunCROU6EG7SCXEZj65PWZVIW7qFe
 glPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777499490; x=1778104290;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5PebPglHoe6H/36VNwDhbR2OIGR9F5WehVi5N/W11q8=;
 b=YcKOijVP3KkcRnjFy+DGJPAIW9+Wzq53aBg4u7NZFOx1e8V/vXeOpSd9HMy+snOop0
 gRrqa465pWBYiotkOkGWo4WWQz7FgX/Sw6WjgqnqbXHyil2Kpu7MJ9ZPFXxT0tAmqCKK
 3LgH9uHrb0kf5GO1amSoC2+NSGaJkjLmdg701+L3eCpLI8Hj3b+k4sNyPb9pCWrsHpcj
 IrLqyvl+TQwO40teSlyQCJb6cRYLbgVqD4qcdbVZgaj/+kpu1o0yu+U4fz4XlS5V3nHI
 S8D2mCQ8xQBa3FulkzZvX5Q3OVKeZ0/K69d6MRfOG5wH699JAEV1tAvoj/bBe6Q0Vn6d
 AHow==
X-Gm-Message-State: AOJu0YwQMzuxn+Ru+XgyWysEqN+etTsaLHthk3wnyRnpv1cNbPvrZ9OH
 aaNY/WluuexcQo3bI4MWcAKj0VmW9kev067TVjWuE5XoKo9NBND+EoNA
X-Gm-Gg: AeBDievhB2F6kAEUayz/5FNqezrmQJER6DT5Z9j98DHS6+oUvlT4KSh1/IPt508Sa6m
 Usjd2ZZjHReEnpRyRo3kMpA7+H2vtRiz6lZaVyCs0N+nL7nW9l44/sclM7hag/GcNFv1pTd7/Ex
 MOvc4mCCwgZsxYYkhzXfQI8Mpkr8QQGWG3S5Cmlws8rp4zaLrnddrD870UkTaLvgwSDf2DzJU6t
 Au6rvg2qqMB11gI//uLR91XP0f3PjIyxZ3TUjkpftMIn+flZYvrnvEeLRyaM+kGUtep8BNBVum7
 uV2yZ94NzMEpTSJ4/KsoWdVGSS7FQyegz71d85EdOW2TCs57fK/F6SK54FnlNm93OUykESlmgLP
 C8cJ3MtNP4rCj+OxcbluNP5u3w2VVXIel4hQRSpz//80a2vRRZeuolKIBapNwnTwx/CHw0BLGs1
 K4Uz17MdxlGYruYw/81vlRhglRTdOVw5e19vwrd/E4j8oGwwAshiQ=
X-Received: by 2002:a05:7300:a583:b0:2c6:67b6:3acc with SMTP id
 5a478bee46e88-2ed1bb3f483mr1902728eec.15.1777499490144; 
 Wed, 29 Apr 2026 14:51:30 -0700 (PDT)
Received: from [127.0.1.1] ([2803:9800:9001:c4f0:5d16:7dac:ff8:d8ff])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf6d315sm4353878eec.1.2026.04.29.14.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 14:51:29 -0700 (PDT)
From: Ericson Joseph <ericsonjoseph@gmail.com>
Date: Wed, 29 Apr 2026 18:51:18 -0300
Subject: [PATCH RFC 2/3] tests: add PIC32MK functional and qtest coverage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-pic32mk-board-support-v1-2-1dfac14f8e2d@voltumotor.com>
References: <20260429-pic32mk-board-support-v1-0-1dfac14f8e2d@voltumotor.com>
In-Reply-To: <20260429-pic32mk-board-support-v1-0-1dfac14f8e2d@voltumotor.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Ericson Joseph <ericsonjoseph@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=ericsonjoseph@gmail.com; helo=mail-dy1-x1333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 19:34:47 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Wire the PIC32MK tests into the build system:

- tests/functional/mipsel: register pic32mk as a quick test (30s),
  build pic32mk_test_fw.bin from assembly source using the mipsel-linux-gnu
  cross toolchain when available, and run test_pic32mk.py which boots the
  board and waits for "Hello, PIC32MK!" on UART1.

- tests/qtest/meson.build: add pic32mk-test and pic32mk-canfd-test to
  qtests_mipsel (gated on CONFIG_PIC32MK).

Signed-off-by: Ericson Joseph <ericsonjoseph@gmail.com>
---
 tests/functional/mipsel/meson.build     | 28 ++++++++++
 tests/functional/mipsel/test_pic32mk.py | 99 +++++++++++----------------------
 tests/qtest/meson.build                 |  4 +-
 3 files changed, 63 insertions(+), 68 deletions(-)

diff --git a/tests/functional/mipsel/meson.build b/tests/functional/mipsel/meson.build
index 8bfdf0649b..62ae73c1db 100644
--- a/tests/functional/mipsel/meson.build
+++ b/tests/functional/mipsel/meson.build
@@ -2,9 +2,37 @@
 
 test_mipsel_timeouts = {
   'malta' : 420,
+  'pic32mk' : 30,
   'replay' : 480,
 }
 
+# Build the minimal PIC32MK test firmware from assembly source.
+# Requires the mipsel-linux-gnu cross toolchain; silently skipped if absent.
+_mipsel_cc = find_program('mipsel-linux-gnu-gcc', required: false)
+_mipsel_objcopy = find_program('mipsel-linux-gnu-objcopy', required: false)
+
+if _mipsel_cc.found() and _mipsel_objcopy.found() and \
+   config_all_devices.has_key('CONFIG_PIC32MK')
+  _fw_ld   = meson.current_source_dir() / 'pic32mk_test_fw.ld'
+  _fw_src  = meson.current_source_dir() / 'pic32mk_test_fw.S'
+  _fw_elf  = custom_target('pic32mk_test_fw_elf',
+    input  : [_fw_src, _fw_ld],
+    output : 'pic32mk_test_fw.elf',
+    command: [_mipsel_cc,
+              '-march=mips32r2', '-EL', '-nostdlib',
+              '-T', _fw_ld, _fw_src,
+              '-o', '@OUTPUT@'],
+  )
+  _fw_bin = custom_target('pic32mk_test_fw.bin',
+    input  : _fw_elf,
+    output : 'pic32mk_test_fw.bin',
+    command: [_mipsel_objcopy, '-O', 'binary', '@INPUT@', '@OUTPUT@'],
+  )
+  tests_mipsel_system_quick = ['pic32mk']
+else
+  tests_mipsel_system_quick = []
+endif
+
 tests_mipsel_system_thorough = [
   'malta',
   'replay',
diff --git a/tests/functional/mipsel/test_pic32mk.py b/tests/functional/mipsel/test_pic32mk.py
index 4af91c4f88..ebfc94f388 100644
--- a/tests/functional/mipsel/test_pic32mk.py
+++ b/tests/functional/mipsel/test_pic32mk.py
@@ -1,9 +1,12 @@
 #!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
-# Functional tests for the PIC32MK board emulation
+# Functional test for the Microchip PIC32MK GPK/MCM board emulation.
 #
-# Copyright (c) 2026 QEMU contributors
-# SPDX-License-Identifier: GPL-2.0-or-later
+# The test firmware (pic32mk_test_fw.S) is a minimal MIPS assembly program
+# that initialises UART1 and writes "Hello, PIC32MK!\r\n" then spins.
+# This verifies that the board boots, the CPU executes code, and UART1 TX
+# produces output on the emulated serial console.
 
 import os
 
@@ -11,81 +14,43 @@
 from qemu_test import wait_for_console_pattern
 
 
+def _fw_path():
+    """Return the path to the pre-built test firmware binary."""
+    build_dir = os.environ.get('BUILD_DIR', '')
+    if build_dir:
+        candidate = os.path.join(build_dir,
+                                 'tests', 'functional', 'mipsel',
+                                 'pic32mk_test_fw.bin')
+        if os.path.isfile(candidate):
+            return candidate
+    # Fallback: look next to this file (for out-of-tree runs)
+    here = os.path.dirname(os.path.abspath(__file__))
+    return os.path.join(here, 'pic32mk_test_fw.bin')
+
+
 class PIC32MKMachine(QemuSystemTest):
     """
-    Tests for the PIC32MK MCU board (-M pic32mk).
+    Boot test for the Microchip PIC32MK GPK/MCM board (-M pic32mk).
 
-    The FreeRTOS firmware is expected to be pre-built at
-    tests/freertos/hello_freertos.bin relative to the source tree.
+    Requires pic32mk_test_fw.bin built from pic32mk_test_fw.S by meson.
+    The binary must be present in the meson build tree under
+    tests/functional/mipsel/pic32mk_test_fw.bin.
     """
 
     timeout = 30
 
-    def get_firmware_path(self):
-        """Locate the pre-built FreeRTOS firmware binary."""
-        # data_file() resolves relative to tests/functional/
-        # We need to go up two levels to reach the source root
-        src_root = os.path.join(
-            os.path.dirname(__file__), '..', '..', '..')
-        fw_path = os.path.realpath(
-            os.path.join(src_root, 'tests', 'freertos', 'hello_freertos.bin'))
-        if not os.path.isfile(fw_path):
+    def test_uart_boot_message(self):
+        """Board boots and UART1 TX prints the expected banner."""
+        fw = _fw_path()
+        if not os.path.isfile(fw):
             self.skipTest(
-                f'FreeRTOS firmware not built: {fw_path}\n'
-                'Run: make -C tests/freertos')
-        return fw_path
-
-    def test_boot_message(self):
-        """PIC32MK boots and prints the FreeRTOS banner."""
-        self.set_machine('pic32mk')
-        self.vm.set_console()
-        self.vm.add_args('-bios', self.get_firmware_path(),
-                         '-nographic')
-        self.vm.launch()
-        wait_for_console_pattern(self,
-                                 'PIC32MK QEMU booting FreeRTOS...')
-
-    def test_freertos_hello_task(self):
-        """FreeRTOS scheduler starts and the Hello task fires."""
-        self.set_machine('pic32mk')
-        self.vm.set_console()
-        self.vm.add_args('-bios', self.get_firmware_path(),
-                         '-nographic')
-        self.vm.launch()
-        # First: boot banner
-        wait_for_console_pattern(self,
-                                 'PIC32MK QEMU booting FreeRTOS...')
-        # Second: at least one Hello message (proves Timer1 tick + UART TX IRQ)
-        wait_for_console_pattern(self,
-                                 'Hello from FreeRTOS!')
-
-    def test_freertos_recurring_ticks(self):
-        """Timer1 delivers recurring ticks — multiple Hello messages appear."""
-        self.set_machine('pic32mk')
-        self.vm.set_console()
-        self.vm.add_args('-bios', self.get_firmware_path(),
-                         '-nographic')
-        self.vm.launch()
-        wait_for_console_pattern(self,
-                                 'PIC32MK QEMU booting FreeRTOS...')
-        # Wait for a second Hello — proves the tick ISR fires repeatedly
-        # and context switches work (CS0 yield + Timer1 preemption).
-        wait_for_console_pattern(self,
-                                 'Hello from FreeRTOS!')
-        wait_for_console_pattern(self,
-                                 'Hello from FreeRTOS!')
-
-    def test_freertos_ping_task(self):
-        """Second FreeRTOS task (Ping) also runs — proves multitasking."""
+                'pic32mk_test_fw.bin not found — '
+                'build with: ninja -C <builddir> pic32mk_test_fw.bin')
         self.set_machine('pic32mk')
         self.vm.set_console()
-        self.vm.add_args('-bios', self.get_firmware_path(),
-                         '-nographic')
+        self.vm.add_args('-bios', fw, '-nographic')
         self.vm.launch()
-        wait_for_console_pattern(self,
-                                 'PIC32MK QEMU booting FreeRTOS...')
-        # Ping task fires every 5 seconds
-        wait_for_console_pattern(self, 'Ping')
+        wait_for_console_pattern(self, 'Hello, PIC32MK!')
 
 
 if __name__ == '__main__':
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b735f55fc4..769de2054f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -164,7 +164,9 @@ qtests_mips = \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
 
-qtests_mipsel = qtests_mips
+qtests_mipsel = qtests_mips + \
+  (config_all_devices.has_key('CONFIG_PIC32MK') ? ['pic32mk-test',
+                                                    'pic32mk-canfd-test'] : [])
 qtests_mips64 = qtests_mips
 qtests_mips64el = qtests_mips
 

-- 
2.48.1


