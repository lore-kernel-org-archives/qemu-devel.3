Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961C1C369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 07:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Jad-0005aZ-1a; Thu, 17 Apr 2025 03:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1u5Jab-0005aK-VZ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 03:23:13 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1u5Jaa-0000Lp-6V
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 03:23:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2b89:0:640:9815:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5567260917;
 Thu, 17 Apr 2025 10:23:09 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6b8:b081:b4a7::1:15])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id mMDENE2FXmI0-rcO5uGGl; Thu, 17 Apr 2025 10:23:08 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744874588;
 bh=GNn6avkYtsFoD++hFu2gCJghWtYb5lNSVfS2jRPK0fc=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=p355sNm/1kqyfJ5755na1bDFGm0lyk4x571y8JpklTRPt8Qs6QlLytbYyQHwriliO
 PWnd+uhOcgNamZt2XsjZ8dUlQ2WPCJQDx8iJC50gfkxtVyw/ceVSktmPL4+Qc9qeiX
 RleH90D5WrHxLPM/ranaNAxWJ4Cw2Bo8uR+lHkCY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v4 1/2] tests/functional: add skipLockedMemoryTest decorator
Date: Thu, 17 Apr 2025 12:22:45 +0500
Message-Id: <20250417072244.147510-2-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417072244.147510-1-dtalexundeer@yandex-team.ru>
References: <20250417072244.147510-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Used in future commit to skipping execution of a tests if the system's
locked memory limit is below the required threshold.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 tests/functional/qemu_test/__init__.py   |  2 +-
 tests/functional/qemu_test/decorators.py | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index af41c2c6a2..6e666a059f 100644
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
index 50d29de533..9f3062d020 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -5,6 +5,7 @@
 import importlib
 import os
 import platform
+import subprocess
 from unittest import skipIf, skipUnless
 
 from .cmd import which
@@ -131,3 +132,21 @@ def skipIfMissingImports(*args):
 
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
+    ulimit_memory = subprocess.run(
+        ['bash', '-c', 'ulimit -l'],
+        capture_output=True,
+        text=True,
+    ).stdout
+
+    return skipUnless(ulimit_memory == 'unlimited' or int(ulimit_memory) >= locked_memory,
+                      f'Test required {locked_memory} kB of available locked memory')
-- 
2.34.1


