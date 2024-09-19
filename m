Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08149CF3962
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 18:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srMM9-0007J7-Lq; Thu, 19 Sep 2024 14:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1srMM7-0007IW-7j
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 14:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1srMM5-0001Nc-MB
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 14:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726772296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXKmNyfO/xawcB6OvqDOE+mIxb46hce82XDAqY/bvD8=;
 b=hccCg76m+R60h+M31JSPzsANPjFjwFRDNvTf017fUebLEN+WcimI2l7mlHV1oLLBmC3VjU
 UYAEEDGcHYELKw/yEL730MGUthW9TiFJSQBVtYbxJIpjoaTSNuR0k12nWKOxMKpOsGE0wq
 pA9eQ/Wilg/e7Nm4ZSn0jgXsOpfniUQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-vftAswZiNJCaKm5jHeH26Q-1; Thu,
 19 Sep 2024 14:58:10 -0400
X-MC-Unique: vftAswZiNJCaKm5jHeH26Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 549B319373DF; Thu, 19 Sep 2024 18:58:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.46])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C96C19560AA; Thu, 19 Sep 2024 18:58:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3/7] tests/functional: Convert the xtensa lx60 Avocado test
Date: Thu, 19 Sep 2024 20:57:43 +0200
Message-ID: <20240919185749.71222-4-thuth@redhat.com>
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
 MAINTAINERS                          |  1 +
 tests/avocado/boot_linux_console.py  |  9 ---------
 tests/functional/meson.build         |  4 ++++
 tests/functional/test_xtensa_lx60.py | 26 ++++++++++++++++++++++++++
 4 files changed, 31 insertions(+), 9 deletions(-)
 create mode 100755 tests/functional/test_xtensa_lx60.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f7f4c2be6..a75d6ba7d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1915,6 +1915,7 @@ S: Maintained
 F: hw/xtensa/xtfpga.c
 F: hw/net/opencores_eth.c
 F: include/hw/xtensa/mx_pic.h
+F: tests/functional/test_xtensa_lx60.py
 
 Devices
 -------
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 7a776c2818..cf58499c84 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1027,12 +1027,3 @@ def test_sparc_ss20(self):
         """
         tar_hash = 'b18550d5d61c7615d989a06edace051017726a9f'
         self.do_test_advcal_2018('11', tar_hash, 'zImage.elf')
-
-    def test_xtensa_lx60(self):
-        """
-        :avocado: tags=arch:xtensa
-        :avocado: tags=machine:lx60
-        :avocado: tags=cpu:dc233c
-        """
-        tar_hash = '49e88d9933742f0164b60839886c9739cb7a0d34'
-        self.do_test_advcal_2018('02', tar_hash, 'santas-sleigh-ride.elf')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 3fc1bb192d..8fd852f4ab 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -145,6 +145,10 @@ tests_x86_64_system_thorough = [
   'virtio_gpu',
 ]
 
+tests_xtensa_system_thorough = [
+  'xtensa_lx60',
+]
+
 precache_all = []
 foreach speed : ['quick', 'thorough']
   foreach dir : target_dirs
diff --git a/tests/functional/test_xtensa_lx60.py b/tests/functional/test_xtensa_lx60.py
new file mode 100755
index 0000000000..8ce5206a4f
--- /dev/null
+++ b/tests/functional/test_xtensa_lx60.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on an xtensa lx650 machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test.utils import archive_extract
+
+class XTensaLX60Test(LinuxKernelTest):
+
+    ASSET_DAY02 = Asset(
+        'https://www.qemu-advent-calendar.org/2018/download/day02.tar.xz',
+        '68ff07f9b3fd3df36d015eb46299ba44748e94bfbb2d5295fddc1a8d4a9fd324')
+
+    def test_xtensa_lx60(self):
+        self.set_machine('lx60')
+        self.cpu = 'dc233c'
+        file_path = self.ASSET_DAY02.fetch()
+        archive_extract(file_path, self.workdir)
+        self.launch_kernel(self.workdir + '/day02/santas-sleigh-ride.elf',
+                           wait_for='QEMU advent calendar')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.46.0


