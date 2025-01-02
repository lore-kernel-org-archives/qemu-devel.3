Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B45E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 10:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTIUp-0003tr-9Z; Thu, 02 Jan 2025 05:32:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTIUn-0003tC-AA
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:32:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTIUl-0005rB-GW
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735813922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2rHxQa1PhAoahuKgtDYSw/InvDF8l5Ykbk+lLRlrRRo=;
 b=f0KNnKXMHgIK3uBxqxyx8bpO1HICIaC6gGs6HUJ9UNRIE/NYI06JFSblwiNZcTyKE2rpjD
 gZAkPQT/2tLdPBKt/X13xPY1fB0C5jMXulsG2YbWZ897GbrlSVrTAkWhuGlC9/VG18M2ns
 yTYiRiVG5RtjzsMgQ93PLhk3SEadM6A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-shSA59nFPhm9eKC6_LCR2w-1; Thu,
 02 Jan 2025 05:31:59 -0500
X-MC-Unique: shSA59nFPhm9eKC6_LCR2w-1
X-Mimecast-MFC-AGG-ID: shSA59nFPhm9eKC6_LCR2w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3301F19560A3
 for <qemu-devel@nongnu.org>; Thu,  2 Jan 2025 10:31:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.39])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 989891956052; Thu,  2 Jan 2025 10:31:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 05/10] tests/functional: Extract the find_free_ports() function
 into a helper file
Date: Thu,  2 Jan 2025 11:31:33 +0100
Message-ID: <20250102103138.354618-6-thuth@redhat.com>
In-Reply-To: <20250102103138.354618-1-thuth@redhat.com>
References: <20250102103138.354618-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We'll need this functionality in other functional tests, too, so
let's extract it into the qemu_test module.
Also add  an __enter__ and __exit__ function that can be used for
using this functionality in a locked context, so that tests that
are running in parallel don't try to compete for the same ports
later.
Also make sure to only use ports in the "Dynamic Ports" range
(see https://www.rfc-editor.org/rfc/rfc6335) and "randomize" the
start of the probed range with the PID of the test process to
further avoid possible clashes with other competing processes.

Message-ID: <20241218131439.255841-5-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/ports.py | 56 +++++++++++++++++++++++++++++
 tests/functional/test_vnc.py        | 36 +++++--------------
 2 files changed, 64 insertions(+), 28 deletions(-)
 create mode 100644 tests/functional/qemu_test/ports.py

diff --git a/tests/functional/qemu_test/ports.py b/tests/functional/qemu_test/ports.py
new file mode 100644
index 0000000000..cc39939d48
--- /dev/null
+++ b/tests/functional/qemu_test/ports.py
@@ -0,0 +1,56 @@
+#!/usr/bin/env python3
+#
+# Simple functional tests for VNC functionality
+#
+# Copyright 2018, 2024 Red Hat, Inc.
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import fcntl
+import os
+import socket
+import sys
+import tempfile
+
+from .config import BUILD_DIR
+from typing import List
+
+class Ports():
+
+    PORTS_ADDR = '127.0.0.1'
+    PORTS_RANGE_SIZE = 1024
+    PORTS_START = 49152 + ((os.getpid() * PORTS_RANGE_SIZE) % 16384)
+    PORTS_END = PORTS_START + PORTS_RANGE_SIZE
+
+    def __enter__(self):
+        lock_file = os.path.join(BUILD_DIR, "tests", "functional", "port_lock")
+        self.lock_fh = os.open(lock_file, os.O_CREAT)
+        fcntl.flock(self.lock_fh, fcntl.LOCK_EX)
+        return self
+
+    def __exit__(self, exc_type, exc_value, traceback):
+        fcntl.flock(self.lock_fh, fcntl.LOCK_UN)
+        os.close(self.lock_fh)
+
+    def check_bind(self, port: int) -> bool:
+        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
+            try:
+                sock.bind((self.PORTS_ADDR, port))
+            except OSError:
+                return False
+
+        return True
+
+    def find_free_ports(self, count: int) -> List[int]:
+        result = []
+        for port in range(self.PORTS_START, self.PORTS_END):
+            if self.check_bind(port):
+                result.append(port)
+                if len(result) >= count:
+                    break
+        assert len(result) == count
+        return result
+
+    def find_free_port(self) -> int:
+        return self.find_free_ports(1)[0]
diff --git a/tests/functional/test_vnc.py b/tests/functional/test_vnc.py
index e600d75234..1916be0103 100755
--- a/tests/functional/test_vnc.py
+++ b/tests/functional/test_vnc.py
@@ -14,22 +14,9 @@
 from typing import List
 
 from qemu_test import QemuSystemTest
-
+from qemu_test.ports import Ports
 
 VNC_ADDR = '127.0.0.1'
-VNC_PORT_START = 32768
-VNC_PORT_END = VNC_PORT_START + 1024
-
-
-def check_bind(port: int) -> bool:
-    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
-        try:
-            sock.bind((VNC_ADDR, port))
-        except OSError:
-            return False
-
-    return True
-
 
 def check_connect(port: int) -> bool:
     with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
@@ -40,18 +27,6 @@ def check_connect(port: int) -> bool:
 
     return True
 
-
-def find_free_ports(count: int) -> List[int]:
-    result = []
-    for port in range(VNC_PORT_START, VNC_PORT_END):
-        if check_bind(port):
-            result.append(port)
-            if len(result) >= count:
-                break
-    assert len(result) == count
-    return result
-
-
 class Vnc(QemuSystemTest):
 
     def test_no_vnc_change_password(self):
@@ -85,8 +60,7 @@ def test_change_password(self):
         self.vm.cmd('change-vnc-password',
                     password='new_password')
 
-    def test_change_listen(self):
-        a, b, c = find_free_ports(3)
+    def do_test_change_listen(self, a, b, c):
         self.assertFalse(check_connect(a))
         self.assertFalse(check_connect(b))
         self.assertFalse(check_connect(c))
@@ -108,5 +82,11 @@ def test_change_listen(self):
         self.assertTrue(check_connect(b))
         self.assertTrue(check_connect(c))
 
+    def test_change_listen(self):
+        with Ports() as ports:
+            a, b, c = ports.find_free_ports(3)
+            self.do_test_change_listen(a, b, c)
+
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.47.1


