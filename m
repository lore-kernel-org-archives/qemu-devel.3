Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248B3C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 14:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbKTe-00032x-Ql; Fri, 24 Jan 2025 09:16:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tbKTW-0002xj-Hp
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:15:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tbKTT-0001F6-Qf
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737728153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=361Mg28r39AijLyNBmfEKQDx1yUbtYDrPhh7YomrG6M=;
 b=JCzRpxGsWss4JHzjBzBqa7anq1omIH8QQwbnrbXgqMb001Ug4TbfBUtRboDPGSzuD65byf
 bpIUTY5w/jO1yEVWnttaH7y6p8Qyu1memODgj7YY0lAhNR5I/GgkaAvWUUwkTigDHSMRGZ
 AC2nu3uHPDhOV0MBOaSRkYC8EjWwHsg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-wYvAqBc2OBGaIMxjCZzB3g-1; Fri,
 24 Jan 2025 09:15:50 -0500
X-MC-Unique: wYvAqBc2OBGaIMxjCZzB3g-1
X-Mimecast-MFC-AGG-ID: wYvAqBc2OBGaIMxjCZzB3g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A43419560B7; Fri, 24 Jan 2025 14:15:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.187])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F89219560B2; Fri, 24 Jan 2025 14:15:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/5] tests/functional/test_mipsel_malta: Convert the mipsel
 replay tests
Date: Fri, 24 Jan 2025 15:15:27 +0100
Message-ID: <20250124141529.1626877-4-thuth@redhat.com>
In-Reply-To: <20250124141529.1626877-1-thuth@redhat.com>
References: <20250124141529.1626877-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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
these tests to the file where we already use the same asset already.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/replay_kernel.py        | 54 ---------------------------
 tests/functional/meson.build          |  1 +
 tests/functional/test_mipsel_malta.py | 30 +++++++++++++--
 3 files changed, 28 insertions(+), 57 deletions(-)

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index e22c200a36..4f50f48163 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -521,57 +521,3 @@ def test_mips64el_malta_5KEc_cpio(self):
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
index b7719ab85f..7d233213c1 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -35,6 +35,7 @@ test_timeouts = {
   'arm_sx1' : 360,
   'intel_iommu': 300,
   'mips_malta' : 120,
+  'mipsel_malta' : 500,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
   'ppc64_hv' : 1000,
diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/test_mipsel_malta.py
index fe9c3a172e..fff42c7f4f 100755
--- a/tests/functional/test_mipsel_malta.py
+++ b/tests/functional/test_mipsel_malta.py
@@ -9,12 +9,13 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import QemuSystemTest, LinuxKernelTest, Asset
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 from qemu_test import interrupt_interactive_console_until_pattern
-from qemu_test import wait_for_console_pattern
+from qemu_test import skipLongRuntime
+from replay_kernel import ReplayKernelBase
 
 
-class MaltaMachineConsole(LinuxKernelTest):
+class MaltaMachineConsole(ReplayKernelBase):
 
     ASSET_KERNEL_4K = Asset(
         ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
@@ -57,6 +58,29 @@ def test_mips_malta32el_nanomips_16k_up(self):
     def test_mips_malta32el_nanomips_64k_dbg(self):
         self.do_test_mips_malta32el_nanomips(self.ASSET_KERNEL_64K)
 
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
+    @skipLongRuntime()
+    def test_replay_mips_malta32el_nanomips_4k(self):
+        self.do_test_replay_mips_malta32el_nanomips(self.ASSET_KERNEL_4K)
+
+    @skipLongRuntime()
+    def test_replay_mips_malta32el_nanomips_16k_up(self):
+        self.do_test_replay_mips_malta32el_nanomips(self.ASSET_KERNEL_16K)
+
+    @skipLongRuntime()
+    def test_replay_mips_malta32el_nanomips_64k_dbg(self):
+        self.do_test_replay_mips_malta32el_nanomips(self.ASSET_KERNEL_64K)
+
 
 class MaltaMachineYAMON(QemuSystemTest):
 
-- 
2.48.1


