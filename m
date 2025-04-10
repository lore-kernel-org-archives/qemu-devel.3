Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86FAC369A2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 20:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2y8h-0000f9-Iv; Thu, 10 Apr 2025 16:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1u2sk7-00029z-UR
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 10:18:59 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1u2sk5-0005Ve-8N
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 10:18:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2b89:0:640:9815:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3035C60B21;
 Thu, 10 Apr 2025 17:18:47 +0300 (MSK)
Received: from dtalexundeer-nx.yandex.net (unknown
 [2a02:6bf:8011:f00:aa58:26d7:246e:b27d])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id eIggH90FZiE0-2FT6qaP7; Thu, 10 Apr 2025 17:18:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744294726;
 bh=KQZximoWw8x5dlbSTsPnqBe/kHVFyYSKfFPQbU8R1qE=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=H4At/nvpdwJTorT3Ej+rnyg6NYD9R4nSD1NVD9SeEQjdRU76T9OJNEmSOg5d8IVgo
 5YM5NK1JKpVpq4x0mC+aywPQikNYunI4suqCOeYtCSWTrNo7uxy6KgnAPDSC78o+jb
 F2UQP6/MIdAIBpZALrSPChCZ+le3Ee1DEMOTFhuU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH] tests/avocado: add memlock tests
Date: Thu, 10 Apr 2025 19:17:53 +0500
Message-Id: <20250410141752.275935-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 10 Apr 2025 16:04:37 -0400
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
 tests/avocado/memlock.py | 100 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 tests/avocado/memlock.py

diff --git a/tests/avocado/memlock.py b/tests/avocado/memlock.py
new file mode 100644
index 0000000000..e3e98d9524
--- /dev/null
+++ b/tests/avocado/memlock.py
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
+from avocado_qemu.linuxtest import LinuxTest
+
+
+SMAPS_HEADER_PATTERN = re.compile(r'^\w+-\w+', re.MULTILINE)
+SMAPS_VALUE_PATTERN = re.compile(r'^(\w+):\s+(\d+) kB', re.MULTILINE)
+
+
+class Memlock(LinuxTest):
+    """
+    :avocado: tags=memlock
+
+    Boots a Linux system with memlock options.
+    Then verify, that this options is working correctly
+    by checking the smaps of the QEMU proccess.
+    """
+
+    def common_vm_setup_with_memlock(self, memlock):
+        self.vm.add_args('-overcommit', f'mem-lock={memlock}')
+        self.launch_and_wait(set_up_ssh_connection=False)
+
+    def get_anon_smaps_by_pid(self, pid):
+        smaps_raw = self._get_raw_smaps_by_pid(pid)
+        return self._parse_anonymous_smaps(smaps_raw)
+
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
-- 
2.34.1


