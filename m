Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6FDC5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 09:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sispl-0002Ep-Mb; Tue, 27 Aug 2024 05:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sispk-0002EK-MX
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:52 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sispi-0008Ay-Ju
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:52 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ef27bfd15bso53447481fa.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724752187; x=1725356987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V5I9NlqjJ3uPggyv85VAD/1WgHDypHVBIY5yjNhqIwY=;
 b=WxX0Ehaeb9RmkeloS+4SyztdxQUm2G80OOg/Wz0+z0y6sn8jkvSovETT6qlfyNna3n
 1DM3e9xdmiQTtcbDcATgsTv9Huox5OBfSaoYBU1H9jGhTdcmCfMqN2pP8mf2JXOounqg
 OkjLTcaxJunexR/lxkCizrvAcN39TkXZnrXvEYLrjRaBa77uyWfHOc0C7Grph7uoFFTA
 GJO3KTJ1ov+B4cprSSD8DGtFEndHdKrK9V+NsYD0OWEU9PU5iGQOZ5YFISIe9FK5bhTi
 701OD9+jC3Rcsfgg6e76oiNccJwFVk+hQ4o1HTI5wxJNiwOYiLFss0aOTOX6AkfLdNIz
 g7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724752187; x=1725356987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5I9NlqjJ3uPggyv85VAD/1WgHDypHVBIY5yjNhqIwY=;
 b=BprwqMCcug4E9pm8CphxB4bJza/xzMHOoeGhRbtmbPKTtboBvvnulCQdk6xZxE8TOX
 BsiElnTZQtJc+0QY8Zd3b+KTkvToNqIG+/myLUDCcsNSwImQiSBmI3E+GbeMl0ZZ4QSA
 9DOwAV/INFtcl++8UKDMnQXTM+3hZJD+a5GYr27qps0sbVAjbaYzJS+HqlLiP4JpLLKT
 l4TaWQAeZFGO9/fx5RyzXw9wS+vMGuz1MwrQ2CNeufEtoau/QkcRgc2jGKwgahJ8MGi7
 FPI/D9N48SMgqRqG5MmQ1h3khyYL/4q5JP3JVBH9qC7WRxh8NZTnaOCmgo7w/K3mmW1r
 2U4w==
X-Gm-Message-State: AOJu0Yxg80RpI+d5hnzX2fYJxGCxUbSUzbtD7v+mw4VywxX0sdi6kmth
 TWSiNX5MExD4RG54UcRz5TN+Z7u7tSuyVkzpWOmQf7n5DlWwPBC25MKRH1HSTqnXBXmcTO3WL0x
 C
X-Google-Smtp-Source: AGHT+IGnPIEahluQIEA/0zZjwfWOoLX0lTIuVlI9BHOeJYGmeFteq3aBNOEYc1Gg+iWG6lZh6PBxNw==
X-Received: by 2002:a2e:be88:0:b0:2ef:2c86:4d43 with SMTP id
 38308e7fff4ca-2f514a12d6dmr17256731fa.3.1724752187379; 
 Tue, 27 Aug 2024 02:49:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.45])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c0bb481f44sm835994a12.91.2024.08.27.02.49.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Aug 2024 02:49:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 6/7] tests/functional: Convert nanomips Malta avocado tests
Date: Tue, 27 Aug 2024 11:49:04 +0200
Message-ID: <20240827094905.80648-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240827094905.80648-1-philmd@linaro.org>
References: <20240827094905.80648-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

  $ QEMU_TEST_ALLOW_UNTRUSTED_CODE=1 \
        make check-functional-mipsel
  ...
  ▶ 4/4 test_mipsel_malta.MaltaMachineConsole.test_mips_malta32el_nanomips_16k_up   OK
  ▶ 4/4 test_mipsel_malta.MaltaMachineConsole.test_mips_malta32el_nanomips_4k       OK
  ▶ 4/4 test_mipsel_malta.MaltaMachineConsole.test_mips_malta32el_nanomips_64k_dbg  OK
  ▶ 4/4 test_mipsel_malta.MaltaMachineYAMON.test_mipsel_malta_yamon                 OK
  4/4 qemu:func-thorough+func-mipsel-thorough+thorough / func-mipsel-mipsel_malta   OK   9.95s   4 subtests passed

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/boot_linux_console.py   | 59 ---------------------------
 tests/functional/test_mipsel_malta.py | 51 +++++++++++++++++++++++
 2 files changed, 51 insertions(+), 59 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 10457743d1..0756e49ded 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -179,65 +179,6 @@ def test_mips_malta_cpio(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
-    def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
-        kernel_path = self.workdir + "kernel"
-        with lzma.open(kernel_path_xz, 'rb') as f_in:
-            with open(kernel_path, 'wb') as f_out:
-                shutil.copyfileobj(f_in, f_out)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
-                               + 'mem=256m@@0x0 '
-                               + 'console=ttyS0')
-        self.vm.add_args('-no-reboot',
-                         '-kernel', kernel_path,
-                         '-append', kernel_command_line)
-        self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
-
-    def test_mips_malta32el_nanomips_4k(self):
-        """
-        :avocado: tags=arch:mipsel
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        :avocado: tags=cpu:I7200
-        """
-        kernel_url = ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
-                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
-                      'generic_nano32r6el_page4k.xz')
-        kernel_hash = '477456aafd2a0f1ddc9482727f20fe9575565dd6'
-        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
-
-    def test_mips_malta32el_nanomips_16k_up(self):
-        """
-        :avocado: tags=arch:mipsel
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        :avocado: tags=cpu:I7200
-        """
-        kernel_url = ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
-                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
-                      'generic_nano32r6el_page16k_up.xz')
-        kernel_hash = 'e882868f944c71c816e832e2303b7874d044a7bc'
-        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
-
-    def test_mips_malta32el_nanomips_64k_dbg(self):
-        """
-        :avocado: tags=arch:mipsel
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        :avocado: tags=cpu:I7200
-        """
-        kernel_url = ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
-                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
-                      'generic_nano32r6el_page64k_dbg.xz')
-        kernel_hash = '18d1c68f2e23429e266ca39ba5349ccd0aeb7180'
-        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
-
     def test_aarch64_xlnx_versal_virt(self):
         """
         :avocado: tags=arch:aarch64
diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/test_mipsel_malta.py
index f31f96b012..6f6e38a4a5 100755
--- a/tests/functional/test_mipsel_malta.py
+++ b/tests/functional/test_mipsel_malta.py
@@ -14,9 +14,60 @@
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import interrupt_interactive_console_until_pattern
 from qemu_test import wait_for_console_pattern
+from qemu_test.linux_kernel import linux_kernel_wait_for_pattern
+from qemu_test.linux_kernel import KERNEL_COMMON_COMMAND_LINE
+from qemu_test.utils import lzma_uncompress
 from zipfile import ZipFile
 
 
+class MaltaMachineConsole(QemuSystemTest):
+
+    ASSET_KERNEL_4K = Asset(
+        ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
+         'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
+         'generic_nano32r6el_page4k.xz'),
+        '019e034094ac6cf3aa77df5e130fb023ce4dbc804b04bfcc560c6403e1ae6bdb')
+    ASSET_KERNEL_16K = Asset(
+        ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
+         'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
+         'generic_nano32r6el_page16k_up.xz'),
+        '3a54a10b3108c16a448dca9ea3db378733a27423befc2a45a5bdf990bd85e12c')
+    ASSET_KERNEL_64K = Asset(
+        ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
+         'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
+         'generic_nano32r6el_page64k_dbg.xz'),
+        'ce21ff4b07a981ecb8a39db2876616f5a2473eb2ab459c6f67465b9914b0c6b6')
+
+    def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
+        kernel_path = os.path.join(self.workdir, 'kernel')
+        lzma_uncompress(kernel_path_xz, kernel_path)
+
+        self.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line = (KERNEL_COMMON_COMMAND_LINE
+                               + 'mem=256m@@0x0 '
+                               + 'console=ttyS0')
+        self.vm.add_args('-cpu', 'I7200',
+                         '-no-reboot',
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        linux_kernel_wait_for_pattern(self, console_pattern)
+
+    def test_mips_malta32el_nanomips_4k(self):
+        kernel_path_xz = self.ASSET_KERNEL_4K.fetch()
+        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
+
+    def test_mips_malta32el_nanomips_16k_up(self):
+        kernel_path_xz = self.ASSET_KERNEL_16K.fetch()
+        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
+
+    def test_mips_malta32el_nanomips_64k_dbg(self):
+        kernel_path_xz = self.ASSET_KERNEL_16K.fetch()
+        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
+
+
 class MaltaMachineYAMON(QemuSystemTest):
 
     ASSET_YAMON_ROM = Asset(
-- 
2.45.2


