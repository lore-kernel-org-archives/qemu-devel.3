Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36928C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 15:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcnWd-0002LN-4S; Tue, 28 Jan 2025 10:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcnWb-0002L0-HD
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:29:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcnWX-0004un-G1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738078148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mTKTMbDk6kHJtA38LwvWbX0MIAdc2zfUhplDP6S50Lo=;
 b=BV0wjr7HL2f95wChH0LkQfRXAsHqqrg+xlRBWkLMFoRtSrxQNv4yXABYob5ugTkSB86IZn
 3N8VNdFLjP184SM51U78sfTa6rybY1svHo5fq4LzXBkRkGCyhk8H3BPVskDsqWjpc52zno
 GlJ/TbN71JYItZvUgAlnNuZ4yI+Y4PI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-6-VVaAV0PtymSmCCXBguAg-1; Tue,
 28 Jan 2025 10:29:05 -0500
X-MC-Unique: 6-VVaAV0PtymSmCCXBguAg-1
X-Mimecast-MFC-AGG-ID: 6-VVaAV0PtymSmCCXBguAg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8F3E180188D; Tue, 28 Jan 2025 15:29:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 507AC1800348; Tue, 28 Jan 2025 15:28:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 3/5] tests/functional/test_mipsel_malta: Convert the mipsel
 replay tests
Date: Tue, 28 Jan 2025 16:28:37 +0100
Message-ID: <20250128152839.184599-4-thuth@redhat.com>
In-Reply-To: <20250128152839.184599-1-thuth@redhat.com>
References: <20250128152839.184599-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Move the mipsel replay tests from tests/avocado/replay_kernel.py to
the functional framework. Since the functional tests should be run per
target, we cannot stick all replay tests in one file. Thus let's add
these tests to a new, separate file there instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/replay_kernel.py         | 54 --------------------------
 tests/functional/meson.build           |  2 +
 tests/functional/test_mipsel_replay.py | 54 ++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 54 deletions(-)
 create mode 100644 tests/functional/test_mipsel_replay.py

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index eae553f20e..9a3f175129 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -505,57 +505,3 @@ def test_mips64el_malta_5KEc_cpio(self):
         console_pattern = 'Boot successful.'
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
                     args=('-initrd', initrd_path))
-
-    def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
-        kernel_path = self.workdir + "kernel"
-        with lzma.open(kernel_path_xz, 'rb') as f_in:
-            with open(kernel_path, 'wb') as f_out:
-                shutil.copyfileobj(f_in, f_out)
-
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'mem=256m@@0x0 '
-                               'console=ttyS0')
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
-
-    def test_mips_malta32el_nanomips_4k(self):
-        """
-        :avocado: tags=arch:mipsel
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        :avocado: tags=cpu:I7200
-        """
-        kernel_url = ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
-                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
-                      'generic_nano32r6el_page4k.xz')
-        kernel_hash = '477456aafd2a0f1ddc9482727f20fe9575565dd6'
-        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
-
-    def test_mips_malta32el_nanomips_16k_up(self):
-        """
-        :avocado: tags=arch:mipsel
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        :avocado: tags=cpu:I7200
-        """
-        kernel_url = ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
-                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
-                      'generic_nano32r6el_page16k_up.xz')
-        kernel_hash = 'e882868f944c71c816e832e2303b7874d044a7bc'
-        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
-
-    def test_mips_malta32el_nanomips_64k_dbg(self):
-        """
-        :avocado: tags=arch:mipsel
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        :avocado: tags=cpu:I7200
-        """
-        kernel_url = ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
-                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
-                      'generic_nano32r6el_page64k_dbg.xz')
-        kernel_hash = '18d1c68f2e23429e266ca39ba5349ccd0aeb7180'
-        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 2b2d8953aa..13de54a1a8 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -35,6 +35,7 @@ test_timeouts = {
   'arm_sx1' : 360,
   'intel_iommu': 300,
   'mips_malta' : 120,
+  'mipsel_replay' : 480,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
   'ppc64_hv' : 1000,
@@ -161,6 +162,7 @@ tests_mips_system_thorough = [
 
 tests_mipsel_system_thorough = [
   'mipsel_malta',
+  'mipsel_replay',
   'mipsel_tuxrun',
 ]
 
diff --git a/tests/functional/test_mipsel_replay.py b/tests/functional/test_mipsel_replay.py
new file mode 100644
index 0000000000..0a330de43f
--- /dev/null
+++ b/tests/functional/test_mipsel_replay.py
@@ -0,0 +1,54 @@
+#!/usr/bin/env python3
+#
+# Replay tests for the little-endian 32-bit MIPS Malta board
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset, wait_for_console_pattern, skipSlowTest
+from replay_kernel import ReplayKernelBase
+
+
+class MipselReplay(ReplayKernelBase):
+
+    ASSET_KERNEL_4K = Asset(
+        ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
+         'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
+         'generic_nano32r6el_page4k.xz'),
+        '019e034094ac6cf3aa77df5e130fb023ce4dbc804b04bfcc560c6403e1ae6bdb')
+    ASSET_KERNEL_16K = Asset(
+        ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
+         'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
+         'generic_nano32r6el_page16k_up.xz'),
+        '3a54a10b3108c16a448dca9ea3db378733a27423befc2a45a5bdf990bd85e12c')
+    ASSET_KERNEL_64K = Asset(
+        ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
+         'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
+         'generic_nano32r6el_page64k_dbg.xz'),
+        'ce21ff4b07a981ecb8a39db2876616f5a2473eb2ab459c6f67465b9914b0c6b6')
+
+    def do_test_replay_mips_malta32el_nanomips(self, kernel_asset):
+        self.set_machine('malta')
+        self.cpu = 'I7200'
+        kernel_path = self.uncompress(kernel_asset)
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'mem=256m@@0x0 '
+                               'console=ttyS0')
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
+
+    @skipSlowTest()
+    def test_replay_mips_malta32el_nanomips_4k(self):
+        self.do_test_replay_mips_malta32el_nanomips(self.ASSET_KERNEL_4K)
+
+    @skipSlowTest()
+    def test_replay_mips_malta32el_nanomips_16k_up(self):
+        self.do_test_replay_mips_malta32el_nanomips(self.ASSET_KERNEL_16K)
+
+    @skipSlowTest()
+    def test_replay_mips_malta32el_nanomips_64k_dbg(self):
+        self.do_test_replay_mips_malta32el_nanomips(self.ASSET_KERNEL_64K)
+
+
+if __name__ == '__main__':
+    ReplayKernelBase.main()
-- 
2.48.1


