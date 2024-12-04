Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893AAE7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 07:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIjft-0006dI-4J; Wed, 04 Dec 2024 02:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIjfW-0006TJ-1l
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 02:19:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIjfU-0005H6-Ih
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 02:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733296767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPc/TAIvpVYP9UaXsmRy/Dwk2j1lH5elMxHmRHmk/FQ=;
 b=IC96RA33UDb6X1quV/IKylNcjEyK9zY2FXuhsOfUvsYqcYvfTsxnKckWPglQma4eAM6xWA
 xfLNzx4o+ZNhWwegsYZDXBDDQXWoE3/D5BBVCByMsKQaZRWvfw4cgo7onZRV65I0xzqT/j
 CKyqYQGWdkscdhZ4cvM8YDdRJf/8UtM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-i4JJG92dNBOyGZnTiKZ37Q-1; Wed,
 04 Dec 2024 02:19:26 -0500
X-MC-Unique: i4JJG92dNBOyGZnTiKZ37Q-1
X-Mimecast-MFC-AGG-ID: i4JJG92dNBOyGZnTiKZ37Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6795219560BD; Wed,  4 Dec 2024 07:19:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.155])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 563371956054; Wed,  4 Dec 2024 07:19:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] tests/functional/test_vnc: Do not use a hard-coded VNC
 port
Date: Wed,  4 Dec 2024 08:19:09 +0100
Message-ID: <20241204071911.664057-4-thuth@redhat.com>
In-Reply-To: <20241204071911.664057-1-thuth@redhat.com>
References: <20241204071911.664057-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Two tests here are using the hard-coded VNC port :0 ... if there
is already a QEMU or other program running that is using this
port, the tests will be failing. Let's better detect a free port
for these tests and use that one instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_vnc.py | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_vnc.py b/tests/functional/test_vnc.py
index 32a81259e4..59c790b1ce 100755
--- a/tests/functional/test_vnc.py
+++ b/tests/functional/test_vnc.py
@@ -46,8 +46,8 @@ def test_no_vnc_change_password(self):
         self.assertEqual(set_password_response['error']['desc'],
                          'Could not set password')
 
-    def test_change_password_requires_a_password(self):
-        self.vm.add_args('-nodefaults', '-S', '-vnc', ':0')
+    def do_test_change_password_requires_a_password(self, port):
+        self.vm.add_args('-nodefaults', '-S', '-vnc', f':{port - 5900}')
         self.vm.launch()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
         set_password_response = self.vm.qmp('change-vnc-password',
@@ -58,13 +58,24 @@ def test_change_password_requires_a_password(self):
         self.assertEqual(set_password_response['error']['desc'],
                          'Could not set password')
 
-    def test_change_password(self):
-        self.vm.add_args('-nodefaults', '-S', '-vnc', ':0,password=on')
+    def test_change_password_requires_a_password(self):
+        with Ports() as ports:
+            port = ports.find_free_port()
+            self.do_test_change_password_requires_a_password(port)
+
+    def do_test_change_password(self, port):
+        self.vm.add_args('-nodefaults', '-S',
+                         '-vnc', f':{port - 5900},password=on')
         self.vm.launch()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
         self.vm.cmd('change-vnc-password',
                     password='new_password')
 
+    def test_change_password(self):
+        with Ports() as ports:
+            port = ports.find_free_port()
+            self.do_test_change_password(port)
+
     def do_test_change_listen(self, a, b, c):
         self.assertFalse(check_connect(a))
         self.assertFalse(check_connect(b))
-- 
2.47.0


