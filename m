Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C439C9EC88
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHo5-0002pO-89; Mon, 12 Jan 2026 08:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlP-0001S9-JZ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlO-0002Wb-0r
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768223717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10XZMlig4LGw9p0kOKwBqLurpUaIpsrfkUplGVNrEW0=;
 b=SQQBqjiZ/89/nQ8C2L8oRfjeQ+n3hf1Epe23Kt3chVSIOUtOgxXL0s3frn1X728KHyeDfI
 NOW0jy3qKxBsESiCG8fw5dWuZZ2a/uYJoBVIr+8cONFPCPOkyjUz2vy3q+i+Lpp96+P0pO
 nxfDy1X/IWwwZo94YX0Ok7XUDSbsFVs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-BkLs4P87PjGmXX1qo96UHA-1; Mon,
 12 Jan 2026 08:15:15 -0500
X-MC-Unique: BkLs4P87PjGmXX1qo96UHA-1
X-Mimecast-MFC-AGG-ID: BkLs4P87PjGmXX1qo96UHA_1768223714
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8060C1956050; Mon, 12 Jan 2026 13:15:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.179])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED38430001A7; Mon, 12 Jan 2026 13:15:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/15] tests/functional: Add a generic test that checks the
 files with pylint
Date: Mon, 12 Jan 2026 14:14:48 +0100
Message-ID: <20260112131457.67128-7-thuth@redhat.com>
In-Reply-To: <20260112131457.67128-1-thuth@redhat.com>
References: <20260112131457.67128-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

To avoid that new pylint-related warnings get committed, let's check
the files with pylint during each run (similar to what we are doing
for the iotests already).

Message-Id: <20251119082636.43286-16-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                              |  1 +
 tests/functional/generic/meson.build     |  1 +
 tests/functional/generic/test_linters.py | 41 ++++++++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100755 tests/functional/generic/test_linters.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a6168cb46f7..6dfd9b27c20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4461,6 +4461,7 @@ F: docs/devel/testing/functional.rst
 F: scripts/clean_functional_cache.py
 F: tests/functional/meson.build
 F: tests/functional/generic/meson.build
+F: tests/functional/generic/test_linters.py
 F: tests/functional/pylintrc
 F: tests/functional/qemu_test/
 
diff --git a/tests/functional/generic/meson.build b/tests/functional/generic/meson.build
index 013cc96fbf8..09763c5d229 100644
--- a/tests/functional/generic/meson.build
+++ b/tests/functional/generic/meson.build
@@ -3,6 +3,7 @@
 tests_generic_system = [
   'empty_cpu_model',
   'info_usernet',
+  'linters',
   'version',
   'vnc',
 ]
diff --git a/tests/functional/generic/test_linters.py b/tests/functional/generic/test_linters.py
new file mode 100755
index 00000000000..b5b90fcf7a3
--- /dev/null
+++ b/tests/functional/generic/test_linters.py
@@ -0,0 +1,41 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+'''Python linter tests'''
+
+import os
+
+from pathlib import Path
+from qemu_test import QemuBaseTest, skipIfMissingImports
+
+
+class LinterTest(QemuBaseTest):
+    '''
+    Run python linters on the test *.py files
+    '''
+
+    @skipIfMissingImports("pylint")
+    def test_pylint(self):
+        '''Check source files with pylint'''
+        from pylint.lint import Run as pylint_run
+        from pylint.reporters.collecting_reporter import CollectingReporter
+        srcdir = os.path.join(Path(__file__).parent.parent, self.arch)
+        rcfile = os.path.join(Path(__file__).parent.parent, "pylintrc")
+        self.log.info('Checking files in %s with pylint', srcdir)
+        reporter = CollectingReporter()
+        pylint_run(["--rcfile", rcfile, srcdir], reporter=reporter, exit=False)
+        if reporter.messages:
+            fmt = '"{path}:{line}: {msg_id}: {msg} ({symbol})"'
+            for msg in reporter.messages:
+                if msg.category == "error":
+                    self.log.error(msg.format(fmt))
+                elif msg.category == "warning":
+                    self.log.warning(msg.format(fmt))
+                else:
+                    self.log.info(msg.format(fmt))
+            self.fail("Pylint failed, see base.log for details.")
+
+
+if __name__ == '__main__':
+    QemuBaseTest.main()
-- 
2.52.0


