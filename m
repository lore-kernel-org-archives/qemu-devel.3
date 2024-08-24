Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A253C5472C
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 16:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shtK8-00065x-4L; Sat, 24 Aug 2024 12:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shtK6-00065P-VL
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 12:09:06 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shtK2-0005yF-W6
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 12:09:06 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5334e41c30bso3158609e87.0
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2024 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724515740; x=1725120540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otuAsvPwpBrvs8+cyeOFUBpFGDM6+eknJHN1E8JavRc=;
 b=iZIONHc4E0WiIr4KyfoLWmzuZtweH0RbjDxCmMM4C5rA5Ze5zE1XAp9Z5EzgBNqBjF
 QcDILWriEj5bWKv8vTVXYpfLio4zEpycBW9yuHnlh5i5a+cC+5+hYbERNWnU6h2x1+I2
 THE0mtWxQA+tWusO/NeFhdkUx+gi/4XPyN0LfEP2P0RH022SIO7LZKoQprrfmTQ7Uzok
 hCHB0LcsNy8xB4U6pOVIwsW4y7prHy9jDsSeCrZG9Lmiw01hNpEHNj7XVPNOSCd1DFDr
 IzE2n//E1fLptSFSvP2uAdeXpPT37VWwflQj1IklTRQkq1oCsHy5XngWgPopO+fRWoOp
 Q1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724515740; x=1725120540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otuAsvPwpBrvs8+cyeOFUBpFGDM6+eknJHN1E8JavRc=;
 b=d4EUwS55Q7hV7c8s8lH1mwt4SwxJmfjDJet8nePeBjNQGXOtiUAZsKJ/0c1LyvRa/r
 sWf+qK6YoDx0QKJQofPxD6Ym5EANuUcyKJDHNiQmI4GI2L3bQqEzpi6iFCicDUcDKHTF
 XrMXDLChceTcJvP3AO7e6Cjm9T1lSEBgVgR1+xCpKkM1ynqLDG9PK+wtLltLZon66bU3
 h13372HYFWZ7ouuULNNKUrwo8oIXFJI73uwfR8hDuJpV5aaQ/eJL5ih04x/hHRnSHVrd
 yY1NVfsmbGevOZBT9dgKWhfkDTGCIVJhNo4gBpNmdrombljT+a89LIBzQ1hFdgFJt16Y
 pS9g==
X-Gm-Message-State: AOJu0YzzgElWo0ildXg/zVm96wCnuTtNXWVOi8ZOKnDTCIwapRKSZQ9S
 7m/9KNa578pPZRWzay82vB1cFoRxh+UI7ZBcmJhZ6N8rYIyWpDZTsUXqZTDIuvSIsaPZRdp+YxJ
 L
X-Google-Smtp-Source: AGHT+IE35SKbR7tr6xlhEK2ct2PwV14QVi3H/2uhx1qcAZii7ZXP80uy9Qxqjik5IwFLzOzjgwo8Jw==
X-Received: by 2002:a05:6512:3c97:b0:530:e1f1:8dc9 with SMTP id
 2adb3069b0e04-534387be5e5mr3419101e87.46.1724515739759; 
 Sat, 24 Aug 2024 09:08:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.198.30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f222af5sm419591566b.41.2024.08.24.09.08.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Aug 2024 09:08:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/7] tests/functional: Convert mips64el 5KEc Malta avocado
 tests
Date: Sat, 24 Aug 2024 18:08:25 +0200
Message-ID: <20240824160829.27655-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240824160829.27655-1-philmd@linaro.org>
References: <20240824160829.27655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, PDS_BTC_ID=0.499,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
 tests/avocado/boot_linux_console.py     | 74 -----------------------
 tests/functional/test_mips64el_malta.py | 79 +++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 74 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 01fd126c53..10457743d1 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -138,38 +138,6 @@ def test_mips_malta(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    def test_mips64el_malta(self):
-        """
-        This test requires the ar tool to extract "data.tar.gz" from
-        the Debian package.
-
-        The kernel can be rebuilt using this Debian kernel source [1] and
-        following the instructions on [2].
-
-        [1] http://snapshot.debian.org/package/linux-2.6/2.6.32-48/
-            #linux-source-2.6.32_2.6.32-48
-        [2] https://kernel-team.pages.debian.net/kernel-handbook/
-            ch-common-tasks.html#s-common-official
-
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        """
-        deb_url = ('http://snapshot.debian.org/archive/debian/'
-                   '20130217T032700Z/pool/main/l/linux-2.6/'
-                   'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb')
-        deb_hash = '1aaec92083bf22fda31e0d27fa8d9a388e5fc3d5'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-2.6.32-5-5kc-malta')
-
-        self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        self.vm.add_args('-kernel', kernel_path,
-                         '-append', kernel_command_line)
-        self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
-
     def test_mips_malta_cpio(self):
         """
         :avocado: tags=arch:mips
@@ -211,48 +179,6 @@ def test_mips_malta_cpio(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
-    def test_mips64el_malta_5KEc_cpio(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        :avocado: tags=cpu:5KEc
-        """
-        kernel_url = ('https://github.com/philmd/qemu-testing-blob/'
-                      'raw/9ad2df38/mips/malta/mips64el/'
-                      'vmlinux-3.19.3.mtoman.20150408')
-        kernel_hash = '00d1d268fb9f7d8beda1de6bebcc46e884d71754'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        initrd_url = ('https://github.com/groeck/linux-build-test/'
-                      'raw/8584a59e/rootfs/'
-                      'mipsel64/rootfs.mipsel64r1.cpio.gz')
-        initrd_hash = '1dbb8a396e916847325284dbe2151167'
-        initrd_path_gz = self.fetch_asset(initrd_url, algorithm='md5',
-                                          asset_hash=initrd_hash)
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
-        wait_for_console_pattern(self, 'Boot successful.')
-
-        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
-                                                'MIPS 5KE')
-        exec_command_and_wait_for_pattern(self, 'uname -a',
-                                                '3.19.3.mtoman.20150408')
-        exec_command_and_wait_for_pattern(self, 'reboot',
-                                                'reboot: Restarting system')
-        # Wait for VM to shut down gracefully
-        self.vm.wait()
-
     def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
         kernel_path = self.workdir + "kernel"
         with lzma.open(kernel_path_xz, 'rb') as f_in:
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index 0c05ebcb2f..1829bed69a 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -13,7 +13,9 @@
 import logging
 
 from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import wait_for_console_pattern
+from qemu_test.utils import extract_from_deb
 from qemu_test.utils import gzip_uncompress
 from unittest import skipUnless
 
@@ -30,6 +32,83 @@
     CV2_AVAILABLE = False
 
 
+class MaltaMachineConsole(QemuSystemTest):
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+
+    ASSET_KERNEL_2_63_2 = Asset(
+        ('http://snapshot.debian.org/archive/debian/'
+         '20130217T032700Z/pool/main/l/linux-2.6/'
+         'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb'),
+        '35eb476f03be589824b0310358f1c447d85e645b88cbcd2ac02b97ef560f9f8d')
+
+    def test_mips64el_malta(self):
+        """
+        This test requires the ar tool to extract "data.tar.gz" from
+        the Debian package.
+
+        The kernel can be rebuilt using this Debian kernel source [1] and
+        following the instructions on [2].
+
+        [1] http://snapshot.debian.org/package/linux-2.6/2.6.32-48/
+            #linux-source-2.6.32_2.6.32-48
+        [2] https://kernel-team.pages.debian.net/kernel-handbook/
+            ch-common-tasks.html#s-common-official
+        """
+        deb_path = self.ASSET_KERNEL_2_63_2.fetch()
+        kernel_path = extract_from_deb(deb_path, self.workdir,
+                                       '/boot/vmlinux-2.6.32-5-5kc-malta')
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
+    ASSET_KERNEL_3_19_3 = Asset(
+        ('https://github.com/philmd/qemu-testing-blob/'
+         'raw/9ad2df38/mips/malta/mips64el/'
+         'vmlinux-3.19.3.mtoman.20150408'),
+        '8d3beb003bc66051ead98e7172139017fcf9ce2172576541c57e86418dfa5ab8')
+
+    ASSET_CPIO_R1 = Asset(
+        ('https://github.com/groeck/linux-build-test/'
+         'raw/8584a59e/rootfs/mipsel64/'
+         'rootfs.mipsel64r1.cpio.gz'),
+        '75ba10cd35fb44e32948eeb26974f061b703c81c4ba2fab1ebcacf1d1bec3b61')
+
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    def test_mips64el_malta_5KEc_cpio(self):
+        kernel_path = self.ASSET_KERNEL_3_19_3.fetch()
+        initrd_path_gz = self.ASSET_CPIO_R1.fetch()
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 console=tty '
+                               + 'rdinit=/sbin/init noreboot')
+        self.vm.add_args('-cpu', '5KEc',
+                         '-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'MIPS 5KE')
+        exec_command_and_wait_for_pattern(self, 'uname -a',
+                                                '3.19.3.mtoman.20150408')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
+
+
 @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
 @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
 class MaltaMachineFramebuffer(QemuSystemTest):
-- 
2.45.2


