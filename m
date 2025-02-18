Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2280EC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPX8-0000Gg-Gl; Tue, 18 Feb 2025 10:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPWT-0008AG-WD
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPWR-0008Gx-H8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739892510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qNBL2oKH1CUiue7VLjb7VFcZSXQyug26lDfg6D9Ytvc=;
 b=PqE0pSk9rUTpk+3e2PsoyEwOYBoC0cCz1BB98N0gKl10GVEkIsKjZxbnZ4xEw7utNWxfvS
 guyz6kPPwHK+oCX9X82a72nbuUDa4NugIKs2yRNuvTYva6x9jezSSS1xBgg10f7rJ+JCWs
 5ZYCZS+EGT2yvk2UiYHP+ukLeBI5KxU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-vQQoJIxCN3CwdCMabECGMQ-1; Tue,
 18 Feb 2025 10:28:26 -0500
X-MC-Unique: vQQoJIxCN3CwdCMabECGMQ-1
X-Mimecast-MFC-AGG-ID: vQQoJIxCN3CwdCMabECGMQ_1739892505
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1CAD18EAB38; Tue, 18 Feb 2025 15:28:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B4C11800361; Tue, 18 Feb 2025 15:28:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/14] tests/functional: Convert the x86_64 replay avocado
 tests
Date: Tue, 18 Feb 2025 16:27:43 +0100
Message-ID: <20250218152744.228335-14-thuth@redhat.com>
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

Put the tests into a separate file now (in the functional framework,
each file is run with one specific qemu-system-* binary).

Signed-off-by: Thomas Huth <thuth@redhat.com
---
 tests/avocado/replay_kernel.py         | 35 --------------------------
 tests/functional/meson.build           |  2 ++
 tests/functional/test_x86_64_replay.py | 35 ++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 35 deletions(-)
 create mode 100755 tests/functional/test_x86_64_replay.py

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index dffced62aa2..35515323723 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -108,38 +108,3 @@ def test_i386_pc(self):
         console_pattern = 'VFS: Cannot open root device'
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
-
-    # See https://gitlab.com/qemu-project/qemu/-/issues/2094
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'pc machine is unstable with replay')
-    def test_x86_64_pc(self):
-        """
-        :avocado: tags=arch:x86_64
-        :avocado: tags=machine:pc
-        :avocado: tags=flaky
-        """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
-                      '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
-                      '/vmlinuz')
-        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        console_pattern = 'VFS: Cannot open root device'
-
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
-
-    def test_x86_64_q35(self):
-        """
-        :avocado: tags=arch:x86_64
-        :avocado: tags=machine:q35
-        """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
-                      '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
-                      '/vmlinuz')
-        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        console_pattern = 'VFS: Cannot open root device'
-
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 85abac6b93d..3054aa18570 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -48,6 +48,7 @@ test_timeouts = {
   's390x_ccw_virtio' : 420,
   'sh4_tuxrun' : 240,
   'x86_64_kvm_xen' : 180,
+  'x86_64_replay' : 480,
 }
 
 tests_generic_system = [
@@ -302,6 +303,7 @@ tests_x86_64_system_thorough = [
   'x86_64_hotplug_blk',
   'x86_64_hotplug_cpu',
   'x86_64_kvm_xen',
+  'x86_64_replay',
   'x86_64_reverse_debugging',
   'x86_64_tuxrun',
 ]
diff --git a/tests/functional/test_x86_64_replay.py b/tests/functional/test_x86_64_replay.py
new file mode 100755
index 00000000000..180f23a60c5
--- /dev/null
+++ b/tests/functional/test_x86_64_replay.py
@@ -0,0 +1,35 @@
+#!/usr/bin/env python3
+#
+# Replay test that boots a Linux kernel on x86_64 machines
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset, skipFlakyTest
+from replay_kernel import ReplayKernelBase
+
+
+class X86Replay(ReplayKernelBase):
+
+    ASSET_KERNEL = Asset(
+         ('https://archives.fedoraproject.org/pub/archive/fedora/linux'
+          '/releases/29/Everything/x86_64/os/images/pxeboot/vmlinuz'),
+        '8f237d84712b1b411baf3af2aeaaee10b9aae8e345ec265b87ab3a39639eb143')
+
+    def do_test_x86(self, machine):
+        self.set_machine(machine)
+        kernel_path = self.ASSET_KERNEL.fetch()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        console_pattern = 'VFS: Cannot open root device'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
+
+    @skipFlakyTest('https://gitlab.com/qemu-project/qemu/-/issues/2094')
+    def test_pc(self):
+        self.do_test_x86('pc')
+
+    def test_q35(self):
+        self.do_test_x86('q35')
+
+
+if __name__ == '__main__':
+    ReplayKernelBase.main()
-- 
2.48.1


