Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC132C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 06:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta8Df-00052W-E4; Tue, 21 Jan 2025 01:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ta8Dd-00052K-IG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 01:58:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ta8Da-0000n3-Rp
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 01:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737442713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g3C9tESw9lcwieDeyNzK/YNWLWBU59pAFfURA6LTMSE=;
 b=GxLgN0A/4Ue5Oijeg53k3RvmCzGgn04nwejeWRD2EQsav/49/TZGo6DhssVZOZGQYFtu5p
 yzjuc9FqDpc909mxPJur6Kc8Cyv8bEVjuQuQ0tgrc9WkyWSx9mqAE8VBG9msBjKLX5pb5M
 V4N5rG9YfVwNM1ChPgMkuESU/XCIuVo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-aBLi1rooN_62MGEsmoihfg-1; Tue,
 21 Jan 2025 01:58:28 -0500
X-MC-Unique: aBLi1rooN_62MGEsmoihfg-1
X-Mimecast-MFC-AGG-ID: aBLi1rooN_62MGEsmoihfg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6D311955DDE; Tue, 21 Jan 2025 06:58:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.56])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 569AD3003E7F; Tue, 21 Jan 2025 06:58:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/functional: Fix broken decorators with lamda functions
Date: Tue, 21 Jan 2025 07:58:14 +0100
Message-ID: <20250121065814.1092720-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
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

skipIfMissingImports also needs to exec() the import statement,
otherwise we always try to import a module called "impname" which
does not exist.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 I've noticed the problem while trying to get the migration test
 through the CI:
 https://gitlab.com/thuth/qemu/-/jobs/8901960783#L100
 ... the OpenSUSE containers apparently lack the "nc" binary ...

 tests/functional/qemu_test/decorators.py | 44 +++++++++++-------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index df088bc090..7750af7b7d 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -16,15 +16,14 @@
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
@@ -35,9 +34,9 @@ def has_cmds(cmdlist):
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
@@ -94,14 +93,13 @@ def skipBigDataTest():
   @skipIfMissingImports("numpy", "cv2")
 '''
 def skipIfMissingImports(*args):
-    def has_imports(importlist):
-        for impname in importlist:
-            try:
-                import impname
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
+            exec('import %s' % impname)
+        except ImportError:
+            has_imports = False
+            break
+
+    return skipUnless(has_imports, 'required import(s) "%s" not installed' %
+                                   ", ".join(args))
-- 
2.48.1


