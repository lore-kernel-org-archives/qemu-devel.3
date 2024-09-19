Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9E4CF3964
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 18:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srMMC-0007SM-V3; Thu, 19 Sep 2024 14:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1srMMA-0007KV-5V
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 14:58:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1srMM8-0001Np-9X
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 14:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726772299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32SIVo5ZUcpeDivRWuhw0SoH5RpwYN28O0swWDGMd48=;
 b=PJUumPVXGJH4z6Rpk9/qp2+NE226runGq45/P6tRWdl9vYlik7hCEGXNJxuRso60syXbgD
 lgnRJhYHMBxbi9TiN9MdKfSw+dyrBJCsr7IJz3OvVvzdmE6d5O6NMVMv8zOfJ521sTqqLD
 AlvkAiyK6lIPz/iyAkcOYpQqqe08Gw0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-X3q4BCyoNRO4oYNxPuaYvg-1; Thu,
 19 Sep 2024 14:58:15 -0400
X-MC-Unique: X3q4BCyoNRO4oYNxPuaYvg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83AE81953954; Thu, 19 Sep 2024 18:58:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.46])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2066419560AA; Thu, 19 Sep 2024 18:58:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4/7] tests/functional: Convert the SPARCStation Avocado test
Date: Thu, 19 Sep 2024 20:57:44 +0200
Message-ID: <20240919185749.71222-5-thuth@redhat.com>
In-Reply-To: <20240919185749.71222-1-thuth@redhat.com>
References: <20240919185749.71222-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use the new launch_kernel function to convert this test in a simple way.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                          |  1 +
 tests/avocado/boot_linux_console.py  |  8 --------
 tests/functional/meson.build         |  4 ++++
 tests/functional/test_sparc_sun4m.py | 25 +++++++++++++++++++++++++
 4 files changed, 30 insertions(+), 8 deletions(-)
 create mode 100755 tests/functional/test_sparc_sun4m.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a75d6ba7d2..b85a3fc529 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1693,6 +1693,7 @@ F: include/hw/nvram/sun_nvram.h
 F: include/hw/sparc/sparc32_dma.h
 F: include/hw/sparc/sun4m_iommu.h
 F: pc-bios/openbios-sparc32
+F: tests/functional/test_sparc_sun4m.py
 
 Sun4u
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index cf58499c84..900af67412 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1019,11 +1019,3 @@ def test_sh4_r2d(self):
         tar_hash = 'fe06a4fd8ccbf2e27928d64472939d47829d4c7e'
         self.vm.add_args('-append', 'console=ttySC1')
         self.do_test_advcal_2018('09', tar_hash, 'zImage', console=1)
-
-    def test_sparc_ss20(self):
-        """
-        :avocado: tags=arch:sparc
-        :avocado: tags=machine:SS-20
-        """
-        tar_hash = 'b18550d5d61c7615d989a06edace051017726a9f'
-        self.do_test_advcal_2018('11', tar_hash, 'zImage.elf')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 8fd852f4ab..8aacd15cf3 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -125,6 +125,10 @@ tests_s390x_system_thorough = [
   's390x_topology',
 ]
 
+tests_sparc_system_thorough = [
+  'sparc_sun4m',
+]
+
 tests_sparc64_system_thorough = [
   'sparc64_sun4u',
 ]
diff --git a/tests/functional/test_sparc_sun4m.py b/tests/functional/test_sparc_sun4m.py
new file mode 100755
index 0000000000..b334375820
--- /dev/null
+++ b/tests/functional/test_sparc_sun4m.py
@@ -0,0 +1,25 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a sparc sun4m machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test.utils import archive_extract
+
+class Sun4mTest(LinuxKernelTest):
+
+    ASSET_DAY11 = Asset(
+        'https://www.qemu-advent-calendar.org/2018/download/day11.tar.xz',
+        'c776533ba756bf4dd3f1fc4c024fb50ef0d853e05c5f5ddf0900a32d1eaa49e0')
+
+    def test_sparc_ss20(self):
+        self.set_machine('SS-20')
+        file_path = self.ASSET_DAY11.fetch()
+        archive_extract(file_path, self.workdir)
+        self.launch_kernel(self.workdir + '/day11/zImage.elf',
+                           wait_for='QEMU advent calendar')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.46.0


