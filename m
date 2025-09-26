Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA5DCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27rF-0008N0-Hq; Fri, 26 Sep 2025 08:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27rB-0008Kr-NI; Fri, 26 Sep 2025 08:47:25 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27r8-0006r9-1U; Fri, 26 Sep 2025 08:47:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 86E0E157F51;
 Fri, 26 Sep 2025 15:45:40 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E89EA290F0F;
 Fri, 26 Sep 2025 15:45:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 09/38] python: backport 'Remove deprecated
 get_event_loop calls'
Date: Fri, 26 Sep 2025 15:45:09 +0300
Message-ID: <20250926124540.2221746-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: John Snow <jsnow@redhat.com>

This method was deprecated in 3.12 because it ordinarily should not be
used from coroutines; if there is not a currently running event loop,
this automatically creates a new event loop - which is usually not what
you want from code that would ever run in the bottom half.

In our case, we do want this behavior in two places:

(1) The synchronous shim, for convenience: this allows fully sync
programs to use QEMUMonitorProtocol() without needing to set up an event
loop beforehand. This is intentional to fully box in the async
complexities into the legacy sync shim.

(2) The qmp_tui shell; instead of relying on asyncio.run to create and
run an asyncio program, we need to be able to pass the current asyncio
loop to urwid setup functions. For convenience, again, we create one if
one is not present to simplify the creation of the TUI appliance.

The remaining user of get_event_loop() was in fact one of the erroneous
users that should not have been using this function: if there's no
running event loop inside of a coroutine, you're in big trouble :)

Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit python-qemu-qmp@aa1ff9907603a3033296027e1bd021133df86ef1
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 5d99044d09db0fa8c2b3294e301927118f9effc9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
index c8d0a29b56..735d42971e 100644
--- a/python/qemu/qmp/legacy.py
+++ b/python/qemu/qmp/legacy.py
@@ -86,7 +86,14 @@ def __init__(self,
                 "server argument should be False when passing a socket")
 
         self._qmp = QMPClient(nickname)
-        self._aloop = asyncio.get_event_loop()
+
+        try:
+            self._aloop = asyncio.get_running_loop()
+        except RuntimeError:
+            # No running loop; since this is a sync shim likely to be
+            # used in fully sync programs, create one if neccessary.
+            self._aloop = asyncio.get_event_loop_policy().get_event_loop()
+
         self._address = address
         self._timeout: Optional[float] = None
 
diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
index 53ea6c59a7..12bdc17c99 100644
--- a/python/qemu/qmp/qmp_tui.py
+++ b/python/qemu/qmp/qmp_tui.py
@@ -388,7 +388,12 @@ def run(self, debug: bool = False) -> None:
         screen = urwid.raw_display.Screen()
         screen.set_terminal_properties(256)
 
-        self.aloop = asyncio.get_event_loop()
+        try:
+            self.aloop = asyncio.get_running_loop()
+        except RuntimeError:
+            # No running asyncio event loop. Create one if necessary.
+            self.aloop = asyncio.get_event_loop_policy().get_event_loop()
+
         self.aloop.set_debug(debug)
 
         # Gracefully handle SIGTERM and SIGINT signals
diff --git a/python/tests/protocol.py b/python/tests/protocol.py
index c254c77b17..e565802516 100644
--- a/python/tests/protocol.py
+++ b/python/tests/protocol.py
@@ -227,7 +227,7 @@ def async_test(async_test_method):
         Decorator; adds SetUp and TearDown to async tests.
         """
         async def _wrapper(self, *args, **kwargs):
-            loop = asyncio.get_event_loop()
+            loop = asyncio.get_running_loop()
             loop.set_debug(True)
 
             await self._asyncSetUp()
-- 
2.47.3


