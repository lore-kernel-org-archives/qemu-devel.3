Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98F2CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYUS-00041C-C4; Tue, 16 Sep 2025 12:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyYUP-0003yI-Qi
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyYUN-0003AY-5p
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758039906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1foPkUg4vYeyDEAJkaD9n1pX7MsE/MFHLY7LZoF6RRg=;
 b=f8Zut/H2CjkAx1l7dE5hcYsnDplH64OXpTpJRj/UI/+Rbc4GIQuynYknSskAI2xD5QVBEA
 cKVVdY9KM6dh+fOf9/hnELMEaH3PBmThTtOhFIoxjWKC/5JAYO70zYyQgkPh+xuTWi5jt6
 ppWuIgebWaler+ebNrFXSeJHeTgmNH4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-hvf3pRQXMSGLvgLcoN9Ftg-1; Tue,
 16 Sep 2025 12:24:56 -0400
X-MC-Unique: hvf3pRQXMSGLvgLcoN9Ftg-1
X-Mimecast-MFC-AGG-ID: hvf3pRQXMSGLvgLcoN9Ftg_1758039895
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38A2E1800562; Tue, 16 Sep 2025 16:24:55 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.221])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20FFA19560BA; Tue, 16 Sep 2025 16:24:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 13/19] python: backport 'avoid creating additional event loops
 per thread'
Date: Tue, 16 Sep 2025 12:23:58 -0400
Message-ID: <20250916162404.9195-14-jsnow@redhat.com>
In-Reply-To: <20250916162404.9195-1-jsnow@redhat.com>
References: <20250916162404.9195-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This commit is two backports squashed into one to avoid regressions.

python: *really* remove get_event_loop

A prior commit, aa1ff990, switched away from using get_event_loop *by
default*, but this is not good enough to avoid deprecation warnings as
`asyncio.get_event_loop_policy().get_event_loop()` is *also*
deprecated. Replace this mechanism with explicit calls to
asyncio.get_new_loop() and revise the cleanup mechanisms in __del__ to
match.

python: avoid creating additional event loops per thread

"Too hasty by far!", commit 21ce2ee4 attempted to avoid deprecated
behavior altogether by calling new_event_loop() directly if there was no
loop currently running, but this has the unfortunate side effect of
potentially creating multiple event loops per thread if tests
instantiate multiple QMP connections in a single thread. This behavior
is apparently not well-defined and causes problems in some, but not all,
combinations of Python interpreter version and platform environment.

Partially revert to Daniel Berrange's original patch, which calls
get_event_loop and simply suppresses the deprecation warning in
Python<=3.13. This time, however, additionally register new loops
created with new_event_loop() so that future calls to get_event_loop()
will return the loop already created.

Reported-by: Richard W.M. Jones <rjones@redhat.com>
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit python-qemu-qmp@21ce2ee4f2df87efe84a27b9c5112487f4670622
cherry picked from commit python-qemu-qmp@c08fb82b38212956ccffc03fc6d015c3979f42fe
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 python/qemu/qmp/legacy.py  | 46 +++++++++++++++++++++++---------------
 python/qemu/qmp/qmp_tui.py | 10 ++-------
 python/qemu/qmp/util.py    | 27 ++++++++++++++++++++++
 3 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
index 735d42971e9..e46695ae2c8 100644
--- a/python/qemu/qmp/legacy.py
+++ b/python/qemu/qmp/legacy.py
@@ -38,6 +38,7 @@
 from .error import QMPError
 from .protocol import Runstate, SocketAddrT
 from .qmp_client import QMPClient
+from .util import get_or_create_event_loop
 
 
 #: QMPMessage is an entire QMP message of any kind.
@@ -86,17 +87,13 @@ def __init__(self,
                 "server argument should be False when passing a socket")
 
         self._qmp = QMPClient(nickname)
-
-        try:
-            self._aloop = asyncio.get_running_loop()
-        except RuntimeError:
-            # No running loop; since this is a sync shim likely to be
-            # used in fully sync programs, create one if neccessary.
-            self._aloop = asyncio.get_event_loop_policy().get_event_loop()
-
         self._address = address
         self._timeout: Optional[float] = None
 
+        # This is a sync shim intended for use in fully synchronous
+        # programs. Create and set an event loop if necessary.
+        self._aloop = get_or_create_event_loop()
+
         if server:
             assert not isinstance(self._address, socket.socket)
             self._sync(self._qmp.start_server(self._address))
@@ -313,17 +310,30 @@ def send_fd_scm(self, fd: int) -> None:
         self._qmp.send_fd_scm(fd)
 
     def __del__(self) -> None:
-        if self._qmp.runstate == Runstate.IDLE:
-            return
+        if self._qmp.runstate != Runstate.IDLE:
+            self._qmp.logger.warning(
+                "QEMUMonitorProtocol object garbage collected without a prior "
+                "call to close()"
+            )
 
         if not self._aloop.is_running():
-            self.close()
-        else:
-            # Garbage collection ran while the event loop was running.
-            # Nothing we can do about it now, but if we don't raise our
-            # own error, the user will be treated to a lot of traceback
-            # they might not understand.
+            if self._qmp.runstate != Runstate.IDLE:
+                # If the user neglected to close the QMP session and we
+                # are not currently running in an asyncio context, we
+                # have the opportunity to close the QMP session. If we
+                # do not do this, the error messages presented over
+                # dangling async resources may not make any sense to the
+                # user.
+                self.close()
+
+        if self._qmp.runstate != Runstate.IDLE:
+            # If QMP is still not quiesced, it means that the garbage
+            # collector ran from a context within the event loop and we
+            # are simply too late to take any corrective action. Raise
+            # our own error to give meaningful feedback to the user in
+            # order to prevent pages of asyncio stacktrace jargon.
             raise QMPError(
-                "QEMUMonitorProtocol.close()"
-                " was not called before object was garbage collected"
+                "QEMUMonitorProtocol.close() was not called before object was "
+                "garbage collected, and could not be closed due to GC running "
+                "in the event loop"
             )
diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
index 12bdc17c99e..d946c205131 100644
--- a/python/qemu/qmp/qmp_tui.py
+++ b/python/qemu/qmp/qmp_tui.py
@@ -51,7 +51,7 @@
 from .message import DeserializationError, Message, UnexpectedTypeError
 from .protocol import ConnectError, Runstate
 from .qmp_client import ExecInterruptedError, QMPClient
-from .util import pretty_traceback
+from .util import get_or_create_event_loop, pretty_traceback
 
 
 # The name of the signal that is used to update the history list
@@ -387,13 +387,7 @@ def run(self, debug: bool = False) -> None:
         """
         screen = urwid.raw_display.Screen()
         screen.set_terminal_properties(256)
-
-        try:
-            self.aloop = asyncio.get_running_loop()
-        except RuntimeError:
-            # No running asyncio event loop. Create one if necessary.
-            self.aloop = asyncio.get_event_loop_policy().get_event_loop()
-
+        self.aloop = get_or_create_event_loop()
         self.aloop.set_debug(debug)
 
         # Gracefully handle SIGTERM and SIGINT signals
diff --git a/python/qemu/qmp/util.py b/python/qemu/qmp/util.py
index 0b3e781373d..47ec39a8b5e 100644
--- a/python/qemu/qmp/util.py
+++ b/python/qemu/qmp/util.py
@@ -10,6 +10,7 @@
 import sys
 import traceback
 from typing import TypeVar, cast
+import warnings
 
 
 T = TypeVar('T')
@@ -20,6 +21,32 @@
 # --------------------------
 
 
+def get_or_create_event_loop() -> asyncio.AbstractEventLoop:
+    """
+    Return this thread's current event loop, or create a new one.
+
+    This function behaves similarly to asyncio.get_event_loop() in
+    Python<=3.13, where if there is no event loop currently associated
+    with the current context, it will create and register one. It should
+    generally not be used in any asyncio-native applications.
+    """
+    try:
+        with warnings.catch_warnings():
+            # Python <= 3.13 will trigger deprecation warnings if no
+            # event loop is set, but will create and set a new loop.
+            warnings.simplefilter("ignore")
+            loop = asyncio.get_event_loop()
+    except RuntimeError:
+        # Python 3.14+: No event loop set for this thread,
+        # create and set one.
+        loop = asyncio.new_event_loop()
+        # Set this loop as the current thread's loop, to be returned
+        # by calls to get_event_loop() in the future.
+        asyncio.set_event_loop(loop)
+
+    return loop
+
+
 async def flush(writer: asyncio.StreamWriter) -> None:
     """
     Utility function to ensure a StreamWriter is *fully* drained.
-- 
2.51.0


