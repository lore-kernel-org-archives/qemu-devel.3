Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2C2C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 09:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sisps-0002PE-Q1; Tue, 27 Aug 2024 05:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sispq-0002Oi-47
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:58 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sispo-0008Bn-1G
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:57 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5334c018913so5052937e87.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724752194; x=1725356994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mK1gcEL6ki/5i9onc4ehh9ftnC10AvXevSPtX+HlMCQ=;
 b=AmMgfw8fFUiNWfrf95mC+TQcQoKi4HQYtWHbQKlSTWmhnC7VGNnAT9Fay+W4RGbJxw
 WfBla2OJWrCaCGMgzAHwE0pjdKVsMNyGWNP3PDpNZy/WkWq8nFRQsCPeoVPI33SZYA75
 qll3cv67uj98FHYrag0yLsInehjKJDvSsaFiUbd3kNvm7id+pD2qb72/IIfaOX3BL525
 UfRzPe03va4+ZW1tQFIYdRnnmBv7thbOjucftvWTdZQEHQLqCwniBTkTXOofdkRgdu1L
 WDLlQXl59AueuObqUhPTaGRVJChE65n5V409dUnhNQm+ty/d5HJyOjdhvmVZtEukGYMA
 Ximw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724752194; x=1725356994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mK1gcEL6ki/5i9onc4ehh9ftnC10AvXevSPtX+HlMCQ=;
 b=VMu88k6P3TqGlzk157VmabzQEFMMpTTuhmOY7e7t44C0kcs9L4MOfSn0d9JlnpvGfW
 Y3ddDM7ClgI08ix5FyHpDEgV9lHlhJevFrE3J+kxxbTnU840vbSo4UZa00sTLdwBJPLh
 ShrKvWvV9KbPOLw41HxJlLdIuxWRLVOKd/ITngcaAPl7fu2Okbf4wwP+aaOwk3Z5BtAT
 Ad9BbOAGnHAhkgcq65NJQVhW1BMygsKJmi8MFYoaOnqQ6ZSuuJZQ73raKJ+cpIWEckGL
 key2PL2yip6u+GVAwGKp7DS8qhTlTv4IMUVAPhRpYgGK7OxzMhkyOYvyHkLvsVC3Zfnw
 +Mlg==
X-Gm-Message-State: AOJu0Yx/2gZz0S6DxTt6/H7BP+hbtC5ZsuJnFd2ExjEOnEJWwaY46jW2
 CNVLQX1BvWSYSZtXupJMsBhtKtUhNdc7QPxY475qyQ/od9EbcNN3p11zp3kYl1UuRr4VAeafpiJ
 R
X-Google-Smtp-Source: AGHT+IEx7V/nVsSi+MYnhw6yqVZVybTIVsJk8zn7G69wM4w1kyFi9aNwgEvv2Ww2W4rxZ0SdLsIZ3g==
X-Received: by 2002:a05:6512:ea2:b0:52e:9ebe:7325 with SMTP id
 2adb3069b0e04-5343883b0ffmr8068059e87.31.1724752193761; 
 Tue, 27 Aug 2024 02:49:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e548620asm89128166b.8.2024.08.27.02.49.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Aug 2024 02:49:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 7/7] tests/functional: Convert mips32eb 4Kc Malta avocado
 tests
Date: Tue, 27 Aug 2024 11:49:05 +0200
Message-ID: <20240827094905.80648-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240827094905.80648-1-philmd@linaro.org>
References: <20240827094905.80648-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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
index 0000000000..2f26dd5884
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
+from qemu_test.linux_kernel import linux_kernel_wait_for_pattern
+from qemu_test.linux_kernel import KERNEL_COMMON_COMMAND_LINE
+from qemu_test.utils import extract_from_deb
+from qemu_test.utils import gzip_uncompress
+
+
+class MaltaMachineConsole(QemuSystemTest):
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
+        kernel_command_line = KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        linux_kernel_wait_for_pattern(self, console_pattern)
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
+        kernel_command_line = (KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 console=tty '
+                               + 'rdinit=/sbin/init noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        linux_kernel_wait_for_pattern(self, 'Boot successful.')
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


