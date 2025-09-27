Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350D9CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 09:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Qrl-0004RX-27; Sat, 27 Sep 2025 05:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2Qrk-0004RK-0r; Sat, 27 Sep 2025 05:05:16 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2QrZ-0006x2-9u; Sat, 27 Sep 2025 05:05:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F01F5158560;
 Sat, 27 Sep 2025 12:03:02 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CDFFC29157D;
 Sat, 27 Sep 2025 12:03:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.21 11/16] python/qmp/protocol: add open_with_socket()
Date: Sat, 27 Sep 2025 12:02:55 +0300
Message-ID: <20250927090304.2901324-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.21-20250927105809@cover.tls.msk.ru>
References: <qemu-stable-7.2.21-20250927105809@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Instead of listening for incoming connections with a SocketAddr, add a
new method open_with_socket() that accepts an existing socket.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20230111080101.969151-2-marcandre.lureau@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit a3cfea92e2030926e00a2519d299384ea648e36e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index 6ea86650ad..4710a57f91 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -18,6 +18,7 @@
 from enum import Enum
 from functools import wraps
 import logging
+import socket
 from ssl import SSLContext
 from typing import (
     Any,
@@ -296,6 +297,19 @@ async def start_server_and_accept(
         await self.accept()
         assert self.runstate == Runstate.RUNNING
 
+    @upper_half
+    @require(Runstate.IDLE)
+    async def open_with_socket(self, sock: socket.socket) -> None:
+        """
+        Start connection with given socket.
+
+        :param sock: A socket.
+
+        :raise StateError: When the `Runstate` is not `IDLE`.
+        """
+        self._reader, self._writer = await asyncio.open_connection(sock=sock)
+        self._set_state(Runstate.CONNECTING)
+
     @upper_half
     @require(Runstate.IDLE)
     async def start_server(self, address: SocketAddrT,
@@ -343,11 +357,12 @@ async def accept(self) -> None:
             protocol-level failure occurs while establishing a new
             session, the wrapped error may also be an `QMPError`.
         """
-        if self._accepted is None:
-            raise QMPError("Cannot call accept() before start_server().")
-        await self._session_guard(
-            self._do_accept(),
-            'Failed to establish connection')
+        if not self._reader:
+            if self._accepted is None:
+                raise QMPError("Cannot call accept() before start_server().")
+            await self._session_guard(
+                self._do_accept(),
+                'Failed to establish connection')
         await self._session_guard(
             self._establish_session(),
             'Failed to establish session')
-- 
2.47.3


