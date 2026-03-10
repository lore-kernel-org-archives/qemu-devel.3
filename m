Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3A5FCC9C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq4q-00075F-4Y; Tue, 10 Mar 2026 01:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4g-0006u0-IK
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4d-0006Fe-8I
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjGM9UUH+1EYmRPXqlMYoKPm/B/kdCrnlHuVtWSiLV4=;
 b=NFnQU2HNqyCAC/H1+vHi7maFH/TW9ExzpfDwMMpYv1LXT20AYVQUZkgeSxz1ptEUJBpCsN
 1f2zcPUd7/Us1D5klAzcrPPC8BmEgwhDGjw8jCDbfeXJvjKBc/R70CSA4JZIaozQFCh5MZ
 WWRnHfJOPQnHkj/HXMwOh+vts3Uu3r4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-iZm52N5-Nfqk3-xYQl1xlQ-1; Tue,
 10 Mar 2026 01:56:01 -0400
X-MC-Unique: iZm52N5-Nfqk3-xYQl1xlQ-1
X-Mimecast-MFC-AGG-ID: iZm52N5-Nfqk3-xYQl1xlQ_1773122160
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AD7F180035D; Tue, 10 Mar 2026 05:56:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C8051956095; Tue, 10 Mar 2026 05:55:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 07/25] tests/functional/migration: Use the migrate_vms helper
Date: Tue, 10 Mar 2026 06:55:12 +0100
Message-ID: <20260310055530.8893-8-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Fabiano Rosas <farosas@suse.de>

Change do_migrate() to call the migrate_vms() helper and provide it
with the two VMs already created. Rename do_migrate -> migrate and
adjust the callers.

While here, standardize on the "src" and "dst" names.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20260303173320.10942-4-farosas@suse.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/migration.py | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 3362e5c743e..49347a30bbf 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -45,17 +45,19 @@ def migrate_vms(self, dst_uri, src_uri, dst_vm, src_vm):
         src_vm.qmp('migrate', uri=src_uri)
         self.assert_migration(src_vm, dst_vm)
 
-    def do_migrate(self, dest_uri, src_uri=None):
-        dest_vm = self.get_vm('-incoming', dest_uri, name="dest-qemu")
-        dest_vm.add_args('-nodefaults')
-        dest_vm.launch()
+    def migrate(self, dst_uri, src_uri=None):
+        dst_vm = self.get_vm('-incoming', 'defer', name="dst-qemu")
+        dst_vm.add_args('-nodefaults')
+        dst_vm.launch()
+
+        src_vm = self.get_vm(name="src-qemu")
+        src_vm.add_args('-nodefaults')
+        src_vm.launch()
+
         if src_uri is None:
-            src_uri = dest_uri
-        source_vm = self.get_vm(name="source-qemu")
-        source_vm.add_args('-nodefaults')
-        source_vm.launch()
-        source_vm.qmp('migrate', uri=src_uri)
-        self.assert_migration(source_vm, dest_vm)
+            src_uri = dst_uri
+
+        self.migrate_vms(dst_uri, src_uri, dst_vm, src_vm)
 
     def _get_free_port(self, ports):
         port = ports.find_free_port()
@@ -65,18 +67,18 @@ def _get_free_port(self, ports):
 
     def migration_with_tcp_localhost(self):
         with Ports() as ports:
-            dest_uri = 'tcp:localhost:%u' % self._get_free_port(ports)
-            self.do_migrate(dest_uri)
+            dst_uri = 'tcp:localhost:%u' % self._get_free_port(ports)
+            self.migrate(dst_uri)
 
     def migration_with_unix(self):
-        dest_uri = 'unix:%s/migration.sock' % self.socket_dir().name
-        self.do_migrate(dest_uri)
+        dst_uri = 'unix:%s/migration.sock' % self.socket_dir().name
+        self.migrate(dst_uri)
 
     def migration_with_exec(self):
         if not which('ncat'):
             self.skipTest('ncat is not available')
         with Ports() as ports:
             free_port = self._get_free_port(ports)
-            dest_uri = 'exec:ncat -l localhost %u' % free_port
+            dst_uri = 'exec:ncat -l localhost %u' % free_port
             src_uri = 'exec:ncat localhost %u' % free_port
-            self.do_migrate(dest_uri, src_uri)
+            self.migrate(dst_uri, src_uri)
-- 
2.53.0


