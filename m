Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C893CE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNttv-0002Uv-Cj; Wed, 18 Dec 2024 08:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNttW-0002F4-FJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:15:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNttK-0005SH-TQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734527704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6WQibGLd1aga+l8qnQklbyV4ow8VYthM36dgdoA6Cs=;
 b=K3zw3YkqfHZSx4UdbBvYaruimTeA5Q2TKCU++jAN0GwPkxk5r95PEADFvMcwB278gXXMmq
 tTtymXBdRkyneXYdHLJNaVErVRimnSk49m/jtb8pKKmEi/Gv2xGHlSJj26QdSaLkuak1Ga
 0RqrXholDHGCpR1Yn9GMTaIleVgVbC0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-B3bVr2seP4qUWUxS1BJo6g-1; Wed,
 18 Dec 2024 08:15:01 -0500
X-MC-Unique: B3bVr2seP4qUWUxS1BJo6g-1
X-Mimecast-MFC-AGG-ID: B3bVr2seP4qUWUxS1BJo6g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B82E19560B3; Wed, 18 Dec 2024 13:15:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97C4B30044C1; Wed, 18 Dec 2024 13:14:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 4/5] tests/functional: Extract the find_free_ports()
 function into a helper file
Date: Wed, 18 Dec 2024 14:14:38 +0100
Message-ID: <20241218131439.255841-5-thuth@redhat.com>
In-Reply-To: <20241218131439.255841-1-thuth@redhat.com>
References: <20241218131439.255841-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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


