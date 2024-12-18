Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6C4E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrxr-0008OM-7c; Wed, 18 Dec 2024 06:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxp-0008Fb-7g
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxl-0005xG-AZ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbvUWHbMp2v3h4Romgjd8BY6FCD6FfHSNBOb/KaYqK8=;
 b=dRhbKs2ezO7HnzmWti34BA6ZvZE8TryPxSLyTlIQsoBCmE8fbeB7Pb8wzfGBskaV0ioc6h
 pdtVjWMm7hIqDmvretuMQh9zJoMY2mEmja2N9ahq4q5nn3yVIEfbVvFqHrIik403pK8ao/
 IMalZIu9p59ljdqLg6c1NnM+N+pvFRI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-j-Lc-8RlMMaHqRacd9sfDQ-1; Wed,
 18 Dec 2024 06:11:31 -0500
X-MC-Unique: j-Lc-8RlMMaHqRacd9sfDQ-1
X-Mimecast-MFC-AGG-ID: j-Lc-8RlMMaHqRacd9sfDQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8038A1955F28
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:11:30 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A5C11964171; Wed, 18 Dec 2024 11:11:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 34/38] tests/functional: Convert the arm virt avocado test
Date: Wed, 18 Dec 2024 12:09:54 +0100
Message-ID: <20241218110958.226932-35-thuth@redhat.com>
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Straight forward conversion, basically just the hashsums needed
to be updated to sha256 now.

Message-ID: <20241206102358.1186644-7-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/boot_linux_console.py | 21 --------------------
 tests/functional/meson.build        |  1 +
 tests/functional/test_arm_virt.py   | 30 +++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 21 deletions(-)
 create mode 100755 tests/functional/test_arm_virt.py

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 4bd1465ba3..c15f39ae1f 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -94,24 +94,3 @@ def test_x86_64_pc(self):
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
-
-    def test_arm_virt(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:virt
-        :avocado: tags=accel:tcg
-        """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
-                      '/linux/releases/29/Everything/armhfp/os/images/pxeboot'
-                      '/vmlinuz')
-        kernel_hash = 'e9826d741b4fb04cadba8d4824d1ed3b7fb8b4d4'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyAMA0')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-append', kernel_command_line)
-        self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index f0326788f0..ebb26d7044 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -91,6 +91,7 @@ tests_arm_system_thorough = [
   'arm_smdkc210',
   'arm_sx1',
   'arm_vexpress',
+  'arm_virt',
   'arm_tuxrun',
 ]
 
diff --git a/tests/functional/test_arm_virt.py b/tests/functional/test_arm_virt.py
new file mode 100755
index 0000000000..7b6549176f
--- /dev/null
+++ b/tests/functional/test_arm_virt.py
@@ -0,0 +1,30 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+
+class ArmVirtMachine(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
+         'releases/29/Everything/armhfp/os/images/pxeboot/vmlinuz'),
+        '18dd5f1a9a28bd539f9d047f7c0677211bae528e8712b40ca5a229a4ad8e2591')
+
+    def test_arm_virt(self):
+        self.set_machine('virt')
+        kernel_path = self.ASSET_KERNEL.fetch()
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyAMA0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.1


