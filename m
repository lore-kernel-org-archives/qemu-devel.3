Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5A7C54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 07:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJ5Tf-0005Ij-OI; Sun, 25 May 2025 03:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uJ5Td-0005ID-D7
 for qemu-devel@nongnu.org; Sun, 25 May 2025 03:08:57 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uJ5Tb-0008HO-BR
 for qemu-devel@nongnu.org; Sun, 25 May 2025 03:08:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:4195:0:640:137b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B2DE360DF8;
 Sun, 25 May 2025 10:08:53 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6b8:b081:7309::1:2])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 68MOog1FXOs0-RFKGp3Xu; Sun, 25 May 2025 10:08:52 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1748156933;
 bh=uKJzMszss7xvilZ1oDyVTg9m8N74JuEiqrv9BmQoVdo=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ptRWTXYVg2A/ddU/9X6wy17+2Qqd4z9gXVLqZjx2mS/tQwSmQMTfwZOApYWjb+OLD
 bRiZZkljfs2ELJmzZ/+Rgd3IbCW3qRl+3PA7uKJv2N1XeOGMHCHcHGfyGvz5b3or5w
 BnVsFgYNhWkYFn1IDyp9ytVWgaL2EXKXgvJW21a8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v8 2/2] tests/functional: add memlock tests
Date: Sun, 25 May 2025 12:07:40 +0500
Message-Id: <20250525070737.54267-3-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525070737.54267-1-dtalexundeer@yandex-team.ru>
References: <20250525070737.54267-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Add new tests to check the correctness of the `-overcommit memlock`
option (possible values: off, on, on-fault) by using
`/proc/{qemu_pid}/status` file to check in VmSize, VmRSS and VmLck
values:

* if `memlock=off`, then VmLck = 0;
* if `memlock=on`, then VmLck > 0 and almost all memory is resident;
* if `memlock=on-fault`, then VmLck > 0 and only few memory is resident.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 tests/functional/meson.build     |  1 +
 tests/functional/test_memlock.py | 79 ++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100755 tests/functional/test_memlock.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 52b4706cfe..13079f58b6 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -68,6 +68,7 @@ tests_generic_system = [
   'empty_cpu_model',
   'info_usernet',
   'version',
+  'memlock',
 ]
 
 tests_generic_linuxuser = [
diff --git a/tests/functional/test_memlock.py b/tests/functional/test_memlock.py
new file mode 100755
index 0000000000..83cb5394cd
--- /dev/null
+++ b/tests/functional/test_memlock.py
@@ -0,0 +1,79 @@
+#!/usr/bin/env python3
+#
+# Functional test that check overcommit memlock options
+#
+# Copyright (c) Yandex Technologies LLC, 2025
+#
+# Author:
+#  Alexandr Moshkov <dtalexundeer@yandex-team.ru>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import re
+
+from typing import Dict
+
+from qemu_test import QemuSystemTest
+from qemu_test import skipLockedMemoryTest
+
+
+STATUS_VALUE_PATTERN = re.compile(r'^(\w+):\s+(\d+) kB', re.MULTILINE)
+
+
+@skipLockedMemoryTest(2_097_152)  # 2GB
+class MemlockTest(QemuSystemTest):
+    """
+    Boots a Linux system with memlock options.
+    Then verify, that this options is working correctly
+    by checking the smaps of the QEMU proccess.
+    """
+
+    def common_vm_setup_with_memlock(self, memlock):
+        self.vm.add_args('-overcommit', f'mem-lock={memlock}')
+        self.vm.launch()
+
+    def test_memlock_off(self):
+        self.common_vm_setup_with_memlock('off')
+
+        status = self.get_process_status_values(self.vm.get_pid())
+
+        self.assertTrue(status['VmLck'] == 0)
+
+    def test_memlock_on(self):
+        self.common_vm_setup_with_memlock('on')
+
+        status = self.get_process_status_values(self.vm.get_pid())
+
+        # VmLck > 0 kB and almost all memory is resident
+        self.assertTrue(status['VmLck'] > 0)
+        self.assertTrue(status['VmRSS'] >= status['VmSize'] * 0.70)
+
+    def test_memlock_onfault(self):
+        self.common_vm_setup_with_memlock('on-fault')
+
+        status = self.get_process_status_values(self.vm.get_pid())
+
+        # VmLck > 0 kB and only few memory is resident
+        self.assertTrue(status['VmLck'] > 0)
+        self.assertTrue(status['VmRSS'] <= status['VmSize'] * 0.30)
+
+    def get_process_status_values(self, pid: int) -> Dict[str, int]:
+        result = {}
+        raw_status = self._get_raw_process_status(pid)
+
+        for line in raw_status.split('\n'):
+            if m := STATUS_VALUE_PATTERN.match(line):
+                result[m.group(1)] = int(m.group(2))
+
+        return result
+
+    def _get_raw_process_status(self, pid: int) -> str:
+        try:
+            with open(f'/proc/{pid}/status', 'r') as f:
+                return f.read()
+        except FileNotFoundError:
+            self.skipTest("Can't open status file of the process")
+
+
+if __name__ == '__main__':
+    MemlockTest.main()
-- 
2.34.1


