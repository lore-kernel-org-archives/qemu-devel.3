Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26D0D44167
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 15:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDPnT-0005mA-L0; Tue, 19 Nov 2024 10:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDPnQ-0005jX-Ih
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:05:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDPnP-0003gA-29
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732028738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B2lxy2lq0R8mXsbS7AtbFcVFuswhiZYcx09bEedRGO8=;
 b=FerL49XCUNlsC0E2NRXt/LR3OuvgCL0VhN/bZXuFVv6Cf92nZV8XGb3e8w/h0yGtyQWABb
 +hQLDmEDkEZrfFaZTNlBRzN6w/gXGz5NZ4REAhtRODQXtAbSy36IS42G50QTZZ5h3bDXPM
 uWaJwSAMaiPq4YKfEyz1709fpFDnCYw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-3kP7mMYbMcG23wopYga1fw-1; Tue,
 19 Nov 2024 10:05:30 -0500
X-MC-Unique: 3kP7mMYbMcG23wopYga1fw-1
X-Mimecast-MFC-AGG-ID: 3kP7mMYbMcG23wopYga1fw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66BA119540F0; Tue, 19 Nov 2024 15:05:29 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCC5D19560A3; Tue, 19 Nov 2024 15:05:26 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 02/15] tests/functional: automatically clean up scratch files
 after tests
Date: Tue, 19 Nov 2024 15:05:06 +0000
Message-ID: <20241119150519.1123365-3-berrange@redhat.com>
In-Reply-To: <20241119150519.1123365-1-berrange@redhat.com>
References: <20241119150519.1123365-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
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

The build/tests/functional subdirectories are consuming huge amounts
of disk space.

Split the location for scratch files into a 'scratch' sub-directory,
separate from log files, and delete it upon completion of each test.
The new env variable QEMU_TEST_KEEP_SCRATCH can be set to preserve
this scratch dir for debugging access if required.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/devel/testing/functional.rst      |  6 ++++++
 tests/functional/qemu_test/testcase.py | 14 +++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index bf6f1bb81e..6b5d0c5b98 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -65,6 +65,12 @@ to the QEMU binary that should be used for the test, for example::
   $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
   $ python3 ../tests/functional/test_file.py
 
+The test framework will automatically purge any scratch files created during
+the tests. If needing to debug a failed test, it is possible to keep these
+files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=1``` as an env
+variable.  Any preserved files will be deleted the next time the test is run
+without this variable set.
+
 Overview
 --------
 
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 411978b5ef..b9418e2ac0 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -13,8 +13,9 @@
 
 import logging
 import os
-import subprocess
 import pycotap
+import shutil
+import subprocess
 import sys
 import unittest
 import uuid
@@ -40,11 +41,12 @@ def setUp(self, bin_prefix):
         self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
         self.arch = self.qemu_bin.split('-')[-1]
 
-        self.workdir = os.path.join(BUILD_DIR, 'tests/functional', self.arch,
-                                    self.id())
+        self.outputdir = os.path.join(BUILD_DIR, 'tests', 'functional',
+                                      self.arch, self.id())
+        self.workdir = os.path.join(self.outputdir, 'scratch')
         os.makedirs(self.workdir, exist_ok=True)
 
-        self.logdir = self.workdir
+        self.logdir = self.outputdir
         self.log_filename = os.path.join(self.logdir, 'base.log')
         self.log = logging.getLogger('qemu-test')
         self.log.setLevel(logging.DEBUG)
@@ -56,6 +58,8 @@ def setUp(self, bin_prefix):
         self.log.addHandler(self._log_fh)
 
     def tearDown(self):
+        if "QEMU_TEST_KEEP_SCRATCH" not in os.environ:
+            shutil.rmtree(self.workdir)
         self.log.removeHandler(self._log_fh)
 
     def main():
@@ -108,7 +112,7 @@ def setUp(self):
 
         console_log = logging.getLogger('console')
         console_log.setLevel(logging.DEBUG)
-        self.console_log_name = os.path.join(self.workdir, 'console.log')
+        self.console_log_name = os.path.join(self.logdir, 'console.log')
         self._console_log_fh = logging.FileHandler(self.console_log_name,
                                                    mode='w')
         self._console_log_fh.setLevel(logging.DEBUG)
-- 
2.46.0


