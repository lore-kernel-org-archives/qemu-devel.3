Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE06E6FE41
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smdLa-0007C3-Ey; Fri, 06 Sep 2024 14:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdLY-00072I-0M
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:06:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdLW-00052Z-Bg
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725645969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hlGjD7p7a/E5EaF/L6lHdEvOprDHkUtk+IeSdNmWok0=;
 b=jDm/VsXTzic0rlEUJffAQRH1BAjivq4YgG6y3VbHzTOigHUi3Mtv8McetorVAcdSQYtD1y
 uOTO5B0lJwv/llmu70UClJoz9vAWxLY4VFUm+7dIa7RSnHSCtWYwyeYgsY5uDy72zMFyJl
 Sm6mCS9CFd+Z4QIVahB4lWo+VQbWPkY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-X5nKyUpQPbKu0SsUsTLxrA-1; Fri,
 06 Sep 2024 14:06:06 -0400
X-MC-Unique: X5nKyUpQPbKu0SsUsTLxrA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D08D1194511A; Fri,  6 Sep 2024 18:06:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6624B19560AA; Fri,  6 Sep 2024 18:06:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH 03/14] tests/functional: Convert mips64el Fuloong2e avocado
 test (2/2)
Date: Fri,  6 Sep 2024 20:05:38 +0200
Message-ID: <20240906180549.792832-4-thuth@redhat.com>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[thuth: Use LinuxKernelTest class for this test]
Message-ID: <20240827094905.80648-3-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/boot_linux_console.py         | 21 -----------------
 tests/functional/test_mips64el_fuloong2e.py | 25 ++++++++++++++++++---
 2 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 396836bf64..e1e20c36f7 100644
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
diff --git a/tests/functional/test_mips64el_fuloong2e.py b/tests/functional/test_mips64el_fuloong2e.py
index 7688a32713..a32d5f9d08 100755
--- a/tests/functional/test_mips64el_fuloong2e.py
+++ b/tests/functional/test_mips64el_fuloong2e.py
@@ -12,14 +12,33 @@
 import os
 import subprocess
 
-from qemu_test import QemuSystemTest
+from qemu_test import LinuxKernelTest, Asset
 from qemu_test import wait_for_console_pattern
 from unittest import skipUnless
 
-class MipsFuloong2e(QemuSystemTest):
+class MipsFuloong2e(LinuxKernelTest):
 
     timeout = 60
 
+    ASSET_KERNEL = Asset(
+        ('http://archive.debian.org/debian/pool/main/l/linux/'
+         'linux-image-3.16.0-6-loongson-2e_3.16.56-1+deb8u1_mipsel.deb'),
+        '2a70f15b397f4ced632b0c15cb22660394190644146d804d60a4796eefbe1f50')
+
+    def test_linux_kernel_3_16(self):
+        deb_path = self.ASSET_KERNEL.fetch()
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinux-3.16.0-6-loongson-2e')
+
+        self.set_machine('fuloong2e')
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
+
     @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     @skipUnless(os.getenv('RESCUE_YL_PATH'), 'RESCUE_YL_PATH not available')
     def test_linux_kernel_2_6_27_isa_serial(self):
@@ -42,4 +61,4 @@ def test_linux_kernel_2_6_27_isa_serial(self):
 
 
 if __name__ == '__main__':
-    QemuSystemTest.main()
+    LinuxKernelTest.main()
-- 
2.46.0


