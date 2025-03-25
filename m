Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA51C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twy4c-0003cu-Mz; Tue, 25 Mar 2025 02:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twy4V-0003c6-HH
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 02:47:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twy4T-0001AG-3n
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 02:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742885251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=neXRzJyBDHwBU3rOJQUjETMsqY2t2kkrhYAvNGAuyt8=;
 b=PfZ+Zir70WtjWkhSJ7n1SA5EqaQILY2UctBgKfgM0WPebAq/7WrqxT45v+hBxXDLPCXcoY
 iwJSbUaEPhLgVWpS4hkPzVyG93ZEyeoJw3qIbs1beSae0pwy9Cb0eoibVNiIIro4XzdDwk
 byWCAirxmnRd3zeeEOdlBz3MwSEpetY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-iMvkSECWM-CcHCFtMt9LVA-1; Tue,
 25 Mar 2025 02:47:22 -0400
X-MC-Unique: iMvkSECWM-CcHCFtMt9LVA-1
X-Mimecast-MFC-AGG-ID: iMvkSECWM-CcHCFtMt9LVA_1742885241
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D90871800262; Tue, 25 Mar 2025 06:47:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.60])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF0A01801747; Tue, 25 Mar 2025 06:47:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/functional/test_vnc: Skip test if VNC support is not
 available
Date: Tue, 25 Mar 2025 07:47:15 +0100
Message-ID: <20250325064715.278876-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

These tests currently fail if VNC support has not been compiled into
the QEMU binary. Let's add some checks to skip the tests in that
case instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_vnc.py | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_vnc.py b/tests/functional/test_vnc.py
index 1916be0103f..8c9953bdb00 100755
--- a/tests/functional/test_vnc.py
+++ b/tests/functional/test_vnc.py
@@ -12,6 +12,7 @@
 
 import socket
 from typing import List
+from qemu.machine.machine import VMLaunchFailure
 
 from qemu_test import QemuSystemTest
 from qemu_test.ports import Ports
@@ -32,7 +33,14 @@ class Vnc(QemuSystemTest):
     def test_no_vnc_change_password(self):
         self.vm.add_args('-nodefaults', '-S')
         self.vm.launch()
-        self.assertFalse(self.vm.qmp('query-vnc')['return']['enabled'])
+
+        query_vnc_response = self.vm.qmp('query-vnc')
+        if 'error' in query_vnc_response:
+            self.assertEqual(query_vnc_response['error']['class'],
+                             'CommandNotFound')
+            self.skipTest('VNC support not available')
+        self.assertFalse(query_vnc_response['return']['enabled'])
+
         set_password_response = self.vm.qmp('change-vnc-password',
                                             password='new_password')
         self.assertIn('error', set_password_response)
@@ -41,9 +49,19 @@ def test_no_vnc_change_password(self):
         self.assertEqual(set_password_response['error']['desc'],
                          'Could not set password')
 
+    def launch_guarded(self):
+        try:
+            self.vm.launch()
+        except VMLaunchFailure as excp:
+            if "-vnc: invalid option" in excp.output:
+                self.skipTest("VNC support not available")
+            else:
+                self.log.info("unhandled launch failure: %s", excp.output)
+                raise excp
+
     def test_change_password_requires_a_password(self):
         self.vm.add_args('-nodefaults', '-S', '-vnc', ':1,to=999')
-        self.vm.launch()
+        self.launch_guarded()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
         set_password_response = self.vm.qmp('change-vnc-password',
                                             password='new_password')
@@ -55,7 +73,7 @@ def test_change_password_requires_a_password(self):
 
     def test_change_password(self):
         self.vm.add_args('-nodefaults', '-S', '-vnc', ':1,to=999,password=on')
-        self.vm.launch()
+        self.launch_guarded()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
         self.vm.cmd('change-vnc-password',
                     password='new_password')
@@ -66,7 +84,7 @@ def do_test_change_listen(self, a, b, c):
         self.assertFalse(check_connect(c))
 
         self.vm.add_args('-nodefaults', '-S', '-vnc', f'{VNC_ADDR}:{a - 5900}')
-        self.vm.launch()
+        self.launch_guarded()
         self.assertEqual(self.vm.qmp('query-vnc')['return']['service'], str(a))
         self.assertTrue(check_connect(a))
         self.assertFalse(check_connect(b))
-- 
2.49.0


