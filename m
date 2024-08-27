Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ABDC5472C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 09:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sispX-0001jc-4F; Tue, 27 Aug 2024 05:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sispW-0001hL-Fy
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:38 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sispU-0008AF-E5
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:38 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5becfd14353so5804797a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724752175; x=1725356975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRGHvqpcK+QeXaBj9ekCJV8Z1lhQaz2hnnSe4o3mJWI=;
 b=WSXkiN19o+hws1KAQOKcdg7QNq7WYbvzR7F8N3MvUQ3kjsrjU8bZjU7uwcSW6q7M4k
 lTtNbtAFeBMgPuUunfq/RJOxvol0xzrWdi9GaO2nMXcmPiw63foKHQaNqNqhw1FGYWL0
 K9UDUWvnBqX7LIqPEM3mS6OJMTLHdcgBkmWaK15Ljzd+W+Ytf7RrcQl8HDmATP42PH2b
 sB1lyNyx/UX534XH4dqEh8SNN9JpmicBVuZLf5nRDkGKUch9Bk59Ho0DdnbIhwv1AAbF
 mFLtsjdIzt4k0ct//of5U5jN5YduDzQpfyZHxXJ/73gGOLK49joztIHdt8eWQdCYR++C
 5OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724752175; x=1725356975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRGHvqpcK+QeXaBj9ekCJV8Z1lhQaz2hnnSe4o3mJWI=;
 b=n8dU3vLtcTnIrVY1HIZV/y60k55iQYtU/9YrDQJbeRjYioXT1TX+j1UM5rqUo5mU6d
 CJMpyv6ZdUx0PftxDngu169rTuNBVKh9QQ7rVn3PHCAQTDvjuGYdOXj61EgrujDXndyn
 eM2ej4VMvmdkOJpxJ3JDqN8ihTYRCdpm8si4EAh4KntE8vY3qLj29oOuNULPDSUxIviS
 KCP72sW0Wmjt0ZVuw6kMeLsE9mHwg6j1WL1JwLccbfUtqtqx6YgdUvuBx38VK6sEPxBU
 o/hQmMYc7zedcgjTsJtPNe43MAFwKGaFTCr1NnLDnHnrPDE29gPsoVjuHhQDRu5ZdRb+
 kKwQ==
X-Gm-Message-State: AOJu0Yx4XALW0VYP8BCizgNLu/2OrHshqqGo/bqAISJd4svsP6XI3/Qz
 YuA/yMMDPF615gHV16qxR2686/lV7RvMV9zQ182WslVCEeEbbL580F+pt9YTYhKrCTzZRf3J3dC
 o
X-Google-Smtp-Source: AGHT+IGL1xoDCBi7MCK86DaiOaQzYEjsaYfqP0R5275QUcwXYN0nL0IEusIyHIDMqiGsZlWLRf+U0Q==
X-Received: by 2002:a17:907:e2a0:b0:a86:82e2:8c64 with SMTP id
 a640c23a62f3a-a86a52de303mr887757666b.35.1724752174516; 
 Tue, 27 Aug 2024 02:49:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e588b034sm87480366b.185.2024.08.27.02.49.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Aug 2024 02:49:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 4/7] tests/functional: Convert mips64el 5KEc Malta avocado
 tests
Date: Tue, 27 Aug 2024 11:49:02 +0200
Message-ID: <20240827094905.80648-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240827094905.80648-1-philmd@linaro.org>
References: <20240827094905.80648-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, PDS_BTC_ID=0.5,
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
 tests/avocado/boot_linux_console.py     | 74 ------------------------
 tests/functional/test_mips64el_malta.py | 77 +++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 74 deletions(-)

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
index 9c1da8f401..9f33146c89 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -16,6 +16,7 @@
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test.linux_kernel import linux_kernel_wait_for_pattern
 from qemu_test.linux_kernel import KERNEL_COMMON_COMMAND_LINE
+from qemu_test.utils import extract_from_deb
 from qemu_test.utils import gzip_uncompress
 from unittest import skipUnless
 
@@ -32,6 +33,82 @@
     CV2_AVAILABLE = False
 
 
+class MaltaMachineConsole(QemuSystemTest):
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
+        kernel_command_line = KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        linux_kernel_wait_for_pattern(self, console_pattern)
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
+        kernel_command_line = (KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 console=tty '
+                               + 'rdinit=/sbin/init noreboot')
+        self.vm.add_args('-cpu', '5KEc',
+                         '-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        linux_kernel_wait_for_pattern(self, 'Boot successful.')
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


