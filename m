Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB71E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNa04-0004Mr-En; Tue, 17 Dec 2024 11:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNa01-0004JV-Mr
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:00:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNZzv-000288-C5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734451233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2/PjAowauHLhm8ppho0o8dsbbcBzfqDvQw+ztoguZA=;
 b=Ox9/bpUxNYaCpwcdYwI/Gijmno92qDVF13CuLPet656EIBbV40aTPIgPqXTcBv3XP8zWzn
 712cNPwxJdZKJlUNKxT/Cot3MFe16kjkw9lbZyTgQHEyvv2ne9cb1MuABhqjRYyATCtS7i
 dMn1dDL40GigQ5E7o8zVG7ffLD0h6nQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-g-cDAI2lMcq08Dsej5_r3A-1; Tue,
 17 Dec 2024 11:00:29 -0500
X-MC-Unique: g-cDAI2lMcq08Dsej5_r3A-1
X-Mimecast-MFC-AGG-ID: g-cDAI2lMcq08Dsej5_r3A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 331AF19560B5; Tue, 17 Dec 2024 16:00:28 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC8D730044C1; Tue, 17 Dec 2024 16:00:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 10/32] tests/functional: add helpers for building file paths
Date: Tue, 17 Dec 2024 15:59:31 +0000
Message-ID: <20241217155953.3950506-11-berrange@redhat.com>
In-Reply-To: <20241217155953.3950506-1-berrange@redhat.com>
References: <20241217155953.3950506-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Add helper methods that construct paths for

 * log files - to be preserved at the end of a test
 * scratch files - to be purged at the end of a test
 * build files - anything relative to the build root
 * data files - anything relative to the functional test source root
 * socket files - a short temporary dir to avoid UNIX socket limits

These are to be used instead of direct access to the self.workdir,
or self.logdir variables, or any other place where paths are built
manually.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 95 ++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 90ae59eb54..89425b737c 100644
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
 
@@ -37,9 +39,99 @@ class QemuBaseTest(unittest.TestCase):
     log = None
     logdir = None
 
+    '''
+    Create a temporary directory suitable for storing UNIX
+    socket paths.
+
+    Returns: a tempfile.TemporaryDirectory instance
+    '''
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
+    Returns: string representing a file path
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
+    Returns: string representing a file path
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
+    Returns: string representing a file path
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
+    Returns: string representing a file path
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
@@ -65,6 +157,9 @@ def setUp(self, bin_prefix):
     def tearDown(self):
         if "QEMU_TEST_KEEP_SCRATCH" not in os.environ:
             shutil.rmtree(self.workdir)
+        if self.socketdir is not None:
+            shutil.rmtree(self.socketdir.name)
+            self.socketdir = None
         self.machinelog.removeHandler(self._log_fh)
         self.log.removeHandler(self._log_fh)
 
-- 
2.46.0


