Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC13CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8faX-0008Q0-RW; Tue, 14 Oct 2025 10:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8faL-0008Hx-9i
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8faE-0004T0-W4
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760450456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iZP0l5kJ/fstb/E7M3cLqNH7C5WxLCSjaU6PD5Aitzk=;
 b=X220aO0RVy6vOAuUqDjWFwwa0JwlVMZ2M5fuYnTKdydVtqMl79WidSvNQlWsMgcc5TB+CB
 SxdLyvuwvhvnMJSQ+cR4hx+vfiZXBqPP6nbQl977a4hUVWvOY1GQG6ZJNxyZAdxaHSXcxt
 HlWR+1RgRnkJZ/KDn4/BbmYqtj9LrP8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-v6QW6aFyPdi2E0Dzj7W4dw-1; Tue,
 14 Oct 2025 10:00:53 -0400
X-MC-Unique: v6QW6aFyPdi2E0Dzj7W4dw-1
X-Mimecast-MFC-AGG-ID: v6QW6aFyPdi2E0Dzj7W4dw_1760450453
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC5A0180058A
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 14:00:52 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.198])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B57E4300018D; Tue, 14 Oct 2025 14:00:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/2] tests/functional: ensure GDB client is stopped on error
Date: Tue, 14 Oct 2025 15:00:47 +0100
Message-ID: <20251014140047.385347-3-berrange@redhat.com>
In-Reply-To: <20251014140047.385347-1-berrange@redhat.com>
References: <20251014140047.385347-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

If the reverse_debugging_run method fails, the GDB client will not
be closed resulting in python complaining about resource leaks.
Hoisting the GDB client creation into the caller allows this to
be cleaned up easily. While doing this, also move the VM shutdown
call to match.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/reverse_debugging.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index 2c37a62cd0..86fca8d81f 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -96,7 +96,14 @@ def reverse_debugging(self, gdb_arch, shift=7, args=None):
 
         try:
             self.log.info('Connecting to gdbstub...')
-            self.reverse_debugging_run(vm, port, gdb_arch, last_icount)
+            gdb_cmd = os.getenv('QEMU_TEST_GDB')
+            gdb = GDB(gdb_cmd)
+            try:
+                self.reverse_debugging_run(gdb, vm, port, gdb_arch, last_icount)
+            finally:
+                self.log.info('exiting gdb and qemu')
+                gdb.exit()
+                vm.shutdown()
             self.log.info('Test passed.')
         except GDB.TimeoutError:
             # Convert a GDB timeout exception into a unittest failure exception.
@@ -107,10 +114,7 @@ def reverse_debugging(self, gdb_arch, shift=7, args=None):
             # skipTest(), etc.
             raise
 
-    def reverse_debugging_run(self, vm, port, gdb_arch, last_icount):
-        gdb_cmd = os.getenv('QEMU_TEST_GDB')
-        gdb = GDB(gdb_cmd)
-
+    def reverse_debugging_run(self, gdb, vm, port, gdb_arch, last_icount):
         r = gdb.cli("set architecture").get_log()
         if gdb_arch not in r:
             self.skipTest(f"GDB does not support arch '{gdb_arch}'")
@@ -191,7 +195,3 @@ def reverse_debugging_run(self, vm, port, gdb_arch, last_icount):
             self.fail("'reverse-continue' did not hit the first PC in reverse order!")
 
         self.log.info('successfully reached %x' % steps[-1])
-
-        self.log.info('exiting gdb and qemu')
-        gdb.exit()
-        vm.shutdown()
-- 
2.50.1


