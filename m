Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEABC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 09:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4cJH-0000cX-BD; Tue, 15 Apr 2025 05:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1u4cIj-0000XR-OQ
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:09:58 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1u4cId-0000Qk-5p
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:09:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2b89:0:640:9815:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A4B92610E8;
 Tue, 15 Apr 2025 12:09:37 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6b8:b081:b4a2::1:8])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id T9D8rr1Fea60-OauJZqUX; Tue, 15 Apr 2025 12:09:36 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744708176;
 bh=Y3GGhWyFIw2cuFLMnWB9oKlUYsw0khi8tapA6yMBEeM=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=vWYy0CRG/cAjzRZ/l894FYMz/2KmbV4e9bEmrXoLFusv6SDr2eggw4I+i3iaefn1T
 n5T+SE/uALe9cpW5GWwhW4KH7q0cUeG+Rq1EnTDi5cdcfWWAaxRtn2RaiVUc8XlAJ7
 qkgLQrdnvUZT2yGqWlknhv2+u6iXSQLH1pAZkvhY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v3] tests/functional: add memlock tests
Date: Tue, 15 Apr 2025 14:08:55 +0500
Message-Id: <20250415090854.71526-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

---

v2 -> v3:
Move tests to tests/functional dir, as the tests/avocado dir is being phased out.
v2 was [PATCH v2] tests/avocado: add memlock tests.
Supersedes: <20250414075702.9248-1-dtalexundeer@yandex-team.ru>

v1 -> v2:
In the previous send, i forgot to specify new patch version (v2)
So i resend previous patch with version specified.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 tests/functional/meson.build     |   1 +
 tests/functional/test_memlock.py | 100 +++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 tests/functional/test_memlock.py

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
new file mode 100644
index 0000000000..e551e54a77
--- /dev/null
+++ b/tests/functional/test_memlock.py
@@ -0,0 +1,100 @@
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
+
+
+SMAPS_HEADER_PATTERN = re.compile(r'^\w+-\w+', re.MULTILINE)
+SMAPS_VALUE_PATTERN = re.compile(r'^(\w+):\s+(\d+) kB', re.MULTILINE)
+
+
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
+        with open(f'/proc/{pid}/smaps', 'r') as f:
+            return f.read()
+
+
+if __name__ == '__main__':
+    MemlockTest.main()
-- 
2.34.1


