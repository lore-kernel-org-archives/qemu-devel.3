Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0625BC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPWx-00005g-Q2; Tue, 18 Feb 2025 10:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPWK-00084d-Fi
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPWH-0008Ad-2h
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739892497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QOB/6AkfGcNXLVdMjutsg1iZQdwIO8zRaHjb2AJm3FQ=;
 b=FtafTdr8ApfIaL3W42jQtYHnSx1MlHcGD9SKgtX62tS21HmFRZ18KayPx1aW6PpyC/I60o
 GMq3AwhyVwiUBsgnikC4yQZo1wQfxySX1eDZXDNQ+IkYMGGZdKY8aQXVHXRtW0L2vBEmRo
 F/PzsmGyH/D2wNJ4l75M39aMNVAwUTQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-YdqyhELzPtCYvwP5Wb9dyg-1; Tue,
 18 Feb 2025 10:28:16 -0500
X-MC-Unique: YdqyhELzPtCYvwP5Wb9dyg-1
X-Mimecast-MFC-AGG-ID: YdqyhELzPtCYvwP5Wb9dyg_1739892495
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F9C6190F9C8; Tue, 18 Feb 2025 15:28:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F22C51800361; Tue, 18 Feb 2025 15:28:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/14] tests/functional: Convert the arm replay avocado tests
Date: Tue, 18 Feb 2025 16:27:39 +0100
Message-ID: <20250218152744.228335-10-thuth@redhat.com>
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
 tests/avocado/replay_kernel.py      | 74 -----------------------------
 tests/functional/meson.build        |  1 +
 tests/functional/test_arm_replay.py | 69 +++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 74 deletions(-)
 create mode 100755 tests/functional/test_arm_replay.py

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 4bd48878b7e..02bd868a429 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -162,54 +162,6 @@ def test_aarch64_virt(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern)
 
-    def test_arm_virt(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:virt
-        """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
-                      '/linux/releases/29/Everything/armhfp/os/images/pxeboot'
-                      '/vmlinuz')
-        kernel_hash = 'e9826d741b4fb04cadba8d4824d1ed3b7fb8b4d4'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyAMA0')
-        console_pattern = 'VFS: Cannot open root device'
-
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
-
-    def test_arm_cubieboard_initrd(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:cubieboard
-        """
-        deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
-        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
-        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
-                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
-                      'arm/rootfs-armv5.cpio.gz')
-        initrd_hash = '2b50f1873e113523967806f4da2afe385462ff9b'
-        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
-        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
-        archive.gzip_uncompress(initrd_path_gz, initrd_path)
-
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyS0,115200 '
-                               'usbcore.nousb '
-                               'panic=-1 noreboot')
-        console_pattern = 'Boot successful.'
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1,
-                    args=('-dtb', dtb_path,
-                          '-initrd', initrd_path,
-                          '-no-reboot'))
-
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
@@ -241,29 +193,3 @@ def test_alpha_clipper(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.run_rr(uncompressed_kernel, kernel_command_line, console_pattern, shift=9,
             args=('-nodefaults', ))
-
-    def do_test_advcal_2018(self, file_path, kernel_name, args=None):
-        archive.extract(file_path, self.workdir)
-
-        for entry in os.scandir(self.workdir):
-            if entry.name.startswith('day') and entry.is_dir():
-                kernel_path = os.path.join(entry.path, kernel_name)
-                break
-
-        kernel_command_line = ''
-        console_pattern = 'QEMU advent calendar'
-        self.run_rr(kernel_path, kernel_command_line, console_pattern,
-                    args=args)
-
-    def test_arm_vexpressa9(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:vexpress-a9
-        """
-        tar_hash = '32b7677ce8b6f1471fb0059865f451169934245b'
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day16.tar.xz')
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        dtb_path = self.workdir + '/day16/vexpress-v2p-ca9.dtb'
-        self.do_test_advcal_2018(file_path, 'winter.zImage',
-                                 args=('-dtb', dtb_path))
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 7af43dbdcfc..815aefc14cd 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -113,6 +113,7 @@ tests_arm_system_thorough = [
   'arm_orangepi',
   'arm_quanta_gsj',
   'arm_raspi2',
+  'arm_replay',
   'arm_smdkc210',
   'arm_sx1',
   'arm_vexpress',
diff --git a/tests/functional/test_arm_replay.py b/tests/functional/test_arm_replay.py
new file mode 100755
index 00000000000..e002e6a2647
--- /dev/null
+++ b/tests/functional/test_arm_replay.py
@@ -0,0 +1,69 @@
+#!/usr/bin/env python3
+#
+# Replay test that boots a Linux kernel on arm machines and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from replay_kernel import ReplayKernelBase
+
+
+class ArmReplay(ReplayKernelBase):
+
+    ASSET_VIRT = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
+         'releases/29/Everything/armhfp/os/images/pxeboot/vmlinuz'),
+        '18dd5f1a9a28bd539f9d047f7c0677211bae528e8712b40ca5a229a4ad8e2591')
+
+    def test_virt(self):
+        self.set_machine('virt')
+        kernel_path = self.ASSET_VIRT.fetch()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyAMA0')
+        console_pattern = 'VFS: Cannot open root device'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
+
+    ASSET_CUBIE_KERNEL = Asset(
+        ('https://apt.armbian.com/pool/main/l/linux-6.6.16/'
+         'linux-image-current-sunxi_24.2.1_armhf_'
+         '_6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb'),
+        '3d968c15b121ede871dce49d13ee7644d6f74b6b121b84c9a40f51b0c80d6d22')
+
+    ASSET_CUBIE_INITRD = Asset(
+        ('https://github.com/groeck/linux-build-test/raw/'
+         '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/arm/rootfs-armv5.cpio.gz'),
+        '334b8d256db67a3f2b3ad070aa08b5ade39624e0e7e35b02f4359a577bc8f39b')
+
+    def test_cubieboard(self):
+        self.set_machine('cubieboard')
+        kernel_path = self.archive_extract(self.ASSET_CUBIE_KERNEL,
+            member='boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = self.archive_extract(self.ASSET_CUBIE_KERNEL,
+            member='usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb')
+        initrd_path = self.uncompress(self.ASSET_CUBIE_INITRD)
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'usbcore.nousb '
+                               'panic=-1 noreboot')
+        console_pattern = 'Boot successful.'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1,
+                    args=('-dtb', dtb_path,
+                          '-initrd', initrd_path,
+                          '-no-reboot'))
+
+    ASSET_DAY16 = Asset(
+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day16.tar.xz',
+        '63311adb2d4c4e7a73214a86d29988add87266a909719c56acfadd026b4110a7')
+
+    def test_vexpressa9(self):
+        self.set_machine('vexpress-a9')
+        self.archive_extract(self.ASSET_DAY16)
+        kernel_path = self.scratch_file('day16', 'winter.zImage')
+        dtb_path = self.scratch_file('day16', 'vexpress-v2p-ca9.dtb')
+        self.run_rr(kernel_path, self.REPLAY_KERNEL_COMMAND_LINE,
+                    'QEMU advent calendar', args=('-dtb', dtb_path))
+
+
+if __name__ == '__main__':
+    ReplayKernelBase.main()
-- 
2.48.1


