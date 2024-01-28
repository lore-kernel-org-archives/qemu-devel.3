Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9780DC47DA9
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 17:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU9JW-00046h-Ij; Sun, 28 Jan 2024 12:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9Im-0002ar-Sw; Sun, 28 Jan 2024 12:50:46 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9Ik-0000la-NL; Sun, 28 Jan 2024 12:50:40 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F0F9B48103;
 Sun, 28 Jan 2024 20:51:27 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8D8546D520;
 Sun, 28 Jan 2024 20:50:36 +0300 (MSK)
Received: (nullmailer pid 812404 invoked by uid 1000);
 Sun, 28 Jan 2024 17:50:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 55/71] acpi/tests/avocado/bits: wait for 200 seconds
 for SHUTDOWN event from bits VM
Date: Sun, 28 Jan 2024 20:50:18 +0300
Message-Id: <20240128175035.812352-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

By default, the timeout to receive any specified event from the QEMU VM is 60
seconds set by the python avocado test framework. Please see event_wait() and
events_wait() in python/qemu/machine/machine.py. If the matching event is not
triggered within that interval, an asyncio.TimeoutError is generated. Since the
timeout for the bits avocado test is 200 secs, we need to make event_wait()
timeout of the same value as well so that an early timeout is not triggered by
the avocado framework.

CC: peter.maydell@linaro.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2077
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20240117042556.3360190-1-anisinha@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 7ef4c41e91d59d72a3b8bc022a6cb3e81787a50a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/avocado/acpi-bits.py b/tests/avocado/acpi-bits.py
index 68b9e98d4e..efe4f52ee0 100644
--- a/tests/avocado/acpi-bits.py
+++ b/tests/avocado/acpi-bits.py
@@ -54,6 +54,8 @@
 deps = ["xorriso", "mformat"] # dependent tools needed in the test setup/box.
 supported_platforms = ['x86_64'] # supported test platforms.
 
+# default timeout of 120 secs is sometimes not enough for bits test.
+BITS_TIMEOUT = 200
 
 def which(tool):
     """ looks up the full path for @tool, returns None if not found
@@ -133,7 +135,7 @@ class AcpiBitsTest(QemuBaseTest): #pylint: disable=too-many-instance-attributes
 
     """
     # in slower systems the test can take as long as 3 minutes to complete.
-    timeout = 200
+    timeout = BITS_TIMEOUT
 
     def __init__(self, *args, **kwargs):
         super().__init__(*args, **kwargs)
@@ -400,7 +402,8 @@ def test_acpi_smbios_bits(self):
 
         # biosbits has been configured to run all the specified test suites
         # in batch mode and then automatically initiate a vm shutdown.
-        # Rely on avocado's unit test timeout.
-        self._vm.event_wait('SHUTDOWN')
+        # Set timeout to BITS_TIMEOUT for SHUTDOWN event from bits VM at par
+        # with the avocado test timeout.
+        self._vm.event_wait('SHUTDOWN', timeout=BITS_TIMEOUT)
         self._vm.wait(timeout=None)
         self.parse_log()
-- 
2.39.2


