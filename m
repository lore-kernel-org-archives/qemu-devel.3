Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F9BD2F038
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkk2h-0006Hq-6L; Tue, 27 Jan 2026 09:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vkk2R-0006An-Lz
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:27:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vkk2Q-0003bH-9N
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769524045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gcl3Dbzs1jyEG1yBKpjfMi+5eNyPUahQKGJSe7GrLo=;
 b=IgKFfFMHA7oOSKQYnIRiVKXFYd0ITEnyACsj2KX79lWaSnj28bg92pDXKvTeAhj6hzhD51
 zFvZyySDnIhLGAph+Ojx4o2p3K7feNwYoiczd9n7VSIvYHhWBOAX6E6izBUyL6U5PfqZAX
 IB5yXJxHNwpiI06OPRbgEoRWG0EI9eY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-bth3LGysNB-B1pruoLqPMw-1; Tue,
 27 Jan 2026 09:27:22 -0500
X-MC-Unique: bth3LGysNB-B1pruoLqPMw-1
X-Mimecast-MFC-AGG-ID: bth3LGysNB-B1pruoLqPMw_1769524041
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AB0C1800370; Tue, 27 Jan 2026 14:27:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.209])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 926A818001D5; Tue, 27 Jan 2026 14:27:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 3/9] tests/functional/x86_64: Limit the memlock test to Linux
 hosts
Date: Tue, 27 Jan 2026 15:27:04 +0100
Message-ID: <20260127142710.131904-4-thuth@redhat.com>
In-Reply-To: <20260127142710.131904-1-thuth@redhat.com>
References: <20260127142710.131904-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260121111140.99482-1-thuth@redhat.com>
---
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


