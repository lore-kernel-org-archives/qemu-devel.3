Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47088CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9QoR-00038v-1r; Thu, 16 Oct 2025 12:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9QoJ-00030f-8F
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:26:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9QoC-000521-EY
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760631988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/tlXzgBzM8e2qGuGsn/nSQgKG9h2gm308BZ+u3+MbPQ=;
 b=To2/gmRIjnfS5VGyXlaEsivY2xfh8BDdRqiv3BVHNkdwmadETFlZfUMbNQjIpPQ4SIYGFH
 2K/MJXxOf0VlpibdEBrJsuTxwcpuRq42vfIHOfMo8AUdztMuJ5cCSFxaPZOEGM3U53eZkT
 lt/FDbupK6cGGrcrt+3waEJOHGE20ns=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-jX_VSIKOOnmCBmvalqthMQ-1; Thu,
 16 Oct 2025 12:26:24 -0400
X-MC-Unique: jX_VSIKOOnmCBmvalqthMQ-1
X-Mimecast-MFC-AGG-ID: jX_VSIKOOnmCBmvalqthMQ_1760631983
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 673681800675; Thu, 16 Oct 2025 16:26:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.163])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEFC41956056; Thu, 16 Oct 2025 16:26:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 08/10] tests/functional: ensure GDB client is stopped on error
Date: Thu, 16 Oct 2025 18:25:59 +0200
Message-ID: <20251016162601.442557-9-thuth@redhat.com>
In-Reply-To: <20251016162601.442557-1-thuth@redhat.com>
References: <20251016162601.442557-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

If the reverse_debugging_run method fails, the GDB client will not
be closed resulting in python complaining about resource leaks.
Hoisting the GDB client creation into the caller allows this to
be cleaned up easily. While doing this, also move the VM shutdown
call to match.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251014140047.385347-3-berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/reverse_debugging.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index 2c37a62cd06..86fca8d81f1 100644
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
2.51.0


