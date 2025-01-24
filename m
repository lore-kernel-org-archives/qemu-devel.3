Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2511C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 14:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbKUK-0003HI-Ep; Fri, 24 Jan 2025 09:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tbKTu-00037j-KC
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:16:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tbKTs-0001JZ-Nq
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737728179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/MKy6zBPW7+skO3SCY3faTwqL/xcuuDQJyNlVi6k7zw=;
 b=fJLWtGhc7X29iXR2BE8cMzY5r1qwYmIjDGGN67jZ2Z9TmZ2ySAqnWDq/dHh6KhaDRgfgdn
 u/FXotTMA0jHnAcpym7svab5HYO+pZbWI/eLm37R8OLAFsKR/G+1SutzAVxHUWzXD6w4XL
 6lCF4p/GKECH0SMNH37Za136m12Rxoc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-UrRDnVyEMAu2EbElk5ZI7g-1; Fri,
 24 Jan 2025 09:15:59 -0500
X-MC-Unique: UrRDnVyEMAu2EbElk5ZI7g-1
X-Mimecast-MFC-AGG-ID: UrRDnVyEMAu2EbElk5ZI7g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 722201801F1C; Fri, 24 Jan 2025 14:15:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.187])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE42419560A7; Fri, 24 Jan 2025 14:15:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 4/5] tests/functional/test_mips64el_malta: Convert the
 mips64el replay tests
Date: Fri, 24 Jan 2025 15:15:28 +0100
Message-ID: <20250124141529.1626877-5-thuth@redhat.com>
In-Reply-To: <20250124141529.1626877-1-thuth@redhat.com>
References: <20250124141529.1626877-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_BTC_ID=0.498, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Move the mips64el replay tests from tests/avocado/replay_kernel.py to
the functional framework. Since the functional tests should be run per
target, we cannot stick all replay tests in one file. Thus let's add
these tests to the file where we already use the same asset already.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/replay_kernel.py          | 57 -------------------------
 tests/functional/test_mips64el_malta.py | 26 ++++++++++-
 2 files changed, 25 insertions(+), 58 deletions(-)

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 4f50f48163..a45881b9a6 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -162,33 +162,6 @@ def test_mips_malta(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
-    def test_mips64el_malta(self):
-        """
-        This test requires the ar tool to extract "data.tar.gz" from
-        the Debian package.
-
-        The kernel can be rebuilt using this Debian kernel source [1] and
-        following the instructions on [2].
-
-        [1] http://snapshot.debian.org/package/linux-2.6/2.6.32-48/
-            #linux-source-2.6.32_2.6.32-48
-        [2] https://kernel-team.pages.debian.net/kernel-handbook/
-            ch-common-tasks.html#s-common-official
-
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        """
-        deb_url = ('http://snapshot.debian.org/archive/debian/'
-                   '20130217T032700Z/pool/main/l/linux-2.6/'
-                   'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb')
-        deb_hash = '1aaec92083bf22fda31e0d27fa8d9a388e5fc3d5'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-2.6.32-5-5kc-malta')
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
-
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
@@ -491,33 +464,3 @@ def test_mips_malta_cpio(self):
         console_pattern = 'Boot successful.'
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
                     args=('-initrd', initrd_path))
-
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
-    def test_mips64el_malta_5KEc_cpio(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        :avocado: tags=slowness:high
-        :avocado: tags=cpu:5KEc
-        """
-        kernel_url = ('https://github.com/philmd/qemu-testing-blob/'
-                      'raw/9ad2df38/mips/malta/mips64el/'
-                      'vmlinux-3.19.3.mtoman.20150408')
-        kernel_hash = '00d1d268fb9f7d8beda1de6bebcc46e884d71754'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        initrd_url = ('https://github.com/groeck/linux-build-test/'
-                      'raw/8584a59e/rootfs/'
-                      'mipsel64/rootfs.mipsel64r1.cpio.gz')
-        initrd_hash = '1dbb8a396e916847325284dbe2151167'
-        initrd_path_gz = self.fetch_asset(initrd_url, algorithm='md5',
-                                          asset_hash=initrd_hash)
-        initrd_path = self.workdir + "rootfs.cpio"
-        archive.gzip_uncompress(initrd_path_gz, initrd_path)
-
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyS0 console=tty '
-                               'rdinit=/sbin/init noreboot')
-        console_pattern = 'Boot successful.'
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
-                    args=('-initrd', initrd_path))
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index a8da15a26b..1eac62b452 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -15,9 +15,10 @@
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import skipIfMissingImports, skipFlakyTest, skipUntrustedTest
+from replay_kernel import ReplayKernelBase
 
 
-class MaltaMachineConsole(LinuxKernelTest):
+class MaltaMachineConsole(ReplayKernelBase):
 
     ASSET_KERNEL_2_63_2 = Asset(
         ('http://snapshot.debian.org/archive/debian/'
@@ -51,6 +52,15 @@ def test_mips64el_malta(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    def test_replay_mips64el_malta(self):
+        self.set_machine('malta')
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_2_63_2,
+                                    member='boot/vmlinux-2.6.32-5-5kc-malta')
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
+
+
     ASSET_KERNEL_3_19_3 = Asset(
         ('https://github.com/philmd/qemu-testing-blob/'
          'raw/9ad2df38/mips/malta/mips64el/'
@@ -90,6 +100,20 @@ def test_mips64el_malta_5KEc_cpio(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
+    @skipUntrustedTest()
+    def test_replay_mips64el_malta_5KEc_cpio(self):
+        self.set_machine('malta')
+        self.cpu = '5KEc'
+        kernel_path = self.ASSET_KERNEL_3_19_3.fetch()
+        initrd_path = self.uncompress(self.ASSET_CPIO_R1)
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0 console=tty '
+                               'rdinit=/sbin/init noreboot')
+        console_pattern = 'Boot successful.'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
+                    args=('-initrd', initrd_path))
+
 
 @skipIfMissingImports('numpy', 'cv2')
 class MaltaMachineFramebuffer(LinuxKernelTest):
-- 
2.48.1


