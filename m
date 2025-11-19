Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C38CF259E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 08:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLdYB-0004xb-Sn; Wed, 19 Nov 2025 03:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLdY9-0004lG-I9
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:28:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLdY7-0000y5-N3
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763540903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JjP04p/a3qVWmVtwDi217sBbPAhwIDdHPY9477Xyuo=;
 b=NWo4YXAk6Ilwo81cJP8316deWjeNhe/uOAG3tQn+ADvc8FepBA4+JnRK9GcYgQp0JZS5nS
 D2FbDv3jgflT7nB9CUFPrgQyys7C9jij3YsatATKpvFLjiXhLjyuVdbk9ov5XSJVYImEVl
 lUzCKZ8+cSXC4rV2Gwt7ROsDaF/uocM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-1xzJYJwJOI-uOCWtNJXETw-1; Wed,
 19 Nov 2025 03:28:18 -0500
X-MC-Unique: 1xzJYJwJOI-uOCWtNJXETw-1
X-Mimecast-MFC-AGG-ID: 1xzJYJwJOI-uOCWtNJXETw_1763540895
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C941C1801237; Wed, 19 Nov 2025 08:28:15 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E295180047F; Wed, 19 Nov 2025 08:28:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH for-11.0 15/15] tests/functional: Add a generic test that
 checks the files with pylint
Date: Wed, 19 Nov 2025 09:26:36 +0100
Message-ID: <20251119082636.43286-16-thuth@redhat.com>
In-Reply-To: <20251119082636.43286-1-thuth@redhat.com>
References: <20251119082636.43286-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

To avoid that new pylint-related warnings get committed, let's check
the files with pylint during each run (similar to what we are doing
for the iotests already).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/generic/meson.build     |  1 +
 tests/functional/generic/test_linters.py | 41 ++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100755 tests/functional/generic/test_linters.py

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
2.51.1


