Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE6FC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 13:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHjwM-0002Pd-D5; Wed, 21 May 2025 09:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uHjw8-0002EM-Rx
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:56:49 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uHjw6-0007BO-5p
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:56:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 3FE3F6271F;
 Wed, 21 May 2025 16:56:44 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6b8:b081:b529::1:7])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id RtO8uI0FbCg0-gt7VsnIl; Wed, 21 May 2025 16:56:43 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1747835803;
 bh=IbJCZnzsJgnAhFSlz/nLHCzzT16xbooHW7NHstX+/YQ=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=am7WN8Ud51g1m0yOdeZUkSvXM6ChRMgaK065Srw7b+ZIDS5btJPWDzFTCK3n5l8Vm
 cDbEIm2LsyVZ3/HbWrDTJAjBZwXvQu0Z3kuJH9BkYOQ9DBxSvw5wQxr0IJk5mBmpDW
 FYGwEvX6VWwfQbP+NfhbzDgwnlgZSpND3H6Hp7Ug=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
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
Subject: [PATCH v7 2/2] tests/functional: add memlock tests
Date: Wed, 21 May 2025 18:55:24 +0500
Message-Id: <20250521135522.11180-3-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521135522.11180-1-dtalexundeer@yandex-team.ru>
References: <20250521135522.11180-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
`/proc/{qemu_pid}/smaps` file to check in Size, Rss and Locked fields of
anonymous segments:

* if `memlock=off`, then Locked = 0 on every anonymous smaps;
* if `memlock=on`, then Size, Rss and Locked values must be equal for
every anon smaps where Rss is not 0;
* if `memlock=on-fault`, then Rss and Locked must be equal on every anon
smaps and anonymous segment with Rss < Size must exists.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 tests/functional/meson.build     |   1 +
 tests/functional/test_memlock.py | 107 +++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100755 tests/functional/test_memlock.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 0f8be30fe2..339af7835f 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -61,6 +61,7 @@ tests_generic_system = [
   'empty_cpu_model',
   'info_usernet',
   'version',
+  'memlock',
 ]
 
 tests_generic_linuxuser = [
diff --git a/tests/functional/test_memlock.py b/tests/functional/test_memlock.py
new file mode 100755
index 0000000000..a090e7f9ad
--- /dev/null
+++ b/tests/functional/test_memlock.py
@@ -0,0 +1,107 @@
+#!/usr/bin/env python3
+#
+# Functional test that check overcommit memlock options
+#
+# Copyright (c) Yandex Technologies LLC, 2025
+#
+# Author:
+#  Alexandr Moshkov <dtalexundeer@yandex-team.ru>
+#
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import re
+
+from typing import List, Dict
+
+from qemu_test import QemuSystemTest
+from qemu_test import skipLockedMemoryTest
+
+
+SMAPS_HEADER_PATTERN = re.compile(r'^\w+-\w+', re.MULTILINE)
+SMAPS_VALUE_PATTERN = re.compile(r'^(\w+):\s+(\d+) kB', re.MULTILINE)
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
+    def get_anon_smaps_by_pid(self, pid):
+        smaps_raw = self._get_raw_smaps_by_pid(pid)
+        return self._parse_anonymous_smaps(smaps_raw)
+
+    def test_memlock_off(self):
+        self.common_vm_setup_with_memlock('off')
+
+        anon_smaps = self.get_anon_smaps_by_pid(self.vm.get_pid())
+
+        # locked = 0 on every smap
+        for smap in anon_smaps:
+            self.assertEqual(smap['Locked'], 0)
+
+    def test_memlock_on(self):
+        self.common_vm_setup_with_memlock('on')
+
+        anon_smaps = self.get_anon_smaps_by_pid(self.vm.get_pid())
+
+        # size = rss = locked on every smap where rss not 0
+        for smap in anon_smaps:
+            if smap['Rss'] == 0:
+                continue
+            self.assertTrue(smap['Size'] == smap['Rss'] == smap['Locked'])
+
+    def test_memlock_onfault(self):
+        self.common_vm_setup_with_memlock('on-fault')
+
+        anon_smaps = self.get_anon_smaps_by_pid(self.vm.get_pid())
+
+        # rss = locked on every smap and segment with rss < size exists
+        exists = False
+        for smap in anon_smaps:
+            self.assertTrue(smap['Rss'] == smap['Locked'])
+            if smap['Rss'] < smap['Size']:
+                exists = True
+        self.assertTrue(exists)
+
+    def _parse_anonymous_smaps(self, smaps_raw: str) -> List[Dict[str, int]]:
+        result_segments = []
+        current_segment = {}
+        is_anonymous = False
+
+        for line in smaps_raw.split('\n'):
+            if SMAPS_HEADER_PATTERN.match(line):
+                if current_segment and is_anonymous:
+                    result_segments.append(current_segment)
+                current_segment = {}
+                # anonymous segment header looks like this:
+                # 7f3b8d3f0000-7f3b8d3f3000 rw-s 00000000 00:0f 1052
+                # and non anonymous header looks like this:
+                # 7f3b8d3f0000-7f3b8d3f3000 rw-s 00000000 00:0f 1052   [stack]
+                is_anonymous = len(line.split()) == 5
+            elif m := SMAPS_VALUE_PATTERN.match(line):
+                current_segment[m.group(1)] = int(m.group(2))
+
+        if current_segment and is_anonymous:
+            result_segments.append(current_segment)
+
+        return result_segments
+
+    def _get_raw_smaps_by_pid(self, pid: int) -> str:
+        try:
+            with open(f'/proc/{pid}/smaps', 'r') as f:
+                return f.read()
+        except IOError:
+            self.skipTest("Can't open smaps file of the process")
+
+
+if __name__ == '__main__':
+    MemlockTest.main()
-- 
2.34.1


