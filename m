Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFF1C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPL31-0003N8-GT; Wed, 11 Jun 2025 08:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2v-0003Kh-BD
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2q-0004OL-1Q
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749646745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwJkJnDs4orokssv+leEWMiYNnMVBZdqAyheL9PDKjs=;
 b=GPfESLvR+cU5uXD6yEtHJVg0fk75SddEesxIu2eVGlLKyvCTtWip3aRVvQg/Ryu8s1jc+4
 lP5Z8fE6k/URH4JSvA0FWsTf1Y/aVAzauyT6+8HeRoMnwxDDw1ScLMRGs9pvUea2lO1Oef
 uvEFQYo/Uu66EBeXabT2XXKnRSgFJSs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-PLg6Ifm5M4ebdswyh9nw7g-1; Wed,
 11 Jun 2025 08:59:04 -0400
X-MC-Unique: PLg6Ifm5M4ebdswyh9nw7g-1
X-Mimecast-MFC-AGG-ID: PLg6Ifm5M4ebdswyh9nw7g_1749646743
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57E7E180136B; Wed, 11 Jun 2025 12:59:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.174])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B7E6019560A3; Wed, 11 Jun 2025 12:59:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PULL 06/10] tests/functional: add memlock tests
Date: Wed, 11 Jun 2025 14:58:42 +0200
Message-ID: <20250611125846.125918-7-thuth@redhat.com>
In-Reply-To: <20250611125846.125918-1-thuth@redhat.com>
References: <20250611125846.125918-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

Add new tests to check the correctness of the `-overcommit memlock`
option (possible values: off, on, on-fault) by using
`/proc/{qemu_pid}/status` file to check in VmSize, VmRSS and VmLck
values:

* if `memlock=off`, then VmLck = 0;
* if `memlock=on`, then VmLck > 0 and almost all memory is resident;
* if `memlock=on-fault`, then VmLck > 0 and only few memory is resident.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Message-ID: <20250605065908.299979-3-dtalexundeer@yandex-team.ru>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build     |  1 +
 tests/functional/test_memlock.py | 79 ++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100755 tests/functional/test_memlock.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 557d59ddf4d..c3fca446cff 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -312,6 +312,7 @@ tests_x86_64_system_quick = [
   'virtio_version',
   'x86_cpu_model_versions',
   'vnc',
+  'memlock',
 ]
 
 tests_x86_64_system_thorough = [
diff --git a/tests/functional/test_memlock.py b/tests/functional/test_memlock.py
new file mode 100755
index 00000000000..2b515ff979f
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
+    Runs a guest with memlock options.
+    Then verify, that this options is working correctly
+    by checking the status file of the QEMU process.
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
2.49.0


