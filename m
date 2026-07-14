Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C35C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 04:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjURm-0003No-Jg; Tue, 14 Jul 2026 00:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wjURd-0003Mg-DM
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 00:08:35 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wjURN-00085K-2O
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 00:08:18 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so2567261a91.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 21:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784002096; x=1784606896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gv77n6fbaqu9PEQiSL1yagq+rFdvmivv5MhuhcGHuIY=;
 b=pJFxPbHrZbxO5pPFD9CnyERA7CjITzHywFMVcROlBPFyeGbh6fVpcXDnC7XOm4y+YY
 bZZTY4zzNeLpZT7AYWSZoz/aOGh5ra/iZXaGjq+RjsZTG4S/Da3/Zif8bR8KHwmDR0Cq
 uUlhdHNoy0Uiu5QtTVX59rVq3aAFTIrAEPw5tYA8uPfe+9MmbAubiumEvYxDDCPx3VtX
 N+6VbELmdYTaeLHQkqS6ZJp2sEL/Wgu23/gUgo4dCqdzdYKyiQpuefCuJsUMEKXgWSQ4
 DQcQQfW2zJ4ujvz8V2gGLRP0n9Vkh5SpSQazgLJAZRPfh1kHiou1UN2kHCyHPWdm6bhw
 z6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784002096; x=1784606896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gv77n6fbaqu9PEQiSL1yagq+rFdvmivv5MhuhcGHuIY=;
 b=WCX5XYS8k6jwO8m70jH9fUr9z8Xe4EPNgucDRMyFZ3KWQVeiAaQ3yqVoCzX/HS6M9P
 91q86RKyD9HQVGfwKs9GICTloGjBuV4R8896+L9yvqJ2BjE6YgNv8MS6frO9zcHGRdmd
 y1segnX5Z+4YD//TQzTXAEiDgf0UOH0j5Ew92qVvCZ/hKl8f4GqC2tftft2YX0f3Emv3
 SIWB0eIc7vH2VnZj8w88EKGk0W9+ZOGEYnXhMtcpn4xvg+l1IvftIEEzbruODwpkEQgG
 b+tqwWcTtA1o68Q3XAf9gzkz4+nfoKjF2qU7eIZlILDm9bBkPOPMACb32zbhxsALzJkt
 icDw==
X-Gm-Message-State: AOJu0YwSPbOgx/lCopXVY2ls/Z0p2AGbaxDcrM26WnejTNiT0tKdUuYd
 In7r4bEe7JwDhbdLbK9xLf35pGdyluLUSx3i94UnBdmghKn9ukWmwq0la0xPPw==
X-Gm-Gg: AfdE7cn7r4KBPXWXoHWvnDOGH3DUjXUNlQYPOB7hu7Vl5qdMXcO96Ys2J00nXGOcPAf
 qcwBn8KkJxl2IqK/+/wKQG2bh6zSk4y18+YOnYEVnqRUEUVGIi9JZlVyKO9dLqcHgWWLfUNgP3R
 qaRGGFk9NSfrBZFaYOPGJCIS0eUr1bArcwpIJ6g5tq26PU05LxkhbSdAb+p3Axf8eGdDPNfCV9N
 8fooQgUp56mnhFYKlvw6rd6hY+WY7lQAMOD9BoXsiJHHSJbB1L7ZG3rvr0TMozZ1PBpZB7kzQXt
 VQvNcvbtlIS9jWInVM89cWjWymAlIoQN3R4Xlkg4pEub3BlvZ+KFpp9Wr7mVK1ImAHtnHzFxE6p
 a94jmhcVTioKcTs1QpfOu6/sf8gBr6rl4G5ZFu6xAjR+0biJWsZqj6TZoFSY5BbtJQm06DilVWV
 93lLYDw8rnqf64ij8BUEdbjyx5iuIMUlQ=
X-Received: by 2002:a17:90b:2685:b0:38e:6ab:32e0 with SMTP id
 98e67ed59e1d1-38e1b015cbdmr891334a91.39.1784002095637; 
 Mon, 13 Jul 2026 21:08:15 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e172b6cfbsm778840a91.3.2026.07.13.21.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 21:08:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Junze Cao <caojunze424@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 3/4] tests/functional/riscv64: Add K230 Linux boot tests
Date: Tue, 14 Jul 2026 14:07:57 +1000
Message-ID: <20260714040758.28332-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714040758.28332-1-alistair.francis@wdc.com>
References: <20260714040758.28332-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Junze Cao <caojunze424@gmail.com>

The K230 machine supports direct Linux boot and firmware boot through
the SDK U-Boot, but neither path has functional test coverage.

Add one test for each boot path. Both tests use the Yocto initramfs
assets and wait for the shell prompt to confirm a successful boot.

Fetch the boot assets from the k230-boot-assets repository maintained
by Chao Liu. Pin the URLs to a repository commit and verify each asset
with its SHA-256 digest.

Signed-off-by: Junze Cao <caojunze424@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260711125320.72319-1-caojunze424@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                           |   1 +
 tests/functional/riscv64/meson.build  |   2 +
 tests/functional/riscv64/test_k230.py | 108 ++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100755 tests/functional/riscv64/test_k230.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 611845c626..6bab70a7fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1830,6 +1830,7 @@ F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
+F: tests/functional/riscv64/test_k230.py
 F: tests/qtest/k230-wdt-test.c
 
 RX Machines
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index c9d4c090fb..d1a3e6c2bf 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -2,6 +2,7 @@
 
 test_riscv64_timeouts = {
   'boston' : 120,
+  'k230' : 120,
   'tuxrun' : 120,
 }
 
@@ -13,6 +14,7 @@ tests_riscv64_system_quick = [
 tests_riscv64_system_thorough = [
   'endianness',
   'boston',
+  'k230',
   'sifive_u',
   'tt_atlantis',
   'tuxrun',
diff --git a/tests/functional/riscv64/test_k230.py b/tests/functional/riscv64/test_k230.py
new file mode 100755
index 0000000000..6ccbf2d581
--- /dev/null
+++ b/tests/functional/riscv64/test_k230.py
@@ -0,0 +1,108 @@
+#!/usr/bin/env python3
+#
+# Functional tests that boot Linux on a Kendryte K230 machine.
+#
+# The direct boot test lets QEMU load OpenSBI, Linux, the device tree, and the
+# initramfs.  The firmware boot test starts the K230 SDK U-Boot and uses bootm
+# to launch OpenSBI and Linux from images preloaded into RAM.
+#
+# Author:
+#  Junze Cao
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import Asset, LinuxKernelTest
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import interrupt_interactive_console_until_pattern
+
+
+class K230Machine(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
+         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
+         'yocto/direct-boot/Image'),
+        '3a44970213fa68ad318d308518adfc0bf4bee72ed1b2926f9b468f82ef7d7829')
+    ASSET_DTB = Asset(
+        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
+         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
+         'yocto/direct-boot/k230-canmv.dtb'),
+        '5050240b48ce0988c73eaefa73e4945a40abca503cf488d22a3adf6ef50bbe4c')
+    ASSET_INITRD = Asset(
+        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
+         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
+         'yocto/direct-boot/rootfs.cpio.gz'),
+        '4e1869a99a232ee60324f71f3a9e84a79b03ccabb5b73f8a727c5ff5be5c0914')
+    ASSET_UBOOT = Asset(
+        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
+         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/common/u-boot'),
+        '0915b9a92a7c911846a8cf691866ef14ef050a51d04209f884ae8e9ec33f36d2')
+    ASSET_FW_JUMP = Asset(
+        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
+         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
+         'common/fw_jump.uImage'),
+        'cf7788e470f1d6e8c85491ecdc2705518db1b6af54080e8c7a3464bad0d902b7')
+
+    def wait_for_linux_shell(self):
+        self.wait_for_console_pattern('meta-k230 initramfs starting...')
+        self.wait_for_console_pattern('~ #')
+
+    def test_k230_direct_boot(self):
+        self.set_machine('k230')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        dtb_path = self.ASSET_DTB.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', 'console=ttyS0,115200 earlycon=sbi',
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_linux_shell()
+
+    def test_k230_uboot_boot(self):
+        self.set_machine('k230')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        dtb_path = self.ASSET_DTB.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
+        uboot_path = self.ASSET_UBOOT.fetch()
+        fw_jump_path = self.ASSET_FW_JUMP.fetch()
+        initrd_end = 0x0a100000 + os.path.getsize(initrd_path)
+
+        self.vm.set_console()
+        self.vm.add_args(
+            '-bios', uboot_path,
+            '-device',
+            f'loader,file={fw_jump_path},addr=0xc100000,force-raw=on',
+            '-device',
+            f'loader,file={kernel_path},addr=0x8200000,force-raw=on',
+            '-device',
+            f'loader,file={initrd_path},addr=0xa100000,force-raw=on',
+            '-device',
+            f'loader,file={dtb_path},addr=0xa000000,force-raw=on',
+            '-no-reboot')
+        self.vm.launch()
+
+        interrupt_interactive_console_until_pattern(self, 'K230#')
+        commands = (
+            'setenv bootargs console=ttyS0,115200 earlycon=sbi',
+            'fdt addr 0xa000000',
+            'fdt resize 8192',
+            'fdt set /chosen linux,initrd-start <0x0 0xa100000>',
+            f'fdt set /chosen linux,initrd-end <0x0 0x{initrd_end:x}>',
+        )
+        for command in commands:
+            exec_command_and_wait_for_pattern(self, command, 'K230#')
+
+        exec_command_and_wait_for_pattern(
+            self, 'bootm 0xc100000 - 0xa000000',
+            'Starting kernel ...', failure_message='ERROR')
+        self.wait_for_linux_shell()
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.54.0


