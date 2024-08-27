Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D431C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 09:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sispM-0001Gj-Gm; Tue, 27 Aug 2024 05:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sispK-0001FJ-Mn
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:26 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sispI-00087v-3u
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:25 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a86910caf9cso854597166b.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724752162; x=1725356962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFVbp5mH2R87j2GJDUCRNTEHqK0ZCmXXo1MP+SE9nGs=;
 b=aBVs+6d0UAym84WJaZLvgTnxyGmR4OuuPhyg+bEGzBuhraoalsTYByFWThoaMuE9Nb
 211+uFYgQ+b+Kk8XsaRcsRB3zUMDivvrL+obx3j+yW3+CA3nptDK8GXGZTj4fhGrL9fZ
 KDtlIsf6dBcxTBhzo6BlVsWv3Jp5Cwb2DNIiInS+tnoC5f2Xp2O3LeStBX4HW4r6p8/j
 dHacG/XIfJlfmKi4Tvy7o1yYvMG54Xv52bJ0lepwqEMjLCxo6l7y0NkLcNzsTsjPJ4gX
 gKDXd978KFZBdxGcAZgvVHl2G154Bwr1serHsiX61b5ycEa4O8dnV9eg582ZLApdrLmX
 TUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724752162; x=1725356962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eFVbp5mH2R87j2GJDUCRNTEHqK0ZCmXXo1MP+SE9nGs=;
 b=qM+ktqwUNWgFHIxjLfnHtZFWMn4ZCLr9Cm9s6hCF5xQvLtL3jjdeg3RvyxlX4ABlyo
 wqoYxUQYFEj5aupEldIDMZVu0RzvhcyrzkSTy2gyVTNDYL9kQ76B+y5D7XP6y3Cq1T96
 9I4DT2pPth3/XUjbOskusGDTLZdct8M/zjnMcNJ4IkgyvrhEFXiqCV3x8d/FNcvSJOqe
 +6HJYGGKBNXejVMDxDhTVnHbit3sEqgNKXT3ruRq7gQ7nQcRbDeu1lMK7MwBdzlJ3WZG
 8cywjHb01IQRczgxfZPkIHDfsfhb36dqIas7ns+KJXnQY4gYkcKJFMD/OWst1RvM+VGz
 tcdA==
X-Gm-Message-State: AOJu0YyUSqMCOBLMRtCHsUoTT2ZJOC/aH6MGrO0PvL4H8AdHpdl19Owd
 Kb3V2V/+BCQROQQ+qDxj5k4LPicr/l4jz2bwEGeNvRTIBlMtRcI5lTRZrrEYMxZ9fw6AJsNofEl
 R
X-Google-Smtp-Source: AGHT+IF72v309h2z/Jlkq6Oj7JT6OTlLDngI0RzQ0rAP1VkG0KWxG7MSKOv3iBzYiq0artzeeiKvsg==
X-Received: by 2002:a17:907:97cf:b0:a7a:acae:340b with SMTP id
 a640c23a62f3a-a86e2a25c77mr229289666b.31.1724752161934; 
 Tue, 27 Aug 2024 02:49:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e588b60csm86934866b.161.2024.08.27.02.49.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Aug 2024 02:49:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 2/7] tests/functional: Convert mips64el Fuloong2e avocado
 test (2/2)
Date: Tue, 27 Aug 2024 11:49:00 +0200
Message-ID: <20240827094905.80648-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240827094905.80648-1-philmd@linaro.org>
References: <20240827094905.80648-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Add extract_from_deb() method in qemu_test.utils package.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/boot_linux_console.py         | 21 ------------------
 tests/functional/qemu_test/utils.py         | 20 +++++++++++++++++
 tests/functional/test_mips64el_fuloong2e.py | 24 ++++++++++++++++++++-
 3 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 18c69d6acc..01fd126c53 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -170,27 +170,6 @@ def test_mips64el_malta(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    def test_mips64el_fuloong2e(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:fuloong2e
-        :avocado: tags=endian:little
-        """
-        deb_url = ('http://archive.debian.org/debian/pool/main/l/linux/'
-                   'linux-image-3.16.0-6-loongson-2e_3.16.56-1+deb8u1_mipsel.deb')
-        deb_hash = 'd04d446045deecf7b755ef576551de0c4184dd44'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-3.16.0-6-loongson-2e')
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
diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
index 99eae5fc45..481a6b8e7c 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -14,6 +14,8 @@
 import shutil
 import tarfile
 
+from . import run_cmd
+
 def archive_extract(archive, dest_dir, member=None):
     with tarfile.open(archive) as tf:
         if hasattr(tarfile, 'data_filter'):
@@ -24,6 +26,24 @@ def archive_extract(archive, dest_dir, member=None):
         else:
             tf.extractall(path=dest_dir)
 
+def extract_from_deb(deb_path, output_path, file_path):
+    """
+    Extracts a file from a deb package into the test workdir
+
+    :param deb_path: path to the deb archive
+    :param file_path: path within the deb archive of the file to be extracted
+    :returns: full path of the extracted file
+    """
+    cwd = os.getcwd()
+    os.chdir(output_path)
+    (stdout, stderr, ret) = run_cmd(['ar', 't', deb_path])
+    tarball_name = stdout.split()[2]
+    run_cmd(['ar', 'x', deb_path, tarball_name])
+    file_path = file_path if file_path.startswith('.') else '.' + file_path
+    archive_extract(tarball_name, output_path, file_path)
+    os.chdir(cwd)
+    return os.path.join(output_path, file_path)
+
 def gzip_uncompress(gz_path, output_path):
     if os.path.exists(output_path):
         return
diff --git a/tests/functional/test_mips64el_fuloong2e.py b/tests/functional/test_mips64el_fuloong2e.py
index 7688a32713..05f0577021 100755
--- a/tests/functional/test_mips64el_fuloong2e.py
+++ b/tests/functional/test_mips64el_fuloong2e.py
@@ -12,14 +12,36 @@
 import os
 import subprocess
 
-from qemu_test import QemuSystemTest
+from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
+from qemu_test.linux_kernel import linux_kernel_wait_for_pattern
+from qemu_test.linux_kernel import KERNEL_COMMON_COMMAND_LINE
+from qemu_test.utils import extract_from_deb
 from unittest import skipUnless
 
 class MipsFuloong2e(QemuSystemTest):
 
     timeout = 60
 
+    ASSET_KERNEL = Asset(
+        ('http://archive.debian.org/debian/pool/main/l/linux/'
+         'linux-image-3.16.0-6-loongson-2e_3.16.56-1+deb8u1_mipsel.deb'),
+        '2a70f15b397f4ced632b0c15cb22660394190644146d804d60a4796eefbe1f50')
+
+    def test_linux_kernel_3_16(self):
+        deb_path = self.ASSET_KERNEL.fetch()
+        kernel_path = extract_from_deb(deb_path, self.workdir,
+                                       '/boot/vmlinux-3.16.0-6-loongson-2e')
+
+        self.set_machine('fuloong2e')
+        self.vm.set_console()
+        kernel_command_line = KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        linux_kernel_wait_for_pattern(self, console_pattern)
+
     @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     @skipUnless(os.getenv('RESCUE_YL_PATH'), 'RESCUE_YL_PATH not available')
     def test_linux_kernel_2_6_27_isa_serial(self):
-- 
2.45.2


