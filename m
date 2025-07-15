Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EBCC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 15:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubhNN-0002Kj-MV; Tue, 15 Jul 2025 11:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubghD-0003rW-Ku
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubghA-0006ZT-Gj
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752589907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5pK3tmmYGTqFklFHKc6zkczYKsDiNwcJN04/F3hJC4=;
 b=B3juwIP7QC1Bf8h3sO+1AuWmJKaZ4QkRj0vqxuXoC4P1cMinWbrSz5v7LCEnTlHhOl90Xz
 I0kz2hCvPUzpLKsKeiohYQxArAHdZvOhZCRosiGkraHIcA+n64w4y4FEzUuDaddNZJBkXO
 U6FgOqigDjVT+iZTeSIzzl3x6+rV0hU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-ki2Ab1RFNVa48N7eXlTdcg-1; Tue,
 15 Jul 2025 10:31:44 -0400
X-MC-Unique: ki2Ab1RFNVa48N7eXlTdcg-1
X-Mimecast-MFC-AGG-ID: ki2Ab1RFNVa48N7eXlTdcg_1752589901
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE46C1958B0F; Tue, 15 Jul 2025 14:31:41 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.173])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A87E2180045B; Tue, 15 Jul 2025 14:31:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 06/14] python: drop 'create_task' back compat helper
Date: Tue, 15 Jul 2025 15:30:15 +0100
Message-ID: <20250715143023.1851000-7-berrange@redhat.com>
In-Reply-To: <20250715143023.1851000-1-berrange@redhat.com>
References: <20250715143023.1851000-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Our minimum python is now 3.9, so back compat with python
3.6 is no longer required.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 python/qemu/qmp/protocol.py |  7 +++----
 python/qemu/qmp/qmp_tui.py  |  8 ++++----
 python/qemu/qmp/util.py     | 33 +--------------------------------
 python/tests/protocol.py    |  7 +++----
 4 files changed, 11 insertions(+), 44 deletions(-)

diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index deb6b20d29..4aff0ea423 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -36,7 +36,6 @@
 from .error import QMPError
 from .util import (
     bottom_half,
-    create_task,
     exception_summary,
     flush,
     pretty_traceback,
@@ -661,8 +660,8 @@ async def _establish_session(self) -> None:
         reader_coro = self._bh_loop_forever(self._bh_recv_message, 'Reader')
         writer_coro = self._bh_loop_forever(self._bh_send_message, 'Writer')
 
-        self._reader_task = create_task(reader_coro)
-        self._writer_task = create_task(writer_coro)
+        self._reader_task = asyncio.create_task(reader_coro)
+        self._writer_task = asyncio.create_task(writer_coro)
 
         self._bh_tasks = asyncio.gather(
             self._reader_task,
@@ -687,7 +686,7 @@ def _schedule_disconnect(self) -> None:
         if not self._dc_task:
             self._set_state(Runstate.DISCONNECTING)
             self.logger.debug("Scheduling disconnect.")
-            self._dc_task = create_task(self._bh_disconnect())
+            self._dc_task = asyncio.create_task(self._bh_disconnect())
 
     @upper_half
     async def _wait_disconnect(self) -> None:
diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
index 7dfb03c9ad..61e8b3773c 100644
--- a/python/qemu/qmp/qmp_tui.py
+++ b/python/qemu/qmp/qmp_tui.py
@@ -40,7 +40,7 @@
 from .message import DeserializationError, Message, UnexpectedTypeError
 from .protocol import ConnectError, Runstate
 from .qmp_client import ExecInterruptedError, QMPClient
-from .util import create_task, pretty_traceback
+from .util import pretty_traceback
 
 
 # The name of the signal that is used to update the history list
@@ -225,7 +225,7 @@ def cb_send_to_server(self, raw_msg: str) -> None:
         """
         try:
             msg = Message(bytes(raw_msg, encoding='utf-8'))
-            create_task(self._send_to_server(msg))
+            asyncio.create_task(self._send_to_server(msg))
         except (DeserializationError, UnexpectedTypeError) as err:
             raw_msg = format_json(raw_msg)
             logging.info('Invalid message: %s', err.error_message)
@@ -246,7 +246,7 @@ def kill_app(self) -> None:
         Initiates killing of app. A bridge between asynchronous and synchronous
         code.
         """
-        create_task(self._kill_app())
+        asyncio.create_task(self._kill_app())
 
     async def _kill_app(self) -> None:
         """
@@ -393,7 +393,7 @@ def run(self, debug: bool = False) -> None:
                                    handle_mouse=True,
                                    event_loop=event_loop)
 
-        create_task(self.manage_connection(), self.aloop)
+        self.aloop.create_task(self.manage_connection())
         try:
             main_loop.run()
         except Exception as err:
diff --git a/python/qemu/qmp/util.py b/python/qemu/qmp/util.py
index 7f9e718154..c44a5aacbc 100644
--- a/python/qemu/qmp/util.py
+++ b/python/qemu/qmp/util.py
@@ -13,13 +13,7 @@
 import asyncio
 import sys
 import traceback
-from typing import (
-    Any,
-    Coroutine,
-    Optional,
-    TypeVar,
-    cast,
-)
+from typing import TypeVar, cast
 
 
 T = TypeVar('T')
@@ -79,31 +73,6 @@ def bottom_half(func: T) -> T:
     return func
 
 
-# -------------------------------
-# Section: Compatibility Wrappers
-# -------------------------------
-
-
-def create_task(coro: Coroutine[Any, Any, T],
-                loop: Optional[asyncio.AbstractEventLoop] = None
-                ) -> 'asyncio.Future[T]':
-    """
-    Python 3.6-compatible `asyncio.create_task` wrapper.
-
-    :param coro: The coroutine to execute in a task.
-    :param loop: Optionally, the loop to create the task in.
-
-    :return: An `asyncio.Future` object.
-    """
-    if sys.version_info >= (3, 7):
-        if loop is not None:
-            return loop.create_task(coro)
-        return asyncio.create_task(coro)  # pylint: disable=no-member
-
-    # Python 3.6:
-    return asyncio.ensure_future(coro, loop=loop)
-
-
 # ----------------------------
 # Section: Logging & Debugging
 # ----------------------------
diff --git a/python/tests/protocol.py b/python/tests/protocol.py
index 4a0ee94727..9bb23b6a7b 100644
--- a/python/tests/protocol.py
+++ b/python/tests/protocol.py
@@ -8,7 +8,6 @@
 
 from qemu.qmp import ConnectError, Runstate
 from qemu.qmp.protocol import AsyncProtocol, StateError
-from qemu.qmp.util import create_task
 
 
 class NullProtocol(AsyncProtocol[None]):
@@ -124,7 +123,7 @@ async def _runner():
             if allow_cancellation:
                 return
             raise
-    return create_task(_runner())
+    return asyncio.create_task(_runner())
 
 
 @contextmanager
@@ -271,7 +270,7 @@ async def _watcher():
                     msg=f"Expected state '{state.name}'",
                 )
 
-        self.runstate_watcher = create_task(_watcher())
+        self.runstate_watcher = asyncio.create_task(_watcher())
         # Kick the loop and force the task to block on the event.
         await asyncio.sleep(0)
 
@@ -589,7 +588,7 @@ async def _asyncTearDown(self):
     async def testSmoke(self):
         with TemporaryDirectory(suffix='.qmp') as tmpdir:
             sock = os.path.join(tmpdir, type(self.proto).__name__ + ".sock")
-            server_task = create_task(self.server.start_server_and_accept(sock))
+            server_task = asyncio.create_task(self.server.start_server_and_accept(sock))
 
             # give the server a chance to start listening [...]
             await asyncio.sleep(0)
-- 
2.49.0


