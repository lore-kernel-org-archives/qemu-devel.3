Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F6FC19778
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEBD-0003kF-Mm; Wed, 26 Feb 2025 04:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEB6-0003e2-8j
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:58:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEB1-00087w-8F
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740563881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPcZUhQZ8nDOVSEnzzC0I/2furLHQ29Yp84CWzaJ5ek=;
 b=i6Ri8A1pyWU0QENIyFAhZCzu94HRu0fKbvjLmvzbC8EKb/FFR0ISB7IeCPa6dlnQb4R3uM
 MiEujc+RRBqhgC4UkmIbXzK0LWYl5ay8J5ODlc086MHmyoS0LopyX1K1OiFfvqmhM/byy6
 bfKcmvPQ00Z851wWBV1QBWMpA7ykZ6Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-yoHXMDrbN4GuFwmYVFVL6w-1; Wed,
 26 Feb 2025 04:57:59 -0500
X-MC-Unique: yoHXMDrbN4GuFwmYVFVL6w-1
X-Mimecast-MFC-AGG-ID: yoHXMDrbN4GuFwmYVFVL6w_1740563878
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6237196E078
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:57:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.144])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F3891800358; Wed, 26 Feb 2025 09:57:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 10/18] tests/functional: Convert the m68k replay avocado tests
Date: Wed, 26 Feb 2025 10:57:23 +0100
Message-ID: <20250226095731.1172375-11-thuth@redhat.com>
In-Reply-To: <20250226095731.1172375-1-thuth@redhat.com>
References: <20250226095731.1172375-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Put the tests into a separate file now (since in the functional
framework, each file is run with one specific qemu-system-* binary).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250218152744.228335-9-thuth@redhat.com>
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
index 58f12f54d14..995cea4f305 100644
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


