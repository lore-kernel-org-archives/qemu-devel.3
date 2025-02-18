Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F550C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPWX-0008A8-0m; Tue, 18 Feb 2025 10:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPW8-0007zi-R4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPW6-00084z-Pv
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739892489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8WWfpUza2m71OYz3Tf7HaZtZOjFUiR8iLdnQmx+UkEU=;
 b=ZqbC7kTpBEyA291GIAbHggXMcmvPldIRV8cI9nBbuDC0IWqi2okC4xU40d8X3MYG4FuOwW
 ze2aLczcrzb94Sk2/8pQFWJT/ZHra6NyPLRtrflEmu17HcN0sTvAwph/y161y8ZxtGQwLn
 UIEiqLmnwO0mBJWzOxxCGjZs35tX39o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-1Ou-qWzLPTejm5qi2tb1sw-1; Tue,
 18 Feb 2025 10:28:08 -0500
X-MC-Unique: 1Ou-qWzLPTejm5qi2tb1sw-1
X-Mimecast-MFC-AGG-ID: 1Ou-qWzLPTejm5qi2tb1sw_1739892487
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A5DD180056F; Tue, 18 Feb 2025 15:28:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 27BAA1800359; Tue, 18 Feb 2025 15:28:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/14] tests/functional: Convert the ppc64 replay avocado tests
Date: Tue, 18 Feb 2025 16:27:36 +0100
Message-ID: <20250218152744.228335-7-thuth@redhat.com>
In-Reply-To: <20250218152744.228335-1-thuth@redhat.com>
References: <20250218152744.228335-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
 tests/avocado/replay_kernel.py        | 45 ------------------------
 tests/functional/meson.build          |  1 +
 tests/functional/test_ppc64_replay.py | 49 +++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 45 deletions(-)
 create mode 100755 tests/functional/test_ppc64_replay.py

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index ef72b1622e4..397f7500463 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -242,39 +242,6 @@ def test_alpha_clipper(self):
         self.run_rr(uncompressed_kernel, kernel_command_line, console_pattern, shift=9,
             args=('-nodefaults', ))
 
-    def test_ppc64_pseries(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:pseries
-        :avocado: tags=accel:tcg
-        """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
-                      '/fedora-secondary/releases/29/Everything/ppc64le/os'
-                      '/ppc/ppc64/vmlinuz')
-        kernel_hash = '3fe04abfc852b66653b8c3c897a59a689270bc77'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
-        console_pattern = 'VFS: Cannot open root device'
-        self.run_rr(kernel_path, kernel_command_line, console_pattern)
-
-    def test_ppc64_powernv(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:powernv
-        :avocado: tags=accel:tcg
-        """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
-                      '/fedora-secondary/releases/29/Everything/ppc64le/os'
-                      '/ppc/ppc64/vmlinuz')
-        kernel_hash = '3fe04abfc852b66653b8c3c897a59a689270bc77'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + \
-                              'console=tty0 console=hvc0'
-        console_pattern = 'VFS: Cannot open root device'
-        self.run_rr(kernel_path, kernel_command_line, console_pattern)
-
     def test_m68k_q800(self):
         """
         :avocado: tags=arch:m68k
@@ -340,15 +307,3 @@ def test_microblaze_s3adsp1800(self):
                    '/qac-best-of-multiarch/download/day17.tar.xz')
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'ballerina.bin')
-
-    def test_ppc64_e500(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:ppce500
-        :avocado: tags=cpu:e5500
-        """
-        tar_hash = '6951d86d644b302898da2fd701739c9406527fe1'
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day19.tar.xz')
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        self.do_test_advcal_2018(file_path, 'uImage')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 1c9fe67f037..e97c96d3ef4 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -215,6 +215,7 @@ tests_ppc64_system_thorough = [
   'ppc64_hv',
   'ppc64_powernv',
   'ppc64_pseries',
+  'ppc64_replay',
   'ppc64_reverse_debugging',
   'ppc64_tuxrun',
   'ppc64_mac99',
diff --git a/tests/functional/test_ppc64_replay.py b/tests/functional/test_ppc64_replay.py
new file mode 100755
index 00000000000..48ce1b7f1e1
--- /dev/null
+++ b/tests/functional/test_ppc64_replay.py
@@ -0,0 +1,49 @@
+#!/usr/bin/env python3
+#
+# Replay test that boots a Linux kernel on ppc64 machines
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from replay_kernel import ReplayKernelBase
+
+
+class Ppc64Replay(ReplayKernelBase):
+
+    ASSET_DAY19 = Asset(
+        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
+         'day19.tar.xz'),
+        '20b1bb5a8488c664defbb5d283addc91a05335a936c63b3f5ff7eee74b725755')
+
+    def test_ppc64_e500(self):
+        self.set_machine('ppce500')
+        self.cpu = 'e5500'
+        kernel_path = self.archive_extract(self.ASSET_DAY19,
+                                           member='day19/uImage')
+        self.run_rr(kernel_path, self.REPLAY_KERNEL_COMMAND_LINE,
+                    'QEMU advent calendar')
+
+    ASSET_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
+         'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
+        '383c2f5c23bc0d9d32680c3924d3fd7ee25cc5ef97091ac1aa5e1d853422fc5f')
+
+    def test_ppc64_pseries(self):
+        self.set_machine('pseries')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
+        console_pattern = 'VFS: Cannot open root device'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern)
+
+    def test_ppc64_powernv(self):
+        self.set_machine('powernv')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + \
+                              'console=tty0 console=hvc0'
+        console_pattern = 'VFS: Cannot open root device'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern)
+
+
+if __name__ == '__main__':
+    ReplayKernelBase.main()
-- 
2.48.1


