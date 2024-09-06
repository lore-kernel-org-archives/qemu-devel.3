Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB430E6FE3D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smdM3-0007xP-5w; Fri, 06 Sep 2024 14:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdLr-0007mL-4g
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:06:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdLp-00053Z-6s
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725645981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4pEa8e5xIR2LKo/+6GUrYo7L0r25OpLVdV5KWDsTqAw=;
 b=N20QkhYnewswGu4w4kKZd57I3yyrqoZwAU2rUQkrQvc3C41VDYNO2KoHoTaVqsIP7xIx1X
 qRFU6NrES4NIlng1wazJDg3EZJpWUgVrvjdt0h6O28XOebHXNzxyxK15oxjTbYtNFuOt6L
 /QIIvj8ZNGUj+0+yUPFiao7fnzHLtUg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-tuwdQGufM_OKXbmoirdiow-1; Fri,
 06 Sep 2024 14:06:19 -0400
X-MC-Unique: tuwdQGufM_OKXbmoirdiow-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBF241955F2E; Fri,  6 Sep 2024 18:06:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69BB719560AA; Fri,  6 Sep 2024 18:06:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH 07/14] tests/functional: Convert nanomips Malta avocado tests
Date: Fri,  6 Sep 2024 20:05:42 +0200
Message-ID: <20240906180549.792832-8-thuth@redhat.com>
In-Reply-To: <20240906180549.792832-1-thuth@redhat.com>
References: <20240906180549.792832-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Message-ID: <20240827094905.80648-7-philmd@linaro.org>
[thuth: Use LinuxKernelTest]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/boot_linux_console.py   | 59 ---------------------------
 tests/functional/test_mipsel_malta.py | 51 ++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 60 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 84b31cb84e..34f4abadd0 100644
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
index f31f96b012..b8dfddd856 100755
--- a/tests/functional/test_mipsel_malta.py
+++ b/tests/functional/test_mipsel_malta.py
@@ -11,12 +11,61 @@
 
 import os
 
-from qemu_test import QemuSystemTest, Asset
+from qemu_test import QemuSystemTest, LinuxKernelTest, Asset
 from qemu_test import interrupt_interactive_console_until_pattern
 from qemu_test import wait_for_console_pattern
+from qemu_test.utils import lzma_uncompress
 from zipfile import ZipFile
 
 
+class MaltaMachineConsole(LinuxKernelTest):
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
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'mem=256m@@0x0 '
+                               + 'console=ttyS0')
+        self.vm.add_args('-cpu', 'I7200',
+                         '-no-reboot',
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
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
2.46.0


