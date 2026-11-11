Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C8D606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HhpxvZs8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQzNi-000815-21; Tue, 10 Nov 2026 22:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQzNg-00080M-HB
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:52:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQzNe-0006uD-FR
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794369133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jL1ZY5YGV4jNZ0LlyOE5AfrHB7c9oeMeQZiaZa21c20=;
 b=HhpxvZs8g5uG3FCqdGkmQLw9oihB4kgwzfHbnqnfWHO5UzK3cR2w/YhdlJWB82As9P1Af3
 upshg+9e04uXW0iwMpqldxqJcKlLMvLmfXu8QQ/DmIZiEqJjLUkG4Tolxt+6RX19BmvlVT
 JmueHhMdVQbPJRltjQMDuXJ6JjYAzkM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-i3NWjXe-N4KoibFHQWmWOA-1; Tue,
 10 Nov 2026 22:52:12 -0500
X-MC-Unique: i3NWjXe-N4KoibFHQWmWOA-1
X-Mimecast-MFC-AGG-ID: i3NWjXe-N4KoibFHQWmWOA_1794369131
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0E8719772E6; Wed, 11 Nov 2026 03:52:10 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D11D9300019F; Wed, 11 Nov 2026 03:52:08 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 4/8] iotests: Refactor python NBD server setup
Date: Tue, 10 Nov 2026 21:51:29 -0600
Message-ID: <20261111035200.1751734-14-eblake@redhat.com>
In-Reply-To: <20261111035200.1751734-10-eblake@redhat.com>
References: <20261111035200.1751734-10-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extract code from nbd-multiconn that I plan to use in another upcoming
unit test.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20261110155356.1520433-8-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/iotests.py          | 30 ++++++++++++++++++
 tests/qemu-iotests/tests/nbd-multiconn | 44 +++++---------------------
 2 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 642a160bb28..7017d2016cf 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1385,6 +1385,36 @@ def case_skip(self, reason):
         case_notrun(reason)
         self.skipTest(reason)

+    @contextmanager
+    def run_nbd_server(self, nbd_sock: str,
+                       max_conn: Optional[int] = None) -> Iterator[None]:
+        args: Dict[str, Any] = {
+            'addr': {
+                'type': 'unix',
+                'data': {'path': nbd_sock}
+            }
+        }
+        if max_conn is not None:
+            args['max-connections'] = max_conn
+
+        self.vm.cmd('nbd-server-start', args)
+        try:
+            yield
+        finally:
+            self.vm.cmd('nbd-server-stop')
+
+    def add_nbd_export(self, node_name: str, name: str,
+                       writable: Optional[bool] = None) -> None:
+        args: Dict[str, Any] = {
+            'type': 'nbd',
+            'id': name,
+            'node-name': node_name,
+            'name': name,
+        }
+        if writable is not None:
+            args['writable'] = writable
+
+        self.vm.cmd('block-export-add', args)

 def notrun(reason):
     '''Skip this test suite'''
diff --git a/tests/qemu-iotests/tests/nbd-multiconn b/tests/qemu-iotests/tests/nbd-multiconn
index 479e872f2a8..96efe01e583 100755
--- a/tests/qemu-iotests/tests/nbd-multiconn
+++ b/tests/qemu-iotests/tests/nbd-multiconn
@@ -62,55 +62,27 @@ class TestNbdMulticonn(iotests.QMPTestCase):
         except OSError:
             pass

-    @contextmanager
-    def run_server(self, max_connections=None):
-        args = {
-            'addr': {
-                'type': 'unix',
-                'data': {'path': nbd_sock}
-            }
-        }
-        if max_connections is not None:
-            args['max-connections'] = max_connections
-
-        self.vm.cmd('nbd-server-start', args)
-        yield
-
-        self.vm.cmd('nbd-server-stop')
-
-    def add_export(self, name, writable=None):
-        args = {
-            'type': 'nbd',
-            'id': name,
-            'node-name': 'n',
-            'name': name,
-        }
-        if writable is not None:
-            args['writable'] = writable
-
-        self.vm.cmd('block-export-add', args)
-
     def test_default_settings(self):
-        with self.run_server():
-            self.add_export('r')
-            self.add_export('w', writable=True)
+        with self.run_nbd_server(nbd_sock):
+            self.add_nbd_export('n', 'r')
+            self.add_nbd_export('n', 'w', writable=True)
             with open_nbd('r') as h:
                 self.assertTrue(h.can_multi_conn())
             with open_nbd('w') as h:
                 self.assertTrue(h.can_multi_conn())

     def test_limited_connections(self):
-        with self.run_server(max_connections=1):
-            self.add_export('r')
-            self.add_export('w', writable=True)
+        with self.run_nbd_server(nbd_sock, max_conn=1):
+            self.add_nbd_export('n', 'r')
+            self.add_nbd_export('n', 'w', writable=True)
             with open_nbd('r') as h:
                 self.assertFalse(h.can_multi_conn())
             with open_nbd('w') as h:
                 self.assertFalse(h.can_multi_conn())

     def test_parallel_writes(self):
-        with self.run_server():
-            self.add_export('w', writable=True)
+        with self.run_nbd_server(nbd_sock):
+            self.add_nbd_export('n', 'w', writable=True)

             clients = [nbd.NBD() for _ in range(3)]
             for c in clients:
-- 
2.56.0


