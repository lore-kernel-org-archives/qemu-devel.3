Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787EFD1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhnA-0000NS-9T; Wed, 03 Dec 2025 03:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhmn-00005P-JX; Wed, 03 Dec 2025 03:00:30 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhml-0006qG-Ff; Wed, 03 Dec 2025 03:00:29 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B36F517076A;
 Wed, 03 Dec 2025 10:59:22 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 80A0D32B491;
 Wed, 03 Dec 2025 10:59:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 093/116] tests/functional: Use the tuxrun kernel for
 the x86 replay test
Date: Wed,  3 Dec 2025 10:59:13 +0300
Message-ID: <20251203075939.2366131-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Thomas Huth <thuth@redhat.com>

This way we can do a full boot in record-replay mode and
should get a similar test coverage compared to the old
replay test from tests/avocado/replay_linux.py. Thus remove
the x86 avocado replay_linux test now.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250414113031.151105-12-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 7fecdb0acd99fa838bb461c67164f6119ec1a3bb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index 5916922435..6ba283d3bf 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -118,52 +118,6 @@ def run_replay_dump(self, replay_path):
         except subprocess.CalledProcessError:
             self.fail('replay-dump.py failed')
 
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-class ReplayLinuxX8664(ReplayLinux):
-    """
-    :avocado: tags=arch:x86_64
-    :avocado: tags=accel:tcg
-    """
-
-    chksum = 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0'
-
-    def test_pc_i440fx(self):
-        """
-        :avocado: tags=machine:pc
-        """
-        self.run_rr(shift=1)
-
-    def test_pc_q35(self):
-        """
-        :avocado: tags=machine:q35
-        """
-        self.run_rr(shift=3)
-
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-class ReplayLinuxX8664Virtio(ReplayLinux):
-    """
-    :avocado: tags=arch:x86_64
-    :avocado: tags=virtio
-    :avocado: tags=accel:tcg
-    """
-
-    hdd = 'virtio-blk-pci'
-    cd = 'virtio-blk-pci'
-    bus = None
-
-    chksum = 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0'
-
-    def test_pc_i440fx(self):
-        """
-        :avocado: tags=machine:pc
-        """
-        self.run_rr(shift=1)
-
-    def test_pc_q35(self):
-        """
-        :avocado: tags=machine:q35
-        """
-        self.run_rr(shift=3)
 
 @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
 class ReplayLinuxAarch64(ReplayLinux):
diff --git a/tests/functional/test_x86_64_replay.py b/tests/functional/test_x86_64_replay.py
index 180f23a60c..27287d452d 100755
--- a/tests/functional/test_x86_64_replay.py
+++ b/tests/functional/test_x86_64_replay.py
@@ -5,30 +5,53 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset, skipFlakyTest
+from subprocess import check_call, DEVNULL
+
+from qemu_test import Asset, skipFlakyTest, get_qemu_img
 from replay_kernel import ReplayKernelBase
 
 
 class X86Replay(ReplayKernelBase):
 
     ASSET_KERNEL = Asset(
-         ('https://archives.fedoraproject.org/pub/archive/fedora/linux'
-          '/releases/29/Everything/x86_64/os/images/pxeboot/vmlinuz'),
-        '8f237d84712b1b411baf3af2aeaaee10b9aae8e345ec265b87ab3a39639eb143')
+        'https://storage.tuxboot.com/buildroot/20241119/x86_64/bzImage',
+        'f57bfc6553bcd6e0a54aab86095bf642b33b5571d14e3af1731b18c87ed5aef8')
+
+    ASSET_ROOTFS = Asset(
+        'https://storage.tuxboot.com/buildroot/20241119/x86_64/rootfs.ext4.zst',
+        '4b8b2a99117519c5290e1202cb36eb6c7aaba92b357b5160f5970cf5fb78a751')
 
-    def do_test_x86(self, machine):
+    def do_test_x86(self, machine, blkdevice, devroot):
+        self.require_netdev('user')
         self.set_machine(machine)
+        self.cpu="Nehalem"
         kernel_path = self.ASSET_KERNEL.fetch()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        console_pattern = 'VFS: Cannot open root device'
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
+
+        raw_disk = self.uncompress(self.ASSET_ROOTFS)
+        disk = self.scratch_file('scratch.qcow2')
+        qemu_img = get_qemu_img(self)
+        check_call([qemu_img, 'create', '-f', 'qcow2', '-b', raw_disk,
+                    '-F', 'raw', disk], stdout=DEVNULL, stderr=DEVNULL)
+
+        args = ('-drive', 'file=%s,snapshot=on,id=hd0,if=none' % disk,
+                '-drive', 'driver=blkreplay,id=hd0-rr,if=none,image=hd0',
+                '-device', '%s,drive=hd0-rr' % blkdevice,
+                '-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
+                '-device', 'virtio-net,netdev=vnet',
+                '-object', 'filter-replay,id=replay,netdev=vnet')
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               f"console=ttyS0 root=/dev/{devroot}")
+        console_pattern = 'Welcome to TuxTest'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
+                    args=args)
 
     @skipFlakyTest('https://gitlab.com/qemu-project/qemu/-/issues/2094')
     def test_pc(self):
-        self.do_test_x86('pc')
+        self.do_test_x86('pc', 'virtio-blk', 'vda')
 
     def test_q35(self):
-        self.do_test_x86('q35')
+        self.do_test_x86('q35', 'ide-hd', 'sda')
 
 
 if __name__ == '__main__':
-- 
2.47.3


