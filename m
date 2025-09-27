Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A2CCAC5B9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 09:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Qrh-0004Qf-Cj; Sat, 27 Sep 2025 05:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2Qrf-0004QJ-Nt; Sat, 27 Sep 2025 05:05:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2Qrd-00077m-A8; Sat, 27 Sep 2025 05:05:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0E109158561;
 Sat, 27 Sep 2025 12:03:03 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E010D29157E;
 Sat, 27 Sep 2025 12:03:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.21 12/16] python/qmp/legacy: make QEMUMonitorProtocol
 accept a socket
Date: Sat, 27 Sep 2025 12:02:56 +0300
Message-ID: <20250927090304.2901324-12-mjt@tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Teach QEMUMonitorProtocol to accept an exisiting socket.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20230111080101.969151-3-marcandre.lureau@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit 603a3bad4b9a95b524dc8d6a41b1be4d5c5cacdf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
index 1951754455..8b09ee7dbb 100644
--- a/python/qemu/qmp/legacy.py
+++ b/python/qemu/qmp/legacy.py
@@ -22,6 +22,7 @@
 #
 
 import asyncio
+import socket
 from types import TracebackType
 from typing import (
     Any,
@@ -69,22 +70,32 @@ class QEMUMonitorProtocol:
 
     :param address:  QEMU address, can be either a unix socket path (string)
                      or a tuple in the form ( address, port ) for a TCP
-                     connection
+                     connection or None
+    :param sock:     a socket or None
     :param server:   Act as the socket server. (See 'accept')
     :param nickname: Optional nickname used for logging.
     """
 
-    def __init__(self, address: SocketAddrT,
+    def __init__(self,
+                 address: Optional[SocketAddrT] = None,
+                 sock: Optional[socket.socket] = None,
                  server: bool = False,
                  nickname: Optional[str] = None):
 
+        assert address or sock
         self._qmp = QMPClient(nickname)
         self._aloop = asyncio.get_event_loop()
         self._address = address
+        self._sock = sock
         self._timeout: Optional[float] = None
 
         if server:
-            self._sync(self._qmp.start_server(self._address))
+            if sock:
+                assert self._sock is not None
+                self._sync(self._qmp.open_with_socket(self._sock))
+            else:
+                assert self._address is not None
+                self._sync(self._qmp.start_server(self._address))
 
     _T = TypeVar('_T')
 
@@ -139,6 +150,7 @@ def connect(self, negotiate: bool = True) -> Optional[QMPMessage]:
         :return: QMP greeting dict, or None if negotiate is false
         :raise ConnectError: on connection errors
         """
+        assert self._address is not None
         self._qmp.await_greeting = negotiate
         self._qmp.negotiate = negotiate
 
-- 
2.47.3


