Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B06ED116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhmK-0008Kw-RG; Wed, 03 Dec 2025 03:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhmJ-0008KO-16; Wed, 03 Dec 2025 02:59:59 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhmG-0006fZ-Pq; Wed, 03 Dec 2025 02:59:58 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5DB1E170765;
 Wed, 03 Dec 2025 10:59:22 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2AEDE32B48C;
 Wed, 03 Dec 2025 10:59:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 088/116] tests/functional: Convert the 32-bit big
 endian Wheezy mips test
Date: Wed,  3 Dec 2025 10:59:08 +0300
Message-ID: <20251203075939.2366131-7-mjt@tls.msk.ru>
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

The test checks some entries in /proc and the output of some commands ...
we put these checks into exportable functions now so that they can
be reused more easily.

Additionally the linux_ssh_mips_malta.py uses SSH to test the networking
of the guest. Since we don't have a SSH module in the functional
framework yet, let's use the check_http_download() function here instead.

And while we're at it, also switch the NIC to e1000 now to get some more
test coverage, since the "pcnet" device is already tested in the test
test_mips_malta_cpio.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250414113031.151105-7-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 42a87f0ce7aaf1923a610cabe4d65f7b1ce9a327)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/avocado/linux_ssh_mips_malta.py b/tests/avocado/linux_ssh_mips_malta.py
index d9bb525ad9..73d294ad5c 100644
--- a/tests/avocado/linux_ssh_mips_malta.py
+++ b/tests/avocado/linux_ssh_mips_malta.py
@@ -172,14 +172,6 @@ def check_mips_malta(self, uname_m, endianess):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
-    def test_mips_malta32eb_kernel3_2_0(self):
-        """
-        :avocado: tags=arch:mips
-        :avocado: tags=endian:big
-        :avocado: tags=device:pcnet32
-        """
-        self.check_mips_malta('mips', 'be')
-
     def test_mips_malta32el_kernel3_2_0(self):
         """
         :avocado: tags=arch:mipsel
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 4113b221de..4dedfc7b9f 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -39,7 +39,7 @@ test_timeouts = {
   'arm_tuxrun' : 240,
   'arm_sx1' : 360,
   'intel_iommu': 300,
-  'mips_malta' : 120,
+  'mips_malta' : 480,
   'mipsel_replay' : 480,
   'mips64el_replay' : 180,
   'netdev_ethtool' : 180,
diff --git a/tests/functional/test_mips_malta.py b/tests/functional/test_mips_malta.py
index 9697c7d63f..89b9556f30 100755
--- a/tests/functional/test_mips_malta.py
+++ b/tests/functional/test_mips_malta.py
@@ -6,10 +6,93 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import LinuxKernelTest, Asset
+import os
+
+from qemu_test import LinuxKernelTest, Asset, wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern
 
 
+def mips_run_common_commands(test, prompt='#'):
+    exec_command_and_wait_for_pattern(test,
+        'uname -m',
+        'mips')
+    exec_command_and_wait_for_pattern(test,
+        'grep XT-PIC /proc/interrupts',
+        'timer')
+    wait_for_console_pattern(test, prompt)
+    exec_command_and_wait_for_pattern(test,
+        'grep XT-PIC /proc/interrupts',
+        'serial')
+    wait_for_console_pattern(test, prompt)
+    exec_command_and_wait_for_pattern(test,
+        'grep XT-PIC /proc/interrupts',
+        'ata_piix')
+    wait_for_console_pattern(test, prompt)
+    exec_command_and_wait_for_pattern(test,
+        'grep XT-PIC /proc/interrupts',
+        'rtc')
+    wait_for_console_pattern(test, prompt)
+    exec_command_and_wait_for_pattern(test,
+        'cat /proc/devices',
+        'input')
+    wait_for_console_pattern(test, prompt)
+    exec_command_and_wait_for_pattern(test,
+        'cat /proc/devices',
+        'fb')
+    wait_for_console_pattern(test, prompt)
+    exec_command_and_wait_for_pattern(test,
+        'cat /proc/ioports',
+        ' : serial')
+    wait_for_console_pattern(test, prompt)
+    exec_command_and_wait_for_pattern(test,
+        'cat /proc/ioports',
+        ' : ata_piix')
+    wait_for_console_pattern(test, prompt)
+
+def mips_check_wheezy(test, kernel_path, image_path, kernel_command_line,
+                      dl_file, hsum, nic='pcnet', cpuinfo='MIPS 24Kc'):
+    test.require_netdev('user')
+    test.require_device(nic)
+    test.set_machine('malta')
+
+    port=8080
+    test.vm.add_args('-kernel', kernel_path,
+                     '-append', kernel_command_line,
+                     '-drive', 'file=%s,snapshot=on' % image_path,
+                     '-netdev', 'user,id=n1' +
+                                ',tftp=' + os.path.basename(kernel_path) +
+                                ',hostfwd=tcp:127.0.0.1:0-:%d' % port,
+                     '-device', f'{nic},netdev=n1',
+                     '-no-reboot')
+    test.vm.set_console()
+    test.vm.launch()
+
+    wait_for_console_pattern(test, 'login: ', 'Oops')
+    exec_command_and_wait_for_pattern(test, 'root', 'Password:')
+    exec_command_and_wait_for_pattern(test, 'root', ':~# ')
+    mips_run_common_commands(test)
+
+    exec_command_and_wait_for_pattern(test, 'cd /', '# ')
+    test.check_http_download(dl_file, hsum, port,
+                             pythoncmd='python -m SimpleHTTPServer')
+
+    exec_command_and_wait_for_pattern(test, 'cat /proc/cpuinfo', cpuinfo)
+    exec_command_and_wait_for_pattern(test, 'cat /proc/devices', 'usb')
+    exec_command_and_wait_for_pattern(test, 'cat /proc/ioports',
+                                      ' : piix4_smbus')
+    # lspci for the host bridge does not work on big endian targets:
+    # https://gitlab.com/qemu-project/qemu/-/issues/2826
+    # exec_command_and_wait_for_pattern(test, 'lspci -d 11ab:4620',
+    #                                   'GT-64120')
+    exec_command_and_wait_for_pattern(test,
+                                      'cat /sys/bus/i2c/devices/i2c-0/name',
+                                      'SMBus PIIX4 adapter')
+    exec_command_and_wait_for_pattern(test, 'cat /proc/mtd', 'YAMON')
+    # Empty 'Board Config' (64KB)
+    exec_command_and_wait_for_pattern(test, 'md5sum /dev/mtd2ro',
+                                      '0dfbe8aa4c20b52e1b8bf3cb6cbdf193')
+
+
 class MaltaMachineConsole(LinuxKernelTest):
 
     ASSET_KERNEL_2_63_2 = Asset(
@@ -70,7 +153,8 @@ def test_mips_malta_cpio(self):
         exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
                                                 'BogoMIPS')
         exec_command_and_wait_for_pattern(self, 'uname -a',
-                                                'Debian')
+                                                '4.5.0-2-4kc-malta #1 Debian')
+        mips_run_common_commands(self)
 
         exec_command_and_wait_for_pattern(self, 'ip link set eth0 up',
                                           'eth0: link up')
@@ -89,6 +173,26 @@ def test_mips_malta_cpio(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
+    ASSET_WHEEZY_KERNEL = Asset(
+        ('https://people.debian.org/~aurel32/qemu/mips/'
+         'vmlinux-3.2.0-4-4kc-malta'),
+        '0377fcda31299213c10b8e5babe7260ef99188b3ae1aca6f56594abb71e7f67e')
+
+    ASSET_WHEEZY_DISK = Asset(
+        ('https://people.debian.org/~aurel32/qemu/mips/'
+         'debian_wheezy_mips_standard.qcow2'),
+        'de03599285b8382ad309309a6c4869f6c6c42a5cfc983342bab9ec0dfa7849a2')
+
+    def test_wheezy(self):
+        kernel_path = self.ASSET_WHEEZY_KERNEL.fetch()
+        image_path = self.ASSET_WHEEZY_DISK.fetch()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 root=/dev/sda1')
+        mips_check_wheezy(self,
+            kernel_path, image_path, kernel_command_line, nic='e1000',
+            dl_file='/boot/initrd.img-3.2.0-4-4kc-malta',
+            hsum='ff0c0369143d9bbb9a6e6bc79322a2be535619df639e84103237f406e87493dc')
+
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.47.3


