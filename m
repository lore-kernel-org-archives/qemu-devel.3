Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B887FE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 17:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLQUg-0005Xz-LY; Wed, 11 Dec 2024 12:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQUf-0005XE-Od
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:27:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQUe-00017m-5U
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733938043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=je0Q9NXkq5uthrqsKXN+C51FrUK7oicX8qQRoXsGIpA=;
 b=AyoBAiriv0Vs8ZuzHJ7Az1jdpuh1t/B5Xkk6nuPqiZOeJt+1DgbWcw7ASCq3lUyxdKG6aU
 G88wsdLoTru3fr1VFZHnlqVV33AYlQzkX+yLmw/y2/haqgAVnFzGWoHmLovGvixBXfK6dZ
 18+MjfqqetdR2bcLc84pjaQMvRWSTc4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-x_HnDPWpN-qfU53UZfyGcA-1; Wed,
 11 Dec 2024 12:27:22 -0500
X-MC-Unique: x_HnDPWpN-qfU53UZfyGcA-1
X-Mimecast-MFC-AGG-ID: x_HnDPWpN-qfU53UZfyGcA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D711E19560A3; Wed, 11 Dec 2024 17:27:20 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF49A1956048; Wed, 11 Dec 2024 17:27:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 09/31] tests/functional: add helpers for building file paths
Date: Wed, 11 Dec 2024 17:26:25 +0000
Message-ID: <20241211172648.2893097-10-berrange@redhat.com>
In-Reply-To: <20241211172648.2893097-1-berrange@redhat.com>
References: <20241211172648.2893097-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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


