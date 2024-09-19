Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBFACF3963
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 18:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srMMG-0007dy-4P; Thu, 19 Sep 2024 14:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1srMME-0007ZZ-LF
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 14:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1srMMC-0001O6-R7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 14:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726772303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SYa+qomcAX21vpHUSncIfptuYVSKRE7oQzzDiYo3Bk0=;
 b=AS8D7jNFPS/2shjtU3s6ullGBrD3hFGBxAGG57sCw5qCkUlC9SqiRpZEX6oQUQSiBk594W
 /8oIS/iGCBcZmHUL72QVAPUVEo76OuRaX6XqK9LmYwPcSyZb+LmrYPv1xpXZetSXVCVfst
 x76NXR3nP+VHxnPiWjFBNFtcWNq3pmc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-WNNcXUWkMcCX2u4fScrkEQ-1; Thu,
 19 Sep 2024 14:58:18 -0400
X-MC-Unique: WNNcXUWkMcCX2u4fScrkEQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 363341953963; Thu, 19 Sep 2024 18:58:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.46])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AE8519560AA; Thu, 19 Sep 2024 18:58:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5/7] tests/functional: Convert the e500 ppc64 Avocado test
Date: Thu, 19 Sep 2024 20:57:45 +0200
Message-ID: <20240919185749.71222-6-thuth@redhat.com>
In-Reply-To: <20240919185749.71222-1-thuth@redhat.com>
References: <20240919185749.71222-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
 MAINTAINERS                         |  1 +
 tests/avocado/boot_linux_console.py | 11 -----------
 tests/functional/meson.build        |  1 +
 tests/functional/test_ppc64_e500.py | 25 +++++++++++++++++++++++++
 4 files changed, 27 insertions(+), 11 deletions(-)
 create mode 100755 tests/functional/test_ppc64_e500.py

diff --git a/MAINTAINERS b/MAINTAINERS
index b85a3fc529..3dd80a0138 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1445,6 +1445,7 @@ F: pc-bios/u-boot.e500
 F: hw/intc/openpic_kvm.c
 F: include/hw/ppc/openpic_kvm.h
 F: docs/system/ppc/ppce500.rst
+F: tests/functional/test_ppc64_e500.py
 
 mpc8544ds
 L: qemu-ppc@nongnu.org
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 900af67412..344c7835a2 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -918,17 +918,6 @@ def test_arm_ast2600_debian(self):
         self.wait_for_console_pattern("SMP: Total of 2 processors activated")
         self.wait_for_console_pattern("No filesystem could mount root")
 
-    def test_ppc64_e500(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:ppce500
-        :avocado: tags=cpu:e5500
-        :avocado: tags=accel:tcg
-        """
-        self.require_accelerator("tcg")
-        tar_hash = '6951d86d644b302898da2fd701739c9406527fe1'
-        self.do_test_advcal_2018('19', tar_hash, 'uImage')
-
     def do_test_ppc64_powernv(self, proc):
         self.require_accelerator("tcg")
         images_url = ('https://github.com/open-power/op-build/releases/download/v2.7/')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 8aacd15cf3..bc33332313 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -111,6 +111,7 @@ tests_ppc_system_thorough = [
 ]
 
 tests_ppc64_system_thorough = [
+  'ppc64_e500',
   'ppc64_hv',
   'ppc64_powernv',
   'ppc64_pseries',
diff --git a/tests/functional/test_ppc64_e500.py b/tests/functional/test_ppc64_e500.py
new file mode 100755
index 0000000000..3558ae0c8c
--- /dev/null
+++ b/tests/functional/test_ppc64_e500.py
@@ -0,0 +1,25 @@
+#!/usr/bin/env python3
+#
+# Boot a Linux kernel on a e500 ppc64 machine and check the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test.utils import archive_extract
+
+class E500Test(LinuxKernelTest):
+
+    ASSET_DAY19 = Asset(
+        'https://www.qemu-advent-calendar.org/2018/download/day19.tar.xz',
+        '20b1bb5a8488c664defbb5d283addc91a05335a936c63b3f5ff7eee74b725755')
+
+    def test_ppc64_e500(self):
+        self.set_machine('ppce500')
+        self.cpu = 'e5500'
+        file_path = self.ASSET_DAY19.fetch()
+        archive_extract(file_path, self.workdir)
+        self.launch_kernel(self.workdir + '/day19/uImage',
+                           wait_for='QEMU advent calendar')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.46.0


