Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351F5D729EC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4qW-0003dR-PA; Fri, 29 Nov 2024 12:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qT-0003Yz-Pj
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:31:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qN-0000u6-E6
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732901510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEBCRp8R1crKHkbALhGxflpLWO/EX7699lt8TYrhwA8=;
 b=hXHQdvRy9qygNqsKDP4jVpnWInDyjUJFSgc2N3mWzn+Wh1/EzgmCZyFmi5GgWSL5ilNBRl
 mZV97Aiohh/zMSB41n7/RTIrwjuAozy1V+GCqyvnZbQ+lgtp7BiqnwbIm+AV8LgnDYvef+
 9kEueTxyF9wZu5LxXn/19DU2hFia3yU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-ScLcTQlCM0GOUlYoTZE2yQ-1; Fri,
 29 Nov 2024 12:31:47 -0500
X-MC-Unique: ScLcTQlCM0GOUlYoTZE2yQ-1
X-Mimecast-MFC-AGG-ID: ScLcTQlCM0GOUlYoTZE2yQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED4EC1955DCA; Fri, 29 Nov 2024 17:31:45 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 325DE1955F41; Fri, 29 Nov 2024 17:31:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 08/22] tests/functional: add helpers for building file paths
Date: Fri, 29 Nov 2024 17:31:06 +0000
Message-ID: <20241129173120.761728-9-berrange@redhat.com>
In-Reply-To: <20241129173120.761728-1-berrange@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

Add helper methods that construct paths for

 * log files - to be preserved at the end of a test
 * scratch files - to be purged at the end of a test
 * build files - anything relative to the build root
 * data files - anything relative to the functional test source root
 * socket files - a short temporary dir to avoid UNIX socket limits

These are to be used instead of direct access to the self.workdir,
or self.logdir variables, or any other place where paths are built
manually.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 86 ++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 90ae59eb54..fb62052817 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -13,10 +13,12 @@
 
 import logging
 import os
+from pathlib import Path
 import pycotap
 import shutil
 import subprocess
 import sys
+import tempfile
 import unittest
 import uuid
 
@@ -37,9 +39,93 @@ class QemuBaseTest(unittest.TestCase):
     log = None
     logdir = None
 
+    def socket_dir(self):
+        if self.socketdir is None:
+            self.socketdir = tempfile.TemporaryDirectory(
+                prefix="qemu_func_test_sock_")
+        return self.socketdir
+
+    '''
+    @params args list of zero or more subdirectories or file
+
+    Construct a path for accessing a data file located
+    relative to the source directory that is the root for
+    functional tests.
+
+    @args may be an empty list to reference the root dir
+    itself, may be a single element to reference a file in
+    the root directory, or may be multiple elements to
+    reference a file nested below. The path components
+    will be joined using the platform appropriate path
+    separator.
+
+    Returns: a qualified path
+    '''
+    def data_file(self, *args):
+        return str(Path(Path(__file__).parent.parent, *args))
+
+    '''
+    @params args list of zero or more subdirectories or file
+
+    Construct a path for accessing a data file located
+    relative to the build directory root.
+
+    @args may be an empty list to reference the build dir
+    itself, may be a single element to reference a file in
+    the build directory, or may be multiple elements to
+    reference a file nested below. The path components
+    will be joined using the platform appropriate path
+    separator.
+
+    Returns: a qualified path
+    '''
+    def build_file(self, *args):
+        return str(Path(BUILD_DIR, *args))
+
+    '''
+    @params args list of zero or more subdirectories or file
+
+    Construct a path for accessing/creating a scratch file
+    located relative to a temporary directory dedicated to
+    this test case. The directory and its contents will be
+    purged upon completion of the test.
+
+    @args may be an empty list to reference the scratch dir
+    itself, may be a single element to reference a file in
+    the scratch directory, or may be multiple elements to
+    reference a file nested below. The path components
+    will be joined using the platform appropriate path
+    separator.
+
+    Returns: a qualified path
+    '''
+    def scratch_file(self, *args):
+        return str(Path(self.workdir, *args))
+
+    '''
+    @params args list of zero or more subdirectories or file
+
+    Construct a path for accessing/creating a log file
+    located relative to a temporary directory dedicated to
+    this test case. The directory and its log files will be
+    preserved upon completion of the test.
+
+    @args may be an empty list to reference the log dir
+    itself, may be a single element to reference a file in
+    the log directory, or may be multiple elements to
+    reference a file nested below. The path components
+    will be joined using the platform appropriate path
+    separator.
+
+    Returns: a pathlib.Path object
+    '''
+    def log_file(self, *args):
+        return str(Path(self.logdir, *args))
+
     def setUp(self, bin_prefix):
         self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
         self.arch = self.qemu_bin.split('-')[-1]
+        self.socketdir = None
 
         self.outputdir = os.path.join(BUILD_DIR, 'tests', 'functional',
                                       self.arch, self.id())
-- 
2.46.0


