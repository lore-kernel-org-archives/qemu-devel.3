Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC3CC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 06:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubvLC-0001EM-7y; Wed, 16 Jul 2025 02:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubvJU-0008Ao-E6
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 02:08:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubvJN-00074P-T8
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 02:08:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4561a4a8bf2so29402725e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 23:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752646092; x=1753250892; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rv3jPEdrdbgbAagDt9LzI7yRG1cPhbgwBJNfUgbNUig=;
 b=O7Yby4cPz2S+zNmQd7NcuFTFGU/0knmD+gJRnuMQQm+bnB5o2tzzaRWbYWjLZD2QTl
 vgrwHhr06pySsNm13KPV2bD8vc3ea6WkLB1FS93c04n6TYqviGC3OROMP+ougp5jR79l
 uuO0wYqURydrc1NQSGGB9gGX14JQK2h3CgclN6tKxgUoEtNhz44RUgbCOHvCTOURBxwj
 eCAfyekzI7IAUy2hA2Kpema56H6wXeJgyb0w7c+WprvazxIzbwTYqdZ/9vHVeXUOQhHk
 oblk0XmJqvLioe8WGNEckQ+z1bl8Br1bBnHSd/AEX2vzryUOXVbhLMvFkME8AWSkcOte
 WC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752646092; x=1753250892;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rv3jPEdrdbgbAagDt9LzI7yRG1cPhbgwBJNfUgbNUig=;
 b=Nqtg4La6/cmwuXHhkZT3rBj9+omdpWPLwFPOPSfroj9JjqldsFdW9bAIg5uFxMZhvQ
 tODzgXV9h7CHTnHnmXZqPErMMFa066yI0JpofsRshb4ZX0fJtTif7zyw0KuZLeYATfSo
 FO3jIa3LnoiUTSuaoVkXrsWkINglun5/zQWbDZkuq/fwF0sWLbT18jQLOjB2R1hFXCeX
 P45oQ1LtrWZHLhv8aUx8PMn4pgjK2f0F/RmOsRti2B0gaTHevGOcw4xFpwJhj2uitMmZ
 YmdpDuwZwPL/TMsDRg+IB/8rrRzgh0ghcaEyeBYoFwhRDbJDd6V2MsgNDXecNMASPglF
 CGqw==
X-Gm-Message-State: AOJu0YxG/6+TZeU9h7a0hRO2ckXLsyu74YZwX+piqq92C56HyKn7qOc5
 hG0Gu7/GKDpI4vfd/5ymbDwnTEALLKnpN61Ztt0N5CkCBAg7sjmkGFMp0tIxCX7L0/8=
X-Gm-Gg: ASbGnctqhcLIDbJ3f8LbAKfpfJZB7OF9VWfNs5L+5nSg7d52SxV1zpM6tM/D9aS34V+
 h6Zf5KSA5L9xvfCHtJV5kDxcp4msQ8c2xtpFkqUG+bSvizH1VfTGlPle58JufNqAZJDOBV9fAaQ
 zIV8giY1SeteJA1PFzfCy4tKliHAa9lnwhPIzLYhWIh74rbOzvsrPR7QuwoNW39wd6gAFUemKuI
 XKR4BXEqxwmI9FiHgqkM8MYM0wRRJn7+l0iYU1RHdzttKFvmfa23Bs+Ds0nE/SLdkyh3Qg6VZIF
 wYg52MUBkCeOZw7ycFVcsnp34gUaoMu6sB7Tp7xtAgFk8/sdWLH6yAl65ZMVZdN+Coiv53We2a3
 MS46L4dAL/1l3nh+aletNJjxcRBPI+n2JT51xyUf4s8Y2j9Z4yG3Q4fX3a5Qtc5g/PznLDqfCIL
 GJzg==
X-Google-Smtp-Source: AGHT+IEvTxtJgm6k97ioR8jCd88CfKfIMd5cQFbd21x7QYu2eJu6GesOlBdN9D/5KldFZY8IR7ActQ==
X-Received: by 2002:a05:6000:40d9:b0:3b4:4876:9088 with SMTP id
 ffacd0b85a97d-3b60e510003mr684087f8f.46.1752646091818; 
 Tue, 15 Jul 2025 23:08:11 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b6039bdea0sm8014493f8f.65.2025.07.15.23.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 23:08:11 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 16 Jul 2025 09:08:00 +0300
Subject: [PATCH] tests/functional: add --debug CLI arg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
X-B4-Tracking: v=1; b=H4sIAL9Bd2gC/x3M0QqEIBBA0V+JeU6wFov6lQgZa3QHwsKxZUH69
 5V9PHC5BYQSk8DcFEj0YeEzVnRtA9sbYyDFezX0ujd67Abl77jlGuFhM0kWu5O7g8UUFKJG4wc
 3vUYDdXAl8vz9z5f1eX47O4SYbAAAAA==
X-Change-ID: 20250716-functional_tests_debug_arg-aa0a5f6b9375
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5981;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=MiSs7UvTYhbtyskBm5gctEZkrIRRjUVb/TsFHm9i2lE=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9kMEhLOWh3S0Zkend2V01GeEdPcVNJWVhKWnk1CnRid2o3UkNRQ0hnZE80OVdr
 U0dKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUhkQnlnQUt
 DUkIzS2Nkd2YzNEowQlFlRC85Zng2QXVNQTRUVUZhcFEvelVWZGxNWWtpQ1RmQzJQaWxFWHRsdQ
 pwWFhIRXVQaXBNRzNsWWZkSFBob1hvZTAzWFEvQjNvMXp5NUFXdW02ckFLUnM0RkgwbXRYQjJzb
 HI3ZjVlazhJCjE4VHBqYWV3ZDlNV25QY2x5Q25pWUVpRXVhSG9oZ2ZCcm1qdTdNU09OcjJob3k2
 NWFCQlg5RWxoU0dWVzRvNE4KUlV2OHBHRjBlUC9xSXNFL004MmlMRVZEc2VEaG5GbXFuUWZpMjV
 FQ1ZzM3dNOHd1aWx0azFCMUFmb1ByVnZSUApXeXRzT1hLdThnOEZIQXA5L0ZRRzZzYmtoeUMyak
 NSSDNLenl1eFJxbS96SlFzV1V6b3p6aEs5a0ZET25Lai94CjRIRU9HeTJPT2kxMnBhbXRHU3hoO
 HpmR25ZY0JLYXVtQzVGd3pMN2xNa21maXlRbVFadWRvY1hSR1lNVnBWclIKN0xvSmo3T2dmY3Vn
 OGRVL3lEQnhvVkFpZlJVOENxY3dmUTlLakFadzh6b3FTc2xxQnU4VXBNRTA0SkRweVplVgpzZnR
 3SVhHRGQ5ZXc3bE03U1dnb3RhYWZBNk5VSG9qTm9FMWpJdnIxOXhrL2VXQWRuc0F4QWFyeW1RdX
 RDY3lGCmhacGhFTGQvczh0UUlReHRWYjVxQ0F2Y3lpN2hNTk5CbGppeFd6ZU5PTHMvMVVPbTVKN
 2ZkMWZ6ZnViMVhkVFAKL1Q3S0E3dkUxU2ZYWDMwbGxaQVk3RHRlcmJ1Zk9GMXVoZUxQRE0wV1I2
 c3YxdXZqcXZCVnFGUWNDTVEvREF4LwpoR21POEUwMzJnd2xTZHRvbmFKdFUyV0RKNEFuTlJUL3d
 HT1NsNVJYM3JPdC9seEVkWStrYjJ0MG9FbVpOd1lNCnFmNlBZdz09Cj1IZ2lGCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

Add argument parsing to functional tests to improve developer experience
when running individual tests. All logs are printed to stdout
interspersed with TAP output.

  ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --help
  usage: test_aarch64_virt [-h] [-d]

  QEMU Functional test

  options:
    -h, --help   show this help message and exit
    -d, --debug  Also print test and console logs on stdout. This will
                 make the TAP output invalid and is meant for debugging
                 only.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 docs/devel/testing/functional.rst      |  2 ++
 tests/functional/qemu_test/testcase.py | 51 ++++++++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index 9e56dd1b1189216b9b4aede00174c15203f38b41..9d08abe2848277d635befb0296f578cfaa4bd66d 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -63,6 +63,8 @@ directory should be your build folder. For example::
   $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
   $ pyvenv/bin/python3 ../tests/functional/test_file.py
 
+By default, functional tests redirect informational logs and console output to
+log files. Specify the ``--debug`` flag to also print those to standard output.
 The test framework will automatically purge any scratch files created during
 the tests. If needing to debug a failed test, it is possible to keep these
 files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=1``` as an env
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 2082c6fce43b0544d4e4258cd4155f555ed30cd4..fad7a946c6677e9ef5c42b8f77187ba836c11aeb 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -11,6 +11,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import argparse
 import logging
 import os
 from pathlib import Path
@@ -31,6 +32,20 @@
 from .uncompress import uncompress
 
 
+def parse_args(test_name: str) -> argparse.Namespace:
+    parser = argparse.ArgumentParser(
+        prog=test_name, description="QEMU Functional test"
+    )
+    parser.add_argument(
+        "-d",
+        "--debug",
+        action="store_true",
+        help="Also print test and console logs on stdout. This will make the"
+        " TAP output invalid and is meant for debugging only.",
+    )
+    return parser.parse_args()
+
+
 class QemuBaseTest(unittest.TestCase):
 
     '''
@@ -196,6 +211,9 @@ def assets_available(self):
         return True
 
     def setUp(self):
+        path = os.path.basename(sys.argv[0])[:-3]
+        args = parse_args(path)
+        self.debug_output = args.debug
         self.qemu_bin = os.getenv('QEMU_TEST_QEMU_BINARY')
         self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
         self.arch = self.qemu_bin.split('-')[-1]
@@ -221,6 +239,16 @@ def setUp(self):
         self.machinelog.setLevel(logging.DEBUG)
         self.machinelog.addHandler(self._log_fh)
 
+        if self.debug_output:
+            handler = logging.StreamHandler(sys.stdout)
+            handler.setLevel(logging.DEBUG)
+            formatter = logging.Formatter(
+                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
+            )
+            handler.setFormatter(formatter)
+            self.log.addHandler(handler)
+            self.machinelog.addHandler(handler)
+
         if not self.assets_available():
             self.skipTest('One or more assets is not available')
 
@@ -230,11 +258,16 @@ def tearDown(self):
         if self.socketdir is not None:
             shutil.rmtree(self.socketdir.name)
             self.socketdir = None
-        self.machinelog.removeHandler(self._log_fh)
-        self.log.removeHandler(self._log_fh)
+        for handler in [self._log_fh, logging.StreamHandler(sys.stdout)]:
+            self.machinelog.removeHandler(handler)
+            self.log.removeHandler(handler)
 
     def main():
         path = os.path.basename(sys.argv[0])[:-3]
+        # If argparse receives --help or an unknown argument, it will raise a
+        # SystemExit which will get caught by the test runner. Parse the
+        # arguments here too to handle that case.
+        _ = parse_args(path)
 
         cache = os.environ.get("QEMU_TEST_PRECACHE", None)
         if cache is not None:
@@ -292,6 +325,14 @@ def setUp(self):
         fileFormatter = logging.Formatter('%(asctime)s: %(message)s')
         self._console_log_fh.setFormatter(fileFormatter)
         console_log.addHandler(self._console_log_fh)
+        if self.debug_output:
+            handler = logging.StreamHandler(sys.stdout)
+            handler.setLevel(logging.DEBUG)
+            formatter = logging.Formatter(
+                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
+            )
+            handler.setFormatter(formatter)
+            console_log.addHandler(handler)
 
     def set_machine(self, machinename):
         # TODO: We should use QMP to get the list of available machines
@@ -398,5 +439,9 @@ def set_vm_arg(self, arg, value):
     def tearDown(self):
         for vm in self._vms.values():
             vm.shutdown()
-        logging.getLogger('console').removeHandler(self._console_log_fh)
+        for handler in [
+            self._console_log_fh,
+            logging.StreamHandler(sys.stdout),
+        ]:
+            logging.getLogger("console").removeHandler(handler)
         super().tearDown()

---
base-commit: c079d3a31e45093286c65f8ca5350beb3a4404a9
change-id: 20250716-functional_tests_debug_arg-aa0a5f6b9375

--
γαῖα πυρί μιχθήτω


