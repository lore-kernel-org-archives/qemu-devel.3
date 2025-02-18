Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E68DC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPXU-0000f7-By; Tue, 18 Feb 2025 10:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPWK-00084b-4G
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPWG-0008BX-Iq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739892498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5LgHzhzSfarKUxhDqL2Bjy+KrTB4K289wOQ1/7TM0XI=;
 b=QtTnFoOzjoc15m+CTga8ZjPgle1XGTwLbHJyy7QfG82JXd8pGbaZa3xLeYUXPSfiW7LIh3
 UqIz9GOO2iHTVjTcPZr2DqozOMu9HsOSEc5pwYzrMk6oUdV01JVNk7G0620TTxalWUARNu
 lKhMfZpQnfn+Jy/O9w4TCZ/R42Gl6ec=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-leztxot4MdGWgoQm7sYA4A-1; Tue,
 18 Feb 2025 10:28:13 -0500
X-MC-Unique: leztxot4MdGWgoQm7sYA4A-1
X-Mimecast-MFC-AGG-ID: leztxot4MdGWgoQm7sYA4A_1739892492
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64F2519783B7; Tue, 18 Feb 2025 15:28:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B6C3180035F; Tue, 18 Feb 2025 15:28:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/14] tests/functional: Convert the m68k replay avocado tests
Date: Tue, 18 Feb 2025 16:27:38 +0100
Message-ID: <20250218152744.228335-9-thuth@redhat.com>
In-Reply-To: <20250218152744.228335-1-thuth@redhat.com>
References: <20250218152744.228335-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Put the tests into a separate file now (since in the functional
framework, each file is run with one specific qemu-system-* binary).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/replay_kernel.py       | 29 -------------------
 tests/functional/meson.build         |  1 +
 tests/functional/test_m68k_replay.py | 42 ++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 29 deletions(-)
 create mode 100755 tests/functional/test_m68k_replay.py

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index b2097afc302..4bd48878b7e 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -242,24 +242,6 @@ def test_alpha_clipper(self):
         self.run_rr(uncompressed_kernel, kernel_command_line, console_pattern, shift=9,
             args=('-nodefaults', ))
 
-    def test_m68k_q800(self):
-        """
-        :avocado: tags=arch:m68k
-        :avocado: tags=machine:q800
-        """
-        deb_url = ('https://snapshot.debian.org/archive/debian-ports'
-                   '/20191021T083923Z/pool-m68k/main'
-                   '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.udeb')
-        deb_hash = '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-5.3.0-1-m68k')
-
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyS0 vga=off')
-        console_pattern = 'No filesystem could mount root'
-        self.run_rr(kernel_path, kernel_command_line, console_pattern)
-
     def do_test_advcal_2018(self, file_path, kernel_name, args=None):
         archive.extract(file_path, self.workdir)
 
@@ -285,14 +267,3 @@ def test_arm_vexpressa9(self):
         dtb_path = self.workdir + '/day16/vexpress-v2p-ca9.dtb'
         self.do_test_advcal_2018(file_path, 'winter.zImage',
                                  args=('-dtb', dtb_path))
-
-    def test_m68k_mcf5208evb(self):
-        """
-        :avocado: tags=arch:m68k
-        :avocado: tags=machine:mcf5208evb
-        """
-        tar_hash = 'ac688fd00561a2b6ce1359f9ff6aa2b98c9a570c'
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day07.tar.xz')
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        self.do_test_advcal_2018(file_path, 'sanity-clause.elf')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index d59ac2be9da..7af43dbdcfc 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -147,6 +147,7 @@ tests_loongarch64_system_thorough = [
 tests_m68k_system_thorough = [
   'm68k_mcf5208evb',
   'm68k_nextcube',
+  'm68k_replay',
   'm68k_q800',
   'm68k_tuxrun',
 ]
diff --git a/tests/functional/test_m68k_replay.py b/tests/functional/test_m68k_replay.py
new file mode 100755
index 00000000000..18c1db539c5
--- /dev/null
+++ b/tests/functional/test_m68k_replay.py
@@ -0,0 +1,42 @@
+#!/usr/bin/env python3
+#
+# Replay test that boots a Linux kernel on an m68k machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from replay_kernel import ReplayKernelBase
+
+
+class M68kReplay(ReplayKernelBase):
+
+    ASSET_Q800 = Asset(
+        ('https://snapshot.debian.org/'
+         'archive/debian-ports/20191021T083923Z/pool-m68k/main/l/linux/'
+         'kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.udeb'),
+        '949e50d74d4b9bc15d26c06d402717b7a4c0e32ff8100014f5930d8024de7b73')
+
+    def test_q800(self):
+        self.set_machine('q800')
+        kernel_path = self.archive_extract(self.ASSET_Q800,
+                                           member='boot/vmlinux-5.3.0-1-m68k')
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0 vga=off')
+        console_pattern = 'No filesystem could mount root'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern)
+
+    ASSET_MCF5208 = Asset(
+       'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day07.tar.xz',
+       '753c2f3837126b7c6ba92d0b1e0b156e8a2c5131d2d576bb0b9a763fae73c08a')
+
+    def test_mcf5208evb(self):
+        self.set_machine('mcf5208evb')
+        kernel_path = self.archive_extract(self.ASSET_MCF5208,
+                                           member='day07/sanity-clause.elf')
+        self.run_rr(kernel_path, self.KERNEL_COMMON_COMMAND_LINE,
+                    'QEMU advent calendar')
+
+
+if __name__ == '__main__':
+    ReplayKernelBase.main()
-- 
2.48.1


