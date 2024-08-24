Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FFCC5472C
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 16:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shtKa-0007LC-Tf; Sat, 24 Aug 2024 12:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shtKT-0006iN-0H
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 12:09:29 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shtKQ-00060N-PE
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 12:09:28 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-533488ffaddso3843625e87.1
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2024 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724515764; x=1725120564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EwdExIDrk2fY0FNdNVdhVZRBCsZH9j0U6ZdTdQpvVcA=;
 b=yRlv+/t4nEQFxjaZ0Q787WgA8p/crCCFpBSJXF47sm3Bu1yBpWEj7nLFDVJtIrmogK
 WshROe6xn5T6/9kWmg3sHb/tC18mW9EeaTC/z/5kKbILu2AaTP0pnJdRvyjkMpMXPJSQ
 8Sfx13G8LgwvTAMrrdpxfwbuHv2xOHRbNwoiS/JtaKhwHa96UHsB7ubPR3+ZdQQnE0IG
 BNvWPWhP7wxYGKC83UsvADxOsTnLxY6B97FTUh4sq79uOm5FB27NoEjYPSQJBDaUpmHW
 bcyZwP8vdFhMiy8yrB6LJVx6PWr2hS+kfIxrAvkkIJRXAFJ03InPzyYIpQoy8+YTR0Tw
 Tteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724515764; x=1725120564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EwdExIDrk2fY0FNdNVdhVZRBCsZH9j0U6ZdTdQpvVcA=;
 b=gRI/o1eCXxz1vojCvkZDBjOAOxXGhLf7keERkp5Cnd23iL519Y0MceBTQMWWIQnxXp
 Z0I4AyiuXohdn1E8Shsik12UchMJIWsZbw80g0lGKyEXQwYw6cvU0K6t0YhG+um2v47/
 V1L/yc+mm88BLe17DGaySjnuddjlaEvv9bnu9ElH4atU2W3/bjutHdKDv/LQ59k4R0Ds
 /YceCVCHjC4G43+131L80x6YtI5+pq/6k7q6dYQyt6ueQgO61f6T9Uw/pP+mdGuLVJZ7
 oV2uToQeTTi4+LYJ+lUgBN1VsgjNpSXXN23thixJRK1FyByzqEeKMdsp1Zl0MbsSgHgI
 LH7w==
X-Gm-Message-State: AOJu0YxWRToroRWyu72dZQxFZETb85FfSyJGXm7Cj68XQkDqeFf7qCh5
 J+8WgovTFLHeKqXL10eBzIbkACC/fLMeQ1rGbIYKdFEVAmJ1CVbA6PEI4SliX/Hz7vf6wWZcXyb
 2
X-Google-Smtp-Source: AGHT+IEFTtOF9FcT894ALunSE6PHLXUrkSZVoCBrds2v+bPkCcwooJyo7xr+h35tMFCr85NOmt2v7w==
X-Received: by 2002:a05:6512:31cc:b0:530:da96:a986 with SMTP id
 2adb3069b0e04-534387bc020mr4047101e87.47.1724515763863; 
 Sat, 24 Aug 2024 09:09:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.198.30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f2202c1sm418679266b.3.2024.08.24.09.09.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Aug 2024 09:09:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 7/7] tests/functional: Convert mips32eb 4Kc Malta avocado
 tests
Date: Sat, 24 Aug 2024 18:08:28 +0200
Message-ID: <20240824160829.27655-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240824160829.27655-1-philmd@linaro.org>
References: <20240824160829.27655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                         |  1 +
 tests/avocado/boot_linux_console.py | 63 ----------------------
 tests/functional/meson.build        |  4 ++
 tests/functional/test_mips_malta.py | 84 +++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 63 deletions(-)
 create mode 100755 tests/functional/test_mips_malta.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b480135f6..e2e62afcdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1368,6 +1368,7 @@ F: hw/mips/malta.c
 F: hw/pci-host/gt64120.c
 F: include/hw/southbridge/piix.h
 F: tests/avocado/linux_ssh_mips_malta.py
+F: tests/functional/test_mips_malta.py
 F: tests/functional/test_mipsel_malta.py
 F: tests/functional/test_mips64el_malta.py
 
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 0756e49ded..370beb795a 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -116,69 +116,6 @@ def test_x86_64_pc(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    def test_mips_malta(self):
-        """
-        :avocado: tags=arch:mips
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:big
-        """
-        deb_url = ('http://snapshot.debian.org/archive/debian/'
-                   '20130217T032700Z/pool/main/l/linux-2.6/'
-                   'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb')
-        deb_hash = 'a8cfc28ad8f45f54811fc6cf74fc43ffcfe0ba04'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-2.6.32-5-4kc-malta')
-
-        self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        self.vm.add_args('-kernel', kernel_path,
-                         '-append', kernel_command_line)
-        self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
-
-    def test_mips_malta_cpio(self):
-        """
-        :avocado: tags=arch:mips
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:big
-        """
-        deb_url = ('http://snapshot.debian.org/archive/debian/'
-                   '20160601T041800Z/pool/main/l/linux/'
-                   'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb')
-        deb_hash = 'a3c84f3e88b54e06107d65a410d1d1e8e0f340f8'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-4.5.0-2-4kc-malta')
-        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
-                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
-                      'mips/rootfs.cpio.gz')
-        initrd_hash = 'bf806e17009360a866bf537f6de66590de349a99'
-        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
-        initrd_path = self.workdir + "rootfs.cpio"
-        archive.gzip_uncompress(initrd_path_gz, initrd_path)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
-                               + 'console=ttyS0 console=tty '
-                               + 'rdinit=/sbin/init noreboot')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-initrd', initrd_path,
-                         '-append', kernel_command_line,
-                         '-no-reboot')
-        self.vm.launch()
-        self.wait_for_console_pattern('Boot successful.')
-
-        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
-                                                'BogoMIPS')
-        exec_command_and_wait_for_pattern(self, 'uname -a',
-                                                'Debian')
-        exec_command_and_wait_for_pattern(self, 'reboot',
-                                                'reboot: Restarting system')
-        # Wait for VM to shut down gracefully
-        self.vm.wait()
-
     def test_aarch64_xlnx_versal_virt(self):
         """
         :avocado: tags=arch:aarch64
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index f8e482a87c..175e88bb87 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -51,6 +51,10 @@ tests_microblazeel_thorough = [
   'microblazeel_s3adsp1800'
 ]
 
+tests_mips_thorough = [
+  'mips_malta',
+]
+
 tests_mipsel_thorough = [
   'mipsel_malta',
 ]
diff --git a/tests/functional/test_mips_malta.py b/tests/functional/test_mips_malta.py
new file mode 100755
index 0000000000..6dd99f572c
--- /dev/null
+++ b/tests/functional/test_mips_malta.py
@@ -0,0 +1,84 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the little-endian 32-bit MIPS Malta board
+#
+# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import extract_from_deb
+from qemu_test.utils import gzip_uncompress
+
+
+class MaltaMachineConsole(QemuSystemTest):
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+
+    ASSET_KERNEL_2_63_2 = Asset(
+        ('http://snapshot.debian.org/archive/debian/'
+         '20130217T032700Z/pool/main/l/linux-2.6/'
+         'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb'),
+        '16ca524148afb0626f483163e5edf352bc1ab0e4fc7b9f9d473252762f2c7a43')
+
+    def test_mips_malta(self):
+        deb_path = self.ASSET_KERNEL_2_63_2.fetch()
+        kernel_path = extract_from_deb(deb_path, self.workdir,
+                                       '/boot/vmlinux-2.6.32-5-4kc-malta')
+
+        self.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        wait_for_console_pattern(self, console_pattern)
+
+    ASSET_KERNEL_4_5_0 = Asset(
+        ('http://snapshot.debian.org/archive/debian/'
+         '20160601T041800Z/pool/main/l/linux/'
+         'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb'),
+        '526b17d5889840888b76fc2c36a0ebde182c9b1410a3a1e68203c3b160eb2027')
+
+    ASSET_INITRD = Asset(
+        ('https://github.com/groeck/linux-build-test/raw/'
+         '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
+         'mips/rootfs.cpio.gz'),
+        'dcfe3a7fe3200da3a00d176b95caaa086495eb158f2bff64afc67d7e1eb2cddc')
+
+    def test_mips_malta_cpio(self):
+        deb_path = self.ASSET_KERNEL_4_5_0.fetch()
+        kernel_path = extract_from_deb(deb_path, self.workdir,
+                                       '/boot/vmlinux-4.5.0-2-4kc-malta')
+        initrd_path_gz = self.ASSET_INITRD.fetch()
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 console=tty '
+                               + 'rdinit=/sbin/init noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'BogoMIPS')
+        exec_command_and_wait_for_pattern(self, 'uname -a',
+                                                'Debian')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


