Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF66C44503
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viW7z-0001Jh-AY; Wed, 21 Jan 2026 06:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viW7u-0001GZ-Rx
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:11:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viW7r-00026z-Ei
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768993909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7BuEQP0zdNuopWQMVUnx4tjcUGM9JEc5KM6cg+mY7gQ=;
 b=Zzq8r3HKgJPk5tUrvfJKOIi27VU4p7LpmVEhCble2Y4HlQdxBq8aivwsGe7P1l4cBWudem
 sISiD+k4/qrbcS4kLGb3Dwlp8st05pBQXONsx3ELJIlv5jcKzwMOJUUaNnWEHgz3494xm1
 jT0nUPKe683drZfj5nYyLW4Ak2OQ/Vc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-lev4CUclPe2uqoPQohIfBg-1; Wed,
 21 Jan 2026 06:11:46 -0500
X-MC-Unique: lev4CUclPe2uqoPQohIfBg-1
X-Mimecast-MFC-AGG-ID: lev4CUclPe2uqoPQohIfBg_1768993905
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDB651956061; Wed, 21 Jan 2026 11:11:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A50C1955F44; Wed, 21 Jan 2026 11:11:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v2] tests/functional/x86_64: Limit the memlock test to Linux
 hosts
Date: Wed, 21 Jan 2026 12:11:40 +0100
Message-ID: <20260121111140.99482-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The memlock test analyzes /proc/*/status files and expects the layout
from Linux in there. However, these files also exist on NetBSD hosts
with a completely different layout, causing this test to fail. Thus
limit the test to Linux hosts now. We already have a decorator to
skip a test if it is running on a certain host system, but in this
case, we rather want to skip if we are not running on a specific
host system, so introduce a new @skipUnlessOperatingSystem decorator
for this job.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Check via a decorator, not via meson.build file

 tests/functional/qemu_test/__init__.py   |  4 ++--
 tests/functional/qemu_test/decorators.py | 12 ++++++++++++
 tests/functional/x86_64/test_memlock.py  |  3 ++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 320193591b2..03e5c73d39d 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -15,8 +15,8 @@
 from .linuxkernel import LinuxKernelTest
 from .decorators import skipIfMissingCommands, skipIfNotMachine, \
     skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipSlowTest, \
-    skipIfMissingImports, skipIfOperatingSystem, skipLockedMemoryTest, \
-    skipIfMissingEnv
+    skipIfMissingImports, skipIfOperatingSystem, skipUnlessOperatingSystem, \
+    skipLockedMemoryTest, skipIfMissingEnv
 from .archive import archive_extract
 from .uncompress import uncompress
 from .gdb import GDB
diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index 807418359ab..fcf236ecfdf 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -57,6 +57,18 @@ def skipIfOperatingSystem(*args):
                   'running on an OS (%s) that is not able to run this test' %
                   ", ".join(args))
 
+def skipUnlessOperatingSystem(*args):
+    '''
+    Decorator to skip execution of a test if the current host
+    operating system does not match one of the allowed ones.
+    Example:
+
+      @skipUnlessOperatingSystem("Linux", "Darwin")
+    '''
+    return skipUnless(platform.system() in args,
+                  'not running on one of the required operating systems (%s)' %
+                  ", ".join(args))
+
 def skipIfNotMachine(*args):
     '''
     Decorator to skip execution of a test if the current
diff --git a/tests/functional/x86_64/test_memlock.py b/tests/functional/x86_64/test_memlock.py
index f970a2c3095..d88843ab5f9 100755
--- a/tests/functional/x86_64/test_memlock.py
+++ b/tests/functional/x86_64/test_memlock.py
@@ -14,12 +14,13 @@
 from typing import Dict
 
 from qemu_test import QemuSystemTest
-from qemu_test import skipLockedMemoryTest
+from qemu_test import skipLockedMemoryTest, skipUnlessOperatingSystem
 
 
 STATUS_VALUE_PATTERN = re.compile(r'^(\w+):\s+(\d+) kB', re.MULTILINE)
 
 
+@skipUnlessOperatingSystem('Linux')
 @skipLockedMemoryTest(2_097_152)  # 2GB
 class MemlockTest(QemuSystemTest):
     """
-- 
2.52.0


