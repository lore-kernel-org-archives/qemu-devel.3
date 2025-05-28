Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57969C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDga-0005ev-Mr; Wed, 28 May 2025 06:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDgL-0004bE-FB
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDgB-0007Ib-0z
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hVA012VkzcvdoDUkAdfR2+pJ3HkG0N8iDqVKF3jHfxo=;
 b=QUNzhrqJrSYQUfj7bZ5eS5pcaWFsjG2h0DEXhVGVFMaHhYceEiKwI3CFODfPfl69tnzZIW
 gftTlwmqjT4Inkg/6GSPR61yDdNUfotPV685J1Eiad7czxd9xJEES0gfyD0KRnQhpx/HLO
 JfYAqG8kBOSOClPYqs1bedA6yDZceUg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-b4_s_PnAMDWa7gKSOXsZTw-1; Wed,
 28 May 2025 06:05:29 -0400
X-MC-Unique: b4_s_PnAMDWa7gKSOXsZTw-1
X-Mimecast-MFC-AGG-ID: b4_s_PnAMDWa7gKSOXsZTw_1748426728
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E38851800374; Wed, 28 May 2025 10:05:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CF5118004A7; Wed, 28 May 2025 10:05:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PULL 05/27] tests/functional: add memlock tests
Date: Wed, 28 May 2025 12:04:45 +0200
Message-ID: <20250528100507.313906-6-thuth@redhat.com>
In-Reply-To: <20250528100507.313906-1-thuth@redhat.com>
References: <20250528100507.313906-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Message-ID: <20250525070737.54267-3-dtalexundeer@yandex-team.ru>
[thuth: improved the text in a comment]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build     |  1 +
 tests/functional/test_memlock.py | 79 ++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100755 tests/functional/test_memlock.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 52b4706cfe8..13079f58b66 100644
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
index 00000000000..8910cb6da33
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
+    by checking the smaps of the QEMU process.
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


