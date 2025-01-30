Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF30CC0218F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUOt-0007N2-9Y; Thu, 30 Jan 2025 08:16:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOe-0007Ii-JK
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:15:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOa-0008Ru-Fj
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738242947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxNpJ8n0NWJQONfwOlrs4HtxhS2jsCl2PTU9UmWLjO4=;
 b=MvJ5CMOiThUxqpVnV9JNJYnZXW02+eTJB+XNWn9DnbveTA/xseWMd3tiQu80JJSTYcWbXG
 yDT83PLNIwbPp7UpiGqh1IkoooPeRPg13l7UVRQ7faZl/giXxXxno60Ga+XunSGDgjfgvV
 lHOLLbjUp0xm7WD54hH6oGDCNUw2S+U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-oQvf1_U_OziYPLWn4CDTSg-1; Thu,
 30 Jan 2025 08:15:43 -0500
X-MC-Unique: oQvf1_U_OziYPLWn4CDTSg-1
X-Mimecast-MFC-AGG-ID: oQvf1_U_OziYPLWn4CDTSg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22D3B1800361
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:15:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A47F230001BE; Thu, 30 Jan 2025 13:15:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 02/20] tests/functional: Fix broken decorators with lamda
 functions
Date: Thu, 30 Jan 2025 14:15:16 +0100
Message-ID: <20250130131535.91297-3-thuth@redhat.com>
In-Reply-To: <20250130131535.91297-1-thuth@redhat.com>
References: <20250130131535.91297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The decorators that use a lambda function are currently broken
and do not properly skip the test if the condition is not met.
Using "return skipUnless(lambda: ...)" does not work as expected.
To fix it, rewrite the decorators without lambda, it's simpler
that way anyway.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250122134315.1448794-3-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/decorators.py | 44 +++++++++++-------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index 08f58f6b40..3d9c02fd59 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -17,15 +17,14 @@
   @skipIfMissingCommands("mkisofs", "losetup")
 '''
 def skipIfMissingCommands(*args):
-    def has_cmds(cmdlist):
-        for cmd in cmdlist:
-            if not which(cmd):
-                return False
-        return True
-
-    return skipUnless(lambda: has_cmds(args),
-                      'required command(s) "%s" not installed' %
-                      ", ".join(args))
+    has_cmds = True
+    for cmd in args:
+         if not which(cmd):
+             has_cmds = False
+             break
+
+    return skipUnless(has_cmds, 'required command(s) "%s" not installed' %
+                                ", ".join(args))
 
 '''
 Decorator to skip execution of a test if the current
@@ -36,9 +35,9 @@ def has_cmds(cmdlist):
   @skipIfNotMachine("x86_64", "aarch64")
 '''
 def skipIfNotMachine(*args):
-    return skipUnless(lambda: platform.machine() in args,
-                        'not running on one of the required machine(s) "%s"' %
-                        ", ".join(args))
+    return skipUnless(platform.machine() in args,
+                      'not running on one of the required machine(s) "%s"' %
+                      ", ".join(args))
 
 '''
 Decorator to skip execution of flaky tests, unless
@@ -95,14 +94,13 @@ def skipBigDataTest():
   @skipIfMissingImports("numpy", "cv2")
 '''
 def skipIfMissingImports(*args):
-    def has_imports(importlist):
-        for impname in importlist:
-            try:
-                importlib.import_module(impname)
-            except ImportError:
-                return False
-        return True
-
-    return skipUnless(lambda: has_imports(args),
-                      'required import(s) "%s" not installed' %
-                      ", ".join(args))
+    has_imports = True
+    for impname in args:
+        try:
+            importlib.import_module(impname)
+        except ImportError:
+            has_imports = False
+            break
+
+    return skipUnless(has_imports, 'required import(s) "%s" not installed' %
+                                   ", ".join(args))
-- 
2.48.1


