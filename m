Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C282BC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 13:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tab1I-0005a1-1J; Wed, 22 Jan 2025 08:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tab14-0005Yx-Ov
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 08:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tab0y-0007FC-Kq
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 08:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737553407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kRYbkOsQHjzoJ8RrBaCEllpb6evC3e+/csnUQvpTj3g=;
 b=JoaR/QQROORVPi3wf0MvK4T56VVLsKaLu4/vfxwpqO3UiJNgPQaobFJVLqp35FD/0l1J/T
 fEtd91NR47XFvu3QqnddU7kagk74iEPdrJd3/WZXeCPAzoROh81SqZU0nILE3hIK6fXJu2
 CzCuA0BEQU+ortgWdT6lpslGREotwO0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-cF6o0ToRNAa8cltSNpGMmg-1; Wed,
 22 Jan 2025 08:43:24 -0500
X-MC-Unique: cF6o0ToRNAa8cltSNpGMmg-1
X-Mimecast-MFC-AGG-ID: cF6o0ToRNAa8cltSNpGMmg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01FC419560BD; Wed, 22 Jan 2025 13:43:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.246])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C2F1195608A; Wed, 22 Jan 2025 13:43:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	"Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] tests/functional: Fix broken decorators with lamda
 functions
Date: Wed, 22 Jan 2025 14:43:14 +0100
Message-ID: <20250122134315.1448794-3-thuth@redhat.com>
In-Reply-To: <20250122134315.1448794-1-thuth@redhat.com>
References: <20250122134315.1448794-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

The decorators that use a lambda function are currently broken
and do not properly skip the test if the condition is not met.
Using "return skipUnless(lambda: ...)" does not work as expected.
To fix it, rewrite the decorators without lambda, it's simpler
that way anyway.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


