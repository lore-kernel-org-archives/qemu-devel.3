Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DEACA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 20:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utB7z-0004JK-1B; Mon, 01 Sep 2025 16:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utB7w-0004IC-Ib
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utB7u-00009Q-HJ
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756758461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZgCm4hCp31KslUyaQcGicvCOl8n+vAe/zDCm9bBpQg=;
 b=EJkv01AXFsoiEfyKlowAdEKS7GZqsEf4Bj7+M9046VV0GtrunJBuznUazdtg+vCwFY3ZL0
 KbH0FolV3XCDI5v0/cQPFs3MZ0zNXnVzNBs0/iFyQLpj9wYqYJY85o2gloNEtondh971GE
 rPzGMYIRlvjWfW7tv+IB2tLDEft26Q0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-7pxelDCsMX-SzmtFAtoSaQ-1; Mon,
 01 Sep 2025 16:27:39 -0400
X-MC-Unique: 7pxelDCsMX-SzmtFAtoSaQ-1
X-Mimecast-MFC-AGG-ID: 7pxelDCsMX-SzmtFAtoSaQ_1756758458
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B81881956089; Mon,  1 Sep 2025 20:27:38 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.85])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AAA3A19560AB; Mon,  1 Sep 2025 20:27:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 13/19] python: backport 'python: avoid creating additional
 event loops per thread'
Date: Mon,  1 Sep 2025 16:26:55 -0400
Message-ID: <20250901202702.2971212-14-jsnow@redhat.com>
In-Reply-To: <20250901202702.2971212-1-jsnow@redhat.com>
References: <20250901202702.2971212-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit c08fb82b38212956ccffc03fc6d015c3979f42fe
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp/legacy.py  | 21 +++++----------------
 python/qemu/qmp/qmp_tui.py | 16 ++--------------
 python/qemu/qmp/util.py    | 27 +++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
index 775b1fdd3b3..e46695ae2c8 100644
--- a/python/qemu/qmp/legacy.py
+++ b/python/qemu/qmp/legacy.py
@@ -38,6 +38,7 @@
 from .error import QMPError
 from .protocol import Runstate, SocketAddrT
 from .qmp_client import QMPClient
+from .util import get_or_create_event_loop
 
 
 #: QMPMessage is an entire QMP message of any kind.
@@ -86,19 +87,13 @@ def __init__(self,
                 "server argument should be False when passing a socket")
 
         self._qmp = QMPClient(nickname)
-        self._created_loop = False
-
-        try:
-            self._aloop = asyncio.get_running_loop()
-        except RuntimeError:
-            # No running loop; since this is a sync shim likely to be used
-            # in sync programs without any event loop at all, create one.
-            self._aloop = asyncio.new_event_loop()
-            self._created_loop = True
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
@@ -331,12 +326,6 @@ def __del__(self) -> None:
                 # user.
                 self.close()
 
-            # If we created our own loop (and we are not running inside
-            # of it), we must close it to avoid warnings and error
-            # messages upon program exit.
-            if self._created_loop:
-                self._aloop.close()
-
         if self._qmp.runstate != Runstate.IDLE:
             # If QMP is still not quiesced, it means that the garbage
             # collector ran from a context within the event loop and we
diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
index d5526338f22..d946c205131 100644
--- a/python/qemu/qmp/qmp_tui.py
+++ b/python/qemu/qmp/qmp_tui.py
@@ -51,7 +51,7 @@
 from .message import DeserializationError, Message, UnexpectedTypeError
 from .protocol import ConnectError, Runstate
 from .qmp_client import ExecInterruptedError, QMPClient
-from .util import pretty_traceback
+from .util import get_or_create_event_loop, pretty_traceback
 
 
 # The name of the signal that is used to update the history list
@@ -161,7 +161,6 @@ def __init__(self, address: Union[str, Tuple[str, int]], num_retries: int,
         self.retry_delay = retry_delay if retry_delay else 2
         self.retry: bool = False
         self.exiting: bool = False
-        self._created_loop = False
         super().__init__()
 
     def add_to_history(self, msg: str, level: Optional[str] = None) -> None:
@@ -388,14 +387,7 @@ def run(self, debug: bool = False) -> None:
         """
         screen = urwid.raw_display.Screen()
         screen.set_terminal_properties(256)
-
-        try:
-            self.aloop = asyncio.get_running_loop()
-        except RuntimeError:
-            # No running asyncio event loop. Create one.
-            self.aloop = asyncio.new_event_loop()
-            self._created_loop = True
-
+        self.aloop = get_or_create_event_loop()
         self.aloop.set_debug(debug)
 
         # Gracefully handle SIGTERM and SIGINT signals
@@ -418,10 +410,6 @@ def run(self, debug: bool = False) -> None:
             logging.error('%s\n%s\n', str(err), pretty_traceback())
             raise err
 
-    def __del__(self) -> None:
-        if self._created_loop and self.aloop:
-            self.aloop.close()
-
 
 class StatusBar(urwid.Text):
     """
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
2.50.1


