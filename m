Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229D3C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPL2w-0003Kr-Nl; Wed, 11 Jun 2025 08:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2p-0003Jp-8q
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2n-0004Nt-AP
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749646743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEOjCmUy01jwqk9KrpLlJaN0XNee6ITqm1T5kaq49Js=;
 b=IV26cDcTiw2ktIKv5TNcGbXuhyzCrJfS6VTmvPUAqZjyaeoWvxbVoMuhKDgKFiIp3f82gR
 2Dy2bmnqFg6ZlWnhXK9mENDNHT0G67ykKeWCFdr9oM4O8T/3ykrRCiwucwyCuRxEuRLTWl
 XwMocbigcPl15nBDlGCHrvPK934RWxA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-49A6-v0AM86Ga2HFG4wcJQ-1; Wed,
 11 Jun 2025 08:59:02 -0400
X-MC-Unique: 49A6-v0AM86Ga2HFG4wcJQ-1
X-Mimecast-MFC-AGG-ID: 49A6-v0AM86Ga2HFG4wcJQ_1749646741
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1679B1955E80; Wed, 11 Jun 2025 12:59:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.174])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D215F19560A3; Wed, 11 Jun 2025 12:58:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PULL 05/10] tests/functional: add skipLockedMemoryTest decorator
Date: Wed, 11 Jun 2025 14:58:41 +0200
Message-ID: <20250611125846.125918-6-thuth@redhat.com>
In-Reply-To: <20250611125846.125918-1-thuth@redhat.com>
References: <20250611125846.125918-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

Used in future commit to skipping execution of a tests if the system's
locked memory limit is below the required threshold.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250605065908.299979-2-dtalexundeer@yandex-team.ru>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/__init__.py   |  2 +-
 tests/functional/qemu_test/decorators.py | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index af41c2c6a22..6e666a059fc 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -15,6 +15,6 @@
 from .linuxkernel import LinuxKernelTest
 from .decorators import skipIfMissingCommands, skipIfNotMachine, \
     skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipSlowTest, \
-    skipIfMissingImports, skipIfOperatingSystem
+    skipIfMissingImports, skipIfOperatingSystem, skipLockedMemoryTest
 from .archive import archive_extract
 from .uncompress import uncompress
diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index 50d29de533d..c0d1567b142 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -5,6 +5,7 @@
 import importlib
 import os
 import platform
+import resource
 from unittest import skipIf, skipUnless
 
 from .cmd import which
@@ -131,3 +132,20 @@ def skipIfMissingImports(*args):
 
     return skipUnless(has_imports, 'required import(s) "%s" not installed' %
                                    ", ".join(args))
+
+'''
+Decorator to skip execution of a test if the system's
+locked memory limit is below the required threshold.
+Takes required locked memory threshold in kB.
+Example:
+
+  @skipLockedMemoryTest(2_097_152)
+'''
+def skipLockedMemoryTest(locked_memory):
+    # get memlock hard limit in bytes
+    _, ulimit_memory = resource.getrlimit(resource.RLIMIT_MEMLOCK)
+
+    return skipUnless(
+        ulimit_memory == resource.RLIM_INFINITY or ulimit_memory >= locked_memory * 1024,
+        f'Test required {locked_memory} kB of available locked memory',
+    )
-- 
2.49.0


