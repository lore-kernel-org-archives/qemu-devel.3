Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52254C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPXW-0000ff-32; Tue, 18 Feb 2025 10:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPWK-00084c-8N
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPWH-0008CK-RG
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739892500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMGx7JhOr3eTgBGwhkBdK9rZiGMxq6yOyNLVkF3IwzA=;
 b=htCClIXb4wnHKDAgCeregBpBYVa9uyc0Gk5g1R+MU2v1TQGjk2JJsMz4QDI7yzdqNbSNOd
 bnkX3JPjjixjD4yADdarOBaPyU9Yz8neHZqjgfysiqYTwDgoqCCDqceLmZ0/baUnvaTa7T
 c30XbfzQBkxuvRdTpNYLNmyXOa+VUyk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-xcAV_bcBPOesOlhifyl3Ig-1; Tue,
 18 Feb 2025 10:28:18 -0500
X-MC-Unique: xcAV_bcBPOesOlhifyl3Ig-1
X-Mimecast-MFC-AGG-ID: xcAV_bcBPOesOlhifyl3Ig_1739892497
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7677180087E; Tue, 18 Feb 2025 15:28:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0C491800370; Tue, 18 Feb 2025 15:28:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/14] tests/functional: Convert the alpha replay avocado tests
Date: Tue, 18 Feb 2025 16:27:40 +0100
Message-ID: <20250218152744.228335-11-thuth@redhat.com>
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
 tests/avocado/replay_kernel.py        | 17 ----------------
 tests/functional/meson.build          |  1 +
 tests/functional/test_alpha_replay.py | 29 +++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 17 deletions(-)
 create mode 100755 tests/functional/test_alpha_replay.py

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 02bd868a429..4347d202742 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -176,20 +176,3 @@ def test_s390x_s390_ccw_virtio(self):
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=sclp0'
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=9)
-
-    def test_alpha_clipper(self):
-        """
-        :avocado: tags=arch:alpha
-        :avocado: tags=machine:clipper
-        """
-        kernel_url = ('http://archive.debian.org/debian/dists/lenny/main/'
-                      'installer-alpha/20090123lenny10/images/cdrom/vmlinuz')
-        kernel_hash = '3a943149335529e2ed3e74d0d787b85fb5671ba3'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        uncompressed_kernel = archive.uncompress(kernel_path, self.workdir)
-
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.run_rr(uncompressed_kernel, kernel_command_line, console_pattern, shift=9,
-            args=('-nodefaults', ))
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 815aefc14cd..884b5aabc50 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -90,6 +90,7 @@ tests_alpha_system_quick = [
 
 tests_alpha_system_thorough = [
   'alpha_clipper',
+  'alpha_replay',
 ]
 
 tests_arm_system_quick = [
diff --git a/tests/functional/test_alpha_replay.py b/tests/functional/test_alpha_replay.py
new file mode 100755
index 00000000000..24a17ef5904
--- /dev/null
+++ b/tests/functional/test_alpha_replay.py
@@ -0,0 +1,29 @@
+#!/usr/bin/env python3
+#
+# Replay test that boots a Linux kernel on an Alpha machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from replay_kernel import ReplayKernelBase
+
+
+class AlphaReplay(ReplayKernelBase):
+
+    ASSET_KERNEL = Asset(
+        ('http://archive.debian.org/debian/dists/lenny/main/installer-alpha/'
+         '20090123lenny10/images/cdrom/vmlinuz'),
+        '34f53da3fa32212e4f00b03cb944b2ad81c06bc8faaf9b7193b2e544ceeca576')
+
+    def test_clipper(self):
+        self.set_machine('clipper')
+        kernel_path = self.uncompress(self.ASSET_KERNEL, format='gz')
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=9,
+            args=('-nodefaults', ))
+
+
+if __name__ == '__main__':
+    ReplayKernelBase.main()
-- 
2.48.1


