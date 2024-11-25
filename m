Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF60D58D5D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFatn-0003ws-Gt; Mon, 25 Nov 2024 10:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatk-0003uy-S7
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:12 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFath-0001js-Hl
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:12 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-382433611d0so3891427f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548068; x=1733152868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2LvUWK0oXyNULzh/PoP5B4uyQP6aDypt8ae/Sui1l0=;
 b=AGqP9kDrBkKHlDLOERGUgRimaUr3FCS7HAQImFWXHgtafd9ICndOdwPkiJF9Rk9sUg
 hLoi/fRncU1PG0fDhaZqabq3L5Kxgqa0zgRzdPBm7qkydciuk1HSGg8znX/iDMoGa8qH
 XtuhOY7I5LHxyZZOPYiGPzOMQYIeEujfOwKGtqzTdY1PGQnrIIHUURY820PQxYUBJ48A
 tqVnQL+WEiVuw28zBQzfCvw/4q6Dgn/vVme97BlMwZCEnVrqrjGP3tmCa11Gs0C552Mw
 YjrH8JkIGw1l9T9ihJRkM7ivdszVB2hOXa2ZSQdjXjxuO/baoirDe99dD+hiahQtmSHt
 4bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548068; x=1733152868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2LvUWK0oXyNULzh/PoP5B4uyQP6aDypt8ae/Sui1l0=;
 b=qM+3TtdHJuN1UwxXLWAr/MKnQv0XEJJMkQlyEwsis6gDsXzzgdSJjTx4HxTcHIuxYq
 rPzFWf7BqXqCjpTl2558uE0Ovv9uSlhXfN112KLQgesTGSMu7XAp78s2HQ3/k4CP6FYR
 fdlH+UINkYV9tHVS07TkdA1HrovfVa9/8ZWdHhUqL1B6m8uqZVMsDUv7mTgy2JaQqaoG
 oglneFLbuLwQlgUOsbsmfJP3NWGAhLlVjPhvM440i5xQBq+4N8cGcvxkl3whJKlZpnGw
 w0zz0fxGQuMcoYmUD/o0+jdbB4grXcwn6UTB+RsYdpgH2RIQECclqPpVGv5gK4hxnQ8h
 FbuQ==
X-Gm-Message-State: AOJu0YwbfaQ9StmgoI7EKhYamYs74aOzWJqTPdUQddWJ4vjtOCRQ41YZ
 WWwnfSC0xaZIxEUBEF2rM/uUB8rzGATwfFuartFzejmTI3oZ36YTbhLwfcoSYOg=
X-Gm-Gg: ASbGncshmGmA22fc3PRdiYhqNv32Wc4wLlXL8EYB2YX6XZ+om2qzZpratLBbaXKFrig
 K2pqUpDJ2pfF6mVI0CSmRDRSJaEfFyv/aJ+GIKwpKDa+AO3FsQnxpmSL+tON02UUIde1r9XbfXW
 ZeMRBxa7r7Tv6xJn5b4VR+H4rs6C5iZVELqtY7DA28LcreilFV3xD2zTwQSnGsWP7teFe5WiSSE
 CTudsB3mt9/AYBieIV7hQ48flJV84ThMc2i4F8u/4bL/Ge5
X-Google-Smtp-Source: AGHT+IH0j5Dau9BvakrrsFuRV0m2i/pKx8mBp1Xedx6g9OPPxpfNeWmDY2QsLnclKs63as0MYEupVw==
X-Received: by 2002:a05:6000:184d:b0:382:465f:336d with SMTP id
 ffacd0b85a97d-38260b3cabbmr15409059f8f.1.1732548067824; 
 Mon, 25 Nov 2024 07:21:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fafe147sm10577475f8f.30.2024.11.25.07.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0303B5F8FE;
 Mon, 25 Nov 2024 15:21:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/28] tests/functional: automatically clean up scratch files
 after tests
Date: Mon, 25 Nov 2024 15:20:39 +0000
Message-Id: <20241125152105.2100395-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The build/tests/functional subdirectories are consuming huge amounts
of disk space.

Split the location for scratch files into a 'scratch' sub-directory,
separate from log files, and delete it upon completion of each test.
The new env variable QEMU_TEST_KEEP_SCRATCH can be set to preserve
this scratch dir for debugging access if required.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-3-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-3-alex.bennee@linaro.org>

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
2.39.5


