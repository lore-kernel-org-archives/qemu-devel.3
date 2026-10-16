Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968CFCCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHczY-0003qt-Og; Fri, 16 Oct 2026 04:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xHczI-0003oH-EA; Fri, 16 Oct 2026 04:08:26 -0400
Received: from mailsender.cdac.in ([196.1.113.117]
 helo=mailsender-core1.pune.cdac.in)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xHczE-0005x9-Sf; Fri, 16 Oct 2026 04:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cdac.in; s=default;
 t=1792138088; bh=8fyoY2xY8ynDtIuX0ixrw2Ej49Klu1ZQgQ2zy0isoH8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W+4ngDsTfUqGEzIRM9d4hI5vsASaZbxpU8XzbExN46jEQ3ZLB91fcCEPLZe5145ZA
 CGt8fJarAkJRhTv0oaFHDWqTyJlQLz7V41kE4YITBII50S0qwvHgT3KCWTkv7uoGp1
 dT+FV45xok/1y2VvaVXP4QQGg9t2GtUxIaj5MvuA=
Received: from mscr-int.pune.cdac.in (mscr-int.pune.cdac.in [10.208.193.2])
 by mailsender.cdac.in (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69G887Qr3825284; Fri, 16 Oct 2026 13:38:07 +0530
Received: from mailgw-cip.pune.cdac.in (mscr-haproxy.pune.cdac.in
 [10.208.193.46])
 by mscr-int.pune.cdac.in (Postfix) with ESMTP id EEB9C1000722E;
 Fri, 16 Oct 2026 13:37:56 +0530 (IST)
X-Auth: karthika.b@cdac.in
Received: from hdg164.tvm.cdac.in (hd_hdg164.tvm.cdac.in [10.176.18.107])
 (Authenticated sender: karthika.b@cdac.in)
 by mailgw-cip.pune.cdac.in (Postfix) with ESMTPSA id 9404F14E17D2;
 Fri, 16 Oct 2026 13:37:56 +0530 (IST)
From: Karthika B <karthika.b@cdac.in>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, sreenadh@cdac.in, raokk@cdac.in,
 Karthika B <karthika.b@cdac.in>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH 6/7] tests/functional: Add VEGA machine functional tests
Date: Fri, 16 Oct 2026 13:37:06 +0530
Message-ID: <20261016080709.17331-7-karthika.b@cdac.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016080709.17331-1-karthika.b@cdac.in>
References: <385625713.441366.1761727810206@webmail2.cdac.in>
 <20261016080709.17331-1-karthika.b@cdac.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CDAC-PUNE-MailScanner-Information: Please contact the ISP for more
 information
X-CDAC-PUNE-MailScanner-ID: EEB9C1000722E.A070C
X-CDAC-PUNE-MailScanner: Found to be clean
X-CDAC-PUNE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-2.899, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
 BAYES_00 -1.90, URIBL_BLOCKED 0.00)
X-CDAC-PUNE-MailScanner-From: karthika.b@cdac.in
Received-SPF: pass client-ip=196.1.113.117; envelope-from=karthika.b@cdac.in;
 helo=mailsender-core1.pune.cdac.in
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Karthika B <karthika.b@cdac.in>
---
 tests/functional/riscv32/meson.build  |  1 +
 tests/functional/riscv32/test_vega.py | 32 ++++++++++++++
 tests/functional/riscv64/meson.build  |  1 +
 tests/functional/riscv64/test_vega.py | 63 +++++++++++++++++++++++++++
 4 files changed, 97 insertions(+)
 create mode 100644 tests/functional/riscv32/test_vega.py
 create mode 100644 tests/functional/riscv64/test_vega.py

diff --git a/tests/functional/riscv32/meson.build b/tests/functional/riscv32/meson.build
index f3ebbb8db5..b02c26c186 100644
--- a/tests/functional/riscv32/meson.build
+++ b/tests/functional/riscv32/meson.build
@@ -7,4 +7,5 @@ tests_riscv32_system_quick = [
 
 tests_riscv32_system_thorough = [
   'tuxrun',
+  'vega',
 ]
diff --git a/tests/functional/riscv32/test_vega.py b/tests/functional/riscv32/test_vega.py
new file mode 100644
index 0000000000..932819501c
--- /dev/null
+++ b/tests/functional/riscv32/test_vega.py
@@ -0,0 +1,32 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a bare-metal hello-world program on the
+# VEGA machine (RV32, Thejas32) and checks the console output.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset, QemuSystemTest
+from qemu_test.cmd import wait_for_console_pattern
+
+
+class Vega(QemuSystemTest):
+
+    ASSET_HELLO32 = Asset(
+        'https://gitlab.com/riscv-vega/vega_qemu_test_images/-/raw/v1.0/baremetal/hello32.elf',
+        '77d3449a495b78ff4d7aa93024682d3e8efa10e64a82c6c0029144ddd3b4c638')
+
+    def test_riscv32_vega_hello(self):
+        self.set_machine('vega')
+        hello_path = self.ASSET_HELLO32.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-bios', hello_path,
+                         '-M', 'vega,dram-base=0x20000',
+                         '-no-reboot')
+
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Hello World')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index b996c89d7d..932447144d 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -14,4 +14,5 @@ tests_riscv64_system_thorough = [
   'boston',
   'sifive_u',
   'tuxrun',
+  'vega',
 ]
diff --git a/tests/functional/riscv64/test_vega.py b/tests/functional/riscv64/test_vega.py
new file mode 100644
index 0000000000..b71daa7bbb
--- /dev/null
+++ b/tests/functional/riscv64/test_vega.py
@@ -0,0 +1,63 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots bare-metal and Linux payloads on the
+# VEGA machine (RV64, Thejas64) and checks the console output.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset, LinuxKernelTest, QemuSystemTest
+from qemu_test.cmd import wait_for_console_pattern
+
+
+class VegaBaremetal(QemuSystemTest):
+
+    ASSET_HELLO64 = Asset(
+        'https://gitlab.com/riscv-vega/vega_qemu_test_images/-/raw/v1.0/baremetal/hello64.elf',
+        'cd2f3b04d8d6cd0ee75e3eeef58988cc02ed783f6f5b3b1d3a95195441fc7f1d')
+
+    def test_riscv64_vega_hello(self):
+        self.set_machine('vega')
+        hello_path = self.ASSET_HELLO64.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-bios', hello_path,
+                         '-M', 'vega,dram-base=0x20000',
+                         '-no-reboot')
+
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Hello World')
+
+
+class VegaLinux(LinuxKernelTest):
+
+    ASSET_BBL = Asset(
+        'https://gitlab.com/riscv-vega/vega_qemu_test_images/-/raw/v1.0/linux/bbl',
+        '018fa3e96ec715d4c915c3a85212da6c300c412e56c6c73a16f965526ca8d858')
+    ASSET_DTB = Asset(
+        'https://gitlab.com/riscv-vega/vega_qemu_test_images/-/raw/v1.0/linux/vega.dtb',
+        '0b8261051c88e690d6508cb1c774fd3cab97d50570ff668fdfabd0bf52c52414')
+    ASSET_ROOTFS = Asset(
+        'https://gitlab.com/riscv-vega/vega_qemu_test_images/-/raw/v1.0/linux/rootfs.cpio',
+        '389a5b9883b14c2a5614ece120abc4ee60543d1110a03a9de35d80405e18c063')
+
+    def test_riscv64_vega_linux(self):
+        self.set_machine('vega')
+        bbl_path = self.ASSET_BBL.fetch()
+        dtb_path = self.ASSET_DTB.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-M', 'vega,dram-base=0x400000000',
+                         '-m', '2G',
+                         '-bios', 'none',
+                         '-kernel', bbl_path,
+                         '-dtb', dtb_path,
+                         '-initrd', rootfs_path,
+                         '-no-reboot')
+
+        self.vm.launch()
+        self.wait_for_console_pattern('cdac login:')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
------------------------------------------------------------------------------------------------------------


