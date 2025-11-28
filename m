Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308FAD116F1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 13:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOyhf-0001rk-4P; Fri, 28 Nov 2025 08:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vOyhc-0001qq-Rb
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:40:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vOyhZ-0002dO-VB
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764337197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KsFo8xY/CGs753K1Z9F3q7jVAI7IiQENnOKq3Bc00Vc=;
 b=fFqakZ6qvIkcGa4PZYnnOG5IpRgsD3OP82n8G8Ke5xStGJJSWmCq/bwGjC01Ikb0e28zM8
 TlA0yOUrRr2HRycmxOv/NDoBab/IXAhZ3SVMZIuTAk0BVeY2VL4EjtRj5ABi7OPI8U90je
 ehjolsMBwYvXR5sUtbL/Td0OGnLBFNo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-FJO9CRryOwiwM_HRMmsqgg-1; Fri,
 28 Nov 2025 08:39:54 -0500
X-MC-Unique: FJO9CRryOwiwM_HRMmsqgg-1
X-Mimecast-MFC-AGG-ID: FJO9CRryOwiwM_HRMmsqgg_1764337193
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E32F5180057A; Fri, 28 Nov 2025 13:39:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.146])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BBF21800840; Fri, 28 Nov 2025 13:39:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-s390x@nongnu.org
Subject: [RFC PATCH] tests/functional/s390x: Add reverse debugging test for
 s390x
Date: Fri, 28 Nov 2025 14:39:49 +0100
Message-ID: <20251128133949.181828-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We just have to make sure that we can set the endianness to big endian,
then we can also run this test on s390x.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Marked as RFC since it depends on the fix for this bug (so it cannot
 be merged yet):
 https://lore.kernel.org/qemu-devel/a0accce9-6042-4a7b-a7c7-218212818891@redhat.com/

 tests/functional/reverse_debugging.py        |  4 +++-
 tests/functional/s390x/meson.build           |  1 +
 tests/functional/s390x/test_reverse_debug.py | 21 ++++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100755 tests/functional/s390x/test_reverse_debug.py

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index 86fca8d81f1..8b9507674a0 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -64,7 +64,7 @@ def vm_get_icount(vm):
 
     @skipIfMissingImports("pygdbmi") # Required by GDB class
     @skipIfMissingEnv("QEMU_TEST_GDB")
-    def reverse_debugging(self, gdb_arch, shift=7, args=None):
+    def reverse_debugging(self, gdb_arch, shift=7, args=None, big_endian=False):
         from qemu_test import GDB
 
         # create qcow2 for snapshots
@@ -99,6 +99,8 @@ def reverse_debugging(self, gdb_arch, shift=7, args=None):
             gdb_cmd = os.getenv('QEMU_TEST_GDB')
             gdb = GDB(gdb_cmd)
             try:
+                if big_endian:
+                    gdb.cli("set endian big")
                 self.reverse_debugging_run(gdb, vm, port, gdb_arch, last_icount)
             finally:
                 self.log.info('exiting gdb and qemu')
diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390x/meson.build
index 70cd36e2913..0f03e1c9db8 100644
--- a/tests/functional/s390x/meson.build
+++ b/tests/functional/s390x/meson.build
@@ -6,6 +6,7 @@ test_s390x_timeouts = {
 
 tests_s390x_system_quick = [
   'vmstate',
+  'reverse_debug',
 ]
 
 tests_s390x_system_thorough = [
diff --git a/tests/functional/s390x/test_reverse_debug.py b/tests/functional/s390x/test_reverse_debug.py
new file mode 100755
index 00000000000..0767dc91678
--- /dev/null
+++ b/tests/functional/s390x/test_reverse_debug.py
@@ -0,0 +1,21 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+'''
+Reverse debugging test for s390x
+'''
+
+from reverse_debugging import ReverseDebugging
+
+
+class ReverseDebuggingS390x(ReverseDebugging):
+
+    def test_revdbg(self):
+        self.set_machine('s390-ccw-virtio')
+        self.reverse_debugging(gdb_arch='s390:64-bit', shift=6,
+                               big_endian=True, args=('-no-shutdown',))
+
+
+if __name__ == '__main__':
+    ReverseDebugging.main()
-- 
2.51.1


