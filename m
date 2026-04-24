Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B48FED3E6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGIgt-0003r3-2T; Fri, 24 Apr 2026 11:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wGIgT-00033b-Dr
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wGIgR-0007aV-R7
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777045386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujhNceZbLZrk0rqVrTeJI7/TEiCjUeSwasyi8BpHUyw=;
 b=QOVyRjJ7v/jO25A8nk8S8lHO3xV+moONxZFSYN7gt2pE7kng4zK5bqR0/dpmNqEbWjFeyi
 Qa6H1Po39CYfGnMNoopwRJAVyGMdWAW5iOkWpyHHY1Y/wdxVISUthUSEtZPde8bbmLJ/yk
 CQbQ76XdYRS92ejdHyiPDsYpZMUwomY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-f9PxNB7cNAauIfBTgHqajw-1; Fri,
 24 Apr 2026 11:43:04 -0400
X-MC-Unique: f9PxNB7cNAauIfBTgHqajw-1
X-Mimecast-MFC-AGG-ID: f9PxNB7cNAauIfBTgHqajw_1777045383
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D313719560B0; Fri, 24 Apr 2026 15:43:03 +0000 (UTC)
Received: from thinkbook.redhat.com (unknown [10.44.32.213])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62C3E1800348; Fri, 24 Apr 2026 15:43:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 14/16] tests: add QEMU_TEST_IO_SKIP for skipping I/O tests
Date: Fri, 24 Apr 2026 16:42:02 +0100
Message-ID: <20260424154205.364268-15-berrange@redhat.com>
In-Reply-To: <20260424154205.364268-1-berrange@redhat.com>
References: <20260424154205.364268-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The nature of block I/O tests is such that there can be unexpected false
positive failures in certain scenarios that have not been encountered
before, and sometimes non-deterministic failures that are hard to
reproduce.

Before enabling the I/O tests as gating jobs in CI, there needs to be a
mechanism to dynamically mark tests as skipped, without having to commit
code changes.

This introduces the QEMU_TEST_IO_SKIP environment variable that is set
to a list of FORMAT-OR-PROTOCOL:NAME pairs. The intent is that this
variable can be set as a GitLab CI pipeline variable to temporarily
disable a test while problems are being debugged.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/devel/testing/main.rst      |  7 +++++++
 tests/qemu-iotests/testrunner.py | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 797111009a..f779a64415 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -284,6 +284,13 @@ that are specific to certain cache mode.
 More options are supported by the ``./check`` script, run ``./check -h`` for
 help.
 
+If a test program is known to be broken, it can be disabled by setting
+the ``QEMU_TEST_IO_SKIP`` environment variable with a list of tests to
+be skipped. The values are of the form FORMAT-OR-PROTOCOL:NAME, the
+leading component can be omitted to skip the test for all formats and
+protocols. For example ``export QEMU_TEST_IO_SKIP="luks:149 185 iov-padding``
+will skip ``149`` for LUKS only, and ``185`` and ``iov-padding`` for all.
+
 Writing a new test case
 ~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index dbe2dddc32..ecb5d4529f 100644
--- a/tests/qemu-iotests/testrunner.py
+++ b/tests/qemu-iotests/testrunner.py
@@ -145,6 +145,18 @@ def __init__(self, env: TestEnv, tap: bool = False,
 
         self._stack: contextlib.ExitStack
 
+        self.skip = {}
+        for rule in os.environ.get("QEMU_TEST_IO_SKIP", "").split(" "):
+            rule = rule.strip()
+            if rule == "":
+                continue
+            if ":" in rule:
+                fmt, name = rule.split(":")
+                if fmt in ("", env.imgfmt, env.imgproto):
+                    self.skip[name] = True
+            else:
+                self.skip[rule] = True
+
     def __enter__(self) -> 'TestRunner':
         self._stack = contextlib.ExitStack()
         self._stack.enter_context(self.env)
@@ -251,6 +263,10 @@ def do_run_test(self, test: str) -> TestResult:
                               description='No qualified output '
                                           f'(expected {f_reference})')
 
+        if f_test.name in self.skip:
+            return TestResult(status='not run',
+                              description='Listed in QEMU_TEST_IO_SKIP')
+
         args = [str(f_test.resolve())]
         env = self.env.prepare_subprocess(args)
 
-- 
2.53.0


